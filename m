Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC27D7602B
	for <git@vger.kernel.org>; Tue, 14 May 2024 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715690658; cv=none; b=slBwf1D5qIOqiYkXazTwGkUpIP7K/Ln4WbowLLo9vrO4XN1vM0gcAWTmHLo81CzZSwFOqoTelNq245szCITnZNZt/q1q7VTJVHp/WQN3ZwyLo3MjSUOJGmHHrZyODi4RN6hx9QbSiO6vxl4rVG8ytZIca5rgKbwdwz9EAUO0Xmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715690658; c=relaxed/simple;
	bh=KgA2jC44PpTa+28JFgW5tZEP7a/G3RSFnF53ijNDPiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNjowwH6cXrzzAULpO1Ig+6q5wgcO8Ogz5G7a2BgSmc8y/C3s4rwIgPKhzRyab1DNj1glGeEPWR+bfiym9B446X0uB7ug7zlmJCKg0yW0IPHxVmQ+nETF80qsBl989ana2Q3rbB6MWrVNwVHY1DNf35/glNlNOgmVEGZgRYF0tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RI/hdyL4; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI/hdyL4"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59a609dd3fso4942566b.0
        for <git@vger.kernel.org>; Tue, 14 May 2024 05:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715690655; x=1716295455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qRNmx8sfuubAEq7EZzRrw6AhcgYR8Hnw0Vxj6RbbPw=;
        b=RI/hdyL4tx8QU6y71yZsusDzbLw37QizYKeh/z1KAfNBNbkBQPG2ZHidZi+/tHEmZo
         m08tScIF0J4ggLTVEluMZGvKQCm+/n9l3KDORis7Sob3GzzW7eZWJwfNwsK9GCH/GQTb
         HAwwol2LfjuyWtACojNMHpQBcgr157Cq4TVD3j343Gdy6oAv5fQn2PTSwvy7oYzmYqeL
         56QJmGE+2PBUiofaHst+XuOGMpUFAC3TxIZ6woJcJ61imDCXITJS4SbGHDRXcCqbOES+
         H493A0U10zDw63asbAgxPDT399zCUJByZnJrXTUK9EeekBcM/FZkKBvJ8bsaTuC4HbC0
         xlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715690655; x=1716295455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qRNmx8sfuubAEq7EZzRrw6AhcgYR8Hnw0Vxj6RbbPw=;
        b=B/u7kpt6hyr8+ylMuGfxgGivp+dmklsTZDfHEP+N9oMzwmwt806crv+Yov+PjHMGUU
         F77S9KVNSa2qyrpdDz/QKxqrLFySQvs372zIVnMPjH41N8NdnAJiAdeiMH6LPBgXu5Dl
         FPLe9hfnJLX7PQD1SWLOBxVax6LZ9FSUdvOIl8nlBE7aU+glYdi9xwoPWVywMF2q544o
         UrSnTh3G9uWC7/rOampjekAnSxL8CCGJOARpWFcOjH8MItVFsippYMjo/7Z4vUcLCvQf
         EC3FKP2rng3MgY/jzSvKWx9/jj7hbHjFCfDDXTsqoAloHd6aHX78upZGQUo6iw6kQr6u
         iZYQ==
X-Gm-Message-State: AOJu0YwocLNYrVsqdUtd2XkRh+SD98iJIDR/Qn+YmT4yA8ujdJEL+GAi
	210pe0anYwrSymTrTks8MGK3vhCxvU0LFvs/Zgx4EBVZtgmbsLo5
X-Google-Smtp-Source: AGHT+IEQ+nOgE4szKC2n6w/UCy4WYGEpzwRvZfzVCrUGAsCy/nz8Qh4ZkZ4b7MNnltl7yr54JUjUiw==
X-Received: by 2002:a17:906:7c59:b0:a59:c62c:344d with SMTP id a640c23a62f3a-a5a115e7606mr1343695366b.9.1715690655141;
        Tue, 14 May 2024 05:44:15 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b019edsm730530566b.174.2024.05.14.05.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 05:44:14 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH 1/6] refs: create and use `ref_update_ref_must_exist()`
Date: Tue, 14 May 2024 14:44:06 +0200
Message-ID: <20240514124411.1037019-2-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240514124411.1037019-1-knayak@gitlab.com>
References: <20240514124411.1037019-1-knayak@gitlab.com>
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

So let's export this to a function called `ref_update_ref_must_exist()`
and expose it internally via 'refs-internal.h'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 6 ++++++
 refs/files-backend.c    | 3 +--
 refs/refs-internal.h    | 6 ++++++
 refs/reftable-backend.c | 2 +-
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index fa5471d219..59858fafdb 100644
--- a/refs.c
+++ b/refs.c
@@ -2863,3 +2863,9 @@ int ref_update_check_old_target(const char *referent, struct ref_update *update,
 			    referent, update->old_target);
 	return -1;
 }
+
+int ref_update_ref_must_exist(struct ref_update *update)
+{
+	return (update->flags & REF_HAVE_OLD) &&
+		(!is_null_oid(&update->old_oid) || update->old_target);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3957bfa579..2df204f891 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2411,8 +2411,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			       struct strbuf *err)
 {
 	struct strbuf referent = STRBUF_INIT;
-	int mustexist = (update->flags & REF_HAVE_OLD) &&
-		!is_null_oid(&update->old_oid);
+	int mustexist = ref_update_ref_must_exist(update);
 	int ret = 0;
 	struct ref_lock *lock;
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 53a6c5d842..5da3029e6c 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -765,4 +765,10 @@ int ref_update_has_null_new_value(struct ref_update *update);
 int ref_update_check_old_target(const char *referent, struct ref_update *update,
 				struct strbuf *err);
 
+/*
+ * Check if the ref must exist, this means that the old_oid or
+ * old_target is non NULL.
+ */
+int ref_update_ref_must_exist(struct ref_update *update);
+
 #endif /* REFS_REFS_INTERNAL_H */
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 98cebbcf39..975061d103 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -825,7 +825,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 					      &current_oid, &referent, &u->type);
 		if (ret < 0)
 			goto done;
-		if (ret > 0 && (!(u->flags & REF_HAVE_OLD) || is_null_oid(&u->old_oid))) {
+		if (ret > 0 && !ref_update_ref_must_exist(u)) {
 			/*
 			 * The reference does not exist, and we either have no
 			 * old object ID or expect the reference to not exist.
-- 
2.43.GIT

