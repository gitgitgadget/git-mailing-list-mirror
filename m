Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E55737B011
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356766; cv=none; b=APyiHSux7za7Vi3BNohE8PsYmTmIoepQ3ZUNr7r/XEDthRJjc3eqzVbrrFmwt5NstqW2Bn7n/RMonTxj5g7bQBF3l3ZHpqVSixQM7Gy+SCJ9NCo5muVeVfEj64DfdX9zewPPHam5dhkA8BJOfRN/RUuBj1jBNP7f8ghmeI5B+ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356766; c=relaxed/simple;
	bh=tfnTGgEzNu/mCuxo6voOwYZcsLgTCllB4laPOIiUt/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1ZK7w/+wLz6rcsErIu60TZveQA92+qGcVKZltiYV46BT4mEJMA0YE3yw7ZaoWZhtHGlRTVsO8vjjcaNoxOxnum27sprb7X44sBTCT6erML9Yl2C3v3Ueuk2P6Oj0UvZanS4CkJgnV9SVke8zmGX7rPJ2io/bkvgdKQkFQg4k/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VfmmJEv4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MNINmZxK; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VfmmJEv4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MNINmZxK"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5531C14001D3;
	Tue, 24 Mar 2026 08:52:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 24 Mar 2026 08:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774356763; x=1774443163; bh=HLaZ19VUo6
	ZVOBEGRNajaCjCRpKIiCShiPbELuvqZeY=; b=VfmmJEv4u3iq0e8qGoElN1lfgk
	0bwN8pUAnseFBOcNE3W/AEZq9c+ANqJ6cdkvh8HzdfMqSgX/1B3L9KxY0hmSXySn
	tmrbs1FMPRhtmPn8ljRp4JOwtbi4oeZ8627o4mXtfNzrow3llB+mjrdTtwzaye2k
	x9ynwoILfJn49s5OasMB+9ZQHyVVrTRAR/sleXRuDW5OcEIpkdROgB9GytM8jhEt
	OTFRjNJaBF3Qv8hBnPl9fUrmqxDsGvfnyDNj8GWEv0UctEaArQMdsN+s3x68BDzj
	TMVqlryRMpVHDnHb4BSFSNFbcRIrkQ4+3DBp650RzgE/76thAfaFyeRH3MDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774356763; x=1774443163; bh=HLaZ19VUo6ZVOBEGRNajaCjCRpKIiCShiPb
	ELuvqZeY=; b=MNINmZxKJmiwG1pQtcr+opbo3LTNU4pPxizjCsMtVP66iNDNo9e
	JXP/9N3zkFZS/Spj4HAs526w3k55zJ8Sw8NOznYgcBUCHuP5mYla4MvHiXHRlNtx
	dsVS3bE7dIVt5i45qmKxgYJ0cShqYgvHup6h5XFTe/6vCYJwW2lQpWfMnsCjEqat
	00ue7k8j6wlZ9XZVAX06jIbCi5URBXokrhEmCuKJpCG758e4BiacxlOgnT0S6M7I
	U9HhMXFMvUdMMOzkE+HqFP28r1M9E/nJ1IDJhinoVA2i+0EXHPzqp1mW2D3Vsloz
	oraDIbFl/qqVzsAUicX6XAVtGlodDqyinvA==
X-ME-Sender: <xms:G4nCaV8o-gjre_35fpS2VSDHQ8bfK4O2fnayL5hZGHR5zNRBrVm7mw>
    <xme:G4nCaQlxiUepnkarZVpV_PR6rD_VjitU4a52qkbCi7xzdIliS7Vb4el5QPdrbQL8E
    TMoY0EO8-h2-xHUtminio73f10NvVXqNbO_qdLBHmLbICFDTSMDI80>
X-ME-Received: <xmr:G4nCabXJcZaJS_IUIijb7nOQXk5dbeLBy7-q7heS_VFJZN7aiUvCcOmUfe_BQzQ49N95kXZ1i9iFvMA1OVpA-yOUCLE9wI_mq_MEf9YjjDNlhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdduieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghhlhgvth
    drthgrkhgrshhsrgesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:G4nCaVGqKLhZ78N_qFcYkPUWXc9Xy_vf3jeqWhPCmYME1o5AulGDBw>
    <xmx:G4nCaXcHF2j8SvmnPJdDnI-ptm_-IXQp799pBLDReGS5rjlPluF0Bw>
    <xmx:G4nCaWJxMxrU8AGOV3EYv_NZSMozVihdR8E6Fx7vtTF09Y1iY7YbaQ>
    <xmx:G4nCacGaVjizBPMEn2ewHdAguVu-E3wlc1NzPFVkwurKHVhUtrECtw>
    <xmx:G4nCacW7890-iON0T83Pky_63U9YI70ackpZ9nAUaOArUMJZmLLGBhNo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 08:52:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8c8d4c3d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Mar 2026 12:52:40 +0000 (UTC)
Date: Tue, 24 Mar 2026 13:52:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Mahi Kassa <mahlet.takassa@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, lucasseikioshiro@gmail.com,
	jltobler@gmail.com
Subject: Re: [PATCH v2] repo: show subcommand-specific help text
Message-ID: <acKJFZiDg88fON4W@pks.im>
References: <20260323152937.257406-1-mahlet.takassa@gmail.com>
 <20260324122111.84122-1-mahlet.takassa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324122111.84122-1-mahlet.takassa@gmail.com>

On Tue, Mar 24, 2026 at 01:21:11PM +0100, Mahi Kassa wrote:
> Use subcommand-specific usage arrays for "git repo info" and
> "git repo structure" so that each command shows only its own
> synopsis in help output.
> 
> Factor the shared usage strings into macros to avoid
> duplicating the same synopsis text in multiple arrays.
> 
> Add tests to cover the subcommand help behavior.
> 
> ---
> v2:
> - wrap commit message lines
> - factor shared usage strings into macros to avoid duplication
> - restore blank lines between tests and before test_done

Something most have gone wrong, as I cannot see any of the macros. We
still duplicate the usage strings.

Patrick

> diff --git a/builtin/repo.c b/builtin/repo.c
> index 55f9b9095c..5ccc5c401a 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -27,6 +27,17 @@ static const char *const repo_usage[] = {
>  	NULL
>  };
>  
> +static const char *const repo_info_usage[] = {
> +	"git repo info [--format=(lines|nul) | -z] [--all | <key>...]",
> +	"git repo info --keys [--format=(lines|nul) | -z]",
> +	NULL
> +};
> +
> +static const char *const repo_structure_usage[] = {
> +	"git repo structure [--format=(table|lines|nul) | -z]",
> +	NULL
> +};
> +
>  typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
>  
>  enum output_format {
