Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06D7286D7F
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 07:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756796740; cv=none; b=SDAXOos7oHgsMFcezgPKZzniRpnZ5/MttPvPXGiEw5KCp/Rl6C2OYmvyK/s0T4V6rBxxFfrcYs07yrNzDT7q8oSTQym/eK9rJTNMgtXxRKfpBt3YPwCEsF1ZmLJ2nls9Ghn6Kalwz/FPnVQnUDUhDAlcXIc/eds9oWwFjHDsR5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756796740; c=relaxed/simple;
	bh=Hq+fJoMhCtjEndQ4JfxoW8YJzCyc3zcvoh/nembfLk0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=jJVZbvSG9OEDxR2CHAWIYugu/yOov2SJ3xo+rWqYWi2XsHJmI02fzLdxuq2WwdGbGg5RwWRhFTxkcaxqPom3LM/f9t1w75QoT3SR9SthG3lPz9+BI7CoPnihB3OkxaLDnxgGARw2KAIu8VYLu/L0WSYLFYgg1+feSBUfycpIO/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYi5NzIw; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYi5NzIw"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7ace3baso282826366b.3
        for <git@vger.kernel.org>; Tue, 02 Sep 2025 00:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756796736; x=1757401536; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Ugt+OpBjbYBsqhj8knPZVUH9b6kPIrpmkKgZwDaC5Y=;
        b=eYi5NzIwNyp4kPWhYpx6RajtlumNytyZoN0W/GMnOe6Fn46BvTMD2KV+jAr43IBayJ
         pGqNe9fudpVb/dLCJfkV0il3UbRZ7u+4gVRLSRZUWXtfF0hu9bKlgjSMQdwnCK9JF8Xb
         29+j2y9tQfG7AEfiJ00qphiZl2sweKl8yFAFdbSZt7pNKFUWHOYr1biEdE9F9c5L+pxa
         SZX0YWq5h15LgHTLwCKNI5UwMGk75MY396yN7JyN3+zLWK/dKnkL+ZnErum3DtTXj6r8
         qaFxiBPABBXdcnpVqLHl3zu+EZH2yUGaKfZCTBKGHsQOBzkrnc0ygAG6zZw2/+72lRKC
         fDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756796736; x=1757401536;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5Ugt+OpBjbYBsqhj8knPZVUH9b6kPIrpmkKgZwDaC5Y=;
        b=wkUlNYQL5RIA31fEITTRRZi3MxtfrSfWukwUyscyiTkug6vKPNdbjwS79KswAs8WvK
         AvR4oHL5P5ol97MPVCdO9a6+D2YxBWrxyViRniBObDTNsvkSfSIeD2lcUNjLOkqrB4a5
         SkMxSMefS2RHlXXzg/yL908+SWX2bONFb7HdL1ucEJT/9PGeOjmDJCGwGo/EoLtoUj4P
         hPzuFj8eZ2O/ACy2Y8wDhfNZWTNqOzgxzIvxBR54C44+q3SQKpgNcAHQ2zAqgOmp6TB0
         ngQJtimXCC0NjOwdKxiEoM+y0cOs1zTtQyNgRD4egwjdQV8+dRdtd9ndXxcoGP61pNYl
         PBZw==
X-Gm-Message-State: AOJu0YwBO5N2KpPqadzWrPbspPHT2IdNq5T2c8KYImSuNOUGUK8BsbbE
	q8wyEb1oJZwRW5rwtlVw199NSEHvINeJKBKBV8SfPLXmYW/evalmS2IDl8iipg==
X-Gm-Gg: ASbGncsFbo9Nq2BWza6g9zIza/J5KYTFttnuc8fVAr/ffg2a7q+4IIbs8JEB1dH8Cq6
	YwnsrvQaJhfnyhMUXtFM6jJFoey1ScpShRgQM7SNOH3HwCjdPPZ5dLddOeb9h+vfzT1Zr134kaW
	tOVGLrout0ebQnH0NFiLnDcDD+k4rBeytdF+H+dN12JFX+Iz704ufe68KpvCdeSqxibpcybre2W
	9+4B05R0w3voY3YJyfvCTHraE03JVOxTt0do6MHck87dROD1yHHOxgnj8K8a3O5RdBz9mPaGboe
	OmrKn1gttWjFfpDjnXhUJdMtxp+bx4s0/TosxQ1756Sz1hrtfw48vXmoBkfGwJeOTI5QLrJnYL0
	3wzEv6G3ylPo04xrTS7SLJItvTO7m9D/QyXLRs3I=
X-Google-Smtp-Source: AGHT+IFoIHOMdd+F0lFUKeWNIUpak7seUOxouijuDMadRTVYNWysqE5Oy+ISXfryAK/EbqPLnQMBUw==
X-Received: by 2002:a17:906:12cf:b0:b04:11e5:9a8e with SMTP id a640c23a62f3a-b0411e59b44mr735276166b.40.1756796735625;
        Tue, 02 Sep 2025 00:05:35 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:39c9:1f0d:23f0:502f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff9918dbd2sm821575866b.103.2025.09.02.00.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 00:05:34 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/5] refs/reftable: add fsck checks
Date: Tue, 02 Sep 2025 09:05:20 +0200
Message-Id: <20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADCXtmgC/5WNQQ6CMBBFr0K6dgwtIK0r72FYlOkAjdCaFomEc
 HcrnsDl+/P/vI1FCpYiu2YbC7TYaL1LIE4Zw0G7nsCaxEzkosprXoIQEgJ1s27HdHNz8OaFBOh
 dtHEmhyvgQPiIUNTKkFEFVmXJ0r9nmtn34bo3iYfU92E91Av/pj+L5OoPy8IhB9nK7iJr1WlFt
 37Sdjyjn1iz7/sHDFTMCuIAAAA=
X-Change-ID: 20250714-228-reftable-introduce-consistency-checks-379ded93c544
In-Reply-To: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
References: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
 shejialuo@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=16031;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=Hq+fJoMhCtjEndQ4JfxoW8YJzCyc3zcvoh/nembfLk0=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGi2lzhg9FZeGXp0NMGn/Kuqu0z4MmjD2D0nD
 Bt2NB8idbTBiYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJotpc4AAoJED7VnySO
 Rox/9NkL/iSFB5RyN5Agq5oTaAozbUbZ6cL9S1bwEONwm2HUEm9hU8fxtUzUfGS8VBfGj4fVOE5
 rlRB2vCbwqFh0Zj4xvPVLjF/TM3zXzZxj8S1DdGadGX2j8ATbKANHp16EUWE/y5RSCqpkErhiLv
 tYPaBV464j/VSY5wfOi5q0aUCWXobeoGD4DW3K/jH+AG+JPUllmA0bO+rwoF6oYiFGI/6q521C1
 LRC0FDzGB4Y3aptyLyCadqVZhuEESrRD+L45zdGf71TnNufIyfYzK6T695ARvGFLqwfSWZyDN7W
 6ncOhkKoonoJuVGan+OUL9cad2uvIKVmzWSuv9hptUH7R3mL+OtP/PwLuotM+F3gp4R71slFPEb
 I0NOgfifn0Vm/MPor+dXKyRXm2QoCtwy8GisUg8Wgk32F3LFzbdtA/cO66BUlrSeyLeSJiBLu9H
 +CZ3mlhBnD734owOlR5SUcgM0V7FQc+707+L6+DD4NbrHA0DgZH8FqKW+RU+HQyD3LeP29xVll7
 9s=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

This series adds the required infrastructure and also some fsck checks
for the reftable backend.

Since the reftable backend is treated as a library within the Git
codebase, we don't want to spillover our internal fsck implementation
into the library. At the same time, the fsck checks need to access
internal structures of the reftable library which aren't exposed outside
the library.

So we solve this by adding a 'reftable/fsck.[ch]' which implements and
exposes a checker for the reftable library and returns specific errors
as defined by the library. We then add glue code within
'refs/reftable-backend.c' to map these errors to errors which Git's fsck
implementation would understand. This allows us to separate concerns.

This series then adds some checks on the stack ('reftable/tables.list')
level of reftable, namely:
1. The table name is as per the spec
2. The number of tables are consistent
3. The tables.list has a newline at the end of file
4. The table names follow correct index sequences

I also plan to send in follow up series's which will implement further
checks and go into deeper layers (tables, block, references).

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v2:
- Ensured that 'struct reftable_fsck_info' is passed around as a
  pointer, this provides a smaller footprint (pointer size vs struct
  size).
- Run FSCK checks for other worktrees too, even if one of them fails.
- Separate messaging for table name vs table check and add additional
  test.
- Use the relative path in messages used.
- Small style and typo fixes.
- Link to v1: https://lore.kernel.org/r/20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com

---
 Documentation/fsck-msgids.adoc |  15 +++-
 Makefile                       |   1 +
 fsck.h                         | 154 ++++++++++++++++++++-------------------
 meson.build                    |   1 +
 refs/reftable-backend.c        |  66 +++++++++++++++--
 reftable/fsck.c                | 134 ++++++++++++++++++++++++++++++++++
 reftable/reftable-fsck.h       |  44 +++++++++++
 t/meson.build                  |   3 +-
 t/t0614-reftable-fsck.sh       | 161 +++++++++++++++++++++++++++++++++++++++++
 9 files changed, 494 insertions(+), 85 deletions(-)

Karthik Nayak (5):
      fsck: order 'fsck_msg_type' alphabetically
      refs/reftable: add fsck check for checking the table name
      refs/reftable: add fsck check for number of tables
      refs/reftable: add fsck check for trailing newline
      refs/reftable: add fsck check for incorrect update index

Range-diff versus v1:

1:  d1875fbbc7 = 1:  c049cd428a fsck: order 'fsck_msg_type' alphabetically
2:  b63799aad1 ! 2:  1e46786745 refs/reftable: add fsck check for checking the table name
    @@ Commit message
         Also add 'badReftableTableName' as a corresponding error within Git. Add
         a test to check for this behavior.
     
    +    While here, remove a unused header `#include "../lockfile.h"` from
    +    'refs/reftable-backend.c'.
    +
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## Documentation/fsck-msgids.adoc ##
    @@ refs/reftable-backend.c: static int reftable_be_reflog_expire(struct ref_store *
     +		fprintf_ln(stderr, "%s", _(msg));
     +}
     +
    -+static int reftable_fsck_error_handler(struct reftable_fsck_info info,
    ++static int reftable_fsck_error_handler(struct reftable_fsck_info *info,
     +				       void *cb_data)
     +{
    ++	struct fsck_ref_report report = { .path = info->path };
     +	struct fsck_options *o = cb_data;
    -+	struct fsck_ref_report report = { .path = info.path };
     +	enum fsck_msg_id msg_id;
     +
    -+	switch (info.error) {
    ++	switch (info->error) {
     +	case REFTABLE_FSCK_ERROR_TABLE_NAME:
     +		msg_id = FSCK_MSG_BAD_REFTABLE_TABLE_NAME;
     +		break;
     +	default:
    -+		BUG("unknown fsck error: %d", info.error);
    ++		BUG("unknown fsck error: %d", info->error);
     +	}
     +
    -+	return fsck_report_ref(o, &report, msg_id, "%s", info.msg);
    ++	return fsck_report_ref(o, &report, msg_id, "%s", info->msg);
     +}
     +
     +static int reftable_be_fsck(struct ref_store *ref_store, struct fsck_options *o,
    @@ refs/reftable-backend.c: static int reftable_be_reflog_expire(struct ref_store *
     +	if (o->verbose)
     +		fprintf_ln(stderr, _("Checking references consistency"));
     +
    -+	ret = reftable_fsck_check(refs->main_backend.stack, reftable_fsck_error_handler,
    ++	ret |= reftable_fsck_check(refs->main_backend.stack, reftable_fsck_error_handler,
     +				  reftable_fsck_verbose_handler, o);
    -+	if (!ret)
    -+		return ret;
     +
     +	strmap_for_each_entry(&refs->worktree_backends, &iter, entry) {
     +		struct reftable_backend *b = (struct reftable_backend *)entry->value;
    -+		ret = reftable_fsck_check(b->stack, reftable_fsck_error_handler,
    ++		ret |= reftable_fsck_check(b->stack, reftable_fsck_error_handler,
     +					  reftable_fsck_verbose_handler, o);
    -+		if (!ret)
    -+			return ret;
     +	}
     +
     +	return ret;
    @@ reftable/fsck.c (new)
     +			reftable_fsck_verbose_fn verbose_fn,
     +			void *cb_data)
     +{
    ++
     +	char **names = NULL;
     +	uint64_t min, max;
     +	int err = 0;
    @@ reftable/fsck.c (new)
     +		struct reftable_fsck_info info = {
     +			.error = REFTABLE_FSCK_ERROR_TABLE_NAME,
     +			.path = names[i],
    -+			.msg = "invalid reftable name"
     +		};
     +		uint32_t rnd;
     +		/*
    @@ reftable/fsck.c (new)
     +
     +		if (sscanf(names[i], "0x%012" PRIx64 "-0x%012" PRIx64 "-%08x%5s",
     +			   &min, &max, &rnd, tail) != 4) {
    -+			err = report_fn(info, cb_data);
    ++			info.msg = "invalid reftable table name";
    ++			err = report_fn(&info, cb_data);
    ++			continue;
     +		}
     +
     +		if (strcmp(tail, ".ref")) {
    -+			err = report_fn(info, cb_data);
    ++			info.msg = "invalid reftable table extension";
    ++			err = report_fn(&info, cb_data);
     +		}
     +	}
     +
    @@ reftable/reftable-fsck.h (new)
     +	REFTABLE_FSCK_ERROR_TABLE_NAME = -1,
     +};
     +
    -+/* Represents an individual error encounctered during the FSCK checks. */
    ++/* Represents an individual error encountered during the FSCK checks. */
     +struct reftable_fsck_info {
     +	enum reftable_fsck_error error;
     +	const char *msg;
     +	const char *path;
     +};
     +
    -+typedef int reftable_fsck_report_fn(struct reftable_fsck_info info,
    ++typedef int reftable_fsck_report_fn(struct reftable_fsck_info *info,
     +				    void *cb_data);
     +typedef void reftable_fsck_verbose_fn(const char *msg, void *cb_data);
     +
    @@ reftable/reftable-fsck.h (new)
     + *
     + * If an issue is encountered, the issue is reported to the callee via the
     + * provided 'report_fn'. If the issue is non-recoverable the flow will not
    -+ * conitnue. If it is recoverable, the flow will continue and further issues
    ++ * continue. If it is recoverable, the flow will continue and further issues
     + * will be reported as identified.
     + *
     + * The 'verbose_fn' will be invoked to provide verbose information about
    @@ t/t0614-reftable-fsck.sh (new)
     +		test_must_be_empty err &&
     +
     +		TABLE_NAME=$(cat .git/reftable/tables.list | head -n1) &&
    ++		sed "1s/^/extra/" .git/reftable/tables.list >.git/reftable/tables.list.tmp &&
    ++		mv .git/reftable/tables.list.tmp .git/reftable/tables.list &&
    ++		mv .git/reftable/${TABLE_NAME} .git/reftable/extra${TABLE_NAME} &&
    ++
    ++		test_must_fail git refs verify 2>err &&
    ++		cat >expect <<-EOF &&
    ++		error: extra${TABLE_NAME}: badReftableTableName: invalid reftable table name
    ++		EOF
    ++		test_cmp expect err
    ++	)
    ++'
    ++
    ++test_expect_success 'table name should be checked' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		git commit --allow-empty -m initial &&
    ++
    ++		git refs verify 2>err &&
    ++		test_must_be_empty err &&
    ++
    ++		TABLE_NAME=$(cat .git/reftable/tables.list | head -n1) &&
     +		sed "1s/$/extra/" .git/reftable/tables.list >.git/reftable/tables.list.tmp &&
     +		mv .git/reftable/tables.list.tmp .git/reftable/tables.list &&
     +		mv .git/reftable/${TABLE_NAME} .git/reftable/${TABLE_NAME}extra &&
     +
     +		test_must_fail git refs verify 2>err &&
     +		cat >expect <<-EOF &&
    -+		error: ${TABLE_NAME}extra: badReftableTableName: invalid reftable name
    ++		error: ${TABLE_NAME}extra: badReftableTableName: invalid reftable table extension
     +		EOF
     +		test_cmp expect err
     +	)
3:  4c6c99ded3 ! 3:  52fc14fdeb refs/reftable: add fsck check for number of tables
    @@ fsck.h: enum fsck_msg_type {
      	FUNC(BAD_REF_FILETYPE, ERROR)                              \
     
      ## refs/reftable-backend.c ##
    -@@ refs/reftable-backend.c: static int reftable_fsck_error_handler(struct reftable_fsck_info info,
    +@@ refs/reftable-backend.c: static int reftable_fsck_error_handler(struct reftable_fsck_info *info,
      	case REFTABLE_FSCK_ERROR_TABLE_NAME:
      		msg_id = FSCK_MSG_BAD_REFTABLE_TABLE_NAME;
      		break;
    @@ refs/reftable-backend.c: static int reftable_fsck_error_handler(struct reftable_
     +		msg_id = FSCK_MSG_BAD_REFTABLE_STACK_COUNT;
     +		break;
      	default:
    - 		BUG("unknown fsck error: %d", info.error);
    + 		BUG("unknown fsck error: %d", info->error);
      	}
     
      ## reftable/fsck.c ##
    @@ reftable/fsck.c: int reftable_fsck_check(struct reftable_stack *stack,
     +	if (!reftable_fsck_valid_stack_count(stack)) {
     +		struct reftable_fsck_info info = {
     +			.error = REFTABLE_FSCK_ERROR_STACK_COUNT,
    -+			.path = stack->list_file,
    ++			.path = "reftable/tables.list",
     +			.msg = "mismatch in number of tables"
     +		};
     +
    -+		err = report_fn(info, cb_data);
    ++		err = report_fn(&info, cb_data);
     +	}
     +
      out:
    @@ reftable/reftable-fsck.h
     +	REFTABLE_FSCK_ERROR_STACK_COUNT = -2,
      };
      
    - /* Represents an individual error encounctered during the FSCK checks. */
    + /* Represents an individual error encountered during the FSCK checks. */
     
      ## t/t0614-reftable-fsck.sh ##
     @@ t/t0614-reftable-fsck.sh: test_expect_success 'table name should be checked' '
    @@ t/t0614-reftable-fsck.sh: test_expect_success 'table name should be checked' '
     +
     +		test_must_fail git refs verify 2>err &&
     +		cat >expect <<-EOF &&
    -+		error: $(pwd)/.git/reftable/tables.list: badReftableStackCount: mismatch in number of tables
    ++		error: reftable/tables.list: badReftableStackCount: mismatch in number of tables
     +		EOF
     +		test_cmp expect err
     +	)
4:  7e8a14c77e ! 4:  4099878ceb refs/reftable: add fsck check for trailing newline
    @@ fsck.h: enum fsck_msg_type {
      	FUNC(BAD_REF_FILETYPE, ERROR)                              \
     
      ## refs/reftable-backend.c ##
    -@@ refs/reftable-backend.c: static int reftable_fsck_error_handler(struct reftable_fsck_info info,
    +@@ refs/reftable-backend.c: static int reftable_fsck_error_handler(struct reftable_fsck_info *info,
      	case REFTABLE_FSCK_ERROR_STACK_COUNT:
      		msg_id = FSCK_MSG_BAD_REFTABLE_STACK_COUNT;
      		break;
    @@ refs/reftable-backend.c: static int reftable_fsck_error_handler(struct reftable_
     +		msg_id = FSCK_MSG_BAD_REFTABLE_STACK_LIST_NEWLINE;
     +		break;
      	default:
    - 		BUG("unknown fsck error: %d", info.error);
    + 		BUG("unknown fsck error: %d", info->error);
      	}
     
      ## reftable/fsck.c ##
    @@ reftable/fsck.c: int reftable_fsck_check(struct reftable_stack *stack,
     +	if (!reftable_fsck_stack_contains_newline(stack->list_file)) {
     +		struct reftable_fsck_info info = {
     +			.error = REFTABLE_FSCK_ERROR_STACK_LIST_MISSING_NEWLINE,
    -+			.path = stack->list_file,
    ++			.path = "reftable/tables.list",
     +			.msg = "trailing newline missing in stack list"
     +		};
     +
    -+		err = report_fn(info, cb_data);
    ++		err = report_fn(&info, cb_data);
     +	}
     +
      	verbose_fn("Checking reftable tables count", cb_data);
    @@ reftable/reftable-fsck.h: enum reftable_fsck_error {
     +	REFTABLE_FSCK_ERROR_STACK_LIST_MISSING_NEWLINE = -3,
      };
      
    - /* Represents an individual error encounctered during the FSCK checks. */
    + /* Represents an individual error encountered during the FSCK checks. */
     
      ## t/t0614-reftable-fsck.sh ##
     @@ t/t0614-reftable-fsck.sh: test_expect_success 'table count should be checked' '
    @@ t/t0614-reftable-fsck.sh: test_expect_success 'table count should be checked' '
     +
     +		test_must_fail git refs verify 2>err &&
     +		cat >expect <<-EOF &&
    -+		error: $(pwd)/.git/reftable/tables.list: badReftableStackListNewline: trailing newline missing in stack list
    ++		error: reftable/tables.list: badReftableStackListNewline: trailing newline missing in stack list
     +		EOF
     +		test_cmp expect err
     +	)
5:  56ee4348d5 ! 5:  e33345088b refs/reftable: add fsck check for incorrect update index
    @@ fsck.h: enum fsck_msg_type {
      	FUNC(BAD_REF_NAME, ERROR)                                  \
     
      ## refs/reftable-backend.c ##
    -@@ refs/reftable-backend.c: static int reftable_fsck_error_handler(struct reftable_fsck_info info,
    +@@ refs/reftable-backend.c: static int reftable_fsck_error_handler(struct reftable_fsck_info *info,
      	case REFTABLE_FSCK_ERROR_STACK_LIST_MISSING_NEWLINE:
      		msg_id = FSCK_MSG_BAD_REFTABLE_STACK_LIST_NEWLINE;
      		break;
    @@ refs/reftable-backend.c: static int reftable_fsck_error_handler(struct reftable_
     +		msg_id = FSCK_MSG_BAD_REFTABLE_UPDATE_INDEX;
     +		break;
      	default:
    - 		BUG("unknown fsck error: %d", info.error);
    + 		BUG("unknown fsck error: %d", info->error);
      	}
     
      ## reftable/fsck.c ##
    @@ reftable/fsck.c: int reftable_fsck_check(struct reftable_stack *stack,
      			reftable_fsck_verbose_fn verbose_fn,
      			void *cb_data)
      {
    +-
     +	uint64_t min, max, prev_max = 0;
      	char **names = NULL;
     -	uint64_t min, max;
    @@ reftable/fsck.c: int reftable_fsck_check(struct reftable_stack *stack,
      
      	if (stack == NULL)
     @@ reftable/fsck.c: int reftable_fsck_check(struct reftable_stack *stack,
    - 			err = report_fn(info, cb_data);
    + 			continue;
      		}
      
     +		if (min != (prev_max + 1) || max < min) {
    @@ reftable/fsck.c: int reftable_fsck_check(struct reftable_stack *stack,
     +				.msg = "incorrect update index in table name"
     +			};
     +
    -+			err = report_fn(info, cb_data);
    ++			err = report_fn(&info, cb_data);
     +		}
     +
      		if (strcmp(tail, ".ref")) {
    - 			err = report_fn(info, cb_data);
    + 			info.msg = "invalid reftable table extension";
    + 			err = report_fn(&info, cb_data);
      		}
     +
     +		prev_max = max;
    @@ reftable/reftable-fsck.h: enum reftable_fsck_error {
     +	REFTABLE_FSCK_ERROR_UPDATE_INDEX = -4,
      };
      
    - /* Represents an individual error encounctered during the FSCK checks. */
    + /* Represents an individual error encountered during the FSCK checks. */
     
      ## t/t0614-reftable-fsck.sh ##
     @@ t/t0614-reftable-fsck.sh: test_expect_success 'stack list must contain trailing newline' '


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
change-id: 20250714-228-reftable-introduce-consistency-checks-379ded93c544

Thanks
- Karthik

