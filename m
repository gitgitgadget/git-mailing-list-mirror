Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916A71F2B82
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 11:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050307; cv=none; b=p2RGJ6td+Qsv88+Ydx9rRHcY1/TLKOqUQ9t50JVHInio51PqhajWhqSLLZLxHS7n91+bSnmbSf98YiL/TBNnl6wHhaRajvHL2hYma1UiJkdkMUP+XHZ8Gl+zeigkEgC2Ofv0IZGdV0dLTS/DvNR9qhri5FuuBzMeF1PYSriW+6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050307; c=relaxed/simple;
	bh=oi3u5ME4cinjw/1bWker9lRtbmrR0EoN9bJ0ENQVF5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDcDR8BV/a4+xR3QG7ATtj7aOXI+PyllF2MV4vuRvZA1h4CheV8Sul0t6vkzwi0BfoyTGO3QOvDmdap7peLtzqM/LK6SifzY6SOQ1clUHcySrH6s1bw6QKgIzevXEcMuCBg6hUNUot53QFhypzZWIaUroQIWD+Kvl9DEOTaLXvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=s5hj8o/O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vIi+nGLz; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s5hj8o/O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vIi+nGLz"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 095C11140172;
	Thu, 20 Feb 2025 06:18:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 20 Feb 2025 06:18:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740050303; x=1740136703; bh=gmgqT+NDym
	o/9RTn1XTl0LChRU1tUVxHBrS7CTUFhQw=; b=s5hj8o/OCLVAgivwFa9itAahPP
	SARcPsYcbwvhOrdhfngyB6BW4iRU+YJwJ988G3rtPTaR8a/1dNQB75VfMI9L+jJE
	1zNJRNxz3rmIjX8l6zvmsi2RfOX9fkVfS/xqFTqXkXNxDrWUKciVJJ2LQzQv7dKV
	A45D0Pxz/w87HIY6NvF0KSFWobBomeZi0oirFXwPTN0ndpCDjLJbfJk7VYFxHnTC
	asIKMaQdOLh83P6YCt8S1pOTMkn27thnDamPSGS2tQE2N4hTS6tg+WbrYlwrCn7V
	zjr9EQBjHXBt70miIPhKZhmLSFZXQG+WHrrCS1PTYatqSFxVtnbFxvWplfuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1740050303; x=1740136703; bh=gmgqT+NDymo/9RTn1XTl0LChRU1tUVxHBrS
	7CTUFhQw=; b=vIi+nGLz4H84PO8Nui/idP/MrZTwigB1bCUqdp4rYoemKnLlEqb
	w1TEYNqLwZSh7jfC5u60IisgHek/fl5mimUFcIzCAiD5KwJ+RsOK1Tf+/FWpPhPo
	q53kkEUxSM4sFz6uQIh1wZ61FYHF5lfWoN+itMf3FiQ6hrc7JZZigGdHjgoN677t
	SIgDd3/HyRF9wSlJiJcJBmSOR+LNn2Tuhe9DNEypxNdSd4X/12S5S5+zEJO8Z7xN
	t+7aet4WdNHqhH2+4LdvAkYHk9Qywifj5J2BvlUFxI57U3Y92iJrGMJlpNypbvSo
	4uorKOpvVlZBbH/bxY9tS3x5WiNRKAKHi+w==
X-ME-Sender: <xms:fw-3Z8hVzp8rWqq9g0a6aL5uN90QDD3NTAsEZC7FcyBsIgCKylF0uw>
    <xme:fw-3Z1BSQji1db4VqglK7ERPlces9kL99fv59fmh_k9UqIPzjDHaOqQNczC22svBg
    POrvRg6s-mc51ExMQ>
X-ME-Received: <xmr:fw-3Z0FEUcNdz6TxD8V7CMGX6Aoe5rhJ0OD-OqWP8r98h5QcQkd2CsP3H8IHf1xZN3I3aGF8vu4JzURg2k8fAWNdRVDby_LXBrHoAMWGztp_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeijedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:fw-3Z9Thu7s98q3ul2IyvV0GhTIgSR7oIfk54uxVisGNGMojbLznnw>
    <xmx:fw-3Z5xjl__9Fr3qQ5gfME3mquufhNQ4DCT6cMe46-qpyJnKqww1UQ>
    <xmx:fw-3Z74tqnNx_vXk9JmOGOz9wrtmTzTu-_U23b0kpKokPAfnr1eAGg>
    <xmx:fw-3Z2y_U4aPlWBDLjDjUsGCUDd2wd-MKJbrR33SPjSpKzANkIJyHQ>
    <xmx:fw-3Z0_IuP-IaSUQizhDoY8qjXiuZENrN3wCq5JRTxlorif0Ia_f3Izt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Feb 2025 06:18:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id be2a6816 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Feb 2025 11:18:19 +0000 (UTC)
Date: Thu, 20 Feb 2025 12:18:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2025, #06; Tue, 18)
Message-ID: <Z7cPd79kZzJkLPi3@pks.im>
References: <xmqqy0y2hg8l.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0y2hg8l.fsf@gitster.g>

On Tue, Feb 18, 2025 at 05:31:54PM -0800, Junio C Hamano wrote:
> * ps/path-sans-the-repository (2025-02-07) 16 commits
>  - path: adjust last remaining users of `the_repository`
>  - environment: move access to "core.sharedRepository" into repo settings
>  - environment: move access to "core.hooksPath" into repo settings
>  - repo-settings: introduce function to clear struct
>  - path: drop `git_path()` in favor of `repo_git_path()`
>  - rerere: let `rerere_path()` write paths into a caller-provided buffer
>  - path: drop `git_common_path()` in favor of `repo_common_path()`
>  - worktree: return allocated string from `get_worktree_git_dir()`
>  - path: drop `git_path_buf()` in favor of `repo_git_path_replace()`
>  - path: drop `git_pathdup()` in favor of `repo_git_path()`
>  - path: drop unused `strbuf_git_path()` function
>  - path: refactor `repo_submodule_path()` family of functions
>  - submodule: refactor `submodule_to_gitdir()` to accept a repo
>  - path: refactor `repo_worktree_path()` family of functions
>  - path: refactor `repo_git_path()` family of functions
>  - path: refactor `repo_common_path()` family of functions
> 
>  The path.[ch] API takes an explicit repository parameter passed
>  throughout the callchain, instead of relying on the_repository
>  singleton instance.
>  source: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>

This series has been Ack'd by both Karthik and Jialuo -- do you want me
to pull in additional reviewers to move it forward?

> * ps/build-meson-fixes-0130 (2025-01-30) 14 commits
>  - gitlab-ci: restrict maximum number of link jobs on Windows
>  - meson: consistently use custom program paths to resolve programs
>  - meson: fix overwritten `git` variable
>  - meson: prevent finding sed(1) in a loop
>  - meson: improve handling of `sane_tool_path` option
>  - meson: improve PATH handling
>  - meson: drop separate version library
>  - meson: stop linking libcurl into all executables
>  - meson: introduce `libgit_curl` dependency
>  - meson: simplify use of the common-main library
>  - meson: inline the static 'git' library
>  - meson: fix OpenSSL fallback when not explicitly required
>  - meson: fix exec path with enabled runtime prefix
>  - Merge branch 'ps/build-meson-fixes' into ps/build-meson-fixes-0130
> 
>  Assorted fixes and improvements to the build procedure based on
>  meson.
> 
>  Needs review.
>  source: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>

This one has also received two reviews by Toon and Justin and it has
been cooking for quite a while, so the same question here.

Thanks!

Patrick
