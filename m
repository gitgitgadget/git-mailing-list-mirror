Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709B113AF2
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759386879; cv=none; b=kVdEwOIpqhYApWwjoTSw0ofDK5PSevl5PkpXOdJ9WTLKi/xj/thQkjxqkY+0/Ole05DoccMPLl4GbwZxV7Da6QlLviHkc+o2X3hkOeo+JYaXrnrt6z8Rep7wo2UXZ1OslDQetGvaTBAOZVT2eBiO5oH4okFno5uqzwb2eL4ggDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759386879; c=relaxed/simple;
	bh=l0051cHLFDRLC11l8QT8v84V83S8r+c+PAgCeBL20iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GW+q4oWncHJhWYwqg5YuaJQkICzBZ+UKrTvc64gfqVXHjS6b4SElbBqPf8EtiD7ae86RqUsHMv6Y1iTXOhzJUgl73oqBaQel4Nt83zw7qRZwYFl1FmNcmg4UQdQlcIzpFHU33ruMXAyULuLnfLNfrsOM3eaNU9Ow86Cbz92ra+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OmM7ByzH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iTw/E4DR; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OmM7ByzH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iTw/E4DR"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2846E7A019A;
	Thu,  2 Oct 2025 02:34:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 02 Oct 2025 02:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759386876; x=1759473276; bh=qTvqvjpzIE
	T+GS7U7CJPNUZnWXjnc6ZN3yKWoEb5he0=; b=OmM7ByzHJK/LJPdVF7SKC6ehAc
	plLhsEw1NQON2CAJSQfWxEg2wAdJU5q81NV1er0jLL9zac5nrWUx6s5A3EMifamM
	9R1GbOyWkEmacXUgnrIAwfTtw9q8IxswpHqeIjci6cLh4fbOLZ7uYGfp6/sUuywz
	GtOz8h6FM1C9UaXMoiRJhclzCYBjHcvTGv24YEnXdzLzGuSwdGuTGezm0q7TNFQd
	Q69IPG8RsoUTlvBvW1JoMvsPmaRz0aI3QhRrUsVhtofMZIxaq4P4ALi2lpXPPfea
	A7d7Q45elQLQ231PStp57X3vLha0iuFP9MTIXloIqDrvTf5stQNNbByrArXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759386876; x=1759473276; bh=qTvqvjpzIET+GS7U7CJPNUZnWXjnc6ZN3yK
	WoEb5he0=; b=iTw/E4DRd2aA0VUyGyPaL611NTB6Ek4/cohTsg02bR75v8r/inl
	c5P8ZFobUhM3dMnjDnbFmVjywbRRa9disOT3KFagenty3hfsn7ISW1y/DWlbZnXB
	Tan7hiUSSISEy4U6XawIpO2z862GL3mcCDBFFbj3Cg+Q/aXRZWWkw5V6STG3ihEI
	aBau2OZB0luZehniEaoPIXsaVTKb0dYQfEe57P5fKN2g+UN4w7f0H6hfVYxiYE6q
	523LoSoUzZKUUXW6SJxz6X1gmtVGJCuIUtemjB5NCU//lkVPHMSKQ2TtoihQdydx
	65vs9rN9mWTf2GdsMKmaSCQxiLyHGeg44Rw==
X-ME-Sender: <xms:-xzeaEVGO3De-1-REOPe0VZ7W2lDqKP8SAYQZN834oGPG9w9wmuZFQ>
    <xme:-xzeaK3tyKaEAU4ZqO2mM6FUTVOrQ376KqacBAuW5W90qtgQBdXGOHPf3Nh98um6u
    ZWwRQbW65MO5My4vb9PXKQdL0PGL0ot0NscNF_DD8X_zz4bc2DnOA>
X-ME-Received: <xmr:-xzeaKp81pWTv5N59f3Sd8GHixf44Ma7am5RTaMhq52l-0jGeyayrDWitJ83ILm1UZ5lASJWLmD9rTdtU0Spl6BVxVTcf-mIVdKcXNlMjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvghmihhlhihshh
    grfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrughrihgrnhdrrhgrthhi
    uhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehruggrmhgrii
    hiohesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:-xzeaJU-u2d2D1jyPXaGYzpm-BbNwIzvFqTSiV4Nyng6Cp2VIAR6fw>
    <xmx:-xzeaNZXBJQw6SeC2QeoutFMmztMuw4FZmGLFqIPQzi4Lv2X5Y9m7w>
    <xmx:-xzeaOcJWcwW2fZ3PtKFh1u0zAyMu56zsELI5sE7QQNR0_oViaKBFg>
    <xmx:-xzeaP0cnefJu1ucQCTtnDob36Xywk35x6OHKH4sf5EHNGYHeFfRzQ>
    <xmx:-xzeaLN1GJ5_gSLKSt6d07EVc4ILty1S6sKzbHs7UW_FPshAck1pm5iG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 02:34:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5c7132d2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 06:34:33 +0000 (UTC)
Date: Thu, 2 Oct 2025 08:34:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 03/10] hook: convert 'post-rewrite' hook in sequencer.c
 to hook.h
Message-ID: <aN4c9sqHTgn2wot7@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20250925125352.1728840-4-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925125352.1728840-4-adrian.ratiu@collabora.com>

On Thu, Sep 25, 2025 at 03:53:46PM +0300, Adrian Ratiu wrote:
> diff --git a/sequencer.c b/sequencer.c
> index 9ae40a91b2..93cd6ab1f2 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1298,32 +1298,46 @@ int update_head_with_reflog(const struct commit *old_head,
>  	return ret;
>  }
>  
> +static int pipe_from_strbuf(int hook_stdin_fd, void *pp_cb, void *pp_task_cb UNUSED)
> +{
> +	struct hook_cb_data *hook_cb = pp_cb;
> +	struct strbuf *to_pipe = hook_cb->options->feed_pipe_ctx;
> +	int ret;
> +
> +	if (!to_pipe || !to_pipe->len)
> +		return 1; /* nothing to feed */
> +
> +	ret = write_in_full(hook_stdin_fd, to_pipe->buf, to_pipe->len);

One thing I wondered in previous patches was whether we now have the
potential for deadlocks. If we feed data to a child that exceeds the
buffered I/O size, and that child writes data that is consumed by Git
larger than the buffered I/O size, as well. Wouldn't that mean that we
may now not make any progress at all?

I guess that's no different compared to before though, as we also used
`write_in_full()` there.

> +	if (ret < 0) {
> +		if (errno == EPIPE) {
> +			return 1; /* child closed pipe, nothing more to feed */
> +		}

Style: let's drop the curly braces around single-line statements.

> +		return ret;
> +	}
> +
> +	/* Reset the input buffer to avoid sending it again */
> +	strbuf_reset(to_pipe);

Is this really necessary? I would've expected that we return a positive
value from this callback, and as a consequence the run-command subsystem
should notice that we're done with writing stdin and close the file
descriptor for us. Afterwards, it shouldn't invoke this callback ever
again, shouldn't it?

> @@ -5140,16 +5154,16 @@ static int pick_commits(struct repository *r,
>  		flush_rewritten_pending();
>  		if (!stat(rebase_path_rewritten_list(), &st) &&
>  				st.st_size > 0) {
> -			struct child_process child = CHILD_PROCESS_INIT;
> +			struct child_process notes_cp = CHILD_PROCESS_INIT;
>  			struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
>  
> -			child.in = open(rebase_path_rewritten_list(), O_RDONLY);
> -			child.git_cmd = 1;
> -			strvec_push(&child.args, "notes");
> -			strvec_push(&child.args, "copy");
> -			strvec_push(&child.args, "--for-rewrite=rebase");
> +			notes_cp.in = open(rebase_path_rewritten_list(), O_RDONLY);
> +			notes_cp.git_cmd = 1;
> +			strvec_push(&notes_cp.args, "notes");
> +			strvec_push(&notes_cp.args, "copy");
> +			strvec_push(&notes_cp.args, "--for-rewrite=rebase");
>  			/* we don't care if this copying failed */
> -			run_command(&child);
> +			run_command(&notes_cp);
>  
>  			hook_opt.path_to_stdin = rebase_path_rewritten_list();
>  			strvec_push(&hook_opt.args, "rebase");

This change looks completely unrelated to me?

Patrick
