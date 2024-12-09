Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D63D21B8F0
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742450; cv=none; b=I0avW0JxmsDYI8zz5mxTfH7t6OXuuoSRg8ZfQk6UshXBhZpcW49rIjZ+1sf81jdKF2wLsB5mlAIHJuMsEQpwOOfBewzWjCrcR3HbmK4DPT0GBbb8HubTgCFMjMHeFZqgMnZMqLjJ5k+igHxtuRTquD7c8d5XcQRxyGw3uq9Qiqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742450; c=relaxed/simple;
	bh=OBQYAEKRSd2fBN/oYIGCe0psMJew4nwiAdtZVB0QIfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RI8HIu6ESv+dkI1QoDrQjx1F7EeW955ogrYij9xEDC5miqWJQTZ57FZIxqmCu/CR95B3bwAtblO85/sMGqqiEWQhcjPCzBUYqflxsNWwTSocOELA6MDfo0ylC9QIDdd6JNwkwOZ+SYEpsm3ZSwREn6LwTsNMiNzJk5mwpC/TQcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7Hrho7w; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7Hrho7w"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385e2880606so3488388f8f.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 03:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733742445; x=1734347245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CCzOtJbDEsEaJ1UVqvV5ZSCi9dBAZdai9+heqibwEPw=;
        b=E7Hrho7wKlI9nvlge6FckW9p1mBWRrqhlE0Sxz/R8zAQ2mHAbGPorPUWoIU8jGk0OT
         IQd/IwNJeZmoeVBQPJXPswRHadDsFmvjNtxhic/49otwtRvhAys8IJCdMwcDjuY3JgRb
         ZKFVU5MA/ID/OaaTLLhlpObKjBIdpncl6Z/wW0+oiIqXMTvdR2QdPYBwajxlm0mXG1sJ
         DG7Ypq2xg9ncsxPLm94x/VMDnAOG+soZ3CQ8FeaEMd6j1j/Z7vievlwu0ZOpr2ibizLR
         oq4JgJxITWgBo1kD9WDZvsi8bX89aLHJmw0RsJ0wUmj4H3vhlQs0HFrZRwv3IDZn1q0l
         b2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733742445; x=1734347245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCzOtJbDEsEaJ1UVqvV5ZSCi9dBAZdai9+heqibwEPw=;
        b=bCEIO5StIoRQ9M2TUn4HfAov5thmfZkisoyTLsCsjZBl8cyDp3UtAkpwaF/GOL1/G0
         cTLzsMxDlYl6XO56n6jtvyw9dy0Ek2Ot8/Nbhpi0QYoCBwo/dJTHn6CnaoeJEKlDl6JY
         zebkCDNTv2Y815FrWxBm0RtJuViyeateWLNAahLYJK/y8l3FHeQvY2EvgTt5WZ5/c/tN
         8FG4lJnJf0hPpVdh3U58hk+iILjB+U8K5PE/mX1vpUuAC4BkDfOdSPEMCFUVL+gnfdbr
         mJo6nSPnVugNum3X7M/CilhwBK4WLCgPIjsjFs6BegCcU2hZpgo6NdCfTcQPHBbYqQ/t
         /zAg==
X-Gm-Message-State: AOJu0YzrlhbU6j0xohVKwYBJhWDbP8LOvU/JIfM2ftEM2LYGt04cu1Wb
	fZC5EL7Ehzd9lMHQ+azGfFG09iGCUQ5SPamdc+gF8H8o+GF4HorfmSYH7XP8
X-Gm-Gg: ASbGnctLM9r7LzLp06tVJhA2AV3TTi5V0ctmxgJivcGow7JIU64EivnNTirKNH21ltJ
	v6jLnb7Fs8I+kkX+l5OqtPrRB04Z9r0an7IaHeuuf18md9Ol02SfVS5tbz5O7EAn0hUOw6mHpF0
	YIshC6JQjA9UpXDESpTFofYc8TwSHKjE0dKSkAmcHwDAvkZvTjmRPRhTxXPSjAA6/OyW/JJO8Wn
	stqsmHEFwsDNim+q0CZL3u6GCRI91M2z2hDPVOduIDD4Qett4ulOtVCpLqVn24=
X-Google-Smtp-Source: AGHT+IFnSXSTOiiZH0DdlcVV809FelGCI1kJTnwUGwnVScAQHuzqOe+H0sIsu0cS43dr1GbpaTC5Cg==
X-Received: by 2002:a5d:588f:0:b0:385:d143:138b with SMTP id ffacd0b85a97d-3862b3db6f0mr7785267f8f.51.1733742445120;
        Mon, 09 Dec 2024 03:07:25 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:8256:2d00:9c39:c2d7:aedd:294d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa672d377fbsm257013366b.75.2024.12.09.03.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:07:24 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 09 Dec 2024 12:07:17 +0100
Subject: [PATCH 3/7] refs/files: add count field to ref_lock
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-320-git-refs-migrate-reflogs-v1-3-d4bc37ee860f@gmail.com>
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
In-Reply-To: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5471; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=OBQYAEKRSd2fBN/oYIGCe0psMJew4nwiAdtZVB0QIfQ=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnVs9nloZS/hXsd91A61GnfWEN2eW1GXa+r+vti
 b+LorWX//eJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ1bPZwAKCRA+1Z8kjkaM
 f23VC/4y2tYHVnGzuRijbx68CqsXanU7NRTuyEf62Hn/cSNqrZCpTVRPhtF3CXNIj8lWaxymzNh
 7HNIoGk1JVHtp+iEZ0yax7Kq+lx+SRX3JzmBNhPqvYwQfjYedwYqbMSC906W2fleupmBQsAd9to
 S1fQuOFAlHkJCYOTHobT6wxkIBGJY0g+4rQ7umcu4PWRU4pC5CUq0slSpDLKSY0GK2CJAgzbnJ7
 btoc47lwsUZlrypzl2hEB1kqYMLUMv67odGrlOoXG4bpnz0uGoSUNLO6ncLiTv19X3aGs4EDYxn
 y1QgpZ2ogg5kMEYeJiH5YMVjJcXfc6UGa0WGXhuM8089slvH+hXFJKd+lGVTyOwVF5vTG0B7rsu
 8jdcLtjsU+Vzpbnj8aYg2hDlQzLlZa2YQc1y3aFqq6ybDs8/3zqdvXBLb/IRjDIpdRrmtzpTJ9r
 kilH3g+qHrWFE6li618QnEwm5iRKB9pWhzev7UTlCyuIaPFVLP78Q8nal0q/WTHJHhbH4=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When refs are updated in the files-backend, a lock is obtained for the
corresponding file path. This is the case even for reflogs, i.e. a lock
is obtained on the reference path instead of the reflog path. This
works, since generally, reflogs are updated alongside the ref.

The upcoming patches will add support for reflog updates in ref
transaction. This means, in a particular transaction we want to have ref
updates and reflog updates. For refs, in a given transaction there can
only be one update. But, we can theoretically have multiple reflog
updates in a given transaction.

The current flow does not support this, because currently refs & reflogs
are treated as a single entity and capture the lock together. To
separate this, add a count field to ref_lock. With this, multiple
updates can hold onto a single ref_lock and the lock will only be
released when all of them release the lock.

This patch only adds the `count` field to `ref_lock` and adds the logic
to increment and decrement the lock. In a follow up commit, we'll
separate the reflog update logic from ref updates and utilize this
functionality.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c | 59 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 13f8539e6caa923cd4834775fcb0cd7f90d82014..9c929c1ac33bc62a75620e684a809d46b574f1c6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -71,6 +71,8 @@ struct ref_lock {
 	char *ref_name;
 	struct lock_file lk;
 	struct object_id old_oid;
+	/* count keeps track of users of the lock */
+	unsigned int count;
 };
 
 struct files_ref_store {
@@ -638,9 +640,12 @@ int parse_loose_ref_contents(const struct git_hash_algo *algop,
 
 static void unlock_ref(struct ref_lock *lock)
 {
-	rollback_lock_file(&lock->lk);
-	free(lock->ref_name);
-	free(lock);
+	lock->count--;
+	if (!lock->count) {
+		rollback_lock_file(&lock->lk);
+		free(lock->ref_name);
+		free(lock);
+	}
 }
 
 /*
@@ -696,6 +701,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	*lock_p = CALLOC_ARRAY(lock, 1);
 
 	lock->ref_name = xstrdup(refname);
+	lock->count = 1;
 	files_ref_path(refs, &ref_file, refname);
 
 retry:
@@ -1169,6 +1175,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 		goto error_return;
 
 	lock->ref_name = xstrdup(refname);
+	lock->count = 1;
 
 	if (raceproof_create_file(ref_file.buf, create_reflock, &lock->lk)) {
 		unable_to_lock_message(ref_file.buf, errno, err);
@@ -2535,6 +2542,12 @@ static int check_old_oid(struct ref_update *update, struct object_id *oid,
 	return -1;
 }
 
+struct files_transaction_backend_data {
+	struct ref_transaction *packed_transaction;
+	int packed_refs_locked;
+	struct strmap ref_locks;
+};
+
 /*
  * Prepare for carrying out update:
  * - Lock the reference referred to by update.
@@ -2557,11 +2570,14 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 {
 	struct strbuf referent = STRBUF_INIT;
 	int mustexist = ref_update_expects_existing_old_ref(update);
+	struct files_transaction_backend_data *backend_data;
 	int ret = 0;
 	struct ref_lock *lock;
 
 	files_assert_main_repository(refs, "lock_ref_for_update");
 
+	backend_data = transaction->backend_data;
+
 	if ((update->flags & REF_HAVE_NEW) && ref_update_has_null_new_value(update))
 		update->flags |= REF_DELETING;
 
@@ -2572,18 +2588,25 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			goto out;
 	}
 
-	ret = lock_raw_ref(refs, update->refname, mustexist,
-			   affected_refnames,
-			   &lock, &referent,
-			   &update->type, err);
-	if (ret) {
-		char *reason;
+	lock = strmap_get(&backend_data->ref_locks, update->refname);
+	if (lock) {
+		lock->count = lock->count + 1;
+	} else {
+		ret = lock_raw_ref(refs, update->refname, mustexist,
+				   affected_refnames,
+				   &lock, &referent,
+				   &update->type, err);
+		if (ret) {
+			char *reason;
+
+			reason = strbuf_detach(err, NULL);
+			strbuf_addf(err, "cannot lock ref '%s': %s",
+				    ref_update_original_update_refname(update), reason);
+			free(reason);
+			goto out;
+		}
 
-		reason = strbuf_detach(err, NULL);
-		strbuf_addf(err, "cannot lock ref '%s': %s",
-			    ref_update_original_update_refname(update), reason);
-		free(reason);
-		goto out;
+		strmap_put(&backend_data->ref_locks, update->refname, lock);
 	}
 
 	update->backend_data = lock;
@@ -2730,11 +2753,6 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 	return ret;
 }
 
-struct files_transaction_backend_data {
-	struct ref_transaction *packed_transaction;
-	int packed_refs_locked;
-};
-
 /*
  * Unlock any references in `transaction` that are still locked, and
  * mark the transaction closed.
@@ -2767,6 +2785,8 @@ static void files_transaction_cleanup(struct files_ref_store *refs,
 		if (backend_data->packed_refs_locked)
 			packed_refs_unlock(refs->packed_ref_store);
 
+		strmap_clear(&backend_data->ref_locks, 0);
+
 		free(backend_data);
 	}
 
@@ -2796,6 +2816,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 		goto cleanup;
 
 	CALLOC_ARRAY(backend_data, 1);
+	strmap_init(&backend_data->ref_locks);
 	transaction->backend_data = backend_data;
 
 	/*

-- 
2.47.1

