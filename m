Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA18A1C6FF6
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741252413; cv=none; b=rdxi/uKu5b3HfF18EtuFareZkxL/AUeh5ASn+L6LVOzTcicmAsSWTDLbiTQB6YZcOF/Ctde6cAZfjdsejla6JmH67yBrRnBi1dS+n8Blch6YefTvWI8OstvKpsiE2NANAqHQNXC1LwNJEUIJifIQRBQvjtV633Sdvquyfl9e8UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741252413; c=relaxed/simple;
	bh=3cCkKKDOTmBxyRfSUBTPGsLCQ/M+YjPSgY4n4fD4Owo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIjP+nO+EiKx7IeBsbltvK6Mnfh9yn0rhafSsv9AueSwHherghFlz8wMEB3rHn70jtFm2fk+FFVgCOQbkyFTwVg3KGq1nNb7Gtlv6XAsvbyYDtSUq4xJXTmcdoov5hkvcumM018L3GDVhSqPpX4zIjcmQwQQop8uN2l6+SYn8vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qgz5XCfF; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qgz5XCfF"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-52364925cfeso1739939e0c.0
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 01:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741252410; x=1741857210; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=K1HoOSsMEgfFSy1djvQMr8ahj4WRViig8qX0qsqefTg=;
        b=Qgz5XCfF7i+q3BWEYAUfECtsKiiDOKoy5w1ynELgFmARmjKGr51uJasUaP2s3spLl8
         RXZW6j3kvvVVAVXDYNANBEEgj/YpNEYBlhS5iqFESbs6cdkXCEQnN9os1BiJcw5RCsCF
         xSfrZPhlqnT9I0/0yyvxTJ+Npk+6ARbDUP69u5VwqHAiYqWVHKtKYVwcs9FqLSXHeim9
         6PLVPSsTqSqR36HHT9C7lRI47i4aL9BZnmhIjYnBpp8u1p5W4ZJAZwfngLaHkdI9AKOf
         VkbDLKGDut+ANc+Cdcqfi3GiQxq/8w3wgIZXkf224R1sRt9qyJ7oppTrbdPoGL/M/J8e
         poOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741252410; x=1741857210;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1HoOSsMEgfFSy1djvQMr8ahj4WRViig8qX0qsqefTg=;
        b=Ov3PJqB3seX0gAGU3h3pLFNf563jep7fef9HPCKMXHsooeLSRIrSJnz/t9Purm33l4
         O2I8ivm+71Ifg9d12HxWB6GGJyzPjD0FzPKfQGfGdtbY3sLkIDuIFUdsszekcgfDv2Ds
         kivmDpDcSg9YSzRuNjWHEcCtY5Zq1rf3fSi9DH/lak7AhXyQnd+e+qgx4SSuX00QbDfl
         NlxVwNKXS0pjKgu2Zy3K35ASqSqyGZl9/PBsNKY+Ek9fKI95367htvs4+6FAwQPz6OnO
         Zx6wxjB1lcANz0PtC2meIEBF1AR941udz+LqCtQGxNuM3fPmC3AHsXjWWftf1tMuFZ0V
         8j9A==
X-Gm-Message-State: AOJu0YzMK+/zucGqDaTiqKYGaBp+1k7jdI8Z6NZSoYylpoCiDJzRz0Fb
	8LLNoGvkD6j95XmPwWOobRs8Dks4TBtFlD20ignuLyTQTxwURX5eF98k7BBfjYMpOK7P5Q5uZao
	HGXM2iVVPjS9hIEiOVrxCYx8TJMU=
X-Gm-Gg: ASbGncttXMrBrU838ES9ibSEdZqiwQBAPM+QfGTJ3fcSSfvJlV0AizFwKcrfbprc7V3
	P4pXctXjNXwgDuNFOdPq6ABI6kItPirnLPi07GBRhX8kDLIA0Q9CdkDNQ5Mk7QgDbHed824WkK3
	O49YTnTuYpjIkh8f74WAOaWL2+6jU=
X-Google-Smtp-Source: AGHT+IFHMgeQ9/qSPtvFsnKzC6u1AGxP/mu87VFtjCFBexcVLK+H9m2hZcnD2h6Kcajn2j8Xhnk7R9GHbwrV5BwRGKI=
X-Received: by 2002:a05:6122:a0e:b0:51f:a02b:45d4 with SMTP id
 71dfb90a1353d-523d5003fe3mr1314872e0c.1.1741252410578; Thu, 06 Mar 2025
 01:13:30 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Mar 2025 04:13:29 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqjz93kwcm.fsf@gitster.g>
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
 <20250305-245-partially-atomic-ref-updates-v3-1-0c64e3052354@gmail.com> <xmqqjz93kwcm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Mar 2025 04:13:29 -0500
X-Gm-Features: AQ5f1JoDTQKU5Y8F0c9Y_RPxfc0CTWu9j9Ie-QEP2Y4KewXm9s84p7-1P04QivA
Message-ID: <CAOLa=ZTQ0MhA=rYJ7UTXReRBMJ=YA3+YqKZX05UndM4J1W9CAg@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] refs/files: remove redundant check in split_symref_update()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com, 
	phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="00000000000065beac062fa8eb4f"

--00000000000065beac062fa8eb4f
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> In `split_symref_update()`, there were two checks for duplicate
>> refnames:
>>
>>   - At the start, `string_list_has_string()` ensures the refname is not
>>     already in `affected_refnames`, preventing duplicates from being
>>     added.
>>
>>   - After adding the refname, another check verifies whether the newly
>>     inserted item has a `util` value.
>>
>> The second check is unnecessary because the first one guarantees that
>> `string_list_insert()` will never encounter a preexisting entry.
>>
>> Since `item->util` is only used in this context, remove the assignment and
>> simplify the surrounding code.
>
> It was a bit unclear what "this context" refers to.  We lost all
> assignments to the .util member and that is a safe thing to do
> because ...
>

Definitely could use some clarification. Will change to:

  The `item->util` field is assigned to validate that a rename doesn't
  already exist in the list. The validation is done after the first
  check. As this check is removed, clean up the validation and the
  assignment of this field.

>> @@ -2843,13 +2835,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
>>  		if (update->flags & REF_LOG_ONLY)
>>  			continue;
>>
>> -		item = string_list_append(&affected_refnames, update->refname);
>> -		/*
>> -		 * We store a pointer to update in item->util, but at
>> -		 * the moment we never use the value of this field
>> -		 * except to check whether it is non-NULL.
>> -		 */
>> -		item->util = update;
>
> ... of this comment, and the "except to check whether" used to
> happen in this code ...
>
>>  	 * be valid as long as affected_refnames is in use, and NOT
>>  	 * referent, which might soon be freed by our caller.
>>  	 */
>> -	item = string_list_insert(affected_refnames, new_update->refname);
>> -	if (item->util)
>> -		BUG("%s unexpectedly found in affected_refnames",
>> -		    new_update->refname);
>> -	item->util = new_update;
>
> ... which the patch removed.
>
> OK.  Makes perfect sense.
>
> Thanks.

Thanks!

--00000000000065beac062fa8eb4f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c016b1b93862952f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mSlp6Z1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meEE0Qy80dkJhb012d1B4WHBPVlAzTS9XcHZiZFc3VApaNk1RbGV6aDdK
Vy9ydGVyYVJPSDRUZEdTZ2R6aFlhYXlmWWZaVWNKNXFvYk92L2Uwd0ZrTGl4NklqaVZsS0YxCldX
c2d4MDlBRTdLOUxEUFJ0Y1ZoQXlyN25XT2ErY1pOcE42SWxtNFYxM0Y1bndid1BuaktONHhaZzFM
VTQyeXoKejV5Zk4wbkZmU21vVzBlWWRrNm02b0IzYWdSQ1BZemdaRno2L3FnUEtZNE1XNVZ6RENC
Y1FGbkVicTFmbkxsWgpENDVXVE5iSlpyODd5TURDWXQ2TCtRWjVoUnliRXBjaTJpV014V2JZcm1V
NmFXcm16d1pjUnZITGVkbVpYeFg4CkNSc1dQWjV1WTF0TXpJTUdEa2ZtMVk0cmZjZlFGSmo4QmZy
MFFQOHU3bGhsK0lsWjBsVDBhTldKTm5scDduM1MKUWE4UWhqR05BNnV0Zk5hUE1zcTgzU0NCVGFH
L3dkZW1EMStQMWNPWmhmL0xISjltVW1hT1JkWVFQSUVqdkxMMwpUbWVXc25MUUdrWFpiNkdGTGVI
N0paZy80SUJsb0FOQzRmVHRxb1lQNDBxMWVYSDd4emg1YnU4ODA4NG1aY3pNCityS3pzdFFEV3BK
QTAyUXNab0YralV2eW5mUktFMjRqdFBPbzd0TT0KPUFIOE0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000065beac062fa8eb4f--
