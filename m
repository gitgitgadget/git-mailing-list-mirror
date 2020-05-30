Return-Path: <SRS0=ERGy=7M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4628C433E0
	for <git@archiver.kernel.org>; Sat, 30 May 2020 14:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A18A920715
	for <git@archiver.kernel.org>; Sat, 30 May 2020 14:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBAUbZ6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgE3O3a (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 May 2020 10:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgE3O33 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 May 2020 10:29:29 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD71C03E969
        for <git@vger.kernel.org>; Sat, 30 May 2020 07:29:28 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g25so4232584otp.13
        for <git@vger.kernel.org>; Sat, 30 May 2020 07:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xlaK8sDyP4Qbi+DcoQeSa0G72Mamy9OIJGuAcI2bDpA=;
        b=lBAUbZ6cN77LoUI8PE6PSOx1UHlFxdCADGKjzDL37hEftWDBI7tOHlAMpXV2M/LW8/
         neG0wk00fgf2miRWvSTK3by/a4Hfse/IdkbLL/bm5N/tHH87OY5y5nU0Toy1II1ske/v
         IvqqfKRd3xeyP9u7o4928JJQEZEHPzjL2WyJnQm0unaXQ6d5maN8ZkqHBt7AktUt7E+m
         8vQf1/zl90JAtlek/IiCLxWc/PdTjFxerDkEtz7z6uw3pwk8+/50G9a769Q1gi4fPQKI
         vur3fLv4snM9X/1IoQ6D93kVhfvAn56drzOKs7vdymw7FLWzC2IqDY18Zfkasybbs5e2
         Fecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xlaK8sDyP4Qbi+DcoQeSa0G72Mamy9OIJGuAcI2bDpA=;
        b=EEB6BpzJCzApyGFtrG5o4zTNgLulE4MJxr75cHDSMlwH/kD8Uj0CFJ0g6ze6U6vaAY
         ZiPyu+3R93EnFNZqKevz+NQk8zFGwRhWzk305ib7/bT68TIwGuiAWDTDLuzD8JQcfu7G
         oBoacicnR8l1kzaxS3rt7mkyj9oZzmaxgUQgr63VaAkJIexLYlY4whPeUJI0hmruoJ7r
         Joe7Go868mgH/lW3jVQrLuKowPhf6B2Yo5tla4UoWZWQrb7cAOWVja1xTuThqMbNT8iX
         MpWAYdPhyCee8/9uVhKfHwy02SnOTQiQ50sxq1bXWte1CW3ATY/5GXYkd/AvzWgrcnxM
         nBpA==
X-Gm-Message-State: AOAM530RZQY0t9Q2hwKJLKZmIVGbNnw/9XXO/TivYsFkZipzgSNESZGt
        gU6xAv21Atsj5H1/mt1JHLmPiY2xry/aqMj27Ug=
X-Google-Smtp-Source: ABdhPJxOYIm/unznR/UyHM+BRfqM9x8DhPl6xpPWMVZL/m/I67YKcbqQU1BnPNTfmwJnEz3NCOeznwJWSVzmzStaTmg=
X-Received: by 2002:a05:6830:4c3:: with SMTP id s3mr10430605otd.162.1590848967332;
 Sat, 30 May 2020 07:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590627264.git.matheus.bernardino@usp.br> <43402007adb0916846f92c3e4ff86d4131056ce0.1590627264.git.matheus.bernardino@usp.br>
In-Reply-To: <43402007adb0916846f92c3e4ff86d4131056ce0.1590627264.git.matheus.bernardino@usp.br>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 30 May 2020 07:29:16 -0700
Message-ID: <CABPp-BHTmYy=AtXoCLG-xXQ_0EZ7=3xiMibkNMDLzsKCnHBoFw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] t/helper/test-config: return exit codes consistently
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 27, 2020 at 6:13 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> The test-config helper may exit with a variety of at least four
> different codes, to reflect the status of the requested operations.
> These codes are sometimes checked in the tests, but not all of the codes
> are returned consistently by the helper: 1 will usually refer to a
> "value not found", but usage errors can also return 1 or 128. The latter

I'm not sure what "The latter" refers to here.

> is also expected on errors within the configset functions. These
> inconsistent uses of the exit codes can lead to false positives in the
> tests. Although all tests that currently check the helper's exit code,
> on errors, do also check the output, it's still better to standardize
> the exit codes and avoid future problems in new tests. While we are

That last sentence was slightly hard for me to parse.  Maybe something like:

...Although all tests which expect errors and check the helper's exit
code currently also check the output, it's still better...


> here, let's also check that we have the expected argc for
> configset_get_value and configset_get_value_multi, before trying to use
> argv.
>
> Note: this change is implemented with the unification of the exit
> labels. This might seem unnecessary, for now, but it will benefit the
> next patch, which will increase the cleanup section.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  t/helper/test-config.c | 76 ++++++++++++++++++++++--------------------
>  1 file changed, 40 insertions(+), 36 deletions(-)
>
> diff --git a/t/helper/test-config.c b/t/helper/test-config.c
> index 234c722b48..1c8e965840 100644
> --- a/t/helper/test-config.c
> +++ b/t/helper/test-config.c
> @@ -30,6 +30,14 @@
>   * iterate -> iterate over all values using git_config(), and print some
>   *            data for each
>   *
> + * Exit codes:
> + *     0:   success
> + *     1:   value not found for the given config key
> + *     2:   config file path given as argument is inaccessible or doesn't exist
> + *     129: test-config usage error
> + *
> + * Note: tests may also expect 128 for die() calls in the config machinery.
> + *
>   * Examples:
>   *
>   * To print the value with highest priority for key "foo.bAr Baz.rock":
> @@ -64,35 +72,42 @@ static int early_config_cb(const char *var, const char *value, void *vdata)
>         return 0;
>  }
>
> +enum test_config_exit_code {
> +       TC_SUCCESS = 0,
> +       TC_VALUE_NOT_FOUND = 1,
> +       TC_CONFIG_FILE_ERROR = 2,
> +       TC_USAGE_ERROR = 129,
> +};
> +
>  int cmd__config(int argc, const char **argv)
>  {
>         int i, val;
>         const char *v;
>         const struct string_list *strptr;
>         struct config_set cs;
> +       enum test_config_exit_code ret = TC_SUCCESS;
>
>         if (argc == 3 && !strcmp(argv[1], "read_early_config")) {
>                 read_early_config(early_config_cb, (void *)argv[2]);
> -               return 0;
> +               return TC_SUCCESS;
>         }
>
>         setup_git_directory();
>
>         git_configset_init(&cs);
>
> -       if (argc < 2) {
> -               fprintf(stderr, "Please, provide a command name on the command-line\n");
> -               goto exit1;
> -       } else if (argc == 3 && !strcmp(argv[1], "get_value")) {
> +       if (argc < 2)
> +               goto print_usage_error;
> +
> +       if (argc == 3 && !strcmp(argv[1], "get_value")) {
>                 if (!git_config_get_value(argv[2], &v)) {
>                         if (!v)
>                                 printf("(NULL)\n");
>                         else
>                                 printf("%s\n", v);
> -                       goto exit0;
>                 } else {
>                         printf("Value not found for \"%s\"\n", argv[2]);
> -                       goto exit1;
> +                       ret = TC_VALUE_NOT_FOUND;
>                 }
>         } else if (argc == 3 && !strcmp(argv[1], "get_value_multi")) {
>                 strptr = git_config_get_value_multi(argv[2]);
> @@ -104,41 +119,38 @@ int cmd__config(int argc, const char **argv)
>                                 else
>                                         printf("%s\n", v);
>                         }
> -                       goto exit0;
>                 } else {
>                         printf("Value not found for \"%s\"\n", argv[2]);
> -                       goto exit1;
> +                       ret = TC_VALUE_NOT_FOUND;
>                 }
>         } else if (argc == 3 && !strcmp(argv[1], "get_int")) {
>                 if (!git_config_get_int(argv[2], &val)) {
>                         printf("%d\n", val);
> -                       goto exit0;
>                 } else {
>                         printf("Value not found for \"%s\"\n", argv[2]);
> -                       goto exit1;
> +                       ret = TC_VALUE_NOT_FOUND;
>                 }
>         } else if (argc == 3 && !strcmp(argv[1], "get_bool")) {
>                 if (!git_config_get_bool(argv[2], &val)) {
>                         printf("%d\n", val);
> -                       goto exit0;
>                 } else {
>                         printf("Value not found for \"%s\"\n", argv[2]);
> -                       goto exit1;
> +                       ret = TC_VALUE_NOT_FOUND;
>                 }
>         } else if (argc == 3 && !strcmp(argv[1], "get_string")) {
>                 if (!git_config_get_string_const(argv[2], &v)) {
>                         printf("%s\n", v);
> -                       goto exit0;
>                 } else {
>                         printf("Value not found for \"%s\"\n", argv[2]);
> -                       goto exit1;
> +                       ret = TC_VALUE_NOT_FOUND;
>                 }
> -       } else if (!strcmp(argv[1], "configset_get_value")) {
> +       } else if (argc >= 3 && !strcmp(argv[1], "configset_get_value")) {
>                 for (i = 3; i < argc; i++) {
>                         int err;
>                         if ((err = git_configset_add_file(&cs, argv[i]))) {
>                                 fprintf(stderr, "Error (%d) reading configuration file %s.\n", err, argv[i]);
> -                               goto exit2;
> +                               ret = TC_CONFIG_FILE_ERROR;
> +                               goto out;
>                         }
>                 }
>                 if (!git_configset_get_value(&cs, argv[2], &v)) {
> @@ -146,17 +158,17 @@ int cmd__config(int argc, const char **argv)
>                                 printf("(NULL)\n");
>                         else
>                                 printf("%s\n", v);
> -                       goto exit0;
>                 } else {
>                         printf("Value not found for \"%s\"\n", argv[2]);
> -                       goto exit1;
> +                       ret = TC_VALUE_NOT_FOUND;
>                 }
> -       } else if (!strcmp(argv[1], "configset_get_value_multi")) {
> +       } else if (argc >= 3 && !strcmp(argv[1], "configset_get_value_multi")) {
>                 for (i = 3; i < argc; i++) {
>                         int err;
>                         if ((err = git_configset_add_file(&cs, argv[i]))) {
>                                 fprintf(stderr, "Error (%d) reading configuration file %s.\n", err, argv[i]);
> -                               goto exit2;
> +                               ret = TC_CONFIG_FILE_ERROR;
> +                               goto out;
>                         }
>                 }
>                 strptr = git_configset_get_value_multi(&cs, argv[2]);
> @@ -168,27 +180,19 @@ int cmd__config(int argc, const char **argv)
>                                 else
>                                         printf("%s\n", v);
>                         }
> -                       goto exit0;
>                 } else {
>                         printf("Value not found for \"%s\"\n", argv[2]);
> -                       goto exit1;
> +                       ret = TC_VALUE_NOT_FOUND;
>                 }
>         } else if (!strcmp(argv[1], "iterate")) {
>                 git_config(iterate_cb, NULL);
> -               goto exit0;
> +       } else {
> +print_usage_error:
> +               fprintf(stderr, "Invalid syntax. Usage: test-tool config <cmd> [args]\n");
> +               ret = TC_USAGE_ERROR;
>         }
>
> -       die("%s: Please check the syntax and the function name", argv[0]);
> -
> -exit0:
> -       git_configset_clear(&cs);
> -       return 0;
> -
> -exit1:
> -       git_configset_clear(&cs);
> -       return 1;
> -
> -exit2:
> +out:
>         git_configset_clear(&cs);
> -       return 2;
> +       return ret;
>  }
> --
> 2.26.2

So, the primary purpose of the commit is getting making the return
status clearer, but most the code changes actually center around
reducing the gotos and unification of the exit labels.  Might have
been slightly easier to read if those two issues had been split, but
the patch is small enough that it's not a big deal.  Makes sense.
