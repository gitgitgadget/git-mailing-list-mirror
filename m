Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723632E1742
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756895888; cv=none; b=Z+hr/cZx1juEF+BErM7t4x03xGzCEn6UJb8p4G/jv6YJl0lmDXI1g6iO4aNufDvoKvM4644xYWH+aknxc7l4yPEsuSyZMnj8wKePdICGt5Cg0sFnKovyZfGJLpiRjVECl8x5exgilC1dtVa25omZ8WGZg/f5FLRj3uyGC8iSOM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756895888; c=relaxed/simple;
	bh=8JQ05KpCUMDnCzqt8judv4mwpGtdzYGzbGPnzODbGUk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCWleIf+gO1T3MDwm84mqSHAMifAYQdG3PLA/DtDLEKblqJSoLP03Mq47p0g/jCCz8k//6SRPjfL4zyI6BS90Oc0HGzMeF4bpUu9sd6rxFrqqF8bmVGZKe09HDnfP5sPelah1ykT2QzezBlVpnH8Rm7y+L7Fy7dIkSMLItTJFzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldBNbj1N; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldBNbj1N"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-50f8bf5c518so4046258137.3
        for <git@vger.kernel.org>; Wed, 03 Sep 2025 03:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756895885; x=1757500685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nu+3kX65aBPE6mB+g32p+71cQmcU2Ji5M9vcOQx5Mh4=;
        b=ldBNbj1NHO3MHKnCE/36JrjVWhZifK6Qv2NFrTpz+lV4BitymKdt1LyPGn1yt9R1Qt
         MhIBDZrhrKlRx+nDr9qi7v2PvIlcgEa26HrcaQ+NGq4kL0sq5FstZEroldoYJrFax90c
         EI92+z/eq9qqdVM3GfypTmXcaTrQEjHi4i6yB3t+A3seVrxQd+Ig0N89a47IJ5UrzW58
         je0obpqbsecQEyok+fGFpd8VKqnFrmrMqvntcXzEY5F+H3zl8islA+ZJIOnGYp6KAbkO
         fgSMMQSCeIlXlarx49h+LTY0B4cEs9EFwAo+/O1cawj8foJ2zztEUY4S5s8aVpqs2OEW
         4pmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756895885; x=1757500685;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nu+3kX65aBPE6mB+g32p+71cQmcU2Ji5M9vcOQx5Mh4=;
        b=uYrYFv6DCP9WS0KUUVe07eGdPnkLR8F3ATpMxO5uRa2hQswOx4aH90fxS02TfdE5WU
         RrTqIRymghx0TNy0e4XWWYhxhIB/LVIspdeSLGGt9dU1PeN4D7xH7KGd0gSnV74LhdHd
         GUHpNX4qSl04CN9HMNJYDJLgTUNuXd8VHKmGzx3pOIR89Pggf3kYKd+621dlG4oOMe5t
         lvmAhlFJp8K0nNJ9n+kKdSumdro14TycYknhIr/MFs1QYuk/GVlhX5hZ7Rc265Pl3q/E
         VRXSd3WhPTNdts0eLvIJRdZSD2bMNcGyNY7EYdbTVsQcbZyiM/38e5etn8N5R1b5IU5T
         TErw==
X-Gm-Message-State: AOJu0Yx9WY5+s+DUUHkRZfeluWalYFfOdd96kqMAiuulthTYUAJrYixB
	rkQ0ipKiL7tvXQSgkqZx2RKS1cHX7TeDInKDMcfhKOfzQbg/3vTGdSZs0ya3HL52oEgJXUt6y/M
	1HuIVOmtJnL/JhymFDyL+Y8vRKDcjhR4=
X-Gm-Gg: ASbGncsBJhRIN+MpRd67f7MN0WosrgtlGdrbcW538QQM+BLCb7CUL6hOeCei9JJKu0/
	c+bLoVuo35Y5PVHDp34vsTWJLCQW2AcXyB8JGIGwYltZsed766R8tBGkr82/AA3qZUeHXs54qf5
	nnYRV4mcOEwQxry9gIaGeTInY10g2cgmMs+8WqvRSUgcdbvavknp5xZELlrzXXOP9VHnd9zT7uP
	/g3ElJnX1hfe8SCVxLx8dQ6natk0/wjSI/4t2e02FzDhQ2co+NP
X-Google-Smtp-Source: AGHT+IHLJaFHFBEQTUQQLeLxB3G1NDUVC4RxpoQ8khtZe4QJcAD638zJPataFFksodnae/d5i/onJcHr7VthgxtZ3K0=
X-Received: by 2002:a05:6102:802a:b0:534:cfe0:f85b with SMTP id
 ada2fe7eead31-534cfe1065fmr382519137.20.1756895885200; Wed, 03 Sep 2025
 03:38:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Sep 2025 03:38:04 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Sep 2025 03:38:04 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aLfw8xiys53A-azC@pks.im>
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
 <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-1-35e69bbb507d@gmail.com>
 <aLfw8xiys53A-azC@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 3 Sep 2025 03:38:04 -0700
X-Gm-Features: Ac12FXxR56ybNkUzlHicaS-CiYhBIf4NBIJ9xbOpW7I5vJeIgtTKG3wU4p7S8DY
Message-ID: <CAOLa=ZTxZXWuFxaTWXmVpfoFjao_F0Mcu469aKQRu5fNNB0KEA@mail.gmail.com>
Subject: Re: [PATCH 1/2] refs/files: use correct error type when locking fails
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, joe.drew@indexexchange.com, peff@peff.net, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000252d02063de33330"

--000000000000252d02063de33330
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Sep 02, 2025 at 10:34:25AM +0200, Karthik Nayak wrote:
>> During the 'prepare' phase of reference transaction in the files
>> backend, we create the lock files for references to be created. When
>> using batched updates on case-insensitive filesystems, the transactions
>> would be aborted if there are conflicting names such as:
>>
>>   refs/heads/Foo
>>   refs/heads/foo
>>
>> This affects all commands which were migrated to use batched updates in
>> Git 2.51, including 'git-fetch(1)' and 'git-receive-pack(1)'. Before
>> that, references updates would be applied serially with one transaction
>
> s/references/reference/
>
>> used per update. When users fetched multiple references on
>> case-insensitive systems, subsequent references would simply overwrite
>> any earlier references. So when fetching:
>>
>>   refs/heads/foo: 5f34ec0bfeac225b1c854340257a65b106f70ea6
>>   refs/heads/Foo: ec3053b0977e83d9b67fc32c4527a117953994f3
>>   refs/heads/sample: 2eefd1150e06d8fca1ddfa684dec016f36bf4e56
>>
>> The user would simply end up with:
>>
>>   refs/heads/foo: ec3053b0977e83d9b67fc32c4527a117953994f3
>>   refs/heads/sample: 2eefd1150e06d8fca1ddfa684dec016f36bf4e56
>>
>> This is buggy behavior since the user is never intimated about the
>> overrides performed and missing references. Nevertheless, the user is
>> left with a working repository with a subset of the references. Since
>> Git 2.51, in such situations fetches would simply fail without applying
>> any references. Which is also buggy behavior and worse off since the
>> user is left without any references.
>
> Yup, agreed.
>
>> The error is triggered in `lock_raw_ref()` where the files backend
>> attempts to create a lock file. When a lock file already exists the
>> function returns a 'REF_TRANSACTION_ERROR_GENERIC'. Change this to return
>> 'REF_TRANSACTION_ERROR_CREATE_EXISTS' instead to aid the batched update
>> mechanism to simply reject such errors.
>>
>> This bubbles the error type up to `files_transaction_prepare()` which
>> tries to lock each reference update. So if the locking fails, we check
>> if the rejection type can be ignored, which is done by calling
>> `ref_transaction_maybe_set_rejected()`.
>>
>> As the error type is now 'REF_TRANSACTION_ERROR_CREATE_EXISTS', the
>> specific reference update would simply be rejected, while other updates
>> in the transaction would continue to be applied. This allows partial
>> application of references in case-insensitive filesystems when fetching
>> colliding references.
>
> Okay. Does that mean that both git-fetch(1) and git-receive-pack(1) are
> already told to evict unsuccessful updates? If so, this bit of info
> should probably be added to the commit message to say that it was
> already the intent, but that it didn't work out because of the
> unexpected error type.
>
>> While the earlier implementation allowed the last reference to be
>> applied overriding the initial references, this change would allow the
>> first reference to be applied while rejecting consequent collisions.
>> This should be an OKAY compromise since with the files backend, there is
>
> I don't quite get why we're shouting :) In any case I think the
> compromise is acceptable, but we very much should warn the user about
> this error. Ideally, we'd even guide them towards the reftable backend.
> But let's read on, maybe you already do that.
>

Let me remove that shout :D

>> no scenario possible where we would retain all colliding references.
>>
>> The change only affects batched updates since batched updates will
>> reject individual updates with non-generic errors. So specifically this
>> would only affect:
>>
>>     1. git fetch
>>     2. git receive-pack
>>     3. git update-ref --batch-updates
>
> Okay, here you mention that we already use batched updates for those
> commands. I think it would help the reader if this was explained before
> going into the individual error codes.
>

Yeah it would read better earlier on, let me move it around.

>> Let's also be more pro-active and notify users on case-insensitive
>> filesystems about such problems by providing a brief about the issue
>> while also recommending using the reftable backend, which doesn't have
>> the same issue.
>
> And yup, you already do exactly what I was proposing. Nice!
>

It was copied from your suggestion!

>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index 24645c4653..9563abbe12 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -1643,7 +1643,8 @@ static int set_head(const struct ref *remote_refs, struct remote *remote)
>>
>>  struct ref_rejection_data {
>>  	int *retcode;
>> -	int conflict_msg_shown;
>> +	bool conflict_msg_shown;
>> +	bool case_sensitive_msg_shown;
>>  	const char *remote_name;
>>  };
>>
>> @@ -1657,11 +1658,25 @@ static void ref_transaction_rejection_handler(const char *refname,
>>  {
>>  	struct ref_rejection_data *data = cb_data;
>>
>> -	if (err == REF_TRANSACTION_ERROR_NAME_CONFLICT && !data->conflict_msg_shown) {
>> +	if (err == REF_TRANSACTION_ERROR_CREATE_EXISTS && ignore_case &&
>> +	    !data->case_sensitive_msg_shown) {
>> +		error(_("You're on a case-insensitive filesystem, and the remote you are\n"
>> +			"trying to fetch from has references that only differ in casing. It\n"
>> +			"is impossible to store such references with the 'files' backend. You\n"
>> +			"can either accept this as-is, in which case you won't be able to\n"
>> +			"store all remote references on disk. Or you can alternatively\n"
>> +			"migrate your repository to use the 'reftable' backend with the\n"
>> +			"following command:\n\n    git refs migrate --ref-format=reftable\n\n"
>> +			"Please keep in mind that not all implementations of Git support this\n"
>> +			"new format yet. So if you use tools other than Git to access this\n"
>> +			"repository it may not be an option to migrate to reftables.\n"));
>
> This reads familiar :)
>

Which I failed to attribute to you, sorry for missing that, will add in
a 'Helped-by'.

>> +		data->case_sensitive_msg_shown = true;
>> +	} else if (err == REF_TRANSACTION_ERROR_NAME_CONFLICT &&
>> +		   !data->conflict_msg_shown) {
>>  		error(_("some local refs could not be updated; try running\n"
>>  			" 'git remote prune %s' to remove any old, conflicting "
>>  			"branches"), data->remote_name);
>> -		data->conflict_msg_shown = 1;
>> +		data->conflict_msg_shown = true;
>>  	} else {
>>  		const char *reason = ref_transaction_error_msg(err);
>>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 088b52c740..9f58ea4858 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -776,6 +776,8 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
>>  			goto retry;
>>  		} else {
>>  			unable_to_lock_message(ref_file.buf, myerr, err);
>> +			if (myerr == EEXIST)
>> +				ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
>>  			goto error_return;
>>  		}
>>  	}
>
> This here is the actual bug fix that makes us treat the error
> gracefully.
>
>> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
>> index 96648a6e5d..e37a5d83e8 100755
>> --- a/t/t1400-update-ref.sh
>> +++ b/t/t1400-update-ref.sh
>> @@ -2294,6 +2294,30 @@ do
>>  		)
>>  	'
>>
>> +	test_expect_success CASE_INSENSITIVE_FS,REFFILES "stdin $type batch-updates existing reference" '
>> +		git init repo &&
>> +		test_when_finished "rm -fr repo" &&
>> +		(
>> +			cd repo &&
>> +			test_commit one &&
>> +			old_head=$(git rev-parse HEAD) &&
>> +			test_commit two &&
>> +			head=$(git rev-parse HEAD) &&
>> +
>> +			format_command $type "create refs/heads/foo" "$head" >stdin &&
>> +			format_command $type "create refs/heads/ref" "$old_head" >>stdin &&
>> +			format_command $type "create refs/heads/Foo" "$old_head" >>stdin &&
>
> These could be written as:
>
>     {
>         format_command $type "create refs/heads/foo" "$head" &&
>         format_command $type "create refs/heads/ref" "$old_head" &&
>         format_command $type "create refs/heads/Foo" "$old_head"
>     } >stdin
>

That reads much better, thanks.

>> +			git update-ref $type --stdin --batch-updates <stdin >stdout &&
>> +
>> +			echo $head >expect &&
>> +			git rev-parse refs/heads/foo >actual &&
>> +			echo $old_head >expect &&
>> +			git rev-parse refs/heads/ref >actual &&
>> +			test_cmp expect actual &&
>> +			test_grep -q "reference already exists" stdout
>> +		)
>> +	'
>> +
>>  	test_expect_success "stdin $type batch-updates delete incorrect symbolic ref" '
>>  		git init repo &&
>>  		test_when_finished "rm -fr repo" &&
>
> We could think about making these tests not depend on the REFFILES
> prerequisite and then verify that with the reftable backend things work
> as expected.
>
> Patrick

That would be a good test to add, will add it in the next version.

--000000000000252d02063de33330
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9f73960330b085ee_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pNEdvb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNmJhQy80ajZmUnhRMWhzMmkwRzBnZ0ZXU3l4Q2xORApuQkpZQk0wT3Jp
RWZwcFc4S2NDSzVLT0xZeVhaNzdici9zOUk0VE5YTmR6bG5FQ1ZxZHA3NnBhZmRnOWhKcVVFCitV
RjlROHdaWFhOOEFTV0J6c3RmYWdZd05FVDdPa0lsNHVOdHdTdmQ0V0JwSExKQWtzVWZ4bUdOSGZR
UUg2b1YKUlVJVFBvNmkxWDM5c0JnTHBabWk1MUNrbWM5NURvZ054SkR4MUFPcnpVTlZpVzVpQ2hX
T2VqaSs1aCtwdmJoZwpPcmROQnFZN3FzTktOcHhGSkg5Sk1OV1hhL2VaamNYZGpQQ3A4SkozaDdv
SGdBR1hWdnk1Y0hFWDhrRDNMSGN3CnE3b1loYmVhSmRhTXhkSzNaNU1leEg1eU5SVzlFcStqY0gx
eWMxamZQRzVDeXhuVGF5Sk9LZE9JVG5XRFdOQzQKY2ZPVHZ5R29xM0hCTmxWVnpHdTRKdTlEMk54
SWpoZkp3UkZ3cnNpZnF3bFRWbFo2RDJIUUdoN1JtUzJXdUdIZwoxVUpJMUxHMVAvMm5MUTlvQWhX
RFZCT0pvanM5dE9BZmQveE53dVd2eGpPQ2ZML2dYaFVpN0RXQ2lEcERNN25CCldSTjIraHVDdWVT
dUJQQ0QzUGphYno2TmVLMTEweUJJaktVbVRYaz0KPXR0dFEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000252d02063de33330--
