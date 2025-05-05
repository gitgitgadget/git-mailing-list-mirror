Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B12EBE
	for <git@vger.kernel.org>; Mon,  5 May 2025 06:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746426286; cv=none; b=jfAvmnBWgl+5pvTDfdIl1tlPcPaL7gYXzMI4XOQ+/BeKc8zbvFxsQOjpq2P92w8Ir1Hvy3kKIW6Ej21rCl3PdYzDFvKe/DF5QGaY+wXC1i2FnJosO3RQ+pB6OaESOGcjV7hUvbaK+NK41E9yI7bOcMAEgL1nIpdR6SOXLjs1CkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746426286; c=relaxed/simple;
	bh=elO33Nrp6KMM5iEIvGWm/2Q05JnsCgm5JHd/yDZQSsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIVpb0JM09DB1qsfDL/h8tvl9DPMPHuqcPF/7pqmJcuOoEerOXBsEjwx8e/hr1tJaDTdVxG9eX/eoTl1oO5cQ/nPK40xyD1CM6t5+cC6BGnXe44SlbCA3UGLy+73/sKm3yJhuIzNXYLcWZgEj/fvexbA5U4e335ViZieCfGxwmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S/997Tln; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hk4rLXC7; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S/997Tln";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hk4rLXC7"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 60F2D25401BA;
	Mon,  5 May 2025 02:24:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 05 May 2025 02:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746426283; x=1746512683; bh=qhpS/NgDSY
	TcuxrYuOvCQ8aaLQCzOJ17yj2gySVialA=; b=S/997TlndQpIi5D2+20bpM8EZi
	yVmEEuJRTu89RhfWkIb5cpNjhaohluV1vM/Ka2rfWS2zoKVEv+L34TTtFG0QpOOP
	PjwoTK04CliebOoF2cwmvXdAS8DAFPhgVjECiUOcOiBgIVcBNnt7jJ7CkqSnwkCJ
	F8OwbbCv01PGh/IlCjOA3SF4ev6pyi6e7pEro49VJvpO3iTRbUKmzyBFdm86SrBF
	BWELdAq+8U5m9db9mBEiDeyyOsTsynbCOMaQ5bxxGUpg8bZ2xHcqhEux2N4WHs0h
	pk0QYbyy5EkIsC7BcCCJC6gal7n9jB1ypqV88J8EBpoVf9lXGk+FUT2qSxLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746426283; x=1746512683; bh=qhpS/NgDSYTcuxrYuOvCQ8aaLQCzOJ17yj2
	gySVialA=; b=hk4rLXC7DpZ6sE1PASeeXX3pkQV5IZ+j2MY+YqV1kmy03XpZbXJ
	FLFhZm8aziy/zDKLjxwBrfeapw/9bffDtGEJC5DWOztyEeiTk6qaESlBpwQsxeC3
	0e50o4vpekPRMibjBUESxdmxXjBgJDYqh+TJif+rqlk4GndhlFHuWlMgsfiY4Zjt
	4iJKfKUrjcIh+ngJD5DFTcqtNElSt6YhVTrcP9XIT78FLB51kr7PPllkVKEFyUkf
	a7cTCad8ko1Osf9FevQaPnmwA9hW4QQZfUry3CvhVRJPwf+K6re9um/csLmzqEC9
	A3SOPvHEJdDA9xtN+g8Ct4Z9AKch5Bcw0Qw==
X-ME-Sender: <xms:q1kYaIQ_-P_O9zdcQE5Dj7DDwLj0DXZF07WVUCgu9IvvIr96nxZJWw>
    <xme:q1kYaFy_aVOieUpjrwI6JQLwddLTeg1IbDh6UU_1nTKxA3LKELtt0cu3FilKrYIeA
    LY_BwE9yOOnrCfWYA>
X-ME-Received: <xmr:q1kYaF16I653IR-MO2xUHSOCpsE8BTKRs6eWoKVLUNxRl46A7ywjClCi0tljN5W6IjS50HHB4qbA8Ts8KgYW3Ao_1pkHgTPLvJPHTCmNXqQNtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepleekgfeuledvkefhhfeugeehvdffjeekjeetkedu
    teeuffehkefghedtueevtedunecuffhomhgrihhnpehgihhthhhusgdrtghomhdpmhhitg
    hrohhsohhfthdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehg
    mhigrdguvgdprhgtphhtthhopegrrhhnohhuugdrsggvrhgvnhgushgvnhesshhophhrrg
    hsthgvrhhirgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:q1kYaMATqr2ePl6DRZFUDoFWPMJBikO_SQs1sh57RM-5bWTYv4FFJA>
    <xmx:q1kYaBitbIBrJDvLPTrY_xV6BF4YQWJXKRJyT7iLZ1p_tL2vDQbixA>
    <xmx:q1kYaIrfzzTqmI3Qp4YQh6NKNPeyo1Kb1cvMdlHoqBOgo-Hu-2cilQ>
    <xmx:q1kYaEi7LXFodPbNjms5MsbyB003bKaAs1UU2BEyBnwfELj28YoEsA>
    <xmx:q1kYaKVVJt7sWJEq5zt1pta_gd8dg5IsSDWDhALJqIvsIR4eZw5mT4TY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 02:24:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3f7f8561 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 06:24:40 +0000 (UTC)
Date: Mon, 5 May 2025 08:24:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: BERENDSEN Arnoud <arnoud.berendsen@soprasteria.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Cleaning up "contrib/" (was: git svn clone failed)
Message-ID: <aBhZHA7av8bWH9Ac@pks.im>
References: <DU0PR07MB8465C407519BD5A8C8F933CE9D8D2@DU0PR07MB8465.eurprd07.prod.outlook.com>
 <3f3a0ee6-49a5-8013-7fe0-65c9ba8bfc3a@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f3a0ee6-49a5-8013-7fe0-65c9ba8bfc3a@gmx.de>

On Sun, May 04, 2025 at 10:19:06AM +0200, Johannes Schindelin wrote:
> Hi Arnoud,
> 
> On Fri, 2 May 2025, BERENDSEN Arnoud wrote:
> 
> > What did you do before the bug happened? (Steps to reproduce your issue)
> > 
> > - I was migrating an SVN repository to Git using:
> > git svn clone <my-svn-repo> --stdlayout --authors-file=C:\path\to\my-authors-file.txt  --preserve-empty-dirs .
> > 
> > 
> > What did you expect to happen? (Expected behavior)
> > 
> > - I expect the entire process to succeed without errors.
> > When unavoidable errors do happen, I expect the error message to be helpful, give a clear description of what the underlying problem is, and how to solve it.
> > 
> > 
> > What happened instead? (Actual behavior)
> > 
> > - The migration failed with the folowwing error:
> > 
> > r2814 = 1ecf20e2d14b45ee517b56f5f51b406801e9869b (refs/remotes/origin/trunk)
> > Found possible branch point: https://<my-svn-repo> => https://<my-svn-repo>/branches/<my-branch-name>, 2814
> > W: Refspec glob conflict (ref: refs/remotes/origin/trunk):
> > expected path: branches/trunk
> >     real path: trunk
> > Continuing ahead with trunk
> > W: Refspec glob conflict (ref: refs/remotes/origin/trunk):
> > expected path: branches/trunk
> >     real path: trunk
> > Continuing ahead with trunk
> > Initializing parent: refs/remotes/origin/<my-branch-name>@2814
> > Use of uninitialized value $args[2] in join or string at C:/Program Files/Git/mingw64/share/perl5/Git.pm line 1655.
> > Use of uninitialized value $_[3] in exec at C:/Program Files/Git/mingw64/share/perl5/Git.pm line 1681.
> > fatal: Not a valid object name
> > ls-tree -z --name-only  data/OVK/: command returned error: 128
> 
> In Git for Windows, `git svn` is quite a maintenance burden (with a few
> known issues) and my current thinking is to drop it from Git for Windows
> instead of leaving it in the current shape (I, for one, cannot justify
> working on it myself, and the same seems to hold for everybody else, too).
> See also https://github.com/git-for-windows/git/issues/5405.
> 
> Is there a chance that you could use the [Windows Subsystem for Linux
> (WSL)](https://learn.microsoft.com/en-us/windows/wsl/) (i.e. the Linux
> version of Git) for this migration, especially given that the
> characterization as "migration" suggests that this is a one-off task?

I sometimes wonder whether we should move such basically-unmaintained
scripts out of the Git repository. They do a disservice to both us and
to our users as they create the wrong impression of being the sanctioned
way of doing a particular task even though they have only been gathering
dust for ages.

Many of the tools in "contrib/" fall into this category, and to the best
of my knowledge there isn't really a clear strategy for that directory.
So from my perspective, we should either rethink whether it is worth it
to have "contrib/" as part of Git, or we should at least do a spring
cleanup and drop bits that haven't seen any love in the last couple of
years.

Patrick
