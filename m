Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1F3443313
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 08:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137684; cv=none; b=Iw4EtQKzlN8QXsUMwzewOc4QBZ77sa6TeEX3zV3UeM7HZUAaa+0hqqJdWUF7yc5nfUlKdVv5D+JOgtzig07YeeomhCIh7YAYgF0NMMp3olnz4Y1r2AW67dp2KDyGy+eDChGnmv0SvmztODvH/dYboiIgLaYv7TUYvMl2bvud7lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137684; c=relaxed/simple;
	bh=Aap2zU2S6E8qU96fLqFuAlnR4ri1DcIUtJ32MHI2Ijk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGSxxmkZHUSZMfYrWk3Anho/FHh0oMl3p/HvfQamQCXSgOPevCUMLbgWfDNhgxU3zGkHECoslztouK5/lyyVBcTAZ1RBxfkkTg4ddWJqES7h0M9RBVG4i4deUBcKJmYwtetfrHAgtvSEdL1wd3IAvIdC28fW1kspPnYHXLMlkmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZRc6G4+r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X+nvxlQQ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZRc6G4+r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X+nvxlQQ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 929641400093
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 04:01:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 16 Oct 2026 04:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792137682; x=1792224082; bh=9rO0PHN8/3
	ksCewErdtRDd9t465B/qyr0flHyUY9KxI=; b=ZRc6G4+rTvcqB9aLKwEmRCJEX1
	P3r8UEnNqHfvmgqsxJTvfWOzbi6AHoFZ16iDsb/L6pFnB+jvlzKzuQ/1racVELSQ
	ANDe9buAYz8QyVZKTzYZEEE8Hoez6IqUJxMn6uyJIgjUxORqEbis18235OqvK/b+
	15IFRZzr1/uc9lotDEKRd/oR9VrRDK/Kf38XeYHuNPfYXeDwYDHrMIOISaHfz+zo
	QNzOrLQSU7GKfl0nFXsvoGtMf06XfmguXwQx306v/3TodSQ3TCygkW/PjHrOkWBz
	cWyQhTgmJdxpv7Lr2mJf3Hkc/+RniR9u8me6REZDX7cLKw8Pc8l3LYE7WrSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792137682; x=1792224082; bh=9rO0PHN8/3ksCewErdtRDd9t465B/qyr0fl
	HyUY9KxI=; b=X+nvxlQQ83HgDWSQryIQ76brjQLu79sh3TEYkBe/T/V3UY4xSUf
	d73WylrdEzm3mlcntJFSjfRLtLLx7vsxNcAdzsbkLzg7KWbItqZDOl0TySsnynTJ
	AAJVMEmxggqCOFdx+U0pzZtPe2ULlmsVuiN8aYt6AVE7D7zqwgghm1jjnBi0NWCI
	curhCON+xyg4FHedaZbCXrVFZcxobnaY0SuA3QcpdzARoDu7/hBgPr/Ar6kgL1EB
	qIQlvjNJjhRF5QZLIGGky8uzds82p1x9P00JP7cPhtVLsMd6XuIKoPIG+uPYGJxO
	jQrXYyf9GVVB7yqncmZmgKuVajRTqmCp+oQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792137682; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:NAlP7qWZvrIB9wOr0BU68Ue5pAnW4mz/kWOzKan9w3kMojN
	veoy81DLDf8Fjnd0ArsXwfJ5AOD3R32CWEbfYjRT6dWYN3poNFBSHPQ18JQsrkiZ
	/nmtrBw3q7b1V9ImkfDjbA83clfQU8Bdkvze2rtu7m8JmziWL8KqzNudVM+sy21t
	LM75sImuAXbUZ6/PKU2FkaUsnnRaE5052QFLrLSMeYYvPhrITFIUCDXTUoiODdEh
	+ulG1C4STPaI9dQCsOBSujHVtJ3mWrunV3x8OYDqEvkbjBfeBl63a7a3ZX0+1DL9
	fY+8J/VomTJ0U0Or/vwoWuIiv21sLMYN9acLsQQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:u6seBvwsXsokgDo59QqR2dNvHHVGbV9HVIOm/sdQgnI=:Aap2zU2S6E8qU96fLqFuAlnR4ri1DcIUtJ32MHI2Ijk=;
X-ME-Sender: <xms:0tnRapmS02bHaRgEEsJIM67Vqxr-1kjcMqfqTqK-MZES7ouB2izy7g>
    <xme:0tnRar2hBRQYntdmXhEl-LhvKqbIpFe1UCqbY5Dgv_3tcowTid-rbJjjI0ZgrztrE
    U76tkFrJpgd_o3AsUiF5TJ08ESfD1jAZ-X1SN2nVB2NJ_mdZtvpB5I>
X-ME-Received: <xmr:0tnRakq52wMKpmTxsgiKVrPWizwL730qbgoimA4bIszXMSPUC4jM0A>
X-ME-Proxy-Cause: dmFkZTFDqs0rO+aAmGBseqJu+XdtQm/Z5VOgrCr8zVtGCSdxeb5VkOxIeZfk6rYfW6uldF
    hkR1pX58S5t4S4HOitV+DPr29FRI2gMJ2u1xsPal7fkC04YY/VwL+2WXv8n5oJbUKy2w/g
    /ivWdEpsZaur4sU7vPOMqDfgPEbR6y6RQnqYfY2+Gq+TtLcfXGmQZgA5qnOC8Cno1nTdkd
    t8Usa1Lscz54j0fW8uOKqPx+wyfLX2pmNdE+tv910bilws/0BPNkgH0sbUsxQJgWxAe7gU
    6bZ9lyVfzGE3mGaT3XydN3QcAjg+ZmzBhW//mqUpJgJBpp3pf8MzBuLXUHwmPIQgrkD9B+
    Vq5acU6KHRhGa4Ic9wRHQVskzw2XK0hvafpqS9FGv8aGthxPrQUBioG6+QCkbatNqlZB4v
    3XH/EjcpCT5SPNojdj6/1Kn4WJQyy70P15oC1xNz1vRqSPlqvlW3PLgHqqX4qPT5W70LWt
    anSSUECk08Pp001esCXa4fdvIQmNkrqYsScRYhst0rCLNw3fQ20x7VzB5N8Q7aXVYXPBDX
    1zmn5s1eTkUEk4xZaDWuOpVNpXJWUnX8FOc7USdWfvJKcoeBTBCsLSo8LbMOwYzDwaIpMH
    ObFKnRKj8WHysfqGgtB4UkAa5Nafv0SfTpoitWQFPOwiFomdvlk9q2pZF2Ig
X-ME-Proxy: <xmx:0tnRaoduXuKEx09LJfVHNFgCdX3lY5U-HZEvJK4CY3X_XkTCdPDkog>
    <xmx:0tnRajqPN93eQsFpVtYR77piHMqOgevDRCxxr6JJWuiuvM7hnvE2qA>
    <xmx:0tnRapFlZL-A00jZu8pYE4s4erd86Y3yOv2gd2yrC7EmemkNtELEUA>
    <xmx:0tnRajuYlpgy2yzueq0G79i24eams7BgNgYYYHHoSsuO5XSlQrDNmw>
    <xmx:0tnRagKgXYXP7igvJn1soL3GnzXag_WGf8JXz96IvMLt7AlcD8_ACkTx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 04:01:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 48d8d1dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Oct 2026 08:01:20 +0000 (UTC)
Date: Fri, 16 Oct 2026 10:01:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/5] completion: simplify stash subcommand completion
Message-ID: <atHZzrybhYzMVGbQ@pks.im>
References: <cover.1791827304.git.ben.knoble@gmail.com>
 <d0e461a14a254cae7d15aa6b62deedb4a0ac6deb.1791827304.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0e461a14a254cae7d15aa6b62deedb4a0ac6deb.1791827304.git.ben.knoble@gmail.com>

On Mon, Oct 12, 2026 at 01:48:27PM -0400, D. Ben Knoble wrote:
> The stash completion helper contains a hard-coded list of commands, but
> git-stash provides a mechanism to list such commands
> (--git-completion-helper). The pattern for using it is wrapped by
> __git_resolve_builtins, so use it, bring _git_stash closer in line with

s/bring/bringing/?

> other completion helpers.
> 
> Note that we maintain the "save" special case, since it was removed from
> default completion in 0eb5a4f911 (completion: stop showing 'save' for
> stash by default, 2018-04-20). We don't have to do anything special with
> the exclude (3rd) argument to __git_resolve_builtins, though, because
> save is already marked PARSE_OPT_NOCOMPLETE.

I didn't understand the last sentence without going into the code.

I assume what you want to say is that we don't have to explicitly
exclude it when completing the subcommand because it's already marked as
NOCOMPLETE. But we don't want to fully ignore it, either, because we
want to be able to complete that subcommand if the user explicitly wrote
it?

So basically: we're not completing it if the user writes "git stash
sa<TAB>", but we then know to complete its options if the user writes
"git stash save --<TAB>". Which I guess makes sense for a deprecated
subcommand.

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index c3a49e2e22..d60e85479c 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -3553,8 +3553,12 @@ _git_sparse_checkout ()
>  
>  _git_stash ()
>  {
> -	local subcommands='push list show apply clear drop pop create branch import export'
> -	local subcommand="$(__git_find_on_cmdline "$subcommands save")"
> +	local subcommands subcommand
> +
> +	__git_resolve_builtins stash
> +
> +	subcommands="$___git_resolved_builtins"
> +	subcommand="$(__git_find_on_cmdline "$subcommands save")"

More plumbing, but less stuff that we need to keep up-to-date. This also
fixes that the "store" subcommand wasn't completed, which should
probably be pointed out in the commit message.

Patrick
