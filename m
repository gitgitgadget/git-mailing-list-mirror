Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8131839D3FC
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168463; cv=none; b=gPzpb5xBu7qIp8Tp1COQyvdL7y81Zf9s63QW9jKszBYK+7XM3RLI2AmRglkU3KqKbVGsiwF2lHPwSKQgcZemY3cQ06z1FJulmPCjAaLMO4pTQhM7ISlBfGwJ310ArYXBLysUmlB9xIdIp24cw1edos2lMNR17pfkj1othksiH+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168463; c=relaxed/simple;
	bh=HBX1WhnwsQCCtebI+3ox6EKSU/d7Ga8basUj87J5Cww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxhPtPnxP560rnjfD/0EoqcS5Vv7dyot39uRobt1IvH4VUNiHizlSmcbz0Id3DMmYU3IqOM7nB9EFy6VUR9kUe9duYZi4S+EmldJTfwwRByrADwQyuhGvZmMvdwAxmg9P4QASRAi5QXEOZZ4l3jor+dJAjPrFuysDJ7F+6JBuDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GMeLlK04; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NUs1PKtg; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GMeLlK04";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NUs1PKtg"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 53AB57A017F;
	Mon, 31 Aug 2026 05:27:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 31 Aug 2026 05:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788168460;
	 x=1788254860; bh=88XC3YpVOb++rjnXHFKTStqPlUo6sNegdJp7oqERKR4=; b=
	GMeLlK04ghG/4N+lYjdkcJltdlGCJ75d87geR2PpljJEMkQC3eNWUXukQH3Ylg3a
	9rI2VrnAh3AbcSy14mp6Y1yB34gKTjuQnEl/u+y6WRDEHVJ6MaCIexpnq6z6z5zA
	d6TbQMCCMjO/WONsAMzXGsndvBVq79KUoPDAXP4b0AGGk5WtxTaAUbCbQCOTQ04k
	nIFv/S44f0J6fckAqCH4yXmD+WQKAc7+1DJ57E+FeK3feFFSnvfng5be7Wh4Qg2k
	4DNu09ryTCnF5J+OHtyf+Q4SBF88768EL9SuFwvyKTE8w6AiwgfYSH407A9bRFlr
	PNPyulOO8IfzD3LFySrStA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788168460; x=
	1788254860; bh=88XC3YpVOb++rjnXHFKTStqPlUo6sNegdJp7oqERKR4=; b=N
	Us1PKtg3U60jrW75lnfdRIWH1+JITOlOKp8//VIAGNHUKLWKlNgggQ780BWEoQDf
	MBoif4xgzitIeBUaAKdhWgst17JQVgYdRASgxYKj1lKkGEx2AX4Qs8nlQBEtdiFY
	jg0SekXus6PPsbx16AiEx7FUoYu4otuWu9INHDzV7/O4LUJb6cdcue5UlQvOrD4n
	r7DtV/XZQZsKBbDe59+/LeaMoJIPI6PiyU5TsUNMskThu0/3xu3nH2GK8Vndb8or
	wJTGgScNha0i1H0g0xiSYoavg7Z4LZkOJT+p8/iEHvOPT5l3iUFKTGJNEZXjBW5W
	mE3MpoZSiRWe3adzfflnw==
X-ME-Sender: <xms:DEmVahmWIWjNFZwbUdH2U49u2tgsKFR6NF8Wvvb9huT4cadcUvxZEw>
    <xme:DEmValS59ti3I0cyF388CUri5tJrqgHSZr9o3bdia48Tx5cZPHM7OsDv6xn3T6JM3
    0PFiofds58cM_Tun5HtWlEtYS-dQ3KzmcyG8gTjUwwIcG_uO3-GhyY>
X-ME-Received: <xmr:DEmVaoHQ66AlsLMTFTHUtjRi3FDy3vfwvFlwXjhIjSn0dnPnTPHStOsws-f7DHkIFONSvg>
X-ME-Proxy-Cause: dmFkZTGc+nhNIGpY0B35Yg8GOfxOYdjkFwfJ+h45w20Hvl0nQeBFzfAVQaVClyxnfUFA/O
    ER1ljMdF59RZEwjXmK/TUGe0fGKdO0N2jupWCDa55WRP1sVCXb4EH3Iy+cy0IPJPJmeQwU
    b2QOAiFq9rktPUgwR3qjSEHzaJTydNrQzMEAbo+q8VLoasEP1QMr4tRDYDuH4MqMwAjMgD
    2dcRd0/Y5vzE48TGk1qZdZ7zAoJa2hq+RFoF+Frclc5nB2vgKb+3i+EY+sEPvG1MHB8U6S
    d1x+VjXg8C0MAFyQmyKTMAG0y9CEwO2q7VQDqq+Sffxy15H/+TTjmvPE9nGjUOyE68maJu
    6I6VXAzTup02wltyVtKjFrkND3bZx4O9EK64nzfpNd4TA/SPGRVmHeVwJSFuLKvk9A7L/n
    3igdTvqLWcVm3hWNmD2ChyHtoHQYvwEZ++Nmv+lmSd07flzq8HsM8HCa4AMEjXXhEtkw+K
    hwk4R6JYNlu9+mWc7sjnvUCibSld4vtaJUqQ8xXnJqByQn2G8/yG0YX6+vJ+kqrpKDxb/S
    LWkqEebSvYe/fRI8QU8KdF/SoR5hTaeyasg9TSnm6tWh2qS7RG5AfZeVuAF0ZVDaIYJrca
    U8QpwHKB7SEfWRm8zAxsZ/fWu3wL3q2wBV9OiONEVnfnRzSh7yw67gc2U7MA
X-ME-Proxy: <xmx:DEmVaiF8Hd2XMeoI85pUQXpkNvfkTXI9xAo-mTlQGfv44MTDRBwRPQ>
    <xmx:DEmVauSerz5jr363EJiG_RJ55cAw2_JmEQXtTdgFYAGPntSoAM4MgA>
    <xmx:DEmVarL1v7lqAne6p3k0X1lLp_D3Am5q6C3cqzotXWILN7Iumu-2mw>
    <xmx:DEmVahaNX2hS6Z2XlDW9Z3BpQ2Qn19IO-1JdIKcU7Zkj49M6jpOd-w>
    <xmx:DEmVaiOjRZsinDF6JxwrAWzzNSuD8AUAAHRC_RqiHuxBzGGEiCfppowW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 05:27:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7d1279a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 09:27:42 +0000 (UTC)
Date: Mon, 31 Aug 2026 11:27:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Olamide Caleb Bello <belkid98@gmail.com>,
	Todd Zullinger <tmz@pobox.com>, Tian Yuchen <cat@malon.dev>
Subject: Re: [PATCH v5 3/3] core: convert build-time USE_NSEC into runtime
 core.useNanosec
Message-ID: <apVJAzddTPPCI7kA@pks.im>
References: <cover.1787231825.git.ben.knoble@gmail.com>
 <cover.1788010335.git.ben.knoble@gmail.com>
 <01cd487cd23f23b1d18359b86fbcf18e25039e6d.1788010335.git.ben.knoble@gmail.com>
 <xmqq8q5n1fa2.fsf@gitster.g>
 <CALnO6CBejkZTgPM9tK6TEGeNYSRfi9r2-xi7R4ckTsRm4ZGaQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CBejkZTgPM9tK6TEGeNYSRfi9r2-xi7R4ckTsRm4ZGaQw@mail.gmail.com>

On Sun, Aug 30, 2026 at 08:27:13PM -0400, D. Ben Knoble wrote:
> On Sun, Aug 30, 2026 at 5:15 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > "D. Ben Knoble" <ben.knoble@gmail.com> writes:
> >
> > > +             /* nanosecond timestamped files can also be racy! */
> > > +             (repo_config_values(istate->repo)->use_nanosec
> > > +              ? (istate->timestamp.sec < sd->sd_mtime.sec ||
> > > +                 (istate->timestamp.sec == sd->sd_mtime.sec &&
> > > +                  istate->timestamp.nsec <= sd->sd_mtime.nsec))
> > > +              : istate->timestamp.sec <= sd->sd_mtime.sec));
> > >  }
> >
> > Currently this is probably fine, but the use of repo_config_values()
> > here means that the order in which we can transition/libify two
> > unrelated things are forced on us:
> >
> >  * We'd first need to make sure repo_config_values() can work on an
> >    instance of repository that is not the_repository,
> >
> >  * And until the above happens, we cannot do a --recurse-submodule
> >    option that loads the index in a submodule and operate on it in
> >    the same process (e.g., "git diff --resurse-submodules"),
> >    because immediately at this step, istate taken from a submodule
> >    would have its .repo member pointing at something that is not
> >    the_repository and we will hit a BUG().
> >
> > And after writing all of the above, I realized that I am mostly
> > repeating what Patric already said in the upstream, e.g.,
> >
> >     https://lore.kernel.org/git/an720tZnot07HYiK@pks.im/
> 
> Yep---just so I'm clear, we don't currently have such an option,
> right? I mean, there is no --recurse-submodules for git-diff(1), and I
> tweaked t4060 to run "git -c core.useNanosec=true diff
> --submodule=diff" without any issue.

I do have a patch series coming up where we start to rely more on
sub-repositories when recursing. The motivation behind that series is
that it allows us to get rid of registering submodule object databases
with the main ODB. But I just double-checked, and your series luckily
doesn't break it.

> I would happily prove that at least none of our existing tests fail
> with core.useNanosec=true, but I'm not really sure how to shove
> configuration into every test invocation of git. Even if we could, I'm
> not sure we necessarily want to add another CI job for that (though
> that's a separate matter).
> 
> In particular, (among others) I have not received any concrete comments for
> 
> > Comments welcome: I haven't touched any tests; I saw a bunch of hits for
> > "git grep racy t" but wasn't sure how to fit this particular change in,
> > especially since it won't be equally valid on all systems? Advice
> > welcome.
> 
> so if there's at least a way to exercise this path on all the tests on
> my system (which should support it), that would probably be a good
> thing.

Yeah, I simply don't have a good answer here. It's messy, and I'm not a
fan of the current direction of `repo_config_values()` because nobody
has yet stepped up to untangle it from `the_repository`. I gave it a
quick shot at one point in time, but the result was messy at best
because of how we populate it via `repo_config(git_default_config)`.

In any case, if we see that your changes interact badly with some edge
cases that we don't currently have on our radar then we can still
refactor the series and move the value into `struct repo_settings`
instead, as that structure works alright with different repositories.

Thanks!

Patrick
