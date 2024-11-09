Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEE6145A16
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731144532; cv=none; b=QKswALpdQZZ0WS3QNrBsgPovYtM2AbRmrwHgNvGUmy6rWUXjIcrLNH4d1lyCu+Ps9AnXU5ov5AceEMpeBxt0jGToWEd8dhRCOWO+IAP0Qir3YjBdYWbZggAlZBjSUQOGF+p3enBXu7znq2stmRoHY/CNSCMmBMW4ZeHNcT4UjgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731144532; c=relaxed/simple;
	bh=95JcqyRm6z7AINnxbPC5Mb0uVpdiKWUwyIhA12+YOoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bD1vqc5hdHOa1tQp3Nh0r0y7frAC02cOZBP8xsOxLP8cCW30QSXTQvmXDEkZpKqUTxDYiMIiolmA1EMEMpFF3OD6YjOiROeW4Wj9zd6I2szqKCKMZNhdZ3EwIroKrc2KVWXYG0bWVC2KEWihuj059Hmt9cDdbEJiJiKLx2cONZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxT9YMi0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxT9YMi0"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2110a622d76so26454175ad.3
        for <git@vger.kernel.org>; Sat, 09 Nov 2024 01:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731144531; x=1731749331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtLp8/PBIi1MihOMiKYRI3aZ8QZhgLLIiwih3DcAbDg=;
        b=mxT9YMi0wqtast8qj07Y1Wg0+MltAqETdRVJXRF8Ac+RjD/WRJKqvIfJNpHr2g/VCV
         20Dj4XGMIBa40hldnCHg4pOMmkUQY7m6Rl4lMCiIiNA0W43UY1VsLxBvldwXXmnOkjFj
         FT6IXhmbvAId8ENxouSHAbW7XdvGYy1a/SybxqMPALXZVXWIfkqUhPw9iHUoAs9ZhNgj
         I5Uj1K03om0IWke+Oswr8GzpESOFtKcGdXfkWNpwFk4JD0uvXA+7VX9i+e5KU39Sf+z/
         8+fuIKn6obCBmJl0Kqy7MVlhnN8jjKzBCa9vF6sCw0F0anJgmOtiG+HrTpUGx5wEQVXg
         HxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731144531; x=1731749331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtLp8/PBIi1MihOMiKYRI3aZ8QZhgLLIiwih3DcAbDg=;
        b=AP2ThI3lYJmg5ZbNi2iKzbI10OZY4x2plNVDK/OiyB3jCsYEQBX3462fyEsYoee60K
         JzyBhSy/21ORH7+obxi5dg4Wj5dkQWagjOY5w4uxzAW120EaP53GWBuG9859pINdBeXx
         7f7XjrodblexsVzwsuSOxnbR8K1b86ru02PVu7nczWx1d+QFMwtKcPeRdQlXLVWklwag
         NXRj2F+m8aHkTv5qCDmQZPa/z/kDlawqLY9yfhHDUT3QJlMTL3SuJGRFyTUtAiJKESfG
         Vp/BHHAiEgOVWi5jR6nHMWjxZ33Mw5H6FKzJcrw6O60nSfKo+LokCM3s9lOj83Q9eFZ9
         kI5A==
X-Forwarded-Encrypted: i=1; AJvYcCWhhHyxeBIHOUEW0qq5zoZd3bvigjq809s6j/RM372hqFI2t/tXFphri/o25hqNZhuO3y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQKZyFiIxcb+BtVSNh2cSRM5Xc69RoNgZrQ+8YxRhexlnmjQ3S
	j5YuMtxSC0yNZY4u4jQnPBoBr4YBKivsNmvqMxnGE80PAwlZ3v/I
X-Google-Smtp-Source: AGHT+IGhcHFZtwgTJWfL3IFGhInDD86jQKlIqd2MKa5nUbqcVr9F51tJ3SB60U+vQjqbopTPvpMCig==
X-Received: by 2002:a17:902:dac5:b0:20c:f3cf:50e6 with SMTP id d9443c01a7336-21183d67bedmr69754975ad.38.1731144530817;
        Sat, 09 Nov 2024 01:28:50 -0800 (PST)
Received: from localhost.localdomain ([103.171.210.156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e41651sm43309455ad.134.2024.11.09.01.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 01:28:50 -0800 (PST)
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
To: gitster@pobox.com
Cc: abhijeet.nkt@gmail.com,
	git@vger.kernel.org,
	me@ttaylorr.com,
	ps@pks.im,
	sandals@crustytoothpaste.net
Subject: [PATCH v6 1/2] show-index: fix uninitialized hash function
Date: Sat,  9 Nov 2024 14:57:38 +0530
Message-ID: <20241109092739.14276-2-abhijeet.nkt@gmail.com>
X-Mailer: git-send-email 2.47.0.107.g34b6ce9b30
In-Reply-To: <20241109092739.14276-1-abhijeet.nkt@gmail.com>
References: <xmqq4j4mv5o6.fsf@gitster.g>
 <20241109092739.14276-1-abhijeet.nkt@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In c8aed5e8da (repository: stop setting SHA1 as the default object
hash), we got rid of the default hash algorithm for the_repository.
Due to this change, it is now the responsibility of the callers to set
their own default when this is not present.

As stated in the docs, show-index should use SHA1 as the default hash
algorithm when run outside a repository. Make sure this promise is
met by falling back to SHA1 when the_hash_algo is not present (i.e.
when the command is run outside a repository). Also add a test that
verifies this behavior.

Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
---
 builtin/show-index.c   | 9 +++++++++
 t/t5300-pack-object.sh | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/builtin/show-index.c b/builtin/show-index.c
index f164c01bbe..b5e337869d 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -38,6 +38,15 @@ int cmd_show_index(int argc,
 		repo_set_hash_algo(the_repository, hash_algo);
 	}
 
+	/*
+	 * Fallback to SHA1 if we are running outside of a repository.
+	 *
+	 * TODO: Figure out and implement a way to detect the hash algorithm in use by the
+	 *       the index file passed in and use that instead.
+	 */
+	if (!the_hash_algo)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	hashsz = the_hash_algo->rawsz;
 
 	if (fread(top_index, 2 * 4, 1, stdin) != 1)
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 3b9dae331a..51fed26cc4 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -523,6 +523,10 @@ test_expect_success 'index-pack --strict <pack> works in non-repo' '
 	test_path_is_file foo.idx
 '
 
+test_expect_success SHA1 'show-index works OK outside a repository' '
+	nongit git show-index <foo.idx
+'
+
 test_expect_success !PTHREADS,!FAIL_PREREQS \
 	'index-pack --threads=N or pack.threads=N warns when no pthreads' '
 	test_must_fail git index-pack --threads=2 2>err &&
-- 
2.47.0.107.g34b6ce9b30

