Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8546A3161B2
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 10:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130643; cv=none; b=B0GlEN6OUd6tB5MIvlS6uknZvRLrSDbMkQXgIZp4ABKwaLKMau5SzoDy7EG2IV6rTOmwXfds+/cSoqf7XxG0RSjaCnKSLhgHcxX9m8LYnE5YGxXePAnkz9VTKp3ICGkRoR74H4jh4ozacWKDLZFpIP4yMfvsqLhKzQ7WsSjmJl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130643; c=relaxed/simple;
	bh=a4nb7vVAdLaBPByS1vEN73Y2TsZdwj2hcNI/JGX6kx4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXlecThvledL8CRK2cjwVTzIgM4qP7LhPR8Jo/bjXFzH5h6zzkHjKUC1jSHp83jRZj/DRrWwvwKwh/dnCSalccNnbk0aP4or9JKiHC90uw7Js819zHySL9I1negsTIwdQIMxVP8+Hb3ddcWdwPy5zxENhDztQTynhUBafJVdNxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlP6Va71; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlP6Va71"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-932ea034862so1308585241.1
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 03:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761130640; x=1761735440; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3UYCifXmeVcx6nOuPqkJ9K1Pk4GH6mq1u6YNyywh8+s=;
        b=mlP6Va71/TC2pyIjVCKyVLn27Zb2kKL7TO/+ZEoUyqF4TppohXYeffacvoxGU+CG99
         jcHk6pYiJzRmN6+bl+jACnxJ/xKFtTSnG4f0QRPp5y2dRBLjUw5z7fkF/ljob7LanWbF
         HO/RIqRzDfnWlX6fWG2yL5MT2u7RGda/t/uLMPS3riy+50etpy3nR3RLZ2wqQzKTqzu8
         svOWFJYRMuCgn/frK1dMhnMw3aKBvCw6NjJ1ZUL6zdNV/pqMqKgR+f3vqKgCWKGK2Zdt
         VM+ANEtjB44xvCgarxbxQ24t8/96KfqDS51okBC0M+NJZMjjvA7c/LptahLORAptAMdQ
         0XRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761130640; x=1761735440;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3UYCifXmeVcx6nOuPqkJ9K1Pk4GH6mq1u6YNyywh8+s=;
        b=k70YzZ980SpRa/FHWCWTczPEusL7tQs7SrroSZR6j9Tk1x6945kJvFWsnG/UWLOT3t
         Y8UZXO182OzW1FeHr2Du7nQKbF0OP/mfBBNdk2VkoLscfPAD2B1QF1BRxoCOd+nmP/Ej
         LdnGQyLUeWzvogfmyFQB3hZo39/NEX0FoeQgjO0rhaEvadm6XSxMqxwu5Tp3TJPjUMJP
         N0OCy5SHzcJ2HMpKE+gm+BIATXcDtKlVjqKpO7YE2rszI0W3FabR5bBqhKo45nkiQk4J
         qTfvZiewnJFO5EJVX6vPEj6R0MEpV4NRqOr45wQ36SrmVLK8+4T4z5o+i+dzQURJMcrG
         1LiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ3BPp2wHFcaPfMDTrurA/iZq0QqazbbDGl+Sti9pwfGRUk0e2rGONZHNtjzmhEtPULGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiTo2DM72j5Vr/9BSpmFtP1YhZFSJuAsAes7SPWNSaAIb1ypld
	t21cKwMZir2WBg/6ISRe2MoOUvLFZupbP1KaBLitRYNu180QUsROfLwZspUnHIMA9+BSFeMam8E
	uCDP8RpI3XKe9uE7xtxa788zvuwGudVk=
X-Gm-Gg: ASbGncu9V6yR74NYAW3KaWIW+veyeVlFq/V4zYJeOqMvCLEqsHJ5+MvDEWTsZA2b5PA
	FP2k36wpEFCpBspZZQt3Oa2EgMtSssfUHKsz1ZN8sVOEXc3ASQUNhmy+9f9Gi1dwYN4vkSLItvO
	AlwckypT+3LhZWdsvZBMksoMuU1ND4MxZRA4L7IrV1aA+NLA2yItblibmrGPgyi+Dr8hSNx2TUu
	eFrwEzOsI1TMZ15NdIlBsfR7RRBvG6S4JGhBuqHj/3XYMoSl+h6S1tjQoLUuOW1Hc38IRlzAUly
	ljXXy7s=
X-Google-Smtp-Source: AGHT+IHc35RkGTxokC3orzmsf81FdTO2oOwb8LYw2WoOepFt9l1JyDLrmhOOe9jBVMspXT25oDC5uvhY1yHME6YqJis=
X-Received: by 2002:a05:6102:947:b0:59d:ad3:e1e4 with SMTP id
 ada2fe7eead31-5d7dd554d6amr6150874137.5.1761130640198; Wed, 22 Oct 2025
 03:57:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Oct 2025 03:57:18 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Oct 2025 03:57:18 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 22 Oct 2025 03:57:18 -0700
X-Gm-Features: AS18NWDmFmpWbVylYfbASLLvoKySV89XB4a4LSuwvmcmsFM5PToNySIt2Et4qBM
Message-ID: <CAOLa=ZTo0pbPDxrHoTgcOoyAiuN+AYgrACti6kga25+trQnXtw@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] refs: improvements and fixes for peeling tags
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000367d530641bd2ea7"

--000000000000367d530641bd2ea7
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> originally, all I wanted to do was the last patch: a small performance
> optimization that stops parsing objects in git-for-each-ref(1) unless we
> really need to parse them. But that fix cause one specific test to fail,
> and only with the reftable backend. So this led me down the rabbit hole
> of tag peeling, ending up with this patch series.
>
> The series is structured like follows:
>
>   - Patches 1 to 8 refactor our codebase so that we don't have the
>     `peel_iterated_object()` hack anymore. I just found it hard to
>     follow and thought it shouldn't be too hard to get rid of it.
>
>   - Patches 9 and 10 remove infrastructure that we don't need anymore
>     after the first couple of patches.
>
>   - Patches 11 to 13 fix a couple of issues with peeled tags that I
>     found. The underlying issue is that tags store both the tagged
>     object and their type, but this information may not match. We never
>     verify the actual object type though when allocating the tagged
>     object, so this only blows up much later.
>
>   - Patch 14 was my original motivation, a small performance
>     optimization.
>
> I'm not particularly fond of the patches 11 to 13. It feels more like
> playing whack-a-mole, and I very much assume that there still are edge
> cases where we should properly verify the tagged object type. But
> changing it in `parse_tag_buffer()` itself causes a bunch of tests to
> fail where we intentionally create such corrupted tags. So I didn't
> really dare to touch that part, to be honest.
>
> If anybody has suggestions for an alternative approach I'd be very open
> to it.
>
> Changes in v3:
>   - I've rebuilt the topic on 133d151831 (The twenty-first batch, 2025-10-20) with
>         - tb/incremental-midx-part-3.1 at 935ab44a0a (builtin/repack.c:
>           clean up unused `#include`s, 2025-10-15)
>         - jt/16a93c03c7 at (builtin/repo: add progress meter for
>           structure stats, 2025-10-21)
>     merged into it. This is done to fix a couple of merge conflicts with
>     "seen". Both of the topics are only in "seen" right now, but they
>     are close to be merged.
>   - Link to v2: https://lore.kernel.org/r/20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im
>

I had already reviewed version 1, the changes from v2 and v3 look good
to me! :)

Karthik

--000000000000367d530641bd2ea7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f11cd1d324a9a509_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qNHVJZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNElsREFDTEdEUHNpcUVsdDdNSWZYMXVkRWJxSkJnMQo4WmR6dkdoQTlE
VmxwRzNOdXZremViZ0VjWTk2dlYrU2ZqYlVwais4Q0JYTnA5bFJsY3pjVHZCSHkvbHQ2OWhQClVY
RGRhLy9OcHVCZzEvalUvUlkzcE8vd1pSQ1Yvck9ONWh1TWtuQVZabENKN2NLYlBMSXhKdjJ6OFpq
WUxFY3kKMDZtblp6cGMya0ZsUno0RW9VVkhYamJ2UnZkMHRRNzl6MVZzajhuTzY2U3BYQzlIZVIz
VFVMQzEvVGY3VzFEdwpGb0hMalpWSU4yN0JyNjcwc3NmRmp4MWlNV0FpTVlmdUVxR0szcVk4c0o5
UmtKMEVxSVVsSEw2YlAxQzdGRDFTCldvU2tQL242RG1VTFZHb1JMQzg5TklhaGk5WlBBSjF0VTh1
U0VMUnN4S2kyMGlIS3JPWjNRdHFFVFNUdExtcVQKd3BMZGxwd3JGcisxajV0QjZjMnZ0Tm1XcFFU
LzdqY3lEcDRESWNmWGZ6aE5MWXZlVi9jOVAzUjJJOGxWVjRhQQp5MjZsbWNGd3JNRTIrSkcwUmlF
Sm1wR0RSRFZhSFdDYTFCOVl1c3pYSHV1RW9oU1hKeGE5TG9NckREcVFIcEpLCmthYjB4aGF3ZnNa
Ty9KZjVOY2pBZTUyaHFCYTZ0akloODA4cDZaQT0KPVNrdGUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000367d530641bd2ea7--
