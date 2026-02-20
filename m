Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7564E450FE
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575563; cv=none; b=g23nyv0KgRBMYTECo6ucIcmcpKTlfV7R4nmctFt0jR02OHYdytioI6zN0VfjBJv24km8pugGlnjds+YQ3v1oVqL13Enmk0v7oUJEIEodyev9I7bwx+PxP+bXpUGWWfEnDt2VPbN7EP/Uyc22kQORrlxOIoVeTUV+O774TAI66Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575563; c=relaxed/simple;
	bh=NWS176EJDq2ef4r4n577zbUNYH8llxLLHITZO7FZ1Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgiF5YXHqTvz8PjMNtdywoekBx0DtEkA22E09Z3eXjQgT4BqL23i+4JrqSRRqB1G5x3KMnyisj83kE+9sjkbsXQgKKW7UgZCM9MfHDk0R5AdTkozS756KHDtnkzivr9gZH7Adtni4V4Ol4Biocb/1YZa2a0mPBNWs4sWyrsRhLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f6pfpTD3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H64AEzGj; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f6pfpTD3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H64AEzGj"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 6E7B91D0007F;
	Fri, 20 Feb 2026 03:19:21 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 20 Feb 2026 03:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771575561; x=1771661961; bh=AverTw8fnU
	2L7p24wIvBDTpYAJWrApOIlEARPwj8kRw=; b=f6pfpTD3ZKeOdvL5pf2DFdCP9o
	p2hechyy1uR/iLsxtw9B51VlUrR1dfXKziwDYmoq47U9bjxzvc8IITfOB+urbVYx
	jXHktbj5vTnrVea07NqWKTsy25BbGuk82H+1oQxCKXH0Gn9u8pVeFxjgYHA1Ud4u
	0mgxUa7NUY2WMIZzedEPdCp/aaT6qQQbXjN+GNKo1lbSZoHlI/LOXKWPwZqCnERW
	ajqAkMWOg3chfblcUuw/pwgc4utNavy279DciH1q1HUdMPBLy7xwuuuJcBt99fSo
	yVf2n42LA2af8Sl64tX8NFaQc7dP8e3LPlqIk1CjDfofj4BIWcJ80FFWNE5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771575561; x=1771661961; bh=AverTw8fnU2L7p24wIvBDTpYAJWrApOIlEA
	RPwj8kRw=; b=H64AEzGjSQHyj4Dw3Ej3cxaCjS4xvpYJlg5cyOpYIDSu04D1cX8
	P9UzD81jCGBxnoEg2y9RdnyOBqFFKbyM+m14GxoLtysaRlNoJNGM9SEEbPslMao9
	bHIh3iV0EcyRo5P/PHfUf2nZ4hBqcIKwJXLOwzrwuFSy3rMRVcApwZ5v7RBqZQbW
	agxIfwZyOzs+De7Gw3QXdu0bdWwm1QVNDOIrIHm7317PF7MvszYqdnYeua2Rl6r6
	jgWVQXQ2a7QzEJOUb4OgpH2rznp7IvPo1ppF9f9kRO5ckmvJLB49A9c4SNgXcpEY
	RwEArT02POJ28FPHKF4Puu4ShjnY47ZJQsg==
X-ME-Sender: <xms:CRmYaRFZsM4nGWTe6boyHFLK3PIxTOdT9St2v6oP2MZOKCGKJLwbqA>
    <xme:CRmYadXy9a056oII7WZb7DxDoBOadvWZzNXvJIyCb_qzxJTUS6cGWPH8j8kgXcwB_
    wtzqqFbtL621u_YVEKOQ_Sho5Gj8GOqoXpS7wpqtXcQ7pZB75xt3wQ>
X-ME-Received: <xmr:CRmYaYLQKQrGFsyXEZiRwIbtImK899g8fcWAAFgLBZPYkfZQL4_Y0sMRvUqddNqQGr4N4qBBdihT6bAJqyoF9N8DjPs6O36KDnTSEF1kkpoH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhg
    ihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CRmYaV-hGrK3IOrC1A2fN8MLtsPu4uLImq8nR1mt5ROnJgakKGfSpg>
    <xmx:CRmYaTJFJ5VOGNukeFVwqfWaIry920A4v28IXasYUQiY0k2pza5ZGQ>
    <xmx:CRmYaSmwkT667Zgpt8oZER9SMzqZjJt0w1foZ46fu-NEguUd1K_DBg>
    <xmx:CRmYafPqAwRMUSqVQ-JRwjUQWXX5Oiy8k7FR1Um4uM9RgkF8F15ZiA>
    <xmx:CRmYaTrtQyf5BDYrQBUv0N1Gi1rSUWeFiyT9TMOSxXe5m75OHLCLlXzw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 03:19:19 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d41cdcf3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 08:19:17 +0000 (UTC)
Date: Fri, 20 Feb 2026 09:19:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/6] merge,diff: remove the_repository check before
 prefetching blobs
Message-ID: <aZgZAuIlCujcoEIt@pks.im>
References: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
 <pull.2048.v2.git.1771552788.gitgitgadget@gmail.com>
 <7155a0da6f8bcdac90cf1ed085622f2c8b68675e.1771552788.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7155a0da6f8bcdac90cf1ed085622f2c8b68675e.1771552788.git.gitgitgadget@gmail.com>

On Fri, Feb 20, 2026 at 01:59:43AM +0000, Elijah Newren via GitGitGadget wrote:
> diff --git a/diff.c b/diff.c
> index 35b903a9a0..91d81f66ad 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -7176,7 +7176,7 @@ void diffcore_std(struct diff_options *options)
>  	 * If no prefetching occurs, diffcore_rename() will prefetch if it
>  	 * decides that it needs inexact rename detection.
>  	 */
> -	if (options->repo == the_repository && repo_has_promisor_remote(the_repository) &&
> +	if (repo_has_promisor_remote(the_repository) &&

I wonder though -- shouldn't we also pass `options->repo` to
`repo_has_promisor_remote()` now? Otherwise we may support backfill
fetches from arbitrary repositories, but we'll only do them in case the
main repository has a promisor remote.

Patrick
