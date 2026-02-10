Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795C0207A32
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770730001; cv=none; b=ClT/nBuHg2EXybuTH4Ngwt0nTN9uLcw3luHsw3Avvl2YAKBIKZrE1zXsso1Jh/NCcwvtJDRNQUJZV2Jt6TOx9EZEMN5B0Xsvi2l8WbqXtLFk16IjPj+KFSfXhN2cElra5YBEXSbPdXvCNeLQfgfqCZMiUykMcvjnmRo8oNc9HFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770730001; c=relaxed/simple;
	bh=ZPlwIkODgglpLZRVosUJb4yXACLFH5/XqB5OQZIyhAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjL861OTzF9RSMdEpHYm3HEA/Gw8szHoMsrtgfZobQnGlxZL9qqqIDmtHeJebJXYbUx/ovjkCa98qyxEgMNWJJxdZ+HEj0h1TrG09dMN4i3VCT2W0tZMCWP1s/GEIpAuJoyP9CW+n34lqThC6TFBFH0v6Q+cNPnn6vuEu7vybjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RBmVK5zC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y/0XBKNy; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RBmVK5zC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y/0XBKNy"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A170CEC05F3;
	Tue, 10 Feb 2026 08:26:38 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 10 Feb 2026 08:26:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770729998; x=1770816398; bh=aqsKk6TTMo
	sGqUyXNk4NqjEWeDVDqDLWrjMvMXV8wOI=; b=RBmVK5zCK+8h07mcl0EyHPmWZD
	JMe8ftlDBtS4b0QgMwstEvr4IIUR6kUX4voBVooBLBlGqZQE4zIJYQU3pftMMnjG
	SPDPiZOFdGpQqnYuVzBpe8wAcG8YTqIdBUtsGLOkTi/6YGlJ5aJ2Y1Y11ddlP2xx
	zwcWQdRiFUZHFsr1l/4aihGEYwglgbdohp7d3iv5R+PQ0FGpgOp6zbY8DlrCxCE3
	f4steTuj2KPl664VONI0EL0R9cdiPB/7KX+FTZ7Z/nDakcQB84pSAarC2g8MgPgr
	zuZGQT/ulWvIDwpVtH+EuWO+83vweLwFpBe50UxtUHcF/lkxIczw3cBkrVAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770729998; x=1770816398; bh=aqsKk6TTMosGqUyXNk4NqjEWeDVDqDLWrjM
	vMXV8wOI=; b=Y/0XBKNyTqcTcyGg7Fsmt4hR2Rqv07hCHBhjocrvmKt2k0vRrXj
	KsxBV+FKB6ICr/bpO88lyQ8xk4BVIzXq9Q4ZZDnbK1tN4Ymngq2fIddCGnCGQE2v
	I0gzth5WqxFLNbYQPFkaC/kZ46Uk4UeqveVdhBREMVShUMHVHe1iBTux8eb4WFgQ
	4ONaxcQ6tvGO/8LnGnrRqN7qANRHOyyMwasD2s9KYJn6S82K7FT5AkpoluPHrN+U
	yyq6JdyKK91Hxl0ptnhZCCW9WymuZAZf9BU4lrajeqUStjV5Z3AWAtCSXgVajy4R
	Z0/gNzp4xapIKrZ2bN5A42jCsfUgnfEpmPQ==
X-ME-Sender: <xms:DjKLaRxDXlD8Om3Zs5qkZxkeaWD78NaBb7bVFYqAXvE00d11F7uk2g>
    <xme:DjKLaZA-CPeknzkCWoEmoSulxDqsbJHdW12oagasoBN0x9v3PeDtfZ0gEj6QKubXa
    bvp2bchAynKFAbsCof0gik9y91yaTQtTWRZUq7RokL4Z2Z1r0EpIg>
X-ME-Received: <xmr:DjKLaeZ-2Y2EnSZ79olU1FVTFsTudRokQ2CTKBNjUwSRyeeGn6cHwP3VD22HQIcnnzvrSSRne5ss88YWs45wMjv-V6nsry8wJt4sf4_sGmY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleeljeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfehtefgveelhfeuueevuedvnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DjKLaRgtN0gazx1xMtcp9KyFtCo3uwxRYy0vTjbRWwygXhbkeNA69Q>
    <xmx:DjKLaQ7N9CE-3UG6VoOl5TrVx54aqVNZvs7J7r8vILi9ZHM2vfWGHQ>
    <xmx:DjKLaY6jjPVXrbFgF10e_nnUOvXluqjo9APwk5JDPg0gCoe3avIsrQ>
    <xmx:DjKLaUdFpUDH8Q5aQYzfIUrd-lSEBLzb6dp1hE5g0ffyUrqi8VDHGw>
    <xmx:DjKLaQwGyJYMy6ikUkegDduFzJgr_rW0rMaMrzDfzEcsZymNJ7ib9Ccp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 08:26:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9b41dcbb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Feb 2026 13:26:35 +0000 (UTC)
Date: Tue, 10 Feb 2026 14:26:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2026, #03)
Message-ID: <aYsyBPZfDHMnYy5s@pks.im>
References: <xmqq7bsob0wo.fsf@gitster.g>
 <aYmleK3kGqzLXyJe@pks.im>
 <c29e0c1d-337c-4411-8d52-07c9155e8abe@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c29e0c1d-337c-4411-8d52-07c9155e8abe@ramsayjones.plus.com>

On Mon, Feb 09, 2026 at 07:41:30PM +0000, Ramsay Jones wrote:
> On 09/02/2026 9:14 am, Patrick Steinhardt wrote:
> > On Sat, Feb 07, 2026 at 03:15:51PM -0800, Junio C Hamano wrote:
> [snip]
> > 
> >> * ps/meson-gitk-git-gui (2026-02-04) 1 commit
> >>  - meson: wire up gitk and git-gui
> >>
> >>  Plumb gitk/git-gui build and install procedure in meson based
> >>  builds.
> >>
> >>  Expecting a reroll.
> >>  source: <20260204-b4-pks-meson-tcl-tk-v2-1-5bc3ccf3a8ce@pks.im>
> > 
> > Probably makes more sense to say that this is waiting on a pull request
> > of gitk, as the patch series itself doesn't need to change.
> > 
> 
> So, I should probably wait until Junio pulls from Johannes Sixt, but as it stands
> on the seen branch (@203d64cf67), I have warning against 'git-gui' on Linux (but
> not cygwin). On Linux, I see:
> 
>   $ cat build/meson-logs/meson-log.txt
>   ...
>   Executing subproject git-gui
> 
>   Project name: git-gui
>   Project version: undefined
>   Program sh found: YES (/usr/bin/sh)
>   Program tclsh found: YES (/usr/bin/tclsh)
>   Program wish found: YES (/usr/bin/wish)
>   Configuring GIT-GUI-BUILD-OPTIONS using configuration
>   Program msgfmt found: YES (/usr/bin/msgfmt)
>   Build targets in project: 694
>   NOTICE: Future-deprecated features used:
>    * 0.64.0: {'copy arg in configure_file'}
>   Subproject git-gui finished.
>   ...
>   $ 
> 
> Note that on cygwin I don't get the warning and the number of build targets
> is 693, rather than 694 (I don't know if that's relevant). Also the version
> of meson on linux is 1.3.2, but on cygwin is 1.5.2 (so, I would have thought
> that the deprecation warning would also appear on cygwin! ;) ).

If I remember correctly this particular deprecation was rolled back
eventually. *goes double checking* Yup, it's been deprecated in Meson
0.64.0, but that deprecation has been rolled back in 0c802d260 (remove
deprecation warning for `configure_file` kwarg 'copy', 2024-05-24),
released as part of Meson 1.5.0.

So I'm not sure whether this really needs addressing. We _could_ make
this conditional and use `fs.copyfile()` on Meson newer or equal to
0.63.0 and older than 1.5.0. But whether that's worth it... dunno.
Probably not.

> The make and meson builds appear very similar, although some paths and version
> numbers differ:
> 
>   $ diff build/subprojects/git-gui/git-gui git-gui/git-gui
>   1c1
>   < #!/usr/bin/sh
>   ---
>   > #!/bin/sh
>   6c6
>   < 	echo 'git-gui version 0.21.GITGUI'; \
>   ---
>   > 	echo 'git-gui version 0.21.0.257.g1a729'; \
>   10c10
>   <  exec '/usr/bin/wish' "$argv0" -- "$@"
>   ---
>   >  exec 'wish' "$argv0" -- "$@"
>   12c12
>   < set appvers {0.21.GITGUI}
>   ---
>   > set appvers {0.21.0.257.g1a729}
>   378c378
>   < set _shellpath {/usr/bin/sh}
>   ---
>   > set _shellpath {/bin/sh}
>   $ 

I guess the /bin/sh thing is something I'll want to address so that we
prefer "/bin/sh" over "/usr/bin/sh". We did the same fix in Git itself
eventually. The wish shell feels sensible though, I don't think we need
to fix that part.

The version thing is actually a bug. The problem is that we have started
to set GIT_CEILING_DIRECTORIES, but we set it to the directory of
git-gui itself. That of course works as long as git-gui is compiled
standalone, but doesn't work anymore in case git-gui is embedded as a
subproject.

So why does it work for our Makefile? That's because we define the
SOURCE_DIR as ".", and as a result we define the ceiling directory as
"./..". And that seems to not restrict our discovery process. I don't
really know why that is, to be honest.

I have created [1] to address these issues. Thanks for testing!

Patrick

[1]: https://github.com/j6t/git-gui/pull/31
