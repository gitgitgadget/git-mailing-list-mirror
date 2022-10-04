Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0FAC433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 17:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJDRl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 13:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiJDRlw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 13:41:52 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B44266F
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 10:41:48 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id b145so2326636yba.0
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 10:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=FJQXNH8SlaB9SQoUiTVijb+QRrY9DWVRnJQWZKwJ+q0=;
        b=F9Cpklt8d46pSWLjMRSubcc7QC2wHNDLHwZMA1eFB7ijWzetg/6JcGEaqAEW9P+3MG
         RR5SvV2y/pJiARaAnjj91JlshBEjdhTZUDSxU9se9M7XcJSh754tQYVzpQ8rJySEscW5
         7IYvlkMhqZG947lF+nNZBDuIhRKJvFRS105U+qFbsSOn+C8xEjw7b5SLRAiMdEWwmFZD
         CDxxTsTlxk81lYNBKfQEwtxHS7vJEayuRJh75R5NVDG0HNUOJXytEqV0CcbspMPdkOfD
         ZxdU5WZVmNCyiBrtdf19D4MczCwr5BhdNB0BWajsqnLdazwPBqytiFSqMzrhcxAwWbbT
         dHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FJQXNH8SlaB9SQoUiTVijb+QRrY9DWVRnJQWZKwJ+q0=;
        b=PDORTl0GesPNmHs7YNUxiwfTF+HLDnRxSsbupyf5bEJZroc7C9AmDFM7rF8tKb6Vfr
         Wy4MrCJNsx3nT9EhYrjAxgiOSNfAJknfQD26KPemKj6wiDb78a3AWlwqs40zCObsZA2D
         gZ5Bs7Bu8jVVLkruat5ZV9z0wl7l3BdUJO36uJIGAtgYRWSSEUD/qa76u+njNAe7w3ak
         iOlpiPqmtfFOjBBwzg5I0AcKsxh5wsb3x2HQ5Agnd3RAkgXHsDQK6xYkj7zCHkpnZ17u
         oq2HfDoTBw5K0mLeIQrAuv846poX8tFx+kIqqLh12CIAPfYbAa2aUOHYfVacqssX3czK
         Sf2g==
X-Gm-Message-State: ACrzQf2a28zE1xRmzjzhGfPUOIeMrLNZYNHzAreqKQpkf1LI0ib3fYV3
        amrJ8GRJ5Gmvo8H/bkCosaopei8xB7iS2GwV/Sc0RgXikWrL5Q==
X-Google-Smtp-Source: AMsMyM75wCmrTyQOPx/bUGyJssjUxaEAoy/nxfH+w0Ux9h8zNeMYCvrkJbzbKg8yGxyTWJKFg1Hxfz4PynP5IXwsYYM=
X-Received: by 2002:a25:1605:0:b0:6bd:284c:62b with SMTP id
 5-20020a251605000000b006bd284c062bmr18333183ybw.391.1664905307076; Tue, 04
 Oct 2022 10:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com> <patch-07.15-a9810aaa852-20220930T111343Z-avarab@gmail.com>
In-Reply-To: <patch-07.15-a9810aaa852-20220930T111343Z-avarab@gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 4 Oct 2022 10:41:35 -0700
Message-ID: <CAFySSZCk3t6OE=zP=86aUNPTuEnvs0LfroH+UcTek7fG_jJ9xQ@mail.gmail.com>
Subject: Re: [PATCH 07/15] run-command API: make "jobs" parameter an "unsigned int"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The rename the "n" variable added in c553c72eed6 (run-command: add an
> asynchronous parallel child processor, 2015-12-15) to "jobs", and
> change the type to an "unsigned int". As we'll see in a subsequent
> commit we do pass "0" here, but never "jobs < 0".

> -       pp->max_processes = n;
> +       pp->max_processes = jobs;
>
> -       trace_printf("run_processes_parallel: preparing to run up to %d tasks", n);
> +       trace_printf("run_processes_parallel: preparing to run up to %d tasks",
> +                    jobs);

Should we normalize what we call processes/jobs/tasks? They all
seem to mean the same thing. I'm leaning towards processes
since the function name itself is run_processes_parallel.

> - * Runs up to n processes at the same time. Whenever a process can be
> + * Runs up to 'jobs' processes at the same time. Whenever a process can be

Also should "jobs" be changed to "max_jobs" or whatever normalized name
we call it? The comment here can then be changed to:
"Runs up to 'max_processes' at the same time."
