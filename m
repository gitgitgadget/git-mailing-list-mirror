Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA0518C356
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579908; cv=none; b=nGIGPMIZkvKi6ALNVToqNFiXSCEqsBBLBWJJxZDeQDprz9uG5nBxi3OY4O6gFETDOJoPT5/ZCSDz5FZ22dnhZ5zBWM3zMHQwv0BoxGznLZJEZpZ7VmPZqTjw3bwGvMzJXUpCn9ywfTV8bMLpJ+5iSKBb0xeumuaeh8rOjTLb1JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579908; c=relaxed/simple;
	bh=WKGthfhgV6Soev1v5zAtC2WQfReQKNxBacH5JO+KycI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZQ1mPRzyEZIIMpEvm9YQwgeIOtwdcfsf+TEXbTapXdKBzmqGrsfojTYXaeEm1G/FudZZHBJpQ4Hdxq5v0JNhhKie+h4cqJaNEX1UWp2ziO8xKLV4qGIX4CZ7joP2nnTzwJGpl9MSbyLFNWxBjSkYxUsPmYRlKrGeUQxa2ZvixY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdoRyBpU; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdoRyBpU"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f124e97d31so1582675a34.1
        for <git@vger.kernel.org>; Wed, 05 Jun 2024 02:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717579906; x=1718184706; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tUl9rftu9FORl+nsNiQuZQSBfx+fCY7y0vML99YM1/Y=;
        b=fdoRyBpUVViGzFYRTuuNgwLNWTw2KxnphzjG4pWq/2vnKrXoIEDa49fkb9gZKoc1ip
         pH0XRAUwskn19DA17W/JtmqHOmXibTOolQ+no+1hhnqmPleU8BXSXpev7d3NKvZ7ER3J
         /QffDn4biGnojtCuufPm1yrMyWUVhoF/DtLmiRt85bunki4T/n6kjA10uSnueX0t2NRa
         rTecFKObHcm9VofEMQuhx4jnb7Tfil+94eAEaSdxFcmvWFjyjVkMXVl4IUlOR0NPdjA6
         0yWdiusNiJsav0XEsWCL0xdFPipTzboUnsE0hd/xwf5LhNGtF5mS34JQMNu8r32mmsi6
         akbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717579906; x=1718184706;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUl9rftu9FORl+nsNiQuZQSBfx+fCY7y0vML99YM1/Y=;
        b=AUgGWFIZ4GRCbsV/nKV1EObjEXkJ+E14sOd7Zd5gBbaNotZjng7gmHYfBgHhuqZ/Lc
         ugHEE/eSiV8bQC8hZacUv7l9ay94wiJE1LeLzb0I4/uC/65FVhW+GzqU5RpFNJq2H7ev
         ZZHDdBv6fvycyuJgu2bYV6V+4SBUDr2fF/Ak5EuDYTNstWPnbRXGJmqUcKA/Akaxs5xg
         cYt7MnJz4UuePf/H69IhbtIGhB3Gm2/CM8vLmsUWB9XiYdxvuywfUzBHYvKrssYX3f/e
         DTZ83IaeTIPsQEhMaOBIshIj2E/4WRP/7SoiZRB1B7wIFxJmoxk3t5GBGzY2ZH5WdnI1
         4Qmg==
X-Gm-Message-State: AOJu0YzwoDfcgrSiv50Ek18qodZJK+9jXcDmktgUPZOJuTvFcRYaUiVC
	XJUdhxChurqd5SPLSYA1Z65VvPhfApOFHFky6oRCTTxfbHv3LvYLHFT+bwJJVz7jp7dSAwG51Xy
	w4I4s0l3UTCqlS5HYPBQ3XYC25sU=
X-Google-Smtp-Source: AGHT+IHoo9w4YSuSgAjwd8NAPngYEOCa0w7bbFcPWFUwnNRwh+pbdCKTK65DQ2PepgUg8Gqaeo6VHKBEn9u03Dyenmo=
X-Received: by 2002:a05:6870:b149:b0:24f:e5f2:1cf0 with SMTP id
 586e51a60fabf-25121d0b758mr2175494fac.14.1717579906362; Wed, 05 Jun 2024
 02:31:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Jun 2024 02:31:45 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZmAbgGfNpZzU76pd@tanuki>
References: <20240514124411.1037019-1-knayak@gitlab.com> <20240530120940.456817-4-knayak@gitlab.com>
 <ZmAbgGfNpZzU76pd@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 5 Jun 2024 02:31:45 -0700
Message-ID: <CAOLa=ZSDRcsmBxje-EgdKNyXCh1OYc4vtzJZKmoHSs94fMxPtw@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] update-ref: add support for 'symref-delete' command
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000315302061a213c8e"

--000000000000315302061a213c8e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, May 30, 2024 at 03:09:37PM +0300, Karthik Nayak wrote:
>> diff --git a/refs.c b/refs.c
>> index cdc4d25557..e29abebe1d 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -950,7 +950,7 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
>>  	transaction = ref_store_transaction_begin(refs, &err);
>>  	if (!transaction ||
>>  	    ref_transaction_delete(transaction, refname, old_oid,
>> -				   flags, msg, &err) ||
>> +				   flags, NULL, msg, &err) ||
>>  	    ref_transaction_commit(transaction, &err)) {
>>  		error("%s", err.buf);
>>  		ref_transaction_free(transaction);
>> @@ -1283,14 +1283,20 @@ int ref_transaction_create(struct ref_transaction *transaction,
>>  int ref_transaction_delete(struct ref_transaction *transaction,
>>  			   const char *refname,
>>  			   const struct object_id *old_oid,
>> -			   unsigned int flags, const char *msg,
>> +			   unsigned int flags,
>> +			   const char *old_target,
>
> The old target is somewhat weirdly placed here, as I'd have expected it
> to live next to `old_oid`. That's only a minor nit, nothing that's worth
> a reroll in my opinion.
>

This is a good point.

>> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
>> index 52801be07d..848d6fc42e 100755
>> --- a/t/t1400-update-ref.sh
>> +++ b/t/t1400-update-ref.sh
>> @@ -1731,6 +1731,60 @@ do
>>  		test_cmp expect actual
>>  	'
>>
>> +	test_expect_success "stdin $type symref-delete fails without --no-deref" '
>> +		git symbolic-ref refs/heads/symref $a &&
>> +		format_command $type "symref-delete refs/heads/symref" "$a" >stdin &&
>> +		test_must_fail git update-ref --stdin $type <stdin 2>err &&
>> +		grep "fatal: symref-delete: cannot operate with deref mode" err
>> +	'
>> +
>> +	test_expect_success "stdin $type symref-delete fails with no ref" '
>> +		format_command $type "symref-delete " >stdin &&
>> +		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
>> +		grep "fatal: symref-delete: missing <ref>" err
>> +	'
>> +
>> +	test_expect_success "stdin $type symref-delete fails with too many arguments" '
>> +		format_command $type "symref-delete refs/heads/symref" "$a" "$a" >stdin &&
>> +		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
>> +		if test "$type" = "-z"
>> +		then
>> +			grep "fatal: unknown command: $a" err
>> +		else
>> +			grep "fatal: symref-delete refs/heads/symref: extra input:  $a" err
>> +		fi
>> +	'
>> +
>> +	test_expect_success "stdin $type symref-delete fails with wrong old value" '
>> +		format_command $type "symref-delete refs/heads/symref" "$m" >stdin &&
>> +		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
>> +		grep "fatal: verifying symref target: ${SQ}refs/heads/symref${SQ}: is at $a but expected refs/heads/main" err &&
>> +		git symbolic-ref refs/heads/symref >expect &&
>> +		echo $a >actual &&
>> +		test_cmp expect actual
>> +	'
>> +
>> +	test_expect_success "stdin $type symref-delete works with right old value" '
>> +		format_command $type "symref-delete refs/heads/symref" "$a" >stdin &&
>> +		git update-ref --stdin $type --no-deref <stdin &&
>> +		test_must_fail git rev-parse --verify -q refs/heads/symref
>> +	'
>> +
>> +	test_expect_success "stdin $type symref-delete works with empty old value" '
>> +		git symbolic-ref refs/heads/symref $a >stdin &&
>> +		format_command $type "symref-delete refs/heads/symref" "" >stdin &&
>> +		git update-ref --stdin $type --no-deref <stdin &&
>> +		test_must_fail git rev-parse --verify -q $b
>> +	'
>> +
>> +	test_expect_success "stdin $type symref-delete succeeds for dangling reference" '
>> +		test_must_fail git symbolic-ref refs/heads/nonexistent &&
>> +		git symbolic-ref refs/heads/symref2 refs/heads/nonexistent &&
>> +		format_command $type "symref-delete refs/heads/symref2" "refs/heads/nonexistent" >stdin &&
>> +		git update-ref --stdin $type --no-deref <stdin &&
>> +		test_must_fail git symbolic-ref -d refs/heads/symref2
>> +	'
>> +
>
> Not sure whether I overlooked it, but one test I missed was when trying
> to delete a non-symbolic-ref.
>
> Patrick

I think this point is worthwhile of a reroll, not because of the test
itself, but because while testing it, I realized that currently when we
try to delete a regular ref using `symref-delete` and providing an
`old_target`, the error message is quite generic. I've added a new
commit to make this more specific and will send in a new version today.

--000000000000315302061a213c8e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a2dd9b584ec2deb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aZ01IOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNm9tQy9zRng5NE1nTkFFN0YrWGoyR2lvUTVpQUlhdwpqeVgyalkwS2VJ
bXlPeHJaa0szSldIU0lOVDROV3QwL2w0RzJTRldpK1U5K1psOEJYSHgwWlZhcVNoellTNHVUCkhh
RWNJZS9vMWJwS053ZWg5SEEvYWNtcXNYL2hSUVl2RlIyUFdVcForL0hYRDFhT25RUnBRRjgvMUgx
cnpYaEoKZ2xmZVNhdTFCZExGcHhiYjhzUEFKRnRDZ2h6Y0RFdlNlZ0ZuRjVIUkFqWUJ2TTVnLzNZ
NUFodC9reTZvSVN2bwp6Q1VFZVdKemlGVUNqL2s3LzN1TzNYTE92RytqNS9EeFRsS2w3aG1jM1dZ
YXZHZWFmSkpMcnpHSG5xdllXSU1qCnJ5dlMzSUE0b0prTmx4SFYzemZ3RFMrRlZxcU9rUCtZOXN1
SHZWaTFBazhYd2hEUmduTTl3OHJsK3RIL2FxTTcKU0thdnFldkNHM0NvZzcwTTlVSnIyRk8zSkpE
NnYycy9Xc1dMSkkvRyt2aCsvU3Q5aXAySVJSMmxpM2tIV2dpTAp3MkF1TjhuWkRCUE5kUVNNTm0w
TkVCTTQ1YUFscGVGNWJBUmxFOFVEMTU2eE5WRms0WUlxNHl1K0F3WUtvTUtoCmgwaXB6b2FMNTRM
UURKa3B4US9IUlcxZ2pnMThjeWtndXZGS2JUND0KPVhJSXMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000315302061a213c8e--
