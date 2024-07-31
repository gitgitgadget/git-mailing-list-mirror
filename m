Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372101CF93
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 09:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417164; cv=none; b=tLqpLJlChh7CXWamuXD6sIUGCp5oSEamPMe1icgkLuessl/izikLBGtLUouiTX7c16hXxsLDQlfRsLdT/CGhd6gaV9XCDqBb6IIauTc85Dr6S85SVo3LODrNi6xvn+BaOI6cqdxHfm3x+uCHiK3O4/bwPWJNPgVQgNt2X/gyEss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417164; c=relaxed/simple;
	bh=ytf9v00xn06MDWXcXwiG9ejhO6VdhGIIblLHTGA6q+U=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnDzzhSTy1wzJ8Tqsn80M/YziOX3U3zwiyC9kWFeEMj9KSl2jrwbN101W3hgmiQ2N2qLFadwNYTtyGvpA12Nr3vi5Pe2+xtRfcYadW8VUl1gvWJsbVMs78FjSPsH9dwlItvWrftll83rt3vZgn8fC71LYzO3zCENMVm/XaKS67I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVWtl7xM; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVWtl7xM"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-260fed6c380so3437488fac.1
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 02:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722417162; x=1723021962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=D6D3lFYx3l8/wu7h3srxqjsyG9XopQbNysBcdzLQZko=;
        b=VVWtl7xM2Z+Lj0iqPLpw3sNJXQ08zWdVvq8YzsGaxHDZ2Ws2Vl3dE6PgYZV9wngBlb
         9p1223uGsFOwh/jDWmxZNezHVrRjFS0qshA5whxvoWb+6LVMz82LGDZiLUDSI91A1lYu
         YkWOhspdz+AL/51HQuVwoKqhLwDY6Da5F4mP3zi+HClnIb0KOTunR4BsVllOi4Y4HnCn
         rtxPqlCmeoe6xZWt3OqyrHEZIR1AHnObVT9+63bgCRcA3buWtOq/nkHv5P8hKLjqEYyF
         hNEoLcAx/2rLqSXRnzDGe4b0uuky85x5xvHrnVT6x1w/T63NYliK8MCvnBphJ6UjOxPf
         rPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722417162; x=1723021962;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D6D3lFYx3l8/wu7h3srxqjsyG9XopQbNysBcdzLQZko=;
        b=n2IpO2zuhZr19rJl/mTG1IXt4xZNfj04tzilJsmbWSSMDc4tc3FGp7eqMjS7IDAsOW
         Mw+RllhauTtbqWH+Eb4mJoLe9divtWeZMFavRMyjghL6YuK+9HaFAWV3rSXkwlwgvd41
         8qYBKCHa8nBVvSt12AsRbkX8uemYgu7ouhR0xBJZbGOKk3G64FgLFlNMRsEB8FPPyUhW
         CDBpqeLxFkaY7M7a+sZzyExPJH58BLh9o2HRylpH4PVZgudvOz87nFyWHSxS3jvrqg98
         fDRmRxkhs+sttt4G0h20fuXafsblOsGvjQLCanKmCWoLPtpNaVwQ6IDIYa1jC99WwqBl
         iAVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsFErzd8UGqnsQhrFLuTO+k3zPQ+JJVZ0kMzBwmnmmOeyohMlggplVWdujZai0MbufxaerDtODPsuvIXbgi2eCrlNo
X-Gm-Message-State: AOJu0YzXen6e6BcozdJHWTzaybKy/ElJhko1I2P+RRTaAbLProiQ3nzZ
	j7oN6poAOzGk+D+xp1fNnlFAbiUu97UABrs5Wjz6ThcfI2pLVREfBYitUtHDHpJXgrfXeuLUUPK
	dn/mqcVU83HIrgMdsnPC/qiFdVBM=
X-Google-Smtp-Source: AGHT+IH+YlWDrqo4IqPIPqlu/DEIam5b3ktyifAGsO0ePDxQOojhCxuz89/ii3+C/uarQE67K+pX1maUJbSdZqg7as4=
X-Received: by 2002:a05:6870:e391:b0:260:f50e:9242 with SMTP id
 586e51a60fabf-267d4f5806amr18725048fac.41.1722417162066; Wed, 31 Jul 2024
 02:12:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 31 Jul 2024 05:12:41 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1722323818.git.ps@pks.im>
References: <cover.1721818488.git.ps@pks.im> <cover.1722323818.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 31 Jul 2024 05:12:41 -0400
Message-ID: <CAOLa=ZS1JS5YyguYhyeAeWuv7Sb2tB0ze_5=GyQgRmhmVDNWyw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Documentation: some coding guideline updates
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000019bbd7061e877ff2"

--00000000000019bbd7061e877ff2
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is the second version of my patch series that aims to improve our
> coding guidelines such that we arrive at a more consistent coding style.
>
> Changes compared to v1:
>
>   - Fix clang-format to use a single space to indent preprocessor
>     directives instead of using tabs. Thus, this series is now built
>     with kn/ci-clang-format at 1b8f306612 (ci/style-check: add
>     `RemoveBracesLLVM` in CI job, 2024-07-23) merged into v2.46.0.
>
>   - Adapt the coding guidelines accordingly to also only use a single
>     space for indentation of nested preprocessor directives.
>
>   - Adopt a proposal by Junio to more clearly spell out the relationship
>     between a subsystem `S`, `struct S` and its functions `S_<verb>()`.
>
>   - Document `S_clear()`-style functions. I have adopted the proposal by
>     Junio hear, where `clear = release + init` with the restriction that
>     `S_init()` must not allocate any resources.
>
>   - Add another patch on top that makes variable initializers consistent
>     in our coding guidelines. Our style is to add spaces between the
>     curly brace and the initializers (`struct foo bar = { something };`).
>
> I think I captured everything that came out of the discussion, but
> please let me know in case I misinterpreted or forgot anything.
>
> Thanks!
>

This series seems good. I did a read-through and have no changes to
suggest! I'm really happy with these fixes which slowly improve the
quality of the codebase.

Thanks!

--00000000000019bbd7061e877ff2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3f994903ad2b257a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hcUFBVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOVVDQy93TVRaVWZWSGpTNGFRdFk3U0dZclBqQ3Z6dAp6N1ZiMU1FQVMv
VU9ER0NNSHNLVE4zeTBRQUhXckswem83NHhPSk93a2RyVStqUDlhMmt2Nzg0VEpIZHZ1ZmtqCjM4
Mzd5aU9EZ0l6RXM0LzBENXZocmJGZjdUbStDM01IandRRC8xZ1dDUEh2MzdWMTFRc1B0aURrbys3
d2lQT0UKMFJqL01OT1JRTnUwMENmcisvcHdKMWlsSU5SRVhzSFd4cXE1d0hEK3FJS0ZZSFdhWGtT
ZnBaZnJjZDdpejRZQgpVUSt6NWNicDZ3Q3Z0anl4OElRNGx2d09OUTJ3Q0dlVTB4N1VXSkgrM0Ro
RFZzMGM4QkgrZEJleDVyQVJKYU9ECkpnN3IyRTRUeVNRNDBZVE5zMnlYOHN1bWRtQXIyUlk1YzRa
Z3ArNmtRL3BpZnlqZWZJQzZodEs0bVJ2Y0Uxd1gKVzd2RUVOcDkxVWxGWXFDVVlRT2ZXZXFnZ2Rt
Ly9kMzViZWpRSjhJbnU0Y2grSEswV0ltbitlRmRzdkVtektPOApCUzdmanVEc2lMT3pQcitScFlX
aThhM2x0dkZNellpcFJCcjV0ZDlneEJXd2tUWjR4cTQ2S2t4S3NnR0YzNndaCmhKZkhIczNvdFcx
d1Q2NnFIWFR6NXdDRUJ1MVlubDRsNnpJbXozTT0KPThZNnAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000019bbd7061e877ff2--
