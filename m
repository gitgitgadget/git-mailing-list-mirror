Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE79390C9A
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 09:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306330; cv=none; b=n3HWFkfFdkA7veltP7IXLOgFtWfuSDOtZYFMQ0mUrJubfKFKb5PHzHeAsDfRoCchsLcdiao+Ty5rgse3CaxQhkfsy+NlVPOmbOjscyIYeSnlTINHjUVb9aXpZFkPCpjJJts8lGdnlsoDssB2OEyRwECetByGX/XiNAbmSEntLes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306330; c=relaxed/simple;
	bh=5wN77FPTsIIYnAAF4sOUoOqnUeJ1KhWttSieppf5lpE=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Vaq8vF85RFa1wpz8iqOfCfRES++V/X4kgP4uuTSP71sapFenwh66lSNVdQPTNi1NDM9eikOIlKoCP/4XJ8Ck+g45RGl0gXOhFwFyoJLyyz+lFI+Qt5PivtTrfkTmxXVj6/Yq3/ccKvqWN/YQE55weAnjcZsCVG2V6EGrmJKSSB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ia7ksS8s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IsUHo0Gd; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ia7ksS8s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IsUHo0Gd"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6C73D1400054;
	Mon,  1 Jun 2026 05:32:07 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 01 Jun 2026 05:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780306327;
	 x=1780392727; bh=Wn/Eh6HI58tkWBbMix6oiik987gsl7XBhjJdnJ3x9fk=; b=
	ia7ksS8sN5DiLHXWda8QP/KNVJ/C29Q7CBErqhu5PJy3AH66LeGpDuoBRT9Gli/p
	dJbRSxnj6AJmv6cEGeT4olgECzE226lqZeUdR0y0ORCGMUxmc1vR3pOYQR4LOtIr
	r0mK+FF9c3twnZlxobaxucGQscehoNQsv89qcA+ihVNi5K1JKWzr+/98YRUWrQRS
	fYGLTsoq2L9H5esYNyTUaRlcDjE05hHVBkaYnjJFZqc0FexqdAcVgYWz/MsafZ4N
	YvyG7ne2DGi9WTIMifTZ/uaUg8QvpNXvMSG7yJSpv6aBU1akhMxd/UbM9qbFN+Aa
	HZNNXeSU1gFfi5k0csL7wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780306327; x=1780392727; bh=W
	n/Eh6HI58tkWBbMix6oiik987gsl7XBhjJdnJ3x9fk=; b=IsUHo0Gdqw7WQy9bY
	MUFoJ9nHB7fZLPabnRv5ewbnxHeWN1uxRHWPPPv20dOJz0LG8Mb4kmOQgJpDMFhV
	1EmcQogV4NSFwgkIXEm5q9P4T9fQNJZKisLEfJEVT2nhiDtdyawyb/l+HeFBRwOK
	wJlvyBKoTLBSKA7qsGLsy08wYKtyTfPC9fDwNxDgv1lxNpuCYyG1PXSMd5W1ErWc
	hLVWXsBpHu+jW9Oz1JHxg9fLpGrNao7Eg01vfT06R3bJwaOOAD3zr9EgtmlZTiUT
	JFrpBEO3e+2ollQXG5fhcOjFkMoPwM2cH7hQSCDjbnQo0NZ8N7juaZjJuss3xZQW
	G7oWA==
X-ME-Sender: <xms:l1EdavYs3oErYVKP6lzHEKB-0RvnJsB8NE1QNecWws1YJ_6PwAz0TgA>
    <xme:l1EdapP8VIr70dnKDFuzMX5uQojHHsTiMouwph-nJeAWo7-ATVU_6Ngxg2JXagnuU
    n4L_V_K290hWvr9YaRqLajoZRhfdnswvXEDhPuijTYjL5xucyI>
X-ME-Proxy-Cause: dmFkZTFa2dxraGOOH5lyrxbu528VmYyRGtK1N7jbc8rF9LDKUyBRGT+XHKRKUP+lkSvv4q
    TpSdpBlfCrbKotOg3eMyTVewogh7J8xac00m6J5eTV+hoVeMgdVhVw4zp2SIvU/3F86B8t
    +AowiBr2mZAr1SPNAHZbjqSax9UGM6xV07yPpRgr3xfasY4AxcGwdrLBpv5DEg8RWiKJLt
    kl/xR1fgoSsHjyeVnAFQogzEIr3B/ZFWvBYx44zfDHA4my7Xsi4gnQx9ix+uxgOj+3jbiv
    /GZqFbL55SvA2ONdSUCnK10Ayfa1rIT/icTw2czqN4Ie1TGXg76Tsa9mKOfjug9UbujOrs
    lHU/cDVrsHg8zTNIL2Y7V9hU2SnZ6MQ7KfWgBlJ72/vv6kocb9cb9RzeXhvf4JSRcSmSnO
    EGa+Cx42NlKAvo6D7iJrf7DJ4Nm3NU4RGGpPNXtkkYj8/SJVfEgIRntMVM+6Tfg9gxm27m
    RRlOd8h0UkX56K8uJzkpY9/jKaD/pMwOg4A79qOmQSrx0ttW6jhvntIwDdUKArwDuNXE88
    mDbJ0nBEEfUgT/GEyHl8Il0BhW8QG5pNf3qLcQd+t4nqYHiNU07ibktWy5MNyUMUOUu32r
    b+qV0ZZAcPqlkZn1a/+n53TA5ED/KNOWOzIlnW126pbJw6X/b1oNX5wDY86w
X-ME-Proxy: <xmx:l1EdaqG9hVBOeN1sJU6IBah6PX-qY8bkIiuq2jytvw4vwPp1idpcow>
    <xmx:l1EdapSslgc2MdVN17nQfPv2Fjvx9aZWBHhRKct92T-C-nZMzjozTg>
    <xmx:l1EdarvwavSn1ZRBqqLU0ZyERn9Vn5mHGRjza530R4f70XSoZ5mebQ>
    <xmx:l1EdagxtzNkz9PBIfXQePgkeYcKhDhtJ1f5AwghGJO3REhhVi05N7A>
    <xmx:l1Edav-XE5VF6_yZIFK7hWqkHrGH48nFoOTnuYB06-GLHc8NzjS1nuCA>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0AB443020073; Mon,  1 Jun 2026 05:32:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AjWID8gagZ8N
Date: Mon, 01 Jun 2026 11:31:46 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Message-Id: <276a92ac-b2cb-4a89-96d0-9071ab6200be@app.fastmail.com>
In-Reply-To: <20260601-pks-deprecate-git-init-db-v1-2-ea3e6eebe674@pks.im>
References: <20260601-pks-deprecate-git-init-db-v1-0-ea3e6eebe674@pks.im>
 <20260601-pks-deprecate-git-init-db-v1-2-ea3e6eebe674@pks.im>
Subject: Re: [PATCH 2/2] builtin/init-db: deprecate alias for git-init(1)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Jun 1, 2026, at 09:56, Patrick Steinhardt wrote:
> The git-init-db(1) command was initially only initializing the object
> database of a Git repository. This has changed over time so that the
> command also initializes all the other data structures, which is why we
> have eventually introduced git-init(1) as a more aptly named replacement
> for it.
>
> This has all happened in 2007 already, and with 5c94f87e6b (use 'init'
> instead of 'init-db' for shipped docs and tools, 2007-01-12) we have
> also adapted all user-facing documentation to mention the replacement.
> It is thus safe to assume that (almost) nobody uses git-init-db(1)
> nowadays anymore.
>
> Deprecate the command in favor of git-init(1) and wire up the removal
> when compiling Git with breaking changes enabled.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>[snip]
> diff --git a/git.c b/git.c
> index a72394b599..6bf6a60360 100644
> --- a/git.c
> +++ b/git.c
> @@ -591,7 +591,9 @@ static struct cmd_struct commands[] = {
>  	{ "hook", cmd_hook, RUN_SETUP_GENTLY },
>  	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
>  	{ "init", cmd_init },
> +#ifndef WITH_BREAKING_CHANGES
>  	{ "init-db", cmd_init },

This can be marked as deprecated.

	{ "init-db", cmd_init, DEPRECATED },

> +#endif
>  	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP_GENTLY },
>  	{ "last-modified", cmd_last_modified, RUN_SETUP },
>  	{ "log", cmd_log, RUN_SETUP },
>[snip]
