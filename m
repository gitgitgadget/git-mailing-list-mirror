Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62209233D9E
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 01:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777340846; cv=none; b=lFt5cNwK9fZ0ZjH48Z/zJhmxzByHW9u4gG7dHkcTR6i1EPB6OcRRivHD0r7G1REC97qAeZiFL4akRYUZaBlgvIUbw5y+sH8dU3bY3saR+7skocCe+1Z4ALkFr2fz1fQN/3UJkOfCFYnx8tFngwzF/eTxi+NzRs1jmGwn/IQ7D/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777340846; c=relaxed/simple;
	bh=7ydm3pYN/1SxRMOeew1n0QhXHVkLV+TkxmxIybjLjqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FWc2j8xSsUgbyzRJ/Gwtw9Rd80aKHMePHLDyWNubj7RN1GKpbLp5rLmJE0tFYnUe+ihh3qcPjZKu0jsdJF0Va3zVBySEkljvvS3/OTm5XPcEWkRDEWCxoHcCZ/d+TVi+IxBqa8/O1kkHNwctNpckTZnbOBTVHX06xwUiRrbYMl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OW80x+uV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u0mRSY81; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OW80x+uV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u0mRSY81"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 73C431D000FF;
	Mon, 27 Apr 2026 21:47:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 27 Apr 2026 21:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1777340844; x=1777427244; bh=rjgUktnZsU
	oWlBVzKo0CNEaOPdv/+PGMiJyqjDSIoX4=; b=OW80x+uVIntsexqlXMEm5R+M2E
	Au+cqZkmjr82RTzVvAalejDW6jVMPyYJkQu/T3+zdG1/DM9cVfPKaohwee6EZ8QV
	yqCUKfpE6CSIZcgfCmzmn4mekjESrWpTMuodpm5vlyKedSxZBiuRprCxMrhZxEcg
	cZCvj+vfNE2INNzRzlbn3Lo0oOVgMnbYsbK/NX1AXuYYXYzzeffMxsDZ/Xif7Dds
	kQDjVceuZ1RMUavlfy2w2IAtENZ4NVJD/75Ty83M2dQs8aT+G4IRBuPfJsd0j13M
	ADZzyj7OvXAdDw748Srp7smTiDoHA7SambHPU4LtGmBBi1UYzC2Gwp6oEU7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1777340844; x=1777427244; bh=rjgUktnZsUoWlBVzKo0CNEaOPdv/+PGMiJy
	qjDSIoX4=; b=u0mRSY81+m/w3tpRT+AkhIXElL9uGyYKW7A/O9FdHbeTt9MuWUT
	14rWljDOlmU27smdoXaCx0WGvKZRoyS3xiSvIJI+8CGpG2UFs3yZgoRdAzvt1FV9
	5Rs6QfgZSstwDLSotTnbM3JAIixUtbf/Y+SklUHG0aoTG0oKx7SO3n19eL3tFmSj
	eup0y78n48uS9OVsugp/gukxkH74xi8dgQJT8YsdOfkDS/zrHpj2I1UJ+O8GjmiY
	WH2YkiY2/DfMCEsOaOXsS2Z+hacKgbKYSH9Dd1R9czUgrCa+be4JkAfsEhUjxCE3
	AGop394swrW9iwScE4EyuaW9U9+z131/Kng==
X-ME-Sender: <xms:qxHwaYHH6lKuPY5siMz7AFOf5GnHqVP9vg1g0DfA8eQ0p8rs5lxJFw>
    <xme:qxHwabX1CXu0hrQluhTkJkroZPjxI6QC-YA0zcsqGnCl808Wy9K8Bh6IgF3sxflop
    2laASJPMSMICiQwgjzuMKGZJiQzPJ0iJDU-H0WghOUaxIFV1SMRAw>
X-ME-Received: <xmr:qxHwaYzKGPcpqfeMkb7OhEBrUFy78ktvosBTR60mWnzCv9dHyh_mGHVjBUzII1Kyi_BGhfCQhv6hgssAMbkdpy5zLzQ9Onwhcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdektddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehmrg
    hrtghnrghrtgesghhmrghilhdrtghomhdprhgtphhtthhopehhrghrrghlughnohhrughg
    rhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:qxHwaYQDUH30FnvNhsDpmGNbfMWF7Viz3jDDYNpXI82MvUWR8kDeYg>
    <xmx:qxHwachnrXacTByriBCzMf_-gSQ5sJExc0hTLR9kTZYUrrukl7H6Hg>
    <xmx:qxHwaXnAJqKhdbj9gtQ9HGm5NjTZm8bzmW8C3U8PnDbhxFf1N5Swlw>
    <xmx:qxHwaXt-FsD7JCdLHTBn0gOmJ7ZAhY0I2MdzHMAlbdjJD_z_zodDiA>
    <xmx:rBHwafeaDVpqQVwMRVYJl4Gu7Bj5LJQ8qIEh-rUjpIBDyKHymqpsUoER>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 21:47:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ramsay Jones <ramsay@ramsayjones.plus.com>,  "D.
 Ben Knoble" <ben.knoble@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Marc Branchaud <marcnarc@gmail.com>,
  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v4] checkout: add --fetch to fetch remote before
 resolving start-point
In-Reply-To: <pull.2281.v4.git.git.1777228346809.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Sun, 26 Apr 2026
	18:32:26 +0000")
References: <pull.2281.v3.git.git.1777188295021.gitgitgadget@gmail.com>
	<pull.2281.v4.git.git.1777228346809.gitgitgadget@gmail.com>
Date: Tue, 28 Apr 2026 10:47:22 +0900
Message-ID: <xmqqwlxrzwid.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>

> A common workflow is:
>
>     git fetch origin
>     git checkout -b new_branch origin/some-branch
>
> The first command exists purely so the second sees an up-to-date view
> of the remote.

This is only half true, isn't it?

Git is among projects that encourage forking only from a well-known
point in history (like the latest released version), not at a random
"tip of the day" commit from the upstream.

Such projects also tend to discourage people from constantly pulling
updated upstream into their unfinished topic branch, or rebase their
unfinished topic branch on top of updated upstream, only to "catch
up", and instead encourage them to make a trial merge to notice when
the base got too stale to cause eventual merge to conflict too much,
and when it happens, make such a back-merge, but otherwise keep
working on the stable base and avoid such "catching up".

And when working with such a project, what users who do the above is
forgetting is to inspect origin/master between the two steps to see
if it is a good commit to start your topic at.

> If it is forgotten, origin/some-branch points at a stale commit
> and the new local branch is created from the wrong start point.

So this part is not quite true.  What makes your topic begin at a
wrong starting point is not that you forget to fetch, but you forget
to verify what you fetched and think if it is a good starting point.

And for that verification to happen, you do not want "checkout" and
"fetch" mixed into one.

On the other hand, if you are allowed to fork at anywhere (as
opposed to a latest release), then not fetching and building on top
of slightly older codebase is not such a huge deal, as you're likely
to be making the "catch up" changes on top of your unfinished work
later anyway.

So as I already said before, I am fairly negative on this topic.  It
feels more like a knob to allow and actively encourage people to be
more sloppy than anything else.

I may have already pointed this out (but I do not remember), but
this option would not make any sense when --track is not in effect,
so instead of adding a brand new option, making it an extension to
the existing --track option might make it slightly more palatable.

