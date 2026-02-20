Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073B933120A
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771604181; cv=none; b=DsE/JEC5AGLWCq28xQH+/aZytOVegtuEb10FHyeZMYawaIbuuJOCxF4fU7rOLmfRQ+7Q4yMgeQ7abzXii65b/3YfHxFQQqiM8KuyKlnuKHyYFAkS5CcMsDIS3PVEfUZl1mg9amoU0ypVEawdfkJGsWZxv4FofhPNenGC+7wrHB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771604181; c=relaxed/simple;
	bh=r3L1BS7eo+eZ0csKA+a27VmVCUGH+k8x8h+016kBlig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BlBM65aMw56gjt3R/uJJmUHXTSl2y5k66tcblk/Fja/ztkM+c+CL6z86voxAYbPbQZB/d0TVYv1uc0CLZi7bDzxjnyBICgrf8GaHMDsgCMS09I9/yCTOtLXX4ryhz+9CiNbO6rkPTD+puENCXCs3lW+FFL5uSl4NObqjwzG89/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cWu4IReZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RoY26Bpt; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cWu4IReZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RoY26Bpt"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 54E97EC0476;
	Fri, 20 Feb 2026 11:16:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 20 Feb 2026 11:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1771604179;
	 x=1771690579; bh=KWsAQBJ06QCIQ6oid7kW7pBfpIvuOl6VREqmMtJYZKs=; b=
	cWu4IReZQDKXFj7KSAzzenRK0LjDx5Fq+kbTgk/enHeL5YbSl4wmWxk0HfZqclpc
	bzs7ro246S/VzsaKUooy+OacL732UkBkrh7ZjBxfSBl9U7VY0QGnysFfyzvKEh5/
	Nu9Kj68kLYDsvZVdeCxydg8i9abrDtM6bElV/oCBgGoHZKYRPaAj9LL6Ga+e3HJ/
	l4lKO//GOwiMnCGsxN9Y89PlBh8XaaFb+Xa/5q9wa12/TRMFM6sz6KWVy5jqKksX
	QWjLzE8o9LksfutRKfLtyiuqik02n6atGURD1m/qfe7vkwc72RvRyKfGhqaeBfYj
	Ud2ytUEe1WM3ztj926E88Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771604179; x=
	1771690579; bh=KWsAQBJ06QCIQ6oid7kW7pBfpIvuOl6VREqmMtJYZKs=; b=R
	oY26BptffgOqMUXAJaVA5hyI1M3Mr4DKRSG7Ln3WSUSfoezPRvctpT76yL08/cot
	GCyrKIXWgYicHtqZxQj8BMxm/U9uCBiWTsz6vM4Ba1ZAP3cAA0iKRIp/+48PU+kJ
	VFXhIHPiFWPYq2pb8BNPIrT3eVg+ddvo4L9BSyk1uH0ZZiJ+7BUwwKVCO8GvueFx
	ykE2vyHUPwxS1xF0xDBiaTWhpjXyRdA2jPLumBFNGlKEYH8EsmJxAlh/oeodsEHb
	rFa+XVE6qHpZqwBM8YKUA4TQpmYWrY1ZIjHCllFnrKTRhpCuc4K/X4z+BimjpE23
	7rxdKdUiwi+n9YzxpZUbA==
X-ME-Sender: <xms:04iYaVIojQ319cAVVYNrp229YfId5_1Tb0NpIeRscor4yAxMn95ctg>
    <xme:04iYaYKXGkLCkb4sg6j74vntFauQoK0JBD4wiLel-ql6Bl08ZZpn3PymhBk48zDLu
    HJ2xrwBfa54Re7JHcwUWFAUHPd3VThF7doAzgWBUg3rz2QciExPTQ>
X-ME-Received: <xmr:04iYaStcM9-Y7fhpi2_Ok1_OmLkyns9O_qXTqZETRfqNOpMbLqLROG3-kaho5_HW2-3g3Ox4TULk0LcvBxM6LnFg_XQ6gR7tVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegskhhkrghrrggtrgihsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegt
    hhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:04iYaVTucEhWbMseKY9MzqSEuN53L3KtzyCdwWi7a_hPc2uKB5J-jg>
    <xmx:04iYaYMn5oigwtdDw2fFW4rxiYb_2z_7tzAQ7Ccz8bb7QjIEY7jWHw>
    <xmx:04iYaabS2GZCPQI1l1y4TIWld4ErHPNZOa75hHPSbgZ8ApbBbJOzyA>
    <xmx:04iYaSzohUR1lHPJQi3fy6U6DM2KUTUEKTmSuObnMSkmyVnf0K2UvQ>
    <xmx:04iYaSNGCIxBrAu8fv0nxxcfOSEuwNPn7Z2wutFCTTV5YhorAKHgpu2b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 11:16:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Burak Kaan =?utf-8?Q?Kara=C3=A7ay?= <bkkaracay@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com
Subject: Re: [GSOC PATCH v2 0/2] mailmap: reduce global state
In-Reply-To: <20260220060442.29469-1-bkkaracay@gmail.com> ("Burak Kaan
	=?utf-8?Q?Kara=C3=A7ay=22's?= message of "Fri, 20 Feb 2026 09:04:40 +0300")
References: <20260219125954.3539324-1-bkkaracay@gmail.com>
	<20260220060442.29469-1-bkkaracay@gmail.com>
Date: Fri, 20 Feb 2026 08:16:17 -0800
Message-ID: <xmqqtsvbz8z2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Burak Kaan Karaçay <bkkaracay@gmail.com> writes:

> This patch series aims to reduce the global variable dependency of the
> mailmap subsystem:
>
>   - Patch 1 eliminates the implicit 'the_repository' dependency in the
>     'read_mailmap' and 'read_mailmap_blob' functions by adding a
>     'struct repository' parameter.
>
>   - Patch 2 removes the 'git_mailmap_file' and 'git_mailmap_blob' global
>     variables, shifting to on-demand configuration reading via the config
>     set helpers and using local variables.
>     
> Changes in v2:
>   - Forward declare 'struct repository' in mailmap.h
>   - Fix whitespace problems

Thanks for a quick reroll.  Looking very good.

Will queue.
