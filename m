Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182F613AF2
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 06:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759386874; cv=none; b=QpOzbTrUaV1R2ahC6rlmCEsFwtlupnQufVGqUfkdG1oc81Zijs2OqT0byRDVc4XNn6Hbem9NbNKbmCMn1eb9BgjtMr0o7tO/O+u5eY4DhrScytvMW82XxqFWBbaBuQ7EY0+DnzUgyL7xLDxAlaz9zXKcoRx/mHSvhV4YJphdO1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759386874; c=relaxed/simple;
	bh=NfJN90J6KnLgbDR4oPRDdocqoVIEfTFijFmKWy/VTxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5QZ/EcgBxgqzC2BdhkA2eqxXSI8fnzHGjjiA+cCykzGpIVNkyn46A0gWZWullxhXJuB9PfUWSpoXbIZ6G8yDvFL6C94X31khm2qAtBtE3PKJwkZn9wxpG4VSnHOYvrZAzgLyMTvmULCeA9VRKpEv1K/GDM/hfxifzqPXyx95WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OaemPj9g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GV6zNY+3; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OaemPj9g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GV6zNY+3"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 241A61D001C8;
	Thu,  2 Oct 2025 02:34:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 02 Oct 2025 02:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759386870; x=1759473270; bh=DIok8QS0aa
	v4TsMnr0k0M6mz5t0kqMT5PC+a0xN68YI=; b=OaemPj9gryNazsgcrsfrn73UDE
	jfVa9s8r2EdmWiVM63cy30IwLw/5bSQAZBxHJPNDEeEnmXB+GPcQpcy1o7tC0BTv
	PvFb0NdoR5ZUSUc0gwbGZi1h9SrNO2lN9H2ph+piGwZ/9Le3kl8o9WWTr5bzEuzb
	HcD5WctEHwsRUfKSYpbCOeOsaTwkLBr9Jqf2ZkonZJMVivgCibd9pLxSsfF4f5IH
	q/PKQF3x2Au0NzHNjyDpLQ/aR63EhEOSQj+aRA1e/DUUk9VmQoi7pUZBvElp/HOZ
	MXoaSkL+PjKwKLziIjKEwB/pUi6VSQ10tx2OnYfIkCqheg6W72qL3EBbL7Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759386870; x=1759473270; bh=DIok8QS0aav4TsMnr0k0M6mz5t0kqMT5PC+
	a0xN68YI=; b=GV6zNY+31ZMezGgQNxUHrsimMpHvd19clMNH7DvoX86F8ImXbJH
	ftc7ssjs2Rhpwo5Lkry3FC6uotGrAVNUWFbZQd9X2TNzFE9yVKGbg4H4RzPmIzrW
	M0xXUiJ9m/+S97Nu7XBs9PN8U+fkorLBj52tQ/2lwsAlZjEsETZm7w5Tv53kinxW
	8TppeFk1XLYGn2yvGZR1oOM0jZC2pSlddpJrih1uh++A5nAgpZk93Frsu0cbUbEG
	pAKohC5qHYhqCjkySBDWmtoMDiyK/ylDtqpdwZ9OH/kyHGRTTzyQXcTYs6Twt+HI
	wsgm91B6oCbN4VWdm3yiWJRTTwy3PYmnGUA==
X-ME-Sender: <xms:9hzeaClYSKKq5lDAqm1l71grhRVtSu_ryW4T7pe3K9bek6Ney6twKw>
    <xme:9hzeaMFjnOq9KGsqV_qJs5_akA5wjK7xCxfHJdsUw-txU35wB-sdhtUyD2Oa4wOd0
    H_1f0QwxBp_tpBKoNyYygyQqzHvEbQVQ_-bT3XH4yiLgNw6NZ84wz4>
X-ME-Received: <xmr:9hzeaC67ZaV4HfzMUmK_dJkm_NubMh-_iYGxnHzGD6fhL_dNjyFCWVuFxZid7H2EN0HjBL13uhA_vBVd5xZn-Ui7E_lwVPHH4SFvE0_TZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgho
    lhhlrggsohhrrgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehruggrmhgriihiohesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghvrg
    hrrggssehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:9hzeaMl0k9Pm5mxe37Rcu7XlMV1Z2T2TnV0oVXuBDIaGjc285NBXuA>
    <xmx:9hzeaPojts8xHA7Kkf6ELRZOj3woLuzPUlQo271R5IrW-6ZbzVPAZQ>
    <xmx:9hzeaDtNpV0exPtfewUa2yPoOlOEonrDfvS1S236t8Kew1zaRi16gA>
    <xmx:9hzeaME_AzM_PX9uYdi_P9a9omARhWI3ekTqdjWmPmSvk-jTXv2pOw>
    <xmx:9hzeaLW4QoHfCULVvdM0rKGY-hzdAJ8Y3IVyc9UX94m8_5irriMWJQqS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 02:34:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d379fac2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 06:34:27 +0000 (UTC)
Date: Thu, 2 Oct 2025 08:34:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 01/10] run-command: add stdin callback for parallelization
Message-ID: <aN4c6l7gRi4auss1@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20250925125352.1728840-2-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925125352.1728840-2-adrian.ratiu@collabora.com>

On Thu, Sep 25, 2025 at 03:53:44PM +0300, Adrian Ratiu wrote:
> diff --git a/run-command.c b/run-command.c
> index ed9575bd6a..6c455a0e43 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1652,6 +1652,44 @@ static int pp_start_one(struct parallel_processes *pp,
>  	return 0;
>  }
>  
> +static void pp_buffer_stdin(struct parallel_processes *pp,
> +			    const struct run_process_parallel_opts *opts)
> +{
> +	/* Buffer stdin for each pipe. */
> +	for (int i = 0; i < opts->processes; i++) {

`opts->processes` is of type `size_t`, so let's use the same type as
iterator.

> +		struct child_process *proc = &pp->children[i].process;
> +		int ret;
> +
> +		if (pp->children[i].state != GIT_CP_WORKING || proc->in <= 0)
> +			continue;
> +
> +		/**

Nit: multi-line comments should start with "/*", not "/**". This is also
present in multiple other 

> +		 * child input is provided via path_to_stdin when the feed_pipe cb is
> +		 * missing, so we just signal an EOF.
> +		 */
> +		if (!opts->feed_pipe) {
> +			close(proc->in);
> +			proc->in = 0;

Hm. It's curious that we use a valid file descriptor here. Shouldn't we
rather use `-1`? Otherwise I could see that we might try to close this
seemingly valid file descriptor at a later point in time.

> +			continue;
> +		}
> +
> +		/**
> +		 * Feed the pipe:
> +		 *   ret < 0 means error
> +		 *   ret == 0 means there is more data to be fed
> +		 *   ret > 0 means feeding finished
> +		 */
> +		ret = opts->feed_pipe(proc->in, opts->data, pp->children[i].data);
> +		if (ret < 0)
> +			die_errno("feed_pipe");
> +
> +		if (ret == 1) {

This condition mismatches the comment: you explicitly check for 1, but
the comment above says `ret > 0` indicates that feeding has finished.

> @@ -1756,6 +1795,33 @@ static int pp_collect_finished(struct parallel_processes *pp,
>  	return result;
>  }
>  
> +static void pp_handle_child_IO(struct parallel_processes *pp,
> +				const struct run_process_parallel_opts *opts,
> +				int output_timeout)

Okay, this function is new and was extracted out of
`run_processes_parallel()`. It's basically the heart of our I/O loop
for our children.

> +{
> +	/*
> +	 * First push input, if any (it might no-op), to child tasks to avoid them blocking
> +	 * after input. This also prevents deadlocks when ungrouping below, if a child blocks
> +	 * while the parent also waits for them to finish.
> +	 */
> +	pp_buffer_stdin(pp, opts);

This part is new, as we now know to also optionally write stdin to the
child process.

> +	if (opts->ungroup) {
> +		for (size_t i = 0; i < opts->processes; i++) {
> +			int child_ready_for_cleanup =
> +				pp->children[i].state == GIT_CP_WORKING &&
> +				pp->children[i].process.in == 0;
> +
> +			if (child_ready_for_cleanup)
> +				pp->children[i].state = GIT_CP_WAIT_CLEANUP;

And this part here has changed, as well. We don't unconditionally set
`GIT_CP_WAIT_CLEANUP` anymore, but wait for `process.in` to be closed.

> +		}
> +		return;

I feel like this return is easy to miss. I think an `else` branch would
be more obvious.

> @@ -1775,6 +1841,13 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
>  					   "max:%"PRIuMAX,
>  					   (uintmax_t)opts->processes);
>  
> +	/*
> +	 * Child tasks might receive input via stdin, terminating early (or not), so
> +	 * ignore the default SIGPIPE which gets handled by each feed_pipe_fn which
> +	 * actually writes the data to children stdin fds.
> +	 */
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +
>  	pp_init(&pp, opts, &pp_sig);
>  	while (1) {
>  		for (i = 0;

Yeah, makes sense. I was briefly wondering whether we should rather do
it as part of `pp_buffer_stdin()`, so that it's more contained. But I'm
not sure that buys us anything.

> @@ -1809,8 +1876,11 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
>  
>  	pp_cleanup(&pp, opts);
>  
> +	sigchain_pop(SIGPIPE);
> +

There are no early exits, so we know this code should be executed.

>  	if (do_trace2)
>  		trace2_region_leave(tr2_category, tr2_label, NULL);
> +
>  }
>  
>  int prepare_auto_maintenance(int quiet, struct child_process *maint)

Nit: stray empty line.

> diff --git a/run-command.h b/run-command.h
> index 0df25e445f..4679987c8e 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -420,6 +420,22 @@ typedef int (*start_failure_fn)(struct strbuf *out,
>  				void *pp_cb,
>  				void *pp_task_cb);
>  
> +/**
> + * This callback is repeatedly called on every child process who requests
> + * start_command() to create a pipe by setting child_process.in < 0.
> + *
> + * pp_cb is the callback cookie as passed into run_processes_parallel, and
> + * pp_task_cb is the callback cookie as passed into get_next_task_fn.
> + * The contents of 'send' will be read into the pipe and passed to the pipe.
> + *
> + * Returns < 0 for error
> + * Returns == 0 when there is more data to be fed (will be called again)
> + * Returns > 0 when finished (child closes fd or no more data to be fed)

s/closes/closed/

> diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
> index 3719f23cc2..dfdb03b3ab 100644
> --- a/t/helper/test-run-command.c
> +++ b/t/helper/test-run-command.c

This helper very much looks like it should be converted to a unit test.
Anyway, that is outside of the scope of this patch series.

> diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
> index 76d4936a87..282afecefc 100755
> --- a/t/t0061-run-command.sh
> +++ b/t/t0061-run-command.sh
> @@ -164,6 +164,36 @@ test_expect_success 'run_command runs ungrouped in parallel with more tasks than
>  	test_line_count = 4 err
>  '
>  
> +cat >expect <<-EOF
> +preloaded output of a child
> +listening for stdin:
> +sample stdin 1
> +sample stdin 0
> +preloaded output of a child
> +listening for stdin:
> +sample stdin 1
> +sample stdin 0
> +preloaded output of a child
> +listening for stdin:
> +sample stdin 1
> +sample stdin 0
> +preloaded output of a child
> +listening for stdin:
> +sample stdin 1
> +sample stdin 0
> +EOF

This block should be part of the test itself.

> +test_expect_success 'run_command listens to stdin' '
> +	write_script stdin-script <<-\EOF &&
> +	echo "listening for stdin:"
> +	while read line; do

Style nit: let's drop the `;` and move the `do` to the next line.

> +		echo "$line"
> +	done
> +	EOF
> +	test-tool run-command run-command-stdin 2 ./stdin-script 2>actual &&
> +	test_cmp expect actual
> +'

Patrick
