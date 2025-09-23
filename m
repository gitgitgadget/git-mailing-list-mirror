Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA06252900
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 21:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664250; cv=none; b=KtWxUBmkBcVspX2h8fVFfPBFHxCOyMLqseZJUp2NWbFQMOjrHzfI8+GtuDU5UG0NSYVi6lidU300Opqefei+/dlUuNati8zJvLZWLcfFlNhGiEpYeDn9BaeWhS/pGqECa2PKnQvPXvWrkQR0ZW5zNx7Bq1vwCAnDYYrGgRAJBUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664250; c=relaxed/simple;
	bh=0ZSyUYtOQFNE+y7sHUu/9V8RxpOfIG9giUk3oWae4DU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oJV5EjpV9UJdEl7uFyDyvVdQ6GVuEfCEDeI0/REBrERzp94nQWuB2elQt+0C+pPQAkJmMgMMmnEHgidNDNmSOP/8vXgkGDTxYb9z0+Hzyy9Wt1gK3eK4N8kql+qGoCkawne/dxXyBRwkSqWeh5r8yTaUAACd3LHQclp8yHjVrHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bp6oGkD/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fMQRS3jh; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bp6oGkD/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fMQRS3jh"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 88111EC00E0;
	Tue, 23 Sep 2025 17:50:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 23 Sep 2025 17:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758664247; x=1758750647; bh=dvmx2sBcfy
	xloFQH0CvC4JllyPDsotjL2u7g+R6Z8Ig=; b=bp6oGkD/QV8R3AcIFum3f0z1m1
	Y2nNvEA0lx+bz2WGs98OeFSfuc3mo9bYAc1gY9s8fT3IAt0ECOzmwUyJxO9b6X9H
	ElDt7PxPB7PrAlfdBvnM50ckPwuPpxdZuPkUq7ekgA19youmRljQhmmstk0IOYpO
	PveG6Dsu8a/U7zomofItR783AmLirE9yHLi/sznLG1wqsBn1G96pMlVI6PVptKhB
	sDuJNyuOSb4+RJY+GgTctPR7yF4352+vaSI4WOnVqmurO3kB9h0Yc3ZLyJvyN1o2
	PEnxTmXJU5KDL/BxS2WUQlakwtymB20+1eQuVstJPA8Byli7QcqL3BAdT7Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758664247; x=1758750647; bh=dvmx2sBcfyxloFQH0CvC4JllyPDsotjL2u7
	g+R6Z8Ig=; b=fMQRS3jh+2SXqUtc2IwvbLomvZCFSxM5GK75T6rfdameLSSBreH
	BsMzKvTzhAkyC3eSYYE9qeElLymk9fvOz+tHsXkTNDiUXALzF66+ttxjTeFSSx5B
	0RQycaEfiQZHW5kQ3C81bFAl5IncxKi1FM0tntl/V4RO3GEIppWxkPk9AK13WvKj
	ugviQvSvqDfs88YxEO0MzxDDU8OxklPfpfa/dIKOmYIRp5zW+xV//XgW4uNV0L4L
	91t+5VIeN6uqcxADK0yF6x6Y4DY0dbRmSX6f4Y90WWQ1T/gCc2R29Y1MpFECZyYN
	dBEB0zbaWCXEqPW5x7tcwVWLRqGB0ztcAuQ==
X-ME-Sender: <xms:NxbTaPmpfAZAwgVrMegE-MvQ1FXLhDxMAcNHfdTT-Sw9YEB-jpVoAw>
    <xme:NxbTaJv7gn7fzFYn3b64WIU6qAI5mVWaYhXsVWYaN7QPHDbgxyVs92aDXP333YA8h
    DBMwRaO0XqgJx7QaH5MfPXQ6cTgI7R2lVzsvkhy6_tqOgR_awVGww>
X-ME-Received: <xmr:NxbTaN_1yItR44VbzAYTNUnaKGrAxZJ5hiNIvdHjlRY8Rv_Hw_6DL02qRaQUX7PPiAqDP3LTQ8sG3sWtFPIOhLVQuqucwdpUaYF7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvggvthhsohhniheftddujeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:NxbTaDM0rKJ98elNNDqXmFBsGPJ-FmbaM5FPj5XmAQFcjllo0Td4xQ>
    <xmx:NxbTaLHIUYitjzEeP4AF_K6czfXpdbQjPg8kvEWCMloCBpaWLZNYQQ>
    <xmx:NxbTaBTTSQqa4LgK0VcoC2lDxjfS3IIS2u0RNF9BlmqMfGSTvYwsRQ>
    <xmx:NxbTaIsfvPkPggK70E9vo52PQK0kWvJw1kbtI38c7VVW_doqnxZteA>
    <xmx:NxbTaCe0b4HtNK3k7JqMXUaRoB8kqL8xEEZhQ_T7nYezEBncjeuBYATH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 17:50:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  shejialuo@gmail.com
Subject: Re: [GSoC][PATCH] builtin/refs: add 'get' subcommand
In-Reply-To: <20250923104533.21165-1-meetsoni3017@gmail.com> (Meet Soni's
	message of "Tue, 23 Sep 2025 16:15:33 +0530")
References: <20250923104533.21165-1-meetsoni3017@gmail.com>
Date: Tue, 23 Sep 2025 14:50:46 -0700
Message-ID: <xmqqecrwon2h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Meet Soni <meetsoni3017@gmail.com> writes:

> While `git-rev-parse(1)` and `git-show-ref(1)` can be used to read
> reference values, they have drawbacks for scripting and discoverability.
> `rev-parse` performs DWIM expansion which is unpredictable for scripts,
> and `show-ref --verify` is difficult to discover and cannot read the
> direct target of a symbolic reference.

Well "refs get" is even harder to discover (it is not even in Git
2.50's manual that is available everywhere on the net), so difficult
to discover is not a good excuse.  In a sense show-ref was invented
exactly to serve as something like "refs get" you are writing, so I
wonder if a better approach is to extend it instead of introducing
a new subcommand in a distant place from it?

Perhaps "show-ref --verify --no-deref" or something that does not
dereference but works directly on a symbolic ref?

