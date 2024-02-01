Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991B64DA0F
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781338; cv=none; b=QmXApRuoldmx2RrbuSPvr1EEycjFBN5uAJpZjDft726mLClYFbjvq1ZjfmwA4PmEbJuHxb0jmvipJYW55h09cCIPIfoXGqge+vbmXi8HyJi5C+oRIqs+jRVO/K6xW46/IXndlb1ZKLZYsswYZ79u/L+s9fx6F6jTAI1sSu2I6kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781338; c=relaxed/simple;
	bh=GL/8in4Hf/RqpDodWvIpWQdTAuImybwMxiP0fepckdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mN7SWWA/mQE/qJ887W0rod867oBOqsJUozK6/LMF0n4jH4dVXvUz83DkXq+NJa3Xbc3z+tLLiv5C04OBqBvUsM+SPFV9bTaIsqRY2SZ/t02wVCiBANyiQiIH9Ht3GWihn7gUZAyqNpMWweSzJH5oV5J99qX95UK6rrrxaLoa4bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aOUR8dzA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hr4vQNQA; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aOUR8dzA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hr4vQNQA"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 5F40C3200B87;
	Thu,  1 Feb 2024 04:55:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 01 Feb 2024 04:55:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706781334; x=1706867734; bh=E6GvKaUVmL
	3KybwUlmrO7WcTHBS3jojThTz8MdKfwCo=; b=aOUR8dzADsXfrRvwQh/jV1q1QT
	C9fqJdB1tEjBk/aVk1MVRBE5IE+e4T2nJIOmopkibkVMvkMJIgkHPoCSWgGK7DmT
	E8sYEUuMEzjNVsa6dDv1zhRdITZbcuFpNKVw3pGwRqyyBdGIXh5hcCjXtv2tCLPH
	MW1GnXNHth9y5LDXJ5U87OXAIIOlZsgqazbzD6b3cR7DLswMfR0Rko3YKHXl9s+g
	46yng5pwwFC7NgKp5RC+/CjAdFk11RwojdSjBUENLVrBByXcC+oWp/DXxDBUGKbr
	SiXdZ90tYjWS4X9h708raVU6ZY2LR1VE2rNLO5rq0Te3PcX8hqkV2FKrgDiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706781334; x=1706867734; bh=E6GvKaUVmL3KybwUlmrO7WcTHBS3
	jojThTz8MdKfwCo=; b=hr4vQNQAEhiaxCgLO/mPUyQYjThnUgk8fAhA4J99xWox
	HHtzq9k8pvs2KEWD0A2MUU2uJSBMiN30VYylscIDYTV5g8i9ijCAwS+tygyIxpom
	Fr4Bp3Z83Dy8WR3umLqKNAiPDDiinp98Wr2HsXNMh8Tcc13z7niktfrOf5V+SFFZ
	jaBdtOqwqVXZFKif/+prJ/kpvmPe5xL1O6vKazUHUZ5u236qPRfp2CLrLCmzlaCW
	2w/7eN9YXujXAjY0EYEg33CWtiandRL0M0Jc9xzXZWZca4K48O7+J2LfSE30/teU
	Rf0clGjKhPIkVgrt3L+eYdDqjL5kV+zl712RSLF3wQ==
X-ME-Sender: <xms:lmq7ZW7pPylkZgQZOXOHfGuxnXqsq7EvUqOAwijqAxPFCQC7VKvTvQ>
    <xme:lmq7Zf5TTdm_hjRJzvqbxhinB5RXXUdc0asjuPl26M4BQ1P2kOkYdbWecfUnvsD4K
    1rCYKQtA68Qxcv65A>
X-ME-Received: <xmr:lmq7ZVdP66iQ7-iK86CeQwe7Omekdh3ufjHUg14zelPQN3WoF_pLBCdvL5us7lXnNn9_MShz0ExOBF2P5Mn5zJx2aPOtuBOzTxOKVQzfyQibUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:lmq7ZTJekDAnHDtsLluY4Wdv9w04OOg-7p5Xx6JtVbh7e4MM3teMww>
    <xmx:lmq7ZaLLdNCwHQUBOUYYiIr8201KrjNtrcxrtS2cGcam3YAo0HJgXw>
    <xmx:lmq7ZUzc7GY6vwyOtREJs23-ZmEGScQ2Ut9xLyeRl-v_YJ31_QS0Fw>
    <xmx:lmq7ZRXrvDKizslDoIeyt_lYNZJYWMLC6bhJx-bPH5Tixiz7v6tJnQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 04:55:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f54f6c81 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Feb 2024 09:52:11 +0000 (UTC)
Date: Thu, 1 Feb 2024 10:55:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Britton Leo Kerin <britton.kerin@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 5/8] completion: log: use __git_complete_log_opts
Message-ID: <ZbtqlBHeFf4xzC8i@tanuki>
References: <20240118204323.1113859-1-britton.kerin@gmail.com>
 <20240128223447.342493-1-britton.kerin@gmail.com>
 <20240128223447.342493-6-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NZrHBb33Y6Vc+HUe"
Content-Disposition: inline
In-Reply-To: <20240128223447.342493-6-britton.kerin@gmail.com>


--NZrHBb33Y6Vc+HUe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 01:34:44PM -0900, Britton Leo Kerin wrote:
> Use the new __git_complete_log_opts function to handle option and
> optiona rgument completion in _git_log.

I think this commit could be merged with the preceding one to clarify
that this really only is a move of code. Sorry if my comments on the
previous round weren't clear on that.

Patrick

> Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 95 +-------------------------
>  1 file changed, 3 insertions(+), 92 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index dfd504c37e..41c76c1246 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2195,98 +2195,9 @@ _git_log ()
>  	__git_has_doubledash && return
>  	__git_find_repo_path
> =20
> -	local merge=3D""
> -	if [ -f "$__git_repo_path/MERGE_HEAD" ]; then
> -		merge=3D"--merge"
> -	fi
> -	case "$prev,$cur" in
> -	-L,:*:*)
> -		return	# fall back to Bash filename completion
> -		;;
> -	-L,:*)
> -		__git_complete_symbol --cur=3D"${cur#:}" --sfx=3D":"
> -		return
> -		;;
> -	-G,*|-S,*)
> -		__git_complete_symbol
> -		return
> -		;;
> -	esac
> -	case "$cur" in
> -	--pretty=3D*|--format=3D*)
> -		__gitcomp "$__git_log_pretty_formats $(__git_pretty_aliases)
> -			" "" "${cur#*=3D}"
> -		return
> -		;;
> -	--date=3D*)
> -		__gitcomp "$__git_log_date_formats" "" "${cur##--date=3D}"
> -		return
> -		;;
> -	--decorate=3D*)
> -		__gitcomp "full short no" "" "${cur##--decorate=3D}"
> -		return
> -		;;
> -	--diff-algorithm=3D*)
> -		__gitcomp "$__git_diff_algorithms" "" "${cur##--diff-algorithm=3D}"
> -		return
> -		;;
> -	--submodule=3D*)
> -		__gitcomp "$__git_diff_submodule_formats" "" "${cur##--submodule=3D}"
> -		return
> -		;;
> -	--ws-error-highlight=3D*)
> -		__gitcomp "$__git_ws_error_highlight_opts" "" "${cur##--ws-error-highl=
ight=3D}"
> -		return
> -		;;
> -	--no-walk=3D*)
> -		__gitcomp "sorted unsorted" "" "${cur##--no-walk=3D}"
> -		return
> -		;;
> -	--diff-merges=3D*)
> -                __gitcomp "$__git_diff_merges_opts" "" "${cur##--diff-me=
rges=3D}"
> -                return
> -                ;;
> -	--*)
> -		__gitcomp "
> -			$__git_log_common_options
> -			$__git_log_shortlog_options
> -			$__git_log_gitk_options
> -			$__git_log_show_options
> -			--root --topo-order --date-order --reverse
> -			--follow --full-diff
> -			--abbrev-commit --no-abbrev-commit --abbrev=3D
> -			--relative-date --date=3D
> -			--pretty=3D --format=3D --oneline
> -			--show-signature
> -			--cherry-mark
> -			--cherry-pick
> -			--graph
> -			--decorate --decorate=3D --no-decorate
> -			--walk-reflogs
> -			--no-walk --no-walk=3D --do-walk
> -			--parents --children
> -			--expand-tabs --expand-tabs=3D --no-expand-tabs
> -			$merge
> -			$__git_diff_common_options
> -			"
> -		return
> -		;;
> -	-L:*:*)
> -		return	# fall back to Bash filename completion
> -		;;
> -	-L:*)
> -		__git_complete_symbol --cur=3D"${cur#-L:}" --sfx=3D":"
> -		return
> -		;;
> -	-G*)
> -		__git_complete_symbol --pfx=3D"-G" --cur=3D"${cur#-G}"
> -		return
> -		;;
> -	-S*)
> -		__git_complete_symbol --pfx=3D"-S" --cur=3D"${cur#-S}"
> -		return
> -		;;
> -	esac
> +	__git_complete_log_opts
> +	[ -z "$COMPREPLY" ] || return
> +
>  	__git_complete_revlist
>  }
> =20
> --=20
> 2.43.0
>=20

--NZrHBb33Y6Vc+HUe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7apMACgkQVbJhu7ck
PpRr+w//QRcXo9XOqprAjxTZt/YR/QvrYDzOSFu0ERP/zZTJyi16OLBPuTk5Q9D2
Gwmnqwkqi2q12ButyQNDJTC/IflFqvB9qtyx8a1o3zsX92wiVv1XhEPbDLIx2u0o
QtXPOvxt8hZjzmvS5Fe3PIRhdsc0M8YAmEQAtrCw3aVYMJ+SHZ/Ob7BmB9GVtbkS
1XEoFk6rOJRKp3DpD4FZe/29qQA5v/L0s0yGfzhDj3RQeyzt52oOR1Fwt1JnZnBS
wmjggU7gKUJIH/n23HLE+P0tMXgteWp5hwPzUHZZPTa7LTPtq3LXehFIttXG49pT
t9Z15/30yp/kDIddmamoe0E8ENT6oByAzFGE/8quIjuNJG72MN/ru4Ph2KjGh411
VJuEXQNTlrscyDTZ+YstfBvzPEJU6OCoDkwWdpuaECqIy6G/l8wMR2vfshFLyKmU
cqHN8yDakojEwyQ3Kx/r8FolKLUKD3XD5v9A1a9sSYjTzcZuxhGOMnYRiVGRfmUD
MvzfRnlYnGBjQMJle7gVsdvBHjk9jIwBJoCyRaNclpvZ8ycKUJSDpGtabAGXiQLF
9UBrHKa04nQiG/9vXIxiNUy/OMrvCajxjvXkRX8nZQyv5XBsNnLR/KrlwQsWjvnE
WR7HAcTEbxcXzd0jjVo2tEdA2EJD5r61FTgkO6V15pjcpmbwUZ8=
=pHLY
-----END PGP SIGNATURE-----

--NZrHBb33Y6Vc+HUe--
