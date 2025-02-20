Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA491F1301
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045620; cv=none; b=CiMNgTyyxjdnEbvW8mcdawvWe9aCIzywWKTPgUEeeKxJwKkNOa5ToY+OPNeiG53scYwFhjSxE0UjX2ZHCx2Bpp9h6OYH9jUeBmXO3FsyVOzDHpGrXxpKxjAP925iSL2U19kOb9M4si+G5MzGDXrWTT80Qq1ofXabHY8CfjWoEQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045620; c=relaxed/simple;
	bh=YFjWgOlto0Fv6p41H0p+G1iwOm6VtkEcovmSMxqZssI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ae6EVDIGzWVA0mOqvUf47MP2DnaX4KFdqo38dtj9TP9t3tk9w4a3u+qSyERPyrYCJnuBssLznoJXL6cc0Mo76+NRVwyvPVZ7XRTQOsDQUpmVwiA8TdyqbdG7RmjT4ybtfxhUARFh/3S4bzyG9EcX0DO0SNmlSRfL93hMFBZEPGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQTdy5W8; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQTdy5W8"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4ba0eb3b0f9so255912137.0
        for <git@vger.kernel.org>; Thu, 20 Feb 2025 02:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740045615; x=1740650415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YFjWgOlto0Fv6p41H0p+G1iwOm6VtkEcovmSMxqZssI=;
        b=hQTdy5W8Yd57d5slhP78+CD6GdLa+MIWMsIKmyflhUfz23ZDdWy9kWuHKd016kaA7h
         TeG4rwooLVT2K73QYKbEkJ/GhrZRd2SkcUbuxCmfILSFh8WWGQWWosqIcg6TptAQId8s
         kTqDOldXBlrhm1i/fvFSltfqOFpzBLNEYnRvKYmPWO0NntHFa8C9lsuTCY1O9BkH7RUy
         eb49dZqVLeC0hAQVNW0r92XlLao58xlNFlSOa4a+lHGcK//WoTb4LkUdWI/YI5g+AuLD
         3HKq+vZvpePYUZ3aG6+sMuQ9qTuUANKzJP2Q76rQXhEWjIXR6A4kq9xQwr28rG9tYFzQ
         TzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740045615; x=1740650415;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YFjWgOlto0Fv6p41H0p+G1iwOm6VtkEcovmSMxqZssI=;
        b=ZPaxkYCfiSrWSemEj5/HzBwVqjMBepQbBn2EgCXjjGOWhlNeIG/SwHLiS3nuAOZ08C
         TqeSgY0PwEn36LJF6EJ4rQEW0dHhVO19Gm3nKsnNCd8l4mSzEZF3nn0SNbXdF/Jc1G1P
         wSEodk1A/TG4cLxqr3+5gLnSJ77BJjFQsrbuKMFCR+fqXrejlnxMBns2cLGK3ESGThyX
         cSnAAZxWlPOTV/GWZZXr/zEkbXPdl18kGzzdZRwLsGLZuBrHAswLKM/EI+3ZcBVSsfYi
         IIzmXO09vdHuHfPCf58dyoCdO3p2VL7DNjzlVbX2e4rr3RVep8ZxWq7uTWUsgPxbtav6
         72rA==
X-Forwarded-Encrypted: i=1; AJvYcCUkwQgteeUhmyodAsgWRo7wNY8CFDg1n+7LVcuelFJa9qpJ5heE88vA5gLwo/vDXwt7eeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybhCwcjOn3ZZtThJZnPoyTSPHbWPpfEJIwv0n7OkFtY4OMc2Tf
	CeMSMqp0bIg02uQ4p46A4mHDNTuCmmNiw5m5/HKxNvGCl0O7dh1Hqhx2NnhjWC49HiF5rr/1LX4
	GSgjvUGW5g/ko43bXfyNPzUpEW0x6uqhm
X-Gm-Gg: ASbGncuwlZNyMD1c0AIxJvmUD5ZLBvMS9gtlTlQ1DNCjBfNtMmd3aVcZ/R/o8w/WueC
	HmtvtP4uUnVfiXM4drALkGdYyhjkSo3CJvEZatH5mlYWwZi+X5/YzGpK9pKopOsL3XQjNRCETeJ
	IAead/vmSRX9i2aQ4Y7qicSImt1gJ9jRc=
X-Google-Smtp-Source: AGHT+IHyWOVDlHE3aA/CL/gSbMcgDbnoavky7h4ll4bYa7qyWatjS9ONZJ83xxQBXaNUMLyn4IvlkQSP6VXj1j0voI4=
X-Received: by 2002:a05:6102:150f:b0:4ba:95f1:cc83 with SMTP id
 ada2fe7eead31-4bd3fe0463fmr11947255137.16.1740045615294; Thu, 20 Feb 2025
 02:00:15 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Feb 2025 05:00:14 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqcyfdfwf5.fsf@gitster.g>
References: <20250211-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v2-1-991a2ec9a796@gmail.com>
 <20250212-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v3-1-98b2c4d2bb0c@gmail.com>
 <87a5aiqmeq.fsf@iotcl.com> <xmqqwmdlg92k.fsf@gitster.g> <CAOLa=ZT025hWSG0JuoWTUe5aDgPg1fcHDaAhuQ+CxHQ2zvreXw@mail.gmail.com>
 <xmqqcyfdfwf5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Feb 2025 05:00:14 -0500
X-Gm-Features: AWEUYZlCckPqb9MgsjAjUmcB04P1PiCSsfRUVzx-cXrzasc_X8n9_qJi9JH3hco
Message-ID: <CAOLa=ZQRjYb23-Y1TL9R8Bt6Wc+aKjEavwfUJ6miFB9JBLNyLQ@mail.gmail.com>
Subject: Re: [PATCH v3] builtin/refs: add '--skip-reflog' flag to bypass
 reflog migration
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org, ps@pks.im, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="000000000000cb0b76062e8ff047"

--000000000000cb0b76062e8ff047
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> I share the same reaction. I didn't consider that flow of thought at
>> all. So I too agree with name change. Let me push in a new version.
>> Although I'm not sure if, Junio, you want to wait for the `git reflog
>> drop` command that we were discussing before accepting this topic [1].
>> I'll leave that to your discretion.
>
> Well, from my point of view, "reflog drop", if can be done for both
> files and reftable without too much hassle, would be a greater
> addition to the toolset than the value "you can drop while
> migrating, but you need to remember to pass that option" gives us
> ;-)
>

I'm still dedicated to pick it up as the next topic that I'd be working
on. So overall I would like both of these topics to land.

> So it really depends on how involved the work to add "drop" thing
> would be.
>
> Thanks.

--000000000000cb0b76062e8ff047
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 44cd0c13cceab1dd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lMi9TMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mem1UQy85dndDSE9KbHRtOE5TZmNCR3h0clNCQXcrdQo4YXpKM2NSWlBS
cnZ2RSs4anJVTjd5SHIvZlhsM2EyWnhKaXhSdTdMTFVYM0ZBVVZrRm03SHBNOWwxQUx2Z09VCmVH
YThjZXAwbW80WjdjLzlrMUc3VzdGUjN5NFl1U2o2VW13dEY1dlBnMHpia2ZJS1lsUE81aEgzcExt
dUk4MjYKVk81c2RGa2ZVTnU1OWpkRC9vOVgyaHZhME1YVGtPdVV6SHF3cysrci9FUkV6Z0JWQXZW
cSs1YjJ6akJvWVdWYgpsUElTVm50UUpNcFRWQ3ZEQWVsc3VXVkRSZGcvNlBXS1BWamlweDdLS0F5
VDZYRkIvcFora0F4Vng4UUU0ZTNGCnYvcEFKTTZkQzgzeGpNVklZMjBxc3Z3V3diZFZWUmlPaFJH
SHpKSlZHekNwT0lmQnZtMnZkM201K0gzZnpaRmQKaXFXZ2ZyY0tBQ1pwZXFDOFJRQVY1MWlNd2Rh
V0NKLy9oL1owMHpzRWhIdHI1Y2JnelBrVkZIdHFnYXVUY0FTdAp6bFh0ekVQalBjYUxaRllkVldZ
OHB6QWI0WUZJTWg2UkRZeENlcHN3QTJmM1MwRXJlQW5hNWVmVmQ3a2FoZDZYCmczOEZ6c1dPRFB1
NFRUajU3ZnN2Tzk4aXFrWGNZb2g3bXhuWVZ5TT0KPTFKUkkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000cb0b76062e8ff047--
