Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A1280325
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 07:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771313060; cv=none; b=rzyJ6CF/UXZE2tK6xp22YE4dpOxXpRLjA+SPUsXQs0zOEo1e9GkrSyDvuFIX5MWePhmq7Ig6cVccfl2/JLf9I+UAZQsuLsDM4uSXt3S9CaUTPa0bu0QyJgQosbv1a36b20jd1PZHYhSwtAm85LmZz22KUkderAs4WVHqNNBes70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771313060; c=relaxed/simple;
	bh=0LUj8YVdMh5nfLzaNDcqcAe8VFku7piXHU6V67AtE3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWgFthcgVn08gQxtUI8jXe09ZRTVOg0GxOup7XxE8E/PJkIcre4Kzw8t2bZoNDCbdKQuyW1iJqMduWGaga82wvQXje6wgDSa5GEKlQDOkhskgGES8rRmLVgUtLwF5aWwl5R6OHDbUrNPq30zglvvwIq60IVmzskvBHI9zaqYRRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mjTdc0xx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q48aOuyN; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mjTdc0xx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q48aOuyN"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 61F061D00351;
	Tue, 17 Feb 2026 02:24:17 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 17 Feb 2026 02:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771313057; x=1771399457; bh=tu3lNz0smC
	fqPt+xRyWy13qkrQOliy6iTh911SaQ5vk=; b=mjTdc0xxBWLWjFJvlz29Sl3Z4/
	X7MkBQdI46T/V3o69u3Al6SAmK4QazHQWQTzTt7vHzkDXgXeI8ai/b6oWREYXttE
	lwdXsJffBsjH4B8YwF0KHAfIvkArsKLroQ/6l02arcLKO3jyGVqpHNe2r4TDbgQA
	RbVLXOjte6x9e55fRoyaPyyZ9DdsVuXQukc9kf70sgNNnv8SrUP5xuca6KAe6ERG
	X3+Deq8TEC8AZt+hsbyvDCKVPnM83vlatOBJkLio35CPN4UV0uSvdPTurehIEaxR
	6OBWXZxkKR3pA84gZwYNR1j2fz3D+WmwuV+eyQM0nE5VCPbsGsoFVqHHRIew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771313057; x=1771399457; bh=tu3lNz0smCfqPt+xRyWy13qkrQOliy6iTh9
	11SaQ5vk=; b=q48aOuyNFiUyLAMd6XXC0vVGZuQmtj4i/J1dTrnpHYMHsZVDG2h
	h6Y1byoJwF6BlrwrjPNHPjliGZVyr00olW2iMbM4XgWRlqPSJWdVhjjj3cweao6p
	9PxUC6iQ3N2iV0BjymCiQtPhUV18e/3AOXfMb5ZrmzgzfLe0Sy0TKtqZKr12JMt5
	z+5bjah9GWuLO40SwepUksJRpkwv10QW5cfxmJt3obvBqCtaHiKekz+aPlntDEGa
	iksmCT9PM5I/ANSvPldttI0TbQ7qYCFU2zMifE6bN2/6GX0TKQFnzXmzaBK5ifAW
	SwT0mnk7rB0Btp2kbV0qPxzy/nARgaYnQ+A==
X-ME-Sender: <xms:oReUaXIYIzDV_CK6OsoplgQMuKH0UDtxrJrnWF3Uv35qRGs4k6tXyg>
    <xme:oReUaSKVLs_xdSHW5BCRMdIQWcJb1xFnOn4XKrAQXslbKAX0QStQj2MxzR4KwwJ59
    UC7OML3EKC-Ounml20AfN7ep4Hh3K1GbGENrzses22hudgQnPcNXg>
X-ME-Received: <xmr:oReUaUsZFHZHSwQisdjGPYgS1Zr5MBw0L17dmafZfPqBsAP7lAUve7HkoznCto8GPWTOq248dudmXF46Najlu1-XTBcuMDuHEKOtrmVVpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudeludehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdr
    fhhrpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:oReUafQ0jIkycCtM1Gf8tkUac_D20eTAP-A7MdIUlYzeXhZKC-qcnQ>
    <xmx:oReUaaP5dp5IdHXDJIIu1ZpzjFgCZdg1O5AZCdNn_EC3sraY6hCSbw>
    <xmx:oReUaUYKyycdTbY6UJmv_NltDwn5Glr7ty4B2Ab88sUQGLvd5LS70A>
    <xmx:oReUaUxXIREOrUbcv-5HM1v_hDOyE8n9-8jkL1E9zwzvCePfLgIzuA>
    <xmx:oReUadsNq9Uo0XiltNAocKo5mhdPLTSYNj2S2YRdMrmMsT9uKF-qGKPb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 02:24:15 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0436adae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Feb 2026 07:24:13 +0000 (UTC)
Date: Tue, 17 Feb 2026 08:24:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	gitster@pobox.com
Subject: Re: [PATCH v6 1/6] setup: don't modify repo in
 `create_reference_database()`
Message-ID: <aZQXmvZbVT1eRtSH@pks.im>
References: <20260214-kn-alternate-ref-dir-v6-0-86a82c77cf59@gmail.com>
 <20260214-kn-alternate-ref-dir-v6-1-86a82c77cf59@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214-kn-alternate-ref-dir-v6-1-86a82c77cf59@gmail.com>

On Sat, Feb 14, 2026 at 11:34:14PM +0100, Karthik Nayak wrote:
> The `create_reference_database()` function is used to create the
> reference database during initialization of a repository. The function
> calls `repo_set_ref_storage_format()` to set the repositories reference
> format. This is an unexpected side-effect of the function. More so
> because the function is only called in two locations:
> 
>   1. During git-init(1) where the value is propagated from the `struct
>      repository_format repo_fmt` value.
> 
>   2. During git-clone(1) where the value is propagated from the
>      `the_repository` value.
> 
> The former is valid, however the flow already calls
> `repo_set_ref_storage_format()`, so this effort is simply duplicated.
> The latter sets the existing value in `the_repository` back to itself.
> While this is okay for now, introduction of more fields in
> `repo_set_ref_storage_format()` would cause issues, especially
> dynamically allocated strings, where we would free/allocate the same
> string back into `the_repostiory`.
> 
> To avoid all this confusion, clean up the function to longer take in and

s/longer/no &/, I assume?

> diff --git a/builtin/clone.c b/builtin/clone.c
> index b40cee5968..cd43bb5aa2 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1442,7 +1442,7 @@ int cmd_clone(int argc,
>  	hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
>  	initialize_repository_version(hash_algo, the_repository->ref_storage_format, 1);
>  	repo_set_hash_algo(the_repository, hash_algo);
> -	create_reference_database(the_repository->ref_storage_format, NULL, 1);
> +	create_reference_database(NULL, 1);
>  
>  	/*
>  	 * Before fetching from the remote, download and install bundle

This is case (2), where we set the ref storage format to itself.

> diff --git a/setup.c b/setup.c
> index b723f8b339..1fc9ae3872 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2701,8 +2699,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
>  				      &repo_fmt, init_shared_repository);
>  
>  	if (!(flags & INIT_DB_SKIP_REFDB))
> -		create_reference_database(repo_fmt.ref_storage_format,
> -					  initial_branch, flags & INIT_DB_QUIET);
> +		create_reference_database(initial_branch, flags & INIT_DB_QUIET);
>  	create_object_directory();
>  
>  	if (repo_settings_get_shared_repository(the_repository)) {

And this is the second case. We call `repository_format_configure()` a
few lines above, and that function calls `repo_set_ref_storage_format()`
itself.

Looks good to me, and a nice simplification. Thanks!

Patrick
