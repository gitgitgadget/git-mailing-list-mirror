Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407893382F9
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 20:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774296622; cv=none; b=GddWLo9r9cjPdSoJCdpaOwTBXQljgVjqyOWiEg8e7SW0W/aAJmHywLeq/NtXM5hAHf1U1q1ZWUndgYsDbUJ4fTLsysVttAcN5tHzMe2hgoxkIBdXKeDo9VyV39E/UJP0GSj6+5YtET5Unzp4MRF+ktMXxqzoB8JQPBI0dn+VGXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774296622; c=relaxed/simple;
	bh=rEkDIv7GGupAzjbdM0r7Tz3/y1MF0w1LrjQ7tui0+MU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZBxdb5SLw3hUAvoCICf7KsLUvQeIC7F2RdzmBdnFVLC/hmXY7vYnHtg3bfynveOBVrlXfO352JRFUsRMlsN4ze+7dNa3xwQy/nm4btgcpaOb3MrpmJTEMOpmxs5y3yK6vKYBg/zcqyhROuS1xiEeNJaXJTS/RLT0gx7dvjAsllw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TEUki/yq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vUWp0jiU; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TEUki/yq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vUWp0jiU"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6E228140019C;
	Mon, 23 Mar 2026 16:10:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 23 Mar 2026 16:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774296620; x=1774383020; bh=7QjfjQN8Kb
	NtW2NIXIYbWZqdpnc11y8MsTS6wR4cBHw=; b=TEUki/yq9YIMOFteFfcUL2JeIy
	3qZXrZSD2ZpMyrSV1+BPwjMYp9TahnK3bbGJ4lc5Mqn7L4w8iE0CEaXYEQA0vABL
	ypvcu6e6U5c+h+BTlL8NFcR/poVXSkipUuNFReLFNn/+k7MhtHP0jVE93J2JwiKz
	v74o5VjV9bduTBT5p4WBWfWEkV0hy6i79VNyaPKwbU86JUrg85weWj7crBGC40US
	MZgmSu/9qRX/azKYEKZXb2LTEGL31m2/zv8ENzI5WwU7UyqRIovTQ48w5dKH3oWu
	5I/jt6KdXpxHieqooxCbk+wzqgkZXCrYdD13Fk9SyWIprpDNTN3BiEdOAD9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774296620; x=1774383020; bh=7QjfjQN8KbNtW2NIXIYbWZqdpnc11y8MsTS
	6wR4cBHw=; b=vUWp0jiUq+EPZFWOuSJGqCDgCRYLscejgjYCt7YD/4kaX/J0LLA
	sfEXbYEzz8AynKNy74ShOqjOmhJfwn30rTiDgEUll7GhV9IayEQnw56UMUy/KHO2
	fxGD8MU8GJdQ3xp4e70Cjm6GVqTaELCYAB7e0YeXWazcYU45UhcWCtkX0GQgg4Bm
	OUd19jTps2KIDMoX8+eY1+Lnqxaa0kFb4fgU8Id6LL/hJm6JYKJdgV7/EovDPMVp
	QXPm9aOkcm39OGb7fdpBMnlaQpQ0h5EoT782gT1j4W77yTcldC0qBx/mrbAdkDWR
	lTzGY4H5EniXa9A+XuNGXi8Iix9+XcFFR6Q==
X-ME-Sender: <xms:LJ7BaedddwBrAkxd0zcVQUjxVSvjOHXVaBc2Vy0hekGNxQqsl1F7Bg>
    <xme:LJ7BafNFU7foe1E5mVeR8TmT8k4vm_kGukofEphxtHaA5bysSg2255b5lGLQKA09V
    3uHAJsQGTBoTm6JSwiAT8Z4NBLd0fMavT-76CB594r7o7G6HivW5g>
X-ME-Received: <xmr:LJ7BaUgoO4Pg9iOLSxvz9jJTUa0EpU_OQkBn5v_GLY6K7CzuZjWteY_hhQtbkUEMz_5sw_bOj3wdnaPARcFzW6SGRzAhWUflpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudelieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhrohhikhesuggvlhgrhigvugdrshhprggtvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LJ7Baa3k4HE8w1v7oH9LTe717WBYTPt3ta9HFJwj7SYTEPF5I_PSCw>
    <xmx:LJ7BaWgB8gyjIe4gqUdPrfCS5OJi7hIRsgiFDI6v9GJto_xLunucaA>
    <xmx:LJ7BaSdXxLo7O2rIph4JpKs23YvXOXM-4aiS5CIKWWSP_p3TbK3G3w>
    <xmx:LJ7BaRk5xZ00GjaIn7bs_T-WI9OTarISujvVh8uv0NTteX5wt5eVkQ>
    <xmx:LJ7BaQkUHHZGhEm-Nvu4YOkRD7KubMUKzwS59bADK3a7k6pQ-AMF7nxH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 16:10:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 0/8] improve "git format-patch --commit-list-format"
In-Reply-To: <cover.1774284699.git.mroik@delayed.space> (Mirko Faina's message
	of "Mon, 23 Mar 2026 17:57:27 +0100")
References: <cover.1773959395.git.mroik@delayed.space>
	<cover.1774284699.git.mroik@delayed.space>
Date: Mon, 23 Mar 2026 13:10:18 -0700
Message-ID: <xmqqqzpa489h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> Not much has changed, just applied the suggestions Kristoffer made.
> Thank you again for the review
>
> [1/8] pretty.c: better die message %(count) and %(total) (Mirko Faina)
> [2/8] format-patch: refactor generate_commit_list_cover (Mirko Faina)
> [3/8] format-patch: rename --cover-letter-format option (Mirko Faina)
> [4/8] docs/pretty-formats: add %(count) and %(total) (Mirko Faina)
> [5/8] format.commitListFormat: strip meaning from empty (Mirko Faina)
> [6/8] format-patch: wrap generate_commit_list_cover() (Mirko Faina)
> [7/8] format-patch: add preset for --commit-list-format (Mirko Faina)
> [8/8] format-patch: --commit-list-format without prefix (Mirko Faina)
>
>  Documentation/config/format.adoc    |  2 +-
>  Documentation/git-format-patch.adoc | 19 ++++----
>  Documentation/pretty-formats.adoc   |  4 ++
>  builtin/log.c                       | 35 +++++++-------
>  pretty.c                            |  4 +-
>  t/t4014-format-patch.sh             | 72 +++++++++++++++++++----------
>  t/t9902-completion.sh               |  1 -
>  7 files changed, 84 insertions(+), 53 deletions(-)

All incremental changes look reasonable to me, and it seems we have
already reached the point of diminishing returns?

It is possible that people are only commenting on low-hanging
obvious typoes and mistakes without seeing a bigger picture,
but I think I've read through an earlier iteration of the series,
and found it more-or-less solid, and I do not think there was a
drastic change of course since then, so I am happy to mark the topic
for 'next' now.

Unless other people find bigger issues remaining in the series, that
is, of course ;-)

Thanks.
