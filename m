Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56F72AD3E
	for <git@vger.kernel.org>; Fri,  2 May 2025 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746177342; cv=none; b=rdVJbYgEDM0FjwgL0NPMh17m0h4KG3XNPgWga6NHLCPym22E142s92pgEep6S/c2IiBJs/yLUB4ZSZmb10fk0lqj88mFk1Cs5vfWB97nmZq7Z7e9je0HWmc9pNGJFQ71F4+Gpbf+/IvW6ZfU6Fr3fxUHnPIgP8hygktm01zTefs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746177342; c=relaxed/simple;
	bh=uGQKAItHL0IrVubLnXBY3JCjbGtmOLZYgi/gy6l2QUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cI6OHoFvJIvpzDJ7Lf1ag4JhDd9VNiUGsQV3CHz2SaBAhdnv2GdKu5odpCoJnYpPlaorL+MXhrfciQWvLIfsSaUic27Ei02d1ECrorAv0XL0QHDP1zJkB9wsQXbU1suZJHM5PLSnrZkpauR/FUoy1BaeAanXt4nAo7uxDYMC9cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sod9NEeM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=obWwy3lW; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sod9NEeM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="obWwy3lW"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id D178C138137D;
	Fri,  2 May 2025 05:15:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 02 May 2025 05:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746177338; x=1746263738; bh=T0Zst+CQx5
	ponzLeTbpKWpMnBTc7H5rJUoJqxTiFYko=; b=sod9NEeM+SVhJWGVc1h7zk3aw1
	+uUraOrtaMrXVMUtATFpoJ80N120k2tubiQLKV4XjiukkijTSILCOHTis91xNEoY
	OgmmbBolXWydbPKLe+Xvm4D6zHbJsfxwX/WNLoSWTPjbdAMuG+2KCeHWcxUjJfhO
	9MqfxDzcXkXmFHzFJ0cya0OM/sVMRsH1tDOhIKSW7DOMOb7kMHUkjyZ3x36x4Q7k
	Jo+f5IpGZYvgMowLZ3EBq5vRUjl6dYqI03uDVCoNFuoHDP7Xq0T2Nf5ayn6uEZ3G
	Qt23Vh151wMPTb+LQzsI1Dvp1TSI3kNUMn1TctMDt1mrW4CdEsaSqrX6zmUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746177338; x=1746263738; bh=T0Zst+CQx5ponzLeTbpKWpMnBTc7H5rJUoJ
	qxTiFYko=; b=obWwy3lWX9c4qjlN2Nfjumivvd9EqRuLe+X9is8Ujj8i7R6X475
	V5V37SZQc5pm3CUdrYcBqYUzrSZJCowAZ/5veyICXmbcaY1adTx/AcsExS8b45Z4
	YUse0VS7QQfK86241tPfVW6hzV7S5mKPRquCzRHe9AJYxOCVP6gOLFWvcfe7xSBP
	memLQ9RokwY1eW9i/Q+6Cf1e69zqNoON8+mo3tS2wA1K/ePTIQjecFkHxad5HzKW
	E1FRKWFHwGXfDoGlyHngdjeEptHm6O3xVecfkQ8Ut1UZPwKwHMTs1IkrkNAmmSR1
	PpIny4Y+9QerdgtXv78BkHvS6pW7SYiuNrw==
X-ME-Sender: <xms:Oo0UaCR_1GHCjVMdprunMYK1vHBwG41l4feI4JEcn_0U6u4AntwXvg>
    <xme:Oo0UaHyW2kZCQ9WP4Ybn7UeaA6iEry-zHqm5KgBKAz1Jy4Pe0vA-k3a1owRKnOKBe
    ZZWj4goWbikZGsZUQ>
X-ME-Received: <xmr:Oo0UaP3S9cdo3mSNkf9AMa9VVBAqrZ7bWdKwFLH1D8y0ByiOPlvCn01mZQnkJl4eCdlBwvSX_y-0SFVbdga3shwokl4U3trgSoUxDdlVtu4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    ghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhi
    nhesghhmgidruggv
X-ME-Proxy: <xmx:Oo0UaOCPWStvUgjStv2Hk7WcNKSv0VWtmNRiU_SNZ1IEFvRZIbHoSQ>
    <xmx:Oo0UaLhGKQt5_8jVSynCL3TktBauLP5NPNV2SnPyN5n_9VTJFR_1Ng>
    <xmx:Oo0UaKoIoxgIRdjr7d6ayVNVwGIMXvI_u4xZbMcHDYOJ4kmdUQdOEQ>
    <xmx:Oo0UaOj9iNKrVw0SXLbtg7l2YWB9es6eaa45ZZB38gfYRdJmJNDaxw>
    <xmx:Oo0UaMZk7ypiJkoM5vQa7IjGrVHoLyvP_Jjk1Rf1ihI0aQrTkdVYtc4I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 05:15:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 376ce3c3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 2 May 2025 09:15:36 +0000 (UTC)
Date: Fri, 2 May 2025 11:15:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/2] scalar register: add --no-maintenance option
Message-ID: <aBSNN6Z3Vve6c6Bm@pks.im>
References: <pull.1913.git.1746008680.gitgitgadget@gmail.com>
 <4910bacd0524a29186e673a174a47cd46ac95b5e.1746008680.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4910bacd0524a29186e673a174a47cd46ac95b5e.1746008680.git.gitgitgadget@gmail.com>

On Wed, Apr 30, 2025 at 10:24:39AM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/Documentation/scalar.adoc b/Documentation/scalar.adoc
> index 7e4259c6743f..b2b244a86499 100644
> --- a/Documentation/scalar.adoc
> +++ b/Documentation/scalar.adoc
> @@ -11,7 +11,7 @@ SYNOPSIS
>  scalar clone [--single-branch] [--branch <main-branch>] [--full-clone]
>  	[--[no-]src] <url> [<enlistment>]
>  scalar list
> -scalar register [<enlistment>]
> +scalar register [--[no-]maintenance] [<enlistment>]
>  scalar unregister [<enlistment>]
>  scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
>  scalar reconfigure [ --all | <enlistment> ]
> @@ -117,6 +117,12 @@ Note: when this subcommand is called in a worktree that is called `src/`, its
>  parent directory is considered to be the Scalar enlistment. If the worktree is
>  _not_ called `src/`, it itself will be considered to be the Scalar enlistment.
>  
> +--[no-]maintenance::
> +	By default, `scalar register` configures the enlistment to use Git's
> +	background maintenance feature. Use the `--no-maintenance` to skip
> +	this configuration. This does not disable any maintenance that may
> +	already be enabled in other ways.
> +
>  Unregister
>  ~~~~~~~~~~
>  
> diff --git a/scalar.c b/scalar.c
> index d359f08bb8e2..2a21fd55f39b 100644
> --- a/scalar.c
> +++ b/scalar.c
> @@ -259,7 +259,7 @@ static int stop_fsmonitor_daemon(void)
>  	return 0;
>  }
>  
> -static int register_dir(void)
> +static int register_dir(int maintenance)
>  {
>  	if (add_or_remove_enlistment(1))
>  		return error(_("could not add enlistment"));
> @@ -267,7 +267,7 @@ static int register_dir(void)
>  	if (set_recommended_config(0))
>  		return error(_("could not set recommended config"));
>  
> -	if (toggle_maintenance(1))
> +	if (toggle_maintenance(maintenance))
>  		warning(_("could not turn on maintenance"));
>  
>  	if (have_fsmonitor_support() && start_fsmonitor_daemon()) {

Isn't this change contrary to what the docs say? `toggle_maintenance(0)`
would cause us to execute `git maintenance unregister --force`, which
deregisters maintenance for us.

> @@ -597,11 +597,14 @@ static int cmd_list(int argc, const char **argv UNUSED)
>  
>  static int cmd_register(int argc, const char **argv)
>  {
> +	int maintenance = 1;
>  	struct option options[] = {
> +		OPT_BOOL(0, "maintenance", &maintenance,
> +			 N_("specify if background maintenance should be enabled")),

Maybe s/if/whether/? Might just be me not being a native speaker,
though.

> diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
> index a81662713eb8..a488f72de9fe 100755
> --- a/t/t9210-scalar.sh
> +++ b/t/t9210-scalar.sh
> @@ -129,6 +129,13 @@ test_expect_success 'scalar unregister' '
>  	scalar unregister vanish
>  '
>  
> +test_expect_success 'scalar register --no-maintenance' '
> +	git init register-no-maint &&
> +	GIT_TEST_MAINT_SCHEDULER="crontab:false,launchctl:false,schtasks:false" \
> +		scalar register --no-maintenance register-no-maint 2>err &&
> +	test_must_be_empty err
> +'
> +

We should probably have a test that verifies that we don't deregister
maintenance.

Patrick
