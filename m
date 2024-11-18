Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB1C13D502
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731917170; cv=none; b=t+3IvcK9VNdHc/XlNUjPQViUJ39HGEgNNDfJHKuPaCwLse6vrlBAgCTYEn6wczwSqrWophUdoCAn6thIhZbG2hTIPfgBh/dTzCdtZUpJgQKqWgX9/MjD0re9BD4/ZfZBCpQIgkBef5rPE9wbbs/twnvkX4L2VS+B737y0Te8tnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731917170; c=relaxed/simple;
	bh=149+2N4plsVyRBBdkMZd8MNFzu3b8MJUnzWpotBg9fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5y9ZTlNqz+YzDiKz4lpqdjZLkyYAZDtK7VjVFsPas+XH8rRXYPGvvDxuMz3XaR8cufKOPBwYreEjUvyXiP6ZOwHeBCB9KzS3d9XsgyzDE6zoDCHs2jqCkpH/PjLq2rvOEF5Fa4DjCwnndqxA+jFyYCGsjUnMb7vT0RSK1Smios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eFvYYWtj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UZYfpzqA; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eFvYYWtj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UZYfpzqA"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 302CF114012B;
	Mon, 18 Nov 2024 03:06:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 18 Nov 2024 03:06:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731917167; x=1732003567; bh=1Xqw+O3QyT
	zlepImX5hsHucWC53n4/qjEC+nubqJwqA=; b=eFvYYWtjfTpsBL2ej5/j5KPzER
	sQdQJ/PvfUh+E+LN9w2ytsbnIFJPPbCvPYwz4GzC9InEBhwVlLIFviVGauqleZmF
	RBYHnHalHYAv+Gyx0EopsSYHorQkgJp+osDxQ5Oh8H4wJyNaKZjwLJPJmsXvn62B
	gLxV3YQ7avaca1u+M1ikmUU94bzymSj6nNfyjDkO4OXOIjW+y4WMp7G2xpT6owbE
	Q8GtI1vEbfvKgaFEFpdVbk2vRQqfwzrHm3cL9CNJI/WCg/ed/iDma7+6oMuuXCKv
	2E88um6ExHBeFDBWT9Nr0tFJokvpf4LIZ6LXIXDlP6erhBB52RCdsVB5tMzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731917167; x=1732003567; bh=1Xqw+O3QyTzlepImX5hsHucWC53n4/qjEC+
	nubqJwqA=; b=UZYfpzqA27AgG6BuxXQfw7D4NYYkyC+fsf7ckfbZZfsmUfxx0DT
	kTcvH/C5C2wSRoc+WJnazsBJwbyFNZ/XfNeG8yIf7XKwXS7dfd27J8GxCIvNkbuo
	zOcbSDX0e4Jka2rBaOEPPSyN0rHDGmr2qSbAep60Do61w4igskY8SAwzLZEDeH8E
	yRcONodakTJpWEXGOMGvlFz44b6zkwif31HWRVEoWKL9CB1hz9RZSI74/z8s7k98
	v/X36V1vScogWItK0OU5zYy+YI8bFVXUwylbkihKmWixFksqsbSRSgwhI75FsOIf
	2G1KehngGNbO8saUXq8RBpIYD/3KpurMvbQ==
X-ME-Sender: <xms:bvU6Z18ZznW5s811MAPcbigtVd2kf4dXWGTPRkTZKkUhMcPN-wkyIw>
    <xme:bvU6Z5tDFmF3AqxP7cVLrX8UNeOk812oMvRlFfJmJ_Ur1K37Jx9Z0IU-HgO1FyepX
    buKHxUAHP4r6KDTuA>
X-ME-Received: <xmr:bvU6ZzBjfAvvF-jgWElso3iU415erYG45y9E94fP0niq55LmMXX6QZz0zSwBkPpvtCu1VnLon-eVHVrBi0i64GlAWal7YKbT6pWEA7DpjaxWuS2n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihl
    ohhrrhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:bvU6Z5fHNvrwewY-KKJS1zhj6HFH69192FCps9l4HV2qnHOgX8Tv9g>
    <xmx:bvU6Z6NpHO6lr1k-vxVOZ8zPJ4tZO_UC_vlLtYotly1WF_JJTipBew>
    <xmx:bvU6Z7kILCb7GsTD50q_db1xwEDF-YoCoDrsY5TBrYiyP_MDvp94Ng>
    <xmx:bvU6Z0t-v7sqcR3CXaxb7HCT8Hbdhpc9niTRmNx1kM5A-wGe0Qz6jA>
    <xmx:b_U6Z3pr6E1JHY7yzOWtfDORkd8o01q4543X0JUbWv_dsFNaqbllTdit>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 03:06:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c633dad6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 08:05:18 +0000 (UTC)
Date: Mon, 18 Nov 2024 09:05:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, me@ttaylorr.com, peff@peff.net
Subject: Re: [PATCH 2/8] midx-write: add repository field to
 `write_midx_context`
Message-ID: <Zzr1ZMmH9p8BF4O6@pks.im>
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
 <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-2-761f8a2c7775@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-2-761f8a2c7775@gmail.com>

On Fri, Nov 15, 2024 at 02:42:15PM +0100, Karthik Nayak wrote:
> @@ -651,9 +653,10 @@ static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
>  	struct strbuf buf = STRBUF_INIT;
>  	char *tmp_file;
>  
> -	trace2_region_enter("midx", "write_midx_reverse_index", the_repository);
> +	trace2_region_enter("midx", "write_midx_reverse_index", ctx->repo);
>  
> -	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex(midx_hash));
> +	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex_algop(midx_hash,
> +								    ctx->repo->hash_algo));
>  
>  	tmp_file = write_rev_file_order(NULL, ctx->pack_order, ctx->entries_nr,
>  					midx_hash, WRITE_REV);

I think it would be nice to split up the changes that start to pass down
a repo via the context and those that start to actually call a different
function like we have here. Otherwise it's hard to spot the callsites
where one actually has to think about what's happening.

Patrick
