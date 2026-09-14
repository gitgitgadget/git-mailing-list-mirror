Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF1E446847
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385496; cv=none; b=Q36eRGIETV0VRPGfStQHaSmSkMqyPdE3uxIYvaTId+9UCQsC81p4bNG3NVCo+J2a9GSqUjAeNZg9SpIeLhSVwU24c/LaMyTGR8bBNXEFAA7jDVNPLipIQpJbM+VTKv6IcYj154ZkWKsbFcnN0B6PTUP8g+YSu5MnhN6Ca9anaGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385496; c=relaxed/simple;
	bh=5Z4V3yPnDOxEad/m4r1X0w4S+aiRWuyaght+dqC7bHA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dMupFfYKwi+4Rt50m1lgS24nyHcwj08OGCAtcBehdGWzm9W3WoqMBK3/Y90rj5xMHLx8uw4jbI+JJbtUobEDKubqGXLOtfb0C1gtjcr9I6N8xxnznxq+5Mr2Y0YvAnAlqNpQEf4pGMi0bejvgqh8GdFsgKct6+8yWAZjmbMEK2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIXQa8gF; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIXQa8gF"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747eb79f7so11716795ad.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 04:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789385495; x=1789990295; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dKH9PEF0YOwsM1PNlmsMK2CSjvhcpygsK9JaAZhe/ds=;
        b=QIXQa8gF+ennJWEzPxpk9dTmQzYAji5Kye5suRPM0rlW0UYAs/oeysyaQhd4ZywLfS
         yC4MMDwAl78MuwOK5BxMcmIMMwkm+ZAZ9HZSVwAXAOmFMuvWBmpXzPZ15pkSB9w5SPU2
         q9Wp4HB3Vx2C1DOR6hjmQZKXYx7VPjRP1L3zuzzZKvHLn0/updRMl4HqqJYD/s0/7Q1i
         6MtA5KWHSVXUIKhWV1UgLhi3Vz1m9kqYD39TOtIO2I7EifF5TWX7Js1UqGv1UZX60zDl
         iSQcPOwu+KJvoig8esEmE6Jf6ApxOb8c5kJibps4awK1yQ3AIol4Tmpqd7GoOfJCEM0r
         kUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789385495; x=1789990295;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dKH9PEF0YOwsM1PNlmsMK2CSjvhcpygsK9JaAZhe/ds=;
        b=aUMyc4inxHeh979Rql8WOoiD960DHJZB+RR4m4dqPgdsRNkUFjVPlNLcSMyepeG6gH
         MbloG/wCFQfQqLs53I6VmabbBFoF0G7m0evm8tfbOgfA2K6uU8XenFK1Lz9E5FfDvinA
         5wAtBsy66QpoDvrZNnes0purEMsThIKSxSnv2wsPd0mskLRKL9tsSkprEoXspezK+0fY
         0euL7Y+tE7T2BD/rAh0MBRU5uLR3G+awbWWy9wemf6xxeDkxoYJUgO26jfP82+e5EzyU
         7V16ciCq8tjzBYCTiXDSQUoMkclOHQDGMGY0RQmHrkQGF7llAg1OJOlpdeBBVZrhWv4z
         7jpw==
X-Gm-Message-State: AFuF++lls4l8pImYkvb33+zIgNjerGjTAWWgPD+gj7M8ICbJZysDz8Ol
	JQK8nwawdDEOGWVszkyrRpZ8m1OizRMWlM/uY7zGJ7x707j2t2DXi1bYiZIm5Q==
X-Gm-Gg: AYBFou2OcvK49i2bj7Xs4YhYlU9F7ygq4VARxQwzeXmuaWqy8Px/Uzcv9sMTfANdC5q
	TPMw1mWr62r/toiuZxY3CS6cbnNI/RBhVr6zRDf19glwceZcCqFsomVA88SSqmsBXTuHcfzfZPW
	y7hxzUdz9EbI/zu6AJjjaE4V9DsT6auAW4LM5LXacXGnoJuuINDLnZF+o0qOU5UoEh3s9f/Xg8P
	DeoYl2wKw8zyix6ozgSzjAFWLBSuZSGk5/wB7lvbxBQdG2N9mrBSW0qp6bl8Z1iBC/yxi7IXF8a
	kyCg5nfGUuAsG4xLMm0Ts/aY93UMdVgDv9pPpLmVTjbaGa0cX4X0RZkkTaj75HdxUVFP2RknSOC
	TCnt4W9Uagh2KqpE3+GdhVY79SPvP9DspaMGxFmfQN/7p6dgza47qyLrpsKBtbEIvWk0wrv/of5
	0HiGdVuMrxqM+i1PKhnsTmbh5Wbh6Caa0KFuQZ2ennADtg3bwB9YH9PzpUaCVEH3ydimaz0v9+H
	Vum
X-Received: by 2002:a17:902:fc4b:b0:2db:257c:9fd5 with SMTP id d9443c01a7336-2dd6c70df7dmr54090605ad.16.1789385494524;
        Mon, 14 Sep 2026 04:31:34 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.219.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2ceb715bsm46840525ad.39.2026.09.14.04.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 04:31:33 -0700 (PDT)
Message-Id: <f8e27b7aacb969fa1162847606871f7df6748274.1789385483.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
From: "Qin ShiCheng via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 14 Sep 2026 11:31:22 +0000
Subject: [PATCH 5/6] pack-objects: add --keep-pack-from-file
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Taylor Blau <ttaylorr@openai.com>,
    Junio C Hamano <gitster@pobox.com>,
    Justin Tobler <jltobler@gmail.com>,
    qeesung <qeesung@live.com>,
    Qin ShiCheng <qeesung@live.com>

From: Qin ShiCheng <qeesung@live.com>

"--keep-pack" names one pack per occurrence, and there is only so much
room on the command line: ARG_MAX is shared with the environment, and
on Windows the whole line is capped at 32,767 characters, which a few
hundred pack names fill. Past that the spawn fails before pack-objects
has started. fetch-pack grew "--stdin" in 078b895fef (fetch-pack: new
--stdin option to read refs from stdin, 2012-04-02) for the same
reason.

stdin is taken here: every mode repack drives pack-objects in already
uses it, for the revision list under "-a", object names for the
promisor pack, and pack lists for "--stdin-packs" and "--cruft". So
read the names from a file instead, one per line, skipping empty
lines. They go into the same list as the "--keep-pack" names and are
treated exactly alike: matched against local packs, ignored when they
match nothing, and kept open under "--stdin-packs=follow". A relative
path is resolved against the directory the user ran from, as
"--refs-snapshot" of "git multi-pack-index write" is.

The list now holds strings from two sources, so let it own its copies.

repack is about to use this to hand pack-objects its own snapshot of
the packs that have a ".keep" file.

Signed-off-by: Qin ShiCheng <qeesung@live.com>
---
 Documentation/git-pack-objects.adoc |  8 +++++
 builtin/pack-objects.c              | 28 ++++++++++++++++++
 t/t5331-pack-objects-stdin.sh       | 46 +++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 65cd00c152..938e27f69d 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -13,6 +13,7 @@ SYNOPSIS
 		   [--no-reuse-delta] [--delta-base-offset] [--non-empty]
 		   [--local] [--incremental] [--window=<n>] [--depth=<n>]
 		   [--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
+		   [--keep-pack-from-file=<file>]
 		   [--cruft] [--cruft-expiration=<time>]
 		   [--stdout [--filter=<filter-spec>] | <base-name>]
 		   [--shallow] [--keep-true-parents] [--[no-]sparse]
@@ -193,6 +194,13 @@ depth is 4095.
 	leading directory (e.g. `pack-123.pack`). The option could be
 	specified multiple times to keep multiple packs.
 
+--keep-pack-from-file=<file>::
+	Read names of packs to keep from `<file>`, one per line, and
+	treat each of them as if it had been given with `--keep-pack`.
+	Empty lines are ignored. This is meant for callers such as
+	linkgit:git-repack[1] that may have to name more packs than fit
+	on a command line.
+
 --incremental::
 	This flag causes an object already in a pack to be ignored
 	even if it would have otherwise been packed.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1fcb4ef8a5..9f8c4b9135 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -194,6 +194,7 @@ static const char *const pack_usage[] = {
 	   "                 [--no-reuse-delta] [--delta-base-offset] [--non-empty]\n"
 	   "                 [--local] [--incremental] [--window=<n>] [--depth=<n>]\n"
 	   "                 [--revs [--unpacked | --all]] [--keep-pack=<pack-name>]\n"
+	   "                 [--keep-pack-from-file=<file>]\n"
 	   "                 [--cruft] [--cruft-expiration=<time>]\n"
 	   "                 [--stdout [--filter=<filter-spec>] | <base-name>]\n"
 	   "                 [--shallow] [--keep-true-parents] [--[no-]sparse]\n"
@@ -5007,6 +5008,26 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
 	oid_array_clear(&recent_objects);
 }
 
+/*
+ * Read pack names from the file, one per line, as if each of them had
+ * been given with "--keep-pack".
+ */
+static void read_keep_pack_list(struct string_list *names, const char *path)
+{
+	struct strbuf buf = STRBUF_INIT;
+	FILE *fp = xfopen(path, "r");
+
+	while (strbuf_getline(&buf, fp) != EOF) {
+		if (!buf.len)
+			continue;
+		string_list_append(names, buf.buf);
+	}
+	if (ferror(fp))
+		die_errno(_("could not read '%s'"), path);
+	fclose(fp);
+	strbuf_release(&buf);
+}
+
 static void add_extra_kept_packs(struct string_list *names,
 				 enum stdin_packs_mode stdin_packs)
 {
@@ -5147,8 +5168,10 @@ int cmd_pack_objects(int argc,
 	int rev_list_index = 0;
 	enum stdin_packs_mode stdin_packs = STDIN_PACKS_MODE_NONE;
 	struct string_list keep_pack_list = {
+		.strdup_strings = 1,
 		.cmp = fspathcmp,
 	};
+	char *keep_pack_from_file = NULL;
 	struct list_objects_filter_options filter_options =
 		LIST_OBJECTS_FILTER_INIT;
 	struct repo_config_values *cfg = repo_config_values(the_repository);
@@ -5233,6 +5256,8 @@ int cmd_pack_objects(int argc,
 			 N_("ignore packs that have companion .keep file")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
 				N_("ignore this pack")),
+		OPT_FILENAME(0, "keep-pack-from-file", &keep_pack_from_file,
+			     N_("ignore the packs named in <file>")),
 		OPT_INTEGER(0, "compression", &cfg->pack_compression_level,
 			    N_("pack compression level")),
 		OPT_BOOL(0, "keep-true-parents", &grafts_keep_true_parents,
@@ -5460,6 +5485,8 @@ int cmd_pack_objects(int argc,
 	if (progress && all_progress_implied)
 		progress = 2;
 
+	if (keep_pack_from_file)
+		read_keep_pack_list(&keep_pack_list, keep_pack_from_file);
 	add_extra_kept_packs(&keep_pack_list, stdin_packs);
 	if (ignore_packed_keep_on_disk) {
 		struct packed_git *p;
@@ -5554,6 +5581,7 @@ cleanup:
 	clear_packing_data(&to_pack);
 	list_objects_filter_release(&filter_options);
 	string_list_clear(&keep_pack_list, 0);
+	free(keep_pack_from_file);
 	strvec_clear(&rp);
 
 	return 0;
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index 4e1fde1b08..d590aa4dad 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -561,4 +561,50 @@ test_expect_success '--stdin-packs with !-delimited pack without follow' '
 	)
 '
 
+test_expect_success '--keep-pack-from-file names packs to keep' '
+	test_when_finished "rm -fr repo" &&
+
+	git init repo &&
+	(
+		cd repo &&
+		git config set maintenance.auto false &&
+
+		test_commit A &&
+		test_commit B &&
+		test_commit C &&
+
+		A="$(echo A | git pack-objects --revs $packdir/pack)" &&
+		B="$(echo A..B | git pack-objects --revs $packdir/pack)" &&
+		C="$(echo B..C | git pack-objects --revs $packdir/pack)" &&
+		git prune-packed &&
+
+		# Empty lines and names that match no pack are ignored,
+		# as they would be with --keep-pack.
+		cat >keep <<-EOF &&
+		pack-$A.pack
+
+		pack-$B.pack
+		pack-does-not-exist.pack
+		EOF
+
+		P=$(git pack-objects --all --keep-pack=pack-$A.pack \
+			--keep-pack=pack-$B.pack from-argv </dev/null) &&
+		packed_objects from-argv-$P.idx >expect &&
+
+		P=$(git pack-objects --all --keep-pack-from-file=keep \
+			from-file </dev/null) &&
+		packed_objects from-file-$P.idx >actual &&
+		test_cmp expect actual &&
+
+		objects_in_packs $C >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--keep-pack-from-file with a missing file' '
+	test_must_fail git pack-objects --stdout \
+		--keep-pack-from-file=does-not-exist </dev/null 2>err &&
+	test_grep "could not open .does-not-exist. for reading" err
+'
+
 test_done
-- 
gitgitgadget

