Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25E87E9
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738160621; cv=none; b=ObISSAgSALeL9+9lMRFooMiRVIU0iQKPtzW25EnOdSTcyRoYfV9CODSVbHiuiljMwz0AB9jUx/dobvxwIHxs7iNBr/uzJatRp7pDlcgiaFkcg1hQLmJmawzx+IFd+AwlOgvIDeqrUTvCTnkt0hfhy3omNPcYhDCwlp/sml5VvFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738160621; c=relaxed/simple;
	bh=2Q3MyJQ2GzQgPTAHlMMRJ4sBR282cq8mGkbttUlTdJ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PS/akzwVg6t/XFUsLBpqzJBwxLdS0OWT0XvgmbrZeAl05MRkwyKzIPlzuGM205eqkqJXgMdxxSbNOJ6g1gu6QlDs9WhcHFkXVEfqXobHrQWpBF1OwiPFJ2aPDJvaLhY/Y9q+lhb2lVmRpc/6I0egwZ3gruZZhKWpzbgtMRMBHhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rVj0/9m7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IMZLA+mM; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rVj0/9m7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IMZLA+mM"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 91CC225400CE;
	Wed, 29 Jan 2025 09:23:38 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 29 Jan 2025 09:23:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738160618; x=1738247018; bh=2Q3MyJQ2Gz
	QgPTAHlMMRJ4sBR282cq8mGkbttUlTdJ8=; b=rVj0/9m7AjrsrLP42dnWBvVlcQ
	1JXa4ZS4tPGzkllhENN9dA1lPLXA3vLC4LtvK77J4QRoTvxWoID/hwfZ6vksKmy6
	fuRVGYkAzH9j24ovIpI0EMbPak/axOMC1szDWEjB4f8XsZWshJBnQjXs4UdHVgDg
	6EBYaGTZAapUNoj1Qa8WmwbLQCz2W5BxCswVDzaPxFBx9x+Uo081i6X8uEiMYYb6
	G1TNXui8tbHLWoAnoxhSVnpxSSiGbnA+XVJsyRH+taqo00k36taO1QCz9hFU/FAQ
	VbfpB8xBq/2/JZFzX/GZv6zwRa2Wm2/ErYnYAuRAvnQIJ2RgOnklh3UsBHhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738160618; x=1738247018; bh=2Q3MyJQ2GzQgPTAHlMMRJ4sBR282cq8mGkb
	ttUlTdJ8=; b=IMZLA+mM23/MLWOCSVZ9BHkNFv/x1+5bqO0tZ+1TAScpe+yyItr
	vzx06ZT5vf4vteTovERvqg+q0huxNE2HpGhOWCxCuHvFfxK+pSEQbuOPcUCMfac+
	/KNSUyt7Jp7mx73Im6OOEMcpS75ri9aRYbAUky+IOcUErQKPmKtqfiKkNg5D34z7
	QFY/AzIV79QnfcMyJkHrwkFKamio6y5OsCEwpJA/mYb26fH719F2EGZcK1/S6XAz
	worEL6pS8pH59lvsun7Tz2zSnZXpqObBgF7aBVV7eTuxHGIF5ek6IAGvm340UYyF
	zk1JXowpUnXHgw0RxlFD6NscegcP7H/z1rw==
X-ME-Sender: <xms:6jmaZ9CuRmjPCe3vfwqyC87JF7Y5Q-9ngLcyZtGXy8giUaUwWXFHZQ>
    <xme:6jmaZ7hq3bbQF4n4mUFSebvGZi781IQcPJ-Mq6vL0UBroLGkR4fuaMKKuy--fNl1F
    HiyKZlP2MHLs0ApkA>
X-ME-Received: <xmr:6jmaZ4kYKLPDuNjDrQ7TqXJF5_2tCCzhP2UXgnmR8wa8XZjH4inxugv78cAEMPp5UUxxfH9JDvC9aT5BzS5P1nE-OhgNWeQoyXvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrd
    horhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegvthhhohhmshho
    nhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:6jmaZ3z0TP--WPCpxIjbUOg2XAZr7LEhYVY-iv139EzCxwKf3lAsng>
    <xmx:6jmaZyRF__2_T2aBXBXaTqAHZTk7m8j1_TA7K48hveok1NLATOb54g>
    <xmx:6jmaZ6Zk5fOimDb0Rn0RRJpASzOFilsMB1vTqLMnkzuCwcNHGhTvEQ>
    <xmx:6jmaZzSQviBtOdqSLK_NOUho0AZK10T9r6siHOuunzKqQDN_3Yt1jg>
    <xmx:6jmaZxFo_eizlhRKxEgn5ZFZd1Z6ZJ5DIoPHqvO2J07zw2w9JwfUskty>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jan 2025 09:23:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Patrick Steinhardt <ps@pks.im>,  Edward Thomson
 <ethomson@edwardthomson.com>,  Justin Tobler <jltobler@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v2 15/20] compat: consistently resolve headers via
 project root
In-Reply-To: <c0ee472a-5ce6-4e2e-8922-65927f07029c@kdbg.org> (Johannes Sixt's
	message of "Wed, 29 Jan 2025 08:50:24 +0100")
References: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
	<20250128-pks-reftable-drop-git-compat-util-v2-15-c85c20336317@pks.im>
	<c0ee472a-5ce6-4e2e-8922-65927f07029c@kdbg.org>
Date: Wed, 29 Jan 2025 06:23:36 -0800
Message-ID: <xmqqldutk8bb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Depending on the desired goal, is it perhaps better to use <> brackets
> more liberally?

I'd be in general in favor of that direction, as the semantics of <>
is more clear than "" from the point of view of the standard ;-)

Thanks.
