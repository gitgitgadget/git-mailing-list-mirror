Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C151D69E
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796802; cv=none; b=ODX11lgjoRS71+QejZOZXLhT15v0OhQxprvOQQKeiN2YVpm07sVo/o6o6Oc55zJP++1mNcZJHHoO2vqZbO2vj59uKoRx9TPm/ehe1JnSCD1nnAd9J5ReAR5f/4ZmQFtcOD430tjCL6PoDrirgZ8GZgIAaw0G5lU9mh0qzopWr8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796802; c=relaxed/simple;
	bh=w7t4tUmOjCPopbpbkr8LKRpReFLErdPtcL873/kjaJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mfg/6EDI+P7x1t5GwEbcfrXhOhck2HXoNizd4TccluQ7nP2veASYkc9h465rqAhgCqWBg7/HRd82TX6R4t2B1FPPFshsLSvVpeiyvovyTF3FBmKmtEMjTtiBL1aZUk0P1LlrK17irrqjHO5PE7MaFabR1KdG0efGrxkR1UeCmq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c8lcjS/c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bR0xkFp+; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c8lcjS/c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bR0xkFp+"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 625EC1151A95;
	Fri, 16 Aug 2024 04:26:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 16 Aug 2024 04:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723796799; x=1723883199; bh=BCrE8ZhKPL
	4aWGDQaOV0phflXz0GNTn4zXNXVDh9zc4=; b=c8lcjS/ckSqHHkRKvZ0qpeOnlz
	1mpTLEPeRPnc/EIc4A7l48gjKnuEhAXmwjNbzIgZc46g3M5E1PKst0hU7WX30kG/
	vUYH29Ap33+mU8OSlsHyFzIC19y1OKUcWJq4tmzkFLvthRDoiZ61ftGKkzHRZX5w
	UgECGDPXOl9zssSkdQrulCHxE76e2OCwZgebzJr4VVhm7r0BnN4xudf1modQDyFP
	PbDaOIxR4qefJF+vdW8hA96t1jC12uc9lcDKwu5saYP+6jg3AY94YiqpUgczRLS6
	I/nXXl2MxjILdDZ8EorCtlXpAeP6nyU1zPurkbjWgZkn3IWHQj28qNjmiHBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723796799; x=1723883199; bh=BCrE8ZhKPL4aWGDQaOV0phflXz0G
	NTn4zXNXVDh9zc4=; b=bR0xkFp+CzEOaBn76ldc/r/weTfEIc/2ZknOC9QaihGT
	EoHuNfSoq/YLOnm5O7bEzWxOrdeJ6gFkmNlSU0hQ7X1Wdo6iGKWyWHpLmd2sbNF8
	yTBXs7el5VKjGzdWqjwtGY9tL8BJlKqCwAMLqraG90hjpt6FdaBhcdyn8HXE6cwm
	FkNe+awn95ZZE0K4v/LlosV/hPBG7YDRPeoVB1ci2ktxLvx460XZkMPOb3+hTwQ6
	E1K0m45yfucI+E6KwtoQbuPPxndzDzHrkUNmB52DCI6lXwetHpxOMo7GnfppvaT0
	wvtjlb5mvdnqzPC0zAyfRJTx7WHrh1NG1aPaiXkeLw==
X-ME-Sender: <xms:Pw2_ZgWWQb9ZgATpV0D6SyLXSsK097_SLRi02EBjLaDx16-AISroFg>
    <xme:Pw2_Zkl6R0ajwFln-mypW1fsrdBAGyHMKmpzSo4Um9JyyWIF38GUIwc5DEJL7d3f4
    8TgnEknd5Prmh8MYg>
X-ME-Received: <xmr:Pw2_Zkb_-CT53d5tq2sE1QSwrWD0RQxgSzBmkuNfdL2bCTb8sqqF8e8AQ1HE8ahVO2jg-Ps87TM7WpL6HuBD82M0aHcq54vQ6qmdZWvqL7LL4nE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtkedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmrghthhgvuhhsrdhtrghvsgesghhmrghilhdrtghomhdprhgtphhtthho
    pehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrsh
    gthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepshhiqhhuvghirhgrjhhorhgurghosehrihhsvghuph
    drnhgvth
X-ME-Proxy: <xmx:Pw2_ZvUAycCXssWdl8kNYXI3JlwFtzC5rt3Cu4bdHoGUONGqCTvMhw>
    <xmx:Pw2_ZqlKkUBkvbCeG6VOTV2L_12duzrRGom61qZzuG45H63m01ehaQ>
    <xmx:Pw2_Zkc8o-l7wYUdv_2M2_J74QCLJ6oX-X1nqOuQ5R3p7QlKBFVTJA>
    <xmx:Pw2_ZsEFurguB1aYDba6tHnZsVQuV1u305RBRpCvDnyWRHTHVGymrg>
    <xmx:Pw2_ZoaGhJghWBpUk4FD0L51rTuEtKsZc10k7H4KNtd5ukA-bkYzyrWN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 04:26:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d6fe1a8d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 08:26:13 +0000 (UTC)
Date: Fri, 16 Aug 2024 10:26:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Matheus Tavares <matheus.tavb@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	newren@gmail.com, Rodrigo Siqueira <siqueirajordao@riseup.net>
Subject: Re: [PATCH] rebase -x: don't print "Executing:" msgs with --quiet
Message-ID: <Zr8NOh-gMuhp-p0M@tanuki>
References: <767ea219e3365303535c8b5f0d8eadb28b5e872e.1723778779.git.matheus.tavb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <767ea219e3365303535c8b5f0d8eadb28b5e872e.1723778779.git.matheus.tavb@gmail.com>

On Fri, Aug 16, 2024 at 12:26:19AM -0300, Matheus Tavares wrote:
> `rebase --exec` doesn't obey --quiet and end up printing a few messages

s/end/ends/

> about the cmd being executed:

s/cmd/command/

>   git rebase HEAD~3 --quiet --exec "printf foo >/dev/null"
>   Executing: printf foo >/dev/null
>   Executing: printf foo >/dev/null
>   Executing: printf foo >/dev/null
> 
> Let's fix that.
> 
> Suggested-by: Rodrigo Siqueira <siqueirajordao@riseup.net>
> Signed-off-by: Matheus Tavares <matheus.tavb@gmail.com>
> ---
>  sequencer.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 0291920f0b..d5824b41c1 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3793,12 +3793,14 @@ static int error_failed_squash(struct repository *r,
>  	return error_with_patch(r, commit, subject, subject_len, opts, 1, 0);
>  }
>  
> -static int do_exec(struct repository *r, const char *command_line)
> +static int do_exec(struct repository *r, const char *command_line, int quiet)
>  {
>  	struct child_process cmd = CHILD_PROCESS_INIT;
>  	int dirty, status;
>  
> -	fprintf(stderr, _("Executing: %s\n"), command_line);
> +	if (!quiet) {
> +		fprintf(stderr, _("Executing: %s\n"), command_line);
> +	}

We don't typically use braces around single-line statements, so they
should be removed here.

>  	cmd.use_shell = 1;
>  	strvec_push(&cmd.args, command_line);
>  	strvec_push(&cmd.env, "GIT_CHERRY_PICK_HELP");
> @@ -5013,7 +5015,7 @@ static int pick_commits(struct repository *r,
>  			if (!opts->verbose)
>  				term_clear_line();
>  			*end_of_arg = '\0';
> -			res = do_exec(r, arg);
> +			res = do_exec(r, arg, opts->quiet);
>  			*end_of_arg = saved;
>  
>  			if (res) {

Do we also want to add a test for this fix?

Other than those nits the fix looks obviously correct to me, thanks!

Patrick
