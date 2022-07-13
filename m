Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1133C43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 22:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbiGMWW6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 18:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiGMWW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 18:22:56 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAE92A731
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 15:22:54 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 8DD1A320091A;
        Wed, 13 Jul 2022 18:22:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 13 Jul 2022 18:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1657750971; x=1657837371; bh=8n9iSxiVlk
        HK2dJ7i54yCdLjWAHflTbUOLJ1neS2vtE=; b=f5hjOkZ3jyeHZ6DIZ5LfBQhR1C
        f+o6bDxPJ3Ve7dciK9eK6JR/89QrqeszyNbTWjxPm839/Hsqn2mmKWFTAeNLmMd+
        +ZEaAwIhPqR+Y27jc7JSAVy0qyVu4aaz54xWl1Hnh8bhjOmSZRQ7aUz1XPq5uI2O
        h8GqKB8n3DpEUIKpTEUBVgR4wg1feoHUZznzbBAh7MBPrxvXjrmR3gZwpxs4MVG2
        IY0e2gNEgixSCfvZ0ue+9Ka282l6Vwv5niRRD7QlrUW20s1O4GZsZA/a5nf0bJFh
        HyE6Krn0fkwVshwo0Yk448jfI5M+sFxlsiKwuAG1uMRj4vL4mYxi2cKaJ9Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1657750971; x=1657837371; bh=8n9iSxiVlkHK2dJ7i54yCdLjWAHf
        lTbUOLJ1neS2vtE=; b=fQwMzppE0Ecn6JVixjQeB+OLc93Z75tDLdU4NYS//y64
        a3SzjM2I4rqqfFAOMu2D6398p3+/feRFJftSY01RDlXbMC2M1CYY9Q+VfNlZKK9O
        4xLuVTGChiYoYDuATUQKSFez7+rCCTRwqd73VeToJv1TurcgGVdZro1hvLc83nMM
        tpnP6CUgvTdMTskiJdgTlum/pkvHkK4KFdKCyFdtKIOAZinN4Vvp4uqloKMsiy43
        qVxLBzRUmIPP3+jPSvXu59ftAr884168GwO+mi9rKSo+v9bpTr+KCkvK/sBKGQ6l
        vRRrLoWseWwT5Nw6zM3pqazFAr7KqjvbEyOrrGClmQ==
X-ME-Sender: <xms:ukXPYp5hULZEOFsWuMelxUlzb82eMjTnDaZFjQ5QWCLJ5JFsuhCZjA>
    <xme:ukXPYm6giyHjSPRbBTZCbiJWUZGZdLpe-SF3Q2EyMT68eYfEiLXKrjNn_Ib3D8JqK
    wE_ZWHAsZZEsuZz7A>
X-ME-Received: <xmr:ukXPYgd7Xvs1WsZz71iiSTX2pJmazAFftr5IpBqHnd1IP_DXzL-j_pqqs7Icuflf19t4g3twQDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejkedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhephfgvrhhn
    rghnughoucftrghmohhsuceoghhrvggvnhhfohhosehuledvrdgvuheqnecuggftrfgrth
    htvghrnhepffehveetfeejveeikeehueejieevgfeuvdeifeelueeigfdttdelleehveel
    vdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:ukXPYiIYGqvevR1zWMmGpIA6_4UCeHGbHwCzfxxErQ8oh-WxhT047g>
    <xmx:ukXPYtKWZkN-NWTYEkna85vXj-qlJCjSJ0m1g4deIPjjJh2Qh4Pt-Q>
    <xmx:ukXPYrx_rYTLGsKKqwq8zim_4a3VpkYvX9Znz8y74gI---q7BQuK5Q>
    <xmx:u0XPYkXsCl9HP8Zh19TmNl_khLiO5C9XE0ViqooJowO7t5Z4Qes-Kg>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Jul 2022 18:22:49 -0400 (EDT)
Date:   Thu, 14 Jul 2022 00:22:46 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] mergetool(vimdiff): allow paths to contain spaces again
Message-ID: <Ys9Ftu3z6zedCsoX@zacax395.localdomain>
References: <pull.1287.git.1657726969774.gitgitgadget@gmail.com>
 <xmqq7d4gbu10.fsf@gitster.g>
 <Ys86MnwhembiXRxj@zacax395.localdomain>
 <xmqqr12oadbk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr12oadbk.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/07/13 02:54PM, Junio C Hamano wrote:
> 
> OK, because "1" fails to execute, the expected output Dscho had
> (which is for the case without base) would become invalid when we
> use "true".
> 
> Perhaps we should use "false" instead?  Or do we need to test both?
> 
I think testing both is not really needed as the unit test is just making sure
that filenames with spaces are processed correctly.  Whatever comes before
(which changes depending on the value of "base_present") doesn't really matter
as long as there is something.

If we have to select one ("true" or "false") using "true" seems more practical,
as that way the BASE file is also included, and thus an extra argument is
tested.

