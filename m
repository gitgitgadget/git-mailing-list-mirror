Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3A71A9B4C
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 13:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748870636; cv=none; b=s0yMdojI7f4OlwzBWQMZSECXruuzkg3cTZkGeLvhbL6Q0NVn3VB+1uRoUIw/x/hHYcMXK2cunpuSj5XXT9dcGtYeMT77cXqOxk8avQ85QaYPFKEaYsdsUe38Mzh2Dzz1P0TbLEoaWvCxzc12g6FubxdWDthluztinccvJjnifHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748870636; c=relaxed/simple;
	bh=21X9sshxvOiEiJj3fqc8gjuOc1j3Sj66UtoMKpIBk4E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qhGY5e67jILtGio39LnTZFvRuGx5Sn8R5fntS4ukvIqXoXrS38GiCn46yjx22VFuiot+OlBgRShnmuNMYxWtuJZOAS5HHv7kHiINdVFzC2CFL3foIJ4mPiGEuftiAl/YVtbBi8fD3vTfbidUxJ8LJk2CnjAfWKzT7mg+zAGUmPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=nabI4n+L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n5u+ToGL; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="nabI4n+L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n5u+ToGL"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id D965D1380315;
	Mon,  2 Jun 2025 09:23:53 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 02 Jun 2025 09:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748870633;
	 x=1748957033; bh=21X9sshxvOiEiJj3fqc8gjuOc1j3Sj66UtoMKpIBk4E=; b=
	nabI4n+LkCQGuPAAt3Nna3ilZ1q3yv69jm2/xWHPVJ+3rCMJzBL8LgdwaFcO8waM
	Wi1ZVlJDU8aFFhuc+aiWUR4/eAMPwx6hCAgoVIz2fwjeIVJU6hoqfSsUJ6aA1hra
	ilVW0eZkO5lztlZHoybwAmk7tH3RH1LAgZa61im2okTOph1krZXoWoX+RY/8W94O
	QBSbpBUESgxrXF6r1bdYhlby29TMOYLG4tJZowEJhKWoFhWOsONFU4qj2H8e4ZPE
	XoTeExa13lTYVub9KhaYL9eB3oVTtMk1WbD8s7ypMooLcIiEKbL+DRWvbWxQA4Fn
	weXAZLvkphIJoQytoMDOoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748870633; x=
	1748957033; bh=21X9sshxvOiEiJj3fqc8gjuOc1j3Sj66UtoMKpIBk4E=; b=n
	5u+ToGLdWdowURzXKAu6alE1U0nBqs6N96i4m0+CjLQfagzzjSVG2//RAjIex50B
	pdKM0uWRb/NkdnlZAwnUFSL2xualZwokD3oz420f8v5/WLO+h7cAR3PI/jrEA0VV
	xBMsx7YRfepJ2QlrpIkJ9mOmtPiK4zQk+x6jEIsHGNsTw5p8Qo/OmFkoI+WIi+A4
	kCkwDeS0rC4rReMucMJbYrEeC34ChjA9dZzirReZW0T59VLgptEdTDWeg+H7MHP9
	zkY6N+2Snw4M2UF2bfclKX26W/jPayTzdw8wkVRJ/KFaaLUB3KGb5bkLxoDv3NNC
	j/Ox1/LT6Xn6TQQ13vEtw==
X-ME-Sender: <xms:6aU9aKHvKt9Cn_hKRWImQf-eFHNsva4nNzxdQHxREwKyMmTuztYQ7eQ>
    <xme:6aU9aLXJ9GZHyMzObV7vuFZQYr-hIfQMjHZ0aIUbiUJs7_LwTDrkfiQs94PqIokBV
    LkvKCyTpHCfzUbyDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjeejkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruh
    hgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefhuedtuedttdeigfdvge
    etkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpd
    hrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:6aU9aELYrqNtpYuUuwAxsokcAtjZNdwAuSk1S8QB0vKR-Zs7hhjVHw>
    <xmx:6aU9aEHMeKWphxqEh-axyrLaqU-26Hv7PxL5cY-JFnqAqg0UG0I3oQ>
    <xmx:6aU9aAUiIeLntZLqXVpINkjw9LK4_bTh7knUAtchx4tbJqVTkDsHHQ>
    <xmx:6aU9aHOWLkD-EDd8Dap3Oh0F18NbmAl8hsnhOXcSmhADPSMWGcWvAA>
    <xmx:6aU9aD3uxwn2fdtVQXwKDClQx1Lwg6_IOJLXMNpzpGsj0OFq1wHjafuA>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3A9081EA0061; Mon,  2 Jun 2025 09:23:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T0396c6d2c772a474
Date: Mon, 02 Jun 2025 15:23:32 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Seyi Kuforiji" <kuforiji98@gmail.com>, git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Message-Id: <5f1e600a-5fc2-4bbf-a7b0-a126ac849607@app.fastmail.com>
In-Reply-To: <20250602122559.208780-2-kuforiji98@gmail.com>
References: <20250602122559.208780-1-kuforiji98@gmail.com>
 <20250602122559.208780-2-kuforiji98@gmail.com>
Subject: Re: [PATCH v3 01/10] t/unit-tests: implement clar specific reftable test
 helper functions
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Jun 2, 2025, at 14:25, Seyi Kuforiji wrote:
> Helper functions defined in `t/unit-tests/lib-reftable.{c,h}` are
> required for the reftable-related test files to run. In the current
> implementation these functions are designed to conform with our
> homegrown unit-testing structure. So in other to convert the reftable

nit: s/in other/in order/

> test files, there is need for a clar specific implementation of these
> helper functions.
