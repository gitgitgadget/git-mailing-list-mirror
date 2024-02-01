Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D67E12FB09
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811999; cv=none; b=aoQYmfM9V1K7w5rigcFQKBRRD0pqCAGEDDWKRIJSpxFZGaNlb4bA9/ljOah7x78gGO8GlPY253gbRpnU2HlrVtw2Kmfv+iXpSdWm+f66+FDf1Jw0dipipFEeRS1aAPJT0OWshdwGbXwdhDforFpl1RyNEJfeWHcTxl+EV7/wU9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811999; c=relaxed/simple;
	bh=Kq5ptSDBudvae8Vc6kEKFaYYFZ5mpHVgDZUs6OCKcYw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eqwcXoU8lLp7QekJ62mcap4xdEuSqb2JpKHuH1xvxFHdKXxPx/NBVGgykQl9K0z6brkrSgVJHPISNUBG+QUj3Me3Tw/nQW0VIsYDd2mqdAFKGf9tDlSFH+DXtjbe5QJxrYav98Ye0meBpihKRmNJQ8jZICZKVjxsjTjbOHBQU60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W8273Yi1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W8273Yi1"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60403a678f2so21228637b3.3
        for <git@vger.kernel.org>; Thu, 01 Feb 2024 10:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706811997; x=1707416797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p22JWUIqWO92jLx8C5F3FYeZQkdlR2RJ+HmEUfnRZG4=;
        b=W8273Yi1f7DmsNpvZYf6lSw8iIbljXdpZbStLtYDekcoyEHmxpxP3rxNvMPlQEzxcC
         DOT5dhKSfJBuX/b+xzauVFiY+TSZZHEoB7rdPpKRWM6mFaVAKpxJXobcLhKSI9DPptXU
         dj81/Wcu3Y/wioRZnUYm7qooXNouXAYFjm+9drcHjTH/j87C37sKpKaTw24JLioy7HWO
         DTAYm5qIWc9y0/S574GAYYx1lES51Yj8GzPL54GHRWouoAbo3KON0QOtqC68RJf0oWUL
         oz4RM/nnt792uYqHBE1ww0IXUQ8FwGk401z650XMOPyp/7m3mCPVIabz7La8VSamsCcS
         Th6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706811997; x=1707416797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p22JWUIqWO92jLx8C5F3FYeZQkdlR2RJ+HmEUfnRZG4=;
        b=WggxmsC5FbYfWyjWSK9yUNOcX7oo2vyJ55j8GiJcwm5YO7F05eKmVGl3Ji16cCHR/A
         4B3iRFWvWZN1zP9mCSM/EN6x6JY1DNYRKo66/RYDsFMb/MIfzbbZjGtDyPVxh/QrT0mR
         xRCsifKY8KqVO9xgMS/yjnpc0Pr8X+NchS7PqXBbBZaljl1gAADi0MGU3GaMPB63Cp3D
         EesQZUQui9PmUc/oQNpJbhSfCj/8MpbQNOKLs4NX4jnnsPqkuWTBsPoXapcgcdncmbUy
         l0+AVC/EWccWx7oVA25qvjtsOkI1akKyc5+QsjZt/WmWFFu+QG6ALDurUvvefqW9/y8W
         IMTg==
X-Gm-Message-State: AOJu0Yw5LLC3FGVKh6jMbN1aNdxRrlohfui2Kdwvx5SK6W0Y77XjAqx+
	+SS0gFpGQU3D3iMI5EywsW2hzoIxgxBI/uko/iUtHRyXIheJqxUjRtls8oUjJgSegTeWqMkwop/
	crQ==
X-Google-Smtp-Source: AGHT+IEWFYJYEu4IbIlc3e6Gu2h8XjUlIqtFvi9LWaE1l341e9bexbeMmh8OtZ6Xb8+NnjdDd+srb3B3guY=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:118f:b0:dc6:e743:6e2 with SMTP id
 m15-20020a056902118f00b00dc6e74306e2mr156578ybu.11.1706811997032; Thu, 01 Feb
 2024 10:26:37 -0800 (PST)
Date: Thu, 01 Feb 2024 10:26:35 -0800
In-Reply-To: <xmqqfryd2drm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
 <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com> <5c7a2354df0f4a29841f9ab8294ead0e1c3b9cf5.1706664145.git.gitgitgadget@gmail.com>
 <xmqqy1c545y0.fsf@gitster.g> <xmqqa5ol409k.fsf@gitster.g> <owlyv879106s.fsf@fine.c.googlers.com>
 <xmqqfryd2drm.fsf@gitster.g>
Message-ID: <owlyo7d011no.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 03/10] trailer: unify trailer formatting machinery
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Linus Arver <linusa@google.com> writes:
>
>> I could just grow this series with another ~22 patches to include those
>> additional refactors, but I am hesitant about doing so, simply due to
>> the sheer number of them.
>
> I actually do not mind at all if you started with a preliminary
> clean-up series, and stopped the first batch somewhere in the middle
> of the 20+ patches before even reaching any of these 10 patches we
> see here, if that gives us a readable set of bite-sized changes that
> prepare a solid foundation to rebuild things on top.  I am having a
> feeling that not even a single person has reviewed them on list even
> though we are already at the third iteration, which is quite
> frustrating (and I would imagine that it would be frustrating for
> you, too), and I suspect that the step like [v3 03/10] that makes
> too large a change with too little explanation (and perhaps a bit of
> "trust me, this does not change the behaviour") is one contributing
> factor why people are afraid of touching it.

I am planning to spend today trying to break up this patch into smaller
preparatory chunks that still end up at the same state as this patch.

Will post another update on how this goes by EOD. Thanks.
