Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1E7401489
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772463376; cv=none; b=bFNgCGHtq1oF/rOCfmAxbAesCkOTP63LWrowxcdmnUEhm8kLvyEjpf923bXWFzcuj1XSky/QAvtmKjZhuXsrVHVp7efX6L42ixoQLsjNKLncsSBfEsb6kSigS9FqvEJMM+iG0tgYEwWIaESc05S9bBCC6TGm/uGcthbca1tLeKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772463376; c=relaxed/simple;
	bh=qvTNVodYKV2hICFHE124DcVVpeAP5QhmsktrOObglAo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gWF4lAKp3mux3VscNEbIuZRLrrCS6eR56SStB3dxW82OqDgjm8mhUbZFLb6aix7vw2N7dxFuHkjhMuqXAlCeB9L/3PHDT5nyus7hf0jUTI9W222bt9k+0eF2qnONFtkgybhzvqn+yLvwaLxWbo0a+18j+99wkbYT01HAo1qULqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eywT2s+6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eywT2s+6"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so751815f8f.0
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 06:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772463368; x=1773068168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hNksnlrNiUZ5MLpCgVeNZFj0saHFAD+XoQzyyOEvC3k=;
        b=eywT2s+6J8ecTf0XMOM0OiaLinOlWbTUUimceU+SGfDRIqbOWlBj2P7UEls0nzxxJF
         50YIfeTBnifLyoJjzic8APf595i6bgWjVdz8KOs6CLuOlnYdi0+pBYGiUOd88GgjCXpk
         RwQ2jVRfffpHXerzUYQRCI+2Slq61id6XyaGPuDpi6XgJsOv43TxQbLH75i1FpSi1yRC
         lWesRzGvq2Dugaphl3J63bY+87FZ99ZrfTLf9MTjlmyltPeTWHzXcae6ZFHZjsXqn0x8
         66Kj6ncC+VDuh9uiSKo5N7q8CGyxOzjHENw1C4RCXHTsF5h2XkorcGBs1FKf6hjKNlBu
         fGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772463368; x=1773068168;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hNksnlrNiUZ5MLpCgVeNZFj0saHFAD+XoQzyyOEvC3k=;
        b=AjBXPIE8hIr5eLIJl8pGKXBdbuMbo6XcAvwEO+//Lqe5iA2WV9e7BF2vTvz7e+LACw
         +YFDHPmFDKkek/pLySnDfHdhBGyzlG4XGvV7vhuthjFRpecIhK34lvgwewzltOYW/2w2
         Xy7o/t6DHJDyqDeuXqVTrQ10x9RiD4KnRcUXMgqmxB/toFZqP2ZoOaG69YpioIQIv20e
         k526YXjtimSsVGTRr57lXRgO/rtIQZi/ET5IKVuj5+Vx5LTDbwQfFacCemvExrHBJ4Xl
         LGSzaww2JEDvAJiQq8Sz6ejjvOrI9CmaCAks0oGCUC0vky2CC/FJrygGdSPieI0iSHDS
         C3Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVdB+uXd7daJP5tb6CAKHarFBkJEhMBFgMe4LeyjG4YvMaKotA60JFG+IAJh9EGpxoF2Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDZdQ26kkhphZIIFvzsOxGp+uhkn9zzYU2xSIZ28NuAr9SnK5m
	tHqQZr5JXq/KxpBl1pTFWsTdpnz1P3NSUDO4yBZ9m97nyf9+pmlydI4I
X-Gm-Gg: ATEYQzypxwyV0dNJ8fdJthBnKPeTIgbiybNXh7vvvOaZkJjhdB003F0V6E0e/NnL3JT
	mo8L4iFOR6N+Eq1CE0qq2DQugKjDFjDz7reco1oba6sUm2dpV7q91uPufyWOyUlI5oqExFUFaWc
	yDQrjUpda7EkfnXJRIVzQ9fyu27gSfsMe0CpF5oy1DZa+4VgDuqOF4xGHVtcHQvs6Cw/mOX450S
	28odR9ui9IIOfcdqcW3RBbOjdHrc73eG4G9cx2kr/B6sMYGlynd5zjckJatG3FyvIMzqJ0KK08z
	5ZtDDmgQD1oBn3sN9qttgTKgpp3sqBN83GXB4ITmRGPVy2GdAiBOk168xsu78S0zwooJliUCeZ/
	EYzEDWy95t/rOCW/P9ZPH/DrSqr+k6eTasR0QJPk64mMY8VN7r7G0IzD8LOU+lUt2Z8ENilapfS
	I3YO9VJjrLhjBFv/J/vOKzCgodeyBtuklCGKewouPLtZTm3ooPJcA0XsVdq2GdTAnyScYNwUzlh
	trvCA==
X-Received: by 2002:a05:6000:2dc5:b0:439:b858:1d28 with SMTP id ffacd0b85a97d-439b8581e08mr5280482f8f.26.1772463368045;
        Mon, 02 Mar 2026 06:56:08 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c60f764sm28456428f8f.3.2026.03.02.06.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 06:56:07 -0800 (PST)
Message-ID: <56b1b6b6-94c2-4a2f-b473-9b4d09d6f52e@gmail.com>
Date: Mon, 2 Mar 2026 14:56:04 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v7 1/5] interpret-trailers: factor trailer rewriting
To: Li Chen <me@linux.beauty>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20260224070552.148591-1-me@linux.beauty>
 <20260224070552.148591-2-me@linux.beauty>
Content-Language: en-US
In-Reply-To: <20260224070552.148591-2-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Li

On 24/02/2026 07:05, Li Chen wrote:
> Extract the trailer rewriting logic into a helper that appends to an
> output strbuf.
> 
> Update interpret_trailers() to handle file I/O only: read input once,
> call the helper, and write the buffered result.
> 
> This separation makes it easier to move the helper into trailer.c in the
> next commit.

This is still missing my sign off c.f. 
https://lore.kernel.org/f5152523-f7ff-4dee-a685-fb0b74cd6a56@gmail.com

> Signed-off-by: Li Chen <me@linux.beauty>
> ---
> v7:
> Use strbuf_write() when emitting buffered output.

Also renamed "sb" to "input"

Apart from the missing sign off this all looks good.

Thanks

Phillip

> 
>   builtin/interpret-trailers.c | 53 ++++++++++++++++++++----------------
>   1 file changed, 30 insertions(+), 23 deletions(-)
> 
> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> index 41b0750e5a..69f9d67ec0 100644
> --- a/builtin/interpret-trailers.c
> +++ b/builtin/interpret-trailers.c
> @@ -136,32 +136,21 @@ static void read_input_file(struct strbuf *sb, const char *file)
>   	strbuf_complete_line(sb);
>   }
>   
> -static void interpret_trailers(const struct process_trailer_options *opts,
> -			       struct list_head *new_trailer_head,
> -			       const char *file)
> +static void process_trailers(const struct process_trailer_options *opts,
> +			     struct list_head *new_trailer_head,
> +			     struct strbuf *input, struct strbuf *out)
>   {
>   	LIST_HEAD(head);
> -	struct strbuf sb = STRBUF_INIT;
> -	struct strbuf trailer_block_sb = STRBUF_INIT;
>   	struct trailer_block *trailer_block;
> -	FILE *outfile = stdout;
>   
> -	trailer_config_init();
> -
> -	read_input_file(&sb, file);
> -
> -	if (opts->in_place)
> -		outfile = create_in_place_tempfile(file);
> -
> -	trailer_block = parse_trailers(opts, sb.buf, &head);
> +	trailer_block = parse_trailers(opts, input->buf, &head);
>   
>   	/* Print the lines before the trailer block */
>   	if (!opts->only_trailers)
> -		fwrite(sb.buf, 1, trailer_block_start(trailer_block), outfile);
> +		strbuf_add(out, input->buf, trailer_block_start(trailer_block));
>   
>   	if (!opts->only_trailers && !blank_line_before_trailer_block(trailer_block))
> -		fprintf(outfile, "\n");
> -
> +		strbuf_addch(out, '\n');
>   
>   	if (!opts->only_input) {
>   		LIST_HEAD(config_head);
> @@ -173,22 +162,40 @@ static void interpret_trailers(const struct process_trailer_options *opts,
>   	}
>   
>   	/* Print trailer block. */
> -	format_trailers(opts, &head, &trailer_block_sb);
> +	format_trailers(opts, &head, out);
>   	free_trailers(&head);
> -	fwrite(trailer_block_sb.buf, 1, trailer_block_sb.len, outfile);
> -	strbuf_release(&trailer_block_sb);
>   
>   	/* Print the lines after the trailer block as is. */
>   	if (!opts->only_trailers)
> -		fwrite(sb.buf + trailer_block_end(trailer_block), 1,
> -		       sb.len - trailer_block_end(trailer_block), outfile);
> +		strbuf_add(out, input->buf + trailer_block_end(trailer_block),
> +			   input->len - trailer_block_end(trailer_block));
>   	trailer_block_release(trailer_block);
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
>   
> +	strbuf_write(&out, outfile);
>   	if (opts->in_place)
>   		if (rename_tempfile(&trailers_tempfile, file))
>   			die_errno(_("could not rename temporary file to %s"), file);
>   
> -	strbuf_release(&sb);
> +	strbuf_release(&input);
> +	strbuf_release(&out);
>   }
>   
>   int cmd_interpret_trailers(int argc,

