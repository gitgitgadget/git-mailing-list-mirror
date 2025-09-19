Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3549623FC54
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 21:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758318789; cv=none; b=hX1+MBiLnjC0MCY+2yANGOdEROsfV5LfD2sy2lZdCx58Fq+stTkSBRazgogA/OXQp+84VQscDcBbs+jnixTqMRO975kpHWhymzMPE9lEx74l3orFhO1aRBh4IeSyiyE7Wf8grFQUCB8XZ7evAjeS+JB0F5eafJN+BBcyd6AGt6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758318789; c=relaxed/simple;
	bh=bHqBx6x6Qdkfo3yn84KnBeS7jAKOeFrY+WdbakIDdFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mk9iEGSVXump1mkM9Qef+6Wc9YgYJ9J9ZGXMrOCz3qrQvHPIh0IcU0cUOyhoTDX8cOjd1o7Kzvvfrs9d4I8rF1FGUEGjPsHYS2JRa+ukRN5nh/MGGRvFx/HCvo9mcmkuDabnRGl2m3EFBrjWsNlIqdZYqvVZuGsee1fpSfig6ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdNtrZZ7; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdNtrZZ7"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-366ce79fbeeso2242141fa.0
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 14:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758318786; x=1758923586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTH+LIa5ohmrZV0JV+9YOIwkSySwT5oksR6t64hdJlg=;
        b=cdNtrZZ7cl6IMaF9JgvJcIxJ0oLIJhIWqEh+UbBH2xNyV65CU9Or1Ktyf528fmSu38
         RBEEdwQbfgoP3eEth5KasyMbcqAOpWALFAoy00Ud9XYPMUihc4NnB6E5PIQzZifgFYJ8
         7pwflOC9cp9agwJLepvpjNB+AqaLDnVYGV6OqMBO0OSqw/kTdMjeWLrlW+cDSXI8LLS6
         wrLd6Por0YCYnRK+D4ATMVji0ln2QniDM+rWHGVljo3HXUhlWupFM0nEUbslAe6YvO4G
         N9jrpMxFpFb1oev1xVzMbbsGklGFuwXxIe6lsUzjBbGqa8jAPpMn7JQyomMEdnkXolXN
         8MxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758318786; x=1758923586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTH+LIa5ohmrZV0JV+9YOIwkSySwT5oksR6t64hdJlg=;
        b=ArRKz3L2qgHFEvsnulEe6nsg+xpX6kQxqbdt9Mmi9LAtwKooUo4tOnjHrmhwqhMuF2
         Njw+w2LSGN/OTcCQwvRxDxARo+a2Lcr5XXpEHfO14e4x9XttMNd44DSsf3BpEw44pE/4
         Jj983/cqPFWH/ZE6o7zgF/kM890NYlJckX8L+mNlobCKcmwV7VN/gkJ8mYdt5ZN21V8w
         v3i2s13iToyG6wKmUzxG8HnpeVSdoOXV62VxD/nn6ZJAINxosjGAUdHwZNNnOUqA3+3Y
         F85BmXNGwPGocLOD8Es6O1YEaXWJJnxi/AE/YdFLaH6+ZxgPaZumcQDUlN4gVjjKtaAp
         fWpw==
X-Forwarded-Encrypted: i=1; AJvYcCWBYH+NHNEH0RnsFL63FhnbhfXXFaIoMIQddGM+aguJe/F2BvxaiqDuJ47JpNFn0p0PJno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRoh/eaqY6hyOyYxCQP79nibo9pgAQ/rNz1Y5OcrRnswvJYYhl
	Kz3mEjsoaj+y3sGMuOiG7jc9S68NFRn5RnDH6GqWCwYsX70J/cO96nlOrZjnnvuw6xImukNViEr
	NPbwFdESTJUpqVhIzFqyFzIN9Lebi66A=
X-Gm-Gg: ASbGnctXGCv5Duq9cIa02fYh+1JzHpBT9CwI2g+movCqqqpCyfBxF2aXNs/NsSIueef
	/onkGcM3hEeUo0qpCg90jNORgMEJRloUei8uG4kc0qfFArv83YCl93yc5brOz0Rzel4/amBhT97
	vg/hfU09kI2UahZpNZkm8P8rrZ1O/JX1EdmBWwYTUdy9Y0r+uXCYwaxfDqoOFNYk/rAUwxDLKN9
	HrCCFpl/haYm5SpEnY=
X-Google-Smtp-Source: AGHT+IHaUBy7Lazqp2n3I/nXVd4GDZ9IFVcDjxjZhvkMPjQqy+rfha3zRcj3/w0KBYVNtQni1FU4hRSKTQ72d3ZZimQ=
X-Received: by 2002:a05:651c:4112:20b0:336:e199:6d73 with SMTP id
 38308e7fff4ca-3641c91f659mr15567721fa.43.1758318786027; Fri, 19 Sep 2025
 14:53:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <7082e32c5975d2aaa277eddae7497eba0f2131e0.1758071798.git.gitgitgadget@gmail.com>
 <CAPig+cRGtMX9bQhb+7g5aXRVjpLKY-qDdQP95f9TmbY8j_BweQ@mail.gmail.com>
 <CAH=ZcbAOBnEVfyNy_4hdpe_dvsqDxsKVTcvurJz_iUWiqOzG3g@mail.gmail.com> <xmqq5xde435i.fsf@gitster.g>
In-Reply-To: <xmqq5xde435i.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Fri, 19 Sep 2025 15:52:53 -0600
X-Gm-Features: AS18NWDeRFd9svJBdT3K7gDyPPdWpHc5GPVr9aa9MlrjJ8K_XD36a-UkWUBRfxc
Message-ID: <CAH=ZcbDvwbCdnpeNv6vp=+Zy1h8RpG125ZCQNUzNOc5qLi8gNg@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] make: add -fPIE flag
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 2:07=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Ezekiel Newren <ezekielnewren@gmail.com> writes:
>
> > I was trying to get the rust compiler to link against libgit.a. Both
> > Meson and Makefile produce libgit.a. No changes were to meson.build
> > were necessary for that to work, but but with Makefile I would get
> > errors like:
> > relocation R_X86_64_32 against `.rodata' can not be used when making a
> > PIE object; recompile with -fPIE
>
> This sounds like a workaround that is somewhat platform and compiler
> specific limitation, at least to me.  Does this need to be conditional
> and if so on what?

I don't know, but I have another question to add to yours. Why does
Make need -fPIE in order for the Rust compiler to link against
libgit.a created by Make, when Meson doesn't seem to specify PIE
anywhere and yet the Rust compiler can work with Meson's libgit.a
output?
