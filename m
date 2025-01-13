Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6321622CA10
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736785822; cv=none; b=FyR6Bw6yXlPXt61I/DxDZ1aZDNwnSXme/wCSCKAE/17tA/fQJgaGrRsoHMX9Zt+1/FwAbIBDuSkTeg4k6EimhMyTV2Ft/KzfPTtbcptgE/3E9/cT6jBwFYacDMYzn14lHpl/uqM+wxNcuSSWFiYYYxLdn5DIJuarxTpirvO7hvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736785822; c=relaxed/simple;
	bh=y/27YSSo0GSRuY6jYx7clA1915mo39tPVIaX9bevj/Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mWVPpQN5Qo/ueGruKYG0+jh/mXbsIqjggEMnHPGqFBlG84xwu/jYngOVBJ7ye7lv3UegEzXULWHXDWjHFpx3iXMh6kroUk98v4HmxL4INJCaP0RWkUFDc6y4ofY+P1AppnlAyAT6GfGsRowcXAjUFXylHwCYJiMy1BDBVga5dMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sh0uAIgf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H+xRyPnc; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sh0uAIgf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H+xRyPnc"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 696EE25401AF;
	Mon, 13 Jan 2025 11:30:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 13 Jan 2025 11:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736785819; x=1736872219; bh=pq3FvLiEWF
	p1gse/JxY8QNLbqv7loeN2NX+NIvD567E=; b=sh0uAIgf5rOSTUusi74m76xQvL
	8lHt0FQxIq00PDz1Nd+8vRCvr77taXtajuBnwxF9P6zl55MXgQkRZ8vyuRSzPU3+
	0xbx5p4VSpGB2LVh2a4/Qzr+x8q7zDRaPKNQhQLP7jmeRULaxW3QMDFNL53Rb/17
	UD5aSNei9ONsZk93LjgtK2vKY+TtlGQtKPLrUeYzbLCgOVhtGbazixzOY1luDkjp
	ep2KV/m540YiXMd5lD9Nmy15AN5U6RLcz7jLqzhdJWwRgkW2gzQOQ6NKQSsiHSgo
	U0zU5EztLI2zzySzM/Hlw9PVe03ZYDwXVLStPx8ukntpUgKOLCTdp/PKYU1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736785819; x=1736872219; bh=pq3FvLiEWFp1gse/JxY8QNLbqv7loeN2NX+
	NIvD567E=; b=H+xRyPncze14L+67y34vebkzJuOiw23T6zyYGvdhBlb0vzwjYJT
	vm8gUmyos9DWbHLk+4TRNRkbE9RCJJarV+NjmWqKftECgaSQpNzEBrgsqbCJZeG/
	ikF5o8794y15N94SEqEtz+Jfq1ijJNBb9VaxI3PzeKD6lp14eK0Rs41UtZzTJshm
	irZbjZWtIVVRUUXSRfs9FxjFuHUfSXeSLwNd9+FVRiWGtFrztxeuSG8WTBiXYTZ/
	JZKL7J4duzbBU580VSF4K+sH04k7j7JP2r455BobPDCGXVzdwV4O5TquD/1eCZEV
	aUc9i0YjySQlSRTe3wVGDr0P2/lAzvTCY6g==
X-ME-Sender: <xms:mj-FZ-T5TEtEOrhdAszk70hrUlH_29zwP2p1SFpWbjv76Fwp0iSl1g>
    <xme:mj-FZzxab5ZDPLZObfBFeE1nIsvIDrklCcZF6QAwr4KE8Pb3cKidJYahV_x1OZSxb
    YCuaAr5_D1gjnWDqQ>
X-ME-Received: <xmr:mj-FZ72rK0fm3yXSDCs_PYhufw3iluHU1IFj7GUSFeWoFDybxU6tzB9cjIc0K49P838gH_zABywUgts2NPZPflW4pN3422BulxmL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhgtvgesfhgvrh
    guihhnrghnugihrdgtohhmpdhrtghpthhtoheplhhishhtsegvfihorhhmrdguvgdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrih
    hlsegvfihorhhmrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mz-FZ6BZAwfh9pTbp8PvutLx5gD8kg7JCn1Emx_WKrD_6xebVW02ng>
    <xmx:mz-FZ3ittppnmm6K4qS-62QqjfueZqxRVe0B_LAgXpUwz5tSGzeVWw>
    <xmx:mz-FZ2pIKHuSZ5Y4ADpMqT00H3_LAYqj-reHDMy_2h7yZVk48Z4Ojg>
    <xmx:mz-FZ6iii8F5d4BLhpOaJNq_t6STQ_lEnRn1ayea5Vmz7uj8ZQ7TyQ>
    <xmx:mz-FZ9aYDaX14pekzFlYOilQoPJUW1Oi05r7xWt7QHCenlpaYzCSLV5T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 11:30:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>
Cc: "Christian Hesse" <list@eworm.de>,  "Git Mailing List"
 <git@vger.kernel.org>,  "Christian Hesse" <mail@eworm.de>
Subject: Re: fatal: Not a valid object name HEAD
In-Reply-To: <D705QOX6EFH7.14GKFWVVUQWH7@ferdinandy.com> (Bence Ferdinandy's
	message of "Sun, 12 Jan 2025 15:17:36 +0100")
References: <20250111202628.0e5894e4@leda.eworm.net>
	<D705QOX6EFH7.14GKFWVVUQWH7@ferdinandy.com>
Date: Mon, 13 Jan 2025 08:30:17 -0800
Message-ID: <xmqq5xmibrs6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Bence Ferdinandy" <bence@ferdinandy.com> writes:

> I think the correct way to handle this would be to check if the remote has
> `mirror=true` set, and if we're running in a bare repository we should overwrite
> HEAD and if it's not a mirror we should instead set up
> `refs/remotes/nonmirrorremote/HEAD`. (I think a remote can be a mirror without
> the repository being bare, I'm not sure.)

A non-bare repository can technically be a mirror but such a thing
is only useful when (1) it never fetches from anywhere afterwards,
(2) it stays on a branch that never changes by convention, or (3) it
stays on a detached HEAD.  Otherwise "git fetch" in it would almost
always fail.

Practically (1) and (2) are not all that useful---such a static
checkout does not even have to be a Git repository but a tarball
extract.  If you overwrite HEAD upon fetch, you will render the last
remaining useful usage, (3), also useless.

Thanks.

