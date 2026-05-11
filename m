Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206563AB298
	for <git@vger.kernel.org>; Mon, 11 May 2026 07:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486103; cv=none; b=Ob5IcmiQAdAwUAlRH7UeJnxxdx6QQAcdX/nJQS4UrMD9LiQnem1IiN/qNJ1OBYYmmyekYojT2SAXDPKed+o9FI2nDU1iE2b0k0HwABH/6LfEp6Kgo6FcWqNs4zv1UuNfBFMUS10//FvxqRjMaBkcpkuS6Vuv3eLx2xOOYSTIJlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486103; c=relaxed/simple;
	bh=KvOBSfmkQgJZraCFMeKiqiQ/q+4yOMaxCczyANxyles=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2GyHKqg5Qa2OJlPIDY9TjZBr9fDvUPwdRD6aj+eSbt2yWQvnJj9HWKwFtwTjX1T/GGXWavYo/YWaWq/ybS2LF9BUScg64TUTj+sPkslJ2Zce+vQV6zf89R9VTX3tNFn5RkixyHBbt9kREc31ch44Q5i3yJfVjxJwJ3JRazB/S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ejbS7c2/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OGaVjEVV; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ejbS7c2/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OGaVjEVV"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9DED81400135;
	Mon, 11 May 2026 03:54:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 11 May 2026 03:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778486089; x=1778572489; bh=wlLJoT5HXi
	0+hO5ffz+AW8g12b7ei/Yt6McWSUTUywk=; b=ejbS7c2/oQ8yn5lMcA45ikh+xs
	iqJHHdKSx/qHag2M3aBmEATzoiVc2weY7/BMDJtJEBd+393h3DIwWHCjU5syBn3I
	gbnFFirb0prBdhRUPIjNGK77emfmMHAwbiy7DZBTxqwzh+4QNhOQ4ZebGjFcpC0t
	Rv91H0o74mo/AUAndTm3YtXQu61pgmjQvBbcKYiiCEaXJWESUYwWPG/oiq+EAdH7
	WTKwJO4BlFOac9MVzMPuR4VTrUqt7gn3dl9zAmBenJRJ1pGg1UHzWtZfLfd8UJov
	pQVgKFzC8jNQlqk6xkSkVYd6t5nO0nv6xdIFTSRritBkQ2q31MLhE+zqbfSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778486089; x=1778572489; bh=wlLJoT5HXi0+hO5ffz+AW8g12b7ei/Yt6Mc
	WSUTUywk=; b=OGaVjEVVFo/8nVYGf1VPyXakeDFu29Qpb5oVsNBSTsja1eJJJzF
	3Ag+OhLSyrFGMVuzeGexBKh780O3dQC7i2HLSGxpLjltB2XvvoryeJaJ1V4ssHEK
	Wff30tStfAFVgRPF+bNOS4r5xrMfALjWGivn5CBTV8ykxUNW4Q/EiDi/UNj06Gw1
	9KeWEAbzACKiKUnPCchgK2aIu66lqm7ipJskgTN5N7+KXV5NZkKiA76JHRcjq4N/
	Qw5HYvZEw1KEy0Mk2eDXQKXcwN2iJSulcNj2Bb48KH0Q+gCi+fyyavAm5JeNUInX
	TSHRUgco+uR6cQI5lrtmw9Q2yP3PuwDNb/w==
X-ME-Sender: <xms:SYsBasZZMpBge4BNrVADEF2RnSw3Fznra-pyb2nmvNhhTbHWT1_DkA>
    <xme:SYsBau0UcsqkDF8rqMuUnGRq3fDBzz1OG1aqw-SKW6Qk4yfrwIqsT5ijP7uQqOV9n
    j0OgrquGhnGwXWT-ym-6P2U-aceJEl96NkbYB1hN7eNWfmyZRMsLg>
X-ME-Received: <xmr:SYsBakXfWbZTbkSfDGLasEFdtFAZcrAlxnUwbtv05IhXa79UL65eEQLAgf8ZiZ_o-G07c8kNtY4Zi_aeyPbMNPcjOlPlTq-4Tn_AYAHfiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshgvsghtrghrughifhesnhgtfhdrtggrpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:SYsBagWSQvXWVr38yVs-jMCBoDqZsX5W30Em4DNv6ZryApU1W7XAQw>
    <xmx:SYsBarclhplEu6MrZ7t8TVztWDlwkLKR6dDf6QCIXN6T-smoTQAooA>
    <xmx:SYsBahX6RWXeGIYuSxpzeIbSw0s9FMRec4dzwSD5GcTaT-t9lNno-w>
    <xmx:SYsBasdiqSzZHH5UrOWz_KSm9N_uFCtMQrmsSOGyo6nnFamJ7OXY0w>
    <xmx:SYsBanmtIE7aCoYVwgI9hFd9ft5dm33po05cVEjRyG6DFZ6opaGVCFWu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 03:54:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 563b0352 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 May 2026 07:54:47 +0000 (UTC)
Date: Mon, 11 May 2026 09:54:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Sebastien Tardif via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Sebastien Tardif <sebtardif@ncf.ca>
Subject: Re: [PATCH] daemon: fix network address handling bugs
Message-ID: <agGLRC1ziF5F8Okh@pks.im>
References: <pull.2299.git.git.1778291290159.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2299.git.git.1778291290159.gitgitgadget@gmail.com>

On Sat, May 09, 2026 at 01:48:10AM +0000, Sebastien Tardif via GitGitGadget wrote:
> From: Sebastien Tardif <sebtardif@ncf.ca>
> 
> Fix three related issues in daemon.c's network address handling:

This is a good indicator that this patch should be split up into three
patches, where each patch addresses one of the issues.

> diff --git a/daemon.c b/daemon.c
> index 0a7b1aae44..84a5e38f92 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -674,10 +674,17 @@ static void lookup_hostname(struct hostinfo *hi)
>  
>  		gai = getaddrinfo(hi->hostname.buf, NULL, &hints, &ai);
>  		if (!gai) {
> -			struct sockaddr_in *sin_addr = (void *)ai->ai_addr;
> -
> -			inet_ntop(AF_INET, &sin_addr->sin_addr,
> -				  addrbuf, sizeof(addrbuf));
> +			if (ai->ai_family == AF_INET) {
> +				struct sockaddr_in *sa =
> +					(struct sockaddr_in *)ai->ai_addr;
> +				inet_ntop(AF_INET, &sa->sin_addr,
> +					  addrbuf, sizeof(addrbuf));
> +			} else if (ai->ai_family == AF_INET6) {
> +				struct sockaddr_in6 *sa6 =
> +					(struct sockaddr_in6 *)ai->ai_addr;
> +				inet_ntop(AF_INET6, &sa6->sin6_addr,
> +					  addrbuf, sizeof(addrbuf));
> +			}
>  			strbuf_addstr(&hi->ip_address, addrbuf);
>  
>  			if (ai->ai_canonname)

We could deduplicate the logic by assigning the address pointer to a
local field first:

    gai = getaddrinfo(hi->hostname.buf, NULL, &hints, &ai);
    if (!gai) {
        struct sockaddr_in *sin_addr = (void *)ai->ai_addr;
        void *addr;

        if (ai->ai_family == AF_INET) {
            struct sockaddr_in *sa = ai->ai_addr;
            addr = sa->sin_addr;
        } else if (ai->ai_family == AF_INET6) {
            struct sockaddr_in6 *sa6 = ai->ai_addr;
            addr = sa->sin6_addr;
        } else {
            die("unexpected address info family");
        }

        inet_ntop(ai->ai_family, addr, addrbuf, sizeof(addrbuf));
        strbuf_addstr(&hi->ip_address, addrbuf);

> @@ -742,7 +749,7 @@ static int execute(void)
>  	struct strvec env = STRVEC_INIT;
>  
>  	if (addr)
> -		loginfo("Connection from %s:%s", addr, port);
> +		loginfo("Connection from %s:%s", addr, port ? port : "?");

Hm. It shouldn't ever happen that either of these is unset as far as I
know. But it's weird indeed that we check for one of them to exist, but
not for the other.

> @@ -936,7 +943,7 @@ struct socketlist {
>  	size_t alloc;
>  };
>  
> -static const char *ip2str(int family, struct sockaddr *sin, socklen_t len)
> +static const char *ip2str(int family, struct sockaddr *sin)
>  {
>  #ifdef NO_IPV6
>  	static char ip[INET_ADDRSTRLEN];
> @@ -947,11 +954,11 @@ static const char *ip2str(int family, struct sockaddr *sin, socklen_t len)
>  	switch (family) {
>  #ifndef NO_IPV6
>  	case AF_INET6:
> -		inet_ntop(family, &((struct sockaddr_in6*)sin)->sin6_addr, ip, len);
> +		inet_ntop(family, &((struct sockaddr_in6*)sin)->sin6_addr, ip, sizeof(ip));
>  		break;
>  #endif
>  	case AF_INET:
> -		inet_ntop(family, &((struct sockaddr_in*)sin)->sin_addr, ip, len);
> +		inet_ntop(family, &((struct sockaddr_in*)sin)->sin_addr, ip, sizeof(ip));
>  		break;
>  	default:
>  		xsnprintf(ip, sizeof(ip), "<unknown>");

Right, the last parameter of inet_ntop(3p) declares the size of the
output buffer, not of the input address.

Thanks!

Patrick
