Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E553442FD7
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433372; cv=none; b=szM2ScHugSP7ak0HWkm5NpEGQoO4NKGaDovWXuvR6pt4mQqKzn13GjBKpKLPkPo1sfWwh00RpT6qK+sEIXPpaRfOid1LWySe1dNQ5Fy80vu0KaaZoZPMPngQCY8HWv0ucJ8NoiodTx7MkxIYQWJm9tHZKDwcoXsyt52xCngsXD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433372; c=relaxed/simple;
	bh=KGBNGYjRy8g4gGHu6nZb/o06ufPqKBcq163O5N69Z/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNA6Roa9u0f8ASHxp8yGZ6JS/6Hh/RMb7ppgSOhRzUJ+ffCw5kB3AeequLthBBQRtXgeWfKEbx0yMfOd7zCyzjQIRjt1oqjDvHwzGfVczQhHFWP/i8GojjtOGRJJgL/bblqZWrQs4HdbsBNv0wpxsOM+xXw6skBLWhDtQ17wv78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/RTsb+5; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/RTsb+5"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cbb662575d3so50472a12.0
        for <git@vger.kernel.org>; Thu, 30 Jul 2026 10:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785433370; x=1786038170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M+dCntWC8zCwCFebL6kr2ZfY0mAaYchbpqPL7tlmb0A=;
        b=Z/RTsb+5HW+30nkdr+1d2Cp83eD91CPtPZLFI6GO7kvWLzeg1rcoqG0eWPV7bXIjoa
         dAevEhOHY6RkK3FajBcb4H+0ClIUZTHTVEkrRb/ttfY34p05IXqyUq2EhhkOT/We2KRx
         zvyFPp0wh3GxANBcIuWJQvVus7ubaDYM+TJ+f62Gy0kd7VL0d99oUdJh890hFkDAnHC7
         pEvaZNVFuM50m10RV9cf1HpopGjxc37zUhfBfd9UkWITTJBA9Np/fIrHic9e3L+AWAwS
         ba48Eq2KCXNFro8PRffmOdLfbPx6vPuGgbD/M7Uz/MJznhqTP3JtzsKRVqD86iV6Fzcq
         rCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785433370; x=1786038170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M+dCntWC8zCwCFebL6kr2ZfY0mAaYchbpqPL7tlmb0A=;
        b=EYN++B/fgSfgXlW0nLQDaTm9Ev4wIYD8vIKrgQ94dzyYff8NU7+e4d3XFYudEFSkHb
         Y1AHc/5CK451xUVpLcNs7qZ6DW4grRvvQI8QLj6Dk9A6KID23Z62tTYa9YddmLBUbAQS
         wj11CA2u9cDnMitgAIIBBfegGOjj8O8N4bFwZOOSdt3tKQDPVjrF9/sxx/vw/uZPiniF
         dOwFTem9SLdaE3dM8H5yeWv2r1DgSyvfpkh7EvjLXg+CTB9Ira3hSlKcZgA+uAdPu6wV
         dN5W0ibMxijrk5uvlFi6VgJ8Lh36d4xiM8TpFhfWaxZlA/rbu4mar5qXrY4vUnyxl2zb
         HllA==
X-Gm-Message-State: AOJu0YxEYHmD5h9sKbEULl/BqYhz1xV8xrodWS+Q04dLU74kBtL4ByiO
	bvnR17EhgWeFjtza5IeqH29z1Su1RUyLAfYRFDcTyy0FI/1x2VITYE8s5vMS/w==
X-Gm-Gg: AR+sD12n3JWr1w6EhZZknuEtyZ5PCUr9LRzePzzBRpoV7U+cKWjwhtdkJ0ijUEtRfy9
	TiOlxM6L78s1F9fIp1xNsSx8ac+JX8A0SoITCadDVCjYGAOtfLrqhNY6Ibfmz3UfJ8HDqod/V3V
	eNOgYExqzfKQNi4Z1S24p9kk7LTlf+3kZ9yC/ZvfCTc5UN3LltzQld3ICTvlqF9bHbA44sNVWcO
	yF2sfqbLEj/KYqCiQFnJPqK5hOKFg11ufYfVN4qJ0huFXoOIex7P5XfCGxEy+jaHSTYIp9iC/1B
	ZEW8deWcINu3oWRAK2bizgch249Ioxhn33Feowifp9xEtpWcVmLE/pygFKJNf+HODbT8Fd/ijv3
	HEubXh+YBTVPZ7mXeJjvZ1b9ECkh3Nq5lg/gAwYDGGdkLNuqCZbiyelaUB9cf9j81UT67FvrD10
	fB1cyGDbqI464h7gwZoLdMcHyW1MLyFqFyQCHvXCNduwbJQrhhbxqvycBcBOXCYXogBFS6tUUIN
	8Q0KtaT6iXd3wQeGINM8xPoQUkwOFKHoF0cBbiYU3fnGwWhwbC893nUXOknIArYtYG0QqkVm6Eo
	G/9+efdNUqAd16zDGGOrG9Ab7YU=
X-Received: by 2002:a05:6a21:7008:b0:3c4:397a:69b0 with SMTP id adf61e73a8af0-3c9004c8cdamr3382264637.21.1785433369677;
        Thu, 30 Jul 2026 10:42:49 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:5622:d88b:20c4:5444:d41a:b6c2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504cc9dffsm25163964eec.14.2026.07.30.10.42.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jul 2026 10:42:49 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [GSoC PATCH v2 5/7] builtin/repack: actually drop filtered promisor blobs
Date: Thu, 30 Jul 2026 23:11:51 +0530
Message-ID: <20260730174153.9949-6-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
 <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make --drop-filtered remove the enumerated promisor blobs instead of
only listing them.

The drop set is computed before repack_promisor_objects() runs, and on
a real run it is passed in so the rebuilt promisor pack omits those
blobs. --drop-filtered implies -d so the old promisor packs, which
still contain the dropped blobs, are removed. Without this the blobs
would survive in the redundant packs. The existing repack machinery
performs the write-before-delete and fsync, so the drop is crash-safe.

The dropped blobs become absent locally but remain recoverable from the
promisor remote, so a later access lazy-fetches them back
transparently. --dry-run keeps its previous behavior, i.e. it lists the
candidates and changes nothing.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Siddharth Asthana <siddharthasthana31@gmail.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 builtin/repack.c                | 17 ++++++++++-------
 repack-filtered.c               |  1 +
 t/t7706-repack-drop-filtered.sh | 12 ++++++++++++
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 8cb92d1a62..9a15ab1f2a 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -273,18 +273,12 @@ int cmd_repack(int argc,
 	die_for_incompatible_opt2(drop_filtered, "--drop-filtered",
 		!!filter_to, "--filter-to");
 
-	die_for_incompatible_opt2(drop_filtered, "--drop-filtered",
-		write_bitmaps > 0, "--write-bitmap-index");
-
 	if (dry_run && !drop_filtered)
 		die(_("--dry-run only takes effect with --drop-filtered"));
 
 	if (drop_filtered) {
 		int bitmaps_from_cmdline = (write_bitmaps != write_bitmaps_before_parse);
 
-		if (!dry_run)
-			die(_("--drop-filtered doesn't work without --dry-run yet"));
-
 		if (!po_args.filter_options.choice)
 			die(_("--drop-filtered requires --filter"));
 
@@ -317,6 +311,14 @@ int cmd_repack(int argc,
 
 		write_bitmaps = 0;
 
+		/*
+		 * Dropping objects means rebuilding the promisor packs
+		 * without them and then removing the old packs, so the
+		 * redundant packs must be deleted. Imply -d on a real run.
+		 */
+		if (!dry_run)
+			delete_redundant = 1;
+
 		ret = enumerate_promisor_blobs(repo, &po_args.filter_options, &drop_oids);
 
 		if (ret)
@@ -442,7 +444,8 @@ int cmd_repack(int argc,
 		strvec_push(&cmd.args, "--delta-islands");
 
 	if (pack_everything & ALL_INTO_ONE) {
-		repack_promisor_objects(repo, &po_args, &names, packtmp, NULL);
+		repack_promisor_objects(repo, &po_args, &names, packtmp,
+			(drop_filtered && !dry_run) ? &drop_oids : NULL);
 
 		if (existing_packs_has_non_kept(&existing) &&
 		    delete_redundant &&
diff --git a/repack-filtered.c b/repack-filtered.c
index 217fc54d7b..08796818d8 100644
--- a/repack-filtered.c
+++ b/repack-filtered.c
@@ -119,6 +119,7 @@ int enumerate_promisor_blobs(struct repository *repo,
 
 	/*
 	 * Apply the filter to find which blobs exceed the threshold.
+	 * The caller has to_drop and is responsible for clearing it.
 	 */
 	ret = list_objects_filter__filter_oidset(repo,
 		(struct list_objects_filter_options *)filter,
diff --git a/t/t7706-repack-drop-filtered.sh b/t/t7706-repack-drop-filtered.sh
index cbdb580702..b3e493e851 100755
--- a/t/t7706-repack-drop-filtered.sh
+++ b/t/t7706-repack-drop-filtered.sh
@@ -128,4 +128,16 @@ test_expect_success '--dry-run does not remove the filtered objects' '
 	git -C repo cat-file -e "$BIG"
 '
 
+test_expect_success '--drop-filtered removes the promisor blob locally' '
+	BIG=$(cat big_oid) &&
+	SMALL=$(cat small_oid) &&
+
+	git -C repo -c repack.writeBitmaps=false \
+		repack --drop-filtered --filter=blob:limit=1k -a &&
+
+	git -C repo cat-file --batch-all-objects --batch-check="%(objectname)" >present &&
+	! grep -q "$BIG" present &&
+	grep -q "$SMALL" present
+'
+
 test_done
-- 
2.54.0

