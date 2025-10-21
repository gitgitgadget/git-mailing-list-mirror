Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47921350A0F
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 21:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761082642; cv=none; b=UeZ9hJ110z8d2/l2o6+gG5VGydWH4zZUqA8DiSHD6kUieclakPNxG5SS6gf1zE76oTAqblIGgP3TJTf9iPHq46ZwtQO4apSJ3zS2dCJFVAwu02+W1Up9OotGz7TqtT9IWY//bH+WgSQwFS95mTQRRaMm2I1Bg66j2xR0x8Rr418=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761082642; c=relaxed/simple;
	bh=2A6/cFfNwAIQRnx0JmkXBz9AYRiU3GJoQdZqXeWZfB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXJEQ9qQP+8YRmXuknqeoIyhWYKDhKuSBcsYVSurmmnU7IrECSqjtzvWL31g4armgGYOJtAD216jXFBhcd5floijVKugj5mndz5d1n+vb9vKkF72lq7eDJF2qGLgzNY3cotAj5ot8mywbSCnxWaWpLhpdu7wxzxSWsyzX2PdOtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRXH4XGx; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRXH4XGx"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b50206773adso76442566b.0
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761082638; x=1761687438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXmT8J1KmdDyIjPj51YC629a5uclRHoUaL9DqQsvhWM=;
        b=jRXH4XGxA+MaMiRHAFbhOWcfmZpwngFzFZfE3GX3zcbIbnFM7abi6QaSqIyRPcPCcr
         PQRTj6UiMG3JNx5tgAm8D4dTVQOm5L2GGDgSLldqtEgHdr24poraScKb9RHhE4gNGe7/
         p/kcde0rydoNXHS5GmD1EE+Lg1+rO+iZ5BJ/ykCfvHE1EH6r56yKHWFztNTt3T5MAxU+
         eszmXyasoEVV1mNMVVwhfPz1D4C2qpDgGuViV3i6lkp6YDJ0wRXtlKiDOiw0LGfZ0X78
         N5KPfh2HWsvQqCSNiHEjDWpKKWNlBLShhJR1NTa+t7eao8MW+5xg7Q7gjf3NUrf2D6kp
         50Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761082638; x=1761687438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXmT8J1KmdDyIjPj51YC629a5uclRHoUaL9DqQsvhWM=;
        b=kd2Ej1b6gIuIoa6FU6klDXGebhqfhmFg3f8PHU2N0BRsPUCCockclGkXCg/LZh9r98
         EixDpk+EKMR/yGzl3PD4XNGF7514hqZa/KNBHDeslChRLilQnReMhZmVUiBM5nDhNXMH
         1KxP5I858lYnsnEi+xuKyNJkam+pqPmKYxHTi67Iw4AFWSkjLMO0L0BnYeiuBoTovP62
         /eIlogW/z//JbCtURxC3XXhJVv9EzhCsUwLK+8tKrwwkp67Ht3Q0yezErcafHae9IDuA
         fHOkttCC48hSlXpLa9qVBDkL9sdafqsYT5KBPnOP3Rg5cuymEWdoe2iUooleJjMkkRGx
         NTnw==
X-Forwarded-Encrypted: i=1; AJvYcCUM2+eetRPG83n7H2aYqQU3WcKkALvl9xd2lnc+ZRtFxQfP9FnxTMADwfw0sv9zOnEr0n4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL4RhgKB2YUiikJ9M3ctTonIvoyZKiwBdG+pgtqcRAbSFo7iEK
	+XL+K5V7h854kmZsA1bGAjspeGLcfPBsCO5B+NI2C4cVj6DG9tE0IWFTeZHxC/4RRO1wMnYdEgP
	mtYq3rSnGo0R+e9RZISiaEfrHfkuY0SrP2jLD
X-Gm-Gg: ASbGnctfPGc7JwcuFvSIHHu7YDHgIERRI2YQxUSnrODZyIMGw13ifxZ39gUTPvald7M
	enNfvAI4rwYqW9sufDaFjwzrIBnavRFsV/BdXwz/WtKDlgqYMk3/f32xneq8nm+cDCSfCrR03vL
	DsH3oGkTHtwwY9wZ/ACdplJzx7nJhNKWsYwJ9z5PqewHZdb8jhBq6IWmC3Ad+1J0fnPeJDMNFnT
	rnxP2PK/ipAbPojPmkwCI5aAoMfp2McG2ZR5FJZXvpd4Bm1cPwDKvfEsP3YpmrVfFuzOUO3lOZs
	SniHnwFqyVxlvhBPMpE=
X-Google-Smtp-Source: AGHT+IErCOaVd4GPfVu2Ipd7ELdOaCJravTakpgYHUKQOuZhDXNCNS/BXDNOn9Ssjg3MY7F+W+bWi1NDwKbX3dPudoU=
X-Received: by 2002:a17:907:9608:b0:b3d:a295:5445 with SMTP id
 a640c23a62f3a-b6d2c00621cmr166774466b.13.1761082638345; Tue, 21 Oct 2025
 14:37:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqldl4und1.fsf@gitster.g> <ecf21e8d-acff-47fb-b972-59cd7b8f3146@app.fastmail.com>
 <CALnO6CAjhgsGS-zoL_EQO0CXyg1gVH70TSqnbThNmJYarU71EQ@mail.gmail.com>
In-Reply-To: <CALnO6CAjhgsGS-zoL_EQO0CXyg1gVH70TSqnbThNmJYarU71EQ@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 21 Oct 2025 17:37:07 -0400
X-Gm-Features: AS18NWCVzitnJCFOlQp7JyP_rVK3K__7ROmzRLRyl5ixZyrjOiO5Me1uHh2dF-I
Message-ID: <CALnO6CBJ7FQqa1JS5LoSqDa2KBHGZ=7KyUjQqNZWqHuq+nZOOA@mail.gmail.com>
Subject: Re: [rfc] flip rerere.enabled default to be "on" at Git 3.0 boundary?
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 5:36=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>
> On Tue, Oct 21, 2025 at 2:56=E2=80=AFPM Kristoffer Haugsbakk
> <kristofferhaugsbakk@fastmail.com> wrote:
> >
> > On Tue, Oct 21, 2025, at 20:21, Junio C Hamano wrote:
> > > A good default matters, and people who find out how useful a rerere
> > > database is would say "gee, that sounds great but why they do not
> > > enable it by default?  It is too buggy and they wanted to reduce the
> > > number of support requests?"  Yes, the reason it is not enabled by
> > > default initially was exactly that, i.e. those opt into the feature
> > > was used as guinea pigs to polish the feature.  But we forgot to set
> > > the graduation criteria and never said "ok it is mature enough, so
> > > let's turn it on for everybody".
> > >
> > > Perhaps Git 3.0 boundary is a good occasion to do so?
> >
> > This sounds nice.
> >
> > Sometimes I make bad resolutions and my cache gets in the way.  But I
> > know it=E2=80=99s a directory or file somewhere that I can delete manua=
lly.  So
> > that=E2=80=99s nice.  And if I didn=E2=80=99t know I think I could have=
 found it on
> > StackOverflow.
> >
> > I don=E2=80=99t think the =E2=80=9Creused resolution=E2=80=9D is super =
clear for things like
> > rebase and merge.  I will get output like
> >
> >       CONFLICT
> >       CONFLICT
> >       CONFLICT
> >       Reused recorded resolution for ...
> >       Reused recorded resolution for ...
> >       Reused recorded resolution for ...
> >       YOUR STUFF IS CONFLICTED
> >       DO THIS AND THAT
> >
> >       this is from memory :p
> >
> > And the =E2=80=9Creused=E2=80=9D messages are kind of =E2=80=9Crandomly=
=E2=80=9D placed in the stderr
> > stream of consciousness.  Could they be colored maybe?
>
> Seconding this: it's too easy to miss the rerere messages, which can
> make other moments more confusing. (IIRC, git-status still says we
> need to "approve" the resolution, but for folks not used to rerere it
> might be obvious how to check the resolution? Idk, can't recall
> offhand.)

Premature send=E2=80=94the above said, I don't think it's anything against
graduating rerere to default. Just that there will be some more edges
to polish, which is a good thing.

--=20
D. Ben Knoble
