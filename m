Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FF63DEAEB
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933646; cv=none; b=sjfj+Gni5ba2dfiasVd19aexNe+jLDo8czSD1LkX4B+nv1JM3+OBCdegOgRaFy4F3sWzIn9pYdbCIbsrDY7zojmLEjJ4fBiPxFcCFbE4MbZvLOqWPFZZUpcS6m619sbGP1ipCYdAkiJpqg627F6useR/uDQkDTIXKmg1JJ//r+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933646; c=relaxed/simple;
	bh=9hmCFKoKScRjhfqO/sM+O28CtMU/EzaD+pSewKN1a58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vpj3oz8abmA7VRARWriUPlOho8gR8p7T2w3tSGdVd2rdNvamKaYVryBJQwdHL4O5M0p1pTeUUv2bz8C75bMZAtGZP6VX4UYAhpaEJTzQqF8v/qoyptMB31licQDopz9f7WEnv59MnmWQejkY9pquvYhZRQpur8A3fCOnGV4Knx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5bjWXXQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5bjWXXQ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so51481995e9.2
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 01:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776933643; x=1777538443; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPlWDpTehSrUWXOWCJ9JidhgaGbaVdI3x5TMBlSYF/w=;
        b=L5bjWXXQurtxdtsthqR7Qw86hx4kcSAmw203enAl1sgBlxUimqR/PoEDZGOMIMXWOq
         AEcJgRU13r7iptlFreGD44RKOdx+Lrfil5+YEAV2a3c4Knd3E2/emEw173p1hD7zoEeU
         6VoAhllAKPiVvpl0VAxOUivZA73IcgCrm8W5aMLt5HaD9zBhOt8RaOH8MCXk75Za32aB
         SYBMXCz1nUYCVXHidir8Vadee9VzZ1JHh+113VcJ5iB6jlku20ksVnIxsssaTEacUyeQ
         Xsqk4uAaqSeV0WnDR4/VZmq1REJuqTFI2cq0nvgiMC5/beuLYMN74gPZU/e1aXQNoK8R
         VG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776933643; x=1777538443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KPlWDpTehSrUWXOWCJ9JidhgaGbaVdI3x5TMBlSYF/w=;
        b=JDRZHi6U2ekM6IvaNZhpWkWyqx/2TUO2ZD9PTGldE5KyHHMTFIBKC44x5lnT18mOYX
         UIz2Jd8OoHwCW5p+bYcpf75XtsJaR8LeTnIUukA/vwbXuG236XEJfEl3GYFYJ+0NDVdn
         MhVPAHGUuwFwmVw/hnZ74jsNZBKKXmgFL1iqBAET23IbAaUF5pQp8SB/Y5BfZZHL/xaQ
         z5x+1OxBE2os5uud0AomH5mWkKHa7PT54FtkIgULXUyTnEaISnU8h8bfhekUBW4ZwkG4
         ZsmshhuVMf5SFimtvygFdNAgm3NqkCVklAWDoT8iz/EJu5BHEyZl9jrdteGsgnXhtW6Z
         /L1g==
X-Gm-Message-State: AOJu0YyQr7hPKHtSMns31zcUV9o8qozSq2AupfgNoJJD2T6P0c3d59R8
	KmstY2heLxPIjByTOx5Zu4uFuVpc7uQf4jqJCGOwBcSIc761njG7yv33X5Rk7w==
X-Gm-Gg: AeBDieuNUgD+TqCXwI7IYTW0L2a7vSDtq+ZH0Ljsg+xbzpkJhtTV0enU0xBoG89INTo
	XBZBE5G4yW41sMZdOMtsFOKIF6dT7Q+8PLQ6x4eef/dcvqYdV5ZmtznPTAIwSi/xKWgnPjkEPZY
	dLAzxobsYQ3koSGosPhYhOo27pQNzAkRctzMM9Q5R58spq25g0znm1R/DcQ/XN4RhWWGceDGmaZ
	hn40VDPiJhBsaMOR8nHMoZblYtP5kAUVa+cyEeykNV39g8Xs5Xmtpi7PAEsQhs1xlmp0mNUivcr
	Q+/JOuIVHHSx/v2h2tvXZEZqXqp5jgu+I2jXuQibQQMebYpInQRKfQcFzRYsW9eqt47ltcgO7DO
	NpNkizQ8MIsz/QJQ1Zr0mxcq2Nx5MsMt7zaf/4JWL0UkaDM5Iaw8CJdHruy1GS1T71zK+hHhBfS
	qkBmF1slulVFw1skELLGcZbbpSzkK5b9kdxM8cyWvi
X-Received: by 2002:a05:600c:46cb:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-488fb7451e4mr372825645e9.5.1776933642885;
        Thu, 23 Apr 2026 01:40:42 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1cda:f096:cc8c:a0e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489fec8f7cbsm234286785e9.11.2026.04.23.01.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 01:40:42 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 23 Apr 2026 10:40:33 +0200
Subject: [PATCH v2 4/9] refs: return `ref_transaction_error` from
 `ref_transaction_update()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-refs-move-to-generic-layer-v2-4-ae5a4f146d7d@gmail.com>
References: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
In-Reply-To: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3225; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=9hmCFKoKScRjhfqO/sM+O28CtMU/EzaD+pSewKN1a58=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnp2wN+OgxdpvRPjfKEeocF4S29syDxAMqkH
 XpIHChy4o5b1YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp6dsDAAoJED7VnySO
 Rox/G6QL/1AaCRU/1y7PLZZxF2lhw2z8AHHMNIHf353LGLFMv5SXEh6H12BU1sTo8AF531YnRix
 NXmNh++QnRSKoj+gGb+++3IWiTxiYG/dRuOU+HDjiFm7FMUoNCw6ET5F2+3yDZhXYBbUaEd/uoA
 IlWo5A8+byIAN+f1OnRCZpkrb1ujmRLVYUoj6Nr98mF7lvJHiQHkS0O1NQp/mbiZzbRiTVvQxHI
 gWPlgbNWk2BWogO5d4ACRaGal8sqocSX1yH8JeF6B3JPrsYgXjOm4MeAQM26l5MdOj0Krm7iani
 F6RPtuqK7L2l0UlPzNrYH7SHBRp5Mi1Gar5DWtUh/fOJZl4XxLB/DvSZ63idQg/2AUSGpm/8TY/
 Gbf/Yijx0w5leKLh6gfLh9RL4g5U+89WR0biBToBz7f5CDG9eM9CtkLanEZLJXnlw3mMztaPl4U
 7Y70+t4YEhjdKdz8VB7iDDqf2GwIXkNjEKGZzWO7DanOktDM2+4jvyu6o8FjqnqapzsCp+jYRX6
 NM=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `ref_transaction_update()` function is used to add updates to a
given reference transactions. In the following commit, we'll add more
validation to this function. As such, it would be beneficial if the
function returns specific error types, so callers can differentiate
between different errors.

To facilitate this, return `enum ref_transaction_error` from the
function and covert the existing '-1' returns to
'REF_TRANSACTION_ERROR_GENERIC'. Since this retains the existing
behavior, no changes are made to any of the callers but this sets the
necessary infrastructure for introduction of other errors.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c | 20 ++++++++++----------
 refs.h | 16 ++++++++--------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index 6b506aeea3..efa16b739d 100644
--- a/refs.c
+++ b/refs.c
@@ -1383,25 +1383,25 @@ static int transaction_refname_valid(const char *refname,
 	return 1;
 }
 
-int ref_transaction_update(struct ref_transaction *transaction,
-			   const char *refname,
-			   const struct object_id *new_oid,
-			   const struct object_id *old_oid,
-			   const char *new_target,
-			   const char *old_target,
-			   unsigned int flags, const char *msg,
-			   struct strbuf *err)
+enum ref_transaction_error ref_transaction_update(struct ref_transaction *transaction,
+						  const char *refname,
+						  const struct object_id *new_oid,
+						  const struct object_id *old_oid,
+						  const char *new_target,
+						  const char *old_target,
+						  unsigned int flags, const char *msg,
+						  struct strbuf *err)
 {
 	assert(err);
 
 	if ((flags & REF_FORCE_CREATE_REFLOG) &&
 	    (flags & REF_SKIP_CREATE_REFLOG)) {
 		strbuf_addstr(err, _("refusing to force and skip creation of reflog"));
-		return -1;
+		return REF_TRANSACTION_ERROR_GENERIC;
 	}
 
 	if (!transaction_refname_valid(refname, new_oid, flags, err))
-		return -1;
+		return REF_TRANSACTION_ERROR_GENERIC;
 
 	if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
 		BUG("illegal flags 0x%x passed to ref_transaction_update()", flags);
diff --git a/refs.h b/refs.h
index d65de6ab5f..71d5c186d0 100644
--- a/refs.h
+++ b/refs.h
@@ -905,14 +905,14 @@ struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
  * See the above comment "Reference transaction updates" for more
  * information.
  */
-int ref_transaction_update(struct ref_transaction *transaction,
-			   const char *refname,
-			   const struct object_id *new_oid,
-			   const struct object_id *old_oid,
-			   const char *new_target,
-			   const char *old_target,
-			   unsigned int flags, const char *msg,
-			   struct strbuf *err);
+enum ref_transaction_error ref_transaction_update(struct ref_transaction *transaction,
+						  const char *refname,
+						  const struct object_id *new_oid,
+						  const struct object_id *old_oid,
+						  const char *new_target,
+						  const char *old_target,
+						  unsigned int flags, const char *msg,
+						  struct strbuf *err);
 
 /*
  * Similar to `ref_transaction_update`, but this function is only for adding

-- 
2.53.GIT

