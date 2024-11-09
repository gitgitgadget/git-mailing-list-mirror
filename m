Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D6F1448F2
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731157143; cv=none; b=TJczxEplg3JgNZ/bPVA0KLTShtd25SM/FHUeDoxdl7TYnXzQJosxa8A1QgaCTT/gWBDwG4CluvgQwuZ4gwjJmeVXWWqtZuA5Z6p7/za40GE8FmWvzq4elWJK4fvIEaczEWl71xKwDJtQ8JSp5xqd3x4nQzuvYdzBFwVH4DBOrok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731157143; c=relaxed/simple;
	bh=wGKJYHzOc3msvACWP92kRjCK6HLOHoMgxm0D6LU9d2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKXgbIflKHClAZKclPdwYhg+AtU5HOeoaGP3D9uMtYJAbcqfi0EpDF+DGN4mw6HUw84AARHMSRjvBulwkCTtKMgE0txsOmERChwZm/8wgVioGsY6knfpaoSPRbIOCwESBgEEtmuvSYEi4GdWoKM/04wKQp9GAC6z0/fOZGRD790=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2lwqqY9; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2lwqqY9"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e30db524c2so2572410a91.1
        for <git@vger.kernel.org>; Sat, 09 Nov 2024 04:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731157141; x=1731761941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Epo9u8dov8ZpvUtbyjnujCkWlSvNmA9YbHCVFypFbac=;
        b=b2lwqqY9O+2Jnhd1gzt4UdKcD4G3z8Io4rlT6Am87QCACtiRTjT9bdtR/1Bz6BoibL
         G+EcJIYOYIM9RU3YCUrKL1Pi4md9W1fXFt+7TzQJDycQEXwvcefbo9pTuA6J6N1iIQt4
         FRAYbmudbLdjFNQqnpS3DQ1gNKWtSH4t+dqEZZENJMOJ3Is3a6aO5V/kSrwnnZUKxgTx
         5i/iAaR9Kc/pWoTQfF9soLNewYgZeb/DEonsrpC8S3OMvNTfq0o6vVthAX5PwKHV/SDD
         QmT5I8sa1fMUbfzWnr+NNXeE5OYaG6hAjt/SXu3O8tWPZBQUrdQWa5L0yMXNziqMOTCp
         CIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731157141; x=1731761941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Epo9u8dov8ZpvUtbyjnujCkWlSvNmA9YbHCVFypFbac=;
        b=eBVoG5SziFKRmhMYp5v4uiA/OVy/UUQauLO47YjxBAcoPV/GGWSVPN8ZfOptAAZctt
         9TbuQvh2t6SWOeBbqWdb/9rAMB0Njqx/LJbVA+earOFM9FA2voZb3Fu7cVoYJ7Q7HGIG
         WMVShcGWKbY9wr/ZEOmZhNC118Aq5E9YArwSA0SLyR/PuMGGmIOIR+J1W83yCJeubtop
         56hT6kobxdTg7aSnLLqJPOAvGLn1duV4X0wK2KgtZya/qm7tkqvJgJ6PSeX7gsErCZxe
         OHlAY5bvP4zK3RQSLce+lpasvq+uEzXgLI8nSCVRYFOsnsGK5a6fjhiEq+tVqmcByrAH
         +Beg==
X-Forwarded-Encrypted: i=1; AJvYcCUmzaoQmmleDN5TU29SPKQpgpidfO7BLpnkC1mZPOdyDOlpkRvEVI1G+UOq8DGlfsBIYcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Nelm0bj44ejzlA3gdG/5+LUWYs0SFrTiGbTP9cUHxw5bDLJD
	Hmhv3DS+zpGZDtMneqjgbzJm4wMJAQNHmy2+P+0NZgQuz0Q/2HbC
X-Google-Smtp-Source: AGHT+IEEttyS9nAsOYKGOi1JoauKwUHTW6Z6q3UnCejk+zOHb2HXSgaNziARgMbQqOYvvWoRL/39Ug==
X-Received: by 2002:a17:90b:4fcd:b0:2e9:5d94:5992 with SMTP id 98e67ed59e1d1-2e9b17814f0mr9156360a91.31.1731157140930;
        Sat, 09 Nov 2024 04:59:00 -0800 (PST)
Received: from gmail.com ([172.56.122.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e458b2sm46025545ad.167.2024.11.09.04.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 04:59:00 -0800 (PST)
Date: Sat, 9 Nov 2024 04:58:56 -0800
From: David Aguilar <davvid@gmail.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
Message-ID: <Zy9ckDezMSKVA5Qi@gmail.com>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local>
 <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZyjlvNJ4peffmGZ1@nand.local>

On Mon, Nov 04, 2024 at 10:18:20AM -0500, Taylor Blau wrote:
> On Mon, Nov 04, 2024 at 01:17:00PM +0100, Patrick Steinhardt wrote:
> > > I admittedly have a hard time squaring the benefits and goals we have
> > > with Meson with the cost of learning a new build system, and/or moving
> > > away from Make entirely.
> >
> > I guess this depends on the exact persona you're optimizing for. There
> > are three main personas involved here:
> >
> >   - New contributors. This is a group of people that I think would
> >     benefit from Meson. They get integration with their favorite IDE,
> >     have easy ways to discover how to tweak build instructions and can
> >     use standard invocations for Meson that they might already know from
> >     other projects.

As someone that was once a New Contributor, my perception is that new
contributors are more likely to be familiar with CMake due to its longer
history and wider general popularity.

CMake has standard invocations and IDE integration so this isn't really
a Meson-specific feature.

That said, if we mean, "Linux/Unix-savvy New Contributors," then
I can understand why Meson might be a favorite, and perhaps this
might be the crowd we are looking to target (in the same vein of
the original argument for why Git uses C instead of C++).

The remainder of my reply assumes that we are targetting a general
audience (in other words, including Windows users).

Disclaimer ~ I don't use Windows so I'm making some broad assumptions and
generalizations about that userbase.

> Patrick Steinhardt wrote:
> >   - Packagers. This is another group of people that would benefit from
> >     my point of view. This is mostly because Meson has certain standards
> >     for how to approach problems, and thus the packager would know for
> >     how to handle things. They don't have to manually track build
> >     options and changes thereof, as these can be easily discovered and
> >     because Meson will error out in case invalid options are passed.

CMake's option() variables and its GNUInstallDirs module pretty much
handles all of the standardization that packagers are looking for on
this front, so this argument doesn't push the needle towards Meson over
CMake from my perspective.


> Taylor Blau wrote:
> I appreciate your thoughtful response to my concerns here. Please feel
> free to correct me if I am wrong, but I think the bulk of your argument
> is captured fairly well by these three points, so I want to focus my
> response here.
> 
> Responding in turn, I think my feeling is something like:
> 
>   - Long-time Git contributors are going to be the ones who will most
>     frequently use the new build system. I am definitely sympathetic to
>     getting too comfortable with our existing tools, but so far in your
>     response I have not seen a compelling reason to switch the project
>     to use Meson.

Likewise, I have not seen a compelling reason to not focus the
effort on CMake instead. In other words, why not enhance the current
status quo (Make + CMake) instead of trying to replace it?


>   - New contributors are a group that we should be optimizing for, I
>     certainly agree with you there. But I think there are a couple of
>     points that your response glosses over:
> 
>       * New contributors should be telling us what build system they
>         prefer, not the other way around. If we are going to switch to
>         using a new build system to better accommodate new contributors,
>         it should be because either (a) they have told us what doesn't
>         work with 'make', or (b) we have a bulk of evidence that new
>         contributors cannot easily build the project.

As someone that was once a New Contributor, I would be more comfortable
with CMake (over Meson) because it's widespread and because it has
less dependencies.


>       * New contributors do not interact with build system internals
>         nearly as much as more experienced contributors. I would imagine
>         that the vast majority of those interactions are simply running
>         "make" or "make test".
> 
>         You mention a handful of other niceties that Meson provides,
>         like language server support, but I am not sure that I agree
>         those are (a) the responsibility of the build system to provide,
>         or (b) that those needs aren't already well met by the vast
>         number of existing tools and IDE integrations that can work with
>         ctags.

CMake has all of these same bells and whistles, and it's already present
in git.git. LSP support just means being able to generate a
compile_commands.json file, and the current CMake setup already does
that.

The one thing that no one has mentioned is dependencies.

CMake has less dependencies. Python is arguably a liability in the build
system arena, and Meson requires it.

Furthermore, if you must have your fast Ninja builds then CMake supports
that too, but, critically, it's optional. If you don't have Ninja then
you can use CMake's Makefile generator. Meson, OTOH, requires
Ninja. CMake seems like a more pragmatic option in that regard.

Sorry for derailing this thread to share my Meson vs. CMake opinion, but
if the main con that the Meson website has to say about CMake is, "The
scripting language is cumbersome to work with. Some simple things are
more complicated than necessary." [1] then my general feeling is that
it's not a very strong reason for Git's needs.

[1] https://mesonbuild.com/Comparisons.html#cmake


>   - Packagers are something that I admittedly have less exposure to than
>     the other groups listed here, but I think my feeling there is
>     similar. While they are more likely to exercise far more parts of
>     the build system, I think we should also only be switching to a new
>     build system if there is evidence of significant, unmet needs by
>     packagers, which I have not seen.

I concur with that. As someone that deals with packaging I strongly
prefer tools that have minimal dependencies, just like Git. Meson
brings along extra requirements (namely Python, as I mentioned before)
whereas CMake requires just a C++ compiler and Make.

On that front, Git's Make-only setup is pretty wonderful from a
packager's perspective because all you need is Make, so I don't
think we would ever want to ditch the Makefiles, and that's okay.


> > > I feel that if we are going to pursue Meson over CMake and/or Make, we
> > > should have a clear plan to either get rid of CMake, keep it up-to-date,
> > > or something else.

We should also have a strong reason to transition to Meson over the
"something else" option of improving the CMake integration instead of
trying to replace it.


> > I fully agree with all you're saying here. Whatever the solution, the
> > new build system should be a proper first-class citizen and should be
> > exercised by our CI systems such that they don't silently break.
> >
> > I also agree that it's going to be a hassle to maintain three (or three
> > and a half if you count autoconf) build systems. But I don't want to
> > break any users out there by dropping everything but Meson immediately,
> > so I think we just have to accept multiple build systems as an
> > intermediate step. How exactly that would look like is certainly up for
> > debate. My take would be:
> >
> >   1. Adopt the new build system and start exercising it via CI.
> >
> >   2. Drop CMake.
> >
> >   3. Drop autoconf.
> >
> >   4. Drop Makefiles.
> >
> > This should happen over multiple releases such that every step will pull
> > in additional user groups, which will make the new build system more
> > solid overall. I could see that one step corresponds to one release
> > cycle, but I'm also happy to adapt the pacing as necessary.

My take would be:

1. Enhance CMake
2. Drop Autoconf
3. Profit?

This would not need to happen over multiple releases. There'd just be
one minor or major release where (2) would happen once (1) has reached
some substantial level of maturity, and that'd be it.

Arguably, we could even do (2) before (1) and it'd be fine.


> I have a hard time imagining the project ever dropping its Makefile
> entirely, if for no other reason that make is available nearly
> everywhere that we want to build Git, and the Makefile is the product of
> nearly two decades of work to make it compile anywhere.
> 
> If our tree really is going to have a Makefile in it forever, then I
> think adding Meson (even if we remove CMake support) has many of the
> same challenges as the state we're in today "supporting" Make and CMake
> in parallel.

I agree, and from my outsider perspective it seems like a simpler answer
would be to double-down on CMake rather than having to adopt another
system and do the whole deprecation dance.

My perception is that any benefits we would get from supporting Meson
would also be present with CMake, but with less effort.

That's just my opinion, though. Perhaps there are strong reasons for why
Meson is a better tool for the purposes of attracting New Contributors
and improving our day-to-day usage, but the benefits are not immediately
obvious to me at least.
-- 
David
