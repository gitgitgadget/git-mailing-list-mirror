Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F7E34E74B
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777286534; cv=none; b=u+8WaZDcJjreBG+mKBXPFjxXFC6Sfg/12g+2G+gWSQ0E+qDfiOzOBTP2y9F1FjhgplaT6gCwQQh3DIVCq2fPFS/Cd/CpKnej55rUGOdzFytmSvroZ5Edy91W/AuDkQZ9F6D3wKHdp+IoUhTWRevXv9RJMGCfNpq6ccDvOMWFnQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777286534; c=relaxed/simple;
	bh=4Ar3znLH3kB7A2W3mIlllChKQt7vT+h3dQSSkvzduIE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=rPZuInAVbBjnfymYqBKdqlu7HNQGwHDigbm/CXKolc55RoXLFXWH6hxb7xd+cDCjuMLubTX2fR5izj3ICTn4yCuzBFUoDElsT1IOZrnfen2/NujUpoEZsBTMGMhxe2+/SHnAl9wrQSX7ivNc3+QeB5eqh3purj0YAlulwiRd1SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xq7mdS5t; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xq7mdS5t"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43fe8bda8e9so5581193f8f.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 03:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777286531; x=1777891331; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/e2Hek+XgZqeEzMDGEIr1yquqfbjOp6JRejqh4eAOcU=;
        b=Xq7mdS5tJerkxccGn+KvhMDHiniYtJTYUq2ECA994+FBfR5Bn4ZzhVQPwWSyVXbKHG
         VJPy4AH/vN+RGbgnWW5r9DEddqiTMFIKPBsu9j99GvHcg9c9HVubkBHi1Pi44U00oKfy
         mLa/KXzagVdZrQbSzyXdhZE+KgQ9PsL9JxUdoHOAcf+QBk1yeWWbU9ybn9P1bUowTb7x
         uYnk6SUHtp1AN+dsvQ72yeAt7OHFONLpHYtDzFbyIMCHYQnzt+9IYbZiI3HhYfCOrM8K
         eiphVla+sAJkgLrdcRsRX7Qcqx7hGLO5KnbGbvvxpVeoIdhpselmFvd0iPEocH3VpJQU
         xXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777286531; x=1777891331;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/e2Hek+XgZqeEzMDGEIr1yquqfbjOp6JRejqh4eAOcU=;
        b=OGNEFef7cLd0rmxWym5D6sQ5XDvQG6pRdjRfVyLrlBQmYDVz2sD6eQ6KKriHP0qmou
         Pdt8HBgrJkcymUp+nPzzUJCaa0D+y8e3yaxu6vEQaxJIiV7LBiu5ynkNQZpp2uHDw4PL
         T9m1rhpmMLz7sZ+voBfOBVk4QX0GQaJtqZUvBW9fNZDc022HgX99Mxc6AGMzWEAhb8rX
         EoxcAj/HEZcBEZn4o5RxEt+tB06GRPCQHXYVN6kOkMmxWjcUPziVvrkfOzEJwzsBPwyw
         BbQnrFY0cuVO4CWyFJcDiHRi1V7I3WQL8C1QhYbRZTxPHSmaQhJL8B+hJiX/uzqIfs0Y
         BNMg==
X-Gm-Message-State: AOJu0YyzU/Get/ojP4xTSRWxdKhkuGIr83Aq8eiQQ/AwFn9lL3HAtVPr
	/PxuygeY4i9qjX8RJhogkdfKGwtMe2nAH5Hf/vjFBWHLbqMTJdf94tTRRYFeAA==
X-Gm-Gg: AeBDievzl6KnCuaRXye2PicsH91ZtM0LxqPSpI7b7irJQVVt2ls9v1SQjQBBU0Hd9uc
	rhmo4d4JCgQAITVE77/PDqZ8nP7TAr6xzp9TJ7hg9WU0Srl/N5k6eqsYTlqiUu84rgUItAKGHYQ
	C6VTLoyRhzZVXV8EwzAtkC2oAtJk0uXq0X0tN8uPIZTLeYO4jLPFFoSPyGgjsaRTSxhk3FwqrjK
	sh9PeyXHTrn2Mhiit/L3CUQD82quFRKYQdE1Ocv520V3r6pInzq/Ptd6S2h6YXXKjo6upuZFTZS
	suX4uw70TdRGQF1zP49jQjGux+vYppBfBiWONzeReP+9Ui7wjT0ldmg9BgcCwe9lkpu63SejQWS
	FMq/cm1d6Y5QWlpUj6jebOCFJva0/gqHPMD0ztiVGZ+XOMLMaV5BY0c49S6owQsn/Z1k8aBhUVW
	8v7uwUUlt5sAL1rz2U8U+J0JCRiH0IJfGdxIgJ8/a/
X-Received: by 2002:a05:6000:1889:b0:43d:21a:9a3e with SMTP id ffacd0b85a97d-43fe3e0bd8dmr62978114f8f.32.1777286530426;
        Mon, 27 Apr 2026 03:42:10 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:5b56:7e7f:83e5:ed3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a7b4sm74231698f8f.22.2026.04.27.03.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:42:09 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/9] refs: move some of the generic logic out of the
 backends
Date: Mon, 27 Apr 2026 12:42:01 +0200
Message-Id: <20260427-refs-move-to-generic-layer-v3-0-e4638dfb7897@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHo972kC/32Nyw6CMBQFf4V07TX0RY0r/8O4KOUCNUBNi42E8
 O8WdMGK5UnmzMwkoLcYyDWbicdog3VDGvyUEdPqoUGwVdqE5azIBVXgsQ7Qu4gwOmhwSHcDnZ7
 QQ60kk0biRRWCJMErsfazye+P3w7v8olmXI0r0dowOj9t9UhX7h9i+VEoUshBUo5cipqrorw1v
 bbd2bierKHI9ip+qGJJpVFqUVNRVKraq5Zl+QKUqB0gIQEAAA==
X-Change-ID: 20260417-refs-move-to-generic-layer-f7525c5e8764
In-Reply-To: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
References: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, toon@iotcl.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9458; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=4Ar3znLH3kB7A2W3mIlllChKQt7vT+h3dQSSkvzduIE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnvPX61kFBo2t2gh5cnL/cQUE8+0pJ2Uvd8+
 W2aHjK58fyd9YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp7z1+AAoJED7VnySO
 Rox/3AgMAIAyvj8NXg7265hdCTHXVE53j23QmcoDNCW4hJOxRVAba7Eba7gPhVJF8T435OJwKMP
 z9HDONhiE+zMpv6xbZVWgHDQF3q782FtdLaI1OeYOto/kmQeMay8AKgwCFUoOf6iLF4srpVd7Sh
 3TIVj3RVSSN7Gdz/PuPts5BxbTZCYzDvzUZDl7aucVz1+Qz4mjEBNJatfLZKQVIU36Xyk3rMnkz
 +puWBg5GHODB/UZNdZcy2PGOq5oDX9F5xy6FkrTocFW1jvC2LU50maAgh7HXOC6xRA80NDoTo3F
 tNI9rfQMUz3QBgEv840DPhLoYO4/RzouDEx4TllNZ+Q2A214r3OnvbqzuqSCoSniW/V5/dLzX/1
 i+2ezPVLjONUEvFHTNERjniBDkCMRDSmGJm9mBW3SjmECGgpBHK2WdxNF05KUm8S69L3B7vyI7i
 67QldzwLMHZtCx5tQW2CQS83IWc42zY36iicXnjpnOaC7IPHzO2KtOldyZdydMQ572UwY2j+yw4
 eo=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

This series came together while I was working on other reference related
code and realized that some of the individual logic implemented with the
reference backends can be moved to the generic layer.

Moving code to the generic layer, simplifies the responsibility of
individual backends and avoids deviation in logic between the backends.

The biggest changes are related to moving out usage of `parse_object()`
and `peel_object()` from reference transactions. The former is used to
validate that the OID provided points to a commit object. The latter is
an optimization technique where the packed/reftable backend store the
peeled OID whenever available, so reading such references provides the
peeled OID without having to call the ODB.

Moving object parsing to the generic layout involves moving it out of
the prepare stage of the transaction and into `ref_transaction_update()`
where every added update is checked. As such, this also involves
modifying update-ref(1) and receive-pack(1) to follow this paradigm.

---
Changes in v3:
- Remove an unwanted change which creeped up during a rebase.
- Add information in the commit message around how the order of errors
  in git-update-ref(1) will change while maintaining functionality.
- Change up the order of an `if..else` to make it clearer.
- Other small typos and fixes.
- Link to v2: https://patch.msgid.link/20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com

Changes in v2:
- Split the second commit into two: one introducing
  `ref_store_init_options` and the second to use it for reflog config.
- Use opts as the variable name consistently.
- A bunch of grammar fixes.
- Link to v1: https://patch.msgid.link/20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com

---
 builtin/receive-pack.c  |  22 ++++---
 builtin/update-ref.c    | 151 +++++++++++++++++++++++++++++++-----------------
 refs.c                  |  60 ++++++++++++++-----
 refs.h                  |  16 ++---
 refs/files-backend.c    |  58 +++++++------------
 refs/packed-backend.c   |  10 ++--
 refs/packed-backend.h   |   3 +-
 refs/refs-internal.h    |  35 +++++++++--
 refs/reftable-backend.c |  40 +++----------
 9 files changed, 231 insertions(+), 164 deletions(-)

Karthik Nayak (9):
      refs: remove unused typedef 'ref_transaction_commit_fn'
      refs: introduce `ref_store_init_options`
      refs: extract out reflog config to generic layer
      refs: return `ref_transaction_error` from `ref_transaction_update()`
      update-ref: move `print_rejected_refs()` up
      update-ref: handle rejections while adding updates
      refs: move object parsing to the generic layer
      refs: add peeled object ID to the `ref_update` struct
      refs: use peeled tag values in reference backends

Range-diff versus v2:

 1:  b8ab8a6c8b =  1:  704a218bce refs: remove unused typedef 'ref_transaction_commit_fn'
 2:  dd419614e0 !  2:  f3e0caa8e4 refs: introduce `ref_store_init_options`
    @@ refs/files-backend.c: static struct ref_store *files_ref_store_init(struct repos
      	refs->gitcommondir = strbuf_detach(&ref_common_dir, NULL);
      	refs->packed_ref_store =
     -		packed_ref_store_init(repo, NULL, refs->gitcommondir, flags);
    -+		packed_ref_store_init(repo, payload, refs->gitcommondir, opts);
    ++		packed_ref_store_init(repo, NULL, refs->gitcommondir, opts);
     +	refs->store_flags = opts->access_flags;
      	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
     +
 3:  337e5c8c5b !  3:  48ebcc2438 refs: extract out reflog config to generic layer
    @@ refs.c: static struct ref_store *ref_store_init(struct repository *repo,
      ## refs/files-backend.c ##
     @@ refs/files-backend.c: static struct ref_store *files_ref_store_init(struct repository *repo,
      	refs->packed_ref_store =
    - 		packed_ref_store_init(repo, payload, refs->gitcommondir, opts);
    + 		packed_ref_store_init(repo, NULL, refs->gitcommondir, opts);
      	refs->store_flags = opts->access_flags;
     -	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
     +	refs->log_all_ref_updates = opts->log_all_ref_updates;
 4:  cdb4aad11e =  4:  d4c120ab28 refs: return `ref_transaction_error` from `ref_transaction_update()`
 5:  454549240a =  5:  6e3b16258c update-ref: move `print_rejected_refs()` up
 6:  1f224fb868 !  6:  505c5b8edb update-ref: handle rejections while adding updates
    @@ Commit message
         rejected, and also checking for rejections and only dying for generic
         failures.
     
    +    Errors encountered during updates will be shown to the user immediately
    +    unlike other errors encountered only when the transaction is
    +    prepared/committed. As the verification of object IDs and peeled tag
    +    objects will move into `ref_transaction_update()` in the following
    +    commit, this means that those errors will be shown to the user before
    +    other errors, this changes the order of errors, but the functionality
    +    remains the same.
    +
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## builtin/update-ref.c ##
    @@ builtin/update-ref.c: static void parse_cmd_update(struct ref_transaction *trans
     +					update_flags | create_reflog_flag,
     +					msg, &err);
     +
    -+	if (tx_err && tx_err != REF_TRANSACTION_ERROR_GENERIC &&
    -+	    opts->allow_update_failures) {
    ++	/*
    ++	 * Generic errors are non-recoverable, so we cannot skip the update
    ++	 * or mark it as rejected.
    ++	 */
    ++	if (tx_err == REF_TRANSACTION_ERROR_GENERIC)
    + 		die("%s", err.buf);
    + 
    ++	if (tx_err && opts->allow_update_failures)
     +		print_rejected_refs(refname, have_old ? &old_oid : NULL,
     +				    &new_oid, NULL, NULL, tx_err, err.buf,
     +				    NULL);
    -+	} else if (tx_err) {
    - 		die("%s", err.buf);
    -+	}
    - 
    ++
      	update_flags = default_flags;
      	free(refname);
    -@@ builtin/update-ref.c: static void parse_cmd_update(struct ref_transaction *transaction,
    + 	strbuf_release(&err);
      }
      
      static void parse_cmd_symref_update(struct ref_transaction *transaction,
    @@ builtin/update-ref.c: static void parse_cmd_symref_update(struct ref_transaction
     +					update_flags | create_reflog_flag,
     +					msg, &err);
     +
    -+	if (tx_err && tx_err != REF_TRANSACTION_ERROR_GENERIC &&
    -+	    opts->allow_update_failures) {
    ++	/*
    ++	 * Generic errors are non-recoverable, so we cannot skip the update
    ++	 * or mark it as rejected.
    ++	 */
    ++	if (tx_err == REF_TRANSACTION_ERROR_GENERIC)
    + 		die("%s", err.buf);
    + 
    ++	if (tx_err && opts->allow_update_failures)
     +		print_rejected_refs(refname, have_old_oid ? &old_oid : NULL,
     +				    NULL, have_old_oid ? NULL : old_target,
     +				    new_target, tx_err, err.buf, NULL);
    -+	} else if (tx_err) {
    - 		die("%s", err.buf);
    -+	}
    - 
    ++
      	update_flags = default_flags;
      	free(refname);
    + 	free(old_arg);
     @@ builtin/update-ref.c: static void parse_cmd_symref_update(struct ref_transaction *transaction,
      }
      
 7:  a52b019afa !  7:  ad1aae6b35 refs: move object parsing to the generic layer
    @@ builtin/receive-pack.c: static const char *update(struct command *cmd, struct sh
     -	}
     -	else {
     +	} else {
    -+		enum ref_transaction_error err_type;
    ++		enum ref_transaction_error tx_err;
      		struct strbuf err = STRBUF_INIT;
      		if (shallow_update && si->shallow_ref[cmd->index] &&
      		    update_shallow_ref(cmd, si)) {
    @@ builtin/receive-pack.c: static const char *update(struct command *cmd, struct sh
     -					   NULL, NULL,
     -					   0, "push",
     -					   &err)) {
    -+		err_type = ref_transaction_update(transaction,
    ++		tx_err = ref_transaction_update(transaction,
     +						  namespaced_name,
     +						  new_oid, old_oid,
     +						  NULL, NULL,
     +						  0, "push",
     +						  &err);
    -+		if (err_type) {
    ++		if (tx_err) {
      			rp_error("%s", err.buf);
     -			ret = "failed to update ref";
    -+			if (err_type == REF_TRANSACTION_ERROR_GENERIC)
    ++			if (tx_err == REF_TRANSACTION_ERROR_GENERIC)
     +				ret = "failed to update ref";
     +			else
    -+				ret = ref_transaction_error_msg(err_type);
    ++				ret = ref_transaction_error_msg(tx_err);
      		} else {
      			ret = NULL; /* good */
      		}
 8:  aa5fd09831 !  8:  5cb7ee9853 refs: add peeled object ID to the `ref_update` struct
    @@ Metadata
      ## Commit message ##
         refs: add peeled object ID to the `ref_update` struct
     
    -    Certain reference backend {packed, reftable}, have the ability to also
    +    Certain reference backends {packed, reftable}, have the ability to also
         store the peeled object ID for a reference pointing to a tag object.
         This has the added benefit that during retrieval of such references, we
         also obtain the peeled object ID without having to use the ODB.
 9:  96146b5083 =  9:  ba34e10548 refs: use peeled tag values in reference backends


base-commit: f65aba1e87db64413b6d1ed5ae5a45b5a84a0997
change-id: 20260417-refs-move-to-generic-layer-f7525c5e8764

Thanks
- Karthik

