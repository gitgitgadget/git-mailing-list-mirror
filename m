Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E7A21B91E
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742451; cv=none; b=WqCsvgolkLFWa31wc7aAHnLpLa/5trNPCKUogYbDU5bMiW0lIr5QV/PEESPKo7aHAesQd3hl5ne7WMyhLA+zc/7qjD3HxhuHSspWJ6frNj0ca5YbVEiyKl0aC3D4IpTYVBoxjnLR7VFJ338yL1pifSyrOpxBxu7uHTvrxFgN4Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742451; c=relaxed/simple;
	bh=YCQQd9ym7xx16rPamjRXYJWagS28PovIK7X844HDYxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JN/jb+3SfiC2/7/0wMC+R4Alza47J9QTl522XDuV22Atsq7sp3+Z/kdHC8X9T4qIEgrA8TJHXuNFlm+sWtUlrNm2OrzARjky1qOFaiQxpP3d9+zlSuKHgJq6/I1OrzPbln5p62IZPbvivkeXuh64zgXUY3jd3Jw9lJcmKCPEoiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UATBTITx; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UATBTITx"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso339278a12.0
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 03:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733742446; x=1734347246; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjzDeyeOaWumKUh5rU1ojNga2tt2q8VFzErpCwuxoMk=;
        b=UATBTITxkVBgy9wcL23vG/bqmZUbi0LEek15Q4jSoz9pzz1BADrGDsGwA7iE0HPN7k
         4y/zQtTgqg4pe9fuNFgKCGdzNk5Xc1rRXWSOraxXoe5exitlrPzcC9OjQgXPswnCQCmP
         LKD1+/k2ey3vSS9geUnENFN8fQRSChvlyd/WWU4uoz4we75Uol2I0QeGDhr1c40D/Rvu
         CC8XAg7im/M+1OzKLRJnGZIIcrZww17crX25T1Bwub9XUo2m62/vAQODgAGRVRIZrOeP
         QO2yL+H8EQdv4jCQPA/Mjc73PgWeYQVYTVXaIqsiNrbwya//dqiD+jI9yFdCcdllVwDN
         vEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733742446; x=1734347246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjzDeyeOaWumKUh5rU1ojNga2tt2q8VFzErpCwuxoMk=;
        b=R3y68F0H2YPpVP8Cg+wxW0+E3s7F2uMek2CPkioQiu4yOwiEh0vKqDS89A5/PAUk5t
         MTxGDxKHN1pOh10vhbjU31Nw7tnmD4kvZBP04sk6W2K5RCdCrLbOO//vmobLDP8ByxMg
         nVrpdlsvzNopscwWM5nWFRpDIuH/qcjuajE+suGlI2bGJdVhRchZ9IeVY6i4PeUhuj9g
         m3HMnvBOT+spyqXyAZTKep6JCS6b87mXJvZhVl+ivk/0ts6osczp7ykaNMuDnDe0ACSf
         F0kn5Xjro2shlrT5R/D3Mf5A7xLcfmE+01sd79a4lrFcjZltb5Y27u98HVJKgTOciKDg
         Jrpw==
X-Gm-Message-State: AOJu0YwUAoR65BTn8Z5fc2k7Fhl0l3MVO+kAUwYFaJ6p1+aIArw2dQOD
	6g6OcLREeqBS8d61jC3cF8SAHP1aqfhg9diMJfCBZgwc23yn/MIaHzrPf5h0
X-Gm-Gg: ASbGnctcFoZECOlu9ORyUkxqBcyqe9MnTPVoO5S42L6CBvJogF/TdOuYU0Zw2BCHvQV
	EP9dE0S5uK/cFknj4Eq6qYIpmgWrALmcKRVrfgsRdZszsRli9arNqH/PPrKfFLBc05d9fl6isdd
	JSrOyGo24I41dRKFP9wyhokU3iDMoTJfsu159ubG8E4s6+gJ440y7e0AoNIGXHsEnbYjM886moS
	cuF6HCCoRB0fKx4qmogwxItJQEbRZrOpTsuaWxDbQdGMSUmZDKbkLg/wR84Bac=
X-Google-Smtp-Source: AGHT+IFHQ2AuiUUmt0nkzl/AANEuKrWbVwHJx8ziaCKvBsyjga0hBSojqdVmGKQ9OIUwoPyzyVKUww==
X-Received: by 2002:a17:907:9145:b0:aa6:8f39:5c with SMTP id a640c23a62f3a-aa68f3913c7mr180584366b.17.1733742445921;
        Mon, 09 Dec 2024 03:07:25 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:8256:2d00:9c39:c2d7:aedd:294d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa672d377fbsm257013366b.75.2024.12.09.03.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:07:25 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 09 Dec 2024 12:07:18 +0100
Subject: [PATCH 4/7] refs: extract out refname verification in transactions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-320-git-refs-migrate-reflogs-v1-4-d4bc37ee860f@gmail.com>
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
In-Reply-To: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2669; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=YCQQd9ym7xx16rPamjRXYJWagS28PovIK7X844HDYxs=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnVs9nUeZbXtgT6WErZe6adHPZCsBfQfQJvcTJ+
 ThLyLD06UOJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ1bPZwAKCRA+1Z8kjkaM
 f8P1C/9uRx518JkTI4lNKuEsTkSbbpd4863z2iawx95Ooa1PFIbfn8zJ7yZO3n37kAryaqwaXCw
 a+MS3R0qRjVdQxox9ryZ0amNTNNUQ30bRep12k9aMcU2nuZZawd+LyaEAvdjbSvAizoNEk4SdUZ
 ZcW7vtiomXvZq7OvXb8+qKpmXGHExw5+Hn7Bx/7EWvyg/wxkJ5M6mbId8UAebx3DaXL0YUsUKlv
 /TmFACbQHJAfHgCum+jhLuh0V1xKqwF7L+cEG02hJNmVvmsn2ivJn7Jw4EKTPr87ktMimEgM4zg
 GJJkxVO8122soiVyr+d/fxDsuPX1rFwYODLZqYVWuWpDgSHZRYrHq1GeWGjdJO6klDap5c3+Kt4
 dZivWdxQUOvzcb0fEVlD5rLpkYvRRifjgszRy17r47+RCgQX7z8H2xZBi2554gPgJr01jll5wCV
 WJE79uKzpSMO+9T5dMfJ/jpOTIWT85/IeySYIWeNZbOhHODNSJVjRyHKxiitm72noCasA=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Unless the `REF_SKIP_REFNAME_VERIFICATION` flag is set for an update,
the refname of the update is verified for:

  - Ensuring it is not a pseudoref.
  - Checking the refname format.

These checks are also be needed in a following commit where the function
to add reflog updates to the transaction is introduced. Extract the code
out into a new static function.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/refs.c b/refs.c
index f003e51c6bf5229bfbce8ce61ffad7cdba0572e0..732c236a3fd0cf324cc172b48d3d54f6dbadf4a4 100644
--- a/refs.c
+++ b/refs.c
@@ -1196,6 +1196,29 @@ struct ref_update *ref_transaction_add_update(
 	return update;
 }
 
+static int transaction_refname_verification(const char *refname,
+					    const struct object_id *new_oid,
+					    unsigned int flags,
+					    struct strbuf *err)
+{
+	if (flags & REF_SKIP_REFNAME_VERIFICATION)
+		return 0;
+
+	if (is_pseudo_ref(refname)) {
+		strbuf_addf(err, _("refusing to update pseudoref '%s'"),
+			    refname);
+		return -1;
+	} else if ((new_oid && !is_null_oid(new_oid)) ?
+		 check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
+		 !refname_is_safe(refname)) {
+		strbuf_addf(err, _("refusing to update ref with bad name '%s'"),
+			    refname);
+		return -1;
+	}
+
+	return 0;
+}
+
 int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *new_oid,
@@ -1205,6 +1228,8 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err)
 {
+	int ret;
+
 	assert(err);
 
 	if ((flags & REF_FORCE_CREATE_REFLOG) &&
@@ -1213,21 +1238,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
 		return -1;
 	}
 
-	if (!(flags & REF_SKIP_REFNAME_VERIFICATION) &&
-	    ((new_oid && !is_null_oid(new_oid)) ?
-		     check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
-			   !refname_is_safe(refname))) {
-		strbuf_addf(err, _("refusing to update ref with bad name '%s'"),
-			    refname);
-		return -1;
-	}
-
-	if (!(flags & REF_SKIP_REFNAME_VERIFICATION) &&
-	    is_pseudo_ref(refname)) {
-		strbuf_addf(err, _("refusing to update pseudoref '%s'"),
-			    refname);
-		return -1;
-	}
+	ret = transaction_refname_verification(refname, new_oid, flags, err);
+	if (ret)
+		return ret;
 
 	if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
 		BUG("illegal flags 0x%x passed to ref_transaction_update()", flags);

-- 
2.47.1

