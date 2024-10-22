Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A96D27735
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585901; cv=none; b=N7qjczL/Lph3wB5AzqD5n3N+mClX6ePIfY4aadDlv5TwlLAu6IsFsNNKcJo17p8Ya4wwFVG0Jzk3rGVnOebVkXdEQjyqKsNx2tNHSS2/otayYfyvQrV7d1oXTQYIOKPx4ZPZZIMvIEjG7YrH2pwEyM1vp4TWDww0+Kj3jcRy72Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585901; c=relaxed/simple;
	bh=Sjze2HZ6c/7jUUqzDtKUIuiqZ8E4myn+perYopWU+q0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGSCZKBV7sNEAtz5bFWJLdHLYA25Wsdx+3WKbfKNFi/k1Qgb5Uky9Y1AToNuAVVrhUAunxvMnJYylDdcjmXSH/akBy0D2VzeanacihKilpIhYye36ihewejiuPzF0azslg6eOzE9q5lnA0sFz+r+UbfJvZgamdOdfqRNmQVDO+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKTabeUH; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKTabeUH"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-84fc0212a60so1413565241.2
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 01:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729585899; x=1730190699; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uDM00XsnQ6kF8GzTJ6nrAm8KNx21lxGICIP5SLoI9Eg=;
        b=TKTabeUHGJogpfRQem4Db35+lTtbRB/XtDKyvi+1FoQL6lprU5/dQXPhfo23IArOm/
         ROKuxV0oit30t28cske9glXeSPKcaoG7tJlY81tnFwQEmkNvZbDjOPlfkBuo1kxesKCs
         acg84yUKagMKX4vcGjxGSVoEQpFwn0RgCDn+zrV/+rIAA/xWvsbMxcBZD/IHKyI+Wey2
         1+Ukvm4k4bJHNGLsyKKm9JRG8+p9EOObaaXdUZOwuVZJ+iu0UrzwpJCAkJd9Wa/gJkF9
         WTKzkVmSmn9sO/587TJhop27P+VcDrb2NGlpcsr2ewkKtzvd3yCIyJEQLkIpKomvizEo
         KGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729585899; x=1730190699;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDM00XsnQ6kF8GzTJ6nrAm8KNx21lxGICIP5SLoI9Eg=;
        b=NeWXJzIH1dq2zPQ+PuywSDIMvBaLmglMqGmhwAjU/5VH0J0Kgpx9fHuiQlvFNReIxa
         qKmmzUyjYKlQAapruFygNWrXtZJLXH+39NZzc0BZqvPrp7FW/9eFfSA9XdqIepMvK31S
         UywZO5JICGMcxxB3INL8+1RZ/KRQnTWmdOxLzu8vCYPZ1ND7RaYwX3fnX2udtGsih0cv
         y4qNGYiQtm012izeoDum8wh/MU216lCuyska+Vu83H3sv6X3nynP0LOmYGuLs3V3M5z/
         Z2r9FUjtoZVfhKTD7D8n+vnoGqvB3HIRX9Gok5fUuw+2bXErRPWR/c15ewNQYIINYLny
         k6rQ==
X-Gm-Message-State: AOJu0YxiaPQIHAxNZvhNH5pR7wDkyyxUzzGQxzIWNO+oIPxUg+nLoJKl
	DTPdktM8ft/EIeRU/xc9IoIisnSSGMm8OgRQLrq1ZFkdTH6mX3bL6WccgTb3/JhiOxqkrLRwAd9
	nR5vOEJF1HSmmGpAo5fU8soofrdM=
X-Google-Smtp-Source: AGHT+IHhme6j/JDNZJqBNNw8kTE770NKG/Lpbx3Pxu7KZbToU7S4sShVTi88R04WVwcLG8BKOqsuuu6IXN7G9ArrsM0=
X-Received: by 2002:a05:6102:6c9:b0:4a5:6f41:211a with SMTP id
 ada2fe7eead31-4a742e70d9fmr1831224137.25.1729585898873; Tue, 22 Oct 2024
 01:31:38 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Oct 2024 04:31:37 -0400
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <ZxbMRACNtMfPiWr2@nand.local>
References: <CAOLa=ZRvFBhageS65uE5enzLBz7H_CAvvnEcPsi_QAi0exRx2w@mail.gmail.com>
 <cover.1729241030.git.karthik.188@gmail.com> <ZxLVLiiEEj2A5Iws@nand.local>
 <CAOLa=ZSCenJLOg1jF==_uNGJ7GZdLiNd6GB_JO4XyXMdLNT65g@mail.gmail.com> <ZxbMRACNtMfPiWr2@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Oct 2024 04:31:37 -0400
Message-ID: <CAOLa=ZQA1MkkV5tVq74LWPsueJ8L4UBXr07CF-JXGsh6jS4zTg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Subject: clang-format: fix rules to make the CI
 job cleaner
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, toon@iotcl.com, 
	spectral@google.com
Content-Type: multipart/mixed; boundary="0000000000001c8b3606250c9977"

--0000000000001c8b3606250c9977
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:

> On Sun, Oct 20, 2024 at 06:17:58AM -0500, karthik nayak wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>> > On Fri, Oct 18, 2024 at 10:46:44AM +0200, Karthik Nayak wrote:
>> >> Karthik Nayak (2):
>> >>   clang-format: re-adjust line break penalties
>> >>   clang-format: align consecutive macro definitions
>> >>
>> >>  .clang-format | 16 ++++++++++------
>> >>  1 file changed, 10 insertions(+), 6 deletions(-)
>> >
>> > Thanks, will queue. Are we ready to start merging this one down?
>>
>> I'd wait for some reviews :)
>
> OK. My impression was that the dust had more or less settled from
> earlier rounds. But let's wait.
>
> Thanks,
> Taylor

I'd be happy if it merged down, I'll see if someone from GitLab can help
with a review.

Thanks,
Karthik

--0000000000001c8b3606250c9977
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c146b1710e67f349_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jWFl1VVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL3Q2REFDamxKRU5ZU1NrUWlUQUJSK08rbnppSXdnMQo3czU4KzBVSkxj
cnpqNEdrYnNscCt2eG1yeXhrOTJ2bTVQMjVmNStSZTczd2JqbHhZeERxSzA1MnlZbXZUWjVICldn
UzBWQmhRM1pJQVRMUEtockdBYjhwSVhIZVFWVG1DR3dGNGJ2K3lRcENCeDk4cUg3UTBkNkV6cUJ1
VTVMcWwKRG9LdjF0NFFweWRUOEJrWjF4bzNJVlNFNUl5WEVWWkh4TysvcDFqbjBhVzdLTWpKUEJV
Tm10OXQ4Y0MzTXdpYQpYSHNBRmlidkpwZ0hRSVdRdHdwS1haekV2TUhpeVFvVzZTeTl6WElNWTRC
Q2JjQXhuUjF1TUI4MDRma3hjaFRZCklpZ2Y0cXVmb1hoRkxXNVRiYkJoblhOUVNSOStHalFER05h
dDRvUnRtaW1iTjdvRDFRdDBjdFFSMktocis1anAKVy9GV3REZGVpeGZvRkNRTWF5OFA0Z3JhNDRJ
dXE0L0Fja1VvOHI3aDd6a0VkZHFVTkxVbFpubWxZODZJckFoWQo5UWFQUHBmbG5iRHZRNkZqWUFK
UzgzZnlNbkwzcCtFVWpvbEsrSG04WnVSM1BzSUt1dUNsU3JYdEVjQjU1MVIrCkZQNXJMOU1Ec1Zk
WU9KV1AzbTlEUzAxcEJ1bjd3VzVuM2F0OWEybz0KPVljdW8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001c8b3606250c9977--
