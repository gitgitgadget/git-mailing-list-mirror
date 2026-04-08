Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7311D4317D
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671181; cv=none; b=HudDjh1zvXg8SPZX6vV/5KQFJqOjC/NotWaMBSN+jTOrHM70oJEhr0BeMIZRGoLCxRwAn7D1MyV1VpL6vTeynxETIenaBx53u9VFZZeix9WiNzOZfa7Ie78RVITm83w9a96z4GADF/dByMXIc8nx6xPRd38e+0l3Tx1IvZiAvPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671181; c=relaxed/simple;
	bh=rTg70TLoq+UnsGLOkAzDyZw/oE9RMFDvIZMM7HahDSo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tOWOhLUZ4TvEANWdKoTJumMXsINu2VjF7AJzO/4VGUsbZ4wQonfqe8bXFsS5Pt9VSfuFWMR7czJM4lWqcD229oeA39OS7xc4sr3Zuz/jpZSr1xh1vXwFExUSmzBgvQf1DuUPIU6NNQdeEquNd5DKjhTf2/2IA+gMpJI5zKMrypM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U1arVtDG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cQ6kf8SR; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U1arVtDG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cQ6kf8SR"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A902BEC0452;
	Wed,  8 Apr 2026 13:59:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 08 Apr 2026 13:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775671179; x=1775757579; bh=lIY2EjbQww
	0630FXGO/gOT2ZN+Stq1Y9Cmc8Ak0Kjik=; b=U1arVtDGdBCNCzEHSMbesjuzed
	LLV1/ZupVnHVDzjYdKjcH/AnAQPY/QT7pzmdAehpkrjR4mVq97Gb70r1cLaVlTau
	yL65z0TLZhimvmBpb4NVwGjACdZs6q3vN6dfBYDHCvw+X6AGdE7F1b6EeUkNbVMr
	e4SwBGpKyn1SkpYKxpHy7ZHPnDirVGhTGNKIw81kKLf9gNFtL7w33mKkC8LfPfWz
	7Ta/TbPz7VENBU9huBiySRINE+A4RLQNP4dUfWHNc/OEBjHCExicY0mpiKaSGnYR
	J8/fPHKXepr5SB19EtqqremDxwc3f06h0pC+R46S8vEDTFdOaqjohJAvQOPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775671179; x=1775757579; bh=lIY2EjbQww0630FXGO/gOT2ZN+Stq1Y9Cmc
	8Ak0Kjik=; b=cQ6kf8SRvkK2sTLT2Va5EW8mpi2eoi22Cq5Ri022dDjJlDxgOyP
	ZA94WoN3+zJS76aXS/W4/MZ1WmFe6OsuKX7jRJsQPJUT9PpKyCstGisnB4rSf0yX
	WgSyXP/MSfH/CeaRzGtOXvsI4OCImCROSGvRcwWuL90Lei8WkChFrlEokYKSxLRY
	+PEvJ5eLO8Hv9cJkzPEW/74jFPsK/b5cUXq25qE4r0l06KG94VQI9BkYdGjSyagp
	X/6zA+Erc+p/CKyXLVdpa8A26wX/IV+rAHGFHOV1ZvWU4cBx40N2tetXZn0JOY8l
	I+7ycENwNaalH6cpxgcBIqTr1p9gI9ClE8A==
X-ME-Sender: <xms:i5fWadCxRJmh62U0TNhU2g2_R7lVJq2q51RhKMQmOb67AoIpM3aiuw>
    <xme:i5fWaSZ87WA9iY1dtzTjvrD5SuL5ZoyhyZe0Rq8OmxHScyTEOpBdJOdkgjrp1qJ0-
    DX4kSekoA6GhA51DS830CRhqUgYI5I799n2vlLR1CbYmZSOo2uF0a8>
X-ME-Received: <xmr:i5fWaQ6TwqyTwr3IW4ouut-GwvOwm4n0xdhHWHWkHtlu-gTURvDw2Lndu1Qt95Ti-4VvDTWsRdCVb_jRZEWLOm16FRiZKLoKgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprg
    gurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtoheprhhs
    sggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:i5fWaTZbgJnDCZ0kaUuFpWrg-JLg0jIzxmb6PA7-FOTA3ayAIYS6Mg>
    <xmx:i5fWafgWd8zKZxMX5vpk32bnt2rNgeQt8w5iDdh7Gr8lmjjby49qlg>
    <xmx:i5fWaU_x803GxgrVIaMtcrvOGJxUtV5dGIggxzolTmUMIs8mfOP09g>
    <xmx:i5fWaaoAuKhmp4o1iqkwTEuAJR09cYMs2sWErzW2XT2r-czXi6RXvg>
    <xmx:i5fWaTUR488sjlYaBjOBRBdQOicU79IqU6mML-xNjDFmnMTKh_N3Rszk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 13:59:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,  rsbecker@nexbridge.com,
  git@vger.kernel.org
Subject: Re: [PATCH] run_processes_parallel(): fix order of sigpipe handling
In-Reply-To: <20260408172055.GA2293804@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 8 Apr 2026 13:20:55 -0400")
References: <00f501dcc6e7$8ef295c0$acd7c140$@nexbridge.com>
	<20260408052031.GB1324339@coredump.intra.peff.net>
	<xmqqpl491mfd.fsf@gitster.g> <87y0ix1kq4.fsf@collabora.com>
	<20260408172055.GA2293804@coredump.intra.peff.net>
Date: Wed, 08 Apr 2026 10:59:37 -0700
Message-ID: <xmqqcy09z62e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> We can fix it by reordering the code a bit. We should run pp_init()
> first, and then push our SIG_IGN onto the stack afterwards, so that it
> is truly ignored while feeding the sub-processes.
>
> Note that we also reorder the popping at the end of the function, too.
> This is not technically necessary, as we are doing two pops either way,
> but now the pops will correctly match their pushes.

Sounds quite sensible.

> This also fixes a related case that we can't test yet. If we did have
> more than one process to run, then one child causing SIGPIPE would cause
> us to kill() all of the children (which might still actually be
> running). But the hook API is the only user of the new feed_pipe
> feature, and it does not yet support parallel hook execution. So for now
> we'll always execute the processes sequentially. Once parallel hook
> execution exists, we'll be able to add a test which covers this.

Great.

> Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
> Signed-off-by: Jeff King <peff@peff.net>

Thanks, all of you, for addressing the issue so quickly.

Applied.

> ---
>  run-command.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index 32c290ee6a..574d5c40f0 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1895,14 +1895,19 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
>  					   "max:%"PRIuMAX,
>  					   (uintmax_t)opts->processes);
>  
> +	pp_init(&pp, opts, &pp_sig);
> +
>  	/*
>  	 * Child tasks might receive input via stdin, terminating early (or not), so
>  	 * ignore the default SIGPIPE which gets handled by each feed_pipe_fn which
>  	 * actually writes the data to children stdin fds.
> +	 *
> +	 * This _must_ come after pp_init(), because it installs its own
> +	 * SIGPIPE handler (to cleanup children), and we want to supersede
> +	 * that.
>  	 */
>  	sigchain_push(SIGPIPE, SIG_IGN);
>  
> -	pp_init(&pp, opts, &pp_sig);
>  	while (1) {
>  		for (i = 0;
>  		    i < spawn_cap && !pp.shutdown &&
> @@ -1928,10 +1933,10 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
>  		}
>  	}
>  
> -	pp_cleanup(&pp, opts);
> -
>  	sigchain_pop(SIGPIPE);
>  
> +	pp_cleanup(&pp, opts);
> +
>  	if (do_trace2)
>  		trace2_region_leave(tr2_category, tr2_label, NULL);
>  }
