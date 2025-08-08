Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E232AE74
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 09:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754644839; cv=none; b=Y9uaOCPzAmqrNbBo2fp4N7m3lY1jERvKIa0XvIukeheZPw5L43mlKilpwg/loM0txZx5Oj0jNFkTw97ug0Em4CXv+WYliGcux2au1yI7D9XhAeVYLC8ZN9ACazY0ytB/TCWAb3/rztpu1alitP5UQddz+lG0C8I1Y8nGpGalf8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754644839; c=relaxed/simple;
	bh=ZdFClEY/i2dHPriizcjulsjQY3oV193Djw+2aCuNAd0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZGfgoL+K2UkdCzx+8Q6uSYyxa0k3N2bUjDHXpm26yTGvvRKBh+W96GfrRI0apK4cAUHbe6tyAhZk8yKnARc9yQLNxTDMu45JtnTwRlQzwZlZxPo/0L7Busn9R+tsLDxqBOIPndvjuaoE5Gft0pZBmWDZnTJgCWWd96tWc6o75I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQ6aeDyX; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQ6aeDyX"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-88bb3eebeacso473282241.0
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 02:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754644837; x=1755249637; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdFClEY/i2dHPriizcjulsjQY3oV193Djw+2aCuNAd0=;
        b=NQ6aeDyXi9EHGHgxGkktNkNccJMU11mShQYWlamH2tKGCBNa6Bx6CwJNeyoG9OMOTa
         e/6vI18ZESsfmKhFHu73fBFZdM9+X5yw0iYWZSEzQXs64VRKxguCNN6xk5JZpHukE8O8
         dUm/BK+M3pXVu2oEab4a8WzNG1BoWhvNXCNA2f2JTHfA3y2Ds9gdR1d3mA5ceTAU99l3
         rs8ffYHSRnxOHCxtV3RiWystP6QixI3CiASeDUPVFPi6jyzWPd0BVttYaWB7wFCZsZPU
         YU5k5Rf9pxXU0N2MgTQQtcNMa3ae2eChlPXSRbP+1O/2r3tsgMcau1bObBz3gEHr0a7J
         AYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754644837; x=1755249637;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdFClEY/i2dHPriizcjulsjQY3oV193Djw+2aCuNAd0=;
        b=EWplO7Afwq8Tq9Lumg12IiHEXbUMlM0FNE7qbIHcIq2F/EElHqUhIas49Mhr1O77u4
         31a8VQ+xLUEnAsDg9AFw12ynESV+IMTW7CxXxTk5pLd7SomCX9UkODJ17ousJUQc0JsB
         BQLsz1Xajj55qnebZR1o8n6W8LEVM9UJQlESGBPlgCFlZiEKbgP2fPnWGiX1qXkiDgrt
         TPSk/VGedleavnjRItE+hW+ebt1+f5VVhYluMEKOAoz4UDQ0FhVY6+bmetCsuzeNUU46
         qvR45CjukfSoz5kSPa6Do0J2yUrl49/IwbJCBLd+7fsCKDJey/8WqJfpopfYZJc/NBLJ
         EgRw==
X-Forwarded-Encrypted: i=1; AJvYcCWG3dw7qleBRBesnENoshFlPjJ2kx8Y9fvHxhhc7SbBLmiKDl/vhiu0sTujipBIjtO/QPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOMz3qpEJDqF3rZuiS1Bv8nhOUIsHaYK4kzqoSBr9GMRZtKRfE
	SIZZYN9ZO0b0CgMm6Wg02qNJp0t9Y/J4FM8nwWQq1LN6IuTDPkAqQDPGsNMU+UgTadSG1cFX50p
	UJFpWI0FJSPrnNYfT/AqZP4+/6ddGqK4=
X-Gm-Gg: ASbGnctpix7Q0nxnIyRjdNnQG6tPi85W8OhFuRoA9jIRNmQi2tM8SnVPMRIbDY6K1OQ
	PH4jyCx7IZaEAbR6TCm7QHPzQdniKrgsKwdiBeSWlGB3c07DjxMTPfxw0/sMMDQ/OYx1yNIEvP/
	XDzeSVMndAM8C8aVMj+RhPr0+D40Hebujttxw2kcvp+8tSWFqA5DFKOG8MJgtcGhWN+Fv8UTqK0
	SP//9b+S0yl5YZ7azRB3EgwHV11aThozDbEalETBw==
X-Google-Smtp-Source: AGHT+IFI2aUHnX/Gyuhn4Qav8PHeAkK02CgQRr0ZZZc3V1o30sFGAniqWlEuKSm5UTOal74ZhMIdWfzgxJ1aiZt55aw=
X-Received: by 2002:a05:6102:54a8:b0:4fc:d0e5:23fe with SMTP id
 ada2fe7eead31-5060eed30cemr697174137.15.1754644837032; Fri, 08 Aug 2025
 02:20:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 8 Aug 2025 02:20:36 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 8 Aug 2025 02:20:36 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250807150239.6987-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com> <20250807150239.6987-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 8 Aug 2025 02:20:36 -0700
X-Gm-Features: Ac12FXyBAYeU5cCnSAtzjZjkFjrOKOZYsCr8mMypaRk1kFPDGv2BIyC5m3cHjQU
Message-ID: <CAOLa=ZTDFszwbQc=U-WEvmquymT_gmZq84-5QJ5VgtyHvXDtaw@mail.gmail.com>
Subject: Re: [GSoC PATCH v9 0/5] repo: add new command for retrieving
 repository info
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: oswald.buddenhagen@gmx.de, ps@pks.im, ben.knoble@gmail.com, 
	gitster@pobox.com, phillip.wood@dunelm.org.uk, jltobler@gmail.com, 
	jn.avila@free.fr, sunshine@sunshineco.com
Content-Type: multipart/mixed; boundary="00000000000038089a063bd71641"

--00000000000038089a063bd71641
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Hi!
>
> Thank you all for your time reviewing and helping me with this patchset!
>
> This v9 only solve tiny nitpicks pointed by Karthik and Patrick in v8,
> just to make clear that everything is ok!
>
> Junio, would you mind to replace v8 by this v9 as lo/repo-info in seen?
>

The changes look good, Thanks.

[snip]

--00000000000038089a063bd71641
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b0a5d7813d01cff2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pVndXQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNG9uQy85bmdmRjFsVVR6QkhydXpLcE5VTVFnTnU3dQphWGFMcUMyZVY3
MXlrM0FQOW5EYXhvM3VRSzUzTGw2TWVYYStPUUxKUzhUYm1wZWFxRCt2dGJEZnpjRWVINXpJCkpp
RWUzZkcvbjFXYjNBOG1hNHg3bFVLeDgxdXRpaDkxbnRjYXdnMnd0azZNem9nNWtJVGxubm5WWEFu
cTk4dFgKWWtXVXBIUHJKNG1NRXhnVW5ROUdtdWM5Y01Ma1B3VWJFM21CL1ZyREdxYWFiT1MrU1RH
OVpqYVZrSm5zM2FISwpReGZXL0FzK1lhUVV5cHJNM1BOQ2lLWlU2NWsyc3liVng0NlhHelNXeFNy
b2M2S0tHZk1QUXUwTjJUbk9Za252CjFlQkJCakhSTE1qYkdhZzJJbzArMzAxWVorUUVtOFpDdXM0
OHYyN1ZzbGpSUlc4VXo5SnhzMVEvMG1NMjFoc08KWXdlRW12Qnc0UGgxa0dmdS8rL0puYWQ5NWc4
Q3o3NnlEbnorV2cyaGNoc3ErRjZoSUVwUzFUSURudCtzYUI5bwpscmtBd2EwekVudjRxRGUwYkgv
SHlLNGlSMklTamhDaUtLUnZiYlVyWFQ1dmU4aDZ5RTJIUkg4U1NNOTg4Uk5QCjJuK3UzYTVxdjUw
aXo2bzV1YW9UZ3hLWEpwaHVPWnFRR0s4Mnd4RT0KPUViMzAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000038089a063bd71641--
