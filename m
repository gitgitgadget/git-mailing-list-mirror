Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE31D145355
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 22:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759356483; cv=none; b=Z0qHQ3kggn88WsvGsi+0P7sGgXv9Qs42/ZQ7mrXrUHDgEbyLZMc94wrxKWrVsQmJOrRJQNUXsPpTRfzQ9kATuRUubp5n9DeQvYQTOvdWtkGgJYSCIVyzCfH3TV5bLLxYlOU5W9U3dXNZ521fSW0io22Rs0H1NlHGH21IaxCGOaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759356483; c=relaxed/simple;
	bh=c7XfGXd3ra3tHHU4ERPOD8oLRbT8wHT5dZhv2Ex/eDE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NLWV+jjzlCkBcdwrBIu2a0wyEyuKKRqqAKoW9625Oaqu2dodLF6FeS/Pllx7W9LmLAjySRWd/wvtvCJEeXhFAo3d1rXJpkdC8ck2Y/UPFWrbX9gxY47zfpsZHkW1Ine1YTaXAMTkty/XJqoJ2gaRKOf2EgUQtD9GfUCv8D8rZuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eHpInGjp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xTPP1zHn; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eHpInGjp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xTPP1zHn"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E81687A0440;
	Wed,  1 Oct 2025 18:07:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 01 Oct 2025 18:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759356479; x=1759442879; bh=2II6Fbjvfl
	Nrsw0wrWlpl1c61PQsVZDksqS7vDbrQ6E=; b=eHpInGjp7QRgFgYBaEFlSY6dht
	ueUF9acp8wEbO3raRtKmbLAZ4BDFJp+JXb4hR381weFHkINGCgS40TB/4FNS/d6e
	yM/4APsTfjkklRe4vzVLYEewq6g7HblLt7Z+MUX3FMfHjbRjT9twk39FPQqu2pyO
	TEfvxa4ii/l7Mn3DCqM8r69yeO1ZXUZtLih0WxWmr/pCWtVqMO0fm7BpxlPZlwDk
	waAGA3Da/0QORolUh14YbHt3MbjLG/6gGKOCamwg4f6yKn3JGYHXWIpa5cQBS3fh
	Bl0tbSbUR9WZJ9iUaa48UdIXrdCSOYjWVxXhPcm2r9leC4kBlXvkadl8I8dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759356479; x=1759442879; bh=2II6FbjvflNrsw0wrWlpl1c61PQsVZDksqS
	7vDbrQ6E=; b=xTPP1zHnHCrJ968IcmKEp2MPd4Xz5ITVbcSO2TWE6fFjFfOTWWb
	DmXwdw6yCPnLsd4QSApW3ZlqP9nEeTxhN699TJUHm3jhAJf/pXFrV1pDS/IVbvy4
	1sH9TkzZETDkWiv/XR1Qvfz7L7DsagNOCAsj7UjVL1NEuGww/g5gVKxkbPqhLLQL
	eVHuCT9LxYARVDqm0wtV9ELsWIr6i86fY1ZZU1QErsJsxwrwQ1ZWoeNARhFeG1eI
	DaHhbSNz424TJgSZdFNVulurwifqJOq1mcZ/V52zqzEEkdHoHt/WHUqIgj4E97NN
	TwPQI6lTtzle7lz7xbFdnMflmk7pgK0jOvg==
X-ME-Sender: <xms:P6bdaKJitUou19JGN698EP7J8UgEWkMoFvIiZvvNF8mZfIHnflx2uA>
    <xme:P6bdaEaP_i3cxR3vOc7eN1QQVExK-2OYq4-onJhktxQVb67PFdKLa-tQSN7ujXUAg
    5VI_puzP_uPPxfZ9M3khZbMkp0bIEXIvU-byPYX4Z1O3BODQeNNwg>
X-ME-Received: <xmr:P6bdaM_A5_1PhATZIdKScN1v4DmBL1rMxMOlRJYnU39ZeRNXtvWBzFigTz4zNCCtrEEIYF7oHUx3AwR_702pCtw6gX8X6U6CCI12>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekgeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjtghusghitgesjhgtuhgsihgtrdhplhdprhgtphhtth
    hopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhho
    sghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehmshhutghhrghnvghksehsuhhsvg
    druggvpdhrtghpthhtohepjhgrshhonhduudgthhhotggrsehprhhothhonhdrmhgvpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:P6bdaFaAaiLEPQJjgTYK8YESHc2GUy8j4Xy2ed5zV9UuT9tOf3oIow>
    <xmx:P6bdaAO9ooHF4g7rZ5qNdkaTkcVO7vpRLuMhmtMh_TnLZlWJ4DQDEA>
    <xmx:P6bdaBCMLJNj8bxNwy7XwAxMgiqb7lpVs4tJ0GbBmHZbNlmLtwcUHA>
    <xmx:P6bdaHJeaCJ9do1YESYQnmpfMlj3d4-hLYzCJhhRRKX2Xw9o5Y4-5Q>
    <xmx:P6bdaKWkLZaZ2nsf5UTabdWA1yAtyI-fYleW-Hw_qiabRbzW49wSJ5ah>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 18:07:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Jakub T. Jankiewicz" <jcubic@jcubic.pl>
Cc: Sergey Organov <sorganov@gmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,  Jason Cho
 <jason11choca@proton.me>,
  git@vger.kernel.org
Subject: Re: What is the reason behind not hiding git worktrees from git?
In-Reply-To: <20251001232718.7218e852@jcubic> (Jakub T. Jankiewicz's message
	of "Wed, 1 Oct 2025 23:27:18 +0200")
References: <aNuy1aab954D3rJ1@kitsune.suse.cz>
	<E311F5BA-F88C-4C3D-88B5-F8508B106D41@gmail.com>
	<xmqq3482312r.fsf@gitster.g> <875xcyfk3k.fsf@osv.gnss.ru>
	<xmqqa52a1h6x.fsf@gitster.g> <20251001232718.7218e852@jcubic>
Date: Wed, 01 Oct 2025 15:07:57 -0700
Message-ID: <xmqqqzvmz35u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jakub T. Jankiewicz" <jcubic@jcubic.pl> writes:

> It just didn't occur to me, that you suppose to have them out outside the
> root directory. The way I think about git is:
>
> directory/
>          .git
>          and all the stuff that belong that repo

But the point of additional worktrees is to have the stuff
additionally appear outside your normal working area, so that you
can continue working inside your primary checkout without getting
affected by those extra directories.  When you _do_ want to have
them _outside_ your primary working tree, you use them.  That is the
whole point of having additional worktrees that lets you make the
contents of other branches materialize on the filesystem.

> You don't create submodules outside of your root directory. Didn't you?

Sorry, but I do not get that question.

Submodule is attached to your superproject as part of it.  A
worktree is an additional and separate instantiation of the project
itself, which is quite a different thing.  They are apples and
oranges, as far as I can see.
