Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F86B5A0E3
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712053170; cv=none; b=YSp7g+6gbItpKgYf2Uf7ldJA8kNwUsr4h97hI8KcKXcQtKnq9Bw4yBLjnT8zDsyXAR7mRF5UfsJUu4eNW3Clz+bMxY5iF5hXp+hpqncvgbd/go1Af3osVhsFI0SLpgGsK+mhN4pb8zx4YYxXff6CvlCxpoL+TOVQ9/lxHQGR5eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712053170; c=relaxed/simple;
	bh=ep3NcUmej5ewstWtU6PoY+sMWRYXSReF+PB8k8GOmGw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=tq1tUB5Sty18xTJvFsxFD1ht1HfKyKRC5M62/01eM3iz8a56C6IuOkdhUd2MnlBgZnFAUV8far2TdyelUVoO3zOetXaeD/wxI7IHvITvCVX16xHyCQVN5wnNgx/8P+YRJapJiKFbvOTiaiTbs61P9UoTCKcwrzOV858+zsM6fOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnOCtC0E; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnOCtC0E"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6f4ad4c57so3977719b3a.2
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 03:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712053169; x=1712657969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ep3NcUmej5ewstWtU6PoY+sMWRYXSReF+PB8k8GOmGw=;
        b=SnOCtC0EHb4xjzfhpMF/rqgt6F0ffNPYJmKBFLHTF72iAHicOdJ29fnClvXPW7dOr0
         hDW1yMYmQviqv/Nu9WHKoyqlRTGWaX+65iitXGqHfVyWuF54dwgZvfFdgdGqmGFMo6e6
         4hAkBe9kdt0hg9OyjRtvi0SapZpj+gwoO4KiZRF65Q+x1da0GmY0wOgszD0rPtN6k/pi
         F9rjNHrD98pYzFcgDUgyXEhFWaPHIJaHFqOHAuvyW++r2e9SrlSBKxWByfksjGu9IM8O
         wBVG8QPDnPDXWvwJLAKbn9IFbSEqHSZ2KX/yJ0C/tw2HnTt5dhZVBuWOv2hl7zP63SCg
         mylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712053169; x=1712657969;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ep3NcUmej5ewstWtU6PoY+sMWRYXSReF+PB8k8GOmGw=;
        b=Hir/nVGzaEH7ebxv6bR34eOM46vra0TBH5/yUCQ55a16ZFtc7pVv88F6BKcuXiaQv7
         ximSUKwhK3nz+0jd3bNhuZSqYS/j9iVXH1ZX3CcGparSrp61xENp445ZwJEuPNXkAWrf
         YxtIcXqT/LXgLdn784mnBkL8pW3O+HtMDbGG4UQ/oy/e5y29zsQmu8QbbgM52pYWem1F
         uyAE8/RyVzNLh99zNHeizZ57jQ1iLdCPhzqkDA7nOVg/e+Nyi5yOCReHJHDda+jFKngz
         rxaWoyl5PgpUqXHn4RYR0HN4fEDrih6lZEpBHyfK1VZxOy3fC18RdYhNOtnErah16BEZ
         9SGw==
X-Forwarded-Encrypted: i=1; AJvYcCX+Pm5jL4c5tOM96dLsqjsKc6GMxiMpqRTU5Cq3oKaDUZ+KJgY6Ivm/RJG5Vy0OQ4jrYF6yAkAWifjUpjHmi1dOsKw4
X-Gm-Message-State: AOJu0YxAUaBOAg91yYdaec6iRPVxSteYhL2UwFjggI3L2JdS/Kg2WKOD
	c1PLiOvZOVuXjWg7hvvAHenrPaBuHLQ+azLY+xmy1Pgi37MEkmQJUh3NOru+
X-Google-Smtp-Source: AGHT+IGlVoTYGQc53EQZJJ4Ii6sNFUT5GjM0hZ/vF+wIWtBTvspm7l+vxL6Cr3gh1Jw4j/rIgmGehA==
X-Received: by 2002:a05:6a21:329b:b0:1a5:6e7a:a757 with SMTP id yt27-20020a056a21329b00b001a56e7aa757mr14717956pzb.4.1712053168765;
        Tue, 02 Apr 2024 03:19:28 -0700 (PDT)
Received: from ?IPv6:::1? ([2401:4900:4ac6:153f:adcf:d625:7af0:7f30])
        by smtp.gmail.com with ESMTPSA id ln13-20020a056a003ccd00b006eaf3fd91a1sm6198347pfb.62.2024.04.02.03.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 03:19:28 -0700 (PDT)
Date: Tue, 02 Apr 2024 15:49:22 +0530
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Sanchit Jindal <sanchit1053@gmail.com>
CC: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 christian.couder@gmail.com
Subject: =?US-ASCII?Q?Re=3A_Fwd=3A_=5BGSOC=5D=5BProposal=5D_Move_exist?=
 =?US-ASCII?Q?ing_tests_to_a_unit_testing_framework?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAN7Jk_2ZQarqVHVCk6=AoUR3sQTFQrK7dfdETwpJvvrdxK6YdQ@mail.gmail.com>
References: <CAN7Jk_2mMiVjXuF02S14OX6Rjq2jVjNxcUbZvTqhcz_YMnD=gg@mail.gmail.com> <CAN7Jk_0hyjx39rrO1PKbEcJQXLtCYkWP7A4mCv01DZu2ffGHyw@mail.gmail.com> <ZgUdKU5uynGrJ33f@tanuki> <CAN7Jk_3Y+Ls2VjhQqzA3Ymy-WDv8nT+v5bzU2a1YGz+j89vPgw@mail.gmail.com> <CA+ARAtq85UYD0_XxPPu2QnWQ5gjpSMrXkTO48DOYkfu5h_1NhQ@mail.gmail.com> <CAN7Jk_2ZQarqVHVCk6=AoUR3sQTFQrK7dfdETwpJvvrdxK6YdQ@mail.gmail.com>
Message-ID: <5B9638BA-7A10-4FBC-AD9B-7C00ABCD4764@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sanchit,


On 2 April 2024 2:20:02 pm IST, Sanchit Jindal <sanchit1053@gmail=2Ecom> w=
rote:
>On Tue, 2 Apr 2024 at 11:46, Kaartic Sivaraam
><kaartic=2Esivaraam@gmail=2Ecom> wrote:
>
>I'm confident that I will be able to dedicate ample time to the
>project, with the exception of a few days in July-August due to my
>graduation ceremony
>I'm open to changing it to a large project if it is required=2E
>

Sure=2E Kindly change the same in the GSoC portal as soon as possible=2E

Best,
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
