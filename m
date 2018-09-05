Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BFB91F404
	for <e@80x24.org>; Wed,  5 Sep 2018 18:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeIEXbL (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 19:31:11 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35334 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbeIEXbK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 19:31:10 -0400
Received: by mail-qk1-f193.google.com with SMTP id f62-v6so3899860qke.2
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 11:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HCI1pPsE/HznYaDWUuiyF/dgg0e/l1+4N92WeclPsKM=;
        b=H2WQ2zicVRMUNuuVPqokdyyuzTT79a8s/pnxQqBDZtV+1J5Kdcqr2fTazBb/0byHWn
         IY+tFvIgQiVY3IYy5MiemBjy8WnBP1ya54Aq7kLdQtBG4/VYZ6BRaPT2lRSefpDCiIlw
         Q4wcXuNWPBjm2xqiDhA/fjXEG8QOHyDxaddxFaEIg4caQyFXaEsmanUEzdBoAp1ub5ar
         tGLJ68gpI7qwHqaYrJxSxBDjG8PgVG+Bsyo25bn5pIpSeoTCrTM4WzSSazynperI5pkx
         GKvayP/e1h6L4+tvDP3xKHcem+vRIcgQNLCsGDMxZqbo5UYOfE97zMzKKH7jJWenJcKT
         0i7g==
X-Gm-Message-State: APzg51AImtq8H0GW5Q9Dp+tUYSoWXrls/ufBCIYY2/n1WE4BWOpkSxnI
        /Q9IMW2nFQzbRrL8+03bv2QoByPo5+dO986EFG+tCE4h
X-Google-Smtp-Source: ANB0VdaSGbD+/QeclKQC2ozwUnUjlTfw/huFzu87VVB/J/9r6EYJ4P0IugurPb3iUGiWyAqGsS10+FhZ0mlJ9nQkd2M=
X-Received: by 2002:a37:9306:: with SMTP id v6-v6mr33331668qkd.36.1536173981724;
 Wed, 05 Sep 2018 11:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.34.git.gitgitgadget@gmail.com> <8dc38afe2b4d73e940daf9a0ff7f9c0a38802d95.1536158789.git.gitgitgadget@gmail.com>
In-Reply-To: <8dc38afe2b4d73e940daf9a0ff7f9c0a38802d95.1536158789.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 5 Sep 2018 14:59:30 -0400
Message-ID: <CAPig+cR4vEcMBe4REd4Z=WMG-MR4PUnyNNBxoJacUXzB8ho6fg@mail.gmail.com>
Subject: Re: [PATCH 01/11] multi-pack-index: add 'verify' verb
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 5, 2018 at 10:46 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The multi-pack-index builtin writes multi-pack-index files, and
> uses a 'write' verb to do so. Add a 'verify' verb that checks this
> file matches the contents of the pack-indexes it replaces.
> [...]
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> @@ -5,7 +5,7 @@
>  static char const * const builtin_multi_pack_index_usage[] = {
> -       N_("git multi-pack-index [--object-dir=<dir>] write"),
> +       N_("git multi-pack-index [--object-dir=<dir>] [write|verify]"),

Nit: The square brackets make the verb optional. You probably want
parenthesis to indicate that one or the other is required:

    git multi-pack-index [--object-dir=<dir>] (write|verify)
