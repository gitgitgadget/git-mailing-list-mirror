Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A6C84A28
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720604378; cv=none; b=W680hkiJQXWOjYG3Bo/Mq/+ZjbuI5CB+qC3vD7KyXXzJrarlJGn47P9sCFNgImOjq0O3l8lAjoPb8dB/82/2wHKC4hA4hXsNDN4djsSieKPdoS/QMSebfa1CsUGOuKk3OGMugCLG2VR+pTDJffbyrE5cI0Dbl4fubHNq+0scb4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720604378; c=relaxed/simple;
	bh=MpEIKN8EwV9PLHxP8kMcMNIw1+fliU4pgt5Ea5KQnuo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnSBmpKkGbKemnTvjUnA68LF4A4qCLGG8t358E8bIUUIFkdGzhSI28D2dM2hRa5b8UFqk1RJdwoOeK6C2i3I1cHTyKqb2H7ouG/AsIqHRiOyaeg/TwCg8aK0/LYAyNWIiKsSoM9irH+JL8hhdoyU4cGe0ihB7f8Ds92c2PBS/mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyN6lYD3; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyN6lYD3"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5c667b28c82so302334eaf.1
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 02:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720604376; x=1721209176; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=o93cC/pUdJ4G4wvuuQd78/vR5l6IyKdU1zrC+ZGV0TQ=;
        b=cyN6lYD3X41l9e4TD0Jjs8tZfAbRyhastBW3HGVEGkHQXKio/VPv9G8J+rMjEs9MBa
         itgyNSgBnwNopazruBvtuE5vJqALujXGBizy/YcOifa9OQkkMUhGHNvR1SZAoR8K4Xz2
         cLkhNkPe1XvCKBaU/oyC8WQxIK1ixXx9L9Vu8WsA+vC90/MVAisxrmA1hMWSvOdrpXPa
         r6dDWDXD0sBCp9vZ5S4LmSWMjRJPtcJxAo/T2w0gjhH4gOXwzVHibQCC4fgC4mhhJif3
         My3KPOZSUaKNAu3erOVYA4xaXzCsdVQGRzn4Lal+Utg3LJUMmMMLcCqPBBQhuCzfa2a0
         /edA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720604376; x=1721209176;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o93cC/pUdJ4G4wvuuQd78/vR5l6IyKdU1zrC+ZGV0TQ=;
        b=uDfltzBt++sKdE0wKFnPU2djII5Oxi3CaVWF+9uY/NOi1iNwC6DocvAx8M9tt5CBwZ
         xDMGln9VncT6oNXfDfu4FHXG5vcPUYTZY8aG/dvju03r7mxggT8FoJ9+PGp34hAWpjK1
         XnCkNNebl/k6fqaRff3sGKbSC1xRVRlPusWw1QeszcUkllu5pwLsm35hhcbppPQdrwnx
         ztGOe/s4MwPy/Qq8C34BX0OIhRDNqvwt0qyR+Yt91tQW6QGjFHebzjWIopl1csdmM0og
         aTVdIVjVx+c1Xx7y6fMOFxR16CGGhzfZ95nU+wDBKsW7Ts0J/aDtKWbEuxQu4yfqDOVT
         Fd9A==
X-Gm-Message-State: AOJu0YysDlTyPbUxL0H4dd8Zg16k8mPmlhg87bBwfw/bxxvv5G9l13Z6
	XldkbU0yddRkrd3i1b79zJYahFyuHuj0KbUNWbE7C9LGJBuwxaJhqNyCOG6nWlTKpdL5CyLSACt
	5XPFrJYbIuREciN8uNgF2ti2RYV/PcsVo
X-Google-Smtp-Source: AGHT+IHvi8nSTOyWSBZuTntLRLG2ejgKSdkSEhqw0wE141K9UhAtZr2aY5NsfkyJHx+cDiFgi8I2PSvnhyFAnoetqX4=
X-Received: by 2002:a05:6870:1653:b0:25d:f950:f18c with SMTP id
 586e51a60fabf-25eafb532f5mr2070363fac.26.1720604375625; Wed, 10 Jul 2024
 02:39:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jul 2024 02:39:34 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAN2LT1Ctwdij9-DujKeuzPX71mzEoMVbdrTkJ8bpRnX9NAZy9Q@mail.gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240628190503.67389-2-eric.peijian@gmail.com> <CAOLa=ZSY1y4wz6M9mOLvTCPoeCmceD-HKqT5tomF+BzbL5yp4Q@mail.gmail.com>
 <CAN2LT1Ctwdij9-DujKeuzPX71mzEoMVbdrTkJ8bpRnX9NAZy9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Jul 2024 02:39:34 -0700
Message-ID: <CAOLa=ZRi2w_CXovpg3h1mfMsOiLWrpS8vL+NzS5o_NwhFdysTg@mail.gmail.com>
Subject: Re: [PATCH 1/6] fetch-pack: refactor packet writing
To: Peijian Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Calvin Wan <calvinwan@google.com>, Jonathan Tan <jonathantanmy@google.com>, 
	John Cai <johncai86@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000009be798061ce16ca7"

--0000000000009be798061ce16ca7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Peijian Ju <eric.peijian@gmail.com> writes:
[snip]

>> Right, this commit in itself looks good. But I was curious why we need
>> this, so I did a sneak peak into the following commits.
>>
>> To summarize, we want to call:
>>    `write_command_and_capabilities(..., "object-info");`
>> in the upcoming patches to get the object-info details from the server.
>> But isn't this function too specific to the "fetch" command to be
>> generalized to be for "object-info" too?
>>
>> Wouldn't it make sense to add a custom function for 'object-info' in
>> 'connect.c'? Like how we currently have `get_remote_bundle_uri()` for
>> 'bundle-uri' and `get_remote_refs` for 'ls-refs'?
>
> Thank you. I am reading through the old comments left by Taylor
> at https://lore.kernel.org/git/YkOPyc9tUfe2Tozx@nand.local/
>
>   " Makes obvious sense, and this was something that jumped out to me whe=
n I
>   looked at the first and second versions of this patch. I'm glad that
>   this is getting factored out."
>
>
> It seems refactoring this into a more general function is on purpose.
> It is encouraged to use this general function to request capability
> rather than adding a custom function.
> Taylor=E2=80=99s comment was 2 years ago, but I think refactoring this in=
to a
> more general function to
> enforce DRY still makes sense.

It would make sense then to move the existing users to also use
`write_command_and_capabilities` eventually. I guess this could be done
in a follow up series.

Then I would say `write_command_and_capabilities()` should be moved to
`transport.c`, no?

--0000000000009be798061ce16ca7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f0b3659efc72a19b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hT1Z0VVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mekR3Qy80NUNMSUNmQWY3RGJMbnZqWU5tK2JCSVNBNgo3K1cxOXVFdmhC
WUVldE9EZ2d5TzlKK0JteUlKVmdPWUg1NEdoY1F2MllaeUhSczEyRmNnc3BocWhVeFYzSzZ0CmNw
U01ZSVc5UStxdDVlWWx0UDhYanZMeVdxMnJVN2ZaZDcwWWduMHNZWlhSNUNnQktnUGprVnZjZzB0
SWNPRmkKakRkQ1Zzd29rUmJJNDlXSEhQRm1neGRoUzBKWFdCRjdQQVEvN0dHdy9zdjArNWk4Q3VN
VW9OalIrdlBPc3YzRgp0ejNCcEtpNUQ2N2xNWEhBSDd1U3pGQ29aaW9pUGp6Skt2STh1TUFFekht
T0lLSG5iWmtBLzMvdEZvV29yUVBnClRqeE5FQy9sdkhJZkVoMFFpbkNSQzBvTXVRU3hzNVprWSt2
QUtDM3BtcGE0NlRnYmttcHVhZXZacFg5dmpCRmMKeHBOTVlYTHpkclY2SVU4VUhOVlpDSk5xRlZI
eTdkeU9SOGd3Qk8rb0twZmd1QXFWQzVJZVFmSkpoUVRMWnlRNAovaEwwLzNXYUswbndIcFVzUy9L
MmMvNi92cGVOcUlxaHdvY29EZVQvajB3My9tMkxuTXdsT3NvRTByUGtrSnhECjhsYU5qbUpWWUM2
Ym9nL1R4Z1JCMFlLSEdoVGtFN1IxNHBRTWFwaz0KPUhtWEkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009be798061ce16ca7--
