Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EAF3FAE14
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774457342; cv=none; b=I9QExYrC9wFqT66mOVVLJYd7tmJ0qBlcTi6Au0GRo3DOBKdatdJAcx9m2GwN89yljOofgObYkLBDH+Dl+SowuyY/mOCpn1QFr7SAUDDRaJJYpULez3s1Ol0OnpR4+cLvH4PNNMPewTaLNwlaKd7L3UvUJXISUqT7LxzuESQHXf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774457342; c=relaxed/simple;
	bh=Ze7BnbRejTgjazYqgQ4wrDedwKJZ7lAixMJjRMtrvAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZRNhUhIjlK/XRf630EZQQQs2exdmDWya6lbSNamoYbU6XgPCe6rpBZVvuPMDGJwwu1y1hE+2TS3looTl7y/9vloRMzccmn3dACR67d+yzQuK/O8doSLp4a7uXZf2SN8h6vefBWnCWdjj7N4Ih+DEDKqleYC6LUV0v9dx5lXr10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIxNAkgz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIxNAkgz"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b06d33e84cso84215ad.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 09:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774457339; x=1775062139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDbxU/RMOAV4SxJ5WYl3nrQ3K++VijFT42Wqwug3qew=;
        b=gIxNAkgz6prPfrPKYXE1LMXL8rLa3LMsf1rBrwgySDe9TsTGLLmNsIoPBh+w1lVsYc
         gDeX0pmVaHv0t1VBuMhtMrjq4GIimuWlPnbPAlncOQTnl3v1u9kqJr5c3K8n8APVSFjq
         PEpg24eM/Y08tCNx6F9IybWhun5z3CP7kjeg6sULN2BwsJEoB946VTzXkuihrhXCb+HZ
         VDnIxlfERrRcpa2CIRCzee5WRN78oWLwAIqER0JS32yxSUQ24TKhM6VjshZfDU3sCBYg
         K8daLwP4iCwC/Osbwt3zcZ9F/h3vLrb38aaVlxBGY6B8IhreN2qPSz6E7YxXKgIvq/lf
         0dsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774457339; x=1775062139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lDbxU/RMOAV4SxJ5WYl3nrQ3K++VijFT42Wqwug3qew=;
        b=M8uF/ZOxQO0pC+ZySs33jmRWq7EykVDj0hp5jLB6w7ss378lKWRNgqrDl3q9EW8llv
         avs17y8xFMHhLqKQLJThbYQsDONfkPQuhRn+jnAc6/v556Eq5Z8JkawVVF1d9NtCn87x
         5BnBUkBrKAQ4FiAwPuXfegXv8QEIER/9CVmEgT5VqpiOZqFfNyA6J/1XVv+2LnxGm4TW
         CD8IUK/11bXw1S3Lhd2ymO5E50hXH6BKEqj0FYL8Sz2bdjd4y81Auhz3Fr5dnZiga3k/
         S0Nmotp1+Zc4p/awUECO2SkpvkDXQPbNuHcSmdu8GFZ+vknEwLHav4BqVcoH9Fnz40Hi
         aa8g==
X-Gm-Message-State: AOJu0YyfBj4EZV1/IlHga/JwvENtLSFY1RvmGcVYGkr2xIRBxyTUaMgZ
	/phkpZsQcUW3r9wzROzdGS32tMzjzBxxEILGk5Ij7gt7ZnZ1Utv4aY3sfk+bwg==
X-Gm-Gg: ATEYQzwiZAFlvgqz2rasK8ScI0d7ANWhxbEswJd+cupoUocj3iO8ytYGgy9Gsf4ECJR
	l9AUYRRbbqK2rFEh6W0tHTcq4TTV1bvF0esYplNb8ZSaezL0ql/ToVatb74yWbV9FqR0rrQw+jt
	CdA/qESH4a67Dr+5+g/DPmE5BdeSk59cOW/gENgN8RvzpkADHFIZUF3NLklOQjvlqEux1h4ofxx
	yLu9WuYbsycRBqJ83VtP6oU+0YhBqFHaxH4YjncOQcYY412tsRkWymgdbh8QzN/voqFonnAbyxf
	wABY9Oon5iO0TLSntMGV6VvTWx72VHgNIUfPT4TVQl6OYGl/DpmB5mtaniPlELqp8oIwt39FBnl
	BsGLHN8hQSF5su9MhYSZAU2YzVR5C3gpNJSXQVj5n+kr6By7soIlmvpzcvZ8RYDIfuXnVLcJVmv
	3Br/TyClw6vb9zj26907n1FkElMhKmynKle+7G+Qthbew=
X-Received: by 2002:a17:903:904:b0:2ae:c5fc:b2ef with SMTP id d9443c01a7336-2b0b0ab4cdbmr42989605ad.30.1774457337949;
        Wed, 25 Mar 2026 09:48:57 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:88eb:4aec:6f26:76cd:bafb:15d6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76ba80sm3901275ad.2.2026.03.25.09.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 09:48:57 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH 3/5] refs: remove the_hash_algo global state
Date: Wed, 25 Mar 2026 22:14:20 +0530
Message-ID: <20260325164833.1216577-4-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

refs.c uses the_hash_algo in multiple places, relying on global state for
the object hash algorithm. Replace these uses with the appropriate
repository-specific hash_algo. In transaction-related functions
(ref_transaction_create, ref_transaction_delete, migrate_one_ref, and
transaction_hook_feed_stdin), use transaction->ref_store->repo->hash_algo.
In other cases, such as repo_get_submodule_ref_store(), use
repo->hash_algo.

This removes implicit reliance on global state. With no remaining uses of
the_repository in this file, drop USE_THE_REPOSITORY_VARIABLE and the
dependency on environment.h.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 refs.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index e7256b3a84..7762babf5f 100644
--- a/refs.c
+++ b/refs.c
@@ -2,13 +2,10 @@
  * The backend-independent part of the reference module.
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "advice.h"
 #include "config.h"
-#include "environment.h"
 #include "strmap.h"
 #include "gettext.h"
 #include "hex.h"
@@ -1473,7 +1470,7 @@ int ref_transaction_create(struct ref_transaction *transaction,
 		return 1;
 	}
 	return ref_transaction_update(transaction, refname, new_oid,
-				      null_oid(the_hash_algo), new_target, NULL, flags,
+				      null_oid(transaction->ref_store->repo->hash_algo), new_target, NULL, flags,
 				      msg, err);
 }
 
@@ -1492,7 +1489,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 	if (old_target && !(flags & REF_NO_DEREF))
 		BUG("delete cannot operate on symrefs with deref mode");
 	return ref_transaction_update(transaction, refname,
-				      null_oid(the_hash_algo), old_oid,
+				      null_oid(transaction->ref_store->repo->hash_algo), old_oid,
 				      NULL, old_target, flags,
 				      msg, err);
 }
@@ -2380,7 +2377,7 @@ struct ref_store *repo_get_submodule_ref_store(struct repository *repo,
 	subrepo = xmalloc(sizeof(*subrepo));
 
 	if (repo_submodule_init(subrepo, repo, submodule,
-				null_oid(the_hash_algo))) {
+				null_oid(repo->hash_algo))) {
 		free(subrepo);
 		goto done;
 	}
@@ -2572,14 +2569,14 @@ static int transaction_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_
 	strbuf_reset(buf);
 
 	if (!(update->flags & REF_HAVE_OLD))
-		strbuf_addf(buf, "%s ", oid_to_hex(null_oid(the_hash_algo)));
+		strbuf_addf(buf, "%s ", oid_to_hex(null_oid(transaction->ref_store->repo->hash_algo)));
 	else if (update->old_target)
 		strbuf_addf(buf, "ref:%s ", update->old_target);
 	else
 		strbuf_addf(buf, "%s ", oid_to_hex(&update->old_oid));
 
 	if (!(update->flags & REF_HAVE_NEW))
-		strbuf_addf(buf, "%s ", oid_to_hex(null_oid(the_hash_algo)));
+		strbuf_addf(buf, "%s ", oid_to_hex(null_oid(transaction->ref_store->repo->hash_algo)));
 	else if (update->new_target)
 		strbuf_addf(buf, "ref:%s ", update->new_target);
 	else
@@ -3154,7 +3151,7 @@ static int migrate_one_ref(const struct reference *ref, void *cb_data)
 		if (ret < 0)
 			goto done;
 
-		ret = ref_transaction_update(data->transaction, ref->name, NULL, null_oid(the_hash_algo),
+		ret = ref_transaction_update(data->transaction, ref->name, NULL, null_oid(data->transaction->ref_store->repo->hash_algo),
 					     symref_target.buf, NULL,
 					     REF_SKIP_CREATE_REFLOG | REF_NO_DEREF, NULL, data->errbuf);
 		if (ret < 0)
-- 
2.53.0

