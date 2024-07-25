Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BC64428
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721891744; cv=none; b=D2CUjzWtxTAsRniyPWmTzke0MaicnAu2Ow42An3p+sj166JZdKqD/ICvTN7EJju84R+xV77sXts8NSjPPP/bxj1BKKf3rJuRk5+V9V08KcZWje1wy5sZY5wcdPT9FgDWEaDZJp7IQXI7VkuQBpOkTXxXHTTJRzW4MCcGz2eZDlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721891744; c=relaxed/simple;
	bh=W+U/1AT7z1SIj+H+NCgTUEAhatjZDnbEz1GTgbx02As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/tDVO1aSljULeUf75VkH3cCkFms7OFPP0gFS3+0JxNdIP6FcOnN/MBI4BUyBwu/iT2uWWY9jw9/GswWDRCsRZ+sGyoQfF2u4o3WwAjyEVXOzCWdmTwTiZMGKQb8ji1pQlgZZZEHOWub1rjSX06FQCbL3REyMhuPNIEBwVilhdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ag/gcTqG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eJH7+s7C; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ag/gcTqG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eJH7+s7C"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 397DD13805E8;
	Thu, 25 Jul 2024 03:15:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 25 Jul 2024 03:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721891741; x=1721978141; bh=H6xZ7bGYfb
	Hlb51cE7BJDyuYVphOpu7pZizaIai3HZo=; b=Ag/gcTqGxnNexTCDTb7Uhhj6SJ
	GdJC8ZrQddpccGPalTG7eHaZBcQ3U7MeU7/S5AjBbSca1sVExmgWMhuLslL+KyJI
	NYK67FnMDDUxl2HqxdS7pSBKogEa4Efc4QTohEYoRTUtPCk4cGlS6Etx3rRmP2y8
	8AZXyXxOtc6977aZmU0PRgHGz6SJeXaJpgtgt3dBIVphOwIBwL8/NeJTiud3yo/e
	zMO+n3dxtTfuGa/D+p1Tl4On/J54zsiqP7l0LeSfkpyIL8DMBNyKa3+cWFezjhRo
	FtT0mc7wMF9HP/7FtJzyKjUSzw4O+JW4omY0oV1f2b2E8EUhgvQipwtdSHog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721891741; x=1721978141; bh=H6xZ7bGYfbHlb51cE7BJDyuYVphO
	pu7pZizaIai3HZo=; b=eJH7+s7Cg28BV0ChDOlKo32IXzHE6UGP9e6Q/c84nB68
	aY/LAg02ba2MQkBekDlQxg6e2ipmAQub7f3efHJxQT96SMq8AaDGcK9dCTz5dNeV
	lWnOiZy+owJKglPF07XGzrEp0Ca+KVWyFcv+sNZ0v2DvHbe6zTYG+tKhaWP2vUpC
	2+X+IQTXxZ5eJISmXUcj+BNnCos1N8aldSIpLkkQTI9RPFsbXazCLM+T2cpIenYz
	A10TLGRML21QGJ5MnpOlx+pkkDOJP554NE9ts9Ov7lX/emg1fTfZvnawryzeZgT2
	otaLGNP2UZEirJ/irlDev5qgLreWCCBo8Ec8NFEpNg==
X-ME-Sender: <xms:nfuhZp0D3DtNevMEItzKXd0rc9jkxKIsFCJILN8RDCoA5VVnWIQd8w>
    <xme:nfuhZgG0nur9opMhzv0wA9ZZbTgVNPgF3pUTcMm-2Y_ITitvu1A3HrdtJLYd-MJGn
    a8MSp5RpuP8CCelEw>
X-ME-Received: <xmr:nfuhZp7il0FNroVQR8zow6E0hH5tjqsOTf4VmTzwYdcunue2h4UnANDc5VHftnHqdTWoeX-rSTgORlLPxUpcZbJfuqGmK8l26IjSOO7cueCaqrij>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedvgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:nfuhZm3d0JXdedaJzS6QQSulNObPo3Pt7FTPKwWEqAjTzmd4_da_Fg>
    <xmx:nfuhZsH5nVPvAYAuQ8ktgt1NyOK9z0c5B8FFCwkNg8hHBMkMTEhIMg>
    <xmx:nfuhZn9ZeaXKBHHl1WOGJsmUUAh_65-34iwll3dPLwfu0o-vVJTeag>
    <xmx:nfuhZpnGxJAxdfiB0TiYu13CQuZfISnZnCrC8gson9D2il42wf9R2Q>
    <xmx:nfuhZogvxfDq0b6uBBxqdyc79vyksqEJmN98z4-q3UrykmIh4Yzewp0w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jul 2024 03:15:39 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 79015a27 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jul 2024 07:14:20 +0000 (UTC)
Date: Thu, 25 Jul 2024 09:15:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Alexander Shopov <ash@kambanaria.org>
Cc: git@vger.kernel.org, gitster@pobox.com, worldhello.net@gmail.com
Subject: Re: [PATCH  1/1] show-ref: improve short help messages of options
Message-ID: <ZqH7mDh73vkX4bPT@tanuki>
References: <20240724111116.91615-1-ash@kambanaria.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bpag9uOPouAVqSJc"
Content-Disposition: inline
In-Reply-To: <20240724111116.91615-1-ash@kambanaria.org>


--Bpag9uOPouAVqSJc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 24, 2024 at 02:11:11PM +0300, Alexander Shopov wrote:
> diff --git a/builtin/show-ref.c b/builtin/show-ref.c
> index 839a5c29f3..85700caae9 100644
> --- a/builtin/show-ref.c
> +++ b/builtin/show-ref.c
> @@ -293,8 +293,8 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
>  	struct show_one_options show_one_opts = {0};
>  	int verify = 0, exists = 0;
>  	const struct option show_ref_options[] = {
> -		OPT_BOOL(0, "tags", &patterns_opts.tags_only, N_("only show tags (can be combined with branches)")),
> -		OPT_BOOL(0, "branches", &patterns_opts.branches_only, N_("only show branches (can be combined with tags)")),
> +		OPT_BOOL(0, "tags", &patterns_opts.tags_only, N_("only show tags (can be combined with --branches)")),
> +		OPT_BOOL(0, "branches", &patterns_opts.branches_only, N_("only show branches (can be combined with --tags)")),
>  		OPT_HIDDEN_BOOL(0, "heads", &patterns_opts.branches_only,
>  				N_("deprecated synonym for --branches")),
>  		OPT_BOOL(0, "exists", &exists, N_("check for reference existence without resolving")),

Agreed, I think that this is a sensible change. In practice, this
feature can also be combined with `--head`, so in that spirit we might
even change it to:

    "only show tags (can be combined with --branches and --head)"

Not sure though whether this is getting too noisy?

Patrick

--Bpag9uOPouAVqSJc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmah+5cACgkQVbJhu7ck
PpQtzBAAizP27FILMN4LnJkl7wx9fVxlVtKfW8Z0NRsMdEyuYrNsQCYlyobHRyYz
wtQPFEOjcRumOiKYepawVJwlqjbPvfHkzJ2HRhqA3ZdaudraeKYnHyqMU63CjJ5k
YftlyjMu6k6Sbn5W+FYxGZMbH8FUSHngrWqQJO7GUUsAp2P1+tGVzHx/kYpVplrz
UBIwKk8f47dZO76dHmS1yvTCdFD2NrenKCuOHbfox5+26Vq7tutKHPAncgQMycuC
NtPZCYKgzvp75m8Z+1d+9ZxtyyrzH0rRdahlGeDf7ofMlIsvRck+gxuY1OjbJZY5
PshwZwN+lLM+iPUVMQl8vjh9UbWO3jjAK5AhCpvVFjTBWBgy/xwDFAMhyYJwYYAN
p4HlXbvt6jlpmrzCV+8pfXhA2ZjcD8ZF9TmZxHtbxEbUw9B7rtLEe3dlR8rTgPol
jWHCXDehlV+chudjwsjupdVlDKGp1Zdi46IFax4+qgp8x0sE2wNm16l7T02otJL2
ZVtd5rFdj3z6R7H07IEa2GnreJDZkfUZvEWnOHuEmbKVIMSrpBU+76WOXdPkHmHj
MBCtXyUpTEmWn2ijrcnsefgViXp98TEJi5L6LHY3yIEBY7lwhOSZyddnO1rFQwcW
DRPvjwpyTV43vFJXumaOOvtZVuSpPuos7np/Aj3fY7rMLGnUiPU=
=oRni
-----END PGP SIGNATURE-----

--Bpag9uOPouAVqSJc--
