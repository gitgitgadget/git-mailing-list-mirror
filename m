Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B321DFFC
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145099; cv=none; b=q+98rWD10VYbk5fvMGNv6FsL3pQCfTaJOByk9fzz5wG5+s5u/11I1bthA9qL/93b8VKEJFnk6ix399shgicCULsON8KmGGlLhEzFkCXxnkAmeUD+vqv18u2/MHPTHON9qCJe5YnA5zaDDv2o0jnFN5yGN8iv5xwGWDcPyu31fVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145099; c=relaxed/simple;
	bh=b4zbMWdNmAQGY0Puli0GqsAp6c+arbIOWteWEztalOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiG1xgKG2BTzWyKuOEb2vWrwUc/ZuWBfA3QyXIRl+b09fUQ1ZBl0YKqy7BSRjkPrrsi03cjgGQGEYAFhyi19mqthS0LnzSyegFqnhzKoNJkq6k+x0bOixCdQ1EdU6RxbBHtEhB6l7d2ntqgdbUJWE5WS/S2BRoCdGeEiKpNRrp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBV1KRbS; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBV1KRbS"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a5557e3ebcaso383756166b.1
        for <git@vger.kernel.org>; Fri, 26 Apr 2024 08:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714145094; x=1714749894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/k7ajxbZTentn2vBeSyUY1FW/z7joLGogvjcRdN6Apg=;
        b=bBV1KRbSZZ0Y4lacJDNmSjOFgVP3pBrlo3sl4Otjtuz8ML/T6HCCsUaWjAkVLAcK/6
         kltm1OJSkYn9tISuPV5pSyHJtp7E1KcTziTOm7fUnwhIx8/ig/QcB/2LsUnIEOAYB5Hk
         FjwRWYXAL/ctUkow6dxGpKHn2Cv7Ba0DIWEb3UOIuSYxLHMlaChasEgP5nW86g0DlkQ2
         h9kt0Aw63Ovj82dLMmeaKoOosgLqk6FCb/IIkdi8MHmv8QKpTvbFEm9XgDu30R/lwjv8
         5eRp4Rk3PA2sTN13SommNeboTxjIDb9M1zgz4MJtDwFZ/UB6hvr0aLzQe2XHzdqWJi7M
         3PAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145094; x=1714749894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/k7ajxbZTentn2vBeSyUY1FW/z7joLGogvjcRdN6Apg=;
        b=K6y8KVg6IisC2IqppOV0Bj4ZKE01L6SPEXWIjxfOusu8SMZegkib8isLuoNHUUAgMy
         204doD9z6mwe4OzFfolpBHdMNxdpSEArq4v77vLmuyWVSyL1ItxkG+/o8RlhznKmcujK
         92qLrQuabB4eQzi+vkswlAZw3YZ/Z4GXfPOGD4j5lsMqFVQYPCJQQED8PPb82fK2mUoQ
         mIGqJTGaegvMSy+/sdEBvDaQDVjkMqRZFMxkYrWtfvc2n8sGsa6DMyKEcRLiGymFj1tb
         8IkTX2FbLhLHtas5OXmh++BVLEvXbt0Pf7aGThObzAQu0xxt99Ca6Tpvmh0egbuzzAhm
         UUxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmCOacKpYqPtiz5k87UKx7Z3eLNpi3GX22cok8NC0qKfkTURNRmNor/DWPtYdFge/Mqabt1pU1c2+c2drcuHGSzgy1
X-Gm-Message-State: AOJu0YwwcopGc3X5e61NcLeFp6HNx2aHfvmDnudQfnEw5ZPaPX1LCBk8
	Jgr6VCh9KlpCkhJSAW/6jnNW7k/r2CBrsrRJ5/OrvDC9NKByA9iv1cdwHA==
X-Google-Smtp-Source: AGHT+IH6CqtfNzMVrpXk1fi6aFRUqUveRPUY8ulVctGaOQSVxYr01a2L7MXqO2GoWjFyyLypUdZ6QA==
X-Received: by 2002:a17:906:3404:b0:a55:aded:200d with SMTP id c4-20020a170906340400b00a55aded200dmr2546012ejb.12.1714145093200;
        Fri, 26 Apr 2024 08:24:53 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id z6-20020a170906434600b00a518c69c4e3sm10643868ejm.23.2024.04.26.08.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:24:52 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v4 0/7] add symref-* commands to 'git-update-ref --stdin'
Date: Fri, 26 Apr 2024 17:24:42 +0200
Message-ID: <20240426152449.228860-1-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423212818.574123-1-knayak@gitlab.com>
References: <20240423212818.574123-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The 'git-update-ref(1)' command allows transactional reference updates.
But currently only supports regular reference updates. Meaning, if one
wants to update HEAD (symbolic ref) in a transaction, there is no tool
to do so.

One option to obtain transactional updates for the HEAD ref is to
manually create the HEAD.lock file and commit. This is intrusive, where
the user needs to mimic internal git behavior. Also, this only works
when using the files backend.

At GitLab, we've been using the manual process till date, to allow users
to set and change their default branch. But with the introduction of
reftables as a reference backend, this becomes a necessity to be solved
within git.

This patch series goes about introducing a set of commands
symref-{create,verify,delete,update} to work with symrefs complimenting
the existing commands for the regular refs in the '--stdin' mode of
'git-update-ref'.

The 'symref-verify' command can be used to verify if a symref exists and
its existing value.

The 'symref-create' command can be used to create a new symref.

The 'symref-delete' command can be used to delete an existing symref while
optionally checking its existing value.

The 'symref-update' command can be used to update a symref, create a symref,
delete a symref or even convert an existing regular ref to a symref. Wherein
like the regular 'update' command, the zero OID can be used to create/delete
a symref.

While this series adds the commands and the required ground work, it only
is accessile within the '--stdin' mode of 'git-update-ref'. However, it makes
it easy to extend it further to the command line too, which will be present
in a follow up series.

Previous versions:
V1: https://lore.kernel.org/git/20240330224623.579457-1-knayak@gitlab.com/
V2: https://lore.kernel.org/git/20240412095908.1134387-1-knayak@gitlab.com/
V3: https://lore.kernel.org/git/20240423212818.574123-1-knayak@gitlab.com/

V3 took a different approach of incorporating changes into the existing commands, 
of 'git-update-ref --stdin' but we realized that there was some ambiguity in how
these commands are parsed [1]. In that sense it makes more sense to compare this
version with v2 instead.

Changes over v2 are:

- Rename (old|new)_ref to (old|new)_target, to avoid confusion.
- Better assertions around the input data.
- Removing the REF_SYMREF_UPDATE flag.
- Filled in missing/new documentation.
- For symref-update, realized that there was some ambiguity on how the
  old_oid and old_target was parsed, and now the command requires the
  user to explicitly input the data type.
- Support dangling refs in all operations.
- More test cases around empty values.
- Removed unecessary header includes.
- Fixed whitespace issues with the previous series.
- Other review comments.


[1]: https://lore.kernel.org/git/20240423220308.GC1172807@coredump.intra.peff.net/

Range diff (against v2):

1:  3269d0e91e ! 1:  4a56e3ede4 refs: accept symref values in `ref_transaction[_add]_update`
    @@ Commit message
         flags to create a `ref_update` and add it to the transaction at hand.
     
         To extend symref support in transactions, we need to also accept the
    -    old and new ref values and process it. In this commit, let's add the
    -    required paramaters to the function and modify all call sites.
    +    old and new ref targets and process it. In this commit, let's add the
    +    required parameters to the function and modify all call sites.
     
    -    The two paramaters added are `new_ref` and `old_ref`. The `new_ref` is
    -    used to denote what the reference should point to when the transaction
    -    is applied. Some functions allow this parameter to be NULL, meaning that
    -    the reference is not changed, or `""`, meaning that the reference should
    -    be deleted.
    +    The two parameters added are `new_target` and `old_target`. The
    +    `new_target` is used to denote what the reference should point to when
    +    the transaction is applied.
     
    -    The `old_ref` denotes the value of that the reference must have before
    -    the update. Some functions allow this parameter to be NULL, meaning that
    -    the old value of the reference is not checked, or `""`, meaning that the
    -    reference must not exist before the update. A copy of this value is made
    -    in the transaction.
    +    The `old_target` denotes the value the reference must have before the
    +    update. Some functions allow this parameter to be NULL, meaning that the
    +    old value of the reference is not checked.
     
         The handling logic of these parameters will be added in consequent
    -    commits as we implement symref-{create, update, delete, verify}.
    +    commits as we add symref commands to the '--stdin' mode of
    +    'git-update-ref'.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ refs.c: struct ref_update *ref_transaction_add_update(
      		const char *refname, unsigned int flags,
      		const struct object_id *new_oid,
      		const struct object_id *old_oid,
    -+		const char *new_ref, const char *old_ref,
    ++		const char *new_target, const char *old_target,
      		const char *msg)
      {
      	struct ref_update *update;
    +@@ refs.c: struct ref_update *ref_transaction_add_update(
    + 	if (transaction->state != REF_TRANSACTION_OPEN)
    + 		BUG("update called for transaction that is not open");
    + 
    ++	if (old_oid && !is_null_oid(old_oid) && old_target)
    ++		BUG("Only one of old_oid and old_target should be non NULL");
    ++	if (new_oid && !is_null_oid(new_oid) && new_target)
    ++		BUG("Only one of new_oid and new_target should be non NULL");
    ++
    + 	FLEX_ALLOC_STR(update, refname, refname);
    + 	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
    + 	transaction->updates[transaction->nr++] = update;
     @@ refs.c: int ref_transaction_update(struct ref_transaction *transaction,
      			   const char *refname,
      			   const struct object_id *new_oid,
      			   const struct object_id *old_oid,
    -+			   const char *new_ref, const char *old_ref,
    ++			   const char *new_target,
    ++			   const char *old_target,
      			   unsigned int flags, const char *msg,
      			   struct strbuf *err)
      {
    @@ refs.c: int ref_transaction_update(struct ref_transaction *transaction,
      
      	ref_transaction_add_update(transaction, refname, flags,
     -				   new_oid, old_oid, msg);
    -+				   new_oid, old_oid, new_ref, old_ref, msg);
    ++				   new_oid, old_oid, new_target,
    ++				   old_target, msg);
      	return 0;
      }
      
    @@ refs.c: int refs_update_ref(struct ref_store *refs, const char *msg,
     
      ## refs.h ##
     @@ refs.h: struct ref_transaction *ref_transaction_begin(struct strbuf *err);
    -  */
    - #define REF_SKIP_REFNAME_VERIFICATION (1 << 11)
    - 
    -+/*
    -+ * The reference update is considered to be done on a symbolic reference. This
    -+ * ensures that we verify, delete, create and update the ref correspondingly.
    -+ */
    -+#define REF_SYMREF_UPDATE (1 << 12)
    -+
    - /*
    -  * Bitmask of all of the flags that are allowed to be passed in to
    -  * ref_transaction_update() and friends:
    -  */
    - #define REF_TRANSACTION_UPDATE_ALLOWED_FLAGS                                  \
    - 	(REF_NO_DEREF | REF_FORCE_CREATE_REFLOG | REF_SKIP_OID_VERIFICATION | \
    --	 REF_SKIP_REFNAME_VERIFICATION)
    -+	 REF_SKIP_REFNAME_VERIFICATION | REF_SYMREF_UPDATE )
    - 
    - /*
    -  * Add a reference update to transaction. `new_oid` is the value that
    +  *         before the update. A copy of this value is made in the
    +  *         transaction.
    +  *
    ++ *     new_target -- the target reference that the reference will be
    ++ *         update to point to. This takes precedence over new_oid when
    ++ *         set. If the reference is a regular reference, it will be
    ++ *         converted to a symbolic reference.
    ++ *
    ++ *     old_target -- the reference that the reference must be pointing to.
    ++ *         Will only be taken into account when the reference is a symbolic
    ++ *         reference.
    ++ *
    +  *     flags -- flags affecting the update, passed to
    +  *         update_ref_lock(). Possible flags: REF_NO_DEREF,
    +  *         REF_FORCE_CREATE_REFLOG. See those constants for more
    +@@ refs.h: struct ref_transaction *ref_transaction_begin(struct strbuf *err);
    +  * beforehand. The old value is checked after the lock is taken to
    +  * prevent races. If the old value doesn't agree with old_oid, the
    +  * whole transaction fails. If old_oid is NULL, then the previous
    +- * value is not checked.
    ++ * value is not checked. If `old_target` is not NULL, treat the reference
    ++ * as a symbolic ref and validate that its target before the update is
    ++ * `old_target`. If the `new_target` is not NULL, then the reference
    ++ * will be updated to a symbolic ref which targets `new_target`.
    ++ * Together, these allow us to update between regular refs and symrefs.
    +  *
    +  * See the above comment "Reference transaction updates" for more
    +  * information.
     @@ refs.h: int ref_transaction_update(struct ref_transaction *transaction,
      			   const char *refname,
      			   const struct object_id *new_oid,
      			   const struct object_id *old_oid,
    -+			   const char *new_ref, const char *old_ref,
    ++			   const char *new_target,
    ++			   const char *old_target,
      			   unsigned int flags, const char *msg,
      			   struct strbuf *err);
      
    @@ refs/refs-internal.h: struct ref_update {
      	struct object_id old_oid;
      
     +	/*
    -+	 * If (flags & REF_SYMREF_UPDATE), set the reference to this
    -+	 * value (or delete it, if `new_ref` is an empty string).
    ++	 * If set, point the reference to this value. This can also be
    ++	 * used to convert regular references to become symbolic refs.
     +	 */
    -+	const char *new_ref;
    ++	const char *new_target;
     +
     +	/*
    -+	 * If (type & REF_SYMREF_UPDATE), check that the reference
    -+	 * previously had this value (or didn't previously exist,
    -+	 * if `old_ref` is an empty string).
    ++	 * If set and the reference is a symbolic ref, check that the
    ++	 * reference previously pointed to this value.
     +	 */
    -+	const char *old_ref;
    ++	const char *old_target;
     +
      	/*
      	 * One or more of REF_NO_DEREF, REF_FORCE_CREATE_REFLOG,
    @@ refs/refs-internal.h: struct ref_update *ref_transaction_add_update(
      		const char *refname, unsigned int flags,
      		const struct object_id *new_oid,
      		const struct object_id *old_oid,
    -+		const char *new_ref, const char *old_ref,
    ++		const char *new_target, const char *old_target,
      		const char *msg);
      
      /*
4:  53fdb408ef = 2:  496bf14f28 files-backend: extract out `create_symref_lock`
2:  a8cb0e0a1d ! 3:  6337859cbb update-ref: add support for symref-verify
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    update-ref: add support for symref-verify
    +    update-ref: add support for 'symref-verify' command
     
    -    In the previous commit, we added the required base for adding symref
    -    support in transactions provided by the 'git-update-ref(1)'. This commit
    -    introduces the 'symref-verify' command which is similar to the existing
    -    'verify' command for regular refs.
    +    In the previous commits, we added the required base for adding symref
    +    commands to the '--stdin' mode provided by 'git-update-ref(1)'. Using
    +    them, add a new 'symref-verify' command to verify symrefs.
     
         The 'symref-verify' command allows users to verify if a provided <ref>
    -    contains the provided <old-ref> without changing the <ref>. If <old-ref>
    -    is not provided, the command will verify that the <ref> doesn't exist.
    -    Since we're checking for symbolic refs, this command will only work with
    -    the 'no-deref' mode. This is because any dereferenced symbolic ref will
    -    point to an object and not a ref and the regular 'verify' command can be
    -    used in such situations.
    +    contains the provided <old-target> without changing the <ref>. If
    +    <old-target> is not provided, the command will verify that the <ref>
    +    doesn't exist. Since we're checking for symbolic refs, this command will
    +    only work with the 'no-deref' mode. This is because any dereferenced
    +    symbolic ref will point to an object and not a ref and the regular
    +    'verify' command can be used in such situations.
     
    -    This commit adds all required helper functions required to also
    -    introduce the other symref commands, namely create, delete, and update.
    +    Add and use `ref_update_is_null_new_value`, a helper function which is
    +    used to check if there is a new_value in a reference update. The new
    +    value could either be a symref target `new_target` or a OID `new_oid`.
         We also add tests to test the command in both the regular stdin mode and
         also with the '-z' flag.
     
    -    When the user doesn't provide a <old-ref> we need to check that the
    -    provided <ref> doesn't exist. And to do this, we take over the existing
    -    understanding that <old-oid> when set to its zero value, it refers to
    -    the ref not existing. While this seems like a mix of contexts between
    -    using <*-ref> and <*-oid>, this actually works really well, especially
    -    considering the fact that we want to eventually also introduce
    -
    -        symref-update SP <ref> SP <new-ref> [SP (<old-oid> | <old-rev>)] LF
    -
    -    and here, we'd allow the user to update a regular <ref> to a symref and
    -    use <old-oid> to check the <ref>'s oid. This can be extrapolated to the
    -    user using this to create a symref when provided a zero <old-oid>. Which
    -    will work given how we're setting it up.
    -
         We also disable the reference-transaction hook for symref-updates which
         will be tackled in its own commit.
     
    -    Add required tests for 'symref-verify' while also adding reflog checks for
    -    the pre-existing 'verify' tests.
    +    Add required tests for symref support in 'verify' while also adding
    +    reflog checks for the pre-existing 'verify' tests.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ Documentation/git-update-ref.txt: performs all modifications together.  Specify
      	create SP <ref> SP <new-oid> LF
      	delete SP <ref> [SP <old-oid>] LF
      	verify SP <ref> [SP <old-oid>] LF
    -+	symref-verify SP <ref> [SP <old-ref>] LF
    ++	symref-verify SP <ref> [SP <old-target>] LF
      	option SP <opt> LF
      	start LF
      	prepare LF
    @@ Documentation/git-update-ref.txt: quoting:
      	create SP <ref> NUL <new-oid> NUL
      	delete SP <ref> NUL [<old-oid>] NUL
      	verify SP <ref> NUL [<old-oid>] NUL
    -+	symref-verify SP <ref> [NUL <old-ref>] NUL
    ++	symref-verify SP <ref> [NUL <old-target>] NUL
      	option SP <opt> NUL
      	start NUL
      	prepare NUL
    @@ Documentation/git-update-ref.txt: verify::
      	<old-oid> is zero or missing, the ref must not exist.
      
     +symref-verify::
    -+	Verify symbolic <ref> against <old-ref> but do not change it.
    -+	If <old-ref> is missing, the ref must not exist.  Can only be
    ++	Verify symbolic <ref> against <old-target> but do not change it.
    ++	If <old-target> is missing, the ref must not exist.  Can only be
     +	used in `no-deref` mode.
     +
      option::
    @@ builtin/update-ref.c: static char *parse_refname(const char **next)
      	return strbuf_detach(&ref, NULL);
      }
      
    -+
    -+
     +/*
     + * Wrapper around parse_refname which skips the next delimiter.
     + */
     +static char *parse_next_refname(const char **next)
     +{
    -+        if (line_termination) {
    -+                /* Without -z, consume SP and use next argument */
    -+                if (!**next || **next == line_termination)
    -+                        return NULL;
    -+                if (**next != ' ')
    -+                        die("expected SP but got: %s", *next);
    -+        } else {
    -+                /* With -z, read the next NUL-terminated line */
    -+                if (**next)
    -+                        return NULL;
    -+        }
    -+        /* Skip the delimiter */
    -+        (*next)++;
    ++	if (line_termination) {
    ++		/* Without -z, consume SP and use next argument */
    ++		if (!**next || **next == line_termination)
    ++			return NULL;
    ++		if (**next != ' ')
    ++			die("expected SP but got: %s", *next);
    ++	} else {
    ++		/* With -z, read the next NUL-terminated line */
    ++		if (**next)
    ++			return NULL;
    ++	}
    ++	/* Skip the delimiter */
    ++	(*next)++;
     +
    -+        return parse_refname(next);
    ++	return parse_refname(next);
     +}
    ++
     +
      /*
       * The value being parsed is <old-oid> (as opposed to <new-oid>; the
    @@ builtin/update-ref.c: static void parse_cmd_verify(struct ref_transaction *trans
     +}
     +
     +static void parse_cmd_symref_verify(struct ref_transaction *transaction,
    -+                                    const char *next, const char *end)
    ++				    const char *next, const char *end)
     +{
     +	struct strbuf err = STRBUF_INIT;
     +	struct object_id old_oid;
    -+	char *refname, *old_ref;
    ++	char *refname, *old_target;
     +
     +	if (!(update_flags & REF_NO_DEREF))
     +		die("symref-verify: cannot operate with deref mode");
    @@ builtin/update-ref.c: static void parse_cmd_verify(struct ref_transaction *trans
     +	 * old_ref is optional, but we want to differentiate between
     +	 * a NULL and zero value.
     +	 */
    -+	old_ref = parse_next_refname(&next);
    -+	if (!old_ref)
    ++	old_target = parse_next_refname(&next);
    ++	if (!old_target)
     +		old_oid = *null_oid();
    -+	else if (read_ref(old_ref, NULL))
    -+		die("symref-verify %s: invalid <old-ref>", refname);
     +
     +	if (*next != line_termination)
     +		die("symref-verify %s: extra input: %s", refname, next);
     +
    -+	if (ref_transaction_verify(transaction, refname, old_ref ? NULL : &old_oid,
    -+				   old_ref, update_flags | REF_SYMREF_UPDATE, &err))
    ++	if (ref_transaction_verify(transaction, refname,
    ++				   old_target ? NULL : &old_oid,
    ++				   old_target, update_flags, &err))
      		die("%s", err.buf);
      
      	update_flags = default_flags;
      	free(refname);
    -+	free(old_ref);
    ++	free(old_target);
      	strbuf_release(&err);
      }
      
    @@ builtin/update-ref.c: static const struct parse_cmd {
      static void update_refs_stdin(void)
     
      ## refs.c ##
    -@@
    - #include "object-store-ll.h"
    - #include "object.h"
    - #include "path.h"
    -+#include "string.h"
    - #include "tag.h"
    - #include "submodule.h"
    - #include "worktree.h"
    -@@
    - #include "date.h"
    - #include "commit.h"
    - #include "wildmatch.h"
    -+#include "wrapper.h"
    - 
    - /*
    -  * List of all available backends
     @@ refs.c: void ref_transaction_free(struct ref_transaction *transaction)
      
      	for (i = 0; i < transaction->nr; i++) {
      		free(transaction->updates[i]->msg);
    -+		free((void *)transaction->updates[i]->old_ref);
    ++		free((void *)transaction->updates[i]->old_target);
    ++		free((void *)transaction->updates[i]->new_target);
      		free(transaction->updates[i]);
      	}
      	free(transaction->updates);
    @@ refs.c: struct ref_update *ref_transaction_add_update(
      	update->flags = flags;
      
     -	if (flags & REF_HAVE_NEW)
    --		oidcpy(&update->new_oid, new_oid);
    ++	if (new_target)
    ++		update->new_target = xstrdup(new_target);
    ++	if (old_target)
    ++		update->old_target = xstrdup(old_target);
    ++	if (new_oid && flags & REF_HAVE_NEW)
    + 		oidcpy(&update->new_oid, new_oid);
     -	if (flags & REF_HAVE_OLD)
    --		oidcpy(&update->old_oid, old_oid);
    -+	/*
    -+	 * The ref values are to be considered over the oid values when we're
    -+	 * doing symref operations.
    -+	 */
    -+	if (update->flags & REF_SYMREF_UPDATE) {
    -+		if (old_ref)
    -+			update->old_ref = xstrdup(old_ref);
    -+	} else {
    -+		if (flags & REF_HAVE_NEW)
    -+			oidcpy(&update->new_oid, new_oid);
    -+		if (flags & REF_HAVE_OLD)
    -+			oidcpy(&update->old_oid, old_oid);
    -+	}
    ++	if (old_oid && flags & REF_HAVE_OLD)
    + 		oidcpy(&update->old_oid, old_oid);
      	update->msg = normalize_reflog_message(msg);
      	return update;
    - }
     @@ refs.c: int ref_transaction_update(struct ref_transaction *transaction,
      	flags &= REF_TRANSACTION_UPDATE_ALLOWED_FLAGS;
      
      	flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
    -+	flags |= (new_ref ? REF_HAVE_NEW : 0) | (old_ref ? REF_HAVE_OLD : 0);
    ++	flags |= (new_target ? REF_HAVE_NEW : 0) | (old_target ? REF_HAVE_OLD : 0);
      
      	ref_transaction_add_update(transaction, refname, flags,
    - 				   new_oid, old_oid, new_ref, old_ref, msg);
    + 				   new_oid, old_oid, new_target,
     @@ refs.c: int ref_transaction_delete(struct ref_transaction *transaction,
      int ref_transaction_verify(struct ref_transaction *transaction,
      			   const char *refname,
      			   const struct object_id *old_oid,
    -+			   const char *old_ref,
    ++			   const char *old_target,
      			   unsigned int flags,
      			   struct strbuf *err)
      {
     -	if (!old_oid)
    -+	if (flags & REF_SYMREF_UPDATE && !old_ref && !old_oid)
    -+		BUG("verify called with old_ref set to NULL");
    -+	if (!(flags & REF_SYMREF_UPDATE) && !old_oid)
    - 		BUG("verify called with old_oid set to NULL");
    +-		BUG("verify called with old_oid set to NULL");
    ++	if (!old_target && !old_oid)
    ++		BUG("verify called with old_oid and old_target set to NULL");
    ++	if (old_target && !(flags & REF_NO_DEREF))
    ++		BUG("verify cannot operate on symrefs with deref mode");
      	return ref_transaction_update(transaction, refname,
      				      NULL, old_oid,
     -				      NULL, NULL,
    -+				      NULL, old_ref,
    ++				      NULL, old_target,
      				      flags, NULL, err);
      }
      
    @@ refs.c: static int run_transaction_hook(struct ref_transaction *transaction,
      	for (i = 0; i < transaction->nr; i++) {
      		struct ref_update *update = transaction->updates[i];
      
    -+		if (update->flags & REF_SYMREF_UPDATE)
    ++		/*
    ++		 * Skip reference transaction for symbolic refs.
    ++		 */
    ++		if (update->new_target || update->old_target)
     +			continue;
     +
      		strbuf_reset(&buf);
    @@ refs.c: int copy_existing_ref(const char *oldref, const char *newref, const char
      	return refs_copy_existing_ref(get_main_ref_store(the_repository), oldref, newref, logmsg);
      }
     +
    -+int null_new_value(struct ref_update *update) {
    -+	if (update->flags & REF_SYMREF_UPDATE && update->new_ref)
    -+		return 0;
    -+	return is_null_oid(&update->new_oid);
    ++int ref_update_is_null_new_value(struct ref_update *update) {
    ++	return !update->new_target && is_null_oid(&update->new_oid);
     +}
     
      ## refs.h ##
    @@ refs.h: int ref_transaction_delete(struct ref_transaction *transaction,
      int ref_transaction_verify(struct ref_transaction *transaction,
      			   const char *refname,
      			   const struct object_id *old_oid,
    -+			   const char *old_ref,
    ++			   const char *old_target,
      			   unsigned int flags,
      			   struct strbuf *err);
      
    @@ refs/files-backend.c: static const char *original_update_refname(struct ref_upda
      }
      
     +/*
    -+ * Check whether the REF_HAVE_OLD and old_ref values stored in update
    -+ * are consistent with ref, which is the symbolic reference's current
    -+ * value. If everything is OK, return 0; otherwise, write an error
    -+ * message to err and return -1.
    ++ * Check whether the REF_HAVE_OLD and old_target values stored in
    ++ * update are consistent with ref, which is the symbolic reference's
    ++ * current value. If everything is OK, return 0; otherwise, write an
    ++ * error message to err and return -1.
     + */
    -+static int check_old_ref(struct ref_update *update, char *ref,
    -+			 struct strbuf *err)
    ++static int check_old_target(struct ref_update *update, char *ref,
    ++			    struct strbuf *err)
     +{
     +	if (!(update->flags & REF_HAVE_OLD) ||
    -+	    !strcmp(update->old_ref, ref))
    ++	    !strcmp(update->old_target, ref))
     +		return 0;
     +
    -+	if (!strcmp(update->old_ref, ""))
    ++	if (!strcmp(update->old_target, ""))
     +		strbuf_addf(err, "cannot lock ref '%s': "
     +			    "reference already exists",
     +			    original_update_refname(update));
    @@ refs/files-backend.c: static const char *original_update_refname(struct ref_upda
     +		strbuf_addf(err, "cannot lock ref '%s': "
     +			    "reference is missing but expected %s",
     +			    original_update_refname(update),
    -+			    update->old_ref);
    ++			    update->old_target);
     +	else
     +		strbuf_addf(err, "cannot lock ref '%s': "
     +			    "is at %s but expected %s",
     +			    original_update_refname(update),
    -+			    ref, update->old_ref);
    ++			    ref, update->old_target);
     +
     +	return -1;
     +}
    @@ refs/files-backend.c: static const char *original_update_refname(struct ref_upda
      /*
       * Check whether the REF_HAVE_OLD and old_oid values stored in update
       * are consistent with oid, which is the reference's current value. If
    -@@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *refs,
    - 			       struct strbuf *err)
    - {
    - 	struct strbuf referent = STRBUF_INIT;
    --	int mustexist = (update->flags & REF_HAVE_OLD) &&
    --		!is_null_oid(&update->old_oid);
    -+	int mustexist = (update->flags & REF_HAVE_OLD) && !is_null_oid(&update->old_oid);
    - 	int ret = 0;
    - 	struct ref_lock *lock;
    - 
     @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *refs,
      					ret = TRANSACTION_GENERIC_ERROR;
      					goto out;
    @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *ref
     +			}
     +
     +			/*
    -+			 * For symref verification, we need to check the referent value
    ++			 * For symref verification, we need to check the reference value
     +			 * rather than the oid. If we're dealing with regular refs or we're
     +			 * verifying a dereferenced symref, we then check the oid.
     +			 */
    -+			if (update->flags & REF_SYMREF_UPDATE && update->old_ref) {
    -+				if (check_old_ref(update, referent.buf, err)) {
    ++			if (update->old_target) {
    ++				if (check_old_target(update, referent.buf, err)) {
     +					ret = TRANSACTION_GENERIC_ERROR;
     +					goto out;
     +				}
    @@ refs/refs-internal.h: void base_ref_store_init(struct ref_store *refs, struct re
     + * takes into consideration that the update could be a regular
     + * ref or a symbolic ref.
     + */
    -+int null_new_value(struct ref_update *update);
    ++int ref_update_is_null_new_value(struct ref_update *update);
     +
      #endif /* REFS_REFS_INTERNAL_H */
     
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
      		 * backend returns, which keeps our tests happy.
      		 */
     -		if (u->flags & REF_HAVE_OLD && !oideq(&current_oid, &u->old_oid)) {
    -+		if ((u->flags & REF_HAVE_OLD) &&
    -+		    (u->flags & REF_SYMREF_UPDATE) &&
    -+		    u->old_ref) {
    -+			if   (strcmp(referent.buf, u->old_ref)) {
    -+				if (!strcmp(u->old_ref, ""))
    -+					strbuf_addf(err, "cannot lock ref '%s': "
    -+						    "reference already exists",
    ++		if ((u->flags & REF_HAVE_OLD) && u->old_target) {
    ++			if (strcmp(referent.buf, u->old_target)) {
    ++				if (!strcmp(u->old_target, ""))
    ++					strbuf_addf(err, "verifying symref target: '%s': "
    ++						    "provided target is empty",
     +						    original_update_refname(u));
     +				else if (!strcmp(referent.buf, ""))
    -+					strbuf_addf(err, "cannot lock ref '%s': "
    ++					strbuf_addf(err, "verifying symref target: '%s': "
     +						    "reference is missing but expected %s",
     +						    original_update_refname(u),
    -+						    u->old_ref);
    ++						    u->old_target);
     +				else
    -+					strbuf_addf(err, "cannot lock ref '%s': "
    ++					strbuf_addf(err, "verifying symref target: '%s': "
     +						    "is at %s but expected %s",
     +						    original_update_refname(u),
    -+						    referent.buf, u->old_ref);
    ++						    referent.buf, u->old_target);
     +				ret = -1;
     +				goto done;
     +			}
    @@ t/t1400-update-ref.sh: test_expect_success PIPE 'transaction flushes status upda
      	test_cmp expected actual
      '
      
    -+create_stdin_buf ()
    -+{
    ++create_stdin_buf () {
     +	if test "$1" = "-z"
     +	then
     +		shift
    @@ t/t1400-update-ref.sh: test_expect_success PIPE 'transaction flushes status upda
     +for type in "" "-z"
     +do
     +
    -+test_expect_success "stdin ${type} symref-verify fails without --no-deref" '
    -+	git symbolic-ref refs/heads/symref $a &&
    -+	create_stdin_buf ${type} "symref-verify refs/heads/symref" "$a" &&
    -+	test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
    -+	grep "fatal: symref-verify: cannot operate with deref mode" err
    -+'
    ++	test_expect_success "stdin ${type} symref-verify fails without --no-deref" '
    ++		git symbolic-ref refs/heads/symref $a &&
    ++		create_stdin_buf ${type} "symref-verify refs/heads/symref" "$a" &&
    ++		test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
    ++		grep "fatal: symref-verify: cannot operate with deref mode" err
    ++	'
     +
    -+test_expect_success "stdin ${type} symref-verify fails with too many arguments" '
    -+	create_stdin_buf ${type} "symref-verify refs/heads/symref" "$a" "$a" &&
    -+	test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err  &&
    -+	if test "$type" = "-z"
    -+	then
    -+		grep "fatal: unknown command: $a" err
    -+	else
    -+		grep "fatal: symref-verify refs/heads/symref: extra input:  $a" err
    -+	fi
    -+'
    ++	test_expect_success "stdin ${type} symref-verify fails with too many arguments" '
    ++		create_stdin_buf ${type} "symref-verify refs/heads/symref" "$a" "$a" &&
    ++		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err  &&
    ++		if test "$type" = "-z"
    ++		then
    ++			grep "fatal: unknown command: $a" err
    ++		else
    ++			grep "fatal: symref-verify refs/heads/symref: extra input:  $a" err
    ++		fi
    ++	'
     +
    -+test_expect_success "stdin ${type} symref-verify succeeds for correct value" '
    -+	git symbolic-ref refs/heads/symref >expect &&
    -+	test-tool ref-store main for-each-reflog-ent refs/heads/symref >before &&
    -+	create_stdin_buf ${type} "symref-verify refs/heads/symref" "$a" &&
    -+	git update-ref --stdin ${type} --no-deref <stdin &&
    -+	git symbolic-ref refs/heads/symref >actual &&
    -+	test_cmp expect actual &&
    -+	test-tool ref-store main for-each-reflog-ent refs/heads/symref >after &&
    -+	test_cmp before after
    -+'
    ++	test_expect_success "stdin ${type} symref-verify succeeds for correct value" '
    ++		git symbolic-ref refs/heads/symref >expect &&
    ++		test-tool ref-store main for-each-reflog-ent refs/heads/symref >before &&
    ++		create_stdin_buf ${type} "symref-verify refs/heads/symref" "$a" &&
    ++		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		git symbolic-ref refs/heads/symref >actual &&
    ++		test_cmp expect actual &&
    ++		test-tool ref-store main for-each-reflog-ent refs/heads/symref >after &&
    ++		test_cmp before after
    ++	'
     +
    -+test_expect_success "stdin ${type} symref-verify succeeds for missing reference" '
    -+	test-tool ref-store main for-each-reflog-ent refs/heads/symref >before &&
    -+	create_stdin_buf ${type} "symref-verify refs/heads/missing" &&
    -+	git update-ref --stdin ${type} --no-deref <stdin &&
    -+	test_must_fail git rev-parse --verify -q refs/heads/missing &&
    -+	test-tool ref-store main for-each-reflog-ent refs/heads/symref >after &&
    -+	test_cmp before after
    -+'
    ++	test_expect_success "stdin ${type} symref-verify no value is treated as zero value" '
    ++		git symbolic-ref refs/heads/symref >expect &&
    ++		create_stdin_buf ${type} "symref-verify refs/heads/symref" "" &&
    ++		test_must_fail git update-ref --stdin ${type} --no-deref <stdin
    ++	'
    ++
    ++	test_expect_success "stdin ${type} symref-verify succeeds for dangling reference" '
    ++		test_when_finished "git symbolic-ref -d refs/heads/symref2" &&
    ++		test_must_fail git symbolic-ref refs/heads/nonexistent &&
    ++		git symbolic-ref refs/heads/symref2 refs/heads/nonexistent &&
    ++		create_stdin_buf ${type} "symref-verify refs/heads/symref2" "refs/heads/nonexistent" &&
    ++		git update-ref --stdin ${type} --no-deref <stdin
    ++	'
    ++
    ++	test_expect_success "stdin ${type} symref-verify succeeds for missing reference" '
    ++		test-tool ref-store main for-each-reflog-ent refs/heads/symref >before &&
    ++		create_stdin_buf ${type} "symref-verify refs/heads/missing" "$Z" &&
    ++		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		test_must_fail git rev-parse --verify -q refs/heads/missing &&
    ++		test-tool ref-store main for-each-reflog-ent refs/heads/symref >after &&
    ++		test_cmp before after
    ++	'
     +
    -+test_expect_success "stdin ${type} symref-verify fails for wrong value" '
    -+	git symbolic-ref refs/heads/symref >expect &&
    -+	create_stdin_buf ${type} "symref-verify refs/heads/symref" "$b" &&
    -+	test_must_fail git update-ref --stdin ${type} --no-deref <stdin &&
    -+	git symbolic-ref refs/heads/symref >actual &&
    -+	test_cmp expect actual
    -+'
    ++	test_expect_success "stdin ${type} symref-verify fails for wrong value" '
    ++		git symbolic-ref refs/heads/symref >expect &&
    ++		create_stdin_buf ${type} "symref-verify refs/heads/symref" "$b" &&
    ++		test_must_fail git update-ref --stdin ${type} --no-deref <stdin &&
    ++		git symbolic-ref refs/heads/symref >actual &&
    ++		test_cmp expect actual
    ++	'
     +
    -+test_expect_success "stdin ${type} symref-verify fails for mistaken null value" '
    -+	git symbolic-ref refs/heads/symref >expect &&
    -+	create_stdin_buf ${type} "symref-verify refs/heads/symref" &&
    -+	test_must_fail git update-ref --stdin ${type} --no-deref <stdin &&
    -+	git symbolic-ref refs/heads/symref >actual &&
    -+	test_cmp expect actual
    -+'
    ++	test_expect_success "stdin ${type} symref-verify fails for mistaken null value" '
    ++		git symbolic-ref refs/heads/symref >expect &&
    ++		create_stdin_buf ${type} "symref-verify refs/heads/symref" "$Z" &&
    ++		test_must_fail git update-ref --stdin ${type} --no-deref <stdin &&
    ++		git symbolic-ref refs/heads/symref >actual &&
    ++		test_cmp expect actual
    ++	'
     +
     +done
     +
3:  37c3e006da ! 4:  e611cb5a8c update-ref: add support for symref-delete
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    update-ref: add support for symref-delete
    +    update-ref: add support for 'symref-delete' command
     
    -    Similar to the previous commit, add 'symref-delete' to allow deletions
    -    of symbolic refs in a transaction via the 'git-update-ref' command. The
    -    'symref-delete' command can when given with an <old-ref>, deletes the
    -    provided <ref> only when it points to <old-ref>.
    +    Add a new command 'symref-delete' to allow deletions of symbolic refs in
    +    a transaction via the '--stdin' mode of the 'git-update-ref' command.
    +    The 'symref-delete' command can, when given an <old-target>, delete the
    +    provided <ref> only when it points to <old-target>. This will only work
    +    when used with the 'no-deref' mode as it doesn't make sense to deref a
    +    symref during deletion.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ Documentation/git-update-ref.txt: performs all modifications together.  Specify
      	create SP <ref> SP <new-oid> LF
      	delete SP <ref> [SP <old-oid>] LF
      	verify SP <ref> [SP <old-oid>] LF
    -+	symref-delete SP <ref> [SP <old-ref>] LF
    - 	symref-verify SP <ref> [SP <old-ref>] LF
    ++	symref-delete SP <ref> [SP <old-target>] LF
    + 	symref-verify SP <ref> [SP <old-target>] LF
      	option SP <opt> LF
      	start LF
     @@ Documentation/git-update-ref.txt: quoting:
      	create SP <ref> NUL <new-oid> NUL
      	delete SP <ref> NUL [<old-oid>] NUL
      	verify SP <ref> NUL [<old-oid>] NUL
    -+	symref-delete SP <ref> [NUL <old-ref>] NUL
    - 	symref-verify SP <ref> [NUL <old-ref>] NUL
    ++	symref-delete SP <ref> [NUL <old-target>] NUL
    + 	symref-verify SP <ref> [NUL <old-target>] NUL
      	option SP <opt> NUL
      	start NUL
    -@@ Documentation/git-update-ref.txt: verify::
    +@@ Documentation/git-update-ref.txt: create::
    + 	exist.  The given <new-oid> may not be zero.
    + 
    + delete::
    +-	Delete <ref> after verifying it exists with <old-oid>, if
    +-	given.  If given, <old-oid> may not be zero.
    ++	Delete <ref> after verifying it exists with <old-oid>, if given.
    ++	If given, <old-oid> may not be zero.  If instead, ref:<old-target>
    ++	is provided, verify that the symbolic ref <ref> targets
    ++	<old-target> before deleting it.
    + 
    + verify::
      	Verify <ref> against <old-oid> but do not change it.  If
      	<old-oid> is zero or missing, the ref must not exist.
      
     +symref-delete::
    -+	Delete <ref> after verifying it exists with <old-ref>, if
    -+	given.
    ++	Delete <ref> after verifying it exists with <old-target>, if given.
     +
      symref-verify::
    - 	Verify symbolic <ref> against <old-ref> but do not change it.
    - 	If <old-ref> is missing, the ref must not exist.  Can only be
    + 	Verify symbolic <ref> against <old-target> but do not change it.
    + 	If <old-target> is missing, the ref must not exist.  Can only be
     
      ## builtin/fetch.c ##
     @@ builtin/fetch.c: static int prune_refs(struct display_state *display_state,
    @@ builtin/update-ref.c: static void parse_cmd_delete(struct ref_transaction *trans
      	strbuf_release(&err);
      }
      
    ++
     +static void parse_cmd_symref_delete(struct ref_transaction *transaction,
     +				    const char *next, const char *end)
     +{
     +	struct strbuf err = STRBUF_INIT;
    -+	char *refname, *old_ref;
    ++	char *refname, *old_target;
     +
     +	if (!(update_flags & REF_NO_DEREF))
    -+                die("symref-delete: cannot operate with deref mode");
    ++		die("symref-delete: cannot operate with deref mode");
     +
     +	refname = parse_refname(&next);
     +	if (!refname)
     +		die("symref-delete: missing <ref>");
     +
    -+        old_ref = parse_next_refname(&next);
    -+	if (old_ref && read_ref(old_ref, NULL))
    -+		die("symref-delete %s: invalid <old-ref>", refname);
    ++	old_target = parse_next_refname(&next);
     +
     +	if (*next != line_termination)
     +		die("symref-delete %s: extra input: %s", refname, next);
     +
     +	if (ref_transaction_delete(transaction, refname, NULL,
    -+				   update_flags | REF_SYMREF_UPDATE,
    -+				   old_ref, msg, &err))
    ++				   update_flags, old_target, msg, &err))
     +		die("%s", err.buf);
     +
     +	update_flags = default_flags;
     +	free(refname);
    -+	free(old_ref);
    ++	free(old_target);
     +	strbuf_release(&err);
     +}
    ++
     +
      static void parse_cmd_verify(struct ref_transaction *transaction,
      			     const char *next, const char *end)
    @@ refs.c: int refs_delete_ref(struct ref_store *refs, const char *msg,
      	    ref_transaction_commit(transaction, &err)) {
      		error("%s", err.buf);
      		ref_transaction_free(transaction);
    -@@ refs.c: void ref_transaction_free(struct ref_transaction *transaction)
    - 	for (i = 0; i < transaction->nr; i++) {
    - 		free(transaction->updates[i]->msg);
    - 		free((void *)transaction->updates[i]->old_ref);
    -+		free((void *)transaction->updates[i]->new_ref);
    - 		free(transaction->updates[i]);
    - 	}
    - 	free(transaction->updates);
    -@@ refs.c: struct ref_update *ref_transaction_add_update(
    - 	if (update->flags & REF_SYMREF_UPDATE) {
    - 		if (old_ref)
    - 			update->old_ref = xstrdup(old_ref);
    -+		if (new_ref)
    -+			update->new_ref = xstrdup(new_ref);
    - 	} else {
    - 		if (flags & REF_HAVE_NEW)
    - 			oidcpy(&update->new_oid, new_oid);
     @@ refs.c: int ref_transaction_create(struct ref_transaction *transaction,
      int ref_transaction_delete(struct ref_transaction *transaction,
      			   const char *refname,
      			   const struct object_id *old_oid,
     -			   unsigned int flags, const char *msg,
     +			   unsigned int flags,
    -+			   const char *old_ref,
    ++			   const char *old_target,
     +			   const char *msg,
      			   struct strbuf *err)
      {
    --	if (old_oid && is_null_oid(old_oid))
    -+	if (!(flags & REF_SYMREF_UPDATE) && old_oid &&
    -+	    is_null_oid(old_oid))
    + 	if (old_oid && is_null_oid(old_oid))
      		BUG("delete called with old_oid set to zeros");
    ++	if (old_target && !(flags & REF_NO_DEREF))
    ++		BUG("delete cannot operate on symrefs with deref mode");
      	return ref_transaction_update(transaction, refname,
      				      null_oid(), old_oid,
     -				      NULL, NULL, flags,
    -+				      NULL, old_ref, flags,
    ++				      NULL, old_target, flags,
      				      msg, err);
      }
      
    @@ refs.c: int refs_delete_refs(struct ref_store *refs, const char *logmsg,
      	for_each_string_list_item(item, refnames) {
      		ret = ref_transaction_delete(transaction, item->string,
     -					     NULL, flags, msg, &err);
    -+					     NULL, flags, 0, msg, &err);
    ++					     NULL, flags, NULL, msg, &err);
      		if (ret) {
      			warning(_("could not delete reference %s: %s"),
      				item->string, err.buf);
    @@ refs.h: int ref_transaction_create(struct ref_transaction *transaction,
      			   const struct object_id *old_oid,
     -			   unsigned int flags, const char *msg,
     +			   unsigned int flags,
    -+			   const char *old_ref,
    ++			   const char *old_target,
     +			   const char *msg,
      			   struct strbuf *err);
      
    @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *ref
      	files_assert_main_repository(refs, "lock_ref_for_update");
      
     -	if ((update->flags & REF_HAVE_NEW) && is_null_oid(&update->new_oid))
    -+	if ((update->flags & REF_HAVE_NEW) && null_new_value(update))
    ++	if ((update->flags & REF_HAVE_NEW) && ref_update_is_null_new_value(update))
      		update->flags |= REF_DELETING;
      
      	if (head_ref) {
    @@ refs/reftable-backend.c: static int write_transaction_table(struct reftable_writ
      			continue;
      
     -		if (u->flags & REF_HAVE_NEW && is_null_oid(&u->new_oid)) {
    -+		if (u->flags & REF_HAVE_NEW && null_new_value(u)) {
    ++		if (u->flags & REF_HAVE_NEW && ref_update_is_null_new_value(u)) {
      			struct reftable_ref_record ref = {
      				.refname = (char *)u->refname,
      				.update_index = ts,
     
      ## t/t1400-update-ref.sh ##
    -@@ t/t1400-update-ref.sh: test_expect_success "stdin ${type} symref-verify fails for mistaken null value"
    - 	test_cmp expect actual
    - '
    +@@ t/t1400-update-ref.sh: do
    + 		test_cmp before after
    + 	'
      
    -+test_expect_success "stdin ${type} symref-delete fails without --no-deref" '
    -+	git symbolic-ref refs/heads/symref $a &&
    -+	create_stdin_buf ${type} "symref-delete refs/heads/symref" "$a" &&
    -+	test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
    -+	grep "fatal: symref-delete: cannot operate with deref mode" err
    -+'
    +-	test_expect_success "stdin ${type} symref-verify no value is treated as zero value" '
    ++	test_expect_success "stdin ${type} symref-verify fails with no value" '
    + 		git symbolic-ref refs/heads/symref >expect &&
    + 		create_stdin_buf ${type} "symref-verify refs/heads/symref" "" &&
    + 		test_must_fail git update-ref --stdin ${type} --no-deref <stdin
    +@@ t/t1400-update-ref.sh: do
    + 		test_cmp expect actual
    + 	'
    + 
    ++	test_expect_success "stdin ${type} symref-delete fails without --no-deref" '
    ++		git symbolic-ref refs/heads/symref $a &&
    ++		create_stdin_buf ${type} "symref-delete refs/heads/symref" "$a" &&
    ++		test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
    ++		grep "fatal: symref-delete: cannot operate with deref mode" err
    ++	'
    ++
    ++	test_expect_success "stdin ${type} symref-delete fails with no ref" '
    ++		create_stdin_buf ${type} "symref-delete " &&
    ++		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
    ++		grep "fatal: symref-delete: missing <ref>" err
    ++	'
    ++
    ++	test_expect_success "stdin ${type} symref-delete fails with too many arguments" '
    ++		create_stdin_buf ${type} "symref-delete refs/heads/symref" "$a" "$a" &&
    ++		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
    ++		if test "$type" = "-z"
    ++		then
    ++			grep "fatal: unknown command: $a" err
    ++		else
    ++			grep "fatal: symref-delete refs/heads/symref: extra input:  $a" err
    ++		fi
    ++	'
     +
    -+test_expect_success "stdin ${type} fails symref-delete with no ref" '
    -+	create_stdin_buf ${type} "symref-delete " &&
    -+	test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
    -+	grep "fatal: symref-delete: missing <ref>" err
    -+'
    ++	test_expect_success "stdin ${type} symref-delete fails with wrong old value" '
    ++		create_stdin_buf ${type} "symref-delete refs/heads/symref" "$m" &&
    ++		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
    ++		if test_have_prereq REFTABLE
    ++		then
    ++			grep "fatal: verifying symref target: ${SQ}refs/heads/symref${SQ}: is at $a but expected refs/heads/main" err
    ++		else
    ++			grep "fatal: cannot lock ref ${SQ}refs/heads/symref${SQ}" err
    ++		fi &&
    ++		git symbolic-ref refs/heads/symref >expect &&
    ++		echo $a >actual &&
    ++		test_cmp expect actual
    ++	'
     +
    -+test_expect_success "stdin ${type} fails symref-delete with too many arguments" '
    -+	create_stdin_buf ${type} "symref-delete refs/heads/symref" "$a" "$a" &&
    -+	test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
    -+	if test "$type" = "-z"
    -+	then
    -+		grep "fatal: unknown command: $a" err
    -+	else
    -+		grep "fatal: symref-delete refs/heads/symref: extra input:  $a" err
    -+	fi
    -+'
    ++	test_expect_success "stdin ${type} symref-delete works with right old value" '
    ++		create_stdin_buf ${type} "symref-delete refs/heads/symref" "$a" &&
    ++		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		test_must_fail git rev-parse --verify -q refs/heads/symref
    ++	'
     +
    -+test_expect_success "stdin ${type} symref-delete ref fails with wrong old value" '
    -+	create_stdin_buf ${type} "symref-delete refs/heads/symref" "$m" &&
    -+	test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
    -+	grep "fatal: cannot lock ref '"'"'refs/heads/symref'"'"'" err &&
    -+	git symbolic-ref refs/heads/symref >expect &&
    -+	echo $a >actual &&
    -+	test_cmp expect actual
    -+'
    ++	test_expect_success "stdin ${type} symref-delete works with empty old value" '
    ++		git symbolic-ref refs/heads/symref $a &&
    ++		create_stdin_buf ${type} "symref-delete refs/heads/symref" "" &&
    ++		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		test_must_fail git rev-parse --verify -q $b
    ++	'
     +
    -+test_expect_success "stdin ${type} symref-delete ref works with right old value" '
    -+	create_stdin_buf ${type} "symref-delete refs/heads/symref" "$a" &&
    -+	git update-ref --stdin ${type} --no-deref <stdin &&
    -+	test_must_fail git rev-parse --verify -q $b
    -+'
    ++	test_expect_success "stdin ${type} symref-delete succeeds for dangling reference" '
    ++		test_must_fail git symbolic-ref refs/heads/nonexistent &&
    ++		git symbolic-ref refs/heads/symref2 refs/heads/nonexistent &&
    ++		create_stdin_buf ${type} "symref-delete refs/heads/symref2" "refs/heads/nonexistent" &&
    ++		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		test_must_fail git symbolic-ref -d refs/heads/symref2
    ++	'
     +
      done
      
5:  8fa0151f94 ! 5:  37f8be2f3f update-ref: add support for symref-create
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    update-ref: add support for symref-create
    +    update-ref: add support for 'symref-create' command
     
    -    Add 'symref-create' to allow creation of symbolic refs in a transaction
    -    via the 'git-update-ref' command. The 'symref-create' command takes in a
    -    <new-ref>, which the created <ref> will point to.
    +    Add 'symref-create' command to the '--stdin' mode 'git-update-ref' to
    +    allow creation of symbolic refs in a transaction. The 'symref-create'
    +    command takes in a <new-target>, which the created <ref> will point to.
     
    -    We also support the 'core.prefersymlinkrefs', wherein if the flag is set
    -    and the filesystem supports symlinks, we create the symbolic ref as a
    -    symlink.
    +    Also, support the 'core.prefersymlinkrefs' config, wherein if the config
    +    is set and the filesystem supports symlinks, we create the symbolic ref
    +    as a symlink. We fallback to creating a regular symref if creating the
    +    symlink is unsuccessful.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ Documentation/git-update-ref.txt: performs all modifications together.  Specify
      	create SP <ref> SP <new-oid> LF
      	delete SP <ref> [SP <old-oid>] LF
      	verify SP <ref> [SP <old-oid>] LF
    -+	symref-create SP <ref> SP <new-ref> LF
    - 	symref-delete SP <ref> [SP <old-ref>] LF
    - 	symref-verify SP <ref> [SP <old-ref>] LF
    ++	symref-create SP <ref> SP <new-target> LF
    + 	symref-delete SP <ref> [SP <old-target>] LF
    + 	symref-verify SP <ref> [SP <old-target>] LF
      	option SP <opt> LF
     @@ Documentation/git-update-ref.txt: quoting:
      	create SP <ref> NUL <new-oid> NUL
      	delete SP <ref> NUL [<old-oid>] NUL
      	verify SP <ref> NUL [<old-oid>] NUL
    -+	symref-create SP <ref> NUL <new-ref> NUL
    - 	symref-delete SP <ref> [NUL <old-ref>] NUL
    - 	symref-verify SP <ref> [NUL <old-ref>] NUL
    ++	symref-create SP <ref> NUL <new-target> NUL
    + 	symref-delete SP <ref> [NUL <old-target>] NUL
    + 	symref-verify SP <ref> [NUL <old-target>] NUL
      	option SP <opt> NUL
    +@@ Documentation/git-update-ref.txt: update::
    + 
    + create::
    + 	Create <ref> with <new-oid> after verifying it does not
    +-	exist.  The given <new-oid> may not be zero.
    ++	exist.  The given <new-oid> may not be zero.  If instead
    ++	ref:<new-target> is provided, a symbolic ref is created
    ++	which targets <new-target>.
    + 
    + delete::
    + 	Delete <ref> after verifying it exists with <old-oid>, if given.
     @@ Documentation/git-update-ref.txt: verify::
      	Verify <ref> against <old-oid> but do not change it.  If
      	<old-oid> is zero or missing, the ref must not exist.
      
     +symref-create::
    -+	Create symbolic ref <ref> with <new-ref> after verifying
    ++	Create symbolic ref <ref> with <new-target> after verifying
     +	it does not exist.  Can only be used in `no-deref` mode.
     +
      symref-delete::
    - 	Delete <ref> after verifying it exists with <old-ref>, if
    - 	given.
    + 	Delete <ref> after verifying it exists with <old-target>, if given.
    + 
     
      ## builtin/clone.c ##
     @@ builtin/clone.c: static void write_remote_refs(const struct ref *local_refs)
    @@ builtin/update-ref.c: static void parse_cmd_create(struct ref_transaction *trans
      	strbuf_release(&err);
      }
      
    ++
     +static void parse_cmd_symref_create(struct ref_transaction *transaction,
     +				    const char *next, const char *end)
     +{
     +	struct strbuf err = STRBUF_INIT;
    -+	char *refname, *new_ref;
    ++	char *refname, *new_target;
     +
     +	if (!(update_flags & REF_NO_DEREF))
    -+                die("symref-create: cannot operate with deref mode");
    ++		die("symref-create: cannot operate with deref mode");
     +
     +	refname = parse_refname(&next);
     +	if (!refname)
     +		die("symref-create: missing <ref>");
     +
    -+	new_ref = parse_next_refname(&next);
    -+	if (!new_ref)
    -+		die("symref-create %s: missing <new-ref>", refname);
    -+	if (read_ref(new_ref, NULL))
    -+		die("symref-create %s: invalid <new-ref>", refname);
    ++	new_target = parse_next_refname(&next);
    ++	if (!new_target)
    ++		die("symref-create %s: missing <new-target>", refname);
     +
     +	if (*next != line_termination)
     +		die("symref-create %s: extra input: %s", refname, next);
     +
    -+	if (ref_transaction_create(transaction, refname, NULL, new_ref,
    -+				   update_flags | create_reflog_flag |
    -+				   REF_SYMREF_UPDATE, msg, &err))
    ++	if (ref_transaction_create(transaction, refname, NULL, new_target,
    ++				   update_flags | create_reflog_flag,
    ++				   msg, &err))
     +		die("%s", err.buf);
     +
     +	update_flags = default_flags;
     +	free(refname);
    -+	free(new_ref);
    ++	free(new_target);
     +	strbuf_release(&err);
     +}
     +
    @@ refs.c: int ref_transaction_update(struct ref_transaction *transaction,
      int ref_transaction_create(struct ref_transaction *transaction,
      			   const char *refname,
      			   const struct object_id *new_oid,
    -+			   const char *new_ref,
    ++			   const char *new_target,
      			   unsigned int flags, const char *msg,
      			   struct strbuf *err)
      {
     -	if (!new_oid || is_null_oid(new_oid)) {
    -+	if ((flags & REF_SYMREF_UPDATE) && !new_ref) {
    -+		strbuf_addf(err, "'%s' has a no new ref", refname);
    -+		return 1;
    -+	}
    -+	if (!(flags & REF_SYMREF_UPDATE) && (!new_oid || is_null_oid(new_oid))) {
    - 		strbuf_addf(err, "'%s' has a null OID", refname);
    +-		strbuf_addf(err, "'%s' has a null OID", refname);
    ++	if ((!new_oid || is_null_oid(new_oid)) && !new_target) {
    ++		strbuf_addf(err, "'%s' has a null OID or no new target", refname);
      		return 1;
      	}
    ++	if (new_target && !(flags & REF_NO_DEREF))
    ++		BUG("create cannot operate on symrefs with deref mode");
      	return ref_transaction_update(transaction, refname, new_oid,
     -				      null_oid(), NULL, NULL, flags,
    -+				      null_oid(), new_ref, NULL, flags,
    ++				      null_oid(), new_target, NULL, flags,
      				      msg, err);
      }
      
    @@ refs.h: int ref_transaction_update(struct ref_transaction *transaction,
      int ref_transaction_create(struct ref_transaction *transaction,
      			   const char *refname,
      			   const struct object_id *new_oid,
    -+			   const char *new_ref,
    ++			   const char *new_target,
      			   unsigned int flags, const char *msg,
      			   struct strbuf *err);
      
    @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *ref
      		}
      	}
      
    -+	if (update->flags & REF_SYMREF_UPDATE && update->new_ref) {
    -+		if (create_symref_lock(refs, lock, update->refname, update->new_ref)) {
    ++	if (update->new_target) {
    ++		if (create_symref_lock(refs, lock, update->refname, update->new_target)) {
     +			ret = TRANSACTION_GENERIC_ERROR;
     +			goto out;
     +		}
    @@ refs/files-backend.c: static int files_transaction_finish(struct ref_store *ref_
      
      		if (update->flags & REF_NEEDS_COMMIT ||
      		    update->flags & REF_LOG_ONLY) {
    -+			if (update->flags & REF_SYMREF_UPDATE && update->new_ref) {
    -+				/* for dangling symrefs we gracefully set the oid to zero */
    -+				if (!refs_resolve_ref_unsafe(&refs->base, update->new_ref,
    ++			if (update->new_target) {
    ++				/*
    ++				 * We want to get the resolved OID for the target, to ensure
    ++				 * that the correct value is added to the reflog.
    ++				 */
    ++				if (!refs_resolve_ref_unsafe(&refs->base, update->new_target,
     +							     RESOLVE_REF_READING, &update->new_oid, NULL)) {
    ++					/* for dangling symrefs we gracefully set the oid to zero */
     +					update->new_oid = *null_oid();
     +				}
     +			}
    @@ refs/files-backend.c: static int files_transaction_finish(struct ref_store *ref_
     +		 * We try creating a symlink, if that succeeds we continue to the
     +		 * next updated. If not, we try and create a regular symref.
     +		 */
    -+		if (update->flags & REF_SYMREF_UPDATE && prefer_symlink_refs)
    -+			if (!create_ref_symlink(lock, update->new_ref))
    ++		if (update->new_target && prefer_symlink_refs)
    ++			if (!create_ref_symlink(lock, update->new_target))
     +				continue;
     +
      		if (update->flags & REF_NEEDS_COMMIT) {
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
      			 * when the reference in question doesn't exist.
      			 */
     -			 if (u->flags & REF_HAVE_NEW && !is_null_oid(&u->new_oid)) {
    -+			 if (u->flags & REF_HAVE_NEW && !null_new_value(u)) {
    ++			 if (u->flags & REF_HAVE_NEW && !ref_update_is_null_new_value(u)) {
      				 ret = queue_transaction_update(refs, tx_data, u,
      								&current_oid, err);
      				 if (ret)
    @@ refs/reftable-backend.c: static int write_transaction_table(struct reftable_writ
      		 *   the given ref.
      		 */
     -		if (u->flags & REF_HAVE_NEW && !(u->type & REF_ISSYMREF) && is_null_oid(&u->new_oid)) {
    -+		if (u->flags & REF_HAVE_NEW && !(u->type & REF_ISSYMREF) && null_new_value(u)) {
    ++		if (u->flags & REF_HAVE_NEW && !(u->type & REF_ISSYMREF) && ref_update_is_null_new_value(u)) {
      			struct reftable_log_record log = {0};
      			struct reftable_iterator it = {0};
      
    +@@ refs/reftable-backend.c: static int write_transaction_table(struct reftable_writer *writer, void *cb_data
    + 			    should_write_log(&arg->refs->base, u->refname))) {
    + 			struct reftable_log_record *log;
    + 
    ++			if (u->new_target)
    ++				if (!refs_resolve_ref_unsafe(&arg->refs->base, u->new_target,
    ++							     RESOLVE_REF_READING, &u->new_oid, NULL))
    ++					/* for dangling symrefs we gracefully set the oid to zero */
    ++					u->new_oid = *null_oid();
    ++
    + 			ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
    + 			log = &logs[logs_nr++];
    + 			memset(log, 0, sizeof(*log));
     @@ refs/reftable-backend.c: static int write_transaction_table(struct reftable_writer *writer, void *cb_data
      		if (u->flags & REF_LOG_ONLY)
      			continue;
      
    --		if (u->flags & REF_HAVE_NEW && null_new_value(u)) {
    -+		if (u->flags & REF_SYMREF_UPDATE &&
    -+		    u->flags & REF_HAVE_NEW &&
    -+		    !null_new_value(u)) {
    +-		if (u->flags & REF_HAVE_NEW && ref_update_is_null_new_value(u)) {
    ++		if (u->flags & REF_HAVE_NEW && u->new_target) {
     +			struct reftable_ref_record ref = {
     +				.refname = (char *)u->refname,
     +				.value_type = REFTABLE_REF_SYMREF,
    -+				.value.symref = (char *)u->new_ref,
    ++				.value.symref = (char *)u->new_target,
     +				.update_index = ts,
     +			};
     +
     +			ret = reftable_writer_add_ref(writer, &ref);
     +			if (ret < 0)
     +				goto done;
    -+		} else if (u->flags & REF_HAVE_NEW && null_new_value(u)) {
    ++		} else if (u->flags & REF_HAVE_NEW && ref_update_is_null_new_value(u)) {
      			struct reftable_ref_record ref = {
      				.refname = (char *)u->refname,
      				.update_index = ts,
    @@ t/t0600-reffiles-backend.sh: test_expect_success POSIXPERM 'git reflog expire ho
      test_done
     
      ## t/t1400-update-ref.sh ##
    -@@ t/t1400-update-ref.sh: test_expect_success "stdin ${type} symref-delete ref works with right old value"
    - 	test_must_fail git rev-parse --verify -q $b
    - '
    +@@ t/t1400-update-ref.sh: do
    + 		test_must_fail git symbolic-ref -d refs/heads/symref2
    + 	'
      
    -+test_expect_success "stdin ${type} symref-create fails without --no-deref" '
    -+	create_stdin_buf ${type} "symref-create refs/heads/symref" "$a" &&
    -+	test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
    -+	grep "fatal: symref-create: cannot operate with deref mode" err
    -+'
    ++	test_expect_success "stdin ${type} symref-create fails without --no-deref" '
    ++		create_stdin_buf ${type} "symref-create refs/heads/symref" "$a" &&
    ++		test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
    ++		grep "fatal: symref-create: cannot operate with deref mode" err
    ++	'
     +
    -+test_expect_success "stdin ${type} fails symref-create with no ref" '
    -+	create_stdin_buf ${type} "symref-create " >stdin &&
    -+	test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
    -+	grep "fatal: symref-create: missing <ref>" err
    -+'
    ++	test_expect_success "stdin ${type} symref-create fails with too many arguments" '
    ++		create_stdin_buf ${type} "symref-create refs/heads/symref" "$a" "$a" >stdin &&
    ++		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
    ++		if test "$type" = "-z"
    ++		then
    ++			grep "fatal: unknown command: $a" err
    ++		else
    ++			grep "fatal: symref-create refs/heads/symref: extra input:  $a" err
    ++		fi
    ++	'
     +
    -+test_expect_success "stdin ${type} fails symref-create with no new value" '
    -+	create_stdin_buf ${type} "symref-create refs/heads/symref" >stdin &&
    -+	test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
    -+	grep "fatal: symref-create refs/heads/symref: missing <new-ref>" err
    -+'
    ++	test_expect_success "stdin ${type} symref-create fails with no target" '
    ++		create_stdin_buf ${type} "symref-create refs/heads/symref" >stdin &&
    ++		test_must_fail git update-ref --stdin ${type} --no-deref <stdin
    ++	'
     +
    -+test_expect_success "stdin ${type} fails symref-create with too many arguments" '
    -+	create_stdin_buf ${type} "symref-create refs/heads/symref" "$a" "$a" >stdin &&
    -+	test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
    -+	if test "$type" = "-z"
    -+	then
    -+		grep "fatal: unknown command: $a" err
    -+	else
    -+		grep "fatal: symref-create refs/heads/symref: extra input:  $a" err
    -+	fi
    -+'
    ++	test_expect_success "stdin ${type} symref-create fails with empty target" '
    ++		create_stdin_buf ${type} "symref-create refs/heads/symref" "" >stdin &&
    ++		test_must_fail git update-ref --stdin ${type} --no-deref <stdin
    ++	'
     +
    -+test_expect_success "stdin ${type} symref-create ref works" '
    -+	test_when_finished "git symbolic-ref -d refs/heads/symref" &&
    -+	create_stdin_buf ${type} "symref-create refs/heads/symref" "$a" >stdin &&
    -+	git update-ref --stdin ${type} --no-deref <stdin &&
    -+	git symbolic-ref refs/heads/symref >expect &&
    -+	echo $a >actual &&
    -+	test_cmp expect actual
    -+'
    ++	test_expect_success "stdin ${type} symref-create works" '
    ++		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
    ++		create_stdin_buf ${type} "symref-create refs/heads/symref" "$a" >stdin &&
    ++		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		git symbolic-ref refs/heads/symref >expect &&
    ++		echo $a >actual &&
    ++		test_cmp expect actual
    ++	'
     +
    -+test_expect_success "stdin ${type} symref-create does not create reflogs by default" '
    -+	test_when_finished "git symbolic-ref -d refs/symref" &&
    -+	create_stdin_buf ${type} "symref-create refs/symref" "$a" >stdin &&
    -+	git update-ref --stdin ${type} --no-deref <stdin &&
    -+	git symbolic-ref refs/symref >expect &&
    -+	echo $a >actual &&
    -+	test_cmp expect actual &&
    -+	test_must_fail git reflog exists refs/symref
    -+'
    ++	test_expect_success "stdin ${type} create dangling symref ref works" '
    ++		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
    ++		create_stdin_buf ${type} "symref-create refs/heads/symref" "refs/heads/unkown" >stdin &&
    ++		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		git symbolic-ref refs/heads/symref >expect &&
    ++		echo refs/heads/unkown >actual &&
    ++		test_cmp expect actual
    ++	'
     +
    -+test_expect_success "stdin ${type} symref-create reflogs with --create-reflog" '
    -+	test_when_finished "git symbolic-ref -d refs/heads/symref" &&
    -+	create_stdin_buf ${type} "symref-create refs/heads/symref" "$a" >stdin &&
    -+	git update-ref --create-reflog --stdin ${type} --no-deref <stdin &&
    -+	git symbolic-ref refs/heads/symref >expect &&
    -+	echo $a >actual &&
    -+	test_cmp expect actual &&
    -+	git reflog exists refs/heads/symref
    -+'
    ++	test_expect_success "stdin ${type} symref-create does not create reflogs by default" '
    ++		test_when_finished "git symbolic-ref -d refs/symref" &&
    ++		create_stdin_buf ${type} "symref-create refs/symref" "$a" >stdin &&
    ++		git update-ref --stdin ${type} --no-deref <stdin &&
    ++		git symbolic-ref refs/symref >expect &&
    ++		echo $a >actual &&
    ++		test_cmp expect actual &&
    ++		test_must_fail git reflog exists refs/symref
    ++	'
    ++
    ++	test_expect_success "stdin ${type} symref-create reflogs with --create-reflog" '
    ++		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
    ++		create_stdin_buf ${type} "symref-create refs/heads/symref" "$a" >stdin &&
    ++		git update-ref --create-reflog --stdin ${type} --no-deref <stdin &&
    ++		git symbolic-ref refs/heads/symref >expect &&
    ++		echo $a >actual &&
    ++		test_cmp expect actual &&
    ++		git reflog exists refs/heads/symref
    ++	'
     +
      done
      
6:  714492ede3 < -:  ---------- update-ref: add support for symref-update
-:  ---------- > 6:  b385f4d0d7 update-ref: add support for 'symref-update' command
7:  c483104562 ! 7:  ef335e47d1 refs: support symrefs in 'reference-transaction' hook
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    refs: support symrefs in 'reference-transaction' hook
    +    ref: support symrefs in 'reference-transaction' hook
     
         The 'reference-transaction' hook runs whenever a reference update is
    -    made to the system. In the previous commits, we added support for
    -    various symref commands in `git-update-ref`. While it allowed us to now
    +    made to the system. In the previous commits, we added symref support for
    +    various commands in `git-update-ref`. While it allowed us to now
         manipulate symbolic refs via `git-update-ref`, it didn't activate the
         'reference-transaction' hook.
     
    @@ Commit message
         new format described for this and we stick to the existing format of:
             <old-value> SP <new-value> SP <ref-name> LF
         but now, <old-value> and <new-value> could also denote references
    -    instead of objects.
    +    instead of objects, where the format is similar to that in
    +    'git-update-ref', i.e. 'ref:<ref-target>'.
     
         While this seems to be backward incompatible, it is okay, since the only
         way the `reference-transaction` hook has refs in its output is when
    -    `git-update-ref` is used with `update-symref` command. Also the
    -    documentation for reference-transaction hook always stated that support
    -    for symbolic references may be added in the future.
    +    `git-update-ref` is used to manipulate symrefs. Also the documentation
    +    for reference-transaction hook always stated that support for symbolic
    +    references may be added in the future.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ Documentation/githooks.txt: given reference transaction is in:
      `<ref-name>` via `git rev-parse`.
      
     +For symbolic reference updates the `<old_value>` and `<new-value>`
    -+fields could denote references instead of objects.
    ++fields could denote references instead of objects, denoted via the
    ++`ref:<ref-target>` format.
     +
      The exit status of the hook is ignored for any state except for the
      "prepared" state. In the "prepared" state, a non-zero exit status will
    @@ refs.c: static int run_transaction_hook(struct ref_transaction *transaction,
      
      	for (i = 0; i < transaction->nr; i++) {
      		struct ref_update *update = transaction->updates[i];
    -+		const char *new_value, *old_value;
    ++		strbuf_reset(&buf);
      
    --		if (update->flags & REF_SYMREF_UPDATE)
    +-		/*
    +-		 * Skip reference transaction for symbolic refs.
    +-		 */
    +-		if (update->new_target || update->old_target)
     -			continue;
    -+		new_value = oid_to_hex(&update->new_oid);
    -+		old_value = oid_to_hex(&update->old_oid);
    -+
    -+		if (update->flags & REF_SYMREF_UPDATE) {
    -+			if (update->flags & REF_HAVE_NEW && !null_new_value(update))
    -+				new_value = update->new_ref;
    -+			if (update->flags & REF_HAVE_OLD && update->old_ref)
    -+				old_value = update->old_ref;
    -+		}
    ++		if (update->flags & REF_HAVE_OLD && update->old_target)
    ++			strbuf_addf(&buf, "ref:%s ", update->old_target);
    ++		else
    ++			strbuf_addf(&buf, "%s ", oid_to_hex(&update->old_oid));
      
    - 		strbuf_reset(&buf);
    +-		strbuf_reset(&buf);
     -		strbuf_addf(&buf, "%s %s %s\n",
     -			    oid_to_hex(&update->old_oid),
     -			    oid_to_hex(&update->new_oid),
     -			    update->refname);
    -+		strbuf_addf(&buf, "%s %s %s\n", old_value, new_value, update->refname);
    ++		if (update->flags & REF_HAVE_NEW && update->new_target)
    ++			strbuf_addf(&buf, "ref:%s ", update->new_target);
    ++		else
    ++			strbuf_addf(&buf, "%s ", oid_to_hex(&update->new_oid));
    ++
    ++		strbuf_addf(&buf, "%s\n", update->refname);
      
      		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
      			if (errno != EPIPE) {
     
      ## t/t1416-ref-transaction-hooks.sh ##
    -@@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'hook gets all queued updates in aborted state' '
    - 	test_cmp expect actual
    +@@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'interleaving hook calls succeed' '
    + 	test_cmp expect target-repo.git/actual
      '
      
    -+# This test doesn't add a check for 'symref-delete' since there is a
    ++# This test doesn't add a check for symref 'delete' since there is a
     +# variation between the ref backends WRT 'delete'. In the files backend,
     +# 'delete' also triggers an additional transaction update on the
     +# packed-refs backend, which constitutes additional reflog entries.
    - test_expect_success 'interleaving hook calls succeed' '
    - 	test_when_finished "rm -r target-repo.git" &&
    - 
    -@@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'interleaving hook calls succeed' '
    - 	test_cmp expect target-repo.git/actual
    - '
    - 
     +test_expect_success 'hook gets all queued symref updates' '
     +	test_when_finished "rm actual" &&
     +
    @@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'interleaving hook calls s
     +
     +	cat >expect <<-EOF &&
     +		prepared
    -+		refs/heads/main $ZERO_OID refs/heads/symref
    -+		$ZERO_OID refs/heads/main refs/heads/symrefc
    -+		refs/heads/main refs/heads/branch refs/heads/symrefu
    ++		ref:refs/heads/main $ZERO_OID refs/heads/symref
    ++		$ZERO_OID ref:refs/heads/main refs/heads/symrefc
    ++		ref:refs/heads/main ref:refs/heads/branch refs/heads/symrefu
     +		committed
    -+		refs/heads/main $ZERO_OID refs/heads/symref
    -+		$ZERO_OID refs/heads/main refs/heads/symrefc
    -+		refs/heads/main refs/heads/branch refs/heads/symrefu
    ++		ref:refs/heads/main $ZERO_OID refs/heads/symref
    ++		$ZERO_OID ref:refs/heads/main refs/heads/symrefc
    ++		ref:refs/heads/main ref:refs/heads/branch refs/heads/symrefu
     +	EOF
     +
     +	git update-ref --no-deref --stdin <<-EOF &&
     +		start
     +		symref-verify refs/heads/symref refs/heads/main
     +		symref-create refs/heads/symrefc refs/heads/main
    -+		symref-update refs/heads/symrefu refs/heads/branch refs/heads/main
    ++		symref-update refs/heads/symrefu refs/heads/branch ref refs/heads/main
     +		prepare
     +		commit
     +	EOF


Karthik Nayak (7):
  refs: accept symref values in `ref_transaction[_add]_update`
  files-backend: extract out `create_symref_lock`
  update-ref: add support for 'symref-verify' command
  update-ref: add support for 'symref-delete' command
  update-ref: add support for 'symref-create' command
  update-ref: add support for 'symref-update' command
  ref: support symrefs in 'reference-transaction' hook

 Documentation/git-update-ref.txt |  34 ++-
 Documentation/githooks.txt       |  14 +-
 branch.c                         |   2 +-
 builtin/clone.c                  |   2 +-
 builtin/fast-import.c            |   5 +-
 builtin/fetch.c                  |   4 +-
 builtin/receive-pack.c           |   4 +-
 builtin/replace.c                |   2 +-
 builtin/tag.c                    |   1 +
 builtin/update-ref.c             | 240 ++++++++++++++++--
 refs.c                           |  78 ++++--
 refs.h                           |  23 +-
 refs/files-backend.c             | 141 +++++++++--
 refs/refs-internal.h             |  20 ++
 refs/reftable-backend.c          |  49 +++-
 sequencer.c                      |   9 +-
 t/t0600-reffiles-backend.sh      |  32 +++
 t/t1400-update-ref.sh            | 413 ++++++++++++++++++++++++++++++-
 t/t1416-ref-transaction-hooks.sh |  41 +++
 walker.c                         |   2 +-
 20 files changed, 1030 insertions(+), 86 deletions(-)

-- 
2.43.GIT

