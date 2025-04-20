Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E973987D
	for <git@vger.kernel.org>; Sun, 20 Apr 2025 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745143745; cv=none; b=ZVcIj0frjfxrtk17DWThQtyqvfndXVaeLVVjNotW2cVFCB5gnuFAvp4+NhQ1Odv9U210qF+Yqo8Gtrxec+hXczAQnGZYMDApZWseDCgWpn0m/yChuPu2tLrI3rJB5t6qY5oGY3JzJNP1G9mf2ANemXUCsALsB/g6Daf3bYUGfuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745143745; c=relaxed/simple;
	bh=1t5qL/lu8Fjh0OhaExBw1oKerQH3NwbUZbz+560iyfI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GqQ5bfvNepEKnmRPKatUmOBUJM/uXbsaZYQCiHtrmNvhPXuTmjAKXD7wDrgwQ6UsaNZwPNu685Z1akY0ZbaDcXHfFp90PFN2jiVJ131C9lgzGRtqa5L+0jezwHPAAsrjoGLIUig+hYTRVKbKa4MFfR56aWH0/Ab5MOmoFW0Ql+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8ZxHS0S; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8ZxHS0S"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-52446b21cfdso1205032e0c.1
        for <git@vger.kernel.org>; Sun, 20 Apr 2025 03:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745143742; x=1745748542; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gMOZGO6M9NSTyZG7Hud2VfLxX74vAEmC4p67jRLSoKw=;
        b=i8ZxHS0SpdOKQhdCnvql0dIoVQawkN5mMw2d5T8EJbrh3GQ0hZtsu1PnDDJo1GfWt9
         sed5+oI/jeJWvEC0BdRKGTiJ+6Fc7av1zv8tJ5B5PsOCHvFl5N6PTlxW79xOCFJwHs5V
         abDwwIQOu7moidYcYkNW72bBkt01KiLOTmPtgzhUbnWusE8UVVb9EuENlIKC1tLgdQi2
         5kWO+xEWSilLprToapi0/m0Cbgbua40aRIcywTZZflvI7TgbHc8MNs7FazpIJgCsFnDC
         ok2oeaVFf9g+gugB4/iePxAtvESS9iN9p9PnqQziUP+5O8z79XrhAqvjsOQQM0+MVaF2
         o3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745143742; x=1745748542;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMOZGO6M9NSTyZG7Hud2VfLxX74vAEmC4p67jRLSoKw=;
        b=B6gcq56Aih0r5fHdUOmuLLlTCAB6/9osphMV5aNBUPpq6e1fjlfzPW2Sgdc2oglJbx
         nXj0w//QcNC21Uq4IdiUXrCFbY1BexVzgRXed6W8TuOkxzajpgz2dXdHIN78urT2Gjln
         yanS/qcDxCOuiTJmc66vAwipgz0XFMPCSbLKMFgHkSMFtcyu4SyG2AXQu4PUygRyeSUh
         S8zYcTDzyzHUJZb3Lwaw5IMM/id8xK0R9P6Q0KrwxarjiV0DumXzyinD5Of8SH7SRKLy
         0Pe1DCcvyB51XEI+vnqgwynhsc/3jlCTdnS/YphBLZi4YIOq9ShfUzjLRraJNOoKCboC
         tBTA==
X-Forwarded-Encrypted: i=1; AJvYcCUF1FUojZ1KfL783F5LwdA/qWSovOWl6jvqUCsI2xVe1LbIjal1U9unV/9EYauJVJB2/Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLdm4uQxfwfdejirWDasOnOWi7z+N4hhXea+bwZc/DL7GkUcVs
	3DMlgSZy/kb3mz37IBVCu4PFSQAF7dJQXuZVUmw3Bv3sLCOJWVdqnc+LTwlgxKdHvKpelN/wI1q
	S10J8yDVUSNlBsNwVzGdNO8WNDb8=
X-Gm-Gg: ASbGncuYp4a0AvZwxK4syV4ZHA18TXptpxE7RVzEcVvERFd93d/rvqUu0F3VGxSwJ3b
	Ugw7YeJH2yujsrkLKhMg5tIYuOP92Pffz29BcaBMzRNF6vZIffYmj5/6xQIxmQUWIE08zRI4dyd
	UFx89h+qwN7qgLQ2mICqTSmbbrv/vRk3XRkJGT/IsqaMd9/MjZGVS32Os=
X-Google-Smtp-Source: AGHT+IHccOoytlhE7o6jECOHhJXwwG+x9CacQbTrX8HAReZYy2hbpDueh4ZXNjyLdyYl4L+yHHy/3IhBdE0mLZG6LHQ=
X-Received: by 2002:a05:6122:220e:b0:518:7ab7:afbb with SMTP id
 71dfb90a1353d-529254db694mr5539030e0c.8.1745143742569; Sun, 20 Apr 2025
 03:09:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 20 Apr 2025 06:09:01 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 20 Apr 2025 06:09:01 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <23493ec4-fd9f-44ae-a81a-8851e495b427@gmail.com>
References: <20250414-505-wire-up-sparse-via-meson-v3-0-edc6e7f26745@gmail.com>
 <20250414-505-wire-up-sparse-via-meson-v3-2-edc6e7f26745@gmail.com> <23493ec4-fd9f-44ae-a81a-8851e495b427@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 20 Apr 2025 06:09:01 -0400
X-Gm-Features: ATxdqUGA_w5CnC4SMb5LIGAC25EyXxqWNLCNXqyVyHeD9_J2QQ-xJ-h9jtfKIDI
Message-ID: <CAOLa=ZRchwJWQfLDCMASEe9RWMOKDQvTfXaKqO=Shy=jhWMNaQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] meson: move headers definition from 'contrib/coccinelle'
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: toon@iotcl.com, gitster@pobox.com, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000dbc3f0063332f072"

--000000000000dbc3f0063332f072
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Karthik
>
> On 14/04/2025 22:16, Karthik Nayak wrote:
>> diff --git a/meson.build b/meson.build
>> index e98cfa4909..3ca5d01071 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -633,6 +633,28 @@ builtin_sources = [
>>     'builtin/write-tree.c',
>>   ]
>>
>> +third_party_sources = [
>
> This is not the fault of this patch but I found this name rather
> confusing as it is not a list of sources but a list of exclude patterns.
> Calling it "third_party_excludes" would be clearer to me at least.
>

This seems to map what the Makefile has, but I would agree, that this
should be renamed.

>> +  ':!contrib',
>> +  ':!compat/inet_ntop.c',
>> +  ':!compat/inet_pton.c',
>> +  ':!compat/nedmalloc',
>> +  ':!compat/obstack.*',
>> +  ':!compat/poll',
>> +  ':!compat/regex',
>> +  ':!sha1collisiondetection',
>> +  ':!sha1dc',
>> +  ':!t/unit-tests/clar',
>> +  ':!t/unit-tests/clar',
>
> Again not a new problem but this line is a duplicate
>

Fair, considering we're touching these fields, I will add an additional
commit to simply cleanup these two issues.

>> +  ':!t/t[0-9][0-9][0-9][0-9]*',
>> +]
>> +
>> +if git.found()
>> +  headers = []
>
> This is called "headers" but it is only really the subset of our headers
> that we want to run static analysis on. Maybe we could call it
> "headers_to_check" or something that makes it clearer what the list is for.
>

Agreed, will rename. Thanks!

> Best Wishes
>
> Phillip
>
>> +  foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_sources, check: true).stdout().split()
>> +    headers += header
>> +  endforeach
>> +endif
>> +
>>   if not get_option('breaking_changes')
>>     builtin_sources += 'builtin/pack-redundant.c'
>>   endif
>>

--000000000000dbc3f0063332f072
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 80be20c27d6f9174_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nRXg3c1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNnFSQy80OEcwc3NiWEhCenBBQTFMMjdNQUJPK0c5QQpRSS83NEFLNU5m
TEE3VnplK2hySGJBdFlNNTZUUUozM3ptdytsbE02T28zdU1udEhDYnJJU2dvN0RrSi9kZkJ3Ck9z
NE5rMFBZY3dRRzRma1ljM29lUlAyTEFwbURNUE9UNVJVeVBMWEMyWVFWQUJBczBGODNDOFpIV2hN
OG5ZYm0KQzhxTE5pejFmUFk0NTJqazlxNWNkV2pGL3hBRTNiTTcxY0hINGtBWjJmanMrcTFybXpr
SFEwM21JR1FTS3hpNAphT3Q5RnFpU0N2RXpPZ3BuU0h3WHg3NXY4RmVTM1NDTjNEaDh2N21rOVls
aDJQa2Z6NjdVU0dMNllibUM3UnRQCmR2Q3dQaVFPSFJ3ZElDeVgzcU1EbEtVK2dPWE9DM1R5c29a
SVpVNE5RV1FKelFZN1F3Z3M4aDhWdldsSFdwVEQKcHAvS3ZQcmpHNTNpaG1pekw0Ymp5ZXRhQVB5
di9CSlYxRkN3REhhVUx5dm1OSWVYU3B1dlIwZGhxT0NpWWxDSwpGRHhFZk8zRFlsMnRVNVNqZGdv
RVB0VG94bWJEczUyQjl6U2h1NUVNVnd3UE1ZR3BqWlQzRGp2VmtMdm1sMFl3CmdBdWJFTktYT0Ro
RCtTQjhzYUd6bXdnM2I4VTBoZlhaWTM3cmZLMD0KPWxYcnYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000dbc3f0063332f072--
