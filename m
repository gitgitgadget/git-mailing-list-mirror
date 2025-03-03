Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B66230BCA
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741033065; cv=none; b=MBjrdfU8XEeY20CNlARVG98xeNvx0rUvsEmwfGefKxppWlL4gVnnaaktmAH7qsnqCvY7pbt8TGogq22RXIjiaWBcH93G10rXDZxz9vTmNeKrGDmRCQtE3K6DCFxI5Ze3kKU5SB2uaGSMZXIFsE+s0LO68EfCGEBXDAG+uORtH1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741033065; c=relaxed/simple;
	bh=xmoQbeXVsspcS98FviME2NBoxQkWxKNvSa0NxTHBesQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dwhHwl+8EDgeyFV8XLPHTEyleuaw1MgSZwKC0o1B6XtnlE6XL4PG96nr2IeAyp+DuNcHsRooq7T21dfhSsapJO6/pmG9L6advtFKFXExyIj1rN+s2cFOj6+WY2pl/HCjeP6oahs9OI6sXF/rdqzvBOV9G+5mGfKkSI5CUtWXKJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=err1MxmX; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="err1MxmX"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-523a6fbf025so233462e0c.0
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 12:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741033063; x=1741637863; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jy13OFV46G2FYRdJuJIwRUWXhv6SKn3UVSRsa8zjzsA=;
        b=err1MxmXNisyauzsNYQ7xYkuWKQAHMoEyZSR0bR3CBCNwI7BBIrXhphS2X/vsrhVxg
         JU44j/ZWj1A3vKFrwvLvTW4uz4NVtUjdfTQ21H9vWPiddBn6JrpLTdIwQl6vHKlRLD6r
         gLeKGsH4SC9sLHpTdX6IwjeDXfSZ+riN6k2wLyDDGIIlPMRRXgzI2KulkyxOjA9RPUey
         iwPmQyGrkVrpDuuxfFp3km4XHWSrOuP1ILDHtStf30FW8OQmjB4boSDfu3Ohagvcrb0q
         PmGOd7D7c8PK1bWJW+K1oYc4J5eDZrpZkppi6FmAUwEUVERSbDJ7/zo+rp2tuTst/LP2
         o4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741033063; x=1741637863;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jy13OFV46G2FYRdJuJIwRUWXhv6SKn3UVSRsa8zjzsA=;
        b=hQYRA1AorLtB+hselbHWJRkneJpEyKkDZG7PwoKs95LLhd6BwwDXr2qyd5Ke2dBLz0
         +lr2hQr3RI3YqY8ju7AK86gKLWCglm2CTVyLv9PDFjhgz8hEEtBmj4QyBcaUuRQUxOjS
         e1zsIS6cBvbORYrwf2z1i/J3T/5n0m9rILwMuJxHokv3gIgFfIsrE5K9q8w3vNeyShXY
         HqGmCZZbObINJvR+SzpSF77QIdlVwNHnot5nMp5q9fe4um9hQmFZ6ZIsjJFTvnfM6PcV
         6zvrhH3fJJi5hAG5JYIfvhGfvlNq0kjDVD+EipNnrDqZHUdxIz0QHrX8PPJYEfLEprja
         qy2A==
X-Gm-Message-State: AOJu0Yz6WUUFGvxmvcLkq5K5qQzLrY/mZWdtAelEHh7YGASASUtx8HKe
	dcGMeUZKdx1TiJsa11zCNO6Hmfrs2JlUn48ihMZ5ni8cuCtXVo8nS6l56sPPIR7uFguuMyEKaRI
	Zc+3dMUWWgR2rVlqYy/MKKsmTU7o=
X-Gm-Gg: ASbGncsvdPHQbXedZb0c/PR5dMPzSmDqb/dPiuA5UHvNyq3d128HhBPq+8Xbv5nKCH6
	/oBpyE8Je1s6y7CGMiRoLtSVcIpOXMRYQ3JoD81vONH6a7MQ25BHZjdI/5xky5NA9cwMhNuw4B1
	07OhvWXFHMbBCL9+S1494ar8VrTWk2WNXQ6h1d8D72uCm5SCLqVIa43zhuSp8=
X-Google-Smtp-Source: AGHT+IEu4ckLauZmBpyBa+HgYL07woklRE9zcbtb8EXlo2+GUZPEKw2Xw32Bye2/dAQEsSHzv92a3c5JC9S6okEv0jE=
X-Received: by 2002:a05:6122:2788:b0:520:af9c:c058 with SMTP id
 71dfb90a1353d-5235b7984bcmr8241085e0c.5.1741033062519; Mon, 03 Mar 2025
 12:17:42 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Mar 2025 12:17:41 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z72kjTRDNOM6iFkY@pks.im>
References: <20250225-245-partially-atomic-ref-updates-v2-0-cfa3236895d7@gmail.com>
 <20250225-245-partially-atomic-ref-updates-v2-6-cfa3236895d7@gmail.com> <Z72kjTRDNOM6iFkY@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 3 Mar 2025 12:17:41 -0800
X-Gm-Features: AQ5f1Jp7UUN9TUOrYW-NmZX7Y4_haVzyht-VGf21B-JRQdQBhrIHU6QlBW15zW0
Message-ID: <CAOLa=ZTwng_NJvTZK2-Rz5JnchsTFCC6txakWcEsYh+41nqYmg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] refs: implement partial reference transaction support
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com, phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="0000000000003bf782062f75d9fa"

--0000000000003bf782062f75d9fa
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Feb 25, 2025 at 10:29:09AM +0100, Karthik Nayak wrote:
>> diff --git a/refs.c b/refs.c
>> index f989a46a5a..243c09c368 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2726,6 +2736,27 @@ void ref_transaction_for_each_queued_update(struct ref_transaction *transaction,
>>  	}
>>  }
>>
>> +void ref_transaction_for_each_rejected_update(struct ref_transaction *transaction,
>> +					      ref_transaction_for_each_rejected_update_fn cb,
>> +					      void *cb_data)
>> +{
>> +	if (!(transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL))
>> +		return;
>> +
>> +	for (size_t i = 0; i < transaction->nr; i++) {
>> +		struct ref_update *update = transaction->updates[i];
>> +
>> +		if (!update->rejection_err)
>> +			continue;
>
> This kind of proves my point that `TRANSACTION_OK` is pointless and
> leads to a mixture of using and not using the enum :)
>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 3b0adf8bb2..d0a53c9ace 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -2851,8 +2851,18 @@ static int files_transaction_prepare(struct ref_store *ref_store,
>>  		ret = lock_ref_for_update(refs, update, transaction,
>>  					  head_ref, &refnames_to_check,
>>  					  err);
>> -		if (ret)
>> +		if (ret) {
>> +			if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL &&
>
> Hm. If the error values were defined as a bitfield we could refactor
> this to not be a flag, but have a `transaction->accepted_rejections`
> instead that allows the caller to ask for only a subset of rejections to
> be accepted.
>

I did consider making them bitfield and even tried playing with that
idea. There are a bunch of side affects of doing that in other
subsystems which check call use the reference API and expect '< 0'
errors.

> I'm not quite sure whether it is a good idea, but the logic to handle
> all of that could be self-contained in `ref_transaction_set_rejected()`:
> if it returned an error code itself, it would swallow any errors in case
> the transaction allows a given error, and bubble up the error again in
> case the error is not allowed. The function could use a rename in that
> case though, e.g. `ref_transaction_maybe_set_rejected()`.
>
> Patrick

I think this is great idea, it does cleanup a bunch of the code. I will
add this in the next version with the rename. Thanks!

--0000000000003bf782062f75d9fa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9a9a89d315e850c6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mR0RtTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMi8xQy93STRSeURYRjhwS2lkakd1eFgraWg2Y1VFMwordGdlTWVKQU9s
T0h5WmZiNjBmUXlzZEpaNU1WQXFOcTdmZHE0WW4yc2Q2YlZPdjhnTnpPWk5kc0FNT25aT3ZjCloz
NSs0VVlSWU1sL1pwWUx1bWtSZFB6TGZVbzJxSnFzZFFBUTYxengza3FWTkRUTy9wU0hlTi9mNndu
OEQwLzYKdFdSb2pBcGVGZVdSNkF1bXhiajJ1SzFtYUtJb0I0SUEyRlRLeTNNeDBkRGJmeCtZL2Jo
c2JaU0ZiRVB6WlFBOApnQlRwUHRFQUxubXR3VVNpN1NubWRpT29GYVRFc0lRT0lsbGxXaHJVeFBC
SFQ4N001NGRWVXU4blBrQmVYZ0UwCkVwS0ZOc01SY2dVUVVuVVJUdTBvNC81R2xqTnNpOFRnZjBt
VHZadSt6VzFmMXVLMEM1YWR3YnF4dmFUMEN4dzIKK1d4SDRnZzMzLzgxT0F3NUlhMmlOZzBZS3k1
NTdoYzM2LzhhV2lyWVMwOTBTZlFkbHZHRlRQVnZPczNuNlFoegovb2JjWHgxQWx1c3B4eTlNUWtR
UGkyZVNLNFBIYnpVUURBQWpoZ09HbGVWS28zSmhaZWxLNDhkNmJQRHp0Y3lCClZ6KzN0RW5yOU5U
Mk5ST2JiL0lwaEd4T2V5dFlSYmdSNVRYeEtRdz0KPU5lVWwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003bf782062f75d9fa--
