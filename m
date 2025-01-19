Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB3E3F9D2
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737285043; cv=none; b=ejooNnP7ayiq3kBElNz7xt2S1iAixekvcbvPh4KMrc3MRjQQ0AWmN+v1PhPAdWjhjCajJZ60tBoBOuRDaKZRBsvFHK12XNdU5iGHm8fsj0/wHS813dKeDeLkJqt5coaIrOWUKSfuqcIux81YH5byjfMupBdzd1mlCKFIucJXsMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737285043; c=relaxed/simple;
	bh=daMu0E7AGoVA9lewSbM9eIuCMiWvaAYYAjwWcT/AWBw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XmHMeYeiyh62WPLqpYjNaQIhZ7NzesMDsQH+HWNj18Q6qP4CXAW9ob40TuMidRXNbjbBHVCSgMb2BNeOv5n80tlNxczLCz790aNakoIlfv9bg3/sCxaixT46d5cRxxMayW66NnPr5ZpxRYiKJ7O2RQtCbAD2XeU+ZmBsHiCF4AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqTUM9JY; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqTUM9JY"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-85c5a91374cso1573604241.3
        for <git@vger.kernel.org>; Sun, 19 Jan 2025 03:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737285039; x=1737889839; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=daMu0E7AGoVA9lewSbM9eIuCMiWvaAYYAjwWcT/AWBw=;
        b=GqTUM9JYrFPEAK56ONVeiJva+0nTPmZ7NgBXfLqQ5ktvRPsG4BvE+nKMXvAOrPcHFb
         yFdxYddJ41bWnEQ5W5vOX/2Ri0L7w23/LaKlt4KNK3OZiTEADT1PjDzuvVrJMzlAXFC9
         3KSa5aKVIEvMSKA3ey84xyOiqq3le7M0wGOpBB+SIugdIN7OVuV7+QgDZaPgAFKG5u9x
         9AwOX8R4HDoJ/vQ5Dt8yQcPQzNBp7Xuyka1z4z+T7XMF7zzUHTHH6OboQi75nyJVy4Pp
         OYwAX7v1lMvFeXztQYNmJXmv9scoW0yT7MuZq1ZxxjkpFkuFNRPQVPC91apmMARCDRC7
         bY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737285039; x=1737889839;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=daMu0E7AGoVA9lewSbM9eIuCMiWvaAYYAjwWcT/AWBw=;
        b=Md50LHLK1+dfAshg4xDbkd7HWduKGkiaEkMd+028F+QkCFdsYYGsZFTAc5JN+Rjd7V
         UFXT4lFAgbBrmwvwHf22fPbQt/Y1RCYq+UU6dstjfX93n5U70VLTgJoKnm/0JDahjdkP
         HDJllID+ItC8qySpUDb+NAj4x7NQmmrVV+wsUBf+KeEr9P2IxqGCuoXHM9Mw8O/8syOb
         sxN7y/rBJ9ErF0+oFpSUechtw22rGEQLOYufTAlcb4SbjvEW9Eup0b6iOTS5cbH8Kfpf
         lQL8xyKDmsM1d1eMu6FshBxavtBryv8bWwSc1AJUSHXWLcnLJV593PmMbFSclKLRlYTN
         Wm2w==
X-Forwarded-Encrypted: i=1; AJvYcCVE32ioXX2q0GMkN3JFjuGAuFpXHfKMZKE7wo8tn0o9lNZYz1TgznEygGZjUqSfJFcBzLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPcjlhQcElFG1ZzX9ij7HlbNER9cpcRKkH0IWOLrGq1ZCVHGBM
	dFEx0fni/sGBlxpwTVdpvSL+7yCM1wVh1Ie+Jd9KHXxhNGgqsZP6qLRGKoiwsmyHoiAsoL/oe37
	AEu8YwtjJEqL+QoWkGiIlnoFNyXem4pIX
X-Gm-Gg: ASbGncuql6WUJETwAN6V3z0AzXYDBeu8QCkMO/T8/PY9fMBfxqLQaUCLZrIljXJBGWQ
	99MPtkL2VBnaWWY9ZeEECCe5O5birss7+kikqhFuZ0dE5kxf3VKdD
X-Google-Smtp-Source: AGHT+IHM5VQtTEkG32bDin0WpjystGidNCjU5WYVRsqFrDpakMIiMLWc9GKQg5wC3DiyiRHQsCln1WQjTQpbOFtdfMQ=
X-Received: by 2002:a05:6102:2c88:b0:4b2:cc94:1d6a with SMTP id
 ada2fe7eead31-4b690ca2b07mr8298856137.19.1737285039665; Sun, 19 Jan 2025
 03:10:39 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 19 Jan 2025 03:10:38 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <87wmetieb6.fsf@iotcl.com>
References: <20250117-kn-the-repo-cleanup-v2-0-a7fdc19688f5@gmail.com>
 <20250117-kn-the-repo-cleanup-v2-3-a7fdc19688f5@gmail.com> <87wmetieb6.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 19 Jan 2025 03:10:38 -0800
X-Gm-Features: AbW1kvYGTyI6Bd8U8aOCCiTlvqtjW5UHeN_ftBpl6tx2WTCkHJ-yzI2G3jFn73M
Message-ID: <CAOLa=ZR=wftoUmOFa5BG_RxGX9v-85zeCs33cZT9Y+rrxa3sDA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] pack-write: pass hash_algo to `write_idx_file()`
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000a9dfb2062c0d31cc"

--000000000000a9dfb2062c0d31cc
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The `write_idx_file()` function uses the global `the_hash_algo` variable
>> to access the repository's hash function. To avoid global variable
>> usage, pass the hash function from the layers above.
>>
>> Since `stage_tmp_packfiles()` also resides in 'pack-write.c' and calls
>> `write_idx_file()`, update it to accept `the_hash_algo` as a parameter
>> and pass it through to the callee.
>
> Technically speaking you're updating it to accept a `struct hash_algo`.
>

Yes, but also the callers pass in `the_hash_algo`. But let me amend to
make it better.

> Besides from this nit, and the other nit I've submitted on the first
> patch, these changes look good to me. I'm doubtful any of the comments
> needs a reroll.
>
> --
> Toon

Thanks for the review! I'll re-roll with the fixes.

--000000000000a9dfb2062c0d31cc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9e4bc4f4f828e5ce_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lTTNhd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMWYzREFDSEMzbXVUWDE1WHVCUjNJWERrbjk1ZTY2Kwprc1lRbXFDSEdt
Q2xiRFpsNVJIYnFvMTVUem5SQ2ZtcVJmdzIvNStpcW51NldyQUFYTU9oTnp0N2N3Y1NGYWRDCm4r
TVBEUUZ5YWMvRnk1Uy8xdFQ4eGpvdEhEY2p0TVA3S2VMTkhYQVVqdmRaWFFwcWRNL2RkVmFQUlow
eEpyMXIKV2RuSEVpUE1MYVl3THZWRlFXMkV3ZEkrTjgzMlgvRHZwMGcrTjJwUUR3L0NaUDB6NlVx
dk85UFN1WUg5KzJtTgpiTUdjRWN2dmNsa01ESjNqMGVnNEloYXVpTXRwVUNhMWpiWW1ZazBjQUdm
WHAxSkNET3VrVHdvcGhzSWhSZjlCClcxOE5tV3I3akRUd0ttV0FMUldwV3gxODh0ekFTZ00veW9s
Y0MvWkxyazJaeTBZT3RiZWhJbHpOcytWVTJZVmkKajlLeWdkazNXNFNOc3ZrUk5XNTFUZDNaV0dT
ZE03M0RLUlpaWTdXblpQUUxMOHlHV1k3NGVQUHZRcFpNZzJUbApkZ1ZWYjM4aGhVSlQ3U2xIZmZS
Zm1JQ2VjQjlkRGRCdUZsYkVZRWZnQlllZm5wSjNLTDl0T0JuQVBJaHB4aVcyCml4T3RnWVJQVHds
QStzVlgyNjFKVFExSXJqN2daZEVvRjZHeGllOD0KPU1yb2cKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a9dfb2062c0d31cc--
