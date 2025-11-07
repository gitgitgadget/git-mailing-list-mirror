Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0637DEEC3
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762521336; cv=none; b=TyNwd4N3B4iZ3ABHyv8tO2LddTJ7RFidZllVPXWR4WAqdaP6j95adRHtGfvCiLle21KptqWynl2kIiuxBQqUoDmEuZDqBQuWt33RTrwGSVC7XO2McfE2s8nN1tp6BknE4tJijznVITUdYgkJGiqKu+Il0HhFSlozTagDUDxmXhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762521336; c=relaxed/simple;
	bh=IGvnILQYobInC7yVBYXOG1yFDU98mqQcIZBPxUbiJFo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2KUokpfC0EYdtRRAcF1nm2XsOzEDZUNgYK1dRlzq/EEh7uV2YC2X5eqwyFBkAhgtNzkIfNgxXg+HukL+f5coaM61bZBDvrAgrVOazueLyzZvmbQTMzzkr7I00W18S9+4/30QFAg+IZsXsKuduVo/3Nl8bGFa8sB3qMOn9q85VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9WKy+I+; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9WKy+I+"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5598942c187so396542e0c.1
        for <git@vger.kernel.org>; Fri, 07 Nov 2025 05:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762521334; x=1763126134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=31HxXmo3trrQNgBdZZ2ep0dRx9yio0LXxG0rXg+OLFg=;
        b=j9WKy+I+/tmZ4u3l69K7AIbf3JfQv1JkryCjCNDS5oq/o7R5rZOyKkYDmd8pXRc573
         fVaG+jmjuMF5WhwLKgip/A6JZtxb9r8GuvTdGrtW0TSgTilAR/Zhu/IC6RNpVh3RsAsj
         2dX26GTJfBjefnvz6MgenYBzV0DIFgbOH4iYimVAbCP0+uo5W5q162YCwkbt5FitrF9P
         einLNeoBL+jM1jLvB7bHdV0dEcpX330wMUlBmIiTet2LAn8I9ElOiQLy5cDFbEUq/AeS
         tMVjTLloD5W70vk+5o/haqqwtrrD/NzpoOGApQ8hGcJryJ1R7vVf4D8QTAqElxD7dlp0
         1RIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762521334; x=1763126134;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31HxXmo3trrQNgBdZZ2ep0dRx9yio0LXxG0rXg+OLFg=;
        b=IFBU3PdI9UlZZN4LHsh2iSIXAmIdXEpzqP6kGk4ykUJZBPCyL3wky4nyp3N6zsYd5c
         VeYbgFw86YyOTNNK9YyFzwT0CivsxZIUMU/cKOhFZpmu+Mey8A4/NTqyu2hFd2xCS2rb
         WKkTeCbz3JmOV7zNUFJ+62GLF8C+Gj6HVIBUCXmzHgGfF/l1XcR6WX2TA+3Y4Wp2+Vvz
         +k0Wbs+kiLqhGgRAamDx2gOKhX6MvKbbSqKH92NEWBO1vVHyVZtnyGGjWd7vduQScnJQ
         JGGf+j+e1/P6p+BPfuluj9iDI+q/byUdxV+tXq56G71yB8o/w1KxDeZTgOcoK/Dda3Y9
         qtaA==
X-Gm-Message-State: AOJu0Yy9CXKAzgIQEaeT4MRGFm8BYZ4RnWLRYU+vDmFJus5K87+ot46q
	qQefw6X8qWTzhziKDQg4Gv/j64JGoEHIIY5viSsp257SVKOGVqzKtI10IsHKdwTe69F72pYVRSC
	g5uvcIs7Lhvbl2BuoTmNS6/9WCmgJUvo=
X-Gm-Gg: ASbGncuHh0M7cOk42RigN8UNuESjhw02P9GQ23mTSArwlX19LnTimkyVTuKo5hDsd3j
	a0IGEPNK9ctBhn4uopF+qBHdX0B0tkYlZbcNqRtgVP65qAqRsm2+1BIbwjYW3E3ofK2XWWYg9lk
	28GomUgYImKke9uyG/U1N8+lS4ZM5JjGUEYj30H8CNpTXPdxJwiiZfS5QBiR2z5LN2XSyKVCFg8
	Punc+y/QvdiuYBHDYosKeEiquOMvC+OZcFEe+pGZrlE8/u8/5Ezwv8CXzySRQ2W/p8J5qlRSnhn
	FpB8zmwbI+vS/Os8CyfkFpzS
X-Google-Smtp-Source: AGHT+IFT+I/4hM5cIp1tkJoQT6ttqQ1R9IB/W3XUGe+wSfmPdHDvVGRvzyl+iLv1dVNkDnFLcB2dUriNXg04X6Xtblw=
X-Received: by 2002:a05:6122:d12:b0:559:75b9:b836 with SMTP id
 71dfb90a1353d-559aae465dcmr574521e0c.2.1762521333573; Fri, 07 Nov 2025
 05:15:33 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Nov 2025 05:15:32 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Nov 2025 05:15:32 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aQyLfD_zx0ndCLvU@pks.im>
References: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>
 <20251106-fix-tags-not-fetching-v2-1-610cb4b0e7c8@gmail.com> <aQyLfD_zx0ndCLvU@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 7 Nov 2025 05:15:32 -0800
X-Gm-Features: AWmQ_bld50pBhQM29wAZnIAm9GJxv5VSitMoMk3cTI6vXgt8SGnSuza6Vb9dwrU
Message-ID: <CAOLa=ZQpTqnCQs4=wcUwJOWy5mXiG4y_eTiFtPkS2uOk4U66Tw@mail.gmail.com>
Subject: Re: [PATCH v2] fetch: fix non-conflicting tags not being committed
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com, sunshine@sunshineco.com, 
	David Bohman <debohman@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000ff45ed064300f904"

--000000000000ff45ed064300f904
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Nov 06, 2025 at 09:39:25AM +0100, Karthik Nayak wrote:
>> The commit 0e358de64a (fetch: use batched reference updates, 2025-05-19)
>> updated the 'git-fetch(1)' command to use batched updates. This batches
>> updates to gain performance improvements. When fetching references, each
>> update is added to the transaction. Finally, when committing, individual
>> updates are allowed to fail with reason, while the transaction itself
>> succeeds.
>>
>> One scenario which was missed here, was fetching tags. When fetching
>> conflicting tags, the `fetch_and_consume_refs()` function returns '1',
>> which skipped committing the transaction and directly jumped to the
>> cleanup section. This mean that no updates were applied.
>
> Okay, this is obviously broken indeed.
>
>> This also extends to backfilling tags when using the now deprecated
>> 'branches/' format for remotes.
>
> I'm a bit lost here -- what does backfilling have to do with the
> "branches/" directory? The backfill is supposed to create tags that
> point into the history that one has just fetched. So:
>

I didn't read the code well enough. Let me walk through what I read:

The block for backfilling tags, is only triggered in `do_fetch()`, if

    if (tags == TAGS_DEFAULT && autotags) { ... }

This means that the autotags must be '1'. And I see at the start of the
function that:

   int autotags = (transport->remote->fetch_tags == 1);

So I went into looking when `transport->remote->fetch_tags` would be set
to '1'. This is only done in `read_branches_file()` which is done when
parsing the now deprecated 'branches/' directory.

I was correct until here. But, there is something I missed.

We also pass a pointer to `autotags` to the `get_ref_map()` function. In
this function, we set `autotags` to '1' for any of the following
conditions:

   - When there is a refspec specified by the user.

   - We have a default branch with a remote specified.

So this means there are other scenarios we use the backfill() command.

That brings us to the second part of it, if we specify the '--tags'
flag, then we fetch all tags, even the ones which aren't part of our
history. This also happens as part of the `get_ref_map()` function. This
flow also skips the 'backfill()' function.

So in effect, we only backfill tags, when the user doesn't specify
either '--tags' or '--no-tags'.

>   - With `--tags` we fetch all tags announced by the remote.
>
>   - With `--no-tags` we fetch no tags.
>
>   - Otherwise we fetch those tags that point into our history.
>
> The last behaviour is a bit more on the esoteric side, but it's
> described as such in git-fetch(1):
>
>     By default, any tag that points into the histories being fetched is
>     also fetched; the effect is to fetch tags that point at branches
>     that you are interested in. This default behavior can be changed by
>     using the --tags or --no-tags options or by configuring
>     remote.<name>.tagOpt. By using a refspec that fetches tags
>     explicitly, you can fetch tags that do not point into branches you
>     are interested in as well.
>

But backfilling isn't about diverged history, no? It's about fetching
history of refs being requested.

> The following test demonstrates this behaviour:
>
> 	test_expect_success "fetch single branch without explicit tag option" '
> 		git init source &&
> 		git -C source commit --allow-empty --message common &&
> 		git clone file://"$(pwd)"/source target &&
> 		(
> 			cd source &&
> 			git commit --allow-empty --message discard-me &&
> 			git tag discard-me &&
> 			git commit --amend --allow-empty --message fetch-me &&
> 			git tag fetch-me
> 		) &&
>
> 		# The "discard-me" tag does not point into the history that we are
> 		# about to fetch, so it should not have been created.
> 		git -C target fetch origin &&
> 		git -C target tag -l >actual &&
> 		echo "fetch-me" >expect &&
>
> 		# But with "--tags" we instruct git-fetch(1) to fetch all tags, so we
> 		# should now see it.
> 		git -C target fetch origin --tags &&

Here, we don't really backfill, but rather we request all tags from the
remote, hence we end up with the 'discard-me' tag. Not because of the
diverged history. I also confirmed this by adding a breakpoint into the
`backfill_tags()` function, while running this test.

> 		git -C target tag -l >actual &&
> 		cat >expect <<-\EOF &&
> 		discard-me
> 		fetch-me
> 		EOF
> 		test_cmp expect actual
> 	'

But I was able to slightly modify the test to get the required affect:

  test_expect_success "backfill tags when providing a refspec" '
  	git init source &&
  	git -C source commit --allow-empty --message common &&
  	git clone file://"$(pwd)"/source target &&
  	(
  	    cd source &&
  	    git commit --allow-empty --message history &&
  	    git tag history &&
  	    git commit --allow-empty --message fetch-me &&
  	    git tag fetch-me
  	) &&

  	# The "history" tag is backfilled eventhough we requested
  	# to only fetch the master
  	git -C target fetch origin master:branch &&
  	git -C target tag -l >actual &&
  	cat >expect <<-\EOF &&
  	fetch-me
  	history
  	EOF
  	test_cmp expect actual
  '

I will add this in. Thanks for the explanation, it really helped
consolidate my understanding here.

>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index c7ff3480fb..d5aee5af10 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -1686,6 +1686,42 @@ static void ref_transaction_rejection_handler(const char *refname,
>>  	*data->retcode = 1;
>>  }
>>
>> +/*
>> + * Commit the reference transaction. If it isn't an atomic transaction, handle
>> + * rejected updates as part of using batched updates.
>> + */
>> +static int commit_ref_transaction(struct ref_transaction **transaction,
>> +				  bool is_atomic, const char *remote_name,
>> +				  struct strbuf *err)
>> +{
>> +	int retcode = ref_transaction_commit(*transaction, err);
>> +	if (retcode) {
>> +		/*
>> +		 * Explicitly handle transaction cleanup to avoid
>> +		 * aborting an already closed transaction.
>> +		 */
>> +		ref_transaction_free(*transaction);
>> +		*transaction = NULL;
>> +	}
>> +
>> +	if (*transaction && !is_atomic) {
>> +		struct ref_rejection_data data = {
>> +			.conflict_msg_shown = 0,
>> +			.remote_name = remote_name,
>> +			.retcode = &retcode,
>> +		};
>> +
>> +		ref_transaction_for_each_rejected_update(*transaction,
>> +							 ref_transaction_rejection_handler,
>> +							 &data);
>> +
>> +		ref_transaction_free(*transaction);
>> +		*transaction = NULL;
>> +	}
>
> Okay. Do we need to discern cases where this is called and we haven't
> managed to even queue a single reference update?
>

I don't see a reason. This is anyways a post-commit action, if there are
no updates, there will be no rejections. So this will be a no-op.

>> +	return retcode;
>> +}
>> +
>>  static int do_fetch(struct transport *transport,
>>  		    struct refspec *rs,
>>  		    const struct fetch_config *config)
>
> Nit: it might make sense to have a preparatory commit that extracts the
> function but that is otherwise a no-op change.
>

Let me do that. I was thinking the change is small. But perhaps that'd
be easier for reviewing.

>> @@ -1826,6 +1862,10 @@ static int do_fetch(struct transport *transport,
>>
>>  	if (fetch_and_consume_refs(&display_state, transport, transaction, ref_map,
>>  				   &fetch_head, config)) {
>> +		/* As we're using batched updates, commit any pending updates. */
>> +		if (!atomic_fetch)
>> +			commit_ref_transaction(&transaction, false,
>> +					       transport->remote->name, &err);
>>  		retcode = 1;
>>  		goto cleanup;
>>  	}
>
> Hm. Don't we also have to unset the transaction now? Ah, no, you pass
> the pointer to the transaction here and set it to `NULL` in
> `commit_ref_transaction()`. Makes sense.
>
>> @@ -1848,8 +1888,12 @@ static int do_fetch(struct transport *transport,
>>  			 * the transaction and don't commit anything.
>>  			 */
>>  			if (backfill_tags(&display_state, transport, transaction, tags_ref_map,
>> -					  &fetch_head, config))
>> +					  &fetch_head, config)) {
>> +				if (!atomic_fetch)
>> +					commit_ref_transaction(&transaction, false,
>> +							       transport->remote->name, &err);
>>  				retcode = 1;
>> +			}
>>  		}
>>
>>  		free_refs(tags_ref_map);
>
> We now have three different callsites where we commit the transaction.
> It gets better due to the newly introduced function, but it overall
> feels somewhat fragile regardless of that.
>

Yeah I must agree with that. I could think of a cleaner way, but will
spend some time here.

> Thanks!
>
> Patrick

Thanks,
Karthik

--000000000000ff45ed064300f904
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d7e9317e00a4a111_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rTjhQQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMllvREFDaUFwS01hSTdxLzBlZFJ1Q2dIclI1cmdMUwpuQWdhaG4rdE9H
TFl0ckw5UEUxVkxOYzBxRFN2UTIxeUcrTW8rZ3JqeVF5RE44Y2JxVUlwZWlmN21tS1dDSm1CCmZ6
SVdDUWxXQ0wzNFdtVlk4RUk4WDZEeHUvNEFWVC9uWUV3YXovTW0wSlJMU2pxQ2I3d3BBNHFFeDR4
YWJVWWkKdXBLcFdMN1RvYnFDZmJRN0xkTWpWbWtlUTJ3UVV4REV5aDhVV1NaZm5CL2JrK3JCZTRz
N01RWDFSYTdKd1hoeQpPTlB2ZUtoQ2tFbHJoWUttdEI1cWlXQlZIMGdXdXAyVWkrbitpWlJ6NzhF
MUlFYWdTOUFkUVoxQzc1bkFKcGlZCjRHendNWXRnbHJEMWNrZ0JndEdibGNDNXVwaDNjUFdWWHZK
VlRvbFEwdTdTcWdYWjBRUXhkMHVHOVdQbmFVV1YKSVV0ZkhHMjFzRmhtV0tjd0pZY2J0UkZJTXVT
VTlWL2IxRzQ2UUJPOXNMbUNFRWtWYzdpSUI4Z1grMnR4YTB6NQp5RDAxWWZKd21SaS9YS1VUKzFp
YXY1eXNTeFl2djRxQ1daREFFSnA4ZG5YMExacEM3KzhrM05DeVNtaXFsNFkxCnZKblBNajlUSnU1
MU9GcnkrWG14NmxIRU9sN3J2czA4UlFLY2hIWT0KPUdUd0oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ff45ed064300f904--
