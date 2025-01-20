Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BFD1DFFC
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737375500; cv=none; b=LWrWLVv38Q5i2rFKKmLeAlmuQmtEFq2xTrYtLByp9ky3cs3t2UkWbM0njZRyuZob901OduwBymppV1LMrrgVhtsRoaOgMd1IG7YOPx4/k0jL/uS8on7hXEeFi4FeCPIrfAmgC/1bkupwdWJvQX5mhCE7MKuf6DHMBOyPEkmOOBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737375500; c=relaxed/simple;
	bh=Pz7EztZh7Fqih+YAJFXy+5FZoFAq3tAcbE2ve/yE0Wo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXB6571XYjTUNsqHIv5KCJCo3LZrwdFC7zsucy0bS3Nm/F09jaN2t+7WGdJlh1Kxwwr4hEPbSm0f3H9vcfnNOFi261VurNF9OQpsgCiJ0c0WztuuAZnlkcGj+5yYFCraOwJ+0KPILKFXSOSW5pEYh6/jH8CVumFBIhm+qnlHPkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFQztPks; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFQztPks"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4b1279ca1d2so1086330137.3
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 04:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737375497; x=1737980297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ywRGoRK3FKOycO4ngAJrK3VfHS5sV2vE9g/cl98KTeM=;
        b=mFQztPksMaeCOIgX2FQ35U9/Q/6Zwasjz8fWmVYNmKy3EcCCy3MLKEYw61UG5EhvVk
         usFDyQnjWb7mVvbrRN0Og588mHswWwj0UD3WHn1O/JguXSPhHH8f9rUhn9ZZYJ5S2CzX
         e2mObEonHweiaYQQHGYCeWp02in1SzxvS4UvRgnjPihePfnluao5seHueE3TimFXyUZF
         ohaEyIiZiEXj17OhD/l/b5lr3kKOV/ogUnqZVcKdppNH9MgyCxs7KV9jfNc69V0yObak
         Y1/hP2NOzECCSUf+1leeYE+wD+UY0ow5DS+xQNgxVDjIorBTLaY8xS5Hq27JkEjUTt3p
         D29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737375497; x=1737980297;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywRGoRK3FKOycO4ngAJrK3VfHS5sV2vE9g/cl98KTeM=;
        b=f08pp3KaiCwxNkUX5asnJlLeXx2Qo4yhMejRZEX4LCkQyO1ry4Djd+mdz6UwoNxS/A
         zeltcuOHwldYWDH6SCXw5SQum8pDg7BmKfxVQFgYCKF3/o8QJODXM4GCOttqp4IRpt8z
         4gOcnNdQUyX+kgeLuhsHtZnWSrMJ9tV7OBlKDOQE0831Jxrt5xKEd/BICmhgMoA5ApvB
         E4CBH/cCbYE5WYL9YS6zd7K8u0pnawqBeW/tu2z2ZvZaTZc3417Er46Yf7hkeqIQNM8g
         L+tjjrCaQH9Otmct2pI3Rq+mmaxQNiRTiJ2xbj9TLQOnfqiWvlE8xj65sZEJJBR9GPfo
         74ow==
X-Gm-Message-State: AOJu0YwbSAGvrmXanC5B3zzmFuFvvL1AnUcwkFCgowxdAALaNTEiUKRj
	bgxlSXPl0CSLqQcNTDvwxZR+KBuEdCwU0CfRZ127AybI/axrVzWI388e2HD4NKX7H+5eal1506n
	84xD9SQstHPBQGmIPVduimjWkIac=
X-Gm-Gg: ASbGnctILJoAeN+yQpIGRKcUm3DmJ28G+/NsEHb0FxEwULHpUTafHcItY7+ANZTxxW+
	TMtKn2lMa89i5i94k6zs7JFnqcSCuz+b1x2ZlqBVeV5u1WSX1qVB4
X-Google-Smtp-Source: AGHT+IHLmAj3CQaXOKmPKhAKPk1fcqn4wU9Vde4alDzR+3c4mnBdCe28mrCLE05DKN/3SFq2WRk3roWrpBu4b+VOwzQ=
X-Received: by 2002:a05:6102:38c8:b0:4b1:11c6:d3c6 with SMTP id
 ada2fe7eead31-4b690b84bd7mr8530223137.5.1737375496003; Mon, 20 Jan 2025
 04:18:16 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jan 2025 07:18:15 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAOLa=ZQpg+8vg+3XMcG4XyoaOMvtMV7KuSkQhJXTkFiPatO7Lw@mail.gmail.com>
References: <20250117-461-corrupted-reftable-followup-v1-0-70ee605ae3fe@gmail.com>
 <20250117-461-corrupted-reftable-followup-v1-3-70ee605ae3fe@gmail.com>
 <Z4oi55XewgX2deTm@pks.im> <CAOLa=ZQpg+8vg+3XMcG4XyoaOMvtMV7KuSkQhJXTkFiPatO7Lw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 20 Jan 2025 07:18:15 -0500
X-Gm-Features: AbW1kvZcq4miZSp8g0h4c31OPvGnhRDR5Z3dgFVnF28rI92SvV18e9sCrMP2eLg
Message-ID: <CAOLa=ZQhcGyAXCHug_5=g8qnRMPJ10xRowHNY7c0RcNH_u5=9g@mail.gmail.com>
Subject: Re: [PATCH 3/3] reftable: prevent 'update_index' changes after header write
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000480e1e062c22412f"

--000000000000480e1e062c22412f
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> On Fri, Jan 17, 2025 at 08:59:14AM +0100, Karthik Nayak wrote:
>>> diff --git a/reftable/writer.c b/reftable/writer.c
>>> index 740c98038eaf883258bef4988f78977ac7e4a75a..c602b873543790e36178f797ed9f98112671f97f 100644
>>> --- a/reftable/writer.c
>>> +++ b/reftable/writer.c
>>> @@ -182,6 +182,13 @@ int reftable_writer_new(struct reftable_writer **out,
>>>  void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
>>>  				uint64_t max)
>>>  {
>>> +	/*
>>> +	 * The limits shouldn't be modified post writing the first block, else
>>> +	 * it would cause a mismatch between the header and the footer.
>>> +	 */
>>
>> Can we make this *even* stricter? I think that this is something that is
>> easy to do wrong, and the fact that it only triggers in some situations
>> of misuse may easily make tests miss this issue. So ideally, we should
>> assert that `set_limits()` is always called before queueing any records
>> to the writer. This would make us error out in all situations where the
>> calling order is wrong.
>>
>
> I agree here, it makes sense to make this stricter. Like you mentioned,
> currently they are independent. The only way to enforce the limits is to
> ensure that they are dependent.
>
>> There are two ways I can see us doing that:
>>
>>   - Detect any state written by `writer_add_record()` and error out if
>>     it's set when `reftable_writer_set_limits()` is called.
>>
>
> Yeah I think this would be simple to do. I guess we can check
> `w->last_key` is set, since any record write would modify that.
>
>>   - Adapt `reftable_writer_new()` so that it takes the update indices as
>>     input and drop `reftable_writer_set_limits()` altogether.
>>
>
> This one is a bit harder to do because of our flow. Generally the writer
> is provided to callers via a callback function passed to
> `reftable_addition_add()`. I guess I could simply pass the data:
>
>   caller -> reftable_addition_add() -> reftable_writer_new()
>
> Any direct users of `reftable_writer_new()` would simply pass the data
> directly.
>
> I'll play around and see if this is doable without too much refactoring
> and have something in the next version.

It seems like `reftable_addition_add()` is internally and externally
called by a lot of functions and as such, modifying them all would be
tedious. Another idea is to modify the function pointer that
`reftable_addition_add()` receives so that the `write_table` argument
receives a function which would set the limits, but this seems like bad
design to me.

So the best/easiest way to do this is to error out if any state is set
before calling `reftable_writer_set_limits()`. I also realized that if
`reftable_writer_set_limits()` isn't called, the writer errors anyways.
So just ensuring that `reftable_writer_set_limits()` checks for any
state being set would work well.

[snip]

--000000000000480e1e062c22412f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9e6c93a1d66d3752_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lT1B3UVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOVRBREFDSllveGZLZFlHRG9Db3JVbC93NTVzZUxRTAppcGdpekZzM2xz
dElNQ2pDbSt6TkZpai9ZUkt2R2piaUt6QUVpNVFtTng2Ym5HU2pTd2MzeDR1TDQ5TUNJbkdMCi9W
Uk12VWZUN1ZIaDNCcnFqSnBGVFlTUlJla244K1RCdDZrcTc0WlVPQ3puUUFmT2tTSTJGSDBsL1Bu
bHAwa0EKMlMxMFE3N1Z4RFMvRStWYkR1Vy8xNC84d1JLd1BTUmd3aHg4ZzU4V2RMMDRld0RoR0lG
RmtXcDIrRzRMZnRtawoyT3pNQ0N6cmV6SlFidlN4R2piSFJuT2hyTWdQMFowcCtjTjAvM0dhZDdK
ZWVReWN5UGtQcGhhY0JIdlJ2aDk5ClZLSFkxMzRKUFpDcmsrK1lhRTVTWjM3anl6bmllTUIzbmR6
dlY2bUdjYWloQjJlWGY5cmdyWCtCMCtFYXpOU2kKV2p2ZWVUNGNOaTRMRjlIa1NYYW5zaVljN3dz
L0ZSTC9TbldwakNGWThlRzhLY1lDQjEwSER5OWszWmR3R212VQppL3RrcEdUdVNtR3d1ZjdrRWIz
K0NpOEpLTVRScE9XcTRqRi91UzlEVGxFUHd1dEZxZHovU1pxVGhjMHNkMnRhCm9kUzdUVGo0K1VN
TGwxNTVxWHBIZmIvUWQxSDFwQmErRVFGUTlBUT0KPTA5UEwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000480e1e062c22412f--
