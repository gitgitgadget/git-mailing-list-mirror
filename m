Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5C769DF3
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707378140; cv=none; b=f62efR+lD9x9ZRUcWoVOuGco1G09HhThRp4lD2rF5WsOjsFK4Vc4TY4plXFEaQcaH4FQJ4L/RxNrbb42gYSojeOJYl0/cUgPfO+JpUepuxim9tdq0HKJ58DRC5BoohK1/PBhxl8zQObjpJFVruj2o/++k1jjvkLj5MF/6VE27uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707378140; c=relaxed/simple;
	bh=uhgAUybGVV1GvNXlebqAOhO9tqZa3T8r8AugNDXFBAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTsdwTxx/UOrWBnQ8i6pWbBcR/jBT/O77OSZZR6+Ep56O0HPe+0QblUxUKep3oLpXRhqkXJx2YvNE7cxNWQo8ZnSlXiJiXEwgwRPeM2I2GT5DEySg2p9YtvGKyytMbSZAVQ9ARTgbMJFZXngawFrNxaPAqW5muQk16na/4tm12U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R9S0QwnY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hOfkEmVF; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R9S0QwnY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hOfkEmVF"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 142973200A7A;
	Thu,  8 Feb 2024 02:42:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 08 Feb 2024 02:42:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707378136; x=1707464536; bh=J6fr3JMvNL
	G/GPOz81o+DSDkHLkViquij8sPDarqWsQ=; b=R9S0QwnYcuKkmmVfFZR1Opt+TG
	CSEUDbMMh0bzQggxWe5WZi7QRc/hi6y7bXkwU13ISGxvWWa/hZxsmD0Yt1z2b5qC
	i6r72hJ+xIGb9d0mW+MWUasNR9qI+t6AZYM4vZjp7+PdJNiMB0r1ByUfJezn6PCK
	lT/TGQGXD+LEqQvFF6O/N81+89IDWwH1hy7bGIyJC/G2ZJZQuZlylEh7PRGQmfiR
	s1qPFas/itc1f+Nm7geORrhk4LYsDxnU+D2cNamAC69/LMCYVVW/ZRACj6QEnd7M
	9RwbFSyCjnP2PrxqyjmQ17v5BIXpHQnpeP+E4kTl+SpILA1V/JDDK8i92bCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707378136; x=1707464536; bh=J6fr3JMvNLG/GPOz81o+DSDkHLkV
	iquij8sPDarqWsQ=; b=hOfkEmVFwCRMyWzdWEeOscRj8UQHEFGjlKkDJrxkR305
	Oi++654Mzicuw9Fu+ac6EvLByj+qBcBgqqXVzps19sYkyXveMteKSd2Vo5UFFns5
	ShtrREZX0Tkdyff0Fh4qsDjDtVNAr6fjjTHJFWkSk3YzKDXg2oPyzV8AAtsCF94N
	PVQyoCpNv4S4WAVO2ZqgctPXvB/wRIj1KpITcrTAdi+myg50yCc7/QCn5KOz6HXP
	92xd3UnmvMGBj/Rmx0OT3s6x6/K639QmuWzVbA5teL8+vj9DvXLCQUXpBHXWqtxW
	hoVR4W4EwSUGjR177EQj06LX0V7EZK37bb0TOW2xRA==
X-ME-Sender: <xms:2IXEZYOZv_thPsqgh4bm4s6anQH_oFknO4ZC0a0uOHe6BC5mtG2uqA>
    <xme:2IXEZe8qOrttFshc0SdXq5tTA70_ifg0N-upbvlQ8PwFy3C31pjWeT6NnAIhjTjMJ
    IPG0zJ3I0JHSjroXA>
X-ME-Received: <xmr:2IXEZfRZC8g4dKs294VL2KykBJUSJYimMSU-qLe-1SCNwxZsAQiLWiAUaIIa8vPBYChS3GaOt5yrYVCjwVF9ztATHNil7dXxvFjZsYQ0KuWUZo5o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdefgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:2IXEZQvxeSnn4x1qssOqC-iv__41yq6JmrcPe6ke90bKS_C-08hEIQ>
    <xmx:2IXEZQdI4zNzSi28t-_BkZWhx5iMTa0rSU9Pg5Otnjn4L4yh3FElXA>
    <xmx:2IXEZU2R1kMDy1WFqpcVN7oQ2HLraMepjT60RwgBsWiL5sKCzdvoBQ>
    <xmx:2IXEZRqv1lj7O7M-BZh0C3Kdla4qEHPCj7NOL4UPSs7KI-6k0fc93A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Feb 2024 02:42:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e5f85b75 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Feb 2024 07:38:42 +0000 (UTC)
Date: Thu, 8 Feb 2024 08:42:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 3/5] completion: add and use
 __git_compute_first_level_config_vars_for_section
Message-ID: <ZcSF1mJ-JXQLmoZ5@tanuki>
References: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
 <pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
 <838aabf2858b73361be8e8579bc80826e1cfd4c3.1706534882.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Te9q+Ov/nCIAiI8b"
Content-Disposition: inline
In-Reply-To: <838aabf2858b73361be8e8579bc80826e1cfd4c3.1706534882.git.gitgitgadget@gmail.com>


--Te9q+Ov/nCIAiI8b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 01:27:59PM +0000, Philippe Blain via GitGitGadget w=
rote:
> From: Philippe Blain <levraiphilippeblain@gmail.com>
>=20
> The function __git_complete_config_variable_name in the Bash completion
> script hardcodes several config variable names. These variables are
> those in config section where user-defined names can appear, such as
> "branch.<name>". These sections are treated first by the case statement,
> and the two last "catch all" cases are used for other sections, making
> use of the __git_compute_config_vars and __git_compute_config_sections
> function, which omit listing any variables containing wildcards or
> placeholders. Having hardcoded config variables introduces the risk of
> the completion code becoming out of sync with the actual config
> variables accepted by Git.
>=20
> To avoid these hardcoded config variables, introduce a new function,
> __git_compute_first_level_config_vars_for_section, making use of the
> existing __git_config_vars variable. This function takes as argument a
> config section name and computes the matching "first level" config
> variables for that section, i.e. those _not_ containing any placeholder,
> like 'branch.autoSetupMerge, 'remote.pushDefault', etc.  Use this
> function and the variables it defines in the 'branch.*', 'remote.*' and
> 'submodule.*' switches of the case statement instead of hardcoding the
> corresponding config variables.  Note that we use indirect expansion
> instead of associative arrays because those are not supported in Bash 3,
> on which macOS is stuck for licensing reasons.
>=20
> Add a test to make sure the new function works correctly by verfying it
> lists all 'submodule' config variables. This has the downside that this
> test must be updated when new 'submodule' configuration are added, but
> this should be a small burden since it happens infrequently.
>=20
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 24 +++++++++++++++++++++---
>  t/t9902-completion.sh                  | 11 +++++++++++
>  2 files changed, 32 insertions(+), 3 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 8af9bc3f4e1..2934ceb7637 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2596,6 +2596,15 @@ __git_compute_config_vars ()
>  	__git_config_vars=3D"$(git help --config-for-completion)"
>  }
> =20
> +__git_compute_first_level_config_vars_for_section ()
> +{
> +	section=3D"$1"

Section needs to be `local`, right?

> +	__git_compute_config_vars
> +	local this_section=3D"__git_first_level_config_vars_for_section_${secti=
on}"
> +	test -n "${!this_section}" ||
> +	printf -v "__git_first_level_config_vars_for_section_${section}" %s "$(=
echo "$__git_config_vars" | grep -E "^${section}\.[a-z]" | awk -F. '{print =
$2}')"
> +}

I've been wondering a bit why we store the result in a global variable.
The value certainly isn't reused in the completion scripts here. It took
me quite some time to realize though that it's going to end up in the
user's shell environment even after completion finishes so that it can
be reused the next time we invoke the completion function.

While this does feel a tad weird to me to be stateful like this across
completion calls, we use the same pattern for `__git_config_vars` and
`__git_config_sections`. So I guess it should be fine given that there
is precedent.

>  __git_config_sections=3D
>  __git_compute_config_sections ()
>  {
> @@ -2749,8 +2758,11 @@ __git_complete_config_variable_name ()
>  	branch.*)
>  		local pfx=3D"${cur_%.*}."
>  		cur_=3D"${cur_#*.}"
> +		local section=3D"${pfx%.}"
>  		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
> -		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_=
" "${sfx:- }"
> +		__git_compute_first_level_config_vars_for_section "${section}"
> +		local this_section=3D"__git_first_level_config_vars_for_section_${sect=
ion}"
> +		__gitcomp_nl_append "${!this_section}" "$pfx" "$cur_" "${sfx:- }"
>  		return
>  		;;
>  	guitool.*.*)
> @@ -2799,8 +2811,11 @@ __git_complete_config_variable_name ()
>  	remote.*)
>  		local pfx=3D"${cur_%.*}."
>  		cur_=3D"${cur_#*.}"
> +		local section=3D"${pfx%.}"
>  		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
> -		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "${sfx:- }"
> +		__git_compute_first_level_config_vars_for_section "${section}"
> +		local this_section=3D"__git_first_level_config_vars_for_section_${sect=
ion}"
> +		__gitcomp_nl_append "${!this_section}" "$pfx" "$cur_" "${sfx:- }"
>  		return
>  		;;
>  	submodule.*.*)
> @@ -2812,8 +2827,11 @@ __git_complete_config_variable_name ()
>  	submodule.*)
>  		local pfx=3D"${cur_%.*}."
>  		cur_=3D"${cur_#*.}"
> +		local section=3D"${pfx%.}"
>  		__gitcomp_nl "$(__git config -f "$(__git rev-parse --show-toplevel)/.g=
itmodules" --get-regexp 'submodule.*.path' | awk -F. '{print $2}')" "$pfx" =
"$cur_" "."
> -		__gitcomp_nl_append $'alternateErrorStrategy\nfetchJobs\nactive\nalter=
nateLocation\nrecurse\npropagateBranches' "$pfx" "$cur_" "${sfx:- }"
> +		__git_compute_first_level_config_vars_for_section "${section}"
> +		local this_section=3D"__git_first_level_config_vars_for_section_${sect=
ion}"
> +		__gitcomp_nl_append "${!this_section}" "$pfx" "$cur_" "${sfx:- }"
>  		return
>  		;;
>  	url.*.*)
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 35eb534fdda..f28d8f531b7 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -2583,6 +2583,17 @@ test_expect_success 'git config - variable name in=
clude' '
>  	EOF
>  '
> =20
> +test_expect_success 'git config - variable name - __git_compute_first_le=
vel_config_vars_for_section' '
> +	test_completion "git config submodule." <<-\EOF
> +	submodule.active Z
> +	submodule.alternateErrorStrategy Z
> +	submodule.alternateLocation Z
> +	submodule.fetchJobs Z
> +	submodule.propagateBranches Z
> +	submodule.recurse Z
> +	EOF
> +'
> +

Shouldn't we verify that we know to complete both first-level config
vars as well as the user-specified submodule names here?

Patrick

>  test_expect_success 'git config - value' '
>  	test_completion "git config color.pager " <<-\EOF
>  	false Z
> --=20
> gitgitgadget
>=20
>=20

--Te9q+Ov/nCIAiI8b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXEhdUACgkQVbJhu7ck
PpQ6mA/7BdfoKou/64f/XxvqXWwzkzq9uhvKXhCz61xsFcvcayTVrlKXCRI6C8ju
4gWAabQnNL5IE5OuktdG7TD+C+ey7dgrFpO20ksFGSyvby2X8KxWXwo1Il54/1PH
szDCYEvQnmhrVYdME/zP58ZB/SmD4myOvmG423lCU5S8/Z5G53YJZFojl0OgAkmU
x5nzDBE4OXsPtQzYo5K5K9+FeM2tDkVuhxZU8tt9zSeup7ChhbhMl632QGJRI2xO
7M17BzSuZ1Zyx+naPoiL22X7p59NOsIEewSF+tGjcWv81147y+UwGoBovYeLpU+C
QL2a7KMne/XHKLdHo8fXsc+LMUgA4wGoZXIZD6kMDUzwBCrGYOhc4Md4Oz8k7uHo
i0u/eNnuBKGf7AVuGd36847GeLk8ZYR87Xz+TgLsSwP9hgT7DUVujANIt9QO+4Wn
7CFn9dadoVlQW3TzIzA2YsHmtjzVazlFN82ppgdTjCz3yDevWR137zKvgWyNJpO3
PLTWSU/hDQP0zhClp/Wtk9Aqom0NQcHtbr725eya63wZi+/+/HC1f8cN29WvuBGE
4NrcKfNkXu0riTZL5fxX8Cwjwa9esQcRl2gpTqmJarlKXai/Q1CnlaB4m9RwSaYC
R+O6lZ20ok8aravwlX9PJnB3CTvB9seel7z8uFluC7GpfKCaOMs=
=JLCd
-----END PGP SIGNATURE-----

--Te9q+Ov/nCIAiI8b--
