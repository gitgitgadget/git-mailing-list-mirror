Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01A63BFAEE
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 06:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791440745; cv=none; b=asLz0dt9sCM5F77XQLuMT+DPpsv+ESx38U/lgSX01Svfa/I1T5tiv94uHepEPCDxKi1Vn/PL94VyMzez9xRTrSI4bgxYcJlrbxJNCJO3M4Wvziv3WW+L2RoupBx3fVgSjwf97XdKqmhhF1DytFqL7s2rIeoBThJQBXixHqZAvcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791440745; c=relaxed/simple;
	bh=pVRMinSIXRnw53YDtkZq2Cu5jMsDVT96vGI7HkHBj6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HDatV+Kfi+XR8R2MB1Q5LcBEYdkDHd++cqPzHl3cnW9JK4vRCq6tbKxx3tMQYqbmT0ow50qtBVRYiKz4Gy6thHVzqdVCvx1vRRB45/xFNPuxtMpXkYSaH0Kf3qAWtUiki+JCG9R12pE+bQXeE+ahUfgagdzi6B2uyGiEtiN+nqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZf+Q+pG; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZf+Q+pG"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3515f9a5d25so3722111eec.0
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 23:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791440743; x=1792045543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9ctyAg8U0JVzf+JcQxS3Bc5SQJ2x4j5cmCrVSPQUFKw=;
        b=kZf+Q+pG1oSDYRlwHG4MRnK7YF0rcp/9jATVaQPvUteiax/FmMoQrWG+IpFg4MIclt
         5k+qjPRutIfA/UADpJthS1mhFlGdnCgTd8kJrEiw68n8f/X2L12nr3w09tBI6yD/EcXh
         754VUeedXJMYPkPE8E6jcIAis9e4ZQgTLa7UnbkqgVvjsgAELW09d7ffKbgL3AAd2nrQ
         OjYKvQmEhTf3Z4sGMovqVARcwnPEuXQlsVZbafh8VdxVGx7J80/2R4gO3MZOTW+Y3ap5
         2Hu4wAHCo+ht3bNmmCQZ8VucAJhLo3+Up8LiARrFT3Fonv5XFJt/NDNleHGhEDZr+bhs
         3hig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791440743; x=1792045543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ctyAg8U0JVzf+JcQxS3Bc5SQJ2x4j5cmCrVSPQUFKw=;
        b=N8rS3fGkkv705HexySyNHBzPycs5fw8TalCahumPzykWcxFZf+4c2dypYElfNpnifG
         bbF4HhbnB/RKC+UBet2PFESIzx9F4BHJidEDpr5CJ2arpZIvkWf5eI34DZuL+KHwr7kf
         6VRBkZL2CzxlEH5IJA2I8KbTrHjP1B1IJ2jAG6ZfJBcCXaiv6f49/mQ5Z4l6Vqw3Yvns
         dj/nZYFRGzviHdP2suvz5gUGKydR7vpt45AwypRmk88uZWmaHAVhhapt0OQF07MMFzcI
         +bulSH80xyVr6obYURaRaq1CHZVUEPOEB7KbNK9RxHy9qdHRPkbeWnf4T8b+7h9rPm96
         109A==
X-Gm-Message-State: AFuF++ls2qHvUxIhBTQ6wpxKAA8fsfX0lrCCTCTTTv4XOzDPki3xdu0I
	YYzDT2iV+4IJyq7aOQhCc2yEANdJnG7guss7zyJplyEbOWfIstGfkqlDxNhkArNP
X-Gm-Gg: AYBFou2SqOJtVO94duNBnDioIDDJxToLduxOiFzl2LZQlsikJCXxl77XK16sCG1aRw+
	fz4aLWTj86Nwq/x+S9I55SL43KoUUnxiAhHaLBNrGQBb7qivxR6Y06c1mIvPG12jUDLdmnUSmXl
	Tz9HE96fAXPThvaKihCvs23yf661VZOUAFhCFUq9BZ22dJeOk5cizCnN16nMozPMmNNpea0zta5
	hoHPjeVt3gSqM+9E5+w7XYNff1Wo01NzONZSRmusTe1Ik09ITBh3Fd3iSPJgAtBNgFXWbZKOUTD
	EVx62OefrueYSKAH44St+EFOBuC49+5OAFSzgfHYIbRQhTOhM6ZFF94UOMQ/Kq+t1aGpm0R8b0r
	/EsQx3OhBJsruw2uHibplApVLXSwfKOAHYCwopfBltPXkh96ZHZJ+RJifHngLBet0gLofxQs9iW
	MLHsQntEmPwi3iYlDZG2+begt/83qpdD8BiLAc0tPytt5M38owOffjHkMFRkASz831VnwOtgmRl
	Plm5pXX1PBv5EhVbH6XacmFG2mWQG9H1W3rflvIZxSPQDbTwg+0u1GYZT9rxboQUfFA7smEdbjM
	IA9eTBNaKdxwRne3wGp0HA==
X-Received: by 2002:a05:7301:1630:b0:339:7675:18e with SMTP id 5a478bee46e88-3515dd838d6mr5085041eec.9.1791440742757;
        Wed, 07 Oct 2026 23:25:42 -0700 (PDT)
Received: from localhost.localdomain ([112.133.247.222])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515aeb5c00sm13303149eec.8.2026.10.07.23.25.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Oct 2026 23:25:41 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: coygeek@gmail.com,
	ben.knoble@gmail.com,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH] repack: do not rebuild packs on --dry-run
Date: Thu,  8 Oct 2026 11:55:21 +0530
Message-ID: <20261008062521.25505-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.56.0
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
existing_packs_remove_redundant() deletes the old packs. The command
still exits successfully, so the user is not told that the repository
was modified.

The existing guard only skips the implied "delete_redundant = 1", so
it does not stop an explicit -d, nor the new pack from being written.

Fix it by returning right after the candidates are listed, and add a
test that checks the pack directory is unchanged with and without -d.

Reported-by: Coy Geek <coygeek@gmail.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
Bug report:
https://lore.kernel.org/git/CACgTecOm+=vbf50tZNXhcYvRi1ZTsQwbjVoJAbQqs2CmXdJCxg@mail.gmail.com/

 builtin/repack.c                |  8 ++++++++
 t/t7706-repack-drop-filtered.sh | 19 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index c4360382c1..c048053912 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -391,6 +391,14 @@ int cmd_repack(int argc,
 			oidset_iter_init(&drop_oids, &iter);
 			while ((oid = oidset_iter_next(&iter)))
 				printf("%s\n", oid_to_hex(oid));
+
+			/*
+			 * add an exit here, so that dry run does not
+			 * go on to rebuild any pack or delete anything, even
+			 * if the user explicitly asked for -d
+			 */
+			ret = 0;
+			goto cleanup;
 		}
 	}
 
diff --git a/t/t7706-repack-drop-filtered.sh b/t/t7706-repack-drop-filtered.sh
index cb36115834..a1c475e4ec 100755
--- a/t/t7706-repack-drop-filtered.sh
+++ b/t/t7706-repack-drop-filtered.sh
@@ -135,6 +135,25 @@ test_expect_success '--dry-run does not remove the filtered objects' '
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
-- 
2.56.0

