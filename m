Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02324C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 11:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AECD964F77
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 11:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbhBCL5x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 06:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbhBCL5v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 06:57:51 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BB9C061573
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 03:57:11 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id f14so10994666ejc.8
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 03:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:message-id:references:user-agent:in-reply-to
         :date:mime-version;
        bh=Odz6GblsQt6ddDqUy2qwieyKZTvDxaMjS8qGvWJ61pw=;
        b=suoqjp3dCf5cGeAtpN5TvsmAl1pznJpv1LbZL2g8Bx+ZQP7vC6UQKcY3ZEePMF7tPV
         Kgp6EeU66TlRXhsRlbhDtLM1IepU75Y+gLllQ7QQKKtJDf9LmPNsFh1RzhD9talbQiDV
         W7tEqRc4WYkfWEPqsEi4UZ2dnQnPnWR9nhdgVmUDycRrcwMZHx85m2sT4Cntklq1epmR
         Qs6kO3qSygkXLNdZb8sEcPJpIErUSezWK+9AEcU764Thol676fLMv9R7EtPzzke2OjUu
         GXqbvU6HTsD2++MCwxx38T41GZYvujN095Z6P/1qRnB4ye3XOvKwFlf4Q9by+l0DEEqx
         cDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:message-id:references
         :user-agent:in-reply-to:date:mime-version;
        bh=Odz6GblsQt6ddDqUy2qwieyKZTvDxaMjS8qGvWJ61pw=;
        b=S2nDtwl9aBQyVXw5VAtll1+8ylk6MOibGD2MWYXl8oTB+YeGprpwDpn/vNwP5tWqgJ
         zoEQXTRVq1mWu9y44kjzCRqOszOWBW3SJcGcDqvZpvJu/hq2Zhp4Iaoy/VNcweJ81Jm/
         4d+XkIwGMhJ0idz2UJKyrzy3PU6RJxm7BhgcjT66RXsq7Au1PZJ9bPSyxKZXw+jr1s47
         /SbrHw/epKouzgn8EJNgTiljdoR7nqBd1mmJSqdCUKJJ0SUND5wEfH7LGFGoMKNadR2u
         LIaNIassnmdX9tG92IDgRBFa1OJc/uxiuOrioMWMtTgqzCzG5TJ03HAlZ1p+3IM4BtYz
         PTeQ==
X-Gm-Message-State: AOAM5331yxTar03Ncn8M1OM59f0LDnh0jsc5BoTJQhrmYJZVXMOTupJY
        1y586/eaFLSJLHSLrt3B+3bTlyzFGiCILg==
X-Google-Smtp-Source: ABdhPJyVhUlvasgX0813TDmVCVYxw0lFAHO80XzHLz2lzXssprhLT1w5loSGo0RYHLosxcOQrMRIGg==
X-Received: by 2002:a17:906:1355:: with SMTP id x21mr2825487ejb.53.1612353429576;
        Wed, 03 Feb 2021 03:57:09 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id u17sm904896ejr.59.2021.02.03.03.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 03:57:08 -0800 (PST)
From:   =?us-ascii?Q?=3D=3Futf-8=3FB=3Fw4Z2YXIgQXJuZmrDtnLDsA=3D=3D=3F=3D?=
         Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Why does fast-import need to check the validity of idents? + Other
 ident adventures
Message-ID: <87bld8ov9q.fsf@evledraar.gmail.com>
References: <pull.795.v2.git.git.1590698437607.gitgitgadget@gmail.com>
 <pull.795.v3.git.git.1590870357549.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <pull.795.v3.git.git.1590870357549.gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 12:57:08 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


[Originally sent 5 days ago, but seems to have been a victim of the
vger.kernel.org problems at the time, re-sending]

On Sat, May 30 2020, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>

Full snipped E-Mail in the archive:
https://lore.kernel.org/git/pull.795.v3.git.git.1590870357549.gitgitgadget@gmail.com/

> There are multiple repositories in the wild with random, invalid
> timezones.  Most notably is a commit from rails.git with a timezone of
> "+051800"[1].  A few searches will find other repos with that same
> invalid timezone as well.  Further, Peff reports that GitHub relaxed
> their fsck checks in August 2011 to accept any timezone value[2], and
> there have been multiple reports to filter-repo about fast-import
> crashing while trying to import their existing repositories since they
> had timezone values such as "-7349423" and "-43455309"[3].

I've been looking at some of our duplicate logic here after my mktag
series where we now use fsck validation. It had a hardcoded "1400"
offset value, which I see fast-import.c still has.

Then in mailmap.c we have parse_name_and_email(), then there's
split_ident_line() in ident.c, and of course
fsck_ident(). record_person_from_buf() in fmt-merge-msg.c, copy_name()
and copy_email() in ref-filter.c. Maybe handle_from() in mailinfo.c also
counts. Anyway, aside from the last these are all parsers for
"author/committer" lines in commits one way or another.

But I was wondering about fast-import.c in particular. I think Elijah's
patch here is obviously good an incremental improvement. But stepping
back a bit: who cares about sort-of-fsck validation in fast-import.c
anyway?

Shouldn't it just pretty much be importing data as-is, and then we could
document "if you don't trust it, run fsck afterwards"?

Or, if it's a use-case people actually care about, then I might see
about unifying some of these parser functions as part of a series I'm
preparing.
