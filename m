Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53CBAD5A
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744013007; cv=none; b=T79ufM0nDVnyyjUxCueR38EbWI8bWRuzXB7xuG8s5+l504Wa+npc73HS2RCoXjb8XawUw0et44RJjigJozjhmIVrmXtff2XohXM8OmInuwNleHOUH4J1VQL8GQC0xyLCJno28Ple5d4omg6LtKhuG+FD+F4p+SMGC0UtMH/57YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744013007; c=relaxed/simple;
	bh=BZVyofcFunt3CyJ6jXELnQ8q09vCJurgI7nAL5BFrMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcfYrWqJS2HOnMum2QNEHHa++053D+/hbnEKTNjK/1B0NL46dE1I3vxNf3SyMmi8bXwieOyPvxCh/2rl/qyxKI8aehxzgNd5fd2X1+nE9KDQKdIZmC3aeALztnVQFQiQY3xsRllBUWsrR6QZu5EpSBVaIduwfpkqEmMHjUrOws0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hwg2ysNS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cgugwjES; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hwg2ysNS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cgugwjES"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DF55711401FB;
	Mon,  7 Apr 2025 04:03:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 07 Apr 2025 04:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744013004; x=1744099404; bh=x+SkMPkxOV
	09z8X6DwcN4PUbMOhUmoJ9yqsQgv4wzRU=; b=hwg2ysNS2aFspT57N/7o3IM7hm
	JUXKYuPt6yJFQ4bdM7MZJe7nBTBr5KRU97LCAb8POTdUE6Ott/8exjgusPuX4huy
	Aggy0a5NrpBlxv7IvNk2iXCRUQvpMUI/cTqNttLLSZx1NcQT6kzoN237K1UMd5Ah
	7SZy+x+3MsCbiLbcIgIQr4Na5r1Ljq9755jBuPsH7f5GTnKoM8tecDW6JjCJx+O9
	Qf2Sc96r0gceNOaZi3sfxy9vAv5M2sfkpJrGWs0he04cCxIZRSqhgG8UEiXflScY
	o43WupSTk9oVQSYNXcU/4dn3UReX9dQc7IzVElCRiLpYTEpldibJRR51Zf8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744013004; x=1744099404; bh=x+SkMPkxOV09z8X6DwcN4PUbMOhUmoJ9yqs
	Qgv4wzRU=; b=cgugwjESrdDurQBWv5D94jVZmUAZRruKB8vU+aXn9jhKEK+ESQ+
	a4zNdou3BNPsFetr21cMM4HhiUBrRVmxJt9XMa3yhMoH1g5QYugKJSDrOuQoVlsP
	Hvk41hGH0Ytcrg15LBNPo1/WxtUrdiyYWHtf4nYx3PqnzlK+Bm0LF/IOYwWUe8NT
	G9CxGi6bsp5h4/8lf//cwFD9Sb7fgRmzYx5TcEBGwmS7sjxKw5E6KxClYptdwM/7
	AzcomI+gYanXh9nPE5t64iYOjaAt+/MUTQHSgd5TFrUarioHxH845NX1WDnHcm33
	t/kT2N/YVbZ3xrtG2Gf/YWFRghJMI1XtIYw==
X-ME-Sender: <xms:zIbzZ6eSa6iMYFW5v5SY_ib6SDSSmJzIT1a3lKvymfWsOL1iNWSl4w>
    <xme:zIbzZ0OXeaevLcZGPFXZyIuknlYmGkd9ZnFXpK5_xbtDzI-XrDDRLahGMpYyYOCWK
    bC9G9tScbF36EGXVg>
X-ME-Received: <xmr:zIbzZ7jxzw9R3VS47NxlbRLhM0E0ZGX1AdHubOQ9R9xCgdnCF1yfrS4V6XQFWDR7AGhy8WBcI5XujBShmhHSYlaveM9lW_jW2Q6_Y4aKmI8b3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleelieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegshhgrthgvrghrnhgrvhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:zIbzZ3-nODkg0o3EhTns1aO3jXWJ3BsMxWT0_doaFbMEA37o40KtXw>
    <xmx:zIbzZ2sv8wqVXD2CYPVcqA0h6iND1SyfB6p5e3bMAh9a8QdaMhz-3g>
    <xmx:zIbzZ-HurydJmXIhaNMHxiUuSWBH0nJPPjVnpn1M3Y6T8LAFP0aTkA>
    <xmx:zIbzZ1NtkL7u2ZwGmeREr3-BHuQQVtPtuXLSBKZIM1He4U9yOfR5BA>
    <xmx:zIbzZ-L6ZxHE5t_WpvXHoNzRz-0A4mcVPMgJgRE2tswm57Av-xBWI5gb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 04:03:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f3e0ee7d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 08:03:23 +0000 (UTC)
Date: Mon, 7 Apr 2025 10:03:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Arnav Bhate <bhatearnav@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH] environment.h: remove unused variables
Message-ID: <Z_OGyqVHaUkFIh1T@pks.im>
References: <2c547567-2b72-476c-9fc5-71cac050fa15@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c547567-2b72-476c-9fc5-71cac050fa15@gmail.com>

On Sat, Apr 05, 2025 at 10:15:32PM +0530, Arnav Bhate wrote:
> packed_git_window_size and packed_git_limit are not used anywhere in
> the codebase. A search found that all references were removed in
> d284713bae (config: make `packed_git_(limit|window_size)` non-global
> variables, 2024-12-03), except the ones in this file, as they were moved
> to struct repo_settings.
> 
> Remove packed_git_window_size and packed_git_limit from environment.h.
> 
> Signed-off-by: Arnav Bhate <bhatearnav@gmail.com>
> ---
>  environment.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/environment.h b/environment.h
> index 45e690f203..cf6fc04e70 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -152,8 +152,6 @@ extern char *apply_default_ignorewhitespace;
>  extern char *git_attributes_file;
>  extern int zlib_compression_level;
>  extern int pack_compression_level;
> -extern size_t packed_git_window_size;
> -extern size_t packed_git_limit;
>  extern unsigned long big_file_threshold;
>  extern unsigned long pack_size_limit_cfg;
>  extern int max_allowed_tree_depth;

Good catch indeed, the patch looks obviously good to me!

Patrick
