Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E402F19F421
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 07:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736407327; cv=none; b=Zgld/bm/hSVSHakBiZINkQxd3dbbbLPVeiYCAW9KxUmQhKEomEU7a7NzC6QS6VhPEJPdMrhhY5J807Ar1kOYhnEzI7oKv9QjLE1Fj7i60emWt0fZIpb0InjgD/2cKk6ogL8uMewUEFxH56GvRYEdm7oRHmi/kSsInFp0t6dmvjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736407327; c=relaxed/simple;
	bh=7QAhNBF3qAVVG8didOgfqMDCEz5i4SU9BZ6UT1t7C6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=byOo8Geam35wQuQN/9reoyXFfNhiAnXopyF9GP/2pNoaz84Q/w6dKoAaSmYAiMu1x03npNIFtbHkYlD2EOQlxl4Uot6vGp+7LfrpfDJWMC/59vOrXTyRCfF9c5lgh0bguTD5IeH3yXK3M93CghrSk1s6pC+8av+BN8sfAhwAEhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rej40VHU; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rej40VHU"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e46ac799015so739130276.0
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 23:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736407325; x=1737012125; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7QAhNBF3qAVVG8didOgfqMDCEz5i4SU9BZ6UT1t7C6I=;
        b=Rej40VHU9xR0GCapZhpbULbS2f8D3Z2a+rqiIXh75XTIyjKFdNmT6r8BQncnio1cCL
         +IR/fvC3vJe+XC703PVG73pRoJWj4gk867taWVbp3oiuaVif0kqLNGyBXq1DnL+LonJ6
         wVtWNm5jNUKCJ41kVzoKfw1X4EUkpT0QZyKPCJJUGcq+OiR6hbP/+LBVnYRcLqnuQvsM
         UwBz0FaEGjYGjxH2xj1sq2qLybW4BRFjYNxxtWsAmMAcYFyZpDwDvvSu/DKtK5FUh6Vn
         qDPkQrnikr2GXG/kW+WdkGI3xCibhw+dl+P9CY9P1U1BFwSl4P3OUi7S1e67GKIjPhE2
         vU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736407325; x=1737012125;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7QAhNBF3qAVVG8didOgfqMDCEz5i4SU9BZ6UT1t7C6I=;
        b=BS4YsWEVLi7m9wuDVoQ/EViaSc7KQa1yt+aTDtcacMv3fiCmSOyI2R9i0h96AjM4dW
         vX2hhiaNw8Z6qnVXYu4/lDgxfjSTNCpE8N2eV3/ug6j3ewP4W5Nr6yzJ4KUtkP1wkK2F
         DwLgMN5j6yQbkka+rB6QtgAqCUPXJNWGWO5THC7ABDiVwuXRl5ZbKcFTGe38SlWuffbF
         MxYcMIIiBxllD6oDW25lr6ZYSNnPoIKRXfhGfWYEP+im3TsGJ7XRKE6TIUiEvTKv2XBP
         yf9n/0376UnDU+57e3z3yRdFirW55VfrD1rG9v9xZTMhUkY5Ckk3BJXuxCrOB+cnL05t
         lnHg==
X-Gm-Message-State: AOJu0YzdDCOW52xcEjbxp8MrxMicoZxh2qNT2WXz4iYiu+u5EgAoCN4c
	5bP/yfnz+yar5X5Cqs66+Q0+MaFN9UKB3GGTZ0c8Lrf0bZ1VzxzgBEJipNoQjVSPlm3B+XBRpHX
	20uewfYs9liw62BpdoiQvBzy2tn8=
X-Gm-Gg: ASbGncusCZuuk2VKC/lNG2gpDhxkBSZ/Qw59oq0KOaCnldrNbWWZoTsDLelWYc3OZqx
	uJW5eobuxTJc+apnpOY4+FS5WUh8FaGr8qXBt
X-Google-Smtp-Source: AGHT+IH9K4bGCy5ckfMoeQnGj3zfSjHvrZ/CJtLvZxh3uzc0K72R96f3LBScZoKHbXjGftepzlLrTbFeaqX8wJHGRm8=
X-Received: by 2002:a05:6902:983:b0:e4e:95b3:4fef with SMTP id
 3f1490d57ef6-e54edf2c899mr4666974276.16.1736407324877; Wed, 08 Jan 2025
 23:22:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107091932.126673-1-kuforiji98@gmail.com> <20250108120339.225596-1-kuforiji98@gmail.com>
 <xmqq8qrlpbnx.fsf@gitster.g>
In-Reply-To: <xmqq8qrlpbnx.fsf@gitster.g>
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Thu, 9 Jan 2025 08:21:50 +0100
X-Gm-Features: AbW1kvYF7FD0fSFw-09U00nDQPIoY6sfXIf-rA7DyftTd8yQGWeVloRZcKrs1qQ
Message-ID: <CAGedMtdJgM+vRryKLz5BKuQSBreHOc+q=rexciPB2WZ4aT3=YQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] t/unit-tests: convert hash to use clar test framework
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jan 2025 at 16:28, Junio C Hamano <gitster@pobox.com> wrote:
>
> Seyi Kuforiji <kuforiji98@gmail.com> writes:
>
> > Hello,
> >
> > This small patch series transitions the existing unit test file t-hash.c
> > to the Clar testing framework. This change is part of our ongoing effort
> > to standardize our testing approach and enhance maintainability.
>
> Thanks; this is no longer a series but a single patch ;-)

You're absolutely right.Thank you for pointing that out :), I'll make
sure to update my phrasing in future submissions.

Thanks
Seyi
