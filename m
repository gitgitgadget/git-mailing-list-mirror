Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D23AC77B7A
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 09:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237728AbjFGJmS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 05:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbjFGJmN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 05:42:13 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B187410DE
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 02:42:08 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 28969320090D;
        Wed,  7 Jun 2023 05:42:08 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Wed, 07 Jun 2023 05:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1686130927; x=
        1686217327; bh=mm3j90HzvM1rAPHodsHI6l6ZUSNXQsPSBELjsT0bIIE=; b=U
        ajXz5RDa6LM1cmqGXUE6fcfq2ALV08rLXeJl3MqPVaBbEmCpIGyYVlh+HtwtP1kG
        o7R0T+UW/Jeub/SE9buN2RbviIazBYimLGiwSt5poLAX6m2AcqaoQ61VE05RaqQp
        r83cMKjDQ7pYlSy/BxD4hN6M4xRiX/fKlQH3Ho7QyhgsaDoX5M5Uf7IBPIYCgHv6
        cPNx5g/t8nRZCqQL6y85YOBDjDada+edpESpfhpcjyBgD4Hwd2IAaKqKfd9rQwSW
        /BwmvVVKvbVd/8SP87ERrz9XH7Y6NgaApQSOHZv0MH7k1XNSSUllCP4Y6NN6T9mf
        vSxEPZHkSI++tbYcj7hzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686130927; x=1686217327; bh=mm3j90HzvM1rA
        PHodsHI6l6ZUSNXQsPSBELjsT0bIIE=; b=NtYAD5tzolYBNgEKg+sIdH9t6E4cw
        XDbv6vWZhHzMJFmq7y+GBzXmwF70+9II2k40akDwGNalPBhI70/K6qRHKsPp4UKe
        n9tanbKSTIn9dVHFAJ2v57+P4/lUN+5UlgFWSsOuU36/vhPcUPALtKcIBcpJenOT
        5g3fRMOj3SJOMIhf2hyU4rRZiPeaScPNzJZOY1iIDVfsxT5l7VoaM6YaE1arMRMk
        6QQGIT/JpY6ddf8GIIOnbFR6Midouc9OkSUbWnPADYSyawBCL3W+KJgUyB/aTZ5t
        4h6XfuZWkmqFiXNFwokcZuKZGaU+JHF+DcXE6Lzyh5mm3B3YyB9tQOrTg==
X-ME-Sender: <xms:71CAZFwCLKAvr3C0sMcidCQ9W3ITWXRvXnm7FzuR5oGHl2QozS_GX5w>
    <xme:71CAZFTFofnb5Y3y4PxcABcChbi8MQV5g-xEk5Y7Ieqea6g8T-0Fq1naCNM1PC4jP
    F26-Mk0m3ChogUj8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtgedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepleevgfdvhffhhfekgfeufeelvdeiffdu
    hfetfeffleffueeftdduudektdeuieeunecuffhomhgrihhnpegtrhgrthgvshdrihhone
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:71CAZPXU-lkYDbzKpYdShtUdOz1JfY_Rk20C-d3H0s2g4alE4a3Zsg>
    <xmx:71CAZHg24Ld28EJ7YP6xOJ16POoBLSxbZWiRoq25UfU5_GhI-WZOkA>
    <xmx:71CAZHDFSj5wWbjG6qboBjHSbkANklnQcAX6Bj_M0CNlM8YvRk3qXQ>
    <xmx:71CAZK_OUcgSz5U038kFXzXBqbGuQbTk9FhR9xyTz5yjyfJV-uHSeA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8217615A008E; Wed,  7 Jun 2023 05:42:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <5b796f88-949c-4bba-b4a7-19ad61171812@app.fastmail.com>
In-Reply-To: <pull.1542.git.1686099081989.gitgitgadget@gmail.com>
References: <pull.1542.git.1686099081989.gitgitgadget@gmail.com>
Date:   Wed, 07 Jun 2023 11:41:10 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Linus Arver" <linusa@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] docs: typofixes
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On Wed, Jun 7, 2023, at 02:51, Linus Arver via GitGitGadget wrote:
> From: Linus Arver <linusa@google.com>
>
> These were found with an automated CLI tool [1]. [1]: https://crates.io/crates/typos-cli

Did you run a command or a script without any manual afterwork? If so,
do you know what that command invocation/script was?

Thanks

-- 
Kristoffer Haugsbakk
