Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177BEC43460
	for <git@archiver.kernel.org>; Thu, 20 May 2021 02:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDEC46109F
	for <git@archiver.kernel.org>; Thu, 20 May 2021 02:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhETCLU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 22:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETCLU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 22:11:20 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE75C061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 19:09:58 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z13so22054411lft.1
        for <git@vger.kernel.org>; Wed, 19 May 2021 19:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4zBmxEvyQIWDBAt1VWOLzlJGb0x7paDMbgDGwb+uA80=;
        b=ChMaMrs/1YlfYUNv/OURPt2a/BIjnNwRFjvm+RVMNJxrCS1O7CtQLhvDULxcty982I
         onTk7M/C2Qw38RYjkisrfhSimVDzLa1lelY4MKjeU/6l9Q2kqSTmoZVrROgj+dwyUO6Q
         /U8HFn9SqPHRIQifNe33eJGAkwd+5bOk79Rl79t8ekjP6lkQVLRMgkfd92aBR39EaeY7
         bnUGYK2k83twClFfVQGqs6E5d6Jpt5CwlwHA/UB4UE5qpfVyfnEyq3vQ+mYfJCAkFA4z
         xQb94t4ceBKjyMNpIM/j6swCMhqrMTJQyld0V3jA4Z5mI92V/qe8+lrUlI3GXR1adNdB
         bv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4zBmxEvyQIWDBAt1VWOLzlJGb0x7paDMbgDGwb+uA80=;
        b=d27XKuB7BkvvtWg42SbuMD4QO3PesMqFW4VFcHqdVYoELKdBLx2PkPYlmdncNAcT1q
         ZityWbHG3lqspG0EJFu0yGHJNop0CdruPOUVKNtAofby3HScKYxrDN1UN+97n9Ihxm2Y
         gijtQGSuWiwx3qBbFjpYiGOXSo26dem5mPUwW7jBPhNclOvvE3AQMVAGosl3TmmRFfXo
         xCG1YWru+JBkufczeksmrAVwj6lZ11HrOYqlzlVeFXM4ru02Ptcj9LGkHa9AXvffnh2J
         MvLeec+/k317rKEjF0B85mTTIL4gpmVk0xyrbIFtu3EEcfQoGPkZzTv7xfqBTHnw9Cth
         cBlA==
X-Gm-Message-State: AOAM532fGaSMys2Z02VF0aKbmzjBS0Iq9qg3jQJmZgj8cFwEB7qeDvPc
        KguYtRM1RTMiTlHF82H3JusQEBFDUeuXIaMC8P0=
X-Google-Smtp-Source: ABdhPJyEsZwmvOdFBp8K8khmdGjonYoT+mPocqDdHsQaHCUIcXTaujQg0FVJJWQBnhraxehHNlGyA1CGouQFmfdQ9Ts=
X-Received: by 2002:a19:c511:: with SMTP id w17mr1728893lfe.113.1621476597147;
 Wed, 19 May 2021 19:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621451532.git.ps@pks.im> <f248b41d6e2df2d34a4304e2655df8cb094483e9.1621451532.git.ps@pks.im>
In-Reply-To: <f248b41d6e2df2d34a4304e2655df8cb094483e9.1621451532.git.ps@pks.im>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Wed, 19 May 2021 19:09:46 -0700
Message-ID: <CAPx1GveeUi1s6LKTkUYS7CqkyZ9mm=6AQg4Ta8VHi1mnT19gEg@mail.gmail.com>
Subject: Re: [PATCH 2/8] p5400: add perf tests for git-receive-pack(1)
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 19, 2021 at 1:22 PM Patrick Steinhardt <ps@pks.im> wrote:
> We'll the connectivity check logic for git-receive-pack(1) in the

s/the conn/do the conn/

> diff --git a/t/perf/p5400-receive-pack.sh b/t/perf/p5400-receive-pack.sh
> new file mode 100755
> index 0000000000..2b0c89d977
> --- /dev/null
> +++ b/t/perf/p5400-receive-pack.sh
> @@ -0,0 +1,74 @@
> +#!/bin/sh

This code is, unfortunately, full of bash-isms:

> +       refs=("create updated:new")

Plain sh doesn't have arrays...

> +       done < <(printf "%s\n" "${refs[@]}")

This is another bash-ism.

> +done < <(printf "%s\n" "clone $TARGET_REPO_CLONE" "extrarefs $TARGET_REPO_REFS" "empty $TARGET_REPO_EMPTY")

I think these are mostly easily corrected but the `refs` probably should
just be dumped into a file, one line at a time, to be re-read from a file,
since `printf ... | while read ...` runs the whole loop inside a subshell.

Chris
