Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CE341B37A
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388415; cv=none; b=WtC1U8CGCyCoakcNwTHv3ZQbQ1FA1J28yfKdTAaNxNtKkE9JQqeBzKEwYYUyFD838nmUw0KzSeLZS8Cht0/R4UvlX7YSu+1uw30eD66rnMH9ksehwWD6iJ4DfixhAs8me/IINABdIAvIGHhu4/MrTKVxJXiqBP6ajIvdgTudgAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388415; c=relaxed/simple;
	bh=EK74SK83ewO+n3Oecy0d3KLfNukJXsJN66Vb3VfdfLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kznEUe4dtpOMpC9Hz4houRuo5gku0dk8MH5gAgF6DqKLGHkD+74EdC40SJv8LQdgv+x+QRjaZY8yRxfO0xDqn3Xw1lI02M3+Q3FiiQw16TiUX75StXkyyYKrhn/u/EgrmklCUt73PPQKEnFsdBFlFJpoDSLps+V9ipcF2RrAaxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gk0x5bo/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eK9xcLSB; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gk0x5bo/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eK9xcLSB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A9A1A7A016E;
	Fri,  6 Feb 2026 09:33:33 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 06 Feb 2026 09:33:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770388413; x=1770474813; bh=L1uueFx5ld
	AUzqK4zB/eNlxQey8dh4S8eELQg75jkWc=; b=gk0x5bo/wwTj0tcOpzP0tgdi+s
	6uCJJTfE1Vqg/tWZInZAri8bC2IKwQlj7UnTG/TSuvjYNrQb/8GGecrV5WEVVTsg
	Sq6MvoaretDTxnEcTw62MoYkAfNTePEeENc46N4oGT2rxO8OPaXE77OQdKLdjiJx
	kjZiqdKICan+yxsoDKNSrvE78PixhQ7EIjj7UMopG0V+WxggLeZJFa9vmtIKa6KX
	zEEFdBWAeLa3EIoiHJ7KPidPPcCeROQnKQdy3E4Vcce2givYGCEfdQGXgVv2TfkQ
	ex/vRUIeHlrt/Z+E0hdxpPv0et8lby5lEI7f3WUBfD+dm3Iq5+XiDWV+ZJkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770388413; x=1770474813; bh=L1uueFx5ldAUzqK4zB/eNlxQey8dh4S8eEL
	Qg75jkWc=; b=eK9xcLSB05KeEZD1PBx8px6jySd3Aka+UrqiffisRXHBbXuxNyK
	M9g0YfSB1OSZhCpiiY5yXEFv6TaavKgblGbbyYU/rOIJwNtO7mgRSk5YT3t7COda
	uh3lhNO6aIuqZZa7M1LHVPEHZkBmupzmEsNDOd2M/hvpc/vYgZ7/+vZ0wc8+7isZ
	5UtnvmpxH1zxikNRdjbU4trgdA0ft3HJMW1o0gLSGKgrUHee6PADfFAgrc0RE8li
	MkCy1xIsU/LjBhRLWFyr/L49AGH7kp1FNFBgktfdxPFtspfAHQ4EG66Z//vf0x4V
	rWGri+RA+k83mEkUBnmQgXYgvbCc/UNICAg==
X-ME-Sender: <xms:vfuFaRxzF2kdukeqoiOraHNolpiHZI0DzVXgoKmdIQPVPhOaqaHMTA>
    <xme:vfuFaYsiCejvUJRJywaGH58UnPIMZvOrrjfK7TKhzwSWorNp5NKOeaoQeCABZeuHi
    4oITy14K4OXq3QMKoLkaaUYCIltB6YPIpE-0M_fa4rLIYAuAuOp-A>
X-ME-Received: <xmr:vfuFaYufjpfTW7WZ_d61So9JQpDD94PmXDUblpI7h0Q_qhN4p1lmYHg7ZaL4BUVizW6Wai9UYYjHN1NEcNWiVBwm3hcoUFssH1pz-FzvpIs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:vfuFadNT_zFvQV59E0SLkextSqGPkgnlQ_vEMyUPR1jvstkfET1PUw>
    <xmx:vfuFaW2-61mrT919598j55XUtfNbp2uMnMTDyAZrnazXVTad-v7a1Q>
    <xmx:vfuFaZODgzObFip2KGNWeZX-p5v5WszDWg3AzhviIsufDkpTNmYjaQ>
    <xmx:vfuFaW0hjEr9VQpRYux2psk_YuAvJXYfsyrmFgkH4a6NaZXmPH917A>
    <xmx:vfuFaYtInMRFGsws-Or7m6SFOos-QkWKcYHV6sDwn4YVMW-vk3pcWhIx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 09:33:32 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id acd62d0b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Feb 2026 14:33:30 +0000 (UTC)
Date: Fri, 6 Feb 2026 15:33:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v4 1/4] refs: allow reference location in refstorage
 config
Message-ID: <aYX7sYaTp6cArMxA@pks.im>
References: <20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com>
 <20260202-kn-alternate-ref-dir-v4-1-3b30430411e3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202-kn-alternate-ref-dir-v4-1-3b30430411e3@gmail.com>

On Mon, Feb 02, 2026 at 01:26:30PM +0100, Karthik Nayak wrote:
> The 'extensions.refStorage' config is used to specify the reference
> backend for a given repository. Both the 'files' and 'reftable' backends
> utilize the $GIT_DIR as the reference folder by default in
> `get_main_ref_store()`.
> 
> Since the reference backends are pluggable, this means that they should

s/should/could/ I guess. It's not like they are broken currently, we
rather want more.

> diff --git a/repository.h b/repository.h
> index 6063c4b846..c648dab196 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -150,6 +150,8 @@ struct repository {
>  
>  	/* Repository's reference storage format, as serialized on disk. */
>  	enum ref_storage_format ref_storage_format;
> +	/* Reference storage information as needed for the backend. */

Nit: it would be nice to document whether this only contains the
additional data after the schema, or whether it's the whole
"files:///dir" string.

Another nit: ideally, the step to pass through the payload to the
backends came before this patch so that we could already make them fail
in case they are passed a value they don't understand. Otherwise, a user
could now pass "reftable://foobar", and the "foobar" part would be
silently ignored without any kind of warning or error.

Other than that this patch looks good to me.

Patrick
