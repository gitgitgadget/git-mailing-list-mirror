Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329CE25A2BB
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 23:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782082987; cv=none; b=jXAPsUk9E4I7BOmRmjOTMvvfitB6RHMRYWDIw6/S6QgcK/s5ZFLGPhxASwshRCo3LYbgmoy+eUVXn1o6vvSDGe38FsbtftwSEqbvwLQA7FoaR552tB9UDLq863N77dj3CePujYM99RHSxAma6jvDCDtRDFfvGZyJYRDAOjvlfss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782082987; c=relaxed/simple;
	bh=nNHIgwQLbAHg8gi71Q0VjJQb8BfpH8NnQPE5mnBEPB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LR3Hnv94in1Cs+/qoHn2oDdzySnzvEa5qsL/0ZPV/Wru/TqXy4UhIbDlKhkT88mp8JsHIXPeFNPo/WPR2XU7PJOhzc8+jLEP2xeuDa5EhSa6ZgVR8lwoQF53a6Wb35garPq6kDV5PtUGHiM0baSvVpfxwvVWozjog4MCam2TZRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Tb2gUcML; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Tb2gUcML"
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-8050b4da489so1256087b3.3
        for <git@vger.kernel.org>; Sun, 21 Jun 2026 16:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1782082985; x=1782687785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ts/Z1Ock3j6317DgsT9+NAZOQN3ZXNitvo+RWkuFsPc=;
        b=Tb2gUcMLG5E2aAca9bOdCL0R6E5NCYH0NysrI4zmkMuewi2+el2YGBqubXPGw3hlUf
         Xc5DBF55Tp5SQhQM/YS/iMyYiSvlIOHSjOlb8MYCF14vzU5rR8eeXzSYOimhFhyE7k16
         f90xGadou3ggIwB6ZyKY6SDsWHaFtuZU5dQUylbbjP0RcEWGs5sOyLrQnLPPtBw5uz4i
         YKsGaDj4RJaSlrF7a3LFvrxIt1JWS2wMl+2m4aCQgaIzawp/1Jrhx8t3lQ27APy4nyz3
         OP4ziCWZKLxkxQD9SlBwXpNtOAscqDMddNmfb923r7Tt5KgCt1YgFk4NxR9kyXMTVAWz
         Ob5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782082985; x=1782687785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ts/Z1Ock3j6317DgsT9+NAZOQN3ZXNitvo+RWkuFsPc=;
        b=KYm/m5TRVl5BzMhCGiV7LnO3jC7a1S87LLbHS8A4bB6OT0CvKaPHr5mYJYf+53i7W2
         fco5HzV7RqqHtERDvD8FmZe4LJDTfBvx9GBzLHy+HiOU8UgGeVV7rWdw+UiGppAE2zi+
         dUyq/f/X7hu/wlTKn/wMZOIPYBIrnlRYsnT/t40oQcAUD4UXfOS7Jp2XsdfeIzb8hvdH
         7XqextljZNGYYVhqk26AJVN0EexnqE8fdwnk0igCJhkCkoigw6gd3qBxvZ05zzRy/9pV
         i+o+XVHFxgf3E2CkQn+kvXMBEgIR2zoD8M2BUA8IKm32M+fN2z5XyLhJRZZ4UZ8z9MsM
         kmyQ==
X-Gm-Message-State: AOJu0YyrXMXadzvK4ycgmvEHBlvU9nraKHL/emVdZGWInNvjYNk8pWS6
	+59tG2JlJ2Z4svoxqifdgQ+L+aPKzPWb9S3Tonj3Cf14ttT41AblfesaoZW0PS2/bT50jPUFmM0
	6o/cYt7fthz+v
X-Gm-Gg: AfdE7cl8FMVji4gG0lFGMZ8FMIQiNZcDvZj+dki/haV2mom4bHPROdqFewW7uqCdQ9g
	ODK+2Ff/QeMqruSYQsuLQ9NtEYRpmAg1wBF8Qw2saCGXUHfSPoj5Pb0qQmznJLMPdNG0ZyNZa8t
	azz4rGXiP2mt3TOtzZXt/fJtRggCMXw6OBOF5lfGO3TjqQQmympWEo2HF89CRyMp6H6kMrU+P7w
	ilpJJOXa339RCd1aTlZRXSkRC3+8jb6Wb96mOudeNAbq28hsmT4t6lt6h/UPV4g55j4DemGUUTE
	+7MH2ijZq6at4omYcG4Be+yoaAwfwuz1K2N0hAdYU8gZ2vBAvGg+jheFqLXG3nYHWo5BBNQPDeI
	i44DHyIewQkF3BJeSnlRkxMm1gOg4nKP4iWLTDwMTz6jYsF0XYuUt+BP84DVhO6ZGaRu6+/i9rb
	PUxjrNGdbxutVpERGVCQh9CEz3xZfLLvXnGFVquaxscks9qttRF+oL9T0hWOZNLpe173yX/8z7S
	HTdLEErkxIYOlI0Wqie5CoEccU1T6G4BMg6E2gzj5Dj+vBvIPQDWsbpAuH4/Hy9giGgEuCP2Q2n
	AeLLVA==
X-Received: by 2002:a05:690c:e3cb:b0:7bd:5579:185a with SMTP id 00721157ae682-801336f1b65mr120775167b3.25.1782082985186;
        Sun, 21 Jun 2026 16:03:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025f8ddf97sm24649327b3.29.2026.06.21.16.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 16:03:04 -0700 (PDT)
Date: Sun, 21 Jun 2026 19:03:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 2/4] pack-objects: support reachability bitmaps with
 `--path-walk`
Message-ID: <1884f49580915695e8860fd4d14d956f749b5850.1782082975.git.me@ttaylorr.com>
References: <cover.1779923907.git.me@ttaylorr.com>
 <cover.1782082975.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1782082975.git.me@ttaylorr.com>

When 'pack-objects' is invoked with '--path-walk', it prevents us from
using reachability bitmaps.

This behavior dates back to 70664d2865c (pack-objects: add --path-walk
option, 2025-05-16), which included a comment in the relevant portion of
the command-line arguments handling that read as follows:

    /*
     * We must disable the bitmaps because we are removing
     * the --objects / --objects-edge[-aggressive] options.
     */

In fb2c309b7d3 (pack-objects: pass --objects with --path-walk,
2026-05-02), path-walk learned to pass '--objects' again, but still
kept bitmap traversal disabled. That leaves two useful cases
unsupported:

 * A path-walk repack that writes bitmaps does not give the bitmap
   selector any commits, because path-walk reveals commits through
   `add_objects_by_path()` rather than through `show_commit()`, where
   `index_commit_for_bitmap()` is normally called.

 * An invocation like "git pack-objects --use-bitmap-index --path-walk"
   never tries an existing bitmap, even when one is available and could
   answer the request.

Fortunately for us, neither restriction is required.

 * On the writing side: teach the path-walk object callback to call
   `index_commit_for_bitmap()` for commits that it adds to the pack.
   That gives the bitmap selector the commit candidates it would have
   seen from the regular traversal.

 * For bitmap reading, keep passing '--objects' to the internal rev_list
   machinery, but stop clearing `use_bitmap_index`. If an existing
   bitmap can answer the request, use it; otherwise fall back to
   path-walk's own enumeration.

As a result, we can see significantly reduced pack generation times from
p5311 (with our `GIT_PERF_REPO` set to a recent clone of the fluentui
repository) before this commit:

    Test                                            HEAD^             HEAD
    ----------------------------------------------------------------------------------------
    5311.40: server (1 days, --path-walk)           1.43(1.39+0.04)   0.01(0.01+0.00) -99.3%
    5311.41: size   (1 days, --path-walk)                    139.6K            139.7K +0.0%
    5311.42: client (1 days, --path-walk)           0.02(0.02+0.00)   0.02(0.02+0.00) +0.0%
    5311.44: server (2 days, --path-walk)           1.43(1.39+0.04)   0.01(0.00+0.00) -99.3%
    5311.45: size   (2 days, --path-walk)                    139.6K            139.7K +0.0%
    5311.46: client (2 days, --path-walk)           0.02(0.02+0.00)   0.02(0.02+0.00) +0.0%
    5311.48: server (4 days, --path-walk)           1.44(1.39+0.04)   0.01(0.01+0.00) -99.3%
    5311.49: size   (4 days, --path-walk)                    238.1K            238.1K +0.0%
    5311.50: client (4 days, --path-walk)           0.03(0.03+0.00)   0.03(0.03+0.00) +0.0%
    5311.52: server (8 days, --path-walk)           1.43(1.39+0.03)   0.01(0.00+0.00) -99.3%
    5311.53: size   (8 days, --path-walk)                    344.9K            344.9K +0.0%
    5311.54: client (8 days, --path-walk)           0.07(0.07+0.00)   0.07(0.08+0.00) +0.0%
    5311.56: server (16 days, --path-walk)          1.47(1.44+0.03)   0.10(0.08+0.01) -93.2%
    5311.57: size   (16 days, --path-walk)                   844.0K            844.0K +0.0%
    5311.58: client (16 days, --path-walk)          0.09(0.09+0.00)   0.09(0.09+0.00) +0.0%
    5311.60: server (32 days, --path-walk)          1.52(1.50+0.05)   0.14(0.15+0.02) -90.8%
    5311.61: size   (32 days, --path-walk)                     4.2M              4.2M +0.1%
    5311.62: client (32 days, --path-walk)          0.34(0.48+0.02)   0.34(0.45+0.05) +0.0%
    5311.64: server (64 days, --path-walk)          1.55(1.52+0.06)   0.15(0.15+0.04) -90.3%
    5311.65: size   (64 days, --path-walk)                     6.4M              6.4M -0.0%
    5311.66: client (64 days, --path-walk)          0.51(0.79+0.05)   0.51(0.80+0.06) +0.0%
    5311.68: server (128 days, --path-walk)         1.59(1.57+0.06)   0.16(0.21+0.01) -89.9%
    5311.69: size   (128 days, --path-walk)                    8.4M              8.4M -0.0%
    5311.70: client (128 days, --path-walk)         0.72(1.44+0.08)   0.71(1.47+0.09) -1.4%

We get the same size of output pack, but this commit allows us to do so
in a significantly shorter amount of time. Intuitively, we're generating
the same pack (hence the unchanged 'test_size' output from run to run),
but varying how we get there. Before this commit, pack-objects prefers
'--path-walk' to '--use-bitmap-index', so we generate the output pack by
performing a normal '--path-walk' traversal. With this commit, we are
operating over a *repacked* state (that itself was done with a
'--path-walk' traversal), but are able to perform pack-reuse on that
repacked state via bitmaps.

When comparing the size of the repacked pack with/without '--path-walk'
on the previous commit versus this one, we see that (a) the repacked size
improves significantly with '--path-walk', and that (b) writing bitmaps
during repacking does not regress this improvement:

    Test                                            HEAD^             HEAD
    ----------------------------------------------------------------------------------------
    5311.3: size of bitmapped pack                           558.4M            558.5M +0.0%
    5311.38: size of bitmapped pack (--path-walk)            164.4M            164.4M +0.0%

(Note that to observe an improvement here, we must repack with '-F' in
order to avoid reusing non-'--path-walk' deltas, which would otherwise
skew our results.)

There is one wrinkle when it comes to '--boundary', which we must not
pass into the bitmap walk in the presence of both '--path-walk' and
'--use-bitmap-index'. Path-walk needs boundary commits when it performs
its own traversal, in order to discover bases for thin packs, but the
bitmap traversal does not expect this. Work around this by setting
`revs->boundary` as late as possible within the '--path-walk' traversal,
after any bitmap attempt has either succeeded or declined to answer the
request.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-pack-objects.adoc |  6 +++--
 builtin/pack-objects.c              | 18 +++++++++++++--
 t/perf/p5311-pack-bitmaps-fetch.sh  | 18 +++++++++++----
 t/t5310-pack-bitmaps.sh             | 36 +++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 8a27aa19fd3..0adce8961a3 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -402,8 +402,10 @@ will be automatically changed to version `1`.
 	of filenames that cause collisions in Git's default name-hash
 	algorithm.
 +
-Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
-ignored in the presence of `--path-walk`. The `--path-walk` option
+Incompatible with `--delta-islands`. When `--use-bitmap-index` is
+specified with `--path-walk`, a successful bitmap traversal is used for
+object enumeration, with path-walk remaining as the fallback traversal
+when the bitmap cannot satisfy the request. The `--path-walk` option
 supports the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`,
 `tree:0`, `object:type=<type>`, and `sparse:<oid>`. These supported filter
 types can be combined with the `combine:<spec>+<spec>` form.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b783dc62bc9..e4dcb563b7d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4732,6 +4732,15 @@ static int add_objects_by_path(const char *path,
 			continue;
 
 		add_object_entry(oid, type, path, exclude);
+
+		if (type == OBJ_COMMIT && write_bitmap_index) {
+			struct commit *commit;
+
+			commit = lookup_commit(the_repository, oid);
+			if (!commit)
+				die(_("could not find commit %s"), oid_to_hex(oid));
+			index_commit_for_bitmap(commit);
+		}
 	}
 
 	oe_end = to_pack.nr_objects;
@@ -4764,6 +4773,13 @@ static int get_object_list_path_walk(struct rev_info *revs)
 	info.path_fn = add_objects_by_path;
 	info.path_fn_data = &processed;
 
+	/*
+	 * Path-walk needs boundary commits to discover thin-pack bases, but
+	 * bitmap traversal does not understand the boundary state. Set it
+	 * here so any prior bitmap attempt sees the usual non-boundary walk.
+	 */
+	revs->boundary = 1;
+
 	/*
 	 * Allow the --[no-]sparse option to be interesting here, if only
 	 * for testing purposes. Paths with no interesting objects will not
@@ -5195,9 +5211,7 @@ int cmd_pack_objects(int argc,
 		}
 	}
 	if (path_walk) {
-		strvec_push(&rp, "--boundary");
 		strvec_push(&rp, "--objects");
-		use_bitmap_index = 0;
 	} else if (thin) {
 		use_internal_rev_list = 1;
 		strvec_push(&rp, shallow
diff --git a/t/perf/p5311-pack-bitmaps-fetch.sh b/t/perf/p5311-pack-bitmaps-fetch.sh
index 5bea5c64e7b..50506216227 100755
--- a/t/perf/p5311-pack-bitmaps-fetch.sh
+++ b/t/perf/p5311-pack-bitmaps-fetch.sh
@@ -4,15 +4,22 @@ test_description='performance of fetches from bitmapped packs'
 . ./perf-lib.sh
 
 test_fetch_bitmaps () {
+	argv=$1
+	export argv
+
 	test_expect_success 'setup test directory' '
 		rm -fr * .git
 	'
 
 	test_perf_default_repo
 
-	test_expect_success 'create bitmapped server repo' '
+	test_expect_success "create bitmapped server repo ${argv:+($argv)}" '
 		git config pack.writebitmaps true &&
-		git repack -ad
+		git repack -adF $argv
+	'
+
+	test_size "size of bitmapped pack ${argv:+($argv)}" '
+		test_file_size .git/objects/pack/pack-*.pack
 	'
 
 	# simulate a fetch from a repository that last fetched N days ago, for
@@ -20,7 +27,7 @@ test_fetch_bitmaps () {
 	# and assume the first entry in the chain that is N days older than the current
 	# HEAD is where the HEAD would have been then.
 	for days in 1 2 4 8 16 32 64 128; do
-		title=$(printf '%10s' "($days days)")
+		title=$(printf '%10s' "($days days${argv:+, $argv})")
 		test_expect_success "setup revs from $days days ago" '
 			now=$(git log -1 --format=%ct HEAD) &&
 			then=$(($now - ($days * 86400))) &&
@@ -47,6 +54,9 @@ test_fetch_bitmaps () {
 	done
 }
 
-test_fetch_bitmaps
+for argv in '' --path-walk
+do
+	test_fetch_bitmaps $argv || return 1
+done
 
 test_done
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index f693cb56691..7924208d99c 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -577,6 +577,42 @@ test_bitmap_cases
 
 sane_unset GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL
 
+test_expect_success 'path-walk repack can write and use bitmap indexes' '
+	test_when_finished "rm -rf path-walk-bitmap" &&
+	git init path-walk-bitmap &&
+	(
+		cd path-walk-bitmap &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+
+		git repack -a -d -b --path-walk &&
+		git rev-list --test-bitmap --use-bitmap-index HEAD &&
+
+		git rev-parse HEAD >in &&
+
+		git rev-list --objects --no-object-names HEAD >expect.raw &&
+		sort expect.raw >expect &&
+
+		for reuse in true false
+		do
+			: >trace.txt &&
+
+			GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+			git -c pack.allowPackReuse=$reuse pack-objects \
+				--stdout --revs --path-walk --use-bitmap-index \
+				<in >out.pack &&
+			test_grep "\"category\":\"bitmap\",\"key\":\"bitmap/hits\"" trace.txt &&
+
+			git index-pack out.pack &&
+
+			list_packed_objects out.idx >actual.raw &&
+			sort actual.raw >actual &&
+			test_cmp expect actual || return 1
+		done
+	)
+'
+
 test_expect_success 'incremental repack fails when bitmaps are requested' '
 	test_commit more-1 &&
 	test_must_fail git repack -d 2>err &&
-- 
2.54.0.23.g371fc4317ad

