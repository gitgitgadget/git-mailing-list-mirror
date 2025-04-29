Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDCF1E231E
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745923579; cv=none; b=EharLrCEadp1ZfmvfB9oBGDyEySPiLjW6xr1plsRD/5gTwwbrlfeF2fiQgXVB2+L3Feuxu9mcvNN+cFVBwReLLZayPrUmUT4js/LW/ldZUb7wWrQqMbEd3I8ahDMOBSeRcdOw2TI77gT2u70nJdL/gZyvUx8p2elJo5n4nSBhvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745923579; c=relaxed/simple;
	bh=oTzCgu3wlabTyhRYI1FkTRH/Os+6vu16b9x3ofY0eN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQQFVUSGDVFh7GhzjP+cmyy0Z2om42m8BkY8f0VZytPs4vHS3JK7247mgydInAGKkdrPKC1yVmaQ6yITujCoEMgQn0fpYumhzVc73HmMj7baE+1bZDFsbPdK16+8xIIG5KjMQzXzXQJMIcHE83ZUklY2qC3xHOlpBclj4Sx47QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WzbOOWyl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AtAvIPIh; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WzbOOWyl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AtAvIPIh"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A759E1140167;
	Tue, 29 Apr 2025 06:46:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 29 Apr 2025 06:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745923575; x=1746009975; bh=JCa7G/w+JD
	VJdaPgy6u4RzCoA0hZQhAvJ40MmYRx4kg=; b=WzbOOWyl7GR7EU7452VZu4iido
	9O4qYGn0d1KyJYhzcGfscUylBo3AGEVnW4z47N04Jw9yKyxHwRdm7rawmqf4s2S5
	1cGw9C87GV2NrZ793UhN+/s7uAo8VtJz3IqHSZqnkq7R8wfcv6/uVqNngg+EzyOG
	N75UIyayG6+lTkC5umFoSKYR+o43pcvPMdL73gA5lWFfBM7jZP81fpSgYJNUpcwq
	Dw1EOlIwj2whJGb/Ao3XJADG4NzbumO5nPAJi1RNFzfFFVq5GLbHcvhqprTALDWd
	znQ3Z3Rkv8G+vIvlrF2KBuZZxOEfrcgogMnH8GvJSDlpIJTKULXUom6yc3yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745923575; x=1746009975; bh=JCa7G/w+JDVJdaPgy6u4RzCoA0hZQhAvJ40
	MmYRx4kg=; b=AtAvIPIhWTwrrNI9zEKbmWnuhovCHQT/+Y0MQwgYlOWE8s9DCSl
	r3jhgsAp1VhYjq+L2lDsdzAQl/luVDl2g4tKJGyHUisbMOERPS/LEkwZCHMqTxnV
	vh0IQiEZtzZkRMnLTHaURmNic+gZOjJUgWhDS0mC61xSLAECnLC/wRgXTcldZq7j
	LmVeqB6KZLi8Yg+kShowMyDtnb3ew0WRAr4TCI59/9Rknv6f8nTv9qsxqV/sO7h0
	VAdD0z8J+22X6PCreYKFa+mzGeJfpuYeVpnJtKG1weO/SZjDf8SFgt51m66wUHla
	YhciJPI/XEece+TvfzeqClMFX0bnAcTkgJg==
X-ME-Sender: <xms:960QaEAaCcNYlzJlBFJm4sFdR97IQpVqgED_DLQdg0EItmd4rK5_ww>
    <xme:960QaGjJazO_3bavtFt6jI8F74wLsJSnymcetKCLaz-Nv8AVOHncZ9U55WZkK8nBV
    Yths7DsN49kU4jOAA>
X-ME-Received: <xmr:960QaHmJGI8mHglW2peY_uQFBJS5WK_r0ZghqKsZNBS0OZqsFa6WVGm1J0-bqFvMyEcjB8S7q8c1qhqYoT5RUXo28wIIMd9h0ri8apP_aeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieefieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepthgroheskhhlvghrkhhsrdgsihiipdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:960QaKyqZOe1Ku7GYKflj_iEDU1wlz9Ha89TAMuTzmz6WEqheENMwg>
    <xmx:960QaJT3BrIOs_KEge9q9OYdaTfn5d4qIo5P043A4Wmv2P60eUtAMQ>
    <xmx:960QaFb-vCTYArD5yhFuF_-HsYbRKf6511gD1wXmwci7kUliYLIsAA>
    <xmx:960QaCQg3-7VgeBFUvVFCThfCDpj2c6UiqL27lQyhLmSt3elCM7luA>
    <xmx:960QaE8oHWybSaoPjf-mPTi_-3kWBFEz8IQzRaXGRy4NK3EXUS7_GhtX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 06:46:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7abc82b0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Apr 2025 10:46:07 +0000 (UTC)
Date: Tue, 29 Apr 2025 12:46:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH] replace-refs: fix support of qualified replace ref paths
Message-ID: <aBCt8YrqJ7IM0ld6@pks.im>
References: <pull.1903.git.1745651452869.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1903.git.1745651452869.gitgitgadget@gmail.com>

On Sat, Apr 26, 2025 at 07:10:52AM +0000, Tao Klerks via GitGitGadget wrote:
> From: Tao Klerks <tao@klerks.biz>
> 
> The enactment of replace refs in
> replace-object.c#register_replace_ref() explicitly uses the last
> portion of the ref "path", the substring after the last slash, as the
> object ID to be replaced. This means that replace refs can be
> organized into different paths; you can separate replace refs created
> for different purposes, like "refs/replace/2012-migration/*". This in
> turn makes it practical to store prepared replace refs in different ref
> paths on a git server, and have users "map" them, via specific
> refspecs, into their local repos; different types of replacements can
> be mapped into different sub-paths of refs/replace/.

I wonder whether this really was an intentional choice or whether it is
simply a bug that led to useful behaviour. In any case, git-replace(1)
itself does not mention your behaviour at all -- it simply talks about
the "name of the replace reference".

> The only way this didn't "work" is in the commit decoration process,
> in log-tree.c#add_ref_decoration(), where different logic was used to
> obtain the replaced object ID, removing the "refs/replace/" prefix
> only. This inconsistent logic meant that more structured replace ref
> paths caused a warning to be printed, and the "replaced" decoration to
> be omitted.
> 
> Fix this decoration logic to use the same "last part of ref path"
> logic, fixing spurious warnings (and missing decorations) for users
> of more structured replace ref paths. Also add tests for qualified
> replace ref paths.

If we can agree that this is something that we want we should definitely
amend git-replace(1) to document this new format.

Which raises the question: is this something that we want? Are there any
arguments that would speak against loosening the format of replace refs
now?

The change itself would be backwards compatible, so any old ref that
parsed as replace ref would continue to parse as one. But the bigger
question is what happens when using an old Git version or an alternative
implementation of Git to parse such replace refs. How do those handle
such refs? For old Git versions we know, for alternative implementations
like JGit or libgit2 we don't. My assumption would be that those simply
ignore the new format, which raises the question whether that is okay.

In any case, we should provide good reasoning why this change is okay to
make.

> diff --git a/log-tree.c b/log-tree.c
> index a4d4ab59ca0..6a87724527b 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -163,10 +163,11 @@ static int add_ref_decoration(const char *refname, const char *referent UNUSED,
>  
>  	if (starts_with(refname, git_replace_ref_base)) {
>  		struct object_id original_oid;
> +		const char *slash = strrchr(refname, '/');
> +		const char *hash = slash ? slash + 1 : refname;
>  		if (!replace_refs_enabled(the_repository))
>  			return 0;
> -		if (get_oid_hex(refname + strlen(git_replace_ref_base),
> -				&original_oid)) {
> +		if (get_oid_hex(hash, &original_oid)) {
>  			warning("invalid replace ref %s", refname);
>  			return 0;
>  		}

It would probably make sense to pull out a common function that parses
replace refs for us so that we can deduplicate callsites and show that
all of them behave the same now.

Thanks!

Patrick
