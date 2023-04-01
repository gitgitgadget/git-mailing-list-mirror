Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4015C6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 19:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjDAT2A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 15:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjDAT17 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 15:27:59 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5932708
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 12:27:57 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y15so33109550lfa.7
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 12:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680377275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7NYHOFfg9pVDEbY36OwygG4dVGBgDA66AjTPWftT/M=;
        b=E7+TdZnuo32+h8xe+0G96dL+zg9TkPH1nicl8n6ApIKRmZzPSCx1kDrMbBeXGO+0Lz
         3QGHb7UW6vphAArqf+GOCP+QsBZPhcvvYGCFKKu6GTR1jpNOPwVfgtc/X90sdbRfxaDP
         6OsycYQk3A+h1gzIFIEFts8AoiM7Gig+jBaeJB0jDxo7A0/l9gJOKpXrRryrdsMGB2pQ
         3cGlkR7LDrbJ2mgtRdoGymIwvmcIRtj84j34BQTONm7hp8x2WVNnwRmXOwT4r8Rjh6C7
         +9LJfhjRrCMnOQXsRnv8NFi8l/smqLkywCvh+ZZzdlLzSmPKW3fmte3B3O/cLnPchDbO
         uuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680377275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7NYHOFfg9pVDEbY36OwygG4dVGBgDA66AjTPWftT/M=;
        b=UD/g3I6NT+7JrdhKHD5AHy2zuZLhUV1QyZk/CiaCiqayhX3bulusEITT24XubUwCT7
         RNCMIFBWNK0ukfhve3SJtqxdhkFBPvS0T8n2umsW9jD5ocxA8LKaT/1GNBTG8/H255BJ
         Jk9Kj9AF3j28eatTPoEY8i+kS6P03Ua7T9BPmHOPrWV2obmWH7gy982XO1U/jXwH1VOT
         b8qo1+cQoLCF3+zhLIQjNVY6VW1vTH2zn0DuXg/eMC/VyCnUAKpCGqOVz+rHndTXW4Td
         BnIXKqxe99i2YGP4nBL7iIk4e9t2txmWbECeVjANlDZyNdKe74rhvxgrV9BgEtcxf2dX
         LcbA==
X-Gm-Message-State: AAQBX9dUZ9SHq6vuvuZrjLyZy3Khhbuhvd35CEZHnbDYCB1/F504lb87
        QGpHi6tYLKVJ9kD15a8Oa51b5AnkIKdVTXqCaXU=
X-Google-Smtp-Source: AKy350bt5eV4D2OKGxxxfifB1FYtVhZfehAZwY1RbOoxCbMnS/3n8ZTpNiVbvpj5bL5m2dhZq8MUXDPJ9nWfn2Vb4lo=
X-Received: by 2002:ac2:5396:0:b0:4e9:c627:195f with SMTP id
 g22-20020ac25396000000b004e9c627195fmr8911538lfh.7.1680377275358; Sat, 01 Apr
 2023 12:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk> <9af68cb065871d9b89e99ef6b48870d322bb5faa.1678893298.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <9af68cb065871d9b89e99ef6b48870d322bb5faa.1678893298.git.phillip.wood@dunelm.org.uk>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 1 Apr 2023 12:27:42 -0700
Message-ID: <CABPp-BF6_gmDCTo5j2fR5_KQfJYVuYZuYv6TdhsMvPYshXzu+g@mail.gmail.com>
Subject: Re: [PATCH 3/4] rebase -m: fix serialization of strategy options
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2023 at 8:51=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> To store the strategy options rebase prepends " --" to each one and
> writes them to a file. To load them it reads the file and passes the
> contents to split_cmdline(). This roughly mimics the behavior of the
> scripted rebase but has a couple of limitations, (1) options containing
> whitespace are not properly preserved (this is true of the scripted
> rebase as well) and (2) options containing '"' or '\' are incorrectly
> parsed and may cause the parser to return an error.
>
> Fix these limitations by quoting each option when they are stored so
> that they can be parsed correctly. Now that "--preserve-merges" no
> longer exist this change also stops prepending "--" to the options when
> they are stored as that was an artifact of the scripted rebase.
>
> These changes are backwards compatible so the files written by an older
> version of git can be still be read. They are also forwards compatible,
> the file can still be parsed by recent versions of git as they treat the
> "--" prefix as optional.

I'm not sure we want to tie ourselves to support completing a rebase
with git version X+1 that was started with git version X.  But, it's
really nice that you're paying attention to that level of detail.  :-)

>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  sequencer.c                    | 23 +++++++++++++++++++----
>  t/t3418-rebase-continue.sh     | 34 ++++++++++++++++++++++------------
>  t/t3436-rebase-more-options.sh | 24 ------------------------
>  3 files changed, 41 insertions(+), 40 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 83ea1016ae..8890d1f7a1 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2930,7 +2930,7 @@ static void parse_strategy_opts(struct replay_opts =
*opts, char *raw_opts)
>         count =3D split_cmdline(strategy_opts_string,
>                               (const char ***)&opts->xopts);
>         if (count < 0)
> -               die(_("could not split '%s': %s"), strategy_opts_string,
> +               BUG("could not split '%s': %s", strategy_opts_string,
>                             split_cmdline_strerror(count));
>         opts->xopts_nr =3D count;
>         for (i =3D 0; i < opts->xopts_nr; i++) {
> @@ -3054,12 +3054,27 @@ static int read_populate_opts(struct replay_opts =
*opts)
>
>  static void write_strategy_opts(struct replay_opts *opts)
>  {
> -       int i;
>         struct strbuf buf =3D STRBUF_INIT;
>
> -       for (i =3D 0; i < opts->xopts_nr; ++i)
> -               strbuf_addf(&buf, " --%s", opts->xopts[i]);
> +       /*
> +        * Quote strategy options so that they can be read correctly
> +        * by split_cmdline().
> +        */
> +       for (size_t i =3D 0; i < opts->xopts_nr; i++) {
> +               char *arg =3D opts->xopts[i];
>
> +               if (i)
> +                       strbuf_addch(&buf, ' ');
> +               strbuf_addch(&buf, '"');
> +               for (size_t j =3D 0; arg[j]; j++) {
> +                       const char c =3D arg[j];
> +
> +                       if (c =3D=3D '"' || c =3D=3D'\\')
> +                               strbuf_addch(&buf, '\\');
> +                       strbuf_addch(&buf, c);
> +               }
> +               strbuf_addch(&buf, '"');
> +       }

Do we not have a function in quote.[ch] that can handle this?  If not,
should we add this code to a function in that file and call it?

>         write_file(rebase_path_strategy_opts(), "%s\n", buf.buf);
>         strbuf_release(&buf);
>  }
> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> index 130e2f9b55..42c3954125 100755
> --- a/t/t3418-rebase-continue.sh
> +++ b/t/t3418-rebase-continue.sh
> @@ -62,29 +62,39 @@ test_expect_success 'rebase --continue remembers merg=
e strategy and options' '
>         rm -fr .git/rebase-* &&
>         git reset --hard commit-new-file-F2-on-topic-branch &&
>         test_commit "commit-new-file-F3-on-topic-branch" F3 32 &&
> -       test_when_finished "rm -fr test-bin funny.was.run" &&
> +       test_when_finished "rm -fr test-bin" &&
>         mkdir test-bin &&
> -       cat >test-bin/git-merge-funny <<-EOF &&
> -       #!$SHELL_PATH
> -       case "\$1" in --opt) ;; *) exit 2 ;; esac
> -       shift &&
> -       >funny.was.run &&
> -       exec git merge-recursive "\$@"
> +
> +       write_script test-bin/git-merge-funny <<-\EOF &&
> +       printf "[%s]\n" $# "$1" "$2" "$3" "$5" >actual
> +       shift 3 &&
> +       exec git merge-recursive "$@"
>         EOF
> -       chmod +x test-bin/git-merge-funny &&
> +
> +       cat >expect <<-\EOF &&
> +       [7]
> +       [--option=3Darg with space]
> +       [--op"tion\]
> +       [--new
> +       line ]
> +       [--]
> +       EOF
> +
> +       rm -f actual &&
>         (
>                 PATH=3D./test-bin:$PATH &&
> -               test_must_fail git rebase -s funny -Xopt main topic
> +               test_must_fail git rebase -s funny -X"option=3Darg with s=
pace" \
> +                               -Xop\"tion\\ -X"new${LF}line " main topic
>         ) &&
> -       test -f funny.was.run &&
> -       rm funny.was.run &&
> +       test_cmp expect actual &&
> +       rm actual &&
>         echo "Resolved" >F2 &&
>         git add F2 &&
>         (
>                 PATH=3D./test-bin:$PATH &&
>                 git rebase --continue
>         ) &&
> -       test -f funny.was.run
> +       test_cmp expect actual
>  '

I appreciate the more stringent test to cover these new special cases.  :-)

>
>  test_expect_success 'rebase -i --continue handles merge strategy and opt=
ions' '
> diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options=
.sh
> index 3adf42f47d..94671d3c46 100755
> --- a/t/t3436-rebase-more-options.sh
> +++ b/t/t3436-rebase-more-options.sh
> @@ -40,30 +40,6 @@ test_expect_success 'setup' '
>         EOF
>  '
>
> -test_expect_success 'bad -X <strategy-option> arguments: unclosed quote'=
 '
> -       test_when_finished "test_might_fail git rebase --abort" &&
> -       cat >expect <<-\EOF &&
> -       fatal: could not split '\''--bad'\'': unclosed quote
> -       EOF
> -       GIT_SEQUENCE_EDITOR=3D"echo break >" \
> -               git rebase -i -X"bad argument\"" side main &&
> -       test_expect_code 128 git rebase --continue >out 2>actual &&
> -       test_must_be_empty out &&
> -       test_cmp expect actual
> -'
> -
> -test_expect_success 'bad -X <strategy-option> arguments: bad escape' '
> -       test_when_finished "test_might_fail git rebase --abort" &&
> -       cat >expect <<-\EOF &&
> -       fatal: could not split '\''--bad'\'': cmdline ends with \
> -       EOF
> -       GIT_SEQUENCE_EDITOR=3D"echo break >" \
> -               git rebase -i -X"bad escape \\" side main &&
> -       test_expect_code 128 git rebase --continue >out 2>actual &&
> -       test_must_be_empty out &&
> -       test_cmp expect actual
> -'
> -
>  test_expect_success '--ignore-whitespace works with apply backend' '
>         test_must_fail git rebase --apply main side &&
>         git rebase --abort &&
> --
> 2.39.2
