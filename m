Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9589B17560
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706082935; cv=none; b=oB3Grg/WrftI/jiw9MzOOctGvzdMLdZkNODWH+S8Y6PRVEC2mjPDB+01vqd/QP5hxUEl4ONmB08xE9djG6LH41O9SEZ0Jxzr2qDIE083HNiAYELFDP+TW4n2Qnr0K+OLeIk6cgXgbLeGhhwnX8kbDkQIoOyPiZVYGAGMzACGWiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706082935; c=relaxed/simple;
	bh=SKOewRywOduiiP43iCfgHDOtA2XmkHb8nkPTIpGLf2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nd/eb8+WNpajuXSiwIe3Roa6JBNEMUvoYAkab2t5C8NmarCBULkUyJ7JHDhCkqcK/PtVdV5wqzkW0QXVknvHX6JOH/8redsGuzRd6zo0KsU/pjXLV+3OQfxvPaIflYV1v0WrK6/X5ZOF8upM0WxnPdf9hzg+R4BvmVjKxlwD4WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+pkWZQr; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+pkWZQr"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ccae380df2so53399071fa.1
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 23:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706082931; x=1706687731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6R0R5wF0vT1Py5Sbv4edWvNCMoOj5DjHc0ehsq+iO9U=;
        b=N+pkWZQr3hActmUpsZblcR/QGRHNgdwkHa+gaHaOb0vNLs7FevGfx2VEqJIXE1zhXu
         0L3w5aByDb8aqoSz5BbS4b1motcwD8/bk3Re3xr8Rt20YEl+k/KyqAYrj4O0vvZ8k4st
         bfXLe5wQhLgxPculTsLOxBko+2eIpjAeyUKVPTdF0amfrzdTXrIsc95eA7i+yPKRj/Mx
         zF+7eB7Foal4dT5ObqcQ+j0LaMCE5sN9egLindstM58DPk0Q7aIQ0/tIJltJadoKQ+Lf
         juxmHlH9IJFKz8LSNyZZaLq8ZoTSxZmtSZvQFcakud0TBPnGbvjMpSNthNHiBth9xgJf
         LIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706082931; x=1706687731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6R0R5wF0vT1Py5Sbv4edWvNCMoOj5DjHc0ehsq+iO9U=;
        b=P0OY/JqoKa2f0Yv2omMn5oQa8fR7vd5ZEkcaIb12eoJb2sBSMr6ysi0EDrBkcfWJM0
         dpxPiQdC94Jwku0YL3wgmyBav8awGOYoIyz5WS58yoEWnswkL59Tz5ULd7rG9OH3B1Oz
         DKosK2LKdn2ds73qJxYj6bWaw7b0m5j2QFO3uIc+wlbJRm+HU4s3zSoWEa3ZOzyYPLTT
         KWu1brjgTifqxaLyAiPToBlwhYlwJuWOhlxOWmO1DwzSKQfm/HyY6lFypXu7cWpYzqkJ
         vv6gkOCuGeqvuJ2K3SrKBCE8Ni3cxNv2/L5YQNsQlDiqZWXqERlqziMYnAkS2AoKe/7t
         o8BA==
X-Gm-Message-State: AOJu0YzZjBAflCM5FImrjP0P32ooRrCDDoLNRyGHHmz72eCdZvd7Hitv
	LVAe0Gv/1tmQtCreYfTQG+A74iRCWwV0c9o7fOQk+KQG7YoNL5SZ6LVm1ICW+t24e5+uz3rrNNn
	QHuGt7+YP9Us45RIPdmbyAko0H2A=
X-Google-Smtp-Source: AGHT+IFUuuLfRojjFRcCDTEzYBY2kwIwN3cISJHgJEqZBGzMUJsiQVycKZp4HaiSSw89uQ9VvPLMp5BWXabLBonWDXI=
X-Received: by 2002:a05:651c:510:b0:2cd:8ee4:83b1 with SMTP id
 o16-20020a05651c051000b002cd8ee483b1mr756958ljp.22.1706082931177; Tue, 23 Jan
 2024 23:55:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZ77NQkSuiRxRDwt@nand.local> <b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org>
 <xmqqjzog96uh.fsf@gitster.g> <006b01da4412$96c6c500$c4544f00$@nexbridge.com>
 <ZZ8ZlX6bf+hjmhN+@nand.local> <007c01da4420$10a7b700$31f72500$@nexbridge.com> <CAJoAoZnHGTFhfR6e6r=GMSfVbSNgLoHF-opaWYLbHppiuzi+Rg@mail.gmail.com>
In-Reply-To: <CAJoAoZnHGTFhfR6e6r=GMSfVbSNgLoHF-opaWYLbHppiuzi+Rg@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 23 Jan 2024 23:54:00 -0800
Message-ID: <CABPp-BHk3KXRBfNdfU8gUpZrRMwBu_YwMSGfPN-NOaNDqEUXoA@mail.gmail.com>
Subject: Re: Defining a platform support policy (Was: [DISCUSS] Introducing
 Rust into the Git project)
To: Emily Shaffer <nasamuffin@google.com>
Cc: "Randall S. Becker" <rsbecker@nexbridge.com>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>, Git List <git@vger.kernel.org>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 3:18=E2=80=AFPM Emily Shaffer <nasamuffin@google.co=
m> wrote:
>
> On Wed, Jan 10, 2024 at 3:52=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
> >
[...]
> > Unfortunately, none of the compiler frontends listed previously can be =
built for NonStop. These appear to all require gcc either directly or trans=
itively, which cannot be ported to NonStop. I do not expect this to change =
any time soon - and is outside of my control anyway. An attempt was made to=
 port Rust but it did not succeed primarily because of that dependency. Sim=
ilarly, Golang is also not portable to NonStop because of architecture assu=
mptions made by the Go team that cannot be satisfied on NonStop at this tim=
e. If some of the memory/pointer issues are the primary concern, c11 might =
be something acceptable with smart pointers. C17 will eventually be deploya=
ble, but is not available on most currently supported OS versions on the pl=
atform.
>
> I hope y'all don't mind me hijacking this part of the thread ;)

Of course not.  :-)

[...]
> Does it make sense for us to formalize a support policy?

Some hurdles that may need to be overcome if we want to do so:

* For a significant number of the discussions I remember, a
significant challenge was that we don't even know which platforms Git
is used on.  That's why we sometimes agree to weather balloon patches
that attempt to use some new option, in a way that is really easy to
remove...and if no one complains for a long enough time, then we
presume all platforms support it and start adding hard dependencies on
it.
* We are often happy to try to fix issues on even obscure platforms if
we get a detailed enough description showing exactly what the problem
is
* However, when reports don't come with a complete diagnosis, we often
will tell people who are reporting issues that we don't have access to
such a platform and someone else will have to dig further.  This
happens more often for exotic platforms (AIX, NonStop, etc.) but also
happens with mainstream platforms (Mac, Windows, and I think I've even
seen it happen with Linux).
* Even when folks report that they can't help the reporter, the work
doesn't always go back to the reporter, because someone else on the
list may respond and dig in; that happens more for mainstream
platforms but can happen with the exotic platforms as well.
* How exactly can we even enforce continued platform support?  What's
the actual mechanism?  I think the only route available to us is
people who care and try to provide reports, testing, patches, new
tools (e.g. our CI runs and gitgitgadget providing reports across
several of the more common platforms, with lots of work to investigate
the occasional weird build issues and flakes so it continues to be
fairly reliable), but what happens if some of those developers start
caring less...and yet we still have an encoded policy that their
platforms are supported?

I generally think we value portability fairly highly, but it clearly
has bounds...fuzzy and even unknown-by-us bounds.  I don't know how to
translate that into a policy, and I'm curious if trying to apply nice
sharp boundaries risks unreasonable expectations on either or both
sides.

Also...

[...]

> I see a few axes we can play with:
>  * which architectures/kernels/OS (do we care about more than the
> usual suspects of Linux/Mac/Windows // x86/amd/arm //
> POSIX-compliant?)
>  * age of architectures/kernels (do we care to offer full support for
> a 10 or 15 year old OS?)
>  * new feature compatibility guarantees vs. core
> functionality/security fix guarantees (which do we really define
> "support" as?)
>  * test provisioning (do we require a VM we can run CI on, or is a
> report generated from a nightly build and mailed to the list OK?)
>  * test/breakage timing (should the above tests run on every commit to
> 'next'? every merge to 'master'? every RC?)
>  * who provides the support (is it the patch author's responsibility
> to fix late-breaking platform support bugs? is it the reporter's
> responsibility? and especially, how does this interplay with test
> provisioning and frequency above?)

That's a great list of questions, but to me it does seem to lean
towards "whatever is supported is supported equally".  I don't know if
that was intended, or just the way I read it.  But if it was intended,
I'd say that while equal support may be an ideal, I suspect it is
pragmatically just too expensive as evidenced by the many optional
features we already have, many (all?) of which have roots in platform
support or the lack thereof:

  * gitk (NO_TCLTK)
  * dumb http(s) transport (NO_EXPAT)
  * smart http(s) transport (NO_CURL)
  * perl regexes (USE_LIBPRCRE)
  * translations (NO_GETTEXT)
  * charset conversions (NO_ICONV)
  * p4 support (NO_PYTHON, affected other scripts in the past too)
  * svn, send-email, gitweb support (NO_PERL, affected other stuff in
the past too)
  * fsmonitor (FSMONITOR_DAEMON_BACKEND)

Also, this list isn't just an "exotic" vs. "mainstream" platform
thing, since even Linux is "second class" in the final category[1].

So, I think if we create a "supported platforms" policy, it should
address optional features as well (though perhaps as simply as "the
support policy only applies to non-optional parts of Git").

[1] https://lore.kernel.org/git/pull.1352.v5.git.git.1670882286.gitgitgadge=
t@gmail.com/

> If we had clearer answers to these questions, it'd be much simpler to
> determine whether experimentation with Rust is possible or useful.

How so?
