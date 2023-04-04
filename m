Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C98C761A6
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 11:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbjDDLaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 07:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbjDDL37 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 07:29:59 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3C51FF5
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 04:29:59 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 7713A320024A;
        Tue,  4 Apr 2023 07:29:58 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Tue, 04 Apr 2023 07:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680607798; x=
        1680694198; bh=XiAJnbfxooeW8PGLfjUbUvtdyFpd0V6HRRvgTwjgKWo=; b=a
        G61oRNN85xSVV7Hv5kkIocK+JAxl1z3OFDpXxO1m1jxlthM9sHW7v351st6zW2aS
        EJbgmbxg8mXBYKovsnjLiDdS9OWRP7fnUVl5hArz1WI8MxVrlM8b6CbWtJhLmzi1
        Nh2cgQPgRvGYHK42jKkmXOEgqJ3CuD3iL6d56qrqRfv8chZ9bOZio7HzoJY1CJij
        ppd5Jlf4UC8Vqce0kMxNwi3ScidT4eAzHmUlHrEXTKUSLZwZa6/if7Qa3TBED4O0
        dnVMuLCS2jjiBPPyGNjtrhJYGO6TwAByAi8hC7sZLAi1qGGRBR0Ed9MVNr2vi5Dh
        Q0uw9jmV53W9ffyII93lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680607798; x=1680694198; bh=XiAJnbfxooeW8
        PGLfjUbUvtdyFpd0V6HRRvgTwjgKWo=; b=L10L/NG8buNWgIF5T+NFKqGJs5OEG
        Cor/4dqR/LSXjC5dIlu7GsiCMjx5VWFTpfCd3GTO1MJx/rPPYNXLOA7Ha+QyqxZ0
        QhTPhg30uwdNqvanfIY1hM399MMjhJUIXZJB1SnMYfzYDn+Nv45nYVAitrCXpPMi
        yp95wQ/kgCEOSJMlcfYWBNIElMBXqJ/uON16oYf3UE+2izhMR5vXYjK5b9s/gXFC
        XfLnDt0/03tCxuNBBwmd3/d3BPAR1wLzumig8qDRTGTI9RkIhdr5RInqoy63jdZV
        QdnJNqwjdoEPUXsfe/rkwC7iBsyJUSfGTuc3sZA40CPakwvF+FEe6HQmA==
X-ME-Sender: <xms:NQosZBa6RVXiIgTbpR8NfmS-ElDf-QReSH-V5TBWZo6xWFj9PP1c3IE>
    <xme:NQosZIYbHty0RVnwOPPZhfTRVd4B6UyU778YLD8bxYZWAsuo54L0LZrwnLfIuJ-EQ
    2Z6eUAQiN4awHodJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    etieeigeetudejkeektdejjedvleetledufefhfefhtdehkeekvdefuefhhfejueenucff
    ohhmrghinhepshhuphgvrhhushgvrhdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghm
    vg
X-ME-Proxy: <xmx:NQosZD90dFCljpYY4G29H_pbvl0t7zkqa9mOMUNsODbpfyKzLIzBNQ>
    <xmx:NQosZPqE_fLvzXF7ARS-pQ5VsZq76jHDjErYJVYxQ5UtxBuYhEaX1g>
    <xmx:NQosZMr-JdqffTYCopk_jucLlf9aQb-4m9PJ3lbGT_v67Hkh4TwcxQ>
    <xmx:NgosZCH5G7cg6rcxVXBbN9abFKllx06Dl5dvvu2RvAJZYWfKXvuk2g>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E30C215A00A1; Tue,  4 Apr 2023 07:29:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <fa47135f-48f7-4cf9-b239-ebdd5b9872d0@app.fastmail.com>
In-Reply-To: <1997583.yJf2vTnlun@earendil>
References: <3473764.PTxrJRyG3s@earendil> <2349908.kWcu0K8Tai@earendil>
 <4e5ac983-a45d-4459-b398-4d092ca2f1c8@app.fastmail.com>
 <1997583.yJf2vTnlun@earendil>
Date:   Tue, 04 Apr 2023 13:29:25 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Thorsten Otto" <admin@tho-otto.de>
Cc:     git@vger.kernel.org
Subject: Re: "git diff" does not show a diff for newly added, binary files
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 4, 2023, at 13:23, Thorsten Otto wrote:
> How can that be done? I mean, git detects that file to be binary. I certainly 
> don't want to treat it as text, and then dump binary data to the terminal when 
> they differ ;)

I used something like this when I last needed to diff binary files: https://superuser.com/a/706286/259670

-- 
Kristoffer Haugsbakk
