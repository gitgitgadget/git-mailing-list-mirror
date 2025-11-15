Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58841DE4CE
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763236108; cv=none; b=u0JMID9qEXHvvxDk8cu2yy2XBT58Y4j2qhAedYzHE+hnaffoQ8v0GHvkKSn/YkuW7B5qUik8IxHDCKjpldgICD/dpZPBftIQOiSt00Wezn1k5okc5biprSN4BYY38Vs3goGfjg4+aaW+Pk9ya1qOJfGDNeqzwycuZbgcY5XRt80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763236108; c=relaxed/simple;
	bh=w3OkMYEa9TTeJTpSqkoG7eA3PU/p2aOv7nMzt2Elgqo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c3KUS4sMOwl0iplOxB1V20n+KfyDRfjji5m4IhLLKg+P5Cflrl9AQYoD4FOMZ8hbN54ibsi/ioEIq11NDcZn38a+Y9SyR+ZRGeOy/FC20pJ/+zrkr8xqRHGDfgFB8S41S66LiPWvQ22g2wc4ivKmNl0PvIM+DAK+RqLgG9vajac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y3oHEJUJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CRHQZJF9; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y3oHEJUJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CRHQZJF9"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 9CF081D0010A;
	Sat, 15 Nov 2025 14:48:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sat, 15 Nov 2025 14:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763236104; x=1763322504; bh=P/NJVw8mJJ
	+bmzS9UmGc5y/toJFnmYXG3b6LpSi+klo=; b=Y3oHEJUJFTgl3KMfnNHmD4IJRZ
	nk/AWx11s/nIZAkQJleLkGFpe6ZWSnagtyPw+Z8vhmROt/WhaANzEX4m7JdnvLMN
	SV3I2qlR5vpOBse0T5GvHSZnuaP+bbu2kEDLkOGa7fHBofIdCBhKS6Ci73t3dxlk
	cL+amHBkVhBQWywDCFFxc0CBuTHPscePF5iVuYSkd/cudwyF4snoXd3NXb7wPjyU
	bW0G7Z3Y024r4WeqxngbEFMZOI3gW5KWXqieK+TxuAoGcMz+YPyuH7c79jGBTZ28
	4S485vT8qFGrYU1AaSGyjR7A+0bCtPadsKn/jr34Obt56Nzm+LuGnxImzdOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763236104; x=1763322504; bh=P/NJVw8mJJ+bmzS9UmGc5y/toJFnmYXG3b6
	LpSi+klo=; b=CRHQZJF9jHvot8EDOVFQ/UL0czad+nlWp1gu8BomSd4hgvhdtAY
	SoErSlg5FZ+SzBSHNIAfGoWJzaI+pcGBMjLkxzGZdyNwjYo2XTC3eqHR3u87+wKg
	x7rugyJBHagTq8m2Y69Xknov50YMKCOS8h9Hi9GUwCELBNRcVrF921oyCdWdePZ/
	VbkT39UFPdu7fS123KpInSFJiGUzuaZVCtdJp08G+iH/5MIXQN4xZSveALeArY3Y
	O1ZYOGMfrIayIeOTD5wz8gMIfOXBWzY7f9XJoDcGh8Ch3pGNSlWvsHQM6NzUG9vB
	mOaJlP+LXUL+0/OEfCovVcAupAHPJrieEBQ==
X-ME-Sender: <xms:CNkYaYqa0z-CBO2x3YFKYKxnUjcOO4uPIMiTb9wtlqcjTRGB9MbTCg>
    <xme:CNkYabOv9ORDlKMHr1B5wpj1QSrZliBn1CY_aMY7Ln26wNGcOd7SwGklG7-D0nrWm
    IJTAuNjN37q_pdNZx4ssKNzY-ymkJCbu3iTIfpaRT21Vl0zl9Uigw>
X-ME-Received: <xmr:CNkYaRras_jpA7RV2W0I-fZy6VfZE8ioA3B1uN5jGXnGEQ3T7TDypbpBiQHpHHYonVtX-fMSEB_1jdB2orSaU7vKM413wtnWN55J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudefheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    gurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvmhhilhihshhhrghffh
    gvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhgurghmrgiiihhosehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhtvggrug
    hmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhm
    rghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:CNkYaWs69EbCflqj5--eAKptKHG_uc8q170t7urI-fWBWxlK7tnevA>
    <xmx:CNkYaY3ZOqOYnxP0mjcTphEvIi_3oiTvxvfad5-M40tkqXjgedOQ1Q>
    <xmx:CNkYaZHGgQyJ_E2nbAR7pO-zgUx7WPlPhuHjA0fG9D3BahhZta2sYQ>
    <xmx:CNkYabs6FEtG0qWy6BD5YNodLKXhB6H1C5wQkBo0Yh6ZclD62KjpFw>
    <xmx:CNkYaYuogQTKFvLYpUh8f4THuQkrUPEEGOAI1mav--dWUVBGm0SKfbhp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Nov 2025 14:48:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,
  Rodrigo Damazio Bovendorp <rdamazio@google.com>,
  Patrick Steinhardt <ps@pks.im>,
  Josh Steadmon <steadmon@google.com>,
  Ben Knoble <ben.knoble@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 10/10] receive-pack: convert receive hooks to hook API
In-Reply-To: <20251017141544.1538542-11-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Fri, 17 Oct 2025 17:15:44 +0300")
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
	<20251017141544.1538542-1-adrian.ratiu@collabora.com>
	<20251017141544.1538542-11-adrian.ratiu@collabora.com>
Date: Sat, 15 Nov 2025 11:48:22 -0800
Message-ID: <xmqq346ff56h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> +static int feed_receive_hook(int hook_stdin_fd, struct receive_hook_feed_state *state, int lines_batch_size)

Overly long line and cannot read.  Can you stick to 80-column lines?

In any case, the reason I am responding to this message is not about
coding styles, but it seems to be the one whose leak is holding the
CI job from passing at the tip of 'seen'.

>  {
> +	struct command *cmd = state->cmd;
>  
> +	strbuf_reset(&state->buf);
>  
> +	/* batch lines to avoid going through run-command's ppoll for each line */
> +	for (int i = 0; i < lines_batch_size; i++) {
> +		while (cmd &&
> +		       state->skip_broken && (cmd->error_string || cmd->did_not_exist))
> +			cmd = cmd->next;
>  
> +		if (!cmd)
> +			break;  /* no more commands left */
>  
> +		if (!state->report)
> +			state->report = cmd->report;
>  
> +		if (state->report) {
> +			struct object_id *old_oid;
> +			struct object_id *new_oid;
> +			const char *ref_name;
>  
> +			old_oid = state->report->old_oid ? state->report->old_oid : &cmd->old_oid;
> +			new_oid = state->report->new_oid ? state->report->new_oid : &cmd->new_oid;
> +			ref_name = state->report->ref_name ? state->report->ref_name : cmd->ref_name;
>  
> +			strbuf_addf(&state->buf, "%s %s %s\n",
> +				    oid_to_hex(old_oid), oid_to_hex(new_oid),
> +				    ref_name);
>  
> +			state->report = state->report->next;
> +			if (!state->report)
> +				cmd = cmd->next;
> +		} else {
> +			strbuf_addf(&state->buf, "%s %s %s\n",
> +				    oid_to_hex(&cmd->old_oid), oid_to_hex(&cmd->new_oid),
> +				    cmd->ref_name);
> +			cmd = cmd->next;
> +		}
>  	}
>  
> +	state->cmd = cmd;
>  
> +	if (state->buf.len > 0) {
> +		int ret = write_in_full(hook_stdin_fd, state->buf.buf, state->buf.len);
> +		if (ret < 0) {
> +			if (errno == EPIPE)
> +				return 1; /* child closed pipe */
> +			return ret;
> +		}
> +	}
> +
> +	return state->cmd ? 0 : 1;  /* 0 = more to come, 1 = EOF */
>  }

> +static int feed_receive_hook_cb(int hook_stdin_fd, void *pp_cb, void *pp_task_cb UNUSED)
>  {
> -	struct receive_hook_feed_state *state = state_;
> -	struct command *cmd = state->cmd;
> +	struct hook_cb_data *hook_cb = pp_cb;
> +	struct receive_hook_feed_state *feed_state = hook_cb->options->feed_pipe_cb_data;
> ... 
> +	/* first-time setup */
> +	if (!hook_cb->options->feed_pipe_cb_data) {
> +		struct receive_hook_feed_context *ctx = hook_cb->options->feed_pipe_ctx;
> +		if (!ctx)
> +			BUG("run_hooks_opt.feed_pipe_ctx required for receive hook");
> +
> +		hook_cb->options->feed_pipe_cb_data = xmalloc(sizeof(struct receive_hook_feed_state));

The allocation done here seems to be causing one (smaller) leak.

  https://github.com/git/git/actions/runs/19381820975/job/55461902226#step:10:3994

> +		feed_state = hook_cb->options->feed_pipe_cb_data;
> +		strbuf_init(&feed_state->buf, 0);
> +		feed_state->cmd = ctx->cmd;
> +		feed_state->skip_broken = ctx->skip_broken;
> +		feed_state->report = NULL;
>  	}
> +
> +	/* batch 500 lines at once to avoid going through the run-command ppoll loop too often */
> +	if (feed_receive_hook(hook_stdin_fd, feed_state, 500) == 0)
> +		return 0; /* still have more data to feed */

It appears to me that the larger leak the leak checker finds

  https://github.com/git/git/actions/runs/19381820975/job/55461902226#step:10:4017

is in find_receive_hook() called from here, where state->buf has
accumulates a lot.

builtin/receive-pack.c:847 its stacktrace #5 talks about is probably
pointing at the struf_addf() call there.  The particular test is
about deliberately causing EPIPE by the making other side refuse to
read, so some error handling on this side is missing the necessary
deallocation, perhaps?

> +	strbuf_release(&feed_state->buf);
> +
> +	if (hook_cb->options->feed_pipe_cb_data)
> +		FREE_AND_NULL(hook_cb->options->feed_pipe_cb_data);
> +
> +	return 1; /* done feeding, run-command can close pipe */
> +}
