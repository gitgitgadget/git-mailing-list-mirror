Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5117E63518
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706026852; cv=none; b=k150QaS1ylQmfzljcitrHxsQVIUti6B5lBdZx9sLqCjDIOrWXyRZxysTTA0hFdaqy/+xdw1AtESNgYXsKs3ls4yBpwsPxUzAmQyAUhaO6ErViGKerBO3m3ZmS3qkNGvxagDVXU7+E4jwKlzSHlgdOR3SIDndzDSqKneLt8BQdkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706026852; c=relaxed/simple;
	bh=3ezCIALA6e4/8khHqNGcEB44JdY1t89Su1jMzAqacuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQQblYGzOmOP13W/9bUWBVreKNM94G2PIDv6Ndns7Ns4a8LLXm9OkU6sRh0XTxFodlEwfFQ05/UV5kfFe0u6QM14Av4ElU1uLcRegMDxkeNRUVcqbuyVYO0/7c18x+tHZWMIdk+ozVjTbegAB/6yFF4Tvzr0skNiehsJksvF6yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/73hWt2; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/73hWt2"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50ea9daac4cso4869320e87.3
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 08:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706026849; x=1706631649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zc1kYpFkUTPSLSEut6Bc7R9gXBkgyBGYOAW3cj9lQLs=;
        b=a/73hWt2ApWz/Y2IX9MCZuG/2xViQyBoWox5g/FWrV7wL6OidMnhBBRMbA4iumtzf3
         N5qLjE85PtkHAJcX2BbJUKKQW4CcLrHB8mNJo2CvrYAMOuNxLpOnD5H0w/RA9ltwZsAh
         ZUpVm6+C0VpZjoOuXqIkQGduowEQLLLH4NltLuI43r2Kx/OnUnD17esVLbmzhz1sTBEj
         e2UJtJOhnisOOY+SZ6lhRdJtFykgxI1KRFjvfsX5FutGgWTKoOgAROynqBsD54z8P4yi
         ZW+a/NSKPSMHTsfhFs6oETYGO6CmE2X6oLdVbozEPLt8jG01qcWJIgYoHQumtQkELbBL
         Gdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706026849; x=1706631649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zc1kYpFkUTPSLSEut6Bc7R9gXBkgyBGYOAW3cj9lQLs=;
        b=Gfm4sZY1OK5n2672jmZI+sS3hzk4J3cG9drZ/WxqWmrRBZOydxHadIn7O1wlRLCGiE
         WcoWjrUzgRwIm8/IpIaElR1DbFAJ6SRzaNKbRUbAgRdck0Q7CWWC1wyJ3fLJ5qPt1w6f
         S90pCdyZMvhPZCtTavUiQbAUnlpWkyrp1LP4KUNo2D8CR9I7KPlcYB1x+73hGXy/82PW
         BQj+UPdAUTU0bQ044BxlhblIAxr00uVRhCa7pEXX7xMjokChiPFCjB4LhwzmF2VCdx3/
         R2gjvxmYh/W60vSF6gAdXDRoDLoNjPnjDUrY1TE0UvP2UF7ghIdNZupJBVIHjrdTp3Wc
         iLKg==
X-Gm-Message-State: AOJu0YwxOgqSybwrGjGw1+H7Nul3J37YjOWsvTyF1nhgBVQOBfG4ZzCq
	6XmRE4EvC6RKms1RB9IAfkQFril4Sg6TvHjrcDvkDvdccCuKgVCIlFczhkxPHuhXpyiMPzBxa4S
	ZCp7mP6moSZcXYFrd20e4qIETJqn0xtsB
X-Google-Smtp-Source: AGHT+IHwEY7x1ZQXGIRK7oLKvmnoQ/QgXMFNO3melYyzG0o9ii5xgS5HgpltwvYZFL0KAMxTxXxHXVoMBIBCEjR9Adg=
X-Received: by 2002:a05:6512:551:b0:50e:3e13:e142 with SMTP id
 h17-20020a056512055100b0050e3e13e142mr2892821lfl.118.1706026848976; Tue, 23
 Jan 2024 08:20:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704802213.git.ps@pks.im> <cover.1704877233.git.ps@pks.im>
In-Reply-To: <cover.1704877233.git.ps@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 23 Jan 2024 17:20:37 +0100
Message-ID: <CAP8UFD3orZNdaxUUxQTa6ZHDQtZLdmWvf9y0GGgaQadw1zoJUw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] t: mark "files"-backend specific tests
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 10, 2024 at 10:01=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:

> Patrick Steinhardt (6):
>   t1300: make tests more robust with non-default ref backends
>   t1301: mark test for `core.sharedRepository` as reffiles specific
>   t1302: make tests more robust with new extensions
>   t1419: mark test suite as files-backend specific
>   t5526: break test submodule differently
>   t: mark tests regarding git-pack-refs(1) to be backend specific

I took a look at these 6 patches and only had comments for patches 1/6
and 3/6 so I replied only to those. The rest looks good to me.

Thanks!
