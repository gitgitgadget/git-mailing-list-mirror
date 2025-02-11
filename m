Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786BB1D8DE4
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 06:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739254738; cv=none; b=rHlIykY7SndXCHM3fJPvswjQzIEMSEnUK1zJTlj7iacUwHs5gWdzuuPcvIh+tf3f54JU46TjBpt/KfQ6sSPrzB5kO5Tq2gMtsX5W5yhgr04WD40nOy4xxCeckndsIpHA9Gre3hJFd/8sA/7HAZMUVIAvVVL+c3OdtefsRODDwk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739254738; c=relaxed/simple;
	bh=P56wBWmpCovypWxFb3j6Tb0EJOuCqtGt7BfkOKtb1ac=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDzjg9ACvyMlQbGcOabSUiC+FJPjC7Fwwi2Rsy5kDMck20Ullc9DlpWLRmSxkM1gfePtsegG6V/Yi0Uu8je4Ou+r1fbfHKtgoImngrpKrV++QD1TLZERI/9MWsMZbWLAyxFBlixyuhfWdrhai6HkFloZ1xeguF0XSVRBxTn2oYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzGCszbX; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzGCszbX"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4bbeb009101so5780137.1
        for <git@vger.kernel.org>; Mon, 10 Feb 2025 22:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739254735; x=1739859535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mgnt9aaeA0rv49LgdGP9EXLiu5SulAbDJ/SCAXiZ4w8=;
        b=gzGCszbXUAi0Iffs/0AFhBizRY2JXfgHo+8xd69F18Q4zufZVVCVFhQAAanngbnHfe
         U0ezp2HFoq96B9MvW66VPbm4VyklUqUk6ZfMJbbyqObhKvURVIiZmuX1+51EaezaJhf7
         KWr7PYacCX8N5DHvs+mr+APEkUrStdms+UvjiqmIxbxyGbduhKgWheVVtKQ3bUjPV6wD
         0DF1xc6vDkuVffmwY2ypJrpN8d4Ap33oBvTFRFb3uTT+KvmhqzSyCQOwVgyL6PZF46YH
         omy3SKSg/PoDk8Fm0btQKIq6TCD4b7n1xxH8+PRamC4z8MlhYdTOF/p+pVnWZr4rtPhM
         /EGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739254735; x=1739859535;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mgnt9aaeA0rv49LgdGP9EXLiu5SulAbDJ/SCAXiZ4w8=;
        b=P/VijZWyz1gt43RsKWMYDS+moL1aX0QZy0pTlTDdw3QfEGupp9lw1DMeQ7gSQa5FT5
         842vD01ASTRXktt3dTO9DiCBY+4LX+t/oDiy+orSEEY9a2YADwKAanDp0Wb/+3LrgW1y
         0GzdzLQE1jjvnGTjpU3V01SWRrbJRdUqB60XW9X7UR2bmydbXxmra2ihF/FgJXI4ruSy
         rpEiwC9gLA8nYqZbM8KcXcPb//F5Xb+r7bvT0TEr78dmILFKm9Zo/AedFFYBM8oG16c8
         j/XfCvsd0HaUkgba8TrTKHnlH+v5coHsOaQ3NFFizDqX6xD5DG0rulgoMr5S63p66Bpp
         qjqA==
X-Gm-Message-State: AOJu0Yxz4Ea8Bw5KfcqFPvYhKZJtaTA5C0ozSejeluFZCW4J8c7lT68H
	RIsEp4SWpPTJ+sR4RPuP/OGeOFAhbmomGxvuqS/NFF35XkzFkcx3ZYFkVlMQAidFzQrit4RMoXz
	5MXAe57owMyHzkpq4KkXwrih+SFwlAV/5
X-Gm-Gg: ASbGncubcgVuZBfwu+egItIEAaeYQApAYESIyloY61dZgYcc7hffSg+wt3lAxSjR35z
	aRpmZpbL1Xa0/B3gw57gQgclY1CJKROqS8zmoPr04FYugPB/bhI5dsp81IeF0vm26gJNfu8MZg9
	3Ti3WjH2o4brXoTTn0zkAMRGt10laJXA==
X-Google-Smtp-Source: AGHT+IFEd4uDRkQat88qf7eTjJHI40ssbrCoBrZYVp7qtxZkZDpcCaMwPaJAbyYrollFW4BHJZo7vvE7LrI920AkJ8U=
X-Received: by 2002:a05:6102:372:b0:4ba:971a:41fd with SMTP id
 ada2fe7eead31-4ba971a441amr7487456137.19.1739254735145; Mon, 10 Feb 2025
 22:18:55 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Feb 2025 22:18:54 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z6YlcpKp2U2V8Yd3@pks.im>
References: <20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v1-1-7d40f3b4e30b@gmail.com>
 <Z6YlcpKp2U2V8Yd3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Feb 2025 22:18:54 -0800
X-Gm-Features: AWEUYZkMyTBTeor1lRUf5FyxOQQEFBmGhgsMx2JyG_AuqdRSXIPWPW0cFgY-_Sw
Message-ID: <CAOLa=ZQX1mZD+iegnezObmJrFy+Zer4CgHTrQz=-SbgHeTfN=g@mail.gmail.com>
Subject: Re: [PATCH] builtin/refs: add '--skip-reflog' flag to bypass reflog migration
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a9ae0e062dd7cc6f"

--000000000000a9ae0e062dd7cc6f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Feb 07, 2025 at 12:57:31PM +0100, Karthik Nayak wrote:
>> The 'git-refs(1)' migrate subcommand, which transfers repositories
>> between reference backends, currently migrates reflogs by default as of
>> In 246cebe320 (refs: add support for migrating reflogs, 2024-12-16).
>
> s/In//
>
>> While this behavior is desirable for most client-side repositories,
>> server-side repositories typically don't use reflogs and the migration
>> of these entries is unnecessary overhead.
>
> Nit: if the server-side repository doesn't _have_ reflogs, then there
> cannot be any overhead caused by their migration either, right? I still
> think that the flag makes sense (well, I proposed it). But to me the
> argument is rather that we don't _expect_ there to be any reflogs, but
> due to historic reasons there actually _might_ be some. This could for
> example be caused by a bugs, misconfiguration, or an admin who has
> enabled reflogs on the server-side to debug something.
>
> So even if there are some reflogs, we don't want to migrate them. Which
> coincidentally helps us to improve performance, but the real value-add
> here is that it makes the result match our expectations.
>

Fair enough, I agree that, finally, we mostly care about not having
reflogs in the end. I'll modify accordingly.

>> Add a '--skip-reflog' flag to the migrate subcommand to make reflog
>> migration optional. This is particularly useful for server-side
>> migrations where reflogs are not needed, improving migration performance
>> in these scenarios.
>
> The second sentence of this paragraph feels duplicated with what you
> have already been saying in the preceding paragraph.
>

Will cleanup.

>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> ---
>
> Another thing to teach b4: skip the comment in a single-patch patch
> series in case you don't supply a cover letter :)
>

True. I think this is because of lack of conditionals in the templating.

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
>
> Nice and simple, as expected.
>
>> diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
>> index a6d9b35a46eb59350aa0d59d982a2fbfaecf1448..9059d4c4121842a9d2e77dc4e54c537eeff8afab 100755
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
>>  test_migration () {
>>  	repo=$1 &&
>>  	format=$2 &&
>>  	skip_reflog_verify=${3:-false} &&
>> +	shift $(( $# >= 3 ? 3 : 2 )) &&
>
> I honestly have no idea whether this works with all supported shells. If
> it does it's a bit funky, but should work alright for our purpose. I was
> thinking a bit about how to improve this, but ultimately came to the
> conclusion that there isn't really a need to overengineer this simple
> test function.
>

I was skeptical too, while not a complete test, the CI seemed to not
complain.

>> @@ -241,6 +243,17 @@ do
>>  				test_cmp expect.reflog actual.reflog
>>  			)
>>  		'
>> +
>> +		test_expect_success "$from_format -> $to_format: skip reflog with --skip-reflog" '
>> +			test_when_finished "rm -rf repo" &&
>> +			git init --ref-format=$from_format repo &&
>> +			test_commit -C repo initial &&
>> +			# we see that the repository contains reflogs.
>> +			test 2 = $(git -C repo reflog --all | wc -l) &&
>
> Nit: we don't want to have Git on the left-hand side of a pipe, as it
> might make use lose its exit code. This could instead be:
>
>     git -C repo reflog --all >reflogs &&
>     test_line_count = 2 reflogs
>

This looks cleaner.

>> +			test_migration repo "$to_format" true --skip-reflog &&
>> +			# there should be no reflogs post migration.
>> +			test 0 = $(git -C repo reflog --all | wc -l)
>
> And here we could use `test_must_be_empty`.
>

Will amend, Thanks for the review.

> Thanks!
>
> Patrick

--000000000000a9ae0e062dd7cc6f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 39bc77f030a65337_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lcTY4d1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL2orREFDZFNtM2VuR1B2U1AvSXMzSFE2RXV3RThHWApLZnUxU3RDa0hX
a1J0MmhDRG05bmJvN2R0dEZTcVlUWG1aNE9vc3FBcUtyU1p2YkllMHpwT0lSOXQ4aEYzajFJCmVU
NkxldzcveVFKaEcyNWUxZmlzUGswUkdNamo4VEU2OUpsSlBmQTA0ZHR1TWNnbTVHTTVGQnRaNzZ0
QVpEN1gKSFlIamhHT3RDTGVIYmpEcFZMY3l5ZHluWTFwMDdoTll3U1REdC9FMXZZR2N2MDMrQmFI
Q1doNU9wRnpkaHdiNApSNGVhbFdzSTVNTU5VcTRUdTB4RFFqVVI1UDA4dDdCRkhPb3JUenhub0RX
MGIyTVJZUk1XVlZKYXQzSmYvblBKCnhQOWVDQkJ1MkdiYVY2ZXhEclUzUmZzTnpPRDRHR1RkR3JB
eTJxSzBlUERqaXM2N2t5a1cyb3ljOUVOaGRrR28KZkFOY0tvWHRUQk1wV29sNFdadlllVkcyY2x5
UXcvUnloZXd0bUlWZHdwRDlXRDY4NkdmTG8waFJObGwyNFpuZQowM3pSbEpwUStNdFZZMkFmeWV4
SWdnVXNUTFRudHhHVTg0cWVqZytMQ0xaaUVjV1BoNU1yMGY5TTRLUnZpOEx1CkVSbUQ0aXBNbG5U
TnRKNG1NSDFhME1FbjBvcmlXNG15WUtCUFpaVT0KPTR2U0EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a9ae0e062dd7cc6f--
