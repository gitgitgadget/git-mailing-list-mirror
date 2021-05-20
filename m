Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A445C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537CF61163
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhETPkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 11:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhETPkV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 11:40:21 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C93C061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:39:00 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r11so19880704edt.13
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=GbwFSr19DXtgZWfmOs5rCRo3aExdBBtrB7Tc9sj4gNQ=;
        b=QMkeAxVPYWDLYzc0scmPAUdKnRrhIIaRLc0G5g4YHFngYvr3NTwEd5ilOfBkvixfb4
         zslXsGOIda/AlrUsiUWiJ7SZtyiKgUCHMJmkobcRP96SNKw70ZdYQuCesDktJXm5AXcT
         14+ggjdSrkwzCJW4K+OsElzFruARuc8LQiwy11x0K618ZE0FDxYy66sj7D/jJSaUl7QV
         9BP6LVf5rezXpBTYXY1XIjGsjEHCWU0tIPFCH3Waf3kSY9J8sQPFWKwEBKoSjCk4dIlr
         RkQiNN+OqmJSyhRz7VBFzp3L/DQ1OstaZtUG/Z3jw/lai1tX0y4XsTIC9Q2KsiB95kQc
         tfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=GbwFSr19DXtgZWfmOs5rCRo3aExdBBtrB7Tc9sj4gNQ=;
        b=XLx2Em/TyJwSDo1HrqylvEDXKCl5VHeMhTUFXIPxOKlM2IZU2xK4glytQtNHVuYe5T
         3NkHGBCovmKP3vYAyPXzjph4C/bzfpc4i5uudox2j7WGLU/VvOvEOXdsLomuXR0eebbV
         Kr7Ofkx1c0dI1cxCyGcPDkkKHHEChS8sYMZoO5IGm6h1+MTp1FmP19f29EMRfGxCJ8ZW
         zZcma+csgS5tMsk4xlCVq4hXk7DZDDsfaz4Wa2ifyPEegeylShKUW90ft50E07P6I64I
         MnzogtXj7sgA9eHTu3dlfrNYxryvQ7GmDZiydCtSJnEbA/3aRyL2eSKh/f1x3/aUv2h1
         g2Mw==
X-Gm-Message-State: AOAM533Jjd1md4bDdRbuNIbHcp8l26occn4IBBURF0ypIVYwuKshGov9
        ZvcD09fLb3urP3KST2fNPrlXJ0CBChzFDw==
X-Google-Smtp-Source: ABdhPJxouTYPzk+zuCNhsjXiUc7l630wzD1ufR1sNRrLVgBijdYenqhKt6ryO7jFABN0ZlISYA+HHQ==
X-Received: by 2002:aa7:c718:: with SMTP id i24mr5592416edq.43.1621525138401;
        Thu, 20 May 2021 08:38:58 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c3sm1857585edn.16.2021.05.20.08.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 08:38:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 16/21] t2017: mark --orphan/logAllRefUpdates=false
 test as REFFILES
Date:   Thu, 20 May 2021 17:38:02 +0200
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
 <b64e3e7ade1583f5ff669cfb6510f5d7402be028.1619519903.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <b64e3e7ade1583f5ff669cfb6510f5d7402be028.1619519903.git.gitgitgadget@gmail.com>
Message-ID: <87mtsppg8e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 27 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> In reftable, there is no notion of a per-ref 'existence' of a reflog. Each
> reflog entry has its own key, so it is not possible to distinguish between
> {reflog doesn't exist,reflog exists but is empty}. This makes the logic
> in log_ref_setup() (file refs/files-backend.c), which depends on the existence
> of the reflog file infeasible.

Okey...

> -test_expect_success '--orphan does not make reflog when core.logAllRefUpdates = false' '
> +test_expect_success REFFILES '--orphan does not make reflog when core.logAllRefUpdates = false' '
>  	git checkout main &&
>  	git config core.logAllRefUpdates false &&
>  	git checkout --orphan epsilon &&

But let's not simply skip the test, but positively test for the reftable
behavior here, or maybe that's planned for a later series.
