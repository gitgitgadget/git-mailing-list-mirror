Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0588B24CEEA
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756924809; cv=none; b=DX5/aHS9FnDeS3uUka4fRp+UEjoOMkKQVyMo+yQyNVGOx7LSYVnjI3IQObHphbt3Fv1f3vas54mupvumxng5D/nZOf/cAmodmUNuut3Tg5Q4qNaCYqv31wYwS0xiRbQE4vnp4p15BHQD95k7IsIa6g31rHVWo7zVhlvTfLXZguk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756924809; c=relaxed/simple;
	bh=VBooKnE2JCJAeertaOBFdRXyI+6goOTARW4MCtjD1hQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XEdUeedV7QG1oWSAKaRHzTp57CQo9B3wyCZfL0ljpHDY3VZv23ExpHx7VPwXKSixE0PePLIVgrRZl2vryyUKkDEXwSGihatEXxiTtwX9VaphgI715szpRpe6oLGoWulALVdQW2kUoofiieU9p/QjgvBCY4Y0we0B4TEObMZjTvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=v8FWln0z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T3c48NLX; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="v8FWln0z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T3c48NLX"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 296791400463;
	Wed,  3 Sep 2025 14:40:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 03 Sep 2025 14:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756924807; x=1757011207; bh=eMToTlQKzM
	4mOo/DzMp+QfYU4ezKegbyn3taHnT8LOI=; b=v8FWln0zg2PAfdRICPQXWPNYkH
	Ljoo5D3bxFg2mnBu9TFt7bec3ZOFkYjbqjG3q1pzkvmXGItnNhuMQSnkddR3/9QW
	ygym+lX3ixQK1/RJWskNve+jljx9UW2lWHX7jSiiTnsVjZ0XbQZNMBkSiAgI+Jrg
	r8lg/iqDrM0TMRBtvMI82L46KMRZwXK2RZpCg9RJ7LiAyyNoK5FTgRcUFSC+A5Es
	sJshqfOql0e66AIHtUun8DC4J8VEedali+MVnDxNHyTJpqDip0zR97Nu9fdLe1Gf
	RKl9GjS7u7XxU/z23Y1zqvg3+1vBQZar8ppm0hR8juVhcxHzxHi7nifWjQuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756924807; x=1757011207; bh=eMToTlQKzM4mOo/DzMp+QfYU4ezKegbyn3t
	aHnT8LOI=; b=T3c48NLXxvO655bdiXeN49FsQUZGZYjFUuDM16wK7ycd6fXpj9h
	oheLrXhcRkWw8ERoro/RW0eerWO/oyHrJ+b1d6tjInC/NbgInqG6Ip7pmIttDh18
	Hc40COr5YtqCgaqVa61Yadqwbosi3zxwPbYcVj1oVjncOA9PfYV9o2OEVs00LB4Z
	TYtoFst0QikwG07JrG9sTpn3UcfQusbHwWb6dI/Jzur15hydB9tyqpa/vlc7DepS
	3Ps3qttjaRpKKupH0uJl85ftUedMJn2ogdhTxJkfTyClArMjHW1JZxyYLsggSrBd
	sp8LuMsUsXCnBXnufghV00pI0mHhuvB4mUg==
X-ME-Sender: <xms:hou4aFukx2OKfiTBGv22ugfrtjgaajMQq05vZxmLtXq6k76o2kn_Cw>
    <xme:hou4aCSRQ4-bFsjLIJPbcc7fjpcXSUUyDtkPHDdSiZq4aRNi-OZ-XE4vxVcCuooIv
    aAOnenNmbQStJli3w>
X-ME-Received: <xmr:hou4aB2EqAsRr3R1omGVovTCvTtELa7s1IPjacv6o4ZMbiPIdIpeJSrfnKuMQjpk1phX4RIozwWlrl2dJ5NqXwNjdGzH-SOsMThL3ok>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtg
    homhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiphdr
    fihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghl
    ihhnsehgmhigrdguvgdprhgtphhtthhopehhuhgrnhhgshgvnhefieehsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:hou4aPupCMKnlyB5lAeQ9aYpuoBYmMOk0Hz0-UjGWhh5-rAiO_t6Fw>
    <xmx:hou4aPjcNFInNYmBJN_QkE5hO2YTVxiThFRTqzwWJfYh1d6PmZUhbw>
    <xmx:hou4aI-jNdeJs4pi12vEFfHtySsk9IFbIuCZrYrdhBiXm91c1k9FHg>
    <xmx:hou4aKs7hhGHSAAqXWNEE4JyTYmj-YVE31IGD_3OdfT7jG_drRghng>
    <xmx:h4u4aLanZOm68YMr8jEPTNLDBWvgN94r606jkhuzFaeRqTgVytVE2S3V>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 14:40:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  phillip.wood@dunelm.org.uk,
  git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Wing Huang <huangsen365@gmail.com>
Subject: Re: [PATCH 6/6] breaking-changes: switch default branch to main
In-Reply-To: <9d52f24e-d495-44d4-b122-7d80d1f4b77f@gmail.com> (Phillip Wood's
	message of "Wed, 3 Sep 2025 10:54:06 +0100")
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
	<487d1a33130cb2fafadcf98da00a332a7408a0e8.1756308283.git.phillip.wood@dunelm.org.uk>
	<aLbWuGQhriQCMFbO@pks.im>
	<96e128d9-e5e3-4bfc-9e33-3caa75cacfe6@gmail.com>
	<aLfHvl5JuttXrI0y@pks.im>
	<9d52f24e-d495-44d4-b122-7d80d1f4b77f@gmail.com>
Date: Wed, 03 Sep 2025 11:40:05 -0700
Message-ID: <xmqqcy87fkhm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> When the variable was introduced in 704fed9ea22 (tests: start moving
> to a different default main branch name, 2020-10-23) it was described
> as "This `GIT_TEST_*` variable is meant purely for the transitional
> period while the entire test suite is converted to use `main` as the
> initial branch name by default." The way it has been used is to allow
> tests to continue to hard code a fixed name for the default initial
> branch.

Yes, but ripping it out would mean that you make it much harder to
transition out of 'main' and move to the next correct name when the
need comes, wouldn't it?

> ... like to keep the patches that switch the tests from using
> "master" to "main".

I have no problem with that.  I am still unsure about that "reftable
cares about the name being 'master'" thing.  If that can live with
any 6 byte name, we may want to fix it to something different from
'master', for the sake of removing 'master'.  Perhaps 'banana' or
something?

