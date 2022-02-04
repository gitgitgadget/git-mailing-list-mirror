Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D74CC433FE
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 18:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377461AbiBDSQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 13:16:27 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:45529 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238169AbiBDSQY (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 4 Feb 2022 13:16:24 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 051F15C0067;
        Fri,  4 Feb 2022 13:16:24 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute2.internal (MEProxy); Fri, 04 Feb 2022 13:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=artagnon.com; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=CFUuTTAIEKvE6gLwvlr9qotstFMVmTuP0qQ642
        3fIB4=; b=c1R8VuNjq3Xdudb8P1w1R0vWDDryqkBwFWl2IvyDDE1CC2jUK99e5w
        UBOWYO3YVuA3wXyBG5ovFon9amLkUMgefM251xka2cvgAcan153Dnho3fePbGluB
        UxtPfAgPS38ZZA5k4cJKLg9/fP71Bok5SCXJHMe11CHKA1M0LJxbyHE9Mm6LRYrl
        OSUEih3tHOPHNSFQ720jwx15Phsr3j3tWL5Zm7VmcD4OTuJvskoKJ9zJ+BmV4ixI
        Vg1mwRWZZiY4MePA8Dwd5ck599wF4pvraV04MAI00s7+A2smIXdWpPKtmDByGJzv
        p38IO5+ixDqGaDwmwzaQOSFDIMCU0emA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=CFUuTTAIEKvE6gLwv
        lr9qotstFMVmTuP0qQ6423fIB4=; b=fDnYaEF6AkU3mftsQ4U730P12gr6Vp34/
        Gv35YP+Ci0a9cv4UOq8rNlK15RFO4uT9AtSXf2zLQBVhm/6mh7XggF2aj32KB6kh
        olG6uw68Gt9JTmbI7EX/D6o/CLbGXwgH5pHhcHUIz8QRdYWMHsTjoygA5ap0PGN+
        /oRDmiJSRU7MLSkaF3YbbmKChlG5YsfegjJzIyUQ77lanoP+6neqMzs046UcLORo
        N9YozL70rwBrhh/aQXft3yzQY5VQSWsygEDpw9gy1/ZrbgE3jjmmPf5YReKNazyh
        7SK6rs/reOzIkIJfpdvoqCuGwYD6fkaAGGPYw8csJB2eoPl3sDlTg==
X-ME-Sender: <xms:d239YRKzsYLO9MLqrQTCVMSfpobPgh1qQD0I5yHIp7022hp0E7dpBg>
    <xme:d239YdKGGUUEq2cwXOiVQTxLIbmyXZiuLLpMpCf3hvNv5UfUUAUbV-gnRsQr51FXb
    poxIdJORUL1Sk61eDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeelgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdftrghm
    khhumhgrrhcutfgrmhgrtghhrghnughrrgdfuceorhesrghrthgrghhnohhnrdgtohhmqe
    enucggtffrrghtthgvrhhnpedvgeeutdfhhfegleetvdejheejveegffekheefffefudfh
    leekteeuuedtjeelffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehrsegrrhhtrghgnhhonhdrtghomh
X-ME-Proxy: <xmx:d239YZtr97dNAfm92Eouk0LKXzYuUn06MSlWDLAexAwgqWOBIWdTtA>
    <xmx:d239YSZ_zYAtZIhXL3IBrae-CxqpUxbUs8zyFqTubqr8csDHSZl_mA>
    <xmx:d239YYYLB98xmCjU2DYPtm90x26_kqVrqWnxG394yjWP9KKMe3G7Iw>
    <xmx:eG39YXnDOcHFX1hFbcjz60YPT4_Tpu0ESnQhEKYRYtqMe9xLEJ6ETw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BC42A1EE007B; Fri,  4 Feb 2022 13:16:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4586-g104bd556f9-fm-20220203.002-g104bd556
Mime-Version: 1.0
Message-Id: <6b8ce04e-8f7b-4ed5-a1f2-42aa4d8a7438@www.fastmail.com>
In-Reply-To: <xmqqa6f7pime.fsf@gitster.g>
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
 <xmqqilus3ctf.fsf@gitster.g>
 <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
 <20987dc6-e0c7-6ca2-19fd-2b323b3f6d9f@web.de> <xmqqa6f7pime.fsf@gitster.g>
Date:   Fri, 04 Feb 2022 19:16:03 +0100
From:   "Ramkumar Ramachandra" <r@artagnon.com>
To:     "Junio C Hamano" <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     "Git List" <git@vger.kernel.org>,
        "Christian Couder" <christian.couder@gmail.com>,
        "Miriam R." <mirucam@gmail.com>
Subject: Re: [PATCH v2 4/4] bisect--helper: double-check run command on exit code 126
 and 127
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> * Can we have *no* rev that is marked as "good"?  I think we made
>    it possible to say "my time is more valuable than machine cycles,
>    so I'll only tell you that this revision is broken and give you
>    no limit on the bottom side of the history.  still assume that
>    there was only one good-to-bad transition in the history and find
>    it" by supplying only one "bad" and no "good" when starting to
>    bisect.  And in such a case, ...

Hm, this addition might be an unpleasant special-case syntax, breaking both `git bisect start [bad [good]]` and `git bisect bad ...; git bisect start`.

R.
