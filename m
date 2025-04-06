Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CCD7E0E4
	for <git@vger.kernel.org>; Sun,  6 Apr 2025 20:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743972524; cv=none; b=CXbVMvjFGqeX8NVCWIhOca79otCd4OncyxUzwtyHG2HzLqqlS7vy6UCz7fk+wv+KoqSNttwfdVechjDkvgjwH0+88dVs7hdChE1W9X/OS8TdSfVr1lX39iPkTCZXpRjdbGeoOfERwA7SWy6tMwBJkh2MB9UzQh+QbJNppScHHI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743972524; c=relaxed/simple;
	bh=OCg9pgmpVtG2rHSQQd/376oPmS6d9ceJsvmvciLFAUg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bnssrvFuBxELhAGs7N3jOC9L6/yOnuRG1DEHxNDuiqOYzM9NIRK6BoKQH0nCVQusxgu6aN+1NccgxwnrHGJxh4UXyRIqRy0wd16n81XevFBwPv1mmWfFjqGSNnTtvDmsgsexxu4zf3SZiRui5N7bVNOsQpCtK9UuhR1MwASs8gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARMlhH/E; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARMlhH/E"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86cce5dac90so1546354241.0
        for <git@vger.kernel.org>; Sun, 06 Apr 2025 13:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743972521; x=1744577321; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jYNcI+yAxYqTr+q8oTS/zCcBe1miKdbe6+sbEtaur04=;
        b=ARMlhH/E23cEYJq+/fszubog4H4HGG1PyRPpjVBWdotUapI7D9M2XVm+R5IMz4PcxE
         V4LRiIcH9xOErAJLgLS2qto8QyNbqYvfb/A2NsGNFyersvbZxzc18kRFD2iHai2/Yzuu
         rYmwzNBSjPWPIDbcZ2Q+jPx3uyvqw1zRG/znnWojc7sRFoZgPOhyZBS+LjmrZ6Lec0Ax
         Gbipnob4RAi3SqPJnB3zZ1gG5GMHlfMhvn72Eb37fJO8qMkFrtptB5+nV/ko5k5LNzcs
         KVMroUp/cQSNuIUMs2h2Y5Cec/Q55QZyd7VVvrvKJrN6mxSE0j/sRQ4oGHcZCPe9oLjR
         yqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743972521; x=1744577321;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jYNcI+yAxYqTr+q8oTS/zCcBe1miKdbe6+sbEtaur04=;
        b=CIaJlUlXKMFenrLmAGXgkyYmLtE93UAYQgbtPPsxnlggLoy+52amHgoFoPggK/P6F9
         1HT4kjUi/1WGJzFB8qwMTUPDeBW3Eul9YRy9OS3dGEfa/aXsQdlw2ZYTcMI5DNgHLbto
         axzc6WNSQ+2Y6VXeeALcWnnn3UBhHgXxsJoRmUKIYqs1LV0q+ZHor5VOqYowdDidlUJt
         5MfcT/+4FnYYcF3IOYijjJohHZ92MuvlRlgLqrm4FFwhKeMnpfNHE6fFVVbbB8q6umtY
         x16Zm71JHF3yTWqgx3OIDlCbt6xcsXfwn2zghabNLxI3mThOhB1PB/IJevnkFoCzZzzw
         MfYw==
X-Forwarded-Encrypted: i=1; AJvYcCX20QREqMrJkJEQPZu9xlcctNpBFKgK9KeGYcHEKlNXeoRYG90rYd5QnR82wlN5F23ws4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpLpSy/i3y8H2AasEwJxjpgVTmZXDVZe6UdVqjqFR2VR5QAOwW
	M+uQ7Q01xEAbhwL4Rx6TgD/aK1rn8LyHXhc9rQcrnYXEY5OAKksxyg3rjtnxwQvGiTZx8NGbyVq
	Cy0NgZdc2UW2z1QLacGnyT1U55us=
X-Gm-Gg: ASbGncurbWhAR4AQwk5erhLK4/ZRLcTNfuMbVMmSOLCgLkRMCKf7J4eqjOpDO1u+V1W
	12kF1HFctuLM4pnJd1Ue0MsQ14gDqjO1gWyEO785rF4R0wmgScVa2WQ4QpNqvp2ym3hf3zsswj3
	Rv8GpkaDefIrq14Al75cZwkOkY7vpHd1SanMWUWXgjoBroP1c4gh9raHaHwJS+
X-Google-Smtp-Source: AGHT+IGTpzEQOUDAMaZWMfAMQ712CSfYwkC4uhF1VnA1fRmuIeB6vFwNxRyA2UehQS8ZwaX4NOLEbvBsaE3PGEwahww=
X-Received: by 2002:a05:6102:1481:b0:4c4:df5b:330f with SMTP id
 ada2fe7eead31-4c8554696f1mr8446340137.17.1743972520951; Sun, 06 Apr 2025
 13:48:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 6 Apr 2025 20:48:40 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 6 Apr 2025 20:48:40 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <874iz5f4i4.fsf@iotcl.com>
References: <20250401-488-generating-bundles-with-many-references-has-non-linear-performance-v1-0-6d23b2d96557@gmail.com>
 <20250401-488-generating-bundles-with-many-references-has-non-linear-performance-v1-2-6d23b2d96557@gmail.com>
 <874iz5f4i4.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 6 Apr 2025 20:48:40 +0000
X-Gm-Features: ATxdqUGK6dCLrCzn87hCF1Q2hren8GR9_rNXglC1uRIeLYraAgHufArrwp7_kLU
Message-ID: <CAOLa=ZRKP=g5vN9O+9-UfP8j1KNTQgj1we2qYkQe+3Z3uy3dQQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] bundle: fix non-linear performance scaling with refs
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: jltobler@gmail.com, ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000009c26b90632223ea3"

--0000000000009c26b90632223ea3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The 'git bundle create' command has non-linear performance with the
>> number of refs in the repository. Benchmarking the command shows that
>> a large portion of the time (~75%) is spent in the
>> `object_array_remove_duplicates()` function.
>>
>> The `object_array_remove_duplicates()` function was added in
>> b2a6d1c686 (bundle: allow the same ref to be given more than once,
>> 2009-01-17) to skip duplicate refs provided by the user from being
>> written to the bundle. Since this is an O(N^2) algorithm, in repos with
>> large number of references, this can take up a large amount of time.
>>
>> Let's instead use a 'strset' to skip duplicates inside
>> `write_bundle_refs()`. This improves the performance by around 6 times
>> when tested against in repository with 100000 refs:
>>
>> Benchmark 1: bundle (refcount =3D 100000, revision =3D master)
>>   Time (mean =C2=B1 =CF=83):     14.653 s =C2=B1  0.203 s    [User: 13.9=
40 s, System: 0.762 s]
>>   Range (min =E2=80=A6 max):   14.237 s =E2=80=A6 14.920 s    10 runs
>>
>> Benchmark 2: bundle (refcount =3D 100000, revision =3D HEAD)
>>   Time (mean =C2=B1 =CF=83):      2.394 s =C2=B1  0.023 s    [User: 1.68=
4 s, System: 0.798 s]
>>   Range (min =E2=80=A6 max):    2.364 s =E2=80=A6  2.425 s    10 runs
>>
>> Summary
>>   bundle (refcount =3D 100000, revision =3D HEAD) ran
>>     6.12 =C2=B1 0.10 times faster than bundle (refcount =3D 100000, revi=
sion =3D master)
>
> That's a good find!
>
>> Previously, `object_array_remove_duplicates()` ensured that both the
>> refname and the object it pointed to were checked for duplicates. The
>> new approach, implemented within `write_bundle_refs()`, eliminates
>> duplicate refnames without comparing the objects they reference. This
>> works because, for bundle creation, we only need to prevent duplicate
>> refs from being written to the bundle header. The `revs->pending` array
>> can contain duplicates of multiple types.
>
> Makes sense to me.
>
>> First, references which resolve to the same refname. For e.g. "git
>> bundle create out.bdl master master" or "git bundle create out.bdl
>> refs/heads/master refs/heads/master" or "git bundle create out.bdl
>> master refs/heads/master". In these scenarios we want to prevent writing
>> "refs/heads/master" twice to the bundle header. Since both the refnames
>> here would point to the same object (unless there is a race), we do not
>> need to check equality of the object.
>
> Yeah, we can never be sure about the changes that happen while the
> bundle is being created. I fixed another race[1] recently which also was
> comparing equality of the object, that causes the ref to be omitted. We
> can only act by "best effort" and having the ref point to /some/ object
> is the best we can do.
>
> [1]: https://lore.kernel.org/git/20241211-fix-bundle-create-race-v3-1-058=
7f6f9db1b@iotcl.com/
>
>> Second, refnames which are duplicates but do not point to the same
>> object. This can happen when we use an exclusion criteria. For e.g. "git
>> bundle create out.bdl master master^!", Here `revs->pending` would
>> contain two elements, both with refname set to "master". However, each
>> of them would be pointing to an INTERESTING and UNINTERESTING object
>> respectively. Since we only write refnames with INTERESTING objects to
>> the bundle header, we perform our duplicate checks only on such
>> objects.
>
> Thanks for that context, I didn't consider that.
>

I didn't at first, but luckily we have a test for such refs, which got
tripped and allowed me to consider that scenario too!

>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  bundle.c               | 10 +++++++++-
>>  object.c               | 33 ---------------------------------
>>  object.h               |  6 ------
>>  t/t6020-bundle-misc.sh |  4 ----
>>  4 files changed, 9 insertions(+), 44 deletions(-)
>>
>> diff --git a/bundle.c b/bundle.c
>> index d7ad690843..30cfba0be2 100644
>> --- a/bundle.c
>> +++ b/bundle.c
>> @@ -384,6 +384,9 @@ static int write_bundle_refs(int bundle_fd, struct r=
ev_info *revs)
>>  {
>>  	int i;
>>  	int ref_count =3D 0;
>> +	struct strset objects;
>> +
>> +	strset_init(&objects);
>
> Any reason why you're not using the `STRMAP_INIT` macro?
>

None. This should be the ideal way to do it, will change in the next
version.

>>
>>  	for (i =3D 0; i < revs->pending.nr; i++) {
>>  		struct object_array_entry *e =3D revs->pending.objects + i;
>> @@ -401,6 +404,9 @@ static int write_bundle_refs(int bundle_fd, struct r=
ev_info *revs)
>>  			flag =3D 0;
>>  		display_ref =3D (flag & REF_ISSYMREF) ? e->name : ref;
>>
>> +		if (strset_contains(&objects, display_ref))
>> +			goto skip_write_ref;
>> +
>>  		if (e->item->type =3D=3D OBJ_TAG &&
>>  				!is_tag_in_date_range(e->item, revs)) {
>>  			e->item->flags |=3D UNINTERESTING;
>> @@ -423,6 +429,7 @@ static int write_bundle_refs(int bundle_fd, struct r=
ev_info *revs)
>>  		}
>>
>>  		ref_count++;
>> +		strset_add(&objects, display_ref);
>>  		write_or_die(bundle_fd, oid_to_hex(&e->item->oid), the_hash_algo->hex=
sz);
>>  		write_or_die(bundle_fd, " ", 1);
>>  		write_or_die(bundle_fd, display_ref, strlen(display_ref));
>> @@ -431,6 +438,8 @@ static int write_bundle_refs(int bundle_fd, struct r=
ev_info *revs)
>>  		free(ref);
>>  	}
>>
>> +	strset_clear(&objects);
>> +
>>  	/* end header */
>>  	write_or_die(bundle_fd, "\n", 1);
>>  	return ref_count;
>> @@ -566,7 +575,6 @@ int create_bundle(struct repository *r, const char *=
path,
>>  	 */
>>  	revs.blob_objects =3D revs.tree_objects =3D 0;
>>  	traverse_commit_list(&revs, write_bundle_prerequisites, NULL, &bpi);
>> -	object_array_remove_duplicates(&revs_copy.pending);
>>
>>  	/* write bundle refs */
>>  	ref_count =3D write_bundle_refs(bundle_fd, &revs_copy);
>> diff --git a/object.c b/object.c
>> index 100bf9b8d1..a2c5986178 100644
>> --- a/object.c
>> +++ b/object.c
>> @@ -491,39 +491,6 @@ void object_array_clear(struct object_array *array)
>>  	array->nr =3D array->alloc =3D 0;
>>  }
>>
>> -/*
>> - * Return true if array already contains an entry.
>> - */
>> -static int contains_object(struct object_array *array,
>> -			   const struct object *item, const char *name)
>> -{
>> -	unsigned nr =3D array->nr, i;
>> -	struct object_array_entry *object =3D array->objects;
>> -
>> -	for (i =3D 0; i < nr; i++, object++)
>> -		if (item =3D=3D object->item && !strcmp(object->name, name))
>> -			return 1;
>> -	return 0;
>> -}
>> -
>> -void object_array_remove_duplicates(struct object_array *array)
>> -{
>> -	unsigned nr =3D array->nr, src;
>> -	struct object_array_entry *objects =3D array->objects;
>> -
>> -	array->nr =3D 0;
>> -	for (src =3D 0; src < nr; src++) {
>> -		if (!contains_object(array, objects[src].item,
>> -				     objects[src].name)) {
>> -			if (src !=3D array->nr)
>> -				objects[array->nr] =3D objects[src];
>> -			array->nr++;
>> -		} else {
>> -			object_array_release_entry(&objects[src]);
>> -		}
>> -	}
>> -}
>> -
>>  void clear_object_flags(unsigned flags)
>>  {
>>  	int i;
>> diff --git a/object.h b/object.h
>> index 17f32f1103..0e12c75922 100644
>> --- a/object.h
>> +++ b/object.h
>> @@ -324,12 +324,6 @@ typedef int (*object_array_each_func_t)(struct obje=
ct_array_entry *, void *);
>>  void object_array_filter(struct object_array *array,
>>  			 object_array_each_func_t want, void *cb_data);
>>
>> -/*
>> - * Remove from array all but the first entry with a given name.
>> - * Warning: this function uses an O(N^2) algorithm.
>
> Funny this has been here for more than 10 years. Thanks for this cleanup.
>
>> - */
>> -void object_array_remove_duplicates(struct object_array *array);
>> -
>>  /*
>>   * Remove any objects from the array, freeing all used memory; afterwar=
ds
>>   * the array is ready to store more objects with add_object_array().
>> diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
>> index dd09df1287..500c81b8a1 100755
>> --- a/t/t6020-bundle-misc.sh
>> +++ b/t/t6020-bundle-misc.sh
>> @@ -684,7 +684,6 @@ test_expect_success 'create bundle with duplicate re=
fnames' '
>>  	test_cmp expect actual
>>  '
>>
>> -# This exhibits a bug, since the same refname is now added to the bundl=
e twice.
>>  test_expect_success 'create bundle with duplicate refnames and --all' '
>>  	git bundle create out.bdl --all "main" "main" &&
>>
>> @@ -701,7 +700,6 @@ test_expect_success 'create bundle with duplicate re=
fnames and --all' '
>>  	<TAG-2> refs/tags/v2
>>  	<TAG-3> refs/tags/v3
>>  	<COMMIT-P> HEAD
>> -	<COMMIT-P> refs/heads/main
>>  	EOF
>>  	test_cmp expect actual
>>  '
>> @@ -717,7 +715,6 @@ test_expect_success 'create bundle with duplicate ex=
lusion refnames' '
>>  	test_cmp expect actual
>>  '
>>
>> -# This exhibits a bug, since the same refname is now added to the bundl=
e twice.
>>  test_expect_success 'create bundle with duplicate refname short-form' '
>>  	git bundle create out.bdl "main" "main" "refs/heads/main" "refs/heads/=
main" &&
>>
>> @@ -725,7 +722,6 @@ test_expect_success 'create bundle with duplicate re=
fname short-form' '
>>  		make_user_friendly_and_stable_output >actual &&
>>  	cat >expect <<-\EOF &&
>>  	<COMMIT-P> refs/heads/main
>> -	<COMMIT-P> refs/heads/main
>>  	EOF
>>  	test_cmp expect actual
>>  '
>
> Great work on the alternative implmentation. And thanks for adding these
> tests and actually fixing them. I've been manually testing a few more
> edge cases, I couldn't find any other scenario that's not covered by the
> current implementation.
>
> I approve.
>
> --
> Toon

Appreciate you taking the time and exploring all scenarios. Thanks for
the review.

Karthik

--0000000000009c26b90632223ea3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 370c45f83c53f5e1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1meTZLSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK091Qy85NTk4TDRlR1ZWaGthSVl3ai9vOG9YdWNmeAoyL1JZa1NMa0k4
ek93ejlKZjdCRzZ6a0NZWlNTRDhKRitWZEFUNEQwUWt3aE1oVE1BWUVUSGJ1WXpYNXQrRlRKCmxj
M3N2bEJ0dUFLTU9SSTRyQ3dvR1FKZk53SWN1SmxIM0hKVTFqVU5hRERSVFMxQUhnY1EyZms5WkFn
eXAzZTQKQ29VN0tFRjhqOE4yKzVJTi85OFBrVTFrVnJyMVJOQ0c4cXVnZ3pIUmtWRU1KOVlUVENx
YS9FdFkyRnZVOUxqeQp1NHVGaW5IRGd2eW5VVXgzWHhuUHpkOWZldXc3eVV5RWVaMXg2SmVQamcw
ZGErZ0J6M01CVWtyWmhINzc0L24rCmRibnlhaGQrWXpyOU15MTRlQTMxckZpYWxnZUFYemN6cDBp
WTQ1VkY0MUs0REgydklzTjNpYVhHMTRJSWlJOUoKNzFYU0tBTGRFUG1Na2hUMVlvbno1S2s3eGlv
WFBCY0d1MEs0UnRZQWlxOG1CdzRPbFZEYU83L0dueUtieDdsSApwSG9HRUZHZER4OG1SRDUxVUVo
MnZrcHRMMHdNNDFlSERMVU5DWnZLQ3k3aU9RVjBSOEIwOXM3MXhIdzdyNllLCmphMnVIL1ZBRVFJ
VE5GZkdpNnY3dWRxa1lmRFV6Y0c4cVMxSi9OQT0KPUQvS1IKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009c26b90632223ea3--
