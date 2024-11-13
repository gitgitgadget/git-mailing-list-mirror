Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B6A16DEB4
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 09:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731489719; cv=none; b=Hdk+AaEqEprz2/qdTq5c/D5aqecBqYk3c5YZF0TWVoKoGb7ORErd1/FoJBD8dO5ENtkSHv8sm6cslIqNJ/IDDz3bgKIhzh78feMKBRsjVEQE1cuX4Ou1hjHMpPnX0O7vt+QKzKBhcARk6Bdyv2BSIOolo2HJrl5UYzecFX0HQ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731489719; c=relaxed/simple;
	bh=upyWoQd8IyOdOky0aSypPwF5mJg9wMlAWeAxYYJolXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAEQQp8BECWbEIm2qpF5jv6bK1SHS0vL0jysBNmekW1X7uX04e+F6aHZHslZdTwoUD+ucKapDeed+ICnqjezB//tkul3FSk9mh07fszMgsZjM1VWjXAXr5zgHHSzP2O98M7h2CIe1YoowbpSLRkdmG2NBmJ178mtD19PMKhe6oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myXXUSdl; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myXXUSdl"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cbca51687so65711065ad.1
        for <git@vger.kernel.org>; Wed, 13 Nov 2024 01:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731489717; x=1732094517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7bkWQf21ULQKPDPwuwgoU2omp7IyW87wseUt0GRPNWY=;
        b=myXXUSdlMzmXKlul3cgT4tMYupFDCXhZNpp6z7ZsKXAInnPJB6JI8HMKL2Xkt0Gy+m
         ZUUvJa11hl8qnPVpz6vm9wFcy+p412FtCh3dQ1z/O/Fd2MpC1Y2TuEL6KwT+AWkcF/GU
         rngJA8eZ6wcz+sdxxO3td+XFsQLfcCog7h5sWMxqpwT/bk4MVielB7z14McblMs/AIGd
         P0XdsX4uVbrXSmKMH/iBL9XQyg9AcZnagGT+SL44JzRd8fRDmERyHhqjbM+clQ1kFnZq
         LzAvZ/Tc7sM4XpoawEDoHKVsJlw3TYew5RvxlgUtJNkx4qndfibtodm/3ZjmNpMSPEDH
         ohNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731489717; x=1732094517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bkWQf21ULQKPDPwuwgoU2omp7IyW87wseUt0GRPNWY=;
        b=RZijZQ2zmEWzi2CCwIQDKbQd24uf+LiWgzcgr6bk2bc0Za/YThFmnmGQ8mZxzFoIfV
         ep1YCyqcTum6tGdooZ3h+CVV1p0Zq7iGLkFIZPIeY9Ml8VD0HmTQrUqdvsVyCSbDiUPO
         mjuvz87gq2XZVc2/Zd6FdlJAgCDEftmPkmPr21RLBkB4uyEmmSaFqlfgfy7Q5Bog2cMZ
         1hmhr2LG3LpSydjv9MEzlS74SRpoLQTsoLMvj6Ljey8yIQRnzI2BGMxIHe7pjQTXGfiZ
         ZdOKYg9xHDY4Bw0Wnuazy5bemFLWfRYgK4Paby8TcTbtUuC/Gcwk20DXJVAbU4mMob/m
         LzRg==
X-Forwarded-Encrypted: i=1; AJvYcCXYBJ4wT8zOxk9MgmeNO/5/2nXe9mWs2iIgrjQGCksd5icEPA9OGWr3criELn4a2ZOWzTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCJ0xxDBD5XvK0+ZHm9MakMlZoOKQag1LwWaQOjgwpxs6CwdzW
	gxYgc/D4KUtnWefO3Osf+0siFjw8eI8IPl4GeR5erP0Vzqtb6bhP
X-Google-Smtp-Source: AGHT+IGJ9UIDBHvmVDP3yReqULkPfNEXWlZ/UyyBznYkWf5iFXr1M1hxutrGWpJ4rrpvP4+P6AvMwQ==
X-Received: by 2002:a17:902:e892:b0:20c:af5d:2ed0 with SMTP id d9443c01a7336-211835b05f1mr265344365ad.48.1731489716612;
        Wed, 13 Nov 2024 01:21:56 -0800 (PST)
Received: from gmail.com ([172.56.122.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e5b849sm105845795ad.214.2024.11.13.01.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 01:21:55 -0800 (PST)
Date: Wed, 13 Nov 2024 01:21:52 -0800
From: David Aguilar <davvid@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
Message-ID: <ZzRvsOeLsq3dJbGw@gmail.com>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local>
 <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local>
 <Zy9ckDezMSKVA5Qi@gmail.com>
 <ZzHeMjqUjzWpdX-Y@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZzHeMjqUjzWpdX-Y@pks.im>

On Mon, Nov 11, 2024 at 11:36:34AM +0100, Patrick Steinhardt wrote:
> On Sat, Nov 09, 2024 at 04:58:56AM -0800, David Aguilar wrote:
> > That said, if we mean, "Linux/Unix-savvy New Contributors," then
> > I can understand why Meson might be a favorite, and perhaps this
> > might be the crowd we are looking to target [...]
> 
> My goal is to not only make things easier to use for Linux users, but
> also for users on other platforms like Windows while also catering to
> the typical developer of Git and making the solution for them as tasty
> as possible.
> 
> I agree that CMake is a tad easier to use and set up on Windows, mostly
> because it is directly integrated into MSVC. But I also think that CMake
> is a harder sell towards the power users because it is comparatively
> hard to maintain due to its somewhat arcane syntax, implicit variables
> and things like this.
> 
> So I'm basically trying to find a good middle ground where all of the
> respective target audiences get benefit:
> 
>   - For Unix devs I think that Meson is easier to maintain and use
>     compared to CMake. We also get nice features like out-of-source
>     builds, good integration with the test suite and easy integration
>     with IDEs.
> 
>   - For Windows devs we have an officially supported way to build Meson
>     from MSVC and co. Also, subprojects allow us to have as easy story
>     for how to build Git without preinstalled dependencies, which is not
>     currently possible with CMake to the best of my knowledge.
> 
>   - For packagers I think that Meson provides better discoverability of
>     options than CMake.
> 
> So Meson may not be the perfect solution for everyone of these target
> audiences, and better solutions may exist to cater specific needs. But
> it provides a net benefit for every single one of these audiences from
> my point of view. And when taking the benefits for all target audiences
> combined I think that Meson provides the bigger win compared to CMake.

Thanks for clarifying. Not that it matters, but you've convinced me.
Constructive criticism follows below in the hope that it can help you
further harden the arguments for Meson.


> > > Patrick Steinhardt wrote:
> > > >   - Packagers. This is another group of people that would benefit from
> > > >     my point of view. This is mostly because Meson has certain standards
> > > >     for how to approach problems, and thus the packager would know for
> > > >     how to handle things. They don't have to manually track build
> > > >     options and changes thereof, as these can be easily discovered and
> > > >     because Meson will error out in case invalid options are passed.
> > 
> > CMake's option() variables and its GNUInstallDirs module pretty much
> > handles all of the standardization that packagers are looking for on
> > this front, so this argument doesn't push the needle towards Meson over
> > CMake from my perspective.
> 
> I think that discoverability of Meson is way better. Here you can simply
> say `meson configure` and it provides you a nice list of all options
> that are available. For CMake it always used to be a big pain.

The pain of discovering options with CMake is true in the general case.

A specific project can enforce conventions so that all option()s are
specified at the top of the main build script or a designated file
specifically for options. That would trivially make the options easily
discoverable in that there's only a single place to look, but that's
nowhere near the rigor that Meson enforces.

Following a sensible convention is why I didn't originally vibe with the
argument that option()s are insufficient, but that would merely be one
project's conventions and is by no means a universal practice.

Elsewhere in this thread it was also mentioned that unknown options are
blindly accepted by CMake. That's actually not true.

While it's not as rigorous as Meson because it doesn't error out by
default, CMake does issue a warning when you specify variables/options
that are not used by the project. IIRC this warning can be made into an
error by using the "cmake -Werror=dev" option, but I appreciate Meson
taking the stricter route as it results in better overall usability.


> > > Taylor Blau wrote:
> > > I appreciate your thoughtful response to my concerns here. Please feel
> > > free to correct me if I am wrong, but I think the bulk of your argument
> > > is captured fairly well by these three points, so I want to focus my
> > > response here.
> > > 
> > > Responding in turn, I think my feeling is something like:
> > > 
> > >   - Long-time Git contributors are going to be the ones who will most
> > >     frequently use the new build system. I am definitely sympathetic to
> > >     getting too comfortable with our existing tools, but so far in your
> > >     response I have not seen a compelling reason to switch the project
> > >     to use Meson.
> > 
> > Likewise, I have not seen a compelling reason to not focus the
> > effort on CMake instead. In other words, why not enhance the current
> > status quo (Make + CMake) instead of trying to replace it?
> 
> As mentioned above, I mostly think that Meson makes for a more
> compelling overall package. That being said, if we eventually come to
> the conclusion that we as a community want CMake instead of Meson, then
> I am willing to go there.

I hope that's not where things land because the separation of
configuration vs. build steps does provide a benefit in day-to-day use
(specifically, faster incremental builds) due to the clean separation
of the configuration and build steps.

It seems like it would be nice if the Meson build were eventually
hooked up so that we can continue typing "make prefix=... install"
(perhaps through an opt-in "enable meson" variable) and the Makefile
would handle driving Meson + Ninja, but that's probably an untenable
feature given the complexity of the current Makefile.

If the Makefile were completely replaced one day then that would be
a nice to have, but it would probably be a bad crutch because the
natural tendency would be to shadow all of Meson's options behind
Makefile knobs. Encouraging users to just run meson directly
seems like a better overall situation. Bisecting is the only
reason why something like that might seem appealing, but
I probably wouldn't push for it myself and maybe there's a better
way to handle that when we cross that bridge.


> > >       * New contributors do not interact with build system internals
> > >         nearly as much as more experienced contributors. I would imagine
> > >         that the vast majority of those interactions are simply running
> > >         "make" or "make test".
> > > 
> > >         You mention a handful of other niceties that Meson provides,
> > >         like language server support, but I am not sure that I agree
> > >         those are (a) the responsibility of the build system to provide,
> > >         or (b) that those needs aren't already well met by the vast
> > >         number of existing tools and IDE integrations that can work with
> > >         ctags.
> > 
> > CMake has all of these same bells and whistles, and it's already present
> > in git.git. LSP support just means being able to generate a
> > compile_commands.json file, and the current CMake setup already does
> > that.
> > 
> > The one thing that no one has mentioned is dependencies.
> > 
> > CMake has less dependencies. Python is arguably a liability in the build
> > system arena, and Meson requires it.
> 
> Eli has menitoned [muon](https://muon.build/), which is a drop-in
> replacement for Meson written in plain C99. I don't know whether it is
> currently able to compile the Git project, but if this is going to be a
> concern for people I can try to make sure that it does.

Thanks both for confirming that muon is a viable alternative.

Elsewhere in this thread packaging metadata for CMake was shared
arguing that CMake also has many dependencies. A subtle nuance there
is that those are all either optional dependencies (e.g. Qt for the GUI
parts) or they are dependencies that can be optionally supplied.

You can build CMake without those dependencies installed and CMake's
vendored versions will be statically linked instead. So, from the
perspective of wanting to go from 0 to 100 with just gcc/g++ installed,
CMake has less dependencies. This might be slightly disingenuous because
CMake vendors its dependencies and distros have to opt-in so that they
can supply their own versions, but the main takeaway is that GCC is all
you need and that's what I meant by, "less dependencies."

This is a moot point for most users, though, and it's even moreso moot
if muon compatibility can be maintained.

As to why I consider Python a liability ~ this is more of a concern for
Meson and it doesn't really matter for end users, but Python has a
proven track record of making breaking changes.

If you're building everything from scratch with new versions of
compilers and tools then the C++ project is the one that's going to
build just fine a decade from now with little to minimal effort.
Python doesn't have that track record.

Even though CMake is written in C++ (which is unacceptable for some
projects), this is subjectively one advantage that CMake seems to have.
This is a moot point, though, and perhaps Python will eventually reach
this same level of respect for not introducing breaking changes.

Furthermore, I suspect that most contributors are simply going to
"apt install meson" or "brew install meson" so it's not really that much
of an issue in practice for the majority of users/contributors.


> I'd honestly be sad if we go down the CMake route, mostly because I
> think that it is an inferior build system compared to Meson. I have
> worked with it extensively in the context of libgit2 and always found it
> to be a pain due to its esoteric syntax, the use of so many implicit
> variables, platform CMake policies, and there being so many ways to do
> the same thing and, where the easiest solution is typically the wrong
> one to pick.
> 
> That being said, I'm trying to be as pragmatic is possible: my main goal
> is to have a modern build system that is easier to use. So while I think
> that Meson fits better into that role, the next-best thing would be
> CMake from my point of view.
> 
> So I'll continue to champion Meson, but if the project as a whole agrees
> to take up CMake as another official build system then I'll adapt and
> make that happen.

I agree with you. Meson looks to be a technically better option.
I kinda wonder how many folks are actually using the contrib/ CMakeLists.txt,
and whether this effort would be helped by retiring it sooner rather
than later?

Would it be worth adding a canary to the CMake build that forces it to
fail to build unless "cmake -D ENABLE_DEPRECATED_BUILD=ON" option is
specified?

It could error out with a message telling users to reach out to the
list alongside the hint to specify the option if they just want
to get a working build.


On a rather low-powered machine here are some timings:

    $ make clean
    $ time make -j
    181.36s user 15.35s system 99% cpu 3:17.33 total

    $ ninja -C build clean
    $ time ninja -C build
    11.23s user 4.67s system 47% cpu 33.605 total

34s vs 3m17s ~ nice! That's also surprising.

That large of a difference is not explained by the extra
probes done by the Makefile; a no-op incremental build is 0.5s for
Make and 0.02s for Meson so the Makefile probes seem to only account
for at most 0.5s.

Is the Meson build simply building much less, and that's why
it's currently so much faster?

Or.. is it because I have "sccache" installed and Meson automatically
uses it? "ninja -C build -v" confirms that it's using sccache and
"make V=1" does not, so maybe that's why.

How do we disable the sccache usage?
"meson configure build" doesn't seem to list anything related to
caching, but it is really nice seeing all of the other options in one
place.

Improvement in build time seems like it could be something that sways
long-time contributors towards Meson. It is pretty nice that it
automatically picked up sccache in my $PATH and automatically gave me
those speedups.


> Thanks for your input, highly appreciated!

Thanks. I don't want to be the CMake champion, so here are a few
helpful/surprising details about the Meson build to help make it better.


(1) I first built w/out having "curl-config" installed. I was surprised
to find that "ninja -C build install" ended up installing "bin/curl" and
"bin/curl-config" into the prefix.

Is there a way to have the install step only install Git without
bringing along these other non-Git bits?


(2) There seems to be a difference in how symlinks and hardlinks are
handled in the install step.

Running "make prefix=$PWD/dist install" ends up with real files in
dist/bin/ (hardlinks) whereas with Meson all of the files in the bin/
directory are symlinks into ../libexec/.


(3) Not all of the same files seems to be getting installed.

I don't see bin/gitk or bin/git-cvsserver when building with Meson.

The share/git-core/templates/ directory is missing completely.

git-gui and its related files are missing. Perhaps this is
intentional/todo at this stage and hasn't been added yet.

Meson installs bin/git-http-backend (symlinked to libexec)
but in the original Makefile this file only exists in libexec/.

The contents of libexec/git-core/ seems to be missing dozens of
files compared to the Makefile build.

share/perl5/ has a bunch of extra git-{cvsserver,send-email,svn,...}
scripts so perhaps this is where some of those files went?
The Makefile places these files in the libexec/ area instead
of in the share/perl5/ area.

The Makefile does not install share/gitweb/static/js/.
Instead, it seems to mash everything together into a single
share/gitweb/static/gitweb.js file which Meson does not install.
Meson installs separate files in the share/gitweb/static/js/ area.
Was that intentional, or is that just another todo?

cheers,
-- 
David
