Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD8E2FB610
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 22:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765321115; cv=none; b=prtyPZlYSImaVuNrIGGZPKJYG5C9VKlGzmy7enFo4YLMxQ1zLJ+dKB/bL/FDLK8P6uLmOy3yaeTL/v9AYde4xqXw0KyPJCyATyDddagJsK5KzIWXjjYAyqbIZTcU9DkBPhy32ap5W0BUqb4t19pw/6oHutKw36a7nKHGyG6HFuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765321115; c=relaxed/simple;
	bh=YXVTgRFYs2VqQfCDatzFXCQhStDsiIkzOISTxaulGlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U78U3z52E4HXL1gKM9AOAQPavlfCQd/pPj0pZEQVkBjanCrviW5Jx3TZDdFxtAz3BwftBVsC+A5EHJae0lj37sqcxbxVkhH3R2KLaTBwaz+Ym8aR9CFGVgxZYfEHUYKAeghB3eqxN4cRPl/cMZ18piv4HHCvbLjMIQx3ZCMRiaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRd9usrW; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRd9usrW"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-44ffaeda17fso2952567b6e.1
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 14:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765321112; x=1765925912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eufKSjKJm9zSqsWgf2Lae1S151cLzSRb7W7gUQsusOg=;
        b=cRd9usrWpaMtHAC+C18EqDejVD+Mz1DcLGYc6vagpFGoN8/bL2SiLwBC8pt/juSRV+
         MNVA6J/quTeZOQvHpuCcycl+EeugyDX/hY03M77iAMkhWWVwUJ7T2kGOlsXAzaWXm90m
         uMA2noBnUpZGiRc4vYNqKKBx/ZtlgOZ5zSamkTMdIMdZoNk1OxfKnh56iXLfMs5kf5xm
         u2gXedV5b4m0Xvx+P3uIDC9lfc9tIpw2IWunxpQ6UsNYNUzKWLAmQRymjW6N9SueKeyX
         kXrvbxlPitvQi6Rh3B+ipjK2xB9x8kOkPHe6kLuY6GtggTVoYrOq8g8cFdaT/k1XFKl6
         UuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765321112; x=1765925912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eufKSjKJm9zSqsWgf2Lae1S151cLzSRb7W7gUQsusOg=;
        b=p4rH19d6aNpZCJN5zsBepd62mNhrxgMDbKS3OSq4C1QVnhXCcLz2IF5F+mEsCeJe5z
         uWy/1zfe+XPwsD3/KLrTVdEH3QpIMCgzRnbV2DcrS8S03a863NsmFRGj3L9+V8yuNus4
         9n2FBN5ekbx/v49K38ycIgtDtFeLJBdBXArOznCP3HFBgFsoesNFTZYFYVXnmjHaEuBr
         xIj+aCLtkqjaZjSV5+IoaqwqRVmYcIMdKwMMfY9Sr/5RKhF1kG0Yz6hKvAnVp1/zjvKI
         jKeyXungXhkVkgswBov04wh4gwKv0Q+lCb8dnZBKgLO3Kc5w4/t6cTq/fp3/aXEq8ED1
         YwgQ==
X-Gm-Message-State: AOJu0YwzmBTFXH6rh6qs1phinVIntnjbFs3ifxII/QIMI0+/+GJPjORF
	1ksMwT64MmF3veT2sMn2GAGyVvBCmwf87SaZk/BcwNwNThN3bAvdGqlK7IDQEg==
X-Gm-Gg: ASbGncul9VVZqdBTTfm4BQOPx9lH5NTofaKAWtQHL+g0P19fksnhgB+jZqcFTNfImqr
	TIHe06VaZN0GBxYngiIBOZzT0z27W+wGLLlJbdm7ywEBH4mG/WxWZiJNikKRuVnvTPHlfL/GS5G
	Wy+F+IrNPIc9edwBl/lk5prW450JfOGf9e5bpKxQrc1mNf1gdf/t/YqsTnH3R9H9ZcCEAm2jGLH
	Nr85/SaBnE1H81DqTv0dom6KSsu9UaL0B0/Tsn3sSQEEwisHFbW3mib70vdE5Q3+qNK7mj73Q3E
	Uf0sN5ZLZTmamI3BBrBRvaEmr+/NwPbLuIrRYcMv4LJIqHeHE490dmj/w2QP7ljH9JefWnvySsq
	eFcfOYScj1NBj852sKjdzzz+xIx/VYp1nEYY8wY0/ZVQXcu6Urjqt5vUX4zvcomFMxzFJaxXIe8
	l7kXhLCjoof0cogksrKBY=
X-Google-Smtp-Source: AGHT+IEzR6MnwW1f3NOEJe1hWoRin4Xim/y6Yp9674gIJ49yjqv3oqaOat+hqMcIDVq5eODmCDFTyQ==
X-Received: by 2002:a05:6808:1581:b0:453:7530:8adb with SMTP id 5614622812f47-455865e8371mr349993b6e.20.1765321112218;
        Tue, 09 Dec 2025 14:58:32 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4537f8a02desm8161354b6e.5.2025.12.09.14.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 14:58:31 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 6/6] builtin/repo: add object disk size info to structure table
Date: Tue,  9 Dec 2025 16:58:20 -0600
Message-ID: <20251209225820.2861276-7-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251209225820.2861276-1-jltobler@gmail.com>
References: <20251209225820.2861276-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to a prior commit, update the table output format for the
git-repo(1) structure commdn to display the total object disk usage by
object type.

Since disk size may vary between platforms, tests do not validate actual
values and only check that size info is printed in an empty repository.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/repo.c            | 13 +++++++++++++
 t/t1901-repo-structure.sh | 19 ++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 8ea7c9b24f..8ddefd523e 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -371,6 +371,7 @@ static void stats_table_setup_structure(struct stats_table *table,
 	struct ref_stats *refs = &stats->refs;
 	size_t inflated_object_total;
 	size_t object_count_total;
+	size_t disk_object_total;
 	size_t ref_total;
 
 	ref_total = get_total_reference_count(refs);
@@ -405,6 +406,18 @@ static void stats_table_setup_structure(struct stats_table *table,
 			      "    * %s", _("Blobs"));
 	stats_table_size_addf(table, objects->inflated_sizes.tags,
 			      "    * %s", _("Tags"));
+
+	disk_object_total = get_total_object_values(&objects->disk_sizes);
+	stats_table_size_addf(table, disk_object_total,
+			      "  * %s", _("Disk size"));
+	stats_table_size_addf(table, objects->disk_sizes.commits,
+			      "    * %s", _("Commits"));
+	stats_table_size_addf(table, objects->disk_sizes.trees,
+			      "    * %s", _("Trees"));
+	stats_table_size_addf(table, objects->disk_sizes.blobs,
+			      "    * %s", _("Blobs"));
+	stats_table_size_addf(table, objects->disk_sizes.tags,
+			      "    * %s", _("Tags"));
 }
 
 static void stats_table_print_structure(const struct stats_table *table)
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index a98c651f1d..51820cc3f6 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -4,6 +4,15 @@ test_description='test git repo structure'
 
 . ./test-lib.sh
 
+strip_object_disk_usage() {
+	awk '
+		/^\|   \* Disk size/ { skip=1; next }
+		skip && /^\|     \* / { next }
+		skip && !/^\|     \* / { skip=0 }
+		{ print }
+	' $1
+}
+
 test_expect_success 'empty repository' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
@@ -30,6 +39,11 @@ test_expect_success 'empty repository' '
 		|     * Trees          |    0 B |
 		|     * Blobs          |    0 B |
 		|     * Tags           |    0 B |
+		|   * Disk size        |    0 B |
+		|     * Commits        |    0 B |
+		|     * Trees          |    0 B |
+		|     * Blobs          |    0 B |
+		|     * Tags           |    0 B |
 		EOF
 
 		git repo structure >out 2>err &&
@@ -107,7 +121,10 @@ test_expect_success SHA1 'repository with references and objects' '
 		|     * Tags           |    132 B   |
 		EOF
 
-		git repo structure >out 2>err &&
+		git repo structure >out.raw 2>err &&
+
+		# Skip object disk sizes due to platform variance.
+		strip_object_disk_usage out.raw >out &&
 
 		test_cmp expect out &&
 		test_line_count = 0 err
-- 
2.52.0.209.ge85ae279b0

