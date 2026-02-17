Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD0B2E040E
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315621; cv=none; b=CBdRzl7hyz9nOIXZdAKbRpIj+bPLDf9UbjS0hSYIkYL7kL+KlUTJlAEEaaonD+gw4skRmVnuIzE9MVpdY30gZTrdz0xACkm1/boJgH1edpDpJE8g5iODb43CcAYjJDxvv8HgNqckxxmm2ax1xpqu1cBiwf596xlNFxkUWoNjQIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315621; c=relaxed/simple;
	bh=2s7Is6cr1IuG8WTTdB4bjwJzP2JwaNL7V+hXwPYsYVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mV3vLbWgD/jtfNr0Lb29LmC9sUXWYamY6Tf5MxrCMtRQlIIc3b8D7x/OuHlAvo1BlM6gPM+kWXWNd16FilVsKnNMybKM/+CHFx8pQYjdxgshm8+opyh06bx32rmUOaOsIYlG3KvFHvmDs/KKLVr8o8Xw2wMhnjv3O3lfoB5HhBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=grFLoOoN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h4sNDRDL; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="grFLoOoN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h4sNDRDL"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 355931D000AF;
	Tue, 17 Feb 2026 03:06:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 17 Feb 2026 03:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771315618; x=1771402018; bh=Z9iTNJmCkD
	fF3jWZd95gwrDIeOK4L9ufddo8ezamtyY=; b=grFLoOoNDI+zrKUDVkrvhiPB+h
	6RJ8stMOFD16G9fuIwqmPOEhzp5z0mBzN11Yer/yYNiMQRE8pibb7fZUVNGpJ/ci
	X4t7UK22rwOEAJhtfwKdY0VDOMgS5142aESFjHJZ/dhcEpu+tA53rUGQ7EBtbFwY
	vPJzxXgLcG0l8uyfTz0/AWXDSkt1nIlWIwMGIyU92HmIaFpI4z6LDHEFHIfK34oV
	aT1w+n04SWRjqBXqCKRzchpZ/k0Q0e5ylUvZp7ex2KjTKXhn2Axh6K8bpOtlhwad
	TcXdofGNOFVk3upW+pyHhmLvczWujxZUhKn2kifEPxZkt/5nGHq4pki1YQaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771315618; x=1771402018; bh=Z9iTNJmCkDfF3jWZd95gwrDIeOK4L9ufddo
	8ezamtyY=; b=h4sNDRDLsjjXGMMMbjYvCLYiD/lVtyfPBXq+2yDAxZWiL64Hwt4
	tKszukOd/V7xvHXsGpOG2/6a6QG82ZigGRFU6WlLggxcYFIGLzAFaTmaxsQe74tp
	J9lQv6iu1yApVS9VV9O91lLXbnN7Gj/9+fM9Gitm3sR2udhIBG1vhzqxOw1FHIgg
	RNKUwu2ju44qC+iVL1E9wU++cjL40JJs8BwUL47+0L3Qlw+qcHCOk2azz33ZbmWD
	tc/4eTBwmuX1u3FQnFUPRyJMuMIPziTNumHGCbb/E4AewnRLc6D8/J4P2F31X8tD
	FPaVPFCF/ldUWBJw76B2f1PKOb7Gj3dzzsg==
X-ME-Sender: <xms:oiGUaRjQ4oNIsv3LtFR3nGUFoIMlQStQKUM9Jxx6lgd05cyTciisHg>
    <xme:oiGUadDq1vemsid1-rlPxYORikt16MH5h98-emyJzG1dxfOLyH7yneqIiJ5V5J2AM
    -mZYbOnE_ZXwmKjGc_GMTYbrLGFtXObtyvBKtwJ3XW9zozPiccq1g>
X-ME-Received: <xmr:oiGUaWHoIuNisBVexpLQqjoIz7bdcF6UaVdR-S1JWIj30k-YknuR4M-zBRliKCI6uAcHv-pRqmirW4wgy1oZw6-IcS4Y0pnDtJZ3Mf2t8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehjohgrqhhuihhmrhhotghhrgdrtghomhdprhgtphhtthhopehjohgrqhhuih
    hmsegrmhhuthgrsghlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:oiGUaVIlMEOn-3RVxHEoXj510OhfnrVWmB2sQ_Je4ynL5ztKIjk9XQ>
    <xmx:oiGUaanF4A0MUjn4hk-zrY1FcRUU73k1ldd89dP8e_N7NE8ki08L9Q>
    <xmx:oiGUadRMrO4JP1womBcoBHHXNuyGdqX93TvK58q_jvHdwDWprACYkA>
    <xmx:oiGUacJBvp8g4ZVJOmK8KmkpqgDHzdu6rbx7lcmB0j7Gtr61nKCmpw>
    <xmx:oiGUaTNPI9dnsYwlA1Xr8OcIRi3Cu6LlYIvulxGqORYLmjp34It8I_Zk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 03:06:57 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bb8ae967 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Feb 2026 08:06:55 +0000 (UTC)
Date: Tue, 17 Feb 2026 09:06:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Joaquim Rocha via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Joaquim Rocha <me@joaquimrocha.com>,
	Joaquim Rocha <joaquim@amutable.com>
Subject: Re: [PATCH] apply: strip ./ prefix from --directory argument
Message-ID: <aZQhnIcPa9sCPpBb@pks.im>
References: <pull.2198.git.git.1771002510709.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2198.git.git.1771002510709.gitgitgadget@gmail.com>

On Fri, Feb 13, 2026 at 05:08:30PM +0000, Joaquim Rocha via GitGitGadget wrote:
> From: Joaquim Rocha <joaquim@amutable.com>
> 
> When passing a relative path like --directory=./some/sub, the leading
> "./" caused apply to prepend it literally to patch filenames, resulting
> in an error (invalid path).
> 
> Since using "./" is almost memory muscle for many, strip the "./"
> prefix so it behaves the same as --directory=some/sub.

Isn't the problem wider than that though? For example, if you had
"././some/sub" it would break again. Or if you had "some/./sub", or
"some/sub/../sub", or "some//sub".

> diff --git a/apply.c b/apply.c
> index 3de4aa4d2e..a44c54077c 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -5001,6 +5001,10 @@ static int apply_option_parse_directory(const struct option *opt,
>  	BUG_ON_OPT_NEG(unset);
>  
>  	strbuf_reset(&state->root);
> +
> +	if (starts_with(arg, "./"))
> +		arg += 2;
> +
>  	strbuf_addstr(&state->root, arg);
>  	strbuf_complete(&state->root, '/');
>  	return 0;

While this change here fixes your observed issues, the next person might
run into a totally different one. So more generally, I think what we'd
rather want to do is to fully normalize the path. How about this
instead:

diff --git a/apply.c b/apply.c
index 9de2eb953e..8946b133a3 100644
--- a/apply.c
+++ b/apply.c
@@ -5002,6 +5002,7 @@ static int apply_option_parse_directory(const struct option *opt,
 
 	strbuf_reset(&state->root);
 	strbuf_addstr(&state->root, arg);
+	strbuf_normalize_path(&state->root);
 	strbuf_complete(&state->root, '/');
 	return 0;
 }

`strbuf_normalize_path()` drops "." components, removes ".." and it
squashes multiple directory separators. So it handles your specific use
case, but also others.

Thanks!

Patrick
