Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950D01DD525
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754413002; cv=none; b=Bu5YJh1clotj7GD/mfhClzUAqjnVX6S7nP1W4ZrPJWqZmz4kwdpdtb0xh4usXe7WIXtOG5NCquZSK0Ev4QcV7ITuoi4y8ZLh7TNwjco42whMQ6uIJOGGDSAhakE4P4phScJg6wOW5HsjY2i5cr7yEvvJmowrU+7acDXNXcOW78I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754413002; c=relaxed/simple;
	bh=Vc969tfXQFsPegENb1ecRUBtcpciM7IqTwN4QkmoXZs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XK5Go6W8XIiJ7r9my4jVrhyop0pPlH0LYlQON9fzRA2Ccg+XIEzhcftXxwDP0ViXY/uvVNVM3+8aTt5lDTXopxYOpXsmyYrwYkZcV9RVmm+E5w+108d5fGRcw8JcvyMVK7pEN687Qheau6gxUdVNVhHubStTCKjO5+tm0ggd5Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JYeS/6Xq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R5OBKf5G; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JYeS/6Xq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R5OBKf5G"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 9A2BB1D00038;
	Tue,  5 Aug 2025 12:56:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 05 Aug 2025 12:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754412999;
	 x=1754499399; bh=dQQjA79u8z4LetoUVIqHMmOt4AcG4EIl/ABG6EHm9Oo=; b=
	JYeS/6Xq7mJ/8RsokKeSjRxhpAcNK7Bei76ohClLvRvk2XCyOqwlkjG2RTXKz15H
	N2bngNtmsn3vSS/CPSWOwLwwqF+2YGXaNUKuOdlGLfrExeGVhUMdwBABCPGp3DS/
	YaHcin0WJltBcS0eDO1txgskDE1QSQLnWsUy5nf+YusI6xJ9pzpekAx+vxa6nQBS
	mUgqpnb0pzKPGE0F5BmWsfZW4g7w0E+3ZTWb0RbMHfXVwAVIRHl7D1Rai0eTQUtK
	IqFdknYbqAmaCv0IA9+hL2HgYP60b2X9Euaf8EzjU5uYHP8MhMwijbzxcNsUHWL7
	G92gBWZJEDQWdUUFiJcR1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754412999; x=
	1754499399; bh=dQQjA79u8z4LetoUVIqHMmOt4AcG4EIl/ABG6EHm9Oo=; b=R
	5OBKf5GCPU/wwTIYfZHuFMNIPgCqfZCEPyFwv8RXN65a3RXvdlnn9WRLn3sW+RxY
	CPvXIwXYfzIa7m6Y8azFbP3EzcR2+ksvc+3x0aAk75dGgr4M9/qoMvJWFaDo0kzg
	EiaJ0JFjU24vUAE4K49Y8/AN+MlG2+i06OJgm0bxePDWAi9PCM6BLsXNS9SERhAg
	IHy1LRA09M2u5A+xNJlI6GbABSOY6RMnEL/D4XQJN1MSrQMjIzBfTw7Jo9Zn+d1Y
	u6+yMAmisQORfjJSDEjbq/hhIr0YTSSSIb+FvEmH8d/VtKYrKfAH/UEDNGzn5a3d
	ldeBDSI/hhgSj6Zuak3VQ==
X-ME-Sender: <xms:xzeSaBQ5tz_HVyOKIUkyld7LEdJH0PIh1OPQxp7syS_qidLx3CGLmA>
    <xme:xzeSaFVTpSInDZQV2E51iWsl5Ko8FzWZevas2ZHsxfTGty9F9JjKUF1kONuDLab9p
    YfuRYIvDfpabM2QRw>
X-ME-Received: <xmr:xzeSaDbnvqqmMLTWLQ4jdWLfCkVaUq-5irIwR0KOr7Us5uZfR4KnfVrvtQI1VPBOPLw6-H7BOIQRR-MsIlFs4hWXaIbXHYk4Q_ZEwPs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:xzeSaL0rDN7TXUkEeEiGuTrk-oamE5TT97ZMD6ylrnpU0Xo3aelGeg>
    <xmx:xzeSaFi7TAGhrxW-WgDMU5c2F8P0Ry2Z8DqLiPaZ6kY5KiceOCXOUQ>
    <xmx:xzeSaPbnBwvEKz9XQgJKLsdl-zLqm1WYtCXmTEYH2ysoaVx-59ThuQ>
    <xmx:xzeSaFSuuRIJQIpaUYb2VngO40eB8YHIrx9lcPXKSEZlmt_HVYvoaw>
    <xmx:xzeSaAj8XQDy0FUlm0ElCpLyOdfkbgGDieN2tWiov2OLYT_89fsWiys3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 12:56:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH 0/6] Introduce more doc linting
In-Reply-To: <pull.1945.git.1754399033.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
	Avila via GitGitGadget"'s message of "Tue, 05 Aug 2025 13:03:47
	+0000")
References: <pull.1945.git.1754399033.gitgitgadget@gmail.com>
Date: Tue, 05 Aug 2025 09:56:37 -0700
Message-ID: <xmqqfre51zcq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Reviewing the documentation part of the last patches, it turns out that the
> majority of my comments are related to the latest documentation guidelines
> which are both easy to forget and almost trivial to automatically check.

Thanks.  Automation is very much appreciated.  These updated
documentation pages will also help as examples when reviewing
others' patches.

Will queue.
