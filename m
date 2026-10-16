Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCB444724D
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 19:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792178038; cv=none; b=k2Ws+lTcxU+r0ndc0Ya/X0DdfZxuxr/kubzV4IBy78Qa0WQ9evWjoEgHPA8p1eTOeeTqVxYnGmheyqkUZApSIMug4dg+rAyap4wDGDaYnzxBF3chZjB+p5chqPLx8PFntFVOSGx2YBRINv7hxnP2gcW9LRbEwFyhAQnzFoT2dsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792178038; c=relaxed/simple;
	bh=PTUIkc99b34/9dyqyxxoF8kN9m8G4bgMU7VfQKQ7lEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r88MAoKYaO1/Ht1b+QZj0Ny43v1uFetQzeq/BjOM+qIqFPJgROqloGrz52Ak1oISgwfomUp1p1lJxyWWFXXL3QRJafcDZeJxFozi8uMbFhgxhLKsXokIBHXdXijicHHPisiHc0T87MY8+OCBUOOxZiyFxw9ISD2LbuJejZy1B7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ep/nJhXv; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ep/nJhXv"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-354ba08cfd1so312841eec.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 12:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792178036; x=1792782836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NEesEdIxGkF/SjzIBIQ4fddIQ2QDNPjv5QCvmyCokzk=;
        b=ep/nJhXvuTZq31vnNJsU+M/GXbIZTbgbg7oHr6PmAyRGRdxlwAapG1vxzuamNEHHZn
         aXPoUApArVh7qDyFqG3vulsM7EafwsOObeeMiZwbbUzDwiQuMSFPbis63kevCfJ/x4qG
         Xeu5HX8NtE491W4h7jxc3bswgIStfZdTE5/sPVnmRvjlQ3PPxaiVT007U5CpncyZl9JH
         4uEeCvd2Ul6eLbydME6ac0OUGalWXDJYG7ZDVgY8x5Ry/s8hC5EWWoINQL84dv5XZ97R
         Xl+9cQKedr2UKfQAsITpBON3RUxJyLUqq4a7JX/sjCGg9p0eP8U3ijvMW7U5UUTPwyYy
         N86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792178036; x=1792782836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NEesEdIxGkF/SjzIBIQ4fddIQ2QDNPjv5QCvmyCokzk=;
        b=r894g3IkfZohj6aFUFojcrJJ5ar7FsDx0cwtZ/KuW6XXJdSaQYGVglAlOV7+uSgtU5
         kUNj0u3Rr+s7JO4DHDtLeyTvCP3wpegxzuI6VR0y5xxBrWrHL9QRU16Trg5B+b7eK7SA
         k1Krhvzsju4pBnzHSzS+e8I3AK/N1D2RxzuxkcGvGSqliZMmb8BOBxIALZ8BOFcoQOWn
         7LXXEb+Zt9bs9APidKymHwtq14+o4FtXMOTT5GrFArAfxhsBB5APMqjTjnWYwpBeq3FS
         gA9a2Toc8sphHIIAUlWZYk68/g/sNQfpadVno/xgLnp8oofGwiZ1ZPN19CDGFM0gcLQa
         dpSQ==
X-Gm-Message-State: AFq9FYIBzu1rZGTohw+HWS8dcZXl5Hw9tBmrvNwVO1WR03FGaqHlxhMi
	ytaMtMx4kxClqhKEnbbYWcpm9yg42LLbZ/kpxCiyM4H4AieTR0NKn1UdHxIYtiSh
X-Gm-Gg: AYBFou38XlhCCgjcynPvCdBJGLEcHIO8li8Zg7zNRYt4KHNWaIUVKnBbP3HxdGxk5vN
	Mp1n+CX7jnQ2RyTKDRHjLk1RD/FAm5IoVkNYmo2QXn83ARiI6U9TyfodfHqBlRNWNrUiPw96lc8
	vlGwgE1T02RpiVynCwOCKfuZezYvzP2nRSLUB6Vq0nXuM+VebAKubuh8sIepRQtwU4qlEwKBkc0
	Vf+CgJvGujHtiX05B9lq3f7MexgQ2MdpRZxnSwAAvMGh4yndtZxwVx5/xKTBiDynkm7lKGxS3n2
	BqBWDgNW9Taxby9gozGME5i3w5pLb9bmx6c2KANxURV0/Or/TrnOJ5D4CyttQdNlldgXxWFwwkP
	wQaqyyaQTX8lRAFvr/GXyI4s51mY82p4Brf1HKcCusGJEc6igcBf4PCmIn+t04PdRq4FIjjnoZy
	b8LowWHisZGVwm/h4wfzPWZ2swhCViJAedpi7iFlkbbE69mQMr5ZXlv7ZKxVWYHyMN1d6htacHr
	pd7w0yQDgZ8pIOuR6diQAzJ7v+5F7Mr9wZGHALD0q6QrciduY8Afggqr3KaRU7ULSeDJg7+WV39
	ZirJw3DzfJHREwoehcoHNa8XTIR8QAPTJhKsmA==
X-Received: by 2002:a05:693c:88d0:10b0:35d:ea6f:b85e with SMTP id 5a478bee46e88-3619e926239mr987259eec.1.1792178036212;
        Fri, 16 Oct 2026 12:13:56 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:88f9:b0ab:e43e:bb3c:ae38:ba89])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081ab80f9sm14106117eec.12.2026.10.16.12.13.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 12:13:55 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: coygeek@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	ps@pks.im,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH v3] repack: do not rebuild packs on --dry-run
Date: Sat, 17 Oct 2026 00:43:44 +0530
Message-ID: <20261016191344.82688-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261010210050.76064-1-r.siddharth.shrimali@gmail.com>
References: <20261010210050.76064-1-r.siddharth.shrimali@gmail.com>
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

A dry run can no longer get past that point, so the two "!dry_run"
checks that tried to keep it from deleting or dropping anything are
now redundant.

Reported-by: Coy Geek <coygeek@gmail.com>
Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
Bug report:
https://lore.kernel.org/git/CACgTecOm+=vbf50tZNXhcYvRi1ZTsQwbjVoJAbQqs2CmXdJCxg@mail.gmail.com/

Changes since v2:
 - dropped the "!dry_run" checks around the implied -d and the
   repack_promisor_objects() call, which the early return made
   redundant

 builtin/repack.c                | 14 ++++++++++----
 t/t7706-repack-drop-filtered.sh | 19 +++++++++++++++++++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index c4360382c1..19894804f0 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -347,18 +347,17 @@ int cmd_repack(int argc,
 		}
 
 		write_bitmaps = 0;
 
 		/*
 		 * Dropping objects means rebuilding the promisor packs
 		 * without them and then removing the old packs, so the
-		 * redundant packs must be deleted. Imply -d on a real run.
+		 * redundant packs must be deleted. Imply -d.
 		 */
-		if (!dry_run)
-			delete_redundant = 1;
+		delete_redundant = 1;
 
 		ret = enumerate_promisor_blobs(repo, &po_args.filter_options, &drop_oids);
 
 		if (ret)
 			goto cleanup;
 
 		/*
@@ -387,14 +386,21 @@ int cmd_repack(int argc,
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
@@ -501,15 +507,15 @@ int cmd_repack(int argc,
 			strvec_push(&cmd.args, "--write-bitmap-index-quiet");
 	}
 	if (use_delta_islands)
 		strvec_push(&cmd.args, "--delta-islands");
 
 	if (pack_everything & ALL_INTO_ONE) {
 		repack_promisor_objects(repo, &po_args, &names, packtmp,
-			(drop_filtered && !dry_run) ? &drop_oids : NULL);
+			drop_filtered ? &drop_oids : NULL);
 
 		if (existing_packs_has_non_kept(&existing) &&
 		    delete_redundant &&
 		    !(pack_everything & PACK_CRUFT)) {
 			for_each_string_list_item(item, &names) {
 				strvec_pushf(&cmd.args, "--keep-pack=%s-%s.pack",
 					     packtmp_name, item->string);
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

