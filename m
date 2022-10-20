Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB13BC4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 22:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiJTWtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 18:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiJTWtp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 18:49:45 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA142AE13
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:49:44 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id cb7-20020a056a00430700b00561b86e0265so376998pfb.13
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SLc98sEkUFax4GNVMGMS8r+mbRl7nHaKnkF52mQ39CI=;
        b=Nm/3sr140PnvvBpqKeC221/7EyOG1ZXwvks+kjkMc88u+LL2CCOuagnFiLeof+TDa8
         bQiNNYjjofCFoN7BO8/jMy26e76RMN61+tIq1ERnfGIt5TfL+YbX6p7PACKOQNQmMD1T
         W9patjRfEEqJltALIdbREiJOlHxYE8JTg9OWaD9rDswlVsux8lelMoeT/u+cuMGN9yDY
         460cQPRK8zSRbyq5NlA3smvZdZ+TVL0BF11rpmALI96sn6Kefvli+YzhBGLxAoqGDBnR
         axoNNkuQMeX9EQrt3hSM/w/XP6VVbWQCYlZVle/CIIReJ1VCSzTfwOZ1FSKAIEYg7/dC
         11nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SLc98sEkUFax4GNVMGMS8r+mbRl7nHaKnkF52mQ39CI=;
        b=ev5uwNzAGjaGyp5vreuduoHVtscUDkJm5SDp1uZ1VZVEWzLEBnJCZsTSGZKDjznfFh
         jIVjWxlu584WvT8bjWHTkbFuUh+pvMGd9cI5FS0EmJ5K8jCDRy2dfXjK4GzpYqKkteGi
         XMeOUsJxjcLexsnmzTNhPspmLlbPZah3gaFLTGxRwoPqtvtJ587+q1fkxsN4IPduOr57
         U+ji0F2CBDsxD+gidqzuISrytPjpwbXSQgh9A11KeWc9bRUgzZP/KXlGwozTm2gAuQKA
         Rt2lN0pnMUW82GcRgeiE2a3xBKCAJpLtwRUvSH5nv/rxkI6fkLFkWgEvlkx682Whhg30
         1TfA==
X-Gm-Message-State: ACrzQf0AMA+h0oTgXD1tyErFMoRXxvmJLRS9UmCUsaF2LTBe9UZeFyCW
        NnOhybjuCm+j5QKftEZYPJ6NYg7SPVVXDQ==
X-Google-Smtp-Source: AMsMyM5nVxrUJInuzu9jCwE4M2V1+Qr4xYoErYvzBpmXy/lRMNpGxqxfRzIno3HichGElvi2p73PEcSUAvVrRQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:234d:b0:561:ec04:e77e with SMTP
 id j13-20020a056a00234d00b00561ec04e77emr16350234pfj.14.1666306183997; Thu,
 20 Oct 2022 15:49:43 -0700 (PDT)
Date:   Thu, 20 Oct 2022 15:49:42 -0700
In-Reply-To: <patch-07.10-2c77ed38d90-20221017T115544Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com> <patch-07.10-2c77ed38d90-20221017T115544Z-avarab@gmail.com>
Message-ID: <kl6lpmemxg8p.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 07/10] submodule: make it a built-in, remove git-submodule.sh
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonas Bernoulli <jonas@bernoul.li>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Replace the "git-submodule.sh" script with a built-in
> "builtin/submodule.c. For" now this new command is only a dumb
> dispatcher that uses run-command.c to invoke "git submodule--helper",
> just as "git-submodule.sh" used to do.
>
> This is obviously not ideal, and we should eventually follow-up and
> merge the "builtin/submodule--helper.c" code into
> "builtin/submodule.c". Doing it this way makes it easy to review that
> this new C implementation isn't doing anything more clever than the
> old shellscript implementation.
>
> This is a large win for performance, we're now more than 4x as fast as
> before in terms of the fixed cost of invoking any "git submodule"
> command[1]:
>
> 	$ git hyperfine -L rev HEAD~1,HEAD -s 'make CFLAGS=3D-O3' './git --exec-=
path=3D$PWD submodule foreach "echo \$name"'
> 	Benchmark 1: ./git --exec-path=3D$PWD submodule foreach "echo \$name"' i=
n 'HEAD~1
> 	  Time (mean =C2=B1 =CF=83):      42.2 ms =C2=B1   0.4 ms    [User: 34.9=
 ms, System: 9.1 ms]
> 	  Range (min =E2=80=A6 max):    41.3 ms =E2=80=A6  43.2 ms    70 runs
>
> 	Benchmark 2: ./git --exec-path=3D$PWD submodule foreach "echo \$name"' i=
n 'HEAD
> 	  Time (mean =C2=B1 =CF=83):       9.7 ms =C2=B1   0.1 ms    [User: 7.6 =
ms, System: 2.2 ms]
> 	  Range (min =E2=80=A6 max):     9.5 ms =E2=80=A6  10.3 ms    282 runs
>
> 	Summary
> 	  './git --exec-path=3D$PWD submodule foreach "echo \$name"' in 'HEAD' r=
an
> 	    4.33 =C2=B1 0.07 times faster than './git --exec-path=3D$PWD submodu=
le foreach "echo \$name"' in 'HEAD~1'
>
> We're taking pains here to faithfully reproduce existing
> "git-submodule.sh" behavior, even when that behavior is stupid. Some
> of it we'll fix in subsequent commits, but let's first faithfully
> reproduce the behavior.
>
> One exception is the change in the behavior of the exit code
> stand-alone "-h" and "--" yield, see the altered tests. Returning 129
> instead of 0 and 1 for "-h" and "--" respectively is a concession to
> basic sanity.

Sounds reasonable.

> The pattern of using "define BUILTIN_" macros here isn't needed for
> now, but as we'll move code out of "builtin/submodule--helper.c" we'll
> want to re-use these strings. See 8757b35d443 (commit-graph: define
> common usage with a macro, 2021-08-23) and 1e91d3faf6c (reflog: move
> "usage" variables and use macros, 2022-03-17) for prior art using this
> pattern.
>
> The "(argc < 2 || !strcmp(argv[1], "-h"))" path at the top of
> cmd_submodule__helper() could now be a "(argc < 2)" if not for
> t0012-help.sh (which invokes all built-ins manually with "-h"). Let's
> leave it for now, eventually we'll consolidate the two.
>
> 1. Using the "git hyperfine" wrapper for "hyperfine":
>    https://lore.kernel.org/git/211201.86r1aw9gbd.gmgdl@evledraar.gmail.co=
m/
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  Makefile                   |   2 +-
>  builtin.h                  |   1 +
>  builtin/submodule.c        | 151 +++++++++++++++++++++++++++++++++++++
>  git-submodule.sh           |  91 ----------------------
>  git.c                      |   1 +
>  t/t7400-submodule-basic.sh |  12 ++-
>  6 files changed, 159 insertions(+), 99 deletions(-)
>  create mode 100644 builtin/submodule.c
>  delete mode 100755 git-submodule.sh
>
> diff --git a/Makefile b/Makefile
> index 6bfb62cbe94..d8e2c02ad42 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -635,7 +635,6 @@ SCRIPT_SH +=3D git-merge-resolve.sh
>  SCRIPT_SH +=3D git-mergetool.sh
>  SCRIPT_SH +=3D git-quiltimport.sh
>  SCRIPT_SH +=3D git-request-pull.sh
> -SCRIPT_SH +=3D git-submodule.sh
>  SCRIPT_SH +=3D git-web--browse.sh
> =20
>  SCRIPT_LIB +=3D git-mergetool--lib
> @@ -1235,6 +1234,7 @@ BUILTIN_OBJS +=3D builtin/show-ref.o
>  BUILTIN_OBJS +=3D builtin/sparse-checkout.o
>  BUILTIN_OBJS +=3D builtin/stash.o
>  BUILTIN_OBJS +=3D builtin/stripspace.o
> +BUILTIN_OBJS +=3D builtin/submodule.o
>  BUILTIN_OBJS +=3D builtin/submodule--helper.o
>  BUILTIN_OBJS +=3D builtin/symbolic-ref.o
>  BUILTIN_OBJS +=3D builtin/tag.o
> diff --git a/builtin.h b/builtin.h
> index 8901a34d6bf..475c79b6a5a 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -224,6 +224,7 @@ int cmd_sparse_checkout(int argc, const char **argv, =
const char *prefix);
>  int cmd_status(int argc, const char **argv, const char *prefix);
>  int cmd_stash(int argc, const char **argv, const char *prefix);
>  int cmd_stripspace(int argc, const char **argv, const char *prefix);
> +int cmd_submodule(int argc, const char **argv, const char *prefix);
>  int cmd_submodule__helper(int argc, const char **argv, const char *prefi=
x);
>  int cmd_switch(int argc, const char **argv, const char *prefix);
>  int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
> diff --git a/builtin/submodule.c b/builtin/submodule.c
> new file mode 100644
> index 00000000000..7e3499f3376
> --- /dev/null
> +++ b/builtin/submodule.c
> @@ -0,0 +1,151 @@
> +/*
> + * Copyright (c) 2007-2022 Lars Hjemli & others
> + * Copyright(c) 2022 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> + */
> +#include "builtin.h"
> +#include "parse-options.h"
> +#include "run-command.h"
> +#include "strvec.h"
> +
> +#define BUILTIN_SUBMODULE_USAGE \
> +	"git submodule [--quiet] [--cached]"
> +
> +#define BUILTIN_SUBMODULE_ADD_USAGE \
> +	N_("git submodule [--quiet] add [-b <branch>] [-f | --force] [--name <n=
ame>]\n" \
> +	   "              [--reference <repository>] [--] <repository> [<path>]=
")
> +
> +#define BUILTIN_SUBMODULE_STATUS_USAGE \
> +	N_("git submodule [--quiet] status [--cached] [--recursive] [--] [<path=
>...]")
> +
> +#define BUILTIN_SUBMODULE_INIT_USAGE \
> +	N_("git submodule [--quiet] init [--] [<path>...]")
> +
> +#define BUILTIN_SUBMODULE_DEINIT_USAGE \
> +	N_("git submodule [--quiet] deinit [-f | --force] (--all | [--] <path>.=
..)")
> +
> +#define BUILTIN_SUBMODULE_UPDATE_USAGE \
> +	N_("git submodule [--quiet] update [-v] [--init [--filter=3D<filter-spe=
c>]]\n" \
> +	   "              [--remote] [-N | --no-fetch] [-f | --force] [--checko=
ut |--merge | --rebase]\n" \
> +	   "              [--[no-]recommend-shallow] [--reference <repository>]=
 [--recursive]\n" \
> +	   "              [--[no-]single-branch] [--] [<path>...]")
> +
> +#define BUILTIN_SUBMODULE_SET_BRANCH_USAGE \
> +	N_("git submodule [--quiet] set-branch (--default | --branch <branch>) =
[--] <path>")
> +
> +#define BUILTIN_SUBMODULE_SET_URL_USAGE \
> +	N_("git submodule [--quiet] set-url [--] <path> <newurl>")
> +
> +#define BUILTIN_SUBMODULE_SUMMARY_USAGE \
> +	N_("git submodule [--quiet] summary [--cached | --files] [--summary-lim=
it <n>]\n"  \
> +	   "              [commit] [--] [<path>...]")
> +#define BUILTIN_SUBMODULE_FOREACH_USAGE \
> +	N_("git submodule [--quiet] foreach [--recursive] <command>")
> +
> +#define BUILTIN_SUBMODULE_SYNC_USAGE \
> +	N_("git submodule [--quiet] sync [--recursive] [--] [<path>...]")
> +
> +#define BUILTIN_SUBMODULE_ABSORBGITDIRS_USAGE \
> +	N_("git submodule [--quiet] absorbgitdirs [--] [<path>...]")
> +

I was surprised to see that these strings aren't deduped from the ones
in builtin/submodule--helper.c, and are, in fact, different. Is there a
reason for that?

> +static const char * const git_submodule_usage[] =3D {
> +	BUILTIN_SUBMODULE_USAGE,
> +	BUILTIN_SUBMODULE_ADD_USAGE,
> +	BUILTIN_SUBMODULE_STATUS_USAGE,
> +	BUILTIN_SUBMODULE_INIT_USAGE,
> +	BUILTIN_SUBMODULE_DEINIT_USAGE,
> +	BUILTIN_SUBMODULE_UPDATE_USAGE,
> +	BUILTIN_SUBMODULE_SET_BRANCH_USAGE,
> +	BUILTIN_SUBMODULE_SET_URL_USAGE,
> +	BUILTIN_SUBMODULE_SUMMARY_USAGE,
> +	BUILTIN_SUBMODULE_FOREACH_USAGE,
> +	BUILTIN_SUBMODULE_SYNC_USAGE,
> +	BUILTIN_SUBMODULE_ABSORBGITDIRS_USAGE,
> +	NULL,
> +};
> +
> +static void setup_helper_args(int argc, const char **argv, const char *p=
refix,
> +			      int quiet, int cached, struct strvec *args,
> +			      const struct option *options)
> +{
> +	const char *cmd;
> +	int do_quiet_cache =3D 1;
> +	int do_prefix =3D 1;
> +
> +	strvec_push(args, "submodule--helper");
> +
> +	/* No command word defaults to "status" */
> +	if (!argc) {
> +		strvec_push(args, "status");
> +		return;
> +	}

We can't return without processing "--cached", e.g. removing the
explicit "status" subcommand like so fails.

  diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
  index d8f7d6ee29..5e61cef18e 100755
  --- a/t/t7400-submodule-basic.sh
  +++ b/t/t7400-submodule-basic.sh
  @@ -587,7 +587,7 @@ test_expect_success 'status should be "modified" afte=
r submodule commit' '
  '

  test_expect_success 'the --cached sha1 should be rev1' '
  -	git submodule status --cached >list &&
  +	git submodule --cached >list &&
    grep "^+$rev1" list
  '

> +
> +	/* Did we get --cached with a command? */
> +	if (cached)
> +		usage_msg_optf(_("'%s' option is only supported with explicit 'status'=
"),
> +			       git_submodule_usage, options, "--cached");
> +
> +
> +	/* Either a valid command, or submodule--helper will barf! */
> +	cmd =3D argv[0];

submodule--helper does die, but the help message that it emits is
submodule--helper specific, instead of the "git submodule" usage string
from before.

> +	strvec_push(args, cmd);
> +	argv++;
> +	argc--;
> +
> +	/*
> +	  * This is stupid, but don't support "[--]" to
> +	 * subcommand-less "git-submodule" for now.
> +	 */
> +	if (!strcmp(cmd, "--") || !strcmp(cmd, "--end-of-options"))
> +		usage_msg_optf(_("need explicit sub-command name to delimit with '%s'"=
),
> +			       git_submodule_usage, options, cmd);

If this is the only "stupid" behavior, maybe just call this out
specifically in the commit message.

> +
> +	/* Options that need to go before user-supplied options */
> +	if (!strcmp(cmd, "absorbgitdirs"))
> +		do_quiet_cache =3D 0;
> +	else if (!strcmp(cmd, "update"))
> +		;
> +	else
> +		do_prefix =3D 0;
> +	if (do_quiet_cache) {
> +		if (quiet)
> +			strvec_push(args, "--quiet");
> +		if (cached)
> +			strvec_push(args, "--cached");
> +
> +		if (prefix && do_prefix)
> +			strvec_pushl(args, "--prefix", prefix, NULL);
> +	}

This looks like a good reason to get rid of "--prefix" from "git
submodule--helper update" like I mentioned upthread.

I didn't notice earlier that absorbgitdirs had the same problem, but
that's an even easier fixup:

  diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
  index d11e100301..1f7f142270 100644
  --- a/builtin/submodule--helper.c
  +++ b/builtin/submodule--helper.c
  @@ -2825,9 +2825,6 @@ static int absorb_git_dirs(int argc, const char **a=
rgv, const char *prefix)
    struct module_list list =3D MODULE_LIST_INIT;
    unsigned flags =3D ABSORB_GITDIR_RECURSE_SUBMODULES;
    struct option embed_gitdir_options[] =3D {
  -		OPT_STRING(0, "prefix", &prefix,
  -			   N_("path"),
  -			   N_("path into the working tree")),
      OPT_BIT(0, "--recursive", &flags, N_("recurse into submodules"),
        ABSORB_GITDIR_RECURSE_SUBMODULES),
      OPT_END()
