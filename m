Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCD44316E
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345500; cv=none; b=W7Np3FDjjYTXbD2uuh9A28UNT7sV4XdR2B4/r04eSDGiLGvM4ub76rrEaUiEroi6yUowCBqquiTcINuSuZgASy6ZRI6frLPJgdYvAjJ5OxGab3b9iNaxoUIivSeaEcpaM888LrfWyNql89q+TvNyt7ZAQdd4Nq+gqGJ7c4+dKqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345500; c=relaxed/simple;
	bh=AcnJTwLC/5BTL/CAOZaSgnh4uTXVjnJROV3Aifzg/dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASJXwvdJJ4tK07dd7MMw7tl17jj/CRKYRzKQbTt5ipKzdlBULK/8ayEoFlBX60Qd9hgMhn/ff+qvXgUbrwsCCG6SKczWrvuSgqrlaTXMP4R/1tPvVgd84f9FwWuGE369Kmp58coJFdjOdhhbnP2dYsos8p1ZEd+EIJEigXfzx0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHAtxZdk; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHAtxZdk"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-61bf9ef4cc0so2678673eaf.0
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 08:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757345498; x=1757950298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htT7Wu9TZEm4BG7NIemhwR4wWLlfGjq7sLxnceILmRg=;
        b=AHAtxZdk0K4oYIDH7DGfYWjHB3niQgZNpIJ9iU9RRQLe4lXLgm3sGeO20aYZKjEi7T
         4HMPgKdH+UaPdZzZBm7Xrrwm8YAOvl7ReK7EnGWncyyrq0e1cLlEnPu+QXAOQMQKIqoI
         Ay1VMFXHA4/IqabE02/64n5QWX/xGCko/4OSoLwdOLUiIFtqlUruN7mQqiHxzO1W62NO
         SmAjDU6KgD2+4oL59hIOThr3VaqEHV+GHiQGpVKtujVMyF7/2DCNiyIgwVOyNaWqZlbg
         ejqOCc8QiI8gwg4Mz955TAVa/WE9H7d3mCO/E18oCDuhLhU0h1bnQbB5rva4DI84/sG6
         A4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757345498; x=1757950298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htT7Wu9TZEm4BG7NIemhwR4wWLlfGjq7sLxnceILmRg=;
        b=PsBCV/EoeqIOUXzBFm77jXTP8cRSYD70CX4qJr35CGVWOnGzJbM9QYntqhfOakoePI
         zF0RM1x3yrpegexUxmfM7WetarQqmjrZWh8MFNeNzTcyEG/IQZoruvPTgbYKcRKssnnN
         mKLW00Vw6SXtaOD1dlzdrvzN43HzTBhVMu7LDNGbqOY185uQc0YnJZHh/fVqP4EVflbe
         bGXlEogYlssh0FPYKbnxRt5aOUxs5OdmmMrW0J4SC6L8IXwusg2KVcfBh16XZCDdX5nf
         YmCL4QdQgeojvthxHQ1PeFFBUcQjAygcHfOVFloZZG4r+wGb82crtxjNTr3uKs0mXT/i
         7Ung==
X-Forwarded-Encrypted: i=1; AJvYcCX/G90vnqDABVAE2biPuvGwGvGzck7Vd0KEg+Wrmc5jnSuMQTGDlc09aT03qGWUHVUo8BA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZa5nWAYfp+jouFjYCrOP0uX7avyz0SajSJpzwI5ZAmxREFBDx
	2Q/hO21dI4kroa91YI7I0bL1x1PqMs9aYjh+nnuiWqCeN8r1rvse8KKSyGjnzoEnMzoKeiwkYHD
	J+OUo0WBqYsjqjPhpCqZ6cYXK7HHJQio=
X-Gm-Gg: ASbGncu77rVV6cMDNLZ02H4kC9ulebWyE4CZhwZiM6sgaociSy8QYYcQ9SkQ2IFjqc/
	IQ7aIwrTOvM+lgsC43MUlP28Cnx0rExBlUnkrFdZBSYovkAz/bo8Eo11RxwSZuKqKvxV05VKihE
	grNQY1FJP31PDkooc5i+LmsJStKGnB27kajpEgoBwKB+97DWRb3Gwj5G/R2+xUFYDLzqxExc9/y
	kZkMxyeb/XO0ZiOUTrigNjo5lrMUtrQYs3w6tbzxe5EpApl
X-Google-Smtp-Source: AGHT+IF7GNJR0EWQJ0CvxisoJzcs4mYAIyop05G+q3Vg91V2fHYvRDXeHtWG9rg9QTfs9Abpgg5wVXxLYRqHBMQcIOw=
X-Received: by 2002:a05:6808:81cf:b0:43b:5288:2913 with SMTP id
 5614622812f47-43b528840f1mr154374b6e.50.1757345497984; Mon, 08 Sep 2025
 08:31:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
 <xmqqsehc1ypi.fsf@gitster.g> <aK9mx2XemppIaKVI@nand.local>
 <xmqqh5xszf91.fsf@gitster.g> <aLbSA5KsBdD4wW_B@pks.im> <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>
 <aLfU5sEa-RE3X4G2@pks.im> <aLjj9cG9_K6YLfeA@fruit.crustytoothpaste.net>
 <aLl6iFXeAvL_hvqR@pks.im> <CABPp-BFNoLC+TdtuEq5Nx+VcFJ-WFga2r0E+eq=fFaaCN_sRGg@mail.gmail.com>
 <aLqIHCdlbwF5X6Cm@pks.im> <CABPp-BG3Zcw63vNziy86MvYNubefn1SmPvXefpqpA=a+42KT8A@mail.gmail.com>
 <042f01dc2011$da9dcda0$8fd968e0$@nexbridge.com>
In-Reply-To: <042f01dc2011$da9dcda0$8fd968e0$@nexbridge.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 8 Sep 2025 08:31:26 -0700
X-Gm-Features: Ac12FXx7LMxms4bCsVCASiX0SF18Df4K8BG6C40c9IF2gJ9q0cb0Uf4PV2i5SDs
Message-ID: <CABPp-BEEU0yhurwewuRjrceU+AeHy9vYzXaOFmK5u0nnoSbp6w@mail.gmail.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
To: rsbecker@nexbridge.com
Cc: Patrick Steinhardt <ps@pks.im>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Josh Soref <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, Christian Brabandt <cb@256bit.org>, 
	Phillip Wood <phillip.wood123@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>, 
	Sam James <sam@gentoo.org>, Collin Funk <collin.funk1@gmail.com>, Mike Hommey <mh@glandium.org>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, Ezekiel Newren <ezekielnewren@gmail.com>, 
	Josh Steadmon <steadmon@google.com>, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 9:10=E2=80=AFAM <rsbecker@nexbridge.com> wrote:
>
> On September 7, 2025 12:10 AM, Elijah Newren wrote:
> >Sorry for the delay; life outside of work is challenging at the moment..=
.
> >
>
> I am going to address the critical point mentioned below and snip the res=
t for brevity.
>
> >I still don't see why distributors _must_ ship the latest version of Git=
 and why folks
> >on some platforms are considered broken if they are using a slightly old=
er version.
> >Let me ask again: has anyone answered why this is considered mandatory? =
 If they
> >have, I've missed it, but I've asked multiple times.  Even if you want t=
o lump
> >"distributors cannot build a newer version" under the umbrella of "break=
ing
> >changes", I argue it's a much different kind of break and one which meri=
ts different
> >timelines for handling than e.g. lumping it in with 3.0.
>
> I do not see that distributors _must_ ship the latest version. Suppose we=
 are on
> 2.51.0 and a CVE comes out that prohibits its use in an organization that=
 does
> not allow any medium-high to high CVEs. This represents hundreds of thous=
ands
> of impacted users in my community alone. How does the CVE get applied if =
the
> latest cannot be built and the git team does not apply the CVE fixes to o=
ld
> versions. Personally, I do not care if git versions are different between=
 work
> and home, or even between CI/CD and other platforms. I don't even care
> if I have to use JGit instead of git in some situations (which I see is a=
 likely
> outcome of this discussion). Is there an official statement of what an LT=
S
> means? In other projects LTS is typically, and formally by policy 5 years=
.
> From what others have said here, positions of 6 months, 3 years, and
> "apply it yourself if you want to continue to use git" have been made.
>
> The core problem of adding a breaking dependency is when a CVE comes
> out that prohibits git from being used at all. If the git team is not goi=
ng
> to provide a clear statement, one way or another, if how CVEs (at
> whatever severity level) will not have a commitment of any kind,
> then distributors are essentially cast adrift and on our own. It would
> be helpful of those of us who donate our time, for no compensation,
> are able to plan for this in a meaningful way. Please remember that
> we have to justify our participation to our management teams to be
> allowed to continue to participate. Nothing is free from this end
> and if fixing (not just applying fixes) CVEs are now 100% our
> responsibility, if would be critical to know that when we build our
> business cases to our bosses, who I am fairly certain will say an
> emphatic no.
>
> Also remember that without support from the git team, the
> code base is no longer the same, meaning the auditors will not
> necessarily accept fixes from third-party sources. This particular
> point enabled adoption on some platforms, particularly NonStop.
> Adoption was at 1-2 customers when we had a divergent code
> based because some platform fixes being different from the
> standard code-base and could not be certified as valid. Once the
> code-base because common, adoption was rapid and enthusiastic.
> If this goes away, I suspect that adoption rates will go negative.
> I am aware that that particular discussion is actually happening
> in some organizations in my community right now, with companies
> looking for alternatives to git based on this discussion thread.
>
> With over a decade of respect and participation,
> Randall

Thanks, Randall, this is useful information.  In regards to one point
not fully covered by Phillip:

> Also remember that without support from the git team, the
> code base is no longer the same, meaning the auditors will not
> necessarily accept fixes from third-party sources.

Why does it need to be "third-party" sources?  Linus years ago blessed
having someone else be in charge of providing updates for stable
releases of Linux.  Junio could do the same with Git and similarly
mark an individual or group of people as the maintainers for the last
Rust-optional version of Git, and those individuals could make
official releases of Git with extended security fix support.  Then
it's not every platform repeating the backporting work that needs to
be done, but rather individuals from the affected platform(s)
collaborating on that work and then making official first-party
releases.
