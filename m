Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A44178367
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351206; cv=none; b=ZmtlhWDl6YYmdsLtRyLS8aZDJivdWnTr2t7T4dEwfy1nMVXfyb/dxUaVFkwzleFvAvn9DWJ4U7Ih4OJpM9kyRyiJ1XSnKHPCDJexOgR2BNd9a4V1EWa+7vlrZXD/+FWFWBIu/c1Fcg8R4STqPFDzMygI5vOvH2RrODNyhhTmASY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351206; c=relaxed/simple;
	bh=jep8UdZQ4EYrFwpoCbsOWwQR+4N2SERR1S9+/rj0Ih4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEEsYfmSX942QDx17D4vPZ1I8EXJxB1USZuvRZLJgJjdzyCkrUi+F+UAabStoABF0G+MEwx/MxRP01CoWC0WMKCe12xK1txoNOMJb3ACOvJyM2+9XOdnlD9DwwoBD3vBn+VMnp80bK1hHKf2qvZUe8iV4RWHPQlHHXl5dhHNk9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Uq5rygDk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n7ZnADW1; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Uq5rygDk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n7ZnADW1"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 17C73138061D;
	Thu, 26 Sep 2024 07:46:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 26 Sep 2024 07:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727351204; x=1727437604; bh=/jSR/xT5cR
	q1c+NhFacms0B/kPuJaQE8JCpteyPNvZI=; b=Uq5rygDktidcXfQX+RuQwQmkoM
	24h1QpUlVMduQEVh2g5id3Ci4Jt0dKWGU/RC+pmpPDmoipUugug49bMES2tpjaYA
	5SScTDmYUO3Sx27cnZSFvPvTysAnhX7Gs+jZzRCX3UyZzn0xsWftcNsWzJ6nfVQ8
	A/ovRF1CxpGOs2pv87yBDYcxtBZIBwIl/r/+HC4a6SRGs3JADlDwZNurEyLMiFN3
	455709P5GzVImPDW5Bp1L0518fXYWENnDF/qnAmFJDkGWvkEtJ3NGAuMkCgdhKF9
	ElKgS0JF/wA4jUKvz0otEz1Ow8VI8UHL0ayBKKvjyfpJre+VjUB/bX3taK5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727351204; x=1727437604; bh=/jSR/xT5cRq1c+NhFacms0B/kPuJ
	aQE8JCpteyPNvZI=; b=n7ZnADW1FrPTY0/G0RFXZ4Paj3tsyR27LMmBYLct1DzD
	6+8OFLiG1T4ahuTQiYqIM/5jVoT7wfggNFkTNrkh/TihNMBr9Jkci1lgop6+Csax
	TbrYn/JYrITxCA+nHvaTAkn0yJZr1pR5kzgXa8aHyIYIGXE1a2KrUNPwQtHR1Wld
	WrmS3o3BAYBHTaOhNsmBBzRoHE9/IEiSz8SjzICWRQuTdSFT5rVx1KEohoIxK7z0
	PV6URnMAYTpLKjyZ1MmwT4X1U078qZnnQCVO5qEg6+6nvpJuXnobZNdXBTS+yB11
	85EDXPN0cyfiY2zzEJaq7VMC76pEuj2KZpeQ4OJCnw==
X-ME-Sender: <xms:o0n1Zv4Gd70nCXrNnJZNFdanKU5AfnYaAykIZslcPvk5bn_ek3qyWQ>
    <xme:o0n1Zk5KFJrW9rFAZJd7EL9TzDkv3dClBg2vVJ0GghT-bR0eftAxVXWwBJhJs1I09
    _TWFKv67P8_GEStgg>
X-ME-Received: <xmr:o0n1ZmcPrvAl7_BP5GfcJfYeTGN8U_DgmGRzZy5j27hl6oi8O-ZKsUST3AR9HXIJ1VqTfrvA6Ld31cP22AUtkc39XJ8cCCjPM_RxdxNydi-WyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:o0n1ZgKFyqXW7EDCE4YRH2ZwcdCTW4S1dMX64RI4i1YuFVqFD7-FAQ>
    <xmx:o0n1ZjIy1iAW9w-YZYDdZbB0wNbfPBU2XUk6SBo_e03UC5TbHf8YGA>
    <xmx:o0n1ZpznSo_Ex9S9B-IRSRbYQr7qriPSAIFRhwwoRHm6MLbSnse9mQ>
    <xmx:o0n1ZvJWaI14BeEDsHZwCGs0eXS3PAa9I-GC7z0kO8A8w1QQq5hdGQ>
    <xmx:pEn1Zr0ktkHsEVCfeJKGDvsBvQnG9mx_PneQKuPa5Lb2yI_-t3P6eFBt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:46:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a44cd8dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:46:05 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:46:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 14/23] builtin/repack: fix leaking configuration
Message-ID: <e015d1704b0da60fbf3663fb31c19780528bc7e6.1727351062.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
 <cover.1727351062.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727351062.git.ps@pks.im>

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
index 3ee8cfa732..c31d5653f1 100644
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
index fc5fedbe9b..445739d06c 100755
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
index be1188e736..c4c3d1a15d 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -2,6 +2,7 @@
 
 test_description='git repack works correctly'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "${TEST_DIRECTORY}/lib-bitmap.sh"
 . "${TEST_DIRECTORY}/lib-midx.sh"
-- 
2.46.2.852.g229c0bf0e5.dirty

