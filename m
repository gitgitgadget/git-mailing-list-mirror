Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D57C47088
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C724613CA
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbhE0AKi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbhE0AKf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:10:35 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F070C061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:02 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id a7-20020a05622a02c7b02901fbef073c99so1663823qtx.15
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=gEM5cL4E5J8tRoPNccOslPhsusndVgfYVhIrtLInemw=;
        b=s7nqhN15LNMrOpERfvz7cLwE8mUNxdjUZ/+mxtqfhRf7hTzbw9IGprHNj5rteYyPcG
         Vhj6lKhuUj6vUyefn38ip3/hosUFBse6PetZQR1BKkBQZ72AVh27dih8+w6jul98X5z2
         b1GQym8DQuwrW4AxKTZS+eU3DURfNY5787FxV+K2w3QW9NqD7UcOGErIIhmse5mciCQ+
         vEGr5kIYAzgRjYMpxwcRHm2xq2cMzOENU0gaq8OCueskOPepD/3NOtaBKTG/FPSWeDoc
         ebzQpbXMeVjkPdPppT3uhyXHYUi/Pzlj02LBvNHJWEUA8EHvCCVaOUYV8hhc+4bMYzfx
         fS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc:content-transfer-encoding;
        bh=gEM5cL4E5J8tRoPNccOslPhsusndVgfYVhIrtLInemw=;
        b=l8LJwwv82GjmhLZC+dJrJOAScA/2U2j1yomqtPGu6EEP4v2/a8srphfyZo7LC/13OL
         MZYVmFGNoTlunBq5qj3UcDRsotT+WQapKGYQsWZMFhucc3ujVqib1rgX+sKBOJ0DzlK5
         CYcRQJ/umD9tfiRzp6HU+DJEHkQMW9JRtZqPPXdLtPAQpkCJ7gLv4RPEWUioetJGXiu3
         WPDIxc0S+IaPzlcIsn71Rh630UNWvnJwnNpnixannjIHHenN6gLxIREyv83ktv+0kA1Y
         H/MFU/c7X9xz5XEUAeaitv1TBVgRAT6mC0zoBW5J4zFvlOZ0mczdgdAyfGBdmDznUhmu
         VRMQ==
X-Gm-Message-State: AOAM530GMElPFBmJYgv20Tfew99g9T52YvTmvqFYXYuKt9bKD1nVBgME
        8rp9i3BDK1u2yipy4GyNI7O1JbE+zGrZG7/eUuNL7VWGIvzT9zDYUet+PreGGSIJnkzMPetgqmK
        GJKZmBtmeB/aZtaJX/5Qw5i2yW8pzNA5viNUGXqfRv4gURQTgDHQS2pRGBWx35pkF+WKNHBL0zg
        ==
X-Google-Smtp-Source: ABdhPJxC0KPwsmcr5LJeVvSp4w6qIST2Uea+1KT+GPM6Us3k3wQ9YP8awFFU02KEG1GPihC87DA5cFp1WDLVeC5WQK8=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:e1ca:: with SMTP id
 v10mr510979qvl.47.1622074141499; Wed, 26 May 2021 17:09:01 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:19 -0700
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 00/37] propose config-based hooks
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After much delay and $DAYJOB, here is v9.

- Addressed nits in reviews on v8
- sendemail-validate hook becomes non-parallelized; updated to use
  =C3=86var's updated system_or_die() function
- changed strbuf to char* in hooks_list
  - Attempted to do so in run_command's stdout callback, but this made
    length protection difficult, so stuck with strbuf there.
- test_i18ncmp -> test_cmp
- Stop doing i18n lego in run_hooks()
- Checked that run_hooks_opt_init() is always separated by a space from
  variable decl blocks
- Checked for early returns which may skip run_hooks_opt_clear(); this
  resulted in minimizing the scope of run_hooks_opt in most places
- Got rid of native-hooks.txt. It was a nice idea, but not attached to a
  large and slow series like this one.
- In traces, log the name of the hook (e.g. "pre-commit") instead of the
  name of the executable (e.g. "/home/emily/check-for-debug-strings");
  the executable name is tracelogged as part of argv anyways, and we
  want to be able to tell which hook was responsible for invoking the
  executable in question.

Thanks.
 - Emily

Emily Shaffer (37):
  doc: propose hooks managed by the config
  hook: introduce git-hook subcommand
  hook: include hookdir hook in list
  hook: teach hook.runHookDir
  hook: implement hookcmd.<name>.skip
  parse-options: parse into strvec
  hook: add 'run' subcommand
  hook: introduce hook_exists()
  hook: support passing stdin to hooks
  run-command: allow stdin for run_processes_parallel
  hook: allow parallel hook execution
  hook: allow specifying working directory for hooks
  run-command: add stdin callback for parallelization
  hook: provide stdin by string_list or callback
  run-command: allow capturing of collated output
  hooks: allow callers to capture output
  commit: use config-based hooks
  am: convert applypatch hooks to use config
  merge: use config-based hooks for post-merge hook
  gc: use hook library for pre-auto-gc hook
  rebase: teach pre-rebase to use hook.h
  read-cache: convert post-index-change hook to use config
  receive-pack: convert push-to-checkout hook to hook.h
  git-p4: use 'git hook' to run hooks
  hooks: convert 'post-checkout' hook to hook library
  hook: convert 'post-rewrite' hook to config
  transport: convert pre-push hook to use config
  reference-transaction: look for hooks in config
  receive-pack: convert 'update' hook to hook.h
  proc-receive: acquire hook list from hook.h
  post-update: use hook.h library
  receive-pack: convert receive hooks to hook.h
  bugreport: use hook_exists instead of find_hook
  git-send-email: use 'git hook run' for 'sendemail-validate'
  run-command: stop thinking about hooks
  doc: clarify fsmonitor-watchman specification
  docs: link githooks and git-hook manpages

 .gitignore                                    |   1 +
 Documentation/Makefile                        |   1 +
 Documentation/config/hook.txt                 |  27 +
 Documentation/git-hook.txt                    | 162 ++++++
 Documentation/githooks.txt                    |  77 ++-
 Documentation/technical/api-parse-options.txt |   7 +
 .../technical/config-based-hooks.txt          | 369 +++++++++++++
 Makefile                                      |   2 +
 builtin.h                                     |   1 +
 builtin/am.c                                  |  39 +-
 builtin/bugreport.c                           |   4 +-
 builtin/checkout.c                            |  19 +-
 builtin/clone.c                               |   8 +-
 builtin/commit.c                              |  11 +-
 builtin/fetch.c                               |   1 +
 builtin/gc.c                                  |   9 +-
 builtin/hook.c                                | 190 +++++++
 builtin/merge.c                               |  15 +-
 builtin/rebase.c                              |  10 +-
 builtin/receive-pack.c                        | 326 ++++++------
 builtin/submodule--helper.c                   |   2 +-
 builtin/worktree.c                            |  32 +-
 command-list.txt                              |   1 +
 commit.c                                      |  22 +-
 commit.h                                      |   3 +-
 git-p4.py                                     |  67 +--
 git-send-email.perl                           |  26 +-
 git.c                                         |   1 +
 hook.c                                        | 483 ++++++++++++++++++
 hook.h                                        | 139 +++++
 parse-options-cb.c                            |  16 +
 parse-options.h                               |   4 +
 read-cache.c                                  |  13 +-
 refs.c                                        |  43 +-
 reset.c                                       |  17 +-
 run-command.c                                 | 156 +++---
 run-command.h                                 |  55 +-
 sequencer.c                                   |  92 ++--
 submodule.c                                   |   1 +
 t/helper/test-parse-options.c                 |   6 +
 t/helper/test-run-command.c                   |  46 +-
 t/t0040-parse-options.sh                      |  27 +
 t/t0061-run-command.sh                        |  37 ++
 t/t1360-config-based-hooks.sh                 | 329 ++++++++++++
 t/t1416-ref-transaction-hooks.sh              |  12 +-
 t/t5411/test-0015-too-many-hooks-error.sh     |  47 ++
 ...3-pre-commit-and-pre-merge-commit-hooks.sh |  17 +-
 t/t9001-send-email.sh                         |  13 +-
 transport.c                                   |  58 +--
 49 files changed, 2505 insertions(+), 539 deletions(-)
 create mode 100644 Documentation/config/hook.txt
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 Documentation/technical/config-based-hooks.txt
 create mode 100644 builtin/hook.c
 create mode 100644 hook.c
 create mode 100644 hook.h
 create mode 100755 t/t1360-config-based-hooks.sh
 create mode 100644 t/t5411/test-0015-too-many-hooks-error.sh



 1:  85b99369f1 !  1:  d2b7ee8317 doc: propose hooks managed by the config
    @@ Commit message
    =20
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    =20
    +
    + ## Notes ##
    +    Since v6, checked for inconsistencies with implementation and adde=
d lots of
    +    caveats about whether 'git hook add' and 'git hook edit' will ever=
 materialize.
    +
    +    Hopefully this reflects reality now; please review accordingly.
    +
    +    Since v6, checked for inconsistencies with implementation and adde=
d lots of
    +    caveats about whether 'git hook add' and 'git hook edit' will ever=
 materialize.
    +
    +    Hopefully this reflects reality now; please review accordingly.
    +
    +    Since v4, addressed comments from Jonathan Tan about wording. Howe=
ver, I have
    +    not addressed AEvar's comments or done a full re-review of this do=
cument.
    +    I wanted to get the rest of the series out for initial review firs=
t.
    +
    +     - Emily
    +
    +    Since v4, addressed comments from Jonathan Tan about wording.
    +
      ## Documentation/Makefile ##
     @@ Documentation/Makefile: SP_ARTICLES +=3D $(API_DOCS)
      TECH_DOCS +=3D MyFirstContribution
 2:  1d19f1477c <  -:  ---------- hook: scaffolding for git-hook subcommand
 3:  c125c63880 !  2:  112a809f02 hook: add list command
    @@ Metadata
     Author: Emily Shaffer <emilyshaffer@google.com>
    =20
      ## Commit message ##
    -    hook: add list command
    +    hook: introduce git-hook subcommand
    =20
    -    Teach 'git hook list <hookname>', which checks the known configs i=
n
    +    Add a new subcommand, git-hook, which will be used to ease config-=
based
    +    hook management. This command will handle parsing configs to compo=
se a
    +    list of hooks to run for a given event, as well as adding or modif=
ying
    +    hook configs in an interactive fashion.
    +
    +    Start with 'git hook list <hookname>', which checks the known conf=
igs in
         order to create an ordered list of hooks to run on a given hook ev=
ent.
    =20
         Multiple commands can be specified for a given hook by providing
    @@ Commit message
    =20
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    =20
    +
    + ## Notes ##
    +    Since v4, mainly changed to RUN_SETUP_GENTLY so that 'git hook lis=
t' can
    +    be executed outside of a repo.
    +
    + ## .gitignore ##
    +@@
    + /git-grep
    + /git-hash-object
    + /git-help
    ++/git-hook
    + /git-http-backend
    + /git-http-fetch
    + /git-http-push
    +
      ## Documentation/config/hook.txt (new) ##
     @@
     +hook.<command>.command::
    @@ Documentation/config/hook.txt (new)
     +	as a command. This can be an executable on your device or a oneliner=
 for
     +	your shell. See linkgit:git-hook[1].
    =20
    - ## Documentation/git-hook.txt ##
    -@@ Documentation/git-hook.txt: git-hook - Manage configured hooks
    - SYNOPSIS
    - --------
    - [verse]
    --'git hook'
    + ## Documentation/git-hook.txt (new) ##
    +@@
    ++git-hook(1)
    ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    ++
    ++NAME
    ++----
    ++git-hook - Manage configured hooks
    ++
    ++SYNOPSIS
    ++--------
    ++[verse]
     +'git hook' list <hook-name>
    -=20
    - DESCRIPTION
    - -----------
    --A placeholder command. Later, you will be able to list, add, and modi=
fy hooks
    --with this command.
    ++
    ++DESCRIPTION
    ++-----------
     +You can list configured hooks with this command. Later, you will be a=
ble to run,
     +add, and modify hooks with this command.
     +
    @@ Documentation/git-hook.txt: git-hook - Manage configured hooks
     +CONFIGURATION
     +-------------
     +include::config/hook.txt[]
    -=20
    - GIT
    - ---
    ++
    ++GIT
    ++---
    ++Part of the linkgit:git[1] suite
    =20
      ## Makefile ##
     @@ Makefile: LIB_OBJS +=3D hash-lookup.o
    @@ Makefile: LIB_OBJS +=3D hash-lookup.o
      LIB_OBJS +=3D ident.o
      LIB_OBJS +=3D json-writer.o
      LIB_OBJS +=3D kwset.o
    +@@ Makefile: BUILTIN_OBJS +=3D builtin/get-tar-commit-id.o
    + BUILTIN_OBJS +=3D builtin/grep.o
    + BUILTIN_OBJS +=3D builtin/hash-object.o
    + BUILTIN_OBJS +=3D builtin/help.o
    ++BUILTIN_OBJS +=3D builtin/hook.o
    + BUILTIN_OBJS +=3D builtin/index-pack.o
    + BUILTIN_OBJS +=3D builtin/init-db.o
    + BUILTIN_OBJS +=3D builtin/interpret-trailers.o
    =20
    - ## builtin/hook.c ##
    + ## builtin.h ##
    +@@ builtin.h: int cmd_get_tar_commit_id(int argc, const char **argv, c=
onst char *prefix);
    + int cmd_grep(int argc, const char **argv, const char *prefix);
    + int cmd_hash_object(int argc, const char **argv, const char *prefix);
    + int cmd_help(int argc, const char **argv, const char *prefix);
    ++int cmd_hook(int argc, const char **argv, const char *prefix);
    + int cmd_index_pack(int argc, const char **argv, const char *prefix);
    + int cmd_init_db(int argc, const char **argv, const char *prefix);
    + int cmd_interpret_trailers(int argc, const char **argv, const char *p=
refix);
    +
    + ## builtin/hook.c (new) ##
     @@
    - #include "cache.h"
    --
    - #include "builtin.h"
    ++#include "cache.h"
    ++#include "builtin.h"
     +#include "config.h"
     +#include "hook.h"
    - #include "parse-options.h"
    ++#include "parse-options.h"
     +#include "strbuf.h"
    -=20
    - static const char * const builtin_hook_usage[] =3D {
    --	N_("git hook"),
    ++
    ++static const char * const builtin_hook_usage[] =3D {
     +	N_("git hook list <hookname>"),
    - 	NULL
    - };
    -=20
    --int cmd_hook(int argc, const char **argv, const char *prefix)
    ++	NULL
    ++};
    ++
     +static int list(int argc, const char **argv, const char *prefix)
    - {
    --	struct option builtin_hook_options[] =3D {
    ++{
     +	struct list_head *head, *pos;
    -+	struct strbuf hookname =3D STRBUF_INIT;
    ++	const char *hookname =3D NULL;
     +
     +	struct option list_options[] =3D {
    - 		OPT_END(),
    - 	};
    -=20
    --	argc =3D parse_options(argc, argv, prefix, builtin_hook_options,
    ++		OPT_END(),
    ++	};
    ++
     +	argc =3D parse_options(argc, argv, prefix, list_options,
    - 			     builtin_hook_usage, 0);
    -=20
    ++			     builtin_hook_usage, 0);
    ++
     +	if (argc < 1) {
     +		usage_msg_opt(_("You must specify a hook event name to list."),
     +			      builtin_hook_usage, list_options);
     +	}
     +
    -+	strbuf_addstr(&hookname, argv[0]);
    ++	hookname =3D argv[0];
     +
    -+	head =3D hook_list(&hookname);
    ++	head =3D hook_list(hookname);
     +
     +	if (list_empty(head)) {
     +		printf(_("no commands configured for hook '%s'\n"),
    -+		       hookname.buf);
    -+		strbuf_release(&hookname);
    ++		       hookname);
     +		return 0;
     +	}
     +
    @@ builtin/hook.c
     +	}
     +
     +	clear_hook_list(head);
    -+	strbuf_release(&hookname);
     +
    - 	return 0;
    - }
    ++	return 0;
    ++}
     +
     +int cmd_hook(int argc, const char **argv, const char *prefix)
     +{
    @@ builtin/hook.c
     +	usage_with_options(builtin_hook_usage, builtin_hook_options);
     +}
    =20
    + ## command-list.txt ##
    +@@ command-list.txt: git-grep                                mainporce=
lain           info
    + git-gui                                 mainporcelain
    + git-hash-object                         plumbingmanipulators
    + git-help                                ancillaryinterrogators       =
   complete
    ++git-hook                                mainporcelain
    + git-http-backend                        synchingrepositories
    + git-http-fetch                          synchelpers
    + git-http-push                           synchelpers
    +
    + ## git.c ##
    +@@ git.c: static struct cmd_struct commands[] =3D {
    + 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
    + 	{ "hash-object", cmd_hash_object },
    + 	{ "help", cmd_help },
    ++	{ "hook", cmd_hook, RUN_SETUP_GENTLY },
    + 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
    + 	{ "init", cmd_init_db },
    + 	{ "init-db", cmd_init_db },
    +
      ## hook.c (new) ##
     @@
     +#include "cache.h"
    @@ hook.c (new)
     +	return 0;
     +}
     +
    -+struct list_head* hook_list(const struct strbuf* hookname)
    ++struct list_head* hook_list(const char* hookname)
     +{
     +	struct strbuf hook_key =3D STRBUF_INIT;
     +	struct list_head *hook_head =3D xmalloc(sizeof(struct list_head));
    @@ hook.c (new)
     +	if (!hookname)
     +		return NULL;
     +
    -+	strbuf_addf(&hook_key, "hook.%s.command", hookname->buf);
    ++	strbuf_addf(&hook_key, "hook.%s.command", hookname);
     +
     +	git_config(hook_config_lookup, &cb_data);
     +
    @@ hook.h (new)
     + * Provides a linked list of 'struct hook' detailing commands which s=
hould run
     + * in response to the 'hookname' event, in execution order.
     + */
    -+struct list_head* hook_list(const struct strbuf *hookname);
    ++struct list_head* hook_list(const char *hookname);
     +
     +/* Free memory associated with a 'struct hook' */
     +void free_hook(struct hook *ptr);
     +/* Empties the list at 'head', calling 'free_hook()' on each entry */
     +void clear_hook_list(struct list_head *head);
    =20
    - ## t/t1360-config-based-hooks.sh ##
    -@@ t/t1360-config-based-hooks.sh: test_description=3D'config-managed m=
ultihooks, including git-hook command'
    -=20
    - . ./test-lib.sh
    -=20
    --test_expect_success 'git hook command does not crash' '
    --	git hook
    + ## t/t1360-config-based-hooks.sh (new) ##
    +@@
    ++#!/bin/bash
    ++
    ++test_description=3D'config-managed multihooks, including git-hook com=
mand'
    ++
    ++. ./test-lib.sh
    ++
     +ROOT=3D
     +if test_have_prereq MINGW
     +then
    @@ t/t1360-config-based-hooks.sh: test_description=3D'config-managed mu=
ltihooks, incl
     +
     +	git hook list pre-commit >actual &&
     +	test_cmp expected actual
    - '
    -=20
    - test_done
    ++'
    ++
    ++test_done
 4:  0b8cd46ff9 !  3:  3114306368 hook: include hookdir hook in list
    @@ builtin/hook.c: static int list(int argc, const char **argv, const c=
har *prefix)
      	list_for_each(pos, head) {
      		struct hook *item =3D list_entry(pos, struct hook, list);
     -		if (item)
    +-			printf("%s: %s\n",
    +-			       config_scope_name(item->origin),
     +		item =3D list_entry(pos, struct hook, list);
     +		if (item) {
    -+			/* Don't translate 'hookdir' - it matches the config */
    - 			printf("%s: %s\n",
    --			       config_scope_name(item->origin),
    ++			/*
    ++			 * TRANSLATORS: "<config scope>: <path>". Both fields
    ++			 * should be left untranslated; config scope matches the
    ++			 * output of 'git config --show-scope'. Marked for
    ++			 * translation to provide better RTL support later.
    ++			 */
    ++			printf(_("%s: %s\n"),
     +			       (item->from_hookdir
     +				? "hookdir"
     +				: config_scope_name(item->origin)),
    @@ hook.c: static void append_or_move_hook(struct list_head *head, cons=
t char *comm
      	}
     =20
      	/* re-set the scope so we show where an override was specified */
    -@@ hook.c: struct list_head* hook_list(const struct strbuf* hookname)
    +@@ hook.c: struct list_head* hook_list(const char* hookname)
     =20
      	git_config(hook_config_lookup, &cb_data);
     =20
     +	if (have_git_dir()) {
    -+		const char *legacy_hook_path =3D find_hook(hookname->buf);
    ++		const char *legacy_hook_path =3D find_hook(hookname);
     +
     +		/* Unconditionally add legacy hook, but annotate it. */
     +		if (legacy_hook_path) {
 5:  05c503fbe1 !  4:  681013c32a hook: teach hook.runHookDir
    @@ Commit message
         list'. Later on, though, we will pay attention to this enum when r=
unning
         the hooks.
    =20
    +
    + ## Notes ##
    +    Since v7, tidied up the behavior of the HOOK_UNKNOWN flag and adde=
d a test to
    +    enforce it - now it matches the design doc much better.
    +
    +    Also, thanks Jonathan Tan for pointing out that the commit message=
 made no sense
    +    and was targeted for a different change. Rewrote the commit messag=
e now.
    +
    +    Plus, added HOOK_ERROR flag per Junio and Jonathan Nieder.
    +
    +    Newly split into its own commit since v4, and taking place much so=
oner.
    +
    +    An unfortunate side effect of adding this support *before* the
    +    hook.runHookDir support is that the labels on the list are not cle=
ar -
    +    because we aren't yet flagging which hooks are from the hookdir ve=
rsus
    +    the config. I suppose we could move the addition of that field to =
the
    +    struct hook up to this patch, but it didn't make a lot of sense to=
 me to
    +    do it just for cosmetic purposes.
    +
    +    Since v7, tidied up the behavior of the HOOK_UNKNOWN flag and adde=
d a test to
    +    enforce it - now it matches the design doc much better.
    +
    +    Also, thanks Jonathan Tan for pointing out that the commit message=
 made no sense
    +    and was targeted for a different change. Rewrote the commit messag=
e now.
    +
    +    Newly split into its own commit since v4, and taking place much so=
oner.
    +
    +    An unfortunate side effect of adding this support *before* the
    +    hook.runHookDir support is that the labels on the list are not cle=
ar -
    +    because we aren't yet flagging which hooks are from the hookdir ve=
rsus
    +    the config. I suppose we could move the addition of that field to =
the
    +    struct hook up to this patch, but it didn't make a lot of sense to=
 me to
    +    do it just for cosmetic purposes.
    +
      ## Documentation/config/hook.txt ##
     @@ Documentation/config/hook.txt: hookcmd.<name>.command::
      	A command to execute during a hook for which <name> has been specifi=
ed
    @@ builtin/hook.c: static const char * const builtin_hook_usage[] =3D {
      static int list(int argc, const char **argv, const char *prefix)
      {
      	struct list_head *head, *pos;
    - 	struct strbuf hookname =3D STRBUF_INIT;
    + 	const char *hookname =3D NULL;
     +	struct strbuf hookdir_annotation =3D STRBUF_INIT;
     =20
      	struct option list_options[] =3D {
      		OPT_END(),
     @@ builtin/hook.c: static int list(int argc, const char **argv, const =
char *prefix)
    - 		return 0;
    - 	}
    -=20
    -+	switch (should_run_hookdir) {
    -+		case HOOKDIR_NO:
    -+			strbuf_addstr(&hookdir_annotation, _(" (will not run)"));
    -+			break;
    -+		case HOOKDIR_ERROR:
    -+			strbuf_addstr(&hookdir_annotation, _(" (will error and not run)"))=
;
    -+			break;
    -+		case HOOKDIR_INTERACTIVE:
    -+			strbuf_addstr(&hookdir_annotation, _(" (will prompt)"));
    -+			break;
    -+		case HOOKDIR_WARN:
    -+			strbuf_addstr(&hookdir_annotation, _(" (will warn but run)"));
    -+			break;
    -+		case HOOKDIR_YES:
    -+		/*
    -+		 * The default behavior should agree with
    -+		 * hook.c:configured_hookdir_opt(). HOOKDIR_UNKNOWN should just
    -+		 * do the default behavior.
    -+		 */
    -+		case HOOKDIR_UNKNOWN:
    -+		default:
    -+			break;
    -+	}
    -+
    - 	list_for_each(pos, head) {
      		struct hook *item =3D list_entry(pos, struct hook, list);
      		item =3D list_entry(pos, struct hook, list);
      		if (item) {
    - 			/* Don't translate 'hookdir' - it matches the config */
    --			printf("%s: %s\n",
    -+			printf("%s: %s%s\n",
    - 			       (item->from_hookdir
    - 				? "hookdir"
    - 				: config_scope_name(item->origin)),
    +-			/*
    +-			 * TRANSLATORS: "<config scope>: <path>". Both fields
    +-			 * should be left untranslated; config scope matches the
    +-			 * output of 'git config --show-scope'. Marked for
    +-			 * translation to provide better RTL support later.
    +-			 */
    +-			printf(_("%s: %s\n"),
    +-			       (item->from_hookdir
    +-				? "hookdir"
    +-				: config_scope_name(item->origin)),
     -			       item->command.buf);
    -+			       item->command.buf,
    -+			       (item->from_hookdir
    -+				? hookdir_annotation.buf
    -+				: ""));
    ++			if (item->from_hookdir) {
    ++				/*
    ++				 * TRANSLATORS: do not translate 'hookdir' as
    ++				 * it matches the config setting.
    ++				 */
    ++				switch (should_run_hookdir) {
    ++				case HOOKDIR_NO:
    ++					printf(_("hookdir: %s (will not run)\n"),
    ++					       item->command.buf);
    ++					break;
    ++				case HOOKDIR_ERROR:
    ++					printf(_("hookdir: %s (will error and not run)\n"),
    ++					       item->command.buf);
    ++					break;
    ++				case HOOKDIR_INTERACTIVE:
    ++					printf(_("hookdir: %s (will prompt)\n"),
    ++					       item->command.buf);
    ++					break;
    ++				case HOOKDIR_WARN:
    ++					printf(_("hookdir: %s (will warn but run)\n"),
    ++					       item->command.buf);
    ++					break;
    ++				case HOOKDIR_YES:
    ++				/*
    ++				 * The default behavior should agree with
    ++				 * hook.c:configured_hookdir_opt(). HOOKDIR_UNKNOWN should just
    ++				 * do the default behavior.
    ++				 */
    ++				case HOOKDIR_UNKNOWN:
    ++				default:
    ++					printf(_("hookdir: %s\n"),
    ++						 item->command.buf);
    ++					break;
    ++				}
    ++			} else {
    ++				/*
    ++				 * TRANSLATORS: "<config scope>: <path>". Both fields
    ++				 * should be left untranslated; config scope matches the
    ++				 * output of 'git config --show-scope'. Marked for
    ++				 * translation to provide better RTL support later.
    ++				 */
    ++				printf(_("%s: %s\n"),
    ++					config_scope_name(item->origin),
    ++					item->command.buf);
    ++			}
      		}
      	}
     =20
      	clear_hook_list(head);
     +	strbuf_release(&hookdir_annotation);
    - 	strbuf_release(&hookname);
     =20
      	return 0;
    -@@ builtin/hook.c: static int list(int argc, const char **argv, const =
char *prefix)
    + }
     =20
      int cmd_hook(int argc, const char **argv, const char *prefix)
      {
    @@ builtin/hook.c: static int list(int argc, const char **argv, const c=
har *prefix)
     +		else if (!strcmp(run_hookdir, "interactive"))
     +			should_run_hookdir =3D HOOKDIR_INTERACTIVE;
     +		else
    ++			/*
    ++			 * TRANSLATORS: leave "yes/warn/interactive/no"
    ++			 * untranslated; the strings are compared literally.
    ++			 */
     +			die(_("'%s' is not a valid option for --run-hookdir "
     +			      "(yes, warn, interactive, no)"), run_hookdir);
     +	else
    @@ hook.c: static int hook_config_lookup(const char *key, const char *v=
alue, void *
     +	return HOOKDIR_UNKNOWN;
     +}
     +
    - struct list_head* hook_list(const struct strbuf* hookname)
    + struct list_head* hook_list(const char* hookname)
      {
      	struct strbuf hook_key =3D STRBUF_INIT;
    =20
      ## hook.h ##
     @@ hook.h: struct hook {
       */
    - struct list_head* hook_list(const struct strbuf *hookname);
    + struct list_head* hook_list(const char *hookname);
     =20
     +enum hookdir_opt
     +{
    @@ hook.h: struct hook {
     + * command line arguments.
     + */
     +enum hookdir_opt configured_hookdir_opt(void);
    ++
    ++/*
    ++ * Provides the hookdir_opt specified in the config without consultin=
g any
    ++ * command line arguments.
    ++ */
    ++enum hookdir_opt configured_hookdir_opt(void);
     +
      /* Free memory associated with a 'struct hook' */
      void free_hook(struct hook *ptr);
    @@ t/t1360-config-based-hooks.sh: test_expect_success 'git hook list sh=
ows hooks fr
     +
     +	git hook list pre-commit >actual &&
     +	# the hookdir annotation is translated
    -+	test_i18ncmp expected actual
    ++	test_cmp expected actual
     +'
     +
     +test_expect_success 'hook.runHookDir =3D error is respected by list' =
'
    @@ t/t1360-config-based-hooks.sh: test_expect_success 'git hook list sh=
ows hooks fr
     +
     +	git hook list pre-commit >actual &&
     +	# the hookdir annotation is translated
    -+	test_i18ncmp expected actual
    ++	test_cmp expected actual
     +'
     +
     +test_expect_success 'hook.runHookDir =3D warn is respected by list' '
    @@ t/t1360-config-based-hooks.sh: test_expect_success 'git hook list sh=
ows hooks fr
     +
     +	git hook list pre-commit >actual &&
     +	# the hookdir annotation is translated
    -+	test_i18ncmp expected actual
    ++	test_cmp expected actual
     +'
     +
     +
    @@ t/t1360-config-based-hooks.sh: test_expect_success 'git hook list sh=
ows hooks fr
     +
     +	git hook list pre-commit >actual &&
     +	# the hookdir annotation is translated
    -+	test_i18ncmp expected actual
    ++	test_cmp expected actual
     +'
     +
     +test_expect_success 'hook.runHookDir is tolerant to unknown values' '
    @@ t/t1360-config-based-hooks.sh: test_expect_success 'git hook list sh=
ows hooks fr
     +
     +	git hook list pre-commit >actual &&
     +	# the hookdir annotation is translated
    -+	test_i18ncmp expected actual
    ++	test_cmp expected actual
     +'
     +
      test_done
 6:  e86025853a !  5:  0a4b9f27b3 hook: implement hookcmd.<name>.skip
    @@ hook.c: static int hook_config_lookup(const char *key, const char *v=
alue, void *
    =20
      ## t/t1360-config-based-hooks.sh ##
     @@ t/t1360-config-based-hooks.sh: test_expect_success 'hook.runHookDir=
 =3D warn is respected by list' '
    - 	test_i18ncmp expected actual
    + 	test_cmp expected actual
      '
     =20
     +test_expect_success 'git hook list removes skipped hookcmd' '
    @@ t/t1360-config-based-hooks.sh: test_expect_success 'hook.runHookDir =
=3D warn is re
     +	EOF
     +
     +	git hook list pre-commit >actual &&
    -+	test_i18ncmp expected actual
    ++	test_cmp expected actual
     +'
     +
     +test_expect_success 'git hook list ignores skip referring to unused h=
ookcmd' '
    @@ t/t1360-config-based-hooks.sh: test_expect_success 'hook.runHookDir =
=3D warn is re
     +	EOF
     +
     +	git hook list pre-commit >actual &&
    -+	test_i18ncmp expected actual
    ++	test_cmp expected actual
     +'
     +
     +test_expect_success 'git hook list removes skipped inlined hook' '
 7:  6e10593d75 !  6:  2ad4f44d08 parse-options: parse into strvec
    @@ Commit message
    =20
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    =20
    +
    + ## Notes ##
    +    Since v7, updated the reference doc to make the intended usage for=
 OPT_STRVEC
    +    more clear.
    +
    +    Since v4, fixed one or two more places where I missed the argv_arr=
ay->strvec
    +    rename.
    +
      ## Documentation/technical/api-parse-options.txt ##
     @@ Documentation/technical/api-parse-options.txt: There are some macro=
s to easily define options:
      	The string argument is stored as an element in `string_list`.
    @@ parse-options.h: int parse_opt_commits(const struct option *, const =
char *, int)
      int parse_opt_noop_cb(const struct option *, const char *, int);
      enum parse_opt_result parse_opt_unknown_cb(struct parse_opt_ctx_t *ct=
x,
      					   const struct option *,
    +
    + ## t/helper/test-parse-options.c ##
    +@@
    + #include "cache.h"
    + #include "parse-options.h"
    + #include "string-list.h"
    ++#include "strvec.h"
    + #include "trace2.h"
    +=20
    + static int boolean =3D 0;
    +@@ t/helper/test-parse-options.c: static char *string =3D NULL;
    + static char *file =3D NULL;
    + static int ambiguous;
    + static struct string_list list =3D STRING_LIST_INIT_NODUP;
    ++static struct strvec vector =3D STRVEC_INIT;
    +=20
    + static struct {
    + 	int called;
    +@@ t/helper/test-parse-options.c: int cmd__parse_options(int argc, con=
st char **argv)
    + 		OPT_STRING('o', NULL, &string, "str", "get another string"),
    + 		OPT_NOOP_NOARG(0, "obsolete"),
    + 		OPT_STRING_LIST(0, "list", &list, "str", "add str to list"),
    ++		OPT_STRVEC(0, "vector", &vector, "str", "add str to strvec"),
    + 		OPT_GROUP("Magic arguments"),
    + 		OPT_ARGUMENT("quux", NULL, "means --quux"),
    + 		OPT_NUMBER_CALLBACK(&integer, "set integer to NUM",
    +@@ t/helper/test-parse-options.c: int cmd__parse_options(int argc, con=
st char **argv)
    + 	for (i =3D 0; i < list.nr; i++)
    + 		show(&expect, &ret, "list: %s", list.items[i].string);
    +=20
    ++	for (i =3D 0; i < vector.nr; i++)
    ++		show(&expect, &ret, "vector: %s", vector.v[i]);
    ++
    + 	for (i =3D 0; i < argc; i++)
    + 		show(&expect, &ret, "arg %02d: %s", i, argv[i]);
    +=20
    +
    + ## t/t0040-parse-options.sh ##
    +@@ t/t0040-parse-options.sh: String options
    +     --st <st>             get another string (pervert ordering)
    +     -o <str>              get another string
    +     --list <str>          add str to list
    ++    --vector <str>        add str to strvec
    +=20
    + Magic arguments
    +     --quux                means --quux
    +@@ t/t0040-parse-options.sh: test_expect_success '--no-list resets lis=
t' '
    + 	test_cmp expect output
    + '
    +=20
    ++cat >expect <<\EOF
    ++boolean: 0
    ++integer: 0
    ++magnitude: 0
    ++timestamp: 0
    ++string: (not set)
    ++abbrev: 7
    ++verbose: -1
    ++quiet: 0
    ++dry run: no
    ++file: (not set)
    ++vector: foo
    ++vector: bar
    ++vector: baz
    ++EOF
    ++test_expect_success '--vector keeps list of strings' '
    ++	test-tool parse-options --vector foo --vector=3Dbar --vector=3Dbaz >=
output &&
    ++	test_cmp expect output
    ++'
    ++
    ++test_expect_success '--no-vector resets list' '
    ++	test-tool parse-options --vector=3Dother --vector=3Dirrelevant --vec=
tor=3Doptions \
    ++		--no-vector --vector=3Dfoo --vector=3Dbar --vector=3Dbaz >output &&
    ++	test_cmp expect output
    ++'
    ++
    + test_expect_success 'multiple quiet levels' '
    + 	test-tool parse-options --expect=3D"quiet: 3" -q -q -q
    + '
 8:  0dc9284057 !  7:  27dd8e3edf hook: add 'run' subcommand
    @@ Commit message
    =20
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    =20
    +
    + ## Notes ##
    +    Since v7, added support for "error" hook.runHookDir setting.
    +
    +    Since v4, updated the docs, and did less local application of sing=
le
    +    quotes. In order for hookdir hooks to run successfully with a spac=
e in
    +    the path, though, they must not be run with 'sh -c'. So we can tre=
at the
    +    hookdir hooks specially, and warn users via doc about special
    +    considerations for configured hooks with spaces in their path.
    +
      ## Documentation/git-hook.txt ##
     @@ Documentation/git-hook.txt: SYNOPSIS
      --------
    @@ hook.c
     =20
      void free_hook(struct hook *ptr)
      {
    +-	if (ptr) {
    ++	if (ptr)
    + 		strbuf_release(&ptr->command);
    +-		free(ptr);
    +-	}
    ++	free(ptr);
    + }
    +=20
    + static struct hook * find_hook_by_command(struct list_head *head, con=
st char *command)
     @@ hook.c: enum hookdir_opt configured_hookdir_opt(void)
      	return HOOKDIR_UNKNOWN;
      }
    @@ hook.c: enum hookdir_opt configured_hookdir_opt(void)
     +
     +	switch (cfg)
     +	{
    -+		case HOOKDIR_ERROR:
    -+			fprintf(stderr, _("Skipping legacy hook at '%s'\n"),
    -+				path);
    -+			/* FALLTHROUGH */
    -+		case HOOKDIR_NO:
    -+			return 0;
    -+		case HOOKDIR_WARN:
    -+			fprintf(stderr, _("Running legacy hook at '%s'\n"),
    -+				path);
    -+			return 1;
    -+		case HOOKDIR_INTERACTIVE:
    -+			do {
    -+				/*
    -+				 * TRANSLATORS: Make sure to include [Y] and [n]
    -+				 * in your translation. Only English input is
    -+				 * accepted. Default option is "yes".
    -+				 */
    -+				fprintf(stderr, _("Run '%s'? [Yn] "), path);
    -+				git_read_line_interactively(&prompt);
    -+				strbuf_tolower(&prompt);
    -+				if (starts_with(prompt.buf, "n")) {
    -+					strbuf_release(&prompt);
    -+					return 0;
    -+				} else if (starts_with(prompt.buf, "y")) {
    -+					strbuf_release(&prompt);
    -+					return 1;
    -+				}
    -+				/* otherwise, we didn't understand the input */
    -+			} while (prompt.len); /* an empty reply means "Yes" */
    -+			strbuf_release(&prompt);
    -+			return 1;
    -+		/*
    -+		 * HOOKDIR_UNKNOWN should match the default behavior, but let's
    -+		 * give a heads up to the user.
    -+		 */
    -+		case HOOKDIR_UNKNOWN:
    -+			fprintf(stderr,
    -+				_("Unrecognized value for 'hook.runHookDir'. "
    -+				  "Is there a typo? "));
    -+			/* FALLTHROUGH */
    -+		case HOOKDIR_YES:
    -+		default:
    -+			return 1;
    ++	case HOOKDIR_ERROR:
    ++		fprintf(stderr, _("Skipping legacy hook at '%s'\n"),
    ++			path);
    ++		/* FALLTHROUGH */
    ++	case HOOKDIR_NO:
    ++		return 0;
    ++	case HOOKDIR_WARN:
    ++		fprintf(stderr, _("Running legacy hook at '%s'\n"),
    ++			path);
    ++		return 1;
    ++	case HOOKDIR_INTERACTIVE:
    ++		do {
    ++			/*
    ++			 * TRANSLATORS: Make sure to include [Y] and [n]
    ++			 * in your translation. Only English input is
    ++			 * accepted. Default option is "yes".
    ++			 */
    ++			fprintf(stderr, _("Run '%s'? [Y/n] "), path);
    ++			git_read_line_interactively(&prompt);
    ++			/*
    ++			 * In case of prompt =3D '' - that is, user hit enter,
    ++			 * saying "yes I want the default" - strncasecmp will
    ++			 * return 0 regardless. So list the default first.
    ++			 *
    ++			 * Case insensitively, accept "y", "ye", or "yes" as
    ++			 * "yes"; accept "n" or "no" as "no".
    ++			 */
    ++			if (!strncasecmp(prompt.buf, "yes", prompt.len)) {
    ++				strbuf_release(&prompt);
    ++				return 1;
    ++			} else if (!strncasecmp(prompt.buf, "no", prompt.len)) {
    ++				strbuf_release(&prompt);
    ++				return 0;
    ++			}
    ++			/* otherwise, we didn't understand the input */
    ++		} while (prompt.len); /* an empty reply means default (yes) */
    ++		return 1;
    ++	/*
    ++	 * HOOKDIR_UNKNOWN should match the default behavior, but let's
    ++	 * give a heads up to the user.
    ++	 */
    ++	case HOOKDIR_UNKNOWN:
    ++		fprintf(stderr,
    ++			_("Unrecognized value for 'hook.runHookDir'. "
    ++			  "Is there a typo? "));
    ++		/* FALLTHROUGH */
    ++	case HOOKDIR_YES:
    ++	default:
    ++		return 1;
     +	}
     +}
     +
    - struct list_head* hook_list(const struct strbuf* hookname)
    + struct list_head* hook_list(const char* hookname)
      {
      	struct strbuf hook_key =3D STRBUF_INIT;
    -@@ hook.c: struct list_head* hook_list(const struct strbuf* hookname)
    +@@ hook.c: struct list_head* hook_list(const char* hookname)
      	strbuf_release(&hook_key);
      	return hook_head;
      }
    @@ hook.c: struct list_head* hook_list(const struct strbuf* hookname)
     +	strvec_clear(&o->args);
     +}
     +
    -+static void prepare_hook_cp(struct hook *hook, struct run_hooks_opt *=
options,
    ++static void prepare_hook_cp(const char *hookname, struct hook *hook,
    ++			    struct run_hooks_opt *options,
     +			    struct child_process *cp)
     +{
     +	if (!hook)
    @@ hook.c: struct list_head* hook_list(const struct strbuf* hookname)
     +	cp->no_stdin =3D 1;
     +	cp->env =3D options->env.v;
     +	cp->stdout_to_stderr =3D 1;
    -+	cp->trace2_hook_name =3D hook->command.buf;
    ++	cp->trace2_hook_name =3D hookname;
     +
     +	/*
     +	 * Commands from the config could be oneliners, but we know
    @@ hook.c: struct list_head* hook_list(const struct strbuf* hookname)
     +
     +int run_hooks(const char *hookname, struct run_hooks_opt *options)
     +{
    -+	struct strbuf hookname_str =3D STRBUF_INIT;
     +	struct list_head *to_run, *pos =3D NULL, *tmp =3D NULL;
     +	int rc =3D 0;
     +
     +	if (!options)
     +		BUG("a struct run_hooks_opt must be provided to run_hooks");
     +
    -+	strbuf_addstr(&hookname_str, hookname);
    -+
    -+	to_run =3D hook_list(&hookname_str);
    ++	to_run =3D hook_list(hookname);
     +
     +	list_for_each_safe(pos, tmp, to_run) {
     +		struct child_process hook_proc =3D CHILD_PROCESS_INIT;
    @@ hook.c: struct list_head* hook_list(const struct strbuf* hookname)
     +		    !should_include_hookdir(hook->command.buf, options->run_hookdir=
))
     +			continue;
     +
    -+		prepare_hook_cp(hook, options, &hook_proc);
    ++		prepare_hook_cp(hookname, hook, options, &hook_proc);
     +
     +		rc |=3D run_command(&hook_proc);
     +	}
    @@ hook.h: enum hookdir_opt
     +void run_hooks_opt_init(struct run_hooks_opt *o);
     +void run_hooks_opt_clear(struct run_hooks_opt *o);
     +
    -+/*
    + /*
    +- * Provides the hookdir_opt specified in the config without consultin=
g any
    +- * command line arguments.
     + * Runs all hooks associated to the 'hookname' event in order. Each h=
ook will be
     + * passed 'env' and 'args'.
    -+ */
    +  */
    +-enum hookdir_opt configured_hookdir_opt(void);
     +int run_hooks(const char *hookname, struct run_hooks_opt *options);
    -+
    +=20
      /* Free memory associated with a 'struct hook' */
      void free_hook(struct hook *ptr);
    - /* Empties the list at 'head', calling 'free_hook()' on each entry */
    =20
      ## t/t1360-config-based-hooks.sh ##
     @@ t/t1360-config-based-hooks.sh: test_expect_success 'hook.runHookDir=
 =3D no is respected by list' '
     =20
      	git hook list pre-commit >actual &&
      	# the hookdir annotation is translated
    --	test_i18ncmp expected actual
    -+	test_i18ncmp expected actual &&
    +-	test_cmp expected actual
    ++	test_cmp expected actual &&
     +
     +	git hook run pre-commit 2>actual &&
     +	test_must_be_empty actual
    @@ t/t1360-config-based-hooks.sh: test_expect_success 'hook.runHookDir =
=3D error is r
     =20
      	git hook list pre-commit >actual &&
      	# the hookdir annotation is translated
    -+	test_i18ncmp expected actual &&
    ++	test_cmp expected actual &&
     +
     +	cat >expected <<-EOF &&
     +	Skipping legacy hook at '\''$(pwd)/.git/hooks/pre-commit'\''
     +	EOF
     +
     +	git hook run pre-commit 2>actual &&
    - 	test_i18ncmp expected actual
    + 	test_cmp expected actual
      '
     =20
     @@ t/t1360-config-based-hooks.sh: test_expect_success 'hook.runHookDir=
 =3D warn is respected by list' '
     =20
      	git hook list pre-commit >actual &&
      	# the hookdir annotation is translated
    -+	test_i18ncmp expected actual &&
    ++	test_cmp expected actual &&
     +
     +	cat >expected <<-EOF &&
     +	Running legacy hook at '\''$(pwd)/.git/hooks/pre-commit'\''
    @@ t/t1360-config-based-hooks.sh: test_expect_success 'hook.runHookDir =
=3D warn is re
     +	EOF
     +
     +	git hook run pre-commit 2>actual &&
    - 	test_i18ncmp expected actual
    + 	test_cmp expected actual
      '
     =20
     @@ t/t1360-config-based-hooks.sh: test_expect_success 'git hook list r=
emoves skipped inlined hook' '
    @@ t/t1360-config-based-hooks.sh: test_expect_success 'hook.runHookDir =
=3D interactiv
     =20
      	git hook list pre-commit >actual &&
      	# the hookdir annotation is translated
    --	test_i18ncmp expected actual
    -+	test_i18ncmp expected actual &&
    ++	test_cmp expected actual &&
     +
     +	test_write_lines n | git hook run pre-commit 2>actual &&
     +	! grep "Legacy Hook" actual &&
    @@ t/t1360-config-based-hooks.sh: test_expect_success 'hook.runHookDir =
=3D interactiv
     +	test_cmp expected actual
     +'
     +
    ++test_expect_success 'git hook run can pass args and env vars' '
    ++	write_script sample-hook.sh <<-\EOF &&
    ++	echo $1
    ++	echo $2
    ++	echo $TEST_ENV_1
    ++	echo $TEST_ENV_2
    ++	EOF
    ++
    ++	test_config hook.pre-commit.command "\"$(pwd)/sample-hook.sh\"" &&
    ++
    ++	cat >expected <<-EOF &&
    ++	arg1
    ++	arg2
    ++	env1
    ++	env2
    ++	EOF
    ++
    ++	git hook run --arg arg1 \
    ++		--env TEST_ENV_1=3Denv1 \
    ++		-a arg2 \
    ++		-e TEST_ENV_2=3Denv2 \
    ++		pre-commit 2>actual &&
    ++
    + 	test_cmp expected actual
    + '
    +=20
     +test_expect_success 'hookdir hook included in git hook run' '
     +	setup_hookdir &&
     +
    @@ t/t1360-config-based-hooks.sh: test_expect_success 'hook.runHookDir =
=3D interactiv
     +	setup_hooks &&
     +
     +	nongit test_must_fail git hook run pre-commit
    - '
    -=20
    ++'
    ++
      test_expect_success 'hook.runHookDir is tolerant to unknown values' '
    + 	setup_hookdir &&
    +=20
 9:  92c67ed9da !  8:  46975c11c8 hook: introduce hook_exists()
    @@ hook.c: void run_hooks_opt_init(struct run_hooks_opt *o)
      	strvec_clear(&o->env);
    =20
      ## hook.h ##
    -@@ hook.h: struct list_head* hook_list(const struct strbuf *hookname);
    +@@ hook.h: struct list_head* hook_list(const char *hookname);
     =20
      enum hookdir_opt
      {
10:  9b3bb0b655 !  9:  e11f9e28a3 hook: support passing stdin to hooks
    @@ hook.c: void run_hooks_opt_init(struct run_hooks_opt *o)
      	o->run_hookdir =3D configured_hookdir_opt();
      }
     =20
    -@@ hook.c: static void prepare_hook_cp(struct hook *hook, struct run_h=
ooks_opt *options,
    +@@ hook.c: static void prepare_hook_cp(const char *hookname, struct ho=
ok *hook,
      	if (!hook)
      		return;
     =20
    @@ hook.c: static void prepare_hook_cp(struct hook *hook, struct run_ho=
oks_opt *opt
     +
      	cp->env =3D options->env.v;
      	cp->stdout_to_stderr =3D 1;
    - 	cp->trace2_hook_name =3D hook->command.buf;
    + 	cp->trace2_hook_name =3D hookname;
    =20
      ## hook.h ##
     @@ hook.h: struct run_hooks_opt
    @@ hook.h: int hook_exists(const char *hookname, enum hookdir_opt shoul=
d_run_hookdi
    =20
      ## t/t1360-config-based-hooks.sh ##
     @@ t/t1360-config-based-hooks.sh: test_expect_success 'hook.runHookDir=
 is tolerant to unknown values' '
    - 	test_i18ncmp expected actual
    + 	test_cmp expected actual
      '
     =20
     +test_expect_success 'stdin to multiple hooks' '
11:  9933985e78 =3D 10:  3ceb4156fd run-command: allow stdin for run_proces=
ses_parallel
12:  43caafe656 ! 11:  93a47f5242 hook: allow parallel hook execution
    @@ Commit message
    =20
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    =20
    +
    + ## Notes ##
    +    Per AEvar's request - parallel hook execution on day zero.
    +
    +    In most ways run_processes_parallel() worked great for me - but it=
 didn't
    +    have great support for hooks where we pipe to and from. I had to a=
dd this
    +    support later in the series.
    +
    +    Since I modified an existing and in-use library I'd appreciate a k=
een look on
    +    these patches.
    +
    +     - Emily
    +
      ## Documentation/config/hook.txt ##
     @@ Documentation/config/hook.txt: hook.runHookDir::
      	Controls how hooks contained in your hookdir are executed. Can be an=
y of
    @@ hook.c: enum hookdir_opt configured_hookdir_opt(void)
      static int should_include_hookdir(const char *path, enum hookdir_opt =
cfg)
      {
      	struct strbuf prompt =3D STRBUF_INIT;
    -@@ hook.c: struct list_head* hook_list(const struct strbuf* hookname)
    +@@ hook.c: struct list_head* hook_list(const char* hookname)
      	return hook_head;
      }
     =20
    @@ hook.c: void run_hooks_opt_clear(struct run_hooks_opt *o)
      	strvec_clear(&o->args);
      }
     =20
    --static void prepare_hook_cp(struct hook *hook, struct run_hooks_opt *=
options,
    +-static void prepare_hook_cp(const char *hookname, struct hook *hook,
    +-			    struct run_hooks_opt *options,
     -			    struct child_process *cp)
     +static int pick_next_hook(struct child_process *cp,
     +			  struct strbuf *out,
    @@ hook.c: void run_hooks_opt_clear(struct run_hooks_opt *o)
     -	cp->env =3D options->env.v;
     +	cp->env =3D hook_cb->options->env.v;
      	cp->stdout_to_stderr =3D 1;
    - 	cp->trace2_hook_name =3D hook->command.buf;
    +-	cp->trace2_hook_name =3D hookname;
    ++	cp->trace2_hook_name =3D hook_cb->hookname;
     =20
    -@@ hook.c: static void prepare_hook_cp(struct hook *hook, struct run_h=
ooks_opt *options,
    + 	/*
    + 	 * Commands from the config could be oneliners, but we know
    +@@ hook.c: static void prepare_hook_cp(const char *hookname, struct ho=
ok *hook,
      	 * add passed-in argv, without expanding - let the user get back
      	 * exactly what they put in
      	 */
    @@ hook.c: static void prepare_hook_cp(struct hook *hook, struct run_ho=
oks_opt *opt
     =20
      int run_hooks(const char *hookname, struct run_hooks_opt *options)
      {
    - 	struct strbuf hookname_str =3D STRBUF_INIT;
      	struct list_head *to_run, *pos =3D NULL, *tmp =3D NULL;
     -	int rc =3D 0;
    -+	struct hook_cb_data cb_data =3D { 0, NULL, NULL, options };
    ++	struct hook_cb_data cb_data =3D { 0, hookname, NULL, NULL, options }=
;
     =20
      	if (!options)
      		BUG("a struct run_hooks_opt must be provided to run_hooks");
     @@ hook.c: int run_hooks(const char *hookname, struct run_hooks_opt *o=
ptions)
    - 	to_run =3D hook_list(&hookname_str);
    + 	to_run =3D hook_list(hookname);
     =20
      	list_for_each_safe(pos, tmp, to_run) {
     -		struct child_process hook_proc =3D CHILD_PROCESS_INIT;
    @@ hook.c: int run_hooks(const char *hookname, struct run_hooks_opt *op=
tions)
     +	if (list_empty(to_run))
     +		return 0;
     =20
    --		prepare_hook_cp(hook, options, &hook_proc);
    +-		prepare_hook_cp(hookname, hook, options, &hook_proc);
     +	cb_data.head =3D to_run;
     +	cb_data.run_me =3D list_entry(to_run->next, struct hook, list);
     =20
    @@ hook.h: struct run_hooks_opt
     + */
     +struct hook_cb_data {
     +	int rc;
    ++	const char *hookname;
     +	struct list_head *head;
     +	struct hook *run_me;
     +	struct run_hooks_opt *options;
13:  2e189a7566 ! 12:  7f8c886d3f hook: allow specifying working directory =
for hooks
    @@ Commit message
    =20
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    =20
    +
    + ## Notes ##
    +    Needed later for "post-checkout" conversion.
    +
      ## hook.c ##
     @@ hook.c: void run_hooks_opt_init_sync(struct run_hooks_opt *o)
      	o->path_to_stdin =3D NULL;
    @@ hook.c: void run_hooks_opt_init_sync(struct run_hooks_opt *o)
     @@ hook.c: static int pick_next_hook(struct child_process *cp,
      	cp->env =3D hook_cb->options->env.v;
      	cp->stdout_to_stderr =3D 1;
    - 	cp->trace2_hook_name =3D hook->command.buf;
    + 	cp->trace2_hook_name =3D hook_cb->hookname;
     +	cp->dir =3D hook_cb->options->dir;
     =20
      	/*
14:  07899ad346 =3D 13:  8930baa9db run-command: add stdin callback for par=
allelization
15:  d3f18e433f ! 14:  d0f362591a hook: provide stdin by string_list or cal=
lback
    @@ Commit message
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    =20
      ## hook.c ##
    -@@ hook.c: void free_hook(struct hook *ptr)
    +@@
    +=20
    + void free_hook(struct hook *ptr)
      {
    - 	if (ptr) {
    +-	if (ptr)
    ++	if (ptr) {
      		strbuf_release(&ptr->command);
     +		free(ptr->feed_pipe_cb_data);
    - 		free(ptr);
    - 	}
    ++	}
    + 	free(ptr);
      }
    +=20
     @@ hook.c: static void append_or_move_hook(struct list_head *head, con=
st char *command)
      		strbuf_init(&to_add->command, 0);
      		strbuf_addstr(&to_add->command, command);
    @@ hook.c: int run_hooks(const char *hookname, struct run_hooks_opt *op=
tions)
     +	if (options->path_to_stdin && options->feed_pipe)
     +		BUG("choose only one method to populate stdin");
     +
    - 	strbuf_addstr(&hookname_str, hookname);
    + 	to_run =3D hook_list(hookname);
     =20
    - 	to_run =3D hook_list(&hookname_str);
    + 	list_for_each_safe(pos, tmp, to_run) {
     @@ hook.c: int run_hooks(const char *hookname, struct run_hooks_opt *o=
ptions)
      	run_processes_parallel_tr2(options->jobs,
      				   pick_next_hook,
16:  417c3f054e ! 15:  83bbb405a5 run-command: allow capturing of collated =
output
    @@ Commit message
    =20
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    =20
    +
    + ## Notes ##
    +    Originally when writing this patch I attempted to use a pipe in me=
mory -
    +    but managing its lifetime was actually pretty tricky, and I found =
I could
    +    achieve the same thing with less code by doing it this way. Critiq=
ue welcome,
    +    including "no, you really need to do it with a pipe".
    +
      ## builtin/fetch.c ##
     @@ builtin/fetch.c: static int fetch_multiple(struct string_list *list=
, int max_children)
      		result =3D run_processes_parallel_tr2(max_children,
17:  c0f3471bd1 ! 16:  73ed5de54c hooks: allow callers to capture output
    @@ Commit message
    =20
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    =20
    +
    + ## Notes ##
    +    You can see this in practice in the conversions for some of the pu=
sh hooks,
    +    like 'receive-pack'.
    +
      ## hook.c ##
     @@ hook.c: void run_hooks_opt_init_sync(struct run_hooks_opt *o)
      	o->dir =3D NULL;
18:  13446e4273 =3D 17:  900c4d8963 commit: use config-based hooks
19:  9380c43180 ! 18:  a562120e22 am: convert applypatch hooks to use confi=
g
    @@ builtin/am.c: static void am_destroy(const struct am_state *state)
      {
      	int ret;
     +	struct run_hooks_opt opt;
    ++
     +	run_hooks_opt_init_sync(&opt);
     =20
      	assert(state->msg);
    @@ builtin/am.c: static void do_commit(const struct am_state *state)
      	const char *reflog_msg, *author, *committer =3D NULL;
      	struct strbuf sb =3D STRBUF_INIT;
     +	struct run_hooks_opt hook_opt;
    ++
     +	run_hooks_opt_init_async(&hook_opt);
     =20
     -	if (run_hook_le(NULL, "pre-applypatch", NULL))
    -+	if (run_hooks("pre-applypatch", &hook_opt))
    ++	if (run_hooks("pre-applypatch", &hook_opt)) {
    ++		run_hooks_opt_clear(&hook_opt);
      		exit(1);
    ++	}
    ++
    ++	run_hooks_opt_clear(&hook_opt);
     =20
      	if (write_cache_as_tree(&tree, 0, NULL))
    + 		die(_("git write-tree failed to write a tree"));
     @@ builtin/am.c: static void do_commit(const struct am_state *state)
      		fclose(fp);
      	}
     =20
     -	run_hook_le(NULL, "post-applypatch", NULL);
    ++	run_hooks_opt_init_async(&hook_opt);
     +	run_hooks("post-applypatch", &hook_opt);
     =20
     +	run_hooks_opt_clear(&hook_opt);
20:  316a605606 ! 19:  e841ed4384 merge: use config-based hooks for post-me=
rge hook
    @@ builtin/merge.c: static void finish(struct commit *head_commit,
      	struct strbuf reflog_message =3D STRBUF_INIT;
     +	struct run_hooks_opt opt;
      	const struct object_id *head =3D &head_commit->object.oid;
    -+	run_hooks_opt_init_async(&opt);
     =20
      	if (!msg)
    - 		strbuf_addstr(&reflog_message, getenv("GIT_REFLOG_ACTION"));
     @@ builtin/merge.c: static void finish(struct commit *head_commit,
      	}
     =20
      	/* Run a post-merge hook */
     -	run_hook_le(NULL, "post-merge", squash ? "1" : "0", NULL);
    ++	run_hooks_opt_init_async(&opt);
     +	strvec_push(&opt.args, squash ? "1" : "0");
     +	run_hooks("post-merge", &opt);
     +	run_hooks_opt_clear(&opt);
21:  a5132f14b3 ! 20:  7e99398f7d gc: use hook library for pre-auto-gc hook
    @@ builtin/gc.c: static void add_repack_incremental_option(void)
      static int need_to_gc(void)
      {
     +	struct run_hooks_opt hook_opt;
    -+	run_hooks_opt_init_async(&hook_opt);
    ++
      	/*
      	 * Setting gc.auto to 0 or negative can disable the
      	 * automatic gc.
    @@ builtin/gc.c: static int need_to_gc(void)
      		return 0;
     =20
     -	if (run_hook_le(NULL, "pre-auto-gc", NULL))
    -+	if (run_hooks("pre-auto-gc", &hook_opt))
    ++	run_hooks_opt_init_async(&hook_opt);
    ++	if (run_hooks("pre-auto-gc", &hook_opt)) {
    ++		run_hooks_opt_clear(&hook_opt);
      		return 0;
    ++	}
    ++	run_hooks_opt_clear(&hook_opt);
      	return 1;
      }
    +=20
22:  01f1331cc9 ! 21:  5423217ef2 rebase: teach pre-rebase to use hook.h
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const =
char *prefix
      	struct option builtin_rebase_options[] =3D {
      		OPT_STRING(0, "onto", &options.onto_name,
      			   N_("revision"),
    -@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
    - 	};
    - 	int i;
    -=20
    -+	run_hooks_opt_init_async(&hook_opt);
    -+
    - 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
    - 		usage_with_options(builtin_rebase_usage,
    - 				   builtin_rebase_options);
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
      	}
     =20
      	/* If a hook exists, give it a chance to interrupt*/
    ++	run_hooks_opt_init_async(&hook_opt);
     +	strvec_pushl(&hook_opt.args, options.upstream_arg, argc ? argv[0] : =
NULL, NULL);
      	if (!ok_to_skip_pre_rebase &&
     -	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
     -			argc ? argv[0] : NULL, NULL))
    -+	    run_hooks("pre-rebase", &hook_opt))
    ++	    run_hooks("pre-rebase", &hook_opt)) {
    ++		run_hooks_opt_clear(&hook_opt);
      		die(_("The pre-rebase hook refused to rebase."));
    ++	}
    ++	run_hooks_opt_clear(&hook_opt);
     =20
      	if (options.flags & REBASE_DIFFSTAT) {
    -@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
    - 	ret =3D !!run_specific_rebase(&options, action);
    -=20
    - cleanup:
    -+	run_hooks_opt_clear(&hook_opt);
    - 	strbuf_release(&buf);
    - 	strbuf_release(&revisions);
    - 	free(options.head_name);
    + 		struct diff_options opts;
23:  85a7721adc ! 22:  1c0c5ad129 read-cache: convert post-index-change hoo=
k to use config
    @@ Documentation/githooks.txt: and "0" meaning they were not.
    =20
      ## read-cache.c ##
     @@
    - #include "fsmonitor.h"
      #include "thread-utils.h"
      #include "progress.h"
    + #include "sparse-index.h"
     +#include "hook.h"
    ++>>>>>>> 9524a9d29d (read-cache: convert post-index-change hook to use=
 config)
     =20
      /* Mask for the name length in ce_flags in the on-disk index */
     =20
     @@ read-cache.c: static int do_write_locked_index(struct index_state *=
istate, struct lock_file *l
    - 				 unsigned flags)
      {
      	int ret;
    + 	int was_full =3D !istate->sparse_index;
     +	struct run_hooks_opt hook_opt;
    -+	run_hooks_opt_init_async(&hook_opt);
     =20
    - 	/*
    - 	 * TODO trace2: replace "the_repository" with the actual repo instan=
ce
    + 	ret =3D convert_to_sparse(istate);
    +=20
     @@ read-cache.c: static int do_write_locked_index(struct index_state *=
istate, struct lock_file *l
      	else
      		ret =3D close_lock_file_gently(lock);
    @@ read-cache.c: static int do_write_locked_index(struct index_state *i=
state, struc
     -	run_hook_le(NULL, "post-index-change",
     -			istate->updated_workdir ? "1" : "0",
     -			istate->updated_skipworktree ? "1" : "0", NULL);
    ++	run_hooks_opt_init_async(&hook_opt);
     +	strvec_pushl(&hook_opt.args,
     +		     istate->updated_workdir ? "1" : "0",
     +		     istate->updated_skipworktree ? "1" : "0",
24:  21ec3e1a9d ! 23:  1193e856e6 receive-pack: convert push-to-checkout ho=
ok to hook.h
    @@ builtin/receive-pack.c: static const char *push_to_checkout(unsigned=
 char *hash,
      				    const char *work_tree)
      {
     +	struct run_hooks_opt opt;
    ++
     +	run_hooks_opt_init_sync(&opt);
     +
      	strvec_pushf(env, "GIT_WORK_TREE=3D%s", absolute_path(work_tree));
25:  e0405e96ad ! 24:  1817b6851b git-p4: use 'git hook' to run hooks
    @@ Commit message
    =20
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    =20
    +
    + ## Notes ##
    +    Maybe there is a better way to do this - I had a hard time getting=
 this to run
    +    locally, and Python is not my forte, so if anybody has a better ap=
proach I'd
    +    love to just take that patch instead :)
    +
    +    Since v6, removed the developer debug print statements.... :X
    +
    +    Maybe there is a better way to do this - I had a hard time getting=
 this to run
    +    locally, and Python is not my forte, so if anybody has a better ap=
proach I'd
    +    love to just take that patch instead :)
    +
      ## git-p4.py ##
     @@ git-p4.py: def decode_path(path):
     =20
26:  c52578e078 ! 25:  b3a354e4a8 hooks: convert 'post-checkout' hook to ho=
ok library
    @@ builtin/checkout.c: struct branch_info {
      			      int changed)
      {
     -	return run_hook_le(NULL, "post-checkout",
    --			   oid_to_hex(old_commit ? &old_commit->object.oid : &null_oid),
    --			   oid_to_hex(new_commit ? &new_commit->object.oid : &null_oid),
    +-			   oid_to_hex(old_commit ? &old_commit->object.oid : null_oid()),
    +-			   oid_to_hex(new_commit ? &new_commit->object.oid : null_oid()),
     -			   changed ? "1" : "0", NULL);
     +	struct run_hooks_opt opt;
     +	int rc;
    @@ builtin/checkout.c: struct branch_info {
      	   a commit exists. */
     -
     +	strvec_pushl(&opt.args,
    -+		     oid_to_hex(old_commit ? &old_commit->object.oid : &null_oid),
    -+		     oid_to_hex(new_commit ? &new_commit->object.oid : &null_oid),
    ++		     oid_to_hex(old_commit ? &old_commit->object.oid : null_oid()),
    ++		     oid_to_hex(new_commit ? &new_commit->object.oid : null_oid()),
     +		     changed ? "1" : "0",
     +		     NULL);
     +	rc =3D run_hooks("post-checkout", &opt);
    @@ builtin/clone.c: static int checkout(int submodule_progress)
      	struct tree_desc t;
      	int err =3D 0;
     +	struct run_hooks_opt hook_opt;
    -+	run_hooks_opt_init_sync(&hook_opt);
     =20
      	if (option_no_checkout)
      		return 0;
    @@ builtin/clone.c: static int checkout(int submodule_progress)
      	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
      		die(_("unable to write new index file"));
     =20
    --	err |=3D run_hook_le(NULL, "post-checkout", oid_to_hex(&null_oid),
    +-	err |=3D run_hook_le(NULL, "post-checkout", oid_to_hex(null_oid()),
     -			   oid_to_hex(&oid), "1", NULL);
    -+	strvec_pushl(&hook_opt.args, oid_to_hex(&null_oid), oid_to_hex(&oid)=
, "1", NULL);
    ++	run_hooks_opt_init_sync(&hook_opt);
    ++	strvec_pushl(&hook_opt.args, oid_to_hex(null_oid()), oid_to_hex(&oid=
), "1", NULL);
     +	err |=3D run_hooks("post-checkout", &hook_opt);
     +	run_hooks_opt_clear(&hook_opt);
     =20
    @@ builtin/worktree.c: static int add_worktree(const char *path, const =
char *refnam
     -			cp.argv =3D NULL;
     -			cp.trace2_hook_name =3D "post-checkout";
     -			strvec_pushl(&cp.args, absolute_path(hook),
    --				     oid_to_hex(&null_oid),
    +-				     oid_to_hex(null_oid()),
     -				     oid_to_hex(&commit->object.oid),
     -				     "1", NULL);
     -			ret =3D run_command(&cp);
     -		}
     +		struct run_hooks_opt opt;
    ++
     +		run_hooks_opt_init_sync(&opt);
     +
     +		strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
     +		strvec_pushl(&opt.args,
    -+			     oid_to_hex(&null_oid),
    ++			     oid_to_hex(null_oid()),
     +			     oid_to_hex(&commit->object.oid),
     +			     "1",
     +			     NULL);
    @@ builtin/worktree.c: static int add_worktree(const char *path, const =
char *refnam
     =20
      	strvec_clear(&child_env);
    =20
    + ## read-cache.c ##
    +@@
    + #include "progress.h"
    + #include "sparse-index.h"
    + #include "hook.h"
    +->>>>>>> 9524a9d29d (read-cache: convert post-index-change hook to use=
 config)
    +=20
    + /* Mask for the name length in ce_flags in the on-disk index */
    +=20
    +
      ## reset.c ##
     @@
      #include "tree-walk.h"
    @@ reset.c: int reset_head(struct repository *r, struct object_id *oid,=
 const char
      	}
     -	if (run_hook)
     -		run_hook_le(NULL, "post-checkout",
    --			    oid_to_hex(orig ? orig : &null_oid),
    +-			    oid_to_hex(orig ? orig : null_oid()),
     -			    oid_to_hex(oid), "1", NULL);
     +	if (run_hook) {
     +		struct run_hooks_opt opt;
    ++
     +		run_hooks_opt_init_sync(&opt);
     +		strvec_pushl(&opt.args,
    -+			     oid_to_hex(orig ? orig : &null_oid),
    ++			     oid_to_hex(orig ? orig : null_oid()),
     +			     oid_to_hex(oid),
     +			     "1",
     +			     NULL);
27:  316cb6f584 ! 26:  692352f9aa hook: convert 'post-rewrite' hook to conf=
ig
    @@ builtin/am.c: static int run_applypatch_msg_hook(struct am_state *st=
ate)
     -	const char *hook =3D find_hook("post-rewrite");
     +	struct run_hooks_opt opt;
      	int ret;
    -+	run_hooks_opt_init_async(&opt);
     =20
     -	if (!hook)
     -		return 0;
    --
    ++	run_hooks_opt_init_async(&opt);
    +=20
     -	strvec_push(&cp.args, hook);
     -	strvec_push(&cp.args, "rebase");
    --
    --	cp.in =3D xopen(am_path(state, "rewritten"), O_RDONLY);
    --	cp.stdout_to_stderr =3D 1;
    --	cp.trace2_hook_name =3D "post-rewrite";
     +	strvec_push(&opt.args, "rebase");
     +	opt.path_to_stdin =3D am_path(state, "rewritten");
     =20
    --	ret =3D run_command(&cp);
    +-	cp.in =3D xopen(am_path(state, "rewritten"), O_RDONLY);
    +-	cp.stdout_to_stderr =3D 1;
    +-	cp.trace2_hook_name =3D "post-rewrite";
     +	ret =3D run_hooks("post-rewrite", &opt);
     =20
    +-	ret =3D run_command(&cp);
    +-
     -	close(cp.in);
     +	run_hooks_opt_clear(&opt);
      	return ret;
    @@ sequencer.c: int update_head_with_reflog(const struct commit *old_he=
ad,
     +	struct string_list to_stdin =3D STRING_LIST_INIT_DUP;
      	int code;
     -	struct strbuf sb =3D STRBUF_INIT;
    -+	run_hooks_opt_init_async(&opt);
     =20
     -	argv[0] =3D find_hook("post-rewrite");
     -	if (!argv[0])
     -		return 0;
    -+	strvec_push(&opt.args, "amend");
    ++	run_hooks_opt_init_async(&opt);
     =20
     -	argv[1] =3D "amend";
     -	argv[2] =3D NULL;
    @@ sequencer.c: int update_head_with_reflog(const struct commit *old_he=
ad,
     -	strbuf_release(&sb);
     -	sigchain_pop(SIGPIPE);
     -	return finish_command(&proc);
    ++	strvec_push(&opt.args, "amend");
    ++
     +	strbuf_addf(&tmp,
     +		    "%s %s",
     +		    oid_to_hex(oldoid),
    @@ sequencer.c: static int pick_commits(struct repository *r,
     -			strvec_push(&child.args, "--for-rewrite=3Drebase");
     +			struct child_process notes_cp =3D CHILD_PROCESS_INIT;
     +			struct run_hooks_opt hook_opt;
    ++
     +			run_hooks_opt_init_async(&hook_opt);
     +
     +			notes_cp.in =3D open(rebase_path_rewritten_list(), O_RDONLY);
28:  0ab776068d =3D 27:  964011dfdd transport: convert pre-push hook to use=
 config
29:  601dada804 ! 28:  c04822add9 reference-transaction: look for hooks in =
config
    @@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'interleaving =
hook calls s
      	EOF
     =20
      	git push ./target-repo.git PRE POST &&
    +
    + ## transport.c ##
    +@@ transport.c: static int run_pre_push_hook(struct transport *transpo=
rt,
    + 	struct strbuf tmp =3D STRBUF_INIT;
    + 	struct ref *r;
    + 	struct string_list to_stdin =3D STRING_LIST_INIT_DUP;
    ++
    + 	run_hooks_opt_init_async(&opt);
    +=20
    + 	strvec_push(&opt.args, transport->remote->name);
30:  d60f2b146e ! 29:  ddc6f56bec receive-pack: convert 'update' hook to ho=
ok.h
    @@ builtin/receive-pack.c: static int run_receive_hook(struct command *=
commands,
      	return status;
      }
     =20
    --static int run_update_hook(struct command *cmd)
     +static void hook_output_to_sideband(struct strbuf *output, void *cb_d=
ata)
    - {
    --	const char *argv[5];
    --	struct child_process proc =3D CHILD_PROCESS_INIT;
    --	int code;
    ++{
     +	int keepalive_active =3D 0;
    -=20
    --	argv[0] =3D find_hook("update");
    --	if (!argv[0])
    --		return 0;
    ++
     +	if (keepalive_in_sec <=3D 0)
     +		use_keepalive =3D KEEPALIVE_NEVER;
     +	if (use_keepalive =3D=3D KEEPALIVE_ALWAYS)
     +		keepalive_active =3D 1;
    -=20
    --	argv[1] =3D cmd->ref_name;
    --	argv[2] =3D oid_to_hex(&cmd->old_oid);
    --	argv[3] =3D oid_to_hex(&cmd->new_oid);
    --	argv[4] =3D NULL;
    ++
     +	/* send a keepalive if there is no data to write */
     +	if (keepalive_active && !output->len) {
     +		static const char buf[] =3D "0005\1";
     +		write_or_die(1, buf, sizeof(buf) - 1);
     +		return;
     +	}
    -=20
    --	proc.no_stdin =3D 1;
    --	proc.stdout_to_stderr =3D 1;
    --	proc.err =3D use_sideband ? -1 : 0;
    --	proc.argv =3D argv;
    --	proc.trace2_hook_name =3D "update";
    ++
     +	if (use_keepalive =3D=3D KEEPALIVE_AFTER_NUL && !keepalive_active) {
     +		const char *first_null =3D memchr(output->buf, '\0', output->len);
     +		if (first_null) {
    @@ builtin/receive-pack.c: static int run_receive_hook(struct command *=
commands,
     +	send_sideband(1, 2, output->buf, output->len, use_sideband);
     +}
     +
    -+static int run_update_hook(struct command *cmd)
    -+{
    + static int run_update_hook(struct command *cmd)
    + {
    +-	const char *argv[5];
    +-	struct child_process proc =3D CHILD_PROCESS_INIT;
     +	struct run_hooks_opt opt;
    -+	int code;
    + 	int code;
    +=20
    +-	argv[0] =3D find_hook("update");
    +-	if (!argv[0])
    +-		return 0;
     +	run_hooks_opt_init_async(&opt);
    -+
    +=20
    +-	argv[1] =3D cmd->ref_name;
    +-	argv[2] =3D oid_to_hex(&cmd->old_oid);
    +-	argv[3] =3D oid_to_hex(&cmd->new_oid);
    +-	argv[4] =3D NULL;
     +	strvec_pushl(&opt.args,
     +		     cmd->ref_name,
     +		     oid_to_hex(&cmd->old_oid),
     +		     oid_to_hex(&cmd->new_oid),
     +		     NULL);
     =20
    +-	proc.no_stdin =3D 1;
    +-	proc.stdout_to_stderr =3D 1;
    +-	proc.err =3D use_sideband ? -1 : 0;
    +-	proc.argv =3D argv;
    +-	proc.trace2_hook_name =3D "update";
    +-
     -	code =3D start_command(&proc);
     -	if (code)
     -		return code;
31:  1e6898670b ! 30:  e1e810869f proc-receive: acquire hook list from hook=
.h
    @@ builtin/receive-pack.c: static int run_proc_receive_hook(struct comm=
and *command
     =20
     -	argv[0] =3D find_hook("proc-receive");
     -	if (!argv[0]) {
    -+	struct strbuf hookname =3D STRBUF_INIT;
     +	struct hook *proc_receive =3D NULL;
     +	struct list_head *pos, *hooks;
     +
    -+	strbuf_addstr(&hookname, "proc-receive");
    -+	hooks =3D hook_list(&hookname);
    ++	hooks =3D hook_list("proc-receive");
     +
     +	list_for_each(pos, hooks) {
     +		if (proc_receive) {
32:  012e3a7a79 ! 31:  b8be5a2288 post-update: use hook.h library
    @@ builtin/receive-pack.c: static const char *update(struct command *cm=
d, struct sh
      	struct command *cmd;
     -	struct child_process proc =3D CHILD_PROCESS_INIT;
     -	const char *hook;
    --
    ++	struct run_hooks_opt opt;
    +=20
     -	hook =3D find_hook("post-update");
     -	if (!hook)
     -		return;
    -+	struct run_hooks_opt opt;
     +	run_hooks_opt_init_async(&opt);
     =20
      	for (cmd =3D commands; cmd; cmd =3D cmd->next) {
33:  2740bcda6d =3D 32:  1cc1384eae receive-pack: convert receive hooks to =
hook.h
34:  f201f3af5f =3D 33:  1bb9a3810c bugreport: use hook_exists instead of f=
ind_hook
35:  0956a94cc7 ! 34:  3db7bf3b0d git-send-email: use 'git hook run' for 's=
endemail-validate'
    @@ git-send-email.perl: sub unique_email_list {
      	my ($fn, $xfer_encoding) =3D @_;
     =20
     -	if ($repo) {
    --		my $validate_hook =3D catfile(catdir($repo->repo_path(), 'hooks'),
    +-		my $validate_hook =3D catfile($repo->hooks_path(),
     -					    'sendemail-validate');
     -		my $hook_error;
     -		if (-x $validate_hook) {
    @@ git-send-email.perl: sub unique_email_list {
     -			chdir($repo->wc_path() or $repo->repo_path())
     -				or die("chdir: $!");
     -			local $ENV{"GIT_DIR"} =3D $repo->repo_path();
    --			$hook_error =3D "rejected by sendemail-validate hook"
    --				if system($validate_hook, $target);
    +-			$hook_error =3D system_or_msg([$validate_hook, $target]);
     -			chdir($cwd_save) or die("chdir: $!");
     -		}
    --		return $hook_error if $hook_error;
    +-		if ($hook_error) {
    +-			die sprintf(__("fatal: %s: rejected by sendemail-validate hook\n" =
.
    +-				       "%s\n" .
    +-				       "warning: no patches were sent\n"), $fn, $hook_error);
    +-		}
     -	}
     +	my $target =3D abs_path($fn);
    -+	return "rejected by sendemail-validate hook"
    -+		if system(("git", "hook", "run", "sendemail-validate", "-a",
    -+				$target));
    ++
    ++	system_or_die(["git", "hook", "run", "sendemail-validate", "-j1", "-=
a", $target],
    ++		sprintf(__("fatal: %s: rejected by sendemail-validate hook\n" .
    ++			   "warning: no patches were sent\n"),
    ++		        $fn));
     =20
      	# Any long lines will be automatically fixed if we use a suitable tr=
ansfer
      	# encoding.
    =20
      ## t/t9001-send-email.sh ##
    +@@ t/t9001-send-email.sh: test_expect_success $PREREQ "--validate resp=
ects relative core.hooksPath path" '
    + 	test_path_is_file my-hooks.ran &&
    + 	cat >expect <<-EOF &&
    + 	fatal: longline.patch: rejected by sendemail-validate hook
    +-	fatal: command '"'"'$PWD/my-hooks/sendemail-validate'"'"' died with =
exit code 1
    + 	warning: no patches were sent
    + 	EOF
    + 	test_cmp expect actual
    +@@ t/t9001-send-email.sh: test_expect_success $PREREQ "--validate resp=
ects absolute core.hooksPath path" '
    + 	test_path_is_file my-hooks.ran &&
    + 	cat >expect <<-EOF &&
    + 	fatal: longline.patch: rejected by sendemail-validate hook
    +-	fatal: command '"'"'$PWD/my-hooks/sendemail-validate'"'"' died with =
exit code 1
    + 	warning: no patches were sent
    + 	EOF
    + 	test_cmp expect actual
     @@ t/t9001-send-email.sh: test_expect_success $PREREQ 'invoke hook' '
      	mkdir -p .git/hooks &&
     =20
36:  7f05b25392 ! 35:  d2a477d9e3 run-command: stop thinking about hooks
    @@ hook.c: static int should_include_hookdir(const char *path, enum hoo=
kdir_opt cfg
     +}
     +
     +
    - struct list_head* hook_list(const struct strbuf* hookname)
    + struct list_head* hook_list(const char* hookname)
      {
      	struct strbuf hook_key =3D STRBUF_INIT;
    -@@ hook.c: struct list_head* hook_list(const struct strbuf* hookname)
    +@@ hook.c: struct list_head* hook_list(const char* hookname)
      	git_config(hook_config_lookup, &cb_data);
     =20
      	if (have_git_dir()) {
    --		const char *legacy_hook_path =3D find_hook(hookname->buf);
    -+		const char *legacy_hook_path =3D find_legacy_hook(hookname->buf);
    +-		const char *legacy_hook_path =3D find_hook(hookname);
    ++		const char *legacy_hook_path =3D find_legacy_hook(hookname);
     =20
      		/* Unconditionally add legacy hook, but annotate it. */
      		if (legacy_hook_path) {
37:  e9b1f847f2 <  -:  ---------- docs: unify githooks and git-hook manpage=
s
 -:  ---------- > 36:  62a3e3b419 doc: clarify fsmonitor-watchman specifica=
tion
 -:  ---------- > 37:  5c864de1aa docs: link githooks and git-hook manpages

--=20
2.31.1.818.g46aad6cb9e-goog

