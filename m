Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1235C3BC4F9
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 16:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768496141; cv=none; b=bK09hqKVxiUI4Y/FFXTWcXfd5ipKvv1gJ74NVmzS7J1lJmp0d5dAs9d2v/TS9nG/YdquMmJyHRnB3e79LYdwEguOHO9HtOPQiWqU951SaN+oMCfdbHqsG7yg3rWl2isHjLPnBX+pYxJqOgVDGC+thB0yhKwC1oM+ow8wRWboAi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768496141; c=relaxed/simple;
	bh=fqCvcyc07VfPt4YH7bCvclvCyhDptJjZTC2AoFdxHK0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rCeIgGmpFD5c/Bg5AMQHLaYF+U5kskV4QQBu3lcRIGX/T69wlBA3eHw46gkj5EDkeO4GXbQfqhBvU1WeCuHxdZ/UceBvb3IyCQiETOr7MnvhcnDMI3S67iRG46pfq08m6pqTMbDYCA57WIbQyXqHJ/somkuAhVGJ6wt5XiM8iXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Cs339jfm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EpLAp8gi; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cs339jfm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EpLAp8gi"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id F2E811D0003B;
	Thu, 15 Jan 2026 11:55:35 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 15 Jan 2026 11:55:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768496135; x=1768582535; bh=xjiz9Ukr9N
	oWNyVBgikPCgzCV2We+vhg7YEgsUhREqM=; b=Cs339jfmg0HQPhGL3Qi2bUjPY2
	PjHjP6YHEwOiTKzk1QBDEa9PwQS/ZuL5i1BuOnlsz/112rbhcDA82Pvz8G6MSos1
	52xXEdC0c4LwREyYthBLt9bOamu+LrAHcw2WOrQd7xeqlzTyz9W4cTNl/o8YxvOt
	7jNHiWxo0y3Qj1GgcoCd6UyLSM6BVsKPuQpG+bXy5eN2gVpTs3wVjN5s63ZLny+L
	scPQiByhK7vJ4eLWf7kD+XpFLKaJwKin9Ba58pNlBNZSFQh7aaQLVsmJxzDsK56f
	aB/b1ANVHa7uGlLCv0lzDDluCdBwsMkkOmmWj+jbPGL049FEImJNqKHj0ewQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768496135; x=1768582535; bh=xjiz9Ukr9NoWNyVBgikPCgzCV2We+vhg7YE
	gsUhREqM=; b=EpLAp8gi0FmXKf2NujMCtl3SfuznuwPUvjhpFJ8oZeruRxZqtnO
	AmZZpPmTnEVJ1vaMc1eP3xfKg2oycgbf9851h3KfCLKqohgSGyDuEfC5m2eyg1BJ
	fesFOCfP7SWT+DjiHk9cL2cRiBDJCYNUuUtFDumAqNx3mEdvn/lImf9uRDEdqxLE
	1DMfn1W2CkLN5PTVhFjbWRfxG7oxGzAYkiJMqMjm4SpyWys+bOH5y3ZElLWN9XKI
	0TXtV3PISlB6xHQETwzbrCgwJoSylGswQgIsrq+YPKsO/oPm2bwnhgxB7x3ADV/u
	vaSgJVtjT+cUxCR8Yzrb1HycZrE5uxk5Ybg==
X-ME-Sender: <xms:BxxpaRbjjcNyFpY6Z_Z8dEiZsFqhA-d-2zQjimRKxqWN48XYIm0YdQ>
    <xme:Bxxpaf1ridvl2h2EbIiI4QCKolab9Lv6_sOa8r-AlUSxGHtUwzt5ict9BH49Vi0HR
    nbagWFuFUh4xVnlMU2ori75BzyjpGFwUMc8IlO2fCJUfVT75cV5OQ>
X-ME-Received: <xmr:BxxpaRVRQhgpkyxm9axkeTUPM2awuT9vCQSmN1wq6QG06yYcTEL9xD9DvuEFnAH0_rqnHilDNmBOHplSCypZM_DYC6cCo8H6M3d3oEk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeiheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnohgsohii
    ohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:BxxpaZXnO8dOXZpWx5gdSIfRbty3hlnK5lQCnAvg_am4ZGI2luC7mQ>
    <xmx:BxxpaQf0TsTWRGuh-9lIaCrHyXXofZ2TUPAFM-FDaUkzzv1KCkobMg>
    <xmx:BxxpaSWy4Zdd99IwtfIylRH_b-9iwojIFCgSV-MrqYpTrHDEsEePNw>
    <xmx:BxxpaZchFS8qgGkuzEiCQOQkQv-1Old5I8x-J4Iki-ceqvPEP8Tpeg>
    <xmx:BxxpaX0UGiu5wL_8UGct2HERp9ZbYyzwqV4H2eoDsJlrsoB4jHe7LQry>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 11:55:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jon Forrest <nobozo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Repost: Inconsistent Behavior in 'git add' (git 2.52.0)?
In-Reply-To: <12239ac3-bc9c-4484-8633-a255a706011c@gmail.com> (Jon Forrest's
	message of "Thu, 15 Jan 2026 08:36:49 -0800")
References: <12239ac3-bc9c-4484-8633-a255a706011c@gmail.com>
Date: Thu, 15 Jan 2026 08:55:34 -0800
Message-ID: <xmqq8qdydddl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jon Forrest <nobozo@gmail.com> writes:

> % git init
> Initialized empty Git repository in /tmp/fish/.git/
>
> The index is empty, as shown by
> % git ls-files --cached
> %
>
> I then ran
>
> % git add file1 jon
> git add file1 jon
> The following paths are ignored by one of your .gitignore files:
> file1
>
> Again, this is exactly what I expected. But, running
> '% git ls-files --cached' shows
>
> jon
>
> This is *not* what I expected.

If the exclude mechanism does not allow others to go through when it
kicks in, like "file1 is listed in .gitignore, so it should not be
added unless it is forced", it would make it almost useless.
Imagine running "git add ." instead of running "git add file1 jon"
and seeing that nothing gets added?

It is plausible to teach "git add" to treat paths that are
explicitly named on the command line (as opposed to the paths that
are discovered due to recursion) differently, but that would be a
new feature, not a bugfix, I would think.

Even then, I am not sure how useful it would be.  Imagine running
"git add *" instead of "git add ." or "git add file1 jon" and seeing
that nothing gets added?  Unlike "giving a '.' would let 'git add'
discover 'file1' and 'jon' due to recursion", an asterisk on the
command line that is not quoted is expanded by the shell command
interpreter, and by the time 'git add' sees the parameters given to
it, it cannot tell if 'file1' was explicitly typed or expanded via
'*'.  It would be mildly irritating if the addition is rejected.

So, I dunno.


