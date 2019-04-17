Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D65E920248
	for <e@80x24.org>; Wed, 17 Apr 2019 16:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbfDQQF1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 12:05:27 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:56307 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732105AbfDQQF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 12:05:27 -0400
Received: by mail-it1-f196.google.com with SMTP id y134so5466287itc.5
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 09:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T8dpXSf4favAMxKO+FxQaQ1lE7EZsKwVRuqtMxUPWLw=;
        b=tc7MQC2WhVdwnJarC/U+4XxMNPkJJP+GD4/VYMtFNwc25gbU0qpPj9jALMVo7Cgpzz
         UCpaLqDEeouNPBkK31oOOOvvOt1QTm6ZCAlkphDWaRpFH6Wo1bPiRBxTPU4MPPtdmg8n
         4ACh1GeGZdkSbQ9o5TUz+xQB00BmtLs2u8jPpjt5Z7COFaRkgf09sb7M0H4zj5aIof+2
         OXCNcGkOj/IO0MEw73O+v5guUA03Lw6wChNJxDni55yhPu7w1dyqQSmydvBB7vWXwT04
         GAX6GYCfezL+1Tvc5q5HStilfly7YkI3QQ8bhc4hbhAmeysDlQHvinBa1StlFDEcn+jU
         3tUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T8dpXSf4favAMxKO+FxQaQ1lE7EZsKwVRuqtMxUPWLw=;
        b=OfOX7n6VIsCt4akj1KYknIGC0cRSp0UL4WS50K530Gjom8uSy1KvpkgxZ8YeV5NHV1
         f9CWVG/fFIoCL6enhFZrNMzl8m7Au3Ad+E8MWxjlzS2F6L4SES1N4wWgYdsvjBCytYdF
         0IcUP5Pm2kA0LDsu0osiB4r8+nsmRhuTvfhICjll+RgNijN6fwfUPGezLW7mpYboldpv
         bC3cyNP/HufF82lmvm9skwe3W9f/z7bVVKE6hsycfO5M+BVLRd/iHNc/xJ837EVm8WgU
         gwR/RW8wBNoIJ44T0884fRwUYV1+A3ZGcYpySLv94WMug5bIZeo9t3YQpmBHSWflQRld
         htHw==
X-Gm-Message-State: APjAAAUQMhPVAZ6NvSfmjDFVpAjeufBwq/IxjceJl8AtPh7jIQHtHB4/
        RJNr+GaQSMtk33ouMcJhkMxe96HkkLeJm/Djr1w=
X-Google-Smtp-Source: APXvYqysghF8ask8BksFBb3y7Dm3oMxM2Zjb+3RbjrLI8nFHbnwGd0yhNif+iOS0qBY6nljeGoG3qxsv5rSKxYeguV0=
X-Received: by 2002:a24:4d8a:: with SMTP id l132mr35507219itb.70.1555517126015;
 Wed, 17 Apr 2019 09:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190325202329.26033-3-avarab@gmail.com> <20190417124438.8191-1-avarab@gmail.com>
In-Reply-To: <20190417124438.8191-1-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 17 Apr 2019 23:04:59 +0700
Message-ID: <CACsJy8D215hMvfCwz1G9mP2te-ZERVaMMRrnM=MK1_bc0oFsjw@mail.gmail.com>
Subject: Re: [PATCH v2] parse-options: don't emit "ambiguous option" for aliases
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 17, 2019 at 7:44 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Change the option parsing machinery so that e.g. "clone --recurs ..."
> doesn't error out because "clone" understands both "--recursive" and
> "--recurse-submodules" to mean the same thing.
>
> Initially "clone" just understood --recursive until the
> --recurses-submodules alias was added in ccdd3da652 ("clone: Add the
> --recurse-submodules option as alias for --recursive",
> 2010-11-04). Since bb62e0a99f ("clone: teach --recurse-submodules to
> optionally take a pathspec", 2017-03-17) the longer form has been
> promoted to the default.
>
> But due to the way the options parsing machinery works this resulted
> in the rather absurd situation of:
>
>     $ git clone --recurs [...]
>     error: ambiguous option: recurs (could be --recursive or --recurse-su=
bmodules)
>
> Let's re-use the PARSE_OPT_NOCOMPLETE flag to mean "this option
> doesn't contribute to abbreviation ambiguity". I was going to add a
> new PARSE_OPT_NOABBREV flag, but it makes sense just to re-use
> PARSE_OPT_NOCOMPLETE.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>
> See
> https://public-inbox.org/git/20190325202329.26033-1-avarab@gmail.com/
> for v1. There wasn't consensus for 1/2 there, but this used-to-be 2/2
> seems like a no-brainer bugfix.
>
> It conflicted with some recently-landed stuff in 'master', but now
> cleanly applies to it and 'pu', and with pu's
> GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS.
>
>  builtin/clone.c          | 4 ++--
>  parse-options.c          | 3 ++-
>  parse-options.h          | 2 ++
>  t/t0040-parse-options.sh | 5 +++++
>  4 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 50bde99618..4dc26969a7 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -100,8 +100,8 @@ static struct option builtin_clone_options[] =3D {
>                     N_("setup as shared repository")),
>         { OPTION_CALLBACK, 0, "recursive", &option_recurse_submodules,
>           N_("pathspec"), N_("initialize submodules in the clone"),
> -         PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN, recurse_submodules_cb,
> -         (intptr_t)"." },
> +         PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE,

What happens if someone adds --recursive-hard? --recursi then
resolving to --recursive-hard sounds wrong.

But on the other hand I can see it's a bit more work to teach
parse-options OPT_ALIAS to say "--recursive is just an alias of
--recurse-submodules" and chances of --recursive-hard coming up are
probably very low.

So I don't know but I thought I should point out.

> +         recurse_submodules_cb, (intptr_t)"." },
>         { OPTION_CALLBACK, 0, "recurse-submodules", &option_recurse_submo=
dules,
>           N_("pathspec"), N_("initialize submodules in the clone"),
>           PARSE_OPT_OPTARG, recurse_submodules_cb, (intptr_t)"." },
> diff --git a/parse-options.c b/parse-options.c
> index cec74522e5..9899ce0171 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -292,7 +292,8 @@ static enum parse_opt_result parse_long_opt(
>                 if (!rest) {
>                         /* abbreviated? */
>                         if (!(p->flags & PARSE_OPT_KEEP_UNKNOWN) &&
> -                           !strncmp(long_name, arg, arg_end - arg)) {
> +                           !strncmp(long_name, arg, arg_end - arg) &&
> +                           !(options->flags & PARSE_OPT_NOCOMPLETE)) {
>  is_abbreviated:
>                                 if (abbrev_option) {
>                                         /*
> diff --git a/parse-options.h b/parse-options.h
> index 74cce4e7fc..51c4b71ab0 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -96,6 +96,8 @@ typedef enum parse_opt_result parse_opt_ll_cb(struct pa=
rse_opt_ctx_t *ctx,
>   *                             Useful for options with multiple paramete=
rs.
>   *   PARSE_OPT_NOCOMPLETE: by default all visible options are completabl=
e
>   *                        by git-completion.bash. This option suppresses=
 that.
> + *                        Will also skip this option when abbreviation i=
s
> + *                        considered.
>   *   PARSE_OPT_COMP_ARG: this option forces to git-completion.bash to
>   *                      complete an option as --name=3D not --name even =
if
>   *                      the option takes optional argument.
> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> index b8f366c442..e8f0371830 100755
> --- a/t/t0040-parse-options.sh
> +++ b/t/t0040-parse-options.sh
> @@ -220,6 +220,11 @@ test_expect_success 'non ambiguous option (after two=
 options it abbreviates)' '
>         test-tool parse-options --expect=3D"string: 123" --st 123
>  '
>
> +test_expect_success 'NOCOMPLETE options do not contribute to abbreviatio=
n' '
> +       test_when_finished "rm -rf A" &&
> +       git clone --recurs . A
> +'
> +
>  cat >typo.err <<\EOF
>  error: did you mean `--boolean` (with two dashes ?)
>  EOF
> --
> 2.21.0.593.g511ec345e18
>


--=20
Duy
