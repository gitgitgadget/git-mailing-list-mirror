Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07771D5143
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275891; cv=none; b=ggJs5IcyB68Y0cXNqjjS9shQyIBupYdzGnErHUX1VYVFAzae8eE3RfNK90CIwZP9kGoVKPb2vo6bz7RxdND/0IL+WPwBSJSQQL5Kqyueyp4UMZpaJpQDgjMv/FR7NVH3NGCnIHPLNyu9MDyxerF5kOhr6CLox3NyHt84j1Sln0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275891; c=relaxed/simple;
	bh=f9BG0ZX1J3uz8jya/foKJMNLaQ5F8laUmRmtLmreSuo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GmzEj3j610bVBAAYdmRcARVMxxaHAqmt6beniBl2LGA3XnjPQ52xYPxzCcwVlYXNkJIyVGJa6wTgqpD8mnHCnaMe28+XR40Tpz9BO7BnGJ141Wyo0TH+ZF1M/Q46Z1x9Ba8AmXIdxdg1IXjRVrNT82p/tR6BQcCDIcWMuP0LK18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYg82tCx; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYg82tCx"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86c29c0acdfso224250241.3
        for <git@vger.kernel.org>; Thu, 10 Apr 2025 02:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744275889; x=1744880689; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GOO+ZmI+KpICzZp0MqHRlXmeAmhFmrXylJz/wGyihIo=;
        b=RYg82tCxr2A3JLejwiLotoadudZJCiQUmBOrmeNUQ/gQjImhtIB7s8LaSp+o7st2qr
         qTcVdEoxRsoJnxVl4vii+NwmSh636vhDXkeAk8WYB89jHwZOOgS0qFZfviFSWQI8SteQ
         h9FOxzMM9mejZkwHSe5hArfNXTbx9634GNtElbuRCLBvA6yjDd66e8tF9LLjQ6muFZ1r
         3cne4pUA9UUY41bTh2BaE3mbr8oGK5NTbPIwOO/NWB8BvUhVC1DbnWigZMbZyfC66CUm
         tnyL2nUBeBf6ukuWmWaMHYjC5hShjRpmBnTC5IV+P12K/84ojMQ/ic1GvbHFIvbWl7YI
         JrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744275889; x=1744880689;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOO+ZmI+KpICzZp0MqHRlXmeAmhFmrXylJz/wGyihIo=;
        b=cekDSA5D53UD7IUg6sjExynST5rttoKjTEu0jdZImL0Z2b8SBIjrmbUeC4e5NOT9Kc
         HG03VZMjTsCPy5rEUUaHUP7wFPCSjYzpOkaTZ/OWXRpeHv336GNYtx+mkuNdQg/NmSki
         6DYp1xVQN89titNSKiTYHygPPCq1JYvXnV5u4zkyrBUAxoyX+iW93Iz4d+Iaz1BI4rrA
         0ru+u643+HB/nn9f/Z2uNzhgij7g/6uj6DZRJaqUlEPZL+16kLvgFIFjfr9voo3ecpba
         V63TXTMa3HlVPyJDi93TeE9XWgxhh/lCRZx+uCI/if9CP399OURBGPnxKQfWx2NVFvvz
         uksA==
X-Forwarded-Encrypted: i=1; AJvYcCXGn0P7XVA6T/6A6mG+gcW8/uJ4wZ/tLXSPDyUbTtSr61WsrVbu2bSN5bFw/ab9oi937Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3wMtKpK8WLub8hDKSGEWN8duaYa1+JncjW/RLbXObrs2CRAtG
	AjKFKctlDDilVGXO5Og7TQzVydd2quYUFiM/HQR8AMmYZoXrVCAQ4YlFvrSJWNQ6M2XqMUwQMMn
	rAozZTjJwD6ALjDT4Pu6iXuX34vMW6XwD
X-Gm-Gg: ASbGncuLj31oeSGzNRmZnE5vlLYInCA3qgRV2eBZkowmF4Qv/NbA26i4yankejJCwXS
	1wBR9tJ294PAlgOxcxltKbJJ9wJWA2W+pncUCAAG+tUCNdO0useiO2jxwB+rLG5mYjeLWja7Z+H
	oBIE/8vM4zkREmjFEQN+qqRoWmWiTnTWO4F4AvkA2UtoeA8CHNsgxKGkM=
X-Google-Smtp-Source: AGHT+IEA1eAz8R1CG8uFZbzCzuVhXhaE29U5j3pHn1RfeE8TAfgGoQK6R2TZelabpm9d2qrMzN71rDYcM3KstS9eR1k=
X-Received: by 2002:a05:6102:3c98:b0:4c1:94c1:1c34 with SMTP id
 ada2fe7eead31-4c9d35c6700mr1297238137.20.1744275888748; Thu, 10 Apr 2025
 02:04:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Apr 2025 02:04:48 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Apr 2025 02:04:48 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <871pu0fl6u.fsf@iotcl.com>
References: <20250408-488-generating-bundles-with-many-references-has-non-linear-performance-v2-0-0802fc36a23d@gmail.com>
 <20250408-488-generating-bundles-with-many-references-has-non-linear-performance-v2-2-0802fc36a23d@gmail.com>
 <871pu0fl6u.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Apr 2025 02:04:48 -0700
X-Gm-Features: ATxdqUESPCUYyCAjYk2ld1Z_tKEwVvqS-cyuOVqWyWJYBlilYq0-XLYBO5NhNi4
Message-ID: <CAOLa=ZQUkv=QpzzOaxv8EUhaoTpQdTPO1fHT=-DY2vfVCK4NyA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] bundle: fix non-linear performance scaling with refs
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: jltobler@gmail.com, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000bd5f5e063268e0cb"

--000000000000bd5f5e063268e0cb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The 'git bundle create' command has non-linear performance with the
>> number of refs in the repository. Benchmarking the command shows that
>> a large portion of the time (~75%) is spent in the
>> `object_array_remove_duplicates()` function.
>>
>> The `object_array_remove_duplicates()` function was added in
>> b2a6d1c686 (bundle: allow the same ref to be given more than once,
>> 2009-01-17) to skip duplicate refs provided by the user from being
>> written to the bundle. Since this is an O(N^2) algorithm, in repos with
>> large number of references, this can take up a large amount of time.
>>
>> Let's instead use a 'strset' to skip duplicates inside
>> `write_bundle_refs()`. This improves the performance by around 6 times
>> when tested against in repository with 100000 refs:
>>
>> Benchmark 1: bundle (refcount =3D 100000, revision =3D master)
>>   Time (mean =C2=B1 =CF=83):     14.653 s =C2=B1  0.203 s    [User: 13.9=
40 s, System: 0.762 s]
>>   Range (min =E2=80=A6 max):   14.237 s =E2=80=A6 14.920 s    10 runs
>>
>> Benchmark 2: bundle (refcount =3D 100000, revision =3D HEAD)
>>   Time (mean =C2=B1 =CF=83):      2.394 s =C2=B1  0.023 s    [User: 1.68=
4 s, System: 0.798 s]
>>   Range (min =E2=80=A6 max):    2.364 s =E2=80=A6  2.425 s    10 runs
>>
>> Summary
>>   bundle (refcount =3D 100000, revision =3D HEAD) ran
>>     6.12 =C2=B1 0.10 times faster than bundle (refcount =3D 100000, revi=
sion =3D master)
>
> I've done some benchmarking with some "real life" repositories, which
> only have a couple of thousand refs and there the difference
> (expectedly) barely noticable. Which is good to know there also isn't
> any regression.
>
> This version looks good to me, I approve.
>
> --
> Toon

Thanks Toon. That is good news. That is also what the earlier benchmarks
showed. For smaller repositories the difference becomes inconsequential,
but for large repos, this can take significant amount of time.

--000000000000bd5f5e063268e0cb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 33694f3398ffcf3c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mM2lhNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1memk5Qy80OVdaNXlRZTdPU05SZ0lhV0FtcHpBK2ptdwovVERaS21yWWJR
OXhRMll2NllVTEx1Tzg4V1RSaGgrTitHdlJMWmk3eEVPeGZDMENUVzFqRU5idjhISFI3Tlp0CmpQ
cEplWnV1YmJiM0hXKzJtZ0xHWW1EWXJBYWdpSXNTRzc3NFhmNmNraHpheExvMGxHd0x1UWFsbW5h
bVVQYSsKNUVwTGY3c3JVODRkRnc3OW1rVFVnM1pHRWl3bm1TQm5HWUVSOE1wd04rRzV3Wi9UZGh3
dGtoYXNOVVVlbUREcgpReWRIQzdWdk9objd1b1JJZ0R4VERJamU3VDZtK21mdzloTWRqMXNYeWdx
WG9CRW5WSTV5ekpLWE1NMU93aHhnCkdORnhMYWk3RVN5bWc2MnAxRGdLNGJ0VDEzYjV4N290cS9a
NHY5Y0JPMVgxeGRVT1hNREtUZEtJVXdJUk9iV2wKNmEybTNRQis2QnVTMTJjRWNvVlVjejJ5TmRh
SFZycnNkWTc2c2k0Rm9oQU96dUlxdFdabEhuY2lKUGNyQ1o5dgpwbUJDNmlGRVBBYmpNZHVXa0Fa
dTNtdVZaRUNrS2c2YUtJbmtNeUhnbmFkVVg2L3F3Z1ptQWV2RWtxUFRtK3d6ClpHYmZoQnFZaWdi
R2xuN2tSWmVSdTRpZCtjVHlDUXVtd0xJTW00QT0KPXlDVlQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000bd5f5e063268e0cb--
