Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F9EAD2F
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713375630; cv=none; b=V48LqMq6+Rm65gIsdfYwEETygn5ylF6N+fFTyhq9Z1OuAGqU/lDiW9BKyASR+WY3Y4Lc/AiTLQyZVdFZL0anIOz3Z7hpso01MR06qxFTNri1mfOXlZ60AerZSrnMsqp2yW6SxwXb2jLA+LlFGjoD2u036N4kIEgHrZA7/+MJ59Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713375630; c=relaxed/simple;
	bh=PHOQpjrZtw2CTr/7mGcMLVbJPH3IKfLYPPxIOfGsYtA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=YDhc2vTVeiP+D17MzEjBaIIdQ7PvYrMceuvvNUCkKnrGa9eE6BWU5BmO1clxNpxDJrmamEnMSbDEFRJagxn99IqMb9RIcM/qd9s7+cTaDk8cdtvqNxTfUupXLedRrcoObMU1zMbcTLOuPynyq6UlkwSpqj02XfTW0r3Y3Wcqskc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCdQySkH; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCdQySkH"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2dac77cdf43so30485011fa.2
        for <git@vger.kernel.org>; Wed, 17 Apr 2024 10:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713375627; x=1713980427; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PHOQpjrZtw2CTr/7mGcMLVbJPH3IKfLYPPxIOfGsYtA=;
        b=OCdQySkHEaXA2/XqCdkZVYvnFnz6JthM+PbDyyhalY48zQwMdpOIBZpIj2F5hKkT+c
         6wId/AD9LtZCYy4bVtv0bSAaaj3HXdSOWdnVE6ugSdwP/eX2J9J9U0v4XYH6+cfDSym7
         4LoCOq82jfFB5H/+nYNr/uut2egj32MEDpLTBRhbXYOlqJDlZadz1zoSh5REgtYl9TZw
         xRYTWdHapW66vnS128eJTEYOmP4CVoTCCTT6LywXo10r+9Ttjgz73zYIhIR7mDpQ0dju
         4OWUbPwW1htKGBw2jHBz9YQjfSQ+xjOrCEaNj3V2s+/D5lnRerFifNvQ5akVGFsUXqhN
         CJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713375627; x=1713980427;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PHOQpjrZtw2CTr/7mGcMLVbJPH3IKfLYPPxIOfGsYtA=;
        b=ovdzwZY34XkXaKRFitv2BE11CTsblW7U8jyLCkpXbsphECQ1JxNbrVFWiN4lip7uAe
         fiABJWsTIho57DKwNDsXK2+Sy7/TtC4bwNAKSF8RUiLPnI2CAb+Q/xcLS/mueTr7cE+K
         UWmo8hEYDeKwm5jqAdGR739FKVa41+bvSx4E8/2yX6E65i58z9a4o1DJSnBGQuJMIzZy
         /cxTPW8owsdZz4R/AA9HCulYMEZJ6ETMGrr9Cwds5AqRoUs9l15JxhxnTQWhSDMSPcOS
         UbXFvf19OhKO5McIa7tXy99Eg4/epXjz2zNzs8r6YCUG0ocrmNLh3nokaZhJy2ecYSEc
         ++dw==
X-Forwarded-Encrypted: i=1; AJvYcCWuZPnbNJzFBK8KWg3okgQCWP1TBD5eQXUl205qkyTz4QcD+8Rf4kf91ZOce93apB6T1huMy627xl0Rqugq7uxDQcbx
X-Gm-Message-State: AOJu0Yx86NuOoBX9eLJdxGbjR+J7OnfPV4ihWLpVn7nLFiQAyHZGkp7l
	qV7WbnBq7+MWxCI1GsCTNG0oO7KMma4Ky8p9WBWt8esTMYS4sAp5z4DGAYuvRS5dtYRPSrbgZxM
	inZJSI1DLwmAHktdaASvZ5QbphmqcyA==
X-Google-Smtp-Source: AGHT+IF0auaEJVFafmyK3KlPBl5eA+tPba+fiGi5jCW1X0F/NtBwXUYPzthR16Wxmq4gjUgb/r81KoVMyCzq63nwynE=
X-Received: by 2002:a2e:731a:0:b0:2d9:fb60:9b0f with SMTP id
 o26-20020a2e731a000000b002d9fb609b0fmr10514828ljc.31.1713375626412; Wed, 17
 Apr 2024 10:40:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Apr 2024 10:40:24 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1713180749.git.ps@pks.im>
References: <cover.1713180749.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Apr 2024 10:40:24 -0700
Message-ID: <CAOLa=ZQmCWh_UHJ+JWbzd_b=Ob=gUE=5wEKy3gpaxu=Bru+Wvg@mail.gmail.com>
Subject: Re: [PATCH 0/5] global: drop external `the_index` variable
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000945dea06164e5945"

--000000000000945dea06164e5945
Content-Type: text/plain; charset="UTF-8"

Hello,

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series converts remaining users of `the_index` to stop using
> it, instead using `the_repository->index`. This gets rid of one more
> global variable and brings a project over the finish line that has
> started back in 2007.
>
> I realize that this patch series is quite large, and that reviewers will
> eventually start to just gloss over things because the conversions are
> kind of boring, too. Also, due to the size it's quite likely to conflict
> with in-flight topics. So if you think that this is too large, please
> let me know and I will happily split this up into multiple series.

I gave it a glance review. I also wanted to run the tests on each
commit, but couldn't apply the series cleanly on either master or next.

--000000000000945dea06164e5945
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: de9b2c969a8723c8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZZ0NZY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOEh5Qy85UjVKYzhJcjFCc3kvcHlhM0EwY0pFQ1ptawpqRDRXdWJSL3g4
MVZ4S2JWZ2pLVGltYlJIWjdQeEU4Z0ViUmJWWXlQWmp5a0ROYSt1TjVPcldLd0NiWStiR0ZvCmtO
WWUzU3FRVG5tcTg1c002d0IvNDQyZ2ErVnFhZW9uRTN5Yy81TnhpOENaRkU5T3R5TkZPS0JzUld0
K0tpQW0KQ09LbXdSa1dkb2ppUU1yTEFjdC9JaVZJVjZiTU82MllhcXJDZ0pTVEc3VSt6d1o1TTFp
STFocGhoRkdKZDk2cwpsSGxVVEZNWlFTa2Jpaml2dmwzMksrZ1B4NXEvSFIvdUxkZEtpZjdQUjU2
UTN5ZSt6QTZ0UjRwdXc1R0FPNDZkCklnRHJ6Q3dYaGFraldaWjZvdFpnK2lGYWJRcmI0MjB4S1ZV
c0ZuUktvOEVPdEN3OHR2T2tZVkx3QXk2SEhXSkIKTUhpb0RGZkFqZjhwM3l1K0xFUkUwQ0ZGNm5Q
QzdFVFVQdWp6Z2V5N2JpYzdOZDN5R0dPT3VveitzSStBVExRMwpUVHFrZ3RRWjV5U2hvalVKWnZU
aXZOd1RxSEdTRzQrazJVS2w4cGdZMzdrdHcvQkYvdmlmME1jVHZJOUJZb1IyCmM3SGVqclVVRzZR
Z2o1UUExMjNwSzlxRm1TeWhTRmgrb3kzcWduST0KPWwwZHIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000945dea06164e5945--
