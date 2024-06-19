Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C225415B548
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 21:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718834301; cv=none; b=hW8qfPFxVPvPVnuBQ7k9WCrcZaYfG5rJNwLNErwGpt50KvG3WBmG7L3Tg6BITW5bzH6TJ4moC8cMd0jPwCAr5mt45gRcTx4xqrxV2GGgsRJtiFaQ+fbQ7wV39WDerI81Y45PK2kvvO6zxvaK1elkn42zaruFK9vXdN3SqOdt7gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718834301; c=relaxed/simple;
	bh=U8YRz38tNmhXPCtXr6gaVQCbE+KH6Ev6o5SnhomDvJY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=k7xno33Jg/2prC+DZ6yclO5CGzIUKIDiTTtZf6Qg/hTr1Q2mMi2BW5xhuXeWNFW3nS4ewWNj8b81b2TYtxhjxEoRCyX26QDkEspU6NVz5Vr2JHXfjzG+PTVHTyCWDE8RYNW4nzANBc1zGk+52GliucWnWiA4ZOHRy90wqRvPl1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXqX/Uiq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXqX/Uiq"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-424798859dfso2942695e9.0
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 14:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718834298; x=1719439098; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pk3GXljznJKO3UKj+ovA2jMmmR2uuECc9hf2eayVXio=;
        b=RXqX/UiqUjuH0uwadGYTG5Nzt2Pyi+rTRb1EI6f7VU7yR9qr7W+jUUXwsjN3Nrl7UY
         Wbv85K6QYfJgzA12kn/VUqw1zGHCCGk/f/Vwt4sNNgcE2/fZu4resCWuiwE3oXzcWyCl
         AMbVPCkMGK24AfezkO/VPif/ZtEEh9kV58cRsOUhuHfkt2FoCXrfjQKo30ao4w6YSxxp
         ejEEEdAgm6QHV2mfY7DyUGVPugBaOI5hvdvWiZka9LLAkTdzpIhK8H5eCBrWDn7JOsKs
         71/sefoZm98dntCbboEy4vOZXyXHY3rLisHF9IRYmfSyuPHU8HL3hIf+oMFonf3M+lK0
         Oe+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718834298; x=1719439098;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pk3GXljznJKO3UKj+ovA2jMmmR2uuECc9hf2eayVXio=;
        b=rPzIRacIgAwYeXaEmgCwwkZxBYt9KZDrLwaArOp6dBmHmvb6MX8Kb62969YCpuQEpJ
         qX0NDdUwKTp5227BVpphxfr48ZwshlJPqlkyWEV1s2ycmf6peG6bP7yvyiIugGq/RtRr
         uzfYgmRiB0hYucahPKG8m2vB+Mr6X47/gK6z+AVF+/TTWPxrwibYzL48KpoQKE+cw84V
         oY9rSSS88t7W5umTN/k8PfEDEyasP6fERAUzJvohTGthvIfzVK1tZ7xIwoEeeB6Bmo3u
         ZRrVnkKiNrFM/JVUtFA/EUdv21EKhzP9ykkyWwRTIBpn46rJX9QtCPBBs5pq15toqumJ
         Ixzw==
X-Gm-Message-State: AOJu0YyccRXnhhz1YHppPgTKn1Ax0+YqN61lO7we1uvk8gHt4YPWCxxK
	ZXIIeQTjtuz65WEAkTJjxP9CJBNcugTm1wPiYuSdIedIbMTcQpPZW3LtjA==
X-Google-Smtp-Source: AGHT+IEglAy02YzYC8BAnLqYKI1I5Y4CuzJdp7Rr2bZsqpGi3xo8ZPB3E+6lVNjjCLXVmxgTW6wMYQ==
X-Received: by 2002:a05:600c:47d1:b0:422:8c48:9908 with SMTP id 5b1f17b1804b1-42475176660mr29057095e9.16.1718834297648;
        Wed, 19 Jun 2024 14:58:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c0b33sm3767025e9.11.2024.06.19.14.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 14:58:17 -0700 (PDT)
Message-Id: <8a3264afd0c072d10ec0571e2038f009733c4de5.1718834285.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 21:57:56 +0000
Subject: [PATCH v2 08/17] mktree.c: do not fail on mismatched submodule type
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Adjust the 'git mktree' tree entry intake logic to no longer fail if an OID
specified with a S_IFGITLINK mode exists in the current repository's object
database with a different type.

While this scenario likely represents a mistake by the user, submodule OIDs
are not validated as part of object writes or in 'git fsck'. In other
commands, any object info would be ignored if such an OID was found in the
current repository with a different type.

Since this check is not needed to avoid creation of a corrupt tree, let's
remove it and make 'git mktree' less opinionated as a result.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/mktree.c  | 58 ++++++++++++++++++++++-------------------------
 t/t1010-mktree.sh | 18 ++++++---------
 2 files changed, 34 insertions(+), 42 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 03a9899bc11..f509ed1a81f 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -107,8 +107,6 @@ static int mktree_line(unsigned int mode, struct object_id *oid,
 {
 	struct mktree_line_data *data = cbdata;
 	enum object_type mode_type = object_type(mode);
-	struct object_info oi = OBJECT_INFO_INIT;
-	enum object_type parsed_obj_type;
 
 	if (stage)
 		die(_("path '%s' is unmerged"), path);
@@ -117,36 +115,34 @@ static int mktree_line(unsigned int mode, struct object_id *oid,
 		die("object type (%s) doesn't match mode type (%s)",
 		    type_name(obj_type), type_name(mode_type));
 
-	oi.typep = &parsed_obj_type;
-
-	if (oid_object_info_extended(the_repository, oid, &oi,
-				     OBJECT_INFO_LOOKUP_REPLACE |
+	if (!S_ISGITLINK(mode)) {
+		struct object_info oi = OBJECT_INFO_INIT;
+		enum object_type parsed_obj_type;
+		unsigned int flags = OBJECT_INFO_LOOKUP_REPLACE |
 				     OBJECT_INFO_QUICK |
-				     OBJECT_INFO_SKIP_FETCH_OBJECT) < 0)
-		parsed_obj_type = -1;
-
-	if (parsed_obj_type < 0) {
-		/*
-		 * There are two conditions where the object being missing
-		 * is acceptable:
-		 *
-		 * - We're explicitly allowing it with --missing.
-		 * - The object is a submodule, which we wouldn't expect to
-		 *   be in this repo anyway.
-		 *
-		 * If neither condition is met, die().
-		 */
-		if (!data->allow_missing && !S_ISGITLINK(mode))
-			die("entry '%s' object %s is unavailable", path, oid_to_hex(oid));
-
-	} else if (parsed_obj_type != mode_type) {
-		/*
-		 * The object exists but is of the wrong type.
-		 * This is a problem regardless of allow_missing
-		 * because the new tree entry will never be correct.
-		 */
-		die("entry '%s' object %s is a %s but specified type was (%s)",
-		    path, oid_to_hex(oid), type_name(parsed_obj_type), type_name(mode_type));
+				     OBJECT_INFO_SKIP_FETCH_OBJECT;
+
+		oi.typep = &parsed_obj_type;
+
+		if (oid_object_info_extended(the_repository, oid, &oi, flags) < 0) {
+			/*
+			 * If the object is missing and we aren't explicitly
+			 * allowing missing objects, die(). Otherwise, continue
+			 * without error.
+			 */
+			if (!data->allow_missing)
+				die("entry '%s' object %s is unavailable", path,
+				    oid_to_hex(oid));
+		} else if (parsed_obj_type != mode_type) {
+			/*
+			 * The object exists but is of the wrong type.
+			 * This is a problem regardless of allow_missing
+			 * because the new tree entry will never be correct.
+			 */
+			die("entry '%s' object %s is a %s but specified type was (%s)",
+			    path, oid_to_hex(oid), type_name(parsed_obj_type),
+			    type_name(mode_type));
+		}
 	}
 
 	append_to_tree(mode, oid, path, data->arr);
diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index 649842fa27c..48fc532e7af 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -71,17 +71,13 @@ test_expect_success 'allow missing object with --missing' '
 '
 
 test_expect_success 'mktree with invalid submodule OIDs' '
-	# non-existent OID - ok
-	printf "160000 commit $(test_oid numeric)\tA\n" >in &&
-	git mktree <in >tree.actual &&
-	git ls-tree $(cat tree.actual) >actual &&
-	test_cmp in actual &&
-
-	# existing OID, wrong type - error
-	tree_oid="$(cat tree)" &&
-	printf "160000 commit $tree_oid\tA" |
-	test_must_fail git mktree 2>err &&
-	test_grep "object $tree_oid is a tree but specified type was (commit)" err
+	for oid in "$(test_oid numeric)" "$(cat tree)"
+	do
+		printf "160000 commit $oid\tA\n" >in &&
+		git mktree <in >tree.actual &&
+		git ls-tree $(cat tree.actual) >actual &&
+		test_cmp in actual || return 1
+	done
 '
 
 test_expect_success 'mktree refuses to read ls-tree -r output (1)' '
-- 
gitgitgadget

