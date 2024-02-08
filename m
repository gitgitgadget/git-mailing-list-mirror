Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218D16A00C
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 07:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707378144; cv=none; b=d0Yc1Dl1YbGmo9ZV7zn06W5W26JvT2kjemUBLDZ2AdHCtyDIYduZI0uK/LoSslj1kxa99fJUTIJeDnzcO9sSsLzXAxRRclVMii7uA6/gqfW/cG+itP/EJ/96vveLq/NFbQ9hh2ffHxc1alSGa2dEhz3GG1xiz5snyDHFuoiQm4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707378144; c=relaxed/simple;
	bh=5B2HEo8aI1cj51gq66p35aidQnxchXStRjr4MRvVI0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJntENo57YM8m6GrFGM+/IjCo4qIfXyywu0Jmwe1UHfe51oRKVZV4rzPuneu4oOsPR7qiTMKT6LBoY54R2HRo0A8w4PYU2Q8NLaT+pJbBP4806Gbov/+Y6gJXBdGtPpcat0jaJZSwefXGR+lxi5Um6QtEl4oOXctMOEpsLrfDIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QR+CzE2m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zCGRbcud; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QR+CzE2m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zCGRbcud"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 0C18A180006C;
	Thu,  8 Feb 2024 02:42:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 08 Feb 2024 02:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707378141; x=1707464541; bh=kX43DUzvsT
	/wrDqjBOx0GaFdF7ffZsfYC/1s2HUMOo4=; b=QR+CzE2mbdqwGkR+E9qSd3RQpk
	+7M7ns/j7hdpWs8ig8KYxl0xn8q/u1VbqSikUkg1NRN/rl/zZ3DoDg2xM+ApUVXe
	hS/a0qNQZT84G7jK0U+Otor/f3FwrexlZmwfCxdWZwLo0Y+o32dezcZqFb+bsDOK
	FajN0zX3YxdvM6Jd+JyGTaI1LHRGdaPr+q2rsVNvIhlBG8rL4VneKXHMQ3i4fCVP
	My+qRd2NH6IG70wx1NmAl89h/9gMV/IdbvcA109/9KX6ezuWg9sBCE3BuBW4Uoi/
	AB2DgRPqY+XXAcoCUVa/GOc+sDu5Aj+vaJS13XgEdLYAz6XeLOcB4SNJO53g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707378141; x=1707464541; bh=kX43DUzvsT/wrDqjBOx0GaFdF7ff
	ZsfYC/1s2HUMOo4=; b=zCGRbcudokm078o5499yz0tSpc37mSZZzN7MaSnBp7V0
	f3HMnwEmbtARIphxglWk9qf4Mm9dWNFRLC28xBEaJvEy8BXZwqw4G7WvH81RnPLM
	rk+qOAU6KeQ26udEh3LY/mA7yzTDmoBPUs/Ep46/mSIsR9w+OfOM6p6TBdGnmT1B
	Vela6Ds/vqAehLGd7IBEKpvWnpeGEf7UNKz6BwJQhNch4vPivSkJ6A/mUm2qTU0T
	ADmO3r4eg1DwWnPAlluBRq/SL2J/VZZwim1uo1556WcB8cKgyDrRLSHx4RXwSLOt
	ZfC2KLghAJMmTtZBN+AXRH8Rw5BtrcNjZlbqNjihtA==
X-ME-Sender: <xms:3YXEZQrC4b4qjBbSHNpIV0jB9ZytqfKEECW7Nz65B1Uxm0NRP6QhHA>
    <xme:3YXEZWq2ou9zRQCMDG2pJTAWfD4y6qoxNrsoFyQSW9TtsHqAFgiFZH2WrUEsMlV6_
    M-1Gregwi4XOrVAzA>
X-ME-Received: <xmr:3YXEZVM_Q0W_FXuDw4M491xKuhpRexu2QPV4DgAPpi7ySzLjCS0bGYhQKYrOn3nwUQekR1XZBFcUCEddiROaglBfcnyQXfx7SwzEeRHNssYf-DLZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdefgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:3YXEZX707Yd4eEO-9kq26oqHVEFwBBZRwygNXmsGc7jfLxUcLHqU1w>
    <xmx:3YXEZf4RZo7h-ZAEeoXbi4LJsg7NFJv1uYIZlz5SbIsFc9-8bTRqqA>
    <xmx:3YXEZXh5rrDvJIYroX4qXlqC-nP4B1wXv_PgTevsaSdAdathiqLvLA>
    <xmx:3YXEZRmW7x9albgLIfp_CvfB04wC8q_8-oxZFya3M13U7chOP4OIPf5WPBk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Feb 2024 02:42:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dfef4837 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Feb 2024 07:38:46 +0000 (UTC)
Date: Thu, 8 Feb 2024 08:42:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 4/5] builtin/help: add --config-all-for-completion
Message-ID: <ZcSF2mw-zR1d38UG@tanuki>
References: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
 <pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
 <d442a039b27820dbd44e604df75ec026b8243d47.1706534882.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AS/dWgWQ5Wqrf8pC"
Content-Disposition: inline
In-Reply-To: <d442a039b27820dbd44e604df75ec026b8243d47.1706534882.git.gitgitgadget@gmail.com>


--AS/dWgWQ5Wqrf8pC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 01:28:00PM +0000, Philippe Blain via GitGitGadget w=
rote:
> From: Philippe Blain <levraiphilippeblain@gmail.com>
>=20
> There is currently no machine-friendly way to show _all_ configuration
> variables from the command line. 'git help --config' does show them all,
> but it also sets up the pager. 'git help --config-for-completion' omits
> some variables (those containing wildcards, for example) and 'git help
> --config-section-for-completion' shows only top-level section names.

You can invoke `git --no-pager help --config` so that Git does not set
up the pager. Is there a reason why we can't use that?

> In a following commit we will want to have access to a list of all
> configuration variables from the Bash completion script. As such, add a
> new mode for the command, HELP_ACTION_CONFIG_ALL_FOR_COMPLETION,
> triggered by the new option '--config-all-for-completion'. In this mode,
> show all variables, just as HELP_ACTION_CONFIG, but do not set up the
> pager.
>=20
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  builtin/help.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/builtin/help.c b/builtin/help.c
> index dc1fbe2b986..dacaeb10bf4 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -50,6 +50,7 @@ static enum help_action {
>  	HELP_ACTION_DEVELOPER_INTERFACES,
>  	HELP_ACTION_CONFIG_FOR_COMPLETION,
>  	HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION,
> +	HELP_ACTION_CONFIG_ALL_FOR_COMPLETION,
>  } cmd_mode;
> =20
>  static const char *html_path;
> @@ -86,6 +87,8 @@ static struct option builtin_help_options[] =3D {
>  		    HELP_ACTION_CONFIG_FOR_COMPLETION, PARSE_OPT_HIDDEN),
>  	OPT_CMDMODE_F(0, "config-sections-for-completion", &cmd_mode, "",
>  		    HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION, PARSE_OPT_HIDDEN),
> +	OPT_CMDMODE_F(0, "config-all-for-completion", &cmd_mode, "",
> +		    HELP_ACTION_CONFIG_ALL_FOR_COMPLETION, PARSE_OPT_HIDDEN),
> =20
>  	OPT_END(),
>  };
> @@ -670,6 +673,10 @@ int cmd_help(int argc, const char **argv, const char=
 *prefix)
>  		opt_mode_usage(argc, "--config-for-completion", help_format);
>  		list_config_help(SHOW_CONFIG_VARS);
>  		return 0;
> +	case HELP_ACTION_CONFIG_ALL_FOR_COMPLETION:
> +		opt_mode_usage(argc, "--config-all-for-completion", help_format);
> +		list_config_help(SHOW_CONFIG_HUMAN);
> +		return 0;
>  	case HELP_ACTION_USER_INTERFACES:
>  		opt_mode_usage(argc, "--user-interfaces", help_format);
>  		list_user_interfaces_help();

We should add a testcase to "t0012-help.sh" to exercise this new
feature. That would also help show the reviewer what exactly it will end
up printing.

Patrick

--AS/dWgWQ5Wqrf8pC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXEhdkACgkQVbJhu7ck
PpTVZw//bjFISOWTqcga7unDfz1uhL8wpn8b7npIX9wkM52+zvLjZTHZa+nLsac9
WDQfnCOwuAjSwKzMSdUtem+yDf1qNfvdbXtiwgTQTqMwIs10feB8T7jD6+6N2cKj
+we4B4gOQxfHD+L9qR1VHBM9AshMZFqSMjT9ePjhWSnC4PjQNGH/hH0I7WKbpjcd
xso/K8f804p5Lsj5EDoSj771OJjtS00iwbWg8Mt+PN72km00jJbjHmZeXnTqoYJT
FataakMUN2q/fgpG5p2hx3exIANZ6v1Iow+jtut0ONrc1PstG3hYwyRZ8sZsa1WZ
HEnhiErsQzurHvtcEdGymN580+HfaX5vnS/pcitsqp8S0Z9Z4Txxu0XiHIigtAyy
V+QcWuh+O1kWum4T6l/mD8h/gNhfAEXCs66hSfV/rpWYOiLXGEOmsKUUpOkWnnCL
FwsLFrHiKPVt+8eu9diqCNwd9UPHWUA3D6rgri5LzPiJ61t739y1/XmhaVxVzZmd
ig0Dnw7P4iuF8rJPaaMhmdVqDaSSfOXXSuMF0h+jPB/S8/WuhHxjgfjcqLtOzWD1
2r+A6zPP8CcjerYrm11Z+e5eYEzExfCjH54UF4lbLcd7RgZftqcm6+3sz8+CrT/F
HJBWy8vfU3D0Do3x3VZwfBZvNqon9oDRlQwXC8QobYyvc9NS9x0=
=+yWm
-----END PGP SIGNATURE-----

--AS/dWgWQ5Wqrf8pC--
