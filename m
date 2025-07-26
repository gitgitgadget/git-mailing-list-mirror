Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C558422DA1C
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753574143; cv=none; b=eBTwkqlbr0V6nITxAxIRv+/d26R2JnWPhHaTY1DRxU+bZCHkZZpEGDT6swd/F6frVWMzw62S9r3dW0PTioaEviZ8W6Xhjey7MlXCb+qDyOGUddwJN4PkA3BkLgkucHgNitwIEWUPEewBNaC6F90e8oyR3MABqMdusyo9E5b/zjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753574143; c=relaxed/simple;
	bh=Z+6SnDIE7qRMzCS69oVqYLLdiB50TkyVEdkQ7DAuypc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCGelce5GdWUog/bMHP5ofWVHedbbjtjcL6L7FXONh8/eYS+YgG4l1IcYwnaAspyapkofc8O4J6c5WKa/OLVIgIsKcJB/Un9nspywpgc1uNKB/grGHOMZra70rJq31rGYU2sTtwZEivt5+jmDjKIYKYYKcDT1vGfKpg1j/pfn9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfwJ50CZ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfwJ50CZ"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31ec651c2a1so103743a91.0
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 16:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753574141; x=1754178941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JO3Ff5pMaTiUORUNR/ymq2y9tzeJiWutx6ns5fFZfII=;
        b=bfwJ50CZeeZBziYPyJN3tzHIG7zp0ChJzMEUMhB5CkvLlcM25oRluOVcoQf8i6jJeD
         Q7uRNfrufMPo0f4i+DHE58mbL25W/S+SbWlYerf1voXcnlK77cDzjyQfPeWdfpUPW/2z
         npjDLzr+vDBA8Kyzwtd7UymYHgRdKjMZheQr73dSXvuUcUDmo+0Olao4efFZzGHrfuGk
         wb0jWyz2fa/tlooQJE36mAsBBFl2hLfrGksf/6Ye6V2+jDK3uEjLSXRI1wFitJiN32CL
         GlkRiJRUvI9H7vEynQnZYZ65UsCyx4V+HJFq14mMBI8F6/k4dVG39cFyUpmbR/l+BQXW
         qoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753574141; x=1754178941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JO3Ff5pMaTiUORUNR/ymq2y9tzeJiWutx6ns5fFZfII=;
        b=PQhV0wOm1f3m16dIDryY7X+JCQhY/W0nq8sfF+yRmp7cdWs65UPnX5OZexl8Uej45s
         nZMSLGLmwu0HEi8wiuGlpCEVVa7VOnt0Kv2+vPDVHa5SVLrWxG6Qk36zFpggeyHVFZnm
         PolSn2hh+/dBpX6ntCgwnxy1PWL1Zio6hurJSES5Z0du8GuhwM38fpGalxLSmtN79+rf
         cD3CwuJ6y1iJ+kwhP3FMxWy6Oqhiw98Uitzl/Nji413cU27KCNbxwVVHJbfnK+O70hNk
         lIbAgKXmgZ2N28pHdmrPO2UC3W1njYMxcslw56TE1VvLQk+V5/agQ2bN5a1UCYFdMk10
         g6VA==
X-Forwarded-Encrypted: i=1; AJvYcCUzEK4YcRh2cCzf4M6gMrC+tdnoOchnArBGpTA3p8B0em9AZgYgUs8S8AKTArqKuZn5oBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx14IaqBYvpP8EIlqQfO371uDNX6TMM5lnaFOIS+2GpUpYjBPA7
	bbLAAibpGUJacgHfxRJRUjeyKwK9QiI1AJW7/EMC2imAdSdq8TLUD61sJDnje3NDMX0HVM/Oc2r
	4SN2yVibJbqkGwGn8KYITfNeBFIR4rpc=
X-Gm-Gg: ASbGncucAzOG6kuyFP+FbljO9D7qdBPS748iFh/PHC8etbzkGIHMbis/vW50d2/GfsU
	0xmIle9L5W0x5O19TRq8iBf3Tw06r9loeRIkXIyj3wGEZFvWxqqHCdv/r+4oF+IvBkhGHFhgrkm
	OjgoGacLu/WDtFkdY99JWKjO/94F3qNZRxsnaxygAnJppa1NIMh5V7SuXaDzNQKYh4XCaFgObZd
	NO24oAc
X-Google-Smtp-Source: AGHT+IErq5io+Nr6T0U8UBzmizGJ+rUay3bkD+gJeKm21IVy6xn1uODyA+m47w+JgYTIIvaFlw62Y0k6qWm6OPuSTZ4=
X-Received: by 2002:a17:90a:c886:b0:31e:4492:af48 with SMTP id
 98e67ed59e1d1-31e77a227e6mr10305405a91.28.1753574140865; Sat, 26 Jul 2025
 16:55:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603131806.14915-1-ayu.chandekar@gmail.com>
 <cover.1752882401.git.ayu.chandekar@gmail.com> <xmqqcy9qlfm8.fsf@gitster.g>
In-Reply-To: <xmqqcy9qlfm8.fsf@gitster.g>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Sun, 27 Jul 2025 05:25:29 +0530
X-Gm-Features: Ac12FXxGejoQ9hZQIP-fiKDoe-rNaX0-t16RzmiUl3bHHo22zTK08gWL4hAXPtc
Message-ID: <CAE7as+b2rSiXziZE0a3BdvPZ5h2961vOUX=zgvnjgvwPKbCHyg@mail.gmail.com>
Subject: Re: [GSOC PATCH v6 0/3] environment: remove sparse-checkout related
 global variables
To: Junio C Hamano <gitster@pobox.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, shyamthakkar001@gmail.com, 
	phillip.wood123@gmail.com, ps@pks.im, ben.knoble@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 3:44=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Ayush Chandekar <ayu.chandekar@gmail.com> writes:
>
> >
> > * For 1/3 and 2/3, Junio told me that it was concerning to put so
> >   many calls to `prepare_repo_settings()` so I tried to minimize the
> >   calls and made sure that there's no useless calling.
>
> I didn't mean that the number of places is the problem.  What I
> found troubling was that this is not done in any central place, so
> it is hard to notice even if some random cmd_foo() failed to call
> the function before doing its real work.  For example, shouldn't we
> be able to, at least for built-in commands that have RUN_SETUP bit
> set, centrally call prepare_repo_settings() somewhere late in
> git.c:run_builtin() after we figure out what should be in
> the_repository?  Now historically, setting up a repository may never
> have involved opening and parsing tons of configuration files, so
> such a change may be incurring extra overhead we did not have to
> pay, so it needs a lot more thought than just trying to minimize the
> number of calls, but some performance measurement.
>

I was quite stumped as I don't know what the perfect solution for this
would be. I get your point that we have calls to the function all over
the place and would take some toll on the performance as well. As you
said that we can probably call the function in git.c:run_builtin() or
we can have a call to it in config.c:repo_config() so that just as the
other settings, we will have our repo_settings parsed, which were once
parsed through the same function(repo_config() or git_config()) and
since all the cmd_*() functions have a call to this, we will also be
able to call prepare_repo_settings() there itself.

> > * For 3/3, Phillip told me that it broke user-facing as it will be
> >   parsed quite late in the callchain and might throw an error mid
> >   operation which we do not want.
>
> So has the behaviour change caused by 3/3 been resolved?

Well, I am not parsing it at that place. But, I am relying on an
already existing call to prepre_repo_settings() before the function
using the setting is called repository.c:repo_read_index(). I tried to
narrow down to a cmd_foo() function so that I can shift a call to the
prepare_repo_settings() from repo_read_index() to it, but this
function is widely called and cannot be narrowed down so I had to
settle with it. I'm afraid the issue still isn't completely resolved

>
> A meta-level comment and a half.
>
>  * Please do not use "-- " (that is a line that has dash dash and a
>    single space and nothing else on it) lightly.  It is called
>    signature line and often MUA pays attention to it when responding
>    to a message with such a line by omitting everything after it
>    (which is supposed to be your "who I am" advertisement) when
>    quoting the original.  Since you had one before the "discussions
>    since v5" section and the range-diff, I had to manually resurrect
>    the part after the signature line while composing this message.
>

I am sorry for that. I will keep that in mind from next time.

>  * This throws everything in repo_settings, but these settings are
>    inherently per repository and they are meaningful only when you
>    are working with a repository.  What makes us choose to make them
>    new members in the repo_settings structure, not direct members in
>    the repository structure?
>
>    Not an objection and not a suggestion to move them out of the
>    repo_settings and to the repository proper.  Just wanted to hear
>    the reasoning behind it (and have the rationale clearly
>    documented, preferrably in the proposed log messages).

Yeah, so what I thought was that if it is a "core.foo" setting, I
would club it with other core.* settings in the struct repo_settings.
But other config settings like in the previous patch series,
"extensions.preciousObjects" or also in this series, the
"sparse.expectfilesoutsideofpatterns", I would put them in some local
context or if they're tied to a repository, I would store them in the
repository struct itself. But, as other "core.sparse_*" variables are
stored in the repo_settings, I thought it was better to store the
"sparse.expectfilesoutsideofpatterns" along with them rather than
storing it in the repository.

Thanks
Ayush
