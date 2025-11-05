Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEBC309EFC
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361853; cv=none; b=sMOEVQg7iYBXwtdzJjm7/+TJpq7WqJdSZSnjymysxT2rBOA3A4AZHG3kou3Qdv29gHzUD/qz8nhmy2/8QFEgeJlTTRb71uOYjbA+C/dYvo9sLHaGeyxlNyHE0aAEp3BUbWMof3IN3lwCL28zF1qVtMPT/3cSIJznCqNiPUMkbxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361853; c=relaxed/simple;
	bh=9AGj6bi6WgIKo5TsUIW3RfAYAC4O3BLGQMAYYalo3HA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sopk6yzMmmVr9B2t9/aqQzxawMO9OeYGcKOujUaF/Gjr2stMlA6wvZrZN9UFLXX9u2P32v3EOo2+mWQ2jtZPfCgcN2gM4x1DUTIQLa8rnwR3n7VoUgwhAs7OzMiav5E4Mx1WQn5B0wABNz81B2Tu7DyKE+lIrkYgcgwDb8gpb2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gbYOHsGp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z+7op4E5; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gbYOHsGp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z+7op4E5"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id EFFFB1D0016A;
	Wed,  5 Nov 2025 11:57:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 05 Nov 2025 11:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762361849; x=1762448249; bh=++3EqKLXKr
	G9cJJYOFtSJX6VgJ1YfuMNGKsIHsPXLBY=; b=gbYOHsGpUB4uC0yRRrpDeaH9H0
	6+orSbs1Q3vHU7GD6Htp0XZQr3jQOv4ajAU3HIR22Qg6Oz7crolHrc4rYlxSx/yl
	lFhjFczjWu4jrr7YJm6Cb200xY9wHvhxpDfiTiYpBn5KP1hAflO9AvAW51wFHTjX
	U/TPfdCRJSwYoRJKWrKLgxXw0eJ8aQzQsu35dSJstXbFgUdq+cQypsTBcxxDLI+c
	lyVj+ysAe3kWx0w4GaO6hVdC7p49yEiM3G9zn01D1UA7O0ZGw1ABwml/m4vSZMFm
	sIySkQwWKt81s6s9/9VgpBh30ZR2I4e/EiiPVHm+CdTcUcljXHRNl9e+2jKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762361849; x=1762448249; bh=++3EqKLXKrG9cJJYOFtSJX6VgJ1YfuMNGKs
	IHsPXLBY=; b=Z+7op4E5S3LoUrb6My+C+GqYmSeowlR1Q49NLOkXi4vy6tBRkHN
	EasTup/tfxUtNTDlBnc8gfYMVu4yLYSto9BWcOVDFtDMz4OQz13EkJa2BRA6RFFq
	6r17RQaJ3eJt638MmcO4lAHnfAVDGJ7fbj/7M1F1zn33eRo9jx2QncSmwDV7QKC5
	XAGgqLVvTKLyKaC3F6iK3jW2cdC5KRU7Yk1VQ1b8RbwfV97ANmhRZVJB3L1nnZh8
	NX8hTmH9BgjGHkRGEPv3henm5Y5bxXn7ihBg91JZldXl0LTyLtudrvV2zp2iEMbl
	M4RHc/Pb9CEu/NxINVhJOLYoOb06HBjXcOA==
X-ME-Sender: <xms:-YELaWjvN2pFEFunrL8hhzviHFKReGQ6i2yYXyJyZ1XGNrNu6hJQLQ>
    <xme:-YELaYiJaeQAosrnF6TaJ6AB3p-FXEcwWF7Da5eiH-8t8n0RO81sR2JQ7h1QXMxw2
    sLUaazHmrAF1Mo5kaUvETgvYXCqrn1VHl0kRIkKNt-KWN1JSP5z3Q>
X-ME-Received: <xmr:-YELaeJ79QAJ7NVFlMUvXUVL5rPi7qJ6qgdQJppLFH0eQHQNnfQAt33VQabygVDgRvVywLIY8zg7-VJMu7gjLKotLFdC5gsQ9oJF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeggeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehlihhnuhigrdgsvggruhhthidprhgtphhtth
    hopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-YELafEkJyr_51I7GEthRfmZgR1ohBHFcVR_mP5GkerZQsBt2-SjiQ>
    <xmx:-YELaaSIQIDg_6iwXXS3onbVUduhWIxipe3VFF1KbtNR5FN7GzUdkw>
    <xmx:-YELaTfH3ryIK0JFcYFJ-zED_-13-8ooLR4te1Q16w3NbNZsYCiHLw>
    <xmx:-YELaRqXTTMfxciKjG0C84WGwwYUBwzORUhXRv6BHVEYtXUjrnzp8g>
    <xmx:-YELaW7EGcCv2BepqsHToJljOCoXtUDUptE8s4oKZyfl9qhagRIkucha>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 11:57:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Li Chen <me@linux.beauty>
Cc: "phillipwood" <phillip.wood@dunelm.org.uk>,  "git"
 <git@vger.kernel.org>,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v6 1/4] interpret-trailers: factor out buffer-based
 processing to process_trailers()
In-Reply-To: <20251105142944.73061-2-me@linux.beauty> (Li Chen's message of
	"Wed, 5 Nov 2025 22:29:41 +0800")
References: <20251105142944.73061-1-me@linux.beauty>
	<20251105142944.73061-2-me@linux.beauty>
Date: Wed, 05 Nov 2025 08:57:27 -0800
Message-ID: <xmqq1pmcmn7s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Li Chen <me@linux.beauty> writes:

> From: Li Chen <chenl311@chinatelecom.cn>
>
> Extracted trailer processing into a helper that accumulates output in
> a strbuf before writing.
>
> Updated interpret_trailers() to reuse the helper, buffer output, and
> clean up both input and output buffers after writing.

Imperative?

>
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> ---
>  builtin/interpret-trailers.c | 51 ++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 22 deletions(-)
>
> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> index 41b0750e5a..4c90580fff 100644
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
> +			     struct strbuf *sb, struct strbuf *out)

So we gained *out strbuf; in the preimage below I see fwrite(),
fprintf(), etc. to outfile that is either stdout or tempfile, but
presumably the output all will be captured in the strbuf instead,
which makes sense.  It is a bit curious what the new paramater sb
is, but this is a file-scope static helper, so it does not strictly
require documenting.  Having a comment would still be nicer, though,
unlike "struct process_trailer_options" that is very limited
purpose, "strbuf" can be used for any string processing, so a good
variable name like "out" that conveys what it is used for by
implication is good, but "sb", which is obvious abbreviation for
"Str Buf", conveys no useful information.

>  {
>  	LIST_HEAD(head);
> -	struct strbuf sb = STRBUF_INIT;
> -	struct strbuf trailer_block_sb = STRBUF_INIT;

We no longer need a separate strbuf only for trailer block; we will
see why before we read through this helper function, hopefully.

>  	struct trailer_block *trailer_block;
> -	FILE *outfile = stdout;
> -
> -	trailer_config_init();
>  
> -	read_input_file(&sb, file);
> -
> -	if (opts->in_place)
> -		outfile = create_in_place_tempfile(file);

OK, so the original code read the input (either "file", or standard
input) into a tempfile and prepared the output file stream.
Presumably it is now the responsibility of the caller of this new
function.  Initializing the trailer configuration is also what the
caller of this function is reponsible for, as well.

So this answers one of the questions I had upon starting to read
this function, i.e. "what is sb?"  It holds the input string, which
is what?  Something that look like a commit message that has title,
body and then a trailer block?  We may want to give the parameter a
better name?  I dunno (as this is file-scope static, as long as it
is obvious to the local caller, it may be OK, but on the other hand,
the caller needs to differenciate two strbuf parameters to the
helper function, one used for input and the other output, so if you
are calling the latter "out", perhaps you would want to call it
"in", or "input", perhaps?)

> -	trailer_block = parse_trailers(opts, sb.buf, &head);
> +	trailer_block = parse_trailers(opts, sb->buf, &head);

So we parse existing trailers from the input strbuf that is supplied
by the caller.  The rest of this hunk is rewriting FILE* I/O with
strbuf addition.

> @@ -173,22 +162,40 @@ static void interpret_trailers(const struct process_trailer_options *opts,
>  	}
>  
>  	/* Print trailer block. */
> -	format_trailers(opts, &head, &trailer_block_sb);
> +	format_trailers(opts, &head, out);
>  	free_trailers(&head);
> -	fwrite(trailer_block_sb.buf, 1, trailer_block_sb.len, outfile);
> -	strbuf_release(&trailer_block_sb);

The format_trailers() helper function appends appends to the strbuf
that is given to it, so instead of using an extra strbuf (and then
appending that to the output), we just pass our output strbuf to it,
which is why we no longer need the trailer_block_sb strbuf anymore.
Makes sense.

>  	/* Print the lines after the trailer block as is. */
>  	if (!opts->only_trailers)
> -		fwrite(sb.buf + trailer_block_end(trailer_block), 1,
> -		       sb.len - trailer_block_end(trailer_block), outfile);
> +		strbuf_add(out, sb->buf + trailer_block_end(trailer_block),
> +			   sb->len - trailer_block_end(trailer_block));
>  	trailer_block_release(trailer_block);
> +}

And again, FILE* I/O is replaced with appending to the output strbuf
in the rest of this helper function.  Good.

> +static void interpret_trailers(const struct process_trailer_options *opts,
> +			       struct list_head *new_trailer_head,
> +			       const char *file)

So the original caller of interpret_trailers() now call this outer
shell, which has the same name and the same function signature as
the original.  Our new process_trailers() helper assumes a handful
of preparatory steps are already done by the caller, so what we are
going read here will be mostly those preparation, a call to our new
helper, and then printing the result to "file" or standard output.

> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	struct strbuf out = STRBUF_INIT;
> +	FILE *outfile = stdout;
> +
> +	trailer_config_init();
> +
> +	read_input_file(&sb, file);
> +	if (opts->in_place)
> +		outfile = create_in_place_tempfile(file);

And these are exactly the lines we lost from the new helper.
Looking good.

> +	process_trailers(opts, new_trailer_head, &sb, &out);

And our call.  "out" should have what we wanted to output to
outfile, so ...

> +	fwrite(out.buf, out.len, 1, outfile);

... we write it out.  Good.  For a single long string that can never
have NUL in it, I'd personally find it more natural to call fputs(),
though.  Use of fwrite() makes readers unnecessarily wonder if there
is something unusual (like needing to be able to handle NULs in the
buffer).

>  	if (opts->in_place)
>  		if (rename_tempfile(&trailers_tempfile, file))
>  			die_errno(_("could not rename temporary file to %s"), file);
>
>  	strbuf_release(&sb);
> +	strbuf_release(&out);

OK.  We could release out a bit earlier, immediately after fwrite().

Looking mostly good.

>  }
>  
>  int cmd_interpret_trailers(int argc,
