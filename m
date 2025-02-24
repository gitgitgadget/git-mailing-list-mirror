Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C71D257ACB
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740394634; cv=none; b=Fs+D9Sz0yrlfigFAEQzN1CZ0cQ087T3dmYNq4nGj05mtlZFolZu3iBrLOEvjV+9XpDp38igxEsnwsFF+pfiDZVM7M4KDwmsq8A2gZ66YeLcWzefPt9tYk8RdiZDS9hwZz1BUP88hB9J6t5Y3Xpwy/kZ4YgFoXg8RmJ9AEgyqEps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740394634; c=relaxed/simple;
	bh=31Ceisun/iUvq6S2r28Ssp0LV8pXxj2LWCRBx4kNrG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLxbd70/vtg16un5dhxqho+NhR58CX48u4L8L6mz0pWgof1G5V8h3qnH1iXgNewPxt5rIgdvPqPgnWqA73DKSVvGE6iA4hlqyxLtG8OPFwLxeskqLO8V2UHzhb05FgUFhSDrV7Sfo73k654F/1006UBu4z+8N11FPy8W4yeos7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QApnaweH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CPDJcoVl; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QApnaweH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CPDJcoVl"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 51DF21140105;
	Mon, 24 Feb 2025 05:57:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 24 Feb 2025 05:57:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740394629;
	 x=1740481029; bh=b0LQiJGOCtCpAZwz2hQUWa47A07oVQB27y16zzCKdAI=; b=
	QApnaweH4ozEtyZqnXra4x0BBT6eoyhCl87lSryzkJNzgxLbupaEBZ0IIddIijqy
	Y085tfqXdOz17ZbFyrDhfgpFs0vtLvfE0P7gykpr0ricuqVmUYQOowwn0OGAztBn
	qeWXFAnSbKh61rIKeZqcIXX8w91Uv8xSO2XiZINK58sN8EfGdQKbIvnDOlhlCnKe
	XgDrNiCCcYRQkrA6rifKYAng6BSRA+FbG+57xE7e9gKo1vKMLZ0CinWV1NpJ6mC/
	mXEqUVVdbz757ZgJ787CjDalx2mjtJwJuACP4axM/4yDB9kDLzOiKjpY/f1OKjt/
	rVKuPQsqb2t/0p0jDFVz2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740394629; x=
	1740481029; bh=b0LQiJGOCtCpAZwz2hQUWa47A07oVQB27y16zzCKdAI=; b=C
	PDJcoVl/9La4hJlR2HsbOhgzSmEiU8QeOIg6yn6tQD7XVPDp22A7N4zco8anB2+n
	bL+N9bV3Bsn4NkUogl9/iAHtNFuFjg6ftPbZVr1NrbNH/OE17MU8TlnCnVC/y6o+
	MZ8GjwoEvZyN9GIsE+Y7xrRBOGRcK7CRJDZ+fbvmIdSMI5Ly18LtJXX9bIAqKO5V
	tGAJ3gjN2VyDRvOzJPQyWv6yA7dZIhRqIgOFOzVri5cknYmMaalgFEzIamiShYlA
	XgQK2lEBaOf2VxepmhndV2YtzZ49UL66trkZ02+EjZjDoiEQzag62ngY4F9AuE6q
	JusbtiMoIGwJ9tK1jjfIQ==
X-ME-Sender: <xms:hFC8Z_e34fysZk_6OfRCAW8DPKdxl31Vy-6R5FXDkcx-ggEVdlfH6Q>
    <xme:hFC8Z1NaDYkdGZYvHOdqsYt6XpSCm6NnvA71ohurT4VxaWzYaovZHvCLVcfLe_RAZ
    XemPY0EL9u1oQQ9gg>
X-ME-Received: <xmr:hFC8Z4hfuo-QoVyVhUl64B7nvBbuMy-3oPQa-JLl35hg-M5RoKoUrDx1skm2PAo2D0Q4uSQ4PPq7-ePJriKJwy8LR3xxoFyF6Krf0BMLZCteXxUO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedvfeejie
    dtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvddtvdehsehugihprdguvg
X-ME-Proxy: <xmx:hFC8Zw9Jcup2Jcxyq_BzLDjQmMYUi23dKJ8ox0meeePC9msbfX6RKQ>
    <xmx:hFC8Z7tZZBi24FyJ4SaW6r9LwSMlQckyn4ujP4XeBc8NnlQiBE6rFA>
    <xmx:hFC8Z_HSou5xEdx1TcgYGiRDCR429Xe1y14aes6WYSyZQv4Xg2w8RA>
    <xmx:hFC8ZyPooctkqiqV7S-TDiCcr6Nvs0TqSXgIEd54OIeQdZH9masmrQ>
    <xmx:hVC8Z07DfFI51AVzUvBPp0t_Oa_9BH-e1VrmTps0k0JfukXnz_vsnrvp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 05:57:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e004f8d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Feb 2025 10:57:04 +0000 (UTC)
Date: Mon, 24 Feb 2025 11:56:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Markus Gerstel <2025@uxp.de>
Cc: git@vger.kernel.org
Subject: Re: 'git gc auto' didn't trigger on large reflog
Message-ID: <Z7xQey4S0ewT5rs7@pks.im>
References: <e650f4e4-e267-4f1f-bb3a-c71b1fe0b276@uxp.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e650f4e4-e267-4f1f-bb3a-c71b1fe0b276@uxp.de>

On Sat, Feb 22, 2025 at 10:50:25PM +0000, Markus Gerstel wrote:
> Hi everyone,
> 
> I was looking on a machine that does not normally get any attention. On this
> machine a daily cronjob has been running
> 
>     git checkout -q master && git fetch && git reset --hard origin/master &&
> git gc --auto
> 
> for 6 years. The git directory now contains a .git/logs/HEAD file of 180MB
> with 823921 lines.
> 
> The repo config contains
> 
> [core]
>         repositoryformatversion = 0
>         filemode = true
>         bare = false
>         logallrefupdates = true
> 
> and the system git version is 2.36.6.
> 
> I can't change the git version -or install my own one- so I can't tell
> if this has been fixed since. A manual git gc fixed everything, so I
> amended the cronjob to just do that instead.
> 
> I was just slightly surprised (and amused) because I expected 'git gc
> --auto' to pick this up, so I thought I'd share this with you.

It's a bit funny, but whether or not `git gc --auto` does anything
solely depends on the state of the object database. This is figured out
in `need_to_gc()`, which returns a truish value if either:

  - You have too many packfiles in the repository.

  - You have too many loose objects in the repository.

If these prerequisites aren't met, then git-gc(1) will skip any other
work unrelated to objects, as well, including pruning reflogs.

So given your above sequence of commands:

>     git checkout -q master && git fetch && git reset --hard origin/master &&
> git gc --auto

You may hit an edge case, depending on whether or not git-fetch(1) ends
up fetching changes. While git-checkout(1) won't write any reflogs if
nothing changes, git-reset(1) writes a reflog entry regardless of
whether it performs an "actual" change. So if git-fetch(1) ends up never
fetching anything you don't accumulate new loose objects or packfiles,
but do end up writing a new reflog entry every single time. The
conditions mentioned above won't trigger, and thus the reflog is never
pruned, either.

Patrick
