Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C6E20E030
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759944229; cv=none; b=hNPTaHPEyrLHnlMm0LmhHuz874uj0oVxhNhTDwTCNTsdSek6X/hxsN4yPrtsywplOSIfbzikrvtCEA5sYtdr4kX3U2HoRTrf/7lNNDNo86AjYaWNEmCOqDnY2fCXus1sWLnsWPLmhZmCevQ5GLOAK3w9xlMncCDaeXqgVphP0dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759944229; c=relaxed/simple;
	bh=/iX0yTjqVsOLh4lgoR74zrSb6B/1VGLxBqqtBU9HbzQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qwgxZ1ohJq1oWfQcvFwPYo/VvcoqS+ggwIKLpYD5D13j5Ul26RWhyCzDPVwn4aixNVR5v50D3lcsbq/ZAOLIW4Kyz60w9jxq7cDni8FKRtplRp+1PmvcH4KSkarGmonwVS+yU5lJsxbk4TKq9xXYGZzk8twoKuGMJLWJDCtiZOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GfG0np6q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fpccTReu; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GfG0np6q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fpccTReu"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 2B9FE1D004E5;
	Wed,  8 Oct 2025 13:23:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 08 Oct 2025 13:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759944226; x=1760030626; bh=2nhFgDlTLy
	SBSIwzimNhtm2pfzyl8Giqi9sC5cHO1Ec=; b=GfG0np6qh0Z7aif36l8NZF+zOg
	GtA81CpJBn74Pl5TiXJuKUz8+E/rRyYPpjM4a3lWXQUCY0atIkGDGG9VB22jt1vq
	sT4aXq9Hmt8m02pCY+Pu2YbNQ1f9ljkoVtrxPAD1SQfVtJjpD218nYp2HB/hAZZr
	InsPwqBka5Zo2GxplS6XPUi5y6/AnVUDYNMM/LsssJTARr1uUG3Wub5opsvWvcA7
	3Eja7SVX5twjuDnt6tAPE7iOBU9/cxIjkFzXJC5LTV8H5ygDGYI5FpATr9jqP2R2
	I5TcAad2ZukG+jg0JNLFz7LNjRD7G3ods6nvTEuHUok/hotwxgsHMEgJ0iZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759944226; x=1760030626; bh=2nhFgDlTLySBSIwzimNhtm2pfzyl8Giqi9s
	C5cHO1Ec=; b=fpccTReuDuBvxg7Bpd6whB9hij00JI5TXUbfvRebdZgCa0X1QYd
	i6rsK6+k4aTrOS5cQ1PwMw10v9DoNfzjaxzw/Z2jjfKz60OegXnFAirTxfslTxiM
	QjFv42lsogLxjqVw+XdpYHxoKT0cZYRBoLIqM+jSOigqQxf/vjNznsgMOrd+lWux
	t+J4qxxv2BFX5Ub/4e+eo/Eeli4wTuvlaJas6ndXQLqj8DU1zih+UEHg95Rru514
	SiN5EkFdBx2+kdChxCMR/douuDDw5yBxTIHPXUtpGyLpO1iSLcUxt7X8BybmGgy8
	wOA7XWPk9jDX1a6bT/U5P6vRkrBzHDEPNiA==
X-ME-Sender: <xms:IZ7maAiM4QJvn8Ck6cfKdWZXVvC4gXMFE7FUkgxDQku_8ZDNVZM_8w>
    <xme:IZ7maAfHCZfFeGmfXERY5GZ3zHUnE5uPHMX6BVTLfiaJ15o8ew9JnkYYzmpWANeI0
    r-gsL3ASY05BrFQj6wvGhDEkQcsrHpKSd6KJZJ_VSjEAJVAM2E07XA>
X-ME-Received: <xmr:IZ7maFcQ7NgXxlWkWUMCq3EhukZID7fqBYpehgQRrS-vkk72V2A-q_G9ZkcwXFZzNmARpyI7vPI3h7_ZuyPHVrodfA_qAYwPfHvs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghhrghrmhhonhesshhighhnrghlqhhuvghsthdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:IZ7maK-iL95l3XhuSd8vcQVbzjOF-olbvP_A3BQiyavbjx3cuaFAMQ>
    <xmx:IZ7maBn6JoyC4hem-0Araht7o5-RbiaBpavV5ZrO4_vcolWsvwvguA>
    <xmx:IZ7maM9z6PjmR9X_uvId6gezzAC5B7FU4YTVd_AUIB1gfTzLl4l7Tg>
    <xmx:IZ7maPlSrIWHFvz0euqEvRikA8ZfS-lwDZ_SjnYfWb_rvRhoCob2-g>
    <xmx:Ip7maAk8NP5JV9o-9VjUopTzlVNE0PQazTKg9aGTeai69mYA3IJG3E1d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 13:23:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Andrew Harmon <aharmon@signalquest.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] git clone from bundle with --all does not fetch all refs
In-Reply-To: <BL3PR13MB520981A726145113DCA8B910BBE0A@BL3PR13MB5209.namprd13.prod.outlook.com>
	(Andrew Harmon's message of "Tue, 7 Oct 2025 23:11:16 +0000")
References: <BL3PR13MB5209A87037FC19CBB9B2916EBBE0A@BL3PR13MB5209.namprd13.prod.outlook.com>
	<xmqqa522icjy.fsf@gitster.g>
	<BL3PR13MB520981A726145113DCA8B910BBE0A@BL3PR13MB5209.namprd13.prod.outlook.com>
Date: Wed, 08 Oct 2025 10:23:44 -0700
Message-ID: <xmqqo6qhfgtb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Harmon <aharmon@signalquest.com> writes:

> The experience of "cloning from bundle should be just like cloning
> from github" did not happen for me. Maybe I created the bundle
> wrong?

I did not say "github", though ;-)

> See the workflow, below. Is the problem that refs are put in the
> bundle at refs/remotes/origin/* instead of refs/heads/*?

Everything looks as expected, including how you prepared a bundle
file.  Perhaps your expectation of what a bundle file is for is
different from what bundle files are designed for?  By that, I mean
that you may have a use case the designers of "git bundle" feature
never anticipated.

The primary and only use case "git bundle" was designed to cater to
was this.  The user has a repository on this machine that they want
to be cloned to another machine, but for whatever reason, it cannot
be done over the network by typing "git clone ..." on that other
machine against this machine.  So the user makes a bundle out of the
repository on this machine, copy that file on a USB stick, bring it
over there, and then the user says "git clone ..." against the
bundle file as if they are cloning from the original.

For that to work, refs/heads/master in the original repository is
stored as refs/heads/master in the bundle.  The remote-tracking
branches may by default not copied into the bundle, but you can by
instructing "git bundle" command.

And if you want to copy the remote-tracking branches via "git clone"
or "git fetch" over the network, you'd specifically ask for them,
as "clone" would by default prepare fetch refspecs for their local 
branches to be copied to your remote-tracking branches, and their
refs/tags/ copied to your refs/tags/. and nothing else.  As a bundle
file wants to imitate end-user experience of cloning or fetching
over the network from the original repository for sneaker-net
operation, the need for specifically asking is the same if you want
to grab (their) remote-tracking branches out of a bundle file.

Stepping back a bit, how would you make a more-or-less exact copy
of an existing repository over the network?  "git clone --mirror"
is probably the mechanism where their refs/heads/master becomes the
refs/heads/master in the resulting repository and the remote-tracking
branches they have in their refs/remotes/origin/* would become the
remote-tracking branches refs/remotes/origin/* in the resulting
repository.  So perhaps doing that against the bundle file would do
what you wanted to do?  If that is the case, then perhaps your use
case was covered by the original design of the "git bundle" feature
after all---to allow you to clone or fetch from the file as if you
are cloning or fetching from the original repository.

HTH.
