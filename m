Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D13F44C64B
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554268; cv=none; b=kmEJ1LKHH9eAJdPz5UZguBGfIAP+W6w5viQDHbCoe237LcF2/2UdJgzKH08FjDiZczPpyeUpJQ54tfATdo4kMhrtnB3+ZAOcpcCUWW5JUICUR7JpiwYR9jhdR4XbcAgL+9EzFcZ3nC2JYIairuolq/OBWOj8iBdp+dfA8GM6D5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554268; c=relaxed/simple;
	bh=kIAI2vgKwxQmlXfxE6HQBFWlT7YD+ptJI9qxcrW6CKQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oRAudutmNf9sqkFyRtun4I38V/zcM1G8A/n11hmk9rJli59NsxC2RGm80Yt+cuPlbK+qCdxjZ98iJcizt9cI3PBJTCWVXboHswocbUOPACk3H7/8SD4lXeueNxQEu8eBVso5x6D+tlG0yf4mc9OIpTXuZAvBVwrREipkP4tyfI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dnz6UUK3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bW3Coe48; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dnz6UUK3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bW3Coe48"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4C8C214000B8;
	Wed, 12 Aug 2026 13:04:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 12 Aug 2026 13:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786554266;
	 x=1786640666; bh=J+gGuzM90vbGxMGJXXdkwTSmXb65sccs0xiUpKJ9rg0=; b=
	dnz6UUK3rAYXomg+pz8CAVVwd9db1YohGPknUr4h1+guXtdfLkvINUpUmbLox0Ie
	R2X7i6e2QMz9IaKst/+3SHCNmaGJIyWz4JrqnFhAHtaBsMsdKhNs7AcKKoHGJOqm
	HT7jPPcnnJmjJsP7SktnWDZzEEFfxUIG+JEpkT4Axzdncn6km1FDDjDv8DIokaQm
	lL5xeeWOtBQQfuu2U5WBGAooiKqIQmJLBpglF87mYa3w7/gKnb/HfE3b6rYdqMXq
	1iSL48+jHbLY55uOWQdJkuZGn6fHFzHJ4Sl/AB2oTMXjDgCx3kOdlDU82psyuNus
	QUBQrO8tjsTHNE1VIRRlww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786554266; x=
	1786640666; bh=J+gGuzM90vbGxMGJXXdkwTSmXb65sccs0xiUpKJ9rg0=; b=b
	W3Coe48a2WxvyA2aYhFjWMjaSAr9zySVY9X2+nZfbyTEsmfKkhUAykP9QqZu2IQI
	kIyrZ0hX/Tafwl9TiGEfkQDkqdvov4yXxGi1R67uQ2DlN81Kd4zPcWAp75UsOsmA
	LUxnD7df9gm0XoM5W56Alf4T66ACcCvSchctmD5sp1b7cZVZOlhx6qKHyz/vUO6R
	GAd07FVPv87v55W9/o5jc9L9t4N7YBVMX4jCGRD9uRsFuAMduXGPxKRAL0zHFjYA
	qQrihalJYFYrnai4Fhn22J2nZ/dNCtcRse/cmisKaT3NNEzwUo8ZWNHoik1GI7ru
	g+Qe5onp1lSLdXbbdbNjA==
X-ME-Sender: <xms:mqd8aunPdpLFgCqjyhMLlhN2RM3IrtP23ksyx7J_rrNccjI7nakE6g>
    <xme:mqd8as2cXDe_JXkua70GCzvhxi4jnaVw4wmeTmGKb5L080QhdhyMnc2_5IvmLLnU9
    XCm106qykfNZr-Zt-gxKYTzpKVJX00RZSbFoAjJXUBUhk1mncXhzHM>
X-ME-Received: <xmr:mqd8ahr_NIjhmuuenPc0bPVxZ4U-1A5RnCo5zF-9IuvVq5n8o7futN4oAPb22mps0BVz910lhsP-4f6em6-6p2p6FyzU3Foa1A>
X-ME-Proxy-Cause: dmFkZTGDPFaVVpBQs0ddUW2V64SbCqdNRV5aZA5shFGYoJ5VCm+O35J2s0EJ3jACMhClHD
    cOLFNWZXe28VTqzI/pR4qrxyGQt+g6qp/bXMxPmZytgCfj09XeMRzjMa+K1PhwQadmhWPI
    Wp9/QtlICClsq4nS4Q23Q91Yh3H8JfpUs+1das7ZqYThyMLQwvLGT8nXxsaTXQz+swWYoc
    LriDZ659OnnRLMttbzcuQiahsoUF77B4hPmv8SYwOo6xhqHoaQeDPndpxKu0ijy3BYbGLw
    iqUBYNscFeSaZF/5DpzFfsQP/r0U5fvc9bDR3i8Nrbt9sWwg8V+QhdWjUd0/zM0bRIWrCW
    Kr3yxnXhjQTi09uXT+BS+qsCqvsL38f7pjxkYeLNvSmC8zun90IDX7j1LasSHIvi8nPQIe
    pGSWm5odwr9MEXIUAFgyOjvOkuDuAk4qG4oI5EzMjWx8kXQ0hPK4NKJcTtg9V8WhxCHMYO
    n3BT2TtE6MwaGzC1Gi0hYanekh6xI7i5Rjw51tixXof5rdeX4GWD2YPNXVt7mFYieEb/Ot
    ZzXY7ERjHxM7g6RshMObcMUTb8aSztyj57cAxFuc3gUs974gpGGH8gBqupgB0vwjlytnCw
    sBIoAXO8g24aKYdsO2ydlaQRhVpH4IESaUcmU64cDmakE+PbLFut4mjS9afw
X-ME-Proxy: <xmx:mqd8ahcI2iwQMusVtSPJq4kBTq8S0EW6jQRDpiMQP_xakeIJ5G-9fQ>
    <xmx:mqd8aopRjxBFYqJooEMx_Hjf0i3j47SJbCESnO-Lpo6-vI38lfzcWA>
    <xmx:mqd8aqEBFvYlZ-sP8p2axW7EPbKCiwPmA0gqJyV2iUudy_CFGTNuUg>
    <xmx:mqd8agtrLDNgMxsMFYFbo8tzcfWpoo_N8QSOYbnEa2y5QFhWhVH64Q>
    <xmx:mqd8atJJCvQSRR1kZq2x6Q8mR3TVjUpg9NTYjNKpnQEEDnZIjZJQdEmp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 13:04:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Marcel =?utf-8?Q?Svitalsk=C3=BD?= <marcel.svitalsky@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
  git@vger.kernel.org
Subject: Re: Bugreport
In-Reply-To: <f4e39b04-b6dd-4b83-9103-8a1c98019dce@gmail.com> ("Marcel
	=?utf-8?Q?Svitalsk=C3=BD=22's?= message of "Wed, 12 Aug 2026 14:59:52
 +0200")
References: <a7899757-9c3d-4735-b7ab-469808707e61@gmail.com>
	<8fe70f89-89a8-426f-bab9-21284722c58d@app.fastmail.com>
	<f4e39b04-b6dd-4b83-9103-8a1c98019dce@gmail.com>
Date: Wed, 12 Aug 2026 10:04:24 -0700
Message-ID: <xmqqik5fxobr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Marcel Svitalský <marcel.svitalsky@gmail.com> writes:

> I see, thank you. Is this a new feature? I've been using this command 
> for years
> and today is the first time I am seeing this. Also, is there another 
> flag instead of
> `--all` that would just include the actual commits only?

--branches
--tags
--remotes

