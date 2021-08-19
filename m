Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-31.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA283C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 03:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0183610CE
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 03:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbhHSDfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 23:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbhHSDfa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 23:35:30 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449FDC061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 20:34:55 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id p21-20020ac846150000b02902982d999bfbso2028461qtn.7
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 20:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=fnu+zCpp0VlNdGb8utmbqS9i1o9FUDgl14TqwCD/KE8=;
        b=NzYPx5MbnKQ7TlArb/OEpaEKch/XpeIIHeeDpbDvNsUPUmqXIGiFHYGCbHpWMtfZTj
         Wu/dEkKrqQFgWzto/SyXuhw6RN8KHZzy8bqAfNAotx3np+reTwaOP6pJyW3GUJnz4FCp
         pWpcDPgjSWoEv4d4y8Nj/YZFvcLfBjR/v/DtV413ejavS8nBcXMvAuU1we6ZafbmjXod
         NhoyUJ9ANEzWsrFzvefMGVz6OIdQIs5q8mnYHOxaFnw8aEjkeo1uofOPen3VlPqmVXvn
         +Wiqq/xWSnTFuJAosMi8DU0J5vqLABAo0nqJepaMQc8xJ6M0ZEMyJcjAvJoFH/fcjPaA
         7Pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc:content-transfer-encoding;
        bh=fnu+zCpp0VlNdGb8utmbqS9i1o9FUDgl14TqwCD/KE8=;
        b=JSN2j7o0iuuq0k7ARryaTk6FYPCUeD328cGB8ZJYfST0baNLVvDXsylV8JpD8jZq8L
         P/gCLQiE98T7P+1R0zJ6I8/lqos/w8eoPTikH8dB/Xa14XNFykmJvSVsozBt7+pSdQ7Q
         jLKNX5dX6CVExbJgX1dJrcJ4kwjhUBMrpPADRsUpYZfkCp4kWVsGeQdlp/yrLMQB1xKJ
         kMksEpA0m6uO+gTlaFKbicX+6S0BZ6OSVjDJ/0uaKeviYXfHs2j3gp61j8zUO878jEoq
         HSE29K0EYlYzRCKi4d4XTbaQrPR8wi56r97l/Yq7quJC0knat+fNEiQCRWBveERs5/dQ
         2tfQ==
X-Gm-Message-State: AOAM531S1JjUst1yP6u4XbypKK+qyaWnD20OaurRUyvdSf6ye3sqtZK1
        6iQfhC2dw+/Wn2+iyJqz9LVBX8wj9uo1igRNsweB35uE6agA5JgNPpwinqrvwVovkSO08dO5fiX
        I5J/KGj6VhJVewHwcFr7rOEIOPDIho0Geycce6IRMzNcLPLuuas+niHlItvoCVKwE+tqtjRs0vg
        ==
X-Google-Smtp-Source: ABdhPJzl/uFgISH2jKTwC4IbECPEJxVpcKVNKv1G2j1NG4CMwXCyxWeMiwBby+/666N+7+R9Jh3UYywuF6/dikleIgo=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:a999:9b6d:55c3:b66c])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:b356:: with SMTP id
 a22mr12460783qvf.7.1629344094356; Wed, 18 Aug 2021 20:34:54 -0700 (PDT)
Date:   Wed, 18 Aug 2021 20:34:44 -0700
In-Reply-To: <20210812004258.74318-1-emilyshaffer@google.com>
Message-Id: <20210819033450.3382652-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v3 0/6] config-based hooks restarted
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the config-based hooks topic rebased onto v4 of =C3=86var's
branch[1]. There is a happy CI build of it on GitHub[2].

The topic overall adds the ability to set up hooks by modifying the
config, in addition to placing specially named hooks into the hookdir.
This enables users to specify multiple hooks for a given event, and so
this topic also fleshes out the use of the run_processes_parallel() API
which is now introduced in =C3=86var's reordering of prior patches.

Patches 1-4 make some minor changes to prepare =C3=86var's series to handle
more than one hook at a time. With the exception of patch 4, there
should be no behavior change for existing hooks.

Patch 2 is opinionated about which hooks should and shouldn't be allowed
to run in parallel; if you care about a specific hook, please take a
look there.

Patch 5 is the motivating feature - it begins to parse the config
looking for hooks.

Patch 6 takes advantage of the decoupling of hooks and GITDIR to allow
out-of-repo hook runs, which would only run hooks specified in the
system or global config. This mainly targets 'sendemail-validate', but
'git-sendemail.perl' still explicitly disallows out-of-repo hook
execution on that hook for now. (Maybe that change should be added in
this series? Or maybe patch 6 belongs with that kind of change?)

Since v2, I have addressed comments left by Junio - thanks for the
review. Mostly these were small nits, but two somewhat larger changes
came out:

 - 'hook_list' becomes 'list_hooks' and 'list_hooks_gently'. It might
   still be better to name it something else, and it might still be
   better to decouple the "is this a known hook" check from the "give me
   all the hooks" function; comments welcome.
 - The documentation in patch 5, which starts using the config, has been
   expanded to hopefully become more clear. I am especially interested
   in feedback in this doc change, as it's the main place users should
   be able to learn how to use the new feature.

Everything else should be pretty minor.

Right now I'm trying to focus on this series first and foremost, hence
sending two rerolls based on the same version of =C3=86var's base restart.
I'll try to perform a code review on =C3=86var's latest tomorrow.

Thanks!
 - Emily

1: https://lore.kernel.org/git/cover-v4-00.36-00000000000-20210803T191505Z-=
avarab%40gmail.com
2: https://github.com/nasamuffin/git/actions/runs/1145128560

Emily Shaffer (6):
  hook: run a list of hooks instead
  hook: allow parallel hook execution
  hook: introduce "git hook list"
  hook: allow running non-native hooks
  hook: include hooks from the config
  hook: allow out-of-repo 'git hook' invocations

 Documentation/config/hook.txt |  22 +++
 Documentation/git-hook.txt    |  87 +++++++++-
 builtin/am.c                  |   4 +-
 builtin/checkout.c            |   2 +-
 builtin/clone.c               |   2 +-
 builtin/hook.c                |  65 +++++++-
 builtin/merge.c               |   2 +-
 builtin/rebase.c              |   2 +-
 builtin/receive-pack.c        |   9 +-
 builtin/worktree.c            |   2 +-
 commit.c                      |   2 +-
 git.c                         |   2 +-
 hook.c                        | 293 +++++++++++++++++++++++++++++-----
 hook.h                        |  61 +++++--
 read-cache.c                  |   2 +-
 refs.c                        |   2 +-
 reset.c                       |   3 +-
 sequencer.c                   |   4 +-
 t/t1800-hook.sh               | 161 ++++++++++++++++++-
 transport.c                   |   2 +-
 20 files changed, 648 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/config/hook.txt

Range-diff against v2:
 1:  81fe1ed90d <  -:  ---------- Makefile: mark "check" target as .PHONY
 2:  b32abc81fb <  -:  ---------- Makefile: stop hardcoding {command,config=
}-list.h
 3:  fa46bd1154 <  -:  ---------- Makefile: remove an out-of-date comment
 4:  715fd63089 <  -:  ---------- hook.[ch]: move find_hook() to this new l=
ibrary
 5:  ac6c018d27 <  -:  ---------- hook.c: add a hook_exists() wrapper and u=
se it in bugreport.c
 6:  53619d87a2 <  -:  ---------- hook.c users: use "hook_exists()" insted =
of "find_hook()"
 7:  39dbb89620 <  -:  ---------- hook-list.h: add a generated list of hook=
s, like config-list.h
 8:  7d2c1cec74 <  -:  ---------- hook: add 'run' subcommand
 9:  3fea1cdaf8 <  -:  ---------- gc: use hook library for pre-auto-gc hook
10:  c86a9c6f95 <  -:  ---------- rebase: convert pre-rebase to use hook.h
11:  31dff1f274 <  -:  ---------- am: convert applypatch to use hook.h
12:  a2e27d745c <  -:  ---------- hooks: convert 'post-checkout' hook to ho=
ok library
13:  1a71fa8b75 <  -:  ---------- merge: convert post-merge to use hook.h
14:  95e19fa468 <  -:  ---------- git hook run: add an --ignore-missing fla=
g
15:  371f581e3b <  -:  ---------- send-email: use 'git hook run' for 'sende=
mail-validate'
16:  99306a4bd3 <  -:  ---------- git-p4: use 'git hook' to run hooks
17:  59d1a563ca <  -:  ---------- commit: convert {pre-commit,prepare-commi=
t-msg} hook to hook.h
18:  7c8de04707 <  -:  ---------- read-cache: convert post-index-change to =
use hook.h
19:  a2e7176609 <  -:  ---------- receive-pack: convert push-to-checkout ho=
ok to hook.h
20:  f03ef24df7 <  -:  ---------- run-command: remove old run_hook_{le,ve}(=
) hook API
21:  18c1dfe677 <  -:  ---------- run-command: allow stdin for run_processe=
s_parallel
22:  eff713fc19 <  -:  ---------- hook: support passing stdin to hooks
23:  2cbec65834 <  -:  ---------- am: convert 'post-rewrite' hook to hook.h
24:  5d34d18bee <  -:  ---------- run-command: add stdin callback for paral=
lelization
25:  b989d910ed <  -:  ---------- hook: provide stdin by string_list or cal=
lback
26:  ce6929493b <  -:  ---------- hook: convert 'post-rewrite' hook in sequ=
encer.c to hook.h
27:  13affda962 <  -:  ---------- transport: convert pre-push hook to hook.=
h
28:  c74720029a <  -:  ---------- hook tests: test for exact "pre-push" hoo=
k input
29:  1252a251bb <  -:  ---------- hook tests: use a modern style for "pre-p=
ush" tests
30:  3f2488fea6 <  -:  ---------- reference-transaction: use hook.h to run =
hooks
31:  2e78c47ead <  -:  ---------- run-command: allow capturing of collated =
output
32:  95132acbb0 <  -:  ---------- hooks: allow callers to capture output
33:  f2510ca910 <  -:  ---------- receive-pack: convert 'update' hook to ho=
ok.h
34:  8686308864 <  -:  ---------- post-update: use hook.h library
35:  b10f5142a0 <  -:  ---------- receive-pack: convert receive hooks to ho=
ok.h
36:  5c29c932c3 <  -:  ---------- hooks: fix a TOCTOU in "did we run a hook=
?" heuristic
37:  5177e8ba2c !  1:  6d6400329c hook: run a list of hooks instead
    @@ builtin/hook.c: static int run(int argc, const char **argv, const ch=
ar *prefix)
     -		return run_hooks_oneshot(hook_name, &opt);
     -	hook_path =3D find_hook(hook_name);
     -	if (!hook_path) {
    -+	hooks =3D hook_list(hook_name);
    ++	hooks =3D list_hooks(hook_name);
     +	if (list_empty(hooks)) {
     +		/* ... act like run_hooks_oneshot() under --ignore-missing */
     +		if (ignore_missing)
    @@ hook.c
     =20
     +static void free_hook(struct hook *ptr)
     +{
    -+	if (ptr) {
    ++	if (ptr)
     +		free(ptr->feed_pipe_cb_data);
    -+	}
     +	free(ptr);
     +}
     +
    @@ hook.c
      static int known_hook(const char *name)
      {
      	const char **p;
    -@@ hook.c: int hook_exists(const char *name)
    - 	return !!find_hook(name);
    - }
    +@@ hook.c: const char *find_hook(const char *name)
     =20
    -+struct list_head* hook_list(const char* hookname)
    + int hook_exists(const char *name)
    + {
    +-	return !!find_hook(name);
    ++	return !list_empty(list_hooks(name));
    ++}
    ++
    ++struct list_head *list_hooks(const char *hookname)
     +{
     +	struct list_head *hook_head =3D xmalloc(sizeof(struct list_head));
     +
     +	INIT_LIST_HEAD(hook_head);
     +
     +	if (!hookname)
    -+		return NULL;
    ++		BUG("null hookname was provided to hook_list()!");
     +
     +	if (have_git_dir()) {
     +		const char *hook_path =3D find_hook(hookname);
    @@ hook.c: int hook_exists(const char *name)
     +	}
     +
     +	return hook_head;
    -+}
    -+
    + }
    +=20
      void run_hooks_opt_clear(struct run_hooks_opt *o)
    - {
    - 	strvec_clear(&o->env);
     @@ hook.c: static int pick_next_hook(struct child_process *cp,
      	cp->dir =3D hook_cb->options->dir;
     =20
    @@ hook.c: int run_hooks_oneshot(const char *hook_name, struct run_hook=
s_opt *optio
     -	hook_path =3D find_hook(hook_name);
     -	if (!hook_path) {
     -		ret =3D 0;
    -+	hooks =3D hook_list(hook_name);
    ++	hooks =3D list_hooks(hook_name);
     +
     +	/*
     +	 * If you need to act on a missing hook, use run_found_hooks()
    @@ hook.h: struct hook {
     + * Provides a linked list of 'struct hook' detailing commands which s=
hould run
     + * in response to the 'hookname' event, in execution order.
     + */
    -+struct list_head* hook_list(const char *hookname);
    ++struct list_head *list_hooks(const char *hookname);
     +
      struct run_hooks_opt
      {
38:  eda439cd57 !  2:  dfb995ce4d hook: allow parallel hook execution
    @@ Commit message
         hook: allow parallel hook execution
    =20
         In many cases, there's no reason not to allow hooks to execute in
    -    parallel. run_processes_parallel() is well-suited - it's a task qu=
eue
    -    that runs its housekeeping in series, which means users don't
    -    need to worry about thread safety on their callback data. True
    -    multithreaded execution with the async_* functions isn't necessary=
 here.
    -    Synchronous hook execution can be achieved by only allowing 1 job =
to run
    -    at a time.
    +    parallel, if more than one was provided. hook.c already calls
    +    run_processes_parallel(), so all we need to do is allow the job co=
unt we
    +    hand to run_processes_parallel() to be greater than 1.
    =20
    -    Teach run_hooks() to use that function for simple hooks which don'=
t
    -    require stdin or capture of stderr.
    +    If users have specified no alternative, we can use the processor c=
ount
    +    from online_cpus() to run an efficient number of tasks at once. Ho=
wever,
    +    users can also override this number if they want by configuring
    +    'hook.jobs'.
    +
    +    To avoid looking up 'hook.jobs' in cases where we don't end up wit=
h any
    +    hooks to run anyways, teach the hook runner commands to notice if
    +    .jobs=3D=3D0 and do a config or online_cpus() lookup if so, when w=
e already
    +    know we have jobs to run.
    +
    +    Serial execution can still be performed by setting .jobs =3D=3D 1.
    =20
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
    @@ builtin/am.c: static void am_destroy(const struct am_state *state)
      {
      	int ret;
     -	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
    -+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_SYNC;
    ++	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_SERIAL;
     =20
      	assert(state->msg);
      	strvec_push(&opt.args, am_path(state, "final-commit"));
    @@ builtin/am.c: static int run_applypatch_msg_hook(struct am_state *st=
ate)
      static int run_post_rewrite_hook(const struct am_state *state)
      {
     -	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
    -+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_ASYNC;
    ++	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_PARALLEL;
     =20
      	strvec_push(&opt.args, "rebase");
      	opt.path_to_stdin =3D am_path(state, "rewritten");
    @@ builtin/checkout.c: struct branch_info {
      			      int changed)
      {
     -	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
    -+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_SYNC;
    ++	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_SERIAL;
     =20
      	/* "new_commit" can be NULL when checking out from the index before
      	   a commit exists. */
    @@ builtin/clone.c: static int checkout(int submodule_progress)
      	struct tree_desc t;
      	int err =3D 0;
     -	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT;
    -+	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT_SYNC;
    ++	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT_SERIAL;
     =20
      	if (option_no_checkout)
      		return 0;
    @@ builtin/hook.c: static const char * const builtin_hook_run_usage[] =
=3D {
      {
      	int i;
     -	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
    -+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_SYNC;
    ++	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_SERIAL;
      	int ignore_missing =3D 0;
      	const char *hook_name;
      	struct list_head *hooks;
    @@ builtin/merge.c: static void finish(struct commit *head_commit,
      {
      	struct strbuf reflog_message =3D STRBUF_INIT;
     -	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
    -+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_ASYNC;
    ++	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_PARALLEL;
      	const struct object_id *head =3D &head_commit->object.oid;
     =20
      	if (!msg)
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const =
char *prefix
      	int reschedule_failed_exec =3D -1;
      	int allow_preemptive_ff =3D 1;
     -	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT;
    -+	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT_ASYNC;
    ++	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT_PARALLEL;
      	struct option builtin_rebase_options[] =3D {
      		OPT_STRING(0, "onto", &options.onto_name,
      			   N_("revision"),
    @@ builtin/receive-pack.c: static int run_receive_hook(struct command *=
commands,
      			    const struct string_list *push_options)
      {
     -	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
    -+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_ASYNC;
    ++	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_PARALLEL;
      	struct receive_hook_feed_context ctx;
      	struct command *iter =3D commands;
     =20
    @@ builtin/receive-pack.c: static int run_receive_hook(struct command *=
commands,
      static int run_update_hook(struct command *cmd)
      {
     -	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
    -+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_ASYNC;
    ++	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_PARALLEL;
     =20
      	strvec_pushl(&opt.args,
      		     cmd->ref_name,
    @@ builtin/receive-pack.c: static const char *push_to_checkout(unsigned=
 char *hash,
      				    const char *work_tree)
      {
     -	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
    -+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_SYNC;
    ++	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_SERIAL;
     +
      	opt.invoked_hook =3D invoked_hook;
     =20
    @@ builtin/receive-pack.c: static const char *update(struct command *cm=
d, struct sh
      {
      	struct command *cmd;
     -	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
    -+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_ASYNC;
    ++	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_PARALLEL;
     =20
      	for (cmd =3D commands; cmd; cmd =3D cmd->next) {
      		if (cmd->error_string || cmd->did_not_exist)
    @@ builtin/worktree.c: static int add_worktree(const char *path, const =
char *refnam
      	 */
      	if (!ret && opts->checkout) {
     -		struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
    -+		struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_SYNC;
    ++		struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_SERIAL;
     =20
      		strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
      		strvec_pushl(&opt.args,
    @@ commit.c: int run_commit_hook(int editor_is_used, const char *index_=
file,
      		    const char *name, ...)
      {
     -	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
    -+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_SYNC;
    ++	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_SERIAL;
      	va_list args;
      	const char *arg;
     =20
    @@ hook.c: int run_hooks(const char *hook_name, struct list_head *hooks=
,
      	cb_data.run_me =3D list_first_entry(hooks, struct hook, list);
     =20
     -	run_processes_parallel_tr2(jobs,
    -+	/* INIT_ASYNC sets jobs to 0, so go look up how many to use. */
    ++	/* INIT_PARALLEL sets jobs to 0, so go look up how many to use. */
     +	if (!options->jobs)
     +		options->jobs =3D configured_hook_jobs();
     +
    @@ hook.c: int run_hooks_oneshot(const char *hook_name, struct run_hook=
s_opt *optio
     +	 * Turn on parallelism by default. Hooks which don't want it should
     +	 * specify their options accordingly.
     +	 */
    -+	struct run_hooks_opt hook_opt_scratch =3D RUN_HOOKS_OPT_INIT_ASYNC;
    ++	struct run_hooks_opt hook_opt_scratch =3D RUN_HOOKS_OPT_INIT_PARALLE=
L;
     =20
      	if (!options)
      		options =3D &hook_opt_scratch;
    @@ hook.h: struct hook_cb_data {
      	int *invoked_hook;
      };
     =20
    -+#define RUN_HOOKS_OPT_INIT_SYNC { \
    ++#define RUN_HOOKS_OPT_INIT_SERIAL { \
     +	.jobs =3D 1, \
     +	.env =3D STRVEC_INIT, \
     +	.args =3D STRVEC_INIT, \
     +}
     +
    -+#define RUN_HOOKS_OPT_INIT_ASYNC { \
    ++#define RUN_HOOKS_OPT_INIT_PARALLEL { \
     +	.jobs =3D 0, \
     +	.env =3D STRVEC_INIT, \
     +	.args =3D STRVEC_INIT, \
    @@ read-cache.c: static int do_write_locked_index(struct index_state *i=
state, struc
      	int ret;
      	int was_full =3D !istate->sparse_index;
     -	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT;
    -+	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT_ASYNC;
    ++	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT_PARALLEL;
     =20
      	ret =3D convert_to_sparse(istate);
     =20
    @@ refs.c: int ref_update_reject_duplicates(struct string_list *refname=
s,
      				const char *state)
      {
     -	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
    -+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_ASYNC;
    ++	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_PARALLEL;
      	struct string_list to_stdin =3D STRING_LIST_INIT_NODUP;
      	int ret =3D 0, i;
     =20
    @@ reset.c: int reset_head(struct repository *r, struct object_id *oid,=
 const char
      	}
      	if (run_hook) {
     -		struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
    -+		struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_ASYNC;
    ++		struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_PARALLEL;
     +
      		strvec_pushl(&opt.args,
      			     oid_to_hex(orig ? orig : null_oid()),
    @@ sequencer.c: int update_head_with_reflog(const struct commit *old_he=
ad,
      			    const struct object_id *newoid)
      {
     -	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
    -+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_ASYNC;
    ++	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_PARALLEL;
      	struct strbuf tmp =3D STRBUF_INIT;
      	struct string_list to_stdin =3D STRING_LIST_INIT_DUP;
      	int code;
    @@ sequencer.c: static int pick_commits(struct repository *r,
      				st.st_size > 0) {
      			struct child_process notes_cp =3D CHILD_PROCESS_INIT;
     -			struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT;
    -+			struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT_ASYNC;
    ++			struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT_PARALLEL;
     =20
      			notes_cp.in =3D open(rebase_path_rewritten_list(), O_RDONLY);
      			notes_cp.git_cmd =3D 1;
    @@ transport.c: static int run_pre_push_hook(struct transport *transpor=
t,
      {
      	int ret =3D 0;
     -	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
    -+	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_ASYNC;
    ++	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_PARALLEL;
      	struct ref *r;
      	struct string_list to_stdin =3D STRING_LIST_INIT_NODUP;
     =20
39:  cdfe3b6e16 !  3:  c8a04306e9 hook: introduce "git hook list"
    @@ Commit message
    =20
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    =20
    + ## Documentation/git-hook.txt ##
    +@@ Documentation/git-hook.txt: SYNOPSIS
    + [verse]
    + 'git hook' run [--to-stdin=3D<path>] [--ignore-missing] [(-j|--jobs) =
<n>]
    + 	<hook-name> [-- <hook-args>]
    ++'git hook' list <hook-name>
    +=20
    + DESCRIPTION
    + -----------
    +@@ Documentation/git-hook.txt: optional `--` (or `--end-of-options`, s=
ee linkgit:gitcli[7]). The
    + arguments (if any) differ by hook name, see linkgit:githooks[5] for
    + what those are.
    +=20
    ++list::
    ++	Print a list of hooks which will be run on `<hook-name>` event. If n=
o
    ++	hooks are configured for that event, print nothing and return 1.
    ++
    + OPTIONS
    + -------
    +=20
    +
      ## builtin/hook.c ##
     @@
     =20
      #define BUILTIN_HOOK_RUN_USAGE \
    - 	N_("git hook run [--to-stdin=3D<path>] <hook-name> [-- <hook-args>]"=
)
    + 	N_("git hook run [--ignore-missing] [--to-stdin=3D<path>] <hook-name=
> [-- <hook-args>]")
     +#define BUILTIN_HOOK_LIST_USAGE \
     +	N_("git hook list <hook-name>")
     =20
    @@ builtin/hook.c: static const char * const builtin_hook_run_usage[] =
=3D {
     +
     +	head =3D hook_list(hookname);
     +
    -+	if (list_empty(head)) {
    -+		printf(_("no commands configured for hook '%s'\n"),
    -+		       hookname);
    -+		return 0;
    -+	}
    ++	if (list_empty(head))
    ++		return 1;
     +
     +	list_for_each(pos, head) {
     +		struct hook *item =3D list_entry(pos, struct hook, list);
    @@ builtin/hook.c: int cmd_hook(int argc, const char **argv, const char=
 *prefix)
     =20
    =20
      ## hook.c ##
    -@@ hook.c: int hook_exists(const char *name)
    - struct list_head* hook_list(const char* hookname)
    +@@ hook.c: struct list_head *list_hooks(const char *hookname)
      {
      	struct list_head *hook_head =3D xmalloc(sizeof(struct list_head));
    -+	const char *hook_path =3D find_hook(hookname);
    -+
     =20
    ++
      	INIT_LIST_HEAD(hook_head);
     =20
      	if (!hookname)
    - 		return NULL;
    +@@ hook.c: struct list_head *list_hooks(const char *hookname)
     =20
    --	if (have_git_dir()) {
    --		const char *hook_path =3D find_hook(hookname);
    + 	if (have_git_dir()) {
    + 		const char *hook_path =3D find_hook(hookname);
     -
     -		/* Add the hook from the hookdir */
    --		if (hook_path) {
    --			struct hook *to_add =3D xmalloc(sizeof(*to_add));
    --			to_add->hook_path =3D hook_path;
    --			to_add->feed_pipe_cb_data =3D NULL;
    --			list_add_tail(&to_add->list, hook_head);
    --		}
    -+	/* Add the hook from the hookdir */
    -+	if (hook_path) {
    -+		struct hook *to_add =3D xmalloc(sizeof(*to_add));
    -+		to_add->hook_path =3D hook_path;
    -+		to_add->feed_pipe_cb_data =3D NULL;
    -+		list_add_tail(&to_add->list, hook_head);
    - 	}
    -=20
    - 	return hook_head;
    + 		if (hook_path) {
    + 			struct hook *to_add =3D xmalloc(sizeof(*to_add));
    + 			to_add->hook_path =3D hook_path;
40:  eb4e03e22b !  4:  af14116d0f hook: allow running non-native hooks
    @@ builtin/hook.c: static int list(int argc, const char **argv, const c=
har *prefix)
      	hookname =3D argv[0];
     =20
     -	head =3D hook_list(hookname);
    -+	head =3D hook_list(hookname, 1);
    ++	head =3D list_hooks_gently(hookname);
     =20
    - 	if (list_empty(head)) {
    - 		printf(_("no commands configured for hook '%s'\n"),
    + 	if (list_empty(head))
    + 		return 1;
     @@ builtin/hook.c: static int run(int argc, const char **argv, const c=
har *prefix)
      	git_config(git_default_config, NULL);
     =20
      	hook_name =3D argv[0];
    --	hooks =3D hook_list(hook_name);
    -+	hooks =3D hook_list(hook_name, 1);
    +-	hooks =3D list_hooks(hook_name);
    ++	hooks =3D list_hooks_gently(hook_name);
      	if (list_empty(hooks)) {
      		/* ... act like run_hooks_oneshot() under --ignore-missing */
      		if (ignore_missing)
    @@ hook.c: static int known_hook(const char *name)
     +	const char *hook_path;
     =20
      	if (!known_hook(name))
    - 		die(_("the hook '%s' is not known to git, should be in hook-list.h =
via githooks(5)"),
    +-		die(_("the hook '%s' is not known to git, should be in hook-list.h =
via githooks(5)"),
    ++		BUG(_("the hook '%s' is not known to git, should be in hook-list.h =
via githooks(5)"),
      		    name);
     =20
     +	hook_path =3D find_hook_gently(name);
    @@ hook.c: static int known_hook(const char *name)
      	strbuf_git_path(&path, "hooks/%s", name);
      	if (access(path.buf, X_OK) < 0) {
     @@ hook.c: int hook_exists(const char *name)
    - 	return !!find_hook(name);
    + 	return !list_empty(list_hooks(name));
      }
     =20
    --struct list_head* hook_list(const char* hookname)
     +struct hook_config_cb
     +{
     +	struct strbuf *hook_key;
     +	struct list_head *list;
     +};
     +
    -+struct list_head* hook_list(const char* hookname, int allow_unknown)
    + struct list_head *list_hooks(const char *hookname)
      {
    - 	struct list_head *hook_head =3D xmalloc(sizeof(struct list_head));
    --	const char *hook_path =3D find_hook(hookname);
    -+	const char *hook_path;
    +-	struct list_head *hook_head =3D xmalloc(sizeof(struct list_head));
    ++	if (!known_hook(hookname))
    ++		BUG("Don't recognize hook event '%s'! "
    ++		    "Is it documented in Documentation/githooks.txt?",
    ++		    hookname);
    ++	return list_hooks_gently(hookname);
    ++}
     =20
    ++struct list_head *list_hooks_gently(const char *hookname)
    ++{
    ++	struct list_head *hook_head =3D xmalloc(sizeof(struct list_head));
     =20
      	INIT_LIST_HEAD(hook_head);
    -@@ hook.c: struct list_head* hook_list(const char* hookname)
    - 	if (!hookname)
    - 		return NULL;
    -=20
    -+	if (allow_unknown)
    -+		hook_path =3D find_hook_gently(hookname);
    -+	else
    -+		hook_path =3D find_hook(hookname);
    -+
    - 	/* Add the hook from the hookdir */
    - 	if (hook_path) {
    - 		struct hook *to_add =3D xmalloc(sizeof(*to_add));
    +=20
    +@@ hook.c: struct list_head *list_hooks(const char *hookname)
    + 		BUG("null hookname was provided to hook_list()!");
    +=20
    + 	if (have_git_dir()) {
    +-		const char *hook_path =3D find_hook(hookname);
    ++		const char *hook_path =3D find_hook_gently(hookname);
    + 		if (hook_path) {
    + 			struct hook *to_add =3D xmalloc(sizeof(*to_add));
    + 			to_add->hook_path =3D hook_path;
     @@ hook.c: int run_hooks_oneshot(const char *hook_name, struct run_hoo=
ks_opt *options)
      	if (options->path_to_stdin && options->feed_pipe)
      		BUG("choose only one method to populate stdin");
     =20
    --	hooks =3D hook_list(hook_name);
     +	/*
    -+	 * 'git hooks run <hookname>' uses run_found_hooks, so we don't need=
 to
    ++	 * 'git hooks run <hookname>' uses run_hooks, so we don't need to
     +	 * allow unknown hooknames here.
     +	 */
    -+	hooks =3D hook_list(hook_name, 0);
    + 	hooks =3D list_hooks(hook_name);
     =20
      	/*
    - 	 * If you need to act on a missing hook, use run_found_hooks()
    =20
      ## hook.h ##
     @@
    @@ hook.h
       * overwritten by further calls to find_hook and run_hook_*.
     + *
     + * If the hook is not a native hook (e.g. present in Documentation/gi=
thooks.txt)
    -+ * find_hook() will die(). find_hook_gently() does not consult the na=
tive hook
    ++ * find_hook() will BUG(). find_hook_gently() does not consult the na=
tive hook
     + * list and will check for any hook name in the hooks directory regar=
dless of
     + * whether it is known. find_hook() should be used by internal calls =
to hooks,
     + * and find_hook_gently() should only be used when the hookname was p=
rovided by
    @@ hook.h: struct hook {
       * Provides a linked list of 'struct hook' detailing commands which s=
hould run
       * in response to the 'hookname' event, in execution order.
     + *
    -+ * If allow_unknown is unset, hooks will be checked against the hook =
list
    -+ * generated from Documentation/githooks.txt. Otherwise, any hook nam=
e will be
    -+ * allowed. allow_unknown should only be set when the hook name is pr=
ovided by
    -+ * the user; internal calls to hook_list should make sure the hook th=
ey are
    -+ * invoking is present in Documentation/githooks.txt.
    ++ * list_hooks() checks the provided hookname against Documentation/gi=
thooks.txt
    ++ * and BUG()s if it is not found.  list_hooks_gently() allows any hoo=
kname. The
    ++ * latter should only be used when the hook name is provided by the u=
ser, and
    ++ * the former should be used by internal callers.
       */
    --struct list_head* hook_list(const char *hookname);
    -+struct list_head* hook_list(const char *hookname, int allow_unknown);
    + struct list_head *list_hooks(const char *hookname);
    ++struct list_head *list_hooks_gently(const char *hookname);
     =20
      struct run_hooks_opt
      {
41:  2c8e874158 !  5:  2bbb179962 hook: include hooks from the config
    @@ Commit message
    =20
      ## Documentation/config/hook.txt ##
     @@
    -+hook.<command>.command::
    -+	A command to execute during the <command> hook event. This can be an
    -+	executable on your device, a oneliner for your shell, or the name of=
 a
    -+	hookcmd. See linkgit:git-hook[1].
    ++hook.<name>.command::
    ++	A command to execute whenever `hook.<name>` is invoked. `<name>` sho=
uld
    ++	be a unique "friendly" name which you can use to identify this hook
    ++	command. (You can specify when to invoke this command with
    ++	`hook.<name>.event`.) The value can be an executable on your device =
or a
    ++	oneliner for your shell. If more than one value is specified for the
    ++	same `<name>`, the last value parsed will be the only command execut=
ed.
    ++	See linkgit:git-hook[1].
    ++
    ++hook.<name>.event::
    ++	The hook events which should invoke `hook.<name>`. `<name>` should b=
e a
    ++	unique "friendly" name which you can use to identify this hook. The
    ++	value should be the name of a hook event, like "pre-commit" or "upda=
te".
    ++	(See linkgit:githooks[5] for a complete list of hooks Git knows abou=
t.)
    ++	On the specified event, the associated `hook.<name>.command` will be
    ++	executed. More than one event can be specified if you wish for
    ++	`hook.<name>` to execute on multiple events. See linkgit:git-hook[1]=
.
     +
      hook.jobs::
      	Specifies how many hooks can be run simultaneously during paralleliz=
ed
    @@ Documentation/git-hook.txt: Git is unlikely to use for a native hook=
 later on. F
     +    event =3D pre-commit
     +    command =3D ~/bin/linter --c
     +
    -+Conmmands are run in the order Git encounters their associated
    ++In this example, `[hook "linter"]` represents one script - `~/bin/lin=
ter --c` -
    ++which can be shared by many repos, and even by many hook events, if a=
ppropriate.
    ++
    ++Commands are run in the order Git encounters their associated
     +`hook.<name>.event` configs during the configuration parse (see
    -+linkgit:git-config[1]).
    ++linkgit:git-config[1]). Although multiple `hook.linter.event` configs=
 can be
    ++added, only one `hook.linter.command` event is valid - Git uses "last=
-one-wins"
    ++to determine which command to run.
    ++
    ++So if you wanted your linter to run when you commit as well as when y=
ou push,
    ++you would configure it like so:
    ++
    ++  [hook "linter"]
    ++    event =3D pre-commit
    ++    event =3D pre-push
    ++    command =3D ~/bin/linter --c
    ++
    ++With this config, `~/bin/linter --c` would be run by Git before a com=
mit is
    ++generated (during `pre-commit`) as well as before a push is performed=
 (during
    ++`pre-push`).
    ++
    ++And if you wanted to run your linter as well as a secret-leak detecto=
r during
    ++only the "pre-commit" hook event, you would configure it instead like=
 so:
    ++
    ++  [hook "linter"]
    ++    event =3D pre-commit
    ++    command =3D ~/bin/linter --c
    ++  [hook "no-leaks"]
    ++    event =3D pre-commit
    ++    command =3D ~/bin/leak-detector
    ++
    ++With this config, before a commit is generated (during `pre-commit`),=
 Git would
    ++first start `~/bin/linter --c` and second start `~/bin/leak-detector`=
. It would
    ++evaluate the output of each when deciding whether to proceed with the=
 commit.
    ++
    ++For a full list of hook events which you can set your `hook.<name>.ev=
ent` to,
    ++and how hooks are invoked during those events, see linkgit:githooks[5=
].
     +
     +In general, when instructions suggest adding a script to
     +`.git/hooks/<hook-event>`, you can specify it in the config instead b=
y running
    @@ Documentation/git-hook.txt: Git is unlikely to use for a native hook=
 later on. F
      optional `--` (or `--end-of-options`, see linkgit:gitcli[7]). The
    =20
      ## builtin/hook.c ##
    -@@ builtin/hook.c: static int list(int argc, const char **argv, const =
char *prefix)
    - 	head =3D hook_list(hookname, 1);
    -=20
    - 	if (list_empty(head)) {
    --		printf(_("no commands configured for hook '%s'\n"),
    -+		printf(_("no hooks configured for event '%s'\n"),
    - 		       hookname);
    - 		return 0;
    - 	}
     @@ builtin/hook.c: static int list(int argc, const char **argv, const =
char *prefix)
      		struct hook *item =3D list_entry(pos, struct hook, list);
      		item =3D list_entry(pos, struct hook, list);
    @@ hook.c: static void free_hook(struct hook *ptr)
      static void remove_hook(struct list_head *to_remove)
      {
      	struct hook *hook_to_remove =3D list_entry(to_remove, struct hook, l=
ist);
    -@@ hook.c: const char *find_hook_gently(const char *name)
    -=20
    - int hook_exists(const char *name)
    - {
    --	return !!find_hook(name);
    -+	return !list_empty(hook_list(name, 0));
    - }
    +@@ hook.c: int hook_exists(const char *name)
     =20
      struct hook_config_cb
      {
    @@ hook.c: const char *find_hook_gently(const char *name)
      	struct list_head *list;
      };
     =20
    --struct list_head* hook_list(const char* hookname, int allow_unknown)
     +/*
     + * Callback for git_config which adds configured hooks to a hook list=
.  Hooks
     + * can be configured by specifying both hook.<friend-name>.command =
=3D <path> and
    @@ hook.c: const char *find_hook_gently(const char *name)
     +	return 0;
     +}
     +
    -+struct list_head* hook_list(const char *hookname, int allow_unknown)
    + struct list_head *list_hooks(const char *hookname)
    + {
    + 	if (!known_hook(hookname))
    +@@ hook.c: struct list_head *list_hooks(const char *hookname)
    + struct list_head *list_hooks_gently(const char *hookname)
      {
      	struct list_head *hook_head =3D xmalloc(sizeof(struct list_head));
    --	const char *hook_path;
     +	struct hook_config_cb cb_data =3D {
     +		.hook_event =3D hookname,
     +		.list =3D hook_head,
     +	};
     =20
    -+	if (!allow_unknown && !known_hook(hookname))
    -+		die(_("Don't recognize hook event '%s'. "
    -+		      "Is it documented in 'githooks.txt'?"),
    -+		      hookname);
    -=20
      	INIT_LIST_HEAD(hook_head);
     =20
      	if (!hookname)
    - 		return NULL;
    + 		BUG("null hookname was provided to hook_list()!");
     =20
    --	if (allow_unknown)
    --		hook_path =3D find_hook_gently(hookname);
    --	else
    --		hook_path =3D find_hook(hookname);
    +-	if (have_git_dir()) {
    +-		const char *hook_path =3D find_hook_gently(hookname);
    +-		if (hook_path) {
    +-			struct hook *to_add =3D xmalloc(sizeof(*to_add));
    +-			to_add->hook_path =3D hook_path;
    +-			to_add->feed_pipe_cb_data =3D NULL;
    +-			list_add_tail(&to_add->list, hook_head);
    +-		}
    +-	}
     +	/* Add the hooks from the config, e.g. hook.myhook.event =3D pre-com=
mit */
     +	git_config(hook_config_lookup, &cb_data);
    -=20
    --	/* Add the hook from the hookdir */
    --	if (hook_path) {
    --		struct hook *to_add =3D xmalloc(sizeof(*to_add));
    --		to_add->hook_path =3D hook_path;
    --		to_add->feed_pipe_cb_data =3D NULL;
    --		list_add_tail(&to_add->list, hook_head);
    --	}
    ++
     +	/* Add the hook from the hookdir. The placeholder makes it easier to
     +	 * allocate work in pick_next_hook. */
     +	if (find_hook_gently(hookname))
    @@ hook.c: static int notify_start_failure(struct strbuf *out,
     =20
      	return 1;
      }
    -@@ hook.c: int run_hooks_oneshot(const char *hook_name, struct run_hoo=
ks_opt *options)
    - 		BUG("choose only one method to populate stdin");
    -=20
    - 	/*
    --	 * 'git hooks run <hookname>' uses run_found_hooks, so we don't need=
 to
    -+	 * 'git hooks run <hookname>' uses run_found_hooks, and we want to m=
ake
    -+	 * sure internal callers are using known hooks, so we don't need to
    - 	 * allow unknown hooknames here.
    - 	 */
    - 	hooks =3D hook_list(hook_name, 0);
    =20
      ## hook.h ##
     @@ hook.h: int hook_exists(const char *hookname);
42:  3216e51b6b !  6:  30ffe98601 hook: allow out-of-repo 'git hook' invoca=
tions
    @@ git.c: static struct cmd_struct commands[] =3D {
      	{ "init-db", cmd_init_db },
    =20
      ## hook.c ##
    -@@ hook.c: struct list_head* hook_list(const char *hookname, int allow=
_unknown)
    +@@ hook.c: struct list_head *list_hooks_gently(const char *hookname)
     =20
      	/* Add the hook from the hookdir. The placeholder makes it easier to
      	 * allocate work in pick_next_hook. */
--=20
2.33.0.rc2.250.ged5fa647cd-goog

