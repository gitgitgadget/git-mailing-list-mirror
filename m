Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60CB8493
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 05:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724391912; cv=none; b=b2vurLBA+Lxi/jQYJwFyjiMaLBW6AzfEZn/mG878dD7ewyRYMAlycNw/WvhsV+l5nYGjZ50n1EANDEFfsCORS9eOSKTyLqDGxZ8mdI1E8CePEPrMmVyrZYyuqnTIYK5vYvOxEA39TIymmQ1SSt+gqJlEPB50VeJGxLcpx4EJBh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724391912; c=relaxed/simple;
	bh=ylBFgU0RQ0SrK/+OHpKGjmtjcSiP1bEIzWwDy8RuzxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6U65ulFaXCy43AlDl9we5Fh9F7ZhB0Q0I8SVugPad6BkxU+aDSs9Kje8fLRsxenGx9fGc26/TBx+SBncibRcgmcAWggIzgSvOVxJy3aoodS7KHF1nyZkJhvoreoWV5Z+abWgTiA7BuUInXYqpiijlY4zqTFymW1ihORd1JPXIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D2BvhRLY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=buRUE6DW; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D2BvhRLY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="buRUE6DW"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EBFBA1151B35;
	Fri, 23 Aug 2024 01:45:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 23 Aug 2024 01:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724391909; x=1724478309; bh=ew0YNy7U+L
	JB5aq9bF+QSxwWHAfusNk/nMWQT2BDq/E=; b=D2BvhRLYbqAZ1EtdFhOSxDKVKA
	rLv64ICY9XJgipnxXYFIR2KRoYWqvFX02FPQ3gKVVkx6Z6c1xSgb+W6xSrvjUsgy
	gtUhasvcRscSIv1XULG922xWST59n0WfuRCLXIzfp2eXFFPv08AyzvMt54UVBTSk
	NTasDQMO1Rob4dUxOXTBs3fb38PG0XtfFSKOAaAxYo7+bJfcvEoWWohiKOADx1xC
	9CwTIV6ecquYjwRQDlXBJOyEWvLS2Lz9wN4oFlXcMxIMzopnD+VDqH2JGIWre3Bq
	Z0wgUtl1ZfP5runY5DEwP1rGQARsts/iSyawXnJVx+h0UtJON+ep+QwWEm4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724391909; x=1724478309; bh=ew0YNy7U+LJB5aq9bF+QSxwWHAfu
	sNk/nMWQT2BDq/E=; b=buRUE6DW1g0OHVKFKqmKyip7/2axlN/7y3PO3SUbvTr+
	orbrbcqRxqEmzJBAx8lDfUdgswAUD2/Q2+KHYhJdSocfjo7Uv+pJcwZuFTwNApjj
	h8kW/ENS30vNsKPxIIZfdYrWzaTqeQxcNZdSUdjDJFJBCvx+qozTVvnUOdlTeT+a
	G5oXOUtJ2hvNolao6QEJMu5DFYaB8e8k4PmgtFjHdJnsHuWUJWWUV+EZjWNISZGe
	9+lSMZZEZsNnYBI1sjlp6H8sAgcbL93p2x2ECmJGbrEVtjXwF2VPtNgGPPcxd14l
	LdRzauC212hO/6CDRcHFaf4zR+nI5sKpme5z7LfVgA==
X-ME-Sender: <xms:5SHIZmdcV8Uo2nRXLGu46UcgHYZ97udpizsQpP0GeRb2_ovLOUgrsw>
    <xme:5SHIZgP-IExpKr_jgB3Duph3O52RPeaCJxhfBc68htWP3lm4rldEMO1_bksGO5iu0
    QARBuff7DqSQF1EYA>
X-ME-Received: <xmr:5SHIZngxZ8rdG1PdVlNZGuTQfzO1hxC5-Dy9Noe2idBq-5q7HsfSH2wYux-fcv8WxkiQ9hOP6L9WvtwW4bzV9SEP4SqwWpjPTKgqg_kyEdTzvfvJbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvuddgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohgvlhgrtggrnhhthhhushhhvgigsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:5SHIZj9M5dP20LlLNgagfXKHmY8bY8riYMfYk31F17j-5yIf8nmNNA>
    <xmx:5SHIZivVeWMyqCPtKJcox8l4GfRhhLe2JZ_4izFvGtn9K-8rjPZeQA>
    <xmx:5SHIZqEB7x7RcindcKI_3yzIzDpFsiOqfG4z5CwIUdy3xsi9z_PsWw>
    <xmx:5SHIZhPpQ3i8ZXy6aSdVtzwP-2_LCYqd52Z37YzzsQQsI14d7lFltg>
    <xmx:5SHIZmKav48Pf3h39fwoYaGI_QVZWzgDrcVSlRph4OUc2-E7OAGVVFfG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Aug 2024 01:45:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6e88985f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Aug 2024 05:44:31 +0000 (UTC)
Date: Fri, 23 Aug 2024 07:45:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Celeste Liu <coelacanthushex@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: replace 3 dash with correct 2 dash in git-config(1)
Message-ID: <Zsgh4LacdOt8N69o@tanuki>
References: <20240822172042.54065-1-CoelacanthusHex@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822172042.54065-1-CoelacanthusHex@gmail.com>

On Fri, Aug 23, 2024 at 01:20:41AM +0800, Celeste Liu wrote:
> Commit 4e51389000 (builtin/config: introduce "get" subcommand, 2024-05-06)
> introduced this typo.

We typically do not word the commit message as a continuation of the
subject. The subject often becomes invisible in many contexts, so it is
helpful if it can be read standalone while providing all of the context
necessary. So mentioning what is wrong would be welcome here.

> Fixes: 4e51389000 (builtin/config: introduce "get" subcommand, 2024-05-06)

We do not use Fixes tags in the Git project.

> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
> ---
>  Documentation/git-config.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 65c645d461..79360328aa 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -130,7 +130,7 @@ OPTIONS
>  --all::
>  	With `get`, return all values for a multi-valued key.
>  
> ----regexp::
> +--regexp::
>  	With `get`, interpret the name as a regular expression. Regular
>  	expression matching is currently case-sensitive and done against a
>  	canonicalized version of the key in which section and variable names

This looks obviously correct to me.

There's one more thing I noticed: the synopsis for `git config get` says
`--regrexp=<regexp>`, which is clearly wrong. As you're already at it,
would you mind including a second patch that corrects this?

Thanks!

Patrick
