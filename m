Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC1443DA35
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 23:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037098; cv=none; b=BwxUwm8FNqkwPfAG8cXodD7+QHHNsBU3vLn6qHPB0nIFr+jbiQP0qGmgOFJbfizy/rTblhD43yquJKwEGO8T0JSpm5g/wEoKicG+2NlTG4IQj652Tq6mHEdY/V47blBTkuFd612zg3y583InKXRNFkVX95wp1oUbz2n0EXOLmhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037098; c=relaxed/simple;
	bh=2QjgX/DfuV3ApN7hcKQXBCZui/6wwOcc5HfeNsnLC6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ckEltQluNsNIS6jD0EE0XZqcAJmAn8OMGdMbVcbOT4lQrnMT9rTOAKm7PBximSEOulBXjvcbcYxk/BcoLgKnU+ti7t43sNzI7ugQa2y8HAqZHf9MCX+Ms3Ude9rPQigvz4QJACT1RCqVp5TIdefF76o/UdchiSjP254C2FK7Uv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I0U6u0S1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JXVm7XYG; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I0U6u0S1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JXVm7XYG"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A580A1D00165;
	Wed, 21 Jan 2026 18:11:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 21 Jan 2026 18:11:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769037080; x=1769123480; bh=0h5KDy5P0j
	oUGBzwnrRSqWuDHsnnh/PjVwTdtAWqKwM=; b=I0U6u0S1iW7AIEJmHkAfjeg5cP
	yVzihsqzhoCcM01Zu5PP3fIxs4zBBbHo35LEQpUnRKyfDS8MzOZyR6Tggvm2xCpV
	TKfb72XikjSQiCuyuK2k0JvPKQZYDsFgLPGXsDBsJldSyzhZuXXfnRs9rJuPV7A4
	aBqrexxXa+G8zRF5Uxq8Pp2TNY+KB6gbQvao0vZYiHJgQJkid/Q+v6bKOV9lCF/t
	eNdl6vL3t+FVPgu38PifrClyMRONn0AhgqsHTjgcmDXMnmqESTV4TJWQtrd5KNk5
	xunFNmfZs5IrkWBY0SpD6xHu0R3AYR3KOu6uFK/6ESNOk/TlU0RF+Cfpq2ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769037080; x=1769123480; bh=0h5KDy5P0joUGBzwnrRSqWuDHsnnh/PjVwT
	dtAWqKwM=; b=JXVm7XYGKV7XS007sVw4SLwIsKQ3H/gg0PTjNf0mvkNEDuqk/GQ
	DB2EHi2Vt4FG2pscrzBtClz7l/Pz5uS7rjdgIBE7bbGvdtmxxZkL1s4FWduCZNLh
	pSh1tYXDqMzpC63H5LZPVwPYd3kCskcmJ1dMJ7E2p0JWSBoRC2micbK8F4Xv8yxw
	qCixCI0uA2ASNw7wxFKuRNJWO2r0uK9MjqIdzpG9bNtZAsFlxtGQBNpdDGn/Sglh
	lfJ5C6ZfelZxhZzDir9ZsBnzgOPu+T3r/4KlxSsbIj4LrPXBO6Rcd1FrDu4QaCSw
	91FbQ3EccGQ+iC8k2Ly1Xg3aYwrFvItmh6g==
X-ME-Sender: <xms:GF1xaYYJWoU30ni6WxZXMaJhcN86nVrbmOdCoM4SpNHQ3yKt__mqdQ>
    <xme:GF1xaSdt1TXAIxHICUF6Q0dLLz4dJOshEigph5I_cvpqi47iTwiVs34H895BnmTsl
    LRkW1YWDg_PAyzfWFPiszh7B3RNocwBJGglg7EKbfJ7HatHvOIr_KQ>
X-ME-Received: <xmr:GF1xaZJBcbHnkcJtaCMKWV_jpj3mPGV7fXXJ8JGntCthmCWxhf_PWzSeJomdTDmnchuORWvePNABJZDZLe2dJ-G-rnvZBlu1-6s33XQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeegheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepvghmihhlhihshhgrfh
    hfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GF1xafI0o9FKJP4ksCoBXejICiTbFG2wi3AcGq_dYOmB_MNe8BVICg>
    <xmx:GF1xaYWFZbeRfAeDfCvnjD0ijdY0GJ2QYa3lXYjJH5UtMJbRz_g4Lw>
    <xmx:GF1xaYlVg5kBbwvwqYo8wFLfrEsY11loA60c_ekvhgCJIefiQSDXew>
    <xmx:GF1xaenR04YHOy6YzwOfieebIf-Kvacrvc4hPl5q36KL5HK0xBgf1Q>
    <xmx:GF1xaQf7tXFNnCsut0xZ4Z4nTLenh48b19pDgtJuQG3CG2im0_Ytxe5T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 18:11:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Emily Shaffer
 <emilyshaffer@google.com>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v7 10/12] run-command: poll child stdin in addition to
 stdout
In-Reply-To: <20260121215436.1473800-11-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Wed, 21 Jan 2026 23:54:34 +0200")
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
	<20260121215436.1473800-1-adrian.ratiu@collabora.com>
	<20260121215436.1473800-11-adrian.ratiu@collabora.com>
Date: Wed, 21 Jan 2026 15:11:16 -0800
Message-ID: <xmqqzf66pnmz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> Child input feeding might hit the 100ms output poll timeout as a
> side-effect of the ungroup=0 design when feeding multiple children
> in parallel and buffering their outputs.
>
> This throttles the write throughtput as reported by Kristoffer.
>
> Peff also noted that the parent might block if the write pipe is full
> and cause a deadlock if both parent + child wait for one another.
>
> Thus we refactor the run-command I/O loop so it polls on both child
> input and output fds to eliminate the risk of artificial 100ms
> latencies and unnecessarily blocking the main process.
>
> This ensures that parallel hooks are fed data ASAP while maintaining
> responsiveness for (sideband) output.
>
> It's worth noting that in our current design, sequential execution
> is not affected by this because it still uses the ungroup=1 behavior.
>
> Reported-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  run-command.c | 61 ++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 43 insertions(+), 18 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index aaf0e4ecee..dfd2aeda07 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1562,7 +1562,7 @@ static void pp_init(struct parallel_processes *pp,
>  
>  	CALLOC_ARRAY(pp->children, n);
>  	if (!opts->ungroup)
> -		CALLOC_ARRAY(pp->pfd, n);
> +		CALLOC_ARRAY(pp->pfd, n * 2);
>  
>  	for (size_t i = 0; i < n; i++) {
>  		strbuf_init(&pp->children[i].err, 0);
> @@ -1707,21 +1707,52 @@ static void pp_buffer_stdin(struct parallel_processes *pp,
>  	}
>  }
>  
> -static void pp_buffer_stderr(struct parallel_processes *pp,
> -			     const struct run_process_parallel_opts *opts,
> -			     int output_timeout)
> +static void pp_buffer_io(struct parallel_processes *pp,
> +			 const struct run_process_parallel_opts *opts,
> +			 int timeout)
>  {
> -	while (poll(pp->pfd, opts->processes, output_timeout) < 0) {
> +	/* for each potential child slot, prepare two pollfd entries */
> +	for (size_t i = 0; i < opts->processes; i++) {
> +		if (child_is_working(&pp->children[i]) &&
> +		    pp->children[i].process.err > 0) {

I find it a bit odd to insist that .err must be positive integer for
us to decide including it in the polled fd set.  Are we safe to
assume that .err file descriptor in use can never be 0 because we do
not close stdin in the main process anyway?

> +			pp->pfd[2*i].fd = pp->children[i].process.err;
> +			pp->pfd[2*i].events = POLLIN | POLLHUP;
> +		} else {
> +			pp->pfd[2*i].fd = -1;
> +		}
> +
> +		if (child_is_receiving_input(&pp->children[i])) {
> +			pp->pfd[2*i+1].fd = pp->children[i].process.in;
> +			pp->pfd[2*i+1].events = POLLOUT;
> +		} else {
> +			pp->pfd[2*i+1].fd = -1;
> +		}
> +	}
