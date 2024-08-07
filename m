Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0ED18FC9B
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013827; cv=none; b=iaRtOpEK+cliZ6hxp2GvXfDXgPYT8qqajde0caAd0vVMmfrkXNvvgp1m+yi3BSDz5AeBZ08CGqw78Ey21ACkDB8jxvLdE7kRMZrzF+ME+ffAYGJsTOwVG1v+ERhDNru5HHS2K05EAbp2yZD90q/qDG9kVDtN1UA8PAEl9zYggXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013827; c=relaxed/simple;
	bh=wl3E4/uN880lZtSXZnoBcfyNB0tlKZURls70twNPfIc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYl8J7tqRzDEpvy5DGJO8Uj+/P/14/ow891CWz0v4Lli0jbkpy2t4TikTafpBOi04oqhfwKzuWpveSuJtKMjQN7Lcwvdtj1cm25Y6/ZekpYWOHTS2aMqngEEBUrxm/9L5TfeaHQN/9W1OCJvwLgyntpHmLDqrOz2+qo+dgk/BgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XY44oUb8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hdj47ww3; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XY44oUb8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hdj47ww3"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id C97DB138FCA2
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 02:57:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 07 Aug 2024 02:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723013824; x=1723100224; bh=XyrdssCvXH
	ox+b01MDR3i6tsp2GN4Y/B7MGBUwh09k0=; b=XY44oUb85cCqBcMkfmZE6DHnk9
	pedwMULywIJsAPkeo5UzLga5e/SfcH8sI1+rUmPdcccr90hLsg6hRVWU8QBuEMRK
	wkCPVeMghcIO0bWfvRMy+A5GO6Hf15NR6xeBGCzZytJORzM7SPjpdw2aok0YQT6R
	Jdh3ERuRMpC+9SFw3SmAvU4Be6+36YPOLZRd1vIVAhgozmKLqboiquh2Jv2AQpFB
	bEbbkq5f5KJzqZh7Tt5sxTMGqYwFK+0Ayn9k2Zk+8ffTOWcnzSK3O+6RLTfA8jsK
	vGamtXeSSgu/p0Hi2tPW6zkp+k+LUFzcpRdRxymXZZ96L0yBftKN91Z0F++g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723013824; x=1723100224; bh=XyrdssCvXHox+b01MDR3i6tsp2GN
	4Y/B7MGBUwh09k0=; b=hdj47ww3PDg3sHU0xNBQG+hfGIHKF0KUOgLuiD3kgqQG
	hJTxmuyGjQp/0iEmuw1J382oMJ8lTvNPVYQs3bnCtqFFKontHA9SkmxD7LH9wxwI
	btJSkTv81rUxAbbwip6K8IL0+Umxh3ukrjyDECFipkoKAjZaPSXu/NTpfqQwuPmW
	GKobxC1ITbsnATL+b2U7iXOSNU959TjG3AqM28K0sHBfCyS7YkvUznFsoda5f88v
	mfHUTjHOmkkCgGdXbOfp6sWdNJmJAVYapAh9xK8Phvry2BrcBOsKtchPKRO6hE5J
	zMLJZnzcvbsGR9K8LVGKjk6Irfurmv2WcI/jW2h82w==
X-ME-Sender: <xms:wBqzZoYqtkxpftoMhNiPv2qK3PwLc8SrbuncN_H2nJFwppMLAzsgcg>
    <xme:wBqzZjabQgMV1VAURzEc0opouqVy8_cQhG_yeDRsQYggHAXo7-KbhEx1J_GeE3jnc
    FJmsH2bOCu2PtzY2g>
X-ME-Received: <xmr:wBqzZi_y9htM0asbtpGEu9M3LCbhBNL243KUYxyqLA8tRiFSMZepoOH5ELmXWNK4PfnCPVlXBvEgcv18uU5sMcgF_FL9IqXL3z8TEjG6ynXT-86n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:wBqzZirE8g-6TZ3cPBr-ACPN42m0I57BrGfDjXq9aKJHBx8tf5iQsw>
    <xmx:wBqzZjoGl2XkQXWku-KHMB2OLMNYlX-o_dTnktW7ZZZkXxlkofDVZw>
    <xmx:wBqzZgRfRHsO0sOOX0c5hr1vgO2NmO9as-gTKeaFnV-ygHT92eqwDA>
    <xmx:wBqzZjqex2vl-hWovhfpTohC2wDJR1hGkftYi-tfzQhnb7IUIZif0g>
    <xmx:wBqzZsBqimFzzRycm-xm8ZDnug7NZbNj58pglWeLq7M5VTDuej7Cj14q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 7 Aug 2024 02:57:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id db8d2e15 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 7 Aug 2024 06:56:59 +0000 (UTC)
Date: Wed, 7 Aug 2024 08:57:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 04/20] hooks: remove implicit dependency on `the_repository`
Message-ID: <9a0964aff3a91fe017992ad2d0266c18b7262ee1.1723013714.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qSfdIMPx+xRBRMb+"
Content-Disposition: inline
In-Reply-To: <cover.1723013714.git.ps@pks.im>


--qSfdIMPx+xRBRMb+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We implicitly depend on `the_repository` in our hook subsystem because
we use `strbuf_git_path()` to compute hook paths. Remove this dependency
by accepting a `struct repository` as parameter instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/am.c           |  9 +++++----
 builtin/bugreport.c    |  2 +-
 builtin/checkout.c     |  2 +-
 builtin/clone.c        |  2 +-
 builtin/gc.c           |  2 +-
 builtin/hook.c         |  2 +-
 builtin/merge.c        |  2 +-
 builtin/rebase.c       |  2 +-
 builtin/receive-pack.c | 10 +++++-----
 builtin/worktree.c     |  2 +-
 commit.c               |  2 +-
 hook.c                 | 21 +++++++++++----------
 hook.h                 | 13 ++++++++-----
 read-cache.c           |  6 +++---
 refs.c                 |  2 +-
 reset.c                |  2 +-
 sequencer.c            |  6 +++---
 transport.c            |  2 +-
 18 files changed, 47 insertions(+), 42 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index a12be088f7..d8875ad402 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -490,7 +490,8 @@ static int run_applypatch_msg_hook(struct am_state *sta=
te)
 	assert(state->msg);
=20
 	if (!state->no_verify)
-		ret =3D run_hooks_l("applypatch-msg", am_path(state, "final-commit"), NU=
LL);
+		ret =3D run_hooks_l(the_repository, "applypatch-msg",
+				  am_path(state, "final-commit"), NULL);
=20
 	if (!ret) {
 		FREE_AND_NULL(state->msg);
@@ -512,7 +513,7 @@ static int run_post_rewrite_hook(const struct am_state =
*state)
 	strvec_push(&opt.args, "rebase");
 	opt.path_to_stdin =3D am_path(state, "rewritten");
=20
-	return run_hooks_opt("post-rewrite", &opt);
+	return run_hooks_opt(the_repository, "post-rewrite", &opt);
 }
=20
 /**
@@ -1663,7 +1664,7 @@ static void do_commit(const struct am_state *state)
 	const char *reflog_msg, *author, *committer =3D NULL;
 	struct strbuf sb =3D STRBUF_INIT;
=20
-	if (!state->no_verify && run_hooks("pre-applypatch"))
+	if (!state->no_verify && run_hooks(the_repository, "pre-applypatch"))
 		exit(1);
=20
 	if (write_index_as_tree(&tree, the_repository->index, get_index_file(), 0=
, NULL))
@@ -1716,7 +1717,7 @@ static void do_commit(const struct am_state *state)
 		fclose(fp);
 	}
=20
-	run_hooks("post-applypatch");
+	run_hooks(the_repository, "post-applypatch");
=20
 	free_commit_list(parents);
 	strbuf_release(&sb);
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index b3cc77af53..bdfed3d8f1 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -58,7 +58,7 @@ static void get_populated_hooks(struct strbuf *hook_info,=
 int nongit)
 	for (p =3D hook_name_list; *p; p++) {
 		const char *hook =3D *p;
=20
-		if (hook_exists(hook))
+		if (hook_exists(the_repository, hook))
 			strbuf_addf(hook_info, "%s\n", hook);
 	}
 }
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0f21ddd2c6..89543b3054 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -125,7 +125,7 @@ static void branch_info_release(struct branch_info *inf=
o)
 static int post_checkout_hook(struct commit *old_commit, struct commit *ne=
w_commit,
 			      int changed)
 {
-	return run_hooks_l("post-checkout",
+	return run_hooks_l(the_repository, "post-checkout",
 			   oid_to_hex(old_commit ? &old_commit->object.oid : null_oid()),
 			   oid_to_hex(new_commit ? &new_commit->object.oid : null_oid()),
 			   changed ? "1" : "0", NULL);
diff --git a/builtin/clone.c b/builtin/clone.c
index af6017d41a..29d4b79eb5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -788,7 +788,7 @@ static int checkout(int submodule_progress, int filter_=
submodules)
 	if (write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
=20
-	err |=3D run_hooks_l("post-checkout", oid_to_hex(null_oid()),
+	err |=3D run_hooks_l(the_repository, "post-checkout", oid_to_hex(null_oid=
()),
 			   oid_to_hex(&oid), "1", NULL);
=20
 	if (!err && (option_recurse_submodules.nr > 0)) {
diff --git a/builtin/gc.c b/builtin/gc.c
index 72bac2554f..2ca6288c6b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -463,7 +463,7 @@ static int need_to_gc(void)
 	else
 		return 0;
=20
-	if (run_hooks("pre-auto-gc"))
+	if (run_hooks(the_repository, "pre-auto-gc"))
 		return 0;
 	return 1;
 }
diff --git a/builtin/hook.c b/builtin/hook.c
index 5234693a94..cc37438fde 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -58,7 +58,7 @@ static int run(int argc, const char **argv, const char *p=
refix)
 	hook_name =3D argv[0];
 	if (!ignore_missing)
 		opt.error_if_missing =3D 1;
-	ret =3D run_hooks_opt(hook_name, &opt);
+	ret =3D run_hooks_opt(the_repository, hook_name, &opt);
 	if (ret < 0) /* error() return */
 		ret =3D 1;
 	return ret;
diff --git a/builtin/merge.c b/builtin/merge.c
index c896b18d1a..662a49a0e8 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -478,7 +478,7 @@ static void finish(struct commit *head_commit,
 	}
=20
 	/* Run a post-merge hook */
-	run_hooks_l("post-merge", squash ? "1" : "0", NULL);
+	run_hooks_l(the_repository, "post-merge", squash ? "1" : "0", NULL);
=20
 	if (new_head)
 		apply_autostash_ref(the_repository, "MERGE_AUTOSTASH");
diff --git a/builtin/rebase.c b/builtin/rebase.c
index e3a8e74cfc..fa0ca613e1 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1774,7 +1774,7 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
=20
 	/* If a hook exists, give it a chance to interrupt*/
 	if (!ok_to_skip_pre_rebase &&
-	    run_hooks_l("pre-rebase", options.upstream_arg,
+	    run_hooks_l(the_repository, "pre-rebase", options.upstream_arg,
 			argc ? argv[0] : NULL, NULL))
 		die(_("The pre-rebase hook refused to rebase."));
=20
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 339524ae2a..4ff22d8b15 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -792,7 +792,7 @@ static int run_and_feed_hook(const char *hook_name, fee=
d_fn feed,
 	struct child_process proc =3D CHILD_PROCESS_INIT;
 	struct async muxer;
 	int code;
-	const char *hook_path =3D find_hook(hook_name);
+	const char *hook_path =3D find_hook(the_repository, hook_name);
=20
 	if (!hook_path)
 		return 0;
@@ -922,7 +922,7 @@ static int run_update_hook(struct command *cmd)
 {
 	struct child_process proc =3D CHILD_PROCESS_INIT;
 	int code;
-	const char *hook_path =3D find_hook("update");
+	const char *hook_path =3D find_hook(the_repository, "update");
=20
 	if (!hook_path)
 		return 0;
@@ -1098,7 +1098,7 @@ static int run_proc_receive_hook(struct command *comm=
ands,
 	int hook_use_push_options =3D 0;
 	int version =3D 0;
 	int code;
-	const char *hook_path =3D find_hook("proc-receive");
+	const char *hook_path =3D find_hook(the_repository, "proc-receive");
=20
 	if (!hook_path) {
 		rp_error("cannot find hook 'proc-receive'");
@@ -1409,7 +1409,7 @@ static const char *push_to_checkout(unsigned char *ha=
sh,
 	strvec_pushf(env, "GIT_WORK_TREE=3D%s", absolute_path(work_tree));
 	strvec_pushv(&opt.env, env->v);
 	strvec_push(&opt.args, hash_to_hex(hash));
-	if (run_hooks_opt(push_to_checkout_hook, &opt))
+	if (run_hooks_opt(the_repository, push_to_checkout_hook, &opt))
 		return "push-to-checkout hook declined";
 	else
 		return NULL;
@@ -1618,7 +1618,7 @@ static void run_update_post_hook(struct command *comm=
ands)
 	struct child_process proc =3D CHILD_PROCESS_INIT;
 	const char *hook;
=20
-	hook =3D find_hook("post-update");
+	hook =3D find_hook(the_repository, "post-update");
 	if (!hook)
 		return;
=20
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 1d51e54fcd..a4b7f24e1e 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -573,7 +573,7 @@ static int add_worktree(const char *path, const char *r=
efname,
 			     NULL);
 		opt.dir =3D path;
=20
-		ret =3D run_hooks_opt("post-checkout", &opt);
+		ret =3D run_hooks_opt(the_repository, "post-checkout", &opt);
 	}
=20
 	strvec_clear(&child_env);
diff --git a/commit.c b/commit.c
index 087cb19f4f..24ab5c1b50 100644
--- a/commit.c
+++ b/commit.c
@@ -1960,5 +1960,5 @@ int run_commit_hook(int editor_is_used, const char *i=
ndex_file,
 	va_end(args);
=20
 	opt.invoked_hook =3D invoked_hook;
-	return run_hooks_opt(name, &opt);
+	return run_hooks_opt(the_repository, name, &opt);
 }
diff --git a/hook.c b/hook.c
index 7e90787bca..a9320cb0ce 100644
--- a/hook.c
+++ b/hook.c
@@ -10,14 +10,14 @@
 #include "environment.h"
 #include "setup.h"
=20
-const char *find_hook(const char *name)
+const char *find_hook(struct repository *r, const char *name)
 {
 	static struct strbuf path =3D STRBUF_INIT;
=20
 	int found_hook;
=20
 	strbuf_reset(&path);
-	strbuf_git_path(&path, "hooks/%s", name);
+	strbuf_repo_git_path(&path, r, "hooks/%s", name);
 	found_hook =3D access(path.buf, X_OK) >=3D 0;
 #ifdef STRIP_EXTENSION
 	if (!found_hook) {
@@ -48,9 +48,9 @@ const char *find_hook(const char *name)
 	return path.buf;
 }
=20
-int hook_exists(const char *name)
+int hook_exists(struct repository *r, const char *name)
 {
-	return !!find_hook(name);
+	return !!find_hook(r, name);
 }
=20
 static int pick_next_hook(struct child_process *cp,
@@ -121,7 +121,8 @@ static void run_hooks_opt_clear(struct run_hooks_opt *o=
ptions)
 	strvec_clear(&options->args);
 }
=20
-int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
+int run_hooks_opt(struct repository *r, const char *hook_name,
+		  struct run_hooks_opt *options)
 {
 	struct strbuf abs_path =3D STRBUF_INIT;
 	struct hook_cb_data cb_data =3D {
@@ -129,7 +130,7 @@ int run_hooks_opt(const char *hook_name, struct run_hoo=
ks_opt *options)
 		.hook_name =3D hook_name,
 		.options =3D options,
 	};
-	const char *const hook_path =3D find_hook(hook_name);
+	const char *const hook_path =3D find_hook(r, hook_name);
 	int ret =3D 0;
 	const struct run_process_parallel_opts opts =3D {
 		.tr2_category =3D "hook",
@@ -173,14 +174,14 @@ int run_hooks_opt(const char *hook_name, struct run_h=
ooks_opt *options)
 	return ret;
 }
=20
-int run_hooks(const char *hook_name)
+int run_hooks(struct repository *r, const char *hook_name)
 {
 	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
=20
-	return run_hooks_opt(hook_name, &opt);
+	return run_hooks_opt(r, hook_name, &opt);
 }
=20
-int run_hooks_l(const char *hook_name, ...)
+int run_hooks_l(struct repository *r, const char *hook_name, ...)
 {
 	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
 	va_list ap;
@@ -191,5 +192,5 @@ int run_hooks_l(const char *hook_name, ...)
 		strvec_push(&opt.args, arg);
 	va_end(ap);
=20
-	return run_hooks_opt(hook_name, &opt);
+	return run_hooks_opt(r, hook_name, &opt);
 }
diff --git a/hook.h b/hook.h
index 6511525aeb..11863fa734 100644
--- a/hook.h
+++ b/hook.h
@@ -2,6 +2,8 @@
 #define HOOK_H
 #include "strvec.h"
=20
+struct repository;
+
 struct run_hooks_opt
 {
 	/* Environment vars to be set for each hook */
@@ -55,12 +57,12 @@ struct hook_cb_data {
  * or disabled. Note that this points to static storage that will be
  * overwritten by further calls to find_hook and run_hook_*.
  */
-const char *find_hook(const char *name);
+const char *find_hook(struct repository *r, const char *name);
=20
 /**
  * A boolean version of find_hook()
  */
-int hook_exists(const char *hookname);
+int hook_exists(struct repository *r, const char *hookname);
=20
 /**
  * Takes a `hook_name`, resolves it to a path with find_hook(), and
@@ -70,13 +72,14 @@ int hook_exists(const char *hookname);
  * Returns the status code of the run hook, or a negative value on
  * error().
  */
-int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options);
+int run_hooks_opt(struct repository *r, const char *hook_name,
+		  struct run_hooks_opt *options);
=20
 /**
  * A wrapper for run_hooks_opt() which provides a dummy "struct
  * run_hooks_opt" initialized with "RUN_HOOKS_OPT_INIT".
  */
-int run_hooks(const char *hook_name);
+int run_hooks(struct repository *r, const char *hook_name);
=20
 /**
  * Like run_hooks(), a wrapper for run_hooks_opt().
@@ -87,5 +90,5 @@ int run_hooks(const char *hook_name);
  * hook. This function behaves like the old run_hook_le() API.
  */
 LAST_ARG_MUST_BE_NULL
-int run_hooks_l(const char *hook_name, ...);
+int run_hooks_l(struct repository *r, const char *hook_name, ...);
 #endif
diff --git a/read-cache.c b/read-cache.c
index 48bf24f87c..742369b295 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3156,9 +3156,9 @@ static int do_write_locked_index(struct index_state *=
istate,
 	else
 		ret =3D close_lock_file_gently(lock);
=20
-	run_hooks_l("post-index-change",
-			istate->updated_workdir ? "1" : "0",
-			istate->updated_skipworktree ? "1" : "0", NULL);
+	run_hooks_l(the_repository, "post-index-change",
+		    istate->updated_workdir ? "1" : "0",
+		    istate->updated_skipworktree ? "1" : "0", NULL);
 	istate->updated_workdir =3D 0;
 	istate->updated_skipworktree =3D 0;
=20
diff --git a/refs.c b/refs.c
index e082fc59b0..0afc70b51b 100644
--- a/refs.c
+++ b/refs.c
@@ -2132,7 +2132,7 @@ static int run_transaction_hook(struct ref_transactio=
n *transaction,
 	const char *hook;
 	int ret =3D 0, i;
=20
-	hook =3D find_hook("reference-transaction");
+	hook =3D find_hook(transaction->ref_store->repo, "reference-transaction");
 	if (!hook)
 		return ret;
=20
diff --git a/reset.c b/reset.c
index 9550dea03d..b22b1be792 100644
--- a/reset.c
+++ b/reset.c
@@ -79,7 +79,7 @@ static int update_refs(const struct reset_head_opts *opts,
 						 reflog_head);
 	}
 	if (!ret && run_hook)
-		run_hooks_l("post-checkout",
+		run_hooks_l(the_repository, "post-checkout",
 			    oid_to_hex(head ? head : null_oid()),
 			    oid_to_hex(oid), "1", NULL);
 	strbuf_release(&msg);
diff --git a/sequencer.c b/sequencer.c
index 0291920f0b..edeeec6f15 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1316,7 +1316,7 @@ static int run_rewrite_hook(const struct object_id *o=
ldoid,
 	struct child_process proc =3D CHILD_PROCESS_INIT;
 	int code;
 	struct strbuf sb =3D STRBUF_INIT;
-	const char *hook_path =3D find_hook("post-rewrite");
+	const char *hook_path =3D find_hook(the_repository, "post-rewrite");
=20
 	if (!hook_path)
 		return 0;
@@ -1614,7 +1614,7 @@ static int try_to_commit(struct repository *r,
 		}
 	}
=20
-	if (hook_exists("prepare-commit-msg")) {
+	if (hook_exists(r, "prepare-commit-msg")) {
 		res =3D run_prepare_commit_msg_hook(r, msg, hook_commit);
 		if (res)
 			goto out;
@@ -5149,7 +5149,7 @@ static int pick_commits(struct repository *r,
=20
 			hook_opt.path_to_stdin =3D rebase_path_rewritten_list();
 			strvec_push(&hook_opt.args, "rebase");
-			run_hooks_opt("post-rewrite", &hook_opt);
+			run_hooks_opt(r, "post-rewrite", &hook_opt);
 		}
 		apply_autostash(rebase_path_autostash());
=20
diff --git a/transport.c b/transport.c
index 12cc5b4d96..f8cd2810a5 100644
--- a/transport.c
+++ b/transport.c
@@ -1271,7 +1271,7 @@ static int run_pre_push_hook(struct transport *transp=
ort,
 	struct ref *r;
 	struct child_process proc =3D CHILD_PROCESS_INIT;
 	struct strbuf buf;
-	const char *hook_path =3D find_hook("pre-push");
+	const char *hook_path =3D find_hook(the_repository, "pre-push");
=20
 	if (!hook_path)
 		return 0;
--=20
2.46.0.dirty


--qSfdIMPx+xRBRMb+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazGrwACgkQVbJhu7ck
PpTJDw//XDMMFNvnaNiPjl01VLb7KaoRcz9c+fzsxmc+PIQ7FdfqdqESrDQGQ3oU
x7fhebVDezaxzOeSfc1nJyGpTmESeoVLU66xMn+Z99W07JzMLlZG34lesoqVvyYD
cctDWZFelHZYvEZE19y1Gry7qVoEP32phf9GBr6M5Vlk/X1ZkpH5hkljlZ1sWaQj
VZPm1/AQ4vPS1+WM6TGjhF3ENYQcKgOY69nZ5Pd+7XzKjx0FqKfRvN3cDb48TzZM
SeoDZ0Ni412flFxfADLNQ3dDmzW1Gm0qZ9rckG3MUN5svLHKR0c2UFtJxEJbLR+W
SwlMuZizzToGIuTBYBCTvnfXuzS4VFA3ZvDsC0uoTqyAfxiPACm67LnB0Gza7469
QID1bgFcC9Y7x58CMXkl0X0aCbxeLPCiiojDsjDH7SZ0rlq9jz64Ts4qai8ZokDJ
aw4eqzMSKrYJ7AgmIT6KJKZUXYdkR4QkmCc2SC8kSsRk+fSe2EfAuehIV/gMMi7J
/izvH/HbySpj2gGcc5hy8uDcMIY1ssmMcra8+mGEh571sAgFK85R7Y72WPPau6zQ
Pcy0VNFkSbWx8nmnFbXuLiCq/yh0WhUb+JOxKlMJl0pyQSk1qA9yBlgl8iXZx7uU
lIz7WrA4U9FR2OvPhjldn3a1Pv2IY36a+RNJPLxfPCWq5tetAqA=
=j3Ij
-----END PGP SIGNATURE-----

--qSfdIMPx+xRBRMb+--
