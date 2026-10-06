Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0881738F930
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791309983; cv=none; b=og8p3s/o7DyYUzEmiE0HfNRNYUMsiFvDvhOx89JQGdwTHcZJKzYJ3PjP2I4J0BYUmge+bEX2AXMMRMhCRZy8j5pt/kBaD1edM7UgGvAB21A6Ll+gI5BbHMwaih1NGk3tXqHxj37gceCSPeeJqWXbi3Dy4XxRKsJAcpBPyMpytZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791309983; c=relaxed/simple;
	bh=n0C5gWJ8OjAyXkj6tNF/oTyP4s7iH6Dh0rUcrhGr2Kg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBbSe89bi9eAQUWClzCl8cehg3ZVUU3SDcfX+9y20ILOI1t5Qb86vrZaqUnvDpZ6YqyensVHOtDXvHftX/8jaEmLbry6e0ufFKwRW/Du13OW1rpkwQ65end0P9Yz9T3VxiB+gBqHU35CsiA6vBdx/GP47JCe7vLlPJPgPOdhjoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=B4SKvcnL; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="B4SKvcnL"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-917866225aaso13257566d6.1
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791309981; x=1791914781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DGKz4LQl9XB0+GD1hMFzD3wxcAcnowGe8Bc0fiNkskE=;
        b=B4SKvcnLpMSwnMO1oohMAl2mSwXFAwC+ykypcTvI7TaF0Pxxqr6c836/sc9KJd0rYf
         M6AmNL0GntdHyo8RORzsdTRT+QbfA2J2UCfDhzUEkoitLhQ0NAAk43JgRt3VTDVpq6k/
         8P5+sj9znaCJV8LvRsjlp/rW/SUugnm8sVhLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791309981; x=1791914781;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DGKz4LQl9XB0+GD1hMFzD3wxcAcnowGe8Bc0fiNkskE=;
        b=S6VAccceBRE1H2P96OkfEbm2yFRUrIuZyxeQQd6ha5ahjz2Isu+wXXF/ouq7XuPri6
         MRO1W6gzsGd1ojUY7Vd9UPQxbLobIA+UWy8i4SmakXFA9Z7QdJDny7OP6ZDMKfwoB+aj
         EYQYAOyEQmxoEnLxdkhAsGhsu4BOE0iTExdGN2jc/NVMT9/7k0kghKLtcezOsj/l1nR7
         9Kbk/VqPIi4W2NTCOI7wkgS/KNvFmqustehObgmxG7a/HCKX4D5Oaq5JKPZ/SbOIdEm3
         OZhhP+8Uh71NvDlEo0YFIe2mnutkX4my5tpDgazJ1XwnMo5hR/w3YlcJYx4aRGFIwji1
         be9w==
X-Gm-Message-State: AFq9FYJozM1tq2azG41m0SGJ+ToFcY3XdN3JIeLkWDcSaOGbYT9IU7VV
	PHSEYR/3RcFAUSUt2rzU5G7YrcWqQB3oXngNYFtMb4vy3r9W1VRWQm26jrSiqGbhOQn12WNrrDq
	q1+uCDAQ=
X-Gm-Gg: AYBFou0MaGH2WzpHXv64nhNdgOfp653msM0YuapE4/5EhfQdoy2EgR5jc6J7v1Vodsl
	9NZ4nAzkp/AZiZGB0Y7ffuEBDq+aTcukgbPjuguzNincLGUC9m3j/D2zx3cb+vioH36iu2hqO48
	nKoF5tUmIcyjKnFN5yBJAiJq7H3C+m1oBj3Z8WFjUZnJ/0BN2cvAu7VERFXAIPUr3mIsFhWytfJ
	muG7VZ1jzTRJEfg68I6YcO4cieXqQyF2iFyDGgzPDk3xIVQHlwJl4g61rSsl46v9HqxFmS20p65
	QAKLPE8IGBtvoEMPPrAOvquhJEuJTMGMX8yuBzaIwXc8Mjy/jRyiLUuBCK6NIrbv9OOrpFfyHi9
	KPGZO77Bh0OhO3JW/+lELCPvJVSr6G14iGga8zsKZFPlLr9dj02diHKiyPHkBbV++RlOWKp7Nox
	0gBDK/rne25LC3UcJqKLC4NKSe4N1GvIa17msOkXXYS9J1JsS81GGQX1MZFdZKJaNBwrQ7f0uN/
	P71KOwiG96ZLjVTmlQSnfrqbVPD1KLS8Q5MDcJ7sEBpIfKJVbU8EFVFIVPGp/+ru7GuxfCUxeUX
	mU5Ue/bvIiDTYtB4Jrnl6w==
X-Received: by 2002:a05:6214:4993:b0:919:8604:33bf with SMTP id 6a1803df08f44-9198b3afbefmr43003496d6.0.1791309980437;
        Tue, 06 Oct 2026 11:06:20 -0700 (PDT)
Received: from com-79390 (vpn-eastus-01.tradc-corp.com. [172.190.114.39])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0b1aef0sm119980886d6.12.2026.10.06.11.06.19
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 11:06:19 -0700 (PDT)
Date: Tue, 6 Oct 2026 11:06:17 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org
Subject: [NOTES 02/07] Git 3.0
Message-ID: <summit-2026.94e33e9ddf234334.02@ttaylorr.com>
References: <summit-2026.94e33e9ddf234334.00@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <summit-2026.94e33e9ddf234334.00@ttaylorr.com>

Topic: Git 3.0
Leader: Patrick Steinhardt
Notetaker: Justin

* Patrick: The blocker was GitHub not having SHA-256 support. When will
  GitHub fully support it?

* brian: GitHub has shipped it experimentally, with general availability
  probably in November.

* Patrick: GitLab already has public, non-experimental support. We are
  looking at spring next year for Git 3.0. libgit2 has support; JGit
  does not.

* Emily: Google will not fund SHA-256 support in JGit.

* brian: It does not look like Bitbucket will support it.

* Emily: Gitoxide may have funding for SHA-256 support.

* brian: There will be a couple more releases: 2.56, then 2.9x, and so
  on.

* Taylor: We could use 2.99 and then 2.999 if needed.

* Patrick: 2.99 would be a stronger signal than 2.95.

* Peff: Why might users not want to jump to 3.0? Rust support will be
  mandatory.

* Patrick: A possible schedule is 2.56 in September 2026, 2.98 in
  December 2026, and 2.99 and 3.0 in March 2027. We need to find out
  whether anybody is interested in an LTS release.

* brian: Gentoo would be interested in a 2.99 LTS release.

* Patrick: We could potentially cut out one of the releases.

* Peff: We could make one of the cycles shorter.

* Taylor: The 3.0 release could be small, containing only the changes to
  the defaults.

* Patrick: The counterargument is that we want to use 2.99 as a signal.

* Peff: We should release 2.99.1 and 3.0 at the same time, with only the
  BREAKING_CHANGES defaults flipped in 3.0.

* [Consensus among the attendees.]

* brian: Are there any objections to Rust in 3.0?

* [No objections recorded.]

* Peff: Are there timing concerns around distribution release cycles? We
  might want to synchronize with them.

* brian: If we do 2.99 and 3.0 back to back, that puts us in the April
  timeframe.

* Patrick: Do we want to drop 2.57?

* [The notes record dropping 2.57 in favor of an earlier 2.98.]

* Peff: GitHub might encounter bugs once users start using SHA-256.
  Would we see similar bugs in Git?

* brian: Codeberg exposes this in its UI, and has a decent number of
  users.

* Patrick: GitLab has test suites covering this, and we have upstreamed
  a few fixes. I am confident there are very few bugs.

* Patrick: Should we migrate?

* Taylor: I may be a little behind on the interoperability work. Would
  it also handle historical tags?

* brian: Yes. The work is done, but not on the list. You can clone a
  normal SHA-1 repository and get interoperability with SHA-256.
