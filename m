Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F15C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 00:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiJKAUa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 20:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiJKAUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 20:20:25 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038943121C
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:20:23 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 00D402B0683D;
        Mon, 10 Oct 2022 20:20:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 10 Oct 2022 20:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schrab.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1665447621; x=1665451221; bh=4Sn9Cn3q+p
        82Fi36alvK6wsva4AVh/mlPFgbAU337mc=; b=B1V2BhQ1VBnvzBFRmnTL9Z3GFz
        ts5zF+rnlXu5JfCtjYW7Vvev0ybXxgGugM8GKFXjE4sJ5qX52mFeODlxJwyyAf9q
        cACp9w65H65l8kwbyQgUHro530I437/NsZeUIAMMElpceNaHOiEI+dYL7X3I0As6
        DEZyu6FF54g1MmdMUX7CvnCZnBCHUKr1PoSrcXbragPgPZA9ouevteyAX1mehtNC
        Jas91VY1g8mUpGbWykurS0XjTs/e0sZR+FetsloTFR3rDl1j9A833qmLFIacrixB
        Y+CtaqIrQAEk/XGBbNMcAdPZyvdrHyTWI72Fstram1dL3Z598pw0yFpNdk9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665447621; x=1665451221; bh=4Sn9Cn3q+p82Fi36alvK6wsva4AV
        h/mlPFgbAU337mc=; b=lKPkg7Q2F6CvQzwdGKWtrMikGdToR3RFOqo8CGhtGvFV
        U33VkJ63uah4WnYMkSwT0NfFZX9pOIa74b3HZqPDQNmgxUfoUYIV15v8FLXRt2NR
        eVOQA+NasCWxMAiO7teCW0WLC+btGMFs5yEfJoXODYHZab/xIVx2qia35jdydgGK
        7rbJk/A6Ktjpw7Pe90/AaK+70yTQ4cNGtwKDfr0PeNCxoUatFCTiI3/75W21Q793
        OQYvjtOTCftZ1iotdHbuh8o/v7ZpKiuJm72LSsKe4NHgVXEpLErGf2r4GL6t/2WB
        5LMR/BMfj2I02w/WbixLkKLc4V8K485UfmBlGSrQ0w==
X-ME-Sender: <xms:xbZEY45m1gEAeX7AeIqJ-hg6vfI8uFWxeEklnH-2mGsz3rwlQ5T3mQ>
    <xme:xbZEY55aS19EzZ0KlClgv1Wt8j3Cc_pq7UG0o8R-uf5EcYwtmqp6EoNLhisYL_VSj
    WMSAWF_9JumbHXtmIM>
X-ME-Received: <xmr:xbZEY3fhh8sJDIYehK22MNn-fQGPKlbg2Aw3sykK0zwMCaylU1sXuyjVYV45jfmmHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejhedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeetrghrohhnucfutghhrhgrsgcuoegrrghrohhnsehstghh
    rhgrsgdrtghomheqnecuggftrfgrthhtvghrnhephfdtfedviedvhfeiheeuueetleevke
    ehvdeuvdfhffeghfeiveegkeduveegteeunecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheprggrrhhonhesshgthhhrrggsrdgtohhm
X-ME-Proxy: <xmx:xbZEY9JVAw5Kxs1PTZTO7L3LSJsP6ZsvaLS2sYVfmFvPKhoquJMuuA>
    <xmx:xbZEY8L6YWxhYWt_bCA664OW-71pOGRIhrJ_2dg1Sq8tCUH6-iMq9Q>
    <xmx:xbZEY-yswBRcwLxvPipTML8vp1oTvuOe-9zsrewM8-eHgeH_8gR-tg>
    <xmx:xbZEYzXeNEzshZWDonmY-mJJcQbDEt7QtP2J4fS_NGeQRDE3AfC-mLfChzs>
Feedback-ID: i1fd14616:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Oct 2022 20:20:20 -0400 (EDT)
Date:   Mon, 10 Oct 2022 20:20:19 -0400
From:   Aaron Schrab <aaron@schrab.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        sndanailov@wired4ever.net, git@vger.kernel.org
Subject: Re: [PATCH] docs: git-send-email: difference between ssl and tls
 smtp-encryption
Message-ID: <Y0S2wyfUF1mZaryi@pug.qqx.org>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        sndanailov@wired4ever.net, git@vger.kernel.org
References: <20221010172859.13832-1-sndanailov@wired4ever.net>
 <Y0R2AwKuXAVMP5Ma@tapette.crustytoothpaste.net>
 <xmqq35bvz10b.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqq35bvz10b.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At 16:56 -0700 10 Oct 2022, Junio C Hamano <gitster@pobox.com> wrote:
>        Specify how SMTP connection should be entered into encrypted
>        mode.  The valid values are 'ssl' and 'tls'. Any other value
>        reverts to plain (unencrypted) SMTP.  'ssl' refers to "implicit"
>        encryption (sometimes calls SMTPS) that uses port 465 or 587 by
>        default.

There can be only one actual default port for each of the settings and 
here that is 465.

Also, port 587 belongs with the 'tls' value. Perhaps saying something 
like:

     uses port 25 by default, but port 587 is often used as well.

>        'tls' refers to "explicit" encryption (often known as
>        STARTTLS) that uses port 25 by default.  Despite their names, it
>        is likely the user is using the newer TLS protocol, not the
>        deprecated SSL, for the actual encryption protocol either way.
