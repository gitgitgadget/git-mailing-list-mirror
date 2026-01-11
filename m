Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A611E2834
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 03:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768102786; cv=none; b=GgpZgspf0tmKSj9WFu9hhIS4lDxM/CBs4j5vtmRtzE6BfIlyb6vP5KEYgLdYfWzUrbGbNRQr89LKQtrQ29u9QEqNUL8E2RPRVeeaLFRqs3nJAHE9mZ1F0K3W+tJGf0F3mBFcKqXMekkIMiKGCRveHGDklATo3XhZwwhPpa6pKXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768102786; c=relaxed/simple;
	bh=DQ7EvOaiO4N7Fk2dHGBRzOzFiWfIEMpxiwfxoJ0O2wA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N/6pvgcLydqRRdTVz6KYNs5Pxvbta82B4QkJ7LO54jz+//iavhz3KJHxHPS66c5+IWQaptFCFFexeZI9wHW/9gjWxBJILyYU9TrKOx0zpxCQ2Ko+kpNCNZcnoHSFrHJ18v4Wpivu+schx0iEWRXVShXi9zaxrdl3M/nSog+r0rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WhwQMZcE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NoZOGJkC; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WhwQMZcE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NoZOGJkC"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 139791D00108;
	Sat, 10 Jan 2026 22:39:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 10 Jan 2026 22:39:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768102783;
	 x=1768189183; bh=IMiJEi8dfGFVnz1boBpFQud6bAjF8oLf1YOKBS//7mk=; b=
	WhwQMZcEMf9iqaZ+84fI1pcvRgSMmTyB284xpxsbEwDjCC+hbtQ+/Iksj0IMaJVV
	T8tzfbe7oJmcbqaQUYp8P/jkCiPv93tpMDNHpCaCW02LQh7hn23gczAFjdvMmGpa
	ywha/Ddli7kmEZo9Zwaf3ZdboirLYkZpPEYwfy5ULjSVWJAi0SGxjs6uDaWn85Sq
	JS0DTaWbIsJu/Sf2dgvJ6b35o2JrYMe0ivK+n2nKhxLIdbSVyhpoQ41ya545LMqV
	pX+CEVFy5fMy0hBnK39FQ2accX/DvkpGZQG+IvNqzQN3XaLtdcpiASpX9JAlZSZU
	H+zTaBc0DLDq/ZSu/Z4AMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768102783; x=
	1768189183; bh=IMiJEi8dfGFVnz1boBpFQud6bAjF8oLf1YOKBS//7mk=; b=N
	oZOGJkCReR6k5eQenNWAI205ObQflY7sETQcEiQv1FTW4cFE7VtkBOQJmR/NqkgI
	5msaN+Nxt54uOmWKFbDAxQE6lJFE7an1y0sk7BXHN0HQfKaimNxnTSTDGE/p5txD
	2tqXvfnhA5USYEReyurzOXEfyvuBmSdvk5CErSQv0hMgWyzXJ4eyjYsCDeLhVEd1
	QuTcfdlBoNYRk8G2ixbeKnsYI802kvsVqMPuApIfqrMsQij7X6AiI4S1DAWrYLdG
	CPyC9KNN2aRYshhjkbYXPJ/6riIfvn0S5h5r2VdktwbEUKFkQQWBV0W2+0ceHPnN
	D37QGZzayudiOB0bHn4jQ==
X-ME-Sender: <xms:fxtjaYUrstcehBFIXAXXt8ZL0q09CWMFF35XUPLSLG-NmDEneuekOQ>
    <xme:fxtjaTnGwMFxphM4ybUwqQuSe9OTAX4KZvSceKhNy-SS8e8an5qEABKLXW6Q8FXET
    0n8Eez0TXSD0_ITUyqRNNOqRNoinz4ZQZwWWj-EitD5ntn9Xm4Z>
X-ME-Received: <xmr:fxtjaRaqoUlB_mbXSAQFZOjNb778XwFFi4tOezbydpTzNGVZtBHNvg9uxhPWEcICznyvEMdBHay1rz8CD03f2Y0Nvg9DbAHBM_GgMV8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudefhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:fxtjaWM9DVKe7FjvvNf8vsUrmMDFMJ7id10NShHUvjSsVdGQF3gihA>
    <xmx:fxtjaeZKT_N71bq-8foNcuje67578su4e5LcnEr3eZ4dQ8n0BGm5Ug>
    <xmx:fxtjac3Vq6T5hkgxwYqMaghqTG4XStg0QnS1shg9Pfp3bSuXn-eiSw>
    <xmx:fxtjacdJJ-bI_ei0OrGNjGVKlZud62K4amXuJHWUU2f_Izs78yFVhw>
    <xmx:fxtjac4HYPu7C60CzXaos1AdSuLc4fPcdIETwiGd8S6X6rjR2nuGe8qZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Jan 2026 22:39:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com
Subject: Re: [PATCH v17 1/2] refactor format_branch_comparison in preparation
In-Reply-To: <20260110200431.53479-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Sat, 10 Jan 2026 21:04:31 +0100")
References: <xmqqfr8ds7br.fsf@gitster.g>
	<20260110200431.53479-1-haraldnordgren@gmail.com>
Date: Sat, 10 Jan 2026 19:39:42 -0800
Message-ID: <xmqqtswsrf5t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Harald Nordgren <haraldnordgren@gmail.com> writes:

> In the meantime I think I will leave this patch series for now 🤗

I think we are reaching the point of diminishing returns after
polishing the series enough at the 22nd iteration.

Let's wait for a few days to see if what others find in the series
and then mark the topic for 'next'.  Hopefully any minor nits can be
addressed later as a follow-up, just like the Q_(ours+theirs) thing.

Thanks.

