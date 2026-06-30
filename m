Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A1C3EFFBA
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 11:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819137; cv=none; b=lXYdlYJeWibFUS0fmmsgm2FFEf3UDCS1aLurLYrtW9qZ4gzB7rp6bJJs5AA+/3PK644TMqeyFzEsTKj3D9SedDxZT1yhuc6D4OKZBEZdOeF0gz6vNq1sBsbewyNsi2T40zFx9DxqaLoInhGkHSRzgdHe6sjYVeDu2k3KJrSEvJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819137; c=relaxed/simple;
	bh=i/CuaGdGKkNJimv3Ucikttlkuq0Qxpwx8FcKDW1wwEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/oIR/aavCPMcWlhYA0SmmhJcnF2ykgFSiB4MSYGXQBTqMwfX79y30jWOO+yh9xneC5OIGjwkym8uwA7A26JsbSbUmyhbTIFlnOvQ6Tuy7tLaG0CGH4llrcjrIdxxsEgBZyzIt84VGN3Ne8RpIeyLB4KCBjoEiD1oGQZAIinzB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C4bNcsvd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YpYuoxiM; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C4bNcsvd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YpYuoxiM"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4A6647A007F;
	Tue, 30 Jun 2026 07:32:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 30 Jun 2026 07:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782819135; x=1782905535; bh=owR7FWYM+O
	j24JOP7An/UqyNkZd2DPE1KI1rWQoKI+8=; b=C4bNcsvd1iEx4OsAoS/IlSDcjl
	M4F5NEfH3BJh68TqWfLKTgY3JRQB6J9siYlSfjwOX06Cg4lTYSLy+DUwriIH6XF/
	R/L2FPNxhsLd0Wt23aDcfyNbzhrFTQc6UaduVXg137gOlCkrOV5HZc+hwoSKt2h6
	S4MRydsto2cMngCm8uoAQnZrkoMuGcEK6Y0PU2zeDeIaCoEz2Hwh50uvW9zvkIdk
	UjX3jQIWrR+3ZFD+ODFTHD6UoyVror2t9mwuFtrPP4wNsK4BxaELYs6KFC2ehDWf
	uDiYcjk+76TWHwFw4dODGR6xhzmtuhbqJE3jHy3at9e+B0FFwwV6dnZo2dhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782819135; x=1782905535; bh=owR7FWYM+Oj24JOP7An/UqyNkZd2DPE1KI1
	rWQoKI+8=; b=YpYuoxiMB5UWR83mNDzk55kVFH5qRSbQ5uPHvYYLS1yMzlytOdk
	+4IRnYECmv12X4ZxwEzncCzNhFIhItMOOZz8cvx2os4uzaotFUpuIt0cOtIiF50f
	eIhD6bOtWj/0ozoG9zBe/x3oQADhBg9o83RBzeLJil8pCfO0yBcNjpVSgTtxi854
	lSxpx+sXkvBBm4biwMLr4pAFDKa8l5uOMn7pgIugS6+otq4QsVhiPAaEsxpuoBIu
	d997Gk+SHB+GTGuhxtWgc86MqLLNrNwdIrYtpo6xKTrhU5Zx9ODWIKGrDLRXDwBO
	moRfbEnBy/KxyHeCpEO2VJ9DcS63NOJqYdA==
X-ME-Sender: <xms:PqlDalWKvY8om-AqOMARpmSTFozN1yr6xHFNDmTvCKkrunHQclv4AA>
    <xme:PqlDaskEhx0YKtzyeCZdvE2g7o9rq3Xm9FiseHgQ1_f1GfhuczHx_wiS2OUlgePNx
    ezCZ3yA7HQ93-i5ZjXcZnufsaWb3V7i5HnjB9Xr9CXtp-B-Md54S2E>
X-ME-Received: <xmr:PqlDamat_wXZJISaUJZHDZ_4nx6ubQp5nPmd5MVNyO4rqOHSlW3Xb1pLZ0qKyKagAL4vmboInf8nGQTlWYsoupqj4FXc6zzaVPVFsrSOHTaOpA>
X-ME-Proxy-Cause: dmFkZTFvhyGWtp7zree5qZVcSczxwhVhMJnslr50wz/vZ+KPECCtcCFLDFPvR6VdoJ1r8t
    WXzDkUtHmCFj33N2YoNtZkU7XzzDbFru95UhDFaBpNh/J8nxZTFBKFBLvsa/mI6YslXYjJ
    5MzcfD1ZSXqooqfrzAy7VHcLwuvE70JH0pKdu/FZjD4kLGi73N0veDhshFIibzQ/bE1ma9
    b/kiuIo0yBjN02SI7K/YW/cUkQJbi/DeLqtxDLeLP1PtSZkqyKyoRj6ku/qgDtGUceNrmB
    MeMZGTwRiJcVcoyAMyRoxAckvW57TdrT7JKnFw4J9I7uGK+DNmobWsSJtpjzFZrVyzQEF+
    cii13Bob93J5XvbKnWN8NioXd+v2su1fcHel/IhcS6fQw8PIoWlk8+VX7LORHyCw3afNBy
    TbKAKIdpGmA0tVd+uOByqiqZYI31SAAiC7Nvji8qUeEImrON/92lq4tEm9Z+GAamvtZn5i
    BeXCKUTZSdbNkBRUl5N0WVsr9Fg2wNgprxfsQ80Kpc4R0fscSxpSq9T/pZyL163j/rAeQ3
    IZHYk9782jTPBfNxvY4wHcGGSPC/7oSGz3k5zv19V4m3hBlbAO8HI/phdKN7SiLHVENn06
    ZA88KnHju4qst0QzvYp9NohdC/x77KEbybvWRr57gc+nlC2YckaatDB4jhAA
X-ME-Proxy: <xmx:PqlDanOGzmo57-TgGH5qACp3_is4kBr6RbVzun4Ioy1sLd97pypdtw>
    <xmx:PqlDarbG_184M0waB2Mz66AuXsG6Gx8Z8QZS9GV_976Bn7-kEGC3zg>
    <xmx:PqlDal1tzf65dYqioi6QkJdE-kGOznS0cwUdUBpMnra-cOBIuTwCpg>
    <xmx:PqlDahcyYA2Cs4ryxxmm6KSeYXFqkcY-zrdj-Jh6Ju4B--xn8VC_IQ>
    <xmx:P6lDajztJ2gVofN1xyTyMZF2d040eSizimhzFUSHvUqb7NjTe3eFKnuO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 07:32:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b3564a9f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jun 2026 11:32:12 +0000 (UTC)
Date: Tue, 30 Jun 2026 13:32:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 3/3] replay: offer an option to linearize the commit
 topology
Message-ID: <akOpOXeD_gS5U7rH@pks.im>
References: <20260622-toon-git-replay-drop-merges-v4-0-ff257f534319@iotcl.com>
 <20260622-toon-git-replay-drop-merges-v4-3-ff257f534319@iotcl.com>
 <ajk-a4a3KSJ2u7Ju@pks.im>
 <87qzltyiao.fsf@emacs.iotcl.com>
 <akInDBlyWbbRFcLH@pks.im>
 <9e7d14c4-82f0-2b89-b07b-f219119a199b@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e7d14c4-82f0-2b89-b07b-f219119a199b@gmx.de>

On Tue, Jun 30, 2026 at 11:44:47AM +0200, Johannes Schindelin wrote:
> On Tue, 30 Jun 2026, Patrick Steinhardt wrote:
> > On Fri, Jun 26, 2026 at 07:36:31AM +0200, Toon Claes wrote:
> > > Then there's the option of rebasing cousins left. That's something that
> > > isn't covered by Dscho's series yet. Maybe --replay-cousins?
> > > 
> > > To reiterate what the final design could look like:
> > > 
> > >  * <nothing>: replay merges preserving topology.
> > >  * "--linearize": flattens merges (only git-replay(1)).
> > >  * "--no-merges": dies when the process tries to replay a merge.
> > >  * "--replay-cousins": does what --rebase-merges=rebase-cousins does.
> > 
> > Right. And if we tried to be consistent with git-rebase(1), then this
> > could be done as:
> > 
> >   - "--rebase-merges" to replay merges preserving topology, which is the
> >     default once we support replaying them.
> > 
> >   - "--no-rebase-merges" to flatten commits.
> > 
> >   - "--rebase-merges=abort" to explicitly die when seeing merges.
> > 
> >   - "--rebase-merges=rebase-cousins"
> 
> The `git rebase` options are unlikely to be a good precedent to follow.
> Their history is full of usability warts, and in hindsight, I would really
> have loved a more steady hand in developing and maintaining a good UX. The
> fact alone that this is called `rebase` speaks volumes about how hostile
> of a user experience this command surfaces.
> 
> In any case, these options should use the much more natural term "replay"
> instead of "rebase".
> 
> But then: you said that `--no-rebase-merges` should flatten the commits?
> That's not what this option name conveys to me; It would convey to me that
> the operation would _abort_ on encountering merge commits.
> 
> In other words, I do think that the --linearize option is conceptually
> quite distinct from the different modes in which merge commits could be
> handled. As such, this option should probably not be conflated with
> the various `--replay-merges=<mode>` modes.

Fair enough. Arguments like this are basically what I want to read in
the commit message. As said in the below snippet: I'm not against
diverging from the git-rebase(1) interface, but if we do that we should
document why we think that the current interface is bad.

[snip]
> > Note that I'm not arguing that we should support all of these options
> > now. I'm merely arguing that we should try to be consistent, unless
> > there is a good argument not to do that. I'm fine with the interface if
> > there indeed is a good argument, but if so we should document why we
> > think that the current interface in git-rebase(1) is not a good fit for
> > this command.

Thanks!

Patrick
