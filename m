Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C40638DD1
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748868377; cv=none; b=Xkz2X7Qhltt0pkBOoxbv1T7KoHWlyxabIrEGGtDrT8qNy4NRKuAU6wo8y/7E0tlR+68ITPSqedKwBrGPtwUP9nGjbuXoB/EWtuzUmoRJQN2aEbIclJr4BpwPUxBa9Ohaji3bGb2RtsXDZc90IA/8r1hdOEX9XOVZgmQvpoFQbFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748868377; c=relaxed/simple;
	bh=6cLzA8NlcPc9huSzQtEqb4WiUhyuhS5CV8PvewRinmY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKpjSArH0bAlc+GSqAn/9H7Ir3HSuWJwH/YM1uOCr0RiET90QWazUJNeForqAOo6N9+FWVwCDugWKyC3cP6aeb9Zh9dZLGs4+QWxWQ0NlmvjgsF390EC09RPZnLgClqw2JJvM6dGm8esI9pxGTnBKh9WM+iOIVNuA1zWSUG3OWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASaQVjzI; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASaQVjzI"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-53082f1ac34so979977e0c.3
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 05:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748868374; x=1749473174; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3yh06rFuYJ7CCM+FNSayBVkJZKoMTytyJASLK51mkYA=;
        b=ASaQVjzI14pRWDRr7YNBIQh5O0eTmoy/kPPQhcTVy7hkE/EFphlmR4kkmXmO19LW6Z
         RkT3tQWrWiYJP7OU9SoyGa/zRZ8bAKXcwuUpGjIesFr2+URsOXINGbFMdIC/l4QUhmHk
         EOxuPIg3BYtL7sU+i7ejDpXBHtUu2ZcDZAqoPjAI9T0UUmBWbshiRQ1kW7ggkk9qHdOU
         ex5e/te2VzlTUa/Fr3u5kK68YeCS+I74+glWmX3lkvmpdBKoyvWHb8Z+ogdGgi7uAUBc
         2Dj/+CPZsbNlERtDgRBA7M3LQb+jv3aenf6VyZxb67yjGnnS15g2vxRXz7PgnI+vE4QT
         KpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748868374; x=1749473174;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3yh06rFuYJ7CCM+FNSayBVkJZKoMTytyJASLK51mkYA=;
        b=fIB9gfqSzesS0FFI3vg5bt4a3r1fmVt0wdlBjdRI4mUbcesf1L5dw2d2HXsTgwYTTf
         TgckZI0sAlezxohyQ3R1bcMn74fDRnahKRds5rqq6iRK+lGqX3S4qmSusob1EXpnICFh
         x7hBtrKvRezyCstnqpUc/xyo57SbMUtIKAh9P6MYlfBw5RBxyHY3bIYHFXkUVXqDq6sN
         Hd93Z9EYFSPdS/p5+wbNNKeRb8lXljWCcXnm80pFXmtue9TGrewlwmoXQec/2Fmv2Riu
         W5Hg3Pryc/b38kbtT8PHt3gNyNY352Lfy6i5PG3AaYIiHJ5w/CJej5tEAUoHYzH/AIl6
         2aew==
X-Gm-Message-State: AOJu0Yz1jvp3sJChoKq3c008yfIFxQFnJyYNavCIWCTbgFnMGxnm7I/G
	pAXvJu/8OIv+kVnKDSJVg5eFGt+Wd2EHULDcOHYaiTJJin0LwksS4ECGBSjVHXUxlxizTeZlfvv
	aoKsSDaA6hSMJfEhVrpoVte4ISkS328ofqUON
X-Gm-Gg: ASbGncsnlwGHSUHLKZMm+Ud+dozxCfM8/Cl/m+HEOaVwyw8cwfNV4vA5sQrcvqDZMTy
	PaC6D60nbuTRfumD3S8NeYB9/P2U4Jq9FxqFkvqWOVF2rBO0yXUTkMl5HWifwzgkphvcuq0O8VZ
	nvB4PMMmkxiAx246nw8FZ/eWWSmBYfcrClI+qerRjdXA21eOu/Buvdcl94XtHaBZFBwQWMiNdG6
	5tpy0LnXT/fjf3E
X-Google-Smtp-Source: AGHT+IH49xNUP/ziriwJPU4A5+xPP8oG1CbLSWYjGmmd21kBKi1y6tB1M/px+W8MyFxQ3+w9SB7AVz8rNXGC/lb/AKI=
X-Received: by 2002:a05:6122:181a:b0:530:65f0:7fc4 with SMTP id
 71dfb90a1353d-53084b9d9cfmr7274644e0c.1.1748868374099; Mon, 02 Jun 2025
 05:46:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Jun 2025 05:46:12 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Jun 2025 05:46:12 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aD2SRmlSKZm8g8kn@pks.im>
References: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
 <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-1-903d1db3f10e@gmail.com>
 <aD2SRmlSKZm8g8kn@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 2 Jun 2025 05:46:12 -0700
X-Gm-Features: AX0GCFvtNRuA4ijTT6b68LCpH65DbJOoImbWHWFOXj7nkYivn3VJYe5uNuJZE84
Message-ID: <CAOLa=ZQQCFA=jdOGDONGcsO_VDUAxfHjn_Wk5r+8weHMFXDQ3w@mail.gmail.com>
Subject: Re: [PATCH 1/3] refs/files: skip updates with errors in batched updates
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000003298900636962612"

--0000000000003298900636962612
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Jun 02, 2025 at 11:57:24AM +0200, Karthik Nayak wrote:
>> The commit 23fc8e4f61 (refs: implement batch reference update support,
>> 2025-04-08) introduced support for batched reference updates. This
>> allows users to batch updates together, while allowing some of the
>> updates to fail.
>>
>> Under the hood, batched updates use the reference transaction mechanism.
>> Each update which fails is marked as such. Any failed updates must be
>> skipped over in the rest of the code, as they wouldn't apply any more.
>> In two of the loops within 'files_transaction_finish()' of the files
>> backend, the failed updates aren't skipped over. This can cause a
>> SEGFAULT otherwise. Add the missing skips and a test to validate the
>> same.
>
> Curious -- we do have tests, so why don't any of them hit this issue?
>

We don't hit this edge case in any of our tests I presume. This
basically requires a deletion request with an expected old OID, however
the reference should be non-existent.

>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  refs/files-backend.c  |  7 +++++++
>>  t/t1400-update-ref.sh | 14 ++++++++++++++
>>  2 files changed, 21 insertions(+)
>>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 4d1f65a57a..c4a0f29072 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -3208,6 +3208,10 @@ static int files_transaction_finish(struct ref_store *ref_store,
>>  	 */
>>  	for (i = 0; i < transaction->nr; i++) {
>>  		struct ref_update *update = transaction->updates[i];
>> +
>> +		if (update->rejection_err)
>> +			continue;
>> +
>>  		if (update->flags & REF_DELETING &&
>>  		    !(update->flags & REF_LOG_ONLY) &&
>>  		    !(update->flags & REF_IS_PRUNING)) {
>
> Ok. And the reftable backend doesn't need the same treatment? Probably
> doesn't because we queue all updates via `queue_transaction_update()`,
> which knows to not add them to the list of updates in case any error has
> happened. And in `_finish()` we iterate through that list of queued
> updates instead of the global list of updates.
>

Exactly, all writes in the reftable backend are propagated finally via
'write_transaction_table()', which checks for rejections. The single
point of entry acts as a good gatekeeper.

>> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
>> index d29d23cb89..e9a605d0ba 100755
>> --- a/t/t1400-update-ref.sh
>> +++ b/t/t1400-update-ref.sh
>> @@ -2299,6 +2299,20 @@ do
>>  			test_grep -q "refname conflict" stdout
>>  		)
>>  	'
>> +
>> +	test_expect_success "stdin $type batch-updates delete non-existent ref" '
>> +		git init repo &&
>> +		test_when_finished "rm -fr repo" &&
>> +		(
>> +			cd repo &&
>> +			test_commit commit &&
>> +			head=$(git rev-parse HEAD) &&
>> +
>> +			format_command $type "delete refs/heads/non-existent" "$head" >stdin &&
>> +			git update-ref $type --stdin --batch-updates <stdin >stdout &&
>> +			test_grep -q "reference does not exist" stdout
>
> We typically don't silence the output of `test_grep`.
>
> Patrick

Will change, Thanks!

--0000000000003298900636962612
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 84337f58cf1278ec_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nOW5SSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMnkwREFDTVZNQ3B6eDRQbFJkMzFvK0N5cnNRb0NJUwo3eHY0KzJkQW1Z
TGJSbnhWYjlwNnp2WDJnRHQzcVQwZmh3Z0NzT2ZZYVBPR2E4UjRUUzExK0FqYWFYWWFmZHk0Ci9S
QXJkeXZYVndBd1l5VVBKOU1IM1IwVkM1cTQyeDhCWlhlVFFjbEJ6NkRmcjJKK3JlZklKMEdRR1Fr
Rk5POHAKdXJDTEszRVJqTUZ2cWxNdDAzakpkanNrT1lFa2pZMlFQSVNNQ1BmV0ZiZ1RRRnFxZVVi
M2xWRU9pbk9qS1lsZQo3UnVKZXJaYXBYWlFKK2VicFlYUXVKV1Z0ZER2ZndBNW91alJTVDZtVytL
ZWczWlNTUFJQcGVjYUMxakZMUE1SCnFCMW8vNmNUaStORktSZzdkNG1wSXN1d0JGTFg2QzdJbnNu
NWtXUTJRTlM0MWZacjBQRVhBZnIwRVJ5cVBpN2cKTmEvdDMrdkpFcW84N29INjdiYzUzdkoxZUd6
cDc5aVhTZ2ZDZjA5RVpuTW1nUUJoNEs2cHNYbUhoK0U1aFE5dApEQ3lLS3lDVjRhMFFFeGs5bmlj
VTdJVkJwUWFaTUZIOXE5ZUJreEVRaEtDSk1xOGFrLzhjUWk0eUdBSHJxOWFjCkkxbDlrZjMzRDll
MGFMRFRmMi9ESGlYdVlHbDlYczhvbXVjcXZRUT0KPWN6dUwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003298900636962612--
