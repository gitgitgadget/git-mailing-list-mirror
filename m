Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B66C4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 20:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0287823110
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 20:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgLEUQ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 15:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgLEUQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 15:16:28 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B32C0613D1
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 12:15:48 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id g185so10039964wmf.3
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 12:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o5smB1Z1I5nobHEFzpkwbNV8xqqcNPddMW9CM6NSRek=;
        b=FpWsS0YGyOtueYrpWYIb/S2nHTBpoPBW6CShO5OFfxyWAuVhW6lBzAY5IMXs1IBcL+
         7Kzm06ytqyKI2Jl/cE4P8lt2qy0xVjQB+KTVhRGMfDbPxfPDbGRcwGVjqC070rGEmzcU
         AvNpJHcZiESbjpgsbyTQ1P4QWxQa89BFRz9JuRf92L7qiUVP6sVJ/xkwHaZ3/NYdF5y6
         yGhPVakYrP1yB8QuegZJrnlqEGmbvPAzi0FNZUI+EWSwRfWf7aksM3MS9CzQQ2p44sZZ
         otsjCeyqHoirZ24cH26JpYfMhGheCh9fgH7UBrHQGcKUfJkRxkuvXuCPFlo4mftjNALU
         hGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o5smB1Z1I5nobHEFzpkwbNV8xqqcNPddMW9CM6NSRek=;
        b=CWyYpvNimNF5IyBy/KAZqKnMK77uwO6hyymtZYODDvPLinZOI67k9fp23X1ejA8sje
         M66vyv2P9Mg9odcrDBQor4D5VESNdbiZJpEVCirUeWSvpmfD46PdgRQouSpLYjtd14dq
         6OVi2O0mg4f00WeWFMQGBikv4pjP50V/GOCApfjfHpP9EUdNHg8X17k1QXkRWTwYMCE6
         bV2w9o0kHH70algyhu+fCw0gMrJ6fkbD6OofFdrPU4frViFVaLpBhd/PrdUoOXkp6DHB
         QxCG9nr4KF0MiWNIqio5xjHWQQn9lfNxZT97vszvCSoIulGhaOO1rhsCqO4h1x+5RKCg
         Ibzg==
X-Gm-Message-State: AOAM531YmrIHadOcHDvB2VZY7elZkrk3eysxMuoY9k2KdXTu19Pl9B6Y
        LrhHSWXQn0Bl+gJ9TxGapyQdf76rzP+FnhGx15nFwMgZLSY=
X-Google-Smtp-Source: ABdhPJwrb744D+NHg4m9GEqWAjr5bPnHs9xoXs4Y6kfnb1SynIlvah4hX8mVlppDF7SyH7pUvPMigHU0fdXbE2yxixw=
X-Received: by 2002:a7b:c843:: with SMTP id c3mr10630933wml.100.1607199346648;
 Sat, 05 Dec 2020 12:15:46 -0800 (PST)
MIME-Version: 1.0
References: <20201205195313.1557473-1-felipe.contreras@gmail.com> <20201205195313.1557473-14-felipe.contreras@gmail.com>
In-Reply-To: <20201205195313.1557473-14-felipe.contreras@gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat, 5 Dec 2020 14:15:35 -0600
Message-ID: <CAMP44s3xqjoJm5AL6dLcS6R-RFGGOdQ39W+ZY3_PWL+WMeCxjw@mail.gmail.com>
Subject: Re: [PATCH v3 13/16] pull: add proper error with --ff-only
To:     Git <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 5, 2020 at 1:53 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> The current error is not user-friendly:
>
>   fatal: not possible to fast-forward, aborting.
>
> We want something that actually explains what is going on:
>
>   The pull was not fast-forward, please either merge or rebase.
>
> The user can get rid of the warning by doing either --merge or
> --rebase.
>
> Except: doing "git pull --merge" is not actually enough; we would return
> to the previous behavior: "fatal: not possible to fast-forward,
> aborting". In order to do the right thing we will have to change the
> semantics of --ff-only.

This commit is wrong, the next one somehow got squashed into it.

I'm sending the two patches separately.

-- 
Felipe Contreras
