Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACD17E792
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749114528; cv=none; b=qDdteP6vFgfBJeOyIRnKRBt79FPuCGO6VZ1Khq1znKrVDCM34W/WuuPeHs/mHjWIFS8U6p+M2YZuHwWfXJxnBgL7bT535mzZxN0lgG99WAh7iCLPBtxL3qaiuZElKkal3WntffqGJdMsRQ0PDJJ2y4Yo1iys1CIbF28K5D2KW0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749114528; c=relaxed/simple;
	bh=B29chimeT0EA5YfIyuKDszIZNu4Z2Kc+I1WbRkEYxac=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHLHnWNWF1P8+wWfpIualVYaG8GH+cYmX+3QGul8krUCVPxWRqpsi8Aa9XfsP7Ol7O3IKeaoDIBgzVjQnNOJt183bqkv+4RmEXzRiZOLNZKQ4O12dqrTphz04zxTXK4hTnFdzsr+Wz+Ywqz77G2+1o9ujC6goYEFlJDEOTUkvk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSzx9uwH; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSzx9uwH"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-52934f4fb23so577939e0c.1
        for <git@vger.kernel.org>; Thu, 05 Jun 2025 02:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749114526; x=1749719326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MofgJqYCxG79MHAaG8ao49t4m6jEavnhjN04J6TS/zU=;
        b=RSzx9uwHL+NfGhDpmH4G6/bAuvSN5oCu0FnaH5zpQXIqdVmGcu65yKrSGND5MeCJ+u
         p4trF6iXQXvSzxjqJsTCdWWxsJn6T0HUPWioYOIdeLI4ZjIZ3MPO4nxNiN8mliOK0lZ6
         yKsTd6shBxoAqeLpT8N/HW6zW8ZCdi/IcYK065PfbUyDHedVrTDCvMk92eDtSCSmkhS6
         pvROxdBEjDOz6hoEdn2DYEvLl6KAAVEmSBIl+Ccv6SA0Y6tPRRHakDTchmAKfk//jo+g
         6Qq102U6g7gskZiHIMy2xIiYBb/WyNHTf1Y95DQq24TJJEz/9YyI+m2UkpqrNbud74cL
         uPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749114526; x=1749719326;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MofgJqYCxG79MHAaG8ao49t4m6jEavnhjN04J6TS/zU=;
        b=BgHUv9dBXGhf1VxwLLpmv18kPXzeEsvYz7ZqaMBjUIgH/NsS1EokQwIIL3MAz4kQpD
         cAX/yZp21bjalr+XE7BausTZbiPR3iXRXLQEFTzesC50piV+uEKKkDXGf23xZnb2JsPK
         cC1BC/V02E9Na8W5Pqiqd547tCWqRV39qQA1qT9kn9trw4xFTSKMat4ZqfQSd+wAy9oC
         IJe/UKXOHlga4UQcfxr15fTGTdpgl5d1kp19hNnr+3wFPsO++0T7PxYGZbCUfPIdqamo
         qkjTfjK4Vees6j4k0smnvkr1S69sGd/ImW1Vi+qeEH+AxaDIM28FnLwb+0FvGkODWGyk
         gFFQ==
X-Gm-Message-State: AOJu0YxDw2Fic1NKoNUywnzqSn1MckwOZ/V88jrkI+6C/ObmThfj0NLh
	tQ+GIl+j732oUxeQtcQMeEIxZ5p7KRpS022Tvm9DMBUgU7e+59bJNHYcxQu6CwUdPFkFlgJt7ke
	Q2A7IXpMiRYh+G4iPTRRtNwFQ41AgjREkQBuk
X-Gm-Gg: ASbGncvQdrJ11w05DeqZZAc3RQ63vS3llvTB0/MvVHWrPniyu/NqDHeASPebLnGOXkF
	5/sOqugm98qa98rtiY0q7Vt3FOOAifHocW+YtrQPZ3q01Q+hnle/PMJuuxkB6IqPiBibMwxK1ot
	2KekSclinTXwexqn0lsQGD7OIr3FesjwPxHKOQi6QSKwJgd36H57mEND184BXBZU4rUng=
X-Google-Smtp-Source: AGHT+IEuq0PdmOCxiGYcMGTusumkG3v017+dV8agYyUK8j5O+RWzsRPPNOhDTCSHjFTuVXv+d+UuL60xbjJUYA6SF8Q=
X-Received: by 2002:a05:6102:3e0c:b0:4e5:9138:29ab with SMTP id
 ada2fe7eead31-4e746e18b70mr4853297137.15.1749114511096; Thu, 05 Jun 2025
 02:08:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Jun 2025 04:08:30 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Jun 2025 04:08:30 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aEFZnmjoxjopv2xF@pks.im>
References: <20250605-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v2-0-26cd05b8a79e@gmail.com>
 <20250605-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v2-2-26cd05b8a79e@gmail.com>
 <aEFZnmjoxjopv2xF@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 5 Jun 2025 04:08:30 -0500
X-Gm-Features: AX0GCFt5Pvgq2ktSop6uITGmVr4GpTK5H3umwbIEBgKaLuRSMaoS7tyHwept6RQ
Message-ID: <CAOLa=ZQVyU63pWgaHONj2bCdCw3XmXLDVqANWkw9TkVzPQshoQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] receive-pack: handle reference deletions separately
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com, gitster@pobox.com, 
	sunshine@sunshineco.com, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000001b29550636cf75f8"

--0000000000001b29550636cf75f8
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Jun 05, 2025 at 10:19:55AM +0200, Karthik Nayak wrote:
>> In 9d2962a7c4 (receive-pack: use batched reference updates, 2025-05-19)
>> we updated the 'git-receive-pack(1)' command to use batched reference
>> updates. One edge case which was missed during this implementation was
>> when a user pushes multiple branches such as:
>>
>>   delete refs/heads/branch/conflict
>>   create refs/heads/branch
>>
>> Before using batched updates, the references would be applied
>> sequentially and hence no conflicts would arise. With batched updates,
>> while the first update applies, the second fails due to F/D conflict. A
>> similar issue was present in 'git-fetch(1)' and was fixed by using
>> separating out reference pruning into a separate transaction. Apply a
>> similar mechanism for 'git-receive-pack(1)' and separate out reference
>> deletions into its own batch.
>>
>> This means 'git-receive-pack(1)' will now use exactly two transactions,
>> whereas before using batched updates it would use _at least_ two
>> transactions. So using batched updates is the still the better option.
>
> s/the still the/still the/
>

Will fix.

>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> index 9e3cfb85cf..34db4377ca 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -1867,47 +1867,66 @@ static void execute_commands_non_atomic(struct command *commands,
>>  	const char *reported_error = NULL;
>>  	struct strmap failed_refs = STRMAP_INIT;
>>
>> -	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
>> -						  REF_TRANSACTION_ALLOW_FAILURE, &err);
>> -	if (!transaction) {
>> -		rp_error("%s", err.buf);
>> -		strbuf_reset(&err);
>> -		reported_error = "transaction failed to start";
>> -		goto failure;
>> -	}
>> +	/*
>> +	 * Reference updates, where F/D conflicts shouldn't arise due to
>> +	 * one reference being deleted, while the other being created
>> +	 * are treated as conflicts in batched updates. This is because
>> +	 * we don't do conflict resolution inside a transaction. To
>> +	 * mitigate this, delete references in a separate batch.
>> +	 */
>> +	enum processing_phase {
>> +		PHASE_DELETIONS,
>> +		PHASE_OTHERS
>> +	};
>>
>> -	for (cmd = commands; cmd; cmd = cmd->next) {
>> -		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
>> -			continue;
>> +	for (int phase = PHASE_DELETIONS; phase <= PHASE_OTHERS; phase++) {
>
> s/int/enum processing_phase/
>
> Doesn't make any difference, but it feels a bit cleaner.
>

Yeah, agreed.

>> +		transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
>> +							  REF_TRANSACTION_ALLOW_FAILURE, &err);
>> +		if (!transaction) {
>> +			rp_error("%s", err.buf);
>> +			strbuf_reset(&err);
>> +			reported_error = "transaction failed to s1tart";
>> +			goto failure;
>> +		}
>
> So if the transaction doesn't contain any deletions we'd now commit an
> empty transaction. The same is true the other way round, in case there
> are only deletions. Do we maybe want to skip phases when there is no
> match? Ideally, we wouldn't even be starting a transaction.
>
> We could for example skip forward to the first command that we would
> have to queue. If there is no such command we continue the loop, if
> there is we can remember that command, begin the transaction and start
> queueing from there.
>

I think that's a fair point, and very simple to implement. I'll add that
in. Thanks.

>> @@ -2024,6 +2043,9 @@ static void execute_commands(struct command *commands,
>>  	/*
>>  	 * If there is no command ready to run, should return directly to destroy
>>  	 * temporary data in the quarantine area.
>> +	 *
>> +	 * Check if any reference deletions exist, these are batched together in
>> +	 * a separate transaction to avoid F/D conflicts with other updates.
>>  	 */
>
> Is this comment still accurate?
>

Nope, will remove this.

>>  	for (cmd = commands; cmd && cmd->error_string; cmd = cmd->next)
>>  		; /* nothing */
>> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
>> index d91dd3a3b5..b2aaa1908f 100755
>> --- a/t/t1416-ref-transaction-hooks.sh
>> +++ b/t/t1416-ref-transaction-hooks.sh
>> @@ -119,6 +119,8 @@ test_expect_success 'interleaving hook calls succeed' '
>>  	EOF
>>
>>  	cat >expect <<-EOF &&
>> +		hooks/reference-transaction prepared
>> +		hooks/reference-transaction committed
>
> Yeah, this shows the empty commits indeed.
>

Yup, thanks for the quick review.

> Patrick

--0000000000001b29550636cf75f8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 43370b0f6b37e97_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oQlhvd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meS9SQy85QUU1M1doNUFzVnFVd3o4UCt1QXQ5ZTJnMwpBUFJEMHlkUk15
NXVrRE9ZMFdMSFN1NHp2UXgwaG1pMDF2UjlyOW42aDFHREYvS25KeE5qdlF0UERRNmFHODVCCndU
Y0hmTUs4ekdINFdWQVl0TDJVd2RXcCtmeWkxRVJPUUhqRXptVWRyb1ZPUjNpa004ZjM3Nmo3RmZs
Q0JSKysKaFdoYkYveG5yYTlHZFN4aXphTlJSZXpZOTFmQjNJdDdqZktIYVlHY1pCb01ZWUlqbUhF
MTE3am9wTXdrbmxwYQpQWEZHL2d0MTVrSlc1OStxU2ZBSDRTdTJ1a05DSXdHOUpDL2FwbEJ5QTR3
Zm55UVMwaENxSjZWSUdFM2ZRMjYvCk1tbTMvUk96N2U5NTl3a1psMWZZUDlFU0xXdGlBSkwvNDYx
MEJ4YTBuVFRPdEQxd0Q3Y2hwdFBBYlZEdEFIR1AKNFFPTkpoT0o0UkhnMElKdThpQlBHeDVUelZu
NisweXpjNjg1U3o1b1NIUUREakpWNFVVTkpYMDYxRlVHZTEwdgpTUmRDbk9mY2VET29OT2Vuekhw
d2xqZlFqQmwwWm1VazhjbW9iTlFwWmdZbUlmUzl1VTl6SlF1LzJ2SytEMXpDClNNTUlxQlVrbHJs
alpSWE1ZenRkUTJTaTkvNHc1M0RNY1FQcXoxTT0KPXRaR0gKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001b29550636cf75f8--
