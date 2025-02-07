Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3764E2B9B9
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 10:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925366; cv=none; b=iiv2ZHwWAcTQ2MqsBtciI8mXX7hNm7rfm4WMslvJk7sLF9PXB4HMtzdCIiHDh/WB16E9EB2yPU4SHweEKKPNMsy2Hql4VW131SRuj/AP7z82WpBtLX2+TwAm+Ab3CHg6nJbtUKYDgXkD9EjB0ZSwEjGZsmu69igv7sQE7/Cyhn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925366; c=relaxed/simple;
	bh=jRYvsC2+yRKEUyQ+O7BYTs7iY0DEMB+1eaHpx6k4Apk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUsK08cf9vDPYX1yhEIFSY4Dze9Q81ac4rnoI2z68NoetYHbdZASJGmD2oBqCy8SsOCdYrIVmZUbaCX1l5yrCMt2tlzijcX4dRgkhY+49qh83MR0ePGf6nQItWeUpghHCdNDVmNHV1fDD6+AOKOIsLMlKlzsu72ctmefMDYYQrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bgVBeill; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xLzBqiUh; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bgVBeill";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xLzBqiUh"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1856A13801DE;
	Fri,  7 Feb 2025 05:49:23 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 07 Feb 2025 05:49:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738925363; x=1739011763; bh=5qA1rBg5i1
	qbl4kR0c1pt+EZn6etw8ELiPv+3LV533U=; b=bgVBeillGP7WBHKi94m+7ZssV3
	AGbtUWVdnaNgtgTVIo56DFdm35y91R+zLREHlOaKQrGG0sbfOtZ0uh2BvoY6vo9i
	w+X3MBHddPJTBt+WEoFZtrseyEg3Pn/dtTfidXoIXqNPjzMun1l0R8fym45gThw1
	z2Sycq/fzhJkn1KWtNdrXZs8lO4EjtIxhIJrwTo6rfRUQg6l+KzTiiebfq7RsyXH
	pn1+hnpY0WSgRcEOLMtm4Rgn96RG/WQtNpd663uf3grJGUEMWXTwFfltwHydReP/
	JAHhZrKlF4fVe27ugGv4/35s7RIB8+E3c3+k7NEG5kim929pcLtKvEvpWo8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738925363; x=1739011763; bh=5qA1rBg5i1qbl4kR0c1pt+EZn6etw8ELiPv
	+3LV533U=; b=xLzBqiUhqi1ULxW0IEmh/kr0QVSd03iEG7zh+fqVtrsfIcPL7Ys
	262X8B+52pKeiLD3LW+XI92TT4cSPfd+oez5P2C+x5Dn38vQbUMraa9DXqKehw68
	XpWv3Li1VqyWFyaUVm0WF3YgXVXMY7Wfy+ZeB5TV9LnevpN08zr+K5hMOrG+QcLT
	REvo6K1KueYrE7SYIWeG0Ky8Ilc6CiRKDSQEVMVEwIf2YFOdb7HWM/F+wEjPL/g4
	bcrDfbqnjC9FZjrV/yxityl6l0gCqfrNlVjh6uSflftJCM7oWpnB+8vIyAt1RfHt
	uRk8qU6kHduI1KJrrxbvsQ9y1vCZfDHoHZA==
X-ME-Sender: <xms:MuWlZ2Iuqlcg6t17wmPrT-imBTB8SUM09kA-SZlpGUEHZxrs1ycg-g>
    <xme:MuWlZ-Lnbz9hG5I8YuFD_4NTY_d5AYWQOIsM08dbQUqmN7OPNQaO52ANUkMX__eI6
    _WsrFqBDtzSixRG-w>
X-ME-Received: <xmr:MuWlZ2sfs0TybubYlLXRAcoCy1mmUm3Og9WMRsTfePzrzsHzMuktIWXloE9SXJwOK4Oo5fkmLFVSpMuKgL2UFwJQUMpijv8wy0IhjzIYD8puPI7j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:MuWlZ7buBTQYTHkEB3eVeenhJHeD9vjT9TK9M4KibGpUKSf-auC9uA>
    <xmx:MuWlZ9brCZvjWFLnaCMwOGgJ1KZ8pkiqFSza25YNHvGMF2W-WnEy3Q>
    <xmx:MuWlZ3BKSmvpeNBQWq9aADqspFHqJmmDgoFDWA0q3aIt8rxvvpGFbA>
    <xmx:MuWlZzbjX5_hQi5EqSjCqO2Jh91nKAQ6apMb9HkQFr2MbnNE9NYNdg>
    <xmx:M-WlZ8ldeuKkCNhQAK7ohLR4lj7LBPe8aRdz_22S6b-NIRpPv-BKHf5e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 05:49:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id df99450a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 10:49:18 +0000 (UTC)
Date: Fri, 7 Feb 2025 11:49:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/16] worktree: return allocated string from
 `get_worktree_git_dir()`
Message-ID: <Z6XlKVwsYNskS_nR@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
 <20250206-b4-pks-path-drop-the-repository-v1-9-4e77f0313206@pks.im>
 <CAOLa=ZSXFqvwFEfJ+cktqzSUf0XMoFC8Z0S0DJHcg4jYN4+DcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSXFqvwFEfJ+cktqzSUf0XMoFC8Z0S0DJHcg4jYN4+DcA@mail.gmail.com>

On Thu, Feb 06, 2025 at 11:15:58PM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The `get_worktree_git_dir()` function returns a string constant that
> > does not need to be free'd by the caller. For `repo_get_git_dir()` and
> > `repo_get_common_dir()` this is because we return strings owned by
> > `the_repository`.
> >
> 
> Not sure what the second sentence is signifying here. What relation does
> `get_worktree_git_dir()` have with `repo_get_git_dir()` and
> `repo_get_common_dir()`?

These are getting called in `get_worktree_git_dir()`. I'll rephrase the
message to make this clearer.

> > But for `git_common_path()` it's a bit less obvious though, because that
> > function does end up allocating memory. This doesn't result in a memory
> > leak either because we write into a buffer returned by `get_pathname()`,
> > which returns one out of four static buffers.
> >
> 
> Now `git_common_path()`, what is binding all these functions together?
> Sneaking down to the code, it looks like `get_worktree_git_dir()` calls
> one of the other three functions. Maybe we should start with that?

Yeah, I've reworded the commit message accordingly.

> > diff --git a/revision.c b/revision.c
> > index 474fa1e767..be72f226f3 100644
> > --- a/revision.c
> > +++ b/revision.c
> > @@ -1874,15 +1874,20 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
> >  	for (p = worktrees; *p; p++) {
> >  		struct worktree *wt = *p;
> >  		struct index_state istate = INDEX_STATE_INIT(revs->repo);
> > +		char *gitdir;
> >
> 
> Nit: should this be named `wt_gitdir` to stay consistent?

Makes sense.

> > diff --git a/worktree.c b/worktree.c
> > index 8f4fc10c44..3b94535963 100644
> > --- a/worktree.c
> > +++ b/worktree.c
> > @@ -59,8 +59,9 @@ static void add_head_info(struct worktree *wt)
> >  static int is_current_worktree(struct worktree *wt)
> >  {
> >  	char *git_dir = absolute_pathdup(repo_get_git_dir(the_repository));
> > -	const char *wt_git_dir = get_worktree_git_dir(wt);
> > +	char *wt_git_dir = get_worktree_git_dir(wt);
> 
> Nit: here too, even though it is a pre-existing name. Perhaps it is just
> me. So feel free to ignore :)

I'll leave that one as-is, even though I share your sentiment.

Patrick
