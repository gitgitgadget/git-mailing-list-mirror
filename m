Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4066F2D9EFF
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758023434; cv=none; b=cgghGgb66k9htDOiHGqhjd+JWZKLofl3wNKG68l1mD7UkJpYtI1E/HkGbY4/M8ugvEsYaWwkJxfKeCBpO3JqQrjtU8Ht8cPjX/+z+qyvu7t15vxkYs48qZxz8GNjpAqhvimAbHwAcYqOyEyAxS5F7JSW+UwMAgu/K9ypCEggVG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758023434; c=relaxed/simple;
	bh=Z9fp1xcaYdZhJe4cBHsVtCWpXPzJKLz16V/pm+5r0bo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqN8ZMS8sc8Dk2XBWFoHLcgE4CJONlc7UEEQ3uNU+IfiNoTbT4o2pMciHuRALm6yOXOJJJRp/3vL/2ggGOlOh1ZeXGsV9RtJKo1VTzQIlNrEqvTyJXKXSVY9fSsZmV/OBnMpZi7bMHAmyvpEK7g77fSv13tEVvvUfc6gkw1ZXVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTrrQJVF; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTrrQJVF"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-8dd35d9d574so1266364241.0
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 04:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758023432; x=1758628232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Do4Uo8FwyUkl3A2ei3SN9jogDq41YpJngEZ1zhBGIcM=;
        b=bTrrQJVF64+8Y1YHfY//ihDpssgadgnk0k6JLYP3SRnC48xB1HFvMPi+gxe+/v0QKH
         +H6j5LmTI4ub+p5dnzn5GrcgtJxp1ejUqoAY43Gr4b4ETXR+6KFG8/KbbRQId/Djizcs
         ei0zNvRtGAhwEwzXaTBdldD1VxMmGCeM4vGIKutcuM/FMGN4s3LT/FdYv7y4REiHkoc0
         oJfbdZZ1hcOv6SyuesRj2SX/9u6uiYTYBOii/4kETgo1IszHEMFrlbTIGEMi26nYdKTl
         q49NkevOpjP3JcXl1gQ+5898/ZjmjoeC3uFTWwWn0ux+BK2aCUgcSGbGtxP3bQghfFnG
         OYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758023432; x=1758628232;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Do4Uo8FwyUkl3A2ei3SN9jogDq41YpJngEZ1zhBGIcM=;
        b=MeAubo8dWXfODm2PJiHyJfwDLnOZLGnHOzbbRFn/xJFLJlPn28AJ1P7Zq5sBJk57EL
         pD5Q7i/p/Ut2Q7D2gM2h55NnuUg8toh1fH2T4B6Dl/7ha2C5GzqVQID6z4q+1C2aQRLp
         0P1nR9CykuEW4SYdOaqfoAQpiyCSq8VlR5qUNHesM7PHe8cSu5tE5NqnN33w9uzEhrpb
         l6ig9bPEmPEkIxHtEwzWz3EwUTLn3l1thlr5bQ9Gqlgze3kqE0MLZDVvC2BlkYeC/Ni9
         KNLLCTbaLikmtxduOF7W0iTuh6E9qlAZAvvbFKmHIwqGVAaA1pQT/61rboab/ai6Uqs7
         VYZA==
X-Gm-Message-State: AOJu0YyB4AUf0C7KOhYzZKU8CwH5l3Q2w8xS3a539U7OZREa2c1wb/Vq
	7mSkIVccnmiGjEE0d+4XWiEqCsMeykNYbdoEDbYUb2ODmn69LxtWelW03y0tDNgXoORQLdgZZCB
	3S+WsNMKeCeE42S58FMZpCQl3S4/jcNE+jl9C
X-Gm-Gg: ASbGnctt8H8R0Z62hhfdF0IBzrqhoc0cKRWbvsR6tBxWgwCDJLML/niaiY9iF7GrKRE
	7rLM1m26hCBG2La0f+xZtotHEYl4Q0KVhO+/BF3eW3Yu4mW+84X2iOAsieBlKVw8I3A/PyYYw3t
	Wvz4HcIDWlRvYrg2G9p9MuFNx5N7I5LVqdhUd7nB4PWBAv7bHZHKzD2s4ZtINvqMXMX0GS9mha4
	xU8i0DB+tomkuDs9WvAdoHivxPqCMtENWhRdaJm3UYvBNbJ+u0X
X-Google-Smtp-Source: AGHT+IFa71a7FsiiipEMn2P7L1o1ZK+CnR+DLhE1vdxOZOkWQ5VngLc41mtLE7RwFX7oOTetPjMKcqQQ6SweI6uBQfc=
X-Received: by 2002:a05:6102:50a7:b0:526:db01:5fb2 with SMTP id
 ada2fe7eead31-55610dc0a98mr5411201137.30.1758023431995; Tue, 16 Sep 2025
 04:50:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Sep 2025 07:50:31 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Sep 2025 07:50:31 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aMk0CdaN8pzEPf7m@pks.im>
References: <20250911-b4-pks-meson-docs-target-v1-0-a92c666ecef9@pks.im>
 <20250911-b4-pks-meson-docs-target-v1-1-a92c666ecef9@pks.im>
 <CAOLa=ZRVaBp6DAM4gYXFjCRORYxObvWn5egrPAOcGZ42mxnsgg@mail.gmail.com> <aMk0CdaN8pzEPf7m@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 16 Sep 2025 07:50:31 -0400
X-Gm-Features: AS18NWC6wuZA-JHeOXuU2FFI7AmOcepx4EYliHVXaR5zZSB5ALEvhENojgd2lRM
Message-ID: <CAOLa=ZSvra91ca_-rgNq1UoNQg6-n1nF4F7NgjuAc-mpNBTS4A@mail.gmail.com>
Subject: Re: [PATCH 1/3] meson: introduce a "docs" alias to compile
 documentation only
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000002bf5bd063ee9ba15"

--0000000000002bf5bd063ee9ba15
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Sep 16, 2025 at 04:14:56AM -0500, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > diff --git a/meson.build b/meson.build
>> > index b3dfcc0497..40b2a2dc54 100644
>> > --- a/meson.build
>> > +++ b/meson.build
>> > @@ -2101,11 +2101,18 @@ endif
>> >
>> >  subdir('bin-wrappers')
>> >  if get_option('docs') != []
>> > +  doc_targets = []
>> >    subdir('Documentation')
>> >  endif
>> >
>> >  subdir('contrib')
>> >
>> > +# Note that the target is intentionally configured after including the
>> > +# 'contrib' directory, as some tool there also have their own manpages.
>> > +if get_option('docs') != []
>> > +  alias_target('docs', doc_targets)
>> > +endif
>> > +
>>
>> Shouldn't we also add it to 'meson_options.txt' with default set to
>> true? That would ensure that `meson compile` would also build the docs.
>
> We already have the "docs" option in "meson_options.txt". In fact, it is
> not even possible to have an option that is _not_ declared in that file
> :)
>

Nice. I should've verified, I was merely looking at the diff-stat

> The option accepts an array of choices, where the choices can be "man"
> or "html" to build manpages, HTML sites, both or none. So as soon as the
> user made at least one choice we enable the "docs" target automatically.
>

Okay that makes sense! The default is set to '[]'. Okay looks good.
Thanks for clarifying.

> Patrick

--0000000000002bf5bd063ee9ba15
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 95aa33fcd0caa3cc_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qSlR3WVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meExqQy85cFBTK0tLQzZpSTJmT2lFQ2xtcExpODNLVwp4cVdhUzBVd3kr
M0lybVNIN0JnQkFjSjkzenRwQUNLSmR4Vkt4aTAweEU3ME9hUEpITmN6SGV1dTVzVE5TQVFsCjU3
YUdVSEkybXBNU2RCalBKWFpZUWFXcmsxWlVQRExWQkJnc3R3OGdKT3JJWTBXLzFuUXlwWWRqUmVq
MmJxcy8Ka2xPOG5td1hZd1U5Mm9Ha2s4cDBvZ2RLTmduZ2hRMElPdkFWaTlldTJxN1FLTjJ6Rjdk
OU4zdW50RlZJUU9XUgp6Q1lQaFp4NEE4OGlLQnJWQTRlS29tdFd2bmdrc2ZBWmNsNlFnNE4vY3gy
bWpuUEsvV1ZqL1liQ2NQZHFuSmxNCmFkTGpqcnBudCtSR2FJS1c1V0ZkakZ6eUo2L3I3cnhZOXhv
bk1DOHVWbEozSGJGK0RIajJZbTJBcURoY3M3RjIKV2FuK0o0OGs5R09Zc3dSbmFQNjFBdFdoVE1C
OWZmZExhbHhzOGhTMDFKS1gxc3FpVjZBVit4NHBUcmNjMGNKUgp1ZzFwbDhIMFlLeTVHdGRVTy85
aUxvamFITDc1SzgyTjVRKzFBOHpQd0lBU3VrRU0xRGhDdkY4U24rbUhHMmorCjByaGxPL3lpMURv
c0thZklLOHZ4K3Z5VklycjVWb0ZrUjgyaHF3az0KPTk2dWwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002bf5bd063ee9ba15--
