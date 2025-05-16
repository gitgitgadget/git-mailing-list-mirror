Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA69282E1
	for <git@vger.kernel.org>; Fri, 16 May 2025 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747385967; cv=none; b=NWHzDY5wCDGMbsmsiVx344PQd4M7cozoGuz60KlhvFsKDuCjjnpL0/tHs530WesjgUFmpKg+v1FgMU4Gl3PeqGwGcv7SO1tPBi447biGmw3ilxudBXHvKmPrneNaWvvsV0RFtDVn9rUv+PbZkAJhojlYVmPrH/n9LzHDulP4U7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747385967; c=relaxed/simple;
	bh=es+pHDdEEQBM9RL5XK+IgjwNCueEhTvvaD3jXKpjmVA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkSdIgaPEcY3dZ+w/1hEOehY24/6VeBCZCtt6iTXc5ssHMIk0Q3fito2HQXNU10af2hplXdEsLPPA1+ve3dfs2CEDG/70fTzLATJ0y1nDOwskZF4ybX+/FshFRCRWZWwqT/RkX9UgW4gYhxiGPYdXv9GbxNFWSSgUz7MMSV53u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BW/3xdg9; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BW/3xdg9"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-875b8e006f8so459745241.0
        for <git@vger.kernel.org>; Fri, 16 May 2025 01:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747385965; x=1747990765; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2lROfrxJDMiKJu8/TShR07UNw/rYb+cJzyi/tBdbCc0=;
        b=BW/3xdg9OJnZthYeuC9RKlfp0oho4f8kT0Nco/7MJ8OA3AQ1bzASpTVcnNTlfCZPb9
         tETjWRxFR6U3McFQiDlJ2UVLm6A7ZVuzEhz0pbFCMM5yuZGXpiFfiujs7SvEjtO9/kPI
         4JveOfSh+qZM3ZIvTRpZooCPeYcmOE2jnnPR8Crk6pN/lKYKgoU0L2zEo/aF8LK64erq
         zyavgW+Xzems3KeLUIhOLAltZYC+8qlMakJeDft1/7ocP9IWvbFCcWH9s6GWUAQHZfni
         hLdAO/hBuJGDSNMklInudDAxuwHRDvz51uXDbqw6X9JOQbHfAzzlUE1OTcG686rFY8CQ
         ugig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747385965; x=1747990765;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2lROfrxJDMiKJu8/TShR07UNw/rYb+cJzyi/tBdbCc0=;
        b=pkv/D10pKPXC0ahiVCs6WgzPZKw4bFi8oHm+sDWg927ItfNIYeSooYIAdrpP5DWu9d
         03AuQHp2RFfwBTmjnymG1xKeOAiij7fxMqqWOwOE6RnyYrASC1g4wj8vSANrhT/Vms4O
         e/7dyU43phZ2jhgDtRW0kxyVs1AB0ctUOnAawfO1pTtxzwCIeYXZacz2eagcttNVkRoq
         41c25O9amImwLWorzfWF0/k/A4r+92CyqlBeXf8KWop1RL0lXNQ30Q4+Rjf26GnLp//u
         DqKzUrYjtCnps5UGHFaanNUKxbBJK5DF+WMFrGtYdyuk7ioJOXl0Sa+QUE/qUyGMqEz9
         2GYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+HkYc29xnAAMi3XNzkh75db8a9wcTQU8yHxWLxNljtDdORs5bAV6LKOQIW1sBePLCmLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydg+neehK5fpb8IN7qQ/6kWUcKAA8QxMvc024g+8ZPAUg8WGVW
	wDODdbBVG7UvfApqVxRpCqFHEzcnEbnR+pnlBYUwe6qWxjFnHLlU5V2xnlX8FHtaz1yhYGXzlY0
	fiFEQ0qDkcQCHmZVCNObjI3wCsh/J+No=
X-Gm-Gg: ASbGncvqZMK3mi13gfusvQhQFnRNo5RBdmUVxUFngKZCKR9i4jJN09qB4VNAvDYe5tM
	IUf2SBhtEWgzGYD4BRhi4xg0UOWa9V86GwdbMLjc4kGns5fFP+g3vhl28iJOjdLQBTUcX7G3U+d
	KWEIXfttIoiWZeEK5sRxIelwv7FmrO17dHTx2dqsGj8NEBcOvsqJtYLrKb66GSEQNzZBU=
X-Google-Smtp-Source: AGHT+IFi+Xk6zClgeE3zXwnAhgBWaXBlVm9IJjWBuAoZenkVV6LZWSFq+9hm36XGCWTWJti96CypbtDEoZEfPjN0Mcs=
X-Received: by 2002:a05:6102:32d2:b0:4c3:6215:9f86 with SMTP id
 ada2fe7eead31-4dfa6c10efamr3677720137.19.1747385964714; Fri, 16 May 2025
 01:59:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 May 2025 01:59:22 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 May 2025 01:59:22 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250516010159.27042-1-lucasseikioshiro@gmail.com>
References: <20250516010159.27042-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 16 May 2025 01:59:22 -0700
X-Gm-Features: AX0GCFthhmzVf7YWO1zopvba6r4e3gaj58fyAZWWJztImKu7isdc2tbyahohiXI
Message-ID: <CAOLa=ZSH4CUdAUOT7H4B+2dwgfx22wJxxjt0SqPavAnEsdkHMA@mail.gmail.com>
Subject: Re: [GSoC PATCH v3 0/2] json-writer: describe the jw_* functions
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000b67c8606353cfff9"

--000000000000b67c8606353cfff9
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Hello, again!
>
> In this v3 I did some minor adjustments based on the review of v2
> (https://lore.kernel.org/git/20250512020935.73140-1-lucasseikioshiro@gmail.com/).
>

This version looks good to me, thanks for the update.

I do have some general suggestions (not requirements):
- It would be nice if these patch versions were inlined with the
  previous ones. Makes it easier to compare versions while reviewing.
- Perhaps include a range-diff to make it easier to review the changes
  in the new version compared to the last one.

I can totally recommend b4 (https://b4.docs.kernel.org/en/latest/), it
helps manage both of the points I mentioned :)

> Lucas Seiki Oshiro (2):
>   json-writer: add docstrings to jw_* functions
>   json-writer: describe the usage of jw_* functions
>
>  json-writer.c |   4 --
>  json-writer.h | 171 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 171 insertions(+), 4 deletions(-)
>
> --
> 2.39.5 (Apple Git-154)

--000000000000b67c8606353cfff9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b7892c09113668c8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nbS9tTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOHpRQy85YldoUWJjU21PN1FrRGtTcUc1MS93SzkzVgpIRnNZeWlpV2RU
NU11TGNNNTZxazk5Wk5NZmx6MThSMGZVOU8rVm5lS3ZHb2dvd0Nta2xrZndFT3Bld0pna0x1Cm5P
STF4ak9IVHVtWjQyWGs1dU05Uk5hR0xzdGhIK3VweFl3Zm54NWE2dXlJLzh4Um1ZaDgwUDZ1dGdo
NjErOE8KM25tUU9lWWZJK25ud21NWE83RXpZOEwxQ0ZGMWI2Q2FPTXdMa0pNZGw0VmdGSThzczc3
YzEzSm9qbWIxZDZkQwpZVzFwYnRqVHlMS2NGeHNRbERKQWdzNjJBRWwyVktaQ0hsNXBDeEFwYk9h
VkkzMGVTejYvbjdvc2ZxVFBrNDhHCmJ1d1lnVzkrbnd2QXJEcGY1S0l4b2JYYmVmNFNsZEljbEhR
UGpJNXBMdE9mN2ljMHQzMEU1Z241VHdMNGs3bW4KcUlqTHZxak1Kc3hDSGhLY1dvem45M2tRMHFw
bU9PdnQ4LzNLUmUzM3d3aDBqdUg3TVM5MTNxRko0Y3lpbzZmMgpRZFR1U05NWTNBRDBkM3IxaThJ
SUlsQUx4dWVrWHRPSllRWFNuL2lvUVpCRURsZ0NNZnVtWVhPNUxLTEtQbXlQCmRpOTlEUWlpbllQ
L0dkb3NrbllaMjZUbGs5THo5YmZTQ2dYbHhhND0KPWR1dXoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b67c8606353cfff9--
