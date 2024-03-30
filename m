Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1102A45974
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711838796; cv=none; b=SCncWp4jQyfpdLMQFPwdhsYT11xC8KLPmR0Y7+texAsVgsQOIby2o+/9dpkQwrwZX0RfVZNhQzVjZ5+oNaCywVEt7Ehu9wFUOzbdxYMzS2fHR+YQh6CAkVul6qhLu5bMZ2N0/ceqqByB8kPt1cZG74qw4r5YfP50VzE7FwaH1kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711838796; c=relaxed/simple;
	bh=oz0nUYEbob5ei7Mc0yZWRkKwbqeYmbkG4MCjy8Ns1vA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTNCPjXSZMWb+EOK728o77cxwA+MuclDOJkjte6exknVku7SY9224soFMc2M+UeRtZLcEDfuGPaI0LECgi9KKMjBXNsIN6JHBKHhh29E2wdPJIfoPLEM+//umt8Gg2STI322skXWVHuB328JnLQ2qKmNkX0odxdQixYWHjEnmXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3Is2scr; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3Is2scr"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4e0e3ef357so386959866b.2
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 15:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711838793; x=1712443593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0gDHTxpd/4lujMbr9UO7uvM+ApEAO4Xxdgj4x9P7BU=;
        b=k3Is2scrMTRIjHmSBmmEOogrAdkD9mdmDLr924ehH8NwF6mwyotBUz2XVNmJepd84Y
         Ns+H5Inu5XNo2Y1KYWc9LZrFThZRfUSDMg5HFe1JD617O0OVueR9dS4moy1oDEfy9JRm
         O+4C/5FZZa5nvwEsJR9YgMao7ThCnyE/0gQczMpBIblvoZjDp6XkrHotdApJ2ocgQjF/
         g2D90qVhNyDJbBRCJt1F2Ii8al1KQ8ryh1VDYzxZXbLunN3tzg87inrFU5aeubYyiU9H
         t2q3IHutTy/V2VG1xaCQEi0Sk94XNJVGvoJXKT96kkzkvtR8c1tO6GusXAarCZ8LIg+u
         N4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711838793; x=1712443593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0gDHTxpd/4lujMbr9UO7uvM+ApEAO4Xxdgj4x9P7BU=;
        b=vyOjMUkDfQA4Y3pIStgT+rLELD/HTu04Mc6v++rK59aj2Oq7RBN2ed2cvVEFeyjJcv
         1IKTAmFeyqLpX0FwSn8OYTldQAEa2yXZKaDOvCKcP0Vgvkk1HaMehEPEYwa4n3OrAXtn
         cNHgtQ+4C8aT9R1VzNzIJeUXsgXwdK8QXEcyV88hfMh9a/jD2TsesI10rFW/KndhHFPk
         hOAN4mWFZz0M7OQZzLMdg7WIN5gkRVPKA8jTvbXXV7GPH5S+42R/MsraBun3bOZdmdR/
         8VPlKcNvh9wb6K2X+vWTqVnW3v0PAyFbfhOrXgG99xFJ7o0xAwoKdsndbboW50dd+Iww
         fr6g==
X-Gm-Message-State: AOJu0YyKF3hBBtxg9BLUWhlN1qUuKl9vo5oaXCq40WSSkeVd1DbuWpKa
	8bLAkBZ+tTT/4S0n9fB4w2ONaJtjZ4kFyfmzx32/8lgv3AwXnN1tmqSTodp0gOg=
X-Google-Smtp-Source: AGHT+IHxEF8VbApaAmyflVqnl1PwHF6qsYxsi3zj7eLroAHPrRswtUHW34jiVMQJVK8iAIvmywczwg==
X-Received: by 2002:a17:907:72c6:b0:a46:13d5:46fe with SMTP id du6-20020a17090772c600b00a4613d546femr5435904ejc.11.1711838792800;
        Sat, 30 Mar 2024 15:46:32 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:9f01:e67d:4cf3:c3bc])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090637d300b00a46cc48ab07sm3533580ejc.221.2024.03.30.15.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 15:46:32 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 6/8] refs/reftable-backend: add support for symref updates
Date: Sat, 30 Mar 2024 23:46:21 +0100
Message-ID: <20240330224623.579457-7-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330224623.579457-1-knayak@gitlab.com>
References: <20240330224623.579457-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

Add support for transactional symbolic reference updates in the reftable
backend.

While this commit is setting up the reftable-backend to support symrefs
in transaction's. It will only be used in a consequent commit, when we
wire up the `update-symref` option for `git-update-ref`.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/reftable-backend.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 92f2803e90..35f2e8e050 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -884,7 +884,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			new_update = ref_transaction_add_update(
 					transaction, "HEAD",
 					u->flags | REF_LOG_ONLY | REF_NO_DEREF,
-					&u->new_oid, &u->old_oid, u->msg, NULL);
+					&u->new_oid, &u->old_oid, u->msg, u->symref_target);
 			string_list_insert(&affected_refnames, new_update->refname);
 		}
 
@@ -909,9 +909,11 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 
 			/*
 			 * There is no need to write the reference deletion
-			 * when the reference in question doesn't exist.
+			 * when the reference in question doesn't exist except
+			 * when we want to create new symrefs.
 			 */
-			 if (u->flags & REF_HAVE_NEW && !is_null_oid(&u->new_oid)) {
+			if ((u->flags & REF_HAVE_NEW && !is_null_oid(&u->new_oid)) ||
+			    u->flags & REF_UPDATE_SYMREF) {
 				 ret = queue_transaction_update(refs, tx_data, u,
 								&current_oid, err);
 				 if (ret)
@@ -963,7 +965,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 				 */
 				new_update = ref_transaction_add_update(
 						transaction, referent.buf, new_flags,
-						&u->new_oid, &u->old_oid, u->msg, NULL);
+						&u->new_oid, &u->old_oid, u->msg, u->symref_target);
 				new_update->parent_update = u;
 
 				/*
@@ -1026,6 +1028,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		 */
 		if ((u->type & REF_ISSYMREF) ||
 		    (u->flags & REF_LOG_ONLY) ||
+		    (u->flags & REF_UPDATE_SYMREF) ||
 		    (u->flags & REF_HAVE_NEW && !oideq(&current_oid, &u->new_oid))) {
 			ret = queue_transaction_update(refs, tx_data, u,
 						       &current_oid, err);
@@ -1187,6 +1190,18 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 			ret = reftable_writer_add_ref(writer, &ref);
 			if (ret < 0)
 				goto done;
+		} else if (u->flags & REF_UPDATE_SYMREF) {
+			struct write_create_symref_arg create  = {
+				.refs = arg->refs,
+				.stack = arg->stack,
+				.refname = u->refname,
+				.target = u->symref_target,
+				.logmsg = u->msg,
+			};
+
+			write_symref_with_log(writer, &create, ts);
+			if (ret < 0)
+				goto done;
 		}
 	}
 
-- 
2.43.GIT

