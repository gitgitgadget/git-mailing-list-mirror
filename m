Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AAF26281
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 20:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753735148; cv=none; b=j+WSlsU3Ss631zhb/F+6SfFXN1ynvsZfuNssIaSnQZs2toYoAZIbvSYffIVy/bdpvQRXPqIOUv3OQSiS7we9ezuzr4KERWaVYhRiylY6dZU7OfqsiQOb2I3Wn6dtCzJ+HjsVQXPJv7JH9qg6Fn9D8vowR3lsfE80iLnI+nmsaWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753735148; c=relaxed/simple;
	bh=7LpfL64DXqO1Y6IFlPtOdmVMuaOdAiDiX/dJi3FOyKc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnFxEsZWAdmAsyePiTgEqRMFNLao6RZ6bqCnfkswi6Sb7fi5JDKj7t6idvAbcyyiJfG3wdUstmgjFR49ZEwzqeQ695Jcjy+RuQ9Chkx67IKTy4i5lMHAEmqHpURrlo4lQXfp7f9PWrZjpj+MEWoxwsy+iSVLWb4/ysq8I+hl+9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W45ZjbPc; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W45ZjbPc"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-88bb987d8fbso419957241.3
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 13:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753735146; x=1754339946; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CF0KVDIVhYUVAADbil7tYXgR/GbFGBWzrh0MVUimXWE=;
        b=W45ZjbPcC3fRRP4BxxkbpRXY9ILsUfr1msZmEeSNkPXRBwACgh0zgwHg3dtoJ0gVyu
         w3rHuVI8k5rP81xOzKUl1IyMDYHZH/gi8dtyOGlC9/Hs58RYTtYc0jPTQiB7WNEgKWFm
         YkVsHRgne+Num2sL9ol07nbIHCozFPwDgqcNSuekvm4Svd4/4CS58IaaxvwlBroITEAu
         h3yT8kdS5JpRU+5Fyyakjvc1vfE9gSyyti4uQ3nNzDVxbAo3SZVRgnc8Vrb5xvBmXXLz
         K6mGeVRbqbabcUjj/nAqwsrW/ZPaUu9B5Co52PG+9OimhU4LcxzMCixFK0g4mhzWsMkn
         i0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753735146; x=1754339946;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CF0KVDIVhYUVAADbil7tYXgR/GbFGBWzrh0MVUimXWE=;
        b=iuboOf/hw/N/f4ba+OgpyMF/vGe0+YUPmdLTJs/BA7NQ82xRJZTSgqYPJQxoAG7r2U
         IHi5ggoAjA7KUzb8ZcV6v1KwFt6ZyM8vRmgp9Q7lnGG752nQFsMILOobWV7P7q6DQbJF
         rCw3v/rX/R1+QGb2Mcuv53HoaSmMqNupjtMFdIg1zZPcCP9YcsJFbgDg5hLipGgZRaks
         rHykCrqD9YiDta4+F1cKfSEJEiE2x1WpB8b6U0W6pCY1fgqpEtkJh4+lImvSl3inC788
         OTv8nDxGwhdQ7u9bbAPjEPRCGoWTbeJzuHLM7kWdoseF18tbCQOCNonLYNgqKvZNhS6Q
         nhqw==
X-Forwarded-Encrypted: i=1; AJvYcCUWgyeZ0+O1I6CJ6mFhILVECNBIW18XQywBu58xt2ziBhKy6ryVDj+zN3PwNf37G1SS4wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlqVvitImwwPYPzprwRGHSm0yu+AX0EiXVlyzHOoq7vaWjd28r
	jClZw8xyLzhUEcnLsgtdjXUQ4ibFCv8z253wIDlAeBAdBxoqGlL4k+HEuTRIc5K/vzFDEJ3tAOj
	E6CvQ8vITMzfOpafAlAnzF7LWsnb8wHc=
X-Gm-Gg: ASbGncvCaMb3KpZFpua9On5EtzquwaPvuL6jd8FORRpVBbWvwZK/YEBPYr2r2RClfa0
	MjfwFg2mFyDNfAHaVLFatC3sUNqT25lDvMTIEVLFSiWnIdgptrhpzN3eMlvXfjO5y+veB+fJKcJ
	90p2ehVM06P50EMI72HTVkD93kKXAoB/MVwpSvMwNgHZdvhhND5QMHw2W5AqOJ2luaN4PfxKwRk
	cPK68Nw4iazkMdotaD4WpOEDnKN1eVeDt3s4rRS0rpWgSJG7cLH
X-Google-Smtp-Source: AGHT+IGvnMembUqowQOPYp9e0O1s7WF8xaI/m4XDy7aWtn9nkzwuyH4oFvXcQuDIX/K8UuPs66oAhNCnukGX1sbenkc=
X-Received: by 2002:a05:6102:3ed6:b0:4e7:3e76:cd21 with SMTP id
 ada2fe7eead31-4fa3fa87610mr5054209137.9.1753735146006; Mon, 28 Jul 2025
 13:39:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Jul 2025 13:39:05 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Jul 2025 13:39:05 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqo6t4up5f.fsf@gitster.g>
References: <20250725-pks-reflog-append-v2-0-e4e7cbe3f578@pks.im>
 <20250725-pks-reflog-append-v2-4-e4e7cbe3f578@pks.im> <6414dbfd-6f34-48d1-aa3f-3fe7998f80af@app.fastmail.com>
 <xmqqo6t4up5f.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Jul 2025 13:39:05 -0700
X-Gm-Features: Ac12FXyyuibeBfNkovl2PUAuo2PkF1vrMgly-WvY9xxl0nIaB57VKO2Omdw1pNk
Message-ID: <CAOLa=ZS6e9dv-c+tajooZa5qFZT2T+jqaJahd3BzVuE7H=5PwA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] builtin/reflog: implement subcommand to write new entries
To: Junio C Hamano <gitster@pobox.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Toon Claes <toon@iotcl.com>
Content-Type: multipart/mixed; boundary="000000000000688c67063b034815"

--000000000000688c67063b034815
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>> I tried `git reflog drop`[1] and it can deal with a branch like
>> `branch`.  It doesn=E2=80=99t need to be told `refs/heads/branch`.
>
> That sounds like a bug to me.

So `git reflog drop` `git reflog delete` and `git reflog expire` use
`repo_dwim_log()` to resolve the provided reference.

And `repo_dwim_log()` uses the following `ref_rev_parse_rules` to
resolve the reference.

  static const char *ref_rev_parse_rules[] =3D {
  	"%.*s",
  	"refs/%.*s",
  	"refs/tags/%.*s",
  	"refs/heads/%.*s",
  	"refs/remotes/%.*s",
  	"refs/remotes/%.*s/HEAD",
  	NULL
  };

Which means we do a best case resolution of a given reference, but the
function also checks for ambiguity and warns for it.

--000000000000688c67063b034815
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a2fa06367a12ef32_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pSDMrZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mLzJ4Qy85RlMvMlNUbGUrRVBNQkVidWhMQVRRbDgzQQp3bCt1MTBqbjB5
cThiNEpKL3lTZmJiUVNPODRwWWsvbS9kNVJxV3d6WkdlajBlOVZ2V29QKzN0ZnhZN3QwSlVBCmxu
eWpPWTJJcFlkWVFLak1hVld0QmhSeG1iRG5xSXY0RFBpM1FWWWNINjBuQy9vSU1xenNBVlN0V1ZW
YnA2cVEKVCtJVWI2OFMxNko3L0ZLOUVtNm4wQVBlaFBIR2NhaE9OMlBHdW42QkF6N1JvVlNmeWhI
VUJBa1VKaUdwQXZOMwo2dy9WWUg0cTc2eWVqNmtSMUtzZFUxdDNHbldrTWluWFpQYnFJZSswZ25P
cStKQXMzK0pReUUzN1BVYk53aDlNClRIUGtoUmRsTVJFb2Y4czFxZTU2dlljNzlITDgxUnZOZ1Nq
dU5MZkR0cVlzU2JvMFhsOTcyS011NGJaY0JHRHkKMTF3M2ZQL0Izb09FS0RLdUZ3UUJsdTk0bXJS
OXZvb3pLald6ZG44QWcxSXRRenlteEtDVUQvSTJBL1lrTU9XOApLWE03OGthcFlnb2xsY1E2clNW
ZjFyZGVkbE9jMlF1ODNqRlJBVHcrTGNJVkhSRk9TdmJkVWpIZ0pkTGJPZ0dYCldDdkh3N1JWWHF6
YjdtZy9lRGhGUXFjdFg5SGFVMTBCSVFMZEx2az0KPThmbzEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000688c67063b034815--
