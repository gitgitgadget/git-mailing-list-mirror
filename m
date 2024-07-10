Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC6012C530
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618610; cv=none; b=kCfTC4EoRS2gSyig6S+Qd1uCdVsdbBY3zqPwYXzYcHTEVwiYAjovxlNqYqwokm/s3BzYfLUp9C7UKiboQJzbYA90G+lc0lSwa0yFUw2JvCuaE2BVhr7XoP12DCvNMcZu56Ag87Dh/ud9mNhP2voqWh+mjn/uclsVLYKLuj+QvRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618610; c=relaxed/simple;
	bh=KR0G9hWRuEu8o1mplgFzMvdJHnzwznr80TclFVpQcCE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMiBHy1fPwjkpSetnUvccYDV3aCXMFcCWFhNJPy+qCj+3NYaRpPuus6ZvgkESUF7cofGBpE/UqYjUTlGGQ8EFUoviV9pF+16/m92cgFpTnmOC091qBrCJ9zELMPHGlF6y5CS3aOaCZKQjriBThExtoxvQjxVNJdLigHZe2cT21U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/NgDNRv; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/NgDNRv"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7044c085338so337117a34.2
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 06:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720618608; x=1721223408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KR0G9hWRuEu8o1mplgFzMvdJHnzwznr80TclFVpQcCE=;
        b=V/NgDNRvSrCIWKXlYyADD3vBtQGxu4QVF1GJS9nDqJfsqLDn0Oxx7u6hXjDfft2kuT
         hEWniWftuGdKRceBcbdCLpHGRonGgtsnGLFbgq3Myj+t/FvT866mqXcosMBpxgnkVs5L
         Rk+CkjHHLdNWreRfCpUrTCcJIB5WthY2gdz8Zfn1s4Z2wCNV62P/NacWpnbyLQw/viRg
         xM2m6QM43HCbqywu8LBGBsx+GlULduqpkbGhU5qRfJyRJzLOrcIcaT7VRk+Yj37QFz2W
         8f7ivaeVGJv1s8/4gs7Tuld6P5vxclPxtgBsU8kVPM7+pX/GuN73MCQBK1KxZABwSuzc
         G+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720618608; x=1721223408;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KR0G9hWRuEu8o1mplgFzMvdJHnzwznr80TclFVpQcCE=;
        b=mehOiNi3B4ruCGAyauZpMNWHg2DGepn0qMcQu4P326QvfteJgrPH+4GzkgP7yBCHn5
         SS6cIh0Jk5Fq6Z9ydDOk6o89QQod+9z9+qIEwoTTyLpdZ6CjWDGPHkBaBC0T8XypYVQE
         Z/9/KwiJBgji1yOYDjQoiqOvzOWgaxiexyGdyo/oK6CLOW2vDSXBJuXwNVcQE2bKT8jY
         KmueaRHp9apq30CJA2mkB3efKl7d3m5n4oXJvb7giVwY/pZifVB9n2Ky07e5TL+D1ev9
         mEI9vTlQpfH4QbSvBic3XMnEZ1XSFczE5aEddCxOzIYsT+Wdh6aFLCgyDcrI7aSjb81a
         YCow==
X-Gm-Message-State: AOJu0Yxqla+UdwLju7n1GiTCXDWfGFFV0G2bHEvjKxnKQTljOcRHmz4F
	2+HnlSeJp338Z/7HA6rxGa69Tx/Kml79gBE7F/6uJMGFNtUTmzcvNSiqnmRSjGIy01yGv3FvGpv
	DVrQlRlHQlyaSXIRnSgSKx2bPck/t/dmB
X-Google-Smtp-Source: AGHT+IEc/bqcIrDsJCgvJCMqp3gPKsetEPWEfr5qmGPuMxBvAAXpaltLt3bTEoUXOOm9iL0CZeE7Umoz2Ao5Is9A5qg=
X-Received: by 2002:a05:6870:304a:b0:254:c617:a9a0 with SMTP id
 586e51a60fabf-25eaec3f819mr4621902fac.50.1720618607863; Wed, 10 Jul 2024
 06:36:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jul 2024 06:36:47 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAPig+cRvz7ctW8K7QbZyDSTTG_qxdU9uRmJYrXPW64OuydH4VA@mail.gmail.com>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240708092317.267915-7-karthik.188@gmail.com> <CAPig+cRvz7ctW8K7QbZyDSTTG_qxdU9uRmJYrXPW64OuydH4VA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Jul 2024 06:36:47 -0700
Message-ID: <CAOLa=ZTkA8jP8MD-pt-OXb-SdzkL=ByC4bsUyuvMBD3DO4zEgQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] clang-format: formalize some of the spacing rules
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, chriscool@tuxfamily.org
Content-Type: multipart/mixed; boundary="000000000000ea881d061ce4bc57"

--000000000000ea881d061ce4bc57
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Jul 8, 2024 at 5:24=E2=80=AFAM Karthik Nayak <karthik.188@gmail.c=
om> wrote:
>> There are some spacing rules that we follow in the project and it makes
>> sen to formalize them:
>
> Since nobody else pointed it out: s/sen/sense/

Will fix in v2.

--000000000000ea881d061ce4bc57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6617879c4a72f737_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hT2ptMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK2NtQy80bm9ZN2IwTEtQSkVnZUx4OHlTelppMDg2bApLWVZnb3hCVWRY
ZkQ5dTNjQmZybGxFTFVCWU5pYWFGRzlxWXN5ZmNKZWVOM2FkNmdRTlFlYURVcHFZUWFjWmc4CjRy
QXovbHluNE9lK2ZYc3NZTTlEbjJJeEtyZ2NycGNIZnFjZDFCZDdmaFFOU08vZE5xekx1Rnh1cklm
eTEra0MKVzBlc3M2RWhOYlYrbjJhREV1QlZvZXJhZWFIQU5MRkhyNC8xUXJadzV6eHVtMVNCeFdS
UHlQeHd6NXVoNmFGegp5Z1QyUnVveWphaE5LWlh4ZUlldFJJMHBwOW0rcjNoTW9LZDVheFJOOWkx
N3VLeTNtNEFGd3VUS3VFaisweXNjCnAvREYrNFJYeW1HTnNHWmM5ckpqcFZ6elpOSVdCa0k2SEEy
NnBwRHpPSklIbytEUHI1K09kOWZDOWVvVHc2d3gKTEE1b0piekdPT3NTalJ3RTlBRWNWTVlXS3Az
UG12d3NZZjBkekE3ZERFc1NhMXVLWGdtWGFIa25HeE84ZnM5awpHWi9JS1JzS1RaMXM5dzBVSFhJ
cmdndFdTTzN4ZHRBWjNsZkpyTkY5ZGlYL2l4M2k3bE53MHpuZGRYMURsTDFqCnFMb1BLMTZTY3d4
SjVSdGZWTm1VSnN4Rk1xZDJxOWxLcTRkNU1NVT0KPUZTLysKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ea881d061ce4bc57--
