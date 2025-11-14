Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7283446D7
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763142639; cv=none; b=PhlJIeeyLNeCjpPcPb6KOXipHcFYzpJE42xhD67/LIdZ+K4HnWi+6UXCs+IJmiQPIi7uVK4e5eAkHcab05lefMOKjWehUD8E58nwKlNUXVc/l7tWLyVtdPsVq5v/Uv/FWnL8pi05zYsYigkIYoAENmddpscV3bU8x0SvTvwtSqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763142639; c=relaxed/simple;
	bh=ged6xsWV4XAzLPbwbRSywxDUWnC9/D/jkp4PQQJ754A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOhfOzp7yY78VL8uV3eyToWkvzzE/ASXbLZUiu9F0PnIiqXui7QCIjhCiFmq/VbC2zE/CNIbZA9qDuv9G74NNzfu3edvdsnMM0BNE+5T/Rk8BHkrhJWCTIuBzGB1rb/8XRswWzA2dpgfPhctPGqTy/4ksjamNDMUEpr28qTDWUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6x3YCju; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6x3YCju"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c6da5e3353so1768606a34.3
        for <git@vger.kernel.org>; Fri, 14 Nov 2025 09:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763142636; x=1763747436; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=58MqYTunZkNzGpn4qdNNACBxYN7GU7l4uoD65lj6+W0=;
        b=d6x3YCju8zVtagXpbHjFIV625S+7ibLmbgbjXsyt8Z0bvaHGDX36RYQDJJxMgjmdoR
         2ufozqK6BJAmRTtC9XMGOo5/77lk+rDHj8b+SWzQUkZE7k/ETLu9Vm6hTCPRnJj2xGeF
         P+BDGtmObqURCUlYBQxFigctDGbWCYhlgg2r+SV9FeVPFTrHRPRA9riHRL+3rhLKv0xJ
         jrcnJbc0Jqmx2AZkJZuKIRs+ybALAsGOTScUXkppLA7vezwjL8gM9HTLSCydE6JInEjb
         HbzFH4tdufEQ0MsmUhMCVvkAz1OzwmirZkk1FaX4M5VPxiBmMdvhnVYCoy1Cp5hcN0G1
         4Lag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763142636; x=1763747436;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58MqYTunZkNzGpn4qdNNACBxYN7GU7l4uoD65lj6+W0=;
        b=THaXik5iIgfia7sugd4g+wK81tHKimeQnB/p5bwvLRGo6vQjPrx9SnKgycfEYQAcyc
         BKJWogvq3vZ6Z1MW2H+KAxCWsuwKWfLYfLhzvvhGmF6K37kYbYxP/FWdsTj5rtUYjwIU
         yjvWncLJtrCT7iWaUl8wl5E9P+B2WTi3aBcg82MojP5Ta14PBE7c2Ex9/8CMwDIZ5A+u
         8EBDoo+SdTd1ctzeAxzZecm2d/x21eZIFszc0ErERMWRco3NKKF9+y29FFuCXuMFalVx
         PM2iNVGAHki7ZK7lQdizYp3o31lETpz0smh0Xa/FcBWTkh2GQCqUbjmgYfTErLiQEEVN
         i7xw==
X-Forwarded-Encrypted: i=1; AJvYcCXoaoH/Pps5VUql3U/zpRgCelrCV3VK+gOJ8eNCgIdFMyq5Q8L/efHfjoRG0M9zXAXcZKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnLydzPGilm1v8a1gXoMONqCe/FEUduJt1jqbvakLcxoG0SBcQ
	evHnaqCLd1SCFjFZaIJrmXuIhz1QAFsV2ED49DjMVxQGl7CVod17Pn7K
X-Gm-Gg: ASbGncsV32v0dYYm+MPa2p9oaihP+9EiNGScTuMZU6RvCMS2buflyx9F4lIlLDgZ3ZB
	+8cdGpk9XltK7keAebj8B580IHDlahVZVQdcyKTWyDi3L5f4qfmAzWXo3jH0gDA+okBFoYlQu+u
	cF3Tzmqc44+AgaA5O0bpxn+ZGoTrxRLoQSHF2MQTl3WWf/NGXRnseQuFXkGzmXcC4J8c6gkIYD3
	LyMDBcX2AKZ7C6kI7nQYFbjQXas9ZR7W0HMeMR0f1YkGRxC3bBk7JaUoLE1XwyILM7tPx9xF3zA
	BeXaHgXsGz8n4DojaKMXXJgezkw7HWwgnq0JSMANRse60cWD9NGdLekmejilBrwXgqeOwH8xgQX
	oKAJxXk0qw/SOAR32y4/plaVJ8Y81+jY39c/45v8mHlUEJ0QyC/vrnMECYdMuNJzX/PHR6D49Ns
	zV1+NKvd++6rwfehs=
X-Google-Smtp-Source: AGHT+IHhfn01h288qdkBRN8ePS6mjkA16tuBfFHmy6zsKKAuN6Okx/Ct42+uRb4OEg2syXSA7tNEhw==
X-Received: by 2002:a05:6830:25d6:b0:7c6:ca92:3617 with SMTP id 46e09a7af769-7c744430d68mr2784846a34.9.1763142636429;
        Fri, 14 Nov 2025 09:50:36 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c73a3bddbasm2812485a34.27.2025.11.14.09.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 09:50:36 -0800 (PST)
Date: Fri, 14 Nov 2025 11:50:32 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>, 
	Alexander Shopov <ash@kambanaria.org>, Mikel Forcada <mikel.forcada@gmail.com>, 
	Ralf Thielow <ralf.thielow@gmail.com>, =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Dimitriy Ryazantcev <DJm00n@mail.ru>, 
	Peter Krefting <peter@softwolves.pp.se>, Emir SARI <bitigchi@me.com>, Arkadii Yakovets <ark@cho.red>, 
	=?utf-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>, Teng Long <dyroneteng@gmail.com>, 
	Yi-Jyun Pan <pan93412@gmail.com>, Gemini <noreply@developers.google.com>
Subject: Re: [PATCH 2/2] builtin/repo: fix table alignment for UTF-8
 characters
Message-ID: <wgxzx47nsro3h6ju3t2aatrygkr5g7i2dbl26fj53qh4f7jdxw@d233r7jflrke>
References: <cover.1763098804.git.worldhello.net@gmail.com>
 <a50bcde6446fbd87b4fb04b28c579a915457813a.1763098804.git.worldhello.net@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a50bcde6446fbd87b4fb04b28c579a915457813a.1763098804.git.worldhello.net@gmail.com>

On 25/11/14 12:52AM, Jiang Xin wrote:
> The output table from "git repo structure" is misaligned when displaying
> UTF-8 characters (e.g., non-ASCII glyphs). E.g.:
> 
>     | 仓库结构   | 值  |
>     | -------------- | ---- |
>     | * 引用       |      |
>     |   * 计数     |   67 |
>     |     * 分支   |    6 |
>     |     * 标签   |   30 |
>     |     * 远程   |   19 |
>     |     * 其它   |   12 |
>     |                |      |
>     | * 可达对象 |      |
>     |   * 计数     | 2217 |
>     |     * 提交   |  279 |
>     |     * 树      |  740 |
>     |     * 数据对象 | 1168 |
>     |     * 标签   |   30 |
> 
> The previous implementation used simple width formatting with printf()
> which didn't properly handle multi-byte UTF-8 characters, causing
> misaligned table columns when displaying repository structure
> information.

Thanks for finding this issue and submitting a fix! I failed to consider
the fact that the printf() format specifier width would be counting
bytes. This causes the overall line width to fall short in some
scenarios with multi-byte UTF-8 characters.

> This change modifies the stats_table_print_structure function to use
> strbuf_utf8_align() instead of basic printf width specifiers. This
> ensures proper column alignment regardless of the character encoding of
> the content being displayed.

Makes sense.

> Co-developed-by: Gemini <noreply@developers.google.com>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  builtin/repo.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 9d4749f79b..d0b4a060b1 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -292,14 +292,21 @@ static void stats_table_print_structure(const struct stats_table *table)
>  	int name_col_width = utf8_strwidth(name_col_title);
>  	int value_col_width = utf8_strwidth(value_col_title);
>  	struct string_list_item *item;
> +	struct strbuf buf = STRBUF_INIT;
>  
>  	if (table->name_col_width > name_col_width)
>  		name_col_width = table->name_col_width;
>  	if (table->value_col_width > value_col_width)
>  		value_col_width = table->value_col_width;
>  
> -	printf("| %-*s | %-*s |\n", name_col_width, name_col_title,
> -	       value_col_width, value_col_title);
> +	strbuf_addstr(&buf, "| ");
> +	strbuf_utf8_align(&buf, ALIGN_LEFT, name_col_width, name_col_title);
> +	strbuf_addstr(&buf, " | ");
> +	strbuf_utf8_align(&buf, ALIGN_LEFT, value_col_width, value_col_title);
> +	strbuf_addstr(&buf, " |");
> +	printf("%s\n", buf.buf);

Ok, using strbuf_utf8_align() compensates the line width when using
multi-byte UTF-8 characters to ensure the correct length. Looks good.

> +	strbuf_reset(&buf);

Do we need to reset the buffer here? In the following loop we reset it
at the start of each iteration.

> +
>  	printf("| ");
>  	for (int i = 0; i < name_col_width; i++)
>  		putchar('-');
> @@ -317,9 +324,16 @@ static void stats_table_print_structure(const struct stats_table *table)
>  			value = entry->value;
>  		}
>  
> -		printf("| %-*s | %*s |\n", name_col_width, item->string,
> -		       value_col_width, value);
> +		strbuf_reset(&buf);
> +		strbuf_addstr(&buf, "| ");
> +		strbuf_utf8_align(&buf, ALIGN_LEFT, name_col_width, item->string);
> +		strbuf_addstr(&buf, " | ");
> +		strbuf_utf8_align(&buf, ALIGN_RIGHT, value_col_width, value);
> +		strbuf_addstr(&buf, " |");
> +		printf("%s\n", buf.buf);

Here we do the same thing for the values column. Looks good to me.

Thanks,
-Justin
