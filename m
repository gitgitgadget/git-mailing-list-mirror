Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B0848FF82
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791461573; cv=none; b=EQ0S1TvRyztJFEhoZqb4UyR5CBkDqWzS6pQNvH+sR644JwIF11fpFzoW7Ard2gFH7Ei4C4oIjoTn76Krtmvl2RTZq1N3lyC3S+KMqFSRh2EcHgrcZ+2hPeB+gfWtU5OhlV3J0Hevut3lvBNYDCEObFqEhBac3Vs+u1Wu6pyHn00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791461573; c=relaxed/simple;
	bh=tksZfNrXzK0IwYpJvakNqY8Y3TCN26VWFyAYUJpQVYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Js300FByoQz6OkR4mVQwOzQioDHuhkbiGQjo4t/30m6N+kuRkIjHE25FSVXPAcFBBe/EmRxHTOG4qyu78CNFzJTwtrCQGEIP4IfIBOXigM08uySIAh6jemf3U60NwN9Z46e5Kum+GfRKmhDKXFuokNBkhUjVidM0svPflS4UiBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=WkUVrYhs; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="WkUVrYhs"
Date: Thu, 8 Oct 2026 14:12:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1791461568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zN8WLiTQYyIe8KOtwvyCQHxtm7V50zGQ4OA0fyl0RqQ=;
	b=WkUVrYhsKAdCTq9P8ZreIpEInN1+8wSf+s9uyba8E9o1Z8CaIkFrNX2VJsst5qU3+x7zRk
	R+KvPACACZAtQgI3XA2zYBrxBqqrDi2uLjtBwbobApabrd7AAtDgrbU3T+LZhurfW51/bF
	neiWkALohjhX/nU0i9plQOt5eKOURN+yLxcUO0slN3yCh/Ou+l2P0GI8or/mHMamRz7rD8
	gHr1TW7O8rJWg4g85UYCPD/NVR3+42Fs49FYfkW6xFPidkrY3Cq2KzutUdMv5YWfkMT8EX
	MRvf8giMJrXEBnkme/iKMUjLgHxwTPF0LC1rrYVo+E9KdrRnjL1yqPbMw1ZT7Q==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>, 
	Mirko Faina <mroik@delayed.space>
Subject: Re: [RFC PATCH 0/6] Introduce precious files
Message-ID: <aseIX3hABbm822X8@exploit>
References: <cover.1791460418.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791460418.git.mroik@delayed.space>
X-Spamd-Bar: ------

On Thu, Oct 08, 2026 at 02:06:56PM +0200, Mirko Faina wrote:
> Introduce precious files based on Elijah Newren's document [1].
> 
> With this series documentation is not updated yet but I wanted some feedback
> before polishing and moving on to implement the changes for "git clean".
> 
> [1] https://lore.kernel.org/git/pull.1627.git.1703643931314.gitgitgadget@gmail.com/
> 
> [1/6] precious-files.txt: new document proposing new precious file type (Elijah Newren)
> [2/6] dir.h: replace pattern macros with enum in attr.h (Mirko Faina)
> [3/6] dir.c: teach parse_path_pattern() precious files (Mirko Faina)
> [4/6] dir.c: teach add_pattern() reject precious pattern (Mirko Faina)
> [5/6] unpack-trees: teach check_ok_to_remove() precious (Mirko Faina)
> [6/6] builtin/ls-files.c: support for precious files (Mirko Faina)
> 
>  Documentation/technical/precious-files.txt | 540 +++++++++++++++++++++
>  attr.c                                     |   8 +-
>  attr.h                                     |  10 +-
>  builtin/check-ignore.c                     |   1 +
>  builtin/clean.c                            |   4 +-
>  builtin/ls-files.c                         |  75 ++-
>  builtin/sparse-checkout.c                  |  16 +-
>  dir.c                                      | 144 +++++-
>  dir.h                                      |  51 +-
>  t/helper/test-path-walk.c                  |   2 +-
>  t/t1091-sparse-checkout-builtin.sh         |   8 +
>  t/t2205-add-worktree-config.sh             |   2 +-
>  t/t3001-ls-files-others-exclude.sh         |  27 ++
>  t/t7508-status.sh                          |   9 +
>  unpack-trees.c                             |   7 +-
>  15 files changed, 849 insertions(+), 55 deletions(-)
>  create mode 100644 Documentation/technical/precious-files.txt
> 
> -- 
> 2.56.0

I forgot to specify the base. The series is based on c46c1e3772 (Start Git 2.98
cycle, 2026-09-30).
