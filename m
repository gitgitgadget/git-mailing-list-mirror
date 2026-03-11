Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5A23C873B
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224677; cv=none; b=STMuaLae5+SES9eJ4Ce8Iz+nR3ILtq9zBvCQa3lXg/xpIlqb8jh3CnE/Hk753A+KJ7eGTMBCeN7oRxseAS6PYu0XzvP0/7QZNTqgjoD8Kv2Q120eZmaZYCkt72uHqfCswVlzeRMR6+rpBcpMYlEPnGJo26RlxJwyNNC0RVvp4LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224677; c=relaxed/simple;
	bh=C3HpiwYL97wsQraOs2+PBFclyVO8+lD5SaUSmYrhJTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3NVeG6/88961DNeBUdKZZG174d5pupOnzpjotyCX+Ax7nGhWNSHU619hpIGrT/YUtYSJAROUuJ6qeqPA+35aeGpequB6IXH5fQWrnZwtpPdQJzJr/84L6obREU7+xltFQVLKtmPpnUUeWKPILf308gNpHgJ6qU/ftRxTCSKvYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G2NJOgu7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1K+l7miO; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G2NJOgu7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1K+l7miO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BCF177A01B1;
	Wed, 11 Mar 2026 06:24:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 11 Mar 2026 06:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773224674; x=1773311074; bh=1nXFEa4W/a
	Cjcy9kLa3/G22UsotcS+zLvwsKUEIaoFc=; b=G2NJOgu76raGHExsE60qOeEBpm
	o+PJHthGCvpTJjRqUb+utQYrKv0a9JgGMWk7ARmbY0Ub4WmaGD6bwEKML5gSsl1q
	fF6Dsb/sueLQ63EV/sarXZPk87ko4xPnELKlyLNubXUG+kJq7wtVeI6DuAjJwhx1
	Q+Q0U0+31E1SJYeO7MHfHnnXLt3Dp9pCxxR/bx82VFAY8mJC9NEjqqT9/JJ2OD2k
	x7xm559IwG4CNnAIrVKkTSsbpUgCk+3V1Z8ky/9rbSYD8jZWF17mLSF5X4vA0WtN
	L++uq6xLvH3TwzLs1K5queiYUqiQrg0N3A7874qcWGM0JZc2ZvJWFUmo1e3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773224674; x=1773311074; bh=1nXFEa4W/aCjcy9kLa3/G22UsotcS+zLvws
	KUEIaoFc=; b=1K+l7miOCY7qIFeCpxOm2/HjIYjLGSuw6jZUNa6LIEhlfnHpdj0
	u2QcUYjctNXSOKfqyGe0BpWVNeINryrQeMLlWJhP2BjM3qnYOcuoK3LccpgIbRPm
	lDzxsq9X7AnpgOfw5ahkx1ZnYjsPwNozJ/JeP3HGdDgSLS8L0/D6rdGPi6m6rwLH
	eSWWGkKRrcm9MLF47LBbi7uk9JWUI+cigwPsIGzQEp+3FD/SQRAC4Kh9GrR9J+Op
	rKtw6NS8SvpA/qBMm7L6IiLdKOTq/d9sPQ94QHcLyfZi+jTuXXMdXC9Jrld7WA1M
	vKAmvnLoJGSdKfYNh+79pgjZGAIrhlug8XQ==
X-ME-Sender: <xms:4kKxaa1JyJcJ74ct0oe2MUGdv2JnU-gV9NCAu9xR-EJaO9yv_vkgHA>
    <xme:4kKxaT-zIZ_q8XK9aQr5ntVeb9G-FHqJ7EJVx8UUYISumTcni7qv83zc6Wazbe5SG
    UsUc1hLF89rioXZnvUbARvJFdtC-xlBkr8volEraEWiGs5uBRQWww>
X-ME-Received: <xmr:4kKxabN-iosNzEYNG9kWA9NEooTNxnY27lBoZ12Xtw3KA1UoKA2dEuE_qlhrUEyqtCp64SWnIpbymfIEGmSTZ_sdeXr6zfEmOrxRKjB0ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeefieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthho
    ohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggs
    ohhrrgdrtghomh
X-ME-Proxy: <xmx:4kKxaXfucWT9rKLLv7DYqrIZLuZb98xHcJDkDkhWF4fOS4y5hzserA>
    <xmx:4kKxaaUvi13v6-CWQfNlEC15pNNzwLKbbapGcL0OxHqwTh6UJa3U-Q>
    <xmx:4kKxafjgKef18M2ju-7Fc3PrcV9R5N5Iy0bbV5ZzFOS8H9U-QZPW9Q>
    <xmx:4kKxaZ_hzNeR1t6pNQKBx2inkj0Ujaw6Q_9tPGKFa-ipQmzLnj916w>
    <xmx:4kKxaRySPQ9tMHAlJlEM_MVDyerpzdks8lXWq_fM5Mog0hgimxvx82bL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 06:24:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 89ccd1df (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Mar 2026 10:24:31 +0000 (UTC)
Date: Wed, 11 Mar 2026 11:24:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 03/10] hook: rename cb_data_free/alloc ->
 hook_data_free/alloc
Message-ID: <abFC3ToqvzCZ25h4@pks.im>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260309005416.2760030-4-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309005416.2760030-4-adrian.ratiu@collabora.com>

On Mon, Mar 09, 2026 at 02:54:09AM +0200, Adrian Ratiu wrote:
> diff --git a/hook.h b/hook.h
> index e949f5d488..e514c1b45b 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -43,8 +43,8 @@ struct hook {
>  	void *feed_pipe_cb_data;
>  };
>  
> -typedef void (*cb_data_free_fn)(void *data);
> -typedef void *(*cb_data_alloc_fn)(void *init_ctx);
> +typedef void (*hook_data_free_fn)(void *data);
> +typedef void *(*hook_data_alloc_fn)(void *init_ctx);
>  
>  struct run_hooks_opt
>  {

Ah, this here is also a small style issue that you may want to fix up in
the preceding patch. For structures, the curly brace goes on the same
line.

Patrick
