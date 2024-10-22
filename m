Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522D61B654C
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617091; cv=none; b=ahoCb9oYDw4xAB0pPEPITBs6R0JMwwggV2kK7lZuQp8RBc+EYkuT/jP+Ynk6xnAd3RUD+UKJYVWwdfUYSVNvEtIQmyNYsmeDPVe8y+8Syiq0YvkM7MmlA1vSQ6yco0jf9wFF8SatfzT84wRViUldQOduq0XaA+HVVrdsHH1ARMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617091; c=relaxed/simple;
	bh=O08VBuWRZm9PuEO3/FJSNfxiJqd4Fwr6sflcxtyo9e0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myEVMyZTQJR4dyejD3YiWeJvIqQvhEeI2aQ3D2hoouToOgpOy2mXP8Tx6VU7bxATTfvMBmvhbmUgD9U1YB0lLQTHA+hWfZrtSuO20h7s1Ojyemq6jz2h9umeMyRdUXmW6Y/c115CUu08bgsOr7/Bvxr3Q7cuajgW+gwzj+4IruY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNo9nHIk; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNo9nHIk"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e290d6d286eso4716605276.3
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 10:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729617089; x=1730221889; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O08VBuWRZm9PuEO3/FJSNfxiJqd4Fwr6sflcxtyo9e0=;
        b=DNo9nHIkjg/GaZf1XHyY3zC2v6H9Iqc9Ci8UWXWcysJu8WpE3j3/eh881t8FSMZBer
         TFUaG0i4yauMyEYGDrCz4NfpzMbcoQM4lbUCD0AsAMuhOcuwAJGjw5vYf/QvKNAu1Hsu
         XFzKdsHUI6JqvdA82bh+sK7GZc22tB3id/p6M560V12Nli6ms2UHH9sNKb1w4i9PRj1a
         jcfplzE0uosx0yxHj1x6Ka40nMPdP2DDO3JDH7V38W9azcnkq0CNJxZ8NQdZ+1U/mfZx
         MJ69lN5zjlFIfwQiLRQ6RGb+XqhyNqqG9/lHfEU/gy+aJqZaVZVSXLhTAMpMaB9t08rX
         k8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729617089; x=1730221889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O08VBuWRZm9PuEO3/FJSNfxiJqd4Fwr6sflcxtyo9e0=;
        b=ct0CMdm/9j46Lo175GWSP0VxAMLEOn0sAWbDigjKL1hk03UeUkLD991xNFeEEAtVQy
         MHUJnxY6TBREs0IBg38XpQPvm44PmoCrak2FelVsFkgRmQq8neFf404Jg0ewsp9Hrp+D
         IZithP3MUz79m9/jNOCCU0+NF9DucLckMO/3/uFwfkfSwdqrDJLt6Ig3uy0Z4fPGgU9L
         XUURZeehmEwddPdGK37zUnVwzh4QIDY0Fy+R1nHWH0HMdKwZw5PxQQEEVm0vxcw+Uzj7
         lRl+V1dZ4izzoX0CQbOXIwUs0wFHfiBk7waVNXbtgROWnKIuq//iAkUJISKnBJtqJU9K
         azYA==
X-Forwarded-Encrypted: i=1; AJvYcCVu059mDlRnkBd7sa4LJzkwF9KsZz1uiIKcdApIc7ZEM5JHEDuyBIG66wcmfwcouBMjcQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvmgL3TjV/b2/YLDWcnRRhr9djuqi2pG0u3PPf3f26wH2bVgO/
	BrflynkCjgVBMk7JnOJcCqBbmbFoWtW81KsmgMeei3pFgK1IeVhii38Pz6T6W/ycIHFtTVuEj4B
	CiIUFO0DzbCC2+corR1Mf3SnC7+HfLJSwhMdtqVOd
X-Google-Smtp-Source: AGHT+IHo38bE95eYiBcDTWNJ3ouPIlgrh/rKvyZ7T2vWwlF5pxYyfzZWEmiPxo+hCET/4coC9WeKCf7FyLIxcjSri/o=
X-Received: by 2002:a05:690c:6488:b0:6e2:12e5:35a2 with SMTP id
 00721157ae682-6e7d3a9d0efmr46060157b3.4.1729617089373; Tue, 22 Oct 2024
 10:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019163439.274656-1-kuforiji98@gmail.com> <cb88194a-15d2-4c3d-8768-189853572ac0@app.fastmail.com>
 <ZxZDFyKxTn_D7c3o@pks.im> <CAGedMteMtaOvyE2gX59bMudEUmCZw7nOh=MuDRi=7CbYm-gBDQ@mail.gmail.com>
 <ZxaySpwA7jg7c1aw@nand.local>
In-Reply-To: <ZxaySpwA7jg7c1aw@nand.local>
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Tue, 22 Oct 2024 18:11:17 +0100
Message-ID: <CAGedMtea3_65wuOc1c548TC1x=ThirB1gC8p6kTomwWf_VzDng@mail.gmail.com>
Subject: Re: [PATCH v2 Outreachy] t7011: ensure no whitespace after redirect
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 20:58, Taylor Blau <me@ttaylorr.com> wrote:
>
> On Mon, Oct 21, 2024 at 06:17:06PM +0100, Seyi Chamber wrote:
> > Yay!
> >
> > Thank you for the feedback @Patrick Steinhardt @Kristoffer Haugsbakk
>
> Thanks, all. Let's start merging this one down.
>
> Thanks,
> Taylor

Thanks, Taylor!

I've also discovered that the test script t9101-git-svn-props.sh also
requires the same update done in this patch.
Is this test script currently being worked on? @Patrick Steinhardt

Thanks
Seyi
