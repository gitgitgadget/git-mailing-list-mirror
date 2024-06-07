Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ABA19AA5B
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767192; cv=none; b=mtiT1KtlIELRGxj4Vrr/q+JuPBWXwh08hea1/dgRKS/eDnjPD/skmX282XbNxJqkoko1ouC246TMLiLSiY51YWKn/XWfDfe8Ga153Rl7X0qADKdDDmp6JnAZkw+Gou67hqgFNHyt23aF+jNbj1CW8VXp411l+N8lc3V6CH/M/Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767192; c=relaxed/simple;
	bh=t2Sh2uOYymZ8PY1NxFZ+tdvRzLosECEg/jwYIX9U8wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rp+mmOGEsGE1PYnfXD9pxTOEfA0DdECgN/5TBKqtsSrz3zzdAnoBB3Ht2pga2tpFsdxsmVpmMj7Wd8O+DMXcB2CNoUrW9jNdijYw0FdgdL7kSxX8U44eKicJjGM5OlCqBpPOiwhZbF3CvTDpkVsQM/uXll6MPzuAhRA+1zK4Hcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVPdWEss; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVPdWEss"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57c60b13a56so417682a12.0
        for <git@vger.kernel.org>; Fri, 07 Jun 2024 06:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717767188; x=1718371988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/VAe/ORVbUECRLIQtAb+P3zV3BjjcPefMr5fQ54+9M=;
        b=GVPdWEss7/ppWYcjV0n7qjfE7uOTI3Vh50Zaf4d7ArOsl4rqx5Mqqy79RY5UkoyM8C
         kXaTF5mHsaaSDUgwfrUOYf5pATJ0r/Sg09tG9lhD+uj1Ba3dSiD5GxU2Gb0FW8G5x3pD
         okgZDEzZfFFgPNsZq9xzZjmi+Fyaeyhg5j3pgr/OWhqVJAP95RkyXvQil3vqcSzhwtAL
         Hbd4skHXapfOdXIByRO7Fv3JrzvsorLzwH6/0ZjuMSiKHV+LNp+dJ5QfRDSKY8WfaKyE
         swhQ2eLqjgN2d94zTwirzb/sQe6ztU8C/gAjad117G0fk521IJ5B4eRBEDyoRNWcmI0G
         +uLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717767188; x=1718371988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/VAe/ORVbUECRLIQtAb+P3zV3BjjcPefMr5fQ54+9M=;
        b=kNe2UNGaN/ItgJ8rF28r/BkSSPiG9j/dTlSi8ha5xrBs2U5bowC9lztUW3K4vBRqo6
         fotd0nRv+97NMi18lYwIs6eOB7iftUq6nyDGj2MRYBJWKaWNxzNaly9rOJr+qps4Y+VV
         rFBlIeXXsvUnQlUO55u1AcalNO1/CC1PJ3qjhv5Ssmd4+NNXCpUMsGqkB/ApyZ4lRqjK
         8zm2s5Xkru0UcOKdYJJ1C6+vZZaRLMu/wsoN6cKF9DpWo6Lnor46rJs2slSom5skqsxI
         lp8T45h1vzRnteb8IbJ4ejkQLEjo0zBPwLf4rgpPGNBYoMUPSZxljE+NG89v6OHq7c7S
         dESw==
X-Gm-Message-State: AOJu0YxHkhRB0EL7MmmYCiVXEKMiP6bJYXUg2PgUklPgo8ZwWfsMkr2b
	p1HpZPrnnR8VD93uWTMq4Hh5lOgyoARUsfXo7Dm3VtPX/RRQ+Yi5HqQ9LJph
X-Google-Smtp-Source: AGHT+IFQ8eOGtpIaCBfOPJ20VudUroU3iW6VyCgW4NGnGI3x+FmIx9GEoS8pcCrz3VJoVB9jQBKvNg==
X-Received: by 2002:a50:d79c:0:b0:57a:259a:489a with SMTP id 4fb4d7f45d1cf-57c508921b8mr1623650a12.14.1717767187356;
        Fri, 07 Jun 2024 06:33:07 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae2340f6sm2764167a12.90.2024.06.07.06.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:33:06 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v5 1/7] refs: create and use `ref_update_expects_existing_old_ref()`
Date: Fri,  7 Jun 2024 15:32:58 +0200
Message-ID: <20240607133304.2333280-2-knayak@gitlab.com>
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

The files and reftable backend, need to check if a ref must exist, so
that the required validation can be done. A ref must exist only when the
`old_oid` value of the update has been explicitly set and it is not the
`null_oid` value.

Since we also support symrefs now, we need to ensure that even when
`old_target` is set a ref must exist. While this was missed when we
added symref support in transactions, there are no active users of this
path. As we introduce the 'symref-verify' command in the upcoming
commits, it is important to fix this.

So let's export this to a function called
`ref_update_expects_existing_old_ref()` and expose it internally via
'refs-internal.h'.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 6 ++++++
 refs/files-backend.c    | 3 +--
 refs/refs-internal.h    | 6 ++++++
 refs/reftable-backend.c | 2 +-
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 8260c27cde..50d8d7d777 100644
--- a/refs.c
+++ b/refs.c
@@ -2679,3 +2679,9 @@ int ref_update_check_old_target(const char *referent, struct ref_update *update,
 			    referent, update->old_target);
 	return -1;
 }
+
+int ref_update_expects_existing_old_ref(struct ref_update *update)
+{
+	return (update->flags & REF_HAVE_OLD) &&
+		(!is_null_oid(&update->old_oid) || update->old_target);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5f3089d947..194e74eb4d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2412,8 +2412,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			       struct strbuf *err)
 {
 	struct strbuf referent = STRBUF_INIT;
-	int mustexist = (update->flags & REF_HAVE_OLD) &&
-		!is_null_oid(&update->old_oid);
+	int mustexist = ref_update_expects_existing_old_ref(update);
 	int ret = 0;
 	struct ref_lock *lock;
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 53a6c5d842..ee298ec0d5 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -765,4 +765,10 @@ int ref_update_has_null_new_value(struct ref_update *update);
 int ref_update_check_old_target(const char *referent, struct ref_update *update,
 				struct strbuf *err);
 
+/*
+ * Check if the ref must exist, this means that the old_oid or
+ * old_target is non NULL.
+ */
+int ref_update_expects_existing_old_ref(struct ref_update *update);
+
 #endif /* REFS_REFS_INTERNAL_H */
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 1af86bbdec..b838cf8f00 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -824,7 +824,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 					      &current_oid, &referent, &u->type);
 		if (ret < 0)
 			goto done;
-		if (ret > 0 && (!(u->flags & REF_HAVE_OLD) || is_null_oid(&u->old_oid))) {
+		if (ret > 0 && !ref_update_expects_existing_old_ref(u)) {
 			/*
 			 * The reference does not exist, and we either have no
 			 * old object ID or expect the reference to not exist.
-- 
2.43.GIT

