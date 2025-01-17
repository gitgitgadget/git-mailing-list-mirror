Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0434E1F9EA4
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737105693; cv=none; b=JRjtn06ERjzggIjuSfRtOWNGzgcw737hYAK1Z7kAAnbVs+ZQgfSXtnFNWIXkuWD71GnqROy7IQqUGmc31FZ0TgUUSe9hISwWwuzrdBwSHt2zeR82agfuLufC93yjIapCvKp9GVVHToo7oJy3B9KDXh3SbsGceWnMK+NogySFqlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737105693; c=relaxed/simple;
	bh=23JyOMoFwF4jiMtL4yVRFt0D3XC8k/jej3UC8iDqdWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WESZ/dK/ZJdHYAHhsim37a7dQ/jQEF/ttWXD5sOeEO/UeDBzmQkNHkWUe3KEgNr7R72I2qMY7LSJSoMDyovhWibMQA/lxivUxNTZqlFq2t8vc3ftJMI2KSGMSmfrE1K3iD4L8cgneMmInLVF91bAmmfPhEuqKwIr7EB+jS0I70M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAnEcD0o; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAnEcD0o"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21bc1512a63so37169465ad.1
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 01:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737105690; x=1737710490; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F86bRfZ0CRnEFPj1MwKkdvsCHGwQ3o0fpITygS2KPxc=;
        b=mAnEcD0ojlBFwu98hiY5cJamWADhYOV7pW2HGuq209/J2wBKPGWjY6yYJSu4q+j0Bn
         5L899a5p9oFJoWMqqBwPxsIFEWGN9Gx21LKgR//wdQCNv1hOwK22Xdi1SQmaucNuPIVB
         WLaWbWQHXcVJuJj+GS6AiHiHUmFX68d+aqV17dd71eP+PhYlB2XjJUQuwMoU4BCHKVA0
         kGjmihY9RK4EryygokyC7zGEEYzfHmWO51377xn9EsfMhk7ZHJ081V8NWBItlsgrGb44
         tLrekx7XoKq1zg0TYRGChBDOnSBL7B3jkVz8/sh+48vppi/Mc9tJMgZ/r8rTAcaQrlIH
         reoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737105690; x=1737710490;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F86bRfZ0CRnEFPj1MwKkdvsCHGwQ3o0fpITygS2KPxc=;
        b=sky2swSPaKBR5trlpCajAm1/D/naR10ZVfXFUML102GTgQMPML3a2mNTVsvtJKKvZX
         Yl71VIxGhjdx28nyYBG/4WjNE7ni55PeB67NjZd4+Ons4kmZWPxNMxHoDJAmzGWXfNaa
         ApLH86FTL4b0tL4ysXmQYjG2K47EPE4+8qvyrxR3NYTJd/RKqLzbnXNgbffqYeupKOGk
         enE8O+mVFKiw6ocIKXZmQNAy1zEnUpXazdx62y8RgHFZV/7gdwYOK05qPaUPWLPhKelm
         2BSRYFgbH2zxrFQBO6gm9iSADREkgmI2ZIdwmmW8Ab70/iEY1uRm0N67K1HJUTOWEggQ
         vrPw==
X-Gm-Message-State: AOJu0YzidY8Oy00MkrJfUed7UavudcS2yI34WYGXXZ//rx9vbxf+2Y0C
	TaLGxiQNBH/9gXuuDuSqPTVAHvwxa5LoLw3oJKDdxHWP7SCndh3rBmf85igr
X-Gm-Gg: ASbGnctX5NSYR6+we8DEz8QzsZo9FF2W6r1MxfAK0KXZe1o4aL9uhOlckhVJxBgnX/+
	c/YBKNSWkYs6uGvZFRfV9eCDYiplmPtwz1sFBf6d4dwCTXVX3ff78tnFAAuoQsqbyXoKXx1Qn8C
	oMBmPL+nIjA3FwqvWqfnnym5r2jM0QRzjNLTtm6zh5iVmJbXvvyLY1W+gOEV+JD3QTAPTZzN3ij
	uvAs6xUEJPlnqFYPrkyjXizVKE+xFz6KVZQQM/EcOmgPUwaszyyfsfnXTI=
X-Google-Smtp-Source: AGHT+IHBq5jBQTl2XkrBMXVNhVcNAVx89WYSsu85yjYT5t2UMSKfhqsJSqvWINjPMJk/gUybO0TvTA==
X-Received: by 2002:a17:902:d492:b0:216:1543:195e with SMTP id d9443c01a7336-21c3553b227mr31320065ad.5.1737105690255;
        Fri, 17 Jan 2025 01:21:30 -0800 (PST)
Received: from [127.0.0.2] ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3e088bsm11714065ad.173.2025.01.17.01.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 01:21:29 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 17 Jan 2025 10:20:52 +0100
Subject: [PATCH v2 5/5] pack-write: pass hash_algo to internal functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-kn-the-repo-cleanup-v2-5-a7fdc19688f5@gmail.com>
References: <20250117-kn-the-repo-cleanup-v2-0-a7fdc19688f5@gmail.com>
In-Reply-To: <20250117-kn-the-repo-cleanup-v2-0-a7fdc19688f5@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3750; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=23JyOMoFwF4jiMtL4yVRFt0D3XC8k/jej3UC8iDqdWI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeKIQgQjCdjEP5Q9aZoXbQwrSqb+bG5CJtmL
 aghk66vonDotokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJniiEIAAoJED7VnySO
 Rox/cRYL/iC1vLVWiFGE69b6+SORJrpucJprZn07SQsB5K88YnkeXmUrEvXvuwVjS9B3fVl/npb
 FjutIUP+xrc7sSK1up/Y8A1HojLwINrfDM0POypdu3pZDM6ID8R5AxEfTERg+yiJVVoHznzmGWh
 Euk8W2dQoXDlgdYIpxJAz3cJBe1AlE/WroiSA6Y7bBYPXNdD5R+uwGFANce0oOgFk9BI2ByaYmF
 DxelSRIY7t7ft3lR9761gRID0yWnEUlONfHiW4q+LSdLrWfENXiQ5agjRNrVFpk9UzDShYm8Gfo
 47SDlkD1/Vts48M2kRxcNv7KoAxFIC0MrDM5/pVBc+1tphbi2dAVmQ/bEzsrY95+4fRXFuZL38r
 mZa5at3kwEI96VmS7p/Ac1Iw2jClTqenttOi0n+viWZo52N5jF4dNub48NM34mdtiTMNVipixNT
 uwEFGhLv+v972LUhZzm+piBqNNK7vtaTItABhJoJB2gL5xqyh+MemrLd/pW4zV9Ai/vx1gcs2f5
 S0=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The internal functions `write_rev_trailer()`, `write_rev_trailer()`,
`write_mtimes_header()` and write_mtimes_trailer()` use the global
`the_hash_algo` variable to access the repository's hash function. Pass
the hash from down as we've added made them available in the previous
few commits.

This removes all global variables from the 'pack-write.c' file, so
remove the 'USE_THE_REPOSITORY_VARIABLE' macro.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 pack-write.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index 09ecbcdb069cc9b0383295798ceb49cbdc632b64..a2faeb1895e41f4c17281380478f1f2cabcc6f24 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
@@ -211,9 +209,10 @@ static void write_rev_index_positions(struct hashfile *f,
 		hashwrite_be32(f, pack_order[i]);
 }
 
-static void write_rev_trailer(struct hashfile *f, const unsigned char *hash)
+static void write_rev_trailer(const struct git_hash_algo *hash_algo,
+			      struct hashfile *f, const unsigned char *hash)
 {
-	hashwrite(f, hash, the_hash_algo->rawsz);
+	hashwrite(f, hash, hash_algo->rawsz);
 }
 
 char *write_rev_file(const struct git_hash_algo *hash_algo,
@@ -286,7 +285,7 @@ char *write_rev_file_order(const struct git_hash_algo *hash_algo,
 	write_rev_header(hash_algo, f);
 
 	write_rev_index_positions(f, pack_order, nr_objects);
-	write_rev_trailer(f, hash);
+	write_rev_trailer(hash_algo, f, hash);
 
 	if (adjust_shared_perm(path) < 0)
 		die(_("failed to make %s readable"), path);
@@ -298,11 +297,12 @@ char *write_rev_file_order(const struct git_hash_algo *hash_algo,
 	return path;
 }
 
-static void write_mtimes_header(struct hashfile *f)
+static void write_mtimes_header(const struct git_hash_algo *hash_algo,
+				struct hashfile *f)
 {
 	hashwrite_be32(f, MTIMES_SIGNATURE);
 	hashwrite_be32(f, MTIMES_VERSION);
-	hashwrite_be32(f, oid_version(the_hash_algo));
+	hashwrite_be32(f, oid_version(hash_algo));
 }
 
 /*
@@ -322,12 +322,14 @@ static void write_mtimes_objects(struct hashfile *f,
 	}
 }
 
-static void write_mtimes_trailer(struct hashfile *f, const unsigned char *hash)
+static void write_mtimes_trailer(const struct git_hash_algo *hash_algo,
+				 struct hashfile *f, const unsigned char *hash)
 {
-	hashwrite(f, hash, the_hash_algo->rawsz);
+	hashwrite(f, hash, hash_algo->rawsz);
 }
 
-static char *write_mtimes_file(struct packing_data *to_pack,
+static char *write_mtimes_file(const struct git_hash_algo *hash_algo,
+			       struct packing_data *to_pack,
 			       struct pack_idx_entry **objects,
 			       uint32_t nr_objects,
 			       const unsigned char *hash)
@@ -344,9 +346,9 @@ static char *write_mtimes_file(struct packing_data *to_pack,
 	mtimes_name = strbuf_detach(&tmp_file, NULL);
 	f = hashfd(fd, mtimes_name);
 
-	write_mtimes_header(f);
+	write_mtimes_header(hash_algo, f);
 	write_mtimes_objects(f, to_pack, objects, nr_objects);
-	write_mtimes_trailer(f, hash);
+	write_mtimes_trailer(hash_algo, f, hash);
 
 	if (adjust_shared_perm(mtimes_name) < 0)
 		die(_("failed to make %s readable"), mtimes_name);
@@ -575,8 +577,8 @@ void stage_tmp_packfiles(const struct git_hash_algo *hash_algo,
 				      hash, pack_idx_opts->flags);
 
 	if (pack_idx_opts->flags & WRITE_MTIMES) {
-		mtimes_tmp_name = write_mtimes_file(to_pack, written_list,
-						    nr_written,
+		mtimes_tmp_name = write_mtimes_file(hash_algo, to_pack,
+						    written_list, nr_written,
 						    hash);
 	}
 

-- 
2.47.0

