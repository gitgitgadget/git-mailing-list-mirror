Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993F0269D18
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765218469; cv=none; b=P7/7kYEmgUG/mfOPd5zVzLS9Kl4qKPF0+xHj7w0Ey1YAgcavsNVJ+YqNvyeVKlcNNlY2jva46NnxeQo7qcWZS2F9OBlA/rx4jJS/4lP1rTUGkgyFOb2XHK9buIC+vyP0qJrGNi2hczlJvUAWaAr8i5GU9LVAhjHwVlrEIuegJeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765218469; c=relaxed/simple;
	bh=RWFdjnUG291wHxmUs2/65yjpwq+G737D34aZh6NUuIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uIOqY0GSSGdRGmwLkDHVKcaDsK2pHi6puU53Nfnoa2AcRRsPU/GisuSoYDeUb/8Tae6sNw1lo9+JKQ7rdpUN5GhLv+7Zv9JzVXlfJclbMyElTJpxPEqaQo3wGH2nhW3KsOa5Cw61dP+yRlDc96pNADEAMub8Jhz7dVR9ER5hiNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HPnBVQX9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gs9XfSM3; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HPnBVQX9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gs9XfSM3"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A7DEBEC0084;
	Mon,  8 Dec 2025 13:27:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 08 Dec 2025 13:27:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765218466;
	 x=1765304866; bh=4czwQ7a29ixH9/GF0DHKlZtRnNVfYortn0xYw9nI2Yc=; b=
	HPnBVQX9nMZtMG7b8KkBZqtOAoD8E8dk7y0ioW27eUsmMAJRChBukRE5ENaFCpws
	MDqShaz/SRwNuYLbk1YrRtJfSN4g7KmJDJf6nRyxyYol4gUnIB24q6pmmj5GCp1E
	gkTF214IRht2LJffOs7RGhcliyDNHRHStDIn5G6MhTIq5oGq76U9RSf04PLUdwS4
	KjtBvZvot+MMsuSHj54CMFQSCvy22OsDSiDo/k/fS949Xx1cQaqNbe+UL9SUZuOm
	NcdZPNVidus5ZqBcKPMRbav0OHnew58tjfZlK/96VXLr2DZOY2B1r9Khnbb6BZAJ
	MDUqRX3R8iSgtEyzm/mG2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765218466; x=
	1765304866; bh=4czwQ7a29ixH9/GF0DHKlZtRnNVfYortn0xYw9nI2Yc=; b=g
	s9XfSM3HGKIA0RqMXwUHGjGMcYv+wgt2WYWuFppx9D/nLzTElXjgrcnHRPSeIoix
	CliO/KNHktpbPsJHh6qgU+VxvirEIt1MkH82E/vWI3rU4O94zoXKhMNZ0o6auuK8
	+V4jzPKK4lEzBDPd6EH+3PfdtUpnZDosyCBfULodEtiQpdBMT1rRr0n0Ax0E6UMO
	tRHXZSfR19NPiX4tgkWutGkfbs5pH9fJ/HFaY8lVeVuEox4LTwxvFBB2v7Bp8ie7
	dnx1hRzBXg7CTr4MxHMQcVQ9tg2sq2Pvj0PSH42OjzG6O9oCgkG6L7jJVwlGvW6r
	V2M3rdWPd+Xz5YpPtWLUg==
X-ME-Sender: <xms:ohg3aZykRFj0eUyjA084nvGjxquPIqUEsGuHpjtPrFHnjgALbQdGXg>
    <xme:ohg3aQs2wPrs_2Uu3eEq6Gf3-44ndrZLb74-2VPuVfIBa_lq62U5iBnDonlIHpzD5
    SPB-FEXm9MUO93BS3vbOKPlnPvN8EMp7gqXAYY2qaZfd5qOXOvRhw>
X-ME-Received: <xmr:ohg3aQvtBgU-CdqbgzdPjTxmxCitM_EZo2TSGaxPKEYOHgpWUkiMWjBIMXmZx3nSpOE74OXp60auURj_5xZNQdUYWT0qif4-b6UDmBV6mXo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgf
    dtudffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ohg3aVNT2VUks0K7e9yI5VQCjjWMjuN0eJ0etScqDzOZDWa5wv_hkA>
    <xmx:ohg3ae2HSgPOgx8IJmBIweq94sIIDY3KYr3ttfxuWM-tOezkIulCMA>
    <xmx:ohg3aRNP6Dvx2nBOOmFB2F0bW1vhyz0SIRgVk3YlA_0zIbiwpoSS4g>
    <xmx:ohg3ae3GSwahZ1yrDsfuxCKjl-wOG5w5mUlehBofpcCP4E-UPbrKQQ>
    <xmx:ohg3aQI3PxZHuW1TUH8sZoEAEWjJufR5kPZd0HR18cPn9tM2uBkp9n_l>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 13:27:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cc4110e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Dec 2025 18:27:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Dec 2025 19:27:15 +0100
Subject: [PATCH 2/2] builtin/repack: don't regenerate MIDX unless needed
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251208-pks-skip-noop-rewrite-v1-2-430d52dba9f0@pks.im>
References: <20251208-pks-skip-noop-rewrite-v1-0-430d52dba9f0@pks.im>
In-Reply-To: <20251208-pks-skip-noop-rewrite-v1-0-430d52dba9f0@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

When calling `git repack --write-midx` we will unconditionally rewrite
the multi-pack index. This is of course expected in the case where the
layout of packfiles has changed. But when the layout of packfiles did
not change it's of course a potentially-large waste of time.

With our default maintenance strategy this isn't really that much of a
problem, as git-repack(1) would only be called by git-gc(1) in case we
know that the layout _will_ change. But that is changing with geometric
repacking, where it is the responsibility of git-repack(1) itself to
determine whether or not any packs need to be merged together. So while
git-repack happily declares that there is "Nothing new to pack.", we
end up rewriting the MIDX.

This issue can be demonstrated trivially with a benchmark in the Git
repository: executing `git repack --geometric=2 --write-midx -d` in the
Git repository takes more than 3 seconds only to end up with the same
multi-pack index as we already had before.

Address this issue by introducing a new function that determines whether
a rewrite of the MIDX would cause any user-visible changes. This covers
the following cases:

  - No multi-pack index exists at all.

  - The user asked us to write a bitmap, and we don't have any.

  - The request preferred pack is different than the one that we have.

  - The packfiles covered by the MIDX are changing.

Only if any of these conditions trigger we decide to write a new MIDX.
This allows us to significantly reduce the time for repacks that end up
doing nothing:

    Benchmark 1: git repack --geometric=2 --write-midx -d
      Time (mean ± σ):      3.183 s ±  0.078 s    [User: 2.924 s, System: 0.219 s]
      Range (min … max):    2.985 s …  3.260 s    10 runs

    Benchmark 2: ./git repack --geometric=2 --write-midx -d
      Time (mean ± σ):     102.5 ms ±   1.0 ms    [User: 89.3 ms, System: 12.7 ms]
      Range (min … max):   101.3 ms … 105.3 ms    28 runs

    Summary
      ./git repack --geometric=2 --write-midx -d ran
       31.06 ± 0.82 times faster than git repack --geometric=2 --write-midx -d

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repack-midx.c               | 90 +++++++++++++++++++++++++++++++++++++++++++++
 t/t5319-multi-pack-index.sh | 42 +++++++++++++++++++++
 t/t7703-repack-geometric.sh | 80 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 212 insertions(+)

diff --git a/repack-midx.c b/repack-midx.c
index 74bdfa3a6e..4e47f7c713 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -2,6 +2,7 @@
 #include "repack.h"
 #include "hash.h"
 #include "hex.h"
+#include "midx.h"
 #include "odb.h"
 #include "oidset.h"
 #include "pack-bitmap.h"
@@ -283,6 +284,92 @@ static void remove_redundant_bitmaps(struct string_list *include,
 	strbuf_release(&path);
 }
 
+static bool midx_needs_update(struct repack_write_midx_opts *opts,
+			      struct string_list *include,
+			      struct packed_git *new_preferred)
+{
+	struct multi_pack_index *midx;
+	uint32_t preferred_pack_id;
+	bool needed = true;
+
+	/*
+	 * If there is no multi-pack index we obviously need to generate a new
+	 * one.  Note that we cannot use `get_multi_pack_index()` here, as we
+	 * might be operating with a closed object database.
+	 */
+	midx = load_multi_pack_index(opts->existing->repo->objects->sources);
+	if (!midx)
+		goto out;
+
+	/*
+	 * If we're instructed to write a bitmap we need to verify whether we
+	 * already got one.
+	 */
+	if (opts->write_bitmaps) {
+		struct bitmap_index *bitmap = prepare_midx_bitmap_git(midx);
+		bool bitmap_exists = bitmap && bitmap_is_midx(bitmap);
+		free_bitmap_index(bitmap);
+		if (!bitmap_exists)
+			goto out;
+	}
+
+	/*
+	 * If we're asked to generate the MIDX with a preferred pack we need to
+	 * verify that the current prepared pack matches the desired one. We
+	 * can only determine this in the case where we write bitmaps though,
+	 * so we ignore this setting otherwise.
+	 */
+	if (new_preferred && opts->write_bitmaps) {
+		struct packed_git *old_preferred = NULL;
+
+		if (!midx_preferred_pack(midx, &preferred_pack_id))
+			old_preferred = nth_midxed_pack(midx, preferred_pack_id);
+
+		if (!old_preferred)
+			goto out;
+
+		if (strcmp(pack_basename(new_preferred),
+			   pack_basename(old_preferred)))
+			goto out;
+	 }
+
+	/*
+	 * Otherwise, we need to verify that the packs that are about to be
+	 * included in the MIDX matches the currently covered packs.
+	 */
+	if (include->nr != opts->existing->midx_packs.nr)
+		goto out;
+
+	string_list_sort(include);
+	string_list_sort(&opts->existing->midx_packs);
+	for (size_t i = 0; i < include->nr; i++) {
+		const char *include_name = include->items[i].string;
+		const char *existing_name = opts->existing->midx_packs.items[i].string;
+		size_t include_len = strlen(include_name);
+		size_t existing_len = strlen(existing_name);
+
+		/*
+		 * We track pack indices for the include list, but the
+		 * packfiles themselves in the existing list. We thus need to
+		 * strip these suffixes.
+		 */
+		if (ends_with(include_name, ".idx"))
+			include_len -= strlen(".idx");
+		if (ends_with(existing_name, ".pack"))
+			existing_len -= strlen(".pack");
+		if (include_len != existing_len)
+			goto out;
+		if (memcmp(include_name, existing_name, include_len))
+			goto out;
+	}
+
+	needed = false;
+
+out:
+	close_midx(midx);
+	return needed;
+}
+
 int write_midx_included_packs(struct repack_write_midx_opts *opts)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -296,6 +383,9 @@ int write_midx_included_packs(struct repack_write_midx_opts *opts)
 	if (!include.nr)
 		goto done;
 
+	if (!midx_needs_update(opts, &include, preferred))
+		goto done;
+
 	cmd.in = -1;
 	cmd.git_cmd = 1;
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 9492a9737b..4adf67385a 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -366,6 +366,48 @@ test_expect_success 'preferred pack cannot be determined without bitmap' '
 	)
 '
 
+test_midx_is_retained () {
+	test-tool chmtime =0 .git/objects/pack/multi-pack-index &&
+	ls -l .git/objects/pack/multi-pack-index >expect &&
+	git repack "$@" &&
+	ls -l .git/objects/pack/multi-pack-index >actual &&
+	test_cmp expect actual
+}
+
+test_midx_is_rewritten () {
+	test-tool chmtime =0 .git/objects/pack/multi-pack-index &&
+	ls -l .git/objects/pack/multi-pack-index >expect &&
+	git repack --write-midx "$@" &&
+	ls -l .git/objects/pack/multi-pack-index >actual &&
+	! test_cmp expect actual
+}
+
+test_expect_success 'up-to-date multi-pack-index is retained' '
+	test_when_finished "rm -fr midx-up-to-date" &&
+	git init midx-up-to-date &&
+	(
+		cd midx-up-to-date &&
+
+		# Write the initial pack that contains the most objects. This
+		# will be the preferred pack.
+		test_commit first &&
+		test_commit second &&
+		git repack -Ad --write-midx &&
+		test_midx_is_retained -Ad &&
+
+		# Writing a new bitmap index should cause us to regenerate the MIDX.
+		test_midx_is_rewritten -Ad --write-bitmap-index &&
+		test_midx_is_retained -Ad --write-bitmap-index &&
+
+		# Ensure that writing a new packfile causes us to rewrite the index.
+		test_commit incremental &&
+		test_midx_is_rewritten -d &&
+		test_midx_is_retained -d
+	)
+'
+
+test_done
+
 test_expect_success 'verify multi-pack-index success' '
 	git multi-pack-index verify --object-dir=$objdir
 '
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 9fc1626fbf..980599961c 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -287,6 +287,86 @@ test_expect_success '--geometric with pack.packSizeLimit' '
 	)
 '
 
+test_expect_success '--geometric --write-midx retains up-to-date MIDX without bitmap index' '
+	test_when_finished "rm -fr repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+
+		test_path_is_missing .git/objects/pack/multi-pack-index &&
+		git repack --geometric=2 --write-midx --no-write-bitmap-index &&
+		test_path_is_file .git/objects/pack/multi-pack-index &&
+		test-tool chmtime =0 .git/objects/pack/multi-pack-index &&
+
+		ls -l .git/objects/pack/ >expect &&
+		git repack --geometric=2 --write-midx --no-write-bitmap-index &&
+		ls -l .git/objects/pack/ >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--geometric --write-midx regenerates MIDX when preferred pack changes' '
+	test_when_finished "rm -fr repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		git repack --geometric=2 --write-midx --write-bitmap-index &&
+		test_commit fourth &&
+		git repack --geometric=2 --write-midx --write-bitmap-index &&
+
+		ls .git/objects/pack/*.pack >packs &&
+		test_line_count = 2 packs &&
+		preferred_pack=$(test-tool read-midx --preferred-pack .git/objects) &&
+		other_pack=$(ls .git/objects/pack/*.idx | grep -v "$preferred_pack") &&
+		echo "$preferred_pack" &&
+		echo "$other_pack" &&
+
+		# Rewrite the multi-pack index with the current preferred pack.
+		# git-repack(1) should decide to _not_ repack the MIDX in that
+		# case. This is mostly a sanity check to verify that the reason
+		# for the repack really only is the changed preferred pack.
+		rm -f .git/objects/pack/multi-pack-index* &&
+		git multi-pack-index write --bitmap --preferred-pack="$preferred_pack" &&
+		test-tool chmtime =0 .git/objects/pack/multi-pack-index &&
+		ls -l .git/objects/pack/ >expect &&
+		git repack --geometric=2 --write-midx --write-bitmap-index &&
+		ls -l .git/objects/pack/ >actual &&
+		test_cmp expect actual &&
+
+		# Rewrite the multi-pack index with a different preferred pack.
+		# This time around, git-repack(1) should decide to repack the
+		# MIDX to rectify the preferred pack.
+		rm -f .git/objects/pack/multi-pack-index* &&
+		git multi-pack-index write --bitmap --preferred-pack="$(basename "$other_pack")" &&
+		test-tool chmtime =0 .git/objects/pack/multi-pack-index &&
+		ls -l .git/objects/pack/ >expect &&
+		git repack --geometric=2 --write-midx --write-bitmap-index &&
+		ls -l .git/objects/pack/ >actual &&
+		! test_cmp expect actual
+	)
+'
+
+test_expect_success '--geometric --write-midx retains up-to-date MIDX with bitmap index' '
+	test_when_finished "rm -fr repo" &&
+	git init repo &&
+	test_commit -C repo initial &&
+
+	test_path_is_missing repo/.git/objects/pack/multi-pack-index &&
+	git -C repo repack --geometric=2 --write-midx --write-bitmap-index &&
+	test_path_is_file repo/.git/objects/pack/multi-pack-index &&
+	test-tool chmtime =0 repo/.git/objects/pack/multi-pack-index &&
+
+	ls -l repo/.git/objects/pack/ >expect &&
+	git -C repo repack --geometric=2 --write-midx --write-bitmap-index &&
+	ls -l repo/.git/objects/pack/ >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--geometric --write-midx with packfiles in main and alternate ODB' '
 	test_when_finished "rm -fr shared member" &&
 

-- 
2.52.0.270.g3f4935d65f.dirty

