Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C2F2222AC
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756994764; cv=none; b=NhTTO+Mgg/5Cfsv0A5ZJVvdCCIkklqpwvb1rB1YWW18BK5QxNeylj9TgwnhC4Q69ANUu2ABj/ylExNAarClxsWCJ8LofBHXjvAZGyZyENX6nBgoB1/5Aul8GaOBguWUoIPdw+meyb9P7JlkiT4oVS67Oy9Fdu4VN12cQPjRR770=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756994764; c=relaxed/simple;
	bh=5Qteg1EJNDC8WuddTk52yiXvYJPL3ivlww5CRXUs2Z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8cRTYxL1j1qsFcSII4+F2arxDRfNqiq98fuCsWFVGj4tf4ORTHFwJhJ+W5Kzq1hCsmuIT8/c+TAyRV9nzEbqaoR/sPLjul0rEnm8MnSygw+NEwkKp1CNFU4YGRuYeCel0PXxNQu2TXNvAtPeGlOi3lK5XVnQBobxtkcRU+NCPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpD8B09L; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpD8B09L"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad4f0so1836023a12.0
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 07:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756994761; x=1757599561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSc42OzCNscTVlOaiK3ppJAOQmDeNFkpIeiEBV/dbIY=;
        b=QpD8B09Lt31xbK/mGuCijsH8siiYtIOPXfCUp4nM4IZvKQc/CnXvZPIR9HYzEg4c5O
         uFO7EpXHbm1m4WjJ9QmVOH0PTwvwmcm8ZNTWgw8zd8FrC1noPHB5FmXN0E5j8lwnAMtr
         XIH99aMQO8v9acCYmiYcHH5+HqeG5nivt5o9tIHpQTFRJM6r/QeQDoUJ+27Ieevs4MtA
         Ca6tP+J85fvO2AYVvQWWraa2ROy8j/NpmtEC0DbJcOO/8321995L2dR+pM2XgNTz5aKs
         3fTQZ7lkemkV55AUlPNmjfrOpqoYhAi4qKflfkVnFJWY06MVGGkkfpA6j2jNiKKvhZGG
         mvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756994761; x=1757599561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSc42OzCNscTVlOaiK3ppJAOQmDeNFkpIeiEBV/dbIY=;
        b=FCqDg//6n6tQzRHAHhTisC4q9g18bgwS0ZLOw6yI9K3wypgu69V2CZhRzn4j3cWYrM
         QjjbmKkKOnZu3oaLRHw6vs6tRlQfAo7gydEkfYLQXLFFeH19dqPLNmoqakztVVWUWDck
         9VvhkDreutQq6w7QZtmdqPVWK3MvFhuxs2v7dGVNEZ4ZyAfvWKG/NRZZEY2WA1DeHdra
         sDYgB8Z4jbuF4DfLTafjMMPTRs6mRhxSzIhoMLUCuzUBYrHfTh0vdBTLrAixFZb+EE2O
         2VMpqcaStqpJ9eao4H+//d0KuQkLDpigCCJ3FJjgu6F76qEfwIIydPz8JDa9vY+GIGd8
         ls5g==
X-Gm-Message-State: AOJu0YykGDIy6qAmbB8yg+/wbP/lNIvBArcSFNXcUQioRmeysH4pVrph
	mxHVwCsTAe6sbngHfofx3IqA1yc5A42nIiThMQuKmRt35pfTPTq4eFbdXzD9sVk6weqUESx9dvs
	td3qczrVRFn6CVPt/mMwJsVEwbFE20Qbgg24t
X-Gm-Gg: ASbGnctN4+d7E6I3MQKCJvJ4N4gk89npf9IO+GnVksfNXO9YW9Di8nCr/4wSUtLONoc
	/iD1mq0mssCNJejhytdUNk8OBXyvta3bWsvryHrYxCRZ4Z+2PPcCAaYNG1EjNBkBgnYvXWGnVoi
	vruJXkA5wG2ry1yGPS/i6G+Yf2G2dG0cVE4jckMe2ffQGZynXM3MCmDYGB9mb37XbuGK99GlYxI
	vMTa16naEVdKNpKbqtcKCrxOhOvOeBp+sV5ReC0a1460K19lLE=
X-Google-Smtp-Source: AGHT+IGJ6hHsyUZjeFNdK5htCLF0sFQYRgAoUwXBzy5l2rygTvR4uUdYTYvadxOMXt3PBDzgTetZo5N91fb5Wv55N4w=
X-Received: by 2002:a17:906:4789:b0:b04:1a1c:cb5b with SMTP id
 a640c23a62f3a-b041a1ccc38mr1531034966b.7.1756994760629; Thu, 04 Sep 2025
 07:06:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALnO6CA3FkiOeF4w1TUf9S_UDTG_1iRxjEZcAkfrL_eqY+P26w@mail.gmail.com>
In-Reply-To: <CALnO6CA3FkiOeF4w1TUf9S_UDTG_1iRxjEZcAkfrL_eqY+P26w@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 4 Sep 2025 10:05:48 -0400
X-Gm-Features: Ac12FXzm-VQp4MFivohKIIpoA1R-bw_cEf4TP8MDBToq-OZl1k1hy7NRLSECuX8
Message-ID: <CALnO6CCEF75uriogAEd5LfORJ-m9OmDcF7ubu-U_xLWwxfZWTQ@mail.gmail.com>
Subject: Re: Performance (self-compiled vs. distributed)
To: Git <git@vger.kernel.org>
Cc: "hanyang.tony@bytedance.com" <hanyang.tony@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 4:31=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com>=
 wrote:
>
> I have an installation of Git at /usr/local/bin/git managed by
> Homebrew. I'm also tinkering with building my own Git (+ patches) to
> experiment with new features. Today I used "make install =E2=80=A6" to ge=
t
> that in ~/bin/git, but I'm noticing some performance problems. My
> shell prompt started coming back slower, especially in a large
> monorepo.
>
> For example, inside said monorepo (apologies in advance; output is on
> a computer I can't easily copy from):
>
>     hyperfine -Ni -w10 {/usr/local,$HOME}/bin/git
>     =E2=80=A6
>     /usr/local/bin/git ran 4.99 +/- 1.69 times faster than ~/bin/git
>
> The difference is 22ms +/- 6.5ms (15.3ms=E2=80=9356.3ms) compared to 109.=
7ms
> +/- 17.8ms (91.1ms=E2=80=93159.9ms).
>
> My build recipe was
>
>     export DEVELOPER=3D1
>     export XML_CATALOG_FILES=3D/usr/local/etc/xml/catalog
>     make -j "$(nproc)" all doc
>     make install install-doc install-html

Interesting. It was suggested off-list that I should try building with
CFLAGS=3D-Oz, which I'm having some trouble propagating (with V=3D1, I see
some initial files built with -Oz and then later some with -O2??).

But on my other (non-corporate-managed) machine, I see almost no
timing difference between a built Git and a Homebrew-installed Git. So
I wonder if the corporate binary sniffer is causing problems=E2=80=A6

--=20
D. Ben Knoble
