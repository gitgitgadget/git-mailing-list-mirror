Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4405153805
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 08:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711355569; cv=none; b=tqltQB3VaPQcwQ+bsxxYtw7mZZdxXsWYicfphXBD7Ar62ShtLT+7EVaYaK0TlE0fnVeMrxv3MsxjnWfnhn1xM6qUsUwpyyJG0Q1yhShbZK+bnPmz28OUow383vWclEDPqFqSQsuTMOwXqSH39+GUHaY2FYLngSXzV5GhwvAWnq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711355569; c=relaxed/simple;
	bh=l7UFIGOctxyv1ngHL7ZZwew1hBjBjul+0L/Q4eEBEos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmtBV/ghO5TRpHrwPz5FvWHUjb1IiRpX1WGMxZm6ovpPT2zhLXuevvdXkQykr4Yf1RISHjOrF2qQSTOk79vVaGAezMq+y3c8ugkH2h2W1D8Gb2Y28xJNvekRlxDytr8STTjbcoetnrVaNxpS0o+dqOjnl87Mrd0Qycikx0i8MqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=DaZ/F1r4; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="DaZ/F1r4"
Received: from localhost (unknown [IPv6:2001:910:10ee:0:d5de:3293:133e:f31a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id D298560399;
	Mon, 25 Mar 2024 09:32:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1711355557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/6Z6ZCCmjmXcrU3aNSUpxKYWU5ouvpyYnnjADFQHvwg=;
	b=DaZ/F1r4g375YOiUdVi5IF/tiC4NkMKl2LKny/063YnzLKuSS1it3UAVL1EgQQmIHNrXzO
	vW8r50bKH6RNk3SM+Kl0nQq2SCf85tvr3HLzwRGOTuahR2N6kUUj5d9OFwu4AXg8sQBoy1
	9e299gPi7qOBsabtxgV4LDE4spoKberuP01ie6SNdQqQIRRq42QJBo0LMrBRe7qBE1673Z
	3G3Hiv6GDcAX4zyeQ3vjedlK/ZJg2JxXYTcTY3LnOr+S9UCPAI+EqAqmPN9lawnnB4zjU5
	zABiXLs5FNEFJxDbb69CHEZtOz7A6aWgr9dd6f5LMN4pMlY6zC1+IEamuRR0kg==
Date: Mon, 25 Mar 2024 09:32:36 +0100
From: Max Gautier <mg@max.gautier.name>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, =?iso-8859-1?B?TOluYe9j?= Huard <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/6] maintenance: use packaged systemd units
Message-ID: <ZgE2pFt-pXurYnKU@framework>
References: <20240322221327.12204-1-mg@max.gautier.name>
 <80580cc5-0285-43d2-ac51-71dce16f0028@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80580cc5-0285-43d2-ac51-71dce16f0028@gmail.com>

On Sun, Mar 24, 2024 at 02:54:58PM +0000, Phillip Wood wrote:
> Hi Max
> 
> On 22/03/2024 22:11, Max Gautier wrote:
> > * Distribute the systemd timers used by the `git maintenance start` with
> >    the systemd scheduler as part of git, rather than writing them in
> >    $XDG_CONFIG_HOME.
> > 
> > This allows users to override the units if they wish, and is more
> > in-line with the usual practices of distribution for systemd units.
> 
> Thanks for suggesting this, I think this is a useful change, but the
> implementation could be improved.
> 
> > We also move away from using the random minute, and instead rely on
> > systemd features to achieve the same goal (see patch 2). This allows us
> > to go back to using unit templating for the timers. This is also a
> > prerequisite to have static unit files.
> > 
> > Note that even if we really need more specific OnCalendar= settings for
> > each timer, we should still do it that way, but instead distribute
> > override alongside the template, for instance for weekly:
> > 
> > /usr/lib/systemd-user/git-maintenance@daily.timer.d/override.conf:
> > [Timer]
> > OnCalendar=<daily specific calendar spec>
> 
> We should definitely do that. Using systemd's random delay does not prevent
> the different maintenance jobs from running concurrently as one job may be
> started before a previous job has finished. It is important to only have one
> job running at a time because the first thing "git maintenance run" does is
> to try and acquire a lock file so if the hourly job is running when the
> daily jobs tries to start the daily job will not be run.

Thinking about that, it occurs to me that the current scheme does not
prevent concurrent execution either: the timers all use Persistent=true,
which means they can fire concurrently on machine boot, if two or more
would have been triggered during the time the machine was powered off
(or just the user logged out, since it's a user unit).

So maybe there should be a more robust mechanism to avoid concurrent
execution ? I assume from what you say above the lock is acquired in a
non-blocking way. Could going to a blocking one be a solution ?

> As the daily job is
> a superset of the hourly job and the weekly job is a superset of the daily
> job so it does not make sense to run more than one job per hour.

Is that set in stone, or could they perform disjoint set of tasks
instead ?

> 
> > The cleanup code for the units written in $XDG_CONFIG_HOME is adapted,
> > and takes care of not removing legitimate user overrides, by checking
> > the file start.
> 
> This points to an alternate strategy for supporting user overrides - don't
> overwrite the unit files if the user has edited them. I think that there is
> still a benefit to moving to system wide unit files though as it means that
> if we improve the unit files in the future systemd will pick up these
> improvements automatically. That is an improvement over the status quo where
> the users' unit files are written once and never updated.
> 
> I think it would help to reorder the changes in this series as follows:
> 
> 1 - simplify the invocation of "systemctl --user"
>   This would be the current patch 3 without adding "--force" or
>   moving "--now" combined with the relevant test changes from patch 6.
>   This would make it clear that those changes are a simple clean up that
>   is independent of the other changes made in this series.
> 
> 2 - don't delete user edited unit files
>   This would be based on the current patch 4 and would show that we can
>   avoid deleting unit files that the user has edited without the other
>   changes in this series. This change should have an associated test.
> 
> 3 - start using systemd's random delay function
>   This would be the current patch 1 without the template changes and the
>   commit message should explain that it is in preparation for disturbing
>   system-wide unit files.
> 
> 4 - install system-wide systemd unit files
>   This would be based on the current patch 2 with the addition of
>   overrides to prevent more than one job running per hour. The unit
>   files should be installed under $XDG_DATA_HOME when $(prefix) starts
>   with $(HOME), not just when they are equal. The associated test
>   changes from patch 6 should be moved here as well as the "--force"
>   change from patch 3.
> 
> 5 - documentation updates
>   I'm on the fence about having these in a separate commit like the
>   current patch 5 or updating the documentation when the code is
>   changed.

I had started cooking v3, I'll take into account, thanks !

-- 
Max Gautier
