Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F76246327
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407332; cv=none; b=NqYP+sjEzThuXROO1n1VQGeLr/w6/7pxixM947owW6mbpb5gSbPLq3y0Oxf810jLjQCzNPleFqbOuwV3VKlyxipLgwX8xyftKsipQ8YxFAShVXWMLL0wI6pk9Ew3dagXV7QxX3l/pqZ6LMERml2/o+UBgBM3xza6w2jJvmzYBiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407332; c=relaxed/simple;
	bh=aCcV6G6bFAow5IqO8uylLsYgS9zezxygw4KSXZYGIa8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TiWx40k+qH/tKfo5RIMqQC6tGZ2kimfBBE7xcp+sLDm8YjUVrTyB85vMIBVO8IVgqBGoTik4N/1eGXU7kQ/vuGaQc8KMobtmABJpbDAGQgUKjGGQJvXArcTzrVXk9vGHXu2leydVawT0z1kT0i9uzFprIdOeMcqYoBIznRhm32c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9nZFnh+; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9nZFnh+"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-544a2339775so1763640e0c.0
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 01:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757407329; x=1758012129; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LiENgnEBvaPw2qzpB8l63hs72DmboY9JorF3HThSjb4=;
        b=g9nZFnh+hHX/BUJ20cQpovkiNxcZx/5ZnaqJez+m7qm4S9XCDJgFp29ZKmesOiWLKy
         v2gaUPSNC8OhSn8WCTwhok1PO6IefFWV6tn9mCcDtOInqwH8s+hbuF37U/xzplMrX+ll
         +y8lbdOCqpPDv0t1B7AqIPrtQiUGoJVu9KrdIw4n7H+9wuM3xk64wFYLnUPOD35/H5fh
         0RR/9Igox2t/C95PpEGZNg1+tAadr+TIRS4hq8gda7cUy40ky4ar6/Vdvg5kbsoOFwnT
         //4eSkv8gqyDZLP8hmnk96jii2vL2VCgnpvit2wc6sTxyF639UUMr/0Ix3RKBIXGwu9d
         s64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757407329; x=1758012129;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LiENgnEBvaPw2qzpB8l63hs72DmboY9JorF3HThSjb4=;
        b=TV6Qmte7U5ogzgWR/X5GmGM0Cm6E9F12QbuH580H4wHb6jw/vyDVWiTUj8c48ahZjV
         ttceBVLHK99q0Df6UUCz1MszYj2cCQdCU6awKO0SEttHH77KKkQkMU76YSmiMO6A4D4y
         Jge1Se7vjLDxFGK+pTVPVacfIxZi5BxTlI2CxxSU/kzUDZDSn1oVmmELK6tNtiNEyPKL
         S27tNr302DZ3ydxNHl6fXkMrH6QdSAcLitmpz+5rE78X72Bm7w58noxAZqnEwquSj+lZ
         U5ouZQmM0MlLuj/b/VxEoWPpZZEns7rkodJervoSV4w0KIt6pEIVsEJ1VirydCaY5WKO
         vFgg==
X-Gm-Message-State: AOJu0YxlFlBepEFwhoNpVCJQWVkk4K44sG+jKcvVziu5kNqnCOo3qixJ
	pDPLqrlQ04XWGrD5sLihkPkKiEj7QRcNFpb//zxbB/SyzPSiUjCt/A2OvSjGnx5e0ObTYPD8Ba+
	a10T1bXBoKyxG3IbKI342xkceuqMhd8I1pbBU
X-Gm-Gg: ASbGncsxWGCodGAgOjkwrd7v7wZihFou1c+rfw/cvobIGiT7gXvCdhEw6l3YyMF0VnH
	9USOs6CasSok69LlKCj880yD3f/ucxN6k7lhrCEcEA6lRxDB8wuBh0Mit/4kU75JEOcpZFaPUmP
	dtohnB8NxoLCCx3j0I/m/a1WJJWpo1IH6DyD83B+fJxelZD/Eqxw9pJNzf8oPp772q4PzzBwGl5
	7TsiqwlC+uIrWSK
X-Google-Smtp-Source: AGHT+IHBRhxjl+9KNozE3YopFsYChZLalMAmRJJ4wB9A26tP99FeZFLp3mMSk9HEAQUaO1skGZ1hd2DLzG9PGm1qiBs=
X-Received: by 2002:a05:6102:d8c:b0:4fb:142:f4c0 with SMTP id
 ada2fe7eead31-53d017f9df4mr2977221137.0.1757407328697; Tue, 09 Sep 2025
 01:42:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Sep 2025 03:42:08 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Sep 2025 03:42:08 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aLf3MaKHZSQfnBlT@pks.im>
References: <20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com>
 <20250902-228-reftable-introduce-consistency-checks-v2-2-4f96b3834779@gmail.com>
 <aLf3MaKHZSQfnBlT@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 9 Sep 2025 03:42:08 -0500
X-Gm-Features: AS18NWDM3YR969S1Zxrqqaw9TFlO_x7huz02CqKcS8N13KvJ46k1WpusCZZlzB0
Message-ID: <CAOLa=ZQoOX9y2_KwnAcyS-dVeQm1QnFdZocomt05BkxL9xDFuA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] refs/reftable: add fsck check for checking the
 table name
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com, shejialuo@gmail.com
Content-Type: multipart/mixed; boundary="0000000000008da152063e5a47fd"

--0000000000008da152063e5a47fd
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Sep 02, 2025 at 09:05:22AM +0200, Karthik Nayak wrote:
>> The `git refs verify` command is used to run fsck checks on the
>> reference backends. This command is also invoked when users run 'git
>> fsck'. While the files-backend has some fsck checks added, the reftable
>> backend lacks such checks. Let's add the required infrastructure and a
>> check to test for the table names in the 'tables.list' of reftables.
>>
>> For the infrastructure, since the reftable library is treated as an
>> independent library we should ensure that the library code works
>> independently without knowledge about Git's internals. To do this,
>> add both 'reftable/fsck.c' and 'reftable/reftable-fsck.h'. Which
>> provide an entry point 'reftable_fsck_check' for running fsck checks
>> over a provided reftable stack. The callee provides the function with
>> callbacks to handle issue and information reporting.
>>
>> Add glue code in 'refs/reftable-backend.c' which calls the reftable
>> library to perform the fsck checks. Here we also map the reftable errors
>> to Git' fsck errors.
>>
>> Introduce a check to validate table names for a given reftable stack.
>> Also add 'badReftableTableName' as a corresponding error within Git. Add
>> a test to check for this behavior.
>>
>> While here, remove a unused header `#include "../lockfile.h"` from
>> 'refs/reftable-backend.c'.
>
> It's quite a bunch of changes overall that could've been reasonably
> split up into multiple commits. E.g. one to introduce the reftable-side
> logic, one to start calling it in Git, and one to drop the superfluous
> header.
>

I'm always hesitant to have small commits for some reason. Thanks for
calling out, I'll split it up.

Sidenote: I used `git history split` for this, and it was just perfect.

>> diff --git a/Makefile b/Makefile
>> index e11340c1ae..f2ddcc8d7c 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -2733,6 +2733,7 @@ REFTABLE_OBJS += reftable/error.o
>>  REFTABLE_OBJS += reftable/block.o
>>  REFTABLE_OBJS += reftable/blocksource.o
>>  REFTABLE_OBJS += reftable/iter.o
>> +REFTABLE_OBJS += reftable/fsck.o
>
> "f" is before "i" in the alphabet I'm accustomed to :) So let's retain
> lexicographic ordering here.
>

This ordering was already broken, but that's no reason to break it more.
Let' me fix it.

>> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
>> index 8dae1e1112..c38c6422f8 100644
>> --- a/refs/reftable-backend.c
>> +++ b/refs/reftable-backend.c
>> @@ -2675,11 +2676,55 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
>>  	return ret;
>>  }
>>
>> -static int reftable_be_fsck(struct ref_store *ref_store UNUSED,
>> -			    struct fsck_options *o UNUSED,
>> +static void reftable_fsck_verbose_handler(const char *msg, void *cb_data)
>> +{
>> +	struct fsck_options *o = cb_data;
>> +
>> +	if (o->verbose)
>> +		fprintf_ln(stderr, "%s", _(msg));
>> +}
>
> Is this `_()` marker correct here? There isn't really any reasonable way
> for somebody to translate a variable with unknown contents. So shouldn't
> it only be the caller of `reftable_fsck_verbose_handler()` that should
> mark the string as translatable?
>

True, but this is a callback function called from within the reftable
library. I guess for now I can leave out the translation and we can
think about the best way to fix that later.

We need a more generic way to translate output strings originating from
the reftable library.

>> +static int reftable_fsck_error_handler(struct reftable_fsck_info *info,
>> +				       void *cb_data)
>> +{
>> +	struct fsck_ref_report report = { .path = info->path };
>> +	struct fsck_options *o = cb_data;
>> +	enum fsck_msg_id msg_id;
>> +
>> +	switch (info->error) {
>> +	case REFTABLE_FSCK_ERROR_TABLE_NAME:
>> +		msg_id = FSCK_MSG_BAD_REFTABLE_TABLE_NAME;
>> +		break;
>> +	default:
>> +		BUG("unknown fsck error: %d", info->error);
>> +	}
>> +
>> +	return fsck_report_ref(o, &report, msg_id, "%s", info->msg);
>> +}
>
> I think this function will become a bit unwieldy over time. We might
> instead want to have an array that maps from reftable-specific to
> fsck-specific error code:
>
>     static const fsck_msg_id[] = {
>         [REFTABLE_FSCK_ERROR_TABLE_NAME] = FSCK_MSG_BAD_REFTABLE_TABLE_NAME,
>     };
>
> So in that case, all we'd have to do is to perform bounds checking in
> the above function. And maybe verify that the developer didn't forget to
> fill in a new msg ID by checking that the derived message ID is non-zero.
>

Yeah that sounds like a really good improvement, let me add that.

>> +static int reftable_be_fsck(struct ref_store *ref_store, struct fsck_options *o,
>>  			    struct worktree *wt UNUSED)
>>  {
>> -	return 0;
>> +	struct reftable_ref_store *refs;
>> +	struct strmap_entry *entry;
>> +	struct hashmap_iter iter;
>> +	int ret = 0;
>> +
>> +	refs = reftable_be_downcast(ref_store, REF_STORE_READ, "fsck");
>> +
>> +	if (o->verbose)
>> +		fprintf_ln(stderr, _("Checking references consistency"));
>
> This line is duplicate across both backends, right? Maybe it's something
> that we can do in the generic logic?
>

Yeah, we can. Will do.

>> +	ret |= reftable_fsck_check(refs->main_backend.stack, reftable_fsck_error_handler,
>> +				  reftable_fsck_verbose_handler, o);
>> +
>> +	strmap_for_each_entry(&refs->worktree_backends, &iter, entry) {
>> +		struct reftable_backend *b = (struct reftable_backend *)entry->value;
>> +		ret |= reftable_fsck_check(b->stack, reftable_fsck_error_handler,
>> +					  reftable_fsck_verbose_handler, o);
>> +	}
>> +
>> +	return ret;
>>  }
>>
>>  struct ref_storage_be refs_be_reftable = {
>
> Looks good.
>
>> diff --git a/reftable/fsck.c b/reftable/fsck.c
>> new file mode 100644
>> index 0000000000..4282b1413e
>> --- /dev/null
>> +++ b/reftable/fsck.c
>> @@ -0,0 +1,53 @@
>> +#include "basics.h"
>> +#include "reftable-fsck.h"
>> +#include "stack.h"
>> +
>> +int reftable_fsck_check(struct reftable_stack *stack,
>> +			reftable_fsck_report_fn report_fn,
>> +			reftable_fsck_verbose_fn verbose_fn,
>> +			void *cb_data)
>> +{
>> +
>> +	char **names = NULL;
>> +	uint64_t min, max;
>> +	int err = 0;
>> +
>> +	if (stack == NULL)
>> +		goto out;
>> +
>> +	err = read_lines(stack->list_file, &names);
>> +	if (err < 0)
>> +		goto out;
>> +
>> +	verbose_fn("Checking reftable table names", cb_data);
>> +
>> +	for (size_t i = 0; names[i]; i++) {
>> +		struct reftable_fsck_info info = {
>> +			.error = REFTABLE_FSCK_ERROR_TABLE_NAME,
>> +			.path = names[i],
>> +		};
>> +		uint32_t rnd;
>> +		/*
>> +		 * We want to match the tail '.ref'. One extra byte to ensure
>> +		 * that there is no unexpected extra character and one byte for
>> +		 * the null terminator added by sscanf.
>> +		 */
>> +		char tail[6];
>> +
>> +		if (sscanf(names[i], "0x%012" PRIx64 "-0x%012" PRIx64 "-%08x%5s",
>> +			   &min, &max, &rnd, tail) != 4) {
>> +			info.msg = "invalid reftable table name";
>
> This here is where the string should be translated.
>

But we don't have translation capabilities within the reftable lib no?
Or am I mistaken?

>> +			err = report_fn(&info, cb_data);
>> +			continue;
>> +		}
>
> I think sscanf is quite frowned-upon in the Git codebase. Maybe we
> should manually parse through the string instead?
>

That would be cumbersome. This isn't user input data, so I thought this
would be okay. But let me do the change.

> Furthermore, I think we should move every single check into a separate
> function, similar to how the files backend does it. This ensures that
> checks are self-contained and that it's way easier to add new checks
> over time.
>

I think Shejialuo also mentioned this, let me do that.

> Another angle: did you verify that reftables written by JGit follow this
> format?
>

No I haven't.

>> +		if (strcmp(tail, ".ref")) {
>> +			info.msg = "invalid reftable table extension";
>
> Same here, this should be translated.
>
>> diff --git a/reftable/reftable-fsck.h b/reftable/reftable-fsck.h
>> new file mode 100644
>> index 0000000000..4cf0053234
>> --- /dev/null
>> +++ b/reftable/reftable-fsck.h
>> @@ -0,0 +1,38 @@
>> +#ifndef REFTABLE_FSCK_H
>> +#define REFTABLE_FSCK_H
>> +
>> +#include "reftable-stack.h"
>> +
>> +enum reftable_fsck_error {
>> +	/* Invalid table name */
>> +	REFTABLE_FSCK_ERROR_TABLE_NAME = -1,
>> +};
>
> Wouldn't it be more natural to give these positive numbers?
>

Yes, that would be better and also fits in with the array suggstion you
made earlier.

>> +/* Represents an individual error encountered during the FSCK checks. */
>> +struct reftable_fsck_info {
>> +	enum reftable_fsck_error error;
>> +	const char *msg;
>> +	const char *path;
>> +};
>
> I wonder whether it should be the reftable library that decides on the
> severity of each generated finding.
>

I think that'd make sense. Let me add that in.

>> +typedef int reftable_fsck_report_fn(struct reftable_fsck_info *info,
>> +				    void *cb_data);
>> +typedef void reftable_fsck_verbose_fn(const char *msg, void *cb_data);
>> +
>> +/*
>> + * Given a reftable stack, perform FSCK check on the stack.
>
> s/FSCK check/consistency checks/
>
>> + *
>> + * If an issue is encountered, the issue is reported to the callee via the
>> + * provided 'report_fn'. If the issue is non-recoverable the flow will not
>> + * continue. If it is recoverable, the flow will continue and further issues
>> + * will be reported as identified.
>> + *
>> + * The 'verbose_fn' will be invoked to provide verbose information about
>> + * the progress and state of the FSCK checks.
>
> Same here.
>

Thanks, changed both.

>> diff --git a/t/t0614-reftable-fsck.sh b/t/t0614-reftable-fsck.sh
>> new file mode 100755
>> index 0000000000..81d30df2d7
>> --- /dev/null
>> +++ b/t/t0614-reftable-fsck.sh
>> @@ -0,0 +1,58 @@
>> +#!/bin/sh
>> +
>> +test_description='Test reftable backend consistency check'
>> +
>> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
> Tests shouldn't define these variables, but should dynamically figure
> out what the default branch name is as required, e.g. by using
> git-symbolic-ref(1).
>

Yeah, makes sense. Will change it.

>> +GIT_TEST_DEFAULT_REF_FORMAT=reftable
>> +export GIT_TEST_DEFAULT_REF_FORMAT
>> +
>> +. ./test-lib.sh
>> +
>> +test_expect_success 'table name should be checked' '
>> +	test_when_finished "rm -rf repo" &&
>> +	git init repo &&
>> +	(
>> +		cd repo &&
>> +		git commit --allow-empty -m initial &&
>> +
>> +		git refs verify 2>err &&
>> +		test_must_be_empty err &&
>> +
>> +		TABLE_NAME=$(cat .git/reftable/tables.list | head -n1) &&
>
> You can drop the cat(1) invocation and directly say `head -n1 file`.
>

Indeed, thanks!

>> +		sed "1s/^/extra/" .git/reftable/tables.list >.git/reftable/tables.list.tmp &&
>> +		mv .git/reftable/tables.list.tmp .git/reftable/tables.list &&
>> +		mv .git/reftable/${TABLE_NAME} .git/reftable/extra${TABLE_NAME} &&
>
> No need for the curly braces around TABLE_NAME here and further down. It
> would be nice to quote these strings though.
>

Understandable. I always prefer using them, since they make it much
easier to read, even without the ambiguity issue.

>> +
>> +		test_must_fail git refs verify 2>err &&
>> +		cat >expect <<-EOF &&
>> +		error: extra${TABLE_NAME}: badReftableTableName: invalid reftable table name
>> +		EOF
>> +		test_cmp expect err
>> +	)
>> +'
>> +
>> +test_expect_success 'table name should be checked' '
>> +	test_when_finished "rm -rf repo" &&
>> +	git init repo &&
>> +	(
>> +		cd repo &&
>> +		git commit --allow-empty -m initial &&
>> +
>> +		git refs verify 2>err &&
>> +		test_must_be_empty err &&
>> +
>> +		TABLE_NAME=$(cat .git/reftable/tables.list | head -n1) &&
>
> Same here wrt the extra invocation of cat(1).
>

Will change! Thanks.

> Patrick

--0000000000008da152063e5a47fd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8efd3d76ecc278df_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pLzZGNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNWpFREFDYVlFdjV3c3hsY0pQRDVnVnRBajN5TTFBUwpDRHhwMWFlaGh2
OTRmRkFBSlpIL2FJQlcvOXlQeUtrNm96SHlDVHlOQXh3OWxCTHZiYTdCWUpQOWo1MmN1eDQzCnpw
dW5lMW8zVFNodVVzeGtYMzMvZHRsRUZPZWVGUjJBZnoxemhEQ2dsZU9vZ09MN1M1YnB4NHJsWjA3
dnRQc1kKUmVtNFcxSUhUNEZzbGNHVjI4eEJIUTlycmx6OHpQRDhaaENpUTFZUVIvL3NmR043TW4v
UEN5UUFoNE1IcmswMQpkWEFEUGZscHBrQVI5TWNHbmZQSFB6SkZVZXBwY0VJSnRmR3Q1SkFlcWNT
WGlSc3drcFRCVVFvbnFHVi90OHFDCllpeTJrYkhVTmlKV1VONHhNbk1iRnhvWCtQMUxOaEhlSWFw
ZDNNd1ArdWFsVHd3RWV1bWdjUmtxLzhuVmpoSU8Kem1KazlYYlVJVDAycnVqMTVmUlJFUFQ1OHdG
SmFKcWpsMUZBNThnWUZlZlFKdWtINGE5NVdUL2pRdzN5eTV0dwpJK280VFAzazZUd0hPMVBxTUll
anBZMUlZYmtPempHWk54SDBCYjFKMS9GSFhMR2RoMHFzejh1OGF4VVJVNWZGCjlySzlsdTZuWVVz
WXg1L0xnK3J1Nm5uQnA4NDBHNzFIOCtCZ3VoND0KPVlDRzUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008da152063e5a47fd--
