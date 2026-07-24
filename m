Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810513CB57E
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 21:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927192; cv=none; b=QsXGeMa22kU+wEreF4x6LPcO7YhkZvO6YsxkNeoT9jk/HOEqRmlC4AeJEc46cu7Df68oQb3CsBY9KjEQWZ87+yGuBgOSp/hVJYzSvJFSJgbP27TVBgpnWPZwGxfdyfaLo/f/VSvlcqfBWuw70td83Oc/bowabhKziD17r0SWa0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927192; c=relaxed/simple;
	bh=jFPCUlyLzxHiWSzofdzgD5GnKiBwVfgD+VUbTCh70DE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIqoeLKNyZTDtGsvWKizzMHXfaz6qfWZJa1hfl3rAaMJs+vXaRlEXuzbMAKvaHLsHIz/Hjz67HGq/2oNvXPcP4g67zK0Jmnob4sP8IQF9R0zr31otHr1l2ZMle7yJDYDjyL2mInt1tJoCP+VL4FfJj5Cp4s9ogxYkIP/3rUazXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Sy/zXn3d; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Sy/zXn3d"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81ed2a00f12so8490457b3.2
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 14:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784927174; x=1785531974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PnLgurrMXgu8C0tKxQHHYEF8uRxx9gvE84rjEsRDYHw=;
        b=Sy/zXn3dqRnE2sLR8P11lTWTTFa0rliZ91kjgJGIdbpn2Uxda99MaZNBFHYeOCqSLh
         SvEfv7XadoAVQ4oYBeh2LFHE0pdBpRMILXJYwtKUDU25YmfYzS10VMkqVYx1Yz4PotHX
         IXHiZp7ZTEuihoulgOhdcB+Z7g/DGrzNJ7g4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784927174; x=1785531974;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PnLgurrMXgu8C0tKxQHHYEF8uRxx9gvE84rjEsRDYHw=;
        b=f2K0wGtdqtQy+GZ91ySuEby/ORSPt84/EpW+h/JzR53dKyTjWA13JnHJGDDt1GYpcM
         Oxp3rWgbSfTr0hJfg78TUH1TKxfAKM7a204mbgTF/akC3C8EIiWpHsPDlEdkVqB/pyZs
         l8mTFJ0VE4HkYrO0af1Xemu+JgmvltCTdUKUN4K/mT+JUHBq1a9382nFIqHTb9IvyZUW
         V0GwvSC0XnRtMt5gOhPeOb8muaCfRV9EXN/1qkBx32zN7/o84+hmVX8h1y0J804Obdm5
         SHkhJvzeTqROaCzVz7jV4RX5NFsNtDwKILacoDZxdLHI3DaZEhfJC7+8kVGkm6X1w59g
         wGww==
X-Gm-Message-State: AOJu0YznB8WgW042tXXPp/OAA0KMnp/i3ip9UooZQvugjAGazy2NgbNg
	0hoORRFuSzhhSUvBPGICEcL8vgfogqjaydgdK36dQNrn1AVWipwdAYc/aw60jWjVf0Esqpr6kCF
	zuTOP6oI=
X-Gm-Gg: AR+sD12Fax0J3xxCUWzu/PnROz60c9ab4svEa7OdxxHMacJbCUBJv+KzY0nQzda5pGE
	c7DgVZDq04SvAtuCpX2gCh9/UwPBjnkkMndNeBWg0ptaSiChWv1PGyCiJflzB2r5+2qCJ49jur0
	MT84nkCEZnbu6EbYcd42h1vQ0Yn41kFzuMAGLMyvRCPYynxParL/2GVK+5piP3sOtejBnpOWOsA
	m2vy4ZUGPNPC0cdcTTf0He0vvZ/H48xlA53k6CcrROpRyrfZW9Uks+PNGhCKCr9fxuAMD8CYkEt
	Y4J4J1carp9HIeGZNqwlpV1CXjt9GEVo1LKLiiS2o2pKRHmR+O8ILrEaTLMYXj7mpUuoIohIiOV
	zGpI4++Aa7esBJY/w5GR9LPFZrq7BWkRmZz+1SDENdDDtz0MhIlijmxAs+957XoakX50vmUVNjK
	jU9NKjJW/oDrnMEKvUEw+y2hYc3V/5MnI7Y+ivAU3YTXdI4DmJOcMUxK4L6gHa7eCKdA5WxGUms
	JDd5DjwmXfuCyyb9PCiYfG+2VM5kzJzJIg7e4UKz8fW6nfrPKFAJaY=
X-Received: by 2002:a05:690c:6a03:b0:81e:de49:128e with SMTP id 00721157ae682-81f69ccc224mr418967b3.13.1784927173797;
        Fri, 24 Jul 2026 14:06:13 -0700 (PDT)
Received: from com-79390 (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f65770c12sm5847007b3.9.2026.07.24.14.06.11
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:06:13 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:06:09 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org
Subject: [PATCH 3/5] midx: verify duplicate pack entries by OID and offset
Message-ID: <5c9dc6880fff33cd6061663cfd170c5daf871dfc.1784927134.git.ttaylorr@openai.com>
References: <cover.1784927134.git.ttaylorr@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1784927134.git.ttaylorr@openai.com>

A MIDX retains one entry per OID, while a non-strict pack index can
contain the same OID at several offsets. verify_midx_file() compares the
recorded offset with find_pack_entry_one(), which may return a different
member of that duplicate run and falsely report a valid MIDX as corrupt.

Check instead that the exact OID/offset pair exists anywhere in the
contiguous duplicate run in the source pack. That is the relevant
invariant: same-pack duplicates have no canonical representation, and
every matching physical copy is valid, including those recorded by
existing MIDXs.

This matches reader behavior. The OOFF chunk records the selected
(pack, offset), and midx_to_pack_pos() reconstructs its RIDX position
from that pair. If midx_pair_to_pack_pos() is given an unselected
duplicate offset, the lookup misses and its sole caller falls back from
partial reuse to normal packing. Readers therefore remain consistent
with whichever representation the MIDX records.

Write a MIDX over the existing duplicate-pack fixture, assert that its
selected offset differs from find_pack_entry_one(), and verify it. Then
run fsck as an application-level check.

Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
 midx.c                            | 59 +++++++++++++++++++++++++++----
 t/helper/test-find-pack.c         | 18 +++++++---
 t/t5308-pack-detect-duplicates.sh | 14 ++++++++
 3 files changed, 80 insertions(+), 11 deletions(-)

diff --git a/midx.c b/midx.c
index 76c3f92cc3..05fe99f8ca 100644
--- a/midx.c
+++ b/midx.c
@@ -906,6 +906,48 @@ static int compare_pair_pos_vs_id(const void *_a, const void *_b)
 	return b->pack_int_id - a->pack_int_id;
 }
 
+/*
+ * Return whether the pack index contains an entry with both "oid" and
+ * "offset". A pack index may contain duplicate OIDs, so an arbitrary
+ * OID lookup is not enough to validate a particular offset.
+ *
+ * Do not use offset_to_pack_pos() here: it may consult an optional '.rev'
+ * file, which is verified separately, or build an in-memory reverse index
+ * that remains attached to the pack. Verify the MIDX directly against its
+ * source pack index instead.
+ */
+static int pack_index_has_oid_at_offset(struct packed_git *p,
+					const struct object_id *oid,
+					off_t offset)
+{
+	struct object_id candidate;
+	uint32_t pos, i;
+
+	if (!bsearch_pack(oid, p, &pos))
+		return 0;
+
+	if (nth_packed_object_offset(p, pos) == offset)
+		return 1;
+
+	for (i = pos; i > 0; i--) {
+		if (nth_packed_object_id(&candidate, p, i - 1) ||
+		    !oideq(&candidate, oid))
+			break;
+		if (nth_packed_object_offset(p, i - 1) == offset)
+			return 1;
+	}
+
+	for (i = pos + 1; i < p->num_objects; i++) {
+		if (nth_packed_object_id(&candidate, p, i) ||
+		    !oideq(&candidate, oid))
+			break;
+		if (nth_packed_object_offset(p, i) == offset)
+			return 1;
+	}
+
+	return 0;
+}
+
 /*
  * Limit calls to display_progress() for performance reasons.
  * The interval here was arbitrarily chosen.
@@ -1015,7 +1057,6 @@ int verify_midx_file(struct odb_source_packed *source, unsigned flags)
 	for (i = 0; i < m->num_objects + m->num_objects_in_base; i++) {
 		struct object_id oid;
 		struct pack_entry e;
-		off_t m_offset, p_offset;
 
 		if (i > 0 && pairs[i-1].pack_int_id != pairs[i].pack_int_id &&
 		    nth_midxed_pack(m, pairs[i-1].pack_int_id)) {
@@ -1040,12 +1081,16 @@ int verify_midx_file(struct odb_source_packed *source, unsigned flags)
 			break;
 		}
 
-		m_offset = e.offset;
-		p_offset = find_pack_entry_one(&oid, e.p);
-
-		if (m_offset != p_offset)
-			midx_report(_("incorrect object offset for oid[%d] = %s: %"PRIx64" != %"PRIx64),
-				    pairs[i].pos, oid_to_hex(&oid), m_offset, p_offset);
+		/*
+		 * Check that the exact offset recorded in the MIDX
+		 * belongs to this OID. A pack index may contain
+		 * duplicate OIDs, in which case an arbitrary OID lookup
+		 * can return a different, equally valid copy than the
+		 * one selected by the MIDX writer.
+		 */
+		if (!pack_index_has_oid_at_offset(e.p, &oid, e.offset))
+			midx_report(_("incorrect object offset for oid[%d] = %s: %"PRIx64),
+				    pairs[i].pos, oid_to_hex(&oid), e.offset);
 
 		midx_display_sparse_progress(progress, i + 1);
 	}
diff --git a/t/helper/test-find-pack.c b/t/helper/test-find-pack.c
index 28d5b1fe09..51093a7030 100644
--- a/t/helper/test-find-pack.c
+++ b/t/helper/test-find-pack.c
@@ -11,12 +11,15 @@
  * Display the path(s), one per line, of the packfile(s) containing
  * the given object.
  *
+ * With '--show-offset', display the offset selected by
+ * find_pack_entry_one() instead of the packfile path.
+ *
  * If '--check-count <n>' is passed, then error out if the number of
  * packfiles containing the object is not <n>.
  */
 
 static const char *const find_pack_usage[] = {
-	"test-tool find-pack [--check-count <n>] <object>",
+	"test-tool find-pack [--check-count <n>] [--show-offset] <object>",
 	NULL
 };
 
@@ -24,11 +27,13 @@ int cmd__find_pack(int argc, const char **argv)
 {
 	struct object_id oid;
 	struct packed_git *p;
-	int count = -1, actual_count = 0;
+	int count = -1, actual_count = 0, show_offset = 0;
 	const char *prefix = setup_git_directory(the_repository);
 
 	struct option options[] = {
 		OPT_INTEGER('c', "check-count", &count, "expected number of packs"),
+		OPT_BOOL(0, "show-offset", &show_offset,
+			 "show matching pack offsets"),
 		OPT_END(),
 	};
 
@@ -40,8 +45,13 @@ int cmd__find_pack(int argc, const char **argv)
 		die("cannot parse %s as an object name", argv[0]);
 
 	repo_for_each_pack(the_repository, p) {
-		if (find_pack_entry_one(&oid, p)) {
-			printf("%s\n", p->pack_name);
+		off_t offset = find_pack_entry_one(&oid, p);
+
+		if (offset) {
+			if (show_offset)
+				printf("%"PRIuMAX"\n", (uintmax_t)offset);
+			else
+				printf("%s\n", p->pack_name);
 			actual_count++;
 		}
 	}
diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-duplicates.sh
index 4ff8f5b449..493ebbc4af 100755
--- a/t/t5308-pack-detect-duplicates.sh
+++ b/t/t5308-pack-detect-duplicates.sh
@@ -77,6 +77,20 @@ test_expect_success 'lookup in duplicated pack' '
 	test_cmp expect actual
 '
 
+test_expect_success 'verify MIDX containing duplicated pack objects' '
+	git multi-pack-index write &&
+	test-tool read-midx --show-objects .git/objects >midx-objects &&
+	midx_offset=$(
+		awk -v oid="$LO_SHA1" "\$1 == oid { print \$2 }" <midx-objects
+	) &&
+	lookup_offset=$(
+		test-tool find-pack --check-count=1 --show-offset "$LO_SHA1"
+	) &&
+	test "$midx_offset" -ne "$lookup_offset" &&
+	git multi-pack-index verify &&
+	git fsck --full
+'
+
 test_expect_success 'duplicate entries remain in pack reverse index' '
 	clear_packs &&
 	{
-- 
2.55.0.383.gde07827a19

