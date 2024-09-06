Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25951CB139
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 10:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725619617; cv=none; b=i/NXUnHbJ8NVj5VqbyhXnrIPbyv6Iyz4XCb4hceD+UWTdqkNdA8LfLjf2RdWR7YqIIJe6P2QVXaNLXKiwn61O/65rInLr1SH4mlQD/1u+k6iHUEXNHFvwAG8RDS8pH+v5DtNRZoWpQH/lwXI/FXKYBbOitpIX9/SB6xwdN55GRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725619617; c=relaxed/simple;
	bh=kQ5+LNl7HZZqr2R9N8fo/yU8TEH/By1ZzdrrNZuB/MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nktZdMIxdhtRtJX5spw8UPH2puxyGvOSDFS0tOmxHIA9POhq7Eu2tuvcs+B6qhNRve4/hRJTRsH7tC7nTZ170OMLoQ8di0LicJrbTxq3pNEnoHMsW/dlHwX8dR3uWZMxkoLhokivxhnDzF61dJZKJiJKTudHycBoJ+uODRyBBMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MitADR7A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mhkJQA11; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MitADR7A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mhkJQA11"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id D09E113801D0;
	Fri,  6 Sep 2024 06:46:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 06 Sep 2024 06:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725619614; x=1725706014; bh=eacSA0hm65
	cnc4RsVho2GBI9qUyY1tqBWq3aqGFX1oE=; b=MitADR7AcHP5dl2Gmq2w9e5Q48
	AQDpdaGZxR/q29O6cyY3pyV6UW/IrFZMQmeWi5rprbFMrgpvTHhm2S9Iq/8u74SI
	pNPN3khQbGxIBZem6nvQD2+P9GoJcC9J8shtjG79f+Z1siQeFgC36+v/5gFUPlaK
	7vAeOXaq9hQe125uvnVNdNhADMHSxVb29ihOaV2PFbo9ys9VQfS+seTkCCmG7E6s
	CAOiRZdRVW7dnfRRJ0I8DBVSHi+PpJNNZggOj6tjSCvoPelLr5Rcw0JHol9Bw7Px
	kN5GTWFzUrNnZu1tft2/OtnM3svjLtCyc2xT+ZWIpZFUL8H1PanIEdUNYhLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725619614; x=1725706014; bh=eacSA0hm65cnc4RsVho2GBI9qUyY
	1tqBWq3aqGFX1oE=; b=mhkJQA117EKMJNf/CkpqQJHkwpXy8frL/WYdm1k3BKNR
	5SA8e7CpCF/j1lsy00s/v2Md9tehmW/qK6QrGbkUmZDf+mUQqYazgiFqdb1cnPPq
	qWYebt+YJBym4tIcn1HiOUGFHwGWAz/iS0EYLZ0/yo/gl2Wv1CRMP6LIlPJz6eFC
	V58JhTAdO37qR+EqaKopLavhhv6fndzyO4jGG8i26BkXw1BtydQRJGlpPpCrb7rq
	qRBtn1dQeeQm23HdlWBcBHqQHrcQaOgTJfhgZmWwDDcLTa5ZrJ/p1Jsh44juL0Sd
	Ubz7oYk9K6x6p+msVUDfe7tIBxFBgzFyjDC+nu1ZyA==
X-ME-Sender: <xms:nt3aZnXadoPwDjiczDhyASg1QTTI8RC3hgwGMrvvLqDT5LHl5EIukQ>
    <xme:nt3aZvk9suOfdJRuk_e_cZvBNXpBWh_rGbFbhRoGhBSPfdDwbyk_s8i-b7bgKmAmo
    pCseOia33FaNtNp_A>
X-ME-Received: <xmr:nt3aZjZxfh3HqbE49uHh4dmTpRhnQuS8nLWRn0cr4XurCDhmKngVyJ8_zlfSLj6IfryIURSXvfnaYiJacP6EaY8jXfZK--zU-CaJpwKZNtWt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiuddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepjhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:nt3aZiUkOJ83JJhL5hNqYfKX9vxnRYyatTS5lE24-tKlMAG9bvzJig>
    <xmx:nt3aZhlmwN_zMWoC-sPmN5OuZcsGryYs0SreiO1iCjO3LosUPvgH1w>
    <xmx:nt3aZveKmG7c0eo3R5PuCtP5i_N5ey94LiGeM8GD-9OOeOKgdq80BQ>
    <xmx:nt3aZrGmHuSQDcShcTMVmhynmcv2JidcmjennXEL7T4Odd5NPc9afQ>
    <xmx:nt3aZni4VGTjpld5VrtoGlRl2dOiuhUPC2AX8UyEZV4fwbfDYQJH0F-G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Sep 2024 06:46:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b36cc478 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Sep 2024 10:46:40 +0000 (UTC)
Date: Fri, 6 Sep 2024 12:46:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 3/3] add: pass in repo variable instead of global
 the_repository
Message-ID: <ZtrdnFjFeWG7asio@pks.im>
References: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>
 <bc9090469340fe2bead812918d149287dcda5609.1725555468.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc9090469340fe2bead812918d149287dcda5609.1725555468.git.gitgitgadget@gmail.com>

On Thu, Sep 05, 2024 at 04:57:47PM +0000, John Cai via GitGitGadget wrote:
> Fr> diff --git a/builtin/add.c b/builtin/add.c
> index dac832df3e7..a68fd7c8313 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c

One thing I'm missing in this patch is it getting rid of
`USE_THE_REPOSITORY_VARIABLE`. Without that change it is impossible to
see whether we are now free of `the_repository` in this file.

> @@ -36,24 +36,27 @@ static int pathspec_file_nul;
>  static int include_sparse;
>  static const char *pathspec_from_file;
>  
> -static int chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
> +static int chmod_pathspec(struct pathspec *pathspec,
> +			  char flip,
> +			  int show_only,
> +			  struct repository *repo)
>  {

Nit: We typically tend to pass the repository as first argument. Also
applies to all the other functions.

> diff --git a/commit.h b/commit.h
> index 0e5fce543c2..92fef717be1 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -2,6 +2,7 @@
>  #define COMMIT_H
>  
>  #include "object.h"
> +#include "repository.h"
>  
>  struct signature_check;
>  struct strbuf;

There is no need for the include here, let's instead add a forward
declaration.

Patrick
