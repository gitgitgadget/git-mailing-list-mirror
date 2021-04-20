Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BE4C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 11:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD6DB613AE
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 11:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhDTLZA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 07:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhDTLY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 07:24:58 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEAEC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 04:24:26 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z5so8101660edr.11
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 04:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=B/1TT4JFaUl9UXzeGKSuJ4dZmVNJzjREG3qOXcdkJuc=;
        b=a7s56qsvSCSUbUvl/AnZHcQlHSKrCXWHP7KZGj0PQ5derHUzpDOYnsU2QLKswBcOwT
         9PrsFzNMEilWn32ScJFbYIzSmsViSzfQqn59okk/MG4UBC+lpGf6mD8lUn8DOrw4xPz8
         1oeEiNex4NNsYwbUEPBS8h+GBk4LAxqFkxA4F6JNIMrD68hyYdUhSeWuF0VsM9CO4e9e
         9GrekXffU9aMoE3jtj+F40m6kNXO0bcjPkRlm02QrCIfB1a+fSOPplU+r8MAMQcZLwlE
         0YL5IQI8RLvmrpd4W0FJjODG97936hll6XDqYXI1MjuMYMQINkAUZOM/EF1cqotnCany
         De2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=B/1TT4JFaUl9UXzeGKSuJ4dZmVNJzjREG3qOXcdkJuc=;
        b=H3VyAQx5kowqFJtPsNPNDMvP4wQSbv5Vd8FDCgESwDxy03E1QMVHHui2DvX9FmdzB7
         /D0K3zlNnDr5a2Qh5tySGAPum1LbJ8aHoEjXdRIksebL8TSIuwd+88ZNm6F/V0ZOgmsw
         F7kldBWvICFbijZ7TrFRY7a4fW8T2CPO8eF4q7ZznnFG8w8FZcs871lr/04gP2By5xgx
         uRBhd5jH/OgVUBDL/CK4PGNbH6WxjwTtVdPu8Mh6FQmKcbWso+i42fK/QMLFIQr+z+7Z
         OUEyReC6pcsAwYsOVwqnpBHX/fIgvI82P7YxathitYCE/daQK2lCjHriETBM9MA23sFN
         kh8A==
X-Gm-Message-State: AOAM531f7g32h7ze2GkF8CqcylcjdsM6hpdzBx2zzWIEqnDpDeHa4qm/
        fYT/cVPmMGEQonAUm4ic2DU=
X-Google-Smtp-Source: ABdhPJwWG+pDnJvrvCfDYofBL7fwcwd0R71kl9Av75NAAR3/d4Faucid+73yhg74cWnXE3dHMmNsMg==
X-Received: by 2002:a05:6402:453:: with SMTP id p19mr24491979edw.88.1618917865519;
        Tue, 20 Apr 2021 04:24:25 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w13sm15170792edx.80.2021.04.20.04.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 04:24:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git: support separate arg for `--config-env`'s value
References: <cover.1618847606.git.ps@pks.im>
 <d52db89bc2f40a9df5e9fafe4e1bb8c173a7f45f.1618847606.git.ps@pks.im>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <d52db89bc2f40a9df5e9fafe4e1bb8c173a7f45f.1618847606.git.ps@pks.im>
Date:   Tue, 20 Apr 2021 13:24:24 +0200
Message-ID: <87sg3l2o7r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 19 2021, Patrick Steinhardt wrote:

> +test_expect_success 'git --config-env with missing value' '
> +	test_must_fail env ENVVAR=value git --config-env 2>error &&
> +	test_i18ngrep "no config key given for --config-env" error &&
> +	test_must_fail env ENVVAR=value git --config-env config core.name 2>error &&
> +	test_i18ngrep "invalid config format: config" error
> +'
> +

Nit: (not spotted on the first reading): s/test_i18ngrep/grep/.

>  test_expect_success 'git --config-env fails with invalid parameters' '
>  	test_must_fail git --config-env=foo.flag config --bool foo.flag 2>error &&
>  	test_i18ngrep "invalid config format: foo.flag" error &&

