Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DAA328B61
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 21:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771536129; cv=none; b=iAmaseNUOXPmJLUTiBxSJiBKu9Cghc4ei3O3rALnjaWsbq2hswmUkPvmtV8VXwwDVdU/AtT+c2OGjWX/Z+qDCTmefdcw48DqxVdtHaTxBHpXqieAv8tZ85774XmVBbTTm4tojQvA3eldLW0J7vPaiyqPy9CA2t9DfaN6VJwEZvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771536129; c=relaxed/simple;
	bh=YPpwTehyibAkmfuhf7ZZo/+TINgz7qLUZdmSrqONe8s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RH3ObIA6Pah+p37Omf73FxFCfeDvuyA/ZEGyRVYSAjfMMp1/iUcRcKx6LjCXA8jVVJuo8XyzIJEVoHo3CzdvKxRveBvN0c7dV+8LAuI1B0Wsf4FjCw+vmz3lPELOSC/gj1hiCkMZLmN1DlDFxXdSWE3BNIX5siYvbmYLHVf2TKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=2V3GGjO9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mPLoeTnS; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="2V3GGjO9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mPLoeTnS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5EE22EC00BB;
	Thu, 19 Feb 2026 16:22:07 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 19 Feb 2026 16:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1771536127;
	 x=1771622527; bh=YKu324ea7vAaieMZGv8aa4cstuzexpqaOSWdwZJ2/Gk=; b=
	2V3GGjO9s3+FQs2g77yUKjz/+HWFlh85beanXiJy6cHvc43uiN3ai8M4KLVsBPrx
	YDwbAOuCekR0M6kdY/oxo0M0gf6tRhbv/7zwGXKw6AG/WP9HnyQmpU2dp2LGKF+H
	HnQwh7tYFxRdwydt+5srv8lnEEO53IOlXCA/eXIwxzUewbJLZumWmuRvy6SntRYn
	MHsTgvbLUtGQ5WAvigVb3HV/GrZIXOx8hq7vqrt/Zzh+zRQIhFQ2KQ7Uhl+9zl6G
	lfmeoW8kAP2KV7c4d0crlIrprZSmW3nugNSpZ5SQX79Ttf9lw9uDLp1NJobBaAU5
	+i5EjCTRNxx6eDZWuaxtAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771536127; x=
	1771622527; bh=YKu324ea7vAaieMZGv8aa4cstuzexpqaOSWdwZJ2/Gk=; b=m
	PLoeTnSgNzhnEYllGQLdez6XijLm1YG7xU4Cz0Diq+gxeH6KIGKGSnud0E7DtY2R
	ao8yYlILZZBR9PDyJ8Sc3xUfRVhhRgD7ri465gFSG+EYjzj4DKvlydX9iXCeKoTu
	PjeDlr/mNd13MB1wQocwpl6fJhwi9e2KrIeovWXe2e5H4UekNGypdI/Vl//zHLIi
	pAmXfMQXBW5MwieKNLCQV+qyJrcsVTy3cRgCID77PJJWA7lXA4PyDV07sJMXVLTx
	qpU663Mt+DmuRpaKvxY4TAVS4jVd5b3QMKGYlqChC/VeBBIHXww7TUsE9AFKiECI
	Oj/z8GIuMpbz/bZ5GJYug==
X-ME-Sender: <xms:_36XaXWZyElh3nriPgv_F8p9Qm6y9UbNBa3Zjx6yvUd1tmHdc2y3LQ>
    <xme:_36XaWdbUa0LJPo3CXsN3a6QHV_xu94otk9SzzT2_ir8Ha1lGhivYrUUM9LL94p3Z
    DhtsQ6a3HW5wlM8u9C55d02QMrxnrwDx87xdN_Kz6zzVsqvVCAmmg>
X-ME-Received: <xmr:_36XabsHyRty071EtHzczm9FneotQ41a5YkG3J4p1Z3PDwAC8TAhEs6tZ7XjiiGrQHGLPGD2y04el6ncBiOouVtoK8VAg2uv-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeiiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegskhhkrghrrggtrgihsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegt
    hhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_36Xad92j0HgacCO_p7xHlWeFgRxCjcPlgsHnL633iyC-zOD_BLuoA>
    <xmx:_36Xae2zi_vemv7egUTUbCSRLcXrn-E-HLdRO5t6GlXet1numM_YhQ>
    <xmx:_36XaaDjmgbmmaCb8gSX_z9C2_gLz153hk1BrmymIooP3O1NOASKbw>
    <xmx:_36XaSfzLea7bd4hOUcJjXeXzwb6ZXKDd9CypVFFe1Usj4S8Q38vcA>
    <xmx:_36XadOF1J3M1R3yR5XgwRx1eSogQzBsRB1mTW7ALUFkMxNWhrBPNK5c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 16:22:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Burak Kaan =?utf-8?Q?Kara=C3=A7ay?= <bkkaracay@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im
Subject: Re: [GSOC PATCH 0/2] mailmap: reduce global state
In-Reply-To: <20260219125954.3539324-1-bkkaracay@gmail.com> ("Burak Kaan
	=?utf-8?Q?Kara=C3=A7ay=22's?= message of "Thu, 19 Feb 2026 15:59:52 +0300")
References: <20260219125954.3539324-1-bkkaracay@gmail.com>
Date: Thu, 19 Feb 2026 13:22:05 -0800
Message-ID: <xmqqh5rc2zuq.fsf@gitster.g>
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

These are surprisingly simple and straight-forward, as the final
destination has nothing to do with any global, and not even part of
a long-lived structure like "repo", but just a simple string_list
mailmap.  Nicely done.

Will queue.
