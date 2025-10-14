Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840B115E97
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 02:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760408346; cv=none; b=pjM5UX0GmcFisK8eESXsWETbcZHnhvj0vKQpvNG05ogQeazzZcmYCNrV312WpURnSguo3Oa6yofc9zRF1ZE1KvUKhUh9uNWmX4s7bQmT8WJfSPvV2JIpkZeqgE+mWdvz4g8nsKHeBehm4FR/ddL1tCbGHXUoINwDkmHJfpwao3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760408346; c=relaxed/simple;
	bh=3rGR0+NABVEqySmFYevNsnm6bOEXHIOlRf+OfGO4LYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eU0xofZhUjWcJe3kETL10KoKYMPhZR5+aG35SxKvGWTwCg4RYKvh1BvfC8sFsNqDt5WmlKG9gOqPV8g2uwG+n6Fiu3KpASJDuYbVr0qjVddmM4gkParGdczCy31NGvnnXKlmZ/9Zs8jtTHTWnP4r50coejxqUUdf4jMTAmvvorE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfUyf5BH; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfUyf5BH"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b48d8deafaeso1024480266b.1
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 19:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760408342; x=1761013142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlMuih8CtsrlYpu0dlb8Bt+1C7cQf63oUmRqQ8hmvyo=;
        b=JfUyf5BHnAxcwmPFTVyDSRUwx3vqRU2XRmVaEBOqx8lS+Y0Q/B+CdWOdk4/1B7BjVv
         glKeArflm4ePcl6FSOAjgpmuZinUEluEGnR/uwnDOrwSnEsRe534MIpXoWnQhXUtbnWa
         6MXIZq6L+0IkGhz9Gn+WxwdNhuj/JFXVotR/b5wKr3rZR9dNON+5MYA/VsJWfzLb0abM
         PESzRmJr6IbMu4CWvw6tBtRVn8GkDcN8HFvoRFmvxqAGh0p6saE1xqVNBHdvNFuMSpYG
         W81QwR/5VKW3YyGvmcEXWo1KNnbcojfBf6UQzoq49szS33yGqIkIJXmXXaukGxA00H7v
         xOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760408342; x=1761013142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlMuih8CtsrlYpu0dlb8Bt+1C7cQf63oUmRqQ8hmvyo=;
        b=G/VZI0A1+Y+gbosuMmumdD5nEWi7P4BQHNLbZhJtTsHjOcnxvMo7f8Npbz+OO4G0eh
         PWgpQfSNN1EYT4pwDa9ACebGBjehV6rKyUy9nYvkQmOMydJdHPiti2eRS5ZshW3P4N+4
         jKHMh3nbvSaBCNlLvfqn+kzCQh+woa7+ZaT0MupDFKOchS2vEfd44rkkHHmjeegX1e8F
         h+UYbQeGhKRFjREkPrzHL/bC05LuxHjE9xv9s6e9Q33WLg6mewH0TqIlm2wUtCNuAIe4
         UmYM+9KriZHN5ATNNqd8KokEB3z8jSOvOFFNHJMqLRn2L9gB4FdA8Jzxk8TrbaD00aZr
         DhKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/KAjElE8igpF+Gq/q39efgQ5BZsQCp2MaPGlFeZ5kn72TnoEYgLLbwy12yKGJKLQB8uY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjj2LEeQzC2dz8T22wbXEePqS62nL2RUujfXLg48ukUXRGeiHy
	AMmLI9yeDkyWqr3KOgYPo1jXtFxvCAVdYyHSe8+jDJgKv3k8aY6idCiXx3Zs67tIm41kgIPQMFM
	dqjWfFv2R8J72ji/TmVC0sNkq5Okuq2Y=
X-Gm-Gg: ASbGncudlWPCCIFOnCg5shUJBAmiDjNXTOmzAfxLGoU6csqbURDdNPG4+PgUAk//1EI
	sfHfcqmU0Opxw9hC+JyN8E8qTLDcM+U/OBI3Cr6Wgah0fzW9KhR/fRsPa/ezSI4PpTZgCBFhgOU
	1OC3yIXf6u+mnz+D7ZXU47jF3AFMM4EHAM5lMkADNdXqT1ZCwvGYr0lnJ9UkwZ7kcfJCcMVsSOr
	cKgqJ8KR78ytY7DwztRgePmnbMrGJpnUoq+4PuPxo4YJLL/Wyk+gpBSm0MM
X-Google-Smtp-Source: AGHT+IGi2YJFovbQQ+YZ6QOZzsLWEQ8DKtzmIg9KgdZ4Gsx/P+k75DmuQmAecshZ1vrTIea9AKXqLBgQf8x63BWD5lQ=
X-Received: by 2002:a17:906:ef05:b0:b50:a389:7ab0 with SMTP id
 a640c23a62f3a-b50aa48d2d7mr2548827666b.4.1760408341475; Mon, 13 Oct 2025
 19:19:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqy0ph5ov8.fsf@gitster.g> <B78CD1B1-67C1-4EA1-94A7-13AD40C43585@gmail.com>
 <d4dc8042-b996-4889-88cb-f0862a12d09c@app.fastmail.com>
In-Reply-To: <d4dc8042-b996-4889-88cb-f0862a12d09c@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 13 Oct 2025 22:18:50 -0400
X-Gm-Features: AS18NWBatqH3UkV40il6pzNTMNU3P-PDYGaeJztICa4XwpYq0tiY0q61oYxt1jk
Message-ID: <CALnO6CDULtw1UmqHfiqLCH4v6U=MuiECHhYwz1-Omkh8x=9yFg@mail.gmail.com>
Subject: Re: [PATCH] doc: explain the impact of stash.index on --autostash options
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Glen Choo <glencbz@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Denton Liu <liu.denton@gmail.com>, motisd8@gmail.com, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 8:18=E2=80=AFAM Kristoffer Haugsbakk
<code@khaugsbakk.name> wrote:
>
> On Sun, Oct 12, 2025, at 20:04, Ben Knoble wrote:
> >>>[snip]
> >>
> >> Yeah, that is less useful to me (there is a tool, given a commit
> >> object, to figure out at which merge it got merged to the mainline);
> >> I didn't think of a way the information can be useful to general
> >> readers.  If the mainline merge was a release or more ago, then it
> >> may make sense to say "commit X, which appeared in version Y, was
> >> broken in such and such way, and here is to fix its breakage"
> >
> > It=E2=80=99s not clear to me if you=E2=80=99d like to see a v2 or not, =
but given you
> > were already happy to merge in the latest what=E2=80=99s cooking, I don=
=E2=80=99t mind
> > not sending one ;)
>
> Sorry.  I misread a What=E2=80=99s Cooking email[1] as asking why a topic=
 hadn=E2=80=99t
> been picked up. But you were asking about sending another patch on top
> of something which was already in `next`.

Apologies. That's probably my poor wording.

> I wouldn=E2=80=99t have sent that email if I knew it was already in `next=
` (if I
> had checked better).

Anything I can do to make it easier next time? Appreciate the review, btw :=
)

--=20
D. Ben Knoble
