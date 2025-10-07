Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA5B2D47F3
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759847045; cv=none; b=Zot738FUJmWG96r/h484tzf0RLZ0sOep410e12OMsHZvTBm3GDwAz1iGgnZt1ykKPU2eGyY8RTvEMvO58PHSLyO79zP431D6ulxA5UIVbaIHJr6c3jwBfa9THvuYk65uhsQ0GrlDMdfyhRpcfBeU12BtZJlIOFAzruZmoMvZspo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759847045; c=relaxed/simple;
	bh=jebjJZ0eS4gr9mHhPbtLmeL+3ffmgt3ZbIUY3/rZ7CI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=Vorwuf4n65oXW3WO7qlKSCIwIlxp1VKXWz31oO7TSvCy+5/qwD3Anfyar5E7Vyx3YIBwYTQwcVhQundkxEfeNzaEZ2/ZptZO1fQSStVf8j3uBC2Qhe7Z82EHvSr12oDbbmskUD2+MiiVvBWsMHYyHyBdHfDFclhJhGF287R/Y8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WotlEviv; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WotlEviv"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-58d377d786bso4217517137.1
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 07:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759847043; x=1760451843; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jebjJZ0eS4gr9mHhPbtLmeL+3ffmgt3ZbIUY3/rZ7CI=;
        b=WotlEvivxKKL0H/tUKI+ysygynUVDJU1knIGe93nWG+k4HWxfMy0p/ROgnwVfA/AcI
         TZVBGndaejssm+Ug7BMF4ZTaDehrPBRbfwQ8Im74IxTyCBBVWkYmQVzcwoFoQWEutRmJ
         xTAADhbJh7QvuffW+M/5L1cTS2NGq4lmPMArYisktDo74jXAkYLyMdiVMTiZTzsmpwCB
         97eW7w20J6/2yUGlzWBm4YCLMITtrE1geEzIMH1rq02mY1DuLJYWu3lr1depvv1tbIqZ
         McQEnAQOWmuu6JNzkuudTUABQt4HXdtrPuYwvKF496RC+jzi8j6vjLILJwROmbaa9z2g
         YOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759847043; x=1760451843;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jebjJZ0eS4gr9mHhPbtLmeL+3ffmgt3ZbIUY3/rZ7CI=;
        b=FWZ8kIUjydlXo8xOj0WczapwbBM2XbEwV5/IruQ37jRph0qe69hBGul0Ve2hKJv2wi
         IxaXrg/kT+qgmAvNs3camF41Ul6H0xwzwNKR7kT2rkdNSZcBXfFnSFGvI3Uw7ZLXuXtH
         ev5uLACgbK7psss+6QL6MuNxy8PjPhz8Ra0ViMU/u4k847fg3PQbxcOKXbpg/ZBKKX/A
         W0u3dBBBNnEiCvZvpO3xYVeQ7aFOnbW34P+VIJCIsTP3zXn59aDSmrTFPBTxIcacRuYX
         MNNWBpTk0FpILmXMXYT0nTvP/UAbHhr9jCt6JE4qmUO1QNlAalhTDgVjXvz3gTt0VeO2
         tcrg==
X-Forwarded-Encrypted: i=1; AJvYcCXi48wpsgTkWHZ6NfrjBaa2KBk2MuErhb22HstlTxp8dIO0Rwtq/FzqjoGqU1aFnwSX2Os=@vger.kernel.org
X-Gm-Message-State: AOJu0YypHutzkumZsf4vMEbVVogAvAWxNwtc0FiaV2M0M95UmSd/Mgm8
	NCprOJDQeQhgjDDov+KEfE8CN+CWJHv4XbtP6FNFwi8prJ6xuhPfAtoZVqFW4JNoqy2QqClCNk2
	3Y3vRGZL/aZmFYToUwu4Wm9XJmhAA+Wo=
X-Gm-Gg: ASbGncsDayPKsvBTuY4D71P5VbauP7B0lYik6PQ4mEa+vaZso6rHcB4fyK9zu2UIFdI
	oqQU3cozYdRxvhLOrdlCM6c0IHNooE1LaJtMlZ4osJURhP6+52xu6JMIFikQGQ1bbFvQa17yHhG
	R2dLwbhP6lB1dy0UeEPZcZ98KGcuW5/QWfCLtwrMET2JlPvzlrgovxfpC4DVju3AUiMVXkWYJhL
	EIn7rHpTzfgAwI2EAEbUrpzw/0U9EarbBDSoZvwFd6YxoyrPFm1sQMrNzB/NQ==
X-Google-Smtp-Source: AGHT+IEnpOglLte6/EIt4lrXJj9QuWkFGaTTvtXAPDHrTGI+5YmYmxhIFon5xOyuJJ70Shzr7pE5IQEjPAO7CJwFcCM=
X-Received: by 2002:a05:6102:5e95:b0:5d3:ff17:fa26 with SMTP id
 ada2fe7eead31-5d41d0e7e12mr6322881137.21.1759847042694; Tue, 07 Oct 2025
 07:24:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Oct 2025 07:24:01 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Oct 2025 07:24:01 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-2-916cc7c6886b@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-2-916cc7c6886b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 7 Oct 2025 07:24:01 -0700
X-Gm-Features: AS18NWBbwgUal8Q70PDDBokFrMs5Lu3zWpjHEnQ19m5HaGmJvYVO3-SlDGLF9rA
Message-ID: <CAOLa=ZR0KWkpB4kjFm2g8F-PK_LWpE20P21rmJGOLONCkfN7yA@mail.gmail.com>
Subject: Re: [PATCH 02/13] refs: introduce `.ref` field for the base iterator
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d6eab10640925153"

--000000000000d6eab10640925153
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The base iterator has a couple of fields that tracks the name, target,
> object ID and flags for the current reference. Due do this design we
> have to create a new `struct reference` whenever we want to hand over
> that reference to the callback function, which is tedious and not very
> efficient.
>
> Convert the structure to instead contain a `stuct reference` as member.

s/stuct/struct

> This member is expected to be populated by the implementations of the
> iterator and is handed over to the callback directly.
>

Wouldn't this also add the burden on each backend to ensure we don't
serve stale data for each '_advance()' call?

Would it make sense to reset this data in `ref_iterator_advance()`?

Karthik

--000000000000d6eab10640925153
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4638d669b8e0b3f2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qbElvQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mekhkQy85cVM3S2RvcnJYSWM5QTg1RkMrbzdNTXNKegpORG5TaTZvdUJq
Y1dOMG54KzIvQ2RhN05TUGNoQjV6UEI3b1o2QlJpV0lyc2RBSWhKWGd2U002c2ZoQkpSZzd0CmRv
MFlsV0svTDB5Q203VDdTM3lnaVdCSytjM1VUbGU2TDh0VjJtUEZWeUpqOTdXcWMybHd2YVZ5ZjM5
TWV4dU0KaEFKQjhLdEdlNllMSVMxdUlick1JOXpFNDlUYzMwUDNNb25kaUdvZnY4TmtORDkzSWNv
ZG91Z2dkdk96UmFZUgo2L1lKeGtIand2Qzlta2l4YUdIbC9WcTMwdzBiYTNiM0JDdk83MHZSRCtk
Ui9LZ2UxaXBWbFE1QXhZNitzeXlRCm9GZmhUZElOeFJkUEZXNmVleEhPTjAxc2JXMjFwUnk5V0Qy
eXo1RzBzL0NhcUtrck1EQ3NueEFaTWFYS0kxQlYKeERMMGNzY3BpMkNUcWRqSm5YcXpVZFNmZWtE
OXQ4MDlMVGQrWXFkNlhrTTYrbm5uZjRpU2Yzempock5pT3ljbApnSzBtcFpoWE5QaC94Rld6cWRa
QnlGcTQ0cHliTzAvbERxMkF0QjVjRzJKazFjdFd5ODk3Tko1eUg4b0NGeVRUCnZsbHB0clcvNjdL
MGROUUg0V2dadWQ2WDd5UzU1VDJBMGpIanpFQT0KPVo2akoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d6eab10640925153--
