Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3FF27F01E
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803887; cv=none; b=Y73cfgmbNzL1sXSzong/6pK64tfg0MsR0S/sBEocglJ11+QmoM4YgTLfakLlRechfoRskv8qP3DtdN0+UlnhZ5Fc2jWyDytnV3OAI8W6UxJC4x8eVZEOjHbFON2xC30Hhgi0yVVkkotIdi+lpJj2mCruH84yN+qqjIBnxAQ5C6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803887; c=relaxed/simple;
	bh=Jh0G0BE5UbRuV66zDfQIm1O9QQSl1XGWdeLAVP3dF+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnHSg9SM6tRd8pPAkoBKVFD0j7Zw7DU4NNq98hiAtNlWBjG4WLFwPoVerUoUFh9V7qyuPxa7oWaDWvEjo1ak1pp++j4OcLn3TH6clWdTfK0YKVgOKdUidyHLDD1NvPXJISaU8hW2MrCltSrmyFxXYJgZJkiJclaN8arVx3A9fPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=X7+UVFsw; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="X7+UVFsw"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8ec37d52c0dso254494685a.0
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 13:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776803885; x=1777408685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VJSpTUWS98wM9EFKygBt+kZV1KKjXfOb6SjoR8mABoM=;
        b=X7+UVFswgWeTXlc/lYBfN3LQ079ArabJTm1pPILF8Th/azR83r/GRwGA5rPli2xBFK
         A/XkFGsG5KYZWOtSCk5A30C6DS4w7O5LyjbMowjGrRmujN4SmYbHzjbHztkgc1aPTdJW
         T5JetPAMZZ8a/yjy2l6o/C7oAqm9j+NGfmaNL0rqFgQNPRAJQ88rwVLFCsIA2OdiKyAL
         OU8D75FPzMsEIaKFnAMUcbnRnSLRGSrUdioRREwEvdHqSU+g+SKb4bAUr9qK7/LzQKR+
         NkxEKlJKyDqsztb9wC1RpCTIra1B6ev8IAUs2H+OjbfLNIpt8LVmzPDiT1aHCCsYNR9A
         hpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776803885; x=1777408685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJSpTUWS98wM9EFKygBt+kZV1KKjXfOb6SjoR8mABoM=;
        b=Co97S+GE+hmiL1QFe2yz9Gmqba/5pDnxSWSnu3Ntk/YxITMuuSkujh7sbMddVeKYb5
         mktQLZ95tk3zLJh3xBTe2X4mZi48jPhpvNVvep/SN9af3dyX3/vK1+tdUVwx5E4Rxga2
         d4UPk55HiSDTqkE3Ffs8VhNjJcyTDFbaHs9cPTAJEXcCpOO4lndbMr3JHHARNRRbwby1
         mXoRH6tmDMrGvNgG8oZX56rguWAwR3w5fWQOqHSA9TxDlkEniuvURmt1RF079djCFqSc
         Af2X9z7uLzUQVBeth6aZax9Q1UV84YiyFvYnEVed96aJ9DTtBd+y29p2QGOabwoeYuQk
         K0iw==
X-Gm-Message-State: AOJu0Yx5Xm50+FC1HDNtGrYiLICu5yPtKWIKVgAMpFTn4lW7SHD6yMrH
	wlnyHNx08KCckLUlTlFzqq4JYGEO5XxkC1j9omK7mmTRda+4s1C7H7PzlBsH5/g7I3OVCzrxoFT
	C1qK3KbU=
X-Gm-Gg: AeBDieu1AVSes6hfMVkdlUp/WldCwbpZ503YbfBj+nOzCy+aktdqPtYJM79sP4ZmK3p
	7OZ42aFQ76A4rxUN1xPIQlpmtcgURTmJ8iVD7zlC8wzEESDxADugUxDnx98BiGNqVbFN/oG2qDf
	QVwl2DiLQxnLtsVfkeWtl5gm5YJBzFbH3z7czhMy/vXHmzAVgqOVn8CxCUcL1z8tHQYrxvmIV7o
	/oPsSKD/8ZlEpFOpbTVgvQyTQvd7BfVv2b3vRMLK8OCiE5jZToJgwlzhLtdGiE8k8tUfkjuxHnr
	eGE7PlU174Jnjq6RfEF6qraRf5hpKEaU+zL+eWwpVz4Jd87yZ9Jui4Rg84fht/5Jc2tYxehuklm
	XQTY43Jecc3C85v6oGzy92h/pkKQ8UBXJAEajv+5OGvQKKSyTW6dFGoQlagu+7nq3iHiJPz0B5V
	bob4MTAsMZ8z9hPfxanRHEIa0U0SbR+lqvtX45Ae9wGd8j9FEfqlZkfrJcgGKLRy483X4gI2ot2
	ofaMbjgF10ScXYcK+6uZOjg2O5e7/bM9rzfk9b2ozE8gu0eXljwZMY5rXibKHlNwBWU1/WYwMfr
	UiDmoaJ1PwCSi7vg+M/jHA5qAAk=
X-Received: by 2002:a05:620a:4056:b0:8ee:9f5e:e13c with SMTP id af79cd13be357-8ee9f5eea83mr529951285a.21.1776803884892;
        Tue, 21 Apr 2026 13:38:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d94d3f99sm1172582885a.40.2026.04.21.13.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:38:04 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:38:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 16/16] repack: allow `--write-midx=incremental` without
 `--geometric`
Message-ID: <d9acef1334ae42df45b8a4ec1e1b771b48249006.1776803827.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1776803827.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776803827.git.me@ttaylorr.com>

Previously, `--write-midx=incremental` required `--geometric` and would
die() without it. Relax this restriction so that incremental MIDX
repacking can be used independently.

Without `--geometric`, the behavior is append-only: a single new MIDX
layer is created containing whatever packs were written by the repack
and appended to the existing chain (or a new chain is started). Existing
layers are preserved as-is with no compaction or merging.

Implement this via a new repack_make_midx_append_plan() that builds a
plan consisting of a WRITE step for the freshly written packs followed
by COPY steps for every existing MIDX layer. The existing compaction
plan (repack_make_midx_compaction_plan) is used only when `--geometric`
is active.

Update the documentation to describe the behavior with and without
`--geometric`, and replace the test that enforced the old restriction
with one exercising append-only incremental MIDX repacking.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-repack.adoc      | 19 +++++----
 builtin/repack.c                   |  3 --
 repack-midx.c                      | 64 ++++++++++++++++++++++++++++--
 t/t7705-repack-incremental-midx.sh | 35 +++++++++++++---
 4 files changed, 103 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
index 27a99cc46f4..72c42015e23 100644
--- a/Documentation/git-repack.adoc
+++ b/Documentation/git-repack.adoc
@@ -263,14 +263,19 @@ linkgit:git-multi-pack-index[1]).
 
 	`incremental`;;
 		Write an incremental MIDX chain instead of a single
-		flat MIDX. This mode requires `--geometric`.
+		flat MIDX.
 +
-The incremental mode maintains a chain of MIDX layers that is compacted
-over time using a geometric merging strategy. Each repack creates a new
-tip layer containing the newly written pack(s). Adjacent layers are then
-merged whenever the newer layer's object count exceeds
-`1/repack.midxSplitFactor` of the next deeper layer's count. Layers
-that do not meet this condition are retained as-is.
+Without `--geometric`, a new MIDX layer is appended to the existing
+chain (or a new chain is started) containing whatever packs were written
+by the repack. Existing layers are preserved as-is.
++
+When combined with `--geometric`, the incremental mode maintains a chain
+of MIDX layers that is compacted over time using a geometric merging
+strategy. Each repack creates a new tip layer containing the newly
+written pack(s). Adjacent layers are then merged whenever the newer
+layer's object count exceeds `1/repack.midxSplitFactor` of the next
+deeper layer's count. Layers that do not meet this condition are
+retained as-is.
 +
 The result is that newer (tip) layers tend to contain many small packs
 with relatively few objects, while older (deeper) layers contain fewer,
diff --git a/builtin/repack.c b/builtin/repack.c
index 5ffa18e085e..1524a9c13ad 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -263,9 +263,6 @@ int cmd_repack(int argc,
 	if (pack_everything & PACK_CRUFT)
 		pack_everything |= ALL_INTO_ONE;
 
-	if (write_midx == REPACK_WRITE_MIDX_INCREMENTAL && !geometry.split_factor)
-		die(_("--write-midx=incremental requires --geometric"));
-
 	if (write_bitmaps < 0) {
 		if (write_midx == REPACK_WRITE_MIDX_NONE &&
 		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()))
diff --git a/repack-midx.c b/repack-midx.c
index 6a0358096ec..b1c429b8cee 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -555,6 +555,60 @@ static void midx_compaction_step_release(struct midx_compaction_step *step)
 	free(step->csum);
 }
 
+/*
+ * Build an append-only MIDX plan: a single WRITE step for the freshly
+ * written packs, plus COPY steps for every existing layer.  No
+ * compaction or merging is performed.
+ */
+static void repack_make_midx_append_plan(struct repack_write_midx_opts *opts,
+					 struct midx_compaction_step **steps_p,
+					 size_t *steps_nr_p)
+{
+	struct multi_pack_index *m;
+	struct midx_compaction_step *steps = NULL;
+	struct midx_compaction_step *step;
+	size_t steps_nr = 0, steps_alloc = 0;
+
+	odb_reprepare(opts->existing->repo->objects);
+	m = get_multi_pack_index(opts->existing->source);
+
+	if (opts->names->nr) {
+		struct strbuf buf = STRBUF_INIT;
+		uint32_t i;
+
+		ALLOC_GROW(steps, st_add(steps_nr, 1), steps_alloc);
+
+		step = &steps[steps_nr++];
+		memset(step, 0, sizeof(*step));
+
+		step->type = MIDX_COMPACTION_STEP_WRITE;
+		string_list_init_dup(&step->u.write);
+
+		for (i = 0; i < opts->names->nr; i++) {
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "pack-%s.idx",
+				    opts->names->items[i].string);
+			string_list_append(&step->u.write, buf.buf);
+		}
+
+		strbuf_release(&buf);
+	}
+
+	for (; m; m = m->base_midx) {
+		ALLOC_GROW(steps, st_add(steps_nr, 1), steps_alloc);
+
+		step = &steps[steps_nr++];
+		memset(step, 0, sizeof(*step));
+
+		step->type = MIDX_COMPACTION_STEP_COPY;
+		step->u.copy = m;
+		step->objects_nr = m->num_objects;
+	}
+
+	*steps_p = steps;
+	*steps_nr_p = steps_nr;
+}
+
 static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
 					    struct midx_compaction_step **steps_p,
 					    size_t *steps_nr_p)
@@ -911,9 +965,13 @@ static int write_midx_incremental(struct repack_write_midx_opts *opts)
 		goto done;
 	}
 
-	if (repack_make_midx_compaction_plan(opts, &steps, &steps_nr) < 0) {
-		ret = error(_("unable to generate compaction plan"));
-		goto done;
+	if (opts->geometry->split_factor) {
+		if (repack_make_midx_compaction_plan(opts, &steps, &steps_nr) < 0) {
+			ret = error(_("unable to generate compaction plan"));
+			goto done;
+		}
+	} else {
+		repack_make_midx_append_plan(opts, &steps, &steps_nr);
 	}
 
 	for (i = 0; i < steps_nr; i++) {
diff --git a/t/t7705-repack-incremental-midx.sh b/t/t7705-repack-incremental-midx.sh
index af1a1483b8c..25a8c40e8ee 100755
--- a/t/t7705-repack-incremental-midx.sh
+++ b/t/t7705-repack-incremental-midx.sh
@@ -63,10 +63,36 @@ create_layers () {
 	done
 }
 
-test_expect_success '--write-midx=incremental requires --geometric' '
-	test_must_fail git repack --write-midx=incremental 2>err &&
+test_expect_success '--write-midx=incremental without --geometric' '
+	git init incremental-without-geometric &&
+	(
+		cd incremental-without-geometric &&
 
-	test_grep -- "--write-midx=incremental requires --geometric" err
+		git config maintenance.auto false &&
+
+		test_commit first &&
+		git repack -d &&
+
+		test_commit second &&
+		git repack --write-midx=incremental &&
+
+		git multi-pack-index verify &&
+		test_line_count = 1 $midx_chain &&
+		cp $midx_chain $midx_chain.before &&
+
+		# A second repack appends a new layer without
+		# disturbing the existing one.
+		test_commit third &&
+		git repack --write-midx=incremental &&
+
+		git multi-pack-index verify &&
+		test_line_count = 2 $midx_chain &&
+		head -n 1 $midx_chain.before >expect &&
+		head -n 1 $midx_chain >actual &&
+		test_cmp expect actual &&
+
+		git fsck
+	)
 '
 
 test_expect_success 'below layer threshold, tip packs excluded' '
@@ -334,8 +360,7 @@ test_expect_success 'kept packs are excluded from repack' '
 		# entirely, so no rollup occurs as there is only one
 		# non-kept pack. A new MIDX layer is written containing
 		# that pack.
-		git repack --geometric=2 -d --write-midx=incremental \
-			--write-bitmap-index &&
+		git repack --geometric=2 -d --write-midx=incremental &&
 
 		test-tool read-midx $objdir >actual &&
 		grep "^pack-.*\.idx$" actual >actual.packs &&
-- 
2.54.0.9.gb905fd5d0ae
