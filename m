Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF09814AD0E
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458793; cv=none; b=cDBuOl7TACyvYZ/ACNIhdMSzk1aXKWpA949JcbwFy23Twv5xInqX8+ISg5hVQAygm+Ag4RcRl3oJYY5toAgEZ3gHGT5yH3mVMteqZHxgcyPBuLK5eMhMoJ6kmhlgi7lyB1J07YLlHRKUOMJgssuesP8M5vsD48kNjFd21d/wMls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458793; c=relaxed/simple;
	bh=Z8IUvEj48WY7n7Y2zS6cIDZvnJXQXxRsSVoCrEugqCI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=knbgUfXx23aJR5vCbbeJvhi0o7XszDr9XpaJfU1YJrSrclOIH55gZ/EBT/D6tnKYgjusqDq8hllxiQLwU9W5x+PvJ6Lq3yzhGHEO1FrdsqyQ3yI7xmrieiNYT96520LuIvENzSTRb3TO6fPbyIVjugqJGcg69SyyA+8S6HaXSEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMD4OB+1; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMD4OB+1"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebe3fb5d4dso37560041fa.0
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 10:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720458789; x=1721063589; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8IUvEj48WY7n7Y2zS6cIDZvnJXQXxRsSVoCrEugqCI=;
        b=IMD4OB+1xak+apXravk1Lo0rNcqsfgSyjJU+b2k387Xig/nBvmQGxwgiIMLhaQNsrb
         dvlVPAAAxwdF5bx0X2q7oE0b60M0YHOzWgVwSUz+jMYY+84NNfV46bx+XCpUwfFQwPiG
         BzO8OZlDczCcl74warOYy4dFBBmTshVr+rZ3CyV7knUQ/qUpfTyLVDwOXDMmOjvjyKgR
         ywtkcpSKSSDxndLcemP8JgebHX3Yk5ay08cghYapfPbKUWIS8oiY99h/rhfqokSCqxY+
         vFtK4mhnOkUJccBOlrufOaVNhBRl9R91/6MCGj7opOWnhI1vJBNsWdVzChDACj7xFzpF
         7GoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720458789; x=1721063589;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8IUvEj48WY7n7Y2zS6cIDZvnJXQXxRsSVoCrEugqCI=;
        b=RUAmykdIGPepLQU8Vv4qUJMKsnXLz/hLo47cffReU7vcCCWAcLkhwfQTsZaz8cp+EX
         YZxD1U8L2UZpkDZ40ucffTlTsG33qCBnmpjnRHsNkmg6BqemZ4j+X6L+WGkJpGA+zF43
         u+Tbg5t1VKmaa6Yses2GUo2+vWVKa0hC2oRkOoTI3Oud/A3EPJQo5jO1gtNNDRYfss0r
         tOv6mowzorCUpn83iQQmohiwbkbGu8/WmLImDkBkuGlIA8i1h1ZLQ6aqFwEUMpcldgBj
         FiGMKdteVaM67Emc09Ztvwpz1UyX1kcQfwmDl61qLf1FwGRXM3XRaJZPqdOdk74Uagmk
         q3Jw==
X-Gm-Message-State: AOJu0YzB/KN0wuhZjNWADt93Aw7rorBItRobTKXQbsVkLacv9QFOOyps
	dVlDstBaOGT3mhCt/9Rw422QHwptDdDw080aEEI6RtmF5UqfHCZZkKZwUVAAv4/RSwZj4+1M1Da
	U0tlLWsv5xEa0IKUb3ioqUyJvSSIkL6Qy
X-Google-Smtp-Source: AGHT+IHt+NHkb0nb1XMzhIPRmHtLSBDbOdXKEvhnpSP+9VV8s3/0dJ1wDXKcWQgdoxcD5R1C6e0Z0z6puQrl3ViNmyw=
X-Received: by 2002:a2e:878f:0:b0:2ec:3f79:dcd5 with SMTP id
 38308e7fff4ca-2ee8f2c951bmr34679811fa.18.1720458788571; Mon, 08 Jul 2024
 10:13:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jul 2024 13:13:06 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAPx1GvcunqYvZtkSJ0wDd4802VPEyRzDJnZmfoGh6L1rFof2vQ@mail.gmail.com>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240708092317.267915-9-karthik.188@gmail.com> <CAPx1GvfkC0rv_8_q5_HfduhuKX4csO+sBZiZqV+Sh+Q0dV8+4w@mail.gmail.com>
 <d3921679-eeb8-4cca-bc0d-967e9e567fd4@syscid.com> <CAPx1GvcunqYvZtkSJ0wDd4802VPEyRzDJnZmfoGh6L1rFof2vQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 8 Jul 2024 13:13:06 -0400
Message-ID: <CAOLa=ZQSDoKHtVRav2DpJhMgy3yhyLZ_itF2Q9fsbPy0WuTvbw@mail.gmail.com>
Subject: Re: [PATCH 8/8] check-whitespace: detect if no base_commit is provided
To: Chris Torek <chris.torek@gmail.com>, Georg Pfuetzenreuter <georg@syscid.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, chriscool@tuxfamily.org
Content-Type: multipart/mixed; boundary="000000000000f1a3ad061cbf86b4"

--000000000000f1a3ad061cbf86b4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chris Torek <chris.torek@gmail.com> writes:

> On Mon, Jul 8, 2024 at 3:35=E2=80=AFAM Georg Pfuetzenreuter <georg@syscid=
.com> wrote:
>> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html sta=
tes
>>
>> "The XSI extensions specifying the -a and -o binary primaries and the
>> '(' and ')' operators have been marked obsolescent."
>>
>> suggesting "&&" being preferred over "-a".
>
> That's annoying, I wonder why they did that. It does make
> the "test" parser a bit tricky, especially with empty expansions,
> but empty expansions are already a problem requiring careful
> quoting in the first place...
>
> Chris

Thanks both, I think with this, it makes sense to keep it as is.

--000000000000f1a3ad061cbf86b4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 367d758a58934ee9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hTUhnTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meCtEQy85RDNwTmZkNWs4R21XdHBoYjJJZDIxVFdLLwpYVFFYaWN1VDNt
Qkp1U2JvNGtCOE0yOTk1QjBHWmNxMVdsc1NqSFB2NzRYUUlIUFhqak9seHhVNWZLbXhqTFk4Cjl3
NWY4b0ZnUGV0NTVvaUU5TTRhMzcvOUxnZU5LVGQ0TjVCa2pYSlpsV25NRkVtREh5K0N0WE95R285
YXpqZ08KR1VlOWJBenJoaEN4MERDT0FVNE1qbFlHc3pmRVpTOWt2b3NBK0ZpQmxjNXpGK3dKYzlQ
dS9Jbi9hbnNVdEFsSgoreGZnTVJWU1Vmamo4Yk1pSEJOdzI0cm43T0dDeTVpTDFaaGxXU2RZTjY2
QytFY082RExKdnF4VEpsU2tUcWxCCktxbFJYM25hTDQ0aForMEJneEpza0xBRWJnYXJkdmRIWDky
eGhOTDJVYnVnRDh0MllCOFFvckVEVk5OWUhITUMKZmxqSnBMdVY0K1ZmZW5aZFV4N2dZRzN4S2hR
UUVva29ET0RQZDR1bEdLYk1qYzl5RDk0OFVVK1NuWXN6OWFJRwp1a0RSLzVMOGFCbXY5c1diVTlm
M1ZqanFTUFQyOXN6WGp2d245Um1nS1FIc2UyTWVPUzF0cDRLb0Y0dVlKc0szCkRTeWQwcEtjMjZY
TG5HNzB4V2hpTFhzcTJNbDNoYnl5Ty9JRHBBWT0KPUtiMi8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f1a3ad061cbf86b4--
