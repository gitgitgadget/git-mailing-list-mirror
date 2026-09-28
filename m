Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099FF492E24
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 09:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589132; cv=none; b=TvuKb5Pta/KDOaz8ellaeWwGz2Ec9pv/o8jGRDun5nEupWagFP1nLzGs01+E94CKELaaE4NiWQfTG0S+ZoesgLZ/ThuXIuTnKPRleWgdYRRUj7kp9OwFeGkUopWO288ZlYWZaZKOy1mWOlQsGdZFkg9wQfOQzuqyuLX07wqUJO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589132; c=relaxed/simple;
	bh=eDRLx+1KZ5cGmin8zH+gBc7c5TOTGwX9H9m9yJRbOPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWGKdSRb/Y5OFcBbzE0nTDCT47oTp/KWBQg6tRjZFAxLRXUn/ZLcp/HtzYhmxTHeo1d6+rCd6XEBXBveeVggAJV3YdreHz7LxAB9YhJLDVKJpMm06PpxLOuMOb2SDYxd0Rh8+mjR/xmPZiavplfQR/8wRG6hqaLPMK3bJ9ucBPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ti6OCCzi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uh6M9DLJ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ti6OCCzi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uh6M9DLJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 37B85140001D;
	Mon, 28 Sep 2026 05:52:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 28 Sep 2026 05:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790589130; x=1790675530; bh=C/oaApj9wT
	mbORsDOZ1RW0stMwbLp97ZHEzl3KVMH7U=; b=Ti6OCCziro6jweY7Bk1EnxNqQo
	Ae5Bar2zFPAvFB1wmjwQh5IP7SLlrrkJM9TDqWOVuK4GrLv+SDmHkcFo/ah1VR7/
	uR3eC9iuhNXBB3XwOpzjAUiAC7YBsP2D4kHTO2WAJ4ApJ/p2F6wLp37eCp6wcVBx
	FjPaf02QzrLJO5v83OG0jALBJqvyiJTrFH6p/bjX/BOQtfr00i35LvkXNvUzKGwY
	/dVRJ3PdhmT78WqyLkhzDMQZdyqZIOdahW0/mqY5b5zPuEylRxZ/LyAKvmmNFibs
	RFPb22QZO0Qt7hk/6zGemODIdRjiAUguMZ4Qeb8V/7HJqkOeLFLotw71FI8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790589130; x=1790675530; bh=C/oaApj9wTmbORsDOZ1RW0stMwbLp97ZHEz
	l3KVMH7U=; b=uh6M9DLJzlRKIWy33a/G0cYf51m+2pp0+Z7pzNpBmtMy/w0TxqW
	jNVgR+FfYEp3206SbRd6WPiAnbQl1oSgJ2catwNyW+EEEzbKaKKiudS1CFlzIpHe
	XbPG7zuAIvIRzwLy96EN1k5JN0abvQGxpQNj8VyzGJ96+wgEnhuxrBCPdp8aGR0Q
	uFlBf4/CZD0hg9uMOUI3hpBkL9Dzruldw6C0a96wU1NwXpjsCoLYPn1Vhu98v5cq
	0LaCe8DaC0zYpDZhEFS1cmrswj504qcx54rj0n70pGH9kcItlufpH8lqd956XtEp
	Gtzu4YPd7jvvLLIaH1Gn9RazqnIA88Q/fBw==
X-ME-Sender: <xms:yji6artdJmwxWjEEucTwEhXtdmlEgGUyw_obpOJV4efYb5aiSNUC_w>
    <xme:yji6asrgOEty_MiTf0KWOlQbwzLEtVsXwytKmnS-Buo1nyF09vEMb5nPU1f5fk4EL
    M4LBnNxVIe7Npu27Melz5Jn_eKtpJNtGRYU26wmjMAou8D7TaG8ON4>
X-ME-Received: <xmr:yji6agl7P68oxYCNtpy4m-wbxnroYCoTP-yqx3TKZmGhNweE12EHrw>
X-ME-Proxy-Cause: dmFkZTFqDrzJqPgIvbQnRqjfRtqx7tBT2xB1DabVjvP/bAkBYQb/0y9CB6qKAKM6k+2Lol
    z0iE9z4Uu7cqEz8ZtkcNesHRrZN4LfF1lsm0bDeckrAVLEqS2gYYkPu3jev24xF4V61zSl
    pM5bz20VnGJ8wAhitMD/SZET3vkg6LjMcyC8cqLBdv2E3EgsxQh6gXjof22MCsbzqDJf/6
    KSu86uWbMJJY4kyXgd1Gl/5xYSYWjJUo5p33RpbqHbUntXPm3RfLrugcCm8bzQUM2P6wq3
    AHEOO8+DcuP7UAHY5FDuikVTANARexdQA2EfiLyYzHXQ+zJT7kJbMYxRRxVy3PPRDh+GFc
    n0PpAsQGxoDgrRBjGFccF0I71LsSU09ViBPk2NSgOJPVR1rlE+WZAt/DIwcIz3Tsm4krvC
    39CSB+CW828DDHpI3AjCNuxdf0P9YdJQq8VHmPZjcHA9w1dlgmYpdLXBsf1ZKdGK315dR5
    d/Nlb0PmUzPHBG4vpJ6oM8WZDODAnHvU5/EXAJI71USuMmSgfMuGRBatmCADHfb5eYtsvq
    rlDqTT7zkLRuwaIBJ0DiZv3diTCVBe5naYq+oxMPCk6tEe59gG5CB+iUgEPLEGnqHHmg0y
    Ig2M0carQI4fPtVHeINMKBebcRbHpq55CbyWwAFtEU28wMw0fkzxYASiTcIg
X-ME-Proxy: <xmx:yji6aoz2o8qwuG_6RNk55YjvuxaDK9j3tXGrIdIumr4qCoGLLSJNFQ>
    <xmx:yji6agmt-eXfHFP5hu8dSdW59T39uRQXx2wu_cvcOSsWh_2BkitPZw>
    <xmx:yji6apd1pWoY26L4rLwGSU5Ib1hMg3Q9-Nb7_0mDtbwIk2xk4MYKjA>
    <xmx:yji6auqyHhsJCr3LwW2H1-NK_TCVfZtbhxKp1iH2siF0qnmsQzaE7A>
    <xmx:yji6aj8OPTVY5Z2mL1bD1GWAdBEqivN-CRukDcHhg7SzWrmdBvsQINVX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 05:52:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c7a016a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 09:52:08 +0000 (UTC)
Date: Mon, 28 Sep 2026 11:52:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/7] repository: adapt `repo_clear()` to fully reset the
 repository
Message-ID: <aro4xkSiJDWknI1W@pks.im>
References: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
 <20260924-pks-create-repository-stateless-v1-6-11499557cf31@pks.im>
 <CAOLa=ZQ_+Ofya1q01fpZjd_wDn=tk8YxbQWNxhFHya47hFRp-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQ_+Ofya1q01fpZjd_wDn=tk8YxbQWNxhFHya47hFRp-Q@mail.gmail.com>

On Mon, Sep 28, 2026 at 09:18:52AM +0000, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/repository.c b/repository.c
> > index b857e1c580..e67ff00550 100644
> > --- a/repository.c
> > +++ b/repository.c
> > @@ -439,6 +436,8 @@ void repo_clear(struct repository *repo)
> >  	strmap_clear(&repo->worktree_ref_stores, 1);
> >
> >  	repo_clear_path_cache(&repo->cached_paths);
> > +
> > +	memset(repo, 0, sizeof(*repo));
> 
> The reason we swap `FREE_AND_NULL()` with `free()` is because we anyways
> set everything to 0. Okay.
> 
> Or was this referring to the 'already blank' repository? Since
> FREE_AND_NULL() can already handle NULL values.

Yeah, the only reason I swap to plain free(3p) calls is because it's
redundant now with the final call to memset(3p). I think the part about
already-blank repositories is not accurate anymore, but it used to be at
one point. Let me reword it.

> > diff --git a/repository.h b/repository.h
> > index 11f5c2ed10..2a348012e8 100644
> > --- a/repository.h
> > +++ b/repository.h
> > @@ -258,6 +258,7 @@ void repo_set_ref_storage_format(struct repository *repo,
> >  void initialize_repository(struct repository *repo);
> >  RESULT_MUST_BE_USED
> >  int repo_init(struct repository *r, const char *gitdir, const char *worktree);
> > +void repo_clear(struct repository *repo);
> >
> >  /*
> >   * Initialize the repository 'subrepo' as the submodule at the given path. If
> > @@ -273,7 +274,6 @@ int repo_submodule_init(struct repository *subrepo,
> >  			struct repository *superproject,
> >  			const char *path,
> >  			const struct object_id *treeish_name);
> > -void repo_clear(struct repository *repo);
> >
> 
> This is a purely cosmetic move to bring it closer to `repo_init()`,
> right? I think it makes sense.

Yes, it is.

Patrick
