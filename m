Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9354C372B27
	for <git@vger.kernel.org>; Fri, 22 May 2026 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779474296; cv=none; b=GEsx+AV9/yjVCcoYU2Q024yBBt6s80hlcsuALkaXc5K9oIrXCEUqfTG2Ru62BJWeCC38Nf/cc3gT8YScL1LJX3IeB/oeijjqhsY3XmqVsA+ShlExSGFJxXJxQs3LYA5qeyQ6lp67k/HK/b9mQQPmfBuVjEO4Ky3fgv7/LKrRbC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779474296; c=relaxed/simple;
	bh=0lZDsUn0CwBgSDStNknTzGNQnmV4AM9yMQC/K2JIJX4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VDbHn+uj/P2YxvJbX2yPFakRLZ2mLKREEXNDWPrpA6A1D2QYBgjQCjOvv3UkaWpD4uXJDmEEiMJGr5v0SJOg7lcrcjROQZV3ZsktCBnU2xE+s3RUJzcEFV5PnwasxbHqqw8K4qzRPX+16sXuEORbYoWZ6KgxkmPcwNoEu9+ih64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QICQRUlL; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QICQRUlL"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8bc3ef10cc4so102018656d6.1
        for <git@vger.kernel.org>; Fri, 22 May 2026 11:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779474293; x=1780079093; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqWr8h9uR6znaMOdvxKi9QVnSjmJDTsXHZJI5dQ+ecc=;
        b=QICQRUlLhSCbm3MKgGJs5pYtg+R3K7GALN0Z5AhKOChc54N1TbozYd7fkGyaZlrpEG
         8kxJkeZ2t5j0b1YhFVVeLFloYrOyKOvi2ZRPliVdXfzDx2qdT78wq/wEBxlgNWa1idIb
         chhRCEHCZQW9DpWTNPpf3TSs8qFFEiOWSEKhgMIbp/UgYiKXNDo43ZMRpBsjCX6I7YRu
         KC1er5pf0o7X2BMm2vSqw7yviQTm2fJH6qTg/yaDOEK3nijI/KzEq0jy0Eyws/+alU+H
         dbmzQWYnkkjMc7S9UYt6UhAPqkYis3iy97nwRBpa2ifejV07JJwZ5qY9TlyBnNuy1m5Q
         Mz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779474293; x=1780079093;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GqWr8h9uR6znaMOdvxKi9QVnSjmJDTsXHZJI5dQ+ecc=;
        b=KQRKBAc3hvQI1PcFqQEgdFT/VGmr/unZTn4rBKPAxeLKW1Rf9qbJRbp71xLMo8J3l8
         MBin9LYAer/W6O7UHKfld4XkmFzICIxeWk8M6z8FuxcC22+7RY+oLFoTsAjaChhG/OsW
         QF27O0h9/4aLDFsqLBfvfNz1qfOnRjehN2OjI7qOqj4pvLpn6cGmiQ7hPn4DMJ4GUniw
         ybeSJM6CLaPq6fndKRE5rzyLWo+umK+XNtlw3eGzNO4OIsEZM6bpH68jrWPED1VQ/WDn
         IznBu1n2BB0zlocnCaTKXgu/M4cNIKygRbQ7g0cNtJcijVR8rPRvkSGJf85K8hsKj1mR
         4L7w==
X-Gm-Message-State: AOJu0Yz/WmxLI8cxbWuUnt+ROzZdKhxwiyIR/cBtwc04zljYWBiYIAb5
	3Y05ewnCZQL3KWrbu2Gu6/zgGUinkk6J6HUwiGusGu8J8HgfOQZGoKvM69SPLlHJ
X-Gm-Gg: Acq92OHpGPl3moG+nPGOKz/jOl8LEhag9tt+kMSBwjBOIxHHF+9LYtjPlVaRsa37cKX
	erKTznIWOK8utuTeMnnwBM7L8SC2Lx+h4i96i95+47E/jLZ3qJ+EHiac5e3XMmeDWMrVDq8AhmQ
	Kwg2IAUlzp3XoculbIDVoJ2kmBzMbyw+rsOF5tWvaFMAaB+NiynDr0WtT+iJ3JnQJ3Bxq0zUDwU
	90FdkD3zwbAk0GsctIUhfNHIcrNffdcqL9GNm1kurIj0mlPnOc6vNbOhjnBP3OtrOUpmNUZ3U/J
	t2ugiQ32sZ9v4u9GPdD+MNu8FhqyxjmiacDEBKQ3pnrBQzKIrQV7NgLesGZ2YXEwgcrIqeJDJ2n
	nJd2PB0G+53nrogS+G1uGrNzEdKxlApt+gMV4+BDe4j+ipZoAo6uJWY6oBwLZ+6wyoVsoyxvQjd
	rnIKGt36p5Zx1TqM2Q9YeR0WLdPcg=
X-Received: by 2002:a05:6214:2b83:b0:8b0:2c81:ad5f with SMTP id 6a1803df08f44-8cc7b541aa3mr85489456d6.11.1779474293501;
        Fri, 22 May 2026 11:24:53 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.123.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc81323f7csm25019936d6.46.2026.05.22.11.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 11:24:53 -0700 (PDT)
Message-Id: <d33d89925119fc9449e29c8031e6962894e8d5e1.1779474277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v5.git.1779474277.gitgitgadget@gmail.com>
References: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
	<pull.2101.v5.git.1779474277.gitgitgadget@gmail.com>
From: "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 18:24:37 +0000
Subject: [PATCH v5 13/13] path-walk: support `combine` filter
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
