Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4819260A24
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382225; cv=none; b=dlZWA1pXTu3jX8zvWHEuyLPFJuBV5QyrXMldGkhxpAXgxAWIeUPGQ1zlAzsLv8uoP4dU1iZclPqJtiPpNOSmJIpJHoHSaQm8tfVTySQQlSY/KmCDnL8EWk2HbrCrik1u5xnSd/l/RtvSck6iSSYsPWFKngo8M5UmOGokEdF9P5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382225; c=relaxed/simple;
	bh=K+YINRhD/RdqJXxTHE8ClUmDVT1aViP1mRUg5ifZCRQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELv8/p7AYrC8+ES5AhQiJlMbGrqL50TnIowJ0Ig7AWnOm1AWIGf3QkzshvI3XQPiZ/cxtzMQh/ELriu1TydkMNlELj3+S6lpvnFkA3NI8vjmlTvGBjZlSOCbOCNhUY7F4Odk0qYXEX8HbX047VsxvfBo1tiLARgt1DP0D4mZDoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dl+qxHkQ; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dl+qxHkQ"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-52054c55991so666848e0c.1
        for <git@vger.kernel.org>; Wed, 12 Feb 2025 09:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739382222; x=1739987022; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2JP2R/fzZRLBhjn/j2vBwka2nWZp/UsOZ9PqMcE6ZqI=;
        b=Dl+qxHkQk0MfCiQa6KgsZZM1DO/wpk2gJ3kkvG/wA7AfjLr6D9wnpkm5z3OLu3oojt
         +Q+uYV9EdHcpuytsf2qNoD/xg7HKlscPzekAK/fIAPFGIUIt6ezFbGvDGeTxdl+OOXnh
         tqRNKO8Vz1zV4Br9j/6QWNZyY/IfqExaHPtxn48K8XWS12vdIAQxF3MTTSV0cYg9rhz+
         6IOxvivJ+ZaRHms5CfGZcfcWM0tUKWnd+Z6qY1afNXyQbHkvLN2X2io1J3s4X9Us0Ddi
         AvIg6BJpvtEfrFIB1LbarzlEhqnj29mG35VX784a8Yw+2OU9yuwuoGM5JkhcgXEVczNG
         /yXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739382222; x=1739987022;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JP2R/fzZRLBhjn/j2vBwka2nWZp/UsOZ9PqMcE6ZqI=;
        b=N04TG4sgn2EnPVwL8i/1Hj3nMGzK+9ErsRHlY1TltmGEde216otmU0oRvmq8dSi8hn
         i5V4w3K5Ss9Vx3PRO9LZdoR39L3aawqf8nhPrBQo7dPDnlzIMn09MfQFPj8/T/jKDYbo
         iNLBOZGf68J/TwqFy3WSn1omuR8U/mTSxDP1xeankcY2yGuKBu3qpOVM/LQWwX6vMSeb
         6OwbKZBHICLra08fW/vHok+4mVQscJypj5PydedS/dTJuQrEtNaJqXOugWk/TyVYo3T2
         3bcSLOdYtz26hqF+CIkqoX1HPJSo4VHmOt/+GSuvACRby/i4ze7QVBT7kBKISamnTtZ9
         JWMA==
X-Gm-Message-State: AOJu0YwI61KvCFVtZPK+7xjxUe/azflHn8QbdJTaITCAN19VNZX0tDso
	a9A8/tIPz6UMG3lvogWx03LozBg1YUTLQzVaFTkuQMydnCUVHMYjv5y8xPRHS6o51YwBiC4W0Jv
	Y7Lc23LWqz8xeHsp6On2jmFLyvkY=
X-Gm-Gg: ASbGncsnhXnbjMJ07/WyPQgQ7fuoTIFlV5R4D5urrDUjxi5NhtAXqOR6JOyd6Cg1XKV
	eSV+cH6PIpKEMUxGk0itlVoiN28PVp018ZZN26gpRYvsrKLMiljvf745WDprafD4rZPJFVgFglz
	y4CrOCf/LVJkKD2oN+W8p/wkgJaE7tZfc=
X-Google-Smtp-Source: AGHT+IFcjr43VP3zZhrnqL2Qsc4aKg7YVkAjhvPzAq81hffRAS5jLcJOhWtNBNxKFeuaC9vDxSsFgtJA05M0xUc5SJ8=
X-Received: by 2002:a05:6122:d02:b0:520:4fff:4c85 with SMTP id
 71dfb90a1353d-520779b9c93mr417739e0c.2.1739382222437; Wed, 12 Feb 2025
 09:43:42 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Feb 2025 09:43:41 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqcyfoz82h.fsf@gitster.g>
References: <20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v1-1-7d40f3b4e30b@gmail.com>
 <20250211-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v2-1-991a2ec9a796@gmail.com>
 <xmqqcyfoz82h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Feb 2025 09:43:41 -0800
X-Gm-Features: AWEUYZmEGgs_1sn-minOqZGbqHC6Q2Wy8j2uX_Xit_jflqnsHBx6Kzrwu02oMho
Message-ID: <CAOLa=ZTc0ahGasJOyef0L5_uz6ui-fx66kJgWVSicLv1Pgqu2A@mail.gmail.com>
Subject: Re: [PATCH v2] builtin/refs: add '--skip-reflog' flag to bypass
 reflog migration
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="0000000000007f6855062df57bf6"

--0000000000007f6855062df57bf6
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The 'git-refs(1)' migrate subcommand, which transfers repositories
>> between reference backends, currently migrates reflogs by default as of
>> 246cebe320 (refs: add support for migrating reflogs, 2024-12-16).
>>
>> While this behavior is desirable for most client-side repositories,
>> server-side repositories are not expected to contain reflogs. However,
>> due to historical reasons, some may still have them. This could be
>> caused, for example, by bugs, misconfiguration, or an administrator
>> enabling reflogs on the server for debugging purposes.
>>
>> To address this, introduce the --skip-reflog flag, allowing users to
>> bypass reflog migration. This ensures that the repository ends up in the
>> expected state after migration.
>>
>> Helped-by: Patrick Steinhardt <ps@pks.im>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> Changes in v2:
>> - Fix typo in commit mesasge and clarify the intent.
>> - Modify the test to use `test_line_count` and `test_must_be_empty`.
>> - Link to v1: https://lore.kernel.org/r/20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v1-1-7d40f3b4e30b@gmail.com
>> ---
>> Range-diff versus v1:
>>
>> 1:  ce14d3d07e ! 1:  6b83089348 builtin/refs: add '--skip-reflog' flag to bypass reflog migration
>>     @@ Commit message
>>
>>          The 'git-refs(1)' migrate subcommand, which transfers repositories
>>          between reference backends, currently migrates reflogs by default as of
>> ...
>>      +		'
>>       	done
>>       done
>> ---
>>  builtin/refs.c          |  3 +++
>>  refs.c                  |  8 +++++---
>>  refs.h                  |  5 ++++-
>>  t/t1460-refs-migrate.sh | 19 +++++++++++++++++--
>>  4 files changed, 29 insertions(+), 6 deletions(-)
>
> This is tangent that is totally unrelated to the theme of this
> patch, but I find that the placement of range-diff makes it very
> hard to follow.
>
> After skimming the proposed log message, the next thing I would want
> to see is the list of paths that are modified, before deciding I
> want to review the patch now.  Once I decide to read it _now_, the
> changes from the previous iteration and range-diff becomes relevant.
>
> Is it just me who decides in what order to review the patches and
> then reviews them in that order?
>
> Anyway.
>
>> diff --git a/builtin/refs.c b/builtin/refs.c
>> index a29f19583474518ee0942ea53c39cbdf9661c5e2..30be0254c14dd3d07693d70c25dddc9990756e9c 100644
>> --- a/builtin/refs.c
>> +++ b/builtin/refs.c
>> @@ -30,6 +30,9 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
>>  		OPT_BIT(0, "dry-run", &flags,
>>  			N_("perform a non-destructive dry-run"),
>>  			REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN),
>> +		OPT_BIT(0, "skip-reflog", &flags,
>> +			N_("skip migrating reflogs"),
>> +			REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG),
>>  		OPT_END(),
>>  	};
>>  	struct strbuf errbuf = STRBUF_INIT;
>
> OK.
>
>> diff --git a/refs.c b/refs.c
>> index f4094a326a9f88f979654b668cc9c3d27d83cb5d..5e8f5c06fa68d16c93ee11edd9742995eea994b6 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3035,9 +3035,11 @@ int repo_migrate_ref_storage_format(struct repository *repo,
>>  	if (ret < 0)
>>  		goto done;
>>
>> -	ret = refs_for_each_reflog(old_refs, migrate_one_reflog, &data);
>> -	if (ret < 0)
>> -		goto done;
>> +	if (!(flags & REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG)) {
>> +		ret = refs_for_each_reflog(old_refs, migrate_one_reflog, &data);
>> +		if (ret < 0)
>> +			goto done;
>> +	}
>>
>>  	ret = ref_transaction_commit(transaction, errbuf);
>>  	if (ret < 0)
>> diff --git a/refs.h b/refs.h
>> index a0cdd99250e8286b55808b697b0a94afac5d8319..ccee8fc6705e6e93a1c6234e7395180f8dfd815b 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -1157,8 +1157,11 @@ int is_pseudo_ref(const char *refname);
>>   *   - REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN: perform a dry-run migration
>>   *     without touching the main repository. The result will be written into a
>>   *     temporary ref storage directory.
>> + *
>> + *   - REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG: skip migration of reflogs.
>>   */
>> -#define REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN (1 << 0)
>> +#define REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN      (1 << 0)
>> +#define REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG (1 << 1)
>
> These are quite a mouthful, but they are only used between the refs
> subsystem and "git refs" command, so being overly verbose and
> specific is a good thing.
>
>>  /*
>>   * Migrate the ref storage format used by the repository to the
>> diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
>> index a6d9b35a46eb59350aa0d59d982a2fbfaecf1448..28c0024a4c8cb8282bf586840265edba442f5056 100755
>> --- a/t/t1460-refs-migrate.sh
>> +++ b/t/t1460-refs-migrate.sh
>> @@ -9,14 +9,16 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>>
>>  # Migrate the provided repository from one format to the other and
>>  # verify that the references and logs are migrated over correctly.
>> -# Usage: test_migration <repo> <format> <skip_reflog_verify>
>> +# Usage: test_migration <repo> <format> <skip_reflog_verify> <...options>
>>  #   <repo> is the relative path to the repo to be migrated.
>>  #   <format> is the ref format to be migrated to.
>>  #   <skip_reflog_verify> (true or false) whether to skip reflog verification.
>> +#   <...options> are other options be passed directly to 'git refs migrate'.
>
> Yuck.  I've never seen preceding three-dots.  Makes readers wonder
> how this thing behaves differently from the usual <options...>.
>
> Doubly yuck is ...
>

I will change it to <options...>. Thanks for pointing out.

>>  test_migration () {
>>  	repo=$1 &&
>>  	format=$2 &&
>>  	skip_reflog_verify=${3:-false} &&
>> +	shift $(( $# >= 3 ? 3 : 2 )) &&
>
> ... this thing.  The above usage declares that <skip_reflog_verify>,
> just like <repo> and <format>, are required so I do not see why we
> need to be conditional here.  If you want to make it optional,
> writing it this way instead ...
>

Right, so <skip_reflog_verify> and <options...> should be optional. So
let me change the description to be:

  Usage: test_migration <repo> <format> [<skip_reflog_verify> [<options...>]]

Which is more accurate.

> 	repo=$1 &&
>         format=$2 &&
> 	shift 2 &&
>
>         skip_reflog_verify=false &&
> 	if test $# -gt 1
> 	then
> 		skip_reflog_verify=$1
> 		shift
> 	fi
>
> ... would make it easier to extend when you ever want to add the
> next optional positional parameter.
>

Thanks this looks good too, let me use it :)

>>  	git -C "$repo" for-each-ref --include-root-refs \
>>  		--format='%(refname) %(objectname) %(symref)' >expect &&
>>  	if ! $skip_reflog_verify
>> @@ -25,7 +27,7 @@ test_migration () {
>>  	   git -C "$repo" reflog list >expect_log_list
>>  	fi &&
>>
>> -	git -C "$repo" refs migrate --ref-format="$2" &&
>> +	git -C "$repo" refs migrate --ref-format="$format" $@ &&
>
> It is a good change to use the named variable we captured upfront,
> but did you mean to leave $@ unquoted?
>

Good catch. I didn't mean to.

> Unless you want to use "$@" to invoke the magic "pass each parameter
> separately, even if it has $IFS whitespace in it" semantics,
> choosing between $* (when you want to split a parameter into many
> when it has $IFS whitespaces) and "$*" (when you want everything in
> one string) is preferred.
>

The intention is to keep the arguments as provided, so "$@" would be the
best choice here. Will change.

>>  	git -C "$repo" for-each-ref --include-root-refs \
>>  		--format='%(refname) %(objectname) %(symref)' >actual &&
>> @@ -241,6 +243,19 @@ do
>>  				test_cmp expect.reflog actual.reflog
>>  			)
>>  		'
>> +
>> +		test_expect_success "$from_format -> $to_format: skip reflog with --skip-reflog" '
>> +			test_when_finished "rm -rf repo" &&
>> +			git init --ref-format=$from_format repo &&
>> +			test_commit -C repo initial &&
>> +			# we see that the repository contains reflogs.
>> +			git -C repo reflog --all >reflogs &&
>> +			test_line_count = 2 reflogs &&
>> +			test_migration repo "$to_format" true --skip-reflog &&
>> +			# there should be no reflogs post migration.
>> +			git -C repo reflog --all >reflogs &&
>> +			test_must_be_empty reflogs
>> +		'
>>  	done
>>  done
>>
>>
>> ---
>>
>> base-commit: bc204b742735ae06f65bb20291c95985c9633b7f
>> change-id: 20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-8066f6df50ac
>>
>> Thanks
>> - Karthik

--0000000000007f6855062df57bf6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 72001db2f0e1e1d4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lczNjc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMjBSQy85RThhVXVKZHg1UGlNYW5LZWZTVk1LQ2RqZwpmNEZyWVRxaGht
VEM4LzI0UjdOOXBIUlFuS3FDNHlIZ25pZWV3cmVBWlhic2x6Uk5nZVl0VFlwOE84Qi8rcVVTCk91
RW1mc1F1QzZRK3ZtN1FIamZRK0VDMU9obFF1RUlmMVFhczdaNkxrNyt5QVBpbVFDd2NMdW5tTEI2
cjdpYmgKckgxdnFKanBEaTBUVmVRRVZselVyU1NzMi85bUdrL1ozaktBNWZpK2tIM1hieTl3YXdq
R2FWeHhOalFmSmUrNQphOU1nem9xdnFSazU5c2c1eElJby9QQjFwOFlib3hJQzV2Uk9NdWFHNTlZ
ZTExdURmSEVyUHFTMzE2N0RHZGs3CmZkY3o0Z2dDODdqbXdiak1kUEVUTkJQL2p2L2ZvaS84S0th
YXlLQU9IV1NPVHl6WXAxd3VGa2dIMExsVzFKSlYKMDdmb20zazhPTUFCN3RzNVNaMzN3TWZMekRK
WkJta3VYVUliVDlydys0MzNUM2VKME1VNERiZUl4c0tKYUc2NQpiV1hJbFhOeWE2dVU2bnEwNkMr
Tmo5UUR2b0tEZHp6VFpHY1hVTFQ1OU5kblRzVEt3c1FYZ1FUYmFpa0ZYTk5MCnR0MU42SkRsOHB2
VFFscll0bUNsQ0k5T0dCRmlPOGhITkJSL1ZvST0KPWJ6ckIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007f6855062df57bf6--
