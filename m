Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FD92C3257
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774779498; cv=none; b=XBrwoCJYiCyIrFpK8MA7LksJgf9ehgKJ3Ta9QrZ8D8tabX+p+T8KpS2L1KbiyI8ompeqpUlkSJEFIxf1Gbcn9LcOeHaLIric4xpoTkM+XxDSuDy0Pb68x1+323xdbNHE2T4nk9wjRAXvKFDtgmL+g1+0v0KsByUDjaKxtg5iteM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774779498; c=relaxed/simple;
	bh=tf3K8SjZAMWi+N0D/gbmRDWOkhrOr0jaLV6i8ot5DTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLpIOkpSq9pHlYG7InOzfsVu4mTEbz3qoROohcQu+EJHdfbX6C5v6z53CeUXJEWZiZTUT/zymhO5Uelc5ska6Kkdh+vuJeIKHWg/Os6NLud3Q1/zlKSBf73CfJrjH/YVTcqILhxM51Y4/ri01GLBg7dUaJoLmUy/fG0G5A1YD0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1Tkwiy5; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1Tkwiy5"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c73e9e4cdf7so1483646a12.2
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 03:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774779496; x=1775384296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+hB7jTEIMTlGhHWPKUzW8bqsVBUSBb2nVxFiwd8UvM=;
        b=I1Tkwiy5eVnyNxmQrkoMApcFH2AB+Ngno6lxy1foBY0yAfUvgeUSMOu7Wj66PAakDt
         wIbaeR28GhTinhBdHd3kEuc1Qgmoo40ZF6+jUtPsLMF8Om7oLnuuLESPjacV4hbmPrCj
         BMEpwdo76n5m0xPwRWZnF/d79di8+L7G8+FIJr2eopd8jX0iz7DwYCnGIk2xSysdQ8+j
         8G0FAc/XrkaMuflWaryQiiS5aTy7ofWP98qSpLFf3AOG+ccRmVIyy6c3csdJ+DI7laPI
         NM9H+i6altb5CMYttiTIhhqLW5MzAwZcEQMGmP9ZWXqlkXbX785si3pnFTAz/oeasViG
         SwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774779496; x=1775384296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J+hB7jTEIMTlGhHWPKUzW8bqsVBUSBb2nVxFiwd8UvM=;
        b=ntZQwvXguuaOHwyAwoArwX/ewRxX5NLMVoexB+nscGd8hllaHWWLu2nIhO2XWc5Zh+
         ldGP+FauJRayrlFk/rm1vc+gTJ8MeK2Ttsg2wo3chyV34iIonWrOPRVPvWxIEgCXWXl9
         A4A6do3oq1znjH4gHpfGAj9T9vHq7pLNMvsymAiKtVN5Ccd3HMp/zyo9OPJaeM9ih7Zy
         vbwPa3begKYZOqriTr/UGkTuAwk6ESJbAXYhU8qa+b+fHS1fGnv4VovPCLolfzIINBI0
         hQ/FM2CgnZCGuSvJe0sjQq/Paf34fmL533SYmgDweOm6qubY3WVaYdn43q+UAdPAl4k3
         W/5Q==
X-Gm-Message-State: AOJu0YyHTTpYmWoQCXlsBreFJUl86SN0ItDIrXam6P9egJF8VExJVOrs
	u2L+FpgijjFM5r1xrBJvLuJeNobjhGz/LNY+ikQ4uoj83mq4XgZ/ZZ0OsY8HcA==
X-Gm-Gg: ATEYQzy6LHVVZmt3Q2RziMb8MYT5w/4gTIFXcMc778+PnIwlpd1/336vsts+aR0Hsbf
	8qqCgrBvtx98fLBlgkXryEubNh/ohrVNONmDQSOd/CV1l6BHZp83sYwZ0BE7CsfU4Qb5v9wGpJX
	8NTjVXF9LjQ0TDiyRPGgh4urtPqfhHEDbNAbzsrNbiFjinDzhL7QPrx0XBQWF68p7UTRFdFvyEa
	RmAf2nzWuTXUNFvNusVJxpOPzdUWLpE5zRIrMqaBVZKVKeTl+oKOb1jzCs6m30BDr0R1xxw4xLj
	1FLLIYCzoQvvp4t1gBXd+5lyYJFY1q0OfOMXkBScJwV/3GnJP068FF/ke4A51Dsrk4UdnJtEMwc
	Xu3MRlKcIPQ7AcaXPSzL04VAlQEXC8FXaT8DU1gf3bpwFKSGLylSCSo4bCHzfBfsQps96UqciVT
	oRE1kFmTjtfTXPTHNr2wgQRiWcJwwCVveYmiIxZnDOutY=
X-Received: by 2002:a17:902:d552:b0:2b2:45b7:3078 with SMTP id d9443c01a7336-2b245b73b92mr45344815ad.3.1774779495892;
        Sun, 29 Mar 2026 03:18:15 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:88eb:4aec:6fcd:e3ea:7ddd:8d9b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242679bb3sm46199185ad.30.2026.03.29.03.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 03:18:15 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v3 3/5] refs: remove the_hash_algo global state
Date: Sun, 29 Mar 2026 15:46:41 +0530
Message-ID: <20260329101725.1092900-4-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329101725.1092900-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260329101725.1092900-1-shreyanshpaliwalcmsmn@gmail.com>
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
 refs.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 2f8c8427cd..d3abce0318 100644
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
@@ -1472,7 +1469,7 @@ int ref_transaction_create(struct ref_transaction *transaction,
 		return 1;
 	}
 	return ref_transaction_update(transaction, refname, new_oid,
-				      null_oid(the_hash_algo), new_target, NULL, flags,
+				      null_oid(transaction->ref_store->repo->hash_algo), new_target, NULL, flags,
 				      msg, err);
 }
 
@@ -1491,7 +1488,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 	if (old_target && !(flags & REF_NO_DEREF))
 		BUG("delete cannot operate on symrefs with deref mode");
 	return ref_transaction_update(transaction, refname,
-				      null_oid(the_hash_algo), old_oid,
+				      null_oid(transaction->ref_store->repo->hash_algo), old_oid,
 				      NULL, old_target, flags,
 				      msg, err);
 }
@@ -2379,7 +2376,7 @@ struct ref_store *repo_get_submodule_ref_store(struct repository *repo,
 	subrepo = xmalloc(sizeof(*subrepo));
 
 	if (repo_submodule_init(subrepo, repo, submodule,
-				null_oid(the_hash_algo))) {
+				null_oid(repo->hash_algo))) {
 		free(subrepo);
 		goto done;
 	}
@@ -2571,14 +2568,14 @@ static int transaction_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_
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
@@ -3145,6 +3142,7 @@ struct migration_data {
 static int migrate_one_ref(const struct reference *ref, void *cb_data)
 {
 	struct migration_data *data = cb_data;
+	const struct git_hash_algo *hash_algo = data->transaction->ref_store->repo->hash_algo;
 	struct strbuf symref_target = STRBUF_INIT;
 	int ret;
 
@@ -3153,7 +3151,7 @@ static int migrate_one_ref(const struct reference *ref, void *cb_data)
 		if (ret < 0)
 			goto done;
 
-		ret = ref_transaction_update(data->transaction, ref->name, NULL, null_oid(the_hash_algo),
+		ret = ref_transaction_update(data->transaction, ref->name, NULL, null_oid(hash_algo),
 					     symref_target.buf, NULL,
 					     REF_SKIP_CREATE_REFLOG | REF_NO_DEREF, NULL, data->errbuf);
 		if (ret < 0)
-- 
2.53.0

