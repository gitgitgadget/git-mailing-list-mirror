Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF7F2AF1B
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 21:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742590930; cv=none; b=fBNLNuJK8ovkTq6VYjVuHLdxjA6v7iHrHKrld1FqWwkLGqr1Pl3qP70sIaWCg75g3UbJGcog5uCvogqaT6vhjU930sA50HM5Calb2UJ7HvxB8TRgQbJGRVPvJp9NydTCvQb1LK8+zHs/55KttL/mzEMsWEemvqO7rEWDRHhbnGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742590930; c=relaxed/simple;
	bh=YhIkoyRfQbh0Q7ZCzuZWDbO6HZOt0tgf2yZECdOBv84=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSChsfkR6RgKIp583/uqrZsOYZXpuoGhzXObx7wPp2ieWZO84F8+dyAo+5PIAZLNANUCmWORTX4Rojhpzb5sDya7XJ9DZK5zrYlGbfwjzYS8a1SrrGN+Y5HmaXBdO0b+lUCxGI5nUG472UoahH4a1m2lJ8bwbfkkXLjdERrudSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLPuqM7F; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLPuqM7F"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-525b44ec88aso232260e0c.3
        for <git@vger.kernel.org>; Fri, 21 Mar 2025 14:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742590928; x=1743195728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=whMvqd7LP6MpluZkiKemWR3QWokeat//FUjplwVMIqA=;
        b=ZLPuqM7FtUNu3j50jPROBmjSzWlE0fAKvM8Sr4PvPuRFS4X1//Yw0CtyCFSHcSdaju
         7o52p2X4t3fTbhKbwnhuvIWwmDRrLtLUFcsm4KLT5jTgaBHmInSZVe6nubcEdsH3M56u
         YO2t6uA0z1M2UdYJzsz8/nvwgnUPkPCNAMcoWkyR0Y/IS+H0zvV/3yL/Q4/avWFyuX5g
         0X5EWY4NbEz0XHlJTK6qP7FflMrByghcqVnvYe3Z4FEdziH7O6tKaJcy15Bn2C0fvst+
         D5HPyxk2cuGE+P8OcY3lxsaxmsv0xR06nbgsd8p470OZoYvZTQKxGkuuI6K4708lrzAO
         A9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742590928; x=1743195728;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=whMvqd7LP6MpluZkiKemWR3QWokeat//FUjplwVMIqA=;
        b=mfVMMkzfenEIx2NJWzFF6wCYpMpqJqJmo7/JCOVPkInoQeJZsVIxKKrgFp0dxBpPZy
         YQMdrUnz8cd/n2/Bjspe/l/4OJec3cdfY11Ko55XkuJiI68O8R1M8g/vojw1PzLYwk0T
         6vJs+St7pW0+nsQLo5E4xlsfwI0XczzgGRavhlSQQoXDVUEi3F/anC/wm/2vNACPtnv1
         eS3Bykptr/zzVzxN+oYTqC05Ss+B63Gsgfne3iNlYGa6VvvTrZRyWoAu9uH5VRrbTmrt
         yWR8b6qhNlX5kgiP7f28xctIP3WFMxHKUsfD+lN0arYHzZN/Fu4H3IfVVvSETLW/37Ls
         +zzg==
X-Forwarded-Encrypted: i=1; AJvYcCWT6FHLir9bRVi+WuPNmq/Nj3kS8Y6KQO8A5ZnsNub+U1fiPYrLC6TybWB7EmR50diuOqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIG+hmzCAmrY66fnJOMBPmxRJratwrLwhue1f9V6Cou9LXNGF1
	6wXPS//Hat6J9qD3Apapy0TJGtKpWrJTryFbY8IdSc1qQli+Ma2mRLq313jkN89C4In7u+ZyVsO
	ryQHOab4W3WMPRAeSkZMvxW3V/HU=
X-Gm-Gg: ASbGncu0b+HEs+LCuCmVlClWDTWd29B8gOYd7fBnXOdtlOsgY5L+twWD6ehJjnccL5v
	l38mRwEW0Y/pUcfaGITKlu+oT8o0MArIOI3ieqa9nwYmkysQEAO2oDSSOi7vhVYwhOtStSIlaSv
	cI83qTQbL6E2lZWmRUZy10gBUpFLiPew6dNvU+5NRQbhTt8va07tWlsSScZBxVYfRHzEwm3Hg=
X-Google-Smtp-Source: AGHT+IE8/mtaFgIA/3Qla8PQwI3HxWButaaUDm5uNH9/i2c9+AKDJUoJ/Nv5kRuTsxx5wzcpOt5cDGwyOIW1sAm8pbQ=
X-Received: by 2002:a05:6122:d95:b0:518:a261:adca with SMTP id
 71dfb90a1353d-525a8503af8mr3740970e0c.8.1742590928050; Fri, 21 Mar 2025
 14:02:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Mar 2025 17:02:07 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ffefdd01-ec80-4af4-b011-723ad1260f68@gmail.com>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <Z432QXJb_TfzNBa2@pks.im> <c39c5424-71d0-4b6d-90b1-a6a70f2ee61b@gmail.com>
 <cd90cf17-6113-4634-a774-6df707b73e95@gmail.com> <d5cba1a9-fe51-4f3f-970b-3ef8a7a2e459@gmail.com>
 <CAP8UFD0GEmsJDFzVAV1bgBNeD6K3auH4paWEKE6=f0=_E6gifA@mail.gmail.com>
 <a2a76725-5778-4b7d-a266-c3a1431316ce@gmail.com> <Z6Xmrfut7jdsVAfg@pks.im>
 <fa9ad3c6-3b3c-4f3c-89c6-101ed1b51eb6@gmail.com> <D7TVXVKVWRS8.S2BJN32QHZ0O@gmail.com>
 <59004310-f270-468d-a248-c83c97de4a1f@gmail.com> <CAOLa=ZRM3bLcR3s6nE8nXFv32zX8-mL6fSh1vbsVetJcp9KFhw@mail.gmail.com>
 <ffefdd01-ec80-4af4-b011-723ad1260f68@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Mar 2025 17:02:07 -0400
X-Gm-Features: AQ5f1Jps9MZ75W0SqsLhHXTyQXweGMTXckZ1Nhh7KsI022Z-ID4nEksG4CVu218
Message-ID: <CAOLa=ZTsp-N3h5bbquFjEY_XSBV=GqCwDWUDCykBfERbxg8PNg@mail.gmail.com>
Subject: Re: Git in GSoC 2025
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Jialuo She <shejialuo@gmail.com>, Ghanshyam Thakkar <shyamthakkar001@gmail.com>, 
	Git Mailing List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
	Christian Couder <christian.couder@gmail.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="0000000000004181420630e09181"

--0000000000004181420630e09181
Content-Type: text/plain; charset="UTF-8"

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Hi Karthik,
>
> Sorry for the delayed response! I kind of missed to respond unintentionally.
>
> On 07/03/25 15:31, Karthik Nayak wrote:
>>
>> I wonder if with Ghanshyam also mentoring, if this statement still
>> holds true
>>
>>    Note about limit of project selection
>>
>>    Kindly note that considering the bandwidth of available mentors, the
>>    Git project would only mentor up to 3 contributors this year.
>>
>> Maybe we can do 4 projects this year?
>>
>
> While we do have 5 volunteers for mentoring students this year, we only
> have 3 candidates who could play the role of the primary mentor.
> Ghanshyam and Jialuo only prefer to co-mentor as far as I could
> understand. So, that still gives us a limit of 3 projects doesn't it?
>
> Kindly correct me in case I'm missing anything.
>

You're right, I didn't think of that :)

> --
> Sivaraam

--0000000000004181420630e09181
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 38e0a067cf0688f6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mZDA4MFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOVpuQy80OEdpSWNGSTBYY3IvTlQ1bFZlMHFycE5TeQpSRXYvZlAvRzlI
bFNZZ2FUS3F4VlF4NUJNUTRlNmt3SDlsTHMzZDRlUTZPRzVaVktWaGJBakU4N0xRbFhzTWIvCkZI
cUx2M05KSUV2emFvblNyYTlyb2VwQ3UwWXIrVkJJOGtsQjF0WW1RMUVvUFMwSG05Qm9XOGp4VHk2
Mlc1Zk8KQVk5YTNtcGhNVWl2UEd4aFhUS2hkN3JVYVh1WmhoTGhzS1puT1JpRWRic2hsMFdRM2cv
RkpPYlA5SE1QZnFvNQpiRFcrazlHeHF1aWxRekNaWXVEaWM5T2I2S1c4UXhXbXlpcEZRdVowbEJG
Mm9DQ1JVS2FFekZVWmNETWFNQm1nCkdQUWJubVVsQytBUFVDWGFDWFZBVlpkWHZyU3g5T1U5cXlN
Nk5NQUFsM0RCRVNzakdlWTcwbGEzTldaYlV0YVQKbGtZUHBaZExhWTVVd3FxUXBjTG1VaC9qYUFM
MnRXQkdlSjVaYWxxOEE2SThWNzFucHMraTh3SWJCeWUzb3ZhUwpjQVpOWG9BSXovWFN4VTJTeWo5
M2hVRGRyZ2xKa3gxNE5xWXhaWVRsOW15VFVwNFA5RktKby9uTkZMclpXVURqCllDNUZWSzVaTTB1
alRScjRZSEk2RitreEwyd1B0VU9ENXVHWkMxdz0KPVJXY1gKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004181420630e09181--
