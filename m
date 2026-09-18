Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8607C3E2ABA
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 03:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700628; cv=none; b=oNaePFQa9jE7ut/Wb5oXsB1x1Xf3a2giKW7dolActxC1R+j72cjlbdQvtXpDay7HiQEIsAm2+TZ9fgBUSDEzkc2tzf8GRmEzuA2h5DTdydtslso7V03b0oKsXbIlymL12YxgcV915btrXftHIcAGg/EejPRjmSdnQEUdj+gwVww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700628; c=relaxed/simple;
	bh=5Z4V3yPnDOxEad/m4r1X0w4S+aiRWuyaght+dqC7bHA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kE0d/l0BhNj9aGovDEo10i17xIfos2F2auTQGDmmGBEAnYUh5acvfix3Ut+McYp79kTmnsAiRSjqDktp2u0Z5RACKdD4agtRMxJlfBuo9pTFcvoyGg+tJZRcU2S3sRmZVQY7bSc93c/UKiBKTqQe5+LYacHlbT0xMbPQlv1DU3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ow8IwqxV; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ow8IwqxV"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939eb3249c1so25947285a.2
        for <git@vger.kernel.org>; Thu, 17 Sep 2026 20:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789700621; x=1790305421; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dKH9PEF0YOwsM1PNlmsMK2CSjvhcpygsK9JaAZhe/ds=;
        b=ow8IwqxVjsWDuQ1yJu6TtFwoj2VslKCEl/xTr4hR3GUCpXfeWohqKczvGLCVK+cj7B
         xT0ZQ8C8wj8rwwwboU1vebRnli3kV/ROgKb/CZVnqKvwl2OpGqn6MAF3T6MtzIzydcix
         7vRrWhTxX+OauSctHrdvmU7ymsKnl39EsF74IL5K8A78cMcV9Fsa2aRMzYmJdyNNuiKJ
         gJcAsPVx/M2fNeTVZ/VOu15zhFAXixxjdBA6WYAx1MnbcrsXc6G6wG6f9C1yKtwoh19W
         MGripTBVDaTN9AJYgNHL19MIQFS/XjPWJnGTd43bp2pt5gmMcJG8iOGHznE06aBJl1sQ
         5LnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789700621; x=1790305421;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dKH9PEF0YOwsM1PNlmsMK2CSjvhcpygsK9JaAZhe/ds=;
        b=2zuBJrjK5PNkWY6V/zrNhVYj/LtqbUTgS/QceDPSciFXiG54R9urIJD5aoTsgBrwvm
         20k4apFZq/oPjp/ES4FsQIdMgGCt3okeEg2bQ9/pjjUTKutII3L7OTDuawO7ZfxqeLVh
         736TeiMDKBm4ndBamysG5ZxdXjsBRe6hc/XAETT4i4jHYsJFguBjp6k+3XAQ09wiDj+J
         dKNXzAO1zKDEA6pbxXvrpTBCn8LsGA8RMqTnw/EO+r5SOHFErBf6UwvaT2bJ5Uaqp5w2
         xx6/HHMRiyvSEDYdTVaq+U4HzAGISeli76Tjrcx+rPZeJHX02GO4rH8Uq8DSVdFW302v
         LEAA==
X-Gm-Message-State: AFuF++mSVYyP3JA2MBJzRyeMifLq3/MPv8WCsVVCOf/v4VmtBVAXL22w
	cxOGreeDtmKakXrgCwTdYR9JO7y7VFMXPo96nLBYgKaY7bX+ANVJk92pkvo7OQ==
X-Gm-Gg: AYBFou0tXIZ7HgkDtSNJLcZmejEp+EAmkSBxG0nSOE5+QIFu2b3N84/vpXNh+MY/C5m
	ZWFXlD6f4OMF5N0b+RK9Hl8yZqRtZCXHWjX5fr5Is36McNYjD0fmRNb6+x/VX98SECyVHUoFZ6G
	xH3N7Q76Rop7TN1BYnJg2NoC/619wqvNDHq52j4RC4C4aGa8VkxQB8tuTD397jzLfVcd5DKIzjT
	X+DoXxQufYuL5i0zquKmVK+cLXasCTmkVws6ZMLeQ7IZIIRQ8Uc9Yz+1pBokwq3abMAarqdMliT
	vPZeln7dYIHEBBo4l4dguZWfYEZm1WCrneewB4/JocTY1Nvt2DMIqR4+9QXanh4OxGudaJmcF00
	dXvMKnDd0nKLRqfHmpjtfkxs8ZnM4FAp5h+HIwbwQGKrbtFSmjb0pj7909VqDiTuvoQd/12cC7Z
	pqxay36v3GzYT1IzyXk5hLMVeUpj/FpO5FW3+mNXEFUyLs6c37hGlYS6Ff2wPh4vdSIbu1wlyqx
	A==
X-Received: by 2002:a05:620a:708d:b0:939:d762:e2d8 with SMTP id af79cd13be357-93bdc7308e0mr150910885a.31.1789700621493;
        Thu, 17 Sep 2026 20:03:41 -0700 (PDT)
Received: from [127.0.0.1] ([20.97.198.245])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0e90a13sm27538485a.20.2026.09.17.20.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 20:03:41 -0700 (PDT)
Message-Id: <20a051cfb6fb23b6cdb7adf6cf53a2b8eb2f4391.1789700616.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2219.v2.git.1789700615.gitgitgadget@gmail.com>
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
	<pull.2219.v2.git.1789700615.gitgitgadget@gmail.com>
From: "Qin ShiCheng via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 18 Sep 2026 03:03:34 +0000
Subject: [PATCH v2 4/5] pack-objects: add --keep-pack-from-file
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

