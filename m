Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217DC132122
	for <git@vger.kernel.org>; Thu, 15 May 2025 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747318053; cv=none; b=Inh7CDKXD7H6P8eg0iXTkcoNyvm1uktTDI+BkdlkonvoZ1mBLZQSsLkHTBUpctkEyPpsuOdWTtQulq8bUFm49ZovwV2bDu/V8oVXTyhDKlAfDAPfDaKE7yWB7UBLVakkaeuX4D1jIfpHIg4HU71U6kUH1KlamTOBNIwV3zkEB30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747318053; c=relaxed/simple;
	bh=9NKESTJYLYu+OY32qc7hJBiBfexW04JANZn+4HGq1fA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=VUDcNwbTFUcVA30qRPnUNrXToLX23l6Y8VQIsSuStDsljCEuUFcv+EidE6UFGChHRyX64RfFdbiGxVczvdcREI91+J2YZFGigplMnRAz2mT2xcvyE7cJ669aLJXspdeAsx85zarYInF1kMCuVNWfKguTsqvt3Z8Og3Z+RgdqvsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPkRVhzO; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPkRVhzO"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5fbee322ddaso2076602a12.0
        for <git@vger.kernel.org>; Thu, 15 May 2025 07:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747318049; x=1747922849; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2VSceFcnPzr6Bd/Xl6zAOqRUAOgbTI1//Q+XdsmFv0=;
        b=UPkRVhzOW0Oscqs3cHKl+pLe+eGrXMGuwGs3JKwp6wMIBWPiulKxVToL6O86XQpDB4
         hKhDk/TFBzVpfh8Xs+LBTVmRo9X4tTg7mk9x5ceVv1ofuA9oRWVCfgSFaipr5d19FJ7x
         5lAEhO6sUOyRsDQtC5X5gjbz8Frv+1L+X8P45rOeyq0mWL2M7z+x08aNbg2QpqO23XXc
         H5+/iLEtVrGPwucBBXpVi346ZHOvvSDH3IwyGcPvcI83N72r7W9gCqV7ldwIRDNE36sL
         2oQ4h/7UNDSWvG43FgK0MVvEFAexQC15v0dfY0XzKafgSZRTI82QJMrrKo4iK4DBdqtQ
         WRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747318049; x=1747922849;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A2VSceFcnPzr6Bd/Xl6zAOqRUAOgbTI1//Q+XdsmFv0=;
        b=DLqh4B/SkvGE3Oo5QNwDmPcUCBF2yD+DT10K7whTmdCUBfZTsLCS0swpPEZATCC/OX
         XsmJncj6L0dfiE227LsOj+OnnJNufJ7pSkjihQpStesde1FDIgWR+jK6SG6r7dj9Bcm1
         qe9ByVb7F9p20LfXl6hkijQDOsNCpcKDr6DDS8X8DoCxPe91zMN8Nj6tE3/KeKOsPLCP
         comuEjUy03Z64hUu68To7BxVOmHoJ06R58P3qLdBXNb4HJUeDQ9rGTmQYSrfIrMjOE8S
         7qm7/CqcuZMHorfQkffGp/n+s6k2KGhu1n0TUQX9UqSvn97QmMzaTjsz5KgYDscAozX8
         o69w==
X-Gm-Message-State: AOJu0YzW15ej0at1sZff3k/jEfTLuY8Ftwl6ht/cuIKRtHS9pI7qVeBm
	6kSvRvu7jGioat1kfEXtzcKWpoQmMy5yeG6JzJxXCOP93WGWnvRGmYc18q/P
X-Gm-Gg: ASbGncvEvY4dKT2SS3RKJXP/Nl5guFs9pDn+9n0cjw1xlGWwPLApalZmGph0wF8rKcC
	jtxQe0VJ2eG7GO5yYuU9zmpYbT/f4eVdvP3aWXg3XrUb7Z8B7rfbtJL82dZGXR5SbdHbo45hMFs
	C9ZQd9kFfnQSWKyw1WbkY4s2ZhZ2CKjzcuPRmVPAimQuGgw7kEr6unDAwHZ8ulN5jZEAnxINj1H
	6lygpFJiKvAE0okMUEw/ei0sWlI0wom/OjPx6dVi50h5XmB6QCXqzQftzQHRb0ReXjG1tRm8JTh
	sMeSiyyYwl6qsAKjuMeSXZnSVL84ZV3Mju/NkM4+PWEmi4Vztd/RTOPtilLOsA==
X-Google-Smtp-Source: AGHT+IESbmnBs78za/ZD3oAZAJdpIdVZc+DgzSMYyJhCfj7m40p5K+dwVsJVgqLS+br0oNFNk6ugAQ==
X-Received: by 2002:a05:6402:3593:b0:5fc:aa26:a12 with SMTP id 4fb4d7f45d1cf-5ff988da0fbmr6174124a12.23.1747318048841;
        Thu, 15 May 2025 07:07:28 -0700 (PDT)
Received: from [127.0.0.2] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d70e296sm10259434a12.75.2025.05.15.07.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 07:07:28 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/4] fetch/receive: use batched reference updates
Date: Thu, 15 May 2025 16:07:24 +0200
Message-Id: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-0-80cbaaa55d2e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABz1JWgC/52OSw6CMBRFt0I69hn6JThyH4ZBLa/wEn5pC9EQ9
 m7FHTg8d3DO3VnEQBjZrdhZwI0izVMGcSmY6+3UIVCbmYlS6FIJCbrksC6tTQgdJfCYXA8c0gx
 rRFhsSGQHSMFO0bqUbREq/zRGytpjVbMsXgJ6ep3RR5O5p5jm8D4/bPy7/nKaq39yG4cSKme0V
 0bVslX3brQ0XN08suY4jg+XntmD9AAAAA==
X-Change-ID: 20250423-501-update-git-fetch-1-to-use-partial-transactions-7fb66339fe79
In-Reply-To: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
References: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, ps@pks.im, 
 gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10274;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=9NKESTJYLYu+OY32qc7hJBiBfexW04JANZn+4HGq1fA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgl9R8URs3/w8HIFKoJIfMrkqNY3IzTu9D05
 574GZEVKtzup4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoJfUfAAoJED7VnySO
 Rox/wgsL/1I0x6mdNKFadVkpshJA22UF41Kxu2zZnt5XPN0gfyytUbARrMS8NnEDL+LjpIWPvK7
 nuIlT07EHS752WhkEc07XxS2Cg1oY+oDivfMkgFnWVmhxpyLQteGNeok1pLVP9IdSqSVczqoESh
 DB6McEJ7FXvrskxk1tA6ckG62rI1lHn6wK3i9pr4kd0W+dnhRO/pPbztc/Dn5xQI+ge/JuG7URx
 jyK4qEvVbtXVrHE/4COj1n3GU0AqrCN7taL3reLMqa1prmIZ1OlScEnt8fE7+8KrJLRZ2fKF093
 UNwirv8+7sxRSes40DcjhT8UDjqJcbyEgCTRJnzH9dFy8QL3eeazXFaYz8FqlIYKezNcaH5U+VQ
 TtiSaEV3K942LJQtWePqkjmWW/AHJm0CYUvPxHfm5qasJcUX7hB51CwkRiyGInyzY2kcUTnFcOJ
 fdVqcPHbDc96Wa399FYq3aGuuIshBCnZwYJ31Db1G6oPJBX5IR5QTnVg0YVxAhau7N6VAfk1/F6
 wA=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The git-fetch(1) and git-receive-pack(1) commands update references as
part of the flow. Each reference update is treated as a single entity
and a transaction is created for each update.

This can be really slow, specifically in reference backends where there
are optimizations which ensure a single transaction with 'N' reference
update perform much faster than 'N' individual transactions. Also having
'N' individual transactions has buildup and teardown costs. These costs
add up in repositories with a large number of references.

Also specifically in the reftable backend, 'N' individual transactions
would also trigger auto-compaction for every transaction.

The reasoning for using individual transactions is because we want to
allow partial updates of references in these commands. Using a single
transaction would be an all-or-nothing scenario.

Recently we introduced an in-between solution called batched reference
updates in 23fc8e4f61 (refs: implement batch reference update support,
2025-04-08). This allows us to batch a set of reference updates, where
individual updates can pass/fail without affecting the batch.

This patch series, modifies both 'git-fetch(1)' and
'git-receive-pack(1)' to use this mechanism. With this, we see a
significant performance boost:

+---------------------+---------------+------------------+
|                     | files backend | reftable backend |
+---------------------+---------------+------------------+
| git-fetch(1)        | 1.25x         | 22x              |
| git-receive-pack(1) | 1.21x         | 18x              |
+---------------------+---------------+------------------+

The first and third patch handle the changes for 'git-fetch(1)' and
'git-receive-pack(1)' respectively. The second patch fixes a small
memory leak I encountered while working on this series.

This is based on top of master: 7a1d2bd0a5 (Merge branch 'master' of
https://github.com/j6t/gitk, 2025-05-09). There were no conflicts
observed with next or seen.

Junio, since the release window for 2.50 is closing in. I would prefer
we mark this for 2.51, so perhaps when/if we merge it to 'next', we let
it bake there till the next release window opens. While all the tests
pass, any bugs here would be high impact and it would be nice to catch
it before it hits a release.

---
Changes in v2:
- Added a new commit to introduce a mapping from 'ref_transaction_error'
  to a human readable string. We now use this to map the errors
  observed.
- Add a TODO regarding handling pruning and creation of refs in the same
  transaction in 'git-fetch(1)'.
- Cleanup commit message typos.
- Fix logic in 'builtin/receive-pack.c' around error reporting to be
  cleaner. Thanks Patrick for the suggestion.
- Link to v1: https://lore.kernel.org/r/20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com

---
 builtin/fetch.c                  | 128 ++++++++++++++++++++++-----------------
 builtin/receive-pack.c           |  64 +++++++++++++++-----
 builtin/update-ref.c             |  26 +-------
 refs.c                           |  30 +++++++++
 refs.h                           |   5 ++
 send-pack.c                      |   7 +++
 t/t1416-ref-transaction-hooks.sh |   2 -
 t/t5408-send-pack-stdin.sh       |  14 ++++-
 8 files changed, 177 insertions(+), 99 deletions(-)

Karthik Nayak (4):
      refs: add function to translate errors to strings
      fetch: use batched reference updates
      send-pack: fix memory leak around duplicate refs
      receive-pack: use batched reference updates

Range-diff versus v1:

-:  ---------- > 1:  8c2b3d08d0 refs: add function to translate errors to strings
1:  b6a257eeff ! 2:  1683b19f10 fetch: use batched reference updates
    @@ builtin/fetch.c: static int s_update_ref(const char *action,
     -		ret = STORE_REF_ERROR_OTHER;
     -		goto out;
     -	}
    - 
    +-
     -	if (our_transaction) {
     -		switch (ref_transaction_commit(our_transaction, &err)) {
     -		case 0:
    @@ builtin/fetch.c: static int s_update_ref(const char *action,
     -			goto out;
     -		}
     -	}
    --
    + 
     -out:
     -	ref_transaction_free(our_transaction);
      	if (ret)
    @@ builtin/fetch.c: static int set_head(const struct ref *remote_refs, struct remot
     +	const char *remote_name;
     +};
     +
    -+static void ref_transaction_rejection_handler(const char *refname UNUSED,
    ++static void ref_transaction_rejection_handler(const char *refname,
     +					      const struct object_id *old_oid UNUSED,
     +					      const struct object_id *new_oid UNUSED,
     +					      const char *old_target UNUSED,
    @@ builtin/fetch.c: static int set_head(const struct ref *remote_refs, struct remot
     +			" 'git remote prune %s' to remove any old, conflicting "
     +			"branches"), data->remote_name);
     +		data->conflict_msg_shown = 1;
    ++	} else {
    ++		char *reason = ref_transaction_error_msg(err);
    ++
    ++		error(_("fetching ref %s failed: %s"), refname, reason);
    ++		free(reason);
     +	}
     +
     +	*data->retcode = 1;
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      
     +	/*
     +	 * If not atomic, we can still use batched updates, which would be much
    -+	 * more performent. We don't initiate the transaction before pruning,
    ++	 * more performant. We don't initiate the transaction before pruning,
     +	 * since pruning must be an independent step, to avoid F/D conflicts.
    ++	 *
    ++	 * TODO: if reference transactions gain logical conflict resolution, we
    ++	 * can delete and create refs (with F/D conflicts) in the same transaction
    ++	 * and this can be moved about the 'prune_refs()' block.
     +	 */
     +	if (!transaction) {
     +		transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     -			goto cleanup;
     +	if (retcode)
     +		goto cleanup;
    -+
    + 
    +-		retcode = ref_transaction_commit(transaction, &err);
     +	retcode = ref_transaction_commit(transaction, &err);
     +	if (retcode) {
     +		/*
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     +		transaction = NULL;
     +		goto cleanup;
     +	}
    - 
    --		retcode = ref_transaction_commit(transaction, &err);
    ++
     +	if (!atomic_fetch) {
     +		struct ref_rejection_data data = {
     +			.retcode = &retcode,
2:  1697d15527 ! 3:  85f68863d8 send-pack: fix memory leak around duplicate refs
    @@ Commit message
     
         If a reference fails to be updated, its error message is captured in the
         `ref->remote_status` field. While the command allows duplicate ref
    -    inputs, the list of doesn't accommodate this behavior as a particular
    +    inputs, the list doesn't accommodate this behavior as a particular
         refname is linked to a single `struct ref*` element. So if the user
         inputs a reference twice like:
     
3:  0579a66c98 ! 4:  1cd2324045 receive-pack: use batched reference updates
    @@ Commit message
         batch updates use a transaction under the hood. This explains the change
         in 't1416'.
     
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## builtin/receive-pack.c ##
    @@ builtin/receive-pack.c: static void BUG_if_skipped_connectivity_check(struct com
     +					      enum ref_transaction_error err,
     +					      void *cb_data)
     +{
    -+	struct strmap *failed_refs = (struct strmap *)cb_data;
    -+	const char *reason = "";
    ++	struct strmap *failed_refs = cb_data;
     +
    -+	switch (err) {
    -+	case REF_TRANSACTION_ERROR_NAME_CONFLICT:
    -+		reason = "refname conflict";
    -+		break;
    -+	case REF_TRANSACTION_ERROR_CREATE_EXISTS:
    -+		reason = "reference already exists";
    -+		break;
    -+	case REF_TRANSACTION_ERROR_NONEXISTENT_REF:
    -+		reason = "reference does not exist";
    -+		break;
    -+	case REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE:
    -+		reason = "incorrect old value provided";
    -+		break;
    -+	case REF_TRANSACTION_ERROR_INVALID_NEW_VALUE:
    -+		reason = "invalid new value provided";
    -+		break;
    -+	case REF_TRANSACTION_ERROR_EXPECTED_SYMREF:
    -+		reason = "expected symref but found regular ref";
    -+		break;
    -+	default:
    -+		reason = "unkown failure";
    -+	}
    -+
    -+	strmap_put(failed_refs, refname, xstrdup(reason));
    ++	strmap_put(failed_refs, refname, ref_transaction_error_msg(err));
     +}
     +
      static void execute_commands_non_atomic(struct command *commands,
    @@ builtin/receive-pack.c: static void BUG_if_skipped_connectivity_check(struct com
      {
      	struct command *cmd;
      	struct strbuf err = STRBUF_INIT;
    -+	const char *reported_error = "";
    ++	const char *reported_error = NULL;
     +	struct strmap failed_refs = STRMAP_INIT;
     +
     +	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
    @@ builtin/receive-pack.c: static void BUG_if_skipped_connectivity_check(struct com
     +		rp_error("%s", err.buf);
     +		reported_error = "failed to update refs";
     +		goto failure;
    - 	}
    ++	}
     +
     +	ref_transaction_for_each_rejected_update(transaction,
     +						 ref_transaction_rejection_handler,
    @@ builtin/receive-pack.c: static void BUG_if_skipped_connectivity_check(struct com
     +
     +failure:
     +	for (cmd = commands; cmd; cmd = cmd->next) {
    -+		if (strmap_empty(&failed_refs))
    ++		if (reported_error)
     +			cmd->error_string = reported_error;
     +		else if (strmap_contains(&failed_refs, cmd->ref_name))
     +			cmd->error_string = xstrdup(strmap_get(&failed_refs, cmd->ref_name));
    -+	}
    + 	}
     +
     +cleanup:
     +	ref_transaction_free(transaction);


base-commit: 7a1d2bd0a596f42a8a7a68d55577967bb454fec0
change-id: 20250423-501-update-git-fetch-1-to-use-partial-transactions-7fb66339fe79

Thanks
- Karthik

