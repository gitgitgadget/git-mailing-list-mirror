Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4802D208A5
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 18:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721933586; cv=none; b=fE1Vmr39AfH1LKdlotZw+ntEA25mU28ezfEMZmg89ezU4+0a9TiSCDnerWgpLGEleP5+Gkto2hYrbFXOeTAKAjq5uJwY1VEBF+KdaV6W2hhrDObnoXf1xgWLS/xcwa7oB56NRt5XvaecvHsvpGTpl0Ie3KKWUKSMUFoCby6r+4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721933586; c=relaxed/simple;
	bh=oIjB/HECpGmwgPLZlSqj8VwhYRAY+NrEPMM7Df6LViM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okrrfSwcKQROGc0umIM2IQThqSyZ0/6WWy6HngbjolJrWsIFqWTJfnEz1L4oA9+epVe3VV1MOSEu41TSMxKpkVBIhPv34h0ghDU5gDLRcU/aJw0kyRf6ZqYmvU5ACKfiRzx/lhANKaKzz/6+idYLRqXglyZyaFr0oaik00N2NQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SSrZ8UJ0; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SSrZ8UJ0"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44fe76fa0b8so54781cf.0
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 11:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721933584; x=1722538384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZMms7uDAD237IVK3hk76l6hUsKGwFG2trwAfRs3cqk=;
        b=SSrZ8UJ0f9w908y3M866EzL2OguAt5nxNzsa12x6psAygJ7gT1vXZ6QLYTj1rfb5Lt
         P4heqQy/Cn11HOi7G0UFeFvxd/gLWSPIc7qV/vZleXYGPi6OsaWrrbneTMzIIR6Xb4Qm
         9CXfcSB4fuH+ZJUgfyYNW8qGDjNeLOLtZyTZXC6mIo9YXqgUZGxykwPO32xmEcsyLGOE
         1dCSkq0RbAEYaKm2Uln9Bg9ZAS2Le3uxOK9KMOKPtzcxXsHXUHV+fFtgokAmuYhQX6FL
         qNlQM/rsedEP91/FviU+JjuCAPD3ztfEHFpVCO054xam7BZ+B8Qyo51ytUvleBBcyJJE
         Ja1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721933584; x=1722538384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZMms7uDAD237IVK3hk76l6hUsKGwFG2trwAfRs3cqk=;
        b=VYbeTYFXr3uinActW21R4CRDElyr3OJXe7AS7i6k8KKhXCxLduWcD+zaq4r8Er5iyp
         A57LVRHdP7PB8c/WFujGt45xskc7b8vCF82DIvjjw3+UFwubnhZ62X/COvkWNiNjzq5h
         mBQAQB+4LBIrRT+WhbzhoK1DdcY/7RVJA3sj8rcfmjSjuFVl6Tdyd367LXKMRIBt8tFq
         FHEbiQ+c1qSF0zfBz9EiG0Ub9QzN6ymXmT/ssJmiP8wG8bMghIYv7dzas6XBwnG56kZ+
         R3wRXCz8v3wD0x5qQg1fM/ju7XedmjamTGB5M4Bmg5UfWQwIiiDi6eGPXa46f8sKssIq
         0asA==
X-Gm-Message-State: AOJu0YzN89zlpbx8f2EBu7+xEKBjVPCQhM9o68AM6efC7RT90DI3YBBT
	DT/iFgjOFUekediTUem6M+gbE7UYwHg9OyBsD/TadnEWh0YIEtC1LTTnvy0UYiwTlBPHxXd30DP
	5C5TjN6ly+Fuub6B02qpuX67MRD46kZJQW6bgys2RCQMf4f3roku1
X-Google-Smtp-Source: AGHT+IHHM++iy/05JNkoOOLuf9yBwXnu/TWuA4zE13rH25AVcbIe1JRcUECnMcmpn1jyMfk5S1l2xuj2p1Eff7D+M4U=
X-Received: by 2002:ac8:7d02:0:b0:44f:ea7a:2119 with SMTP id
 d75a77b69052e-44ff3b32b44mr376791cf.18.1721933583897; Thu, 25 Jul 2024
 11:53:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718173843.2411415-1-emilyshaffer@google.com> <xmqqh6cmmi8n.fsf@gitster.g>
In-Reply-To: <xmqqh6cmmi8n.fsf@gitster.g>
From: Emily Shaffer <nasamuffin@google.com>
Date: Thu, 25 Jul 2024 11:52:50 -0700
Message-ID: <CAJoAoZmKD5su=1-kw7x590zVdkqT1xPMs1VumH1j=aMHtD4mcg@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: add platform support policy
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <johannes.schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 3:46=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:

[..snipped nits, I have fixed them for v4]

> > +* You should run nightly tests against the `next` branch and publish b=
reakage
> > +  reports to the mailing list immediately when they happen.
>
> Can't it be daily instead of nightly ;-), or is it better than
> nothing if you can afford to run only once every other day?
>
> A topic (unless it is during the shuffle time around -rc0) usually
> spends no less than 7 calendar days in 'next', so while I would
> appreciate if somebody runs tests twice a day, in practice you
> should be able to catch a new breakage in 'next' if you run a full
> and thorough test twice a week.

I ended up adding a sub-point to explain cadence preference and
reasoning, since that's a lot to fit into a parenthetical. Thanks.

>
> > +* You should either:
> > +
> > +** Provide VM access on-demand to a trusted developer working to fix t=
he issue,
> > +   so they can test their fix, OR
>
> "VM access on-demand" -> "on-demand access to your platform" (iow,
> physical iron is also fine for our purpose).

Done, thanks.

> > +Minimum Requirements
> > +--------------------
> > +
> > +Even if platform maintainers are willing to add tests or CI runners, w=
e will
> > +not consider helping to support platforms that do not meet these minim=
um
> > +requirements:
> > +
> > +* Has C99 or C11
>
> OK.
>
> > +* Has dependencies which were released in the past 10 years
>
> This is hard to understand and I wonder if we can clarify.  I get
> what you want to say: suppose we rely on library X that is getting
> regular feature and security updates in reasonable cadence, say
> every 6 months there is an upstream release of library X, but a
> niche platform has ported the library only once long time ago, and
> hasn't updated it ever since.  Now the Git project may consider
> helping a port to such a platform if the initial port of library X
> was 8 years ago, but will not if it was 12 years ago.
>
> But if Git depends on an ultra stable library whose last public
> release was 12 years ago, disqualify everybody is not what this
> requirement wants to do.
>
> I attempted to formulate my version along ...
>
>     Keep up with the versions of dependencies (libraries, etc.) and
>     not to lag behind compared to typical mainstream platforms by
>     more than X years.
>
> ... the above line, but to me it is no better than the original, so
> I failed miserably.  But the idea I am bringing to the table here is
> that time of release is not absolute.  If typical mainstream
> platforms consider a release of a library made 8 years ago from the
> upstream performant, functional, and secure enough and fit for use,
> we do not consider that they are approaching the limit.  But if
> another platform uses the same library from 12 years ago, i.e.
> lagging behind others by 4 years is a problem at the same graveness
> using another library that was released 6 years ago, when other
> platforms are using a much younger vintage of the same library
> released at 2 years ago.

Yeah, I think it makes sense to relax just a little bit more, and give
ourselves flexibility to use common sense. I ended up with:

"""
* Uses versions of dependencies which are generally accepted as stable
and
  supportable, e.g., in line with the version used by other
long-term-support
  distributions
"""

It's not quite my favorite, still, because I guess that LTS distros
could get to a point we don't want to support (do we really want to
provide cutting-edge git features to a 25-year-old LTS distro, for
example?). Plus, "just look at everyone else's homework and use that"
feels a little weird.

Will keep thinking on this, I'd welcome other suggestions for phrasing.

>
> Having said all that, everything I removed from my quote I found
> agreeable.  Very well written.

Thanks. :)

 - Emily
