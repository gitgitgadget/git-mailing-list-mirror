Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6327241F367
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205501; cv=none; b=PKRTOGqRANkqTkUCDB0hTMQhnRbPEB7AEmum1XsoVZYYtmEfM0tM62KJzagjxCRmS0ynX/iKfCTo53JnM2GgpWnJCUqGp67mvjWVulk4D3vZUOCpezbG0JhPBttsbzx4UFlhRRbYg6SwbWG8QTjMMF8BvWLVlP9viTjFX1iur2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205501; c=relaxed/simple;
	bh=JqS54EPx38nrCwK4dS+3enMWWaAnxKA2dRqL5SVJM2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hXtTZFzlTtAQpin74Sp4tBw4trgLuK+5w+ub7tcl3iMcXcQck9IUc/X0BCgnH8lwbT1aF7IG00JTtCW4MWnuZrJq8qW70u6LKVzw9MXSbVd9dL348g+OkXUTqBYTSFxtk3MN06TnYnVAUebmiKYcRZGjd5sQp+YFSzrByfam87I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nKkmTvj7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d+0Ox38P; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nKkmTvj7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d+0Ox38P"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 78A36EC0170
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 08:38:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 16 Jul 2026 08:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784205498;
	 x=1784291898; bh=7D1lFGxNpZW4Ze/I1Be3WudtHyj2W+LA6U4136jOm68=; b=
	nKkmTvj7NrW0jR10URaZ7P0p/blj/biLDE9MaMoFlJi4PdCvUteCiEfK6zdpnzO5
	2ar+/eY4y5mfc9gAbQIOHTK6b/yi69u59Kys40SY23slBRWGNm1YVGWWNFL+lRkH
	Ckbwb7pZ5y2oT93XVphnkqTWeCo8rt4ttqeQBV0ncbTz5BQH6KFRL8yqjXYBT0Gx
	pc7dQZPdW7Bt59+bNviM8G9ugzikwFZrSP5gvawSDF1ITrrc+hu7sCcNmSW1Mvxx
	psX9FmYeC6eHx0loWCyLxcCzjPzeDg5JzNmIcW8ihpbqqQMgBAjlxtP6lt8Wve2J
	76Wq3eblRqX+hhH1F4GVag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784205498; x=
	1784291898; bh=7D1lFGxNpZW4Ze/I1Be3WudtHyj2W+LA6U4136jOm68=; b=d
	+0Ox38P0UQr2/bcPKsZ5KfluoetLS6/GqLGZQ7CygSMU/rnkFJk+IWBcezpYKLeJ
	NJkRzeSVr1fv3aJciyUO+q8ugJDO+64yz5Okc1YnIvEsde5mwQlcKXh8Yp8FxRqX
	qevPd901h5KaDVIgGgEHyrGiUASVyh1CNsVW9zLWSeoZagf6UQwlXijdiJs7omfY
	np5ABOa1kdHZ7FlCLSAgacBQ19MGk3ADODqlH1wgXevtCbWnOOqECBhYNAIxQWkq
	d80QtGQfv4mbkPu/a8SdSJxImfEe9p+NAuHuO6SK56eh2LE2D6lkYbSzKXVHfajl
	FVjVOi5tqaUyaSXQksGOg==
X-ME-Sender: <xms:utBYaphQrwZYU40kJqN4XzplxbJVQZTdrtb_7MsLYZU21Q2ug7lakA>
    <xme:utBYak_1zR3r3ePF4iUm8Om-vWh5DOGE6NDaW8gNZbj3Yq5cjcibcYO1GhS9W4Ikp
    _2-FWHR1C0MEGf_eo9boogi32ZMASPhCxRWTpZ-I7bgbMSE0Xtm_A>
X-ME-Received: <xmr:utBYauvXDN5InmuZUnjE0FcGekeJmCNoJZB8d_s9PIOExO09XhOLMt23WbtPwVorDkT4ZNfeXHlQBk5vsWpE-hlc51pOSlZEFeOIQMOh>
X-ME-Proxy-Cause: dmFkZTGRj4TwDsjFrrSOvrOicNxtGnj7zyVq5svFdmrzVQICEC+hEsRkJA5sXtRXGkL/ti
    njETPH/1MVqKXv8SNbk2cmFaahE+CDe576lxg6KzCyDVK4iphcTVl/MXCoYNqiNHeaAUh9
    bz89uXHPuiw9w5xRpnBX/xFTJ1+D9AvOUhsnbRpw3aJYI9FCZknBZXjHUg/Y+YYAr3hwIf
    8zg/XYn0J9ZWpCOEfTgUhKbVxbGJwouFZk9B3KO1pKHS5xHIBizQVTX6nKiljwrWIXCxUJ
    I9IkWP1CTXn63ObQazG+zQulfUfl4xkYkdAlj1jwmIDQKl+5EFiPFLk2rBlbZk6KUfoYJw
    MGZn49tqVfoCWY/RQuy6HSgasAsA4m2599GzoIPYj6tGCuTyxv5yZ7HIA3zQ6hrkW+0461
    AB8/1nnDmHsSpvblE+HXHkyPSaYN8Mxs62M3/9zldR20/nVQI/MbuA/SaW/hPztdk91lzk
    kSwA+CcnyDt2o+ycIjivtqBkp+XDCU7QNAsBovRZr8CT/CQeV1PW3Mdh70yRDd+TAe82Pj
    6o3CrucDHS1V7JoAxqok2wV7aTozS8mMbPudXrhVjIKa7zEd4GuhnETyaQT9TpUUoVG/Vp
    +s0I8TTBeV1OPzEh2TEIKMqx9RHVI287U3W3nx9GVjhlZwYE5hvtpVVTyZwg
X-ME-Proxy: <xmx:utBYajaSjlQjlCjLv8g_ZMtkjBA7UXTl9_HJVN0hl9SsMpChoUjgRA>
    <xmx:utBYamq6_VY5U9rXHYYDOV0yuwKvRdcYE_p0oJLf5xMp3n-gSune0A>
    <xmx:utBYag-I5obJyQC93m9HSzgHP9GYF_kjyy4upvAQvmDBILkK1Hvr7g>
    <xmx:utBYat9xOA0fZqSzE3G_hkj_sd8YaW01rBQwjBBm-2Y5pYuHT69lPQ>
    <xmx:utBYaijbw3dYebTmMShjUlYVPWqkKKZFS_ghEw21TuHT_CopoAYtBnr3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 Jul 2026 08:38:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id df5f46fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 Jul 2026 12:38:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jul 2026 14:38:04 +0200
Subject: [PATCH 3/3] refspec: stop depending on `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-pks-refspec-wo-the-repository-v1-3-aa40844d067f@pks.im>
References: <20260716-pks-refspec-wo-the-repository-v1-0-aa40844d067f@pks.im>
In-Reply-To: <20260716-pks-refspec-wo-the-repository-v1-0-aa40844d067f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The only remaining user of `the_hash_algo` in "refspec.c" is
`refspec_append()`, which needs to know the hash algorithm so that it
can parse the appended refspec item. In contrast to the functions
adapted in the preceding commit, this function always operates on a
`struct refspec`. As that structure is expected to only ever contain
refspecs that all use the same hash function it doesn't make sense
though to adapt each caller.

Instead, adapt the structure itself so that it gets initialized with a
hash function and use that hash function to parse new refspec items.
Adapt callers accordingly.

This removes the final dependency on the global repository variable in
"refspec.c", so we can drop `USE_THE_REPOSITORY_VARIABLE`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-export.c       |  4 +++-
 builtin/fetch.c             |  6 ++++--
 builtin/push.c              |  6 ++++--
 builtin/send-pack.c         |  5 ++++-
 builtin/submodule--helper.c |  2 +-
 http-push.c                 |  2 +-
 refspec.c                   | 13 ++++++-------
 refspec.h                   | 17 ++++++++++++-----
 remote.c                    |  4 ++--
 transport-helper.c          |  2 +-
 10 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 0be43104dc..8f4da4cfac 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -51,7 +51,7 @@ static int show_original_ids;
 static int mark_tags;
 static struct string_list extra_refs = STRING_LIST_INIT_DUP;
 static struct string_list tag_refs = STRING_LIST_INIT_DUP;
-static struct refspec refspecs = REFSPEC_INIT_FETCH;
+static struct refspec refspecs;
 static int anonymize;
 static struct hashmap anonymized_seeds;
 static struct revision_sources revision_sources;
@@ -1372,6 +1372,8 @@ int cmd_fast_export(int argc,
 	/* we handle encodings */
 	repo_config(the_repository, git_default_config, NULL);
 
+	refspec_init_fetch(&refspecs, the_hash_algo);
+
 	repo_init_revisions(the_repository, &revs, prefix);
 	init_revision_sources(&revision_sources);
 	revs.topo_order = 1;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1d4a129039..6e1a224553 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -96,7 +96,7 @@ static struct string_list deepen_not = STRING_LIST_INIT_NODUP;
 static struct strbuf default_rla = STRBUF_INIT;
 static struct transport *gtransport;
 static struct transport *gsecondary;
-static struct refspec refmap = REFSPEC_INIT_FETCH;
+static struct refspec refmap;
 static struct string_list server_options = STRING_LIST_INIT_DUP;
 static struct string_list negotiation_restrict = STRING_LIST_INIT_NODUP;
 static struct string_list negotiation_include = STRING_LIST_INIT_NODUP;
@@ -2429,7 +2429,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 		     const struct fetch_config *config,
 		     struct list_objects_filter_options *filter_options)
 {
-	struct refspec rs = REFSPEC_INIT_FETCH;
+	struct refspec rs = REFSPEC_INIT_FETCH(the_hash_algo);
 	int i;
 	int exit_code;
 	int maybe_prune_tags;
@@ -2631,6 +2631,8 @@ int cmd_fetch(int argc,
 
 	filter_options.allow_auto_filter = 1;
 
+	refspec_init_fetch(&refmap, the_hash_algo);
+
 	packet_trace_identity("fetch");
 
 	/* Record the command line for the reflog */
diff --git a/builtin/push.c b/builtin/push.c
index 1b2ad3b8df..8ccdb07c40 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -66,7 +66,7 @@ static enum transport_family family;
 
 static struct push_cas_option cas;
 
-static struct refspec rs = REFSPEC_INIT_PUSH;
+static struct refspec rs;
 
 static struct string_list push_options_config = STRING_LIST_INIT_DUP;
 
@@ -749,6 +749,8 @@ int cmd_push(int argc,
 		: &push_options_config);
 	set_push_cert_flags(&flags, push_cert);
 
+	refspec_init_push(&rs, the_hash_algo);
+
 	die_for_incompatible_opt4(deleterefs, "--delete",
 				  tags, "--tags",
 				  flags & TRANSPORT_PUSH_ALL, "--all/--branches",
@@ -855,7 +857,7 @@ int cmd_push(int argc,
 			}
 
 			refspec_clear(&rs);
-			rs = (struct refspec) REFSPEC_INIT_PUSH;
+			rs = (struct refspec) REFSPEC_INIT_PUSH(the_hash_algo);
 
 			if (tags)
 				refspec_append(&rs, "refs/tags/*");
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 1412b49bc8..d6cdbae472 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -153,7 +153,7 @@ int cmd_send_pack(int argc,
 		  const char *prefix,
 		  struct repository *repo)
 {
-	struct refspec rs = REFSPEC_INIT_PUSH;
+	struct refspec rs;
 	const char *remote_name = NULL;
 	struct remote *remote = NULL;
 	const char *dest = NULL;
@@ -214,6 +214,9 @@ int cmd_send_pack(int argc,
 
 	repo_config(repo, send_pack_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, send_pack_usage, 0);
+
+	refspec_init_push(&rs, repo->hash_algo);
+
 	if (argc > 0) {
 		dest = argv[0];
 		refspec_appendn(&rs, argv + 1, argc - 1);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1cc82a134d..c396b826ba 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3150,7 +3150,7 @@ static int push_check(int argc, const char **argv, const char *prefix UNUSED,
 	if (argc > 2) {
 		int i;
 		struct ref *local_refs = get_local_heads();
-		struct refspec refspec = REFSPEC_INIT_PUSH;
+		struct refspec refspec = REFSPEC_INIT_PUSH(the_hash_algo);
 
 		refspec_appendn(&refspec, argv + 2, argc - 2);
 
diff --git a/http-push.c b/http-push.c
index 3c23cbba27..969d984cb9 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1716,7 +1716,7 @@ int cmd_main(int argc, const char **argv)
 {
 	struct transfer_request *request;
 	struct transfer_request *next_request;
-	struct refspec rs = REFSPEC_INIT_PUSH;
+	struct refspec rs = REFSPEC_INIT_PUSH(the_hash_algo);
 	struct remote_lock *ref_lock = NULL;
 	struct remote_lock *info_ref_lock = NULL;
 	int delete_branch = 0;
diff --git a/refspec.c b/refspec.c
index 33a6fb8e45..7cb479983b 100644
--- a/refspec.c
+++ b/refspec.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -185,15 +184,15 @@ void refspec_item_clear(struct refspec_item *item)
 	item->exact_sha1 = 0;
 }
 
-void refspec_init_fetch(struct refspec *rs)
+void refspec_init_fetch(struct refspec *rs, const struct git_hash_algo *algo)
 {
-	struct refspec blank = REFSPEC_INIT_FETCH;
+	struct refspec blank = REFSPEC_INIT_FETCH(algo);
 	memcpy(rs, &blank, sizeof(*rs));
 }
 
-void refspec_init_push(struct refspec *rs)
+void refspec_init_push(struct refspec *rs, const struct git_hash_algo *algo)
 {
-	struct refspec blank = REFSPEC_INIT_PUSH;
+	struct refspec blank = REFSPEC_INIT_PUSH(algo);
 	memcpy(rs, &blank, sizeof(*rs));
 }
 
@@ -203,9 +202,9 @@ void refspec_append(struct refspec *rs, const char *refspec)
 	int ret;
 
 	if (rs->fetch)
-		ret = refspec_item_init_fetch(&item, refspec, the_hash_algo);
+		ret = refspec_item_init_fetch(&item, refspec, rs->hash_algo);
 	else
-		ret = refspec_item_init_push(&item, refspec, the_hash_algo);
+		ret = refspec_item_init_push(&item, refspec, rs->hash_algo);
 	if (!ret)
 		die(_("invalid refspec '%s'"), refspec);
 
diff --git a/refspec.h b/refspec.h
index e482b720a8..fadef67933 100644
--- a/refspec.h
+++ b/refspec.h
@@ -49,14 +49,21 @@ struct refspec {
 	int alloc;
 	int nr;
 
+	const struct git_hash_algo *hash_algo;
 	unsigned fetch : 1;
 };
 
-#define REFSPEC_INIT_FETCH { .fetch = 1 }
-#define REFSPEC_INIT_PUSH { .fetch = 0 }
-
-void refspec_init_fetch(struct refspec *rs);
-void refspec_init_push(struct refspec *rs);
+#define REFSPEC_INIT_FETCH(algo) { \
+	.fetch = 1, \
+	.hash_algo = (algo), \
+}
+#define REFSPEC_INIT_PUSH(algo) { \
+	.fetch = 0, \
+	.hash_algo = (algo), \
+}
+
+void refspec_init_fetch(struct refspec *rs, const struct git_hash_algo *hash_algo);
+void refspec_init_push(struct refspec *rs, const struct git_hash_algo *hash_algo);
 void refspec_clear(struct refspec *rs);
 
 void refspec_append(struct refspec *rs, const char *refspec);
diff --git a/remote.c b/remote.c
index b4dff1e5f9..d151b1f9d9 100644
--- a/remote.c
+++ b/remote.c
@@ -150,8 +150,8 @@ static struct remote *make_remote(struct remote_state *remote_state,
 	ret->prune = -1;  /* unspecified */
 	ret->prune_tags = -1;  /* unspecified */
 	ret->name = xstrndup(name, len);
-	refspec_init_push(&ret->push);
-	refspec_init_fetch(&ret->fetch);
+	refspec_init_push(&ret->push, the_hash_algo);
+	refspec_init_fetch(&ret->fetch, the_hash_algo);
 	string_list_init_dup(&ret->server_options);
 	string_list_init_dup(&ret->negotiation_restrict);
 	string_list_init_dup(&ret->negotiation_include);
diff --git a/transport-helper.c b/transport-helper.c
index 80f90eb7ba..8a25707b03 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -162,7 +162,7 @@ static struct child_process *get_helper(struct transport *transport)
 
 	data->helper = helper;
 	data->no_disconnect_req = 0;
-	refspec_init_fetch(&data->rs);
+	refspec_init_fetch(&data->rs, the_hash_algo);
 
 	/*
 	 * Open the output as FILE* so strbuf_getline_*() family of

-- 
2.55.0.313.g8d093f411d.dirty

