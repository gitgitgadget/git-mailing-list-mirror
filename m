Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7968BC64E75
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 09:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2750922201
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 09:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7MFi0C8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgK0JNe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Nov 2020 04:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbgK0JNc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Nov 2020 04:13:32 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD60C0613D1
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 01:13:32 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id k14so4809966wrn.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 01:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/lerpByANzYJQQO77BKBIjSFhdLPePoLW1utzoKtBbk=;
        b=d7MFi0C8OdxzITXkNEPHMGhxFrekFcMV2qeKI6ZNZVfyyk17L+F8b3evZ1vdbkPgqK
         1UYa6NXP8Md5tG2GGHLQE9PdARbTPYszOCooivbewXEaaovKcSqdhsiTPSb9qqZFyyvz
         FFXCHm9+Myqlhce+E5POIjnFK2MaRnKaTBmsqO5+E+Zzp6nu9UtHFH0ozyeJ3FJ5ntwp
         mLwE1HQhx8fl82KNhZSsPKEndCKeVatKXqMQ6k9qAfk7YDgq3AUL/YApuQz+9csmsJX0
         UkLiCLi+pD7anNMola6WdoJ2wXE03dRk40DTV0uL9SD13/ADOJTq6FnOHaN2tJLzrmvQ
         aKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/lerpByANzYJQQO77BKBIjSFhdLPePoLW1utzoKtBbk=;
        b=ZU8oAdDW2jfow3kINXXaIqRhJCewDaxZEYXbWwyC+ykRrmQ8pixhNcQ5NrC4ADPXav
         iH0+oqs6270Bdt1S46x3u4MOw4FyAXz1crCiVaQdmCFXWtYtFJOYM5VD3+0pvY9bZv8w
         YVXymdvFpwIj5wWXJ7Kj70AE7vf7InboAoVTMKRzwsubh2MXkhcBgJPxPkZ81hNXae0U
         R83/qDMsUDEk79hgHUnQB9tagzIc6nXGNa+S9xGRnxy0KtLPNFDx73scg7mvsX8NJHXA
         VvaMXI1aKWZ0FHHE2mk+2CbwZLH21yTEZpQfQcfYV2CqHlDPPn/uQUB8lfbmS3o8fvBb
         +LwA==
X-Gm-Message-State: AOAM5328S0RdzZPIEPQLb28I7fVC4NITBc/5y3y4ZD0bhD5DGoVkvZYs
        fdN+s63fv5xdwahziAS/GJB/YYXb4GeqvnikdQM=
X-Google-Smtp-Source: ABdhPJzJzOeAOHnmbd9UR74Uj5ZaX/BCt0OrAPa5/HsSVhq0yIQLSt3X+G+9ByQ3xfNK/QMOSXRP1IJEZdcuZvdBFk4=
X-Received: by 2002:adf:e788:: with SMTP id n8mr9223350wrm.84.1606468411180;
 Fri, 27 Nov 2020 01:13:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
 <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com> <2aa30f536fb7ce5501d1ecf0315cbcb1c1c5ce38.1606419752.git.gitgitgadget@gmail.com>
In-Reply-To: <2aa30f536fb7ce5501d1ecf0315cbcb1c1c5ce38.1606419752.git.gitgitgadget@gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 27 Nov 2020 03:13:20 -0600
Message-ID: <CAMP44s1EhqDf4_T1zLC8iXA32P1atVMW-AnP=EJ3eXTzUbnU8w@mail.gmail.com>
Subject: Re: [PATCH v3 04/16] reftable: add error related functionality
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 27, 2020 at 2:42 AM Han-Wen Nienhuys via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> +/*
> + Errors in reftable calls are signaled with negative integer return values. 0
> + means success.
> +*/

This is the format of multi-line comments:

/*
* A very long
* multi-line comment.
*/

> +enum reftable_error {
> +       /* Unexpected file system behavior */
> +       REFTABLE_IO_ERROR = -2,
> +
> +       /* Format inconsistency on reading data
> +        */

No need for a multi-line comment here.

> +       REFTABLE_FORMAT_ERROR = -3,
> +
> +       /* File does not exist. Returned from block_source_from_file(),  because
> +          it needs special handling in stack.
> +       */

Once again, and for the rest of the file.

-- 
Felipe Contreras
