Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4612C3271
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748939467; cv=none; b=e+eCQ12oTWBaHHgAM5glDjlsLImBvmCRj+TfH78QnX7nNCUrLxIQTCCj3zqMR34zs94ylUBAGyYl2JX9KpGKKYtM1TOEv4oLFdN4Q/63MirVUQVhZzNkDQtEOtAosD1CIA2wVGUunnHkesHiWFEe7+uxO1NKgSXG03eoukw0xZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748939467; c=relaxed/simple;
	bh=QCOKzyCsI5ZjGM0tDkIJGlMnKqhbgj44muske20pRCI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egH5XycaIo/d50Vcp9RA4lDLl4yjGMYxN7lvjYPZ3EJ1hFU8HKztlHzBoogbkY7o5WEP9ia17Pb34hkQinFssREX9uVSMqe4wzxyMDXxj5kV32iADkyJbC9hjwF3Cid8f1Yn1/ILosCtm5OGoedhgST/Yq26V/AwJH+gPl2hsfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMYIglY2; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMYIglY2"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-527a2b89a11so2038307e0c.2
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 01:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748939462; x=1749544262; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QCOKzyCsI5ZjGM0tDkIJGlMnKqhbgj44muske20pRCI=;
        b=LMYIglY2LVcHYxMaQpdHOOcqcwW+nfjsGMqfAvyUJTGE+xpUOaU0KZEyIJg9slW94s
         mT9sosmt2SD9KAe0j+56rEJtGFecXSGQ3H1bcyE65owA4jVbS73l3cAA8V08ehT2cmqc
         R1K9N1uH+d9io7s3ubWqt+27ntRIEGMpcLD2R7XUYzzs7blrdiYEWruZVWOlE0VDJr7I
         Kx2J+AvFkps7k/HLwnst7ROnc8hpKrpMXIfM0PWWPNihDSAUC5qJ7/6Y15O0hYq0nvHx
         QrbgUsXYppKcPGKf32+yIvDmBGd0UwlSZaNlX8ygJT4V//uko4zhUOwK4u4fBxS6hYhN
         kM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748939462; x=1749544262;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCOKzyCsI5ZjGM0tDkIJGlMnKqhbgj44muske20pRCI=;
        b=XoWC9kVdw7rJ7w0sfeCHZAmhdQUEwzEodCARjwTIk1LQgk6M2wAWMAbjFuU3D+myP7
         yQTEHGv2IDwfHp+meigCiosu/E62e/lncIzAb+MC8/dwVsEWf5X1tx6Wab/X2KeYB7KH
         DsMYArdFIzshxlAwe2WFRuO+G6XR+nDw8YJgIvPPkyEAdcILERVf7fc4Ycd7vEHjhNR9
         vEEHb1wz/M1H6ghASGF7p1G1s9Z0DiWz9jGDLuMn3rh5fz666uTP63vhSUrIBxwdq96W
         +FKxT7PQgADMVGEJTjO7zqdHnFdbe5LQxtJgckbEq4dAgn5jn9O8T3SGKY11dIfXGD9w
         nOnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBq5gE10c4pd9Db8kuzr9VC2r7Zb5uMgrZQ6RzTRfBTfGkWApFVgMULRN6pmr26COFnQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx6Sr/8ljf4xRRt85jiLV+ulnqPxhnYQ2xCX91sBeVoYeiCEBa
	mE4a9XQLqaUH45ZONyrsZXdVLk+qz8WbTKvetVucZnWKUghfYZm4BZyEvulxM6HzcsJYZkTsHiT
	VwEH7ZiQ/AqgExDIcxDu03S070aTS0e0=
X-Gm-Gg: ASbGnct5Op/fmrvawGaydesaytLB+U6UEKuPtFrn7lliEz6VKJimzzQsfyosbMXMi7w
	uT/bnnjtHWkmdMeisynH4tNKwR3V48C00nXojgnWaVivu3saUD/yxA5AAOQ19dX5mu/l3/Nr8ai
	lZHYUddWw+Odr7XZnkPdyFbNedr16HEci9CsoIyY3iIWj4Wrzta7mjheYzhJkKtFx775U=
X-Google-Smtp-Source: AGHT+IFfHsJ4r+HWOHdK+UW5u/gSUs02HimBqYVQxXOXLQnkKDP9R1vjQjwOVVbrSzfaEtVtKx7ZlfvsHL+3gz0+Vpc=
X-Received: by 2002:a05:6122:1350:b0:530:7e05:2009 with SMTP id
 71dfb90a1353d-53080f73eb1mr14097934e0c.3.1748939461774; Tue, 03 Jun 2025
 01:31:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Jun 2025 01:31:01 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Jun 2025 01:31:01 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250602-b4-pks-maintenance-ref-lock-race-v3-10-587d44252dcb@pks.im>
References: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
 <20250602-b4-pks-maintenance-ref-lock-race-v3-10-587d44252dcb@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 3 Jun 2025 01:31:01 -0700
X-Gm-Features: AX0GCFvWI562rOzarNnhRraFGhl7dQKTFXBc9wPCvnfhOV3R59y5ResHC5H02vw
Message-ID: <CAOLa=ZTLvL52UpZZbXtMefHPE+s5PWhUR4ZLgB6T_JMFjqfBZg@mail.gmail.com>
Subject: Re: [PATCH v3 10/12] usage: allow dying without writing an error message
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, david asraf <dasraf9@gmail.com>, 
	Emily Shaffer <nasamuffin@google.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>, 
	Ben Knoble <ben.knoble@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000005a6c0b0636a6b3b2"

--0000000000005a6c0b0636a6b3b2
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Sometimes code wants to die in a situation where it already has written
> an error message. To use the same error code as `die()` we have to open
> code the code with a call to `exit(128)` in such cases, which is easy to

Nit: This reads a little weird.

> get wrong and leaves magical numbers all over our codebase.
>
> Teach `die_message_builtin()` to not print any error when passed a
> `NULL` pointer as error string. Like this, such users can now call
> `die(NULL)` to achieve the same result without any hardcoded error
> codes.
>
> Adapt a couple of builtins to use this new pattern to demonstrate that
> there is a need for such a helper.
>

[snip]

--0000000000005a6c0b0636a6b3b2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fb01cb72d886949b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nK3NzTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOThvREFDZVU3aWdoM1J0NVRjL0svQmJiQS8yOStvOQpsSmZZMCtTQTRo
d2RJVVhreXlEK3F5cEdsaXVrR1lZUldueFZLbklRT3dUclkvQzdtdFdOWmlQemRzRVh6Sy9hCnRQ
dDRsVE5VajZCSm9Sck1ucy92b3NZOEszd3ptK1JHUmRTcTFVYTluWkdvSTFBZkhjYnVxZklINm1t
MXFITVkKdVQ5TWlCYXpOYTc2ODZVZUs0UmFNVDFyMUI4bC9CcmJBaUZqWmdRMU92dlFjZzMwYTAz
SHJSaERaY0lBbnRDTwpDS2t6TUJTbzIxY0xzdHkyajVzNFRFRlZGMkRFYWVBb1BBN1hVSGNYSzlx
Wm5uajZZT2NjdzJLUEZ4ZDIrNS9vCkhxOFhHRVZHd3o3OWZpeXljRFdZTnU3NW1McDkrbHJac2NP
dE5ka2xwQU5Gc3JyZjRPaWdjYnhncDMwWEQyaUQKZExGd2hQNE5XTTZoTVFSVkVnbmZTTnZvcEd0
a1A5NnlDVkN2bDhKeEFNM2dhUFY1blNPS0N4blZJZVJ3L3h5TApiN28yN09BMTF0eG9IeTdmNTJP
VUpXUTVkRllsM2JDMkNjaEpPT2c1UTFaUTdsdnBWZ1VrMEhnNXpMUklUSDhZClhSRTZuaUt3b1VD
NHorTWFvbDFzWVdaUUpZWGc2MnBOUzFLMFl2RT0KPUVneW8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005a6c0b0636a6b3b2--
