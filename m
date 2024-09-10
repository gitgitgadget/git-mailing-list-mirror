Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152BA1A2567
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 19:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725996391; cv=none; b=C4VC01eKH7TX+k3AsCkMm+J3NtXhjTXSh3WNQlfUajkAX4SKs4C/mffdXPlbJPNufPaEIlnzIfbG5TZtp2nRLaoeHTcm1Rdyr9hNnz9yrZ8FD65cqczflKpqaM0P6VZUhqGEo6/hIazFCGnnBhjbUfV3UlzpEJa8SJzNgcby954=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725996391; c=relaxed/simple;
	bh=AUBnNbnVHlL8Z8WqUWo1qHmvxd3L2oHcjREomoZrMmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9Jmp/LQvPZ2Km7LNwv3ArLHttLBYyznb52AHsrXTxGSY8M5TnMDCJAueJOP0JCh5HYLfCIs+nKnri/J7LoiIedcYD7cViw0qTDDpyjbXtgbFN2N1oTL3yPtYgi+TJlfyE6TGY0KiCcwc2RrU5hjVlCxtGq+RekXYybpuQLOduc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XLlTUlOD; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XLlTUlOD"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c2460e885dso30928a12.0
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 12:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725996388; x=1726601188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUBnNbnVHlL8Z8WqUWo1qHmvxd3L2oHcjREomoZrMmY=;
        b=XLlTUlODZtqOFeEu8awwgbuo3KMS43ostjEwdDSqxXAoiMF4F/ZX6uRKRCG9/QQCsk
         3KIxhIZxXzu9mcJzhARq+hw6Kb3pEt+8ypCWyzjT+BrKynln3nelb2H02fYJKGyS20w3
         /gozmTgfALHbzAiue0L9GoNSSpz6pqRnzrw5Acrr5pQxdu/Y2tUNA0E+Bstv/10sjGPo
         5EuyEWE+J3vPy6KW93q2+VNH1eQL9mr46yLzl7Kme2M/juRUcduGdclvuYpnsvYO+iRO
         oq8+WIG5hToEUhvAf0yUVCxVPRM8JZyryNK0/3E70IaPaB/E1dlyTdAwYw/qOWc5oFHs
         869Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725996388; x=1726601188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUBnNbnVHlL8Z8WqUWo1qHmvxd3L2oHcjREomoZrMmY=;
        b=me/Ugpit3R0wzm23t1Et25AKlGoeX8WNx+wbl5mp0xWLLNTPK0cv+nhEj7u+8pc7l2
         zgY+1t9ZdWnZ83NOB4t13wjYwJaKvKLZ7UyHc+2qZQvucv+s+/Pcfp8yYxA3SUzFImJF
         nKTU+z8MUVJ4bJA5j3yiJCmlPJcaeGYyZ2KCJmLwuICq76XRvIeHoMmiF5p4SVGvxaea
         8rMWAaYUjgmVaWXC7tLhnuS/3qu+Rl0nGUVpe1uDRMt6R9YOSHErv51RV22R5D1b5oS4
         QuHRGOSHlEU89SubDKdFt8MHNvjQRfBzZrLSRsaIk/ZYMHEwQpl++PkN4Y0km4XFiXqG
         CaPA==
X-Forwarded-Encrypted: i=1; AJvYcCUhcefj/A7eoMc/Yb4fo8g08hobakjfztFVJSpRQcWtkU5iniYIQRq3KyhM2UySbF63Npg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Qt+wLR2oYkyKeCUzUc6mkYi+EUI3y1dodq2mclvO/HkYYW3Z
	oZbpSbTC1rN+mGhCIdrG+3DmF54pfXDaQC6OFOVD6FLYkRljjdXxrcTjLe5A2rhfjBW/dP8ZTR2
	+CEeL+lt4KqSGR57hrpHut5Ct5PzJ9+pqzgm0
X-Google-Smtp-Source: AGHT+IFx1uQRWlu6HO+b5kFP1JV4UddZ/61Hh972YovmjsDdUoyCtX0NJ/DuSmpbpu43iANf+c60L+gdzF2wAb+3oFI=
X-Received: by 2002:a05:6402:5194:b0:5c2:62c8:30a with SMTP id
 4fb4d7f45d1cf-5c40c872e58mr74913a12.1.1725996387766; Tue, 10 Sep 2024
 12:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906221853.257984-1-calvinwan@google.com> <20240906222116.270196-4-calvinwan@google.com>
 <CAPig+cRKbvWT3Bx65-ULAYRSrrKTCL0C7r6xpNSdN5JjLBPjCQ@mail.gmail.com>
 <Zt_qM8ZGN4fnqUoY@pks.im> <c8d65466-a9c3-4556-84c1-3daf0c7cea14@gmail.com>
In-Reply-To: <c8d65466-a9c3-4556-84c1-3daf0c7cea14@gmail.com>
From: Calvin Wan <calvinwan@google.com>
Date: Tue, 10 Sep 2024 12:26:16 -0700
Message-ID: <CAFySSZDj2wOmzGMvnCFgVLXQK97Q01R4QJRPbMbaTwZ4h3h8kg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] config: add git_configset_alloc() and git_configset_clear_and_free()
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org, 
	Josh Steadmon <steadmon@google.com>, spectral@google.com, emilyshaffer@google.com, 
	emrass@google.com, rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, 
	sandals@crustytoothpaste.net, Jason@zx2c4.com, dsimic@manjaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 1:50=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 10/09/2024 07:41, Patrick Steinhardt wrote:
> > Is there ever a case where one wants to
> > allocate the configset, but not use it?
>
> That was my thought too - I suggested providing git_configset_new() that
> would allocate and initialize a config set in my response to the last
> round [1]. It is good to see that the struct in now namespaced in the
> next patch but separating out allocation and initialization makes the
> api harder to use than it needs to be. I'd also like to see
> git_configset_clear_and_free() become git_configset_free().
>
> Best Wishes
>
> Phillip
>
> [1]
> https://lore.kernel.org/git/47b18fa4-f01b-4f42-8d04-9e145515ccc1@gmail.co=
m

Agreed, it doesn't make sense to have both alloc() and init() when
they can be combined and same with renaming
git_configset_clear_and_free() to git_configset_free().
