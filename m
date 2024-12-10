Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7059C1BEF97
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829626; cv=none; b=t4qQ9CTK6ej7zOKKwu0J5J5M77NCQZ6ODyuMsb7GL7Qx/Md/1TZAisYZufYIYwNbl/0hTnz/iSo1YUPIScSZcB52o6M4GAwpkquS24lbyShcfT+cMcqNC5nLpT/B+WJLv3qntxkEMjWQ35VBCw0frezH6q170WDklOxCZFIzSeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829626; c=relaxed/simple;
	bh=DPdUDn7vaIDFu+tDTCX7RbNYZ6FMk6UbgPw2NHkg6Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swB73C+yvKt6YrS8FuVxicRNvW9023XsKLz6ODJ4KDV7JsrQoNh11T/cj3gIz8alIu7DyY7YCMKzfJvjOWYxqajeThMpAg5CKg/wyVYynJ9iIiV0JCBBmQ3OZvE+gXb0jMoFc9fOrncos29k5YAfezJ8NkomHVXhK2qxdHzzu8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uN+osWge; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4YzeoGJk; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uN+osWge";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4YzeoGJk"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4F43A1140168;
	Tue, 10 Dec 2024 06:20:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 10 Dec 2024 06:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733829621; x=1733916021; bh=75aK7IVKhM
	+AF2Qo/xii8Qe2ylXlYtyPZR3CO4D5G7U=; b=uN+osWgerFPtzsrYRFy/TwRvdk
	CXt6Q+eOXcXmwVRa9xKE0LMsADXyInx+zmeox5b+65ZixFqtAgNN4MzVn1OEQV2C
	IpUu0xWeeT3yoJo60hzndi6QCISDz+yqadxjOxQ5DT7nvY+udb7r6NmA3ty4FLee
	tEVvF7I7asRiPqDj7WmBG+u258wGY2jlJekQg5Jjsmci3z4gsHj5Gt5/7O5lCejz
	YWnGYF53xO9hsdFmqlUdGzJkXf6rj2w7EwbNQRh8D1azbmbQ0pufn1CeghzpF71r
	A5pRVNt15TMBmqErIh6cekXrN5JivgMec8pqDGPQXnDSP/qGLP7IGUSRRIDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733829621; x=1733916021; bh=75aK7IVKhM+AF2Qo/xii8Qe2ylXlYtyPZR3
	CO4D5G7U=; b=4YzeoGJkRHy3PmYsckp3X6Db7aZgnboic8C1O6d2kYlLR4KDiP1
	A5qaLwTDBii4FHv4bdQ8NAEzvp5hl+i2Qr8/C+++lNUnvD7Gns38XPIAkFnfsvpC
	awYgU/YVBpEMagZ2s0zfnoHwsr1+cr95yPP7vnFaGeCb1WauOUZu/x4P2kqjS8I3
	qFnw0tUjn5iV8fStnaROYxU+Q3Axfid1/7FPHWawDvfltzbSBeDWniIX11nl5hDu
	KVXXZmewzpsissubFPkWfThwnXZY0iQh5P8ot2bg4JQQrt/Ax59OmElrZj1zBD/i
	Vg0Q0I8WcYCFgsa6Q/7P9nqv8flqVpTM09A==
X-ME-Sender: <xms:8yNYZ0q-b3wn6RHLEXiRPjdgsNWLnErYoiMHXSPzTGSgVRCA6hwhAw>
    <xme:8yNYZ6qduEBNdkD0BhToGLq-gZjnVDFExQOkyJclnyKlnPqt6tFCd-chowcKVYbaU
    2Q3Otm9g4f4njXMvw>
X-ME-Received: <xmr:8yNYZ5M1WiiJAtADXId-AeAQ5bKK7HbC57oSIWlTjn6xbv9vJsFQeFr4cvhxIc4HWHhUfEXnIbAsXPyLjPt9nR6DOBwgoE-AHC1A5m27OIdS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeekgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuh
    igfhgrmhhilhihrdhorhhgpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohho
    rdhorhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhush
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:8yNYZ75N8lzFDKnBrjlDkBlis0m0K9gEVjhGlam1DQOeOhSoB4vwPg>
    <xmx:9CNYZz6Sb_DUw7kednz2Efkf2QHPbxBHvfCychJ-_0LbbkJC-pM1DA>
    <xmx:9CNYZ7iU87ItZ0dYi0CQ-5gYoYebQW8kFpFciUwxOGRbG2-ccz8sEw>
    <xmx:9CNYZ94zkSX2uxhvn1Qb7xTnoiLtGIE_EsCIzWdpKRoJIHqvw7NDzw>
    <xmx:9SNYZ3hF-Pi3veRzGv3Qq18iCa8cQMTxazl0wwh3jp7ygmIjfL2MT8dM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Dec 2024 06:20:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id da15b318 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Dec 2024 11:18:43 +0000 (UTC)
Date: Tue, 10 Dec 2024 12:20:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v11 25/26] meson: fix conflicts with in-flight topics
Message-ID: <Z1gj4M-qHQ2Qcq5a@pks.im>
References: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
 <20241206-pks-meson-v11-25-525ed4792b88@pks.im>
 <xmqqikruswtd.fsf@gitster.g>
 <Z1aLT-Hcq2iMWH11@pks.im>
 <xmqqplm1nv7g.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqplm1nv7g.fsf@gitster.g>

On Mon, Dec 09, 2024 at 04:58:59PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > I have the following change queued up in a local patch series:
> > ...
> > What it does is to verify that test suites wired up in Meson are
> > up-to-date, and if they aren't `meson setup` will fail and print all
> > missing or extraneous test suites. For code it's a bit harder to do as a
> > lot of it only compiles conditionally, so I don't have a solution for
> > that yet.
> 
> It would certaionly help those who build work "meson" to remind
> themselves that they need to make matching changes to Makefile world
> when they update their meson.build files.
> 
> > It also doesn't execute as part of `make test` -- if we want that I'd
> > have to implement it via a separate shell script instead. Which isn't
> > too bad, we'll simply have to agree on a direction. But the logic will
> > execute as part of CI so that any discrepancies will be flagged.
> 
> And catching a breakage as part of CI is a good first step
> nevertheless.
> 
> Having said all that, with a longer term evolution of the build
> systems in mind:
> 
>  - Currently, anybody who is working on our codebase is expected to
>    make "make all doc test" succeed before even running format-patch
>    and/or send-email.  But unless you are testing with ps/build
>    topic, you won't be checking "meson test".  The same is likely be
>    true for CMake (I am not encouraging folks to send a change that
>    is OK only for "make" and deliberatly breaks "meson" and "cmake";
>    but for those who are used to build with "make", having to _also_
>    check with "meson" and "cmake" is additional barriers.

Fair.

>  - The ideal world, at least from the point of view of those
>    advocate ps/build topic, should be that "meson" is treated at
>    least as another build system with equal footing as "make".  With
>    even longer timeframe, the effort may even aim to supersede and
>    deprecate "make", but before that happens, it has to at least
>    become build system with equal importance.

Agreed, feature parity is a necessary requirement and I'll of course
continue to iterate on it once Meson has landed. We might get away with
removing the autoconf framework without feature parity as users can
still use "make" without it, and because it's seldomly used and broken.
But replacing "make", if it happens at all, is a much larger undertaking
that will require many releases.

I'll also align with Dscho to figure out what to do with CMake.

>  - In the longer timeframe where many more folks work with "meson"
>    than "make", check implemented on the "meson" side to make sure
>    that "make" world will not left rotting would be helpful before
>    we finally kill off "make" support (if that is what we are aiming
>    for).  But until then, I think the pay off would be larger if we
>    helped "make" population to avoid leaving "meson" and "cmake"
>    builds out of sync when they update Makefile.
> 
> And that is why I suggested "make test" as that is currently what is
> run by everybody.  It is like &&-check that helps individual developers
> with their test before even submitting their changes.
> 
> I am unlikely to run the check locally before pushing them out,
> simply because meson build is not yet part of my everyday workflow,
> but even after I made it part of my workflow to check, in a sense,
> it it too late.  Once we adopt ps/build~1 as a part of our official
> world, if a developer, who builds on top of the 'master' in the not
> so distant future, does not pay attention when they touch Makefile
> without making matching changes to meson.build files, I'd want to be
> able to scold them for not running "make test"; otherwise the
> process will not scale.

Fair.

> I also had to wonder if we can share the common list of files and
> have both make and meson worlds include them from the same source,
> but if the eventual goal is to migrate into a single system, it is
> not all that great an idea.  After giving up on one of the systems,
> we would not want to keep a system where we keep a list of source
> files in a separate file (possibly in a separate syntax), which is
> not how either world would normally work.

That would be great indeed, but it's somewhat incompatible with how
higher-level build systems work. We do it in CMake by parsing our
Makefile and extracting source files, but the problem is that this only
happens at configuration time. So the set of source files would not be
updated properly when your Makefile changes. An alternative would be to
use globbing, but that is not recommended, either. Quoting CMake docs:

    We do not recommend using GLOB to collect a list of source files
    from your source tree. If no CMakeLists.txt file changes when a
    source is added or removed then the generated build system cannot
    know when to ask CMake to regenerate. The CONFIGURE_DEPENDS flag may
    not work reliably on all generators, or if a new generator is added
    in the future that cannot support it, projects using it will be
    stuck. Even if CONFIGURE_DEPENDS works reliably, there is still a
    cost to perform the check on every rebuild.

The same is true for Meson:

    Meson does not support this syntax and the reason for this is
    simple. This cannot be made both reliable and fast. By reliable we
    mean that if the user adds a new source file to the subdirectory,
    Meson should detect that and make it part of the build
    automatically.

    One of the main requirements of Meson is that it must be fast. This
    means that a no-op build in a tree of 10 000 source files must take
    no more than a fraction of a second. This is only possible because
    Meson knows the exact list of files to check. If any target is
    specified as a wildcard glob, this is no longer possible. Meson
    would need to re-evaluate the glob every time and compare the list
    of files produced against the previous list. This means inspecting
    the entire source tree (because the glob pattern could be
    src/\*/\*/\*/\*.cpp or something like that). This is impossible to
    do efficiently.

We could of course eventually reverse the logic and have Makefiles parse
files from Meson. But as mentioned already, the biggest issue is that we
have lots of source files that get compiled conditionally, and properly
parsing these would be non-trivial.

I guess we'll see over time how much of a problem it is to keep build
systems in sync. Proper tooling is a first step to make things a bit
less tedious, but if this still proves to be too painful I'll have a
look for how to further automate things.

Patrick
