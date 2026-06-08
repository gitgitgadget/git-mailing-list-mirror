Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620BB3876C1
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 07:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780902139; cv=none; b=fxiIMVwsNklT1E5FcXHjgu3LRnswdlofgN6YX9dSTD6ztiuhL7YRQfvbihjMaejolZiC9JApcQrRV27R7IJ6mPwb9dLTHk6PZjHxHKIVax816e+4sZEScqO4TDGGVkHg2WUg8YUJmFjJHp3y3goF7H9pUeiI+WfV0We8JFylRYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780902139; c=relaxed/simple;
	bh=kBpbwuiAXSC6NxXl+XTVKfwboyfkM+dXySOmE7JfEbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kw3iGFA/7CHHbTR7Gi3pWmcxsDzBhr7ANrHziy63KdIw/MGOc/V853rLqCxm+7Niw0X5DCwd+Xnf2hydT6Z4UwRsrgelcNTcntfLcOFBzCUYSpznNxW1CYbxt7EAC6vxbNJleAYiR0QJsJ/2cKyNTQT+yImXZ0Fauwmib6wTlVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lVGROeu6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d2Lp5p7t; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lVGROeu6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d2Lp5p7t"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id ABBC01D00052;
	Mon,  8 Jun 2026 03:02:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 08 Jun 2026 03:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780902137; x=1780988537; bh=g+YBs4eZJj
	d+YU+efIILl5QtsrsFekwUyTVk9Zg989Q=; b=lVGROeu6Mrpw3tadLtbzpYoSEW
	lHit7Yvjl9L2LjxaLRrjJdaMaqpHGd+d3DUjjLn67UdNqNNBHy9lidRHi2TkERml
	N1MAXM2GBinrrNGXyEHLr9XnUiduKq6Q5+djRyqtm2v/aZVMnr0ZgwOebJWyZnBz
	HuJXaHVFhB3I1BZup0YsrtUf9t6nQ/jGbxiEX+2a1mHVpGPN3MdRL+jvgFAwdtf1
	q1VKoNAAJzA3TaFb343PrvfnbHkZ8s1oWlM9cAW3Wc6GGNmbbFtDjYvH/aXf6Y2+
	h/1Zt4ZQT2/SWXwASEk0rlOp7+pAkcxP3Q6Grys4yJKLmVSKzNhSjsQs4A8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780902137; x=1780988537; bh=g+YBs4eZJjd+YU+efIILl5QtsrsFekwUyTV
	k9Zg989Q=; b=d2Lp5p7tnqs5AL482yCvaFCplyYtgOGCi1zjw4brPNaKGfro6My
	Q+VCJrtvfhmLoPCb6ZJOAVqCuHnIIqUsXaasBAc7wMnwvDMegXDZR3z6U0so/sjl
	mMPJefL4g8j93llWMtm7h1NX78qf6hnUwd4fCIZs4XeloI5QMgP8oEhIVhdCsd6i
	SlxVaBrIu7PebCb6l1E0v6IzRwXT8Q8H/trS4KKDQh4uvcHKT2f8RRDqpsJj6FnQ
	dPZoBJIPaRv3oUYKC1aL2s2NzvTJd6EkaUwEcK+2VMUSepLVjO0/pduwywc5+UUk
	NCDa5xmq3dWWqHg2x7QEcBOVgHbEZMT8onw==
X-ME-Sender: <xms:-WgmaiCEoBNag7lZOnPu6X7rmZ9T4sMgl6QqC_6R8OXZ5TSDVmI9OQ>
    <xme:-WgmaiihIPiN7DGpUhyo9G2X5Wp58NJzlOneaXG2dJqjg7-dE_xUJkbGyRWJZXyzn
    lKE1ZSluTiMT9p0JEbfZ7Le80ndUEH_Chw1Ot21LGdGv_7RUU77>
X-ME-Received: <xmr:-WgmajOE12tVqIzRWfweKZFoLXZtbAKOtt4DfKOwGqD6AZNPfpAU1YID3LrzXbnVtIVMiMnOQmSvzMQkIMJ4vk-C0mnIayTGwswQpOBqIA>
X-ME-Proxy-Cause: dmFkZTFXK4N7/2pxEhV2EMh7pOEy7Ij/dwdZvYg8IROZF33btBrVJc7IIM3nVjGKGfEg7Z
    X4WF6YMjF5isu1ZX24BOU0bSbGMzCixxacBfTRnJ4xD7oRpxryHNNz0/+gxA1Li3knLeZ4
    GZ5koD1r62v1njH2WLOTfP7qwFkWLLUEluL1AWeXwhMOhZnT8FOtmeviSQAGNk0pTgAalX
    1ojfkVEuaUrsYteC+/mD5P22BEI1baogLjcBDsoV7dtQ6Cyd4rhW1MXffEj0b+yddliyLG
    T8DRVdqfMAI9U/I9IT44JRY/7MC+6kuC0BdSX170EVQA03d7wC8CUSLUC0qHFyzjRYvwAK
    dbk66kM9kSh1djlS53f7JuGbqZ8Fe3qDWSdhE7HY4Z9uyeisl7TkXTmHzPZH8AAes3lKyv
    ilyfDmiFphtXEqNIWmewPtjma0wsrVQsGahOzRDxVh+0AUx7yiAa0hMtYfdYMVKwVnOUAQ
    QYKlZYlr1hzMqdJmpDzAo6YHjipxv4jfm3xSaJGEmiFMB7lsvntj8Wy1v/8d2WrEB3BXQx
    F64JI0AzZpmBlHaWcPyCxKCHNKdT3NjK3fGF4X6IKiVAaMIZfyHwjP8i8hC7SpUD98QGN/
    9Gb/nTKSwMqRoperkBiZFKmMLR7YTqqJg/Z+lUhJK1AAyPV8Oi0DOOU9NxNg
X-ME-Proxy: <xmx:-Wgmar5kZ8yQX_5nsxxGaYyciMtSp02ZN2PEnahZWycCClH-1tvYXw>
    <xmx:-Wgmap0Wd3nSwVFJRrM6T5YE1s7sL5werIY5wy-hMDbs8BuaEvoqpw>
    <xmx:-WgmakaaWVIfvpta4NiyfukAlOmyuZ5cH13dddWELWhsU2ykxQSloA>
    <xmx:-WgmapBG3liq2jfg5WqhuA3tgTQOmpRFBUh4NymGPAM9lvU5A8IZYg>
    <xmx:-Wgmaq070jqiwx1uBQHomNZeIDtfEBKTErU8wnEhXowXUfugUxI08TrI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 03:02:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 17b4c74c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 07:02:14 +0000 (UTC)
Date: Mon, 8 Jun 2026 09:02:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Alexander Monakov <amonakov@ispras.ru>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: fix typo in GIT_ALTERNATE_OBJECT_DIRECTORIES
Message-ID: <aiZo9FqsdKrhz0gA@pks.im>
References: <20260605172643.8796-1-amonakov@ispras.ru>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605172643.8796-1-amonakov@ispras.ru>

On Fri, Jun 05, 2026 at 08:26:43PM +0300, Alexander Monakov wrote:
> One file accidentally spelled GIT_ALTERNATE_OBJECT_DIRECTORIES with
> REPOSITORIES instead of DIRECTORIES. Fix the typo.
> 
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> ---
>  Documentation/technical/hash-function-transition.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/technical/hash-function-transition.adoc b/Documentation/technical/hash-function-transition.adoc
> index 2359d7d106..241d2f763d 100644
> --- a/Documentation/technical/hash-function-transition.adoc
> +++ b/Documentation/technical/hash-function-transition.adoc
> @@ -545,7 +545,7 @@ Alternates
>  ~~~~~~~~~~
>  For the same reason, a SHA-256 repository cannot borrow objects from a
>  SHA-1 repository using objects/info/alternates or
> -$GIT_ALTERNATE_OBJECT_REPOSITORIES.
> +$GIT_ALTERNATE_OBJECT_DIRECTORIES.

Yup, this change looks obviously good to me. Thanks!

Patrick
