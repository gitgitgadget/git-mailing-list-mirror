Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3EB43DA38
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768918206; cv=none; b=EZ+kEc/FHkwuHLt7J9b7qjEE5YX0JImoEcKb2ixh/si0Wa5PgX14LdExUoKPjctbEVA57BLJAvTH5fX19D91yWUvVgpRwd/jWYftBcrXJ1ypB+IqzCpnUNh2FQ0UofMzuOAAgqZn0rCLdFAwiJYWSsMjN2PqzlnREgLRPr96R8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768918206; c=relaxed/simple;
	bh=TTS1HZUNLaXxeD+AzW1462Qx6S95WzG8rVCEdJLtFPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSfDUwafKnvBTEp4qt7PDS4CMPeuoWrvWF0MoTpS/fMZWmp3ugXv7cB+sj5967kaV53FNWe9mNutcTpn5s62Vq60bkFLXwziTIXm+ZkGqMLLQ0gmvz4gmDE1ET45Li3EAiGTc8APlkPOoJoaXQUXevDJlin16gWtvrMOoc17Hqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2CsnDW/; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2CsnDW/"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81e8b1bdf0cso3103147b3a.3
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 06:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768918204; x=1769523004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tx1q49fWHwyfY6dlzu/Qi/pKKHUmTjZD4fMYoMgmVwY=;
        b=c2CsnDW/Pbb39/k/6PlnZbkORvRGHrMhqDeGUdUYVapOsocrf+JklDgCcKXNqybGXX
         NKsLfiGUeVbAOlvMLEQUo8hni1bUXWZD8A1c4TF4NCbkDujWqrxJVCthSiaYAoxN0RLW
         RI28w0/VR3oDHYqwAmileUpDUFhfmx5Pdoji4Cdm1A0JXRZGZGy6HlT43bd7bLG03vvC
         L8uvNP4rtTsSxhmEAmTTZKm0vSXLZHtBh+aGyVSSjQFd19YlIV51JeSeOH1qGn/Ap8Jy
         XwDtqy4xGsfFtZwcTjUwmYO1mCccmrOtcejValjHPXk6cSHSi+vAf5Al2DKzxyu5rYRH
         o+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768918204; x=1769523004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tx1q49fWHwyfY6dlzu/Qi/pKKHUmTjZD4fMYoMgmVwY=;
        b=s28wu4x/+R9a0Xz93z4XjQuXia3XL3wq0dFjp/jdj9LVYa7uSVIaNFxfYTaYg8xcpS
         Lwr3TsxjmpLPhHXzL31Uj+AL/lsw+7Vr4fMBwnuW+HmpXF77eSBqt6YPdS4OoWRCFUKT
         SgR1u50xk8pHGxUy3MNHGxJTuivznt+xi27CIna0Mws3a+WQqeyGNbiw9K2Pm0LCs82E
         6PghNHl9HnHYW6bvBK9ZcvY3CwaBOWXyPIlYhbdWHNaR1uid15GkC/uh8UX+9YbbBYmm
         2I1vZGDd3Z1gnMcMbVKbR/bHznMm9m9tcYf09M2O4OrHKiQQ2XbX8aLkCOTPTkhTYIFv
         zUzw==
X-Gm-Message-State: AOJu0Yx1qUMMoHr0UXCFn3MS6niGBp58lEJn4Oi7ts6sKfmeHQZaHDAS
	KTzoTj/TAx6OZGrVUixX+62BdZcNk7FXcRQVZAfDVmPxL2QqJcQ1JK+G5cqEBw==
X-Gm-Gg: AY/fxX5BIVUbCW//Gf5sfYFIc48jPES7dOOjjdafww09molU+iLHidqtYMPrIbMyhkE
	S2CpAFQfPl7WikgWgp50+sxYbiEo8UBzPorEkAyGW491whs63UbO1tr25iyrdC83Gz/w2futR6t
	SQnZsdwEpzq5BTbyIHbTcMviXpaEK3v8A7Erbq7eloSE7jaZdIvKtzbTvuZzQEEwbT4RMpZK/nJ
	9c/pGVq9gA4KLwO9VDRhxiINQe+vsbkr6Y3XMu+QZ96KZyev69WHtzXsQFmLg3HcqJFUBcf5IwI
	NQ2BPVaMCuzHa3D48KMmD2qgSaZkvcMqv+LT157JG+qY7pIKm/+vWI/cWCj66umy1mj1UMiIY2j
	fQp97uRR3HiDCsT6Uz0fRWnfi1rhUfw/Ag+K33yQp4SffK+2QnVZO3wWGsRK7AJwF1hLhAuTXKC
	2ByDSUr/CYqgCi1ATjo/5ahFB9VzpFgIv7nQAS+/d3jXsElGaJYoWYePo5
X-Received: by 2002:a05:6a21:6112:b0:342:1265:158f with SMTP id adf61e73a8af0-38e45e21462mr2006228637.51.1768918204116;
        Tue, 20 Jan 2026 06:10:04 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd7:6181:2062:a538:8b6f:d4b5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352d5a3ea3dsm1362250a91.3.2026.01.20.06.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 06:10:03 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH 3/3] show-index: remove global state variables
Date: Tue, 20 Jan 2026 19:35:41 +0530
Message-ID: <20260120140901.517928-4-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120140901.517928-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260120140901.517928-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Git is in the process of removing global state,
this function still relies on the global variables,
the_repository and the_hash_algo.

Remove the associated macro and the UNUSED attribute from
the repo parameter, and replace all uses of the_repository and
the_hash_algo with repo and repo->hash_algo, respectively.

This modernizes git show-index and makes it more compatible.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 builtin/show-index.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/builtin/show-index.c b/builtin/show-index.c
index a9c2f18b73..96adae14c0 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
@@ -16,7 +15,7 @@ static const char *const show_index_usage[] = {
 int cmd_show_index(int argc,
 		   const char **argv,
 		   const char *prefix,
-		   struct repository *repo UNUSED)
+		   struct repository *repo)
 {
 	int i;
 	unsigned nr;
@@ -37,7 +36,7 @@ int cmd_show_index(int argc,
 		hash_algo = hash_algo_by_name(hash_name);
 		if (hash_algo == GIT_HASH_UNKNOWN)
 			die(_("Unknown hash algorithm"));
-		repo_set_hash_algo(the_repository, hash_algo);
+		repo_set_hash_algo(repo, hash_algo);
 	}
 
 	if (fread(top_index, 2 * 4, 1, stdin) != 1)
@@ -63,7 +62,7 @@ int cmd_show_index(int argc,
 
 	/* detection of hash algorithm
 	Only works for small files, i.e without large offsets */
-	if(!the_hash_algo && version == 2) {
+	if(!repo->hash_algo && version == 2) {
 		struct stat st;
 		size_t file_base_size;
 		size_t table_size;
@@ -79,9 +78,9 @@ int cmd_show_index(int argc,
 		hash_size = size_rem / (nr + 2);
 
 		if(hash_size == GIT_SHA1_RAWSZ) {
-			repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+			repo_set_hash_algo(repo, GIT_HASH_SHA1);
 		} else if(hash_size == GIT_SHA256_RAWSZ) {
-			repo_set_hash_algo(the_repository, GIT_HASH_SHA256);
+			repo_set_hash_algo(repo, GIT_HASH_SHA256);
 		} else {
 			die(_("unable to detect hash algorithm, "
 					"use --object-format option"));
@@ -89,10 +88,10 @@ int cmd_show_index(int argc,
 	}
 
 	/* Final fallback to SHA1 */
-	if(!the_hash_algo)
-		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+	if(!repo->hash_algo)
+		repo_set_hash_algo(repo, GIT_HASH_SHA1);
 
-	hashsz = the_hash_algo->rawsz;
+	hashsz = repo->hash_algo->rawsz;
 
 	if (version == 1) {
 		for (i = 0; i < nr; i++) {
@@ -114,7 +113,7 @@ int cmd_show_index(int argc,
 		for (i = 0; i < nr; i++) {
 			if (fread(entries[i].oid.hash, hashsz, 1, stdin) != 1)
 				die(_("unable to read sha1 %u/%u"), i, nr);
-			entries[i].oid.algo = hash_algo_by_ptr(the_hash_algo);
+			entries[i].oid.algo = hash_algo_by_ptr(repo->hash_algo);
 		}
 		for (i = 0; i < nr; i++)
 			if (fread(&entries[i].crc, 4, 1, stdin) != 1)
-- 
2.52.0

