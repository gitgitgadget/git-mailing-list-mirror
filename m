Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7A43328FD
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 20:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651757; cv=none; b=mOfQB6ZqPRP+eTVHfuzD1ddh2PHTJa8UgPRb1C0Rwkr1TJAF5C6s4JroNlEKOVZevVEu3FHkOoR999gc7HvwQ5mjRR5yG4UUfmqnJIJnQafLNP97Sbip+K819vo1c7WKXCrLcmd1fetDbO4+mCRPt7NLF95c0w/wvFaBklbfqNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651757; c=relaxed/simple;
	bh=EsG2lHIyt/KKrnQ4k+ZZOc7onXMQXVL/WB6uEJlxa/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kh37DYUY/k33nl56Zfe97aVPM9pdW4dO1xW3WwypZZwQspGV9TQJ6u73Rzp1DFShDlm+mpsJJ4tFdHdlV+/3RqbbKr45FwJybbSDhWK4y4OoA8F9tHceRILSydtmBPialCPEBqTxf6PvmKvBMJ9GI1bkOQHbo9IgjWQCq96FofY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kb/QPGkk; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kb/QPGkk"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca7c1176317so191231a12.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 13:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786651755; x=1787256555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UUyVAiCfQB4NOVZb6QxtOLKy9hFJOdLuiAkNneGCmvg=;
        b=Kb/QPGkkKMTcB2lwt78kV0VDcpxor84nLb4f99DIP+9wczq04D1m/hrcrbAzYhUtqe
         dWnCYOxoXPTw/I9tqV9oyHeIfyr8ksduqnnk6rUro5kWOi5uOj4EeHg1nt8zMFPihM98
         kUw7+TH9CuyhUYWjyQpwjTuitxybS46iIIPlesB0XfR+JE47+20bqwXMmoHftjABLMzq
         Ticvhizv9cU1I/V7EgegZylO0l3+T8mC3HusOPXbIbewOwCcRL3wrhgkahLBv43HtL8x
         1J5i4ztREHbfxCMBEs8ZXsJddiVthMln9cojGO+k+zPWLxUN/Jz6jwVCmASJam4I4oQr
         fy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786651755; x=1787256555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UUyVAiCfQB4NOVZb6QxtOLKy9hFJOdLuiAkNneGCmvg=;
        b=s7aJhx3e9f+cC8+TvDjLMYKqKiHsY67IUO5Bkel2IppAeOCYf6BnUWGjcs+Bw95Fxr
         q34Ma9S/LFwWMkTgq6auQoyqFTqNf/7WM3p4iV3RmYLQj4b2B24pWQJLNbwnES5LBUem
         fIluetmPrVTmCW4DM78ycGKR4f00OZy1NFdPT5D3eaRXuw8jWnO3l/2XdBdUa7ZCI0U9
         2Q7Xcg94Z/mvUQp/16Mlf7omd4YrTv1OXYXsJ+9B/bHlGWiPrZB6UaU5TQHasjUzYv4O
         E+i0Y3uuJbDcELP0e2mhdg36NbLmZNMqlGlMItydfhINww64/THjngq/q2j3E54ZmCDC
         pf1Q==
X-Gm-Message-State: AOJu0YyxZmNZN8EKmVkkVIOAs52rFVve78dwTEOpRxC9sVmLcg4gsi20
	hvhwKDgVOxSeAK2ULQEnjv3DBo+TziH5MWZ2z0ku800SSiXkWSuboY/tgFVXj0yc
X-Gm-Gg: AR+sD13rStkzzEMZYmzEB/4rzOEEikkilBKVN71SfYCLGnGdjTmYlsWsr4IcyytocwE
	om/ovYNlysYU64zviRTuFLOGGA7//iIZG5QPwen3/o8SQrPWLC9UJcLPP0jrQaSopgfzJgAYwQd
	UKdzWFT3mSV8NkOSWpDp9o2iQqIjI50UdNxjSQYid0bfiK8D/6Ll2Wl9PswMGHc84XtOGtU5GFz
	h5bNIbweju6TVi2NE//vaMYA5Ni4EliRGpQ6fczhH33XOcwhMrBtD+aPXEzPJBbTbruhpCtqwpZ
	hyUquxLiE2g1ISnLN1RcaZDmaFSJv3gpFyzC52op8aC+qIHzWYVcty3pqEQ2aCsy7Y0/bAs2H6k
	awLlmgbOPzQBdPbrBzLYbb/vK5qY8z/s0Av6yFX6KCqBplD3/oyLD6JixltHQDJzUwe4FzAL7Pw
	2PzAk0QsCVLFpfLA/VIVFRLn30tSvxKzYvUiRfffxCGzeBLeOKtz8oRDJqe/fPAmsAJ9ES5JuN+
	1VSQCrs3wdV1tujglZ81+ADZmMzFqdBrjXCz7L5JcAfG3W1UtiWsSF2Pg6RNVKuM3Vz6cvkey3F
	UM4ZGaDgoDEGO+Nvmau6og==
X-Received: by 2002:a05:6a20:b40b:b0:3cb:b5f6:43d4 with SMTP id adf61e73a8af0-3cc71d5c2f8mr309288637.23.1786651755316;
        Thu, 13 Aug 2026 13:09:15 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:ad47:4055:841d:89ad:96b0:2f73])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387c6f95sm1533440c88.6.2026.08.13.13.09.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 13:09:14 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	ttaylorr@openai.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [GSoC PATCH v5 5/6] builtin/repack: actually drop filtered promisor blobs
Date: Fri, 14 Aug 2026 01:38:29 +0530
Message-ID: <20260813200830.84348-6-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260813200830.84348-1-r.siddharth.shrimali@gmail.com>
References: <20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
 <20260813200830.84348-1-r.siddharth.shrimali@gmail.com>
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
 Documentation/git-repack.adoc   | 28 ++++++++++++++++++++++++++++
 builtin/repack.c                | 14 ++++++++++----
 t/t7706-repack-drop-filtered.sh | 12 ++++++++++++
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
index 72c42015e2..130249a139 100644
--- a/Documentation/git-repack.adoc
+++ b/Documentation/git-repack.adoc
@@ -12,6 +12,7 @@ SYNOPSIS
 'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]
 	[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
 	[--write-midx[=<mode>]] [--name-hash-version=<n>] [--path-walk]
+	[--filter=<filter-spec>] [--drop-filtered [--dry-run]]
 
 DESCRIPTION
 -----------
@@ -182,6 +183,33 @@ depth is 4095.
 	`objects` and `objects/info/alternates` sections of
 	linkgit:gitrepository-layout[5].
 
+--drop-filtered::
+	Delete the local objects that match the `--filter` specification
+	instead of keeping them in a separate packfile, reclaiming the
+	disk space they occupy. This is intended for partial clones,
+	where the filtered objects are promisor objects that remain
+	recoverable from the promisor remote and are lazily re-fetched
+	on demand when they are next needed.
++
+Only large blobs are supported for now, so `--filter=blob:limit=<n>`
+is currently the only accepted filter. Because dropped objects must be
+recoverable, this option requires a promisor remote to be configured
+and refuses to run otherwise.
++
+This option requires `-a`, and implies `-d`: the objects are dropped by
+rebuilding the promisor pack without them and then removing the now
+redundant old packs, so the redundant packs must be deleted for the
+space to actually be reclaimed. It is incompatible with `--filter-to`
+and with bitmap writing (`-b`/`--write-bitmap-index`), since filtering
+breaks the single-pack closure that bitmaps require. A bitmap setting
+coming from configuration is silently disabled for the duration of the
+command.
+
+--dry-run::
+	Only meaningful with `--drop-filtered`. List the objects that
+	would be dropped, one object ID per line, without rebuilding any
+	pack or deleting anything.
+
 -b::
 --write-bitmap-index::
 	Write a reachability bitmap index as part of the repack. This
diff --git a/builtin/repack.c b/builtin/repack.c
index 3633b17ce8..a5f13fdd87 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -287,9 +287,6 @@ int cmd_repack(int argc,
 		die(_("--dry-run only takes effect with --drop-filtered"));
 
 	if (drop_filtered) {
-		if (!dry_run)
-			die(_("--drop-filtered does not work without --dry-run yet"));
-
 		if (!po_args.filter_options.choice)
 			die(_("--drop-filtered requires --filter"));
 
@@ -322,6 +319,14 @@ int cmd_repack(int argc,
 
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
@@ -447,7 +452,8 @@ int cmd_repack(int argc,
 		strvec_push(&cmd.args, "--delta-islands");
 
 	if (pack_everything & ALL_INTO_ONE) {
-		repack_promisor_objects(repo, &po_args, &names, packtmp, NULL);
+		repack_promisor_objects(repo, &po_args, &names, packtmp,
+			(drop_filtered && !dry_run) ? &drop_oids : NULL);
 
 		if (existing_packs_has_non_kept(&existing) &&
 		    delete_redundant &&
diff --git a/t/t7706-repack-drop-filtered.sh b/t/t7706-repack-drop-filtered.sh
index 6352f1fdce..80c695742f 100755
--- a/t/t7706-repack-drop-filtered.sh
+++ b/t/t7706-repack-drop-filtered.sh
@@ -135,4 +135,16 @@ test_expect_success '--dry-run does not remove the filtered objects' '
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
+	test_grep ! "$BIG" present &&
+	test_grep "$SMALL" present
+'
+
 test_done
-- 
2.54.0

