Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1D43E9F7F
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083529; cv=none; b=kWLgbLB5iZGVcO9OPRz60BQZiDeWnVZuaTApjXvq6qIHbHqqm97+jVDdeL5RylcwYrky0dETsuuoRHPirYN6kprStlNCQfmTgO4dca6H0GVgQgi3v5rLfPF8tsNL55PDD+wyD2aovEZXRbNbTSJTtwp0ZyIV6sMO2Za5bEsuEfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083529; c=relaxed/simple;
	bh=IMACRuBqccFKpZmenmlnQ0Uz01cBORZpWqMkv3/P/1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n+JBORU4Pf2DY5Wth25ZkHPAllMtmiiIiUIvtfYY2ZgqiLNcvivFLoayTtkhuqN7h1HE+3ZK3sURnl4S/2QXgPy5KQQevvH+fMfuFZbunyHjzojNittH7U2ErU8X3O2RGT1qf2pxpEPj7mKgJPrKC19wlafi1il4UD4zmk5BdTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THBirWP+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THBirWP+"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so12052435e9.0
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 04:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769083525; x=1769688325; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JhuXJzfzbCdMOPhZN5alU/dnu8gPEtMTjdZDqxg5QYk=;
        b=THBirWP+YKtyCxV1ox8mfvjdgHSJircSRWOK7hMLSnMURp7/fNC4jd9Av+HuQL5OZT
         iC6vn5LkJGBxKnPPAmfrDG5qU+VltR4pDrHy8Afoe9h+DPYV9ZGHJ7E50LAGw80XuCMz
         jl7gkCvFJOU7+/Gk54fkBiCEXP3fFtZ1p74YCc0rdmFUE2yTemUBV/1JM2/0cg5/Fqi1
         8FN1H6+t8F65ZHd/4WDPV/Se2KWpfZNR+Dw/RNkh0GUC/k06AAHSPIfZlKpBSzHbxUos
         ZIbZ370SSMi6SdGycqAlW0Tkkw1y10pBL+QSiH6jjkFurYn29IFhPrwfpqVP5MB849WJ
         90IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769083525; x=1769688325;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JhuXJzfzbCdMOPhZN5alU/dnu8gPEtMTjdZDqxg5QYk=;
        b=DGe50DbnrFycqk/IbLUWnytG/x/vhM9QE54bx8MAKFDXDBoxzgUJLVajgHTFT2em1I
         KffTFrDOTLIt0woUw6wygyAlxkvdHGD0iG1SAr37AqlrfPLe3sOFGdcZSuDE2zLgbdZv
         YSyJPdfGN3Ry0Y1AoG0mI5a9vGRN+eOsAaPMofuFCrmiDUoZaSOF5U6mZySkFphEz/xT
         g5FwwfqJQbJOpNZhE0C5JLXa/Urr8CC7ej8Zz0vNu1w2Rn60p50EpJpt936Dr5k/Ude5
         lYqmVZJrg3rBSSrSdGNrgxx7IS4Y+LBKPDIft1xmU9FtOkWHgOgzPhEFAOOuaoow5dse
         GIJQ==
X-Gm-Message-State: AOJu0YyLX7z2uyLLN7EkAA8MK1Gm6LIFC9H2rFw5ecvFjIXQq+Y1D5YY
	8OYfoTFwxB24Nqt2ZULDRb/SNpyaHXOXAS/bx/+dQKuKmC/mm6rOXNrt
X-Gm-Gg: AZuq6aJowKpUMBtaLwbMzKg5z2vekh2r8IloyV3/afQ0ONE/usbY+Bj1CKTYqXJ4Myj
	QWiuVnzGvaaAvSAbLuTNiUW27bbotJcMPNTKh1A9nO3rBmH7nBOTSv2yBGAY01fx26xt9IOTlPX
	oKTaVlvqZ8/SmIkgCUaocd0bM78fZn4f9XzhgagZMKyzwB6l8jtg14PQgDiQErSw18Fb2qtgZRn
	UrxE5iDAmaq3w6qRWlfPZqUcZEfo4z9I3Q7H+tCgPGQip1dOaLfnLOkDWx+z8ki+mniqcLOYJfE
	jmbc/a93cUhB2MeJsvH5HpV3IYSXqKcfWKpoDUUaY1+mvKZWRgMMmYlwsPcOT3Q2+tC5aiMdMZS
	mQMyEDWnDTGgPHV4S/tjr2anYJmt4sWqJrLmIJ7Vxm8pjzAYxTZrqGkFWwW2rUjkpsT9mPlobhY
	fm5N1zuzGb/0Lo6hyNwg==
X-Received: by 2002:a05:600c:34d3:b0:479:1348:c614 with SMTP id 5b1f17b1804b1-4803e7f03fdmr129939185e9.26.1769083524843;
        Thu, 22 Jan 2026 04:05:24 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:ef49:411:ff92:1c50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470403d3sm64926445e9.5.2026.01.22.04.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 04:05:24 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 22 Jan 2026 13:04:56 +0100
Subject: [PATCH v4 2/6] refs: add rejection detail to the callback function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-2-2ddba0832440@gmail.com>
References: <20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-0-2ddba0832440@gmail.com>
In-Reply-To: <20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-0-2ddba0832440@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net, newren@gmail.com, gitster@pobox.com, 
 phillip.wood123@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3039; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=IMACRuBqccFKpZmenmlnQ0Uz01cBORZpWqMkv3/P/1k=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlyEoCIQqXN3izuMKZClb/9oPM/pC5YjLWUm
 wI9Wlurf8SQK4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpchKAAAoJED7VnySO
 Rox/GEML/RxC/wwT+afi8Ge7TwDtEUAKaqrwKdV0aMVJ/6LBr+6zK88qA4JSbVSvWNTzbhQNpTH
 VJ/wvCHClER+anMY5QvwkAdxICEwJrSOtXstk49XkTctGTUGt3kxfIIAl3K2DjQdaCyeW/2FseE
 evrqVjoJdiL4WegC2RkNyo96C0QDTDc8HzNrkrovjr3v1sVFunl4MCLzMFNJsGzODpHGie19vuv
 rImM/pKzOs7/GJv2uUoz2Qqp/VUU8HjVHwjE/Vm11K6GrfCZaOZsLXLLzW8s+JiEb4ILI7NSAyf
 TJbZZlGHRfRI40JxXgxbPK1ly7zfXkIojIy+IJ+SD36kpPCEEAklULJSAtD+pTbiF8d9aBDI3fy
 FwstzYYfbM4f2mmHsaDplarNQ7DRROfehBcrgJm1yeybCJlT9kUdAwtftRDwomaW5K+932RIojY
 LYBGIfgLslOQNJ4Z07HFW45V6ajLzIWleiBgCwL4CpwxMHLBsSxiCoMJi2Yv7yGkEeOc/ntF175
 nU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The previous commit started storing the rejection details alongside the
error code for rejected updates. Pass this along to the callback
function `ref_transaction_for_each_rejected_update()`. Currently the
field is unused, but will be integrated in the upcoming commits.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c        | 1 +
 builtin/receive-pack.c | 1 +
 builtin/update-ref.c   | 1 +
 refs.c                 | 2 +-
 refs.h                 | 1 +
 5 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 288d3772ea..d427adea61 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1649,6 +1649,7 @@ static void ref_transaction_rejection_handler(const char *refname,
 					      const char *old_target UNUSED,
 					      const char *new_target UNUSED,
 					      enum ref_transaction_error err,
+					      const char *details UNUSED,
 					      void *cb_data)
 {
 	struct ref_rejection_data *data = cb_data;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ef1f77be8c..94d3e73cee 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1813,6 +1813,7 @@ static void ref_transaction_rejection_handler(const char *refname,
 					      const char *old_target UNUSED,
 					      const char *new_target UNUSED,
 					      enum ref_transaction_error err,
+					      const char *details UNUSED,
 					      void *cb_data)
 {
 	struct strmap *failed_refs = cb_data;
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 195437e7c6..0046a87c57 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -573,6 +573,7 @@ static void print_rejected_refs(const char *refname,
 				const char *old_target,
 				const char *new_target,
 				enum ref_transaction_error err,
+				const char *details UNUSED,
 				void *cb_data UNUSED)
 {
 	struct strbuf sb = STRBUF_INIT;
diff --git a/refs.c b/refs.c
index 53919c3d22..c85c3d2c8b 100644
--- a/refs.c
+++ b/refs.c
@@ -2874,7 +2874,7 @@ void ref_transaction_for_each_rejected_update(struct ref_transaction *transactio
 		   (update->flags & REF_HAVE_OLD) ? &update->old_oid : NULL,
 		   (update->flags & REF_HAVE_NEW) ? &update->new_oid : NULL,
 		   update->old_target, update->new_target,
-		   update->rejection_err, cb_data);
+		   update->rejection_err, update->rejection_details, cb_data);
 	}
 }
 
diff --git a/refs.h b/refs.h
index d9051bbb04..4fbe3da924 100644
--- a/refs.h
+++ b/refs.h
@@ -975,6 +975,7 @@ typedef void ref_transaction_for_each_rejected_update_fn(const char *refname,
 							 const char *old_target,
 							 const char *new_target,
 							 enum ref_transaction_error err,
+							 const char *details,
 							 void *cb_data);
 void ref_transaction_for_each_rejected_update(struct ref_transaction *transaction,
 					      ref_transaction_for_each_rejected_update_fn cb,

-- 
2.52.0

