Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C1D2773F4
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 05:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769058519; cv=none; b=k/1mfok7E9hada1f61R2RL0VIevSUKxgJ8Og5aM2+4qZqZYQK+maQRXAGyBFGuuwAYeLINUuy1pif69WmsUrVSonHYeV3I2HKahZC3VZMSsyN1tX8j4GfGEOiBj0uQZ5VaQJD0JOULwwnnPKzyJQtmuxYPHA+9axhxDwgExONFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769058519; c=relaxed/simple;
	bh=gw1MX8RaqNMQSdjYy3oR0XHHuhozt1+n8AWKX+nB+SQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=BzQKWwYpuYmpsu6ty5Uboqr+OrQnR0RB3EpjX80bF/Pfwb/9Tc6LoBIEMkc5ii0+ZtVYqaFO/H0k7taiRYTBoGbSX09B+CytsTo8SXMD6yH4NUyOiMTu7GY4Tz6DJ84Mo1YDZcRVJgjV8+I09xOmrJM6Qfh70kPe02+9Z5pJ6wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPfHItX7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPfHItX7"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-81f39438187so372769b3a.2
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 21:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769058515; x=1769663315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gw1MX8RaqNMQSdjYy3oR0XHHuhozt1+n8AWKX+nB+SQ=;
        b=HPfHItX71SvgYWeslAtuYlUwoMb1UNUCauFWYOD4eMBMC7UlhR9D9rj40MEa77FfaE
         CJO6aYnYFGXHrOO93tnVtEOBb1CNOwSw2NMFp9VuNwHAT1o+/nMNxc7VsuyVP4aiTvUY
         3uH4Oqa16FLRmWIPyOCwIwCYjT/dH39la3cWxuJ/T4eVZoFBMKLqaaDPiFmhhxUTwR6M
         i7xmDTjgNWIv6HXhe/rS0GfD+rX6qplaisc55K7Z+zIIjCpXCx/W3o73cUqhrnLzUQHA
         2++LOOld6/tHcWFCs5HFPMJptd+kHeDYC/71ymOTnQH7wH2ZavoZwhj5OpOh7ofEzyu1
         W8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769058515; x=1769663315;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gw1MX8RaqNMQSdjYy3oR0XHHuhozt1+n8AWKX+nB+SQ=;
        b=XYiJ/D9oitt/wxcMPFaldqJAmwN6txRqFiHGpjJJ6hrClS7djywCtn2+BTGhY48hW/
         3ifhPlODB4kxxyqe4V6qd9LSzjaKYtEjGykTjbTaN7xPiZMkN/FJXR+SuTPrGJQf+Mzk
         +l3bSxA6kQyyMvPmQ8QfN8N0m1pNPmobJDQrMYJGrCGBESGQ+MImSMIZ+8Kpo8wdTMBQ
         D3m0pEgQIYhxVzTmbx0/wjWYQlLcyomNR5bn4kYz/Fns+2x09EKdEyv/QTaW5ZZrQfkm
         oKXuqLcZbVpHnz3f3d5N2V1udRpt6QTWcsSBwAEIO9w4mdXYZOOeunwCQCp0t6RJkbtZ
         gmZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM2STTP3+PbNGJOEzebTmu0dlRHgBvRghq9slZ94R9jhepcSbZqyyAQUlDEKjPw4PNzsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1112cfZlvLAwWjRfCroMxHvpfX727AeAaTrTJHf5Q9C2dbBLV
	rwoHrqjEOIn3lQh7zERxN44KPtlbkNzl/XYmECa5XxeNuEXFFRqrh74J
X-Gm-Gg: AZuq6aIgvo9sYYfaSAIJFQK8IUIm5aRCo4dJEQpyx2BFn3HtlPhJ1Eb2CEEnH/8jGkP
	BiHFXZZN1xESaUruwWkRZVa5D6+kqHB+q//szV9DmWtGu5NOORa//CvTsS8Bm5aYkQvF0w49Env
	Fy6BBigPjOZmPMcm27s/0xSncK+7tLaSiJxTnGcwKpA2Tm3JQGW8Ej1F5KHMuhDSftzpss46emm
	vhpUPyw2F84kOmM11ew6TOV8bMEFZ1s5n4g2SxUA0YKUpQFDsbL7ImvTXU3JD+060K6MtBJ2GpI
	a8w17TA5mNTeUkHrIRhj1wBVunY9kJJUx67E5G1+G3srFFqHxggbW2aczz8o69l4JrMcS/l550Q
	/RDDXjD4+4cqMQg10CazlnQ8of4yZnL2F3q3WBaDk3m3/+ZQqS631SUique7oENWU3AwyQ0Bx6P
	kRtU72evbKBsE4XtakepqFcWDhkMimgyaCKUEuTRvVeaaN
X-Received: by 2002:a05:6a20:d81a:b0:343:af1:9a57 with SMTP id adf61e73a8af0-38dfe771f04mr19807122637.56.1769058515089;
        Wed, 21 Jan 2026 21:08:35 -0800 (PST)
Received: from ehlo.thunderbird.net ([2401:4900:9157:13b7:d635:584f:2939:e903])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf37b380sm16189083a12.34.2026.01.21.21.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 21:08:34 -0800 (PST)
Date: Thu, 22 Jan 2026 10:38:29 +0530
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Christian Couder <christian.couder@gmail.com>, git <git@vger.kernel.org>
CC: karthik nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>,
 Justin Tobler <jltobler@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Meet Soni <meetsoni3017@gmail.com>,
 Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
 Bello Olamide <belkid98@gmail.com>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: Git project and GSoC 2026
User-Agent: K-9 Mail for Android
In-Reply-To: <CAP8UFD11txMWSfMTvDtcBJuuZA5mKffo6XUyR9LWk2d_N0RRtA@mail.gmail.com>
References: <CAP8UFD11txMWSfMTvDtcBJuuZA5mKffo6XUyR9LWk2d_N0RRtA@mail.gmail.com>
Message-ID: <35E56A79-FD65-4CBF-9A35-BCFB9A169BFA@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Christian,

Thank you for initiating the discussion=2E

On 16/01/26 16:36, Christian Couder wrote:
>=20
> The application period for mentoring organizations to participate in
> GSoC 2026 is from January 19 to February 3=2E Let's try to anticipate a
> bit and decide soon if the Git project wants to participate=2E
>

Indeed=2E

> If we want to participate, we need (co-)mentors, org-admins, projects
> and micro-projects ideas, and we need to update existing pages or
> create new ones on the Git Developer Pages (git=2Egithub=2Eio) website (=
or
> on git-scm=2Eorg if we want to switch this to it now)=2E Please chime in
> if you are interested=2E
>

I would be glad to help as an org-Admin this year too=2E I could act as a =
fallback mentor in case any mentor / co-mentor becomes unavailable during a=
 particular period of the program=2E

I also Cc-ed Chandra Pratap as they expressed interest to be a co-mentor b=
efore=2E=20

> About (co-)mentors and org-admins, Karthik, Justin, Siddharth and me
> have already expressed their interest in (co-)mentoring in internal
> GitLab discussions=2E I am willing to be an org-admin too=2E
>

Wonderful to see that we already have 5 potential mentors! Keep them comin=
g! Also, it would be nice to hear potential idea suggestions too=2E The mor=
e the merrier :-)

> The Git team at GitLab is also willing to manage Slack discussions
> channels for (co-)mentors, org-admins and helpers, and then for
> accepted contributors too, in the same way as for GSoC 2025=2E
>

Cool!

--
Sivaraam
