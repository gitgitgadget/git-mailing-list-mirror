Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F027C28F1
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 04:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734927692; cv=none; b=SmVk2oh5oVGjG14+zLa4jB2JpvxRgcHvgjFgcKIE4zXhvoz2riyJNtT/MpstL1csrd/5F3ww137cbTYZ+exXHnAJIgoABkieJopRgXCnywm4I20CyD2NFgVV6aRkZ7W65eFbEpvl5fhOl49i4G5+SrMxajHzSwZJEsQXeVqI/CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734927692; c=relaxed/simple;
	bh=vQNZnxz2SEP4uTtm7tMuAy/2WZJp2INFmv+4s/Ks6Qg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DyH0jZ59GcSdw7PnH+hu3IcM8Fqdj5ESMXv9t0JrOpJgBcjmjpvVC90Tf22/X6aigFXgXm1xy9FIfpe/wF0fjMlJWQKgX8/zCKk2dpSvabdF7hO2/P4lB73+vtNBiZQ0tEZwbVSi2sChrS22k5K6xBd6/w7dN3lzUeVNrBg+EjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zjZltX1/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yX5OhFmk; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zjZltX1/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yX5OhFmk"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B6F932540073;
	Sun, 22 Dec 2024 23:21:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 22 Dec 2024 23:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734927689;
	 x=1735014089; bh=ksycje5ij0/pVzyibKnwodrfV04WW1iT0cTsvRx8JE8=; b=
	zjZltX1/FWCAtTxMCzM1jQTht9fV7s9IG22Q20aYReJGYr82oXKMOeW50CAzeUCb
	8QGbX0jBf2UUIljWJliTqGJufjdAjILIE6/dwck2wqjUI/R3BXADB12ZgiaxlER+
	AXjd2MQUPOGcF23UeGlegUU//hm89ogRoXj2+WtpuizEkWwkuabL/ax0AWUhZTLW
	bkVwbbquV+UK9MaLcplVamyNSuNv8olte8S+Gx1nv7PTXSaany+H0MNysrJ7I6H0
	ztLHfkV7wWoMEtAJUZ6myEJvicTlgsrU9G/oE3EV1ewpCjlS+JBMfzDAM9Rx5qdZ
	BJ/rbQto2koOZZLqhOEfKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1734927689; x=
	1735014089; bh=ksycje5ij0/pVzyibKnwodrfV04WW1iT0cTsvRx8JE8=; b=y
	X5OhFmkAauXzN/b6wdqrYGHNy67Ih6t/EoQayhzyRshgC08SorcNWFqYS/cuGonp
	Qshkw0xxU8GGSIhcxXjtBHAvnnqqiBrNAb1EnSq/ursplmrwKAhW905FK6Mz+SGK
	c5+nxcAkqtppfpfCD5GBGgHn+ZFAzZQxNnT/Gz+NfSjYd8ERxQ7fYXsZjlQRxOeU
	D7OA7CsRBYfw0P51e6b9Ww3mkn0CwrMRm03XMkhIsLqKpyavt7L64QLstLmKGxh/
	9tGiLQhm41mP7IGtFmyfE4OxDvkHquTxlGyeuMRMiIy9P9HtLu914AaqZ4ezlmHm
	9P6fu8WJ/MpyvZCj+0g/w==
X-ME-Sender: <xms:SeVoZ4kdmiQ3YYHlIAjTU2iYaGxkayzFTASaRPwz3bYNqyeKhwbQzg>
    <xme:SeVoZ33FaVyX9zmQp5zVWjxGXsoDuGEOGEjZ3dfOAEfp0EbruUzntBzvqhudLUW-j
    y6qjhvqOWbRQ98XHA>
X-ME-Received: <xmr:SeVoZ2q8E83VaBFTpVfu0hRaCzAhHAXrl2viy9O2d7DTNF6cKo5EsgrQTO2KeM3wYlb57exD_8gAbPpYSa9OQDRkSA-wZ8ViVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtledgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhusghhrghmrd
    hkrghnohguihgruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:SeVoZ0nhSe_DdmoZR9BAXmqyTqoIF4ZiU5d3ILoTVrncdU1l33o57g>
    <xmx:SeVoZ21GbHxopGGRJM7fQifM3DF1_oZss3MBXvzEOKjPbAqUq5bGGw>
    <xmx:SeVoZ7uGwjS_dJDGT7eHyorWFDMdKWImiHLKJuU45LUU_SZhfvG61Q>
    <xmx:SeVoZyXx4AykFFEiwOFe17zHJrx08vkD7mmG0oheal-xrcpCftOsPg>
    <xmx:SeVoZy_gvg3B3ZUbXYHhi_FtOPTDzPCiAjt4nscOXhimyOrkdliulL0u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Dec 2024 23:21:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shubham Kanodia <shubham.kanodia10@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: Consider adding pruning of refs to git maintenance
In-Reply-To: <CAG=Um+2cdMcys2x492_i47-qdvx5aJ7k6r=xSH5a3JZtMZBEZw@mail.gmail.com>
	(Shubham Kanodia's message of "Sun, 22 Dec 2024 17:49:35 +0530")
References: <CAG=Um+0v=BmmYjvBAXs4r4My6zYvpJvcE+0U6SAnxKUcd1-A4w@mail.gmail.com>
	<Z2Emh42DJkHFGWq7@pks.im> <xmqqcyhq3ge7.fsf@gitster.g>
	<CAG=Um+1NwB=ymwg+oM62f_W8G=3Gt14UFGe+S2MM3gTOdUcuHg@mail.gmail.com>
	<CAG=Um+0yFYeBQGznkVG6TJeN-U+qySbt-0EbvM6Vd-BcvSCT4g@mail.gmail.com>
	<xmqq7c7y13tc.fsf@gitster.g>
	<CAG=Um+0qGEf+pX0cjCA2Qti4NYwFeCb29zgS7k2Lu_0yfuEz-w@mail.gmail.com>
	<xmqq34iluhqy.fsf@gitster.g>
	<CAG=Um+2cdMcys2x492_i47-qdvx5aJ7k6r=xSH5a3JZtMZBEZw@mail.gmail.com>
Date: Sun, 22 Dec 2024 20:21:27 -0800
Message-ID: <xmqqwmfr112w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Shubham Kanodia <shubham.kanodia10@gmail.com> writes:

> If you wanted to be able to do that, you'd probably need to do —
>
> ```
>     git fetch origin new-ref-branch-from-remote
> --refmap=+refs/heads/new-ref-branch-from-remote:refs/remotes/origin/new-ref-branch-from-remote
> ```
>
> which is pretty awkward to type everytime.

Or have this in your .git/config

    [remote "origin"]
	fetch = +refs/heads/new-ref-branch-from-remote:refs/remotes/origin/new-ref-branch-from-remote

and run

    $ git fetch origin new-ref-branch-from-remote

If you plan to do the same for more random branches, you could
instead do

    [remote "origin"]
	fetch = +refs/heads/*:refs/remotes/origin/*

as long as you promise that you never run "git fetch" without saying
which exact refs to fetch.  I wonder if it helps to introduce a new
configuration remote.*.fetchmap

    [remote "origin"]
	fetchmap = +refs/heads/*:refs/remotes/origin/*

that only talks about how the mapping goes without saying what gets
fetched by default, so that the lack of remote.origin.fetch would
cause

    $ git fetch origin
    $ git fetch

not to grab everything (like when you had the same specification as
the value of remote.origin.fetch instead), but allows you to map
whatever you grab from there when you did

    $ git fetch origin foo bar

If the glob pattern given by the fetchmap participated in how
fetch.prune behaves (i.e. I see refs/remotes/origin/baz here, but
while trying to fetch refs/heads/{foo,bar}, I notice that they no
longer advertise refs/heads/baz---let me prune that stale one),
that would make it much simpler.

> Now to come back from this little digression, for now —
> - We ask users to set both `fetch.prune` and `fetch.pruneTags` to true
> (so that if a third party tool does do something, the damage is
> limited and they don't have an ever-growing list of refs)

Good.

> - Setup this job that cleans stale remote refs on a periodic basis,
> which means that their ref counts heal over time (if they configure
> all third party tools right)

OK.  And a scheduled task would make this part better.
