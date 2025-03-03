Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341EE1DFD83
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034056; cv=none; b=vEayoehyxx77E+2mpHT/Kc6FFVwPdPMPWrGXyT5+v1xj5FPn52/d3TBFZo90hn+BKJ9AazZPjRNHXZCvwuGejDWG7mbgt/4tit3eg4BlFP540YccZjh2ZqDSh+Ft7/+yaZs9ek+fF/TayHgbLEzZTyI94yXUZRPj/LKb0lxQUQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034056; c=relaxed/simple;
	bh=D86+8xk9LoOhxwxTplxlU238u60IRQ4dQRBTlhfT554=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HASftquOkS8Y5zMIRveGfUuAIUCpvXcRMkaeu0wJxyIYORPw8NwO/G2Jlmhg38ri3CC4uC6ewZCfYBc28w6CsM8dxkQb/JDz/RRl4qceIRDp5W3DlcGeA1Diwr//fDeCQpjkFemuIDVE+Dc3+ms5B0dxOBWZqsShS0zFgC2WIPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFCQuEMy; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFCQuEMy"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86b42825d51so1889004241.1
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 12:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741034054; x=1741638854; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=W1CWamcOMqJt6NGZngXQyZiCuxdZq4NVGK0v8pHP5jI=;
        b=AFCQuEMyMYp5LEU1nFUiGwyMgSVZJGKFM10iVeBFW+ntz1q77Cvp9bLrRX/i7C4PFs
         CBeF4a5aUaBcoCUgtEL0NiLm7Dt/qvTYBmFfduyFw7PypcOnl0UnpOI2iLSmxt/SqwcF
         Py2MIFfpt0McP3aINvngqGHDgj/t1n718fE1LIuwUU/brkO2iXLUdpjUCRRsRXd3VXps
         khOaYPVfABDJBP5Co8xwhylzWAgz82QABvXYjX0dkWagPJvI6yLOb80n5ZR5/qEr9j71
         8gQGsw+/SjF48jnWIkdrnkPR6GGP/1bIqbST7CGAFx0tQukyZ++ER7p0qQOe4iVklIuH
         Gysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741034054; x=1741638854;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W1CWamcOMqJt6NGZngXQyZiCuxdZq4NVGK0v8pHP5jI=;
        b=buUHxLjY64kzDVaOFg4yk1g+piTzd9uNUacz7a/ioEAWVHGlUpx77Z3FcuX+XB7rWN
         PntmfYZA4bui7DHiApJfDu1kfWemvArPaWowkL57BBvSJWFaZ4Ufq+7Gfxv/Ex0r/GQ/
         VwZF/FHA8CEDsdHq9KhOoIB5+8G/jlCUOHBFYVqrroSrOxhYoIsftxeqn0wLZBRCfGIN
         3egYneNULtECBndHtkrE7rhEdck/PpM0lxyrtoOl/Nf+uioz3/cVEhMp/8QukTnrnBnI
         npzn7r4J/prxzogBzGbOuNfaSp78EH0wseQVGSylY60sWX4e93NuQgq4hN9IeSO/H0Ih
         IkHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbzHmqcJGUQxeJhzxsFHBtaX31Ubtz5fVAbAvg961npY97kMKe5LsagNCZsqef2xNZpKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9AcHvP4Um9Ny5EGG4++9govqrWFeUKSJHVj1V24NNIEkArck/
	lJTljU0/yjuGzsGFP749vIr85Fi7Dfj88Bl601/z8ZQsLq7osIaaaT/PANEHYWrpz6lc4UCCSIf
	61httE0+rvnxeJIPRbjpDxHDmKN0=
X-Gm-Gg: ASbGncsy1j5WAYLen63TXdkLOkorErQ8MR0hSVVfbsWs5AUVgsowPMVAnKHKQt2h9AW
	z8rzkdmF0KHQlMiCe3uUUzd9qHpjSHK1F9KPLcx0eDAQuFnDBhLUNYFI3RR5Wp9ozgYdFIghvBF
	SIilxOmcHTyFL+4jn9NVFe7otHp9Je1kAfdYaaUkmSbLbnIb63rwuL/cjBP84=
X-Google-Smtp-Source: AGHT+IElgh3kw9OwmbZ4+bWOcIhD+VO/QAlHdzAaai4BmAufvH1eOxuF70ANWJHxIDK4VIdKOrj3Ne2pjVeXXeNgdT4=
X-Received: by 2002:a05:6102:6d5:b0:4bb:b809:36c0 with SMTP id
 ada2fe7eead31-4c044a041a0mr9120168137.20.1741034053969; Mon, 03 Mar 2025
 12:34:13 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Mar 2025 12:34:13 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ceda422e-8c8e-4a1d-aaab-9a7a2fc009dd@gmail.com>
References: <20250225-245-partially-atomic-ref-updates-v2-0-cfa3236895d7@gmail.com>
 <20250225-245-partially-atomic-ref-updates-v2-7-cfa3236895d7@gmail.com> <ceda422e-8c8e-4a1d-aaab-9a7a2fc009dd@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 3 Mar 2025 12:34:13 -0800
X-Gm-Features: AQ5f1Jqig782YxE5Iezdsxj5Bvh6Da4qmRTAn7kEuXdHdbf3bvEdB99u2WtvuXI
Message-ID: <CAOLa=ZTeDH+yWpK6KBK=yDFymyUFuDg7Qb3Ww7EnX8wgHC0_ag@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] update-ref: add --allow-partial flag for stdin mode
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com, phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="0000000000005448ee062f7614a2"

--0000000000005448ee062f7614a2
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Karthik
>
> On 25/02/2025 09:29, Karthik Nayak wrote:
>> When updating multiple references through stdin, Git's update-ref
>> command normally aborts the entire transaction if any single update
>> fails. While this atomic behavior prevents partial updates by default,
>> there are cases where applying successful updates while reporting
>> failures is desirable.
>>
>> Add a new `--allow-partial` flag that allows the transaction to continue
>> even when individual reference updates fail. This flag can only be used
>> in `--stdin` mode and builds upon the partial transaction support added
>> to the refs subsystem.
>
> As '--stdin' allows a single instance of "git update-ref" to create more
> than one transaction perhaps we should instead allow the caller to
> specify which transactions they want to allow to fail by passing an
> argument to "start", similar to how we support "no-deref" with "update"
>

I was considering adding a 'allow-rejection' flag similar to "no-deref"
with "update", but decided against it since that was an update level
config and we want a transaction level configuration.

But I like your idea better. I'm not bullish on either the current
implementation or your suggestion, since we can extend one from the
other. My main motivation to add this flag to update-ref(1) is to show
viability. The goal would be to follow up with changes to `git-fetch(1)`
and `git-receive-pack(1)` to use partial transactions.


>> following format:
>>
>>    rejected SP (<old-oid> | <old-target>) SP (<new-oid> | <new-target>) SP <rejection-reason> LF
>>
>> or with `-z`:
>>
>>    rejected NUL (<old-oid> | <old-target>) NUL (<new-oid> | <new-target>) NUL <rejection-reason> NUL
>
> What's the reason for the different output with '-z'? In the list of
> options '-z' is documented as only applying to the input stream. Looking
> at the code the existing messages generated by report_ok() are all
> printed to stdout with a LF terminator.
>

That's a great point, there was no real reason and I think we can drop
this.

>> +static void print_rejected_refs(const char *refname,
>> +				const struct object_id *old_oid,
>> +				const struct object_id *new_oid,
>> +				const char *old_target,
>> +				const char *new_target,
>> +				enum transaction_error err,
>> +				void *cb_data UNUSED)
>> +{
>> +	struct strbuf sb = STRBUF_INIT;
>> +	char space = ' ';
>> +	const char *reason = "";
>> +
>> +	switch (err) {
>> +	case TRANSACTION_NAME_CONFLICT:
>> +		reason = _("refname conflict");
>> +		break;
>> +	case TRANSACTION_CREATE_EXISTS:
>> +		reason = _("reference already exists");
>> +		break;
>> +	case TRANSACTION_NONEXISTENT_REF:
>> +		reason = _("reference does not exist");
>> +		break;
>> +	case TRANSACTION_INCORRECT_OLD_VALUE:
>> +		reason = _("incorrect old value provided");
>> +		break;
>> +	case TRANSACTION_INVALID_NEW_VALUE:
>> +		reason = _("invalid new value provided");
>> +		break;
>> +	case TRANSACTION_EXPECTED_SYMREF:
>> +		reason = _("expected symref but found regular ref");
>> +		break;
>> +	default:
>> +		reason = _("unkown failure");
>> +	}
>
> I agree with Patrick that these messages should not be translated.
>
>> +	if (!line_termination)
>> +		space = line_termination;
>> +
>> +	strbuf_addf(&sb, "rejected%c%s%c%s%c%c%s%c%s%c", space,
>> +		    refname, space, new_oid ? oid_to_hex(new_oid) : new_target,
>> +		    space, space, old_oid ? oid_to_hex(old_oid) : old_target,
>> +		    space, reason, line_termination);
>> +
>> +	fwrite(sb.buf, sb.len, 1, stdout);
>> +	strbuf_release(&sb);
>> +	fflush(stdout);
>
> There is no need to flush after each line, we'll flush all the error
> messages when we call report_ok() in parse_cmd_commit() or when the
> program exits. The caller has no way to know how many error messages
> there are to read so flushing each one individually does not help the
> reader avoid deadlocks.
>

That does make sense, I'll remove the flush here!

>> +}
>> +
>>   static void parse_cmd_commit(struct ref_transaction *transaction,
>>   			     const char *next, const char *end UNUSED)
>>   {
>> @@ -573,6 +622,10 @@ static void parse_cmd_commit(struct ref_transaction *transaction,
>>   		die("commit: extra input: %s", next);
>>   	if (ref_transaction_commit(transaction, &error))
>>   		die("commit: %s", error.buf);
>> +
>> +	ref_transaction_for_each_rejected_update(transaction,
>> +						 print_rejected_refs, NULL);
>> +
>>   	report_ok("commit");
>
> This is good, the caller knows to stop reading when they see "commit: ok"
>
>
> Best Wishes
>
> Phillip

Thanks for the review on the series.

--0000000000005448ee062f7614a2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7d271ee116770e67_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mR0VrTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mekxDQy85MG92R1ZvTUk0bEx2SURYcnRzcVg4am5nTgovRWdwSVdPU0Zp
c3NoUldUQi91Q2RReVRtV2VJN0xiM25xTjVQY3lRWWdaS3B1UDlVRFRXNlEwM2NWL3dJekRvCm5J
dXJyU004aXh1SmZGOGRtd2MzUmJzTFV5ZHVUVDFQRm5QdWRTMFRzRlFMd2Y3S0pCaFgyeUhyUFp0
cHEzMU8KOUpUT0V5SVZwRGRLMjJWUW81YTdDM1VZaGpBNHpLRUhDQkQxMWZFd09ReDNhdjMxZXBJ
YXh3TkNtVTBwRUNPWAp6VTl6M0l6T1RVQi9wWnZWSGVWOE5YOXpzYWsweXVlb0NNYncwRk9TT0Q2
VE94V1BINEFpblVZcy9XUG82a1NOCnBTRHAxY3lXajNzTVFhWERhV2ZaNUxUZ2NUVmhFdS9xcm5r
TFFYcCtIT3pvQ2gvSDZZYm9CQnUrb25WbHZoTU4KQjFzZitBNmg5REhuRmVQTmt3cGlRZEtwVmEx
cDd3Q2U5MUpUZE1acVc5QWtlNXVmVDRaQnhWSmFJa2liWXFSNgp4RXJTb2ZJWFdsZTJ4UzFocTgw
V0dnVHdwZXdPeTVRdnNsWEo1QmF0QzVvaWprWVN4cXBFNmljZyt2TkVKaW82CnlHNDM2UnBkenB4
d0JQNFFZVWFIeXVXT3YrMmUvdWJsRExjYnBtRT0KPVBWYXkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005448ee062f7614a2--
