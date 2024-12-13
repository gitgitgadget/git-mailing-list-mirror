Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26971C07E2
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086217; cv=none; b=i89bLtvP70ANKPvxCzPIoxWo2Bwchx2WQC7d5WiCC9XdWWDEIjnL2j3NVms+IibkJBX6mFLiY5jfM46+3v1B1lt2xAFYiMVB0ssUD3vrjpPnTchOq89fONvAt21awz2OokkD7j9FCuVx5uA6ZaHa+FQ+EKLZrC4qJVvoLBWi43o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086217; c=relaxed/simple;
	bh=NoEckIGxQa5jQrZ0dQ7BHqCovFckF/qXPjbGFqkkuA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dt9TBSy0VKcYXjWWCqxBHVLCKx/ndKJyIbYc3fIC3OXmGrGFELEC+sRU2bvZUpNrhYO/6gHbBJs4R+cQF6xcpPFMUp+Cz3teEUsiKNPVJlCnkLd5Y/SVWDY2AdkJQHv5yJaYw0PJHSgHB+LPlVP3zCeEC5B9RIiqQpdnEFPymtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2gKCsyE; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2gKCsyE"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa6997f33e4so237149266b.3
        for <git@vger.kernel.org>; Fri, 13 Dec 2024 02:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734086214; x=1734691014; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Io5XE6RXiBUov+SaLOGtphgg3UciL24hpxxR053Wce4=;
        b=T2gKCsyEJSPq7d6cNdl/3KluV6lws3yBx0zyo+EO2U0BbAySZpK/i8gzRUuB76PAo+
         79zpsvLnWDDP2/35f6fDm4Ip4M222Usp36oTVOnEob00CBcWEOG/pUZ8GMKwBMxHUyGb
         3PVmeHc6yORfO2+kTL6wtEpsB1dahtI9QaUxLMPT8W6E2h0hFg5JQx4xx+1yFQ78yPxw
         +I5kctSGgqgZ1FXqc+RoyVNdWFvdjuJueS5I02k2356DPVnTHIolhIempS/ZCTvnJYDh
         eGtKRhif2OeHiwaDnDnA7PcRo4UsH67p4n01G06khxnvDO4DdUtOLNJKjjM4QfbOPIwb
         uUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734086214; x=1734691014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Io5XE6RXiBUov+SaLOGtphgg3UciL24hpxxR053Wce4=;
        b=v4uOvOBuAKeRYXelExMILxAmWuSW8HiJrxac4/UAN1ZN+Ka38qt1nxYlLhoNvF0NNt
         yWis50QSxA6QM5zrbvjZoqnU09D24Aj4BD/HnfxFbm4vNkYRj3utR/mKWp3b7L3H9EI6
         td6X7Mn9JJc3tEFLskkLWj1+vn1WrovG0EBkc66Y4xXIM9iiMod4Pfd8EkKqytEnusKl
         lLE7x/PM+KUXn5G7uLjoQEXJX3z0RUhDPejFDeRku1TQ2/yenpvvUFf7Xurr0Dy0poFT
         EWD1wR3kN/mrwT+Ayatdxn/hPo0hcGYRpK5L31I2MoILtD9YAgeESNsDyxV65DiokKej
         uJZw==
X-Gm-Message-State: AOJu0Ywbu8SLzH2xl/eCTkt7dsu01ug5CZ/rFZYpH0tvni1/dbIS8Inh
	p4KMwElJ6NLIyzUepBr6lLJiVQqdmVWXWqB/hzP0zAYkmtlKb3JF
X-Gm-Gg: ASbGnct7+kY4yZane+04zq85YFqr80E3JVgLMZNbeWbem323ry1Pb202o+QfQNuP5ij
	jYMp8hfotpEFmMUGN+IJaW2VJhnTRO/NVnTYOfRnB6GXeLC53uvYR6JkqInD4tzwqfUkS10sRe0
	GwVwIR5KhT3a6q1nyNm8RHkoD0de0wIKkewQRidWbYDJYeYXIY4Vz97vpcFe8FL1rAJ6nPqxuKm
	nslEicGp35AZloBkfcOsiUr0uQEux0NgDnrGjloo4i9IXUMQjKDVg/hJVL1WGGMWFo4yA==
X-Google-Smtp-Source: AGHT+IHQjSYHlm9jzVcydVJ3Nx2wx5TdvVFHVXT7YVOSVOsxBDLp08UlTY38R0nkF4vthvObGOxPxA==
X-Received: by 2002:a17:907:7813:b0:aa6:66bc:8788 with SMTP id a640c23a62f3a-aab77e8a87emr192418266b.45.1734086214004;
        Fri, 13 Dec 2024 02:36:54 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:8256:2d00:9c39:c2d7:aedd:294d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6883f65c3sm686785266b.157.2024.12.13.02.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 02:36:53 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 13 Dec 2024 11:36:49 +0100
Subject: [PATCH v2 4/8] refs: extract out refname verification in
 transactions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-320-git-refs-migrate-reflogs-v2-4-f28312cdb6c0@gmail.com>
References: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
In-Reply-To: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2366; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=NoEckIGxQa5jQrZ0dQ7BHqCovFckF/qXPjbGFqkkuA0=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnXA5Ax1IR50x9djyLZSMGTFu7b5A38pHgA+dvB
 2nTw5gUl3WJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ1wOQAAKCRA+1Z8kjkaM
 f34EC/4h/JAQ4GJ7M3NRjEEjkaijnGAGlpAKu8XOcj4ZPnKdQeKL3PizlMHnSvC7mkY7t6Gx1F9
 0NMDg/FO2F6QLLHzOmb3PphEZz3pA9C75mRhZOGPFWrvfmD4rt2nkisFMLhd6x06tLU6Gy80nqe
 qPadXg3BNEofUb1EFo+nJStRSyPHk8kPUEF+wL3bp3+BY+aSSEgb4NmR9xv0jfE6Q1I3GJ56gqu
 pyyp090KdqKYOPPPuUe0v5VP7D9NtyKT9+JnVXbUQbE8BzQ3GzZeJi/vCVga6SLB22NAT3Dp0t6
 p7f+gVYR8vt+QM2o4k2onO2U2+oTyXuVN5aqZ6160faUajnxpUIOAleTwJPQCXAym3AJffqO8QL
 oT3t11UH1y0+yCwjqO0SQj6tf0sPF0CjK79bB61cesfae4Vr8uNJVPAaF8yvcQrfr+fZLCYN5Wx
 3sDH6sjEUAC8olMyXQCA7XYnhjwxwuYnHYwpwkXV9g/nP+GkA4kAYdjwWEoFuDWjCouBo=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Unless the `REF_SKIP_REFNAME_VERIFICATION` flag is set for an update,
the refname of the update is verified for:

  - Ensuring it is not a pseudoref.
  - Checking the refname format.

These checks will also be needed in a following commit where the
function to add reflog updates to the transaction is introduced. Extract
the code out into a new static function.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index f003e51c6bf5229bfbce8ce61ffad7cdba0572e0..9c9f4940c60d3cdd34ce8f1e668d17b9da3cd801 100644
--- a/refs.c
+++ b/refs.c
@@ -1196,6 +1196,28 @@ struct ref_update *ref_transaction_add_update(
 	return update;
 }
 
+static int transaction_refname_valid(const char *refname,
+				     const struct object_id *new_oid,
+				     unsigned int flags, struct strbuf *err)
+{
+	if (flags & REF_SKIP_REFNAME_VERIFICATION)
+		return 1;
+
+	if (is_pseudo_ref(refname)) {
+		strbuf_addf(err, _("refusing to update pseudoref '%s'"),
+			    refname);
+		return 0;
+	} else if ((new_oid && !is_null_oid(new_oid)) ?
+		 check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
+		 !refname_is_safe(refname)) {
+		strbuf_addf(err, _("refusing to update ref with bad name '%s'"),
+			    refname);
+		return 0;
+	}
+
+	return 1;
+}
+
 int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *new_oid,
@@ -1213,21 +1235,8 @@ int ref_transaction_update(struct ref_transaction *transaction,
 		return -1;
 	}
 
-	if (!(flags & REF_SKIP_REFNAME_VERIFICATION) &&
-	    ((new_oid && !is_null_oid(new_oid)) ?
-		     check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
-			   !refname_is_safe(refname))) {
-		strbuf_addf(err, _("refusing to update ref with bad name '%s'"),
-			    refname);
+	if (!transaction_refname_valid(refname, new_oid, flags, err))
 		return -1;
-	}
-
-	if (!(flags & REF_SKIP_REFNAME_VERIFICATION) &&
-	    is_pseudo_ref(refname)) {
-		strbuf_addf(err, _("refusing to update pseudoref '%s'"),
-			    refname);
-		return -1;
-	}
 
 	if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
 		BUG("illegal flags 0x%x passed to ref_transaction_update()", flags);

-- 
2.47.1

