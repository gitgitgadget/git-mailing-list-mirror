Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829632AF14
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 19:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743623374; cv=none; b=p4rIHFmLFSoES6ZthH9UgIaY7rhrnXYo/wsuvcTXNn+J1foK4/Cc4MULeDpSWNZ5qnYS2UsIST/gVkuZCG8EprjUQ49FYWaTVGkzYbwu6MwRLJjMsG+WKE0HB7jBqh3kYbBF1rqty9Wv+5niR6y8fQ5bZRnZjut5hMvkqc/2rYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743623374; c=relaxed/simple;
	bh=oR+snq27XWsODs15y4xNG2MtXZLf11T5WNbYJ7XZusg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuRmTlp/vEchJkDE3dC9nmASq6caqWTfJqeBDMgVuRRrrPMuyYcsHN35tLezZWmuJB+946nnDntUHvRrEcHJTa57UROuOWQEI/4/9ev34BrC1NmFm9jM7QSU5losobq/OD2o3nlhwIjsygPL/9EJ6UxQoOOi96Kv6x/fRl9yCR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JkzpOk1r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JkzpOk1r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC416C4CEDD;
	Wed,  2 Apr 2025 19:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743623373;
	bh=oR+snq27XWsODs15y4xNG2MtXZLf11T5WNbYJ7XZusg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JkzpOk1rhLm5pKmqJfzlsXhy4ic8C/ePkGgX4YomiNphbA7Du58t3H1xj+H8NHiBF
	 dAJOe7Sf6wEHVCWv/jLoGy5MencGVnccCZ/2WTXcK+yaMpCeiP0Jh6j6DkRDgAJJyu
	 HBi9xa8NupC4OBAUk4CNXdiKYDat/HVzlKMS0aBc=
Date: Wed, 2 Apr 2025 15:49:32 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Remo Senekowitsch <remo@buenzli.dev>
Cc: Martin von Zweigbergk <martinvonz@google.com>, 
	Git Mailing List <git@vger.kernel.org>, Edwin Kempin <ekempin@google.com>, 
	Scott Chacon <scott@gitbutler.com>, "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
Message-ID: <20250402-classic-hilarious-barnacle-7d0d0f@meerkat>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <D8WEKR5QQD3W.23CD3CXEPONGB@buenzli.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D8WEKR5QQD3W.23CD3CXEPONGB@buenzli.dev>

On Wed, Apr 02, 2025 at 09:34:18PM +0200, Remo Senekowitsch wrote:
> Mailing lists don't suffer from this as much, because mail clients don't go
> out of their way to hide old patchset versions from users. However, they also
> don't provide any tools to help code reviewers associate old and new versions
> of patchsets. A change-id header could be essential in developing tooling
> for mailing lists that track patchsets and even individual patches within
> them across versions. Easily being able to view the interdiff between the
> last-reviewed version of a patchset and its most recent version is tremendously
> useful for any code review workflow.

Yes, this already exists, using change-id footers.
E.g. you can run this inside your git checkout:

	$ b4 diff 20250331-b4-pks-collect-build-fixes-v2-0-6b06136808f3@pks.im
	Grabbing thread from lore.kernel.org/all/20250331-b4-pks-collect-build-fixes-v2-0-6b06136808f3@pks.im/t.mbox.gz
	Checking for older revisions
	Grabbing search results from lore.kernel.org
	---
	Analyzing 19 messages in the thread
	Preparing fake-am for v1: meson: fix handling of '-Dcurl=auto'
	  range: 98f2b1fb3587..163b98dec916
	Preparing fake-am for v2: meson: fix handling of '-Dcurl=auto'
	  range: 1406ab7e183b..df3c15fbd1ce
	---
	Diffing v1 and v2
		Running: git range-diff 98f2b1fb3587..163b98dec916 1406ab7e183b..df3c15fbd1ce
	---
	1:  6587b42aec = 1:  f41c06addd meson: fix handling of '-Dcurl=auto'
	2:  d8d124b84d = 2:  8c2301bcd5 gitweb: fix generation of "gitweb.js"
	3:  1f27a035f9 < -:  ---------- meson: require Perl when building docs
	4:  163b98dec9 = 3:  e1962003a5 meson: respect 'tests' build option in contrib
	-:  ---------- > 4:  6f07c417a8 meson: distinguish build and target host binaries
	-:  ---------- > 5:  df3c15fbd1 ci: use Visual Studio for win+meson job on GitHub Workflows

-K
