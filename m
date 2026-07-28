Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212163A380E
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 04:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785212755; cv=none; b=YGUseAPNVq5qapdyc4/zJ1TFRs9XO89H+vD8ZQcyZiDRVfEcP8XStRvb8q++UZqlXzQtt8qJEsg5ZsE7AKeARJuAc4rdANf9Vjug3l04z85mucXYv7HHrQ41bUu7QmWVLmrLgvbXHMnwJVatW3Yb0TcY7DSMr47sv6a+oJ/NmEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785212755; c=relaxed/simple;
	bh=dXybVUm5J6BeyHpTku3ubH0BSxGF2otskICmy1oV41U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UPcuoGOXd03wgB+5Tr2C6cqas92Im+ioR1Lp7bni/BwmjC4zwlllv4iSIbVLA2v8EtFolMaiszZNZKHi3FHDW6wi78IV9zXbX9SVb/MwPGAETRzU+GI+GFBxBlDv8VgS7JvLUG70wtBmBescvLnJYx3Sd8BNMthTTApca3S1Uu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=aqCbPAHY; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="aqCbPAHY"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso3075372a91.3
        for <git@vger.kernel.org>; Mon, 27 Jul 2026 21:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1785212752; x=1785817552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ROtPYpTLmzoFyWfkYpyR8vLYbGZAZ3UWrn+PpTrNTyY=;
        b=aqCbPAHYqVyzc7w++wc9v/pDrVPO2uLpEjlpGPCs4W+75mUCNhgmJJ3vYXo+JUoG4m
         9peSEgk6KNthFa5s2IMmX/gRrEbPfBCkrawjULDOr2RzIxshg34TMdnvZWPOicrxOr/L
         OiR7amfXcItFZBlxE94QPwnu1sivAh8C1yWqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785212752; x=1785817552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ROtPYpTLmzoFyWfkYpyR8vLYbGZAZ3UWrn+PpTrNTyY=;
        b=SB9DT7nPyp5SsDRBRzbnJvgRqKK7lPxwsUKPbIf261yKNPlxylop8C778gQbCZJdoN
         yTNUI4bLgcYyhLFkh2mI0RqYd4+Y8iR7mc/DHjXJngpjlwM98HKv/SxXTFejOdWevqyZ
         zH9lPdvQey81I8b37h0tAwTqTfYE/gEeaNR3wbWfSrj1iUw4ReXzxfMGhQX2TW7TSbEw
         8Ok+X1b2Yt5fBHlURXN5Ixv+GIijuDV5bAWmw25rQdk3xUk8iLNY6g6rkJrjqj1Wzw2I
         t3M9OMkfHcY9LGHZDRagrP4fsiYSmqOtCJOjI2YsTHn6Z1/yCrL3xkeTtmcYcjODW5mf
         FS9A==
X-Gm-Message-State: AOJu0YyBIJEBOrgzD81e9Im0eHRbGbRKvxDg1So5GrE18dhK9Je8/C0y
	2XORRSezCLkTthpfOeTmi3g7OlWbk/CbS/R7R5/IYQ+USX2LSgL+VOLimzGnnyL2GCwKsymi1d+
	kPFZP4es+KQ==
X-Gm-Gg: AR+sD1217kZgsQtQ6vBbYV3JQUhYpol4WpKX9PMcCGCwfUcPFG7hNBUe6NQx/x2dbtz
	ZwRJfFpeukRw3OIHrq28ZEQ0DOCBLThN4Tqaqal6b2cZ1pL9cBndKyAEd9HcpL3GuQBdIDxeQs8
	Hs3mW4NdxtyOouTNK5iSdMJ1a5y5NrFoI/VELb6Z9sth+OUByIK61G/Cn9N+8tPkhoY2nXo3zjk
	RPBPfbgw6Xu2nPsiZhdxKVZd2stEc2NSR0BiQ1Kv13jRImc5jDDMj7Ep0NgkGaWrWXWYbMkSpTF
	mGaXcembDAO7FavqlmwlBsdPnm9ctbhY/V26z+JdiTrR6RZu7C3Rvjzrf06/TFuBz7+Ki2zeISG
	94HSbkjwrj6Ul8996j7KXVPNItqpC8uhFN/s2EzEF3TNP1p2zyUVUGGkdMShmvugpfG9u2Ug+hz
	Av5Z1w0hsdGrDYNuX3ZJrBaJIj6smnO6jSIno8rIgLk+hUP9LwcPbx/OeioSuYYoO0VMfym0Ydq
	cykpZw7VKN7de4P2m33r8kY7iiLwqZz5EOfXCwoXkMdos0iegaBwvI4uGsbejPksjJaNPxyqQMR
	TA==
X-Received: by 2002:a05:6a20:2583:b0:3c3:704d:57c4 with SMTP id adf61e73a8af0-3c8aaf7ce69mr1064608637.12.1785212752269;
        Mon, 27 Jul 2026 21:25:52 -0700 (PDT)
Received: from com-58127.corp.openai.org ([199.47.143.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc5a67f3sm39715677eec.29.2026.07.27.21.25.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 21:25:51 -0700 (PDT)
From: friel@openai.com
To: git@vger.kernel.org
Cc: Friel <friel@openai.com>,
	gitster@pobox.com,
	peff@peff.net,
	stolee@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	jonathantanmy@fastmail.com
Subject: [RFC PATCH] index-pack: optionally allow duplicate objects
Date: Mon, 27 Jul 2026 21:25:32 -0700
Message-ID: <20260728042550.91133-2-friel@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Friel <friel@openai.com>

index-pack accepts repeated object IDs by default. However,
--check-self-contained-and-connected also enables strict index
validation, which rejects them. A clone therefore rejects a pack
containing duplicate objects even when all of its objects are connected.

By default, shallow and filtered clones do not request this pack-local
check and already accept duplicate objects. Ordinary full clones reject
the same pack because they enable strict index validation.

Git's upload-pack normally uses pack-objects to select each reachable
object once before writing a response. A server can instead construct
that response by streaming entries from existing packs. When those
packs overlap, the same object can appear more than once.

Avoiding duplicates requires the producers to coordinate their object
selection or track object IDs across all input packs. A duplicate can
also be used as a delta base, so removing it can require buffering and
rewriting the response. Doing that work at request time gives up the
memory and latency benefits of streaming existing packs.

Add pack.allowDuplicateObjects so a client can accept these packs during
its initial fetch:

    git clone -c pack.allowDuplicateObjects <repository>

Add --[no-]allow-duplicate-objects to override the configuration for
index-pack. Preserve the default rejection introduced by 68be2fea50
(receive-pack, fetch-pack: reject bogus pack that records objects twice,
2011-11-16). An explicit --strict or --verify remains strict regardless
of the configuration and cannot be combined with
--allow-duplicate-objects. Object validation, connectivity checks, and
delta resolution remain unchanged.

Signed-off-by: Friel <friel@openai.com>
---
Applies on top of tb/pack-with-duplicates.

 Documentation/config/pack.adoc    |  11 ++
 Documentation/git-index-pack.adoc |  12 ++-
 builtin/index-pack.c              |  41 ++++++-
 t/t5308-pack-detect-duplicates.sh | 171 ++++++++++++++++++++++++++++++
 t/t5309-pack-delta-cycles.sh      |  10 ++
 5 files changed, 241 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/pack.adoc b/Documentation/config/pack.adoc
index 22384c2d2f..2229878abe 100644
--- a/Documentation/config/pack.adoc
+++ b/Documentation/config/pack.adoc
@@ -39,6 +39,17 @@ is set to "multi", reuse parts of just the bitmapped packfile. This
 can reduce memory and CPU usage to serve fetches, but might result in
 sending a slightly larger pack. Defaults to true.
 
+pack.allowDuplicateObjects::
+	Allow linkgit:git-index-pack[1] to accept a pack containing
+	multiple copies of the same object while checking that the pack
+	is self-contained and connected. For example,
+	`git clone -c pack.allowDuplicateObjects <repository>` can accept
+	a pack generated from overlapping existing packs. Object and
+	connectivity checks are preserved. Explicit `--strict` and
+	`--verify` continue to reject duplicate objects.
+	`--no-allow-duplicate-objects` overrides this setting.
+	Defaults to `false`.
+
 pack.island::
 	An extended regular expression configuring a set of delta
 	islands. See "DELTA ISLANDS" in linkgit:git-pack-objects[1]
diff --git a/Documentation/git-index-pack.adoc b/Documentation/git-index-pack.adoc
index 18036953c0..1cb11ff898 100644
--- a/Documentation/git-index-pack.adoc
+++ b/Documentation/git-index-pack.adoc
@@ -11,7 +11,9 @@ SYNOPSIS
 [verse]
 'git index-pack' [-v] [-o <index-file>] [--[no-]rev-index] <pack-file>
 'git index-pack' --stdin [--fix-thin] [--keep] [-v] [-o <index-file>]
-		  [--[no-]rev-index] [<pack-file>]
+		  [--[no-]rev-index]
+		  [--[no-]allow-duplicate-objects]
+		  [<pack-file>]
 
 
 DESCRIPTION
@@ -97,6 +99,14 @@ default and "Indexing objects" when `--stdin` is specified.
 --check-self-contained-and-connected::
 	Die if the pack contains broken links. For internal use only.
 
+--allow-duplicate-objects::
+--no-allow-duplicate-objects::
+	Allow or reject multiple copies of the same object while checking
+	that the pack is self-contained and connected. The default is
+	controlled by `pack.allowDuplicateObjects`. The command-line
+	option overrides the configuration. `--allow-duplicate-objects`
+	cannot be combined with `--strict` or `--verify`.
+
 --fsck-objects[=<msg-id>=<severity>...]::
 	Die if the pack contains broken objects, but unlike `--strict`, don't
 	choke on broken links. If the pack contains a tree pointing to a
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index bc86925ad0..4ffcbb6c28 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -33,7 +33,7 @@
 #include "strvec.h"
 
 static const char index_pack_usage[] =
-"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict[=<msg-id>=<severity>...]] [--fsck-objects[=<msg-id>=<severity>...]] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
+"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict[=<msg-id>=<severity>...]] [--[no-]allow-duplicate-objects] [--fsck-objects[=<msg-id>=<severity>...]] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
 
 struct object_entry {
 	struct pack_idx_entry idx;
@@ -135,6 +135,11 @@ static int nr_threads;
 
 static int from_stdin;
 static int strict;
+static enum {
+	DUPLICATE_OBJECTS_REJECT = 0,
+	DUPLICATE_OBJECTS_ALLOW_CONFIG,
+	DUPLICATE_OBJECTS_ALLOW_OPTION,
+} allow_duplicate_objects;
 static int do_fsck_object;
 static struct fsck_options fsck_options;
 static int verbose;
@@ -1673,6 +1678,12 @@ static int git_index_pack_config(const char *k, const char *v,
 			die(_("bad pack.indexVersion=%"PRIu32), opts->version);
 		return 0;
 	}
+	if (!strcmp(k, "pack.allowduplicateobjects")) {
+		allow_duplicate_objects = git_config_bool(k, v) ?
+			DUPLICATE_OBJECTS_ALLOW_CONFIG :
+			DUPLICATE_OBJECTS_REJECT;
+		return 0;
+	}
 	if (!strcmp(k, "pack.threads")) {
 		nr_threads = git_config_int(k, v, ctx->kvi);
 		if (nr_threads < 0)
@@ -1889,6 +1900,7 @@ int cmd_index_pack(int argc,
 		   struct repository *repo UNUSED)
 {
 	int i, fix_thin_pack = 0, verify = 0, stat_only = 0, rev_index;
+	int write_idx_strict;
 	const char *curr_index;
 	char *curr_rev_index = NULL;
 	const char *index_name = NULL, *pack_name = NULL, *rev_index_name = NULL;
@@ -1941,8 +1953,11 @@ int cmd_index_pack(int argc,
 				strict = 1;
 				do_fsck_object = 1;
 				fsck_set_msg_types(&fsck_options, arg);
+			} else if (!strcmp(arg, "--allow-duplicate-objects")) {
+				allow_duplicate_objects = DUPLICATE_OBJECTS_ALLOW_OPTION;
+			} else if (!strcmp(arg, "--no-allow-duplicate-objects")) {
+				allow_duplicate_objects = DUPLICATE_OBJECTS_REJECT;
 			} else if (!strcmp(arg, "--check-self-contained-and-connected")) {
-				strict = 1;
 				check_self_contained_and_connected = 1;
 			} else if (skip_to_optional_arg(arg, "--fsck-objects", &arg)) {
 				do_fsck_object = 1;
@@ -2022,6 +2037,26 @@ int cmd_index_pack(int argc,
 		usage(index_pack_usage);
 	if (fix_thin_pack && !from_stdin)
 		die(_("the option '%s' requires '%s'"), "--fix-thin", "--stdin");
+
+	/*
+	 * Connectivity checks require strict object traversal, but may allow
+	 * duplicate entries in the pack index.
+	 */
+	write_idx_strict = strict;
+	if (check_self_contained_and_connected) {
+		strict = 1;
+		if (allow_duplicate_objects == DUPLICATE_OBJECTS_REJECT)
+			write_idx_strict = 1;
+	}
+
+	if (write_idx_strict &&
+	    allow_duplicate_objects == DUPLICATE_OBJECTS_ALLOW_OPTION)
+		die(_("options '%s' and '%s' cannot be used together"),
+		    "--allow-duplicate-objects", "--strict");
+	if (verify &&
+	    allow_duplicate_objects == DUPLICATE_OBJECTS_ALLOW_OPTION)
+		die(_("options '%s' and '%s' cannot be used together"),
+		    "--allow-duplicate-objects", "--verify");
 	if (promisor_msg && pack_name)
 		die(_("--promisor cannot be used with a pack name"));
 	if (from_stdin && !startup_info->have_repository)
@@ -2055,7 +2090,7 @@ int cmd_index_pack(int argc,
 		read_idx_option(&opts, index_name);
 		opts.flags |= WRITE_IDX_VERIFY | WRITE_IDX_STRICT;
 	}
-	if (strict)
+	if (write_idx_strict)
 		opts.flags |= WRITE_IDX_STRICT;
 
 	if (HAVE_THREADS && !nr_threads) {
diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-duplicates.sh
index c6273a1aeb..95c81fa7b4 100755
--- a/t/t5308-pack-detect-duplicates.sh
+++ b/t/t5308-pack-detect-duplicates.sh
@@ -139,4 +139,175 @@ test_expect_success 'index-pack can reject packs with duplicates' '
 	test_expect_code 1 git cat-file -e $LO_SHA1
 '
 
+test_expect_success 'connectivity check rejects duplicate objects by default' '
+	clear_packs &&
+	create_pack dups.pack 2 &&
+	test_must_fail git index-pack \
+		--check-self-contained-and-connected --stdin <dups.pack &&
+	test_expect_code 1 git cat-file -e $LO_SHA1
+'
+
+test_expect_success 'connectivity check can allow duplicate objects' '
+	clear_packs &&
+	create_pack dups.pack 2 &&
+	git index-pack --check-self-contained-and-connected \
+		--allow-duplicate-objects --stdin <dups.pack &&
+	git cat-file -e "$LO_SHA1" &&
+	git cat-file -e "$HI_SHA1"
+'
+
+test_expect_success 'configuration allows duplicates with connectivity checks' '
+	clear_packs &&
+	create_pack dups.pack 2 &&
+	git -c pack.allowDuplicateObjects index-pack \
+		--check-self-contained-and-connected --stdin <dups.pack &&
+	git cat-file -e "$LO_SHA1" &&
+	git cat-file -e "$HI_SHA1"
+'
+
+test_expect_success 'command-line allowance overrides false configuration' '
+	clear_packs &&
+	create_pack dups.pack 2 &&
+	git -c pack.allowDuplicateObjects=false index-pack \
+		--check-self-contained-and-connected \
+		--allow-duplicate-objects --stdin <dups.pack &&
+	git cat-file -e "$LO_SHA1" &&
+	git cat-file -e "$HI_SHA1"
+'
+
+test_expect_success 'command-line rejection overrides true configuration' '
+	clear_packs &&
+	create_pack dups.pack 2 &&
+	test_must_fail git -c pack.allowDuplicateObjects=true index-pack \
+		--check-self-contained-and-connected \
+		--no-allow-duplicate-objects --stdin <dups.pack 2>err &&
+	test_grep "appears twice in the pack" err
+'
+
+test_expect_success 'configured allowance does not relax explicit strict mode' '
+	clear_packs &&
+	create_pack dups.pack 2 &&
+	test_must_fail git -c pack.allowDuplicateObjects=true index-pack \
+		--strict --stdin <dups.pack 2>err &&
+	test_grep "appears twice in the pack" err
+'
+
+test_expect_success 'explicit strict mode cannot allow duplicate objects' '
+	clear_packs &&
+	create_pack dups.pack 2 &&
+	test_must_fail git index-pack --strict --allow-duplicate-objects \
+		--stdin <dups.pack 2>err &&
+	test_grep "cannot be used together" err
+'
+
+test_expect_success 'configured allowance does not relax verification' '
+	clear_packs &&
+	create_pack dups.pack 2 &&
+	git index-pack --check-self-contained-and-connected \
+		--allow-duplicate-objects --stdin <dups.pack &&
+	test_must_fail git -c pack.allowDuplicateObjects=true index-pack \
+		--verify .git/objects/pack/pack-*.pack 2>err &&
+	test_grep "appears twice in the pack" err
+'
+
+test_expect_success 'verify cannot allow duplicate objects' '
+	test_must_fail git index-pack --verify --allow-duplicate-objects \
+		.git/objects/pack/pack-*.pack 2>err &&
+	test_grep "cannot be used together" err
+'
+
+test_expect_success 'configured allowance preserves connectivity checks' '
+	clear_packs &&
+	tree=$(git mktree </dev/null) &&
+	commit=$(echo message | git commit-tree "$tree") &&
+	{
+		pack_header 2 &&
+		pack_obj $commit &&
+		pack_obj $commit
+	} >not-self-contained.pack &&
+	pack_trailer not-self-contained.pack &&
+	rm .git/objects/$(test_oid_to_path $commit) &&
+	test_expect_code 1 git -c pack.allowDuplicateObjects index-pack \
+		--check-self-contained-and-connected \
+		--stdin <not-self-contained.pack &&
+	test "$(git cat-file -t $commit)" = commit
+'
+
+test_expect_success 'allowing duplicates preserves object checks' '
+	clear_packs &&
+	tree=$(git mktree </dev/null) &&
+	cat >bad-commit <<-EOF &&
+	tree $tree
+	author A U Thor 1234567890 +0000
+	committer C O Mitter <committer@example.com> 1234567890 +0000
+
+	message
+	EOF
+	commit=$(git hash-object --literally -t commit -w --stdin \
+		<bad-commit) &&
+	{
+		pack_header 2 &&
+		pack_obj $commit &&
+		pack_obj $commit
+	} >bad-objects.pack &&
+	pack_trailer bad-objects.pack &&
+	rm .git/objects/$(test_oid_to_path $commit) &&
+	test_must_fail git index-pack \
+		--check-self-contained-and-connected --fsck-objects \
+		--allow-duplicate-objects --stdin <bad-objects.pack 2>err &&
+	test_grep "missingEmail" err
+'
+
+test_expect_success 'set up upload-pack that serves duplicate objects' '
+	test_commit clone-duplicates &&
+	commit=$(git rev-parse HEAD) &&
+	tree=$(git rev-parse HEAD^{tree}) &&
+	blob=$(git rev-parse HEAD:clone-duplicates.t) &&
+	{
+		pack_header 4 &&
+		pack_obj "$commit" &&
+		pack_obj "$tree" &&
+		pack_obj "$blob" &&
+		pack_obj "$blob"
+	} >clone-duplicates.pack &&
+	pack_trailer clone-duplicates.pack &&
+	write_script .git/duplicate-pack-hook <<-EOF
+	cat >/dev/null &&
+	cat "$TRASH_DIRECTORY/clone-duplicates.pack"
+	EOF
+'
+
+test_expect_success 'clone rejects duplicate objects by default' '
+	test_must_fail git clone --no-local \
+		-u "git -c uploadpack.packObjectsHook=./duplicate-pack-hook upload-pack" \
+		. clone-reject 2>err &&
+	test_grep "appears twice in the pack" err
+'
+
+test_expect_success 'shallow clone already accepts duplicate objects' '
+	git clone --no-local --depth=1 \
+		-u "git -c uploadpack.packObjectsHook=./duplicate-pack-hook upload-pack" \
+		. clone-shallow &&
+	test "$(git -C clone-shallow rev-parse HEAD)" = "$commit" &&
+	git -C clone-shallow fsck --full
+'
+
+test_expect_success 'filtered clone already accepts duplicate objects' '
+	git clone --no-local --filter=blob:none \
+		-u "git -c uploadpack.allowFilter=true -c uploadpack.packObjectsHook=./duplicate-pack-hook upload-pack" \
+		. clone-filter &&
+	test "$(git -C clone-filter config remote.origin.partialclonefilter)" = blob:none &&
+	test "$(git -C clone-filter rev-parse HEAD)" = "$commit" &&
+	git -C clone-filter fsck --full
+'
+
+test_expect_success 'clone -c pack.allowDuplicateObjects accepts duplicate objects' '
+	git clone --no-local -c pack.allowDuplicateObjects \
+		-u "git -c uploadpack.packObjectsHook=./duplicate-pack-hook upload-pack" \
+		. clone-allow &&
+	test "$(git -C clone-allow config --bool pack.allowDuplicateObjects)" = true &&
+	test "$(git -C clone-allow rev-parse HEAD)" = "$commit" &&
+	git -C clone-allow fsck --full
+'
+
 test_done
diff --git a/t/t5309-pack-delta-cycles.sh b/t/t5309-pack-delta-cycles.sh
index f613950e38..fb5ed81ca3 100755
--- a/t/t5309-pack-delta-cycles.sh
+++ b/t/t5309-pack-delta-cycles.sh
@@ -217,6 +217,16 @@ test_expect_success 'failover after a tail into a three-object delta cycle' '
 	check_blob "$T" tail
 '
 
+test_expect_success 'configured connectivity check recovers duplicate delta bases' '
+	clear_packs &&
+	git -c pack.allowDuplicateObjects index-pack --fix-thin \
+		--check-self-contained-and-connected \
+		--stdin <recoverable-1.pack &&
+	printf "\7\0" >expect.duplicate-base &&
+	check_blob "$A" expect.duplicate-base &&
+	git cat-file -e "$B"
+'
+
 test_expect_success 'index-pack works with thin pack A->B->C with B on disk' '
 	git init server &&
 	(

base-commit: fd2739b159d075cd4c6fa69b2cd876ba1caa5c88
