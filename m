Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CC23F9D9
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559775; cv=none; b=hMWqdfLN3ZKPyZTEwLZfelz45q48kkAZIMloBK4UFRIZV0dupZEX9EURGWNDaHPrrcV3Fakc/eJfnGnkmVi6MgBm2GVnW6hcKq+kwvyxQLtoEs37Esfl5wEX7ZKXPRpHGEb4Nw4C5Tu0JcM015WLKMUskcSH8y98kZKvbYbf4KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559775; c=relaxed/simple;
	bh=63r6+p31LOQp8Nac0YwPwbT7m2UaUijcke8wb8n3B1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwmiXUnM358EBs3wcpBZ0KAoRVggN2YpCisvXc9iYrz4Y4wvuw6PvC5sP6euwjNHxecqSOWz7D5tBEVmZXg21BPRP8ehgDi8+gdzi15zAdFw9PciPD3EyciuLidze9tFQ48UyPMtXXXqTV+BiKHlWRLtq5noZMS7gSrdDOk821w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPcm5YQL; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPcm5YQL"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a26fa294e56so770097766b.0
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 05:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709559772; x=1710164572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63r6+p31LOQp8Nac0YwPwbT7m2UaUijcke8wb8n3B1g=;
        b=VPcm5YQLC7F6SMi1Lni8BdsrZfpkkizVGPVlycxAHZCYWqeDb+YsVfttsomOMljghy
         xrCIi3R54iqLG7FMvCE+TdRe50hDVRoEBG8+7/8nShJviyKLy9Li/7OlmBDXEkc2N0gr
         MDDBykcUWtH8VKZH28bohXBlfeL4WlO2z4O2I8uvt8bS35ru2xDzKbbfRc6k1uGz2vv4
         knTzxGKrmi6Kq7DHhA5k4FzlYdpEzPZvoHwCIIAyBE7h1L7+MJ7WNq7xreksEm6ggjOf
         kZAgPepvU8fOBVxrkU4JTZfWe+2bOYG+8FvS4XQEKKJaESeeszSVcLLCg5ls6Jnay5Q2
         HM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709559772; x=1710164572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63r6+p31LOQp8Nac0YwPwbT7m2UaUijcke8wb8n3B1g=;
        b=q+AayHnGdDK738o/R7k5SgjfLf/x61BE8PZaiNuvZ0IISbXT+m+0nrddYYGIODqmb7
         3QKCOCL6NXEz7IhxFzQiUhIsKcyiPLcjrU4QuYuKAxuRMolpOlgm87D5IulteZr9fePn
         kDaqMuHx7uTUBfi8diybnjIdc33wK/vJVWHJmzXMbre6WXh3m919yyinIxMl4XNcmZcS
         MW6PM/UUVolMpx2QrWNbC8ctflyf5YGLDCo3Sxl1NLXw3nrsLXx7qxY+kbw67js4pW6r
         rGmI1j7wNTyGuwkt6NL7r/bFqPL9SEXIsodSTOMWzZSUkdgKrRmUd8/HKhwYJeNffWiu
         cpIA==
X-Forwarded-Encrypted: i=1; AJvYcCWs4jDlapyrMTrWnscmdAr3oN1oCV8HksCuihTjB0HqHU4KOiFcjIhn6nF/BOlkUzmOClnd3AofT5yohwStEfW8AyKk
X-Gm-Message-State: AOJu0YzUVjPIZYTVC8qLpCjNZYaHR0e9kmVAAeVXJZWDt185Bm/R4Cp8
	ihPtYPqP37L3PX49BK/os/zgKezlu1FAs12JeboO6OQG7QxZD227NBpffCbPzXhhSs4auMBH0So
	QmVAvAaSG5iYMbSKf9mYTxvVqwo8=
X-Google-Smtp-Source: AGHT+IEMMKSu30cZ1ZA3c/3rRhOG+1e3lCkpvbl4/cdIDAioBKieQk3BHyG3wt2agKjLGScEssUO/fnYs1gV+aPgry8=
X-Received: by 2002:a17:906:81d4:b0:a45:3792:fac8 with SMTP id
 e20-20020a17090681d400b00a453792fac8mr2109276ejx.25.1709559772451; Mon, 04
 Mar 2024 05:42:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqzfvjf5tq.fsf@gitster.g> <84995a068640c72c8f17406ffa0441c7fdba4bdc.1709543804.git.ps@pks.im>
In-Reply-To: <84995a068640c72c8f17406ffa0441c7fdba4bdc.1709543804.git.ps@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 4 Mar 2024 14:42:40 +0100
Message-ID: <CAP8UFD2Qzw8p5dTjTAjuKaSoHu22LBcJGUf3PG-NaK5CZOX0fw@mail.gmail.com>
Subject: Re: [PATCH] SoC 2024: clarify `test_path_is_*` conversion microproject
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 10:17=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> One of our proposed microprojects is to convert instances of `test -e`
> and related functions to instead use `test_path_exists` or similar. This
> conversion is only feasible when `test -e` is not used as part of a
> control statement, as the replacement is used to _assert_ a condition
> instead of merely testing for it.
>
> Clarify the microproject's description accordingly.

Applied and pushed, thanks!

I wonder if it would be better to create a PR in
https://github.com/git/git.github.io/ and perhaps just send a link to
it, rather than sending patches to the mailing list, as patches on the
mailing list could be mistaken by tools and perhaps people as applying
to the Git code base.
