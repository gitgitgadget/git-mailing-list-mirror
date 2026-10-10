Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F665255E43
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791666071; cv=none; b=O1PF2w/P/yTzUyb2RiRwpsDD40ngDqu7MKXwM3qitxqhIbpogplqg3ul+4tsdup6o3II15fqDkrcZY38bO4RchU5JFMUEfRaya5bgDK5+uB/X4h2o79n2oGv49Y5sNcr5xYhmN6wF6mmtF92yinlvV4dCEliB/FMsWDCfKAmluo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791666071; c=relaxed/simple;
	bh=0XiPXt0IerbUVvHpi5pTWBRYAhotUJFa34EpXUKAhmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIVjgynNewJ1X9Q9AZYcblUihTdbtBIcRXmOANaymuXN2W3ZUfeymgDJoibAADd0T4LyXk64/OyLV7qXqI6nZXsAJKR6nacikhLsWo4obXuicHR3bYa4Hklx4LvSa2z7kJdakgm4wtmcUwYdabwY7734nqCbmlmd3GReceuae5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASEN/Z8b; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASEN/Z8b"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-170135e43c7so280790c88.0
        for <git@vger.kernel.org>; Sat, 10 Oct 2026 14:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791666069; x=1792270869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R13NhmTInGEARGt42xNwnobQtW2t9IzJDN//37fWDco=;
        b=ASEN/Z8bQtpkOvsTj1GgKmwJ2YG3yjisDZ1CGZqnmVk/FkWC07edtzVleeFo1VwTNZ
         w93rdDHq/Y1tfDXlNO83EXuqmyQfLdtCI2XNcArDURbHpb4glvwdeMKhxAY+uJY5MDeP
         S2i/jirlDPrYsp0ViGS+7iHhCFW/6UzL1PaIkBuJs5vXlCaDzLHuWR0D/gtTFBP/hmc1
         Tb4gckTZyQYUfZvNa9Gp3x6Rx5fXe7CgrC/UoLdxE9OcJlRItXop5P938Hp68jKkjVtM
         T7hpGhtwqtwpJ7iYP2FZaypB3t8DyLpizQLWo5pudZcbeoLAAH2iRsL7mXFiymoRhbR8
         PIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791666069; x=1792270869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R13NhmTInGEARGt42xNwnobQtW2t9IzJDN//37fWDco=;
        b=dOwa+XEOL9nxniwvgFMlOYRyoVgD1hIy7kBQOJUkvopNDCAv9K52BIf3Nu0ZQrEdQL
         IEds5a+uUyIyi/IlBafURE+dRYWxHy/RdK1iWtSa7Fo5dtdDd0X5SpiJeeRXKDTuti/u
         6CZSmgv8JcKBxG1KqKAilLv9VaT41KG6/l8Mw8QrRom9MLwvJDxqdB+FIsfAFTUtFJba
         Stdhf5boMgyitx4Ya59JbKEwjo7TGNIYPVLc3U4O42FhH3Kd16mlQy40FpB6H3N2UCi7
         504pYq0sAUj3G+tG+dOcRdRwXK3oickZ/B+dI+gp0AUud9WFPfqDXkTDhX2qO9YKi8Zt
         SzYQ==
X-Gm-Message-State: AFq9FYLfUucHYC4wtfXGvZucspHWJDoK7v74EdcKv1D+hnjcVdsu5lyk
	yHVCJBDolfHN6ALXH2s579IBy6J4QL18AztKJBmPzcTr1hbSvn599A+7yNK4WrkA
X-Gm-Gg: AYBFou2AAvH0scCwG9zwOkiE9GO15siPLYVezaxgprqVE+QAE0hJpFib2myQfgu0bwL
	VXkCnjPCg0hTZJTmc9patTaPVzV4C7wB6sdtmGXQGg5O4BgQuO0UNCNBbI9isj7RAa7imD/oNP4
	ySVYAi/t8+xXx8QYvWe4QBarUW/53oLJk6GJqJVFMeFTQgZoEpm+CDRF3Ve4BFLBFrymDwwcHvc
	q27FLyoZ3lP6J4zN0mhg92H5W/6awid9SACE9NTy1zJFodWNkMDCrDTYiEMmBEcF8zCM8bPwjoL
	luFo4S1cnrSRKET0OWHFJj/ZvkTM5fCGzJQzVVNn/HKDeIUB4vXaoSnUPYRN2iF5gGik4RL3aG2
	t5RhJyiiQsFtmteZ/mF+Z6Nuumb6MqZ52OwyXdqT9k9SLC6uTJLev1ZI8YsOI/I7SZFI3oSAN/r
	ndU9hDKduFTOO5O2f9C7D/ALJTT/PKVz2tB6zFjVp6a0N4t9W+Zc+rmOschFUJAMJ+yQek9Wvg/
	uQ+24wKt2UHVOVYNiX35coFZP4+jxQIbWwmMbGHwLCwuQPnM10AA98nVTltfHCDL5w5icmTTzvq
	9BntOfzBuVYW7UvT8+QB37TvtCTlcCU=
X-Received: by 2002:a05:7022:e27:b0:171:a066:938e with SMTP id a92af1059eb24-171a0669487mr567128c88.21.1791666068747;
        Sat, 10 Oct 2026 14:01:08 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:5436:d246:945e:7001:dd65:6221])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a3f6186fsm16957223c88.14.2026.10.10.14.01.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Oct 2026 14:01:08 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: coygeek@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH v2] repack: do not rebuild packs on --dry-run
Date: Sun, 11 Oct 2026 02:30:50 +0530
Message-ID: <20261010210050.76064-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261008062521.25505-1-r.siddharth.shrimali@gmail.com>
References: <20261008062521.25505-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"git repack --drop-filtered --dry-run" is documented to list the
objects that would be dropped "without rebuilding any pack or
deleting anything", but it does both.

This is a bug in cmd_repack(): after printing the candidates, the
--dry-run block falls through into the regular repack code.
repack_promisor_objects() writes a new promisor pack, and with -d,
existing_packs_remove_redundant() deletes the old packs.

The existing guard only skips the implied "delete_redundant = 1", so
it does not stop an explicit -d, and it does not stop the new pack
from being written either.

This has been broken since --dry-run was introduced in 1e746b00aa
(builtin/repack: add --drop-filtered and --dry-run options). The
--dry-run block never returned early, so a dry run has always gone
on to do a regular repack. It was not broken by a later change.

Fix it by returning right after the candidates are listed, and add a
test that checks the pack directory is unchanged with and without -d.

Reported-by: Coy Geek <coygeek@gmail.com>
Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
Bug report:
https://lore.kernel.org/git/CACgTecOm+=vbf50tZNXhcYvRi1ZTsQwbjVoJAbQqs2CmXdJCxg@mail.gmail.com/

Changes since v1:
 - reworded the comment
 - documented the bug in the log message

 builtin/repack.c                |  7 +++++++
 t/t7706-repack-drop-filtered.sh | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index c4360382c1..7797972642 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -387,14 +387,21 @@ int cmd_repack(int argc,
 		if (dry_run) {
 			struct oidset_iter iter;
 			const struct object_id *oid;
 
 			oidset_iter_init(&drop_oids, &iter);
 			while ((oid = oidset_iter_next(&iter)))
 				printf("%s\n", oid_to_hex(oid));
+
+			/*
+			 * Only list the candidates to be dropped; skip
+			 * the actual repack
+			 */
+			ret = 0;
+			goto cleanup;
 		}
 	}
 
 	if (delete_redundant && repo->repository_format_precious_objects)
 		die(_("cannot delete packs in a precious-objects repo"));
 
 	die_for_incompatible_opt3(unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE), "-A",
diff --git a/t/t7706-repack-drop-filtered.sh b/t/t7706-repack-drop-filtered.sh
index cb36115834..a1c475e4ec 100755
--- a/t/t7706-repack-drop-filtered.sh
+++ b/t/t7706-repack-drop-filtered.sh
@@ -131,14 +131,33 @@ test_expect_success '--dry-run does not remove the filtered objects' '
 	git -C repo -c repack.writeBitmaps=false \
 		repack --drop-filtered --filter=blob:limit=1k --dry-run -a >out &&
 
 	# Candidate blob must still be present after a dry run.
 	git -C repo cat-file -e "$BIG"
 '
 
+test_expect_success '--dry-run leaves the pack directory untouched' '
+	BIG=$(cat big_oid) &&
+	packdir=repo/.git/objects/pack &&
+
+	for opt in "" -d
+	do
+		ls $packdir >before &&
+
+		git -C repo -c repack.writeBitmaps=false \
+			repack --drop-filtered --filter=blob:limit=1k \
+			--dry-run -a $opt >out &&
+
+		ls $packdir >after &&
+		test_cmp before after &&
+		test_grep "$BIG" out &&
+		git -C repo cat-file -e "$BIG" || return 1
+	done
+'
+
 test_expect_success '--drop-filtered removes the promisor blob locally' '
 	BIG=$(cat big_oid) &&
 	SMALL=$(cat small_oid) &&
 
 	git -C repo -c repack.writeBitmaps=false \
 		repack --drop-filtered --filter=blob:limit=1k -a &&
 
-- 
2.56.0

