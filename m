Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9D42367B8
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 03:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751945682; cv=none; b=s1ffW3vw86JO3w0sFs554s+2zmzduMq9KsGIItYjAnKjuAY2ABVmltBTqIcFQ9FDE/ZQtFu9egsKLnnT4lJvjWL5D5cf2GqHnrXxKeMIMwkZq9OEUSqBY8MoHXfdrbDKWj8ofPtxx/JmNhQamNI/OPz/ZUk5L9YeBJYBFVogXbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751945682; c=relaxed/simple;
	bh=tL2V8tx9fvOeL+xfUB2rJNOysm+tF8k9UX/i09aJ7VI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQnkeepuEJll4eJhuQ6oCuOEmB6JU+JB0EcFuEbL2rpwrI1gOqZLi0013wQ2LLSK7R/2CGqbUU8jZoOzHh5F2XQoHpHtcxdp3CYZrA79wFDwJo8iS7sNM47l2LT8r3lpF2cn1d/LqBsWoZp2HhiBlsPd8EvfQMPx4U8jxm/2sY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfnzCQjN; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfnzCQjN"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ade76b8356cso705967366b.2
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 20:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751945679; x=1752550479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMj92tNiTNuygLvQNviqxj//2qDE2omMTESlQ49t0Xw=;
        b=YfnzCQjNA9TJkbYP6pXbFc0FteL1M9i/kdgssPlvzr19rvn6FY6Cby7USZozIkid1U
         ewHlqndUKdtrVMEey2mPmS5FMDBw8Zn+5wFODlwk/nlulpI4Fre3WahHRvgiHHLM7anj
         wHwJTtD5+9aqUbgayv56LYYh0vejVMqwKXM4v32Mw1Nwd2i+ea7/tPKD5eOHs7PCOaM0
         R/bSFtYEV4Mf6isFRlPr3qMaaXVc9g+c+8TSPOlSXS63ckF4m5ADOu0a8VR+UGjHJdDU
         V9SOtluJKBWQF0ruI4OHr2U8jYNJjD7D5v3PNkszWp3915wvPDdvn0Mk/U4uu9DZna43
         1uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751945679; x=1752550479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMj92tNiTNuygLvQNviqxj//2qDE2omMTESlQ49t0Xw=;
        b=NcXdOws7UKUDPkH6aKdzFPw29aoggIIGZKSxguak7qX9p+AHVtWzqh7W9GyKRcgmT3
         RfvqQhrEWGeOALnlpTT5sHB+/PiKFxWDPOMd7IwXwFwocAe8kaQCU232stSuerdz52jQ
         QeXnwS48Xp9s2G9cNyG2x5XjYkshUA85KK/KDXSxAd5aWhJbNuOr9lp1mkN+C/a7DnSh
         tgWc4y0km/lPo102rPq0lT6IEHm/74geKjfEMf92FuowGkA0mt7jvq8X2YaLlR0tzoLb
         MnWhZpYRLnRYSVF2+pg84ru/qztzpf1PhffeYT34DwR2f7oOoWY8VYbDjv3fbR4Ylcv2
         gTvA==
X-Gm-Message-State: AOJu0YyLzPJXE79+cL9CtgSbYvi/j+204ZWnKZRzlwzR2DNTgDl3utPD
	5mL2nXmaQaBCnuYfSoqN+XfTCWgUYIFP+kBaTByT2yTB/V/3Qb1PW7+zNo9acngi7dhBCbMelTU
	uKVYKxwZK5a9Uv4OHKte30UJ2u1rX3uw=
X-Gm-Gg: ASbGncs5UC4AnnUkmzQjQsDykQuq2aCIGr0RoTbxZL/uC3VCxvrE5Rbjbxka0jVrqm9
	2Ig1rWxtB9uY7d44FwG7kmDECEm21Mizeof4AOoZ1j9nAHUq113hNOtUsI8UEMkqqHAJgZvyJfC
	ib8C3n2uh8R1B3nh/OZnz+a33W86S6FyNKMhjRYU5D/KQJ7QcXg9fOzlDv38O9oqqnguEOicL/P
	YERHtoRXML5RckE
X-Google-Smtp-Source: AGHT+IFrwnh/YOMcsrV4cehNyZyniUBkGmTFLUcu1WzwNsZwIgqeYNtWK/73Mm5K7kes/vimuZzeaL8IeSXtAbqCL+Q=
X-Received: by 2002:a17:907:f486:b0:ade:42a7:dad2 with SMTP id
 a640c23a62f3a-ae3fbd87488mr1509965566b.33.1751945678640; Mon, 07 Jul 2025
 20:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611134506.2975856-1-christian.couder@gmail.com>
 <20250625125055.1375596-1-christian.couder@gmail.com> <xmqqzfdf1ve9.fsf@gitster.g>
In-Reply-To: <xmqqzfdf1ve9.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 8 Jul 2025 05:34:26 +0200
X-Gm-Features: Ac12FXzIKL08W90y9uJB_Plm_0v4YPghp2WG1e93Ncp9_Ol2xBlsU2wMJcUoOmU
Message-ID: <CAP8UFD1GKjcV=-4SdWSPSe737ghJ9G3=CyTLX1=UodxqWY-USQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Make the "promisor-remote" capability support more fields
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 12:35=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:

> The topic saw only a few comments in this last iteration.  Would we
> be seeing a hopefully small and final update to tie the loose ends
> before we declare that the topic is ready for 'next'?

Yeah, I am planning to work on a small update soon.

Thanks.
