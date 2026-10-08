Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB544481FCE
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453152; cv=none; b=ieJpHFD4CdOU0zGIaFf/BU7A7BE/YqwqC63oVeB/Po4tP7vtLg8d+VEQlWgdFyGlJe7XEP2DwRP9kMdDPs3U83uQsDjCFFpaBKgKEQ9SQK+P7eR/upoHwi+JFMk3W3pIJu/S2Su4EpQ3feU7HYZXV28eI/tfj7QIRgxgyXCUhx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453152; c=relaxed/simple;
	bh=RE7BozTJeFZyzVTFFsfXdjNxK3d5GQXXwQSfDewYZDY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rTwLnNU12xLqieTYS1g/OkkQdZWaSNL84SJlkN5g1MEUtyxIMwjwk7E4Z8PwklZo1l/QGi19VtAQgR6RCCu1O7ZD8tnigoXlZBqjP4n6YYmOuoMGKQYnOcNIj3eDlDry5jZodqhtDCupkNIvQEY8LQGPrEthBcR+ynOiAWXKD6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnfhsV3S; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnfhsV3S"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-873a4edb243so3537658b3a.0
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 02:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791453150; x=1792057950; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C4gC0GIpX64VxYXTHzgjuUD+1RaVmsibmyIZqa2vxP0=;
        b=BnfhsV3SMmX2I2lfjGSM9Z6IItyB9/en2K/KXgeQz5zW4q0Os6bHo1+ncxqSwvF0bp
         FYI3BLbc2pacXFBJdaltkH6jKGJ+RSN2fyacYC7Q7md6nyQygfzw+L7K7AzWFt9OtpNN
         VG5PqBDUCt1VduTefFbvXi7f5ZjHj1i9cKHZNQfva82oUHZ8h2JPYhQc4UvlGuGoPw43
         as3Z+jbT/5mFQXtY3y8OvsoIsIOCJkZl3pO9QyZfyHZifjE2fY2FJ8VnaI6c1O9B7pCu
         xD8L8FhUW2yxk0udH8yy14p6gdIElqLO5wPBk4pXrI4MHMUxQVOj+THDj+IHADKjzVZK
         Xi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791453150; x=1792057950;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C4gC0GIpX64VxYXTHzgjuUD+1RaVmsibmyIZqa2vxP0=;
        b=UcaswRXyDxjmG1Pcyu8GXj3+Q3KxLWvl+YnDpYKzgH29Jp1Omjlc85hnQNjAYa/aCR
         8Ci+VjNsmYfU/ZtlpHyShTGM0ZNpvwhQLK3lD8H9WcgDtQ/oddFAK7n5lslts+p4v6FQ
         jRFJxlLGgLCEUJl+RDxHRKr6wIcXO6URqZ2zuOoF2an+EMaqoIA16Yi8uU0nUl1wl2Nz
         NQfmHz0LIAjjGhZyeE2lnC74kWxkylOtdg5+/xbpSXDNChpYmWRhJiNBDc8TbQzhVI9b
         /VDbdW0GaPhsA5QDcBYM2gnMM99MDqSJmkVujyzz1wOC2IZz01JOoXJZtAP++GichYcV
         hlsA==
X-Gm-Message-State: AFuF++mGr1r3fvocpwq5hgLarVc8uPNKmEk0OJrrlG1JKrwat8kkY9M1
	1/7aVBvrcoEB99wNsVexCRIFndfBORR9oQXeUuEIHdWhvwcUtehViF1yX17b3In5
X-Gm-Gg: AYBFou0tj1Vb1x8FBhZ3mhSkvVyMtZxifXmrnYDOaeGcDsSfcyAZvTQ1aRiajQf8PI0
	h/xZ5OCehCVPipfqbcI9aAkSydzG9WBCgy96uKLJLXoeklvHPfRtn2F1eAMWkixNz0zK1dEdj06
	/3a/gABdoI+u1IyEbjCdywwROOwg2g78msexR1yIgtMXtYNGf01J4gAQzmb4GYavo1ZlTGcgUZj
	xBLCCXDIcFDBCM3LQ/i7O4d6WmyyDaT604gdXZ/R5+/joq68QPCeP/8GAw7Semwnm7kQ/tMMDh6
	YBYVe08Fcd71bCE3h6eKuAemo8m3b6QM528qDorsX5WVSI+8LF1QhqzoVHley12PHsg3YWtRZpI
	Hkkbi+MjlxHAH7WBWm3sdbWMdy0qGy55OQlQc3t2lyl/6aZQ/FQFd+Q4LA/7xhnx2lkZ0b5VdPj
	rCdfZvNt7bMWPh+82hlcmXR7g9tz8GOsVc773Ga7G9i5Yj3voh0O1uPfuPxBSL95g6pLDz7utXl
	w==
X-Received: by 2002:a05:6a00:348c:b0:882:359f:ef17 with SMTP id d2e1a72fcca58-891b138dae4mr4299383b3a.12.1791453149901;
        Thu, 08 Oct 2026 02:52:29 -0700 (PDT)
Received: from [127.0.0.1] ([4.154.246.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-892bc17706csm1302465b3a.60.2026.10.08.02.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 02:52:29 -0700 (PDT)
Message-Id: <148175cfa00fd835a296dd1ed04703c2a80b7e3d.1791453141.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2219.v3.git.1791453141.gitgitgadget@gmail.com>
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
	<pull.2219.v3.git.1791453141.gitgitgadget@gmail.com>
From: "Qin ShiCheng via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 08 Oct 2026 09:52:20 +0000
Subject: [PATCH v3 4/5] pack-objects: add --keep-pack-from-file
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
index 48faef2227..621b333d0b 100644
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
@@ -5002,6 +5003,26 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
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
@@ -5142,8 +5163,10 @@ int cmd_pack_objects(int argc,
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
@@ -5228,6 +5251,8 @@ int cmd_pack_objects(int argc,
 			 N_("ignore packs that have companion .keep file")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
 				N_("ignore this pack")),
+		OPT_FILENAME(0, "keep-pack-from-file", &keep_pack_from_file,
+			     N_("ignore the packs named in <file>")),
 		OPT_INTEGER(0, "compression", &cfg->pack_compression_level,
 			    N_("pack compression level")),
 		OPT_BOOL(0, "keep-true-parents", &grafts_keep_true_parents,
@@ -5455,6 +5480,8 @@ int cmd_pack_objects(int argc,
 	if (progress && all_progress_implied)
 		progress = 2;
 
+	if (keep_pack_from_file)
+		read_keep_pack_list(&keep_pack_list, keep_pack_from_file);
 	add_extra_kept_packs(&keep_pack_list, stdin_packs);
 	if (ignore_packed_keep_on_disk) {
 		struct packed_git *p;
@@ -5549,6 +5576,7 @@ cleanup:
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

