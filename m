Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA3E189B8D
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137754; cv=none; b=bBwDq2GGGwE7lNDnDG39Md9XoFsEgY9eHZqzWzwsV48QKKT3+AB2fIlyigafqxImX2aSbqV3zDQFY07wtnpmL3A3+5+fMlgn1fOdjV8Omo1Iug+3d46+k6sA6xEj0/ly86utWgQ/ezyFF77g+IwlYOjXRjib2C2cPYquQsrf6lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137754; c=relaxed/simple;
	bh=UIyahgWBlNDfo41E2ozfCQyarvo5rk9VVVt8SS/FBIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvDaTb1RsUqj2+wEDHE/TVaV5vGiJXDZdAgGvPsIl37WrYyPdh3NB+/pJf2kU1HNNYaglxwgEPgwBRDQsTt7KLcF590Sz0BkQLd4yP3kzJq44Xh2jESyCk38Xisuq+rXEB7GFTbxyNuwGip0+/QhikPS3YhjWh71mhXwjpHvvrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sRmtXjKN; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sRmtXjKN"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7abe5aa9d5so160605666b.1
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 10:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723137749; x=1723742549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwA1IJkdzfMkXaLsjvE5DMN/Wa/JwPk4CRudv/tFEyI=;
        b=sRmtXjKNN8oPn7GvAqBPDjf+6uOYPsyZrKtpnkaFgELqWRCeePRfta6RuXNgs242to
         EI+iMvB5jzgTWeEtmUbJPqUJniRHMnIcJ0LzzIJtv2OzxLEivptSM1idCLDlos457SdR
         JjYfoL0CwmNY6vULplZv7DaIa0In32m7zZGV1E5jfLGITugpPfo0X+YCD7IfEhBV0tBN
         RNmWtYx5HEucohrmzZ5fhTkq/Ra2fLXvz7pn5YIVkDDXrqgzO/5CtBOc0XF91MmAl78z
         MH85DxLI8d8kgpUn0F7IJg7y2tTRNcnYBqv2fO/9rR1axVeAR/5e8hKPeW0qoJYqNw1+
         lTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723137749; x=1723742549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwA1IJkdzfMkXaLsjvE5DMN/Wa/JwPk4CRudv/tFEyI=;
        b=XdeQo8taTmwiukjB0GtQIl4kYobwVUFcw+10ACUFtLZUXmve+hr4Mjle3YB5tjiCvL
         FT1HTXJqJV678T+hKYNtT8tLhzpTUjxIsguJSDam1aJ3sHGz0lRG+5gvwUfl7Sl8ZY1k
         0UYFEspBE11v4f6lmepAcgKfzbyyqaH2J4COyZWizQk9eqUCHc6K9T+sz2IjFigkgcgv
         9o7eIdIVagDz+raPEBfKPl78dIr60J8wJcvhu4gzjqWhYY/NVg3uyyR3TQL0alRtx7rI
         HCIg1iUB5OjbakQWJ7paBz3gp1xrUlyxRK1ASz/oVREm2EmsjCOpAExzpZofY4ohZcT0
         LJzA==
X-Gm-Message-State: AOJu0YzW5ByLY2WU35s39eRfSQ444LO1y3AOWaMNQ5uiXoPH/AyzlR6j
	q0SdVfbHezpWkhWb//pukUUgTzp8kaSC96dNcVoSHtqhnti+qtsdjupCCKi+2HuVfbcfXsSZkHe
	IWiMZ4fwqVWFjCTXKQxmWdmA8PYZjXVU7RWh7
X-Google-Smtp-Source: AGHT+IGLUsDOqOkTaNl0NYfzpZCoAibVhBImTmj1xfsKqXBWPO/gsnikYLZm3LTIzEJcnocEVFDfM77QPPhRS+sFsQo=
X-Received: by 2002:a17:907:3e1a:b0:a7d:2612:33d6 with SMTP id
 a640c23a62f3a-a8090e9f92fmr224881166b.53.1723137748918; Thu, 08 Aug 2024
 10:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ab0fcc2e-936f-4d76-8059-fb2bc8a4f661@app.fastmail.com>
In-Reply-To: <ab0fcc2e-936f-4d76-8059-fb2bc8a4f661@app.fastmail.com>
From: Kyle Lippincott <spectral@google.com>
Date: Thu, 8 Aug 2024 10:22:11 -0700
Message-ID: <CAO_smVg=1gFBudrd70V2_AXSPOUTFz=j7QqBpbkvR7P_KqnBtQ@mail.gmail.com>
Subject: Re: Documentation bug (?) when describing `zdiff3` merge format
To: punk.lion0906@fastmail.com
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 6:22=E2=80=AFPM <punk.lion0906@fastmail.com> wrote:
>
> The docs at https://git-scm.com/docs/git-merge#_how_conflicts_are_present=
ed describe the following snippets in `diff3` and `zdiff3` style as equival=
ent. They do not seem equivalent to me, so either this is a mistake or the =
`zdiff3` style is counterintuitive needs a better explanation.
>
> diff3 style:
>
> ```
> Here are lines that are either unchanged from the common
> ancestor, or cleanly resolved because only one side changed,
> <<<<<<< yours:sample.txt
> or cleanly resolved because both sides changed the same way.
> Conflict resolution is hard;
> let's go shopping.
> ||||||| base:sample.txt
> or cleanly resolved because both sides changed identically.
> Conflict resolution is hard.
> =3D=3D=3D=3D=3D=3D=3D
> or cleanly resolved because both sides changed the same way.
> Git makes conflict resolution easy.
> >>>>>>> theirs:sample.txt
> And here is another line that is cleanly resolved or unmodified.
> ```
>
> zdiff3 style:
>
> ```
> Here are lines that are either unchanged from the common
> ancestor, or cleanly resolved because only one side changed,
> or cleanly resolved because both sides changed the same way.
> <<<<<<< yours:sample.txt
> Conflict resolution is hard;
> let's go shopping.
> ||||||| base:sample.txt
> or cleanly resolved because both sides changed identically.
> Conflict resolution is hard.
> =3D=3D=3D=3D=3D=3D=3D
> Git makes conflict resolution easy.
> >>>>>>> theirs:sample.txt
> And here is another line that is cleanly resolved or unmodified.
> ```
>
> The problem is that, I believe, the "or cleanly resolved because both sid=
es changed identically." sentence should not be part of the **base** in the=
 latter example, since that whole line was moved outside the conflict.

This line _still changed_, even though there were conflicts around it,
meaning that if we didn't have the "... identically" line in base, we
wouldn't see that this line was removed anywhere in the diff. I agree
with the other responders that this is awkward, as it means you can't
reconstruct the original 'base' version from these diff markers; if
you tried, you'd get a base version that has "or cleanly ... the same
way" followed by "or cleanly ... identically". For manual conflict
resolution where you generally won't ever keep 'base' or attempt to
reconstruct it, however, it seems fine to me if you're aware of it
happening.

>
>
> I'd appreciate knowing which it is.
>
>         Thanks,
>              Ilya
>
