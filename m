Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1261D2036F0
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 11:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738583628; cv=none; b=dvTZlEgA24vkeFGj8QIMOw9kGmGCzM8gvjgtvieS3rlfZzL/YvZdM983yCkCdFVSLkAKFWROVjKaXPo4ddEzUFR028m+Yvrn8dJGpO8tKf/cfkMtDcxJzX0IMocQrDtxPzYAedz885g5Z+O9pLPRc/QhDsVTKmFgI7OsbcdvZtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738583628; c=relaxed/simple;
	bh=zuyh6I34R4KD1L0kqMaqLo0pi05XNW5VhLwdLonifzY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfLCllHOXIDoE+aI0csa8mfGr+l0m6mdbKMOanbwreA7G0akNxCywpyvq8Wj31V7OQBVOlpqvE+ps59pmlec05E4/+Y/sjuwmdvwX/yqsJ8lRTzWkw+3gEP3gXhJ5Dyuo2/O4GaXVGumI6Cz2kc8+8U+MqNuZey5y0ETTf+gdfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htqXh3UC; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htqXh3UC"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4afdf096fc5so946225137.2
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 03:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738583626; x=1739188426; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gq0s591m/7gdg3EePp8Urku3KBBn4ZcH80tXb3DdSP0=;
        b=htqXh3UC7PQl/18GYexGAO1HXc/ALQa5sm5BhRdO+sVtvUmr1+59hIZFBJz0uqoZVj
         /9iwnqMfrXU1pXey2xkw+vmdtJUX7CDTJFOYrrn3rZrZ5BHh7HgrckN0S1q0dIHrH1Mg
         sC+QHLrtD7gC4QMsBAJad0q7xDc0YDOtSLwMPF32Cl6MgPyn8LUDu8rRrOonE837E3qX
         aSluVJqvJGyQo9pyuOYmP/25lRJpQXSbnW/7TVYzozilIXI9c+mb/CX/+upEtmg/LuVq
         FEaFT7XhjSHDsJyXPlKhnM3ekaKeNXe2wb/4B6N21T7VYyLO6KYjm59w0/s5wzr2svoD
         bELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738583626; x=1739188426;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gq0s591m/7gdg3EePp8Urku3KBBn4ZcH80tXb3DdSP0=;
        b=YU31g/giT/sbaZakKJzqv7rg0Xd61XBtyN2AbUI0QJj76p2vHDBShBkPT9zHZw+EWC
         jUu491ufFCdwItQJOznhjOjX9kbgXLDDorsuQVpQCPQZUNjU91zzq8TiqpY2nF/EvRCb
         mMhLnbPWkvqPMTaTyuEfQOizvwJSxAqD3MHyd7RRIkf/cwyiU5onSo3zLjDZCdDNbdpw
         BpnKOjqWOxaxG3KVC8us/MPbWr4gw8l6nW+QXO+acUETwfD5SSP9o0v0zFRp7+Q3nq6p
         p+fYjNuJYsbswz7ct0pquo7NJhZFEEYE+KSM0p/F4l96WqEoiawmTgd/4BSQA2AZboGC
         HIeg==
X-Gm-Message-State: AOJu0YwUXLcGWd0qk2hIy2rgauTnhFuTTJtzQS498Am+x/FgVke+O1jc
	L7inVRhG5xM1kNRLn2033vj7qhLMYMcxBA645lCDETyRnKyHvS6/Ql6ZRe72Z4c5EwQohpoWosg
	uRFtIoeUVC/q5sxley+mM/N69B8w=
X-Gm-Gg: ASbGnct/Dz8PzKhRHa63lIKBmSc9D1+ZpxXcH+kWuBPGmw27QGNCjTpxXjF1rtFgs8V
	qj2+Oq4ikkQ7JXtf/sPbBmWgVAAC3+j0vwFSzstsVHgmYH77XXg7vzvA+f1cQ+wTg1RapOvPqs5
	oekst9Ss1et3kxHB6W1w+tAE1nkTnwlWA=
X-Google-Smtp-Source: AGHT+IEB4QoI3JlNmvdpko1lKOyPz2ADKVJLLg5Wkxjj6njK5HI3ZfIEf/ccfU6YKN822+VxOJr1QrZqUtnByQfu9IU=
X-Received: by 2002:a05:6102:38ce:b0:4b6:39ba:3b3b with SMTP id
 ada2fe7eead31-4b9a4f57ad6mr15393114137.11.1738583625863; Mon, 03 Feb 2025
 03:53:45 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Feb 2025 03:53:45 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cd90cf17-6113-4634-a774-6df707b73e95@gmail.com>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <Z432QXJb_TfzNBa2@pks.im> <c39c5424-71d0-4b6d-90b1-a6a70f2ee61b@gmail.com> <cd90cf17-6113-4634-a774-6df707b73e95@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 3 Feb 2025 03:53:45 -0800
X-Gm-Features: AWEUYZks-yYaGaGNZ0Dt4rBqhn5mexSDV1gvoe8bRKZjOYg_inBvqfXbn3R-yAg
Message-ID: <CAOLa=ZT7gOH-eu9gKDRyYJvzSDQ8pmMYqBxXFRdxbNN4iKZWvw@mail.gmail.com>
Subject: Re: Git in GSoC 2025
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <christian.couder@gmail.com>, Jialuo She <shejialuo@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000006eb213062d3b8bcc"

--0000000000006eb213062d3b8bcc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Hello Christian, Karthik, Jialuo, Patrick and all,
>
> On 28/01/25 23:00, Kaartic Sivaraam wrote:
>>
>> Thank you for suggesting these ideas, Patrick! I've incorporated them
>> into a draft ideas page for now. You can see them here:
>>
>> https://git.github.io/SoC-2025-Ideas/
>>
>> Kindly suggest any corrections to the description, project size /
>> difficulty as necessary. I've mentioned potential mentors based on what
>> I'm aware of so far.
>>
>> Patrick, Christian and Karthik, kindly mention the ideas that you're
>> interested to mentor.
>>
>
> Gentle reminder that the ideas list needs completion. Specifically, the
> following ideas only list Patrick as a potential mentor:
>

Sorry for the delay here, was OOO for a bit. Thanks for following up :)

>    - Refactoring in order to reduce Git=E2=80=99s global state
>

I've worked a bit on this and would be happy to mentor or co-mentor
here.

>    - Machine-Readable Repository Information Query Tool
>

Here too, I'm happy to co-mentor or mentor here.

So I could co-mentor one of these with Patrick, as I can cover when he's
OOO.

> The following idea mentions Karthik and Patrick as potential
> mentors.
>
>    - Implement support for reftables in =E2=80=9Cdumb=E2=80=9D HTTP trans=
port
>

I don't have a bunch of knowledge here, so I could co-mentor but not
mentor by myself.

> The following idea mentions Jialuo and Patrick as potential
> mentors.
>
>    - Consolidate ref-related functionality into git-refs
>
> It would helpful if you all could chime in to let me know if the
> existing allocation is fine and to what other projects you need
> to be mentioned as potential mentors.
>
> --
> Sivaraam

Overall, I should be able to cover a maximum of 2 projects (with at
least one as a co-mentor).

Thanks for putting this together.

Karthik

--0000000000006eb213062d3b8bcc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 78734daf28fec3a3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lZ3JrY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM0pCQy8wWVVwbXkzbXp5aWxyOVBWVXZ5WkFNQ24xMgozMDFyK3c1WnlI
REVpNkdud1hNV3RORmJYdklSK2FOTUMzV0pCZ0RvNHZJSXpheHZFZlR4OGNCZ0ZOaWw0czJHCnV1
KzRtMm5wVzllNjNTWFpzSEo2dWl1dE4wcyttK0dNL2hDaCswU0dZNlZyLzRCb1MyaVJxNUNocEsw
Uk1PSmIKc2RlWFBzSWc2OUIwNkJLYXF4Q1JpOThYWWsxRXlnRzFGam9KaXBLdGUrejJWVFZFcG1j
Z3dXNCtYRTdsYzNFbwowa0FtdDVlTm83ME9tK2M3ek5kTndvSmpKSElxdldkRExQSkxKQzNMaFIx
ZFpOQnBUb2owd2crMXhFUkcwcmJkCjQ3NmVZYUk0ZGZTaXQwVURnVEd2WDBHWjlVUVBqVnhERWNV
bkI3Z3FzREJ5T1FZaFUxM0Z0V2NveE8xVHVJTk8KODg2UW1RWHZTNTZpakdGY1hNTVhYNXAzdzk4
ZlFFZ3VYeWxXRnZSdGEvZHNqSnRMRFdNdEdMQy9jS2RvMGtNSApzeVRRVTN4cWlGMXl2emdmbENG
K2JNUDJRbWdrMkg3TVJKWjdFTTJ4Z1lhaXJoTyt2UUkvVkpZeVhRVS8yYytUCmIyL1dnYXdRWUdm
MFdlLzBneFlFa1dEUCtwNE92eE91R1NkZ0RKYz0KPWhsT3AKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006eb213062d3b8bcc--
