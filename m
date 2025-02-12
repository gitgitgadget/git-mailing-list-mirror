Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA052F4FA
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739363820; cv=none; b=szt7xlW3GY4Sc2jssXeo5cV1BBtv0MciqnpOWcxrDIJt+2/+SJPP+ds++94b9zRzV1K6QFxTPcOfte4tSi+Fi5qCaHLzPgRYfWTA2rY8Ke2ox9d6jNUHWhZSZUGv7FSVPMXrdUp4FWNymgQ3H4W8x3UpQ6dx3acla1Q8G3+a4N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739363820; c=relaxed/simple;
	bh=EPu6yOdIxm6hneNPuuVOsaE2FqGWaDH8MqxVpShlnAE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWiUNCTizPsgplU9zygIkDpjfyjorrwY6kQbh/TVRgFVDiV6UEwBJ/t0Ggeh223XYA8TZqMV5joIYxX0wslz2f1BPOykF9OpPPLcl0rlnxEJe+D7GbZ2Bv+UuPgmrJN7cNYFnQkIDXH26OpOP3XFmPy/teJqM/l5lpV6DG764FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCOZKwFb; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCOZKwFb"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-51eb181331bso1919081e0c.0
        for <git@vger.kernel.org>; Wed, 12 Feb 2025 04:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739363817; x=1739968617; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WjF1J0DzYHQ9YEhmpMl+VaJAc3/gZNtSmO1Y0yoYTUM=;
        b=MCOZKwFbDtOcW+RYjkJiroyqW50MKHTVPN+0AdsDRuf/VCjx+MBpybzFzL69ryC6kq
         rykMdzw+4RU6P+NGL277qORTAIOFKlSliSSWZUJYkurZKtAg1lJ9pKPJPLxUJvlHmx+m
         KmP+xN7RU4kBNxXz0rtp+aF3YdO/uIiIyLp/xNMpYJAAiAcq1wCafBnggj7CI+BikRN7
         VXSz5Jk52inuaO7bGSk3Jw2RXAD2axwFUhBQmTyk8GxeF5yLPGvxl/gTrkCCnSSPqgNT
         NnRc+lKJMW8SNGF+2WeoyXQ3sp8Tg1U2iOYnInro6xvIffULGUENDWh1RKSozbxo9Os4
         KMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739363817; x=1739968617;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WjF1J0DzYHQ9YEhmpMl+VaJAc3/gZNtSmO1Y0yoYTUM=;
        b=F1z4bmnq0kQ9rX1iuzwjM3iFFEIWsKX9ULXi125pnBFx1Ywd0QkCA6B08k+AAIaTYb
         /XpdkVOYxPlCy5Hh5ckPne4K9RTQ6oB5Q49k2LJtc5iINsM5MiJqTwS8ThhXGuJGEa4u
         0mGgRfqzjTRIYFq+oAt8MCoi/hdcNpjBBvm8NXuKaINbSjPfCZDUy1MphtLBjux8I01M
         rxJN2WvRpPvUBpk6LRGFgZ+hOcvIr4raPVL8N2lD41xeTxIzoXubrgNN8LRbfPRvNhU8
         W1m5O1dCgbC7podjF26RxgJAyOcZo1xqyzuJxCCBpcszLSRUUvGtJKPrGrq+5y25evbw
         WGBw==
X-Forwarded-Encrypted: i=1; AJvYcCXoe7dYj9lv41w3EdDLAtVhUNdMiYEPsZESAc/4lpCDefs016MX9BslG+UGqE1wblnsvzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtZSVeR0V2MisqPQ2ZU69fioQPEBLYoJjq3DKYm2ESfUqspwo7
	VYk4QZZNo/NqKrMXp9WHyKFLn/mvF0Dcl3CflaUEv3+1+4r7TeLUZpKfs8d22GwSVTAVoBkTJHu
	cK8p8oJzq0pBqX2+1bcihSGNcS2Q=
X-Gm-Gg: ASbGncu+HsHR+kgLz48SKPz/mNF5GDXwqVr4xJe0VpsG4i97Gm3GpopNyIxy0pTbXDa
	gv03k8CeHa31aPdaqV+8Dsfl6XPD9J8cVe4nleaym6kzK39DtXqm0dwOul49zsJZCW61jRibGg1
	4VMYqEzm8IFk9PAlSXlcG5li+rR57lTYE=
X-Google-Smtp-Source: AGHT+IH4ShJuLffadEHgRtLuOkaL/0nuJ/HNjvkG+cvpSJm37ZVi6EvmsHuFUnZCvilasvruSdZzIMrDntyhpLbHPAY=
X-Received: by 2002:a05:6122:1783:b0:51f:3e67:75df with SMTP id
 71dfb90a1353d-52067cd3575mr1999036e0c.10.1739363817516; Wed, 12 Feb 2025
 04:36:57 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Feb 2025 12:36:56 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <786eef7b-94e5-4f92-a82c-aeea69b5c103@gmail.com>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
 <4beb0359-763d-425d-b416-ac40bda59e2e@gmail.com> <786eef7b-94e5-4f92-a82c-aeea69b5c103@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Feb 2025 12:36:56 +0000
X-Gm-Features: AWEUYZn5Ed2eTQ5OCoR2Pn4orZLCOdL5gAOHtx_IcQ7yu0CdQ9geMdeEF3HcYw8
Message-ID: <CAOLa=ZREofXJnyFEzQLoAKk-A1_==wqBy3YyCCgLeXT8qhdGHg@mail.gmail.com>
Subject: Re: [PATCH 0/6] refs: introduce support for partial reference transactions
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="0000000000007a9245062df1325e"

--0000000000007a9245062df1325e
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 11/02/2025 17:03, Phillip Wood wrote:
>> On 07/02/2025 07:34, Karthik Nayak wrote:
>  >
>>> This series introduces support for partial reference transactions,
>>> allowing individual reference updates to fail while letting others
>>> proceed.
>
> Thinking about this some more it is possible to skip the checking the
> current value of the ref so what is making the transaction fail? Is it
> D/F conflicts or something else?
>

It could be a multitude of issues, to name a some:
  - D/F conflicts
  - Unexpected old oid/target
  - dangling symrefs

So this gives a hatch to partially commit parts of a transaction while
also notifying the user about parts which failed.

> Best Wishes
>
> Phillip

--0000000000007a9245062df1325e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d1a2c54f0898f11d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lc2xlY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNlREQy8wU3ZuTmZ2YnMweEQyK1VRTUhHcjlPSVA1NQpPblUySXVNRkZk
STl5V1hDckxwUEQvazVFMWJBdXBGYTZPa1djb3lZcSs0WDYrWjduREtjQnJHNXdWckhrK2g5Ckxp
TXlkM292MzJoVHB4b2ozOVhwcDFjYjJnV01GamErTFgxVktTbjFxZGdpMjdnbGFKVVJ0R1A3bUpq
UWJLemcKMlZSWjIwQzNmVHJRdllVWE5GRnFpTG91Y0R2bFhPWTZxbjRxcnVxbVV1ckNuTDA3Zk91
QmQxVTVHcythUlBaRwp3UXZpTTRYV3pXNnlMcVYxOUZyNXBxNVBzT3dpQXNBaTBsdmpPMk0veWQz
eVUvMVRROC9wL01RTGdiTUcvak5QCmN0RW9TVDZvNmthOHc1YUpDRzd0SW1DTXVsd0tkQWphWk5k
aEkyM2M4ZDA1Z0ExYjFOWVphSVpFMXZOSkRHTjMKUmJXY1diM21SUnJxWm0yeUJLYWlyK0hBUWFV
Q2RhaTFrMDBnZ2VyaEVsQkFBZ1BnVmNYeUlYZlZNaC9JMCtaSgpBa1YwZEtVd2EzSDZHdGJqT1o4
ZnoxbDZBWEdqcnpmUDlYaEFIT0w3MkpERlFDZHg0WVdHblBUblZ2a3BHWHp4CmdQaDBQRllHRnM4
Y1BVK2YvRndsSkFOQTMwL2h6ZlZOZjFvVHljWT0KPXZJUmQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007a9245062df1325e--
