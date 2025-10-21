Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF80B24729A
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032487; cv=none; b=uwqD+DtY/O7elG7a9fhR9Oz1/UCzBYrLYSwJFbylY0almZs0l8/s5RIbSwzGaPf9z2EM/xJPkUv6LAxjdY0NbAa3kX4S13Xqm8k1CPLjAlSm3RrDwsqspmu4YahBWc0pUe7HVyiWpxrLIY/kSYkjrabWJBTSSW2wpJwgzEL3CIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032487; c=relaxed/simple;
	bh=61CQV0JEreaPo2MjaEIQKTG3cotXq2ayZcZsYcbnSUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nv4Os4WdMAIbKLLqMoOZgi0HvgLfPILjrzmqc8eRjc//6oe63R2EXdWsNxdu/hf4YRioX8qFLwYRgyLbmpiPpowR4y52RdqdjyNp2E5/YePl+kI3NC7QmD/vGM8EajZ8z4V387lOPiUiI0GUuf9MNHp4dGIbfpl0IurEHWkS6Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pcW/13DJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lTKkHjeH; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pcW/13DJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lTKkHjeH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 214E0EC00E1;
	Tue, 21 Oct 2025 03:41:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 21 Oct 2025 03:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761032485; x=1761118885; bh=RO2jas3+Tp
	yViUdaq0ZI4jPd7/WpnZuZ8EFmwSr4u90=; b=pcW/13DJ7oSXh27x8Ew2b1bHWU
	jRCe3pHn1Ief0gzQ+JuVFHtRctCcME1YBtyLOXauy+2by25UdgtrL1qjPWfP131S
	k//M/3QsgoxDBoNDMf+H3npOh8pX1iPnWm9QbcaGFeSq76ZShbJfDCkJB8lAMei3
	fsk6d7BbhuTz5Mq8F8d5SbjmNg5+wUhVsy7ELaknk56PQn0mVgh1eFGR4+yA7hZM
	oirsG0AZnQKVQ2NNQwGQcszhX6I9a9+xAjKKA0N+vILSdM6Ztcc/PbMyrZ1DSNmV
	0RioRATGtctnEQkkJ3lV9VTEFtD+xr06ajnpeQAYwEsh9y5dDWlrC0rpXqCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761032485; x=1761118885; bh=RO2jas3+TpyViUdaq0ZI4jPd7/WpnZuZ8EF
	mwSr4u90=; b=lTKkHjeHwcR+2NvcaUr+eQwskkSQkdUy0yWdWOzkuUN226Grd6k
	NgLf5YAvy3t5bCoT2XlMxuEx7dHcurbX26kOqIRmJ7z9sM9AHe0TBGVxsxtjB8Xm
	Yz4rNLS4zqK8Mb2DXCpyDAeky4IGdzy66j/l43iNPXqFlAtuiLHfMlUBGBLnE3w5
	a0kjKzrziSK3GCH+59jVPfpQZKCFIFHlYp1WijrtXMU5aT67QaBOq2RUgBcviwk/
	0YuiMrDCMc97OYsNy+5r/aj49qefOGvxSbYPP1VWtT+sNuzVM8avK27yuXRu/7cq
	aDX0qCB/EjdMbM07hAN6q7oCJUL/vIL86aA==
X-ME-Sender: <xms:JDn3aHpBc4YcrHCoAMojEjKYbokdCNwMBwJYMYa9jnLtdWv8rG8M9g>
    <xme:JDn3aENdEidb2RhVsGOdS7N51mmdNxZp8vexV1x8yhmG1VltIywf4Kmgf9vo-TGWO
    iKECMR5O91L5nHchJ83OOmxfJUVnPMOr7mM9-zlyyoR2RwAkSvF>
X-ME-Received: <xmr:JDn3aH28fb2ddYmT794WUKT8_XhBxGcTmpySUkv7S7Xv5GW6dMCIKE83fCHOHCe1nWiAcJj1-Zy3YfgjLi_7WTKA9Ko_g9gWftD2EF-U04r9DQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvmhhilhihsh
    hhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhgurghmrgiiihhosehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprh
    gtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghp
    thhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsthgvrggumhho
    nhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:JDn3aLBEqtxJve8Jilf5gn3Z2lo01AdYi6hvduflnIjK8fpVo15ZTQ>
    <xmx:JDn3aMKO9WHVhCkR7x9e02nhykVM1AtXV3cJ276TLvUdE5PH91Sg8w>
    <xmx:JDn3aMnKSTw2YX7hVugfGMzH-SVoYY9s8InnmVTQ60LTrZCopP7DFQ>
    <xmx:JDn3aNbp7v-4S960x2ncK2MkfUyb6brRFTV4MUWbzP6roF7EaMSbqQ>
    <xmx:JTn3aFNzbqCJAaj1SukQrDquZJB27SV3EE6ErMwbthKn3zG1_I1ktA8H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 03:41:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5510effd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 07:41:23 +0000 (UTC)
Date: Tue, 21 Oct 2025 09:41:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 04/10] transport: convert pre-push to hook API
Message-ID: <aPc5IE1Ie3i_Axqs@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-5-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017141544.1538542-5-adrian.ratiu@collabora.com>

On Fri, Oct 17, 2025 at 05:15:38PM +0300, Adrian Ratiu wrote:
> diff --git a/transport.c b/transport.c
> index c7f06a7382..67368754bf 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1316,65 +1316,56 @@ static void die_with_unpushed_submodules(struct string_list *needs_pushing)
>  	die(_("Aborting."));
>  }
>  
> -static int run_pre_push_hook(struct transport *transport,
> -			     struct ref *remote_refs)
> +static int pre_push_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_task_cb UNUSED)
>  {
> -	int ret = 0, x;
> -	struct ref *r;
> -	struct child_process proc = CHILD_PROCESS_INIT;
> -	struct strbuf buf;
> -	const char *hook_path = find_hook(the_repository, "pre-push");
> +	struct hook_cb_data *hook_cb = pp_cb;
> +	struct ref *r = hook_cb->options->feed_pipe_ctx;
> +	struct strbuf *buf = hook_cb->options->feed_pipe_cb_data;

Same question here, isn't `feed_pipe_cb_data` accessible via
`pp_task_cb`? May very well be that I misunderstand the two callback
context and data, I found that part to be a bit hard to follow.

> +	int ret = 0;
>  
> -	if (!hook_path)
> -		return 0;
> +	if (!r)
> +		return 1; /* no more refs */
>  
> -	strvec_push(&proc.args, hook_path);
> -	strvec_push(&proc.args, transport->remote->name);
> -	strvec_push(&proc.args, transport->url);
> +	if (!buf)
> +		BUG("pipe_task_cb must contain a valid strbuf");
>  
> -	proc.in = -1;
> -	proc.trace2_hook_name = "pre-push";
> +	hook_cb->options->feed_pipe_ctx = r->next;

I think that the lines between the "task data" and "task context" are
being blurred here. I understood it so that the task data is what is
specific to the callback, and that data may be changed to keep track of
the state. Subsequent commits do it that way, so shouldn't we also treat
the context as immutable here and instead handle iteration via the data?

> +	strbuf_reset(buf);

Nit: it would make sense to move this reset down a bit close to the
first call that writes to it.

> -	if (start_command(&proc)) {
> -		finish_command(&proc);
> -		return -1;
> -	}
> -
> -	sigchain_push(SIGPIPE, SIG_IGN);
> +	if (!r->peer_ref) return 0;
> +	if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) return 0;
> +	if (r->status == REF_STATUS_REJECT_STALE) return 0;
> +	if (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) return 0;
> +	if (r->status == REF_STATUS_UPTODATE) return 0;

Nit, feel free to ignore: this might read a tiny bit nicer with a switch
statement.

Patrick
