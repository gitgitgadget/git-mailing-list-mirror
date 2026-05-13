Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1F13A8749
	for <git@vger.kernel.org>; Wed, 13 May 2026 21:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778707166; cv=none; b=Mg/R+ht1jbx5Ejq3bZxQcDwH0dp3rJjKhby7xsQtz9J9Hqvf4c/T2Tjq3MldfGs6YWn9++t5wzDS8cGIKE3chotHB+zqeaJ5w2nMePS0OQjMEgcOV6NkWR2GW4SyODLvsL3ih8iLPnBFYQ+PdlXH4IU3bQ/9HmGwm45R1wnt4Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778707166; c=relaxed/simple;
	bh=0lZDsUn0CwBgSDStNknTzGNQnmV4AM9yMQC/K2JIJX4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UV/7mbNv/LP7YIlY4UUXGzrPbMM0zdSFdepru84IyKCiMclJT86ataRA/EWhTroJ04riQeTjfZOQN2pf1Qt71Puy5aQtqH+HCs5XFcop5aTyJzLPXKjdOrM6CozwcH4aBf2NaDYswHGZL1boQDn+VR9bE0O/sp7xIFwRaia7wdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUUn5RY3; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUUn5RY3"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c1a170a50so10178973c88.0
        for <git@vger.kernel.org>; Wed, 13 May 2026 14:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778707159; x=1779311959; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqWr8h9uR6znaMOdvxKi9QVnSjmJDTsXHZJI5dQ+ecc=;
        b=HUUn5RY39H/Ftw0LziWbnCnZpmjwfMoT6sZW4xgSBHpyBaYVVnz7e/ua7pXN/55Wu1
         cqCu6CPfxSvjbpaZWjF5GgtO6qDCkcJJTHzu607TtJylo3mqReRZMA24uAkIgdxXP5xx
         Q3mqKKgICi5JC7w0+iTBiNyi9HS1eISADB4kFEg+b7GqvEcFs9v924QsnY6GZupLmf3g
         mvljhuCA/0sLMWdhGBuZuIrodvkN7UvWSuNtjJT9RfUHVwYtRz8XE9/0wjP0U3TghSgl
         hhPuwaLNwniw34Dv41Pzo7GOnK1oqAnuSFmep5BMRNaRHkT6xzeS+6pl3Dyx0I9lVVxj
         3Ncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778707159; x=1779311959;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GqWr8h9uR6znaMOdvxKi9QVnSjmJDTsXHZJI5dQ+ecc=;
        b=PfmWUjXKsqRtFE+kq+ZtGeeeCZnTQ2ra/NgzNjcrXYfBmmH2SoBxiAmMIti5+jqT48
         Nkm/rzSzFGQmiPbmGZ1Ohhqk9UStpPIZzIafIP8LRyrvjiyjMtlxYGxxLVrE7eA1rtm0
         XASBYjfTLu40rjcwM4C2tyYYs5p0LmQoMH/dA8lG6Gt5sPUuDkYF/CNrqr7xVYegTZFm
         gnBIjYtvH5qlZXMUayHWKNU7hIc9Gr8BpgxUiVd729t3/PpcdlC+zZKsOPyf2LS35G//
         m8os/iccvsS8x47sCFRH58jLMroNDrxZ+PpCLDZB5huII3gdYhAGU4PVRszdme8dV+vW
         gerQ==
X-Gm-Message-State: AOJu0YwZwt5Qj8iI8RdbZv3iV4mlS4lSdMDrHP3ZdcMu4Qx3OgQgkDlF
	CQ7W69E1vEbkThfnvYUfzIzSKMEIhqgXiE6n+fGY2Rktxrh3HGQe4+hY1+Ggm9mF
X-Gm-Gg: Acq92OECLMHuLC4qxckhOApDkJ1Vn0Vfai7mwmUHYMRrrzBm6qzF5AaIOdnsNb4r2CW
	1wGbry85kHMerthAQ0tkW5PCaMp8E96/UBch+jDWs+bzkKKKljSVE34D5Cl+Ru7bNQQv1yoRQOv
	wyoK3idl1bDbUMbE6H0/ABBsvsLbfj8U4YZ0rKSHGdMuUp6qj/pPLNx2LcIyxF9HlgD76VuAQc7
	j2qfP1n75XYu8CqgO2kqZo/NQnrTuXegJic9LUY33/f0zfp3ldFauMymCiar2HotV1e/FHHuvED
	rI49FzvoKrqt9sVlrindX0cPl2EyyNwgc0ljph95WP89jLVu16wlW2e5zgSc5WMX8JhYaDgWQVw
	/T7tZwJM3fyWauZKUP00EOpZTs3XR8zGQXXhvpvwcMfDw4CfSwjQXmH0DrE/ixDVjZ7/mNJosug
	n0LWz6UBlNNG1r2zAmdXVPcqvwfQ==
X-Received: by 2002:a05:7022:1716:b0:134:cf44:758f with SMTP id a92af1059eb24-134cf447b95mr269710c88.44.1778707158491;
        Wed, 13 May 2026 14:19:18 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.77.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc33a67csm1083809c88.13.2026.05.13.14.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:19:17 -0700 (PDT)
Message-Id: <a615b1a7078a6f092deb180d135f32c313094315.1778707135.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
References: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
	<pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
From: "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 May 2026 21:18:55 +0000
Subject: [PATCH v4 13/13] path-walk: support `combine` filter
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Taylor Blau <me@ttaylorr.com>

From: Taylor Blau <me@ttaylorr.com>

The `combine` filter takes the intersection of its children, that is:
objects are shown only when all child filters would admit the object.

The preceding patches added support for many individual filter types.
Enable users to compose these filters by implementing support for the
`combine` filter type.

Mapping intersection onto path_walk_info works because every supported
child filter is a monotonic restriction:

 - `blob:none`, `tree:0` unconditionally clear `info->blobs` and (for
   `tree:0`) `info->trees`; clearing an already-cleared flag is a
   no-op.

 - `object:type=X` is now expressed as an AND of each type flag with the
   filtered type, so applying multiple such filters only refines the
   existing set rather than overwrites it.

 - `blob:limit=N` has to compose too: the intersection of "size < L1"
   and "size < L2" is "size < min(L1, L2)".

   Update the `LOFC_BLOB_LIMIT` handler to take the running minimum when
   `info->blob_limit` is already set, so a combined filter with, e.g.,
   both "blob:limit=10" and "blob:limit=5" produces a limit of 5
   regardless of ordering.

 - `sparse:oid` is left unchanged. A `combine` filter that includes a
   `sparse:oid` is allowed at most once, since the existing handler
   refuses to overwrite `info->pl`. Two `sparse:oid` filters in a single
   `combine` would be unusual and are rejected with a warning, matching
   the standalone `sparse:oid` behavior.

Implementation-wise, the existing `prepare_filters()` called
`list_objects_filter_release()` inside each case branch. That works fine for
top-level filters, but `combine` filters need to recurse over its child
filters without releasing each one in turn (since the parent's release
iterates the sub array). Split `prepare_filters()` into a recursive helper
that performs only the mutation, plus a thin wrapper that calls the helper
and then releases the top-level filter once.

The `LOFC_COMBINE` case in the helper just walks `sub_nr` and recurses;
child filters are released by the wrapper's single
`list_objects_filter_release()` call on the parent (which itself recursively
releases each sub-filter, the same way it always has).

If any sub-filter is unsupported (e.g. "tree:1", "sparse:<path>", or a
not-yet-supported choice), the recursion bubbles a failure up and the
existing pack-objects/backfill fallback paths kick in.

Add coverage in t6601:

  - "combine:blob:none+tree:0" collapses to "tree:0"

  - "combine:object:type=blob+blob:limit=3" yields only the blobs
    smaller than three bytes

  - "combine:object:type=blob+object:type=tree" intersects to empty

  - "combine:tree:1+blob:none" reports the "tree:1" error.

Update Documentation/git-pack-objects.adoc to add combine to the
list of supported --filter forms.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-pack-objects.adoc |  3 +-
 path-walk.c                         | 25 ++++++++--
 t/t6601-path-walk.sh                | 71 +++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index f2852ebd31..8a27aa19fd 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -405,7 +405,8 @@ will be automatically changed to version `1`.
 Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
 ignored in the presence of `--path-walk`. The `--path-walk` option
 supports the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`,
-`tree:0`, `object:type=<type>`, and `sparse:<oid>`.
+`tree:0`, `object:type=<type>`, and `sparse:<oid>`. These supported filter
+types can be combined with the `combine:<spec>+<spec>` form.
 
 
 DELTA ISLANDS
diff --git a/path-walk.c b/path-walk.c
index 418972e753..94ff90bd15 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -571,8 +571,8 @@ static int setup_pending_objects(struct path_walk_info *info,
 	return 0;
 }
 
-static int prepare_filters(struct path_walk_info *info,
-			   struct list_objects_filter_options *options)
+static int prepare_filters_one(struct path_walk_info *info,
+			       struct list_objects_filter_options *options)
 {
 	switch (options->choice) {
 	case LOFC_DISABLED:
@@ -589,7 +589,8 @@ static int prepare_filters(struct path_walk_info *info,
 		if (info) {
 			if (!options->blob_limit_value)
 				info->blobs = 0;
-			else
+			else if (!info->blob_limit ||
+				 info->blob_limit > options->blob_limit_value)
 				info->blob_limit = options->blob_limit_value;
 			list_objects_filter_release(options);
 		}
@@ -604,7 +605,6 @@ static int prepare_filters(struct path_walk_info *info,
 		if (info) {
 			info->trees = 0;
 			info->blobs = 0;
-			list_objects_filter_release(options);
 		}
 		return 1;
 
@@ -656,8 +656,13 @@ static int prepare_filters(struct path_walk_info *info,
 				warning(_("sparse filter is not cone-mode compatible"));
 				return 0;
 			}
+		}
+		return 1;
 
-			list_objects_filter_release(options);
+	case LOFC_COMBINE:
+		for (size_t i = 0; i < options->sub_nr; i++) {
+			if (!prepare_filters_one(info, &options->sub[i]))
+				return 0;
 		}
 		return 1;
 
@@ -668,6 +673,16 @@ static int prepare_filters(struct path_walk_info *info,
 	}
 }
 
+static int prepare_filters(struct path_walk_info *info,
+			   struct list_objects_filter_options *options)
+{
+	if (!prepare_filters_one(info, options))
+		return 0;
+	if (info)
+		list_objects_filter_release(options);
+	return 1;
+}
+
 int path_walk_filter_compatible(struct list_objects_filter_options *options)
 {
 	return prepare_filters(NULL, options);
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index 0fd8e61c76..e9fcd85e75 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -727,6 +727,77 @@ test_expect_success 'all, object:type=blob filter' '
 	test_cmp_sorted expect out
 '
 
+test_expect_success 'all, combine:blob:none+tree:0 filter' '
+	test-tool path-walk \
+		--filter=combine:blob:none+tree:0 -- --all >out &&
+
+	cat >expect <<-EOF &&
+	0:commit::$(git rev-parse topic)
+	0:commit::$(git rev-parse base)
+	0:commit::$(git rev-parse base~1)
+	0:commit::$(git rev-parse base~2)
+	1:tag:/tags:$(git rev-parse refs/tags/first)
+	1:tag:/tags:$(git rev-parse refs/tags/second.1)
+	1:tag:/tags:$(git rev-parse refs/tags/second.2)
+	1:tag:/tags:$(git rev-parse refs/tags/third)
+	1:tag:/tags:$(git rev-parse refs/tags/fourth)
+	1:tag:/tags:$(git rev-parse refs/tags/tree-tag)
+	1:tag:/tags:$(git rev-parse refs/tags/blob-tag)
+	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
+	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
+	3:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag^{tree})
+	3:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag2)
+	blobs:2
+	commits:4
+	tags:7
+	trees:2
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'all, combine:object:type=blob+blob:limit=3 filter' '
+	test-tool path-walk \
+		--filter=combine:object:type=blob+blob:limit=3 \
+		-- --all >out &&
+
+	cat >expect <<-EOF &&
+	0:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
+	0:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
+	1:blob:a:$(git rev-parse base~2:a)
+	2:blob:left/b:$(git rev-parse base~2:left/b)
+	3:blob:right/c:$(git rev-parse base~2:right/c)
+	4:blob:right/d:$(git rev-parse base~1:right/d)
+	blobs:6
+	commits:0
+	tags:0
+	trees:0
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'all, combine of disjoint object:types is empty' '
+	test-tool path-walk \
+		--filter=combine:object:type=blob+object:type=tree \
+		-- --all >out &&
+
+	cat >expect <<-EOF &&
+	blobs:0
+	commits:0
+	tags:0
+	trees:0
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'combine: rejects unsupported subfilters' '
+	test_must_fail test-tool path-walk \
+		--filter=combine:tree:1+blob:none -- --all 2>err &&
+	test_grep "tree:1 filter not supported by the path-walk API" err
+'
+
 test_expect_success 'setup sparse filter blob' '
 	# Cone-mode patterns: include root, exclude all dirs, include left/
 	cat >patterns <<-\EOF &&
-- 
gitgitgadget
