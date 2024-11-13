Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13521DFD82
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731504301; cv=none; b=FPb1L3C5LYrd2AmkjncD2VVVpGRhbAMOUh1OMZy7g0gkuaS3o/rx71t8KByBJbKXY9lQ9iue+r9+IzxggD0iHl2eN8jeG+wTtSCNpcm58rRuLzexaepaPsRJVjlJo90DBjP/rtKDdH8l6vfy7IVXHMduqdrMbz+zW/5NOcRMsTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731504301; c=relaxed/simple;
	bh=d1v39ZeCdDqtdJEbcWcluMfkDuicyp0Qfh+C0qGq7ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNlX84xRWKkZtl3RIgeAJpkQoYDn+LLxblcXS0gcJaYx9zA/h4zK5vPt4dhVMcik/CXsVZAj3pzwXI3pRX+NgBQoQRgcrq5s6uBTIV/QXqcFxH8zW8Qs1LhZd+AYtSId9hC73TeVV6XGf6UMvsi/ONOfOd7SmLGOXRQqWaHf1w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dENVXB6U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S0N9i5JB; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dENVXB6U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S0N9i5JB"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 1227B13805F7;
	Wed, 13 Nov 2024 08:24:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 13 Nov 2024 08:24:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731504299; x=1731590699; bh=75Qe58PDS1
	oW+4k+5O6GGPqoqO5svQtPc9NwpFnc74I=; b=dENVXB6U9h1080ojUjqbXrwKS/
	dcaESrI0WadXlbF2l683lS5WbeedMqNDxbBtU5KMmZOoNpQDrqSN/hmsSIu8r6Rj
	kIR2RefQYSudH6Na8PhefBVrgbWQiq1qxlNuWQTYboxvBkhglhre8KnSw+3JLuDO
	0WEDpwm47h19XBdxty05HTRjecafw34m8wQifIiqg3xfxZ5kRqZTtw+ayjCnzhi9
	JxHCCyrJ/Iju1Wc4jZgUl9CE6OMdm2BnDFHhHonnqSG/uDKYugac5amzS+1zqPFR
	JZh63fqbpz/KgnXQB/hS/zGeLxRojTnjit58Mjc5GbcWmHU5hwlaIQtGFs/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731504299; x=1731590699; bh=75Qe58PDS1oW+4k+5O6GGPqoqO5svQtPc9N
	wpFnc74I=; b=S0N9i5JBcc9ziN1CGrKoiwwiiQiGDV6x3ePZFpn/FjlWbBe6XAr
	KIV91TCCueeL7YryunQKyH/+0GwRfWiQbuO6CufaQVHymzxMfjPHOEiovKCnuSV8
	nltUjCe3u7jy5PN3vimtcgRCUCYUUIfTNpp05wTSl4+B3W26xVdjRD8oI5F7xVPy
	wgz7u/2yP7J69Nmv99beMWeWGgHcq8aoVWa9bTN86HDLj9uPDbI035MA1dN7mOdm
	/2MtXsXI+L4o/159N9pHB3Xpfp6KNavPppc3Iu8s6iclCYXWtWUxoNbXnnt2Iw3+
	asxpLuRD8Dzxjlb8qTMWAy1Pl92hnlz71Kw==
X-ME-Sender: <xms:qqg0Z98Y9-e4qqH1FMnol5OKNUQZ4AiZf4IT0pcNG5yFrJWWvStFUA>
    <xme:qqg0ZxsNGFxRcD9CDL5qvXFln_S79IVo8Y8UY6qS9_dyVMgs3rHZ799cDhP5wDmdO
    fiFa01rZTIED3V0ug>
X-ME-Received: <xmr:qqg0Z7AuSEiDdW_Qc9HbE3CtHPc-zDw5w7hpL7KO1E8b1_SI0skqWJVv8m4IpGfpGdbldkoojvITG4ugZMo1Fr06EA3mNoZa3OHpfRZgyMDUE0U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpedvleeffeeuveeugefguddutdfgffekvdeliedtvefhhedv
    hedvueegiedvudfhleenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhunhgrmhgvrd
    hinhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehp
    shesphhkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrh
    drtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprh
    grmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvse
    hsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:qqg0Zxdt0Y9OG1vQn8nYBSRj93KGAXLcENlN3bQxsK9F2xERrcVK0w>
    <xmx:qqg0ZyPhpSNbKQlHkAE0jWq5NtARxTCz2_MgubdOFX4boOKeAD7ouQ>
    <xmx:qqg0ZznqEJ2mgfJRjRISHEJsYufsAooF7vXSTohj9BTZdG8oAvVcgA>
    <xmx:qqg0Z8uBzN-cwc_FW5ld_qrPcwzFQbL1FT4HkTKPyo1m2bCAe_FZMg>
    <xmx:q6g0Z5oBiFJK8FCnDKiiCMeoRt9f2hlwN0ShzIsMdXt6p7wX4EvozM21>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 08:24:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5a8068f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 13 Nov 2024 13:24:18 +0000 (UTC)
Date: Wed, 13 Nov 2024 14:24:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [-SPAM-] [PATCH RFC v6 00/19] Modernize the build system
Message-ID: <ZzSooGxkL3BrHhk-@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <20241112-pks-meson-v6-0-648b30996827@pks.im>
 <94fa4a3c-c9aa-473a-a129-74edfd617a16@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94fa4a3c-c9aa-473a-a129-74edfd617a16@ramsayjones.plus.com>

On Wed, Nov 13, 2024 at 03:30:20AM +0000, Ramsay Jones wrote:
> On 12/11/2024 17:02, Patrick Steinhardt wrote:
> > Hi,
> > 
> > this patch series modernizes our build infrasturcture. It refactors
> > various parts of it to make it possible to perform out-of-tree builds in
> > theory.
> > 
> > The series then continues to wire up Meson as a proposed alternative as
> > a modern replacement for our current build systems. It provides better
> > integration into IDEs than our Makefiles, better usability than our
> > Makefiles and CMake, better configuration and discoverability thereof
> > than autoconf and CMake (which is of course my personal opinion).
> > 
> > The intent is to have Meson replace autoconf, which is mostly unused and
> > broken. Eventually, the plan would to also replace CMake and our
> > Makefiles in case we figure out that this replacement is indeed a net
> > benefit for the project, but all of this would happen over the course of
> > multiple releases.
> > 
> > Changes in v6:
> > 
> >   - Add documentation for how to use Meson.
> > 
> >   - Fix compilation in case libintl exists, but required tools like
> >     msgfmt and related don't. Instead of failing, we now automatically
> >     compile with the equivalent of NO_GETTEXT=YesPlease.
> > 
> >   - Update last patch that fixes semantic merge conflics with in-flight
> >     topics in "seen".
> > 
> >   - I've changed the series to be based on "master" at b31fb630c0 (Merge
> >     https://github.com/j6t/git-gui, 2024-11-11) as all prereqs of this
> >     series have since landed. This doesn't make any difference though
> >     as there aren't any merge conflicts or additional changes caused by
> >     this. I mostly mention this so that there is no confusion around the
> >     changed base commit.
> > 
> 
> Tested this version, without issue, on Linux and cygwin (build + test).

Thanks for verifying!

> On cygwin, the unit test now no longer times out:
> 
>   $ cd git/build
>   $ tail test-out
>   1030/1030 t9902-completion                               OK             114.74s
> 
>   Ok:                 1030
>   Expected Fail:      0   
>   Fail:               0   
>   Unexpected Pass:    0   
>   Skipped:            0   
>   Timeout:            0   
> 
>   Full log written to /home/ramsay/git/build/meson-logs/testlog.txt
>   $ 

Great.

> Having said that, I was expecting to see an 'Unexpected Pass', since
> meson decides to not set NO_REGEX. (The 'make' build on cygwin will
> set 'NO_REGEX = UnfortunatelyYes' in the config.mak.uname).
> 
> In the meson-logs/testlog.txt file, for the t7815-grep-binary.sh test
> stdout, we find:
> 
> ----------------------------------- stdout -----------------------------------
> ok 1 - setup
> ok 2 - git grep ina a
> ok 3 - git grep -ah ina a
> ok 4 - git grep -I ina a
> ok 5 - git grep -c ina a
> ok 6 - git grep -l ina a
> ok 7 - git grep -L bar a
> ok 8 - git grep -q ina a
> ok 9 - git grep -F ile a
> ok 10 - git grep -Fi iLE a
> ok 11 - git grep ile a
> ok 12 - git grep .fi a # TODO known breakage vanished
> ok 13 - grep respects binary diff attribute
> ok 14 - grep --cached respects binary diff attribute
> ok 15 - grep --cached respects binary diff attribute (2)
> ok 16 - grep revision respects binary diff attribute
> ok 17 - grep respects not-binary diff attribute
> ok 18 - setup textconv filters
> ok 19 - grep does not honor textconv
> ok 20 - grep --textconv honors textconv
> ok 21 - grep --no-textconv does not honor textconv
> ok 22 - grep --textconv blob honors textconv
> # 1 known breakage(s) vanished; please update test(s)
> # passed all remaining 21 test(s)
> 1..22
> ==============================================================================
> 
> Note the 'TODO known breakage vanished' on test 12.

Interesting. Right now we don't parse the output of the test executions
themselves, so we only operate on the level of whether or not the whole
test suite passed. So it's expected that this does not get reported as
an unexpected pass.

While Meson can itself generate TAP output, I don't think that it has
support for _reading_ the TAP format.

> Setting NO_REGEX on cygwin is for 'reasons' (not necessarily good) and we
> need a way to override it's decision here. (In general, we need to be able
> to use *any* of the many build variables to override meson's automatic
> setting of these build variables).

I can add an option for this. Out of curiosity, what is the reason? Is
this anything that we can autodetect?

Patrick
