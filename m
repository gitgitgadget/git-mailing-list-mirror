Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB87A34B194
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 12:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775218221; cv=none; b=DDsKCNejBrJJkAVRlzmPRm9/DsNpNWtl51InNUBxMxBBYdonASjg65em/8g0bUIGKaBOr79fkapadu2lUEswIeJT0UKltwQKOMnLPxlvWpAqUQHAeaYakCOpeR9muvgwZdgU9LqKqpDaFcViukXqLC2jBDqf60gh9PXeRqI1AgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775218221; c=relaxed/simple;
	bh=IPgM5mj1E3cTtxv0qSpJ4671xY852u/zUPxqBU/WUrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHoQsd6esLhazQo0dAM2LCeuFe7LXRz6xGe7xepY0LyM8QoEOKuGE/fJvDgtlPsxmLHfo4t/7rgivw+J6ENhUML9bQ/9Y6iQ9kP974plwCHQOthLjFmkK4vmZ1ChVsWolpa1A+KRtQkiwOtJ7I008XSMEa6LDtiZ28NYRPNsOv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkTCtn9L; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkTCtn9L"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82cd9d0eceaso1427589b3a.3
        for <git@vger.kernel.org>; Fri, 03 Apr 2026 05:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775218219; x=1775823019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZVeBan9xXWd1BtGIUi3zA06TgvQborzc82cN0RI4hc=;
        b=ZkTCtn9LDBJxsw2qWgmh18dP1ICAEiohYpYxiNseHwAYl5ArJxeHieC5x7SLmIhZHw
         goqG867tAwPAtjkBYFVsTmVG02maFZSOHvbAHEiYjh1RM+MsZ/jJBuIxm75TGp2BeqBm
         27ev+b3WJd28jJxgPNCZQZRseLStslubjiSxwqL4sFhzgiNGMoVA2IcZDePUYyRqYGTu
         FoGrqoYzlXzgIQDtSW+gHxD4SY3TDEtpRO8rK7dnJIXv5Gd4ep/5XJHfezoVh3Hf896U
         QrLSjw5yQ4aQk9EDzqUJYDicCqgHEcb17Ypn9bFU61ZJzFmx8/QrUp4PR5G867fzRxX4
         /oBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775218219; x=1775823019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GZVeBan9xXWd1BtGIUi3zA06TgvQborzc82cN0RI4hc=;
        b=XXE69TIXQF0blC9Ku92Lk2KjDYVJSh8clOuM0n5wxdtCAXfzXaec13rWdhSZvkj+7a
         +4dSOZqvxVj5sHcx0rCRd2T+hL0c8x+D9dZu63JQeR1XzglP329IHEsXRyquny94v4Mf
         31hDBVD1iSAc/vPYLS9wrwQ9TPXGSvoFB1zIjbIT+97cRTazNHw4eOx6BEwkL/vGj6+N
         mcTujOx2UW+gBney51Y/hnMLgpqrPasYOQ1ClQGh00YqYyb10VGQ0RyLghMpezlQl42U
         7dk95pbxkvxQdeSsMXFee3720DhgV/NeW4dtbHslJI/bRNcbNbbCJBD6HIgiEBDc6ftd
         I7jg==
X-Gm-Message-State: AOJu0YyT0MOZKQmmHH2ssXyimF7mLqxaT+1dmpQNZBjHA9ZWNm2ifCI1
	GSJ0TRmJqPjZPwFe1yYh5f4kYXV+7QAhrzsMqhC51L5wjYVL70dhJWpcPd0aBw==
X-Gm-Gg: AeBDieucU6Ylos3xUni/BirHyyNlR9nm/MDcvaBYMubHvc0VS/j7TH7mPkJpQAukZz5
	jN2l0meVwG2DNGguLV7KNen+/mdXul4FSsttk37Fmr0IC048wmbC64H1ehOPfBCrZDVjAnAYLeL
	zKiieGFKRsIwaYiDG6cwV0bLlFGNbd/tYL/gEyg/vbD0FPQkyMatSFZAs8Ww2TnBFd3eBG29/c1
	SolmDlXn2eWGAl/AtCDQwg/k7k2zw8dXIP76sBYvXxj33WI42FwjDmscLTGZ0PzviqmUjn1S85R
	gSLUsBR7KOcneZ4dUwEOEWaHmU05CkAPQvb/pAjY0mVNsWrnjbkGJm+5ZiyHcPpt2zAW8MDBLah
	CfstIHeWpIyjkkSJdCztQ57tt3UMNvcE8SeoGg7LVVaqfcJJ1ytjJluiGcNQf2IcGXqdNtDM/dP
	ELqeff7XsbqtXK9zlQbfjmlUJS9+HkgFBanT7rngb4gLY=
X-Received: by 2002:a05:6a00:21d6:b0:82c:d7e7:2f8a with SMTP id d2e1a72fcca58-82d0db96cd4mr2770984b3a.39.1775218218816;
        Fri, 03 Apr 2026 05:10:18 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:1cd6:212e:a788:cbbb:a39d:2c2c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c41b8dsm5390775b3a.34.2026.04.03.05.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 05:10:18 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	a3205153416@gmail.com,
	bkkaracay@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v4 2/3] refs: remove the_hash_algo global state
Date: Fri,  3 Apr 2026 17:38:59 +0530
Message-ID: <20260403120938.1142533-3-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403120938.1142533-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260329101725.1092900-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260403120938.1142533-1-shreyanshpaliwalcmsmn@gmail.com>
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

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 refs.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 214ebfd5ce..cb58e10dc6 100644
--- a/refs.c
+++ b/refs.c
@@ -1472,7 +1472,7 @@ int ref_transaction_create(struct ref_transaction *transaction,
 		return 1;
 	}
 	return ref_transaction_update(transaction, refname, new_oid,
-				      null_oid(the_hash_algo), new_target, NULL, flags,
+				      null_oid(transaction->ref_store->repo->hash_algo), new_target, NULL, flags,
 				      msg, err);
 }
 
@@ -1491,7 +1491,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 	if (old_target && !(flags & REF_NO_DEREF))
 		BUG("delete cannot operate on symrefs with deref mode");
 	return ref_transaction_update(transaction, refname,
-				      null_oid(the_hash_algo), old_oid,
+				      null_oid(transaction->ref_store->repo->hash_algo), old_oid,
 				      NULL, old_target, flags,
 				      msg, err);
 }
@@ -2379,7 +2379,7 @@ struct ref_store *repo_get_submodule_ref_store(struct repository *repo,
 	subrepo = xmalloc(sizeof(*subrepo));
 
 	if (repo_submodule_init(subrepo, repo, submodule,
-				null_oid(the_hash_algo))) {
+				null_oid(repo->hash_algo))) {
 		free(subrepo);
 		goto done;
 	}
@@ -2571,14 +2571,14 @@ static int transaction_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_
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
@@ -3145,6 +3145,7 @@ struct migration_data {
 static int migrate_one_ref(const struct reference *ref, void *cb_data)
 {
 	struct migration_data *data = cb_data;
+	const struct git_hash_algo *hash_algo = data->transaction->ref_store->repo->hash_algo;
 	struct strbuf symref_target = STRBUF_INIT;
 	int ret;
 
@@ -3153,7 +3154,7 @@ static int migrate_one_ref(const struct reference *ref, void *cb_data)
 		if (ret < 0)
 			goto done;
 
-		ret = ref_transaction_update(data->transaction, ref->name, NULL, null_oid(the_hash_algo),
+		ret = ref_transaction_update(data->transaction, ref->name, NULL, null_oid(hash_algo),
 					     symref_target.buf, NULL,
 					     REF_SKIP_CREATE_REFLOG | REF_NO_DEREF, NULL, data->errbuf);
 		if (ret < 0)
-- 
2.53.0

