Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6E219AA5A
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767192; cv=none; b=j7AUHJwzoR2vBl/F6G/xzn1ykAynDRiRlDejxlivVvudMOriP4CviKtgODzYQ2Ek+5E+PVJAxVV+JW6nabZ9e6OKG1z3FFc9RUgKdNKB9QeWQ3GtnnFv+R1/v4msTGIExoPU40McPBpo1DrwiySEjZFOLvv257PiAmR0/GNj4KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767192; c=relaxed/simple;
	bh=LeBg6I0inzCH069uGqVhz17t46bmb4xO3YXRPb4rsGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXGjy29BDN+vIMVPZ+HbF4R75DIfML7wa+mwdc9gExEkRr6CzbyIIngJdheAd4y5z9dxC8FQFkO4pNelc9IJBewIq04lvvp798EVZlckCQtSyC3CnIRdT5XdljgkO3Ah/o4EdOjp02STXPaSoxG0ACdhMMyvXCO4qexH7FTCyUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLrQBVbu; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLrQBVbu"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-579fa270e53so3211843a12.3
        for <git@vger.kernel.org>; Fri, 07 Jun 2024 06:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717767189; x=1718371989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGDFtCyuHoAE6524CRKSHIhfq1Okh4M+NjKMp35vqwQ=;
        b=nLrQBVbuSeJXzwlQpW9szefDUmR1aML2OEWqcCSlzTYXjiXJlqncJksf4jePJc3m1M
         PuSsGDBWwC2voNnFW5iUwtKxhL/1LH8aeLirnYLZtCJ6EXED5Iv1grJMoM72dzLQap6D
         8X36y1rJxQuggEil4nmPoMWkjDzy9eo+69LA+LLWEytks9kgUdyoRUwXFHI/SDpjBwV3
         nkzaxaLC2jwHBvnwaGbbciCzn86s09N8PmTOW7ChPBClndXjpqoxDltU/7ZhZhMQmfIe
         21dtDfmcmKSK4pt/hi7uAANqVoJ/R5vR4XALhsM26X3ZrOfREPXhPq3JWkhMxSUZoiWc
         AESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717767189; x=1718371989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGDFtCyuHoAE6524CRKSHIhfq1Okh4M+NjKMp35vqwQ=;
        b=ryffJU6qpEuaSaYoWBlHFei/3yHt/awk98r1h+jFDt6oj3J3vSeipXh9qYsi2Pziq/
         sIHCz9QoS75PijUg6fMcw1aMAh+2uCNRH46q1DsOs1xWcBGi1Uc+u91qUWSSLaYUqtLE
         HVhZZnBMQropeHaG/DuhUpfoWlXSRu91n+QaAYzT95AlwDWlJXsqrR1P2ygcVZGDz0FG
         LM0T3Nbze8RbUsoI6FPH8DNhXlmrMSw/5ciYP5P2e20V9dLrVv4oTNowy9uxF3omXPg0
         FLmmawz4sF9dQblxm/5DmTOZaP1lDh0vOBnnb/RS1rXISQaAAUb+c3y55Cc3pI5f5qVH
         HQiw==
X-Gm-Message-State: AOJu0YzCz8y7bvoY/JS4KczcbBnQqgoRC92rqFK+kBBmudFDlcl078iA
	JCYx55ioAxMmm/RfDgnlo+ARfJrFViWDNEtdKJ7si97H/anlVWQF
X-Google-Smtp-Source: AGHT+IGHLqCkMf9J95454a35WvjChqbfnpiz2C3jZ5X3/9mNlTsx4qGDbP5gvUUjQqZJK5ZumPb1mg==
X-Received: by 2002:a50:9b5a:0:b0:579:7b6c:5ab3 with SMTP id 4fb4d7f45d1cf-57c508fc040mr1908139a12.22.1717767188671;
        Fri, 07 Jun 2024 06:33:08 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae2340f6sm2764167a12.90.2024.06.07.06.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:33:07 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v5 2/7] refs: specify error for regular refs with `old_target`
Date: Fri,  7 Jun 2024 15:32:59 +0200
Message-ID: <20240607133304.2333280-3-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240607133304.2333280-1-knayak@gitlab.com>
References: <20240605102958.716432-1-knayak@gitlab.com>
 <20240607133304.2333280-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

When a reference update tries to update a symref, but the ref in
question is actually a regular ref, we raise an error. However the error
raised in this situation is:

  verifying symref target: '<ref>': reference is missing but expected <old-target>

which is very generic and doesn't indicate the mismatch of types. Let's
make this error more specific:

  cannot lock ref '<ref>': expected symref with target '<old-target>': but is a regular ref

so that users have a clearer understanding.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c    | 14 ++++++++------
 refs/reftable-backend.c | 10 ++++++++++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 194e74eb4d..fc57c9d220 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2491,14 +2491,16 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 
 		/*
 		 * Even if the ref is a regular ref, if `old_target` is set, we
-		 * check the referent value. Ideally `old_target` should only
-		 * be set for symrefs, but we're strict about its usage.
+		 * fail with an error.
 		 */
 		if (update->old_target) {
-			if (ref_update_check_old_target(referent.buf, update, err)) {
-				ret = TRANSACTION_GENERIC_ERROR;
-				goto out;
-			}
+			strbuf_addf(err, _("cannot lock ref '%s': "
+					   "expected symref with target '%s': "
+					   "but is a regular ref"),
+				    ref_update_original_update_refname(update),
+				    update->old_target);
+			ret = TRANSACTION_GENERIC_ERROR;
+			goto out;
 		} else if  (check_old_oid(update, &lock->old_oid, err)) {
 			ret = TRANSACTION_GENERIC_ERROR;
 			goto out;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index b838cf8f00..c66ab9ecd8 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -928,6 +928,16 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		 * backend returns, which keeps our tests happy.
 		 */
 		if (u->old_target) {
+			if (!(u->type & REF_ISSYMREF)) {
+				strbuf_addf(err, _("cannot lock ref '%s': "
+					   "expected symref with target '%s': "
+					   "but is a regular ref"),
+					    ref_update_original_update_refname(u),
+					    u->old_target);
+				ret = -1;
+				goto done;
+			}
+
 			if (ref_update_check_old_target(referent.buf, u, err)) {
 				ret = -1;
 				goto done;
-- 
2.43.GIT

