Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3853531A57E
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575149; cv=none; b=LdfZlaKWw/uRGaqsRjV/wlba7QPgtStdiE69gIIKn95C+aG1WoafuUGOVbRHPKwYKFvc0Z+UvjPP47DPNxKHtLJa5uX7IcU5oedwJoK+4y3rSSjK40i5NRyVNczcd2tNVw96whak5Wd4kQbuXdpj6/hcVf630nabwNyzTSKNIIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575149; c=relaxed/simple;
	bh=LmiLGEB5mMWTCEJJZYc+367o2xPd/5Ia6JRFTCc0Keo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s2rrlQ1nn8weZjTOtUIdqhr+Drmx4Y5BZIP/cE79Hu84UnSrnrCcho4dbgSKvGXofhlqe29n8Pw3STBJq9v7cHfTDSYzf3uZUJzGB1qomKh3KzGQ/XcDhocQ1y+MSz90OaP0eVN2lJq92IDZbp4lkmEzULE9nBeqYmscCubVNQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vi+odtj8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cwPxGKJ7; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vi+odtj8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cwPxGKJ7"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 4CE961D00285;
	Mon, 22 Sep 2025 17:05:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 22 Sep 2025 17:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758575146; x=1758661546; bh=LmiLGEB5mM
	WTCEJJZYc+367o2xPd/5Ia6JRFTCc0Keo=; b=vi+odtj8Mo5czFlwWYS1mq+Ejk
	FTQI1qjUdVKhUpzBp5/YahjLIVUmFQMJ+cbebXvi9nswMiGrGQ/gK0Q+MLgXxSpy
	QdEwDA77hWPaTEGSFqV2QvulHIEq1QQh0u2/ScJlWL3YDgcqSrpyFwPqKJd7HYz5
	JF/QMq30nZmxssYdkvSvJ1exF45N5u+lH7ucBmG2IV9BZFKr6jbN+ZVetsDdQHk3
	GAK3FNvhQAXbBdSJ/bJKkXv98mrqxxj+FYD2tZeLRAZXBI3t2Gk7dHn56cf5z4fk
	DTToabD9pLs6Coar1T7xeciu+3bO6n/cYgdV4ErfHFqxMDHKOL3+uuszaKaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758575146; x=1758661546; bh=LmiLGEB5mMWTCEJJZYc+367o2xPd/5Ia6JR
	FTCc0Keo=; b=cwPxGKJ7B7re5gPj5WTmMR8AqCGrIrfIcDG/zpoAqqopMNss4t4
	gA0Uv7XtsEslDToA/K98HlPfENwI642OjJd6talFg1j7cTw6dFiq796f0ycTK8Zw
	S1gQNIflgQdQtvQsrrlrvG7xRGz4OI4uSIVSC1DDNUX69eoMX4VZ26C/4tR5IuyB
	L0ibCMmETegssuAHIU7sqSyKP6/pOuVuvwpb9h2lAvPfGSBRA8/zbzapvaHhiMOr
	In6i0i34GBU28Yp5ZKjmSf0NZW7AB3vp36zYZvINgrYaMTaoCuO2vfNGuc0D5/VB
	hDZjKz7laGkmD9VTzrWh0AgFvQFxLftHaiw==
X-ME-Sender: <xms:KbrRaIkipi5jtieuT2kX5jCzI09t0kk3xOgHWs7CHUVP0nAWAZE5yw>
    <xme:KbrRaO2KPie4EHFuV0BXXpy_jr82wKFP8phpZzFfaiiXeoTCSoJuJHUY0wNcFzrGz
    JbR9V5ASpbXMpli2jFxXVE_WtrEPzi3Fh6n3QPVzl__6i05gvlxOG8>
X-ME-Received: <xmr:KbrRaLoi2OwgtA86PWVcEboUaogky48v4YbvocepdBLse6ZRrzzMAVzmjYA2Nduiv-p3QK40ugrYIDQ8MCk5ngebCdFJBgQDQnwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepffevvddvveethfejfeffffdvteekff
    evkeeutdeiueevhfduteevudduuedvteehnecuffhomhgrihhnpehgihhthhhusgdrtgho
    mhdpghhithdqshgtmhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepvhgvlhhotghifhihvghrsehvvghlohgtihhfhigvrhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KbrRaDfz0S-t5OUzqP-hxpjihQAQ2CPd5X88eLYJQWGNmq0AKWqyRA>
    <xmx:KbrRaCou3ZJWrFKkL-YA6ako3xxd6kJ0YAUhj4-8os7pXCfILfZjQw>
    <xmx:KbrRaMGx9IjEVO7v7JW4eWXBdZzaj339pD9k5I_H02w6wKl3jTDDuw>
    <xmx:KbrRaKsouuvI6HrW8kdjLzosMicDf98cVf04CM8c6GCQrqDIBFfUGg>
    <xmx:KrrRaE_r28haIeOVUaMdeNRbr3IPHJskmEtohSqLikBF_CWJQ1kLHgaC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 17:05:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?=
 <velocifyer@velocifyer.com>,  git@vger.kernel.org
Subject: Re: How do i get news of git releases
In-Reply-To: <20250922201403.GD2205919@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 22 Sep 2025 16:14:03 -0400")
References: <4ea9cb1e-4367-4926-a9ba-0680dd63e616@velocifyer.com>
	<20250922201403.GD2205919@coredump.intra.peff.net>
Date: Mon, 22 Sep 2025 14:05:44 -0700
Message-ID: <xmqqy0q6rydz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> The project doesn't use GitHub's Releases feature specifically, but I
> think annotated tags that are pushed to the repo end up there, too. The
> resulting feed entries are a little bare. Possibly they could be
> populated with the release notes, but from the Git project's
> perspective, the GitHub repo is really just a Git mirror. Presumably it
> would require some scripting around GitHub's API for the tag pushes to
> also create Release entries (and then probably somebody would want the
> same for the GitLab mirror, and so on).
>
> I think it may also be a reasonable feature for git-scm.com to have its
> own RSS feed. It already has to know about all of the releases (so it
> can point to the most recent one, for example). Most of the development
> for that site happens at https://github.com/git/git-scm.com. So if you
> or anybody is interested in adding the feature, it would probably make
> sense to start a discussion there.

It would give us a bit finer grained report to trigger updates to
the blob RelNotes symbolic link points at, if the rss geneators can
monitor such things.
