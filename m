Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DBE7083A
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 19:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869773; cv=none; b=dr803bl8/hVbJv7AQsXnw7aAlF62zktpVDa/x1lAal4PTAE/BCcv+eaA6cAU8p+ihgzWg7iBMw1kkuIU0ithn2C6d+A/3+f5aUck5e8ac4wznObuQmxqFvV4fuhZ4fwATKPv+klQQ1DODH6KyAR+XE0aGj9hqn5EKRxEVetLL3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869773; c=relaxed/simple;
	bh=iiZ6DyCYPLAoYg8wc425Br74UvcPWMsmMHRVHrAIBz0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=qNsVPDVDfsn8OaACeepHucWNx9c4EImqglbcEQD81HpP1xDOjJG7Vid3tU/v3poj6rVUP4L99u8cZDSsSaIGZYQHKZ4uxToQGbwBF7xYD32s5alhAGidyR/6fYktvCNXomDcqfEVt0hgSNocUQEmfME9SB5pxTHXq8B5zyj63AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JX75Z5vR; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JX75Z5vR"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-525b44b7720so2124835e0c.0
        for <git@vger.kernel.org>; Mon, 28 Apr 2025 12:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745869770; x=1746474570; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Edqcikz6/4X411kFgcrZ1BSkQ3CO4cN9JA4ycXEl+ko=;
        b=JX75Z5vRGdATxAkrj7EUO+U04dvkpmqBSrjdVuTxLgg57GBgjm8pAl3WlwBfSM9ws8
         zHvIjfdXXJKQ6mAPSu6Wu7xdsHVYWg/KPvuTARmCADt6n/lKiM+SPelN1jaTrhwbE1D9
         c09B2MMGSKIKgl9JQpSHR3AyIPNpBPqlEu7dSRRNY6lgOpoW/urNN0ib8x2fKrng+IEu
         9CG779tmZUxLPfiVwtO3fCbi4GkfxAgShaWrO7FnNoDl8DnzjMMfV6sJP+AMwPb4B6aj
         WXLrEfrjwwmzxJ671VIAjJjPqUHlTckppPLnLlafohdJVyHLlo/R4sEJepYMG3gVyY3v
         oxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745869770; x=1746474570;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Edqcikz6/4X411kFgcrZ1BSkQ3CO4cN9JA4ycXEl+ko=;
        b=TPkYaA4Q5xuoKCW5H+DDoP9cYG2zQ5Rs+06lifX9WMMNBH4EwVB+OFjPnH32Wd8o3S
         HDAjIdMAERM4nhrXtNnOLrj6QD7K9pvn49vpeWsDYB4NMT9HRjoOSsuFwIH5MiCFNvni
         y4gdO7FTQ00u2X7CwTkqHRE0RDw5Kh/TGT0EfTFT06Hg/WIOfUjUIpBGi/xk+FImdtBQ
         qGttgUSEbXGSa+l0EmLNgWFI1WNHqnRoNgvqSpW+L/PJ9tuAZHg5cCVvgtiqsq1SXZnY
         pl+aHVu4m6s4nqxjpw5t3GMHy2vFaNMSgP8hq7neEQmnQHk0c3UjNQTKhzz9Akc8K9yg
         nJkg==
X-Forwarded-Encrypted: i=1; AJvYcCUi77hpoXknuaOl5SxCbv4wZgdDP+qUszxO5nfzFobbCO7uaAuLclLmlpehZYTENQ3HCeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWz5+0ggNVeEcRIqIUtUUvTbr3aoFG9IQ87MtVcpAukIGXAgVP
	1A8R8uLBLqL3WYDykbyp7vqOYP6DPNIvm8UK86ygAkKddD632c3DQHkfTC51Iibjgp1IZm0bWpA
	LHFctZibXLcpkwsFrFp08UICJQYK1RSDs
X-Gm-Gg: ASbGncsiB3gxZnD8js+FlgfQdlWbzC8R5Xr6gQS8wBDZTX9nYBzPBSbl4BZcOGQBo0U
	8pPJ/pqlHth3EHvnebaeTP70x8sCWKRGxk1BkEIXMGyksHNWQ/phWXCRqECTNRwgTjuT6AE9/TU
	H4HjqDpHpuPJMJPk954S9NHX4+aqObh36ByL0/bga6oXs/7ziDSPsDvsNRBjNF+KKKX7o=
X-Google-Smtp-Source: AGHT+IG/C3b9Sd9rnxC+kRtZtqHrzAAXtOSObXgnQADpWVaZwYaeI1RR/sWyKf5lKfBueQaxcgZ/QfPwn89mEVRX2mQ=
X-Received: by 2002:a05:6102:15ab:b0:4c4:fdb9:2ea with SMTP id
 ada2fe7eead31-4d640698094mr7925585137.7.1745869770394; Mon, 28 Apr 2025
 12:49:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 14:49:29 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 14:49:29 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
References: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im> <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Apr 2025 14:49:29 -0500
X-Gm-Features: ATxdqUH_eVKf0avmnWshyvPk3_sh1z7CNVxHCJHhED5WSHmhiOCO49SzZf3TnsM
Message-ID: <CAOLa=ZSPoWOpMPj3kD5=aZQfU_JGX1QH_frJ71stPrtK_VQ4RQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] object-store: a handful of cleanups
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000007d2de10633dbfb9c"

--0000000000007d2de10633dbfb9c
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series contains a handful of cleanups to the object store
> subsystem:
>
>   - A couple of definitions are moved out of "object-store.h" as they
>     belong to other subsystems.
>
>   - Some functions are dropped and/or renamed.
>
>   - The biggest part is the removal of `repo_has_object_file()`. This
>     function and its `_with_flags()` variant are marked as deprecated,
>     with the replacement being `has_object()`. The benefit of that
>     function is that it doesn't reload packfiles and doesn't fetch
>     promisor objects by default so that it becomes more explicit when
>     one really wants to do so.
>
> These cleanups are in preparation for getting rid of `the_repository` in
> "object-store.c".
>
> The patch series is built on top of 4bbb303af69 (The seventh batch,
> 2025-04-17) with ps/object-file-cleanup at 68cd492a3e6 (object-store:
> merge "object-store-ll.h" and "object-store.h", 2025-04-15) merged into
> it.
>
> Changes in v2:
>   - A handful of improvements for commit messages.
>   - Link to v1: https://lore.kernel.org/r/20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im
>
> Thanks!
>
> Patrick

[snip]

The range-diff looked good to me. Thanks!

--0000000000007d2de10633dbfb9c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e8575092d8432dde_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nUDI4Z1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meDVGQy85VDJyeEowSVZmVzNRVmEyUTVzUnB1VU1JTgp0M0JRNkdBL1A5
ZWlWdFYza3M1M3ZBMkdibFN0WnRxVFNoQ3BkMWdQMjZsV0c0b3BuMDBjNmpSQ29uWXppdXo2CktC
cUtJY0h4SHBUVEtYakJxZnU2R2tjL2luYjY4SjRCcDJvaEF3akJiM3VlejJUZElUcnA0TGQyZGJH
cVRjR2gKZTBHK2ozSzQvdUJLNlFzTUo5UktNMWRuTEdCQklRejd6OWI0VDZZaXlNdXpTYlJmSyti
amwrWkk2OENGZGkzVAp6NnA3RmxORnZ3OHJJRXJLNzJ5ZzZCSUJEdnhiVGZLN1RuOXduNkFaZDVF
VW5iTU4xZkU3SkpXMVBnU24ybkowCjJpUGpNUU8xQ004NXprKzQvaG5wam8wNjBRVGZVMnExVXJQ
dEUxcVBpVkJWUk92MFFQYkN5TDdFQWEwSHRwb2QKRlgwYkNOYkg1MElUc1QycmdxaS9RS1U3UWJt
VlpQY1hNT3FmbFBWYzA0ZWUvKzQ3b3ZSVUZqeThZM1F6eXRDNApxNGFVOTJLQzBJRnVBVTZESFZh
Z1Q3YlRnRzlhTnZlSFM2TVNQbUlMV0QxSVdlNnBxQjREdTl6NVlLeTVZdm80CjNSdVRnakJtd3Js
bnJnK2dFKzJrTjR0SWJHZDhxOUU0bms2T08yTT0KPUovUTgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007d2de10633dbfb9c--
