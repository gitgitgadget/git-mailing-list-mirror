Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF887C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 09:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjDKJqe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 05:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDKJqd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 05:46:33 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BE61997
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 02:46:32 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id D7656320094A;
        Tue, 11 Apr 2023 05:46:28 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Tue, 11 Apr 2023 05:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1681206388; x=1681292788; bh=aHKQ8+5VTDZkY2uYVV1Bm6H4q
        m56Z2Faf0pZ63PAcio=; b=xz2E3E1RORHStokUarBVC6ZhWssFk4/S/hXvYn6Gr
        uiIuUuN3ovNIggQHbuO7mFY7v2wMAYTX9i3yiovwrqqjeBRHq4qozB4U/xyqsWj6
        ntNJTssMolVtaciWOxUxP3O8UuDPk4qurkRAK1A5JJRvgLOzeS81appGVvDC6vQ1
        4N9qrxbsUM/LKvIB6j7Affapash2MBcSN0p3WkYjxNclbpjaLXpJyHgt18xMkyOj
        o+mHiRc4OUNJ8X5artUy4SLxtiSAAe8RKI+t6mswB9HmxFpejTyUhmjOGhIpRYag
        f8Kha9cZSC3+8tOnSZV8uTB83wIvIC0vH421mXPxavh2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681206388; x=1681292788; bh=aHKQ8+5VTDZkY2uYVV1Bm6H4qm56Z2Faf0p
        Z63PAcio=; b=b7yUFtCjmGh4VCEQ/KtUCBSKPkv4uPdpaQdoItSeyXhQ4z0SrgW
        Ny6l4Eo2gwvmqX9xiloCWY/qIpuGKC5fPwUhvRoCDmAeFW8VTwghbcHoMiTCeRNf
        w1noufBhUYEhj3gFwBizXYiulRaGxyYH2TXFutbjGzuHpLrCuKCXh6dP/fpJbKW9
        H23O6OVB4AqF3zTKcmU4MEMGMQLWKH4Xjy4LZypEF8ptKZTSbek4PokuHS1hpNmH
        sR4NdcWrKJWflVRN+c0K+gkJ+gRRZ5DczGG7PVKru/KqCjPqlly+Zwgokb6Kn/01
        lEXFR157pyJ/mfQadH+a78FPz6/aMcFl82w==
X-ME-Sender: <xms:dCw1ZCfCP1HxsgrIn0K9HmuNGpKmDRxhhC6S5jT5E1dtF-GzczdmiiI>
    <xme:dCw1ZMPQfvY94nWz6PPOK22oMoyF2XyF3F0FiB1uHP3oaInS6HQpEYgkvY3p06rGc
    FHwJV7Zdwv3YWmDgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkeduvedthfelueevheffhedvveei
    ueeiheehudehveegueetteduuddtfeelueenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:dCw1ZDhtsmiS5GVPNBtgWeaj5iZd4HIt247Q74GPo3EIKh0pyGDCnQ>
    <xmx:dCw1ZP88nGZ4HE7o_Y6fZzOVVNDTbKgzytvkD8OoeK9wTWidprzE7A>
    <xmx:dCw1ZOvWqqibkVOl5tsD_rxiebrxIlbuKogBbJP5WERpO8N3fz3UKQ>
    <xmx:dCw1ZDVJOJGSLLCm5m-zlCO3M2C7wOQFwJii7zh2zmAovuEiJXywpQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4A26215A008E; Tue, 11 Apr 2023 05:46:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <a356d9d4-e7e5-460d-bf90-b9d51649a20b@app.fastmail.com>
In-Reply-To: <ZDSjBQhyDBGi9wBN@nand.local>
References: <CAKazavxTXwcZFtL2XyU3MpaUR=snWY8w8Lwpco+mkbqm2nWE=w@mail.gmail.com>
 <5b99135f-c1d4-434b-b508-35f5d66dd2bb@app.fastmail.com>
 <b5316855-971d-4b7b-89cd-e81ececc5124@app.fastmail.com>
 <CAKazavzS112w3wsxnA-2ibWH3xGrE_w7Av+VZg-DfgfH0aK72A@mail.gmail.com>
 <ZDSjBQhyDBGi9wBN@nand.local>
Date:   Tue, 11 Apr 2023 11:45:47 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Taylor Blau" <me@ttaylorr.com>, "Rohit Ner" <rohitner1@gmail.com>
Cc:     "Derrick Stolee" <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: git log causing hang while browsing upstream linux
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2023, at 02:00, Taylor Blau wrote:
> TL;DR: if you run "git commit-graph write" once before running "git log
> --oneline --graph", you'll get near-instantaneous results.

Cool! Testing on Linux repo:

Without it:

    $ time git log --oneline --graph | head -1
    *   0d3eb744aed4 Merge tag 'urgent-rcu.2023.04.07a' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu

    real	0m11.379s
    user	0m10.655s
    sys	0m0.726s

With it:

    $ time git log --oneline --graph | head -1
    *   0d3eb744aed4 Merge tag 'urgent-rcu.2023.04.07a' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu

    real	0m0.032s
    user	0m0.014s
    sys	0m0.023s

Maybe I=E2=80=99m gonna enable `git maintenance` for my repos. :)

--=20
Kristoffer Haugsbakk
