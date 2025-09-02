Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC4616F265
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808294; cv=none; b=HZJFzhbRYzPWOrfXTiLOEvNbMeb9Yulwj18SBIvMZ9ZOkdZCsPx27yek74mj7YhoQeKLsJQ83j8TPo4MVX878haxLB8ucVD9VfOZunS+svuvmdb+0YdlS7IdhUQWE8GwfqwerG1dv11GwQsI0y/dCn+YHx8drBlnvlZ4IdYHaJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808294; c=relaxed/simple;
	bh=ejEotohj/gy3ZhISlU0tvAE0K7t2WgWMjV0VkWSYmfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ei74alLhgnpiDLud2ZvbGkPVAnzoodOoJDUNvFn4V+utVnUnkqwX+WtEQF17fKro0Wiggx1Yz/5AKgnmHYsoUZ94U0VPyO30KCn4l9QECsf8/XaNvQe4WsmiTsX7SEW4/P3hEgZ+3kpuC3EIC35i0QUxI8rDWZKK1PQSMS+GHWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bSQgxj40; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nWffP/W/; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bSQgxj40";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nWffP/W/"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id CE270EC030B;
	Tue,  2 Sep 2025 06:18:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 02 Sep 2025 06:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756808291; x=1756894691; bh=XNC5VXw5fq
	DVY+y4XN/Wisx8LUrBgR4yxFj4NopDuBU=; b=bSQgxj40HvgspD9Ht/p+cuM2td
	r2KGLOjdn2hc1981wn0vR9XhxCw3slzFRHviJKk7sEFuvsJVO0h1hGlG2GCw+IQg
	3SpXcbP7xzi5wJ90ZOPx1FVZ9momv89VaPm0rInj9c4SFTogTIXDNMH4CuiJzmRg
	G0yDl5GihftqtnqrGFg6KGIsdoC5TeOYpL0tcaRybLQWtpYqWsSR5aCjsQbLnMff
	+ADoaKEeGdXoDOzxfuJglYutfI31zfVoQsSRi+RlyJ+9JziJksUhX4ImO9emNvnh
	TOVUUCDEOmsU1B1Vy2+OBT+7UzDfC4cSA+KYdmwqlXwdKtkDWFsyjdYdvz7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756808291; x=1756894691; bh=XNC5VXw5fqDVY+y4XN/Wisx8LUrBgR4yxFj
	4NopDuBU=; b=nWffP/W/n8ZobwMt1DscLz/xrj4nxLkqnXwNaCDz2GKt3okmafG
	aIkOZAyZatQ69Af0pgksJXk2JBs6dvkUma326DM+uidHx/5FjuihUd2YQTgXx67m
	YgkdA2YpUrsQc8Nx2h6EZvFNQXzNbbPcpZo1Rgn3HoDxMFQEbtqSPueK7SiPPC+T
	qE9dotJw0mLTPJiV3pQxEGNh1k2iIloPVuzryQ+Wx5PrSMSAj6O5/k/8gJRWJa42
	/VdO/XxRMDVpy3Ee9jTgWyUAbFIsnnkOUwx6E1kSihkGcgqy9RWWhWy1nAZ15iEa
	1VvOUPgBa8uJ8VHW/rPGR/bY1DQpTzkdCkA==
X-ME-Sender: <xms:Y8S2aF95GuvJcqu2Yn5BW2xw4mQzj6EdHkwFxLqSipk-egIW-svmyw>
    <xme:Y8S2aM8PY10E6WhvvnM2jNAbaYCJdpEIRBApNWLgzCBsK_kRtmnb9TRA3GsVwlL7g
    9VDDAK7oD11mZy4Iw>
X-ME-Received: <xmr:Y8S2aMc4AMHOisDC8DaWLiWEcUpTP4z6eI5f5e57Q8Giv5w40M59T_2z1MDFCmc_UCV6dFoKjcfp68ffkoka8vmZnNptL2jMWAQA2dVW_3OcWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdegucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghilhhouhht
    mecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvvght
    shhonhhifedtudejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:Y8S2aFFy8LMuMXnnWMTnlV0Rmr5ynS3v5gUQ4Np3OiRyxexyF7_MWg>
    <xmx:Y8S2aKfzUk9zLiKVROBrt9CGKOed2C5VSHgSZtFp7whPxfVPfmlIkQ>
    <xmx:Y8S2aPHRACvFu2wU120sf6ykazmSZVQUbCLZfUV_s0O3W2CYdjWaUg>
    <xmx:Y8S2aDWqUvfEDM5Moatf40j7oEBmINduK09ZXiTzo6_mAc-3nENRzw>
    <xmx:Y8S2aO5uytd92pfQfBXQ0v5nmJyiduZkn-XVJBnwS3oZGy7uxzdZ7ZSU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 06:18:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8bc77672 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 10:18:10 +0000 (UTC)
Date: Tue, 2 Sep 2025 12:18:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, shejialuo@gmail.com
Subject: Re: [GSoC][PATCH 3/5] builtin/refs: add optimize subcommand
Message-ID: <aLbEX-f8LGEFO13C@pks.im>
References: <20250826073645.1074397-1-meetsoni3017@gmail.com>
 <20250826073645.1074397-4-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826073645.1074397-4-meetsoni3017@gmail.com>

On Tue, Aug 26, 2025 at 01:06:43PM +0530, Meet Soni wrote:
> diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
> index e608980711..121a2fbeff 100644
> --- a/Documentation/git-refs.adoc
> +++ b/Documentation/git-refs.adoc
> @@ -18,6 +18,7 @@ git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
>  		   [--contains[=<object>]] [--no-contains[=<object>]]
>  		   [(--exclude=<pattern>)...] [--start-after=<marker>]
>  		   [ --stdin | <pattern>... ]
> +git refs optimize [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
>  
>  DESCRIPTION
>  -----------
> @@ -38,6 +39,11 @@ list::
>  	formatting, and sorting. This subcommand is an alias for
>  	linkgit:git-for-each-ref[1] and offers identical functionality.
>  
> +optimize::
> +        Pack references into a single file to improve repository performance
> +        and reduce storage usage. This subcommand is an alias for
> +        linkgit:git-pack-refs[1] and offers identical functionality.

This feels way too specific to the "files" backend. We do pack
references there, but with the "reftable" backend we don't. Furthermore,
there is no guarantee that we'll only have a single file after
optimizing the store with either of the backends.

So this should be rephrased to become agnostic of the actual backend
that is in use. Maybe just say something like "Optimizes references to
improve repository performance and reduce disk usage."

Patrick
