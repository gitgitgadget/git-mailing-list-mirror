Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6780E25A326
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475773; cv=none; b=amt+ZRUTTw1xp6wsYcLIhTSQpiscDnD6/oNq+H8g+rH5dLyFJ3bZzz7eemmGWkphvltDQVM2LsG9JfCbPp2y3iulLPRlkNStJ5TFTMe//BJMt185YiBcKvGGIDfwhEXb28X1l0FH4J2kaR45/OGbJ9QXuFi6ZjXMK9sMANyeA3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475773; c=relaxed/simple;
	bh=0dMo+iw6lK+NCpy46rCiFrOtgDlsG3IPksNamq/YXyQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=VF4wk8HXX/s2+Zt95lGUXPDRDxzJRH85irU1RINQ1psLOUwfTEXHN1N3ojqd/hXqBgeoytgEfQ3fhm6VetKV73Wtiu08knQ8KY1J874EHCQHl5cvnNMEdEny99EfP/9yfmiCsVuJqBXULC8VessG4wL3wwxRYLBj1uXAwmfCP2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jynkYLAp; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jynkYLAp"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb7520028bso714762166b.3
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 01:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740475768; x=1741080568; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntPmneiWcoKKuiIQ+Gr67nZVmtwL/NF2jRbQ/GEU+8k=;
        b=jynkYLApHJ8hnHbnFCgQP0XT5gKEGsoaDPq5n/Epva2IsYnre6m1iEPAtbquhiCHab
         nAcDZTLuVYG24HkfpihId3JoLLCQJC2HEaVG/lZstnDGDzM6BOHcKaNQNUNO+MccHNYu
         jRG/fbpocKMzgT0AWVCNE94/QhrzXADt9DCZQL07KTZYHnypn0CCKy/4sw3VotlHTfbB
         SNEjhYULy5N2kdHVCEYWFltT8T5EF31PmE4W7NcSNacUGgvPHm+x08WjvY6bCqx4sScT
         aToU7fMwHoh0NwgiERUDRKE/HcFIGsuH/QccqvxbrfZtpPjX0IXQy5w0d5J6/Ib3LrIN
         /siw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740475768; x=1741080568;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ntPmneiWcoKKuiIQ+Gr67nZVmtwL/NF2jRbQ/GEU+8k=;
        b=dD1rsvsIZdWDk/tyJ7wbQL2WyqoLjpX2lt+5Na1hTKdHQwJRZdrkKzcx8+DloUlQyd
         OCZ2aZmNzLIA8FdZCYan4MqLUE/FCKfM7VKa/wKRMgxSvkfMaEb+Fl3PBotJpr5fBbel
         u3gjLjbaHV3ojs692hRadY6GS6kFSG0/pb6t6fKqFtXjqHCGqHi0VZHUU2JQQxy7hUar
         fgnZ+28bWDlBEDA82OfUtBx7sNNHvAhGsA5Rjg8hwswhAGllUOgxZNlQ9rYw/0JEI5qi
         yZc9BjFZvN+ub0FkVjP9w5zCqVsJHuAxV2lfB4JREeuDOH8hY3VUpNNcfs/6d/NkY05J
         AlaQ==
X-Gm-Message-State: AOJu0YxN+PotaJQS33nv3bxABeRavlHLO7nxY5VwNkSXT8dTm4sFMEip
	CVQ4QsTR3JJUsZPFf79XAxKDMjBtN4CmIE1tyt/6/7zG0YCOH6VT
X-Gm-Gg: ASbGncuaR7G6aAsTonEb/NdHw9I2HRL3QPS8ZbdaCsprrt6TcRc5eyzZB6hsZH0W5QI
	4GMKLLdZqfjykEXznWSQRgrwTNf8EGFqRHHvAkqpVDu3dkJPF/iEz7mFt3K5ptaJwenZlTxuLej
	29OmcG6mOnjSdWVoGqXTnwYWYrMrIOILQNDilq6p81PKeDVfChMm337S3cUjTbVdMe3BxCmy/l0
	mSmkonfnC/F8W1bzA80m3gs7uKSlvt+33LeT5YwmvVclnuEh161tm+47HyGu89yw3+hs4uRfXU0
	HcH7VQJycgrW6sjHO+k9tkCfx8DXx6LS
X-Google-Smtp-Source: AGHT+IF9znEnfX7BNYKH8jdkL5rYzJ3/IxuQ0R6OtaseJoH/2bZrV6lDt1VG3a0fxVlMNJnIYyZC7A==
X-Received: by 2002:a17:907:7805:b0:ab7:9a7:688e with SMTP id a640c23a62f3a-abc09c26188mr1362048466b.45.1740475767940;
        Tue, 25 Feb 2025 01:29:27 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:20c2:4ab6:a193:5b8c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cd561esm111944466b.19.2025.02.25.01.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:29:27 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/7] refs: introduce support for partial reference
 transactions
Date: Tue, 25 Feb 2025 10:29:03 +0100
Message-Id: <20250225-245-partially-atomic-ref-updates-v2-0-cfa3236895d7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGGNvWcC/4WNTQ6CMBBGr0K6dsxQfkRX3sOwGMsAkwAlbSUSw
 t0tXMDl+77kvU15dsJePZJNOV7Ei50i6EuiTE9TxyBNZKVR56nGEnRewEwuCA3DChTsKAYct/C
 ZGwrs4d5y9cYKs7wwKmrmeMr3TLzqyL34YN16Fpf0WA95gRpv/+VLCghcUlbesW11Rs9uJBmux
 o6q3vf9BxPAjU/QAAAA
X-Change-ID: 20241206-245-partially-atomic-ref-updates-9fe8b080345c
In-Reply-To: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=41368;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=0dMo+iw6lK+NCpy46rCiFrOtgDlsG3IPksNamq/YXyQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGe9jXMxWMXwEXZkTnac7It8zuKIKTl/x61xo
 OhFDAJL2dKFKokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnvY1zAAoJED7VnySO
 Rox/5XAL/3X5ydbjyPDGF5sVedOUu18D2C+VoV7uU3e2TaALzv7zNIAFcbMrbZvzv/0gieAeWPe
 N1xZC40L56iWiPPZed2hX8ScZaN/1mhIFsOlS2GtpEsXmf3gMejYGcFWVRhWruecsAqbrpg1zJk
 eL4Z3lHDU+lqAzFn4kI8XY7fbQ0gHtSY3YzPcdcpC/0Vx06wuFS1UcCo26mC06JZx/tlfhlZwfF
 r+8YmnbGb82OFvXJxo6GY5Xg36JQRcPJy9JBmCKdxxY/IyjAGgB3sVl7ak/lZXDvZ2dDee71gNT
 /BW9Xno7weD5FvNYH2DsY4q5wQwLJBeFU7M4ZwGfyZu/RMtApPH4Clu9frxb2cDSkG3Tqo5ScFz
 5CaB3KnHFFjJNekS4CEwFGQQ9jSZyqZ4ZTbLSvgsnVBoD/jmBQcgOhfaBnCUSLR65fkK+JFFBww
 cpJEGQRxUbGSsgHCAWYLU7s0e4pZLxky0lYx34w9XwzuHbrEPoyL94hmz0BaI+bIt+WY/+14UW4
 iY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

 Documentation/git-update-ref.adoc |  21 +-
 builtin/update-ref.c              |  74 +++++-
 refs.c                            | 101 ++++++--
 refs.h                            |  78 ++++--
 refs/files-backend.c              | 260 ++++++++------------
 refs/packed-backend.c             |  70 +++---
 refs/refs-internal.h              |  22 +-
 refs/reftable-backend.c           | 496 +++++++++++++++++++-------------------
 t/t1400-update-ref.sh             | 216 +++++++++++++++++
 9 files changed, 849 insertions(+), 489 deletions(-)

Karthik Nayak (7):
      refs/files: remove redundant check in split_symref_update()
      refs: move duplicate refname update check to generic layer
      refs/files: remove duplicate duplicates check
      refs/reftable: extract code from the transaction preparation
      refs: introduce enum-based transaction error types
      refs: implement partial reference transaction support
      update-ref: add --allow-partial flag for stdin mode

Git's reference updates are traditionally all or nothing - when updating
multiple references in a transaction, either all updates succeed or none
do. While this behavior is generally desirable, it can be limiting in
certain scenarios, particularly with the reftable backend where batching
multiple reference updates is more efficient than performing them
sequentially.

This series introduces support for partial reference transactions,
allowing individual reference updates to fail while letting others
proceed. This capability is exposed through git-update-ref's
`--allow-partial` flag, which can be used in `--stdin` mode to batch
updates and handle failures gracefully.

The changes are structured to carefully build up this functionality:

First, we clean up and consolidate the reference update checking logic.
This includes removing duplicate checks in the files backend and moving
refname tracking to the generic layer, which simplifies the codebase and
prepares it for the new feature.

We then restructure the reftable backend's transaction preparation code,
extracting the update validation logic into a dedicated function. This
not only improves code organization but sets the stage for implementing
partial transaction support.

To ensure we only skip errors which are user-oriented, we introduce
typed errors for transactions with 'enum transaction_error'. We extend
the existing errors to include other scenarios and use this new errors
throughout the refs code.

With this groundwork in place, we implement the core partial transaction
support in the refs subsystem. This adds the necessary infrastructure to
track and report rejected updates while allowing transactions to proceed.
All reference backends are modified to support this behavior when enabled.

Finally, we expose this functionality to users through
git-update-ref(1)'s `--allow-partial` flag, complete with test coverage
and documentation. The flag is specifically limited to `--stdin` mode
where batching multiple updates is most relevant.

This enhancement improves Git's flexibility in handling reference
updates while maintaining the safety of atomic transactions by default.
It's particularly valuable for tools and workflows that need to handle
reference update failures gracefully without abandoning the entire batch
of updates.

This series is based on top of b838bf1938 (Merge branch 'master' of
https://github.com/j6t/gitk, 2025-02-20) with Patrick's series 'refs:
batch refname availability checks' [1] merged in.

[1]: https://lore.kernel.org/all/20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im/

---
Changes in v2:
- Introduce and use structured errors. This consolidates the errors
  and their handling between the ref backends.
- In the previous version, we skipped over all failures. This include
  system failures such as low memory or IO problems. Let's instead, only
  skip user-oriented failures, such as invalid old OID and so on.
- Change the rejection function name to `ref_transaction_set_rejected()`.
- Modify the commit messages and documentation to be a little more
  verbose.
- Link to v1: https://lore.kernel.org/r/20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com

Range-diff versus v1:

1:  e48e562f27 ! 1:  4a1b748e7a refs/files: remove duplicate check in `split_symref_update()`
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    refs/files: remove duplicate check in `split_symref_update()`
    +    refs/files: remove redundant check in split_symref_update()
     
    -    In split_symref_update(), there were two redundant checks:
    -       - At the start: checking if refname exists in `affected_refnames`.
    -       - After adding refname: checking if the item added to
    -         `affected_refnames` contains the util field.
    +    In `split_symref_update()`, there were two checks for duplicate
    +    refnames:
     
    -    Remove the second check since the first one already prevents duplicate
    -    refnames from being added to the transaction updates.
    +      - At the start, `string_list_has_string()` ensures the refname is not
    +        already in `affected_refnames`, preventing duplicates from being
    +        added.
     
    -    Since this is the only place that utilizes the `item->util` value, avoid
    -    setting the value in the first place and cleanup code around it.
    +      - After adding the refname, another check verifies whether the newly
    +        inserted item has a `util` value.
    +
    +    The second check is unnecessary because the first one guarantees that
    +    `string_list_insert()` will never encounter a preexisting entry.
    +
    +    Since `item->util` is only used in this context, remove the assignment and
    +    simplify the surrounding code.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
2:  b5efdd3149 ! 2:  1cfb4f91b5 refs: move duplicate refname update check to generic layer
    @@ Commit message
     
           - Add a `string_list` field `refnames` to `ref_transaction` to contain
             all the references in a transaction. This field is updated whenever
    -        a new update is added.
    +        a new update is added via `ref_transaction_add_update`, so manual
    +        additions in reference backends are dropped.
     
           - Modify the backends to use this field internally as needed. The
             backends need to check if an update for refname already exists when
             splitting symrefs or adding an update for 'HEAD'.
     
    -      - In the reftable backend, in `reftable_be_transaction_prepare()`,
    -        move the instance of `string_list_has_string()` above
    -        `ref_transaction_add_update()` to check before the reference is
    -        added.
    +      - In the reftable backend, within `reftable_be_transaction_prepare()`,
    +        move the `string_list_has_string()` check above
    +        `ref_transaction_add_update()`. Since `ref_transaction_add_update()`
    +        automatically adds the refname to `transaction->refnames`,
    +        performing the check after will always return true, so we perform
    +        the check before adding the update.
     
         This helps reduce duplication of functionality between the backends and
         makes it easier to make changes in a more centralized manner.
    @@ refs/files-backend.c: static int split_symref_update(struct ref_update *update,
      	return 0;
      }
      
    -@@ refs/files-backend.c: struct files_transaction_backend_data {
    - static int lock_ref_for_update(struct files_ref_store *refs,
    - 			       struct ref_update *update,
    +@@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *refs,
      			       struct ref_transaction *transaction,
    --			       const char *head_ref,
    + 			       const char *head_ref,
    + 			       struct string_list *refnames_to_check,
     -			       struct string_list *affected_refnames,
    --			       struct strbuf *err)
    -+			       const char *head_ref, struct strbuf *err)
    + 			       struct strbuf *err)
      {
      	struct strbuf referent = STRBUF_INIT;
    - 	int mustexist = ref_update_expects_existing_old_ref(update);
     @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *refs,
      		update->flags |= REF_DELETING;
      
    @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *ref
      		lock->count++;
      	} else {
      		ret = lock_raw_ref(refs, update->refname, mustexist,
    --				   affected_refnames,
    -+				   &transaction->refnames,
    - 				   &lock, &referent,
    - 				   &update->type, err);
    +-				   refnames_to_check, affected_refnames,
    +-				   &lock, &referent,
    +-				   &update->type, err);
    ++				   refnames_to_check, &transaction->refnames,
    ++				   &lock, &referent, &update->type, err);
      		if (ret) {
    + 			char *reason;
    + 
     @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *refs,
      			 * of processing the split-off update, so we
      			 * don't have to do it here.
    @@ refs/files-backend.c: static int files_transaction_prepare(struct ref_store *ref
      	size_t i;
      	int ret = 0;
     -	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
    + 	struct string_list refnames_to_check = STRING_LIST_INIT_NODUP;
      	char *head_ref = NULL;
      	int head_type;
    - 	struct files_transaction_backend_data *backend_data;
     @@ refs/files-backend.c: static int files_transaction_prepare(struct ref_store *ref_store,
      	transaction->backend_data = backend_data;
      
    @@ refs/files-backend.c: static int files_transaction_prepare(struct ref_store *ref
      
      	/*
     @@ refs/files-backend.c: static int files_transaction_prepare(struct ref_store *ref_store,
    - 		struct ref_update *update = transaction->updates[i];
      
      		ret = lock_ref_for_update(refs, update, transaction,
    --					  head_ref, &affected_refnames, err);
    -+					  head_ref, err);
    + 					  head_ref, &refnames_to_check,
    +-					  &affected_refnames, err);
    ++					  err);
      		if (ret)
      			goto cleanup;
      
    +@@ refs/files-backend.c: static int files_transaction_prepare(struct ref_store *ref_store,
    + 	 * So instead, we accept the race for now.
    + 	 */
    + 	if (refs_verify_refnames_available(refs->packed_ref_store, &refnames_to_check,
    +-					   &affected_refnames, NULL, 0, err)) {
    ++					   &transaction->refnames, NULL, 0, err)) {
    + 		ret = TRANSACTION_NAME_CONFLICT;
    + 		goto cleanup;
    + 	}
     @@ refs/files-backend.c: static int files_transaction_prepare(struct ref_store *ref_store,
      
      cleanup:
      	free(head_ref);
     -	string_list_clear(&affected_refnames, 0);
    + 	string_list_clear(&refnames_to_check, 0);
      
      	if (ret)
    - 		files_transaction_cleanup(refs, transaction);
    -@@ refs/files-backend.c: static int files_transaction_finish_initial(struct files_ref_store *refs,
    - {
    - 	size_t i;
    - 	int ret = 0;
    --	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
    - 	struct ref_transaction *packed_transaction = NULL;
    - 	struct ref_transaction *loose_transaction = NULL;
    - 
     @@ refs/files-backend.c: static int files_transaction_finish_initial(struct files_ref_store *refs,
      	if (transaction->state != REF_TRANSACTION_PREPARED)
      		BUG("commit called for transaction that is not prepared");
    @@ refs/files-backend.c: static int files_transaction_finish_initial(struct files_r
      		BUG("initial ref transaction called with existing refs");
      
      	packed_transaction = ref_store_transaction_begin(refs->packed_ref_store,
    -@@ refs/files-backend.c: static int files_transaction_finish_initial(struct files_ref_store *refs,
    - 			BUG("initial ref transaction with old_sha1 set");
    - 
    - 		if (refs_verify_refname_available(&refs->base, update->refname,
    --						  &affected_refnames, NULL, 1, err)) {
    -+						  &transaction->refnames, NULL, 1, err)) {
    - 			ret = TRANSACTION_NAME_CONFLICT;
    - 			goto cleanup;
    - 		}
    -@@ refs/files-backend.c: static int files_transaction_finish_initial(struct files_ref_store *refs,
    - 	if (packed_transaction)
    - 		ref_transaction_free(packed_transaction);
    - 	transaction->state = REF_TRANSACTION_CLOSED;
    --	string_list_clear(&affected_refnames, 0);
    - 	return ret;
    - }
    - 
     
      ## refs/packed-backend.c ##
     @@ refs/packed-backend.c: int is_packed_transaction_needed(struct ref_store *ref_store,
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
      		reftable_be_downcast(ref_store, REF_STORE_WRITE|REF_STORE_MAIN, "ref_transaction_prepare");
      	struct strbuf referent = STRBUF_INIT, head_referent = STRBUF_INIT;
     -	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
    + 	struct string_list refnames_to_check = STRING_LIST_INIT_NODUP;
      	struct reftable_transaction_data *tx_data = NULL;
      	struct reftable_backend *be;
    - 	struct object_id head_oid;
     @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_store *ref_store,
      						 transaction->updates[i], err);
      		if (ret)
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
      		}
      
      		ret = reftable_backend_read_ref(be, rewritten_ref,
    -@@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_store *ref_store,
    - 			 * at a later point.
    - 			 */
    - 			ret = refs_verify_refname_available(ref_store, u->refname,
    --							    &affected_refnames, NULL,
    -+							    &transaction->refnames, NULL,
    - 							    transaction->flags & REF_TRANSACTION_FLAG_INITIAL,
    - 							    err);
    - 			if (ret < 0)
     @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_store *ref_store,
      				if (!strcmp(rewritten_ref, "HEAD"))
      					new_flags |= REF_UPDATE_VIA_HEAD;
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
      			}
      		}
      
    +@@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_store *ref_store,
    + 	}
    + 
    + 	string_list_sort(&refnames_to_check);
    +-	ret = refs_verify_refnames_available(ref_store, &refnames_to_check, &affected_refnames, NULL,
    ++	ret = refs_verify_refnames_available(ref_store, &refnames_to_check,
    ++					     &transaction->refnames, NULL,
    + 					     transaction->flags & REF_TRANSACTION_FLAG_INITIAL,
    + 					     err);
    + 	if (ret < 0)
     @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_store *ref_store,
      			strbuf_addf(err, _("reftable: transaction prepare: %s"),
      				    reftable_error_str(ret));
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
     -	string_list_clear(&affected_refnames, 0);
      	strbuf_release(&referent);
      	strbuf_release(&head_referent);
    - 
    + 	string_list_clear(&refnames_to_check, 0);
3:  1f1c261afd = 3:  91e96c9048 refs/files: remove duplicate duplicates check
4:  556fd87651 ! 4:  c47a020dc5 refs/reftable: extract code from the transaction preparation
    @@ refs/reftable-backend.c: static int queue_transaction_update(struct reftable_ref
      	return 0;
      }
      
    -+static int prepare_single_update(struct ref_store *ref_store,
    -+				 struct reftable_ref_store *refs,
    ++static int prepare_single_update(struct reftable_ref_store *refs,
     +				 struct reftable_transaction_data *tx_data,
     +				 struct ref_transaction *transaction,
     +				 struct reftable_backend *be,
     +				 struct ref_update *u,
    ++				 struct string_list *refnames_to_check,
     +				 unsigned int head_type,
     +				 struct strbuf *head_referent,
     +				 struct strbuf *referent,
    @@ refs/reftable-backend.c: static int queue_transaction_update(struct reftable_ref
     +		 * can output a proper error message instead of failing
     +		 * at a later point.
     +		 */
    -+		ret = refs_verify_refname_available(ref_store, u->refname,
    -+						    &transaction->refnames, NULL,
    -+						    transaction->flags & REF_TRANSACTION_FLAG_INITIAL,
    -+						    err);
    -+		if (ret < 0)
    -+			return ret;
    ++		string_list_append(refnames_to_check, u->refname);
     +
     +		/*
     +		 * There is no need to write the reference deletion
    @@ refs/reftable-backend.c: static int queue_transaction_update(struct reftable_ref
     +	if (ret > 0) {
     +		/* The reference does not exist, but we expected it to. */
     +		strbuf_addf(err, _("cannot lock ref '%s': "
    ++
    ++
     +				   "unable to resolve reference '%s'"),
     +			    ref_update_original_update_refname(u), u->refname);
     +		return -1;
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
     -		 * stack.
     -		 */
     -		ret = backend_for(&be, refs, u->refname, &rewritten_ref, 0);
    -+		ret = prepare_single_update(ref_store, refs, tx_data,
    -+					    transaction, be,
    -+					    transaction->updates[i], head_type,
    ++		ret = prepare_single_update(refs, tx_data, transaction, be,
    ++					    transaction->updates[i],
    ++					    &refnames_to_check, head_type,
     +					    &head_referent, &referent, err);
      		if (ret)
      			goto done;
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
     -			 * can output a proper error message instead of failing
     -			 * at a later point.
     -			 */
    --			ret = refs_verify_refname_available(ref_store, u->refname,
    --							    &transaction->refnames, NULL,
    --							    transaction->flags & REF_TRANSACTION_FLAG_INITIAL,
    --							    err);
    --			if (ret < 0)
    --				goto done;
    +-			string_list_append(&refnames_to_check, u->refname);
     -
     -			/*
     -			 * There is no need to write the reference deletion
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
     -		}
      	}
      
    - 	transaction->backend_data = tx_data;
    + 	string_list_sort(&refnames_to_check);
-:  ---------- > 5:  ff7235f2b8 refs: introduce enum-based transaction error types
5:  14b9657c99 ! 6:  74dce2ea61 refs: implement partial reference transaction support
    @@ Commit message
     
         Git's reference transactions are all-or-nothing: either all updates
         succeed, or none do. While this atomic behavior is generally desirable,
    -    it can be suboptimal when using the reftable backend, where batching
    -    multiple reference updates into a single transaction is more efficient
    -    than performing them sequentially.
    +    it can be suboptimal especially when using the reftable backend, where
    +    batching multiple reference updates into a single transaction is more
    +    efficient than performing them sequentially.
     
    -    Introduce partial transaction support through a new flag
    -    `REF_TRANSACTION_ALLOW_PARTIAL`. When this flag is set, individual
    -    reference updates that would normally fail the entire transaction are
    -    instead marked as rejected while allowing other updates to proceed. This
    -    provides more flexibility while maintaining transactional integrity
    -    where needed.
    +    Introduce partial transaction support with a new flag,
    +    'REF_TRANSACTION_ALLOW_PARTIAL'. When enabled, this flag allows
    +    individual reference updates that would typically cause the entire
    +    transaction to fail due to non-system-related errors to be marked as
    +    rejected while permitting other updates to proceed. Non-system-related
    +    errors include issues caused by user-provided input values, whereas
    +    system-related errors, such as I/O failures or memory issues, continue
    +    to result in a full transaction failure. This approach enhances
    +    flexibility while preserving transactional integrity where necessary.
     
         The implementation introduces several key components:
     
    -      - Add 'rejected' and 'rejection_err' fields to struct `ref_update` to
    -        track failed updates and their failure reasons.
    +      - Add 'rejection_err' field to struct `ref_update` to track failed
    +        updates with failure reason.
     
           - Modify reference backends (files, packed, reftable) to handle
    -        partial transactions by using `ref_transaction_add_rejection()`
    +        partial transactions by using `ref_transaction_set_rejected()`
             instead of failing the entire transaction when
             `REF_TRANSACTION_ALLOW_PARTIAL` is set.
     
    @@ Commit message
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## refs.c ##
    -@@ refs.c: void ref_transaction_free(struct ref_transaction *transaction)
    - 		free(transaction->updates[i]->committer_info);
    - 		free((char *)transaction->updates[i]->new_target);
    - 		free((char *)transaction->updates[i]->old_target);
    -+		strbuf_release(&transaction->updates[i]->rejection_err);
    - 		free(transaction->updates[i]);
    - 	}
    - 	string_list_clear(&transaction->refnames, 0);
     @@ refs.c: void ref_transaction_free(struct ref_transaction *transaction)
      	free(transaction);
      }
      
    -+void ref_transaction_add_rejection(struct ref_transaction *transaction,
    -+				   size_t update_idx, struct strbuf *err)
    ++void ref_transaction_set_rejected(struct ref_transaction *transaction,
    ++				  size_t update_idx,
    ++				  enum transaction_error err)
     +{
    -+	struct ref_update *update = transaction->updates[update_idx];
    -+	update->rejected = 1;
    -+	strbuf_addbuf(&update->rejection_err, err);
    ++	if (update_idx >= transaction->nr)
    ++		BUG("trying to set rejection on invalid update index");
    ++	transaction->updates[update_idx]->rejection_err = err;
     +}
     +
      struct ref_update *ref_transaction_add_update(
      		struct ref_transaction *transaction,
      		const char *refname, unsigned int flags,
     @@ refs.c: struct ref_update *ref_transaction_add_update(
    + 	transaction->updates[transaction->nr++] = update;
      
      	update->flags = flags;
    ++	update->rejection_err = TRANSACTION_OK;
      
    -+	strbuf_init(&update->rejection_err, 0);
    -+
      	update->new_target = xstrdup_or_null(new_target);
      	update->old_target = xstrdup_or_null(old_target);
    - 	if ((flags & REF_HAVE_NEW) && new_oid)
     @@ refs.c: void ref_transaction_for_each_queued_update(struct ref_transaction *transaction,
      	}
      }
    @@ refs.c: void ref_transaction_for_each_queued_update(struct ref_transaction *tran
     +	for (size_t i = 0; i < transaction->nr; i++) {
     +		struct ref_update *update = transaction->updates[i];
     +
    -+		if (!update->rejected)
    ++		if (!update->rejection_err)
     +			continue;
     +
     +		cb(update->refname,
     +		   (update->flags & REF_HAVE_OLD) ? &update->old_oid : NULL,
     +		   (update->flags & REF_HAVE_NEW) ? &update->new_oid : NULL,
     +		   update->old_target, update->new_target,
    -+		   &update->rejection_err, cb_data);
    ++		   update->rejection_err, cb_data);
     +	}
     +}
     +
    @@ refs.h: void ref_transaction_for_each_queued_update(struct ref_transaction *tran
     +							 const struct object_id *new_oid,
     +							 const char *old_target,
     +							 const char *new_target,
    -+							 const struct strbuf *reason,
    ++							 enum transaction_error err,
     +							 void *cb_data);
     +void ref_transaction_for_each_rejected_update(struct ref_transaction *transaction,
     +					      ref_transaction_for_each_rejected_update_fn cb,
    @@ refs.h: void ref_transaction_for_each_queued_update(struct ref_transaction *tran
     
      ## refs/files-backend.c ##
     @@ refs/files-backend.c: static int files_transaction_prepare(struct ref_store *ref_store,
    - 
      		ret = lock_ref_for_update(refs, update, transaction,
    - 					  head_ref, err);
    + 					  head_ref, &refnames_to_check,
    + 					  err);
     -		if (ret)
     +		if (ret) {
    -+			if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL) {
    -+				ref_transaction_add_rejection(transaction, i, err);
    ++			if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL &&
    ++			    ret != TRANSACTION_GENERIC_ERROR) {
    ++				ref_transaction_set_rejected(transaction, i, ret);
     +
     +				strbuf_setlen(err, 0);
    -+				ret = 0;
    ++				ret = TRANSACTION_OK;
     +
     +				continue;
     +			}
      			goto cleanup;
     +		}
    -+
      
      		if (update->flags & REF_DELETING &&
      		    !(update->flags & REF_LOG_ONLY) &&
    @@ refs/packed-backend.c
     @@ refs/packed-backend.c: static int packed_ref_store_remove_on_disk(struct ref_store *ref_store,
       * remain locked when it is done.
       */
    - static int write_with_updates(struct packed_ref_store *refs,
    --			      struct string_list *updates,
    -+			      struct ref_transaction *transaction,
    - 			      struct strbuf *err)
    + static enum transaction_error write_with_updates(struct packed_ref_store *refs,
    +-						 struct string_list *updates,
    ++						 struct ref_transaction *transaction,
    + 						 struct strbuf *err)
      {
    + 	enum transaction_error ret = TRANSACTION_GENERIC_ERROR;
     +	struct string_list *updates = &transaction->refnames;
      	struct ref_iterator *iter = NULL;
      	size_t i;
      	int ok;
    -@@ refs/packed-backend.c: static int write_with_updates(struct packed_ref_store *refs,
    - 					strbuf_addf(err, "cannot update ref '%s': "
    +@@ refs/packed-backend.c: static enum transaction_error write_with_updates(struct packed_ref_store *refs,
      						    "reference already exists",
      						    update->refname);
    + 					ret = TRANSACTION_CREATE_EXISTS;
     +
     +					if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL) {
    -+						ref_transaction_add_rejection(transaction, i, err);
    ++						ref_transaction_set_rejected(transaction, i, ret);
     +						strbuf_setlen(err, 0);
    ++						ret = 0;
     +						continue;
     +					}
     +
      					goto error;
      				} else if (!oideq(&update->old_oid, iter->oid)) {
      					strbuf_addf(err, "cannot update ref '%s': "
    -@@ refs/packed-backend.c: static int write_with_updates(struct packed_ref_store *refs,
    - 						    update->refname,
    +@@ refs/packed-backend.c: static enum transaction_error write_with_updates(struct packed_ref_store *refs,
      						    oid_to_hex(iter->oid),
      						    oid_to_hex(&update->old_oid));
    + 					ret = TRANSACTION_INCORRECT_OLD_VALUE;
     +
     +					if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL) {
    -+						ref_transaction_add_rejection(transaction, i, err);
    ++						ref_transaction_set_rejected(transaction, i, ret);
     +						strbuf_setlen(err, 0);
    ++						ret = 0;
     +						continue;
     +					}
     +
      					goto error;
      				}
      			}
    -@@ refs/packed-backend.c: static int write_with_updates(struct packed_ref_store *refs,
    - 					    "reference is missing but expected %s",
    +@@ refs/packed-backend.c: static enum transaction_error write_with_updates(struct packed_ref_store *refs,
      					    update->refname,
      					    oid_to_hex(&update->old_oid));
    + 				return TRANSACTION_NONEXISTENT_REF;
     +
     +				if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL) {
    -+					ref_transaction_add_rejection(transaction, i, err);
    ++					ref_transaction_set_rejected(transaction, i, ret);
     +					strbuf_setlen(err, 0);
    ++					ret = 0;
     +					continue;
     +				}
     +
      				goto error;
      			}
      		}
    +@@ refs/packed-backend.c: static enum transaction_error write_with_updates(struct packed_ref_store *refs,
    + write_error:
    + 	strbuf_addf(err, "error writing to %s: %s",
    + 		    get_tempfile_path(refs->tempfile), strerror(errno));
    ++	ret = TRANSACTION_GENERIC_ERROR;
    + 
    + error:
    + 	ref_iterator_free(iter);
     @@ refs/packed-backend.c: static int packed_transaction_prepare(struct ref_store *ref_store,
      		data->own_lock = 1;
      	}
      
    --	if (write_with_updates(refs, &transaction->refnames, err))
    -+	if (write_with_updates(refs, transaction, err))
    +-	ret = write_with_updates(refs, &transaction->refnames, err);
    ++	ret = write_with_updates(refs, transaction, err);
    + 	if (ret)
      		goto failure;
      
    - 	transaction->state = REF_TRANSACTION_PREPARED;
     
      ## refs/refs-internal.h ##
    -@@
    - 
    - #include "refs.h"
    - #include "iterator.h"
    -+#include "strbuf.h"
    - #include "string-list.h"
    - 
    - struct fsck_options;
     @@ refs/refs-internal.h: struct ref_update {
      	 */
    - 	unsigned int index;
    + 	uint64_t index;
      
     +	/*
    -+	 * Used in partial transactions to mark a given update as rejected,
    -+	 * with rejection reason.
    ++	 * Used in partial transactions to mark if a given update was rejected.
     +	 */
    -+	unsigned int rejected;
    -+	struct strbuf rejection_err;
    ++	enum transaction_error rejection_err;
     +
      	/*
      	 * If this ref_update was split off of a symref update via
    @@ refs/refs-internal.h: int refs_read_raw_ref(struct ref_store *ref_store, const c
     + * Mark a given update as rejected with a given reason. To be used in conjuction
     + * with the `REF_TRANSACTION_ALLOW_PARTIAL` flag to allow partial transactions.
     + */
    -+void ref_transaction_add_rejection(struct ref_transaction *transaction,
    -+				   size_t update_idx, struct strbuf *err);
    ++void ref_transaction_set_rejected(struct ref_transaction *transaction,
    ++				  size_t update_idx,
    ++				  enum transaction_error err);
     +
      /*
       * Add a ref_update with the specified properties to transaction, and
    @@ refs/refs-internal.h: int refs_read_raw_ref(struct ref_store *ref_store, const c
     
      ## refs/reftable-backend.c ##
     @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_store *ref_store,
    - 					    transaction, be,
    - 					    transaction->updates[i], head_type,
    + 					    transaction->updates[i],
    + 					    &refnames_to_check, head_type,
      					    &head_referent, &referent, err);
     -		if (ret)
    -+
     +		if (ret) {
    -+			if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL) {
    -+				ref_transaction_add_rejection(transaction, i, err);
    ++			if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL &&
    ++			    ret != TRANSACTION_GENERIC_ERROR) {
    ++				ref_transaction_set_rejected(transaction, i, ret);
     +
     +				strbuf_setlen(err, 0);
    -+				ret = 0;
    ++				ret = TRANSACTION_OK;
     +
     +				continue;
     +			}
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
     +		}
      	}
      
    - 	transaction->backend_data = tx_data;
    + 	string_list_sort(&refnames_to_check);
6:  8c90e4201a ! 7:  d79851e041 update-ref: add --allow-partial flag for stdin mode
    @@ Commit message
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    - ## Documentation/git-update-ref.txt ##
    -@@ Documentation/git-update-ref.txt: git-update-ref - Update the object name stored in a ref safely
    + ## Documentation/git-update-ref.adoc ##
    +@@ Documentation/git-update-ref.adoc: git-update-ref - Update the object name stored in a ref safely
    + 
      SYNOPSIS
      --------
    - [verse]
    +-[verse]
     -'git update-ref' [-m <reason>] [--no-deref] (-d <ref> [<old-oid>] | [--create-reflog] <ref> <new-oid> [<old-oid>] | --stdin [-z])
    -+'git update-ref' [-m <reason>] [--no-deref] (-d <ref> [<old-oid>] | [--create-reflog] <ref> <new-oid> [<old-oid>] | --stdin [-z] [--allow-partial])
    ++[synopsis]
    ++git update-ref [-m <reason>] [--no-deref] -d <ref> [<old-oid>]
    ++	       [-m <reason>] [--no-deref] [--create-reflog] <ref> <new-oid> [<old-oid>]
    ++               [-m <reason>] [--no-deref] --stdin [-z] [--allow-partial]
      
      DESCRIPTION
      -----------
    -@@ Documentation/git-update-ref.txt: performs all modifications together.  Specify commands of the form:
    +@@ Documentation/git-update-ref.adoc: performs all modifications together.  Specify commands of the form:
      With `--create-reflog`, update-ref will create a reflog for each ref
      even if one would not ordinarily be created.
      
    -+With `--allow-partial`, update-ref will process the transaction even if
    -+some of the updates fail, allowing remaining updates to be applied.
    -+Failed updates will be printed in the following format:
    ++With `--allow-partial`, update-ref continues executing the transaction even if
    ++some updates fail due to invalid or incorrect user input, applying only the
    ++successful updates. Errors resulting from user-provided input are treated as
    ++non-system-related and do not cause the entire transaction to be aborted.
    ++However, system-related errors—such as I/O failures or memory issues—will still
    ++result in a full failure. Additionally, errors like F/D conflicts are batched
    ++for performance optimization and will also cause a full failure. Any failed
    ++updates will be reported in the following format:
     +
     +	rejected SP (<old-oid> | <old-target>) SP (<new-oid> | <new-target>) SP <rejection-reason> LF
     +
      Quote fields containing whitespace as if they were strings in C source
      code; i.e., surrounded by double-quotes and with backslash escapes.
      Use 40 "0" characters or the empty string to specify a zero value.  To
    -@@ Documentation/git-update-ref.txt: quoting:
    +@@ Documentation/git-update-ref.adoc: quoting:
      In this format, use 40 "0" to specify a zero value, and use the empty
      string to specify a missing value.
      
    @@ builtin/update-ref.c: static void parse_cmd_abort(struct ref_transaction *transa
     +				const struct object_id *new_oid,
     +				const char *old_target,
     +				const char *new_target,
    -+				const struct strbuf *reason,
    ++				enum transaction_error err,
     +				void *cb_data UNUSED)
     +{
     +	struct strbuf sb = STRBUF_INIT;
     +	char space = ' ';
    ++	const char *reason = "";
    ++
    ++	switch (err) {
    ++	case TRANSACTION_NAME_CONFLICT:
    ++		reason = _("refname conflict");
    ++		break;
    ++	case TRANSACTION_CREATE_EXISTS:
    ++		reason = _("reference already exists");
    ++		break;
    ++	case TRANSACTION_NONEXISTENT_REF:
    ++		reason = _("reference does not exist");
    ++		break;
    ++	case TRANSACTION_INCORRECT_OLD_VALUE:
    ++		reason = _("incorrect old value provided");
    ++		break;
    ++	case TRANSACTION_INVALID_NEW_VALUE:
    ++		reason = _("invalid new value provided");
    ++		break;
    ++	case TRANSACTION_EXPECTED_SYMREF:
    ++		reason = _("expected symref but found regular ref");
    ++		break;
    ++	default:
    ++		reason = _("unkown failure");
    ++	}
     +
     +	if (!line_termination)
     +		space = line_termination;
    @@ builtin/update-ref.c: static void parse_cmd_abort(struct ref_transaction *transa
     +	strbuf_addf(&sb, "rejected%c%s%c%s%c%c%s%c%s%c", space,
     +		    refname, space, new_oid ? oid_to_hex(new_oid) : new_target,
     +		    space, space, old_oid ? oid_to_hex(old_oid) : old_target,
    -+		    space, reason->buf, line_termination);
    ++		    space, reason, line_termination);
     +
     +	fwrite(sb.buf, sb.len, 1, stdout);
     +	strbuf_release(&sb);
    @@ builtin/update-ref.c: int cmd_update_ref(int argc,
      	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0;
     -	int create_reflog = 0;
     +	int create_reflog = 0, allow_partial = 0;
    ++	unsigned int flags = 0;
     +
      	struct option options[] = {
      		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
    @@ builtin/update-ref.c: int cmd_update_ref(int argc,
      		OPT_BOOL('z', NULL, &end_null, N_("stdin has NUL-terminated arguments")),
      		OPT_BOOL( 0 , "stdin", &read_stdin, N_("read updates from stdin")),
      		OPT_BOOL( 0 , "create-reflog", &create_reflog, N_("create a reflog")),
    -+		OPT_BOOL('0', "allow-partial", &allow_partial, N_("allow partial transactions")),
    ++		OPT_BIT('0', "allow-partial", &flags, N_("allow partial transactions"),
    ++			REF_TRANSACTION_ALLOW_PARTIAL),
      		OPT_END(),
      	};
      
     @@ builtin/update-ref.c: int cmd_update_ref(int argc,
    - 	}
    - 
    - 	if (read_stdin) {
    -+		unsigned int flags = 0;
    -+
    -+		if (allow_partial)
    -+			flags |= REF_TRANSACTION_ALLOW_PARTIAL;
    -+
    - 		if (delete || argc > 0)
      			usage_with_options(git_update_ref_usage, options);
      		if (end_null)
      			line_termination = '\0';
    @@ t/t1400-update-ref.sh: do
     +			echo $head >expect &&
     +			git rev-parse refs/heads/ref2 >actual &&
     +			test_cmp expect actual &&
    -+			test_grep -q "trying to write ref ${SQ}refs/heads/ref2${SQ} with nonexistent object" stdout
    ++			test_grep -q "invalid new value provided" stdout
     +		)
     +	'
     +
    @@ t/t1400-update-ref.sh: do
     +			echo $head >expect &&
     +			git rev-parse refs/heads/ref2 >actual &&
     +			test_cmp expect actual &&
    -+			test_grep -q "trying to write non-commit object $head_tree to branch ${SQ}refs/heads/ref2${SQ}" stdout
    ++			test_grep -q "invalid new value provided" stdout
     +		)
     +	'
     +
    @@ t/t1400-update-ref.sh: do
     +			git rev-parse refs/heads/ref1 >actual &&
     +			test_cmp expect actual &&
     +			test_must_fail git rev-parse refs/heads/ref2 &&
    -+			test_grep -q "unable to resolve reference" stdout
    ++			test_grep -q "reference does not exist" stdout
     +		)
     +	'
     +
    @@ t/t1400-update-ref.sh: do
     +			test_cmp expect actual &&
     +			echo $head >expect &&
     +			test_must_fail git rev-parse refs/heads/ref2 &&
    -+			test_grep -q "reference is missing but expected $head" stdout
    ++			test_grep -q "reference does not exist" stdout
     +		)
     +	'
     +
    @@ t/t1400-update-ref.sh: do
     +			echo $head >expect &&
     +			git rev-parse refs/heads/ref2 >actual &&
     +			test_cmp expect actual &&
    -+			test_grep -q "expected symref with target ${SQ}refs/heads/nonexistent${SQ}: but is a regular ref" stdout
    ++			test_grep -q "expected symref but found regular ref" stdout
     +		)
     +	'
     +
    @@ t/t1400-update-ref.sh: do
     +			echo $head >expect &&
     +			git rev-parse refs/heads/ref2 >actual &&
     +			test_cmp expect actual &&
    -+			test_grep -q "${SQ}refs/heads/ref2${SQ}: is at $head but expected $old_head" stdout
    ++			test_grep -q "incorrect old value provided" stdout
    ++		)
    ++	'
    ++
    ++	# F/D conflicts on the files backend are resolved on an individual
    ++	# update level since refs are stored as files. On the reftable backend
    ++	# this check is batched to optimize for performance, so failures cannot
    ++	# be isolated to a single update.
    ++	test_expect_success REFFILES "stdin $type allow-partial refname conflict" '
    ++		git init repo &&
    ++		test_when_finished "rm -fr repo" &&
    ++		(
    ++			cd repo &&
    ++			test_commit one &&
    ++			old_head=$(git rev-parse HEAD) &&
    ++			test_commit two &&
    ++			head=$(git rev-parse HEAD) &&
    ++			git update-ref refs/heads/ref/foo $head &&
    ++
    ++			format_command $type "update refs/heads/ref/foo" "$old_head" "$head" >stdin &&
    ++			format_command $type "update refs/heads/ref" "$old_head" "" >>stdin &&
    ++			git update-ref $type --stdin --allow-partial <stdin >stdout &&
    ++			echo $old_head >expect &&
    ++			git rev-parse refs/heads/ref/foo >actual &&
    ++			test_cmp expect actual &&
    ++			test_grep -q "refname conflict" stdout
     +		)
     +	'
      done


base-commit: 408c44885d5b61a728dfc1df462490487cb01dae
change-id: 20241206-245-partially-atomic-ref-updates-9fe8b080345c

Thanks
- Karthik

