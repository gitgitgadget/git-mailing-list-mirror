Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB9061FDF
	for <git@vger.kernel.org>; Sat,  7 Dec 2024 09:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733565274; cv=none; b=ECkbSD9sj6CiViVAnuVOFhDpHlqR4vLyQkv2E9Au8xA2lJRM8pD6hxUxzWCKBVDoPcnVfgu2ktmVODXj70RrQKIjkd1wSsMIkN+PeanbX/UpTWRfujsSbotbf1iurP3mWTGBYArqofDBcb2/QkC8zEpd8ifxOK5ycIAv4N1Beo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733565274; c=relaxed/simple;
	bh=KC+sErJ1chCC8CO6W7aHSwj6beIxzHExnhgeM89YyBE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTHevFLj+oHAEUtUpR9nSZ1yMrlEy13YGzA3kGMraulWm2GddMl0aqtdVL6PgqI9hi8LvtHuf//fkVdyIfCTOEL4w7qo3mXjfhPZNBlEW4Qi1+gRNJulweopxvCP+Z2gaPp4f3LnRcQ8HTp19rHhzBYB3TK0jWHdbYXpHWBhcD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVULvqL7; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVULvqL7"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-85c41442fdeso415939241.1
        for <git@vger.kernel.org>; Sat, 07 Dec 2024 01:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733565272; x=1734170072; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BPhOqJyDtRO+hULZFo96ZRyZq/SEUvya6GBoPDVab10=;
        b=PVULvqL7a6mXJTOA4W+rDi78XWGcZ71F3pdJf/q32sz6Y1sSe9wpI1JMAVRTzSjADB
         5tt3Ely4TIlKY/etalCdKnKW/6gJSB9ycqyyOUP/JIftrUiEH7SXr6VoklvMmPoBEIVd
         kCINp+SzRjeNBCZ/0GzSl5IHqEBQPzNEhEvkXsAi89jT0zpgzcBYBGcG+L63+Vc8QPoi
         VyaJ+k7a6wxg67DOWWdslUOeaawPQZw4frQZnlbRYTA0axFOUTo1zhMeXQqOeXRFw+4e
         zLNqUhX0VNX8Ed/eMdy5nJScTVl4HEeDXU4g4pwh6ghqb0/2hiJAQTlCDgeM/FQ6pWid
         DPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733565272; x=1734170072;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPhOqJyDtRO+hULZFo96ZRyZq/SEUvya6GBoPDVab10=;
        b=n2daxNwAbWe+w3nSah9dpdauMl1dYGuCk1NrIls7In9wLBwg+l0pZjxR6FzNsw6pe5
         EVFqFEKqZLyDFZx042Rh+jvoPx+g8ML/fDysOLGGzj9E8jNSJzMFMV3n9rQgB6Se/0L/
         rjs//cKg6y/xfabPuAgGsCf25VQEAzHo8OqM/Wdmlus8kxoj2FIfMC2ZKGCkUoUeR/nu
         mMFvfGSJEZlKEh3JTWLJRDZv5cZJ6TSobPW6PIDpXHNb7NNieByUNdl3+RV/c/lQo9vS
         C+SKIo9D0nC2RLyF0GGSZnR/AwhTnnmCOiFLhG01lja+fxeFD8uXR/+06YSmYSMYMYCj
         paOg==
X-Gm-Message-State: AOJu0YxABYEeOQbsyytFTtovY/JkjZ0PJj++WAxoJ+mlCVoe2jMrCM2G
	47ITE89PKe1SbD8buE+fo31C7DXMfSp/awmAjMPnvwEuNEH6ukAB8JN/pNAg7x8nOAkF2Z0LSq6
	7Z5dfjiIdc4GpE4PGFNLm6XR4JfA=
X-Gm-Gg: ASbGncsfe7y9UYCNsXT+2aoX8boI3ktAVELdQhhbmofaCgCVsj9tPLcpR2FGBG5GqiM
	k9fDLe/GHWP/Z9HV4/tWomLZf2iDYTAYMrtyJDKIk2iIxlGCCGB/WLfDJMJBwfx0Y
X-Google-Smtp-Source: AGHT+IGUZ51D3OctkvCFPZCkXxQFJGfASoemZwSwKcKvwecaawCT0S7iSdGyJ2VRfBrVZKZwjcKu1eb93YhDdKachHA=
X-Received: by 2002:a05:6102:3751:b0:4af:bb73:9987 with SMTP id
 ada2fe7eead31-4afcaaed226mr6473715137.18.1733565271628; Sat, 07 Dec 2024
 01:54:31 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Dec 2024 01:54:30 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqwmgcv23b.fsf@gitster.g>
References: <20241205-424-reftable-writer-add-check-for-limits-v1-1-b287b055204e@gmail.com>
 <20241206-424-reftable-writer-add-check-for-limits-v2-1-82ca350b10be@gmail.com>
 <xmqqwmgcv23b.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 7 Dec 2024 01:54:30 -0800
Message-ID: <CAOLa=ZRYDqhAPMiuAS-HGaC1huiUGgLW3hL_dDNwrFA5c8ewEQ@mail.gmail.com>
Subject: Re: [PATCH v2] reftable/writer: ensure valid range for log's update_index
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000003605700628ab1e6f"

--0000000000003605700628ab1e6f
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The corresponding check for reflogs in `reftable_writer_add_log` is
>> however missing. Add a similar check, but only check for the upper
>> limit. This is because reflogs are treated a bit differently than refs.
>> Each reflog entry in reftable has an associated update_index and we also
>> allow expiring entries in the middle, which is done by simply writing a
>> new reflog entry with the same update_index. This means, writing reflog
>> entries with update_index lesser than the writer's update_index is an
>> expected scenario.
>>
>> Add a new unit test to check for the limits and fix some of the existing
>> tests, which were setting arbitrary values for the update_index by
>> ensuring they stay within the now checked limits.
>
> Interesting.  I am a little curious how this was found.  As long as
> the other parts of the system (i.e. the callers) are not buggy, the
> update pointer will stay within the range, and that is why I do not
> think I can write an end-to-end test to trigger an existing bug that
> would be caught by this "fix".

I was reading the reftable code and noticed it. So mostly luck. Agreed
with what you're saying, I'd say this is mostly a 'safeguard'.

> Fixing the existing unit tests that
> feed a wrong input and expect some right outcome is good, but would
> it be a good to also have a new unit test that validates that such
> an incorrect precondition for calling is caught and the caller gets
> the expected REFTABLE_API_ERROR as a result, I wonder?

I'm confused, I did add a _new_ test in this patch to do exactly what
you're suggesting.

> Being able
> to trigger a condition that is harder to do with the end-to-end test
> is one good thing about having unit test framework, no?
>

Totally, these kind of specific changes are perfect for unit-tests. Plus
it was very simple to add one too.

> Will queue.  Thanks.

Thanks!

Karthik

--0000000000003605700628ab1e6f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f227678ace8e32e8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kVUcxVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mODZzREFDUG1rQWJpMmNXYVdlKzR0Y05BUVdyeitsNQpmZWV6VmxhNmZs
K01OcWJQN3JqNUJjNnhuSE4zZ0pwVXpqaGVVWVMwUW9VV1Q0NkRaVHU4YXQ1MXJtQTdSeGtmCkpH
bmR0cFJUTllhZllIaHY1Y0lrekRuRjg2THpLRE1pSFdHNEo1MlRGUUloSEtiZHJ2WXVxeHZPcTJw
dkNoZHgKTGY3MU1DL042SEhLd2pPcEpnMFVCR2JGYWwyQlZIcktab09DcWs0cnZEY0kwODhmY3JL
L21mZlpOUEtHd0ZLdQpZUjZYNERLUDdnR0ZUc2h6cHZCWkxWK1o2SGZtMHBRYmVHWXpKeXo3UnlG
RCtZZ3g1amxUd0NUcXNLcEgzVENICkhsSnhEVi8rWDM3WlF1VXRwOGIxdy9YaEdkRm5YUjBwaW1C
OXFxeVZRVUtDeStHVG5tTHpBRlFUV25uU2c5eTkKaHJGK1NNVEtDdkJVd0tEZ2VZeGpmZHlZeWhh
T2hJeStqQ1BVeTdpbFBoV2Y3ZjdIT3kzcXZ4ajRsTVN6Z28vSApOMlRmZW1OL2pJUHJ1U2tiRkJB
YW40VVdSRWExQ1VOWHpPaEEvTUxhdGRoSVR1dGRIb1NrdDRzWi90MTRpN2JvCmFrakVsdEV3TWZG
MzE1U0RSNHZPc0NMVUtFc20ydUNxT2hyN0VyRT0KPUI3RSsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003605700628ab1e6f--
