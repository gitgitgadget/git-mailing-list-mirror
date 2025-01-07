Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECAB2F46
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 01:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736213041; cv=none; b=Bz+z7xuvnRET3/GT8/9elFriRJVlDNEBB8mERwXzBGsF+YGXE1M4EIruE2FjuvcCuKGWSAyp5e1R5nJx0JL0nN4gyqz4mP7TinHWgxaFKaN/s3bsT/XTOfS7dbixWxRqygE24xN1MULTK2rSexvloFg5Nn/zF7gdas31lohm8Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736213041; c=relaxed/simple;
	bh=BGb4NgLtHA5vF787sx+EgLO7WoAxdJKeSPeVWzcjCmk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E2InKY9xhKsCF7XQPTNBLGOTWJSL7gG6lMgwwqt4lvvyWtZY4Jhd6gsKd9umeG7dbqMGIjPpGUWvqyaANhpMY4/CV9lRSR9YbAGcT3nIti7+Bf8Y/PssiiLe7h/9TO7DPgVhkiLh31ArPamZKfsx0Ljv5IQrt8f7OrakDaPFRlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CkhLaeaf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ENlXZ8eu; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CkhLaeaf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ENlXZ8eu"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DAF4925401D0;
	Mon,  6 Jan 2025 20:23:57 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 06 Jan 2025 20:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736213037; x=1736299437; bh=cj1yEcjrht
	2vXFS1j9+K48OJrFI2/oFXAfI5TVuszRU=; b=CkhLaeafV7YtJUUe+TrcBVXz0M
	eI5D5HKyhk1f85I80f7S9wlUusAmI6Rqcxm8rYdKTnSdciX8MYia1ZNDJeCEpXdQ
	SBNmiYytjT3GEfFjfDPDKUN5F4i+ynU5LHRIxQi3KP1m+0Ytihlmw81A73qlqXry
	n+HSl5SAnRW7325uDHo8GZLsAmbcv+bY7gidPOa3lbDSQatkI6ULEPtNEX9xmPCU
	cwzhv6fBpnucPJeBupa2I8SP4q/a6owIq3+QnxU3u6GsdRs0Prb72Yup7MtsImYD
	4FYmyjY2lIkQzG5bhorLqHrzIvRcjJxDv2TkGCQPCDwyqaEflxKq8qVm+mJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736213037; x=1736299437; bh=cj1yEcjrht2vXFS1j9+K48OJrFI2/oFXAfI
	5TVuszRU=; b=ENlXZ8euSuZRWRNGxFYhXnwsWL0IOnvlQkwImhX0yyjNPB6oYjD
	Go0J1xddGVTLqE3TS9N/GagkhYlfzETzcN8NeuZ7qlpq4ReXE6NIqUdeBfzRojqu
	/NxBdJgDFe1swTf9MbEOJ4LDQWXKhzlDEJh/FWjhDyiEWXcg/DfXcIp2PV+41UJV
	h/UASQu3jXoFfr7QGf5+CU5LEAYaRjIt8yyBlgG6AGlAqBrUHyP5AhV6Le/n0r8A
	kunyn7TEKHuoPPmCRfOZsmgh7JmPBdgbjMPbZRxIRD6uFnrOANSq8tL+wv0WIYnU
	Mlrcp5DbKOk+bi03aeVnxmh1s/QBlKQaO8w==
X-ME-Sender: <xms:LYJ8Z2vkK8nRalVRqFkMMkrD_U07VFqL_jmeUy5EtlfxN7BiNg5mDA>
    <xme:LYJ8Z7d_grvs_oVBqgQ2zBbiBsfZGJOzmoDUCcFK-B4hq58liD5HuPYFqcdVs6PYI
    TNVhmCnDAuWvzeN_w>
X-ME-Received: <xmr:LYJ8ZxwjY3uhrxgcm6UkCpZkb3pqcjqcac_sxdX3MQJx4eOZsldkG2v6PMLqJe0BNZuSx3vwKWTmVt3vMt_1X6ZCucGbYzcfGhDr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeguddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlvghvrhgrihhphhhilhhiphhpvggslhgrihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LYJ8ZxOHdIVbqj8xvcoQYWRtttenSbQnTpxp--unlJ_WcTqp8rRgYA>
    <xmx:LYJ8Z29ZwL9qHWpt3LEJpGA0f8uOiPOTU9gHjQLmWpjQ1j5uj5BVfg>
    <xmx:LYJ8Z5VqeqrzjVEKALiOXhbZqLEaHLqL2e4yDlXgWbxfjeHM0KpBwA>
    <xmx:LYJ8Z_fQ2nvCtFB24BvSeWnu2o_6I2L7JYMWd2GtZoyEFVbZmmpPlQ>
    <xmx:LYJ8Z9m7zOaQisn8rGMQgF5L4xWfaGl02mywJmoEF5t1_AU_KRsl4c4i>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 20:23:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Philippe Blain <levraiphilippeblain@gmail.com>,
  "D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: Re: [PATCH v3] completion: repair config completion for Zsh
In-Reply-To: <pull.1860.v3.git.git.1736200026899.gitgitgadget@gmail.com>
	(D. Ben Knoble via GitGitGadget's message of "Mon, 06 Jan 2025
	21:47:06 +0000")
References: <pull.1860.v2.git.git.1736002073641.gitgitgadget@gmail.com>
	<pull.1860.v3.git.git.1736200026899.gitgitgadget@gmail.com>
Date: Mon, 06 Jan 2025 17:23:55 -0800
Message-ID: <xmqq4j2bwh5g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
>
> Commit 1e0ee4087e (completion: add and use
> __git_compute_first_level_config_vars_for_section, 2024-02-10) uses an
> indirect variable syntax that is only valid for Bash, but the Zsh
> completion code relies on the Bash completion code to function. Zsh
> ...
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> Acked-by: Philippe Blain <levraiphilippeblain@gmail.com>

Thanks, both.  Will queue.

