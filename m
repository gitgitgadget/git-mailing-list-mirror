Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019B6537F7
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 20:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712004742; cv=none; b=thcgwr0GuoAkTO/0aG0NYCXVX5Hrfpo/QQWwNcdMaNKjCtcsEYsXq9ImIisJtbdvoJLbK4Po18JX31MRc9DrzwafyVms+/gGd23HrBQc1SPoLKAOh7iUholYHahVQBo88Shcca4vgRWOWS02PAF4Irh21PaGLJspvvW4WDAUo8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712004742; c=relaxed/simple;
	bh=VpouMQXWZIPpSWPbmyjxk92mOMX9g08IwEgkW8PAmWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=KrOI6R+NK8KoPaK5fdbmVn+ZfbBXDkhD6hMsQ8HrzJHX+Pv9Gx2hwa1Uh+KPUknw9GR4EpLLYKFdz+UaoW+LdM0ajmfVbtkJGxqfkRowoM3GlYozosU1YBD0Glsujer0IgR8xFvIyFpbWW+RzcKbtCUSqMUjLXVIFjJxU2JDCIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isY8c3nW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isY8c3nW"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-415523d9824so26045945e9.3
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 13:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712004739; x=1712609539; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JLGdC9eoOUfmv1CM0ueM9YpI437YMURnLYKunhHV81Q=;
        b=isY8c3nWK28BwqcIPXIyA713dqp1rYh3oDkfZEjkfli6ba1M/KSdnFBNtlN7kjOlwF
         GNjANGMNVy7mazX7uwU6yNbBjHhhaxM3+4GZKpQyvU7mIYwAy8hhTUaeGYGouujlBBKX
         pqKwHlRv7NMsmVT6pS8qiE71GaG6KYHKKEGJ9RTkbr3URHfU7kwqIspuJMxJOOaH3jQk
         Xi0MHQ/KRz5vwe6y0yoE3kftpTO1mf+Y/J4wL1ZcfHHg2mnMA+rb4pEKt5TYZfKc8oo3
         2mERi1IbmfOhg8NU0fWI9PvjKNPdV1K7uzIgV87EFwP7puuAuNju7wQ1ku2HCtiS5Et4
         Vjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712004739; x=1712609539;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JLGdC9eoOUfmv1CM0ueM9YpI437YMURnLYKunhHV81Q=;
        b=bubgrmSGPkPptxd7CpyivxOyHVrMNlp7zVuWMxGjdAoKq0Efhe0crWr1PXZCNAC66c
         dv4AJgozlRHSAtdrkyo5ghq0sbYVeYwvHtsm3WF9bxM4OEDC5H26UMa1JECweNLZG8eX
         PMYaAj5GhsMQH1ZW2ZsUGlSR3I85GWxrpk96yrs/6pXB4tEFa6q2g6OV6tcBFABTcM+h
         sGWBuOubAzkS1/b2xnaHh4t/FPOwEZlZrW15yKgMZnZG7QY3tH5ZixtBK4Px6vj41Otu
         aCcXvZp0bvtx5DA5hzhI40VdwAN8gWfS8gTF/vmJqIq2I/qdHL+CFzPR4ywNHshtDxkL
         +cfw==
X-Forwarded-Encrypted: i=1; AJvYcCXwwvjjZPaysI08izIUSht9XD8VNCzF0k3OCZHnNtkuuzRNg9idVkYh42k92oc6UZvuzLydQaa9fjWoZeDs22A9l2O9
X-Gm-Message-State: AOJu0Yz8+Icax8lyLWO9BWN5dqpN2nKpOafRmu2+eVNlQcr46BZTXTDY
	YUGzw7bhKN/NNa/6EsciwpRpg1hBb4LE7R62WS/KP70kXTrNYlV8NLaK7ZhP8Kf23FCbuWz3CKG
	SzU61KKEoO+V23bUfsmtWwOXXW58=
X-Google-Smtp-Source: AGHT+IEAhQoKyyXzCUbLNLSPXp9Zhwj2yjHc2xTlakpLV168s3LZ02xVODPGYwhYOEISHPQv5Vax62mc4g6l1xqYjHM=
X-Received: by 2002:a05:600c:4f86:b0:414:8e02:e441 with SMTP id
 n6-20020a05600c4f8600b004148e02e441mr8561184wmq.13.1712004739177; Mon, 01 Apr
 2024 13:52:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
 <20240324011301.1553072-14-sandals@crustytoothpaste.net> <CAGJzqsn4Lz1T=q8NHi7kHHRdYVXKCMPGVBGzkkvZA=P1O9HtUw@mail.gmail.com>
 <ZgXmxvRv0rNBKk5K@tapette.crustytoothpaste.net>
In-Reply-To: <ZgXmxvRv0rNBKk5K@tapette.crustytoothpaste.net>
From: M Hickford <mirth.hickford@gmail.com>
Date: Mon, 1 Apr 2024 21:51:30 +0100
Message-ID: <CAGJzqsnAby-p=XH4HnTObB=Eq7n12D_uDhdmSOcTBwLzktN60w@mail.gmail.com>
Subject: Re: [PATCH 13/13] credential: add support for multistage credential rounds
To: Junio C Hamano <gitster@pobox.com>, M Hickford <mirth.hickford@gmail.com>, 
	Matthew John Cheetham <mjcheetham@outlook.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Mar 2024 at 21:53, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2024-03-28 at 08:00:00, M Hickford wrote:
> > Is this design sufficiently flexible for OAuth DPoP (RFC 9449), or at
> > least to make it work in future?
> >
> > OAuth 2.0 Demonstrating Proof of Possession describes "a mechanism for
> > sender-constraining OAuth 2.0 tokens via a proof-of-possession
> > mechanism on the application level. This mechanism allows for the
> > detection of replay attacks with access and refresh tokens."
> > https://www.rfc-editor.org/rfc/rfc9449.html
> >
> > Popular hosts GitHub, GitLab, Bitbucket and Gitea already support
> > OAuth. OAuth DPoP "provides a general defense in depth against the
> > impact of unanticipated token leakage". Motivated by a 2022 GitHub
> > attack involving stolen tokens
> > (https://github.blog/2022-04-15-security-alert-stolen-oauth-user-tokens/),
> > some hosts are already experimenting with it.
> > https://lore.kernel.org/git/20230128142827.17397-1-mirth.hickford@gmail.com/
> >
> > In particular, the http request has to include both Authorization and
> > DPoP headers https://www.rfc-editor.org/rfc/rfc9449.html#name-the-dpop-authentication-sch.
> > The latter depends on timestamp and a server-optional challenge in a
> > DPoP-Nonce header.
> > https://www.rfc-editor.org/rfc/rfc9449.html#name-resource-server-provided-no.
>
> It will likely be sufficient with further extensions.  Right now, we
> don't have a way to provide DPoP headers or send nonces to the client.
> However, there's no reason we cannot provide that functionality in the
> future via additional key/value pairs, in which case this design should
> be fine.
>
> This would have been sufficient if the OAuth working group had not added
> extra additional headers that other authentication mechanisms would have
> simply put (and, honestly, should have been put) in the WWW-Authenticate
> and Authorization headers, but alas, we can't change it now.
>
> Since I think this gets us at least part of the way where we need to be,
> I think we should be able to keep it for now and implement the extra
> support for DPoP later.

Fantastic, thanks for considering this.

I look forward to sharing a test Git remote with OAuth DPoP when I can
figure out how.

> --
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA
