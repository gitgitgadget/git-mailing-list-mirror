Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF99B1CAA6C
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 05:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742447640; cv=none; b=iCTW0vZlBS1ORly8+JFAfE1X2AZAqwjHAzTNcpxf14oq4FESYQCZIt3GwBpOc7YzFF7hU7H+NS6bxuMO8/l6wcoxQZosUqMkamj3Afa11fRfFH4oClPou2nkpsJAz+46mMv6hOonsa9uFQGB/bSDTVTP8GD1RfSlVFJeZ1wTzlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742447640; c=relaxed/simple;
	bh=/sIQAi7KtPGy0YIrn3qHljJ+rPlPfOlgmcpObR+lIzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzak6KVAe4cBZ314pbP0xQnCJpp6R2h0K7SWUP64WFC9TgoRfOolG3LehXWLnGTKDcOotP0+t3MnfMlv2hwY5OLZPE0W8gLXQ1D8V6pk7cpde2/U9rHSUDRWSyeJqOpBBXifZf8uKF1SMgFGR8HBfauWXyoMU+l2RXROHev73E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T3mXyUKu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iSCuaold; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T3mXyUKu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iSCuaold"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B459B25401EA;
	Thu, 20 Mar 2025 01:13:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 20 Mar 2025 01:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742447636; x=1742534036; bh=bNGOxgeN1y
	sgfizHcMZ6dg+PVRTA+cN63wypddbxbKs=; b=T3mXyUKuC1daCQfcHUjbeZPDxI
	QVQ7Hi/Vv2plPeHZNnE7PfUodUzI1CBFfp/Jz/KO7o2XNSiFl/tY7+5drUe3OEAq
	EB3SXK6fDAFwPOlGPGUEcW0cqlXwwb8z2Ft9H2eZoUBv4lCnKH6ED0STe0wpF9/N
	63rzKYMPv4aVTSsJ0UkhMJZV6s/HETqdLay9wYeLThyLtHeKkXXgiyM/1KZzweEU
	vhSjh3/cs9On4/5jMCS0pVANLoWoppjtxKvxeOr6S4uim8n0hFsYziPNSgY7jxop
	X+qHw4j8gPDTolfBfRWxXhESGXDUu118yvYYGPs9Xn149I+n9cWeHR6LwH8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742447636; x=1742534036; bh=bNGOxgeN1ysgfizHcMZ6dg+PVRTA+cN63wy
	pddbxbKs=; b=iSCuaoldOJ8Zz0JGU25jYU3pH4rYJ0L9Rg1yeF2zfOW6NPlQJTO
	+FvtG0GqLv6gr+Hn80wPLaTRE+g24H6f2HGZyy5Occ9XnNZofihWF6TOAm3zOin/
	6LbF1zYly+b4PnxvGD6Y0XErTSGr8d2g8jnlAIyv9N0GuF0V1UjTx0PG6FdHgOoZ
	wzj6kFgePZRAX1v22s8sNDjpiXE1qODKtAXwpXm0u05nAeHX7V0u1GpD33HoXX6p
	RBWh+nvaeEdfWtsRduzGrNQgawIXy4nRZlfY4SIS8YbBLrsBScLY8Bm30UJ7EPkp
	8UxyP0sEqFzPKyLYuQGeqEHy66W7arV3hNA==
X-ME-Sender: <xms:FKTbZzokpv4K7soSLc3nUGU1r0gvz1byiwnWW9Iscfa5-7rm3F2kxQ>
    <xme:FKTbZ9qkt6pgCy6ylqivIUqU90VypldVTNZYWbAmdJ_RxJ0d8gmvd2xypOqXEB8cN
    GKfkQl7JoQUx_-tWA>
X-ME-Received: <xmr:FKTbZwNlpaq6KyqymNg6xEuJAKX6O3i6QLHkWAJgJYqymCP0HzFN4xJ4K6xzjVtM1Bjxcwc-t6pRaoiTp9xHiVWMSi3Ep7q9yn-zFTHThQrteZc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FKTbZ24g1D6-OmfhC8ZyC2IbhGPCI24GokjeET7NRJcT2RyogtE2hQ>
    <xmx:FKTbZy5nINtTNgkkyhC3LVaphEC_G9TbDs6yZjeATu-vsr1EskCbbw>
    <xmx:FKTbZ-jezezPGUtlQqk2ZGI5l2sOT1gTK_dJVttgnzZ_JkVRPOK2Qw>
    <xmx:FKTbZ07qaepWY2GIfqg3iv4vrBMpoPdpN6yNR_4a_hpnAav72se8kA>
    <xmx:FKTbZyHss5fpIQKQJ0ANuYGHupY3p3_CBZBfcWb68FHJs-FeOraRtStA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 01:13:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1c4828c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 05:13:54 +0000 (UTC)
Date: Thu, 20 Mar 2025 06:13:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] clone: suppress unexpected default branch advice
Message-ID: <Z9ukEUvuiPUQ3eiI@pks.im>
References: <fff634dh5qeb4rgjqn7cru7v4a2voj4us4thvwtttxjcdnu2bu@jvv3htcon2ul>
 <20250320014646.2899791-1-jltobler@gmail.com>
 <20250320014646.2899791-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320014646.2899791-3-jltobler@gmail.com>

On Wed, Mar 19, 2025 at 08:46:46PM -0500, Justin Tobler wrote:
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 9eb66234bc..3b166b05e3 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1523,7 +1523,7 @@ int cmd_clone(int argc,
>  	}
>  
>  	remote_head = find_ref_by_name(refs, "HEAD");
> -	remote_head_points_at = guess_remote_head(remote_head, mapped_refs, 0, 0);
> +	remote_head_points_at = guess_remote_head(remote_head, mapped_refs, 0, 1);
>  
>  	if (option_branch) {
>  		our_head_points_at = find_remote_branch(mapped_refs, option_branch);

Makes sense. You don't have control over the branch name anyway when
cloning, so it's nonsensical to print that advise. Another subsequent
step could be to turn the `advise()` into `advise_if_enabled()`, but
that change isn't really needed for git-clone(1) because there wouldn't
ever be a reason to print it.

Do we want to add a test somewhere that demonstrates that we don't print
the advise anymore?

Thanks for fixing this!

Patrick
