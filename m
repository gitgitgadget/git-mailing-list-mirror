Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF3517C77
	for <git@vger.kernel.org>; Thu, 23 May 2024 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486625; cv=none; b=a1FBSfBIikdGLRdl3l80zX+qXTAyl2w6V1mulRBrewjd3V3qbKLvWz+m+r6lmpQSnEfdp8IgFdDCKwMMHH/iy1FlR2DUNhPrNO6VxwuVPHNGKwLaKH1NbX3gN/sFSlW5X+lA5QT74rpNhiO7WcjYasaFLUGGvqDBX1iJ7navkV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486625; c=relaxed/simple;
	bh=gRC1KmQ+Sjp5Fu1F0XfUDD+OR7NrqwAG0sCMGzRDLwc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8zk3HB6qhBhfxOdJeAsPv2IFHdoj+cWGmZ7Te+KX50JVW1prOy/DaTtZGBD1/F6h4bPv72fDDLMP2Dx75kv36hkEGVgyrUfr1Xe/y8DorrqVfQkVGuY+vFzO7JecAK7rBVYMI0xFM9IZGM4K5zSo8g9ou3Lq4o3rC5ntJv1U68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2qvnciq; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2qvnciq"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e73359b8fbso50203101fa.2
        for <git@vger.kernel.org>; Thu, 23 May 2024 10:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486622; x=1717091422; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XEhA/xkLCbYvzP5O5Ec8Hla4G950QVKTBeIdukSHJBQ=;
        b=Z2qvnciq/gvzCwXf8ZDut+SKeQeFK6ultAHtKhUjeulAKqgt5SoE/TG9c/bPsoXeME
         pOlJV2X8xQjotUV97sY5+xecg1XEnHSJ/lYmkQ9hxEzqnxN7vD9ZBwmNBkNtFtTZTSsK
         F6VJb45ZsKOr0gfuBFluZztO4OvD/E57IrJyzm+DObSsp6FgIV3WkJU3RX8DOHxguEMr
         /gxbolDCq4M6vm2y9SD5d8a/HdBvCzsanDk4mZzh8q72ilV9BwMulyQaYPe2iT5+hH/T
         cYN5IPzOYG2mYLknRA5gXPbuZvkHs+2QZhVCiF/r8qU7aDQk0aWCwGSbweqhUk9bsIuC
         ewhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486622; x=1717091422;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XEhA/xkLCbYvzP5O5Ec8Hla4G950QVKTBeIdukSHJBQ=;
        b=lggnHSQuNK90xJOykmNsaaVugK9U33MOSmGx2s7+PVLGpslMVn+1+iAzMGFBD5/iYQ
         2898cqiqKcnMp+qEykFQ6It11FJfo8/5QxpBlRzZTpp8mCVDN5o8PZFZt/l/KmUQ1nRH
         gDBsTNhj1uhVJMpQIIn2Of35sgm7DCklNyFJlZaoFqWDRvBJ8g9YN8lgPI15IpisF75N
         +lNWBO94/rcf5Ns3tcDczfoJMsnzjhcK0sYnh9ZVBxLktruMaWgIfTBu13UdtyQWltZC
         lUBvZHkUs4ZJ73rOxnZKMLJxclijx8Lca+qyF4ZO4XKO33k5nA+ztJwuRpfvbTabyKPs
         WfsA==
X-Gm-Message-State: AOJu0Yx//xS4zD9cBK7xFymRo0t7eERxXN6DziBMR4+RoGs/MKnkrdVq
	Y6nTVUJhqNWax9e6BTHiz74GBA5llmwBQFDt0iO+BJdxXm2uxcAZx4iq7C+bXBUFtBy+fOiuwUG
	tCKj9Wi8lu0S/XFEuSqn0GCv06FVTTt1+0xRVBg==
X-Google-Smtp-Source: AGHT+IHgwd+mx5tXD7Oor6TfrXY8gwZ8CKWcR/EQiyDORmGsa2GEeYvIshkBJ2BRKBE3B6zsIhfh/wnt7aAeG1wujr8=
X-Received: by 2002:a2e:9bc7:0:b0:2da:a73:4f29 with SMTP id
 38308e7fff4ca-2e9494fa890mr51221451fa.30.1716486621358; Thu, 23 May 2024
 10:50:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 May 2024 13:50:18 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqr0dsv6e8.fsf@gitster.g>
References: <20240514124411.1037019-1-knayak@gitlab.com> <20240522090326.1268326-1-knayak@gitlab.com>
 <xmqqbk4wy3ji.fsf@gitster.g> <CAOLa=ZS31CuL8kDODNfM5L8gXN6RUOG5uEP5Q9JzEuaxtLEZ8g@mail.gmail.com>
 <xmqqr0dsv6e8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 23 May 2024 13:50:18 -0400
Message-ID: <CAOLa=ZQq_ce8thcjxMitDt8s0aiqVUWt8A43ziU0Zd5F2Joorg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] update-ref: add symref support for --stdin
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000540624061922af6c"

--000000000000540624061922af6c
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> The patches 1, 5 fix small issues in the reference backends. The other
>>>> patches 2, 3, 4 & 6, each add one of the new sub-commands.
>>>>
>>>> The series is based off master, with 'kn/ref-transaction-symref' merged
>>>> in. There seem to be no conflicts with 'next' or 'seen'.
>>>
>>> Wait.  There is something fishy going on.
>>> ...
>>> Is this actually a single patch submission of 9/9 alone?  Patches
>>> 1-8/9 are all old ones that are in 'master' already.
>>>
>>> Puzzled...
>>
>> I think this is just a mess up in the range diff, I haven't changed
>> anything locally. So adding the correct range diff here:
>
> Quite honestly, I care much less about the range-diff that is almost
> unintelligible than the actual patches.  Your title line says 0/6,
> your updated range-diff presumably have 1: to 6:?  As a sanity check
> mechanism, the list of commits and the overall diffstat is a more
> useful part in the cover letter message so that I (or any other
> recipients) can use to compare against the list of messages that
> appeared on the list.
>
> We may want to teach "format-patch --range-diff" to place the output
> of range-diff _below_ the list of commits and the overall diffstat
> in the cover letter (and at the end of the patch for a single patch
> topic).
>

I usually manually add in the range-diff, which is probably where the
error came from. I didn't even know about "format-patch --range-diff".

> I'll ignore the range-diff in the original cover letter and see if
> the rest makes sense.
>
> Thanks.

It does use the same base as the previous revision, I rebased in place
using 'rebase -i' and amended for fixes from the first review.

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Wait.  There is something fishy going on.
>>
>>> Range diff vs v1:
>>>  1:  1bc4cc3fc4 =  1:  1bc4cc3fc4 refs: accept symref values in `ref_transac...
>>>...
>>>  8:  4865707bda =  8:  4865707bda refs: remove `create_symref` and associated dead code
>>>  9:  4cb67dce7c !  9:  2bbdeff798 refs: create and use `ref_update_ref_must_exist()`
>> ...
>> I am confused why we are seeing a total reroll of such an old topic.
>>
>> Also you have one more patch at the end.  Neither the before or
>> after version of 9/9.
>>
>> Is this actually a single patch submission of 9/9 alone?  Patches
>> 1-8/9 are all old ones that are in 'master' already.
>
> And then there is a mystery of this v2 being a 6-patch series.
> Perhpas a wrong range-diff was pasted into it?  If this were truly a
> total reroll of the previous 8-patch series with an extra step
> appended to the end, it would have been a 9-patch series, not 6.
>
> Even puzzled...

The v1 of this series is also a 6-patch series, this is not a re-roll of
the earlier series 'kn/ref-transaction-symref' (which is already in
next). This is based on top of it.

Sorry for the confusion though.

--000000000000540624061922af6c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9eff86022cc7e999_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aUGdkZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN2FDQy85VDQrNkNGL1huMkZIVks1Z1JTQ0RBeEtTQwpYdUkrZHdBdzBP
elBKa0o5TzFzWFh0TGxoVm8zNVhJK2pjQnJrZnZhSWhzN1JXdkFlNVR6Y1Z3NW1FWXFleGZLCkpK
R1dEMy9iRkJyWis2d3hCVUdFd0Q3VktoZWFVWjlQZDhVQzFNYUQrQ2J2bCtScWk2VlhDN3FiTEdJ
ZHYrbTgKbFlnTitUN2JWQTRyU2F0NVNSMEROS25hNVFtSTV1b3lPTXFWN0l2eTlDOTFHSUNPU0Np
ajJQVkM3RGxKTFdURwpKblZtdjk3Z0Fhek9yb2sramMxcnNoQnRmNTIraW50UjZnYVI1Vm15QUJa
a1B0bndLOWpEa04xTlp2elhFVDF5CmxwTDVDWDZRU0x2NjNxZGNQQ1NHRWlDcWxDOEVDYm1LVG1Y
UWQrL3JqUXlCZXN5UkZKalkveDFJRE5ubzRNNWEKaFJ4OW50WEVFdk9JVTJjdXZLR3V3b294NTBD
Nkh0aEdTZm02NTBLaThnOWprZi9TWThadDFQNFRhdHVVU1NiYgpGWGtzdE0wdVE4TjUwcG1zRnR5
Nng0eWpKcDRtM3hhRDRNR2dyVWovKzdXK21KaE9LcDRMUXprQnBCb1JBRUZSCnJpOXVIanhXWFZK
YW5GcjJ1Q09kTEFYcjRHZno1VWJhZjJqS0xERT0KPTRVWFUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000540624061922af6c--
