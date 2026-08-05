Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D623DB319
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 06:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910793; cv=none; b=FQh0OKB4pXww/Rxc46c8rJvDFRv3r06QYzUq0bXv8jSTp05T9fzEgKTi9pZAN9ymoiAAEBRg29zB17WrgqS1J4wtuD/Ug2sh3C2rghXnJN0rFe+halDexOLARNcnqfG3EwIFyAPBevrdfEx4QVQYQSqImdXIn3JSeCeNhQaycTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910793; c=relaxed/simple;
	bh=x1cto94667IUrhWc44ogA7yUd2uqGaVUZZRah5IFea8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBhmNatvJkpgVY8aUpffoNuUuLoOX+ZFEY5a0xTLmCkDBY4Z1X2+Y4/3gjR28LNFp3E4bV3rjCi8PB9NnZUJwqwbXvHNWv2eYJmYxzfGKdUVbtzJ1106JgJqCCOLlJ4EpxmpqttgPEhCth4VCZOdXdEKI0WCME0q8fz6NP1AoyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ADjVNAf8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FKCMPgT2; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ADjVNAf8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FKCMPgT2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 23DCC140016B;
	Wed,  5 Aug 2026 02:19:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 05 Aug 2026 02:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785910789; x=1785997189; bh=QUzwtULDuF
	/lGT0Q+PlJBf1+xbDW+24KZI0f1pb09+E=; b=ADjVNAf8RuHzppIjIOjPVXAZ+T
	GkfidD1DmjdvTw1b0Qf+53O4XIRa1k8vIvQqOMTTSMkkZI3WGZBJ99g7NqmChIp7
	0SUwSZUVM0i3OSHrwj/sIWMkC+6imG9Lyp3B10L4nUrC4YplnU/ap1OdwCAqGRlc
	O3dRbNSA5OSy+T3hQiYo89JIruxOMftMp5YcA2Nrps+CBG1jJxKFcBzzA4N0yjtY
	zbMO1rVYfvEU6mfDWXlzkJs+j61za2Ujx7maka7hnZcWprmr/fjslLUUjfXUKkG+
	Nzh79Pq1u/v1HCPhoc8SsxAJaTLxq3IAr8A3xoKrCNJvTZdOLv7iMZyOA1Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785910789; x=1785997189; bh=QUzwtULDuF/lGT0Q+PlJBf1+xbDW+24KZI0
	f1pb09+E=; b=FKCMPgT286p3Aa9BETnW6YXuaT0jNxtr3ihCHNfI8xFlaI0vDxa
	0o0Znpk3XS3igwqQKRYttBM2nxlsxTWaEC4xkFeO24XqsJNvZprJQLu8pnjy9cSt
	ms2VZ3WKc3ZC54RC7yvuRq5JF/HCrSd7dMjFuh+tTN29sZdoIYZ/al0H5GbB6Dla
	kXAoCblTqYDiLvV8ucM/MOQcapKREDTzDUloEKI42D0Ieea4iIhYGV2TUp3HvgbJ
	vQDN1qEyVPnlyMv/S3965jZBQg96SHUYeSe0d5rd0blxhqfPghZUhHCU0eRmnWQV
	vxSCLj3uFEG4TYqeOPgb1RDv2cCNq9DZuLA==
X-ME-Sender: <xms:BdZyaooiaccZ2AyvEwwjOfhpcLYuLIQNhgOmLSUyaqrcjZhMIlJ6Zw>
    <xme:BdZyalpxMkPKpaikH24ZVlO7Pj579aMKkODltMnNHfh5wheaerNcdJt37W4Nhke77
    C18mUTtDdCEg76hnq3YMbyaNccC5KR7cqaZ2AeKR08fyrF_6ECKH2o>
X-ME-Received: <xmr:BdZyaiMtM-dPCVwqYK3ps1FFjZt3C2dq_hmhgno5IVSyRrgTG8Cs5WDJDhBQe2Zv1fgUGVh6YxLnyYR6Y54ZzQ8gpHvYwHrjWcZoo1t_Lg>
X-ME-Proxy-Cause: dmFkZTEo+c916gczkidc2fM2jJ8IMIFGNof4JvCqHRo5ZfG3pqlZEtd3MQFwTqviC3ZC7k
    j2gdq6gjZx+hwkvP9LpHi/BXmUdIvV1ukKGiC0bCjHjP5ppxI4EYhlqoBqiFpMqfVcE8bf
    fWol2sPro9QmYaQtoozL82vneRG/Dh4UGdO20Y+SIMotsp2LsmTGJFsM1TIylClwS+7JEK
    jEu7DH25kagJed2c+OAqQbPYswv5vlwCwvvViC4ITiGfw0/1U4EkExCD4VLgneqj5kGYho
    CBVtHOOS1nhofJTbA2dLz8vZ3aITp6GAg3YBB9E7mIFM8nFPyiBigqWEBFPDbHNu0trvnA
    qnzdA03Vg0svk5qffekAFeWEQ4XPxUSjYBV/RX5b27fCxDV5ObZnrJHsyfnoPsgYAtMuYr
    5ERqWp2sZweYBGq/Wdg8wAD/yEbGJaw0tp+Xmca6sAgQ1y47A5QmR4T29cv8/zIPHPP50r
    gJAaZ5PCbakqJujQ0jb2VWI1KHKvJ7BeTpX6510uvp4GCO8oXB0UvzEP/3Oc1+pTM9ZjDZ
    rUfVF255ghvhE22jjMGLMX5NNFI415YcpW1ESikuoChHELWxqHwHlVFMfXyMepsjO645rB
    hRcD5CDRPeVFEGwxi5gKP4O5B16MVWD/3LgRGRvLPVK8TNQtyzgGR13EGLZA
X-ME-Proxy: <xmx:BdZyauy3uzrNTkSHBjrQMHok-w-nnwz2boSHHa1HXVPWtvpKfuq_xA>
    <xmx:BdZyajuN_Ivb9_pbu8s_x_pZl6_nsfjBgt7qR203EcZlMuhvUeF7-g>
    <xmx:BdZyav5xZSyv1hN5pynAOIqdtk8-9iC_VuCj7zDkY_tQJXEmaKJEmA>
    <xmx:BdZyaqTQru1-zpXRsHfHT-mBMK_T_rj_CL1hD2C0NlEQFAZKGAJhgg>
    <xmx:BdZyagcgg1PkdMDq1uuS-ut7uXtphQxbZgG-CWkkj7NlkQpBZA7tmGSM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 02:19:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 914bfb3b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 06:19:46 +0000 (UTC)
Date: Wed, 5 Aug 2026 08:19:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] completion: add 'git history' subcommands
Message-ID: <anLV__4THdvugj8f@pks.im>
References: <20260804-history_autocompletion-v1-1-6f7459ffb677@kernel.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804-history_autocompletion-v1-1-6f7459ffb677@kernel.org>

On Tue, Aug 04, 2026 at 09:56:32PM +0200, Vincent Mailhol wrote:
> Use the parse-options completion helpers for the "git history"
> subcommands and their options. Complete positional arguments as
> revisions, and add coverage for each kind of completion.

Ah, great! I wanted to write shell completion for git-history(1) for a
while but never really found the time to actually do it.

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index e875787710..f10813c8d7 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2137,6 +2137,30 @@ _git_help ()
>  	fi
>  }
>  
> +_git_history ()
> +{
> +	local subcommands subcommand
> +
> +	__git_resolve_builtins "history"
> +
> +	subcommands="$___git_resolved_builtins"
> +	subcommand="$(__git_find_subcommand "$subcommands")"
> +
> +	if [ -z "$subcommand" ]; then
> +		__gitcomp "$subcommands"
> +		return
> +	fi

Okay. We first try to figure out whether there is any subcommand passed
by the user already. If not, we complete available subcommands.

> +	case "$cur" in
> +	--*)
> +		__gitcomp_builtin "history_$subcommand"
> +		;;
> +	*)
> +		__git_complete_refs
> +		;;
> +	esac
> +}

Otherwise we try to either complete available options if we see a
leading "--", or alternatively we complete references. This works well
for "drop", "fixup" and "reword".

The one command where this falls flat a bit is `git history split`.
While the first non-option argument is indeed a reference, subsequent
arguments are pathspecs. So ideally, we'd notice that we already have a
reference there and, if so, complete file paths.

But that being said, I think this is a good-enough first iteration and a
strict improvement over the status quo -- we don't have to be perfect
right from the start. So if you want to also make that case work then
great, but I won't insist on it.

> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 9ae3c48ebd..08ecf682ed 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -3107,6 +3107,23 @@ test_expect_success 'git clone --config= - value' '
>  	EOF
>  '
>  
> +test_expect_success 'git history subcommands' '
> +	test_completion "git history " <<-\EOF
> +	drop Z
> +	fixup Z
> +	reword Z
> +	split Z
> +	EOF
> +'

This will cause conflicts with "seen", as there's a new upcoming
"squash" command that's currently cooking there. That's fine though,
nothing you can do about that.

Thanks!

Patrick
