Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FA7C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 15:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjECPKY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 11:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjECPKW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 11:10:22 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D615592
        for <git@vger.kernel.org>; Wed,  3 May 2023 08:10:21 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bc4ba28cbso7043796a12.0
        for <git@vger.kernel.org>; Wed, 03 May 2023 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683126619; x=1685718619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/6mHcPeCWqxadCFojaVBTgRePCt4EdatGWgc8/M1EI=;
        b=so6NYphuu4NXinHgVZ3iD+Q+4T5/DMp+m7mTiod48Fgy50BesRZTJ5P8/vLcVFIZB6
         2gRm38t18AIwF73mpMapKkAQrTYqQinUUKK1BTa3cr7c135lO0FhuKp6ALzuEkMR8V2r
         WnF4ahHWmgBgFzHzhCxNPehQrwN/vJ9pHFE+Tn8W0g3AennRwiBQUbKgH4L/F/jGFE/Q
         GuT2pTOVU6I+1aFkrrLGE+TVYyC62PyT35E3Q6b9MpE9n5HzziAdlgpDVzrQDnc7MzG0
         iB6ZfnWo5A1+k7olnH9+UA7Fc0yk30J1y/OF6SuyKIRCuJCc2c/UOc+za1aNWJ/JijAd
         8ASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683126619; x=1685718619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/6mHcPeCWqxadCFojaVBTgRePCt4EdatGWgc8/M1EI=;
        b=ijoQwyf6dWJW3ayFMGMLyKWC8OMgUCvrEBppaWXT1hwnOGtYNfDBQ3s92S9RZGVHCH
         gmONTUlDBByS/aU8ED4fLfdouUnX8CxWGA7jJNQQb0zlGIOKUptSYOvXBaea3Q6HSAue
         8axI7w4fqg0w/h3Y40slquRuOudZGbYt8NQN7l6lwBvKVKvuRWeN/m9s2Nl9LCo/qeg+
         nXsq4fBLxY0yNmHqjxGpbp0ICS5fZLcbwLWysWoM2sOL4fEjLP8i7ktrqdUv7uYENtJ+
         IQaEgfQVrvzNEZMDOxEorFaqd+K/MDD/14HFPWyWev29s3VxuQ3uSqJGGlXCPFILuUae
         2hhA==
X-Gm-Message-State: AC+VfDybzilFU0H85aJPV5XQfLfDIMZXPJi6YgF8pYWbVENqcAuuCVAe
        axxW1A/rKd1p6IgE757H9AcHnytJgXKXHZAsg50YAhiBgOA=
X-Google-Smtp-Source: ACHHUZ45wnt7PqeDp5iU3zp1H8DallAeM2UxnRYAIFcoGALX6Rp7IH5iyudbH0q9gy6GFmJYCYS9cLZ3Iru2mEdWgLM=
X-Received: by 2002:a17:906:4fc7:b0:862:c1d5:ea1b with SMTP id
 i7-20020a1709064fc700b00862c1d5ea1bmr3674018ejw.8.1683126619351; Wed, 03 May
 2023 08:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1470.v3.git.git.1682707848916.gitgitgadget@gmail.com> <pull.1470.v4.git.git.1682822352360.gitgitgadget@gmail.com>
In-Reply-To: <pull.1470.v4.git.git.1682822352360.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 3 May 2023 17:10:07 +0200
Message-ID: <CAP8UFD00omU=HiGQyaNx=ZbuH79rCv-eHkCuQ1sf5xv9zu4ffg@mail.gmail.com>
Subject: Re: [PATCH v4] attr: teach "--attr-source=<tree>" global option to "git"
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 30, 2023 at 4:39=E2=80=AFAM John Cai via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 74973d3cc40..b8f4f604707 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -212,6 +212,11 @@ If you just want to run git as if it was started in =
`<path>` then use
>         nohelpers (exclude helper commands), alias and config
>         (retrieve command list from config variable completion.commands)
>
> +--attr-source=3D<tree-ish>::
> +       Read gitattributes from <tree-ish> instead of the worktree. See
> +       linkgit:gitattributes[5]. This is equivalent to setting the
> +       `GIT_ATTR_SOURCE` environment variable.

As you talk about GIT_ATTR_SOURCE, I wonder if this variable should
also be documented in the "Environment Variables" section of this
Documentation/git.txt doc.

> diff --git a/environment.h b/environment.h
> index a63f0c6a24f..758927a689c 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -55,6 +55,7 @@ const char *getenv_safe(struct strvec *argv, const char=
 *name);
>  #define GIT_QUARANTINE_ENVIRONMENT "GIT_QUARANTINE_PATH"
>  #define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
>  #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
> +#define GIT_ATTR_SOURCE "GIT_ATTR_SOURCE"

To be similar with the definitions that are just above, I think it
actually should be:

#define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"

> @@ -314,6 +315,21 @@ static int handle_options(const char ***argv, int *a=
rgc, int *envchanged)
>                         } else {
>                                 exit(list_cmds(cmd));
>                         }
> +               } else if (!strcmp(cmd, "--attr-source")) {
> +                       if (*argc < 2) {
> +                               fprintf(stderr, _("no prefix given for --=
attr-source\n" ));

The example I sent was about '--super-prefix' so it made sense to say
"no prefix given", but here it makes more sense to say something like
"no attribute source given for --attr-source".

> +                               usage(git_usage_string);
> +                       }
> +                       setenv(GIT_ATTR_SOURCE, (*argv)[1], 1);
> +                       if (envchanged)
> +                               *envchanged =3D 1;
> +                       (*argv)++;
> +                       (*argc)--;
> +               } else if (skip_prefix(cmd, "--attr-source=3D", &cmd)) {
> +                       set_git_attr_source(cmd);
> +                       setenv(GIT_ATTR_SOURCE, (*argv)[1], 1);
> +                       if (envchanged)
> +                               *envchanged =3D 1;
>                 } else {
>                         fprintf(stderr, _("unknown option: %s\n"), cmd);
>                         usage(git_usage_string);
