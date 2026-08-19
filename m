Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8E844D013
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138016; cv=none; b=WSVmndaXPqyWSZWKUkDkXZoxV9ooTgrciZXLBx00aPI5N27VQpSbBJAURzNOkxwnJOhp4DDSLaPAiGA/Cxlgxb+SWw3HlPOAG3cjYlY3XpxLPhzW/iTo0W8uM2vCeG7YWOC0yNWNWNGub8+afrFoEH/vnm7aiOWfdjSYIfA1GE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138016; c=relaxed/simple;
	bh=unu9YeclEhG4xPQdhsp7cZB0rBnDQNk9lUOgPKKxVWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHfn7Lv6ACembfRjRYLChrO8Ejlp6SWxdj50O+KdJGYlvD6TtWTg844oGw8AQF1FBb19lNfwX1rFvFUfn+dEiQn/cqYW6KRES1nMJJxDztVkv9qJT+tRe4NiGY6Y2oP0QBJY1XieIVIe86gQqCknOiBTmG5d9zJcRlid5wCF6qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZmAOHk/q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M/3CuFBx; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZmAOHk/q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M/3CuFBx"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id EA00F1D00153;
	Wed, 19 Aug 2026 07:13:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 19 Aug 2026 07:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787138013; x=1787224413; bh=mnkw3Tp4zS
	1fTcGVphwVPak9L+OzfONf6Idxduwis+U=; b=ZmAOHk/qGXVXnBz/e0IOdfYhjz
	QoE1UWIXRNoSMMEbx093/zwUCI+2sYXkbcsxE/RwF7FH8h7yFt/GRIZYpMA5kBXl
	d7Yu6DylIaKRmRC86MvMAQr5GEq7kLFy3c2X92K0eIEeMW5pIXOMguF5DOFMO9Y0
	SQGQ11DVsT/5jnpwGBEe02TJuZ1CFh1WdxSE4Ukugn8JvJm20mJfMs9VmiTPh858
	Dk09FR+DgvxMvNEdy3JfCU7LAlZN0MjuON7wsHErZO6cMO3uNG0lJMcH9ar4PI3p
	SjI3llByvcWox/K44gUixQMujGXSKTd6FQJ4Z9DmnUjCe+/tyqBNwzz1XkEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787138013; x=1787224413; bh=mnkw3Tp4zS1fTcGVphwVPak9L+OzfONf6Id
	xduwis+U=; b=M/3CuFBxVLBPeRak9hY+RBLTaaJvtJIm7sjlrLWDhO05fALWjqa
	wwGC5X075kTSg5Qz9b5FuyXWFKRYGXblbcKVLw+ZHehfNyIKiHtPZzPiwEF5cMbo
	54a7Ibb1AD88B6z/DzpPSWXrwXrErrYVwJj6FwyUikRLtOfMt7V2sTkWa7Thr49w
	K6FH2/RaWjWBLnSMs9CMLQevQBEDHSFPuOIU7I2RPHq3EiDAzJX0YzTuXw9NLBlO
	KmaUJvpj0YOXpx4FfpTdJpFCRvQsu0bNjBjvAR6CHI1k1XwU0Akpk0L7Fdm35d9T
	wjBuBDnqzGRXUOk4PxtDCoxUsjIsvqc2VdQ==
X-ME-Sender: <xms:3Y-FakQES4vzJGA_Q2pLfx0MZhQbOtUrAIgKol60fH1ytaVUYufTnw>
    <xme:3Y-FaorPorbcTTyAg8Rw0FI9rpzinGzYtaY5lHN_PLEPGTIl_vZHhv-3ouy3ByX1j
    VyynTSp0ZGLzf2ebLv-UwdX7nn59OSy9G6v_uY9XwU4bH7IajfKag>
X-ME-Received: <xmr:3Y-FaqLsEqzoG5_RVwmh6Z7BUHYHB9amSuYz7TSN3ptW5EJLvw-GldnGM3_yPZ6G96zrZEaMcRuTtRkfyFMeEV3dQD-pRCde9zAQJF4x>
X-ME-Proxy-Cause: dmFkZTG0GEY6axZ+Wn4O6te2LRprKx+5AO1GpxasARdSbtSSbCuxSzf7eLahirAFwGnGh2
    lqan/ye8fHcr4XDzWztY2fPWUPgeWlCWKAB8/+JBdPnXRDyUxYHtbEx3/sozzPHgFGC6Lk
    ozMy9UecR1xlVpfnkDA+DS3hL8Alml0BXz/+BZ3ZnuCvaLF2quc/BTppB4muLg951W+3UD
    rstbVTzgggmjeignE7uQ/dAI5rdnFO+1Ypv8fqk8GRrvXvIqLtb9HU2YHDF426s3kK/5iH
    Yq1Fwt4NQigpR3pvZJcyKy1WIv56F2C6z0QIAjm4NwMifROWLF3rhjWMW3Hg9KyQ11O8He
    4TZaRhA3MVKuNUQwHyLX0KlcNMPF+RkbO6a/wNE3K7Wq78d11WIYvCwUPkclYFnMFqyIhF
    DlA82UTYoSDklYY5NzK06RrIeff2bwAMOERlQtka2M2GNiGrXc+OjK4L/e2IA66bge9ygt
    Nvf3i2qHOq0YmqtXcFTASkTrhXIdHKbbZMchC1GrLCh+RUKIyZGOoKx1HS4CD5wpD0fDdL
    SihZe+L4l2YTta2M50EKNL1FcAkiETkXeDtBx2+cYw9+lth8CxR+uzuh/En5ZwaVVyM5EU
    8tpYnm6xGySS27xBeMcAE6UE0O0yLBgQ65G/3OBPlLGpBA//jC2NHQ6e8BbA
X-ME-Proxy: <xmx:3Y-Fajp3oWuOEE3nTKGMUxhFhaiToeNt7YILVrTNPfvzxJ1qTtwksw>
    <xmx:3Y-Faqyca08V23RmZThRmLxn9_p9csXEfyissIzudH0abApssYkH_Q>
    <xmx:3Y-FavOWIBpGZc5P6FshxqZX9ebR3TE_BLdqS59Zbb0-lvjYhBolPA>
    <xmx:3Y-Fan7fu5_S4ZBe1_6yjaR_7p2we0cJMoo6G_yoTPNovmtlJ9YPnA>
    <xmx:3Y-FaoBgFBmYEpejqCWGPDDiZmkTc1JumHusoxT3DmIDTHMabDWdpLJ2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 07:13:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0fa5c46d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Aug 2026 11:13:32 +0000 (UTC)
Date: Wed, 19 Aug 2026 13:13:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Philippe Blain <levraiphilippeblain@gmail.com>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 2/4] completion: complete 'git history --empty' values
Message-ID: <aoWP2OHLMDmNBBBv@pks.im>
References: <20260813-history_autocompletion-v3-0-69eed1cea93a@kernel.org>
 <20260813-history_autocompletion-v3-2-69eed1cea93a@kernel.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-history_autocompletion-v3-2-69eed1cea93a@kernel.org>

On Thu, Aug 13, 2026 at 09:05:03PM +0200, Vincent Mailhol wrote:
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 1727768487..7f3cabd595 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2169,6 +2169,15 @@ _git_history ()
>  
>  	if ! __git_has_doubledash; then
>  		case "$cur" in
> +		--empty=*)
> +			case "$subcommand" in
> +			drop|fixup)
> +				__gitcomp "drop keep abort" "" \
> +					"${cur##--empty=}"
> +				;;
> +			esac
> +			return
> +			;;

It would've been fine to just do this for every subcommand, I guess. But
this version works for me, too.

Patrick
