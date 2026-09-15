Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3F63C5536
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 19:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789500903; cv=none; b=pY3LUqvtpuyfbfzy0XkqvbxZyfQJOmQMzdEDy+p3ctCI6WnD3K10O3VHH7j5whRZxEWCO5/5+K1+jjw20m1HwOvBMcxRUSnXgfSBHX7fmKldlAa54iIGN6jRZBHjq/qFIwDAGhGxpaztpENM2Kb3LuMSjbJsmy6vwFzHviNfg74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789500903; c=relaxed/simple;
	bh=jk62LMAPpO9rUWrJ7qZW84VZPp0G3n7AV6zuH5hpd6Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o7zsGTKSUdn5hkpvJoxACMnS+AkOc2ZTeA4TvXK6vuKliGeQJdNV8+Lzi71LxjDpzW8T9S+HSg6J6QWM+fcSc6QVqeB/S5eGAIF+qZVFhwpzx5s0BhPo93sUPdtnX93wAMGibQ7dkMLGUmuZEAfeCtrMp63Haw4MYyzzB7QD0FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ahpWXnWY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DUMn8j9J; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ahpWXnWY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DUMn8j9J"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 041C77A01D7;
	Tue, 15 Sep 2026 15:35:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 15 Sep 2026 15:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789500900;
	 x=1789587300; bh=uu89MTmP1YHhwBqWm83bgoufaidVyhjYvjoBQm/Lomo=; b=
	ahpWXnWYMunjwaZmuOlO4oQrGbNS4QHJRVApZW0Z7zKWzzoEmtGLftFWiybqk7+B
	+QBlOHZ3pJ4EdM8tMnmYRT5zen57yHldpEAxC6HtzZcThZ1axpDRtbXsqgoldXW2
	jHLRlCdCydCBZnc/xzAnCyW6l/P+oj9rrB4smXEiOxEHME8sQ+rbysfhBWVrsYHo
	O/8YsTEbsFezthhdqCxI1bkctzNXsE0FcK7rlgPZY8BDy+zA9Hxlalpulps+/pNY
	kN54nPeW4o1AB1jZ4M1zv146Nw8zK6qkRr6yXdJmqGj5KhSA7a6S09+nHRUi3i3U
	HQrCGSkkVczvak9YJrZMUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789500900; x=
	1789587300; bh=uu89MTmP1YHhwBqWm83bgoufaidVyhjYvjoBQm/Lomo=; b=D
	UMn8j9JI942ftfpVdnieo2dHb5Ro4h/r0+7FwFmU8dk4fsu58H02lvIZJGFVefuA
	YLtNEuXQ00gmUEhQm+82lioWxK0LtPO10oajaQuyvdtfAemW5XEIMGM4y9A5po+A
	Kv9bEFUHXa8yKIxisy70TVgWDQfnfQRoKPxx93T5L/j1ZWk5ctKrgssHscTK+uSg
	/3HhL26f48N4+1hymHrzmrP6kok7dx7+5v50ojV9Nx9RHM/3uJraUTMfhkB/tzO+
	kfJT8ChSSjcsTXjI6C94eIAcJJho3CYqrApeegtcKF7IYImNgmiiVV4WkZ0twh+j
	mMFJxHGbNtf7QinsAXmJQ==
X-ME-Sender: <xms:5J2pakBZOxTDM8RagFFJDb3YVTPNEDc5lbL80o09uj3JdKVzNfQiMA>
    <xme:5J2pat93RmjabsCJvdICPscZ50qfCtR4at2yH_x2f6bwg-eFSjRy8h50ljBrvnNMt
    rm62o4jjAXgqvvweeskn38DiC0q9i--VJ6jaM4auOWn9UlvJ2fNQhQ>
X-ME-Received: <xmr:5J2pak9sxc1uBmmLdqwQFK_jloCj47oY-GBc70zLuWbYAoDI25LrRWYici9bGtnISpnvFg93KPdC7G27cKjPcPOdzvX-u8Xf0PZu>
X-ME-Proxy-Cause: dmFkZTEHxTR0rM6gXFbo2IHcqOddyD9sWskXLzC3xY6wvch55H/XGalBpymbgi5n/EU9kS
    0n5OB8Fz9iyFtGB2qb2tjaWE7giUEa5qFUWFshS2GQftP6wU2MxcSKPyfbhWTSxlCib/Eg
    fIdTJUUFbUqEEUJRIRYcl7xk92kJB0823Q3CXHHQy7BqXD5hP6hT4+cgaTotU/8YPWYWvK
    GrVzfruC6re7mKCw1tgJm3TONBhzwZoQvvEYI+quqgT9WbfrPEJqfS4oNiqJocwhDl+UIH
    Xp8pJEJBxNGW4fkoFVSr0Tr6UCQFXIskcmVycQeHLcfCUNYtBYr8kh1zWZvt+dQD0ITisv
    P3Uy89VVDxZjditDHLEAxuL8SosFVecNlqcB9aVRn/FNt8Q6rb2BlnO7Fxcf8ynkpJ4HUW
    UN0esnp6nMzZIy3iL3Ztr22JvB+Aht7m7ag81S3k+5xJjdki6i2VpzcUP5qFqcv8SCOcN0
    /V0V0w25iMGcwl6DIU84wVbt0YcLipqWcGgmrEjaYsdK2H78yep1+qnv/b0YQPQhkX1bXr
    yfid9q5UVPT4movdNeqyTwMDh5g3vHQj+qq+XwPbuBGkJUR07HdPRar/HEg4Uwz/2DiN7/
    H2Yje0sdxrT9alNiaUa2QkR4aa0FEXqjSeweJ6p1EHPOIoYwERdDehVU8apg
X-ME-Proxy: <xmx:5J2pakeb_D8usDBCR8bt5Ngcn-lYvcBQ0A3iqJlu3Ox8aU9b1XneNQ>
    <xmx:5J2patFi5VNB64bZZoOcDIoTvz4U6mhzNdEUMnvoluvCcHEaCDzQEQ>
    <xmx:5J2paidasDChj5NuQqLeMpvNmkhOIftBKt_gTDuEtwrNzpavbY1OJQ>
    <xmx:5J2panF23IdVG55APG37BDLALaQYJIygLr7E0jLYjoqn0X_P7wUMJQ>
    <xmx:5J2paiLgPaOw8DIk3h1gixBRXIe2-MkRCSQnGflYf2i4c7oQcOANZDAt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 15:35:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Andr=C3=A9_Kie=C3=9Fling?= <akiessling@carneios.de>
Cc: git@vger.kernel.org
Subject: Re: Bug!?: Refspec '+' should be same as '--force' but is not
In-Reply-To: <1bcb043e-e744-4e01-8569-4da5669d25fc@carneios.de>
 (=?utf-8?Q?=22Andr=C3=A9=09Kie=C3=9Fling=22's?= message of "Tue, 15 Sep
 2026 17:06:38 +0200")
References: <1bcb043e-e744-4e01-8569-4da5669d25fc@carneios.de>
Date: Tue, 15 Sep 2026 12:34:58 -0700
Message-ID: <xmqqld92z4t9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

André Kießling <akiessling@carneios.de> writes:

> Hi there, think I found a bug...
>
> In https://git-scm.com/docs/git-push I find:
>  > The + is optional and does the same thing as --force.
>
> The fetch documentation refers to push for the details of <refspec> so I 
> assume, the statement also holds for fetch refspecs.

A fresh clone typically creates

    [remote "origin"]
	url = ...
	fetch = +refs/heads/*:refs/remotes/origin/*

And indeed "+" there *is* optional.  If you remove "+" from there,
then your "git fetch" from origin will notice every time "origin"
rewinds its branches because it fails to update your remote-tracking
branches without forcing.  So it is like giving "--force" to allow
the origin rewind its branch tips hence your remote-tracking branches.

IOW, the statement holds for both push and fetch and the
documentation is correct.  But forcing vs not forcing should not
affect pruning.  They are totally separate concepts.  So quoting the
above documentation and then suddenly discussing if pruning takes
place or not is a bit jarring.

> When I run `git fetch origin --tags --force` it will force update tags 
> that changed on remote (as expected) but will NOT delete local tags.
> When I run `git fetch origin` with config set to `remote.origin.fetch = 
> +refs/tags/*:refs/tags/*` it will delete my local tags as if prune was set.
>
> I'm using Git 2.54.0.windows.1

Even though I do not do Windows, this is so basic a thing that I do
not think there would be platform-dependent behaviour differences.

Unfortunately, the above does not reproduce for me.  Here is my
failed reproduction attempt.

First the set-up.

    $ rm -fr /var/tmp/x && mkdir /var/tmp/x && cd /var/tmp/x
    $ git init src
    $ cd src
    $ git commit --allow-empty -m initial
    [master (root-commit) 9edb8aa] initial
    $ git tag -m initial v0.0 master
    $ git for-each-ref
    9edb8aaed37552991a2c7578da7862ffecae1e30 commit refs/heads/master
    26fb2b9f313528b70566594e621d3873e9815415 tag    refs/tags/v0.0
    $ cd ..
    $ git clone --no-local src dst
    Cloning into 'dst'...
    remote: Enumerating objects: 3, done.
    remote: Counting objects: 100% (3/3), done.
    remote: Compressing objects: 100% (2/2), done.
    remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
    Receiving objects: 100% (3/3), done.
    $ cd dst
    $ git tag -m ours -f w0.0 master
    $ git commit --allow-empty -m second
    [master 4b48c71] second
    $ git tag -m 'our second' w0.1 master
    $ git for-each-ref
    4b48c71f0f2d3ca58eeed0d3afa71f23681dd98e commit refs/heads/master
    9edb8aaed37552991a2c7578da7862ffecae1e30 commit refs/remotes/origin/HEAD
    9edb8aaed37552991a2c7578da7862ffecae1e30 commit refs/remotes/origin/master
    26fb2b9f313528b70566594e621d3873e9815415 tag    refs/tags/v0.0
    cc47a66dac78d2838e767436a44b24aaca521ef7 tag    refs/tags/w0.0
    9f49b658425485deff4cc1c4ea52583bfecd294a tag    refs/tags/w0.1

The origin (src) has a commit and a tag that points at it, the clone
(dst) builds a commit on top of that, has two tags of its own.

Now the reproduction attempt comes.

    $ git config set remote.origin.fetch --append '+refs/tags/*:refs/tags/*'
    $ git fetch origin
    $ git for-each-ref
    4b48c71f0f2d3ca58eeed0d3afa71f23681dd98e commit refs/heads/master
    9edb8aaed37552991a2c7578da7862ffecae1e30 commit refs/remotes/origin/HEAD
    9edb8aaed37552991a2c7578da7862ffecae1e30 commit refs/remotes/origin/master
    26fb2b9f313528b70566594e621d3873e9815415 tag    refs/tags/v0.0
    cc47a66dac78d2838e767436a44b24aaca521ef7 tag    refs/tags/w0.0
    9f49b658425485deff4cc1c4ea52583bfecd294a tag    refs/tags/w0.1
    $ git config list --local
    core.repositoryformatversion=0
    core.filemode=true
    core.bare=false
    core.logallrefupdates=true
    remote.origin.url=/var/tmp/x/src
    remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
    remote.origin.fetch=+refs/tags/*:refs/tags/*
    branch.master.remote=origin
    branch.master.merge=refs/heads/master

Unless this is Windows specific, which I highly doubt, there must be
something that is missing from your report.  Perhaps you have some
configuration settings?
