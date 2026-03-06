Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7C42F0C79
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 21:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831091; cv=none; b=HqUQbkXE2KDQqb6FQHplDSS/pggAiP+TknQtu8MjASqLJ+0uwJ74Nz1OlFLX49PciaKpuRcHcmEtrKpAGlXiporlN46fcblG4/8DCC5aIhLvpFkDclaDY2DqANSbYIEm5J4DItIgUfTk9qA75sEJzs8MsoJfXwUEBYK2o8oIKTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831091; c=relaxed/simple;
	bh=i6a2pBuXGes63eU6FU5yjkhgc8MfbpL7LUfmfSZ+n88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IKtgpN6w1XZaEjScn9Nlc8cUV+hUfuEXi9EUFH1OrynYt0bZb3yM4mo2i4fSEvVDUwXTy/bC+bcm+fPkTNA2W0bO81EfKpqyoJgJsy1eAUX9jHRd3Dif+83/hxVLUG9wX6gD1MKQY//yNe6FXjtGTCzCPiYHuoU4fHlyLWdlQhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cpOFeDll; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MawrqNE7; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cpOFeDll";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MawrqNE7"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B150D1400205;
	Fri,  6 Mar 2026 16:04:48 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 06 Mar 2026 16:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772831088; x=1772917488; bh=6F64q9+5cV
	QQYh6wsSWkv2TJX4W+QpN34kQOymhUy34=; b=cpOFeDll6Xl+LLUi6GocmkWjmd
	UyUX8BlX3xBc6Xda8qxkvIW8NHiusWYG+t1GRZ5zQnpHVzI+9zdomAfRRvU82F2+
	0Vv1GL9fQ2vwXfhhsk7vYYFGbojF2QAnDD7evFFU/r/3Vn/rDsrAgKS2oiQetOgi
	Eg4JvPT7BdMpEs+MGWHi30TzWbOa+5QPwBiDziFmB8HSbkcvuL58/wYgW0TpGWMH
	XagH7ID0eLgyQXREqxXUsplp4LVkGUOz7N0J/YpCVqozIDMMpck4vBQWugPuG80+
	ohoYEeK8q9oFiiS9zUEOr/Pb7uxNBtKoa6MDQrYJmrg4v+u0a4UIZTEL1u2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772831088; x=1772917488; bh=6F64q9+5cVQQYh6wsSWkv2TJX4W+QpN34kQ
	OymhUy34=; b=MawrqNE73y3AtnB8nyVZdfrR4yhVloEc7vaZuounYezNq97McGK
	aqsLfOw/Fv74ts3EIbLEwTAArhNR6ADEYKdpHoNoDeIR5qmbd1jfXXGQ90NDDsoA
	Fs35sULvYdcaMK8wnoIU6s4WP0XQzCpzwoAkFDcsTcyv3DRsIeZjx+PuLi0G3lrr
	eQ7yE9Yg+WtZ7W64vlzzVUp96cWTobQ7z3T8HWYcTKOrChfQSZsFfQ95iTXuhR37
	9kIKeL8rkaDMpaVevurWPN7u+bhx0K981/rdpKnOd0MvdE9WQYxEJcJJJR3ocMbs
	XzaY3op6bJsbz9kW7KUuBD4P23+Y2dMwvcQ==
X-ME-Sender: <xms:cEGraRkegsCzOesFCRJN3GCZqQds0lgaqajeqLuECNYHOvbzmxazHQ>
    <xme:cEGraWK2ai9ad-Z2pa9sqNGHeqKKZKZlKmR6VP-LD-iZvXOvyFyI8TnGx3KknSjci
    fYA-KAXPjcz75upIUgTnmQ6spVO80BHWTkpTiQjOFtjFgj8JXyRuA>
X-ME-Received: <xmr:cEGrae6CGZVGbiQXqGNIqaejaK8nl6T8wOjfFMb-NXW_80Gf4aTFHP3dgb4ufDD_KYO4V-DgY36Ack779kyDIzIBhyo9NKU9gQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepmhgvsehlihhnuhigrdgsvggruhhthidprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:cEGraS2yFg7VOJZDnToMlsTzDxC8I8M7VHaImsrv56P4RX5NElYtog>
    <xmx:cEGracfBQrkEIVKTKTqodp6PtxgOb7uqW40EGtKBd8RyDu7J9JWiAg>
    <xmx:cEGraQdQxw8CQ-J7MoTt0EW0jNxj3ysl5If58WFoJlzRddsLFaU4fw>
    <xmx:cEGrafw4e412uBUsexqHNdn-hn73kuFdJ7UcLQFoq-y2IkH5vtn5ig>
    <xmx:cEGraUpgFlyTE2Cc6NS_BQHNH-cJSg5m3cAlsM0UcM6e6AXdC5W5X_tc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 16:04:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,  Li Chen <me@linux.beauty>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v8 1/6] interpret-trailers: factor trailer rewriting
In-Reply-To: <0d08b361995f4d117b3c80a7e403c1a821d10a5f.1772808594.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Fri, 6 Mar 2026 14:53:27 +0000")
References: <20260224070552.148591-1-me@linux.beauty>
	<cover.1772808594.git.phillip.wood@dunelm.org.uk>
	<0d08b361995f4d117b3c80a7e403c1a821d10a5f.1772808594.git.phillip.wood@dunelm.org.uk>
Date: Fri, 06 Mar 2026 13:04:46 -0800
Message-ID: <xmqqo6l0zn2p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Li Chen <me@linux.beauty>
>
> Extract the trailer rewriting logic into a helper that appends to an
> output strbuf.
>
> Update interpret_trailers() to handle file I/O only: read input once,
> call the helper, and write the buffered result.
>
> This separation makes it easier to move the helper into trailer.c in the
> next commit.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Li Chen <me@linux.beauty>
> ---

If "Li wrote it and signed it off, Phillip is relaying" is what is
happening, the sign-offs are in reverse order.  If "Li incorporated
what Phillip wrote earlier in his larger work", then the sign-offs
may be fine, but it would be necessary to hint that that is what
happened in the proposed log message.  I cannot quite tell which is
the case.

>  builtin/interpret-trailers.c | 57 ++++++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 25 deletions(-)
>
> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> index 41b0750e5af..69f9d67ec0e 100644
> --- a/builtin/interpret-trailers.c
> +++ b/builtin/interpret-trailers.c
> @@ -136,32 +136,21 @@ static void read_input_file(struct strbuf *sb, const char *file)
>  	strbuf_complete_line(sb);
>  }
>  
> -static void interpret_trailers(const struct process_trailer_options *opts,
> -			       struct list_head *new_trailer_head,
> -			       const char *file)
> +static void process_trailers(const struct process_trailer_options *opts,
> +			     struct list_head *new_trailer_head,
> +			     struct strbuf *input, struct strbuf *out)
>  {
>  	LIST_HEAD(head);
> -	struct strbuf sb = STRBUF_INIT;
> -	struct strbuf trailer_block_sb = STRBUF_INIT;
>  	struct trailer_block *trailer_block;
> -	FILE *outfile = stdout;
> -
> -	trailer_config_init();
> -
> -	read_input_file(&sb, file);
> -
> -	if (opts->in_place)
> -		outfile = create_in_place_tempfile(file);
> -
> -	trailer_block = parse_trailers(opts, sb.buf, &head);
> +
> +	trailer_block = parse_trailers(opts, input->buf, &head);
>  
>  	/* Print the lines before the trailer block */
>  	if (!opts->only_trailers)
> -		fwrite(sb.buf, 1, trailer_block_start(trailer_block), outfile);
> +		strbuf_add(out, input->buf, trailer_block_start(trailer_block));
>  
>  	if (!opts->only_trailers && !blank_line_before_trailer_block(trailer_block))
> -		fprintf(outfile, "\n");
> -
> +		strbuf_addch(out, '\n');
>  
>  	if (!opts->only_input) {
>  		LIST_HEAD(config_head);
> @@ -173,22 +162,40 @@ static void interpret_trailers(const struct process_trailer_options *opts,
>  	}
>  
>  	/* Print trailer block. */
> -	format_trailers(opts, &head, &trailer_block_sb);
> +	format_trailers(opts, &head, out);
>  	free_trailers(&head);
> -	fwrite(trailer_block_sb.buf, 1, trailer_block_sb.len, outfile);
> -	strbuf_release(&trailer_block_sb);
>  
>  	/* Print the lines after the trailer block as is. */
>  	if (!opts->only_trailers)
> -		fwrite(sb.buf + trailer_block_end(trailer_block), 1,
> -		       sb.len - trailer_block_end(trailer_block), outfile);
> +		strbuf_add(out, input->buf + trailer_block_end(trailer_block),
> +			   input->len - trailer_block_end(trailer_block));
>  	trailer_block_release(trailer_block);
> -
> +}
> +
> +static void interpret_trailers(const struct process_trailer_options *opts,
> +			       struct list_head *new_trailer_head,
> +			       const char *file)
> +{
> +	struct strbuf input = STRBUF_INIT;
> +	struct strbuf out = STRBUF_INIT;
> +	FILE *outfile = stdout;
> +
> +	trailer_config_init();
> +
> +	read_input_file(&input, file);
> +
> +	if (opts->in_place)
> +		outfile = create_in_place_tempfile(file);
> +
> +	process_trailers(opts, new_trailer_head, &input, &out);
> +
> +	strbuf_write(&out, outfile);
>  	if (opts->in_place)
>  		if (rename_tempfile(&trailers_tempfile, file))
>  			die_errno(_("could not rename temporary file to %s"), file);
>  
> -	strbuf_release(&sb);
> +	strbuf_release(&input);
> +	strbuf_release(&out);
>  }
>  
>  int cmd_interpret_trailers(int argc,
