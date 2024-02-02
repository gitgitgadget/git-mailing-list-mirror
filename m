Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2F720F7
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706878969; cv=none; b=qKgH2EfnuGjL9Kolh6QRFl1y5BH/+LUecTjHpBbuvgzBBECAEi8jb3JxrgYSfUtXa+pCqz0uBP54A+5jl+DhKZjTdW4g+YtDeU0i9IUIx4/P0Gnpe3pTvYTsAyP7ceTTbeLt5eZyTA5R6HyyKaS5jVn4zJZuKQEST+24H6L7cqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706878969; c=relaxed/simple;
	bh=4lAkRW6Lhe6tWyD9yQ9ZJg+4l/CO/G1yYVfoIv20yx0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4zoIIuLpLfv6r7gODxQHiqgiQuEbYi+TvBbsgzTs3edQPadk/3dWaQnfv/vMvp86BCd0VgxgTrw0aRewxRVqJdEtOkHz5DH3ml9pybjsHM08Wr3t8Oo2y133WhhYW5Zg0VjTUKxVqQObYFrHVSS3wxIWnuVvF8Frl1tMqY2JLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLzxATNH; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLzxATNH"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2191b085639so303657fac.0
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 05:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706878958; x=1707483758; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4lAkRW6Lhe6tWyD9yQ9ZJg+4l/CO/G1yYVfoIv20yx0=;
        b=mLzxATNHDKL3r82SXPL9C4RPmu5rHH+f5E529DgFYMLDWsju+KSpCT2JO41FIU6K+o
         EhkLUe3e1e4KR9Xk4QTXlwgchuGF6+YTN9jefJ85UqZqHkaJMo/8BX1qqOO4+OknCQsc
         Jk2YPv8x8u8WWVAvGgRhBCB2+4+0/WKdLD23BNBFiZ0+waV33Zbqjf+qTm2F5VAtQY2b
         mA8UZrGoLjsN2nHtkDTT6XTLhX3BW+kKYZxPAVhUmhWxKfMT4JMt4YyIk+gpkyLLeImb
         PR/g63yI4eWgv9EbGuRKpj1GdUDEqztuC+5p1F2ahYWV9HdYjINLErR1eTRVJlEtmB56
         Se5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706878958; x=1707483758;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4lAkRW6Lhe6tWyD9yQ9ZJg+4l/CO/G1yYVfoIv20yx0=;
        b=K1uq+PrKm5PP7Xg9ftKEpVy6lMqBrqWHH34S1KeFgFQcEncIV7CIulO/x3RHDbssvj
         0WqX9JpcrCG70WC55XiI28Teb6FsgN+rRtZSzMy5XuAejEiQWK9w7W7weGcYSTwhNe9a
         IGWhGoJq4PqCmNi3c4YPF3SHfBgwlerhkFXsJYiyukJC6jwsUb0iGP1QXR3aCoplDkuX
         nTgIx7JcOeVdh11pA5MfpfPxxfBHq21WzaC341T+c5Rm3VUG2m7fWUIub2FXISm+PHhf
         hDMTki8lHpkzT7S7BvP377OqiVdi1ThsLWl0U8RsuJUXs4dpl/kZn64OT3P9tvsNt2UC
         7+BQ==
X-Gm-Message-State: AOJu0YwUYDu9n2GqXi5XHMcoyoFya0Q5tcWjZ3ODYqXJBukNWECv3+W/
	QJK5LY+iG+5pev5DN30Nwc/8jpKRLwsXixyapw2xssB+ULMNmqpa6rd+MTgiFnsaheCotNhnepR
	JeyFY8NrxGseRVd6GEbnnQhUbT+o=
X-Google-Smtp-Source: AGHT+IHgl5v0NgywqVxLAPxHB+nP2wWGZXI91PCd/YoHj9p0nO2wU+YQUgzAOLCVw3Le1nbuUZ+D1urCoJhzV7E8K0c=
X-Received: by 2002:a05:6870:34d:b0:214:84ce:8775 with SMTP id
 n13-20020a056870034d00b0021484ce8775mr8569425oaf.7.1706878957866; Fri, 02 Feb
 2024 05:02:37 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Feb 2024 05:02:36 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1706862705.git.ps@pks.im>
References: <cover.1706601199.git.ps@pks.im> <cover.1706862705.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 2 Feb 2024 05:02:36 -0800
Message-ID: <CAOLa=ZS=Qo5i0niayUyCpsFwePSZoGg3NCWdnAuhvvTizmYTyQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] refs: introduce reftable backend
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Han-Wen Nienhuys <hanwen@google.com>
Content-Type: multipart/mixed; boundary="000000000000f56a6e061065b973"

--000000000000f56a6e061065b973
Content-Type: text/plain; charset="UTF-8"

Hello,

Patrick Steinhardt <ps@pks.im> writes:
> Hi,
>
> this is the second version of my patch series that introduces the
> reftable backend.
>

The diff looks good to, apart from the tests (which I didn't get around
to reviewing), everything else looks great!

Thanks,
Karthik

--000000000000f56a6e061065b973
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4ea753a6603cb475_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1XODUrb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMHB6Qy85WVN6dmVlWjhtcHVBVGtjK0FrSTdoL1ZxcgpJOTlFSnY3Yytr
SWhOL01uTE9ESXpGdGpWTG1GaXg2a1l0Y1QrNXh1K2ZNMHpzNEloM2Vwa2dvNndyY2cxRytCCmlJ
Qk5UY3hORytXdkhvRzFFWTc3N212b0g5SzcxVFM3ZS9aOWM0Rk85WmFUYUI5ZURQaWlkM0VkSDFJ
OGZPVzQKTHJleDV6UVVzRVVrOGh2eWpkOWIyaU9WMTlGZjByUlNRaTA4N1M2N0t3TFkvdmwyUWFl
cC9HSVdPajl1Yzd1TgpOZWowMVBJOUE5K1Q5WkdvMHYrWFh6SjhkSVJlZXNrMHphMDMrNTZTNC8z
aVZPYTd0eEFFaWVVek1Zb1pPbEdaCkNidlJWR1NiTno5VTVKcFFhZWNneVdpM01TN1VNd3F2ODAv
RzZWcVp4T3NMeVMrcVBGMGtva3IvcmtIcWc3TUsKUHZ6N29yUklVUWxiOFZvY1FrV1gwbGZpUTlk
UUVIYVFGTzQ2a21EZlY0QnJzY3E1Nm1HYXhBK2l2Ti9NWUtFUApuYy84bDZqR2puS29wRXg3Q204
dk8vYUtXZHVIMWxRUUw0eFUrTVBoMVVXaVc0QUhVV1dodjJsNjd0a1BPZVNLCnlFRU9oclRIS2FX
NStFaW9nbFo2czdyZ2pIY3F4b3FKVGxHZ1BuUT0KPWE3a0oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f56a6e061065b973--
