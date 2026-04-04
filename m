Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BF82BD0B
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775311200; cv=none; b=B2/9IbHh/ogKDNr2cTmg9mpizm4Mvn1o3j0Iyk5/asc0x9cnY8iL1HswpD1/6OoyzRQXau6U2WxZJrW9qvUxi5RUVckqHmrv7y8nkKOkPWVWB+7vGrS/SPdtPE4i7wskpPcjmL0Y0gXXLMl4lW++TQ1xadd8OxU9kOndcLMY/3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775311200; c=relaxed/simple;
	bh=IPgM5mj1E3cTtxv0qSpJ4671xY852u/zUPxqBU/WUrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1+XGS+PH/kdDcaJZ6r71NRSOlAhyLGIUapd9lSjg+C/WOIR0vzWpkUW5/+wfQJZh1V1v9c/3FFTfYwS5ZeyWbdMDJ43W6GVH7HL24zNZ9qHNX2djX1sPON6TEyrzR+atOaqHeQDYmFK6RMkvBEPSMboYu8KkNZ8IFEfd81uQt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVgQvXiA; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVgQvXiA"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82cdb4ab547so1323694b3a.2
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 06:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775311199; x=1775915999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZVeBan9xXWd1BtGIUi3zA06TgvQborzc82cN0RI4hc=;
        b=bVgQvXiAuEiXrcIpjd8tgOtsruXV5T1quPahF79kbfIoA7Xgo+/oNmZotI4N4D7JtT
         b2AhP0Hph7jLZy+YJ52rmy//otdXX7MNPeE5haCtI1iwaeFCGe6pqa07knpVFohDB5Yj
         u/QKFEl9kV6jlhNfRoc5rTh1vzLikwdfpsUro3Ly3iVe+4TTmHnK/Fkq3D6rCM+Zp0ti
         x8SAb14u3em4nGa171MgRMyw0ktX5/DnCktZGZqH1FflSdos/HV93T+x12MrQmGoH8AT
         bAvNr0Nnr+kPnfBmHa2v8/BrNH/EnL8/1Tujym0NoLSQelAh0JukGA+oYc1VPpr38Q7M
         VULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775311199; x=1775915999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GZVeBan9xXWd1BtGIUi3zA06TgvQborzc82cN0RI4hc=;
        b=r+pUe25KysDq7ARSA05Gwk/aBf45DE2OyOy0w9GJXuy/k+KmmZe0+IRDx+ej2PR4nC
         +3EhykSWYjw6FXFCHDAUmuhXKXYv+tQqeD32lZTHF40XaSR0NhW2ysVAse4TKaCouxXm
         KfAVCKm/sEiSsHzz9BOgwwkcexDxUwjaEmni250x1YBXuVhlpL8VsL3pR4DtbCEFih7g
         9AruAsCqNLTuYVPn46Tk3jiet909rC01XxSSTzeK1YUPeaT6y0ZJSWzEkDaasjiwcku/
         HCpgn0AVOu80CnihmJzsIJM+7g/U4t/6ouPWJX0fpvp81P+KJSMaKd1C8Dw9MOQXuX9H
         pTrA==
X-Gm-Message-State: AOJu0YzLKb1YehzfjEuuZItbGVCsCSShcJOO5OaqDL4aGDqYwAaaHs2J
	x+OFeiK+oPtJ2EGyEvTgpg3H5/5CrQSTo+Z4FLHS4rFxlUMbPRBzf2NBB51mtw==
X-Gm-Gg: AeBDievKbdJpxPp2DyTq/J6ZXvfndF45e0cFu+hX+vWqucLb3zMFHDDXbWeD8GPjosD
	b5YjQqUojVV9YcT10qYmFPjt7BWWOKoEf78LJ5eQTMFl1nNGEpiDb9utGpRyoTIqJQy6QQr0PoY
	yEv2Uvo2Dr7oKrAe+ve1gYpTFZ93nJpreGJQbhzAhwe0IR/KZSW8KW3fW6WHn8WVaB2/V8FPK4F
	CNC19L11JX5DyCxr+j58C/a6Vyh/yuZDRzbYbQenTnpUcmwdqzwJGKAWNi2KLzMK2yiGmyJnN4j
	ZbQfV0R7t48KhtNQgbZ7XjPzouqMg8pIoluVYgEj3tfku/mQjFX9saxLNoP1zneoY/fIlYioOum
	UMiicnvNYhwBumQ5R9XSpKAGj1gfMoZu8HMKYcEhEcjEkC6HsxQGp6efOi8nqBIsFrKxuk74rod
	lsiVwY7aaDJVN/l7uFjHsuXPhoXdAHq+KGOWWGI7OKbxQ=
X-Received: by 2002:a05:6a20:72a9:b0:398:9923:749f with SMTP id adf61e73a8af0-39f2ee01670mr5763744637.20.1775311198769;
        Sat, 04 Apr 2026 06:59:58 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:8811:aff7:7421:f350:c0a6:bb03])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6491fe0sm7071805a12.11.2026.04.04.06.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 06:59:58 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	a3205153416@gmail.com,
	bkkaracay@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v5 2/3] refs: remove the_hash_algo global state
Date: Sat,  4 Apr 2026 19:28:39 +0530
Message-ID: <20260404135914.61195-3-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404135914.61195-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260403120938.1142533-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260404135914.61195-1-shreyanshpaliwalcmsmn@gmail.com>
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

