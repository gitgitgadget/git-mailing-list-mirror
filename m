Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71892215F45
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655244; cv=none; b=NLdRksviX8uG0/CYxyc9pysdpEdDXrNnLHXs3yX/KmBthjOaBqIhCD7t/nE+WKDDAzl5MgxtqIkz2o7fMi3It8fPg1kswJbqgVBhQikQQSn54U1HSqh0RXVj7MQTmi9qGwa0wR5yx5YChP8fl2I0n7PSvGFAa1RZEibZYfZo+OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655244; c=relaxed/simple;
	bh=pUfha2CU/VqxZ4FDhl13e7njgfsw58dbs8wd6qSHiPc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=aRHlDWF0LiKq3WHlvWPZj7b/u+k56niykX6M50B1xAew1vxB2RF90SAnw4ToLrRV1A9YArmL0MYLN4CWLHmwniUMi8RddHNQXc2hkkUh48gK2OaPUW4ejxcyyqE/fURhWRPwV9MY2ROHdAv1JSYkWyL+PygCyFJKjJbZNLhcOOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFk4fs21; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFk4fs21"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-860f0e91121so1425773241.0
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 03:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740655241; x=1741260041; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pUfha2CU/VqxZ4FDhl13e7njgfsw58dbs8wd6qSHiPc=;
        b=SFk4fs214XQhfK/S8oQDD2MburaNxHOlMh3EqWFvvm0YHZu7ImNVkOwNv3g3F9CJU2
         1POzWh/xw7pbrv+qFUm6LYv9uzAyBCc1KEdfsaE0VilL4kxhRC4z/8QXDttrsi2OQbYl
         S5B2JEdwkSNyxEXG8TVyUjUUt+M5cK6Er2gYwXKtbAayT4PF+KLgZH5SgAmA2r7p9F5c
         xQNwfw0yIBu/as3Cy7lyT4KfN7tqjzqv047wM7En01Kck9s4uZQdLKSaGcKIIxqdAITs
         xuDsic2hClCCihGZnEzZWLHbD4YagoLzkVb5TPHUy7xuWY4MN0oYj7FjYDQISl/h+WpR
         fuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740655241; x=1741260041;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUfha2CU/VqxZ4FDhl13e7njgfsw58dbs8wd6qSHiPc=;
        b=e8xLv+iheVLEJVovNwChkSU1rrdCGHqPzyaGANZxDMWLlScZtVPIFzSzN+Z+5cp4O4
         jXGNcLJeKw0fFI7pR4LOL0wms5i3USofGt8ToPnUAXEzryePMJSa2vdSyW/FYzfI/ZI/
         aXSrgJ5tPfBFJO0TX67gCu7Jpa9uy41K7Xe9s4jzi+VNYJe6ey1sffwyeaVL1MZfzq59
         ptXK91xIrIc8ALQi79pjr/GM9pivU1BN0cn7PH5B5N46Yl8RFRN4rdDGfEbGh8qw1lon
         M+vV2Qq8GloNvUgkwpBaT0v349osjt2I1jjFhcq1iyKnkW3C2w6KYRy03aEDp9Xf7H9U
         9CxA==
X-Forwarded-Encrypted: i=1; AJvYcCXhSiKz/T7N8RAcQPQIlgUEAIYoaRBab8YUc2uC75qC23G46SmNhQR8EnSHC2t0JEE+jrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye8+It/OiA3tD+JaV+aKk+yNj1pWuGAQac5n/kGoRlKRfNPtBW
	gpB/Rkt10Y66AERSzQOgnWmQUDQQUlWa2/FBPZd5tkvw6RwFYqDlY02meplP1LMQmf9xZRtKT89
	BYMfaizeHdERLs53xdF+layjQxDk4CYHj
X-Gm-Gg: ASbGncsxz1lUyXPuXO3Xoak2LRIOOccolml2nStsm/9Cv/mEtlrvPEt7XCvjL9IyQli
	ZCK4MatL23Jhs11mhVnLFd5TTOjTEVirUZIvGTWe3BqXwikTu4lM3cGSXUzacp+0MKDWvgnzHh/
	thoWGdyEt6Vt3OvnhesY9sAIdVKaVIt46eDG6CKcpj
X-Google-Smtp-Source: AGHT+IE6VzBHaTIbjqsKHuodP2yTPcqeHsNRpIhe/gCe6gUIHmK4+Rog6Y5KRa7lWPQnNB9hOeWL2Aa0oDaQHycX3Vc=
X-Received: by 2002:a05:6102:943:b0:4bd:bc19:851c with SMTP id
 ada2fe7eead31-4c0310053e5mr1641837137.5.1740655241181; Thu, 27 Feb 2025
 03:20:41 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Feb 2025 03:20:40 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250221-pks-cat-file-object-type-filter-v1-2-0852530888e2@pks.im>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
 <20250221-pks-cat-file-object-type-filter-v1-2-0852530888e2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Feb 2025 03:20:40 -0800
X-Gm-Features: AQ5f1JrpClM8dNApm_WgojKNRDjdtujMXXyNLZA5M0HKO4tZHF9Xz9pza8q2du0
Message-ID: <CAOLa=ZRHWSpefDOZzPTZZY1k-Y-w_Vv9rri4WkGDy4NRVCW4HQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] builtin/cat-file: wire up an option to filter objects
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000053ce96062f1de15a"

--00000000000053ce96062f1de15a
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> In batch mode, git-cat-file(1) enumerates all objects and prints them
> by iterating through both loose and packed objects. This works without
> considering their reachability at all, and consequently most options to
> filter objects as they exist in e.g. git-rev-list(1) are not applicable.
> In some situations it may still be useful though to filter objects based
> on properties that are inherent to them. This includes the object size
> as well as its type.
>
> Such a filter already exists in git-rev-list(1) with the `--filter=`
> command line option. While this option supports a couple of filters that
> are not applicable to our usecase, some of them are quite a neat fit.
>
> Wire up the filter as an option for git-cat-file(1). This allows us to
> reuse the same syntax as in git-rev-list(1) so that we don't have to
> reinvent the wheel. For now, we die when any of the filter options has
> been passed by the user, but they will be wired up in subsequent
> commits.
>
> Note that we don't use the same `--filter=` name fo the option as we use

s/fo/for

> in git-rev-list(1). We already have `--filters`, and having both
> `--filter=` and `--filters` would be quite confusing. Instead, the new
> option is called `--objects-filter`.
>
> Further note that the filters that we are about to introduce don't
> significantly speed up the runtime of git-cat-file(1). While we can skip
> emitting a lot of objects in case they are uninteresting to us, the
> majority of time is spent reading the packfile, which is bottlenecked by
> I/O and not the processor. This will change though once we start to make
> use of bitmaps, which will allow us to skip reading the whole packfile.
>

[snip]

--00000000000053ce96062f1de15a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 214e4272a82a5be1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mQVNvWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMHNlQy85NTFvSHVxcGgwblVxZFM2VmZxY1ZCTHgwRQorL2FzOUp4RW9B
cTZndkQyZW1qTDEvckk1em5yWmc1UjdON3RMeDlOWHNqekJZMjYvVXBEVE5vN21xZjJjNy9CCmZv
SmxuNkN5NkJ4bVpJbHhMdERFMFhqZUNsRXgzOE1UeHhmd3kyR0NubUpRSnh1cytIVnpocnVIb1lK
VWdMZE4KSENvNXBHTnJIeFh4cVpKU24xd1Z6UVBIZi92dUFMZmhYMkhLM2FRNU9hNkZaeUlFY0h5
RTE5NWhXVjZneWFrRgpBWCtyeFNid0pJRzdqZi90alh3dkU5a3cxdmFSY1JCcWl3d3FlTnFPdFRX
bVlDeDVQNDZzUmxQZTFYdUNVWXVxCmh0cWRJZCtWaXlCdFdZWEsxRUhCU1dxOWJiVXpZbmU1ZFRD
dzRLWDNSNjhOL1AwNWdXd003dWZzRnpxeHR4T04KS1NXRWI0NEpJcFRiSzhzMll3YWxudUEvOWcw
aitzMm5GbmFrckc4a1lxUWFPQmNuTllQTUFOQndFajhhejNBMAp2dUNidFNpajRJQXcxUmFyYmY1
YTRhcW5ZaTh4UjhTaEs2RHZnZ2NNMlVEdlZmeG9lVDJ0ZEgyTjBXcXJJTFYxCjUvU2VHbTlQU1FF
bkx4UW5sOVJZeHdZT1VpVGlEQ3FwOVBTOWhacz0KPVVxSEIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000053ce96062f1de15a--
