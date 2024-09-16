Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693A115748E
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487169; cv=none; b=G3elH8h9Vp41AP0KP+vS5eHNExAF3A1zrnuCGhl0aVoeEeI4HdplQy3EIcPeLJwthCPn9P92GCr0YAAko1fhIGR3ZepBKTF2tHtlT41UmR0XG1sVAuD3gzqW+PD4TKvOry+8Hhh01lncRidx4wbeZxpaXjSJ6ZaARVOE1P+0oTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487169; c=relaxed/simple;
	bh=G0zgYrJB0LAi1lAySopPWetK/R6ObdC8dF9cl7yOzY0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OS9Hxl0jxRv6oyiag6F7cZ5JTBYrBN08GhuiNcfq0abFhAo9NNOF7llcgyQSB8xBWpBlvSn9k6sIflBoo7nECtQTfIP2gjfwVklLibqee3ve/ej6OGI4j8cO0rnGxTLlBdFIQwEE6BEvgDEaNXePHBPprmX1DUkKZ1+juFzuubc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NDUQhbAN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z27+Y57t; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NDUQhbAN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z27+Y57t"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C3C74114023B
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:46:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 16 Sep 2024 07:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726487166; x=1726573566; bh=1ZJfGtzqvt
	yzJWnZb6VOnIb94WGnF7Sluf2NKzaMnhc=; b=NDUQhbANXTNRN8Sope2KrNWRBH
	RB+SEBxxWbw/veWts+0eNGzZJzkNoBIjf+eioTaTB7Pm2URRRw75v46Be6SxQ3/1
	acTT/ZFFmuibjDR+kOsRYV18VnnIndjEzrY9Uq8SVdMta+bZBB2omevbj+QsdXv9
	XsN4vP3luA6X5W7NE5fyu81o7gzvJ+Yh+VBU3fyCqYI3e3L/9JBP3X6TH/CsDkN6
	aDYn2rdjIttIeOZctXPmt5XqAPFR7IaEJ0JQjunI6ELOKh2ZLjCmcJ/9JYDA7gBf
	Hkp/MLW5ZmErYTGG6ue8yljYnplpDDd9jrO/18Im4PZLW0ld3i3eol+RbzWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726487166; x=1726573566; bh=1ZJfGtzqvtyzJWnZb6VOnIb94WGn
	F7Sluf2NKzaMnhc=; b=Z27+Y57tcW2MjfKMAYos4+TSLZq84PRlV6COjGCRlk5U
	7D2+KfE4HLTF5hppcun7BIe1TfwstESzhl4uD2+8LEVKkv40oXSHLbHZ4R4e71jB
	OSmt5sy20aCpsfa3QZFDe2ij9IwRebQ4ZVSfc+uO7sA/VDjJulxKiHFv0ZOg8SI3
	v1UnoGjGW+JXEck/t9x16kLnPcPUIA8nu35KXThs1nR+NuswiwSQzmW1rQwxHK/Y
	93VSk4i+tVP6DDUy5uuHm6ydUYnEKnpZ8xVgEWAk/LdtDgk5gXYnpCNsdKpH+jCg
	7o7WYyfIir/TnGfjSfPiS0AenWTY/7CLGCO+2qIAUg==
X-ME-Sender: <xms:fhroZh4HXlUjaWm9CUV85a6E_x9D-yClYIyiAI-Xf62oHpNnda8QJw>
    <xme:fhroZu4XDK90WL_PEJBnivB_KKWW4fNOqQVUY0QjRWhuJ6oENoiLxEJ5r_EkAQ0fU
    q0GAlR1wy1kwiC4Hw>
X-ME-Received: <xmr:fhroZodcbtB814yf0CigwQajD4OpKGwqjqN91RSC0EV9_7j1xYLerYH0DCXhYy9-nATIy5q5jO52jsy9VsAPspFlyAVu8SYSA2BR2Jx3rDJ47TQ7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fhroZqIbdomMYR4Sl3RR_GyCNInWpmpGp-_TNO5eRKehcvb5TQvwAg>
    <xmx:fhroZlIUudXBKYmlrlzFHoptCVZ7Bx5mSChmyzG7Z_xFReAzjr-edA>
    <xmx:fhroZjzvjaDCSp50LR-VzUPeFF0lU_yX6fqMM2OoYjL1JFdr4W4JGg>
    <xmx:fhroZhJWTOcat3B_x18rCYCi8P7PBp6XuprgdC55vwfH_py4l6UhRQ>
    <xmx:fhroZjg5JMs13iJEwKQ3N-Lqeq4jWgXDKzrmvrbJKTehhGhUbS9G6uzS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 07:46:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 340d54ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 11:45:48 +0000 (UTC)
Date: Mon, 16 Sep 2024 13:46:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 14/23] builtin/repack: fix leaking configuration
Message-ID: <a5f3931eee1e49c60e1d5be214263aeaf3d5c65f.1726484308.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726484308.git.ps@pks.im>

When repacking, we assemble git-pack-objects(1) arguments both for the
"normal" pack and for the cruft pack. This configuration gets populated
with a bunch of `OPT_PASSTHRU` options that we end up passing to the
child process. These options are allocated, but never free'd.

Create a new `pack_objects_args_release()` function that releases the
memory for us and call it for both sets of options.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repack.c              | 57 ++++++++++++++++++++++++++---------
 t/t5329-pack-objects-cruft.sh |  2 ++
 t/t7700-repack.sh             |  1 +
 3 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 3ee8cfa732f..c31d5653f1f 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -85,17 +85,34 @@ static int repack_config(const char *var, const char *value,
 		run_update_server_info = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "repack.cruftwindow"))
+	if (!strcmp(var, "repack.cruftwindow")) {
+		free(cruft_po_args->window);
 		return git_config_string(&cruft_po_args->window, var, value);
-	if (!strcmp(var, "repack.cruftwindowmemory"))
+	}
+	if (!strcmp(var, "repack.cruftwindowmemory")) {
+		free(cruft_po_args->window_memory);
 		return git_config_string(&cruft_po_args->window_memory, var, value);
-	if (!strcmp(var, "repack.cruftdepth"))
+	}
+	if (!strcmp(var, "repack.cruftdepth")) {
+		free(cruft_po_args->depth);
 		return git_config_string(&cruft_po_args->depth, var, value);
-	if (!strcmp(var, "repack.cruftthreads"))
+	}
+	if (!strcmp(var, "repack.cruftthreads")) {
+		free(cruft_po_args->threads);
 		return git_config_string(&cruft_po_args->threads, var, value);
+	}
 	return git_default_config(var, value, ctx, cb);
 }
 
+static void pack_objects_args_release(struct pack_objects_args *args)
+{
+	free(args->window);
+	free(args->window_memory);
+	free(args->depth);
+	free(args->threads);
+	list_objects_filter_release(&args->filter_options);
+}
+
 struct existing_packs {
 	struct string_list kept_packs;
 	struct string_list non_kept_packs;
@@ -1152,12 +1169,16 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	const char *unpack_unreachable = NULL;
 	int keep_unreachable = 0;
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
-	struct pack_objects_args po_args = {NULL};
-	struct pack_objects_args cruft_po_args = {NULL};
+	struct pack_objects_args po_args = { 0 };
+	struct pack_objects_args cruft_po_args = { 0 };
 	int write_midx = 0;
 	const char *cruft_expiration = NULL;
 	const char *expire_to = NULL;
 	const char *filter_to = NULL;
+	const char *opt_window = NULL;
+	const char *opt_window_memory = NULL;
+	const char *opt_depth = NULL;
+	const char *opt_threads = NULL;
 
 	struct option builtin_repack_options[] = {
 		OPT_BIT('a', NULL, &pack_everything,
@@ -1191,13 +1212,13 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("with -A, do not loosen objects older than this")),
 		OPT_BOOL('k', "keep-unreachable", &keep_unreachable,
 				N_("with -a, repack unreachable objects")),
-		OPT_STRING(0, "window", &po_args.window, N_("n"),
+		OPT_STRING(0, "window", &opt_window, N_("n"),
 				N_("size of the window used for delta compression")),
-		OPT_STRING(0, "window-memory", &po_args.window_memory, N_("bytes"),
+		OPT_STRING(0, "window-memory", &opt_window_memory, N_("bytes"),
 				N_("same as the above, but limit memory size instead of entries count")),
-		OPT_STRING(0, "depth", &po_args.depth, N_("n"),
+		OPT_STRING(0, "depth", &opt_depth, N_("n"),
 				N_("limits the maximum delta depth")),
-		OPT_STRING(0, "threads", &po_args.threads, N_("n"),
+		OPT_STRING(0, "threads", &opt_threads, N_("n"),
 				N_("limits the maximum number of threads")),
 		OPT_MAGNITUDE(0, "max-pack-size", &po_args.max_pack_size,
 				N_("maximum size of each packfile")),
@@ -1224,6 +1245,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, builtin_repack_options,
 				git_repack_usage, 0);
 
+	po_args.window = xstrdup_or_null(opt_window);
+	po_args.window_memory = xstrdup_or_null(opt_window_memory);
+	po_args.depth = xstrdup_or_null(opt_depth);
+	po_args.threads = xstrdup_or_null(opt_threads);
+
 	if (delete_redundant && repository_format_precious_objects)
 		die(_("cannot delete packs in a precious-objects repo"));
 
@@ -1389,13 +1415,13 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		const char *pack_prefix = find_pack_prefix(packdir, packtmp);
 
 		if (!cruft_po_args.window)
-			cruft_po_args.window = po_args.window;
+			cruft_po_args.window = xstrdup_or_null(po_args.window);
 		if (!cruft_po_args.window_memory)
-			cruft_po_args.window_memory = po_args.window_memory;
+			cruft_po_args.window_memory = xstrdup_or_null(po_args.window_memory);
 		if (!cruft_po_args.depth)
-			cruft_po_args.depth = po_args.depth;
+			cruft_po_args.depth = xstrdup_or_null(po_args.depth);
 		if (!cruft_po_args.threads)
-			cruft_po_args.threads = po_args.threads;
+			cruft_po_args.threads = xstrdup_or_null(po_args.threads);
 		if (!cruft_po_args.max_pack_size)
 			cruft_po_args.max_pack_size = po_args.max_pack_size;
 
@@ -1547,7 +1573,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	string_list_clear(&names, 1);
 	existing_packs_release(&existing);
 	free_pack_geometry(&geometry);
-	list_objects_filter_release(&po_args.filter_options);
+	pack_objects_args_release(&po_args);
+	pack_objects_args_release(&cruft_po_args);
 
 	return ret;
 }
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index fc5fedbe9b0..445739d06c9 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='cruft pack related pack-objects tests'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 objdir=.git/objects
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index be1188e7365..c4c3d1a15d9 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -2,6 +2,7 @@
 
 test_description='git repack works correctly'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "${TEST_DIRECTORY}/lib-bitmap.sh"
 . "${TEST_DIRECTORY}/lib-midx.sh"
-- 
2.46.0.551.gc5ee8f2d1c.dirty

