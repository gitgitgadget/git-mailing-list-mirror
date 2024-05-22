Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9225480607
	for <git@vger.kernel.org>; Wed, 22 May 2024 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716368614; cv=none; b=iaLwoLjkecSwCzLmK7YktpCdjoM0meN69QpDFj/vOl177nGG9+QY/3TJryfvEkOKlJvzU4xE0dDY4ki7gAGxsMBtIlRw6u6SGylimmoH2a7TgWMyrgZ+fh1oY2hU9qWj+9Py9mpyO6lKHMmkkK4xl2rID26VsN6zxAupvLN/0oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716368614; c=relaxed/simple;
	bh=h99lto38gvDSFS+LM7fh69jI+qhFIxdReuA5l1HWbGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9Y46W+TLqnyvQqVA86CgFogIfqgwzp+AL8lO65PNfIE86IRHuuMlXxPr7CdEInGOOEKOYEU+JsQjTiV5NSUs7xDc4quPtDKZX1JB7fwgVwy57AvMzbcRHTUVwgNAqxHLX4ZoX1qVV5uYjGBr7p6dJtpK+AaC8KJd+nRowrrrZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhZxe/In; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhZxe/In"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-572669fd9f9so9921885a12.0
        for <git@vger.kernel.org>; Wed, 22 May 2024 02:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716368611; x=1716973411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdWWKo/gycfWwrs6jjjSXW/PKVbEMO/4cVQB+ft7/r0=;
        b=lhZxe/InnnqymV2FmYiqNljbBV4qB2opuX0WkIl+TleMEv++p0b46suwg2rOkpgceJ
         duE9QXYXn/pZdo1yo3V2e9A6zqpy95MxNZCORD+6JRK3RI1QBWykYi9T7RkdYjJfWqTu
         2HEF7qpCuBOhszulKsvkVRVkvbfDrTZfe7CT+WTlPH4doxQhN55QTlvTGEniMyGMU0um
         4O+kidHHxyWQYSh9GuNRz2SYPeLaI9Rppn7X9Mln5mBgG+jswOa2Fye401ftWv+pyE5b
         ddrdgPonTRrYVwauUR9FkjtFty50KKRKiG3xDAX6+92zdSWueYUL+yBI7mEESDeN/H9W
         df9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716368611; x=1716973411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdWWKo/gycfWwrs6jjjSXW/PKVbEMO/4cVQB+ft7/r0=;
        b=bDAkaHe39rdtv+2504u5vb3eS6eZbixo5eEc2T97g4vRj65Y25ebLDPs+xslHN7bEL
         vAtsWojIvp7iK1oRaFdpxtC2SYcuz4HwyoCJSuqXnYl+OehhMosV/QdTrxxIXlvUv0j9
         uCMpSY18qeqUjnkRkfdYfaU7H+Fz3U/l06uWVkTPFHIFxuwzS7nedQeW9vcUCqIhf8ez
         yWPO9/neBju9aVM3Wj2wkpFcf57Z6Brg6pZGmCaufwQRe+Cr4NEjLPWIMx1NRr2rJ9eW
         MIn0u/2DQbBGCokdX/J8erZIiWaXOXfUdMgHFgYUQhRgoZ475MHeB4imxoqFLuTt21+3
         q0Nw==
X-Gm-Message-State: AOJu0YyR9Wg4tqQp5/77X0184n2rt7XBpz4W88+AjqirxST5bYGVoIMT
	x1ZCbqR3nN4eEJC7ZtIdNOxIfIlDSVgJ/2FyhE7F2bYQjlmNFtasvHuG49w9
X-Google-Smtp-Source: AGHT+IFjgacEF2Y4aKR/I4JBGAu73mSLetfGq/F7lrYPTwfWovGukimzmE6oFNdUm9ZOD+dmskKofA==
X-Received: by 2002:a50:d6ca:0:b0:570:369:3e06 with SMTP id 4fb4d7f45d1cf-57832a96712mr865989a12.19.1716368610705;
        Wed, 22 May 2024 02:03:30 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:414d:df4b:1d67:e754])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57509d459desm8281354a12.61.2024.05.22.02.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 02:03:30 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v2 1/6] refs: create and use `ref_update_expects_existing_old_ref()`
Date: Wed, 22 May 2024 11:03:21 +0200
Message-ID: <20240522090326.1268326-2-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240522090326.1268326-1-knayak@gitlab.com>
References: <20240514124411.1037019-1-knayak@gitlab.com>
 <20240522090326.1268326-1-knayak@gitlab.com>
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

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 6 ++++++
 refs/files-backend.c    | 3 +--
 refs/refs-internal.h    | 6 ++++++
 refs/reftable-backend.c | 2 +-
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index fa5471d219..00e87f8ee3 100644
--- a/refs.c
+++ b/refs.c
@@ -2863,3 +2863,9 @@ int ref_update_check_old_target(const char *referent, struct ref_update *update,
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
index 3957bfa579..ef760869ca 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2411,8 +2411,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
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
index 98cebbcf39..dc7aa7f274 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -825,7 +825,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
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

