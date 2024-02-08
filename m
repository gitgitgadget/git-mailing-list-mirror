Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E642E6A025
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 07:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707378150; cv=none; b=q8J55wDad35dLPxtq1F0Ken0yJl/aiYAvYUKR1emathHAIzsrAg0Y2Ww5N5jLiVtUv7VhO/Svjk6L8jCue3ZAFe9OnHpfMY3hf7HkB10XQnpskVgkdAfPQEAA0nQ3V/aebJDOs2ytrbt3rhkLw3XtgSorCACJ/mclGkXZcyr+A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707378150; c=relaxed/simple;
	bh=who93FgXOo6RiEjkFom0nEyIXjFd052urBaYyVTbigE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jD/jL6kpTi0j98owUz4DM2EvCE4iKoaI/aif8M/vtZ0+r56rh0lG98zYygMiVRBDQz+4T24dMggDAlgOe9+SlZI2hs7H9mFoSf4hY7rKaHILHYbPS+YK+FL72agI8C1lb4VXq6VS7YAI+PD/wnAYqJHtCgFsnqD0+kNrMZIoFCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E/PkBwCt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LJT3hn4+; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E/PkBwCt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LJT3hn4+"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 01D9D3200A7A;
	Thu,  8 Feb 2024 02:42:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 08 Feb 2024 02:42:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707378147; x=1707464547; bh=bvBO8I9LsI
	+aF17bi5GEp7xsWX85sJzxH2aKR3LY8ac=; b=E/PkBwCtQUrgHjjKb8JTacKNIn
	b4aMiAABmREgt7XpuAUDeG0fW+UdU7+u+9wjJnXsTMRRkqRZY4MepoRMMqIlncyz
	q0uFUTVRXtcwYPwUW32GgyoeGJKTf0Xe3GTq+xgZAa7cu4x9J6wYSzeLo2X8A7yj
	VH7Ww0H0ma3zskwIcZo8z5uwEtuuQbCi6JZXmhYeTsFZD6ad6d85KN90D1roi4uk
	ihnrKrxbpgvQktkOphsFp7oq6Y1GRoeQlTJszRIoPyay+2wtK26ZlL+21nvs6g1l
	2YmUk57kDSzKdYCn8kVcrd02f4kca/wqc3mGAOhrwl/CW31JrWvpCHlJQ32Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707378147; x=1707464547; bh=bvBO8I9LsI+aF17bi5GEp7xsWX85
	sJzxH2aKR3LY8ac=; b=LJT3hn4+aWPlXeWGQKFxxI0mRN3eh5tYxhfoM/G/HLTc
	vjA85ZLAd+nxdBYMDEz+qdtrNwUVEgv6g83tcVsnvQYancvNlRKQ7EJ1C/PTrq6f
	4Ay8HVN4kp8kPUdBquPeKivch2JeZoRDSycq1KXtI2Xy+QumzIF4oEN65SgyeI2k
	F3bLZEsPGggZUOOFo+6PATAKtp0NJbXU6SxkoxXsXUxlFl8YOYL3uUsw2fBA/Fah
	XNFqiqeTCW9DIlesojY9JtBuLS/bRQNg1idQXOtXFzj/uAyPke6ory+rYwjDzg+v
	2WF65Ai7IW0ia4w93NUNe+nFVY2VJx+/8iWUWbyHDw==
X-ME-Sender: <xms:44XEZUYFoiTslGAIkaHOypyjgPm4hVbwnLva55rkYAjKEHHJvOxzNQ>
    <xme:44XEZfY-NwLe166lvm_sq4Eqv8Jzhyap5cPqwCmHDr65d4omGbDtpBFyfG3LN2--d
    glXFhvB_XFlgLVo0g>
X-ME-Received: <xmr:44XEZe8qP-qE0PCMsQJbBTWu6Bq_TPTLamjyCbuf9MioeIjlBkiotjLzIyIUUtyKGSbKdicnPnFRKNiFcijhiSVsAWscNPtjrgs4ujKXlcpoeXKr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdefgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:44XEZeptr5iVMm4Nhw2_OtYaA5SZvMAFrR-Jh71LloQ55Le227ZC_Q>
    <xmx:44XEZfrMbRviUgQl7OimNhML3lTDCDGlJNPWhTejujiGtiEISxt3Gw>
    <xmx:44XEZcR-R5cCzojBDe2b2dq0iIFHFkqkowWtE3QFpNcpQ4gBEfIUgA>
    <xmx:44XEZW2_Y16ph4qHCpmx9O0r2cgZK-fsVbUTNq_RM8v2pYCL3Xuc6Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Feb 2024 02:42:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b72b3703 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Feb 2024 07:38:53 +0000 (UTC)
Date: Thu, 8 Feb 2024 08:42:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 5/5] completion: add an use
 __git_compute_second_level_config_vars_for_section
Message-ID: <ZcSF4fv_a16Ziwyy@tanuki>
References: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
 <pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
 <a2e792c911e1b9fa77d27ec327f6a9dfe06d4de4.1706534882.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YOQJfmN8IpBGejlu"
Content-Disposition: inline
In-Reply-To: <a2e792c911e1b9fa77d27ec327f6a9dfe06d4de4.1706534882.git.gitgitgadget@gmail.com>


--YOQJfmN8IpBGejlu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 01:28:01PM +0000, Philippe Blain via GitGitGadget w=
rote:
> From: Philippe Blain <levraiphilippeblain@gmail.com>
[snip]
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 2934ceb7637..0e8fd63bfdb 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2605,6 +2612,15 @@ __git_compute_first_level_config_vars_for_section =
()
>  	printf -v "__git_first_level_config_vars_for_section_${section}" %s "$(=
echo "$__git_config_vars" | grep -E "^${section}\.[a-z]" | awk -F. '{print =
$2}')"
>  }
> =20
> +__git_compute_second_level_config_vars_for_section ()
> +{
> +	section=3D"$1"

This should be `local section`, as well.

> +	__git_compute_config_vars_all
> +	local this_section=3D"__git_second_level_config_vars_for_section_${sect=
ion}"
> +	test -n "${!this_section}" ||
> +	printf -v "__git_second_level_config_vars_for_section_${section}" %s "$=
(echo "$__git_config_vars_all" | grep -E "^${section}\.<" | awk -F. '{print=
 $3}')"
> +}
> +
>  __git_config_sections=3D
>  __git_compute_config_sections ()
>  {
> @@ -2749,10 +2765,13 @@ __git_complete_config_variable_name ()
>  	done
> =20
>  	case "$cur_" in
> -	branch.*.*)
> +	branch.*.*|guitool.*.*|difftool.*.*|man.*.*|mergetool.*.*|remote.*.*|su=
bmodule.*.*|url.*.*)
>  		local pfx=3D"${cur_%.*}."
>  		cur_=3D"${cur_##*.}"
> -		__gitcomp "remote pushRemote merge mergeOptions rebase" "$pfx" "$cur_"=
 "$sfx"
> +		local section=3D"${pfx%.*.}"
> +		__git_compute_second_level_config_vars_for_section "${section}"
> +		local this_section=3D"__git_second_level_config_vars_for_section_${sec=
tion}"
> +		__gitcomp "${!this_section}" "$pfx" "$cur_" "$sfx"
>  		return
>  		;;

Nice.

[snip]
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index f28d8f531b7..24ff786b273 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -2593,6 +2593,16 @@ test_expect_success 'git config - variable name - =
__git_compute_first_level_conf
>  	submodule.recurse Z
>  	EOF
>  '

Missing a newline.

> +test_expect_success 'git config - variable name - __git_compute_second_l=
evel_config_vars_for_section' '
> +	test_completion "git config branch.main." <<-\EOF
> +	branch.main.description Z
> +	branch.main.remote Z
> +	branch.main.pushRemote Z
> +	branch.main.merge Z
> +	branch.main.mergeOptions Z
> +	branch.main.rebase Z
> +	EOF
> +'

Patrick

--YOQJfmN8IpBGejlu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXEheAACgkQVbJhu7ck
PpSmOg//VjkgZgYRD2Xs7Uvp+35gvzlbhhG/O1vBaAVTd+lWLcPfyabuotpYMTdy
IuLira4XUo4ZeAuwU4UOMSgYm7SSm3jshWgt5cRHHPKp8tvkt6Vjg58MJcKbpBbe
TRyGjl+5SAD1yk1nSM6b8fRKuW+4EkmhojOXkWFvboMB/jMPCVubgX+FQVuZHHKk
WrMPiofXAvJt9R13bGexCVbo+6GkRRVX4psIW/381D5jVWZFng8udI7DDLTcr8dN
HXlJUAmsA+HA9bkAo0Q0U2c2OjnAk+BqO1JoWDviWnrr5jPLOp1AitLAwHmN3Iel
71F8WSysFc+HqPrfI6KF8gL/ITOR81zVptqZlXwiBU+mBIo61kOa4jg72eJ4uRQ4
lbnpfgfmFQIGVT6GGm5zNz2mG0JfA6rrmSaIsVij6CmpCOXo1ih6CN6zwa1V4hz/
mbII6jpA2iDfTgSGF0HsNPyhu2qHoD9nC7njB0hSsSTSdwQwBUNnrM6N2fH107cI
mwhW1CJLWEPPAr1iXV/mg5n24a6/4k8uwDWRCZqHb69e+xiH10LTeBTUZB3Hsi63
a/W5h8Sy2HJywo9+nNq2cVKtsyczCZKUYu+1D+FlbEOjcn6y+8R64LN3uYeJacik
2jFSqCgbM/4qDjOXeUHN1l0q+Uf5iDI0AY+ciK3v53t41D7gx0U=
=yx4y
-----END PGP SIGNATURE-----

--YOQJfmN8IpBGejlu--
