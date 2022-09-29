Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5A6C04A95
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 04:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbiI2El6 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 29 Sep 2022 00:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiI2El5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 00:41:57 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1069E128A0E
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 21:41:56 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id u64so197879ybb.1
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 21:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=B73mbqGxWO5dG0D8TuYTmvYCwi90tToOX16KM8CLbn0=;
        b=6NpjAALUk8XiYkJZASTaSrXicXPgd018PO+EfV/uYptDjfOKkG5zzckOojTfE5LWmE
         enw0IrhWd+a+6+XscyrmLuQgjauI+xhm5VBRHmsS2DCd4PDZLyxcAXP//j7YRxD6dh6y
         4UvHTWCiAb9i/Btj8UmctyQOXwidjsAdzvM1NoEePHKQ6vopFayzAoEKZTC920MgzLo7
         ggXcWmuAbcQmkaGhCpQw11bm9uaZyAz6r7C3QnP30/MFFC7bc16YSOemA62jRkbqCrbc
         5vEnH5diX2lLpuuqpEvE9ez+k8wI6uLL7aoXa/XMctcFm48JHhT7mIPv6djow9s+YedR
         7/Uw==
X-Gm-Message-State: ACrzQf20Q9IfhUykn87Smat+vpZ4OiZZnuyEA/mX0WEg64+cmgIrNWMK
        4d8hLMkY7OQRLJFiP8xnUZvCeZ9TJD3lvnSX46I=
X-Google-Smtp-Source: AMsMyM64f2CWE45B0ZMvJ0Q8kmVLzss+gdlJSQtHX9kz9jqS2cZGIaaoVhZspuf1jbu9U8AdITU3twszprxTrEn6gLo=
X-Received: by 2002:a25:1ed6:0:b0:6bc:1c2e:a57c with SMTP id
 e205-20020a251ed6000000b006bc1c2ea57cmr1354990ybe.633.1664426515248; Wed, 28
 Sep 2022 21:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
 <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <patch-v2-26.35-ac62cda1ab2-20220928T082458Z-avarab@gmail.com>
In-Reply-To: <patch-v2-26.35-ac62cda1ab2-20220928T082458Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 29 Sep 2022 00:41:44 -0400
Message-ID: <CAPig+cRm5U45dhQuW1xAmhPZ=rn4b=QoRv1t0u3RtFaC374Y9w@mail.gmail.com>
Subject: Re: [PATCH v2 26/35] doc txt & -h consistency: make "stash" consistent
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 28, 2022 at 4:44 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Amend both the the -h output and *.txt to match one another. In this

s/the the/the/

> case the *.txt didn't list the "save" subcommand, and the "-h" was
> similarly missing some commands.
>
> Let's also convert the *.c code to use a macro definition, similar to
> that used in preceding commits. This avoids duplication.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/builtin/stash.c b/builtin/stash.c
> @@ -21,72 +21,95 @@
>  static const char * const git_stash_usage[] = {
> +       BUILTIN_STASH_LIST_USAGE,
> +       BUILTIN_STASH_SHOW_USAGE,
> +       BUILTIN_STASH_DROP_USAGE,
> +       BUILTIN_STASH_POP_USAGE,
> +       BUILTIN_STASH_APPLY_USAGE,
> +       BUILTIN_STASH_BRANCH_USAGE,
> +       BUILTIN_STASH_PUSH_USAGE,
> +       BUILTIN_STASH_SAVE_USAGE,
> +       BUILTIN_STASH_CLEAR_USAGE,
> +       BUILTIN_STASH_CREATE_USAGE,
> +       BUILTIN_STASH_STORE_USAGE,
>         NULL
>  };
>
>  static const char * const git_stash_branch_usage[] = {
> -       N_("git stash branch <branchname> [<stash>]"),
> +       BUILTIN_STASH_BRANCH_USAGE,
>         NULL
>  };
>
>  static const char * const git_stash_clear_usage[] = {
> -       "git stash clear",
> +       BUILTIN_STASH_BRANCH_USAGE,
>         NULL
>  };

Copy/paste error: s/BRANCH/CLEAR/
