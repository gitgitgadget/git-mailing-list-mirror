Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD2A1C8FD7
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732618480; cv=none; b=YesDV7VYiGvSiHI4CBwbGHBsxcE1DtVvDRNGtVQLPhzX0n7XUTCNO0LXKV02CKut0dRl0aRraW+3teinqIjHYl+UAbp9CZXTemTaqW+U9QBEd9GwQF3emZjYnaBJ63ThnAS9AQ7tLnuHf2PFDx0bJu1cbQtqQ84wjh/CHFUNSqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732618480; c=relaxed/simple;
	bh=iUBAks2/Ttb/46BXLBsaYhBQLrg6zE/jmj8s4DzEVWg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kj/PjMm8WGV//Y/hLns/8YwthCUXGWbydkRfJ+JyW72VCcoNIEsNguAk3ahoecItx/n3aC97ZW3w18BFOdruwieAG8TxKFdb08rJLMRtZtWSvTbBfofDVib9pJ1NKHp0hSlpBHjlOU8gmkqFGyR5vd9fM9QUIcUM/xfZMaIqZ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIggCYKY; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIggCYKY"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-85700242ca1so1197528241.0
        for <git@vger.kernel.org>; Tue, 26 Nov 2024 02:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732618478; x=1733223278; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aYphyAgIS3SP2j/KxK1zc7lsChxaKeC+CE/j7kjH6Fc=;
        b=PIggCYKYdyT43gEQ+9rdqJcey7tDiQtENtM5so2dwl1Wt43ZNlJvRPsxrTlPr5GcN5
         ljLN8IYhr3vnkgxZInmRevlHdAJ3Mi0fhhxgp+hGbX8ESMh76KLZyd0hah3Kfj7dynIN
         ymPSyLXInh/OzN+ovxbhTQNqLVVqTUb+u6VIyK1djW7t+Hq2Y7E3VRfgB2AuRJVryQ+6
         e/ESsyF9hJwtJwmq8MOcd9GxjIwxNHhD+y0jC7YPQFVeVjNXjOy40c00Yv3OFUpeaCxh
         ivrB2Pdla9ZTtl16bCeJUtDSKdjjTlbDh3tNfzdcB4NnuifIU+N8crw6H4wvuIT/Z7Ou
         kKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732618478; x=1733223278;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aYphyAgIS3SP2j/KxK1zc7lsChxaKeC+CE/j7kjH6Fc=;
        b=mzZy3uU2Kg7QfGhSopRj6RNbqq9cbu6t2UjHkAKreWzzrPQ0JesG3tGQL36UWiX+mh
         JxLmesqRkt11mBxV9817WIlbPkWMeHHM1vDKaGNt5aZx7si5hFpe2E4wIUZvQGox/IAI
         zI/tuixXgGPTlHAL8OU1ls2frIw1VL1WGi2qEqNIYJy+w5u4eCelNsdavfs9f446OlQz
         p2gfhXw6kQzUtDxqwVjrfR8OfK1JYcUYjOQmo7sTJ33UIUgoj8EJEIRsJrKSgHg5St/k
         8JvXe+Z6xb/7DcJmnSetjsU3EBs9/WPWxh/Y/Pnb5cj2P8P68umEewX2DNh8y0L6inyV
         qMDQ==
X-Gm-Message-State: AOJu0YyUkPVugFZ5Uw9K2N7VUFRihz4Pd8u0x167JxGPE5x4iZ5qwHu0
	K8RJN6CkHonYXV04J8BJOMmxn2EwuyT77JDHbXaQt+mBnj/GmDq7uviq3QEi32z+ESVZAj6Rxmq
	WmxDC1uzw/yDzVkIdrB0LmOLRoEc=
X-Gm-Gg: ASbGncsuclZU4UR9nruYMKatJGEMFzNnZRSzNOsjXCDFaCcDN5utg3KqMmyTTKaxTcA
	lkYHpxlYcEGQJIDAI6K8DAT0CpTlopg==
X-Google-Smtp-Source: AGHT+IH7gIo7LJPvwx1CnY0RMchpUvQv6Zi2N0f3QMqIb1hfv8a9zOo8ETjGxuaXjzmmOhZR64X0VpR6+KnbHPxWQF0=
X-Received: by 2002:a05:6102:a4d:b0:4af:3f64:a111 with SMTP id
 ada2fe7eead31-4af3f64a397mr523701137.20.1732618478181; Tue, 26 Nov 2024
 02:54:38 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 26 Nov 2024 02:54:37 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqfrnezcbh.fsf@gitster.g>
References: <cover.1732269840.git.karthik.188@gmail.com> <d1b6e8801bb7edc9ce55bb50a5d46f9779906ad1.1732269840.git.karthik.188@gmail.com>
 <xmqqfrnezcbh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 26 Nov 2024 02:54:37 -0800
Message-ID: <CAOLa=ZQY-oLzshh2iEcxkZE+ut0WjE+A9HGRwfuyFNwweeZPHQ@mail.gmail.com>
Subject: Re: [PATCH v8 07/10] config: make `delta_base_cache_limit` a
 non-global variable
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, me@ttaylorr.com, peff@peff.net
Content-Type: multipart/mixed; boundary="000000000000ec8c5f0627ceaca1"

--000000000000ec8c5f0627ceaca1
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> In `gc.c` add it to the `gc_config` struct and also the constructor
>> function. The gc functions currently do not have direct access to a
>> repository struct.
>
> We should remember to remove this member from gc_config when we pass
> the repository through the callchain.  As a built-in, cmd_gc()
> should already be receiving the repository as its parameter, so it
> may not have to wait for a long time before we are ready to do so.
>
> Perhaps have a comment next to the member's definition to remind us?
>

Yeah, that seems like a good idea.

>> These changes are made to remove the usage of `delta_base_cache_limit`
>> as a global variable in `packfile.c`. This brings us one step closer to
>> removing the `USE_THE_REPOSITORY_VARIABLE` definition in `packfile.c`
>> which we complete in the next patch.
>
> OK.
>
> IIUC, Taylor's comment to avoid repeated calls to configuration
> layer to obtain delta_base_cache_limit, aside from typofixes, was
> the only thing remaining for this topic?  If so, everything is
> looking really good.

Thanks, will send a new version with the comment inlined.

--000000000000ec8c5f0627ceaca1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 14896ad96e6149c7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEpCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kRnFPd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNU5NQy9qdDRNWGJTZ1VwdUhWc3FJZkhWMWNrek5NQwpPUFQ2UnVrWHJY
M2RSWG1GdFF3R2dpc0RBRjlIU1hISjNpekc5UUlNQlZFcmtCNDFwakJoek82cUYrbFRZZWljCmNR
aTk1MnlvZTkyRmpHc080K3FpRlNsdUpUa3c0RDc0NUlYNHcwRDRDcGJUVG1zMWZVNXZCdm5Odjht
ZmtRMEMKZFQwRHR4QmZIUzJUVXdnV214Zk5GUmwvdllldDhkNmc0T0pkVnFGSWExNDlxMHFkMmVv
SlRZN2pnem9RTThJcApneTA4V3M1L1kxM3FoL2c5SDJHWmpoeUs5YlV6VXJtNkpMRXdiWnplK2ZT
QkRrMjg0RWE0S2VBTUl2MFJUcElSCjNjYUtXNjd1M2lJTUs4YURZTGpMUXltaHVzWDRHY1pheUlz
Vml0Y1M0SDVVOGplSUsrVkNocmtlRm5Sdm81WDYKYU1EVGpyU2RKNURkUHVGSElXRHMxY3A0QjBx
c1luTHZENXREYTRvbUxvc3NQNWwzM3E1TW9NZHQzekRlSUo2UwpVWC9yUDBTS0VZVW1xbTJGQUI0
Nk85ZE1IYzltUkpyZGNnWVdBYTc4aGNtd3BHdFhFYVBqbGlodzRKay9ORXNPCjMwM1RJejVYYTJR
UWk4eTFCdkdFdWJnYWw1c2ZyUGFPOEg0VzNBPT0KPUhKc0gKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ec8c5f0627ceaca1--
