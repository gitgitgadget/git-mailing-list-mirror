Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B184014AF
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772463381; cv=none; b=Eo7z5GNTBCyBkDOuw/NokWZCsk6ibAZkH9YoDIJ85L0GbMUqAMBaBZPCpWUPf+49/bGNi//NMjKRazjW7RA1wrvhy6rr8v6sUTYMMP247s6vsgT+TFvue7Mv+M4bWU2LhJSEUdFolcvjg0wXt6CYfcRfBt4YwVEVJTK8fzz4pZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772463381; c=relaxed/simple;
	bh=JmygvwVR5EfrzbvKUbAMj8478hbY0ahpNCmbZXSnHbw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=haJcyEwctn6FEyrReG3sD1vNBFRzOG7sgEsXdteosCW/pIzHutAf0YxybYIvEe0/cX1LDDvc3g36p/eY1iIA4azaNkcYx7SyQgZ/7uES2FWLi22xHR9C9XA5Pn/Reh5sHDduTjW8ywUApacaKB5m/wcfMo5LQSVzy0a0ZbO2fRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLcz/cU4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLcz/cU4"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48370174e18so25952985e9.2
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 06:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772463378; x=1773068178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nCpPfc0Ycv4pcOuAd0PFWhFVB5GAd/LjaTnPf69cIoA=;
        b=CLcz/cU426vrhglzbfqz6ytaQMEIMZjp7I9lGDj++a+Rn8oafROGa8KgiKZlZUvgL3
         q3lEnc9bo8l4fbTwKcdrpvs2JvUhILxOCY1hRRnSP5UEyewFKk8l0TcgZVDl75cdLUwR
         6CCUvysc2IKFgKa2IXk1BPHjOba5QeDWwJrn628zXcjvId9kicc0QMnYvAjPCJDw32XI
         Mv9fbek7bB2MBMwfDJCBiVXx+8lCdFv9XC67yf0s3skA7QGm192BLnfOVby1A/nuRVRT
         uf52ELSRuDOiuccBVbUGr4IiDWKynDXkXoXH2psqgPNwhOpjoP06Nr7i4ZspM2P0rejk
         2Uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772463378; x=1773068178;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCpPfc0Ycv4pcOuAd0PFWhFVB5GAd/LjaTnPf69cIoA=;
        b=mKY+iI9XjAzj4biJkz+wzZokpKXXQFODJbszN2C1HDYGUJPZjmniw61Yyimk+FXyBx
         ozgMbkY3n4lZbykx7aW58CX+7UVyiU+0CswZq9O339ezcHdgQwrv+0Z0uzY/+WTDQ5Nw
         tZ1WEu1v74GY5+Q3EevptlqPCz/fm8FEJevWgobiRLSl23QrJVJ2yCwsx6ne+5PhDwK9
         Z6UzXKf3Iqxl34o6Ota3XHvH0EMxvcYiWDmTVmRU67Ji53K56hYmkCrPqUf/FZNmefbv
         r8+ZGer22qrcmeHvQB4+aiXE40iM0Q7xTxRivfkf1sxwIK0Ti2ktd6C5FE33BvFaR/qY
         pt9A==
X-Forwarded-Encrypted: i=1; AJvYcCXPgwdrHs22OFuEBglXnmC1LOR/JvIR9Y+WPqOYmrjASNGT1gpV+BbZQQjKGvA8aLLgLu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk/dEt479i0K0Tx4HqzqZ1oLJrkQ/EphgZcdNkDhlaBktw/mWh
	UAbfy8K849kkMKTxOK/vxZtickTJepTduV3vq0aqnY/7MiVYNbZHaHZz
X-Gm-Gg: ATEYQzy1875On7xzTRsVima1AYydQNvhXc7ieJfSXptetkAPQQhjiVZUEqZ8TnNhTXq
	i/amhp8iHPl4WVsD59TuRFJSaV9u41FqDIFsJyhUrsx2slX0ncKWTSkHqF+sfU5Ro9qrWahHQLf
	MiRhoDL7cf2pY8kD2MVnJStKXamWrX7LAECYZJ7EaJtZ7xw6hQU+DBCYFGB5oP648fo5S705fLB
	tO23d5aW31X5vyMRLPMMrrig+lJgiNsbEnBHXyZl80uqIUKvBDtcBhllhVlZRkfXNX4WpNPrs+F
	5vA9i/9NF7RdkSg5+MxiQND7ZR43VP2l2LegWto8m57KYnF0YN6NuC0vLU3l2AyfdIOHJgjNK6h
	UrhWHdkujYVC+Wni328yvnvIZWSw1oPf1aRi2I0+A/beNfsnNgd4mFEWVxS1h7oPulZiekQle9h
	oqUphQ+XOd8XrkSfe+ZMbB7vt/IDLgMq1GFxh8aV5mTZn22OAkM1AtuQW3fk8/Z3rBQjVp2pe98
	ZVbAQ==
X-Received: by 2002:a05:600c:a085:b0:483:badb:618f with SMTP id 5b1f17b1804b1-483c9bc5b7dmr210570565e9.25.1772463378118;
        Mon, 02 Mar 2026 06:56:18 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7031f3sm371171105e9.6.2026.03.02.06.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 06:56:17 -0800 (PST)
Message-ID: <db8eda43-5b2b-41eb-91bf-1b5b4da817de@gmail.com>
Date: Mon, 2 Mar 2026 14:56:15 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 2/5] trailer: move process_trailers to trailer.h
To: Li Chen <me@linux.beauty>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20260224070552.148591-1-me@linux.beauty>
 <20260224070552.148591-3-me@linux.beauty>
Content-Language: en-US
In-Reply-To: <20260224070552.148591-3-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/02/2026 07:05, Li Chen wrote:
> Move process_trailers() from builtin/interpret-trailers.c into trailer.c
> and expose it via trailer.h.
> 
> This lets other call sites reuse the same trailer rewriting logic.

This looks good, thanks

Phillip

> Signed-off-by: Li Chen <me@linux.beauty>
> ---
> v7:
> Rename the input parameter from sb to input.
> 
>   builtin/interpret-trailers.c | 36 ------------------------------------
>   trailer.c                    | 36 ++++++++++++++++++++++++++++++++++++
>   trailer.h                    |  3 +++
>   3 files changed, 39 insertions(+), 36 deletions(-)
> 
> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> index 69f9d67ec0..1354109e0f 100644
> --- a/builtin/interpret-trailers.c
> +++ b/builtin/interpret-trailers.c
> @@ -136,42 +136,6 @@ static void read_input_file(struct strbuf *sb, const char *file)
>   	strbuf_complete_line(sb);
>   }
>   
> -static void process_trailers(const struct process_trailer_options *opts,
> -			     struct list_head *new_trailer_head,
> -			     struct strbuf *input, struct strbuf *out)
> -{
> -	LIST_HEAD(head);
> -	struct trailer_block *trailer_block;
> -
> -	trailer_block = parse_trailers(opts, input->buf, &head);
> -
> -	/* Print the lines before the trailer block */
> -	if (!opts->only_trailers)
> -		strbuf_add(out, input->buf, trailer_block_start(trailer_block));
> -
> -	if (!opts->only_trailers && !blank_line_before_trailer_block(trailer_block))
> -		strbuf_addch(out, '\n');
> -
> -	if (!opts->only_input) {
> -		LIST_HEAD(config_head);
> -		LIST_HEAD(arg_head);
> -		parse_trailers_from_config(&config_head);
> -		parse_trailers_from_command_line_args(&arg_head, new_trailer_head);
> -		list_splice(&config_head, &arg_head);
> -		process_trailers_lists(&head, &arg_head);
> -	}
> -
> -	/* Print trailer block. */
> -	format_trailers(opts, &head, out);
> -	free_trailers(&head);
> -
> -	/* Print the lines after the trailer block as is. */
> -	if (!opts->only_trailers)
> -		strbuf_add(out, input->buf + trailer_block_end(trailer_block),
> -			   input->len - trailer_block_end(trailer_block));
> -	trailer_block_release(trailer_block);
> -}
> -
>   static void interpret_trailers(const struct process_trailer_options *opts,
>   			       struct list_head *new_trailer_head,
>   			       const char *file)
> diff --git a/trailer.c b/trailer.c
> index 911a81ed99..0c9200506d 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -1235,3 +1235,39 @@ int amend_file_with_trailers(const char *path, const struct strvec *trailer_args
>   	strvec_pushv(&run_trailer.args, trailer_args->v);
>   	return run_command(&run_trailer);
>   }
> +
> +void process_trailers(const struct process_trailer_options *opts,
> +		      struct list_head *new_trailer_head,
> +		      struct strbuf *input, struct strbuf *out)
> +{
> +	LIST_HEAD(head);
> +	struct trailer_block *trailer_block;
> +
> +	trailer_block = parse_trailers(opts, input->buf, &head);
> +
> +	/* Print the lines before the trailer block */
> +	if (!opts->only_trailers)
> +		strbuf_add(out, input->buf, trailer_block_start(trailer_block));
> +
> +	if (!opts->only_trailers && !blank_line_before_trailer_block(trailer_block))
> +		strbuf_addch(out, '\n');
> +
> +	if (!opts->only_input) {
> +		LIST_HEAD(config_head);
> +		LIST_HEAD(arg_head);
> +		parse_trailers_from_config(&config_head);
> +		parse_trailers_from_command_line_args(&arg_head, new_trailer_head);
> +		list_splice(&config_head, &arg_head);
> +		process_trailers_lists(&head, &arg_head);
> +	}
> +
> +	/* Print trailer block. */
> +	format_trailers(opts, &head, out);
> +	free_trailers(&head);
> +
> +	/* Print the lines after the trailer block as is. */
> +	if (!opts->only_trailers)
> +		strbuf_add(out, input->buf + trailer_block_end(trailer_block),
> +			   input->len - trailer_block_end(trailer_block));
> +	trailer_block_release(trailer_block);
> +}
> diff --git a/trailer.h b/trailer.h
> index 4740549586..531fa1a13f 100644
> --- a/trailer.h
> +++ b/trailer.h
> @@ -202,4 +202,7 @@ void trailer_iterator_release(struct trailer_iterator *iter);
>    */
>   int amend_file_with_trailers(const char *path, const struct strvec *trailer_args);
>   
> +void process_trailers(const struct process_trailer_options *opts,
> +		      struct list_head *new_trailer_head,
> +		      struct strbuf *input, struct strbuf *out);
>   #endif /* TRAILER_H */

