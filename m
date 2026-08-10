Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BD3430CD1
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786383695; cv=none; b=XTScNUNUV5xAYIyyp6fTysDe6tldBqye5K3yUz0taEVOx6ETHTIDlOdPEK1/RYwQzk7XiG5T6egdap069rr/ZbWmtIx5su25qF5N1T4FnnKo0Djklo44OA67/HF2NJS4vh9sInNGls6QHP7JkKCCMqbU9yNCUD6uTCfp25i22VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786383695; c=relaxed/simple;
	bh=exVu1ABIQogRa6+zI0mC+LaVfXBaYCCey0rskEKFKqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qs+WfDvoGfW2MGmlmMJoeg//a0LmUlK5MzwYZutPYcdHKFFq72WZcvS2XFmsogB+DZ9ChYrf7qlCZ53Bp28ET5mgHrAc14J9xOe69FoR1Gp8Zl3m1pQLWsftXv9D14E8Jfwdmf0PM3KYhecqP7fhMm/QIIj5EmralQECegtxfV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5kaaKma; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5kaaKma"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso1546708b3a.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 10:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786383694; x=1786988494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u6g9daj8qWPZXbHMcEw6At4C4HtqvLTnWnDlyKH7X08=;
        b=E5kaaKmaiNDtF3SU5G+Ob0cU8ECnGDdKi7n0NCxC50pnJi16sTmoEQPyb76me+p4Ye
         sSlqnW0ridXxapXmzLnzwOecOkqUT/AP+mDK9kZffKtbvFl4/5KnOFy6Zm5RQJ45BMvO
         bEBXWo+ey/jWJcOKeVGqCtVj56/48k1sczGjq/RoYHRnkcSTdypfNqirqszCIOb59w/6
         6u7lR/AW4rLLBSc/CL2OSkZP+TS3QcAaUanS2XdnSDksmCcMlka2Ehq1uDRgytBeuYzt
         oP8kNW2lw4d/rTOvB9L7gKznUWL3nkAaiwxJSoKxQ1KVsguPPhMXVNfS1KboRllo8zUj
         yHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786383694; x=1786988494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u6g9daj8qWPZXbHMcEw6At4C4HtqvLTnWnDlyKH7X08=;
        b=mRJb469pXBjeRgph+mfP46+SpLaneUUOxDOeW50egg0+d7En6lzwHOa1pKPI2T5HKP
         xKOPLlDYVT8qU6Diy4S9vXaEbgGKKbS8DDH3Umz/xtE8BPgch2g7+IRwm2uBp57KCcdT
         Tawiyl9TMwjU+rEy5jBECU96EeUkIM/k+RzvvOM9Q0fQ4etOkr5IsgM3yRxUdPF/MIms
         cP1JM9bIhs52P4GmB2LLmQH6RpIUA3uSAEz+dOEB0dUew07/mskiPYZ4XI4ZDaeN3Hrm
         WAUToSQzqKyZFdGSnf2YAj5CVvg5kDYHLwBgaAg+Vu+e9MdICXcg8jjd1l620aXBRSYN
         Cv4Q==
X-Gm-Message-State: AOJu0YzAHoZTW+mSokB9K7wsu/Ja4xTv9Uo1wF4okL4obFlOBXVzBfDQ
	hZbLJRAcUrO1FBRTHu98EMj0puKslKiePzBzvHBQHFRefSzgbqLpFzG3+hFyIVSZ
X-Gm-Gg: AR+sD12MhLP7WkRAy/54qK9I2s5ZDxNPKucY9uXpiAnus9qPlPoQWCu1nD7l7OUdWMW
	DPIAvDHDkSMJFtf4dNg5v5sMlSirxFjs763bRwmfvfj9MBRNuthBUKRKu5psyeG2dduHHlc2x6/
	dWyam21c79LkyD8BLfx4a83NTyOfbNPj2/R4LEX3LY5Kd/xQdGgKsQo/YhFuSYFYGEyDtzYtmD0
	kvqGtU/RDD+CslFv1+KUGjYda0sUNos57/5fyZE2qJLXQAbsaTg2nTYSQZct8gFNJvlQK6ikKg7
	1Z2GBuNDmUHmQlHOj2XZpxZV2j3L76LQqAZ5HBETn+MVgTmTjhjrVM1aWuDlyCJGPZTnLkhNX4A
	TkJGZBtFNTMSow3/lrGrYrrxFZiKXdqLGAJz/XvmWxMhZwIjEuhA6Wi3wpqvLK4zsy/MLCUBdh/
	D2RhA5cb3DJS4rcH5xQOS38DeKqvNYQWOIzTBt0uHv7Q1JSQcwwEXnMepgQ0A2HwrSp2Xf+YnJD
	1lgYa9jlpOyTkGy0xp4EszrKyifX1PhOFJ7S1/29ft7f75ToMyTuVYc7koTY3Qn6SuyBnsti4Xx
	b7iI2ZAAeeSnAhf260LMzQ==
X-Received: by 2002:a05:6a20:7349:b0:3c6:3c5b:f2e1 with SMTP id adf61e73a8af0-3cbadcfcacfmr32373922637.32.1786383693537;
        Mon, 10 Aug 2026 10:41:33 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:5026:8db8:20aa:c615:9a47:206a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14101b7b39bsm36865585c88.14.2026.08.10.10.41.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Aug 2026 10:41:32 -0700 (PDT)
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
Subject: [GSoC PATCH v4 5/7] builtin/repack: actually drop filtered promisor blobs
Date: Mon, 10 Aug 2026 23:10:45 +0530
Message-ID: <20260810174047.6524-6-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
References: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
 <20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
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
 builtin/repack.c                | 14 ++++++++++----
 repack-filtered.c               |  1 +
 t/t7706-repack-drop-filtered.sh | 12 ++++++++++++
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index a47e64d91e..e90016a33e 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -287,9 +287,6 @@ int cmd_repack(int argc,
 		die(_("--dry-run only takes effect with --drop-filtered"));
 
 	if (drop_filtered) {
-		if (!dry_run)
-			die(_("--drop-filtered doesn't work without --dry-run yet"));
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
diff --git a/repack-filtered.c b/repack-filtered.c
index 79ba6d90aa..e6c35c23de 100644
--- a/repack-filtered.c
+++ b/repack-filtered.c
@@ -120,6 +120,7 @@ int enumerate_promisor_blobs(struct repository *repo,
 
 	/*
 	 * Apply the filter to find which blobs exceed the threshold.
+	 * The caller has to_drop and is responsible for clearing it.
 	 */
 	ret = list_objects_filter__filter_oidset(repo,
 		(struct list_objects_filter_options *)filter,
diff --git a/t/t7706-repack-drop-filtered.sh b/t/t7706-repack-drop-filtered.sh
index 453053cc18..ba00239c9d 100755
--- a/t/t7706-repack-drop-filtered.sh
+++ b/t/t7706-repack-drop-filtered.sh
@@ -134,4 +134,16 @@ test_expect_success '--dry-run does not remove the filtered objects' '
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

