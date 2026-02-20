Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54531A9F90
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771604373; cv=none; b=qR3TZsRf55O5G4VES9VLN9NEH0n7AhLFiSbwG+xPPytl5jVtFlogvTckQ/Be1rnmIBEpGL/Oubj5unKoyuQCMX9lCEIzj9ipYxzQ0bTXlPUHbjCh+OfqNK/upzokwgQIGBSVprrtvw09lV8W+VTN+mV4Zqw3yQozv1kDn8hevAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771604373; c=relaxed/simple;
	bh=X60BYm2w0bBgt1JflMa5soCdGsHIRUwbY2cG2WhwxNk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eHNW/6EtB+9el4OUKXz6Yl5Iffevi96IF17WO19/p40XNR+XZ/jwWXJhPGdRrL12syT9mFdK1FX6l2aUCWVmWBavMkayBhqWmVgSF940YxT38ye4eAovlZOrxC0l5pJ1jXE6bCCbirIsMvGhnBlwy82XVFhPGYUDlt2iGX1uAvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bBI4qCyq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WIrtnXUH; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bBI4qCyq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WIrtnXUH"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 17369140019D;
	Fri, 20 Feb 2026 11:19:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 20 Feb 2026 11:19:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771604372; x=1771690772; bh=X60BYm2w0b
	Bgt1JflMa5soCdGsHIRUwbY2cG2WhwxNk=; b=bBI4qCyqOZtDvtwZpeh35QTQDz
	GIFK1dR5qGJhwaRZfCNVPrV7jh47qyLsXAEdSPp9wHT+/33Ib1heR035y4ls/tG6
	yOxoh81Ow8l58ZJw92nQf5+byQX+v9pIx6U4fKFNJHJg1h7qukca9cQmZ8RKoeqM
	wHIY7YpxcpFid0imXeGccb9G35Y4NskykJGIzguP1B7RkkgaI5Zd9cPrQqHpz+jA
	JhVcs6OwTS335Xfp49F0aE/ZrH9NsD6DcxGZeFNqJ6u4/Vs8kxGtMD2X8aSWr4tP
	BXkfG1Lm/GTrKCfkd79S0R+UVLssy3OVK/ySFQ5miJly/AeFOF6zaTz9VH3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771604372; x=1771690772; bh=X60BYm2w0bBgt1JflMa5soCdGsHIRUwbY2c
	G2WhwxNk=; b=WIrtnXUH29dV0q/Po0YiUnKCMMphoBZ/J9YfjcMP7F05kXsRa5Z
	Pi0EwJS790PkENbCC7XZy4qmvaLSTVPL5+ctZUBV5FpXno2Ds4H2EPYgq8y1liqM
	fobqwWVbW5NTM4tUwZ9GW+6O+wytoYrpdOknKBRTOngyeUCoux7McC9uHvQc6Tp0
	oULyAHhWYRrHqwXmhRYmPhtq6j65p5DibPriuzMC2GFzU7IBezt4WlEsTdTrMsFs
	OhLmLcMSG0OxsAhj3ouqLlEzRBWzQ3oz8BbYW+TOY9OPOZ7o76vstVFwQ0FQ4Y7G
	gHw9xgI+aHsSy1bpJwccb5M5kpGnFiWqVYg==
X-ME-Sender: <xms:k4mYaYABX4IzHFQg7wYtbKwNykMajdUpPEfNPVAnj9kM6131k2Isyg>
    <xme:k4mYaSQnlygbNiU2n4znulIfNP10DqPlVbI1FunwfKIQR4aW4lip9lAXeXGH2Ks6Q
    DFtZeksDj2i9wIrwRTj0CLK91Ty3FUYIJLkiSsOPo-ugORnJ4CSCw>
X-ME-Received: <xmr:k4mYaep9F81fURTv8ZoLOhpoRo7MLACoGkIkpEml0dYjyOQ13nZVimuVpMaej9ana_d7wDniaug_QlpwfuBPhvkQtyNk7c_lgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigf
    efkeevteevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepugigughtseguvghvrdhsnhgrrhhtrdhmvgdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:k4mYacxZangY11TOr0M72oxqAnkrEgme6M7yYUFb0LyCCcwm5i0oDw>
    <xmx:k4mYabKN2O-Voky2z6OW0fjTripU0eD2SZvEmaSUU-e_ehvKoWsT4Q>
    <xmx:k4mYaWIByQ3DXUA4fsWDLuduB9vKWdpac8EM_ymg2xffPgwi-X0anA>
    <xmx:k4mYaYuwFSbTVci4SdGDPjGxGinlvk-us9piV-2Az4-K9JJbQAXdNQ>
    <xmx:lImYaZ6o4_GWc1J_GozVnNkeVooeBMLB7gZblkGGUy3j-RQjfzt5mgGu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 11:19:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: David Timber <dxdt@dev.snart.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v1 0/1] send-email: add client certificate options
In-Reply-To: <20260220081717.555185-1-dxdt@dev.snart.me> (David Timber's
	message of "Fri, 20 Feb 2026 17:17:12 +0900")
References: <20260220081717.555185-1-dxdt@dev.snart.me>
Date: Fri, 20 Feb 2026 08:19:30 -0800
Message-ID: <xmqqpl5zz8tp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Timber <dxdt@dev.snart.me> writes:

> Additional doc touch up on configurations. No code change :)

Just to unconfuse me, this mention of "No code change" is relative to
https://lore.kernel.org/git/20260220075304.536514-1-dxdt@dev.snart.me/?

Thanks.
