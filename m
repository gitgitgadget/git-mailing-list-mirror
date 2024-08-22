Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356E9139D1A
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 08:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314394; cv=none; b=tKAG7C4uW5tuUrmO2/FsajtrZWzj9Vsqc9va6cxq2FsVYM0uUj+WaevZKjtrWIL588qIhBmdX0LAaGVCfl5iAnkCSekanxT+qqNFD1a0RdHqUZqYkCG66Hoc7bylHHKSBIsPcYKgHyeBPTO07eqxL0C5Uw0Cp+tJ16nGTAFYt8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314394; c=relaxed/simple;
	bh=jbZr2IppFTe8iF0xmcF+NNVnD0R6jV/2iDp9sdkVsA8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j4RlSX06i5ONn96r+OKmDBA9NJucLpIWqDaJZKDWJ7bEPLWjCESV0DEHRXXfGPyRIRnjRk3GiqSkkZ6aDXENO8EQD3X0Go5Sp/+9usOiO1DTJ6ScbJpePrie/z1K31yovdRx2uQBdvBxrzSS69Un7y+y6AgXR2kfIpc4twUE8vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SproiFWz; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SproiFWz"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3db130a872fso328053b6e.2
        for <git@vger.kernel.org>; Thu, 22 Aug 2024 01:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724314392; x=1724919192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jbZr2IppFTe8iF0xmcF+NNVnD0R6jV/2iDp9sdkVsA8=;
        b=SproiFWz/XOw+zmXCHcmQJRfui6rz9+un6ni4PGgmO/k432qwtQKxZOFmpHD/orjMa
         7HKjEyYHdu4OZAJG61uIZEOyvtLU259R4bBh+vu0UftmziLYDA/niIVxDyNh0dS7dMhT
         7Vn0PjKD4P3IzGLc49jGbwIkbFJfRGGXLjGuCSazGahlTl0MAIP1pC8Ef4eDdxXqhjmV
         Om5r+3s+FxeKOUeINocRQSEBei9yEUflNF1Fk7pC//5UVp7tTFExQBtEEtPvrxZuw1+K
         uRNjoyM8Rh8k0OV3LULtGnC+sMbUrN5OH1+ejag1JW8eBr1dM702cILHB6glfXKXmtYp
         E63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724314392; x=1724919192;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jbZr2IppFTe8iF0xmcF+NNVnD0R6jV/2iDp9sdkVsA8=;
        b=Ck1TOcPz74RFUWsY7rk5MU+4sRE6IL3NkCAzEGeIS4H6yeHNM886dKUGHnVCGBWjVQ
         1Aqq+7EUkJIB7+XqeK8SM9WOH02eWOS8SPgZybn1Qdi9pia6U5h76Mv6b2Y+9fr9RIVt
         /uRp3TB3GKxns9Jv7LWjBMi35QeJrfo/Yd90iolLK4poKR1IOzbtJ7tol3gwwir+YRN1
         8rLfQVdzSFODYrkue+2RpbWhf6wVxrgr43YQGQxXnYMcNKSoeONMlr4XIHWnqnD7cD8E
         B7vVS5/G53WL7XYE+GFRKi7TwMzQ/eZhQEAU6g/GT1pbnk5xXuxE8BWjMUhh8qHRkZAU
         GCOA==
X-Forwarded-Encrypted: i=1; AJvYcCVqrp4bj5RPe8UWnJLQljyi7Oulv3t66Fch9HBUBjFX7PK6UzvnWrDVnGeDMKNjVWYk3Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7YI7a33+4kxouse6KP8daHxPAiPJf7iwKkDisZnPT5BJmKf5o
	lZ9PDBzf4okAVN2dckOySPnrGW8qv8VNXdfvRNqWcAMKOCdTWK7KE5q1oQr+LDVFJGfe2Hayreo
	xhScyzuY4nRfemnMe5mIHrJQVmHs=
X-Google-Smtp-Source: AGHT+IGIZcbHhcnSCLbp2bDrf9H5K47raEVE9pwaPUvEko30jKM3omKHFAi+yWBCOjBiiSSM11AIKrIqweLwJyPye0A=
X-Received: by 2002:a05:6808:23d1:b0:3dd:34d3:7108 with SMTP id
 5614622812f47-3de194ea678mr6044625b6e.1.1724314392042; Thu, 22 Aug 2024
 01:13:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Aug 2024 01:13:11 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1724080006.git.ps@pks.im>
References: <cover.1724080006.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Aug 2024 01:13:11 -0700
Message-ID: <CAOLa=ZR+bbYrYrZ79zPY3eYWQRQo97NfmcJXS=-nD842g7=XiQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] reftable: fix reload with active iterators
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="000000000000d1c3410620413a52"

--000000000000d1c3410620413a52
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> as reported by Peff in [1], the reftable backend fails in t5616 in a
> racy manner. The cause of this is that git-maintenance(1) processes leak
> into subsequent tests and perform concurrent compaction of the stack.
> The reftable backend is expected to handle this gracefully, but doesn't.
>

I've not looked into the recent changes made to `git-maintenance(1)` but
my understanding is that, now, `git-maintenance(1)` can detach itself
without relying on `git-gc(1)`'s detach.

> The issue can surface whenever reloading the reftable stack while an
> iterator is active. In case some of the tables got compacted, we will
> end up closing them and thus the iterator now tries to use those closed
> tables.
>

Make sense till here.

> This patch series fixes that issue by starting to refcount the readers.

Not sure what you mean by 'refcount' here though.

> Each iterator will bump the refcount, thus avoiding the problem. While
> at it, I also found a second issue where we segfault when reloading a
> table fails while reusing one of the table readers. In this scenario, we
> would end up releasing the reader of the stack itself, even though it
> would still be used by it.
>
> This patch series addresses those issues by making the reftable reader
> refcounted. The first 6 patches do some simplifications of code which is
> close. The remaining 4 ones introduce refcounting and wire it up as
> required.
>

Perhaps it becomes more clearer as I read through the patches.

[snip]

--000000000000d1c3410620413a52
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 47eefa37981ce9bd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1iRzh4WVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOVZEQy9zRVpHbjYrM05EVXgva0NzT3diRmh0SEtNMApMRzNyVHlzeGNO
SnJWRVdxTkw0OTJqOTVHNk9VaTU5WVJqd3BPSW9lUVpLSThkNnMzUlZkWEtTMFplWkxzMnN3CkJB
clhXWXorVFZWKzRBekE3aUJEeUJJTmtKK2xSekhwRTJ3Ti9obWF4ZTVqUlloeXJNWWFHT3o2V2d5
cWRtZmoKcUMrWjVFczdIMTlGUWVxTHlFVUlGSHdka3QwWnVtVHM3ekJZNzd5TzdiNU9JekpxR2tk
S0lFNDJjZEhWYnRVdQpUV1pycjQrQ3dJQ3Q5czBrS3NZamo4K2JkMHVtNWZoRWZtaVFOb05PdjVw
aE9JV3FLV1RQTnhGZFFNQVdybHBWCmxLWGRBVGlTUkNrL0NYY3I3UUhWTzIwUDVLbmNLMEhQNFoz
eGNlTEw2N2crWWNudEpzaTFqNWdWVzIweVQ3NmMKM1EvL2VBSVdoMzdyaEJZZkxkejdIOVBMcnpK
dHNRY1QwMmdTalVyUVFxckNKclovRExWcXhPcitYT3BxKzBHdwpuTDhGSVl0RHlhcG8wM2hwd1JW
TlhyZDYrMDQ5OWRWTVZTcWtVc2czdG9YM1ZsQ2JkQWNGWmFiR0hlMUs3eVJvCk4yanNrMnFRNFYv
Y040aUEyYUM1OGlMcG4yOTJFMURyTi9aNitvRT0KPWFFVzQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d1c3410620413a52--
