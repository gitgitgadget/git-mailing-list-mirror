Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD77F3207
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 03:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728445329; cv=none; b=n8M2iYCOi7wU9Eh6x/laoyjkEsnCAEOb9wvt16LZsgKDya6cGNooPBAGh9m5BOM71g7jDOG4hXFEQ7QPk2/7G/NBP5cwjw0Yt9Pu1rTG30KUgN6KBMHNuC1vsT+ccORK+SIUAavzfK5UTZfVIUmltLqBRExc7/WKrIxODTxPw2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728445329; c=relaxed/simple;
	bh=g0HoRIscP/sABqXMqK0KeSQn8p+SJ67PLAKZPb5yUKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ow+V2ZBxxPO4PT/FTI9KoVUxZNYigdCZQWrVTlPTdzYwzsC0AB0C7yPyOR0CaJMjZQ9tKnyaWu2BlrjQxjxFsm/DXpyak+kgT6+fxQXvdEg4lWKTZVkPTaXbllPTg/t2nIBBTtTnSOdM6kbYAGo2+zWjlDrr9qczHVKJ16aE4L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nKhRAYmx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M2mvbMKH; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nKhRAYmx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M2mvbMKH"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id C20FF138060A;
	Tue,  8 Oct 2024 23:42:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 08 Oct 2024 23:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728445326; x=1728531726; bh=HfL8Iy/m9r
	WbG0aPQ89SAU3WKxZ8zDpkPfLVUEOMfKw=; b=nKhRAYmxdEG2GwA2XoHOG4x+Ut
	P4tR5GyMRJ/QJs+D51WNtnJ1y1dAQxSpsI2qD451M8RD4BfqjbEtQGTmv6rr7BIR
	6edV26Mvf/oI3c89x7VaTz0MFN7+OHeUaPfxPt+vG/lAZt+6wfYqWMftBJi50YxG
	G8OUVoZLivQpb7Jb3taNGPEyr+OyqWTQfSV94H8jN5eO7S5XAdAI30d/amFQHqTE
	eRFq9XBw06XJf6ZzN2e0n5UcOFAMAyL8fQS+qn9ysanDANK0KeuLo2rHEOjvKthi
	Ebqe3CsiM1oCVoDAoZ2bfP5hrVRwTf5cbX4VbnuU5wF1gMLeexlSDBdajFig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728445326; x=1728531726; bh=HfL8Iy/m9rWbG0aPQ89SAU3WKxZ8
	zDpkPfLVUEOMfKw=; b=M2mvbMKH4E3F2iOIP523WLd/VS5JgusyeVSGHDlKh3vS
	tr85Vtqaiwkk6saQm9GeYUYP7c5+L2E9ZnCtlD15dIxQZ3A/mEkGWhsnlUyieQwm
	+onu4jbvAOySzDq58f6RzRCxWIW/5yAheAlDR4/ooQN7mtheyZ+Og0cNqlSc8OXz
	f0svk0EXL0/T5thgRCfB40lSXUr5lfFqCXF5tZuGEHsayUcQ+0tvznFGVt5XRhza
	Pmn45KCrKv7IF+EvMxSyUKi/E/q7wLvGTYWqDBS2gW1Pe4gQTwQ6c8wRZx9xDb0x
	Whu4n7YJCrhpU/0Knhd1pJuEY1zmXXt5Vgur9tWDHg==
X-ME-Sender: <xms:jvsFZ5Krb1R_au3OyA-giR03S9QFH2Bz8cIZUkl_67qBH_dJe8RUJQ>
    <xme:jvsFZ1JVP1aKfmWTdh5-Xc67D-jzHMcWJOQmcKJ1gOMkzVGbskcTl1lPSxhLyhYmg
    TKt506svlDUvafidA>
X-ME-Received: <xmr:jvsFZxtYl1rCl4o0bJfjS_eM16Q7jFT2WI3DiZje1G6SAJCKiCM1oQrUrYQUg3c9Mg4xpVR89UALv8RRV-GltjWQaCFaThj0WtfFxM-3Pu40iA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefvddgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfihhvvgdv
    fedutddtfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:jvsFZ6YxYHNAZLb8tp_Il8rTOUPH1T0MCK9OacVKP85fTpd0dAiVxA>
    <xmx:jvsFZwYM3IEoCzqfEc6F8B48_mLw-f6N1I2C1MRgSFksdgTzLr2xVQ>
    <xmx:jvsFZ-Ae7cd1o-5f2lTQo7vpjliOD_0fe5zL9d4V-6VzSUwV4gCreQ>
    <xmx:jvsFZ-b20FJdIIXmKDVZs1usyNeNWyCF2l-LfCxfnNzXO9eRHEkWiQ>
    <xmx:jvsFZ_lTfpyISnu5UwMbu5svoEXifsmJ9c_uqVcfm23AoSSB0GoKgBzM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 23:42:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a75c8539 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 03:41:03 +0000 (UTC)
Date: Wed, 9 Oct 2024 05:42:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [Question] local paths when USE_THE_REPOSITORY_VARIABLE is not
 defined
Message-ID: <ZwX7ieAvmjQma45E@pks.im>
References: <ZwQSWcmr6HWTxxGL@five231003>
 <ZwUkUuQgxaE2-djk@pks.im>
 <ZwVzF9Xgn72tT5Ee@five231003>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwVzF9Xgn72tT5Ee@five231003>

On Tue, Oct 08, 2024 at 11:29:51PM +0530, Kousik Sanagavarapu wrote:
> On Tue, Oct 08, 2024 at 02:23:54PM +0200, Patrick Steinhardt wrote:
> > On Mon, Oct 07, 2024 at 10:24:49PM +0530, Kousik Sanagavarapu wrote:
> > > Hi,
> > > 
> > > I have two questions but a bit of a background first -
> > > 
> > > [...]
> > > 
> > > So my question is - do we want, in the future in which we are free from
> > > the dependency on "the_repository", for all the local paths to be a part
> > > of "struct repo_path_cache"?  Which in my gut feels wrong - one alternative
> > > then is that  we will have to refactor REPO_GIT_PATH_FUNC - or am I missing
> > > something here?
> > 
> > What I don't quite understand: what is the problem with making it part
> > of the `struct repo_path_cache`? Does this cause an actual issue, or is
> > it merely that you feel it is unnecessary complexity?
> 
> I feel it is unnecessary complexity.
> 
> 	$ git grep -E "(static GIT_PATH_FUNC|^GIT_PATH_FUNC)" | wc -l
> 	65
> 
> Meaning each of these would have to have an entry in
> "struct repo_path_cache" in the world where we don't rely on
> "the_repository".  Some of these are also not direct ".git/some-file" but
> ".git/dir/files" where ".git/dir" is also given by a seperate path func,
> like ".git/rebase-merges" and ".git/rebase-merges/head-name".
> 
> So why hold pointers to such filenames instead of just calling
> repo_git_path() manually - all these filenames are "local" anyways - unlike
> say files such as "SQUASH_MSG"?

It does make the interface easier to use at times because you don't have
to worry about freeing returned strings. In other situations it likely
is unnecessary.

In any case, not all cases must strictly be converted to REPO_PATH_FUNC.
A refactoring may also decide that using e.g. `repo_git_path()` or
`repo_common_pathv()` might be better alternatives.

Patrick
