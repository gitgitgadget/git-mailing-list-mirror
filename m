Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A04FC2D0E5
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 18:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95B820777
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 18:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kdgUfsz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgCYSn0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 14:43:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55231 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgCYSn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 14:43:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F2EA7B610F;
        Wed, 25 Mar 2020 14:43:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T2en+WbBwP6yHGpozMoodMOD+d4=; b=kdgUfs
        z8Zs54AkrMmG3KTXg2jkbXSPHfUe36LRu7sY18xoGzUPVypS7yUPgcPWIelA78Y0
        D1GdNv/CjH1bK4iloz6xuOB5zXSpcClVQF4s1UH4Tm4ZEw9Za7GBYhVQVZwLT86O
        aAaRLVr/YxUaNct5Yxd2GEGJMyE9A4HalmetM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=exc4m67KcGD7iKwZtMMlILvEjGViPm/J
        QcnKblIteioOQ0Rcs+HsHyc+PA16/StfTQqhXxGBWrSuuPV10rc9Jg3p3RqyyijD
        zUSarGrtfN4FxaI6SDMwRTCaJOs/eQJyGIUhABww2b6hnL5tukT2KdhbUl6tnite
        SuAzel7VdSw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E397DB610E;
        Wed, 25 Mar 2020 14:43:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3578BB610C;
        Wed, 25 Mar 2020 14:43:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] import-tars: ignore the global PAX header
References: <pull.577.git.1584968924555.gitgitgadget@gmail.com>
        <pull.577.v2.git.1585078545448.gitgitgadget@gmail.com>
        <xmqqd0911n3b.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2003251859070.46@tvgsbejvaqbjf.bet>
Date:   Wed, 25 Mar 2020 11:43:19 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2003251859070.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 25 Mar 2020 18:59:14 +0100 (CET)")
Message-ID: <xmqqlfnowa0o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 803F4A14-6EC8-11EA-BB04-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Too many of such in-code comments added by me became stale. I'd rather
> keep this in the commit message where it explains the reasoning for the
> current change.

I was updating this week's "What's cooking" report, and described
this one like so:

    * js/import-tars-do-not-make-phony-files-from-pax-headers (2020-03-24) 1 commit
     - import-tars: ignore the global PAX header

     The import-tars importer (in contrib/fast-import/) used to create
     phony files at the top-level of the repository when the archive
     contains global PAX headers, which made its own logic to detect and
     omit the common leading directory ineffective, which has been
     corrected.

I guess we are ready to mark it as "Will merge".

Thanks.  
