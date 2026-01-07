Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF431B4244
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767781040; cv=none; b=Suh3CXzJNNyWR9l4yiQfZcLQmaUPf4HtmbKfBUZIPPe41ist91Y0M7ropWjuFmfXNUOKa31YAK23OCOCZLwwbRRbxUdFncgo0GUroQRpfTzPDW1D+KWBpdJgoknPmp+4g0xirAbdd0sL1fVBbOiq8/XFk15a3qp+VPzlz3q/LHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767781040; c=relaxed/simple;
	bh=oeakKBEg+KILpT+KR6gTuBb/i2/ffNUSjYmCQHXEbcw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlMGEashoI1cZ0kge31hsQNLF2qLdwgaBohB2okKNKOKZbZKZLI36BzQVOY8PhFePgB0v9JLm9f488V+E2xuZdpqaAdgOwHoH0MT96Yi6Se3zirt9XJvmMGtKrbWmJxTx5o+0XoedvmSJ11FjddrybtC7Mzc/AMDr3fxhy/5kL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lj4jOZTC; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lj4jOZTC"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5dd6fbe5091so733726137.1
        for <git@vger.kernel.org>; Wed, 07 Jan 2026 02:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767781037; x=1768385837; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oeakKBEg+KILpT+KR6gTuBb/i2/ffNUSjYmCQHXEbcw=;
        b=lj4jOZTCjg9Uwksh4hPu9bmB3P9q/CdBIrtniHuU5Mj5XaYsVUQpBfw8VsgY5gli7J
         8eKYyRggjtJApYv5ze29Miy2OFtg4VSuNe8p0bhFsnSuVR4GGjaA8lHzZQz+hUAgJrly
         IY+JhiqPSp1GWSn1JWrg+mpmm+h4OEOW0nt0eCFeRoaboTia8bTHGA7ssPu8AUZ9ennn
         9165+1JvbWxA/1CUFbv4Q2DNtwSG0M4lDmxuhbnQkuEF3oXIJgiezSBnU8pYAPpHv2sn
         rK7MIiNcra9sveSpdtrfhXAXNxzaJB6WlFBRq7p8aCcZPXAL8aO/csHGlUbOn1ORsG2Q
         oPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767781037; x=1768385837;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeakKBEg+KILpT+KR6gTuBb/i2/ffNUSjYmCQHXEbcw=;
        b=HvorQiGuWYRQPJQtJwR2uOT5rN8vGqcVxu12IJ/9wyXhUZscy3M3prjRrbcZd1gRdy
         rlLZ9m9yVjfq09Psd6tcBZuniNtRLwK9bSLpk+gXFo+egQ6GOkSL7rc0wevd6UNo5ppz
         DNXKoTvhzRviDButyhG9Pe/R1z9M/RhxMoYb2c0VK3c+SsVigQYsjVWSj/DTiZfwftuD
         LQQOHvhZFES5/K156d+l3TXLGnMwfxXuEi+R9puFS7Q+smICTrvJEN6Z+uCaUvJXmvG/
         hfDfKAk0Wo8RLX3FrValVgjSsHEwM4ehCvIxLPm+OML0zzaVVRhpmJfZcS1G/d5cE9Rl
         DfzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXDxw81aZuUtmw6rNlXU9P/xXrgrcwNJVMDTbooZLrs0ejojjlnZudyBnl0g4Hzj/XcPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqQOyA4zZvh/xzwTzMjlWLIlASiEth5SsvhsKRISSwF1FkdWYv
	lnjcRJeuVDV1qWJnkUUlcqfvM5xk55ywPtrQ5GcPHhulQUad9iF7ILa4ip3nrapX9lKTfU3uae1
	Wn0fgRQdFpenDzkjvZu7Q+w5M3YCPqnI=
X-Gm-Gg: AY/fxX41g8xyNzvOrzDzSTR6okg49jvCrZP+PYek85k070ktCBloAfMuSW0hmJN5nHV
	2N/hfflTBiaJKTEUzxIIeiU2qcl3KYum0aF7dGnthc29p8B+H51yC2LSxQlDWp6+7oBUKSGgOzH
	QMHiK1wm7cAAMx1xkht8jRbmCReOEmIKMCUMQ4TNgsRKm1diNM0/WVB/7K4UgRkFpqmypToU9PZ
	lKVyoZuoCl1Ua85tFMEam9ikcV4X3JNslSuuFzap0OJxwld3cAxvU9cnwP1G0O1z28YWATkEEYB
	g/wM6fUCDqs884Sg0VX/CbSaNNXUaA==
X-Google-Smtp-Source: AGHT+IHKkZsApzG6Iz+PZlk4ea1hHd3/XyQPmVEthfmQHm8wfKlUpzy7+22+HC6emkYxZ96SFZuIjMAQKDgJarti1eM=
X-Received: by 2002:a05:6102:3ed4:b0:5db:cec7:8101 with SMTP id
 ada2fe7eead31-5ecb697675bmr596006137.29.1767781037599; Wed, 07 Jan 2026
 02:17:17 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 Jan 2026 02:17:16 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 Jan 2026 02:17:16 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260106-b4-pks-odb-read-object-info-improvements-v3-0-b5e02fae1fb0@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
 <20260106-b4-pks-odb-read-object-info-improvements-v3-0-b5e02fae1fb0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 7 Jan 2026 02:17:16 -0800
X-Gm-Features: AQt7F2rTnUcDZ3pJO1oWk6_foKiOjc1TJ_A9N-6vKDYgvRrjh4fm8N_KZwdLPoM
Message-ID: <CAOLa=ZQujhfSP9EmqgiD7z+NxdD99cc0Tqarm1ROdwrTP0ATNA@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Improvements for reading object info
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Aaron Plattner <aplattner@nvidia.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Toon Claes <toon@iotcl.com>
Content-Type: multipart/mixed; boundary="000000000000c9a8b40647c99801"

--000000000000c9a8b40647c99801
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series contains various small improvements for reading object
> info for either loose or packed objects. These improvements were split
> out of a larger patch series where I'm about to introduce a new generic
> `odb_for_each_object()` function.
>

I'm dropping into v3 of the series for review, as such the series looks
good to me.

Thanks!

[snip]

--000000000000c9a8b40647c99801
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 184b170504ab9fcc_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sZU1xc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mejBNREFDWmNZSklWdGlYUFVYcFB1QlR3emFTSEdURgpoT0NRMnEyajJ5
OEY2Qk93UDExbWQ1akdUQzd3RU9oS2NKR2ZSYzhUNkV5U0lMNnNxazU2UVNpTjBVOFJYY2VCCm84
Y1pxQzkyaG9zMHdMRWlNQUdtclNrTTAxbmVUYjZNaUZhNEQxQmhscnQzeHdNVnVxQ01LU3U0NUtO
dHhFY0kKNGVicnNWcnRxeklncTdnbGdrMFRPNkt4SVBLTzVtY09wdDVSV0pGZ2pKRW5RRzR5eWRl
MWRwM2swUGNDUlBLLwpROGg0cXd4bm9aa3N6RUNXekROMUVOVitsNFh1bUljazA5TS9SZnBISTlu
ZURTVGNtRDhnaHJoYk5OV3JocmkrCklBenF3MzV1ZThYRVFmemk1d3JJL3FKaERnalhDVm5jMVV2
Zi9zTWlaK2hjQkRaTnVuL0dMOWovQ2x0cmZlWHEKa0wzbjdFTG44ejZKWE5FNzlqTjUyaDFYYjN0
Zm1HTzNTMC9US1N1aTNzdzBxOUJ0a1JpajNaYmJJWXVjWjZjeQpCK01kc3UxVGdISUhINkFSSmcr
OXU4V0tBUCtaOU9IN0x1N1FyVU1pYTlhQ0MrdWVPc25iSWI3NW1tZE9NSGZwClJGOU9MS2VxRU9I
ZllDZXE2K2prbU1VdmljUFc1MklJZDh3QWNQMD0KPTI4SXQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c9a8b40647c99801--
