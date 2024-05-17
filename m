Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F50A12FB12
	for <git@vger.kernel.org>; Fri, 17 May 2024 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715962917; cv=none; b=Ne0DpcoUoESuNKilWRwh7mzuE2UtlQjsZNAbU2fiLi1xwzOkl7Sy6iLM9BtXZfZ0O5o+Fe6kc19FnELDn/WIYf7nAmD1+6wkjsiuyAPIl+1CaU/FcOWKoLC0B//+FcteWbgDFJi1CHyN6GPSWmlklMqiFJ7sDXJXOvpen0Zd/p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715962917; c=relaxed/simple;
	bh=zCmDpGtvepazpW6TL4TAN1hAWCs/o7TZh2ftLjU9DKU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcO7A3dAkcU5JDl1mI+ilJopW/8o6VLizC5SvR6t0K+97/Ikujiss204qutXF5NprQgNwXTlsM0t8DJOQ7riW9H+slatbvrR86lfJtvYrVd96ta/etXwMLVtLRlSNpach3TkiV06Iaz6fQgM+VY311wVDX5W/vzm/2064KZOBS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xhb/22s+; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xhb/22s+"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5b28c209095so227920eaf.0
        for <git@vger.kernel.org>; Fri, 17 May 2024 09:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715962914; x=1716567714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jWGwnRLMn0sSotiBEFqAinC1voiyHXzEJvyCAssF/bI=;
        b=Xhb/22s+QIR3ObyIIlBrYcx56ctJhRqBxjdu0YbXiWt63+ZTy1nZrFWGTWbzXOpS+P
         n5/aa1pU0TGSblqmyDTZ1Gv0ESMwqaKLs5zwFexmHMCC7vzrm7e5r402WF3gks9gvJt7
         LCJMXsGzSvbOGefjKUv3MrbQ46WwweRmdWTBkVfHtgvUXBKu7q8M0rtLJmX5YkmyxLt4
         cEHM78VQ1SExcu5czt9JRtoAKSYE2bmgE/2oUc59qTV6iu4LDat0zzQL8M9IOKP7zPJe
         eyiExYigx2EjDYNKlvVD0fLf5FmTzrPmEW1w5MK2BcytNlIQWa+IeD1BW9EcHiyAI3vl
         dNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715962914; x=1716567714;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jWGwnRLMn0sSotiBEFqAinC1voiyHXzEJvyCAssF/bI=;
        b=CHy85aUlmGf/BwMsdj0veUqJ+qVYpZjwkxHmcVRPBeTlmDqMLeJ0EqSsgV1Qs54xiD
         oGe8bbIy3CPfQ9zSeW08P73/z7gDOF2sPxFNN9ekVnqmaf8ro9f1evy8xH6C/0DD6sia
         4uDcbRqK32vuwH0/qnJB3uBdLlOSOq/TgB4ZHAWiltl3T0SILcSwqx6pvCrAZZwEcmZS
         gK3yVtSsAq/uB8JS0Fy2+mAtkzjKVLneVpnRFISeVtOXgmiCmQlZ79FEQt0XzpIEfjB9
         QHonmohfz5oL3AnnTwhgJapVmPGscI1YR7H1m8I08slC0fkZTc5H3wHOQfoLqadzDiQN
         Bhjg==
X-Gm-Message-State: AOJu0Yy/aHmcr0w4K24nmbgu1XUASWJSTi4iAf9RLvLG9cbUZqbnmYzF
	wepBFZN+sxp/2TdVxd01vYWBLbh4Y5VH8fDCyRZxdZGCGh+kScJB9WmaRgL79D/18TItgSbI1/Y
	gwWPDtngqjTcfHd8TYHu0ZhkOTnPkYw==
X-Google-Smtp-Source: AGHT+IEpi7r1v2nTRygPKgqlOitC5msLIU8Tha7l5oXiwzApYQ+pCekN/HeDZHX3O1/wm/kHlkdDwB6KXuTJ8OyUIBU=
X-Received: by 2002:a05:6870:d248:b0:238:f752:b1f with SMTP id
 586e51a60fabf-24172f719b7mr23664531fac.59.1715962914087; Fri, 17 May 2024
 09:21:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 May 2024 18:21:53 +0200
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZkXpYep2MKdsyNyV@tanuki>
References: <20240514124411.1037019-1-knayak@gitlab.com> <20240514124411.1037019-3-knayak@gitlab.com>
 <ZkXpYep2MKdsyNyV@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 17 May 2024 18:21:53 +0200
Message-ID: <CAOLa=ZSUV1X==x2CBivgu=L7SQryXNZZkLwxgyNth=a+bH9SQg@mail.gmail.com>
Subject: Re: [PATCH 2/6] update-ref: add support for 'symref-verify' command
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000f1465e0618a8bfa2"

--000000000000f1465e0618a8bfa2
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, May 14, 2024 at 02:44:07PM +0200, Karthik Nayak wrote:
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> The 'symref-verify' command allows users to verify if a provided <ref>
>> contains the provided <old-target> without changing the <ref>. If
>> <old-target> is not provided, the command will verify that the <ref>
>> doesn't exist.
>>
>> The command allows users to verify symbolic refs within a transaction,
>> and this means users can perform a set of changes in a transaction only
>> when the verification holds good.
>>
>> Since we're checking for symbolic refs, this command will only work with
>> the 'no-deref' mode. This is because any dereferenced symbolic ref will
>> point to an object and not a ref and the regular 'verify' command can be
>> used in such situations.
>>
>> Add required tests for symref support in 'verify' while also adding
>> reflog checks for the pre-existing 'verify' tests.
>
> I'm a bit surprised that you add reflog-related tests, and you don't
> really explain why you do it. Do we change any behaviour relating to
> reflogs here? If there is a particular reason that is independent of the
> new "symref-verify" command, then I'd expect this to be part of a
> separate commit.
>

Ah! There is no divergence in behavior, rather this is behavior which is
never captured in tests. So I thought it makes to have tests around it.

> [snip]
>> diff --git a/refs.c b/refs.c
>> index 59858fafdb..ee4c6ed99c 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1331,14 +1331,17 @@ int ref_transaction_delete(struct ref_transaction *transaction,
>>  int ref_transaction_verify(struct ref_transaction *transaction,
>>  			   const char *refname,
>>  			   const struct object_id *old_oid,
>> +			   const char *old_target,
>>  			   unsigned int flags,
>>  			   struct strbuf *err)
>>  {
>> -	if (!old_oid)
>> -		BUG("verify called with old_oid set to NULL");
>> +	if (!old_target && !old_oid)
>> +		BUG("verify called with old_oid and old_target set to NULL");
>> +	if (old_target && !(flags & REF_NO_DEREF))
>> +		BUG("verify cannot operate on symrefs with deref mode");
>
> Should we also BUG on `old_target && old_oid`?
>

I didn't do this, because `ref_transaction_add_update` downstream from
this already does that. But I guess no harm in adding it here too.

>> @@ -1641,4 +1647,88 @@ test_expect_success PIPE 'transaction flushes status updates' '
>>  	test_cmp expected actual
>>  '
>>
>> +create_stdin_buf () {
>> +	if test "$1" = "-z"
>> +	then
>> +		shift
>> +		printf "$F" "$@" >stdin
>> +	else
>> +		echo "$@" >stdin
>> +	fi
>> +}
>
> I think this would be easier to use if you didn't handle the redirect to
> "stdin" over here, but at the calling site. Otherwise, the caller needs
> to be aware of the inner workings.
>

Not sure what you mean by easier here, but I think it would be nicer to
read, since the client would now determine the destination of the
formatting and this would align with what the test needs to do. Will
change!

>> +for type in "" "-z"
>> +do
>> +
>> +	test_expect_success "stdin ${type} symref-verify fails without --no-deref" '
>
> We typically avoid curly braces unless required.
>

Will change, thanks!

> [snip]
>> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
>> index 067fd57290..fd58b902f4 100755
>> --- a/t/t1416-ref-transaction-hooks.sh
>> +++ b/t/t1416-ref-transaction-hooks.sh
>> @@ -157,4 +157,34 @@ test_expect_success 'hook captures git-symbolic-ref updates' '
>>  	test_cmp expect actual
>>  '
>>
>> +test_expect_success 'hook gets all queued symref updates' '
>> +	test_when_finished "rm actual" &&
>> +
>> +	git update-ref refs/heads/branch $POST_OID &&
>> +	git symbolic-ref refs/heads/symref refs/heads/main &&
>> +
>> +	test_hook reference-transaction <<-\EOF &&
>> +	echo "$*" >>actual
>> +	while read -r line
>> +	do
>> +		printf "%s\n" "$line"
>> +	done >>actual
>> +	EOF
>> +
>> +	cat >expect <<-EOF &&
>> +	prepared
>> +	ref:refs/heads/main $ZERO_OID refs/heads/symref
>> +	committed
>> +	ref:refs/heads/main $ZERO_OID refs/heads/symref
>> +	EOF
>> +
>> +	git update-ref --no-deref --stdin <<-EOF &&
>> +	start
>> +	symref-verify refs/heads/symref refs/heads/main
>> +	prepare
>> +	commit
>> +	EOF
>> +	test_cmp expect actual
>> +'
>> +
>>  test_done
>
> So the reference-transaction hook executes even for "symref-verify"?
> This feels quite unexpected to me. Do we do the same for "verify"?
>
> Patrick

Yes this is the same for verify as well. I was surprised to find this
too. It's just the way ref update code is written, all updates land
trigger the hook. This means verify, which is also a form of update,
with just the new value not set, also triggers the hook. I've kept the
same behavior with symref-verify.

--000000000000f1465e0618a8bfa2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: efffe9906aa60383_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aSGhCOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meUdzQy85Q1FjeXdjZmJoQVlYdjVFVjhUR3VmVGFmUQp0dmlQNUVscDdL
WitKZTR1cDFkMm9rSGFTMGxlZUFxcHZSK1lhVk1uYnhZSnBYcnFoQUN5VDBKQVI0d3lTUkVFCjF0
ZVN0NVlBSEh3QWVhbUFyMDBWMjQvSDJtcjJpcUtSRlp5VVh4N2pFdUs0Qk4xKy9INFcwS3RFSkpQ
Z2hOOFQKczVFV1hpQUlvblo2MWhsY2MzN0gxTUtYVDQvaTMyay9kWUdUb2QwWnZ3Rk1lRjQ3TzI0
Y0wxdCtqUmdoOGV3TwpWa1RQNzRkVjlRUWFVZWl3T09BdHdiUzdhRjNGSFZrcXY4OVhpVWRLakNk
WHBJMy9waUcySk9iRU94Rk9CcUJPCkpSRTlSZHlvSElHWnA5UGkxUmZqZEd3ZG1PWGgvbjZZcXpR
Umh6aDUyZWR2RXpUdGFhUFgrT0tJcytxa1YwZHoKTk9rMXBoRFY4aXJGWE0rRXo3MG4rUnpxSWZj
bmFpVDdxeVQyQW9lb3ZqTmdDT3BxOGhVY2NsM0llazQzLzg1QgptbXhWMkw4cWd4d1h1Q1BjRW9G
K1VGODZCU1Zic2gzWmtXaFJmYjl5SmZXcnBMSkFQRjVOL2JmNW9uOGNJVlMrCm1McWFxUi9ET2Fj
VS9hUHpNdWdjLzFaREhTczBoZ1ErZzhadXhxdz0KPWsvZEoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f1465e0618a8bfa2--
