Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F186B3E8C7C
	for <git@vger.kernel.org>; Tue, 19 May 2026 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184073; cv=none; b=lhUPIHQwz/PDoltckmR087LxxzUgWt6dMagjfUYxdpdqhRi9KYRaljfpoXYlep6Q6iIVv3dAuzz4GtJ82lKR+DF6cfu4xq7GiW1YF/8I4yJFj0KlW0hHg9OoO1R5lKRWQ1+2J0r8ITNiX9vSGWklQbAJlG02yWzAnEdPVYhxE/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184073; c=relaxed/simple;
	bh=yzDlCdfwQs4Vm5sCOg+a9FQdFptbfbk32UhV4tiGEpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8BJ0r54tuxa+yGYOeVLRsbcGhcWMXIjEiAJNhvrpLS68FGZhhwKH3WjEhG0KsTHstpGSd2F/ta6CYUVUp0HCQpLtM9U3b68KwRy/gJJjrD9X5Kvl6t0wsPqJppQf85r4pcnw1Vou6iRrNeDJrwFKGnjY5TMFAuPvnkI5uk6c70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UZSLGTmQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UNf1ACZi; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UZSLGTmQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UNf1ACZi"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 334617A00D1;
	Tue, 19 May 2026 05:47:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 19 May 2026 05:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1779184070; x=1779270470; bh=WW96hjP2gD
	ShenBcIv6LsAtvfCoorF+1C9gX4f1qFHo=; b=UZSLGTmQGk+RCA5bUbxqNGhTTR
	qXPsXmw0qhj/Rj7bzqcFwAJTe7eLPqB53jyXsgoK0nnTYTx6afk39FGxZ5RGj/sw
	uLAqZqxFWzks96LslxheKU5qG0HziVm2fNno+lSNbWdXRb7lXNiXZzWmDORUDlTL
	aE+C30NKJfJxkSraVmd1PwwvcdeupocOckN41LV4+KQtIQBgi5iBN+RPLnFJ1bPP
	E8MrTbKra2P4xgBoC3he+3WeD4ausSDVj9I+yBz93L8DDJ+FUmOV1b3MuoocfctW
	QjFgl4rND2jhfF5zpYZU6Na7Qn15SzITGufqqMqYNbHbTbWPrf20P/JrltMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779184070; x=1779270470; bh=WW96hjP2gDShenBcIv6LsAtvfCoorF+1C9g
	X4f1qFHo=; b=UNf1ACZiYrMu77E9DDAETkUj/69rnlcvWNh5z7LIYylU+s9mAnX
	n0vTQXhqabKqaUhJVqiK2dWc+EhvfzeTVsefMEuiHD3BBSEuCh2z6odv1F24OMMP
	ESl8KI5eB/LGWw6hbv1ZhJlEJLic3s1lVrZrrObfYHvg1YsCtq1deQbfpCucLNJU
	bPSBd1gRxy7wxyg5uRJXsEedQ/2IgpeQmwY/4ywwdmGOt4diT6VJZed7Ybn/d3Oq
	EOapH0zSTM1Mwod3GYch3JD9D7r2EzaeWWS6/AW2+Ejy+bzhrgm/sJ7NymM7DC75
	UZu9dhnmHRfZADcx7g3Ev9DraQkfYFR9qfw==
X-ME-Sender: <xms:xjEMapLkIK-LdVO7mR1pSHgP4i6UXn40YWHdyevXumwNTvx-tpCMFw>
    <xme:xjEMasBkIYw4-1mhs0EYu3HSARdNEbWh37yxGAcazIKa1_tFRouwhiXxj8RqkLVwx
    Ddc1_aW6LG2WYeDoyuZpWk4jFriA3yTQ2MGRC-5oR1Ci5cTnKRvlg>
X-ME-Received: <xmr:xjEMaqD4zq7zjbyiLDIeTrBhggBVRErwGt5HKz-bipB3J8zjFpTiO2qasVQZjX6sonQK7V7rFUGN-tduRB62Og7nnBqQS660geHwVNQIGyc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedugeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheptggrthesmhgrlhhonhdruggvvhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xjEMamDGoNobKN2LKZoLC7WpD4iX9kdNjHE-JDu1JO5BBrAqqKIdNw>
    <xmx:xjEMatpzRN6uDSzI9A1lkst7hVk0j_-iTtXJ9PA09doF6gZ3it8JuA>
    <xmx:xjEMaomJLwDwrjCF-DaBI_dmvKPBOpn02PpAp3i9DzhTD9WQ4RiTqg>
    <xmx:xjEMalztU7iYxdMdKST83fzJeFfokSHKUYgoplv1d6fMoF4DOziJFw>
    <xmx:xjEMavQyrmsF9rCjrZg4n7-TtibDJLbdXqvC2aPdymt0b8FSXmzm_lf7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 05:47:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3da35794 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 May 2026 09:47:47 +0000 (UTC)
Date: Tue, 19 May 2026 11:47:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
Subject: Re: [PATCH v2 02/18] setup: stop using `the_repository` in
 `is_inside_worktree()`
Message-ID: <agwxwNIfZuwj9qod@pks.im>
References: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
 <20260518-pks-setup-wo-the-repository-v2-2-6933c0f1d568@pks.im>
 <CAOLa=ZT2Qo+oJ1rx2iM3QRcXMGaucFRJdxBAgxBdz3ZtgSb=Qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZT2Qo+oJ1rx2iM3QRcXMGaucFRJdxBAgxBdz3ZtgSb=Qg@mail.gmail.com>

On Tue, May 19, 2026 at 01:23:21AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The function `is_inside_worktree()` verifies whether or not the current
> 
> Nit: Here and the subject s/is_inside_worktree/is_inside_work_tree/
> 
> Honestly, I would prefer `worktree` as that's what we've used through
> out the code base, but that is probably out of scope here.

Oh, good eyes.

> > Note that there is one small gotcha: we sometimes may end up with
> > relative directory paths, and if so `is_inside_dir()` might fail. This
> > wasn't an issue before because of how we proactively set the cached
> > value during repository discovery. Now that we stop doing that it
> > becomes a problem though, but it is worked around by resolving the
> > repository directory via `realpath()`.
> >
> 
> Curious if you discovered this via a test. But running the tests
> without `realpath()` didn't trigger any failures. Is this something we
> can add a test for?

No, I wasn't able to come up with a test for this. I think overall the
paragraph could use some tweaking as it's warning about something that
cannot happen right now.

Originally, I had the order of `is_inside_work_tree()` and
`is_inside_git_dir()` reversed, and I had most of the commit message in
`is_inside_git_dir()`. So this explanation here was originally part of
the gitdir commit, and here it is correct: when setting the repo's
gitdir we don't resolve it to its real path. And not using the real path
does make tests fail in this case.

But this is different for the work tree: the only caller that sets
the repository's worktree is `repo_set_worktree()`, and that function
does use `real_pathdup()` to resolve the path. So we know that the
worktree is always the absolute resolved path, and consequently it's
unnecessary to resolve the variable again.

So there's two ways to handle that:

  - We could be defensive about it and continue to allow a relative or
    non-resolved worktree path here and manually resolve.

  - We could rely on the fact that currently the worktree path is always
    resolved anyway.

I think a world where we only ever use absolute paths is preferable, but
I honestly don't trust our repository setup infrastructure enough to say
that this assumption will never break. Furthermore, it would create some
asymmetry between `is_inside_git_dir()` and `is_inside_work_tree()` that
is overall a bit puzzling.

I guess the proper fix for this would be to also change the repository's
gitdir to be an absolute path. But that would result in a bunch of
user-visible changes, both in error messages and in commands like `git
rev-parse --git-common-dir`.

Meanwhile I'm more leaning into the direction of keeping the code
as-is, but correct the commit message.

Thanks!

Patrick
