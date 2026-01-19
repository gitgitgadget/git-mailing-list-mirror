Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776FA268690
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 06:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768804459; cv=none; b=j0FGpAk5/y0IU1S7U9zLyiFxDKWnKxWohGsRDnLy+Qq0xF5m6pe0eiGkV3JMiofmXEAmqkbj4U/wcZMkM2GrXMIProSHgP8mjK5x2am5ImAAy0IfO8xD49AiLcc4nOJoFdZhexsx/a16p/63GhYADmmC3ZPi4nzY2cKogFqcpXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768804459; c=relaxed/simple;
	bh=6Go/Gzlf2XqFfBgiMyc1unNjofxyMgGmrxVVERYhS0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhwFZpFWX/mgH0t9sOwoROU2yD4qOtIiIE9T1WwiOXiM1evGkJbhBikLI9wFjcw3dqtPsiukzEJwVs55xfL+JF7DLsN6iCtLS8vUhMW6M3UTM0srysclLQ+tIItnN0lRz7xkkJQOVY0Nf6H+FQ4Es48L/qv+S5rTPw6vSxONBME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F1S0FXsA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OcIqtidH; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F1S0FXsA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OcIqtidH"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B3A0BEC0900;
	Mon, 19 Jan 2026 01:34:17 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 19 Jan 2026 01:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768804457; x=1768890857; bh=N0ERCMul9f
	GSpdpTBTBc5Fl4UPb9QPHXejSq9GdjSf4=; b=F1S0FXsAQ3LtX5x/EWv5eTBOmh
	A+QqcvUfvLIY/j3zziiKQAuEKzbqWloaaVAYeu9Ox1/3qquYcIV0xaKUbI73MzG4
	fJ1Wt9ukUg2gPQyz7B97qA7U2H087T0/BWaF6RjkOYgR/geHwWeGhuksP8l8r46a
	mOv9jhwiS4RRMSdq0W3P1r3/NhmuJoBlt9WJIMvQcLBf+w7M3IGG0luIEqSqN7p+
	wlfbIYgv8rQnfABl3WZ0MkOvQTG/NlqtGwO3wYy0SWKFuGSFwnX+vSQjJL1WlDyA
	tMA9X8qXuXEcCyqYdoMPNZ6JvH05611rFJJVxkjmN0N4ibh0H3LJFZitMauA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768804457; x=1768890857; bh=N0ERCMul9fGSpdpTBTBc5Fl4UPb9QPHXejS
	q9GdjSf4=; b=OcIqtidHF3d5Hj/4KEN9AmXQDFhsHCgWIMGy4QfEe+Fhw+LtMAm
	wqujI0n9sDq4XaCLBb3ITyUrbiYQ+f6HDKZWknowflV57cX3YxmoYcyQBTEZSf7y
	ZthdJ6WTOcl1RV+NJcbkXDmgWlBw/mj99dxAq9fKwtD69XVdUG0ZWgFi6BfsWUGv
	a8EQ1FnFiZIQRFSoHjxurmt2M1gIMtGKcHdGQxFQf21G1L2na6UnTEbHhTi2IpB9
	g9Xv8FsHyhidGdpqmhV4YCCV8MNc4vtgLpyptfwkDAn4GA1gKbg0WycdcVJZZWpN
	Jxc6/irwyNIkEVnvWkQbaprae1LxuhJoOEw==
X-ME-Sender: <xms:adBtabQ7vxUZByU4__yh2E7W42oVxLwezyXjIDqPQ1g2IE05_-is5w>
    <xme:adBtaUMb0uVH2YnDWNpwWWx6FOLHu0pLLujDasw_yE9ptCM0jtNduCf8ci-i1DzK5
    7R6muvIFl7N6m2bRln7kyHD5YwdTof_lYLFpwDRuzkgmWeXJdWxww>
X-ME-Received: <xmr:adBtaePVNQ__vFbNr1whqSEG8kayI7PAuNrYbix41ZMJF0jZY_Bp4xzr-xGgPmu7GUw1qirf1JqnXJvfKocWOv7nMM_2hBRTnoVUy4cWrN4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeeikeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrghrrghlug
    hnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvght
X-ME-Proxy: <xmx:adBtaUuHJMjKVbP09nbniNw3bnhEEihae5NfA4iPBVHD17b5DmwuCw>
    <xmx:adBtaYV4oDZUXl0FBKFWbvXhW_JqplhMiMiueQ2sRDNledWpYYlGhg>
    <xmx:adBtactPyOklkZ2twTs6sUDD1v2g7cYE3NQjcH0QMxouk_7eVp4eoA>
    <xmx:adBtaUVl8Yh8BcQRA-mbvfyokQmlw0DDxOQrEJdipaazsPm6A0dmAw>
    <xmx:adBtae57HKzkGu-DG8vYaCCqxAd6rFx8ll3_Dz-9wOmbM6DPs_Zhs-ik>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 01:34:16 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3d86b457 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Jan 2026 06:34:16 +0000 (UTC)
Date: Mon, 19 Jan 2026 07:34:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH 4/4] remote: always allocate branch.push_tracking_ref
Message-ID: <aW3QZaYoPQvBkfvd@pks.im>
References: <20260119051858.GA1991308@coredump.intra.peff.net>
 <20260119052320.GD1991523@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119052320.GD1991523@coredump.intra.peff.net>

On Mon, Jan 19, 2026 at 12:23:20AM -0500, Jeff King wrote:
> diff --git a/remote.c b/remote.c
> index e191b0ff6e..3e9d9b3e1f 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1924,7 +1925,7 @@ static const char *branch_get_push_1(struct repository *repo,
>  		return tracking_for_push_dest(remote, branch->refname, err);
>  
>  	case PUSH_DEFAULT_UPSTREAM:
> -		return branch_get_upstream(branch, err);
> +		return xstrdup_or_null(branch_get_upstream(branch, err));
>  
>  	case PUSH_DEFAULT_UNSPECIFIED:
>  	case PUSH_DEFAULT_SIMPLE:

Makes sense. I was wondering whether you'd also change
`branch_get_push_1()` in a subsequent patch, so I'm happy to see this.

This whole series looks good to me, thanks!

Patrick
