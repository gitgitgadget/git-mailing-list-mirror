Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D3D1FBCBE
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 21:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745443336; cv=none; b=NPKBhcH/8lDRo+cUpgV6QaFOyHescXN7qgDGr7BogcxU0uvySkFmvmz83ovzShF/kXfWlXPlGH73XM7U882KRw7hf5pN6jN6Tjtu+UwUNbdxX7iOjAZW31tHrR/cAwxdqhOZZ/ohWXy6cyDqL21JUPTtowEwuhGe+3yHF8BKwxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745443336; c=relaxed/simple;
	bh=Nffuo/IJkYCii04rAmbDm0geoNxBkdvXI0k9knvSELE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sb+bnSbwnU2sCagaEWp06zgwrmrQs4cnwNAQ882IUvvtxf9xv/C2GBs2Qwvfnxa11kD/pPZqaAlURPr1eO2JJ69uOyH8+TPbzvZtNwrT9CBselpXMr3GNDQv5d2jguCnfE0IOxwip6rKJPNAYeak1KeES6oTtNxc2FgI3WLGOxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HP08xaqx; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HP08xaqx"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-52410fb2afeso264394e0c.3
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 14:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745443334; x=1746048134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0jeRJ/WnDokUFQjblrAYkBiScK2YNDBTT1lHZBPNIKI=;
        b=HP08xaqxbQr2T5eLyNf2KNGfqWn08Sh4bqpvlB+OEM01QoX2J1rkHxm2Wq+ux24DGQ
         upd3djcVwTUeViZ6rzAiY1esbj/JICfcNauVuGBZXZiBotm4E0Dlz3b1XWGBx4I9h/Bu
         Z1zN+QHt7tP33hTLbuPpGRYFAX4y95NEIbA3FaFyDszBwnIlaXIKaSClnebOoxDrBnSf
         8HlNZMZJNaAq/ZBK7M48Vp7aaEg9FOjrQsC88g2r7v96Npl2anUWsIROxtsWBZNmCfQZ
         ZgeNM0kXrI2QGqvDoDu/4b3otS++ZUXyXGMl8Xb6U1LyfoKsT332E7B4nc0XOpEBpPxw
         /Ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745443334; x=1746048134;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0jeRJ/WnDokUFQjblrAYkBiScK2YNDBTT1lHZBPNIKI=;
        b=qNk7iVCjri+j9Qic+xGG64AneXnZoyEHCy6ZTIi/av9vruX7lbxFXIC6oOEd9Hxq7E
         +MoFniPE3FgmVUvUYcQq3Tc9zQp+PCX8OteZxkXK3ACNwyM0XPOr/C9FCSb4uVBC6GDE
         2EngT2Sn5rr6MaOpEcY7CVwnb47dRE0HQHc8uC6RBdIpjQH11IqNgPicuwYZmzLuxcJ4
         mWP3AWInUxPslWP/Gy072keP5NtZymurxrGVFXc8OhxzaesgwinAFFEX9hvsVMwy3TTX
         L4LeI/mxv/QAsqZb3CpQ7pqSp8QhOVAvBvQpGhIlAqy/AaKtW5tOAnWLcf/zPdW8fsKJ
         V2FQ==
X-Gm-Message-State: AOJu0YwZTyMsWY84UiXBXLn++YLQ6lMN3MSiMJ4Z0hL0oMdib+TkrVJN
	nVSGer9nYMNcCZqJmbphhU5nH87o8hnXLFpaZsTpjCGIZQbgdvjBtWtOkmxadyc1Xt441JsV8LY
	M6hxItV692JkO9EI7mweAThaSBCM=
X-Gm-Gg: ASbGncuLGNUtpDbVOsL/Qnm5GgWKMNb2fBX4IT8bNfUoRJqK53oF6jKJz+OFXfjdJQE
	KskjoZ7UeXUgZcNjIfdr5l25X+31ylzAxLcL7r3J2drdh8TzHvmPVBrauA9LqBTS4NCRh9/DuYa
	h+s4Y0NyZr99SzQPsC+ZBxqXBNLY3q/XWDRddk6YGMPgZyQLsGI1R/w+9K
X-Google-Smtp-Source: AGHT+IEM1hXAwEp+9C/nTBMGyR6GD9NXYAJkXulaqQwAWeCVsJMPgWXiO/SpLvXU5xTvnXsxpzPAG4WHbvJUy7d6T6s=
X-Received: by 2002:a05:6122:1351:b0:529:2630:b1d5 with SMTP id
 71dfb90a1353d-52a78274bedmr420546e0c.5.1745443333958; Wed, 23 Apr 2025
 14:22:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 14:22:11 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 14:22:11 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqr01iwruj.fsf@gitster.g>
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
 <20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
 <8a907622-a975-4f9c-86b3-54b8f5447709@gmail.com> <xmqqtt6ezshm.fsf@gitster.g>
 <xmqqv7quwsob.fsf@gitster.g> <xmqqr01iwruj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Apr 2025 14:22:11 -0700
X-Gm-Features: ATxdqUF7EZRJ_azA2SEnN0eebbDd-EbzYaLQ6HJqkIyLJnZA6855Pp6SUTcNcKo
Message-ID: <CAOLa=ZT+hUuvdMbES_k8Pk+dLgrOovZB4fiRjJpS2AUrRrUogg@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] meson: add corresponding target for Makefile's hdr-check
To: Junio C Hamano <gitster@pobox.com>, phillip.wood123@gmail.com
Cc: git@vger.kernel.org, toon@iotcl.com, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000e58972063378b143"

--000000000000e58972063378b143
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> As it takes quite a lot of time to do full integration of the day,
>> during which time GitHub CI is idle, I pushed this branch alone as
>> if it were the tip of 'seen', and it seems that quite a lot of CI
>> jobs are now broken,
>>
>> https://github.com/git/git/actions/runs/14624509129/
>>
>> with "Process completed with exit code 8." at the end of
>> ci/install-dependencies.sh step.
>
> Yuck.  It's JGit download that is failing.

Sigh! I did test on GitHub [1], before pushing the patches to the
mailing list, so I was really sad to see your first mail. Now I'm not
sure if I have good luck or bad luck!

[1]: https://github.com/gitgitgadget/git/actions/runs/14604710114/

--000000000000e58972063378b143
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1bad94ce001eced2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nSldnSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1menptREFDV1Zpd2pXQ3pTeUpyOStJL2xGL094TndNQQpzcEZpbll0YTZh
eEk3Qi85Um5BNWxZWk1LTzdpSjJLMmJkbXkwNWErNmZaTTIyZWZHUXBodWdNL2hGa01FcHpaCjJC
dDRsdkNEMm1LSjNjNWVjZllZRnpuV2J0MTNpK3R3b2VNaVhYR3cyNm1FSFFyajRVNy9rODZqL1k5
TWN5QlkKNlBYcFV1VTliQjJaV2N1VFlQWnJPS3VxeDJtYlZJR2YyKzc5TG9FbjhHSHVDU2Z6TDJY
R1JUTmtmeXpPWkg0RQpQR1FVdHZFaXJmRGdQN0dndU5qM05pWlBoYStEbkpLbzQwdlRDc3FvRVln
emJ6WHJ1M2Iybm9ReWk5SnJveVRRCkl5YlpOcUExbTM2QVZWRGFCNzhTSEM1cXllTW91WnRxeG1T
cDUvam1yTWtoS3YrZzFyQ002MjYvVjBlVWRDdFEKaWdhK3hvUVg1THFXaFFjdVhQSHR3K1JGZHEw
dzcxUEdSTkNhOFlFaFluRmt3Y2FhZGRzb29wOGFXY1RJZGlOego1Wk1WbXlnUUJHd0tOMjd5MG44
b2FNSkFQU0NTOGdFMG5qTGZNc0plalpZZHRrbUJMOHNsZXdWMWlIdHptR2cwCkJ1djB6Y1psQkky
OTkvL2tqeVNPWG1ZaW1FSVEvU0tNNlFYMjZyND0KPW5qRlMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e58972063378b143--
