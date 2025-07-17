Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD272248A8
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752784353; cv=none; b=MkmmiTtZD1Yf4MhjUbpiS4zR/QGF44Aq7BUAIduvYkGRSaSXV1OQZjhRYH9s7cGayrqaVO1tT0Yn3xDcjg9i/5cQhH+MFEu0lBLWKb3hxDcQWPGbeF1Dvt1qlN1MmmL+lIsFc6X7UuQ3F0TErFwdLrGerr/al7GZqN2wJc1XUwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752784353; c=relaxed/simple;
	bh=LMHWr/Jk/LCHA9l1VxqyJm3U48rkduLIbJrelWeCdfA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Af0oDxzdKACy9I9aHwT9H2TspxX63VIlek1HAX9qtv+/lLbve0JKQt6pl5tP2GZusiwHoGjsDKY1arBqLUdvsK5W/ApYCjdGftzDnfqbEU8H4TFl0beycg/RNkPNynn0MlQoZQg1WlhNMMB+U6zZ1ha5E/1s1FnE341IoTpEdGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMn5suFa; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMn5suFa"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so822691f8f.1
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 13:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752784349; x=1753389149; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqOowsYrOMLRM9RauuBk8vQViQlOWdRCXqM9cNH/Jk4=;
        b=NMn5suFaWKagYVwpq1c5Qm/xSiaJ4FyIABaJRKMnmy0AucAJevzTDpb7evV8rdkyeS
         4EFWiI83GeU+gmFKvHa3+sv/cB9IYqNYG7+5T0Jk490CmTcw9MZxjyXQXsv8M53ECWGK
         v6w68NZ5679S5GpjbYsApqy5Db9Nr2zp6M189m1hlYEtm21oXnclW8//J8FHGHF4K3Tn
         bP5E3XjUU+oA4MoUtHo4r0ssggM7cPzOutt8a5xjLlvnVydHROcSFtf2oPjUCOqkhc/M
         r6zjsylQjh5dzCyVZh2Sqzqf1ZgnYQmYDDdyjxcW+IoFllZ0YGDCDrIRl3Ws2fzZ5YfZ
         sEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752784349; x=1753389149;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqOowsYrOMLRM9RauuBk8vQViQlOWdRCXqM9cNH/Jk4=;
        b=lhrbASYr0Alq78fa+hCik+95zgVVK7yS9/6UtTpN8c6mY3ZKNEUQqh2UQ0De9zbt+P
         C48kmRNlt15HtnzXrSEgAMnyxNhjVtmPyhhbpKC6BlFHz+zUCPsmMgwtwOLOWtqHswEP
         klO+4HAawV1QQSkOxMxw5l8lzfAC0Pr78cPiZB5227fuQ60CQoZmZO/2z5STd0Ch8RM0
         GhcS8xEX2yZ6KOY0YfjsN30ncu+6yMyr9Cr0tlwCPQY1PjKPVhhfx0zhdyZB88Ot2a7Z
         fUSLOKhoOtfAn2Qk1r5BUnDUTDTerlbHnQpOx4L4reWsfzlZxBgcsCSPtV88hoRbalyh
         W1qg==
X-Gm-Message-State: AOJu0YwZEYxf2p8ZnsPy7+6lZUKqQf9/PY1k/y/wa5UNfeIS6hrXMGZs
	V9btSaBgLa1ZEJXUtUFpmp61g4kC8b/7CcPqkUOPDSSeSkEN/mDCX4mfzpyMrw==
X-Gm-Gg: ASbGncvYxH+uTDMXo41Z6b7n2mqnjkuECYVb/Fex00ADjiHUVVxBzuF3hUhiiuETU07
	/rL8dI+VMgxbrbb691B1ctPOrfKlCZovttTcKk4JGthgdQOfvTC81v6v4eCmqhDZ95QKygllUms
	2h6AQNt0WgogyHBJNfSaJR2QBpcIsKNl5jFv4MRyNsPOSdWTrb/B1g/bifqbozPNN/Hh//Ly/Q1
	vAp00MR3MWgxerIA1PdOI/7vjhhheJ0kDLbNl+Cvj5q4nS5FmBiZhX8qxo9fZi+cSRkOiVvJ8CX
	Chq1kPpJJit3ckYmTAybwzjWgcFMcNR2sbxR+aKgCkeUzfRKD1PsWq+dsYySi8tlmD7oYE2Wk1S
	+kxIzN3eyhOyQZ4E2cEMWK20=
X-Google-Smtp-Source: AGHT+IET/pYawx8H1MxVwnXWTXlVUkYE9kLTi7BGRTei5yd9yWNzraEzUZVYdzIgbLUROnpRcKU5ZA==
X-Received: by 2002:a05:6000:4910:b0:3a4:d274:1d9b with SMTP id ffacd0b85a97d-3b61b0f5cccmr255199f8f.25.1752784348927;
        Thu, 17 Jul 2025 13:32:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e1a5sm21273890f8f.74.2025.07.17.13.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 13:32:28 -0700 (PDT)
Message-Id: <cc05150d6e142b6e0b2837b437903577cacb629a.1752784344.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Jul 2025 20:32:20 +0000
Subject: [PATCH 3/7] xdiff: delete unnecessary fields from xrecord_t and
 xdfile_t
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
Cc: Elijah Newren <newren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

xrecord_t.next, xdfile_t.hbits, xdfile_t.rhash are initialized,
but never used for anything by the code. Remove them.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 24 +++---------------------
 xdiff/xtypes.h   |  3 ---
 2 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index a45c5ee208c8..ad356281f939 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -91,8 +91,7 @@ static void xdl_free_classifier(xdlclassifier_t *cf) {
 }
 
 
-static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t **rhash,
-			       unsigned int hbits, xrecord_t *rec) {
+static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t *rec) {
 	long hi;
 	char const *line;
 	xdlclass_t *rcrec;
@@ -126,23 +125,17 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 
 	rec->ha = (unsigned long) rcrec->idx;
 
-	hi = (long) XDL_HASHLONG(rec->ha, hbits);
-	rec->next = rhash[hi];
-	rhash[hi] = rec;
-
 	return 0;
 }
 
 
 static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
 			   xdlclassifier_t *cf, xdfile_t *xdf) {
-	unsigned int hbits;
-	long nrec, hsize, bsize;
+	long nrec, bsize;
 	unsigned long hav;
 	char const *blk, *cur, *top, *prev;
 	xrecord_t *crec;
 	xrecord_t **recs;
-	xrecord_t **rhash;
 	unsigned long *ha;
 	char *rchg;
 	long *rindex;
@@ -150,7 +143,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	ha = NULL;
 	rindex = NULL;
 	rchg = NULL;
-	rhash = NULL;
 	recs = NULL;
 
 	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0)
@@ -158,11 +150,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	if (!XDL_ALLOC_ARRAY(recs, narec))
 		goto abort;
 
-	hbits = xdl_hashbits((unsigned int) narec);
-	hsize = 1 << hbits;
-	if (!XDL_CALLOC_ARRAY(rhash, hsize))
-		goto abort;
-
 	nrec = 0;
 	if ((cur = blk = xdl_mmfile_first(mf, &bsize))) {
 		for (top = blk + bsize; cur < top; ) {
@@ -176,7 +163,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 			crec->size = (long) (cur - prev);
 			crec->ha = hav;
 			recs[nrec++] = crec;
-			if (xdl_classify_record(pass, cf, rhash, hbits, crec) < 0)
+			if (xdl_classify_record(pass, cf, crec) < 0)
 				goto abort;
 		}
 	}
@@ -194,8 +181,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 
 	xdf->nrec = nrec;
 	xdf->recs = recs;
-	xdf->hbits = hbits;
-	xdf->rhash = rhash;
 	xdf->rchg = rchg + 1;
 	xdf->rindex = rindex;
 	xdf->nreff = 0;
@@ -209,7 +194,6 @@ abort:
 	xdl_free(ha);
 	xdl_free(rindex);
 	xdl_free(rchg);
-	xdl_free(rhash);
 	xdl_free(recs);
 	xdl_cha_free(&xdf->rcha);
 	return -1;
@@ -217,8 +201,6 @@ abort:
 
 
 static void xdl_free_ctx(xdfile_t *xdf) {
-
-	xdl_free(xdf->rhash);
 	xdl_free(xdf->rindex);
 	xdl_free(xdf->rchg - 1);
 	xdl_free(xdf->ha);
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 8442bd436efe..8b8467360ecf 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -39,7 +39,6 @@ typedef struct s_chastore {
 } chastore_t;
 
 typedef struct s_xrecord {
-	struct s_xrecord *next;
 	char const *ptr;
 	long size;
 	unsigned long ha;
@@ -48,8 +47,6 @@ typedef struct s_xrecord {
 typedef struct s_xdfile {
 	chastore_t rcha;
 	long nrec;
-	unsigned int hbits;
-	xrecord_t **rhash;
 	long dstart, dend;
 	xrecord_t **recs;
 	char *rchg;
-- 
gitgitgadget

