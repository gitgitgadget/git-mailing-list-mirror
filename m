Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D4A3093B5
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716916; cv=none; b=A/l6m0awRnTfzW6N009TuySlznPRJopUpDexJYuqqnliwyYCSmSgVBQqHKYbbeLBzIuRJuezSCoN4jGiAD+Q2prhBEYiTr+ZgwVOHfHKmhLL5vmpybOmCB9jdGshODgWGAhT1j3ObLyjAc+tHBQXrcgxb15oUedT5IWsU9+oakI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716916; c=relaxed/simple;
	bh=ak+GjipcEl2ZnKtYR9JZuWlfkVwun7zth33nkZ+GRRM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=phwiOqt7UENHALzwL8ELA1fjD1ckwvUp6OLhxf7v4vzb2U940NLAT9otIxBQ9iCz8pwSz5NZ11EUTdvwQ2Wx9ql2NfihcZK1qal3g+FHS82vJLbf/TSCwMUILzD+nRCcSj3m/PXFiPULgfROHsfLxjL4HhXeeFq3RBFh7SiOhZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j1GVXtEC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nc9gooJG; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j1GVXtEC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nc9gooJG"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BDF687A00EA;
	Wed, 17 Jun 2026 13:21:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 17 Jun 2026 13:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781716913; x=1781803313; bh=yqbFuSd967
	49kw9ootCDvuNBmzFthtB2Je4aI5Y5474=; b=j1GVXtECTblPqIIfKVS/2uF+Zh
	OliLHv6cWQgRem9T7Np+xJyvIZ58ZJjLA/Sjxz86rz8LFCVQn7EvKG1olzwFFlmv
	STylqUGEKT5d/lRduYBILSv0X079sTTJrF0qg3sFLkadv6tuRdIxKloR5P5gmlvt
	uRVJ8zEF2ZjHzPr5+2aeihllMLQy8V43DmtCLX59zmC+Xv3yvcnnUQnCNvmvdfqP
	0gNMyERPWZVAra4K0GFDCnHimSJRRiBQpQ5UBop0o8fBNGWVCCmsSJg/POc9XWyN
	V4+sW+ka4XGda9I6WJPknzB4fIx5WzJtefDmSY1/gBjntx4xikW6JZz7lLeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781716913; x=1781803313; bh=yqbFuSd96749kw9ootCDvuNBmzFthtB2Je4
	aI5Y5474=; b=Nc9gooJGcT3uzmYn0shWaKmtWJpj2Jo4BXwXJ2fF7orVvcAEfGc
	gfAJ69nVQSjAQVuGEtRigVrgJlcL+wm1nRfLsf2hYnaZ3uAAlYFoZ8NrPRk9XyVh
	wWRsEDIhvfxGLjOPV3Nsf2gcwVKdJLqyCejtVJWNU8QRpeNeZKa7g93fjJmJytPw
	GddSkQskSTxq2Oeb0TXL9Uo9JNZri+NSXdja2tlmWrAsaXyoVCjosna1s/MdaVx8
	ZIEx15Ztz//zTa7HCWm2Fvw3eYTHgpeACM6AdJ1q//2IQNt4xK3BDSz+8DCX+S4C
	CtsRar3p39kDdPnDYkE3LfEEaJUaPclYChA==
X-ME-Sender: <xms:sdcyahPkU_V-5ZAyn79dYr8no3PzvNC9xTdmXB8f4b9VpRdbtkdljQ>
    <xme:sdcyaq_uU_JAYjwOG70ozF3OMhIltngd8M3uk7SWt7u1LUcx_n_KBChAVf1gBLhL2
    cuxYWz_in2bnvGc33eeHJRoX_oobsME2GUYlQAirusYSwQ_nCOhWQ>
X-ME-Received: <xmr:sdcyalToa8-WFzdUissPhTqqwGJPuKvI0w56YQ-uYCIx_lnaaKx9GfGEqt1zaZ6kluaID7fLYTH27lqsRM5CudgqA_tPDolUtdLD>
X-ME-Proxy-Cause: dmFkZTFf6vWfF/846mFdMOth/5SvPregSW/XOpP1oi4wMrBnVT1ayS9c/n+BumaV3F50xO
    6uBYzuw9dHLfbn5kx9OvmQU435Lh2jLdQFF7SqsMzGHiYrZRHSmLMa5lDAiT7vPtMWFUWb
    1re6Q81fkEoDMOtV23f9V+XgFFploHU+fFl2wlkLnDz4IZMS62vKwaQPBNY9s/HXW0C3lT
    jlrp3YrQrQGilCtsnC8fi0cYnl+NaxUG171qvKTxvdLm3IDG/temU8LP3mNo4oPfGNlME/
    Cu22DtumTHg0CEgyicKCWzjiDDgTZv1bchL+4rzuq2dM+N+c1vU6DwSu7WHNZKZBJ676jK
    a4ShAT0M0h0K9frbaPQxZfaLGVYTkluaUJOQDBXcRW1gfb4xAUnRf9YAm0luyPaS3/hsjk
    F7OYgXFoNDAeRR0PgVhNyVC1GyO24AST87EmecSdp5V5JFudj9kM5XDd5x0Ld9zpyWKiSZ
    CBrP2bAQpeV4f0VqqkLRk9AH19JRKk+O8ocVaGcNq6X0vHQ/KFKzDDJkpNVuZK9yJXlqEU
    S2CA+bcROgiPwJXw1RcmRYHOX9bpRFStcaP4wDF+MfPrGAvZPIwavqtt9Q6/d+s9TPO23/
    mHP8A5Yc00H90lYGB+yDSvITxI8KihNf2qzPLxX7zYz3Wdjn929ntFNz4mQg
X-ME-Proxy: <xmx:sdcyaslxPSIqie_7i_W3PMrjn5sWzoV6e85dG4jps7hpwtLupWuvOQ>
    <xmx:sdcyalQ-8ah0UgPJdLUJfi7yxXIJd8yAOMu_pJIY7QxiyNyNUdaoyQ>
    <xmx:sdcyaqNPvUiUo2QX9Vd8P6oCJe1YuQkYV48MTorPacsaUyaOKl-NFA>
    <xmx:sdcyauVtVlrESpoJ0h4wdvOLz7wHiLoc0vEI_Zj_NF9X-kxrGXzr_A>
    <xmx:sdcyaow_EewprjoSLPhDyqzfzYVHosrWMaorJUs3--QjkgCMV2p_2a0->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 13:21:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lutz Lengemann via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Lutz Lengemann <lutz@lengemann.net>
Subject: Re: [PATCH] completion: zsh: support completion after "git -C <path>"
In-Reply-To: <pull.2155.git.1781710256081.gitgitgadget@gmail.com> (Lutz
	Lengemann via GitGitGadget's message of "Wed, 17 Jun 2026 15:30:55
	+0000")
References: <pull.2155.git.1781710256081.gitgitgadget@gmail.com>
Date: Wed, 17 Jun 2026 10:21:50 -0700
Message-ID: <xmqqa4stw09d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lutz Lengemann via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Lutz Lengemann <lutz@lengemann.net>
>
> The zsh completion wrapper (__git_zsh_main) did not handle the global -C
> option, so "git -C <path> <command> <TAB>" offered nothing and could not
> complete a command's arguments.

I do not write, use, or customize zsh, so please take my comments
with huge grains of salt, or just ignore them completely (your
choice) ;-), but one thng I noticed was that ...

> diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
> index c32186a977..323049be8b 100644
> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -227,6 +227,7 @@ __git_zsh_main ()
>  		'(-p --paginate --no-pager)'{-p,--paginate}'[pipe all output into ''less'']' \
>  		'(-p --paginate)--no-pager[do not pipe git output into a pager]' \
>  		'--git-dir=-[set the path to the repository]: :_directories' \
> +		'*-C[run as if git was started in <path>]: :_directories' \
>  		'--bare[treat the repository as a bare repository]' \
>  		'(- :)--version[prints the git suite version]' \
>  		'--exec-path=-[path to where your core git programs are installed]:: :_directories' \

... this part talks about not just "-C<dir>" but knows about
all the other options that the "git" potty itself takes, while ...

> @@ -252,6 +253,14 @@ __git_zsh_main ()
>  		;;
>  	(arg)
>  		local command="${words[1]}" __git_dir __git_cmd_idx=1
> +		local -a __git_C_args
> +		local -i i=2
> +
> +		while [[ ${orig_words[i]} == -C ]]; do
> +			__git_C_args+=(-C ${orig_words[i+1]})
> +			(( __git_cmd_idx += 2 ))
> +			(( i += 2 ))
> +		done

... this only knows about "-C<dir>" and nothing else.

Doesn't it want to do something similar to what __git_main in
git-completion.bash does at the beginning, namely, this part?

__git_main ()
{
	local i c=1 command __git_dir __git_repo_path
	local __git_C_args C_args_count=0
	local __git_cmd_idx

	while [ $c -lt $cword ]; do
		i="${words[c]}"
		case "$i" in
		--git-dir=*)
			__git_dir="${i#--git-dir=}"
			;;
		--git-dir)
			((c++))
			__git_dir="${words[c]}"
			;;
		--bare)
			__git_dir="."
			;;
		--help)
			command="help"
			break
			;;
		-c|--work-tree|--namespace)
			((c++))
			;;
		-C)
			__git_C_args[C_args_count++]=-C
			((c++))
			__git_C_args[C_args_count++]="${words[c]}"
			;;
		-*)
			;;
		*)
			command="$i"
			__git_cmd_idx="$c"
			break
			;;
		esac
		((c++))
	done
