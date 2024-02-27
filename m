Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9414814A0A2
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709064627; cv=none; b=ddGSIbZ4UEx09VLXubsJCjxOFlCwgzOL1jOQV8kSP3ZnE9UbREQWzyDqQrf68S5dHDNGfYtoMPHxFtHCcXWulOinWfMmmJ4xvGnDk1VV9Sd8I/mKC9x2PdPkQJXG11yqEeJtKWX6csIhxMxPNPlLapY1JT4/UbgWcgK0ZHf4jTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709064627; c=relaxed/simple;
	bh=XtLaX7GutAHa2DVJWLHVHaoiwiMYO+ShRHA/gfyWv9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZJHLHfkix4U3CiXmfIXSEe20yzP6iplS7u/hnSiZLtEwJ4dGj29ea0+gsuQI7tX0RxlyXNQaKHvam9XypoqEVOp2vXXp3T9kTXnedq1nwnWCaQ0c+fy4xD7Ikzskgj3MXeKByTFcaeUMFyTvU/FyJjloV8ZVhSYiPKJY1YvVhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MwXHBmD7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MwXHBmD7"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-512ff385589so3091170e87.1
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 12:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709064623; x=1709669423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hluobeTPyC3RdzOQInQig2ufr5Nrw95xAfgu7NfBQnc=;
        b=MwXHBmD7afMSOW/FB+sL1hB38gQTN1/cIVNpI+HPljO+g2OBnLKN7Arf2hejDkwSpc
         ljQoOjDpFtFRVMp5o6go4dh96cBQMdBUN2KGhgE6sCVZEW8IQ1wFaS1iSmJLg95Usoov
         7KswlvCUvFk+V73xeUZSra7uq0YyEnqkQg2hWrEcUryKp2H1/mArxxO8oC4R547V8cCF
         Kq+0nkeQsuvS/yMmDjYw7K6lD8bisu3XEA8sw8V3hDdLuxaB6LmS1V0KiSA30021L7wa
         ywlSTs3Y/nXVDybEIQ2V0o66PQ+vfzTLtEviQiQCliAPddLx+08NRYhbgldTkll8qQuR
         ahJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709064623; x=1709669423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hluobeTPyC3RdzOQInQig2ufr5Nrw95xAfgu7NfBQnc=;
        b=VshYgoFDnjbNw08JpFWQGyPSnUzzcujydZ/RiM6N6INURrimkBrv5vrCirl6cnkBi5
         cQjopchogFUvvqINoC/2EC7tbOGEEyxKzBlJ0GUk1GFuzEA0+NhK+lfsHhNbh6IpqNR+
         9xKqndKM/qz9qC6H0PnpAEi+dKozm31NHgcupFe8rvB3+s+a7V46/Nfu9X+7olD+EFo0
         iYrDXXJihVFUzm3GNKmhQw4040hrBSx+O9Si2121FO0XOMoMQq1f3t6jWzq4UMfbuJEL
         QtURV5B7+FvficQJER1Z0n2wGe2Uy1wGmxH7pk8QyTwiEYvezgXn8JUELMl3DDkWZr5C
         5Log==
X-Forwarded-Encrypted: i=1; AJvYcCXwbc0DbeIEHfnFdwZM1qpHVn2SXDlHez6yoxLDWwQVubQeCTqYIUt8xdavDU9nAC8v7Rp3Vw6zEEhYzoKNXguAzlrN
X-Gm-Message-State: AOJu0YzEiFkblXSTcd82JKvvNdgG4BXN+x1WkbiDVrL4HCZttyv6LXu2
	qW4fBMH9q8DmuVkq2YLwD4GwAsIwo/JawHBINOTXpxgRPWXxw8OZ3j3G/qQsAqmWKDv4hPrRJch
	W+gb5Bk7TR6QIx69eOzfWngNhlqtIqDr4pQ/l
X-Google-Smtp-Source: AGHT+IHwkD/alHTyYaI57/8vRlvJzEnEfH7IezDL7kQeFZo6qN0EJ3/2ttvQA8L9dp5MrmAyqcpSH+7p4AYHCrhoigA=
X-Received: by 2002:a05:6512:3a8f:b0:512:fb30:aade with SMTP id
 q15-20020a0565123a8f00b00512fb30aademr6486310lfu.3.1709064622915; Tue, 27 Feb
 2024 12:10:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1696021277.git.jonathantanmy@google.com>
 <20240222175033.1489723-2-calvinwan@google.com> <xmqqh6i0cgyo.fsf@gitster.g>
 <CAO_smVi76TbmHd5w2rpBEEYbaw46SNTrekFHE-ohDC6-=dk6DA@mail.gmail.com>
 <xmqqle76iwqw.fsf@gitster.g> <CAO_smVjeNYFTgh4MZjRM9U1coY=UJxo-E6bD9OfdS1A1Xf6vcQ@mail.gmail.com>
 <20240227084529.GJ3263678@coredump.intra.peff.net>
In-Reply-To: <20240227084529.GJ3263678@coredump.intra.peff.net>
From: Kyle Lippincott <spectral@google.com>
Date: Tue, 27 Feb 2024 12:10:07 -0800
Message-ID: <CAO_smVg9phJGv=fMcHXjqvY74pHuMdousqfLMpyBcQ+fVMY90g@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] pager: include stdint.h because uintmax_t is used
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	Jonathan Tan <jonathantanmy@google.com>, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 12:45=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Mon, Feb 26, 2024 at 04:56:28PM -0800, Kyle Lippincott wrote:
>
> > > We use inttypes.h by default because the C standard already talks
> > > about it, and fall back to stdint.h when the platform lacks it.  But
> > > what I suspect is that nobody compiles with NO_INTTYPES_H and we
> > > would unknowingly (but not "unintentionally") start using the
> > > extended types that are only available in <inttypes.h> but not in
> > > <stdint.h> sometime in the future.  It might already have happened,
> >
> > It has. We use PRIuMAX, which is from inttypes.h.
>
> Is it always, though? That's what C99 says, but if you have a system
> that does not have inttypes.h in the first place, but does have
> stdint.h, it seems possible that it provides conversion macros elsewhere
> (either via stdint.h, or possibly just as part of stdio.h).

It's of course possible that on some platforms, stdio.h or stdint.h
defines these types (or includes inttypes.h internally, which defines
these types). However, I think that to be "correct" and for a compiler
to claim it supports C99 (and the compiler _must_ claim that because
of the guard in <git-compat-util.h>), inttypes.h must exist, and it
must cause these symbols to appear. If there are platforms that are
claiming to be C99 and inttypes.h doesn't exist or doesn't provide the
symbols it should, I don't think we should try to support them - they
can maintain platform-specific patches for whatever not-actually-C99
language the platform supports. Basically what git for windows is
already doing (presumably for other reasons), as far as I can tell.

>
> So it might be that things have been horribly broken on NO_INTTYPES_H
> systems for a while, and nobody is checking. But I don't think you can
> really say so without looking at such a system.
>
> And looking at config.mak.uname, it looks like Windows is such a system.
> Does it really have inttypes.h and it is getting included from somewhere
> else, making format conversion macros work? Or does it provide those
> macros elsewhere, and really needs stdint? It does look like
> compat/mingw.h includes it, but I think we wouldn't use that for msvc
> builds.
>
> > I think it's only
> > "accidentally" working if anyone uses NO_INTTYPES_H. I changed my
> > stance halfway through this investigation in my previous email, I
> > apologize for not going back and editing it to make it clear at the
> > beginning that I'd done so. My current stance is that
> > <git-compat-util.h> should be either (a) including only inttypes.h
> > (since it includes stdint.h), or (b) including both inttypes.h and
> > stdint.h (in either order), just to demonstrate that we can.
>
> It is good to clean up old conditionals if they are no longer
> applicable, as they are a burden to reason about later (as this
> discussion shows). But I am not sure about your "just to demonstrate we
> can".

Yeah, I'm also not convinced the "just to demonstrate we can" has much
value. I was trying to get ahead of future discussions where we claim
it's important to never include stdint.h (because people remember this
discussion and how contentious it was) and think it might misbehave,
and instead just include it in <git-compat-util.h> to prove it
_doesn't_ misbehave, and thus start to allow usage in self-contained
headers when necessary.

> It is good to try it out, but it looks like there is a non-zero
> chance that MSVC on Windows might break. It is probably better to try
> building there or looping in folks who can, rather than just making a
> change and seeing if anybody screams.

I think I miscommunicated here, or had too many assumptions about the
current state of things that I didn't actually verify. When I wrote
"and seeing if the build bots or maintainers identify it as a
continuing issue", I was assuming that we had build bots for all major
platforms (including windows, with however it gets built: mingw or VC
or whatever), and I included the "maintainers" part of it for the long
tail of esoteric platforms that we either don't know about, or can't
have automated builds on for whatever reason. I agree that making
changes that have a high likelihood of breaking supported platforms
(which gets back to that platform support thread that was started a
few weeks ago) should not be done lightly, and it's not reasonable to
make the change and wait for maintainers of these "supported
platforms" to complain. I was relying on the build bots covering the
"supported platforms" and stopping me from even sending such a patch
to the mailing list :)

>
> I think the "win+VS" test in the GitHub Actions CI job might cover this
> case. It is not run by default (because it was considered be mostly
> redundant with the mingw build), but it shouldn't be too hard to enable
> it for a one-off test.
>
> -Peff
