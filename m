Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65916209F4E
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138628; cv=none; b=nVoHhVQ8OVoNQV79ak5ts32O9PcyXnAlN0AKUvAoGFBQhrWDza7KBQ5YuTNL1pFmQPLSQ+wqzDAV7ARh7VvLdfAo87EzSIFcNENyISIIwteom10M2HVx9nC2d+qPiPG7d3EN77IKhrS7Zq0t4agolugz09lCbu8HWItDJR2dnYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138628; c=relaxed/simple;
	bh=IPz4jrJm/bkUzW1VQl/cHlLOmSyNAHD6mHhOX0lva+I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdyO6cJa5Au0DMiioVMuJbXd/BynlM+EN0fzYu31qnlTenINcuFcgTDlIh6zauVqWoLeggcH1k5jM4XlApBD/crnvQAUSve1/9jF68IqZgpUi0TWeBqSq5aLHdgbhtCFLt3ORhKvONKw2CnXGVQNzJlxFsLbgyToQ/QVDM94TWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHcvBBCr; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHcvBBCr"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4b9486a15a0so1866976137.0
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 03:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740138625; x=1740743425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IPz4jrJm/bkUzW1VQl/cHlLOmSyNAHD6mHhOX0lva+I=;
        b=VHcvBBCrdKTdsnpRq9V8x1DBevQE6H9QEF2X6XxrX0gFwTbVcizwHsrB7ve3BLOIFJ
         lymAkvXYAZkWdCj+RyW+ospjA49ecIrxTrrA/7GXuJc0cEP5w0cvONPyZNbzNol2kkbn
         aUL4g9YohvWOhcQiISQ1lwczvM32ik2ixHDZBwgYWYG+iYYy7lV40t5SAWp9YuTZe7xS
         B3bKSUZ/r3Yt6zmodB4gjQxPJGwhvTrpTZtrgVh/rDIb1gwrP8XIYWHKyd4iw3U/Qi6f
         Z5nihNpfzKfGjjG0rhMghbv3Zrz0F5zZRL6XWJ+/eOAj1WQSEUEfgDwZYeLjlholQPOd
         DiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740138625; x=1740743425;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPz4jrJm/bkUzW1VQl/cHlLOmSyNAHD6mHhOX0lva+I=;
        b=TS7dvZb/deICTH5gr0K6HETPkAHUrzunAljZOmvnV/7dvVeGW4MIYv934RLfx0RLm5
         MCxQ+7hh01PMrI1W9zoW4JnOFIuM48Zjksq/ZwMT7kWIdVEnbAtorJIVDYsVednIz4xN
         fUBUoAjNY9KVKm+qg/K1a0fvL/Zw1nIRWsVEh8pFoEKoFwEyFddGViLKy19zn57R507j
         W7JRH3RpSVs5OFeps31DN4DVas2oh+soHfaiIIEmWPkeGSVNfjr5zz/JzCnOQDUMsyaT
         MSrD4u8NDT0c8DWlA4Esjqi6GilqAFQPtedy7y9cm4dZCMKljXmnX0yXAt7QpvjKX+gp
         Ty+w==
X-Forwarded-Encrypted: i=1; AJvYcCVt2LCCyzVU5m5+IcWtwIZVoUa/VHdQXLtCCPC49xNUX2LANgRyBFfoxU/DKS2Lb1H35wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzENNFU4w8h+WN/DbKm60lWeEgv1K2QicC1yCDguWXaJPg9Uupg
	rTc9tt3ILiGAKXYX61Pyfwoqia+tLr3y7NvCixXypi+oIJGlTb6IgBB5P6HgF/oEPwVLgSX79W4
	1KsxSoem/fbPo/1BbU0JG1ATaA4dmBE9D
X-Gm-Gg: ASbGnctlFcr1LDJT/2SghGB+obUm/ei43Ykqms4Pf0NJjz0ofwJvPiTBcnCyP7Um6f9
	BDBhPskIgXTss+LS1VSfI5OGTaDjSSMDXB4mO1xU045oaJsxsYG143KY6x1yo3BW05EWIuMPlk+
	KFZAO902GlfCVTRBOSAWMy4RJSR/z0a4wJhmoS912I9g==
X-Google-Smtp-Source: AGHT+IGCMV3zCV3gudZKYK4xwV+a1hGHsjEJUcLvh4nETgOomgVHtg3KZ0ah6ma0JKaoJpK14umQipRGjULsgr10csw=
X-Received: by 2002:a05:6102:c8b:b0:4b3:fee3:2820 with SMTP id
 ada2fe7eead31-4bfc0f8549emr1221947137.9.1740138625187; Fri, 21 Feb 2025
 03:50:25 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Feb 2025 06:50:23 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <282b132e-27b0-41b7-8556-cbbdc08081bc@gmail.com>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
 <4beb0359-763d-425d-b416-ac40bda59e2e@gmail.com> <CAOLa=ZQF0=WgW-2HumRbSp4rUjXikEfecjp5Uxp+zJ+Tun5yzw@mail.gmail.com>
 <282b132e-27b0-41b7-8556-cbbdc08081bc@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Feb 2025 06:50:23 -0500
X-Gm-Features: AWEUYZk7oV6RELK8yOd-q_NF8Mcf4fFT1Zd1vJCBM6RbT3rTqg5q8H1K6J6BrVY
Message-ID: <CAOLa=ZQHMsZK0rmb2MuJYuaR-+1s6CdEQm86caKc_qXMSOKPTw@mail.gmail.com>
Subject: Re: [PATCH 0/6] refs: introduce support for partial reference transactions
To: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk, 
	git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="0000000000009d607c062ea598f0"

--0000000000009d607c062ea598f0
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Karthik
>
> On 12/02/2025 12:34, Karthik Nayak wrote:
>>> On 07/02/2025 07:34, Karthik Nayak wrote:
>>>> Git's reference updates are traditionally atomic
>>>
>>> I'm nitpicking but the updates aren't actually atomic, if a transaction
>>> updates two refs then it is possible for another process to see the one
>>> ref pointing to the new value and the other pointing to the old value.
>>>
>>
>> Good point. This is true in the case of the files backend, since updates
>> involve locking individual files and during the commit phase, there is a
>> possibility that one ref is updated while the other is yet to be
>> (committing of the lock is not global but rather per ref file).
>>
>> However this is not the case with the reftable backend, there, updates
>> are written to a new table and committed at the end after locking the
>> table. So in the reftable backend, this is indeed atomic.
>
> Ah, interesting. That explains why batching updates is so much more
> efficient when using the reftable backend.
>
>>>> This series introduces support for partial reference transactions,
>>>> allowing individual reference updates to fail while letting others
>>>> proceed.
>>>
>>> This sounds like it's abusing ref transactions to implement a
>>> performance optimization.
>>
>> I understand where you're coming from. This is definitely a stray from
>> the regular atomic behavior, that transactions promise. But I would say
>> this is more of an exception handling for the regular transaction
>> mechanism and AFAIK this is also something that some of the databases
>> support (see EXCEPTION in PostgreSQL).
>>
>> Overall, we're adding an exception handling support to the existing
>> transaction interface.
>
> My understanding of exception handling is that if an error occurs then
> an error handler is called (reading [1] that seems to be what PostgreSQL
> does as well). Is that what is being proposed here? I thought this
> series added a flag to ignore errors rather than provide a way to handle
> them.
>

That is correct, and while the current implementation is to ignore them.
It does make way for building something like that in the future.

> [1]
> https://www.postgresql.org/docs/current/plpgsql-control-structures.html#PLPGSQL-ERROR-TRAPPING
>
>>> I wonder if it would be better to provide that
>>> via a different interface than shares the same underling implementation
>>> as transactions. That would make it clear to someone reading the code
>>> that individual ref updates can fail without affecting the rest. Burying
>>> that detail in a flag makes it rather easy to miss.
>>>
>>
>> Thinking this out, having a different interface sound good, but I feel
>> we'd end up with the same structure as currently presented in this
>> series. Only other way is to really split the implementation to support
>> partial transactions as a entity of its own. In that case, we'd end up
>> with code duplication.
>>
>> Do you think you can expand a little more here?
>
> I was thinking of a function that took a list of refs to update and made
> a best effort to update them, ignoring any updates that fail.
>

Yes, this is what we want too, but in the context of transactions.
Without transactions, this is already possible to build albeit on the
user side with some simple scripts.

> My concern with adding a flag to ignore errors in the transaction api is
> that a partial transaction is a contradiction in terms. I'm also
> concerned that it seems to be ignoring all errors. I'd be happier if
> there was someway for the caller to specify which errors to ignore or if
> the caller could provide a callback to handle any errors. That way a
> caller could ignore d/f conflicts but still cause the transaction to
> fail if there was an i/o or could create a reference if it did not exist
> but leave it unchanged if it did exist.
>

Yeah, I think this is also something that Patrick raised and something I
will tackle in the next version of this patch series.

The next version will skip all user oriented errors (errors which can be
fixed by changing the user input), while still catch system errors (I/O
, memory ...). I also see how this can be extended to allow users to
nit-pick which errors they don't care about. But that is something I
don't plan to tackle for now.

> Best Wishes
>
> Phillip

Thanks for your inputs!

--0000000000009d607c062ea598f0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c47a24c9260d8458_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lNGFINFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK0dLQy85NzFISC9CQW44Mk54OWxFVzNlVWdYcVluZApGTFNzcWxKZlR3
VVA5eEhPM0NHdGpUN2ZFSURTTVdBS0pQWWs2U2NxWCs3MSswbjlqYmUvSlRNNGxUM2dFNkZQCm1G
T1hwWTRSL0tWOTdpVjlqd3oxQVlsWGFKRm5KU0ZVR2ZEVWdsNCtvbmcwU0V6d3FiRlRtSW40eWhX
WVN0dngKTFMyQktwVHFiVG83by84UUhwZm8rVUpiMFNKWDRiZjYxRE9kY25ib2RsYTZSUlhLZTdx
ZHdMZnJpcFMvNGI4YQo2eERxaVpBdDUzb3VXeWNkTUplQUtzVTkreU9SOUUyTlJoNFRSaStIUjg3
ZG9iYkh0VmJEUmMyMlN3elpuSy91CnpnM08wYVRzekJ2MC91eG41ZlFXbnlZVEg2dkJHZEl5VHZY
Sm5RWXZaT2U0VVFpaEF4U3gzWkpXaytiMGFQYkUKWUpxZnYydVd5c0ZQUVdTcytPVVp1UkJpVnAr
UFh2N2s0NWlmc05kQnc5aFQzY1Q2SWpqNTZlamNxMms3MVBZRQpza2w3dHNIdkZpamRIQnliTlhk
NDYyNXZ2UDhNOENqaXJyZ1M1UGFSTVc1SGVXZHRERkJ4aVc1S3RnY1Z2ZVJ1CkRNRXhzb3RNNGZF
SjB3Snd6QktFNm9qMGdTTEMwSks1Snc1RDhNbz0KPXBVcHUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009d607c062ea598f0--
