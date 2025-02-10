Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1396824BCFD
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739206817; cv=none; b=n4UFJO0VjONrcaZTI/HzAr1TLEpyiqcR+dm+RLW2zBSwv6jBNWbe7tKr4ijja6g2ZvlNklLMjHBi3GoHAs68qZnKVhjuRWE+y3axwFOFBFDFNQszqmoIWMsNCFvHJLS076KU5i1LVfTFR39TTGkow4fRJLeX5lJ/6ueOBnmB6w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739206817; c=relaxed/simple;
	bh=IOCmiCeoGFPTdPZlxvnL2fd7VaX8lCQ1h0XcDDISPQo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPMYgzUyosSDRfZY/mzKsdtiJ+IyyDlsT7uXOB0dzljWMdoNx2FParEAG91ChkFGQ8DhK4lvtS9ovZRbme5MT6D4QS7DwQf+V0qDtppqbwKqbXThiRhpyX/WIT7NCYRdNiAs6JXG28++ZopOJc2epe4X6ky+3GnkbmjzkPhxw08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbXZ57lz; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbXZ57lz"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-51f227e8bf6so1037470e0c.2
        for <git@vger.kernel.org>; Mon, 10 Feb 2025 09:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739206815; x=1739811615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=y8sCrfEdqzbY1HmKME6tuSK4nXmlMURtEjVW+u5J6HY=;
        b=dbXZ57lzzefxlpvi+YOyOjoGNKin45iapb/X9Y/+DlJOlRfr8AcmullD+3dNEzPMrT
         9ui7rwJBU2MfRTzr7UPfL8JyWi5Wd1PheaM/LPwng+1Bwh3Od+w/LXvURZXMbrfomj/O
         S1jQdUK4A0fo61CqCz9Efl2jvXHOMtTXlltYU7cBhmH62i9AOGK+0819chBvKkf5Y5tk
         QzT945szJfCcDwMplVTvweOaXIYIpJb+BIMR5UpqxAPvPYZsxEOcmyftke1ehRNTzGjE
         2nfKTC8jwHPnLMDcbLhQEUth2iUZj3dEXzfhbA5eippNBqecIXrsGk4VKZX7M6SRxDf1
         ad/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739206815; x=1739811615;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8sCrfEdqzbY1HmKME6tuSK4nXmlMURtEjVW+u5J6HY=;
        b=jNy4sKKR93QjYk5XnmQXnFqd9bRqXveLQwSNI9sJrvAWutyV/6iMjZtw5c8XOHzFZu
         KSHmjgBvyGnDb/labq5Q9NkVr+ANfMsPsgBJMG+pf0jdajMANdOx25smawuQOtST+vR1
         lq2G2QS5EPksT3DP24KB2PDUtV5O/zKninvw7PbwuAE4oiyolZzcdbR3x6bIi3TLAmUx
         ZSy+Tk4rto6EtkBpxy4Z6JCnuFIJkbJQ7t3M4jbfFc8GeJECI6O3Gwbxvd/OKeCDqQQk
         ZLhPBLx/smfUlV/vGxzNFYJ1ySW02hLlNXV1falrHDjdIvzwl2wq/MRlTsAvE/Z/UaRa
         s15A==
X-Forwarded-Encrypted: i=1; AJvYcCVZdBV5VgVNx+yvUTypQf/VtgAJrhq25aHqFNC1hvMUAKi0JUaUXSeMNANENO8DLjoZchw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyGh6Mt3EzkZbyjR5B8levVs+EBfqKRfQ0UUd5Mgrflz/5W8cz
	2REqKI7LiRlT3luV9xZ++H+juGun8xrx2mBe5t9bde0rPQXbB7GM3smIs9iSu5jR2aqDLgl1SbA
	LrfG4YSscRVkaC9CfCfKnB3M+2LA=
X-Gm-Gg: ASbGnctD7HU8S+qDce0Y0e3C+7/HufxEzBYLtO/nTpY6e+dfukFxfV5tQjcJ4r20mXR
	IsUtirOWJbch2RN57ITyh6bCjtjXkQCuYczYz38R0TgYfsWXGayY5lYdbMpdmKrhFtynZRlEPRk
	ey+T5iL0JYHDirJNR1iSTrjDISror9JFU=
X-Google-Smtp-Source: AGHT+IELiwWUSgtADYgiWn8Jsz3F1xPqdlG554R11lhy1aIvv11gu4Y9nYd8w0fsjSeQZIpG6Verq2UFVyKfstET8WQ=
X-Received: by 2002:a05:6122:659d:b0:520:3987:ce0b with SMTP id
 71dfb90a1353d-5203987d202mr3607854e0c.2.1739206814742; Mon, 10 Feb 2025
 09:00:14 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Feb 2025 12:00:13 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <a2a76725-5778-4b7d-a266-c3a1431316ce@gmail.com>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <Z432QXJb_TfzNBa2@pks.im> <c39c5424-71d0-4b6d-90b1-a6a70f2ee61b@gmail.com>
 <cd90cf17-6113-4634-a774-6df707b73e95@gmail.com> <d5cba1a9-fe51-4f3f-970b-3ef8a7a2e459@gmail.com>
 <CAP8UFD0GEmsJDFzVAV1bgBNeD6K3auH4paWEKE6=f0=_E6gifA@mail.gmail.com> <a2a76725-5778-4b7d-a266-c3a1431316ce@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Feb 2025 12:00:13 -0500
X-Gm-Features: AWEUYZkXI3CrHe4HKGzt45322B7WLQjhs4oq8X9wd7DDqHZNr7ODEIhxFbCAgYs
Message-ID: <CAOLa=ZQZmq2YYe4iV0UMa+CaKkQh9v+h5oDuxHd0R1AfceLTrA@mail.gmail.com>
Subject: Re: Git in GSoC 2025
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Jialuo She <shejialuo@gmail.com>, 
	Git Mailing List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000626088062dcca4ee"

--000000000000626088062dcca4ee
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Hi Christian, Karthik, Patrick, Jialuo and all,
>
> On 05/02/25 18:50, Christian Couder wrote:
>> Hi Kaartic and all,
>>
>> On Tue, Feb 4, 2025 at 7:33=E2=80=AFPM Kaartic Sivaraam
>> <kaartic.sivaraam@gmail.com> wrote:
>>
>> I have just added myself as a possible mentor. If possible I'd like to
>> just co-mentor this project and someone else to be the main mentor for
>> this project.
>>
>  > ...
>>
>> I have just added myself as a possible mentor. If possible I'd like to
>> be the main mentor for this project.
>>
>
> Thank you for adding yourself as a potential mentor!
>
> With this, it seems to me like we could at the max. accept 3 students
>
>>> Note that I haven't assigned any mentors / co-mentors for each project.
>>> I suppose we could assign that based on the applications we receive and
>>> the ideas that we end up selecting.
>>>
>>> Based on Christian's inputs, we should be able to distribute
>>> projects among mentors well.
>>
>> Yeah, I hope it will be possible to distribute projects among mentors we=
ll.
>>
>
> Indeed. From all of your inputs I was able to come to the following
> allocation of mentor / co-mentor.
>
> -- 8< --
>
> Consolidate ref-related functionality into git-refs
>
> - Mentor: Patrick
> - Co-mentor: Jialuo / Christian
>
> Refactoring in order to reduce Git=E2=80=99s global state
>
> - Mentor: Christian
> - Co-mentor: Karthik / Jialuo
>
> Machine-Readable Repository Information Query Tool
>
> - Mentor: Karthik
> - Co-mentor: Patrick
>
> Implement support for reftables in =E2=80=9Cdumb=E2=80=9D HTTP transport
>
> - Mentor: Patrick
> - Co-mentor: Karthik
>
> -- >8 --
>
> Let me know if this sounds fine to all of you. So, I suppose we could
> pick a maximum of 3 projects but we cannot pick both "Consolidate
> ref-related functionality into git-refs" and "Implement support
> for reftables in =E2=80=9Cdumb=E2=80=9D HTTP transport" at the same time =
as Patrick
> only prefers to be mentor in one project.
>

This looks great to me, thanks for putting it together. Once the
applications start coming in, we can finalize on which combination works
out for us.

>
> Based on this, I'll tweak the ideas page to mention that we could
> pick a max of 3 candidates.
>
>
> BTW, I've just submitted Git's application for GSoC. We should know
> by February 26 about the selection result.
>

Again, thanks for all the work here!

> --
> Sivaraam

--000000000000626088062dcca4ee
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fc8989c45a48caea_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lcU1Ka1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL1h3Qy85UXRTOXdtZ2Z1ZkVMc3h4d0l6UnZidVJkRAovR2tZNDFTZGdG
Slg2UlNvYmVPN0JRYU1zNWRMYUVqdGFBL2NmZlkxYjl4dkRmYmtEaTZZNllNWUFSN1JWdFR3Ck4v
R2NQTjJZc3BCcGlLWlF1MGlkR0QxNmltMTV1RzdKL2FVTmpIRmlSbHNSMEJuQWJacjZjRldjK2lL
cXZjVEsKTVpZQlliTmR1MHQxUEZIN0h6TDF6UnVwOWllRm43Z0c1d1U3d2NJM210RFR4QVplK2x0
d0tsTkRxRFdrZkx5eQpqc1ZuY2R0R0huQWY4ODVnMlBLOHZsUjVDazEzek04cys5VE8vajNXbWEv
UFFMNUM2WWVzekptUzJVU2R0Y1NBCmJhbnIvaGFLMEdGYmljYXhVNEdWeVFkM3I4NWFZY2JvOWZ1
ejRsd3dEZ3NUa3R6ODhkSUIzQlJ1QTdRSEw4TzcKNmJlbmFDTG4yQzlBT3h6SkRpVjZORTErUGJm
alRxMTZTZWlsNFhCSWZRMkwwQTF5emVUdXZWckl2YUJQYUFXOQppdWczSTR5bm5KN3hDQS9RS0hB
dDV2OHFmV0oxY2FudTF0U2sySWpycElQT3MxelRHSS9sZi95aVFxOCs4WlQ0CnpueEhLOXBXZ1Vj
U0dNaWY1a2ZZL2l6bGJDTGJDaG9jYm1HNzVwVT0KPSthV2gKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000626088062dcca4ee--
