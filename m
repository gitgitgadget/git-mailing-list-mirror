Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DFB6FC3
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749054785; cv=none; b=kXV/8kQHg0E0gxbPOh9lHUvJbdNmTQzUQsW9AR5SCZEapMJWA1l2ynpW0woVb97W3nsaqGuJUBxORmjvfOHnCaMBzqs7r+z/tknkkVbU0BF3EZ5RJBBGm2zGvc067rm99BMxHvtigu0RBGqTouIGv1P8UTeCxqKoAAjwvrsp6t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749054785; c=relaxed/simple;
	bh=5fAHA46PO0OtKOjiHHxBhz4okF9vgR2uBmB5TI7UyZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rG318XFbLSNxWAH/Fj1LR1s1RoszIKD4ZyrWmKULz7Bpd0iGQK8zNyf7q3CZsarQ+Aq/v9KCAL0XOGVa6B3PTLQ4oHHVhyc0t9DKWf7lvK67GDkUleJfiL+rBmu7BhQGulgs9G71uGr1dz4LkHQI7UD/ju4NDM5kmN7Qtoljut4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DSpUPkOG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mrLcMc9N; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DSpUPkOG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mrLcMc9N"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1BF5B138044C;
	Wed,  4 Jun 2025 12:33:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 04 Jun 2025 12:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749054783; x=1749141183; bh=z4C7MshDOM
	Kcey4vXyFVpNYhcX3MLH8ijq7cPAPYqSY=; b=DSpUPkOGC5B37ZDOI59g85hgHE
	3ST0TvF+IlNKfgvaKDS4AJkxEoRPTkxJu0Lq80WVu9i6GtG++GJnkwcSMwTCfjcI
	bQautLBihrOU9RjqXZZgKZAudJwd5o0lAqy8XnvW/f9pmCUH7NHwWtWLog22Qvfv
	OSJqOIDV6NZdBwNMJu9Ihr+yaObaeIWWkH05t0B2XlX8wUVTpq1cVhwwaZjmcoX6
	TijnsL2sQIyMZ69XCKxTDgaJZpx05IN9QmhnFTxv2iRawx/ZbVzVZP0sKz7BeyVF
	V5wnENqo2L/lHBmutzM73rD3L4HIrCIWorNBzTqayuUtIhZ+qzJBsZ+bojJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749054783; x=1749141183; bh=z4C7MshDOMKcey4vXyFVpNYhcX3MLH8ijq7
	cPAPYqSY=; b=mrLcMc9NNC9QXoL4YvuiIpPNP+qc4tzcclrtXbYkBx54HKFuS+X
	s+JYaYdmpjKnjywI21VCxxN9RDO1PNWUvQkR5a4GsKk87yIfavEzvJ1Pg73Ndmyg
	v300g9RSVJgAeX0mYom7bBSNTDktqJx7rXpzHSA3nr1bOkWyu4Yluvq968ugDNbV
	swCBgI6IKhvR9ftmJzPcBb4I3rIIxZDkqeYzJW63Q+uyCMIuIDlNT+HYe+ZllyhZ
	HJcXnPZb9FwtzlfYH9EYiCaPKAXlJ2I9m7AmzNk4xCy7w1iLp4MHAR7J5QwUsMoK
	XauOlqixP+N3VSuacBtd/iqtOtEUp+S1eUw==
X-ME-Sender: <xms:PnVAaJmOCRePTIUOdCdSXHg5mQ6Zpq5tfzCElGPPpUcEDf8tPFuPJQ>
    <xme:PnVAaE1JMdDvGRWpOJeX9y6wNuyBZ6O77KYG81PQVZFsMH8dcgGZOCn0B90p1xyYE
    dZD3ElhhDtHlh7jTQ>
X-ME-Received: <xmr:PnVAaPq7Mz0xE_lAvYIzSi82in-ibY5otLdjZeZKcVr2_EAFNta84GTQMMkSeZKeSoFPMMXZSQsOicOyrae3uluQSZUJZlv1LUOO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegrphgvnhifrghrrhesghhmrghilhdrtghomhdprhgtph
    htthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehprght
    rhhikhdrfigvihhskhhirhgthhgvrhesnhhuthhrihgvnhhtrdhiohdprhgtphhtthhope
    hkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgt
    phhtthhopehprghtrhhikhesphhsphgufhhkihhtrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PnVAaJkRReUHPS6Z_8NruCKSckppCrTePPMqq6FrsqTRlaQH3SfaLg>
    <xmx:PnVAaH24h88VRQfyoYLnvRGu0mHo0MM1Fipdw3LXzJyRWOa1qlstmA>
    <xmx:PnVAaIt3rEY-Skoy9PjQcOrnJBigjOFDyYTpZr0GQ0ozbY81IEYvxw>
    <xmx:PnVAaLVZlzswEGKbs1IlHHDZxqPYIhS5l8ozeWK5AxOTlg1126rjbQ>
    <xmx:P3VAaCiuUYeyu0NDJ4rhv1MKFtbBosXbd0RUfwwQZRs38b_cOYegza4H>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 12:33:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Patrik Weiskircher via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  apenwarr@gmail.com,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Patrik Weiskircher
 <patrik.weiskircher@nutrient.io>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Patrik Weiskircher
 <patrik@pspdfkit.com>
Subject: Re: [PATCH v2 0/2] contrib/subtree: Add -S/-gpg-sign
In-Reply-To: <pull.1928.v2.git.1749046597.gitgitgadget@gmail.com> (Patrik
	Weiskircher via GitGitGadget's message of "Wed, 04 Jun 2025 14:16:35
	+0000")
References: <pull.1928.git.1748882439.gitgitgadget@gmail.com>
	<pull.1928.v2.git.1749046597.gitgitgadget@gmail.com>
Date: Wed, 04 Jun 2025 09:33:01 -0700
Message-ID: <xmqqldq7bh6q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Patrik Weiskircher via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Changes since v1:
>
>  * Adjusted commit message to not mention the not implemented flag yet.
>
> Patrik Weiskircher (2):
>   contrib/subtree: parse using --stuck-long
>   contrib/subtree: add -S/--gpg-sign
>
>  contrib/subtree/git-subtree.adoc   |  19 +++--
>  contrib/subtree/git-subtree.sh     |  66 ++++++++---------
>  contrib/subtree/t/t7900-subtree.sh | 113 +++++++++++++++++++++++++++++
>  3 files changed, 158 insertions(+), 40 deletions(-)

Still looking good.  Will queue.  Thanks.
