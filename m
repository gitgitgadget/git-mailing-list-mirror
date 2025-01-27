Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B1017D2
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990552; cv=none; b=U9+gSPDKkNpfr6o4GShY3l8A0uujGB05wfvr2oGXgDN65ztKyoCu0MuepRWFkIIALjqLnXNdiXItqEZ7vxd1FdkulVS4YKkDNqrAHVp1SyRmWMfZwJhdTqycqMG128CzCUCOETa4Rh6y7KNnLI7a9Y2DKlTnz+L+5mrTY1ghsQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990552; c=relaxed/simple;
	bh=SPgVxwpJslm3bpTgYPnHZLNPXeBdCw97vi8YLNamzlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwsgksXTvg6UYtdbs9ucRow/RNk/Ny0eofhiwuJEVGPnlG4H+FSah41kvWdTI94E1rtjR7KEBBxRT8Q3cCjQacNgkzd7JyEwzlB6rInadOFHv+i2EMtos1x8ZgCjpFlWu4d4cbU0gO1pDgfXB/S+Aio/QYZVR3RVL9jxyU3eFtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjdojgoQ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjdojgoQ"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaef00ab172so726885266b.3
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 07:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737990548; x=1738595348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrwK+c/ea9sUkeOB15oaVQoE5fyoAlQPx412qfrH0QY=;
        b=gjdojgoQrh+9xdW+gtLtJlwrilLSqrlR3bJhXKDSrrkPEajzxXDjl45LLnQnsLVk/R
         RuJeE8M2qabL2GmpfVWkff+95Z5yVzfL6Zcm4IvL9+YG2fmhndiMG943isqqmblJDcmt
         llN4MqXXQAkJeSmWYQECwgKGu5M/amYKZBowot6TIQ+A38A/nnhSnNvjGffdr7CWdVx7
         5FrCevRuSx+PIHU1yTk0oidHXVw9s7IOk3UWg4J6eNzhSqDIJl8iB6LoFdhm8e6Tyckm
         ybFSinG6mKNA4BQH5ZOGcpsXIxHa63zp9f6ZnXoaiC9g3+LsEXHLSEzOKxy6J7Gqf8Pg
         Roeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737990548; x=1738595348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrwK+c/ea9sUkeOB15oaVQoE5fyoAlQPx412qfrH0QY=;
        b=qOrJVLgi0j4V8mCjFovOxCXVoTVD9uWnSKSmLeFNJaodGod+mBAMXaEau4snD52LAy
         FQnYek9OB7kBAFWx3qCgCBPQc4djsYR3oh94JDbmzoJrE9hN1DSUAMviy+YkA8eLqJuf
         iZ8jWkIYNufm1VGKf1uHPq6UalZqbBnupdo6ZnckrrdKH3DCfGxKRGlczYYq+GWYWTGf
         zOX21MZMD+DdwJgtghgB+gqBOPst+zsYIQep4m6GgD8P0qpv6vVMXP3wCMDnhilE19pF
         +ljrdQPEJaTSk41f3rsGpd9M/3n95l97wA0Ark/OnL1Y/LGxigzxg5hXGILuTxAHdixQ
         Zw+g==
X-Gm-Message-State: AOJu0YxHEwq6fql7TgLvMlHZUEMAGTFyz6xwxi+NW7ISWtPgVodKGEYL
	sD92NXVolCzO8sYizqP+paj/l1fEwQLEXGnIG8LuOogfVfCR27dYyv34YF8e9UrFI6xiwy3wKVa
	xxrg9NLPjvhgA2i9DgF6kRzigoko=
X-Gm-Gg: ASbGncv/hNUCh86ORPtlg9lu3olx5GJY2v9MUONYtxOSDzVPegI3bICvBgexW4GfZ8C
	r59YhYhEBBHFePpIS1yf0vOzxu7tlOL95apP41LK2FdVVzgz4MjSObff4tL/WBVOC
X-Google-Smtp-Source: AGHT+IE8gi5RFjn84rtWKq9+ppv12CTfPBDZtL4vXiBEAfaESLHsjCkozAjf+nsqz2EmaEkKRUj+38j9a1qJk85UEbY=
X-Received: by 2002:a05:6402:5246:b0:5d9:ad1:dafc with SMTP id
 4fb4d7f45d1cf-5db7db073f1mr91982629a12.25.1737990548024; Mon, 27 Jan 2025
 07:09:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910163000.1985723-1-christian.couder@gmail.com>
 <20241206124248.160494-1-christian.couder@gmail.com> <20241206124248.160494-4-christian.couder@gmail.com>
 <xmqqh67fudmx.fsf@gitster.g>
In-Reply-To: <xmqqh67fudmx.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 27 Jan 2025 16:08:56 +0100
X-Gm-Features: AWEUYZltJSb9gL3sr8xAr48XIhxpsPlX95QMLwlzbfriS7LZbOWKcAu0XJYfE4o
Message-ID: <CAP8UFD1t3ch302ys2miqpBhdmRC4+1vLrOe-dyUoF=hrsVQB8Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] Add 'promisor-remote' capability to protocol v2
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Christian Couder <chriscool@tuxfamily.org>, karthik nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 7, 2024 at 8:59=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > Then C might or might not, want to get the objects from X, and should
> > let S know about this.
>
> I only left this instance quoted in this reply, but I found that
> there are too many "should" in the description (both in the proposed
> log message and in the documentation patch), which do not help the
> readers with accompanying explanation on the reason why it is a good
> idea to follow these "should".

In the next version, I have changed the commit message to replace many
"should" with something else.

> For example, S may suggest X to C,
> and C (imagine a third-party reimplementation of Git, which is not
> bound by your "should") may take advantage of that suggestion and
> use X as a better connected alternative, and C might want to do so
> without even telling S.  What entices C to tell S?  IOW, how are
> these two parties expected to collaborate with that information at
> hand?  Without answering that question ...

The improved commit message in the next version says earlier that "If
S and C can agree on C using X directly, S can then omit objects that
can be obtained from X when answering C's request."

> > To allow S and C to agree and let each other know about C using X or
> > not, let's introduce a new "promisor-remote" capability in the
> > protocol v2, as well as a few new configuration variables:
> >
> >   - "promisor.advertise" on the server side, and:
> >   - "promisor.acceptFromServer" on the client side.
>
> ... the need for a mechanism to share that information between S and
> C is hard to sell.  "By telling S, C allows S to omit objects that
> can be obtained from X when answering C's request?" or something,
> perhaps?

Yeah, now this is mentioned earlier.

> > +Note that in the future it would be nice if the "promisor-remote"
> > +protocol capability could be used by the server, when responding to
> > +`git fetch` or `git clone`, to advertise better-connected remotes that
> > +the client can use as promisor remotes, instead of this repository, so
> > +that the client can lazily fetch objects from these other
> > +better-connected remotes. This would require the server to omit in its
> > +response the objects available on the better-connected remotes that
> > +the client has accepted. This hasn't been implemented yet though. So
> > +for now this "promisor-remote" capability is useful only when the
> > +server advertises some promisor remotes it already uses to borrow
> > +objects from.
>
> We need to figure out before etching the protocol specification in
> stone what to do when the network situations observable by C and S
> are different.  For example, C may need to go over a proxy to reach
> S, S may directly have connection to X, but C cannot reach X
> directly, and C needs another proxy, different from the one it uses
> to go to S, to reach X.  How is S expected to know about C's network
> situation, and use the knowledge to tell C how to reach X?  Or is X
> so well known a name that it is C's responsibility to arrange how it
> can reach X?

Yeah, it's C's responsibility to arrange how it can reach X.

> I suspect that this was designed primarily to allow a
> server to better help clients owned by the same enterprise entity,
> so it might be tempting to distribute pieces of information we
> usually do not consider Git's concern, like proxy configuration,
> over the same protocol.  I personally would strongly prefer *not* to
> go in that direction, and if we agree that we won't go there from
> the beginning, I'd be a lot happier ;-)

I don't want to go into that direction either. I have added the
following into the commit message:

"It is C's responsibility to arrange how it can reach X though, so pieces
of information that are usually outside Git's concern, like proxy
configuration, must not be distributed over this protocol."

I think that requiring some global configuration is a good thing. What
we should particularly make easier and more flexible are some details
about the best ways to access each individual repo, like which filter
spec it is best to use. So that if the repo admins decide to move some
smaller objects to the LOP, each client doesn't have to adjust the
filter spec.
