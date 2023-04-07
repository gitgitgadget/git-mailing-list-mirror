Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3F5C6FD1D
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 05:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjDGFr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 01:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjDGFr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 01:47:58 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DA586B0
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 22:47:56 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id y7so10240513ljp.2
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 22:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680846474; x=1683438474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKACt/b7ihOug5gTGZ1CMRkx7tlQywKe4Ca04Sp6yus=;
        b=Mw5pX6uOMI217u9rFGP3/RYgzue/DoehyqFvmkc+cHxVnHmgPjGLNvhSsaXLhlvb4F
         GpLEZZKOiqoyfPw8qVEDTjwfHT8i3e7TkYyoCfsZMRb2FsYjSXyaJeCV3XNy1E52knGb
         Qg0P6tXLgEQ+/AulY8bISNjMGeFUUtz0lsZnhg3f3EJmjagzDubSDLRhNj4juQfdra+z
         VPQGMNxmxX4Y8dNVqX4xCWJ6LB+ex3BFoQwgMZyTeBM0OWLaLHRcrskMIEL/8gqYMUXZ
         hpjhKKkCLrh0BU8pPIeRjYyrbzh1dPXOGYVADOkGssPG/aFINNtrfhMsdD4vsG2kqrK0
         LcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680846474; x=1683438474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKACt/b7ihOug5gTGZ1CMRkx7tlQywKe4Ca04Sp6yus=;
        b=iqd8L3r5Z+IJ6a4X2vrRxNmewmakDRxqR9+idvxULEDWoNDFGx4V9elZ6BaHlerZAi
         UkM2wHtVVIwxgTFuErW7Lyf8Mk8qTthXItRlzlrlzpCLMJQCpOr00EJaPIzCFF1RHTJh
         rL+J/WvQHO9BxLXlTyoCRTFfQrWz7yz9botfipeXjkvlJQrbO+I0TqcezSw+xY4EGqDF
         VbYuFX9EK/QSbg846LsxiPGwU3OSgR+nRFpbOZ7t4q6btKnKGT40HWtjCO1ECjY+4vV7
         5K6MWiPUiNZSHbSyYEpDGZ9jZRzTeGJ+SHLMCUgV9I0sGVZ/13oWCPKJjd0tC90senJX
         l6TQ==
X-Gm-Message-State: AAQBX9cS9+d0ROFzCbxs1E3/Wxa+tRRSu+NsLCEu1YnOJ32HvLz3Qnyd
        tCUjE5vDJUB3i5sy8oPtK7ueS3L3i9Eu1+a9s8w=
X-Google-Smtp-Source: AKy350aAltSgULznBUquqe43YxwS82MuD/8RO2q9gcp0Ail4ikolcaPm4KFnZrX8xu0v7+7GPRXQiTxopnjqN9B9VbA=
X-Received: by 2002:a05:651c:103c:b0:2a6:16b4:a554 with SMTP id
 w28-20020a05651c103c00b002a616b4a554mr241837ljm.3.1680846474180; Thu, 06 Apr
 2023 22:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk>
 <cover.1680708043.git.phillip.wood@dunelm.org.uk> <9a90212ef284510fa691b8eebd6bdd61098282fd.1680708043.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <9a90212ef284510fa691b8eebd6bdd61098282fd.1680708043.git.phillip.wood@dunelm.org.uk>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 6 Apr 2023 22:47:42 -0700
Message-ID: <CABPp-BGPyVZu1iOW5TLUE+tfU+uFs=UNNzFX+=DFY5D2Wt4-+w@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] rebase -m: fix serialization of strategy options
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2023 at 8:22=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
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

s/be still be/still be/

Sorry for not noticing this last time.

> the file can still be parsed by recent versions of git as they treat the
> "--" prefix as optional.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  alias.c                        | 18 +++++++++++++++++
>  alias.h                        |  3 +++
>  sequencer.c                    | 11 ++++++-----
>  t/t3418-rebase-continue.sh     | 36 ++++++++++++++++++++++------------
>  t/t3436-rebase-more-options.sh | 24 -----------------------
>  5 files changed, 50 insertions(+), 42 deletions(-)
>
> diff --git a/alias.c b/alias.c
> index e814948ced..54a1a23d2c 100644
> --- a/alias.c
> +++ b/alias.c
> @@ -3,6 +3,7 @@
>  #include "alloc.h"
>  #include "config.h"
>  #include "gettext.h"
> +#include "strbuf.h"
>  #include "string-list.h"
>
>  struct config_alias_data {
> @@ -46,6 +47,23 @@ void list_aliases(struct string_list *list)
>         read_early_config(config_alias_cb, &data);
>  }
>
> +void quote_cmdline(struct strbuf *buf, const char **argv)
> +{
> +       for (const char **argp =3D argv; *argp; argp++) {
> +               if (argp !=3D argv)
> +                       strbuf_addch(buf, ' ');
> +               strbuf_addch(buf, '"');
> +               for (const char *p =3D *argp; *p; p++) {
> +                       const char c =3D *p;
> +
> +                       if (c =3D=3D '"' || c =3D=3D'\\')
> +                               strbuf_addch(buf, '\\');
> +                       strbuf_addch(buf, c);
> +               }
> +               strbuf_addch(buf, '"');
> +       }
> +}
> +
>  #define SPLIT_CMDLINE_BAD_ENDING 1
>  #define SPLIT_CMDLINE_UNCLOSED_QUOTE 2
>  #define SPLIT_CMDLINE_ARGC_OVERFLOW 3
> diff --git a/alias.h b/alias.h
> index aef4843bb7..43db736484 100644
> --- a/alias.h
> +++ b/alias.h
> @@ -1,9 +1,12 @@
>  #ifndef ALIAS_H
>  #define ALIAS_H
>
> +struct strbuf;
>  struct string_list;
>
>  char *alias_lookup(const char *alias);
> +/* Quote argv so buf can be parsed by split_cmdline() */
> +void quote_cmdline(struct strbuf *buf, const char **argv);
>  int split_cmdline(char *cmdline, const char ***argv);
>  /* Takes a negative value returned by split_cmdline */
>  const char *split_cmdline_strerror(int cmdline_errno);
> diff --git a/sequencer.c b/sequencer.c
> index 045d549042..9907100c8a 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2925,7 +2925,7 @@ static void parse_strategy_opts(struct replay_opts =
*opts, char *raw_opts)
>
>         count =3D split_cmdline(strategy_opts_string, &argv);
>         if (count < 0)
> -               die(_("could not split '%s': %s"), strategy_opts_string,
> +               BUG("could not split '%s': %s", strategy_opts_string,
>                             split_cmdline_strerror(count));
>         for (i =3D 0; i < count; i++) {
>                 const char *arg =3D argv[i];
> @@ -3048,12 +3048,13 @@ static int read_populate_opts(struct replay_opts =
*opts)
>
>  static void write_strategy_opts(struct replay_opts *opts)
>  {
> -       int i;
>         struct strbuf buf =3D STRBUF_INIT;
>
> -       for (i =3D 0; i < opts->xopts.nr; ++i)
> -               strbuf_addf(&buf, " --%s", opts->xopts.v[i]);
> -
> +       /*
> +        * Quote strategy options so that they can be read correctly
> +        * by split_cmdline().
> +        */
> +       quote_cmdline(&buf, opts->xopts.v);
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
> -       EOF
> -       chmod +x test-bin/git-merge-funny &&
> +
> +       write_script test-bin/git-merge-funny <<-\EOF &&
> +       printf "[%s]\n" $# "$1" "$2" "$3" "$5" >actual
> +       shift 3 &&
> +       exec git merge-recursive "$@"
> +       EOF
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
> 2.40.0.670.g64ef305212.dirty

Looks good.
