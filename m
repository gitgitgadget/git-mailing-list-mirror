Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D67B2AF0A
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 05:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742968487; cv=none; b=R7V2PkAJSYEj4MKnGWg6XnBG/FqD9C3G17ootuz4DvCHfzbJ3eHmwYhDpM+V47EvvC961rvtAzmxZPhq/QJrIpjffGK6VFbHOcpcg9UMdU1xtR8OZ7sOKoBfIZNGesamM6bQxoh8UqxU+mkRd/VnhSiWNYMF1atwM6CSRPhbhpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742968487; c=relaxed/simple;
	bh=V43Sl7IUIoyLnEwlE3+63+hhPy/F9+XLr7zaP/TjYhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FybT91j6f8QY4KdXwZBWOrGHyrb/gweXsOcEj8kSnCMBlFKeeAkkRzEMb6Rr/ej0VW6D2RWH3hO87YMP5SACu1Y2cqJXa90fTX1v5tt1DLMA4+PinSy33dFfOPf/UNdnVCpGCgRrKb1hPI/swX/kSj8QnKkF5+M6AWsuKf6/ark=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L4I4sVz/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OjTYhdk7; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L4I4sVz/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OjTYhdk7"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2B33F114020B;
	Wed, 26 Mar 2025 01:54:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 26 Mar 2025 01:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1742968484; x=1743054884; bh=cxV+mfu5ge
	KN0LNpgpVt4hl3Jff1kqNn/PN0dxfDJc0=; b=L4I4sVz/S2yEBWBJp+1PkI0jnH
	qLSO8dXhDjc9OYDeh/i6FjI0DCIB6C1utTlKQA146zP1OVMjFWkWqzDdWXa4w/GT
	JnzP1ny4PUZIIFoDCnlHFZJI+YFiowyKfOil8I2hQt/9mZgO62oBgCU4oHDWn5BJ
	TKoxe5OVk8sxSUXHkOVk33frrrJbwAh9rDyrZjtpRYt/cZtyIr/PvBFqXzjKpEMm
	/FXjmQDjqqJxp0mjAALV+CaOLo6QMbwO6f0tTaM+D/JJe3sWKLjnwmVGRGLgRMuj
	zdbTL0pUtJeOlRcoPQeM50t6l98It2IZIlG3n+aor5B4uWlX61ikR6HG5ZYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742968484; x=1743054884; bh=cxV+mfu5geKN0LNpgpVt4hl3Jff1kqNn/PN
	0dxfDJc0=; b=OjTYhdk74vxsOdaTEeHtM5gMIedrJQr5gMaTjf0rhFEz4v57yN/
	RKoke6UrC3YxMA4wRWHPNhfi4kUS/UssUUBhO+3BHI+X0pJ96C7sWNhAClpR+pSj
	XSoSonjZxnxi/w2dWR8JTb1GhNdmvakGuUeE1frg0mGSyGzYrYh9m6QYVWHd6hRA
	2zPZcC+xJC0iuz7I9UTjDftRyODQjmioKtW1USOdjjjdTiAlmgwYLeDan2r96Juq
	JN62OgRIAcDhH2lnSRRmqIa6kKYrrJoAUWXYwn+RzwyEAQnCvyHllWZPYI07pGtM
	0mGz0xeXgCq80HyN2RF/fELfL9YTpAyQzbA==
X-ME-Sender: <xms:o5bjZ0AR0-NKIjOX6ZFD5JDGamswd2u8s3vOLFwGfObww7hW4q6rhA>
    <xme:o5bjZ2j0U1ETPJuKzsGc6UicvpuUI9GKRj9WZNCssDOCHNkJchvxA1x5nKPFW5kBz
    zyLWFGNw0_5xbUJrg>
X-ME-Received: <xmr:o5bjZ3nYlIWYLoGphaSWnjtjVFZFWWWzHWPx9Wl5zuTgFepNDrVSvLwM0sNzLNd4bvNdijzwLY9LzcFqq1Gf6ASZHrEo4G8cJIek3186I4_4cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieegjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnh
    gvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehphhhilhhiphho
    rghklhgvhiesihgvvgdrvghmrghilhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:o5bjZ6xNTF2cco0ucu9T5ArVuS3gzQIYNo36KQh7rZcND7WKQ1uC-g>
    <xmx:pJbjZ5ReGUbJhOsdvDt-_Ctt5B-qgrZR8VGnTDPvoqqiME69DiPY8g>
    <xmx:pJbjZ1bZHK2DO3Zc1Ij-2s7bBuhhFDtVgAismx9aAOtKs1QKPfqk0Q>
    <xmx:pJbjZyRfcQKwPbT8j8KAKZi7xWh-vT_Y75YfsHKvuFogFXEyKTfY9w>
    <xmx:pJbjZ6Row_9FXynsYP__k595sM8HmJBG5lVY_NvigCm5xmm2aDeONd4_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Mar 2025 01:54:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b68de4a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Mar 2025 05:54:41 +0000 (UTC)
Date: Wed, 26 Mar 2025 06:54:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 06/10] diff-delta: explicitly mark intentional use of
 the comma operator
Message-ID: <Z-OWoK-DlvnxXPkO@pks.im>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
 <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
 <5e0e8325620395196608a0851f1f6fc9408f6090.1742945534.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e0e8325620395196608a0851f1f6fc9408f6090.1742945534.git.gitgitgadget@gmail.com>

On Tue, Mar 25, 2025 at 11:32:10PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The comma operator is a somewhat obscure C feature that is often used by
> mistake and can even cause unintentional code flow. That is why the
> `-Wcomma` option of clang was introduced: To identify unintentional uses
> of the comma operator.
> 
> Intentional uses include situations where one wants to avoid curly
> brackets around multiple statements that need to be guarded by a
> condition. This is the case here, as the repetitive nature of the
> statements is easier to see for a human reader this way.
> 
> To mark this usage as intentional, the return value of the statement
> before the comma needs to be cast to `void`, which we do here.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  diff-delta.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/diff-delta.c b/diff-delta.c
> index a4faf73829b..a03ba10b2be 100644
> --- a/diff-delta.c
> +++ b/diff-delta.c
> @@ -439,18 +439,18 @@ create_delta(const struct delta_index *index,
>  			i = 0x80;
>  
>  			if (moff & 0x000000ff)
> -				out[outpos++] = moff >> 0,  i |= 0x01;
> +				(void)(out[outpos++] = moff >> 0),  i |= 0x01;
>  			if (moff & 0x0000ff00)
> -				out[outpos++] = moff >> 8,  i |= 0x02;
> +				(void)(out[outpos++] = moff >> 8),  i |= 0x02;
>  			if (moff & 0x00ff0000)
> -				out[outpos++] = moff >> 16, i |= 0x04;
> +				(void)(out[outpos++] = moff >> 16), i |= 0x04;
>  			if (moff & 0xff000000)
> -				out[outpos++] = moff >> 24, i |= 0x08;
> +				(void)(out[outpos++] = moff >> 24), i |= 0x08;
>  
>  			if (msize & 0x00ff)
> -				out[outpos++] = msize >> 0, i |= 0x10;
> +				(void)(out[outpos++] = msize >> 0), i |= 0x10;
>  			if (msize & 0xff00)
> -				out[outpos++] = msize >> 8, i |= 0x20;
> +				(void)(out[outpos++] = msize >> 8), i |= 0x20;

Hm. I think the end result is even more confusing than before. Why don't
we introduce curly braces here, same as in preceding commits?

Patrick
