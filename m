Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE0D01F404
	for <e@80x24.org>; Wed, 24 Jan 2018 18:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965027AbeAXS70 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 13:59:26 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44465 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964999AbeAXS7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 13:59:25 -0500
Received: by mail-pf0-f194.google.com with SMTP id m26so3811512pfj.11
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 10:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kv2IbMpqIHbfd+5MJyO2pLyjQ4E61Ymz+IlDZ2AORMY=;
        b=nWppFv63MTCw7We3DRCEXf1Z5zAGSmwkivDJ1OHERw4foxOlqR0OtFOGYeUujiD1Ak
         /S6nXnC77t8i4SOwa7i3hyJkjb/ZE+3ujG7rR4TCu8nAdYE2BL3P1XmOLbXY7eyFgHBK
         sD152gD/QWMT+LQNDgdg3i6K2n/fx6oWervYYFIN9/1v+wsI+/VX4o5IntU58/r6VNUQ
         QjMe5XApbSMG83K52xhAaQ2bJp1T0cbCp13gaP5UyaA8rpAReGzDDmv48y5ru9HUAQch
         vq152su83UJ95yDHjCsKoY8bCgqBTNiqp7GP+8Vfx2gCpOV5vB4EeYNm/jzNTNl+lXN2
         X93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kv2IbMpqIHbfd+5MJyO2pLyjQ4E61Ymz+IlDZ2AORMY=;
        b=JPIFcQBb7W7O0acJeySYhvhKmZ5Dk6P2TZUEvg7kc/CaNgz2b/KIrxgxY+MEMQ1ymO
         Dog16oBZ2/o5KiuC3vE9W7XQXPpvMOsRIc2CIuU05QaI825e4JR9mFI2VnjgEOXfiNE7
         e6hHHairhoDNDp1oIlPdvAnXdlO8gMsVVRNz2Nk/ApeYhBgb/ygJ8UUt+PCoFQA0axDo
         T6St1DZCPIw9G76jtJRAJMIXYJBb6TxdOGqYJMmb9yftJ81/e8N1sxdZybaO6EjhZfWL
         7rrPbxKl5OZTWEDJ/+06e4BuXJQurxHU1guIqevSMnDmQdE+w+o8c1uiwSxSj5Fm6BXt
         luAA==
X-Gm-Message-State: AKwxytee0ZP3U0eyzVLinw420KnGwMMCu/St1wjL3Qoae44ABlFaK8z2
        VtYtb6Kcy8EvOkLL0j3Ug6k=
X-Google-Smtp-Source: AH8x226iR6r5QIXpbXwsBkkYa793LmcCF+KtnLUaBAGQ0z6uYHbtwQ4UQyDEofK36Mi5+JwbI4rQfA==
X-Received: by 10.101.69.199 with SMTP id m7mr11400858pgr.444.1516820364892;
        Wed, 24 Jan 2018 10:59:24 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:69e6:5f42:e334:a0e2])
        by smtp.gmail.com with ESMTPSA id d22sm12040678pfl.135.2018.01.24.10.59.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jan 2018 10:59:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 3/3] sequencer: run 'prepare-commit-msg' hook
References: <CAKdAkRSuNhEri+3eUbX8iVjr0JUyADSJBtgL==VjNwgKwe3Xqw@mail.gmail.com>
        <20180124123422.10637-1-phillip.wood@talktalk.net>
        <20180124123422.10637-4-phillip.wood@talktalk.net>
        <3587bc5f-c5f7-d037-6644-25e21a5f4942@ramsayjones.plus.com>
Date:   Wed, 24 Jan 2018 10:59:23 -0800
In-Reply-To: <3587bc5f-c5f7-d037-6644-25e21a5f4942@ramsayjones.plus.com>
        (Ramsay Jones's message of "Wed, 24 Jan 2018 18:51:22 +0000")
Message-ID: <xmqqh8rbdqwk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 24/01/18 12:34, Phillip Wood wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>> 
>> Commit 356ee4659b ("sequencer: try to commit without forking 'git
>> commit'", 2017-11-24) forgot to run the 'prepare-commit-msg' hook when
>> creating the commit. Fix this by writing the commit message to a
>> different file and running the hook. Using a different file means that
>> if the commit is cancelled the original message file is
>> unchanged. Also move the checks for an empty commit so the order
>> matches 'git commit'.
>> 
>> Reported-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> Reviewed-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>
> Echoing Eric's earlier email, I don't think this Reviewed-by is
> warranted - I only requested the addition of a static keyword,
> I didn't actually review the patch.

Thanks for clarification, and I tend to agree.  You, Eric and I
certainly did not review what is posted here, so if I "git am" these
patches as-is, we'd be lying.

Having said that, I think this round takes all the review comments
raised against the previous round(s) into account.  So I'm tempted
to tweak them with s/Reviewed-/Helped-/ and queue.

Thanks, all.
