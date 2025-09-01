Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC4E84039
	for <git@vger.kernel.org>; Mon,  1 Sep 2025 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733609; cv=none; b=MbL/rkpxlGQGVeTmESSpgzF1a8CzzKKfsWG3+6oHGQ76HtSFZNpGMsnU+2b3UkYUWr/vqMTjPiH+TrxpPnm+/dlPqHDPjEtZbSg9dQFtU4EjX7bnGg5wnLQSjwAKqXVYQrtzofL2VjFKI9nRsmsB6iCD/SLfDcl2sDUzXOWdby0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733609; c=relaxed/simple;
	bh=biLWtRw05txCIlBwc2BmrYVFAiStCoEaJOLlvmLiwOQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pAFK4j76i1eGpxjTwaS7cs3ck4L6CV1nJfZimx9PR4c8B5DiY1AXySvoRqwUuWTgo45jadZnuN5Spi+hAwBid/b5p9b3XQUQBQzO4gMzUQyAkvS5luWaSOWP70ZM2YfsNmaFih1U+yz9ss/KCtV7TmnYwvAtQqRiAMs3eve8x+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pss6uaWx; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pss6uaWx"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-52912c1c805so2069725137.2
        for <git@vger.kernel.org>; Mon, 01 Sep 2025 06:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756733607; x=1757338407; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mSQBiR83IgyCiEvXDJ8QdXCjJ6OzMy7/CChkJ3DNTPQ=;
        b=Pss6uaWxynMA8Wkay3Gyb5VV+0xG4HIlBKJwGksD0J7fjQPZEw8H/kHQ0j9nVR/18/
         eBCbQuOjTHwZe6eFNVDSJpsbDU0hh8H9BhE4Ewvdrwzh2j1DOGFhrWVDIjcSSR1pQNLu
         hcIFD+wvMmPKkEvxuvxX3AjWGDmWrJB6f5Pa+09gdJW6lV/AcRlJi9hX0kZAsIra6A/A
         Xu3BGs0lTYLLM87fn3wSesL7/Iq8zGdIzNflvVz9J9YHW9OJRMAY1nbRPn4p/dvmxbEz
         Uh92Mlw3X04j7L0d+kt0YMrk95uPin+5INpPh+Rzc5CByO4aTfU4V7nZSc0Zr3TwyNv+
         HChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756733607; x=1757338407;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mSQBiR83IgyCiEvXDJ8QdXCjJ6OzMy7/CChkJ3DNTPQ=;
        b=QwJeQNPodhQtaZwL988jOud/6OH7vpAmeIZ8FrzSqjvHcQulm7v9hMBZgzIO06CrQy
         jlU/xmx63QMXENCqfkR90RL2ZKKL00XAyc/fp0BsHaRqal5f+PSEtOTPAHqPbiFXY5la
         nqIyu31ApbigYBmKXsiwTuTCJXSWUbJZ6/VHnJ6V1WaZoH7aIijK+iuLzV9BsUZW+aOn
         8Vk5re+WdDaY8wE1CjVP57foVyzB4jszQyp5L5KO0LqZ+8HK/s/TBy7Bbor40mtJrGcJ
         KXINN1SZ6opqSQK2bt39XWbbU7EygRox5gCZE6p3DqSOchNqNQTtJ/Jta/hVxwcEQM9o
         f/CQ==
X-Gm-Message-State: AOJu0YyyNzlvVNx/Kh3VYJhcAFFHGIxq/Ytpnja4fmjkvXGlGj0qZM6E
	YAQFCfYGRO/r7OgTMUeriA3aBROe6nVmkS7bElsilJyqvuW3RqM+yO0dDBDm2ukCD0NIpBcaIiy
	oGMo6ifY7WrOBko+lSm2JgPbO0KDgdD3zMg==
X-Gm-Gg: ASbGncu+5GMEohcm+1HA52upOdbQPHtpb9IhZ7Hym1cWGByvvHltC8BBcL1wJeu398H
	QXl10r85554lwkEqR9dNZP/uxCyyUPxXGarGKYKPmmxs/i5rxwGZHS/XpTTUtd17P1ObEO7Al3W
	n97NjWb3xeIN0UFKX3dcOE2EST9gyNtYT9+CtI9O057czwRjIkNTd4+Xt4rLQpPD81fxu2AeNfX
	bQMlltSjtNUmxqala+73BgzBsrvkRqrnVKr3Mvg4DRS8MjNXOFC
X-Google-Smtp-Source: AGHT+IEkE6Z+0b1VvQvBLthdYp3UqTLRaFUwq/sfNSnt+drxMUVM0LhziifkPieU4flMFAcxbonTwQfvq6MUN/iJK/0=
X-Received: by 2002:a05:6102:5f04:b0:529:e9a5:c216 with SMTP id
 ada2fe7eead31-52b19848814mr2177831137.4.1756733606380; Mon, 01 Sep 2025
 06:33:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Sep 2025 06:33:24 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Sep 2025 06:33:24 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aK3fHRMFiRBYNiJE@ArchLinux>
References: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
 <20250819-228-reftable-introduce-consistency-checks-v1-2-8b8f6879fa9e@gmail.com>
 <aK3fHRMFiRBYNiJE@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 1 Sep 2025 06:33:24 -0700
X-Gm-Features: Ac12FXyAYIhE9R6YS_FlqlaZGdNWIL-BGQDF_hJkC-OTtKqnmKXNvWHMu2X_LlE
Message-ID: <CAOLa=ZR43JYu1ky_HF7nC4xkVe6B+fMWTNK+sczaar_8YNcd8A@mail.gmail.com>
Subject: Re: [PATCH 2/5] refs/reftable: add fsck check for checking the table name
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="00000000000092e2ea063dbd6ad6"

--00000000000092e2ea063dbd6ad6
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> On Tue, Aug 19, 2025 at 02:21:01PM +0200, Karthik Nayak wrote:
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
>
> A design question here, we name the "fsck.c" for the source code but for
> the header, we use "reftable-fsck.h", it is a little strange. Why not
> just "fsck.h" instead of "reftable-fsck.h".
>

Since the reftable code is treated as an external library, all
'reftable-.*.h' headers are treated as headers which expose APIs for the
libraries users. We would have defined 'reftable/fsck.h' if there were
internal users of the 'fsck.c' code. But there are none.


>> diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
>> index 1c912615f9..784ddc0df5 100644
>> --- a/Documentation/fsck-msgids.adoc
>> +++ b/Documentation/fsck-msgids.adoc
>> @@ -38,6 +38,9 @@
>>  `badReferentName`::
>>  	(ERROR) The referent name of a symref is invalid.
>>
>> +`badReftableTableName`::
>> +	(ERROR) A reftable table has an invalid name.
>> +
>
> When reading this, I feel a little strange. `Reftable` already indicates
> it is a table. Should we simply say like the following:
>
>     A reftable has an invalid table name
>

I'm not sure about this, since 'reftable' refers to the reference
backend and the 'table' refers to an individual table within the
'reftable' format. I would say both are important.

CC'ing Patrick here for a second opinion.

>>  `badTagName`::
>>  	(INFO) A tag has an invalid format.
>>
>> diff --git a/Makefile b/Makefile
>> index e11340c1ae..f2ddcc8d7c 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -2733,6 +2733,7 @@ REFTABLE_OBJS += reftable/error.o
>>  REFTABLE_OBJS += reftable/block.o
>>  REFTABLE_OBJS += reftable/blocksource.o
>>  REFTABLE_OBJS += reftable/iter.o
>> +REFTABLE_OBJS += reftable/fsck.o
>>  REFTABLE_OBJS += reftable/merged.o
>>  REFTABLE_OBJS += reftable/pq.o
>>  REFTABLE_OBJS += reftable/record.o
>> diff --git a/fsck.h b/fsck.h
>> index 559ad57807..5901f944a1 100644
>> --- a/fsck.h
>> +++ b/fsck.h
>> @@ -34,6 +34,7 @@ enum fsck_msg_type {
>>  	FUNC(BAD_PACKED_REF_HEADER, ERROR)                         \
>>  	FUNC(BAD_PARENT_SHA1, ERROR)                               \
>>  	FUNC(BAD_REFERENT_NAME, ERROR)                             \
>> +	FUNC(BAD_REFTABLE_TABLE_NAME, ERROR)                       \
>>  	FUNC(BAD_REF_CONTENT, ERROR)                               \
>>  	FUNC(BAD_REF_FILETYPE, ERROR)                              \
>>  	FUNC(BAD_REF_NAME, ERROR)                                  \
>> diff --git a/meson.build b/meson.build
>> index 5dd299b496..82879fbfaa 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -452,6 +452,7 @@ libgit_sources = [
>>    'reftable/error.c',
>>    'reftable/block.c',
>>    'reftable/blocksource.c',
>> +  'reftable/fsck.c',
>>    'reftable/iter.c',
>>    'reftable/merged.c',
>>    'reftable/pq.c',
>> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
>> index 8dae1e1112..ccd12052f2 100644
>> --- a/refs/reftable-backend.c
>> +++ b/refs/reftable-backend.c
>> @@ -6,20 +6,21 @@
>>  #include "../config.h"
>>  #include "../dir.h"
>>  #include "../environment.h"
>> +#include "../fsck.h"
>>  #include "../gettext.h"
>>  #include "../hash.h"
>>  #include "../hex.h"
>>  #include "../iterator.h"
>>  #include "../ident.h"
>> -#include "../lockfile.h"
>
> Here, we delete this header file. Is the reason that we don't need this
> header file anymore?
>

Yes, it wasn't needed in the first place, let me add a comment in the
commit message.

>>  #include "../object.h"
>>  #include "../path.h"
>>  #include "../refs.h"
>>  #include "../reftable/reftable-basics.h"
>> -#include "../reftable/reftable-stack.h"
>> -#include "../reftable/reftable-record.h"
>>  #include "../reftable/reftable-error.h"
>> +#include "../reftable/reftable-fsck.h"
>>  #include "../reftable/reftable-iterator.h"
>> +#include "../reftable/reftable-record.h"
>> +#include "../reftable/reftable-stack.h"
>>  #include "../repo-settings.h"
>>  #include "../setup.h"
>>  #include "../strmap.h"
>> @@ -2675,11 +2676,59 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
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
>> +
>> +static int reftable_fsck_error_handler(struct reftable_fsck_info info,
>
> A design question: why do we need to pass the value "info" instead of
> pointer?
>

I didn't see a reason to make it a pointer. But it does make it more
efficient when the struct size increases. Let me change it!

>
>> +				       void *cb_data)
>> +{
>> +	struct fsck_options *o = cb_data;
>> +	struct fsck_ref_report report = { .path = info.path };
>
> Let's make it reverse-christmas-tree ordering.
>

Will change!

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
>> +
>> +	ret = reftable_fsck_check(refs->main_backend.stack, reftable_fsck_error_handler,
>> +				  reftable_fsck_verbose_handler, o);
>> +	if (!ret)
>> +		return ret;
>> +
>
> From my understanding, if we find that there is any trouble in the main
> worktree reftable backend, we would just abort the check. Should we
> continue to check the linked worktrees?
>

I think that makes sense. Let me make that change.

>> diff --git a/reftable/fsck.c b/reftable/fsck.c
>> new file mode 100644
>> index 0000000000..22ec3c26e9
>> --- /dev/null
>> +++ b/reftable/fsck.c
>> @@ -0,0 +1,50 @@
>> +#include "basics.h"
>> +#include "reftable-fsck.h"
>> +#include "stack.h"
>> +
>> +int reftable_fsck_check(struct reftable_stack *stack,
>> +			reftable_fsck_report_fn report_fn,
>> +			reftable_fsck_verbose_fn verbose_fn,
>> +			void *cb_data)
>> +{
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
>> +			.msg = "invalid reftable name"
>> +		};
>
> Should we define this data structure outside of the loop? It's
> unnecessary here as we could change ".path" and ".msg" dynamically in
> the loop.
>

I don't think it'd make much difference for reftables, since tables are
geometrically packed. But I don't feel strongly, so I'll make the
change.

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
>> +			err = report_fn(info, cb_data);
>
> I think we could just pass pointer to avoid unnecessary copy operations.
> Besides that, I think here we report two different kinds of problem. But
> we would give report the user always the same message `invalid reftable
> name`. This is too vague.
>

Not sure what you mean by 'unnecessary copy operations', could you
elaborate?

> I think we'd better set different messages for different problems.
>

Fair enough, let me modify that.

[snip]

>> diff --git a/t/t0614-reftable-fsck.sh b/t/t0614-reftable-fsck.sh
>> new file mode 100755
>> index 0000000000..0d11871b1c
>> --- /dev/null
>> +++ b/t/t0614-reftable-fsck.sh
>> @@ -0,0 +1,35 @@
>> +#!/bin/sh
>> +
>> +test_description='Test reftable backend consistency check'
>> +
>> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
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
>> +		sed "1s/$/extra/" .git/reftable/tables.list >.git/reftable/tables.list.tmp &&
>> +		mv .git/reftable/tables.list.tmp .git/reftable/tables.list &&
>> +		mv .git/reftable/${TABLE_NAME} .git/reftable/${TABLE_NAME}extra &&
>> +
>> +		test_must_fail git refs verify 2>err &&
>> +		cat >expect <<-EOF &&
>> +		error: ${TABLE_NAME}extra: badReftableTableName: invalid reftable name
>> +		EOF
>> +		test_cmp expect err
>> +	)
>> +'
>
> We would check two kinds of errors, should we add two tests instead of
> only this one.
>

Yeah, makes sense, will add!

>> +
>> +test_done
>>
>> --
>> 2.50.1
>>
>
> Thanks,
> Jialuo

Thanks for the review.

--00000000000092e2ea063dbd6ad6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e4b4fe1987e87704_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pMW9LTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMThDQy85SnZFMXcvUXZuQXE4RUVReXd2NWlSTDJWZApoZTdrdXVWZDRi
dnJ1blRoOFhGTmVTNmp4cFZBTjE3UGlPRTJEVElDZ2FGYmVCSW5HNEhwNU5uRXlvcCs0TGluClpH
M095b3pzNVdBdmJSREFmbWpWdkhpc0Z0Y2RacFdadHNRa1c5T0RBMytQdDdLZkpOaUJZdDU0ZGhV
TUNMcG8KWUxjNFBQQXBQWGJiQ1ZFVC91WkpyNTdNVm1OZjBUK1VScDI0WUsrTVZ1ZVNLRnlnMGVG
Z0E4MlluS0x0Q3VkOQo4MHdYZmlOZjN4cytwRWlYeFVDbEFibStpOWRlU2s0M292a3J1KzV2SU9y
bjRvTmhENlBSNzNNMFlvQVlYdGIvCnl2aE81SjFuNTZISDdxdG1Ga2xzZUxXbzZibnlCMmxEYkFp
a2F5SlZ6RjZXWXZtYms3MFgvTmRTRCtOQjgyL1QKS3VIYm4wUW51TDVWRVVWbGdOTEwyK1JUYXRu
R3FOV1FvTWNTTzRoRGJhK2FSNmlXRUlEbWxUN3Bha3psWU5RSwp5b0w1YkF6TnJteHMwRmw4WWtm
RmdFMGhVTDBXSkVlK0h5STJyV1g1TDFUZWxURGo1eGhaZnZYLzNZU3dUQlFJCk90cG1GT293NXEv
YXo5MEJqODlzNU9uVGQ0SW05MGV2OTEzM0VuWT0KPXBZRTEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000092e2ea063dbd6ad6--
