Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7298376
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 05:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743744133; cv=none; b=Py4sp5SdpmuUy5hZMn2jbyeyAA1NrbyVitmXHKLov/8pxurNGpq7lxk2oeJT7J/WCaQXuYYjH78ivVl69RweOxbVBfDs3MrQ5miMB172lEqWr9ZpzVQzBEWfv66oKtzeVsG8OgS2eU5Yxi56Qj4OqpsKVa73ta8rmtitbNwua1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743744133; c=relaxed/simple;
	bh=VOLks4WSIviWHJZ6dtHbtNXxpxcwIPq+jSLjgmlVFNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dW5Hwy9pQjajgkMV4aH0AXnb89Z/XHYpkd+3I4K/t4KITvbcCBcBsP+BleF/oYFG8OaUwUNzrzUfRGSpgvMJRDohOjMOqfWL5N1YgHDY8whj3OCfIoKcs9Al/6NgXPVbQ6iGHXgkEpR7s7YfCR0o+zKukLp5QuoMOUCZrBRmTl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2eex/bJT; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2eex/bJT"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5cbd8b19bso3654a12.1
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 22:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743744130; x=1744348930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWn9fvf8bY0c4MGWf/sM42pj5aGXdn/e16ygPdch7cE=;
        b=2eex/bJTwwhZAoiPkN1PFBx3PahBx+6typJmjWKsp4rDixFRyfFVG/F2FANUvyO36R
         izopdiYc6xX3BSCyJYvmv15w0k37W3ne5giBkJNSe+yABV36lfWwiV0h4LP7mK9dzxKE
         Q1JaG5iEo4xg3WCjdbkVOCGmCVQFqX4GWvCtJdjJ+/igUbgPJaF72J9rvT+zZSisaT+u
         PB1yhnZIbgUSY36/3hdxqzyKZnPfMcL79vr0t/V6nyp/Ebq1T+Rm68ag10XUBCKjAzqT
         bms/f1Ksmvs2PyWJJLS+6figtrtxxDs1U8JekI/4q1Wna1e3+CYw8GJUfHdA61MHqYts
         LkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743744130; x=1744348930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWn9fvf8bY0c4MGWf/sM42pj5aGXdn/e16ygPdch7cE=;
        b=WgkF4O4TPlrQKynuWPEMJPLbDg8ui9MUDNjknPlK4qvGeAVWvC6Xjm9okzKTY43uxY
         FMVa1f9i2fPyX8zKf+7TK7ygDoBwQWwmJ8pj7ldauWDXVb26FyP2mY7VUgN0EHfS97//
         Gnjua/AfC0+Q5nV6/dDDvZk2ZaoVdHjiCu2VACAUP0dLVMhQ1mdS/ev7AmTfiexRDLGs
         wsROSm9tDEUCHk8JuPI16oqLnqa6ZNP4NeoJsVDYMvn6tVVupNhKJMMVaFYEfq9qBKCk
         +rhlp5Pu8/TytQ5KPLtP80wjNdWGE17ObOzs39Nn43p4GrHOXy8edLMHLA6zNhmxlVDa
         dkLg==
X-Forwarded-Encrypted: i=1; AJvYcCX2AAe48RhiilRIHTwGJC1N+V7G2116tFc0U8gAzIb9UnhEqLLk1RgYS7LcMGAVnaGVJLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGxoV8w5oOUglyVoWz47yp+0wGN/QYmzTVVKVcFZOE+xRUUKbD
	nPZddez7nvatyYDsRj72V47f8kMWnL2+uC1aITJVIZApGlBO87Eic2KN/WqMIfWbeWVhqITz3li
	mI2sx/k4+n3H6AdltyYP4XTQVzmGcvVS23NfV
X-Gm-Gg: ASbGnctdNeUpJrHVxmfCAdcOYdMMAbwrXPGWEpvoE7uAxniWm0cIIidZsrqsnmzSH/6
	/KHaANIfaiSOn4PkLvch3aKk8uop5hmJJCHEi4TgVNGs9oZovJ6KMggeUgxYwG0gcpfxPYKjsUq
	68cBe38zMnRcp7p86oZNja1S0DiS3fXzaDVWg0
X-Google-Smtp-Source: AGHT+IH5v2RV8+yvNirBWiD3U/TmSCGsE4Zy7iYwyllLD+hUn9Pufj1GdBbjSIutzxCPKSmSXTkXC5SV8EBAtcoA9Z4=
X-Received: by 2002:aa7:c450:0:b0:5dc:5ae8:7e1 with SMTP id
 4fb4d7f45d1cf-5f0b4947ea6mr64590a12.6.1743744129444; Thu, 03 Apr 2025
 22:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com>
 <D8X5I3W7K1DI.2JYHGNY9L7ZD3@buenzli.dev> <CABPp-BECTrVp9X6bVmzU8LEeYsC3KbzeJvAaDPN+FgZz_uEhmA@mail.gmail.com>
 <CABPp-BFYoZ1cuUMJPhWhtgntS0D-E=ZF+8_KS7gC+ShXjTrEDg@mail.gmail.com>
 <CAESOdVB4yrDQ1v1BZtPiHDJwbaRVN6tixWg9eWNmBitXyqAh6w@mail.gmail.com> <CABPp-BHWFaUHAXwuddNpD1w=Fe7BK=9-Bc=-b9yXbqqWsQ8_pw@mail.gmail.com>
In-Reply-To: <CABPp-BHWFaUHAXwuddNpD1w=Fe7BK=9-Bc=-b9yXbqqWsQ8_pw@mail.gmail.com>
From: Martin von Zweigbergk <martinvonz@google.com>
Date: Thu, 3 Apr 2025 22:21:57 -0700
X-Gm-Features: ATxdqUF73SSuNzCMfxOTE5Scf78W_4_zphTQ26w_Yte3OPiQ7pyYZl-Jw99qbCg
Message-ID: <CAESOdVArh6Vksd9bktBz4DBqOzvoydfh6_DZcm2t9kJ5F-s1EQ@mail.gmail.com>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
To: Elijah Newren <newren@gmail.com>
Cc: Remo Senekowitsch <remo@buenzli.dev>, Git Mailing List <git@vger.kernel.org>, 
	Edwin Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>, 
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Apr 2025 at 22:00, Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Apr 3, 2025 at 8:47=E2=80=AFPM Martin von Zweigbergk
> <martinvonz@google.com> wrote:
> >
> > On Thu, 3 Apr 2025 at 19:40, Elijah Newren <newren@gmail.com> wrote:
> > >
> > > One possible simple solution here is just to treat change-ids (or
> > > there abbreviations) kind of like abbreviated hashes -- they aren't
> > > guaranteed to be unique.  If the user specifies a change-id and there
> > > are multiple branches with such a change-id, we provide the user an
> > > error much like we do for abbreviated hashes.
> > >
> > > Is that what folks have in mind?  If so, I'll be happy to drop my
> > > reservations about this aspect.
> >
> > Yes, that's close to what we have in mind. I think I just didn't
> > explain clearly that it's mostly harmless in at least Jujutsu if there
> > are multiple commits with the same change id. If there are multiple
> > visible commits with the same change id, then you'll just have to
> > decide what should happen when the user tries to refer to commits by
> > change id. We currently let it resolve to all the visible commits with
> > the given change id.
>
> resolve to all visible commits?  So the Jujutsu equivalent of 'git
> switch <change-id>' would simultaneously check out N different
> branches?  Or do commands which cannot accept multiple commits just
> throw an error in such a case?

Yes, the latter.

The closest equivalent of `git switch` is `jj new` and that command
actually does support multiple commits - that's how you create a merge
commit. But we also have a little safeguard in the form of requiring
you to say `jj new all:xyz` if you really want that. For commands
where it's more expected and harmless to take multiple commits as
input, we don't require the `all:` prefix.

> Doing a "git log --no-walk <change-id>" and have it resolve to several
> commits would be kinda cool...

Yes, this is one of those commands where it's harmless so `jj log -r
xyz` simply shows all (visible) commits with the given change id.
Other examples include `jj abandon`, `jj describe`, `jj diff -r`, `jj
rebase -r`, `jj squash --from`, while e.g. `jj rebase -d` (the
destination) requires the `all:` prefix to allow multiple parents
(making the roots of the rebased set into merge commits).

> Yep, thanks, that answered all my previous questions...though you
> raised one new one that I mentioned above.

Yay!
