Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECCA1B415B
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737373626; cv=none; b=oMx3qRdeSmMnxWZPCJf7qvr2L17rdeduzvD+NWedJfdbKkwBt1NpMZ3iLjqJuC2N5NZUwTK6eqmCLRi5JOEDYdRyGJkelXcDPkM446LOsUCOeqhEjgThEUAV+mHasTc0JdJU35Ch0DCbaQU1mstJqf9b5EjkXJ1uWscYGVDIS3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737373626; c=relaxed/simple;
	bh=9K6qfr7UJJnmnCnSSVyEf4i/76k5hqc4ndrz5cBhXTg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0l3GnfnQYJElklkeM6IsafGDaMeG6KtPFx6wKpoS78pf5mqpzKYmgqnv5FXh7RJPAsGY7RO8pTs8qlMka/aT/ERsJp1U9gsbuXptnP35pJdNYBtxzgYeG56EiwOjajsD+m3buetuv6gYwaxnjwEv3aU2MOLmM7GvbYV2mIhwGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EprnBuy4; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EprnBuy4"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-85b9f2de38eso846149241.2
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 03:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737373623; x=1737978423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+NS0LI8ARsF48HS4LX89xNultoM8Aup62y1sOCzZD0M=;
        b=EprnBuy49VUsq156x9vpfVYRmm3qUdM/gmycAE5gL+ukmD884JXVhC3kCMx37DYEfI
         PqQDOT2A/wsZ91oRIV6WKaNLWnGN6xWN8Ha0qI4mYYw8HwWf2F+pgpqbjYALBBYMY5Gl
         tkW3TLPVjCKWFJcgu5eDQBs+mNpe7Hl5qpLgPvXIvJB3p0YySUmx4aN96zzL+XX5r2A9
         hSu1IcwDGCA+7Jwptu2nhwpk5E+5jqKltiUaFOfHpZNSxPC1ur8QcTgR2rtG8bKjUiiL
         YCIBAAGvNXxuW6FfbBCi0FN15oSrpaPQV5r2uXFvWb0pUITozkweuBeQf6PerAq99K/c
         DhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737373623; x=1737978423;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+NS0LI8ARsF48HS4LX89xNultoM8Aup62y1sOCzZD0M=;
        b=FWS280GKm5V/4CATf5Hlc4fkb0QiwFJ62LyeHk+8vvshz8jJ9WpwOrwZlXaGn7iLSd
         3n0+f3OLQbEomq/jBs1avf3ohWoSVD7nKgIJ+SlF5dVrAJFFkuwRT+xTajjFwqql4iBf
         WS+ZYRAX4CdXZ9nZ9RLfkR9l6HDaiFyVWTTteqrsGz6Hp5X0nq8ffDtGknbAgmUAuQ4h
         ZjIAFIkYVbFiGHCBHxOAH+9Ppy7EAf6e6TzEx3Je9JDKrVzFH9ha/9WiUbfZaeMeWa/K
         kamuFI9EPcLEU/vD85XbOCTlRcnntb8cDxG+yHjhA/r0bPUz8j0RCKuz+bLrqbqAEAPM
         Tidw==
X-Gm-Message-State: AOJu0YyDFRf5Em/3RIhJwckr2JJX5ItSy16Z9nLNFXKYv03ireXYRVDH
	f/yeR32LJ3jSEfKetlkrQpFjGGl2RPzEhWua+Qpy8g3+oQOad8qzswR4QdZna5K+oYMZg7xipl4
	hHi7fPU9g7obvgY5THacF75/ZLOU=
X-Gm-Gg: ASbGnctrrEH2mdJdi2VG0yvyRHxazbHOlZXYc8VFjdFbuQsVMRqQP61URy/lEwpKu7F
	KP0KL/qCAvGOShQNFtHCItOKquy2sJDvoiInupjij4WbwmZBx9Vbu
X-Google-Smtp-Source: AGHT+IH5EatoEtDKOn1qPByzoOUqiInA1gz82/X3H/9o0np8kivtGHKdbA72CJpeFKiX7Q/lvl/qcNnIuWvRZPUFTXY=
X-Received: by 2002:a05:6102:1625:b0:4b2:ad50:a99c with SMTP id
 ada2fe7eead31-4b690b86c0fmr9073078137.2.1737373623627; Mon, 20 Jan 2025
 03:47:03 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jan 2025 03:47:02 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z4oi55XewgX2deTm@pks.im>
References: <20250117-461-corrupted-reftable-followup-v1-0-70ee605ae3fe@gmail.com>
 <20250117-461-corrupted-reftable-followup-v1-3-70ee605ae3fe@gmail.com> <Z4oi55XewgX2deTm@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 20 Jan 2025 03:47:02 -0800
X-Gm-Features: AbW1kvYmi4kJBOjiyd_ficfeXl_21bo4fQq32vM44_wqgFYFaTnQRmkkrY3US14
Message-ID: <CAOLa=ZQpg+8vg+3XMcG4XyoaOMvtMV7KuSkQhJXTkFiPatO7Lw@mail.gmail.com>
Subject: Re: [PATCH 3/3] reftable: prevent 'update_index' changes after header write
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000add8a1062c21d1f5"

--000000000000add8a1062c21d1f5
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Jan 17, 2025 at 08:59:14AM +0100, Karthik Nayak wrote:
>> diff --git a/reftable/writer.c b/reftable/writer.c
>> index 740c98038eaf883258bef4988f78977ac7e4a75a..c602b873543790e36178f797ed9f98112671f97f 100644
>> --- a/reftable/writer.c
>> +++ b/reftable/writer.c
>> @@ -182,6 +182,13 @@ int reftable_writer_new(struct reftable_writer **out,
>>  void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
>>  				uint64_t max)
>>  {
>> +	/*
>> +	 * The limits shouldn't be modified post writing the first block, else
>> +	 * it would cause a mismatch between the header and the footer.
>> +	 */
>
> Can we make this *even* stricter? I think that this is something that is
> easy to do wrong, and the fact that it only triggers in some situations
> of misuse may easily make tests miss this issue. So ideally, we should
> assert that `set_limits()` is always called before queueing any records
> to the writer. This would make us error out in all situations where the
> calling order is wrong.
>

I agree here, it makes sense to make this stricter. Like you mentioned,
currently they are independent. The only way to enforce the limits is to
ensure that they are dependent.

> There are two ways I can see us doing that:
>
>   - Detect any state written by `writer_add_record()` and error out if
>     it's set when `reftable_writer_set_limits()` is called.
>

Yeah I think this would be simple to do. I guess we can check
`w->last_key` is set, since any record write would modify that.

>   - Adapt `reftable_writer_new()` so that it takes the update indices as
>     input and drop `reftable_writer_set_limits()` altogether.
>

This one is a bit harder to do because of our flow. Generally the writer
is provided to callers via a callback function passed to
`reftable_addition_add()`. I guess I could simply pass the data:

  caller -> reftable_addition_add() -> reftable_writer_new()

Any direct users of `reftable_writer_new()` would simply pass the data
directly.

I'll play around and see if this is doable without too much refactoring
and have something in the next version.

> The latter might be preferable as you basically want to set limits in
> all (most?) situations anyway.
>
>> +	if (w->next)
>> +		BUG("update index modified after writing first block");
>
> Let's not use BUG, but rather return a `REFTABLE_API_ERROR` error. It
> requires a bit more plumbing because we'll also hvae to adapt all
> callers to handle errors. But on the one hand we don't want to die in
> library code. And on the other hand we don't want to keep on adding more
> dependencies on "git-compat-util.h".
>

Fair enough, thanks for explaining.

> Patrick

--000000000000add8a1062c21d1f5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b5091f66d790ce3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lT043UVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meGRNQy80L1pRUEhiZExoWUkzRDJEdFFKbkFkMnk3ZwpWcytZWnU2Tlkr
ZUxuc2wzR29pSkdWRmk3RS81TW9Cc1hFZUVFajRUdktZYVpjaUFVUHVWTWh3cmI1TDExZm5zCnI2
MEVVMFhlK2Y0S0pyMWhhRHZWU1M1QVFpVVVFQndKL2dER2duN0VlVmNSY090Ylp0R0ZGMzNDUHdD
UnBWWkcKeTZJZ3NYNUpqSThiVjA3MTdRVHlGbkZDajFneVNicWQ4cHBWNzl4bVVoN1BEbUxZMnJ1
eWV4M3ZWQWY4QjVvaApjc2poNDI0ck9QaS9tVEpOUlV1aXZtUGE4YTk3ODM0RDdGazN0SWpuNzk3
TldDc2REMVovS2loRWd1Szk4a05JCjBHNnJDbVArZEZGSE5JWnRvMlk0NU15VGJoM3NoUlJJN2Vm
b3NBaEVCNHBmM0QzdTc2NzgvTHRWVDRlbzNVRnQKZHZFVXY4cjIyaU5uZFArVi9XWFJkSFc2WHB1
ZVNtU3ljc2tSbFRMVENtdTdVNTdvWWhxN29iSkQ3eVNFTlVOSQpkMHpBMGJUQmlwUm9DZy83M3Fh
aEdWZ2tJQ24rK0JTdzh0U0ZzMWswRnZMYTdZVHozaUc3WjNrQlRMNzV3TFgxClUxQlFhcUNlajVM
R29kNWM3T0daSWpZT3NnTjFaMmNZU0VYdlk0Yz0KPURYUWUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000add8a1062c21d1f5--
