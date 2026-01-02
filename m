Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAE9316199
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 18:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767379951; cv=none; b=ekHWBiGw4/q9kGjH7Ve9rS1dth20qnYk+CrQyI6Ekx97WuswjIMApKnvHXotDtMBANVs4PY6DjofWEXM9Cd7swAbWxK8qfGzz2ksptPQbQrB83Uct3KM3urQ2B0K3E9szHxr4G8pwSsHvDPdd41uPEuJ6oVJ2u0hFG0ES1RHAf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767379951; c=relaxed/simple;
	bh=LHQITH9qzxxsLEZPz3kFV6rFLAXUqHxHlv/PSIPgQu8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VPHB85nPuNaRa3E122Fte8BOBsStljFvk0Q6SAYo4vn978aCEH5W5aa+eWSv8egTClN+gyVBJ2jr6tu50gW9fpsme9rsrJ9ta34keVYolvqsgEIvmgT3O9UzOrglyKGUb5JkIVGX3XnTf/ABEZwlqstxi/eAWrObIGMy+/MWQCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bffJKSH6; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bffJKSH6"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a0833b5aeeso167176295ad.1
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 10:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767379948; x=1767984748; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMzDubryhq9ebzLzowGeFhRwtqUqTQ6XLhyowv6K8ig=;
        b=bffJKSH6gAbfQB7VAHs25H3qpJeI+kqxJAKpu/i5priysXn8MxNc9hsp5xw3nMmXx7
         kKE+V8sHP4pNPQuHbOyqWsf5z6Ih5crE3CS0pGZ79Esx1N1/cNzOLDAmCIncKydyHsuf
         SMYnk67QQWyXTun9c8IkjY7kVIZ1FtOXh79OR/TOipJ4yG2b0ZbqEUxJ4dCfKg7AxS7v
         HwVYuyPSlhLC8w5x3LqT9awaN9cmgGF3g3qx6DImCh94mgNxX2UIMtOLLokUMDPeyYT1
         ZUVe/L0ycsdvgiSFG/Pn0uA8YFeR7sTcPwO4tJqKXiMn0YSYsO8HFRw9ZMsJZxmsgC88
         ZC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767379948; x=1767984748;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HMzDubryhq9ebzLzowGeFhRwtqUqTQ6XLhyowv6K8ig=;
        b=oHOb8C3DfbSHm7Jx8/8Krp/zyhmc4VaB8sH7ogWF9ityno/zkG3druMFXxY75eHsl/
         vn7WS3IqJA7UrgFMexVV4E4cs3CICksWSbWWQkmG28nB895uPsx2HdLgieVY44PUfWh6
         XsAxxd8yl6o3HqC4Uj6TiOsy8aBH8QBsfYTxhT9kXDyhJuXGFzBSQmTFJIrSojoq6Oyn
         /m50tqXg2jdX2muh0hfOZR4gdnkG6meXlVW11I8RFVVLez+KdR4AMQJRQL3b5F64J9yX
         0rdjkSC94lUaxmihTMiGNjQANUxLuuyHygVHcKxoDslhKYEaiIv4EZs73R/CMoY+LwfU
         uNYg==
X-Gm-Message-State: AOJu0YwSALYCLYXbj1Kb+JokhUWjQJiu6b8ij74T3yf3cOlgqDbME/9j
	ni5yqyVf8J8llpxSXrtPO0TL5ywB8Jm3uGOeOZWknyissfXZkIpnt9yGaEGRBAVq
X-Gm-Gg: AY/fxX6yBgPah79ZzpVtPOZMLLHRmtARX7bJXJby32XKbtPGzw1JIZOM0hwVLGhJydF
	/cEcHOin0s3052YJ+okYO9GVcgF6d8SMWNkTjCQlEM16RFF3uLssdd1lwwtW2hQL85rbHaJyJ/z
	5JAeZURLtNh56jaz4WkQ4ObjIuETwqrBJsvQnhjGrdCPSkCuPcb9BsKigYuO7EiSjEMKW9Jq/te
	f8jsvttAcM+EH7UmY7NkodoRJoCSgOSKT4kSK12rytv44pQk2Td//Mb2Qr/frZWJD7h9Wh7x4Dz
	74gYvPLV+1l+cI7vdB/TIRUNumCLCYawXCHYIlInnzj+cIIU9Bqrwi0Qic5+ClFDQ3GwmF7tClC
	PFffgIrIKyl2bhtRt1vTR+8cr5Gn3eQ2pfLdUur2JNkRahjtSfES/2C+YRWY4dcGHLsRla5eOJH
	gwCCyVntZ/bElXCA==
X-Google-Smtp-Source: AGHT+IGDsOCJE/8OXOJ3lexcpmPHsAdgfuTcL+HEBKZ5PM70WSSDEKX/8T7ZMg7Ychc7oYsoCouSgg==
X-Received: by 2002:a05:7022:f68e:b0:11b:d561:bc16 with SMTP id a92af1059eb24-121722b52fcmr41015141c88.22.1767379948394;
        Fri, 02 Jan 2026 10:52:28 -0800 (PST)
Received: from [127.0.0.1] ([57.151.128.130])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfd95sm152073825c88.1.2026.01.02.10.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 10:52:27 -0800 (PST)
Message-Id: <9bd01bce9f0763d9dcc962ff94fcda36346bafc4.1767379944.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Jan 2026 18:52:16 +0000
Subject: [PATCH 02/10] xdiff: make classic diff explicit by creating
 xdl_do_classic_diff()
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Later patches will prepare xdl_cleanup_records() to be moved into xdiffi.c
since only the classic diff uses that function.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c | 43 +++++++++++++++++++++++++++----------------
 xdiff/xdiffi.h |  1 +
 2 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 4376f943db..e3196c7245 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -311,26 +311,13 @@ int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
 }
 
 
-int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
-		xdfenv_t *xe) {
+int xdl_do_classic_diff(xdfenv_t *xe, uint64_t flags)
+{
 	long ndiags;
 	long *kvd, *kvdf, *kvdb;
 	xdalgoenv_t xenv;
 	int res;
 
-	if (xdl_prepare_env(mf1, mf2, xpp, xe) < 0)
-		return -1;
-
-	if (XDF_DIFF_ALG(xpp->flags) == XDF_PATIENCE_DIFF) {
-		res = xdl_do_patience_diff(xpp, xe);
-		goto out;
-	}
-
-	if (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF) {
-		res = xdl_do_histogram_diff(xpp, xe);
-		goto out;
-	}
-
 	/*
 	 * Allocate and setup K vectors to be used by the differential
 	 * algorithm.
@@ -355,9 +342,33 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	xenv.heur_min = XDL_HEUR_MIN_COST;
 
 	res = xdl_recs_cmp(&xe->xdf1, 0, xe->xdf1.nreff, &xe->xdf2, 0, xe->xdf2.nreff,
-			   kvdf, kvdb, (xpp->flags & XDF_NEED_MINIMAL) != 0,
+			   kvdf, kvdb, (flags & XDF_NEED_MINIMAL) != 0,
 			   &xenv);
+
 	xdl_free(kvd);
+
+	return res;
+}
+
+
+int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
+		xdfenv_t *xe) {
+	int res;
+
+	if (xdl_prepare_env(mf1, mf2, xpp, xe) < 0)
+		return -1;
+
+	if (XDF_DIFF_ALG(xpp->flags) == XDF_PATIENCE_DIFF) {
+		res = xdl_do_patience_diff(xpp, xe);
+		goto out;
+	}
+
+	if (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF) {
+		res = xdl_do_histogram_diff(xpp, xe);
+		goto out;
+	}
+
+	res = xdl_do_classic_diff(xe, xpp->flags);
  out:
 	if (res < 0)
 		xdl_free_env(xe);
diff --git a/xdiff/xdiffi.h b/xdiff/xdiffi.h
index 49e52c67f9..8bf4c20373 100644
--- a/xdiff/xdiffi.h
+++ b/xdiff/xdiffi.h
@@ -42,6 +42,7 @@ typedef struct s_xdchange {
 int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
 		 xdfile_t *xdf2, long off2, long lim2,
 		 long *kvdf, long *kvdb, int need_min, xdalgoenv_t *xenv);
+int xdl_do_classic_diff(xdfenv_t *xe, uint64_t flags);
 int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		xdfenv_t *xe);
 int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags);
-- 
gitgitgadget

