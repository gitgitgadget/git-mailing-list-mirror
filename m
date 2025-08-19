Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BD1207A18
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755618580; cv=none; b=kLckgDyaPAMaZbHGK3xsEDZXvYNBReq5snbSiEqWDoFa24y7k3ignU6DisW0q5PjBo2I1EAOhRyd5lLKREVq/fo7UdZx2mI/Kly7BxIb/er4Uiq299mZv4W+FPFyLRuf9moEz/TdNPLOe7SEXGOvWBnKLQ8ENL3YsjXkzISdY9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755618580; c=relaxed/simple;
	bh=TMtVcAz7LnL6haUwzSEdkMTjA6m9saVSUY9YMDlnfAg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JPCSBkEqwHC2a6hn5t8Lu+pTA6u3Vv2WQWuPbXTksCO6eJ+ZISm0j2F/ulDUFO1qy4HfXtZeKdHV/NJ8i0FHvvIE8f6/B4bPQLPdd8EdGsv1tA0U/X3TL5NK289FbksRHsvyg1eDZh7qu5l99da4qu3u/9Fl0UurJqDuCm4Fh/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NFgDhup8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=StJF+yYv; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NFgDhup8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="StJF+yYv"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 8C03C1D001EE;
	Tue, 19 Aug 2025 11:49:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 19 Aug 2025 11:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755618577; x=1755704977; bh=XDw0epH7D+
	TY0yh2bMIcz4/I/MRQYk6Bht/0B48Yib4=; b=NFgDhup8iguLjkrgnP5vg0HUtO
	+qJ/4u93hZjW4aqF3aOr9cwDFm03MeGDuMgQcdBAkcxx1/xaiWD0K5MWcSJxS4Wl
	pM8nHkrhecjT9j9472J3yQKOh8dYcYorH4KnPL4UXDdUFO0DT2/25Qf/T0TcNqbj
	/qW9LaxQUIIjhOukeQxvnZC8Ws6QG7/6VosIPgvFkaj8JB3VuPYyun2/RpTsp+Hg
	bOXIHVYG+3MY9jU7Vr6a7n5rXPKTjF89mTlz5+Fa/rO9l29cyL4neEHplA+6mJgX
	1uwd4Z+6YO3PKhRuPHeZG//Fx81OP7EMlOBk9KZ01gpfKtVtOb+Og3bVTRAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755618577; x=1755704977; bh=XDw0epH7D+TY0yh2bMIcz4/I/MRQYk6Bht/
	0B48Yib4=; b=StJF+yYvSW/ombJOP35M+oPL/JvkQMY+Qv7bgJQPD3pVn+kDqJ1
	pMRJY2gywlw14uf1m758orP2yn/D2SwVdpaHgWDZ2Sog3PP+QZOXJzq8NZqx+5PH
	HdevFQ2Kag6pMLzLKx0iFTVUmDozai7wPd76OiinEu2ysJP1/IOIuClTVEm6UEHn
	Ar7QLGOQxagyeeriRvUkbfEm8rGqDTCF87vQomPwzb0+2nUbeqSoiZGuCz+I8RYS
	OHc9/7vnwnlT/0qKRkNjn7eIbW1O/hE3HFrCXTSr+w9gxbJfkbD3Arejx4bLtSpa
	f34CCam2hReHujgeiBVTDWb+YGIJtsDx2NQ==
X-ME-Sender: <xms:EZ2kaIzGe8TvqiHu5mCiiHSpoM04ZN_dTIOiV67TiPa1ACXDdoAxJw>
    <xme:EZ2kaG1fD7zWsTqk9eMOvII1orqMioFqLc-pN08dA-0V5LBiJzpQm3Ag56i-_5pvt
    QdLSvyRBanyEurHkw>
X-ME-Received: <xmr:EZ2kaG6d4zk18QNbrF0jf0axZufrI8tp_z-X_WzIY_sCeygu8WHbY6-_Y6pLBu6pPdRJWW_QdgYFDzPUZ2Wd4UpGWV5iPahB4gCpcNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheitheskhgusghgrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EZ2kaJURBFiiXo0BSrI3XfturgMAR061VBoaBJWk-hD3g9lk0ZuS2g>
    <xmx:EZ2kaFCoedtkiaNqx-x4RJ4nfwWNKWXYA-6eajNuJB_DptlZyJqn0A>
    <xmx:EZ2kaI6dr9HG3yNHekjDJqWxgyst5BB4WN8LjDqCQHYntoR0F59jEw>
    <xmx:EZ2kaAyQaI2YzfPClR7Iq0e3r5Hjj3abWI9Emm43Cr57xRLMgIG5uw>
    <xmx:EZ2kaJaAIAiZx_eapf54ZJNgAWow-GL0smATPf7kucM0setJcLRT47Le>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 11:49:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 0/3] meson: wire up gitk and git-gui
In-Reply-To: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im> (Patrick
	Steinhardt's message of "Tue, 19 Aug 2025 10:18:34 +0200")
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
Date: Tue, 19 Aug 2025 08:49:35 -0700
Message-ID: <xmqq7byzfh0w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> I have upstreamed support for Meson into both gitk [1] and git-gui [2].
> This small patch series wires up support in Git.
>
> To the best of my knowledge this is the last missing piece for feature
> compatibility with our Makefile. As such, from my point of view, I think
> that we can stop treating the Meson build system as experimental and
> instead officially endorse it. Once merged I'll thus send another patch
> series that updates our documentation in various different places to
> also mention how to build Git with Meson.

Good.

With such a documentation, it would help folks to verify (and make
extra fixup if needed) to see how well feature parity is achieved
and peel that experimental label.

Having said that, I somehow feel that ...

>  {git-gui => subprojects/git-gui}/.gitattributes       |   0
> ...
>  {gitk-git => subprojects/gitk}/.gitignore             |   0

... a move like this is bending the source to match the limitation
of the tool, making the people who use (write, read, and build from)
the source to pay for the price, which is backwards.  The tool, be
it Meson or Make or CMake, should be serving the project, not the
other way around.  In our current build system, we don't have to
have borrowed code (from gitk, git-gui, sha1dc, or xdiff) inside a
specific subdirectory.

But I may change my mind while reading the real patches, not the
diffstat.

Thanks.
