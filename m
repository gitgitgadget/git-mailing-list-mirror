Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9681E1F2BA4
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761082622; cv=none; b=Ojc6KhbE1vgyk1NTIdiEBKjpLpkV7+xoD5QBAxHxkvLZxhoJgRZINWq5bcVLOQgHSCwi3PSHAEtZf50usgev0u3fZ04byMVx/BnPGOs43A8Nf+b/A9c5hQ90tsZPVM2rk485yGTubzeOwwFe4q6vtj0ubjtxyJSy9MfqeAGrH3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761082622; c=relaxed/simple;
	bh=QDGJzBGiZrdw33bN733HxR8jn0E//V+WsFU+Ypv/5vw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QgYrdB8sp+8GOK0T53xh0tNOadGvbA5Znrk4uByV8njKkgUAwK6krUUUCYVNoY/JUbBtmHRa1WrKAKbqEnH8E5oe2sAfOZ9a+PLr3ZA242lCcV5yMx+MP9VZLm4Y+ubuAUv5+msoIaZWxom5m3a+VeJ3+/Q+828zAlnHCXViGVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NLkLXNpf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sziTtpRZ; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NLkLXNpf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sziTtpRZ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AE4337A0098;
	Tue, 21 Oct 2025 17:36:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 21 Oct 2025 17:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1761082619;
	 x=1761169019; bh=owiUXZMjliyVWejH8sly6q5MAz/FZxdu+oAOQrZNIkM=; b=
	NLkLXNpf5FNNsbRPB6A/oNwhwpVpsudoMRtJ+60B0cIiII6hR9Ts4JRLShQryknY
	XUjzH/7nPa27QDMQwyNvK/ZlX9Dp18kEb8NPWsekWb61ygT+I3CkKJM0XQi9HXJj
	BrmFUPJkxESViyXhjLDdu9SQouGzJpo0PUb4DuYRZxzVFWj0vDypA/zEYgrP9vMt
	/8MaX9/Lo4z12BI+W/g0wRw9UEh+YbU7s/awqxDU0A4CmNvw/2wF5i5gMxWHyucY
	ZD+EcAABjSh1xAxo/S0mibua1mgEX9fQ5rjUN/dKFUGHJmA2yFDTeHwyR3goti6K
	v1vKDSrnuNXHYXYyaNmCMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761082619; x=
	1761169019; bh=owiUXZMjliyVWejH8sly6q5MAz/FZxdu+oAOQrZNIkM=; b=s
	ziTtpRZUHF7wG3fccVlmR6sPRZRJ1bwzvQSxqEVdpbATkr9lqhGRoMRehUrvGkH0
	Ov6BZjZDeUg48W3xrwjsSnkt3xOkS9JFJYsqzAOsSDu2lgoqxJUwHWhA/YsHGUPJ
	iOL2B5PIjuBj+yPvXL7gCKUooKmp1e1omzekrLRSawOgYIW5es10cLMIgsPf1CDw
	dGQ0Tz8bAxoQ6feKBgaspbh2MVY8Lv+53LzC+zVthxA6DXpdMhs5027gm0oQ9yyT
	kSExUrUBwqTLWmH61O8CnhhQBqPngE12lqCJjbOcA7pK9eEfGKij3KFEqyBKvOAo
	JQCGC+buQdf5Met69H3ag==
X-ME-Sender: <xms:-_z3aBHnB_JpEVtuFQRpucoiS4FADxUVv2bbZdxfrPKPeOfKNQJtSw>
    <xme:-_z3aNVo0UsAXuyAebqZ2ISeBhCcPRgfTeu1ertvQ3gPpDoTXA8V7UIVJ1vTq5LDC
    h8sH1s83G-f4VgXZFjWblk92zub8QdotnPyU2mDDCYqTqY7IyS1BnM>
X-ME-Received: <xmr:-_z3aIIOnzTitgnWgZY4FcWAvXsA3Il5noetsD21VaEVCUthOo1QZoo6g0jo2EHkIVq77cEVducI4GAZmM4nxNXiX21hdTOU2Ife>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedujeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhjuhhsthhosehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-_z3aF8HukNkV5SjOaR-Skg0ISRcNP2wMB8febwdIQ_LoYUwGuqnxw>
    <xmx:-_z3aDKzqdOLgjAlz0sgqKeVLZ0x3vsYKTQH9c_kxulv0c0EZnqNGg>
    <xmx:-_z3aCmG7nJ9AS0IfCaYLbxBrexLCvXARvnl7m4iWtUrC3byF2klbQ>
    <xmx:-_z3aPMIz_9WslNCl9ahDV4bVv_7LDPRa8xytvWplRN4D83gfvdN4w>
    <xmx:-_z3aCK8EUFIlCVGP_om-pFBFafwocGqe1TxV9wRWxv4YZKtYcR0fsur>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 17:36:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  =?utf-8?Q?Rub=C3=A9n?= Justo
 <rjusto@gmail.com>
Subject: Re: [PATCH] add-patch: fully document option P
In-Reply-To: <0188c766-d788-476d-a4d4-f95a6f59b31b@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Tue, 21 Oct 2025 20:02:53 +0200")
References: <0188c766-d788-476d-a4d4-f95a6f59b31b@web.de>
Date: Tue, 21 Oct 2025 14:36:58 -0700
Message-ID: <xmqq5xc8szr9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> Show option P in the prompt and explain it properly on a dedicated line
> in online help and documentation.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  Documentation/git-add.adoc |  1 +
>  add-patch.c                |  5 +++--
>  t/t3701-add-interactive.sh | 44 +++++++++++++++++++-------------------
>  3 files changed, 26 insertions(+), 24 deletions(-)

Nice.  I do not recall why we decided to hide "P" behind "p" like
this, but I think making it clear like this patch does does make
sense.
