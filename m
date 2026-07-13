Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6118B13B5B3
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 01:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783905123; cv=none; b=m5x8QSpVaziRZcjnAvckwwtGFJ1o+mx0JnQPQtMIcyNaOz3xGpQTHyH9WLrQIcPfUzeacqqSdtzToHnwVWylUIHtcsHqvawprWONrO1yPHehfTB6CYWfGOWqLvqelnxFLfl7fvKeHu+VkOIWzFo9fXcrvZc1cdHa0R8TZ31TbTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783905123; c=relaxed/simple;
	bh=o4zIgQpjyFbRFcToldXZwpAxxGMOK7TSBy/o+ToFQsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mey/JxnSyrzghuXQ1vuCMfUeCqw9zEKX80v61rroKJCnzNG7jQQyw9b83+FBJV3JeaMt6BDMHKlMnZXz7Eb8FpJhdYWUMe+5rii5fM69sKDCSf0HvZ11McV63hk+Kz2lE2e422/ebMOwUo2QZMcrdMjQYHJrvZiRiDgd7Zv/nfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=B/AvmPJo; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="B/AvmPJo"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81e86df8987so26391607b3.3
        for <git@vger.kernel.org>; Sun, 12 Jul 2026 18:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783905121; x=1784509921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UNK6zbOOyjHbzy0J5VHO4KCsiVfuldhzhCcI9GoTOcI=;
        b=B/AvmPJo1OLuWCk/P9dnCFOMrz5fL5f682TaCKB1Y3Jq2xRssquyEhGOg6Yx4vNJBd
         D0Q5eIi6oQOY804UMXHiQ1ydXIFf6fx0CN8yIt7cXbtjDLVBM1hDWgveBVF25w2ukhes
         sLVRQOoj/GV580giadmjNUc7s7OwR0tSC0fRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783905121; x=1784509921;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UNK6zbOOyjHbzy0J5VHO4KCsiVfuldhzhCcI9GoTOcI=;
        b=QQr2u+HAWuMvi0MjE9MWnTDpf6dbNmiIID2vs310UyhSHb0/dv7aOmaldoJISfHkXz
         Q2GTti3SmYwv87CAJxqPpXa/+N2NLnWXTQr/ogcR8BLYpvRso7f8HzG6V/ycyYAzGd2j
         AOR6kJWruXFyPgr5LLf6yrB45glklJ8fc9fGWmvdboTzXpifyxktp9wxAHqqGZz4lmtz
         k4899tfJR95ISADj/iAPHVNKfHpRZkGIKv2moBLE2EYVkrAuDZvrmH5Ae11q/9S3xJgL
         Kl8amtpaEH86w60IukA6fOBmpi+1mpOMAWDOj7NBAmZZMumTx1fmqC7L2hOK/S1nJvtw
         BLAA==
X-Gm-Message-State: AOJu0YwM4g89UOdGv+a4GT+8V0SerU/vpeZ1GTop8ZBVUCCLcMsNvZXy
	6I/hqymDzZ5p/KSvPbENQQceH31CIgxQaRaPkWjTPAYLJAAWh40TiuXBX+nd6XU9X2hbqKd6aP/
	hQNUhi40/Gg==
X-Gm-Gg: AfdE7cmLgjWU2zNQgMM6XhnqDUSFjhxhIFIaZd/Eme/qC2NGOeuUtooUTlN61jpvtWF
	vmu26fem+MD0HrWr+zqIuimx0J91mEnc0q9QAA2mxjgAyB4boSA6XGacUq9XAa+yem9fQRIkK0+
	Yj76Gdocm6836D/iE5nVodk/P+FzqZ0zR8zVGbBmDp7sdXg3kfNJTRjaabbzB86MtoDF6nWslz3
	u0v/k8EuCvb/JJjfbDxCONaSK3TW0uep+ujOE/4WFdD9uMKA47QzA3bVYcgoFnWacBcPbXvOpEK
	3bXqvdQuUQEJzYaCCsgSLw6DJHne3lKo6OIswPvKabMPwxxL4Nnw4FI5j8l5nN7PipsLbOEMiGI
	9VLS52o68KcIxslsjnB4DFjMqw+Z0d6mLIZoIdn1rfP0ucONiU4LluageXEJ5oEb2B/WYuF659o
	/f3oC87vc/UVSuFMlAk4bAcFz53uMRiXOs
X-Received: by 2002:a05:690c:6b83:b0:81e:6b13:4463 with SMTP id 00721157ae682-81e9015b234mr57808897b3.46.1783905121315;
        Sun, 12 Jul 2026 18:12:01 -0700 (PDT)
Received: from com-79390 ([12.187.141.7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6be98dfbsm103176577b3.2.2026.07.12.18.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 18:12:00 -0700 (PDT)
Date: Sun, 12 Jul 2026 18:11:57 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] pack-objects: introduce `--no-ref-delta`
Message-ID: <alQ7XVq5CYD8CyE8@com-79390>
References: <cover.1783905084.git.ttaylorr@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1783905084.git.ttaylorr@openai.com>

Some consumers of 'pack-objects' may wish to avoid packs which contain
`REF_DELTA` entries. For instance, a 'receive-pack' implementation which
retains the resulting pack without building an index of object IDs may
prefer every delta base to be discoverable from an earlier entry in the
same pack.

Teach 'pack-objects' a new `--no-ref-delta` option to avoid writing
`REF_DELTA` entries, without changing whether `OFS_DELTA` is allowed.

When used without `--delta-base-offset`, no delta representation
remains, so avoid delta search entirely. Otherwise, allow new deltas
whose bases appear earlier in the same pack.

For now, disable delta- and bitmap-reuse under `--no-ref-delta`, since
either may copy an existing `REF_DELTA` entry. This is overly
pessimistic, but simplifies the changes in this commit. The next commit
re-enables reuse in the cases which do not require `REF_DELTA`.

Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
 Documentation/git-pack-objects.adoc |  8 ++++-
 builtin/pack-objects.c              | 16 ++++++---
 t/t5300-pack-object.sh              | 52 +++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 65cd00c152..5e42e4429d 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -10,7 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git pack-objects' [-q | --progress | --all-progress] [--all-progress-implied]
-		   [--no-reuse-delta] [--delta-base-offset] [--non-empty]
+		   [--no-reuse-delta] [--delta-base-offset] [--no-ref-delta]
+		   [--non-empty]
 		   [--local] [--incremental] [--window=<n>] [--depth=<n>]
 		   [--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
 		   [--cruft] [--cruft-expiration=<time>]
@@ -297,6 +298,11 @@ Note: Porcelain commands such as `git gc` (see linkgit:git-gc[1]),
 in modern Git when they put objects in your repository into pack files.
 So does `git bundle` (see linkgit:git-bundle[1]) when it creates a bundle.
 
+--no-ref-delta::
+	Do not emit deltas which represent their base by their literal
+	object ID. This is independent of `--delta-base-offset`;
+	without that option, no deltas are emitted.
+
 --threads=<n>::
 	Specifies the number of threads to spawn when searching for best
 	delta matches.  This requires that pack-objects be compiled with
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e3760b3492..c3574fcb8a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -190,7 +190,8 @@ static inline void oe_set_delta_size(struct packing_data *pack,
 
 static const char *const pack_usage[] = {
 	N_("git pack-objects [-q | --progress | --all-progress] [--all-progress-implied]\n"
-	   "                 [--no-reuse-delta] [--delta-base-offset] [--non-empty]\n"
+	   "                 [--no-reuse-delta] [--delta-base-offset] [--no-ref-delta]\n"
+	   "                 [--non-empty]\n"
 	   "                 [--local] [--incremental] [--window=<n>] [--depth=<n>]\n"
 	   "                 [--revs [--unpacked | --all]] [--keep-pack=<pack-name>]\n"
 	   "                 [--cruft] [--cruft-expiration=<time>]\n"
@@ -221,6 +222,7 @@ static int ignore_packed_keep_in_core;
 static int ignore_packed_keep_in_core_open;
 static int ignore_packed_keep_in_core_has_cruft;
 static int allow_ofs_delta;
+static int allow_ref_delta = 1;
 static struct pack_idx_option pack_idx_opts;
 static const char *base_name;
 static int progress = 1;
@@ -3405,6 +3407,9 @@ static int should_attempt_deltas(struct object_entry *entry)
 	if (entry->no_try_delta)
 		return 0;
 
+	if (entry->preferred_base && !allow_ref_delta)
+		return 0;
+
 	if (!entry->preferred_base) {
 		if (oe_type(entry) < 0)
 			die(_("unable to get type of object %s"),
@@ -3647,7 +3652,8 @@ static void prepare_pack(int window, int depth)
 	if (!pack_to_stdout)
 		do_check_packed_object_crc = 1;
 
-	if (!to_pack.nr_objects || !window || !depth)
+	if (!to_pack.nr_objects || !window || !depth ||
+	    (!allow_ref_delta && !allow_ofs_delta))
 		return;
 
 	if (path_walk)
@@ -4662,7 +4668,7 @@ static int pack_options_allow_reuse(void)
 	       !ignore_packed_keep_on_disk &&
 	       !ignore_packed_keep_in_core &&
 	       (!local || !have_non_local_packs) &&
-	       !incremental;
+	       !incremental && allow_ref_delta;
 }
 
 static int get_object_list_from_bitmap(struct rev_info *revs)
@@ -5111,6 +5117,8 @@ int cmd_pack_objects(int argc,
 			 N_("reuse existing objects")),
 		OPT_BOOL(0, "delta-base-offset", &allow_ofs_delta,
 			 N_("use OFS_DELTA objects")),
+		OPT_BOOL(0, "ref-delta", &allow_ref_delta,
+			 N_("use REF_DELTA objects")),
 		OPT_INTEGER(0, "threads", &delta_search_threads,
 			    N_("use threads when searching for best delta matches")),
 		OPT_BOOL(0, "non-empty", &non_empty,
@@ -5309,7 +5317,7 @@ int cmd_pack_objects(int argc,
 	if (unpack_unreachable || keep_unreachable || pack_loose_unreachable)
 		use_internal_rev_list = 1;
 
-	if (!reuse_object)
+	if (!reuse_object || !allow_ref_delta)
 		reuse_delta = 0;
 	if (cfg->pack_compression_level == -1)
 		cfg->pack_compression_level = Z_DEFAULT_COMPRESSION;
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 4bee490ff6..b9e36044b9 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -211,6 +211,58 @@ test_expect_success 'pack with OFS_DELTA' '
 	test_grep " OFS_DELTA " deltas
 '
 
+test_expect_success 'pack without REF_DELTA' '
+	git pack-objects --no-ref-delta --stdout <obj-list >no-ref.pack &&
+	git index-pack -o no-ref.idx no-ref.pack &&
+
+	test-tool pack-deltas --list-deltas no-ref.idx >deltas &&
+	test_must_be_empty deltas
+'
+
+test_expect_success 'pack without REF_DELTA with OFS_DELTA' '
+	git pack-objects --delta-base-offset --no-ref-delta --stdout \
+		<obj-list >no-ref-ofs.pack &&
+	git index-pack -o no-ref-ofs.idx no-ref-ofs.pack &&
+
+	test-tool pack-deltas --list-deltas no-ref-ofs.idx >deltas &&
+	test_grep " OFS_DELTA " deltas &&
+	test_grep ! " REF_DELTA " deltas
+'
+
+test_expect_success 'pack without REF_DELTA skips excluded delta bases' '
+	test_when_finished "git read-tree $tree" &&
+
+	echo bar >>d &&
+	git update-index --add d &&
+	thin_tree=$(git write-tree) &&
+	thin_commit=$(git commit-tree $thin_tree -p $commit </dev/null) &&
+
+	{
+		echo $thin_commit &&
+		echo ^$commit
+	} >thin-revs &&
+
+	# Each type appears only once in the output, so any delta must
+	# use an excluded base and therefore be a REF_DELTA.
+	git pack-objects --thin --stdout --revs \
+		<thin-revs >thin.pack &&
+	git index-pack --fix-thin --stdin thin-fixed.pack \
+		<thin.pack >/dev/null &&
+
+	test-tool pack-deltas --list-deltas thin-fixed.idx >deltas &&
+	test_grep ! " OFS_DELTA " deltas &&
+	test_grep " REF_DELTA " deltas &&
+
+	git pack-objects --thin --stdout --revs \
+		--delta-base-offset --no-ref-delta \
+		<thin-revs >no-ref-thin.pack &&
+	git index-pack --fix-thin --stdin no-ref-thin-fixed.pack \
+		<no-ref-thin.pack >/dev/null &&
+
+	test-tool pack-deltas --list-deltas no-ref-thin-fixed.idx >deltas &&
+	test_must_be_empty deltas
+'
+
 test_expect_success 'unpack with OFS_DELTA' '
 	check_unpack test-3-${packname_3} obj-list
 '
-- 
2.55.0

