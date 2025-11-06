Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EED145FE0
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762417135; cv=none; b=FmOwBIL0OdbQwgQAZv94CTBJOORgP37R8uBDCjNv1+BnmBRBVdvmcMwXb1JhEsKEYCsL6ip0Uo8Aa2+IkCCBcCKVFpdUBZz4XdLUa+6vwjf5Q37AQNoAyCdwhLug9NK17oNMSzSGwwAAP5LUJnKh/9li4oqZgc6ivAMHup5pS/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762417135; c=relaxed/simple;
	bh=GppSTNaB6OAY2nE7UbvQIbO2vGxcMjh2g5/I27QBBNU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSxQa2EFkqWyGG5Odwrhe+7b8XWHUBjCijAvU8GtR7AQInjtJeng7Qb3FYVRPAGprE1ugCu3/bgX+b4IgjwkJjZkuS7lpJmTDniwj5NzSp2JAol8jIix5MknFB9yu6kEieRbVaubktkcaZA7/cqBkGqtrDjWhh3nl/r5VcoP5EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzDLsrAc; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzDLsrAc"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5dbae7f85a3so258430137.3
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 00:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762417133; x=1763021933; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sJoj3ddqqMmwAcGDcV6kAOQLd69J3F/KrN5kdYzkd/w=;
        b=DzDLsrAcgFWusJEJjpeYbZ2FxQ28cB4YDqZcJt4A5bFD3KiLXqza0AaPRjntO+9xKK
         ZZRwz8nmYQoXsS97G6cO9/fF/LXZpCAMVmiRgN6DzAdBi8bzcUP4z/SldZfAckia38bA
         9Oc6X84BXp0rBwL4toeAZqEPQVYygEepR+0uCpiA8P0y9UtGkmyE15gTT9Tf4eNRRn61
         ZkhxfP5afFlxldlA191nK7RQy5ZyksdB1x4IbkZhRSJIhh1WuOQ9DXII4ydA7VIe4lnT
         cdTOsQnyUcpOIwWwrm1X/7Hz1cRGPhc40Ri3QACYBrFKLPojM/7IpCAiNJ/FMrgry8uO
         enEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762417133; x=1763021933;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJoj3ddqqMmwAcGDcV6kAOQLd69J3F/KrN5kdYzkd/w=;
        b=VYbe9jOLOTu3VIOZRyeVSZi0+OG6R1JU/+Sj9ynGJss/eXxZe3+YcWS1J/TNEn1S8W
         VHNAN09dExzoQ1nkgh4pDnBQG7Vr00C3qPZ/jcnMQls6ezIOzTcCr60QBctx9npsz/an
         f5n20RxnOi+coh7EmVF5VAKJ3nJWAARhi8uq+FrisT7Avompm0/Zeiq1wloKUWG4xO3h
         RH0O8ihhi5bPttf/7o9Lw1DX2OO1UL+z0OliiokhnJT9IKcmO8sbzGvhPT8NaMPxdvKH
         585rj/w52Kh/nIyIMFZZM8NqrbBDyL0HrTNLS2Lw0TtGBQ92zD+YIfN5uICBB+6W1nxc
         wuQw==
X-Gm-Message-State: AOJu0YwQR7XgCRZDucR3rYfyk+pyGi2m1yoZ8i94pTiFO25gSsxkXx2g
	iPKoOCt5kegVdSImQeyCz7vpTQhgBYhaPVX0JMqEyER4+arWQ6Hj/IIQuv1s/on8sddOO/Wwu8J
	nck/0GKjX/e7oskF20riJQqIyOEquas5NRDY8
X-Gm-Gg: ASbGncsBSD8H7mxST7oyMGM3TcAX3awCizys9tUhT4B7aQY2Fkfl73VMaMCnwSTA+4O
	P86R1DC09z7NEb3pGF4BeEOBq+V+m96SUZWdqptNUd3FynDzB7Rfd6qn6WgsEw5KVgNJcDY4UcW
	vNT7eopkkO59R8JGRwNcU+VPU/EsA3grZs3C0tMFW4YO7BK6Xa+Mx86B9hQCkSSgHzqX69W4BZB
	dJmI1dt38pTnHaA8nesxmXuIAY0CbSckvPTSvF6NGJ80Cg4/jyMmDImItr+RkCsP58NdameSawq
	6j+lw24b9oqvBlZIArLy7UdseZoAqC19ADLbfw==
X-Google-Smtp-Source: AGHT+IHByuKuJtT/bUl+wLsSSmDF7GjoDJP/VavnJNX7U06nSCdP99d7JtVDlIeRz99F1DWYJRoQW9BO7ymAD2dXiV8=
X-Received: by 2002:a05:6102:3713:b0:5db:ce1d:679c with SMTP id
 ada2fe7eead31-5dd88f0fb54mr2172606137.8.1762417132709; Thu, 06 Nov 2025
 00:18:52 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Nov 2025 00:18:51 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Nov 2025 00:18:51 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqms50l594.fsf@gitster.g>
References: <20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-0-303462a9e4ed@gmail.com>
 <20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-2-303462a9e4ed@gmail.com>
 <xmqqcy5xpmrw.fsf@gitster.g> <CAOLa=ZRD_zNCnGf3ibU=X04vC8WjxzRVAyg+OwPr1Hf12kSGgA@mail.gmail.com>
 <xmqqms50l594.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Nov 2025 00:18:51 -0800
X-Gm-Features: AWmQ_blejQ7D-6KJh-4Eiu-KiofYXSberNJ7mcpN0bdZxOHVtyorqqPNMGIrA6o
Message-ID: <CAOLa=ZTTfaGsQrK-e5c9h4nMk656GM0Mue6Ytie4GOes4n_-5g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] reftable/stack: add function to check if
 optimization is required
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="0000000000002453550642e8b7fe"

--0000000000002453550642e8b7fe
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> The reftable backend performs auto-compaction as part of its regular
>>>> flow, which is required to keep the number of tables part of a stack at
>>>> bay. This allows it to stay optimized.
>>>
>>> Sounds very sensible.
>>>
>>>> Compaction can also be triggered voluntarily by the user via the 'git
>>>> pack-refs' or the 'git refs optimize' command. However, currently there
>>>> is no way for the user to check if optimization is required without
>>>> actually performing it.
>>>
>>> Sounds very sensible goal.
>>>
>>> But where is the existing logic to decide when it needs to
>>> auto-compact, performed as part of its regular flow?
>>>
>>> After reading "the reftable machinery already decides when it needs
>>> to compact and does so" plus "but the logic to decide is not made
>>> available to users", I would have expected for this patch to extract
>>> such an existing logic or otherwise make it available to new callers
>>> so that things like "gc --auto" can call it, but the diffstat shows
>>> mostly additions, which does not give readers any confidence in the
>>> new function that answers "do we need compaction?".  It would give
>>> _an_ answer, but there is no clue if the answer it gives is the same
>>> answer as the existing logic that decides when to compact as part of
>>> the regular operation.
>>>
>>> I am puzzled.
>>>
>>>> +int reftable_stack_compaction_required(struct reftable_stack *st,
>>>> +				       bool use_heuristics,
>>>> +				       bool *required)
>>>> +{
>>>> +	struct segment seg;
>>>> +	int err = 0;
>>>> +
>>>> +	if (st->merged->tables_len < 2) {
>>>> +		*required = false;
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	if (!use_heuristics) {
>>>> +		*required = true;
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	err = stack_segments_for_compaction(st, &seg);
>>>> +	if (err)
>>>> +		return err;
>>>> +
>>>> +	*required = segment_size(&seg) > 0;
>>>> +	return 0;
>>>> +}
>>>
>>> Specifically, where is the above logic come from?  Is it duplicating
>>> an existing logic but that code is hard to separate out into this
>>> helper?
>>>
>>
>> Good question.
>>
>> Most of this logic is already part of 'reftable_stack_auto_compact()'.
>> We also have another similar function 'reftable_stack_compact_all()'.
>> The former is used for compaction based on heuristics and the latter is
>> for compacting all tables into one. In the refs subsystem usage of
>> heuristics is denoted by the usage of the 'REFS_OPTIMIZE_AUTO' flag.
>>
>> The function we're introducing allows users to explicitly mention if
>> they want to use heuristics or not. This allows us to differentiate
>> between the two modes. The result of which is that this uses intertwined
>> logic of the two existing functions. Hence we can't extract any code out.
>>
>> I'll add this information in the commit message.
>
> You mean you already have two duplicate implementations whose
> definition of "when should we compact?" can drift apart over time
> (worse, they may already be subtly different), and you are adding
> yet another one?

More like we have two functions:
1. compact all tables into one
2. compact based on heuristics

This function oversees logic from both.

> Instead of describing such an insanity in the commit message, can we
> refactor to have a single central logic that is used from three
> places?
>
> Thanks.

You're right though, I did manage to extract out the common code and
will send in a new version. Thanks for the push.

- Karthik

--0000000000002453550642e8b7fe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e2031110893471c7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rTVdlY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNTFjQy85TGIxdkxaRGx5U0tRVkw1Qjh2UHVsVWxGQgpLU0FDbXFUcVds
V04zbFprclgwS1drQkFCZDlaRWVnNmtRUm54UkpWaUlUWkt5U1llQUlBeXlKZXdXUGcwZUU1Cm9E
blJ6OHIzR28rd2V4WFhNUnliUU1NME1GalM5TVB2YWRybXNaSDhlS1dxRXZEbmZ0OVduZWVNNlh4
U0JNTUcKWVRrakEzbCtxelRNVnNEVEloUGF5VTM4WitjenpVZ2szcmN1YWhQNitwVUhlTkp1N0dU
LzczZkRiVWJ2MVNGUwpaL1Y4djBhRzhZOUZ2UHJYcHBLWHNjY0RuK2FUak5KeVl0ZVR0VDlXMDVY
eTZPZFhhK1pwN1EvbG1BTUlmYkJHCklWUGtyVG82TDFQaG15ZjE5K2hnZXFIcnRGdUpTVFlZZDht
NXYyNzNUK2dzVWxIUkVBYjR2TnVtQmdBMFJGNWkKWXRvdDZIZHZhL0g1aU1NUXh5UWYrRlF3K3V0
S0EyYm40VDhKeXdTUTBvK2UvVFdjRFNUNXZEd2JiYmNCcG1pNApodUtQd1F6VWxEMmRZbDJsTWVS
M3FUSWtEbDUvWmlwNnVwRzBYRkRzcWlWVWdKVXhXdlRZOE1tR21XejFQTGpHCmR2NWdJTkNjMjUy
UEpjaTUvdjlJU055V1h6aVJjcWV6Rk8ycE5kOD0KPXlJRVQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002453550642e8b7fe--
