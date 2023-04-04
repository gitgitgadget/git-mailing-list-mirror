Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB62FC6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 20:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbjDDU1w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 16:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjDDU1u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 16:27:50 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E98A2D64
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 13:27:49 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id D7BE93200A6C;
        Tue,  4 Apr 2023 16:27:48 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Tue, 04 Apr 2023 16:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680640068; x=
        1680726468; bh=k5I33So6heTKgvpN0gpXYTVFkFrZQ51ILIaUb6s5wag=; b=A
        wxi7wyCHEU9ftgdr8/upvQxNElR5rrKJ9xM/4IhIXqT6hE9t5n6lIZ5SlHY72aq4
        9py9H+pPW5g8yqYrkXmd1X6pGEMUBOONh1u770lAnMjQnZxLh+AlJdDX9HtoI1Wz
        IGr/2uax+OFeaPhLu0vXzvdZNQwDJvGpNx+e22f6yu4xI/39lYW+GCz7f+/Iw+8E
        XNORTNGEJbIRj7nn1AAcEAHagKIjOjv8P7ZukIOf87hS9eI71Ao9ADPqISfz+mXZ
        tttDcw3oA+kiQ8PbZvctDgoZpApeVSNUbBawqaKxLHfhJG3CLvB8MLdU6UpoD2Rr
        HqkK9FyH4SS/SCQ+ZmhpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680640068; x=1680726468; bh=k5I33So6heTKg
        vpN0gpXYTVFkFrZQ51ILIaUb6s5wag=; b=D9bXD1svv2/Ap1RID1aq2fXcSpagP
        QAwXuLQbJVdmab3xIsU4abSFLuv5xG7qyEVChwhh5oXZJ/7QrQzVr2i8w8QfIPRF
        hOP47qbzv++w14mF2W2+D6BYOD2cG9BBQvPU4LTUfCln1q+cg+oMQH+f5in27Gg/
        tvYlkU4Wgn1KSEWS2FT1M2pxyaYyJcjJElFvFTMRrcsZF6anZAtghV7pt06aRClg
        21g+ZoF4/+avs3xZFZUfa6NIzb783gURpBWLjO2sEqAm6gYVX5kkF3PRZPL8tHG+
        526jpK/UwqlFwBVP0g+8ddOYlwL5uuQ5pknaP9MKqEKd1z/RTETWukguA==
X-ME-Sender: <xms:RIgsZNhY2zv-rns0NUZ9pfR4Ra764nZATidqY7K7SDvPth8qDIQqc4o>
    <xme:RIgsZCAATQ3bD5NJnbguAkzslVEJA6Hc_INofDkXVxowjVUcji_1dTyLr6Qjt0qtY
    hprRysHy6NzBnV5gQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeefffevieelkeevvdefjeevffdtledt
    udeggfekheehleeigfeitdeigfegvdejtdenucffohhmrghinhepghhithhhuhgsrdgtoh
    hmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:RIgsZNElxqwPcXcHqNc7A53q1miXvn9xJpZhqveGXlYg436u5Xuavg>
    <xmx:RIgsZCRM5_XL43VtiwLyTZPH4ha2QPN8VRuV_daWAPIVQnV82Ln_lg>
    <xmx:RIgsZKyHVycH2xycudkSjt8zdN1f2jc0XHfAXrvpOWra4U1YfGaW7Q>
    <xmx:RIgsZPsWZd40u0r1seOMiesJKy43SAPjV93OuOuhBWItg17N048wIQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3604F15A00A1; Tue,  4 Apr 2023 16:27:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <5b99135f-c1d4-434b-b508-35f5d66dd2bb@app.fastmail.com>
In-Reply-To: <CAKazavxTXwcZFtL2XyU3MpaUR=snWY8w8Lwpco+mkbqm2nWE=w@mail.gmail.com>
References: <CAKazavxTXwcZFtL2XyU3MpaUR=snWY8w8Lwpco+mkbqm2nWE=w@mail.gmail.com>
Date:   Tue, 04 Apr 2023 22:27:26 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Rohit Ner" <rohitner1@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git log causing hang while browsing upstream linux
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 4, 2023, at 22:13, Rohit Ner wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> 1. git clone https://github.com/torvalds/linux.git
> 2. git checkout master
> 3. git log --oneline --graph

Seems like `--graph` is expensive.

FWIW: on my machine:

    $ time git log --oneline --graph | head -1 
    *   76f598ba7d8e Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm

    real	0m10.616s
    user	0m9.594s
    sys	0m0.654s

Second attempt is only marginally faster.

-- 
Kristoffer Haugsbakk
