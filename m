Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5C4194C96
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 19:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734635565; cv=none; b=rSZLHAsfJVfJdjo6w9SP97lV9mur5tODgH7h70B8CCBsoH7UPplE48RfdVzcPYPUuCNG0fQjd3uTNwfNf4bml3LwPFi6Ly+G11LkqS40n5MEgJX7cjQWZ2cVNf9AXsHRNMoRFkKF1+KYmbwgf+mxJuEzqY5EzqHyO//Sfx7p6LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734635565; c=relaxed/simple;
	bh=xLF0HncCJH2qP+vKD1P82awMm4HzfM4gR4Yi4OZV9GQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=T89ziucj3TMwxYlJTT+5oegmNAn1iUsZTTiHc9I6OIKiLI35QNXPYjlnfLWWkdRJ1El/5RUVry5m+OQzMsU+n4lndHgvMpoJHV+UgKMF+i3qBpx6bBGpeK/zJv8n2S2TvWlBzm+Ywmkc299SSM1NmimrscjsMuvjMGxsgTSWh7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3wsltNf; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3wsltNf"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa680fafb3eso15789266b.3
        for <git@vger.kernel.org>; Thu, 19 Dec 2024 11:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734635562; x=1735240362; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RTd/CIjthWcDKIPTL0ZodC+wnozj9e5tFB/ipbpar4Q=;
        b=C3wsltNfnfAWoshx0M8D97648+Rf+wzO7UEVfBoFXgIGoiF8aLlGhFlmTJLqjAUEp7
         b46y57vp601FIBT5pQQqNu1wOx7MB2iyOHM9C2v9cSiHMKZpPMDRR4K00mFqQojyZjQ9
         lZcVt0J0jH41NkE7HVUjy3OKa/CWSmBvZavCNnkaWCtLhBC6KQgVCUUPY+r08S1lAFsC
         xzQU+RQJA3jZTt8s0KZCp49yhR7LFHd6BEM/p9xdqdwgG9dvNZEm8GmRvLAiEu6JGUX2
         8FYoLPrmDhf8l9BZYj/BEKyaQpUA2YgSB1NKA1GxNMCyThF4W34NeoNrKixN2vo5vpu2
         9tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734635562; x=1735240362;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RTd/CIjthWcDKIPTL0ZodC+wnozj9e5tFB/ipbpar4Q=;
        b=jbRheFokQ/CsPMZoT8iPSx/4umARAtFw+yqiRalyn2X8vct3eK1AlhuNVt29J877l0
         PM/X8nnStD55C7Q5tayxpyalkPqFTf1RHcnEOwFzrvynvoJLGxqSubhzjjh1JTOYQEYi
         RGbuygWH20Cq/WYGHdvIdITZP6YW6mv5KoEY+qIlS4fNDR+mEdWoR4zKbF+NAnK/lO2D
         JrlyDhhkuKFF5SDaTlQUtwm5qwPhvQGVLGiYBgMp2sBd7/MNi5wUIX4uP0z0IrwHiz0y
         5i7fC1RxsJhCvQsOV9o/c3A4D4QNNenlpTQhrehgQW+yNHMwpQVLfM3IjN8G1PzRwzX1
         g07w==
X-Forwarded-Encrypted: i=1; AJvYcCVHsO4ZM32iEcHEgCyRyu9FyJdqhQO4Bz+c6C2C6desHcgRy/npeMwvl2O6I/f1KeaJ/Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkCLKrL9XQTckGxrO9+qRIMGHTzygArhxU/WFrQH/nLcbO4WAO
	SFgoxbrM2jrpt8WOu7ETfCmtCs89as1Ic/eaSdi5cwojgNnu5uICS/YWH8ISJ35x+2WINdtP26u
	CM0TW3dhve1eGIPbYuCs+kMxEie8=
X-Gm-Gg: ASbGnctHNRHj8IKBfsvg6r07Amh9/UTH/vYb8GrLQ9o+5WBKeuiGo4nsT7CZviQdKc3
	vqoZLTSu+wRax7g/j4YuZ6s4rBMFh1ZYmTeSUq5TQ
X-Google-Smtp-Source: AGHT+IEciMKy74wizeVyO/3b2YFerVItwCqxwq8dsBqbW81nsJU2SaJGzK1MuKsdBFd/EhaDCyi7UdKPKCLF/5JkHF0=
X-Received: by 2002:a17:907:3e8f:b0:aa6:91ca:3674 with SMTP id
 a640c23a62f3a-aabf473a5acmr286509166b.4.1734635561856; Thu, 19 Dec 2024
 11:12:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGJzqs=ksKqY2M8Px3uv6ut=MBwkmpPUqp3xVzVpNMJ0YBrBww@mail.gmail.com>
 <CAGJzqsnAO_vDSYOC7ZbYUQHJ3fT10JuQ2RrC2cvY4hcPMnZ=bg@mail.gmail.com> <Z2N-rV4fhF3ZkGlp@tapette.crustytoothpaste.net>
In-Reply-To: <Z2N-rV4fhF3ZkGlp@tapette.crustytoothpaste.net>
From: M Hickford <mirth.hickford@gmail.com>
Date: Thu, 19 Dec 2024 19:12:00 +0000
Message-ID: <CAGJzqsksGy4Koz-RbqKebSVL7DO_WP6RvhXqug-f0EPhTGK+ng@mail.gmail.com>
Subject: Re: Fwd: [Bug] `credential fill` prints incomplete bearer credential
To: "brian m. carlson" <sandals@crustytoothpaste.net>, M Hickford <mirth.hickford@gmail.com>, 
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Dec 2024 at 02:02, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2024-12-18 at 20:42:31, M Hickford wrote:
> > Hi. Is this a bug in git version 2.47.1? Or am I using it incorrectly?
> >
> > # erase existing example.com credentials
> > printf "host=example.com\nprotocol=https\n" | git -c credential.helper= -c credential.helper=cache credential reject
> > # store bearer token with expiry in far future in credential-cache
> > printf "host=example.com\nprotocol=https\nauthtype=bearer\ncredential=letmein\npassword_expiry_utc=2147483640\n"
> > | git credential-cache store
> > # try to retrieve credential
> > printf "host=example.com\nprotocol=https\n" | git -c credential.helper= -c credential.helper=cache credential fill
> >
> > Expected output (complete credential):
> >
> > protocol=https
> > host=example.com
> > authtype=bearer
> > credential=letmein
> > password_expiry_utc=2147483640
> >
> > Actual output (incomplete credential, no prompt for username or password):
> >
> > protocol=https
> > host=example.com
> > password_expiry_utc=2147483640
>
> This is expected.  Every request to a credential helper should include
> all of the capabilities that the caller supports on input, and the
> credential helper will always emit those on output.  `git credential`,
> however, will only emit the capabilities that were actually supported,
> so that general callers (including Git LFS) can determine the actual
> set of supported capabilities.
>
> In this case, you asked the cache helper for a credential, but didn't
> tell it that you supported `authtype` and `credential`.  Therefore, the
> only safe thing it can assume is that you are incapable of parsing and
> understanding those fields, so it doesn't emit them.  This is a benefit
> for security, because some tooling logs all fields but the `password`
> field, and we don't want to include new secret fields that the caller is
> going to shovel into a file or syslog.

Thank you Brian for the explanation. That fits my example.

Typically `credential fill` prompts the user if it can't complete a
credential. Surely it should prompt in this case too?

https://git-scm.com/docs/git-credential "git-credential will attempt
to add "username" and "password" attributes to the description by
reading config files, by contacting any configured credential helpers,
or by prompting the user"

>
> In addition, the helper could actually store two different sets of
> credentials, one which is a username and password, and one which is an
> authtype and credential.  If you provided the capability, the latter
> would be omitted, but otherwise the former would.  That can be helpful
> if you have a stronger credential type but might occasionally need to
> use older software (say, older versions of Git or Git LFS).
>
> However, if you provide the proper capability, this works as you expect:
>
> ----
> % printf "host=example.com\nprotocol=https\n" | git -c credential.helper= -c credential.helper=cache credential reject
> % printf "capability[]=authtype\nhost=example.com\nprotocol=https\nauthtype=bearer\ncredential=letmein\npassword_expiry_utc=2147483640\n" | git credential-cache store
> % printf "capability[]=authtype\nhost=example.com\nprotocol=https\n" | git -c credential.helper= -c credential.helper=cache credential fill
> capability[]=authtype
> authtype=bearer
> credential=letmein
> protocol=https
> host=example.com
> password_expiry_utc=2147483640
> ----
>
> Note that `capability[]` directives should always start the request to
> allow one-pass parsing.
>
> Hopefully this is helpful.
> --
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA
