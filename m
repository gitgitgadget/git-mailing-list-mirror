Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D25215746E
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969523; cv=none; b=crv8Ds7nhZQuSR9FFHTEQeqwqpzKJAdnY2xWqw2f6xNgHhrLcUME9QncL0fofWyPvPEbsaawKAip9SYuxY+8m6513kczOcQYbPAHNc6J5TutTqVFtnWECQgilxMXSGd461dOK/QjiIsaBwEuZGi6tbp29maptER88qq/L0iDhIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969523; c=relaxed/simple;
	bh=WdIFpBI32nOEndM44pr2+LPOJlhtkXXGEeDjk/1b5iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/pvSNGkNS3yr/dIXby/M7hU6/gf3i3+S2rZpu2BhcjTzX5FMfTaQrB4dZo4y0IlU9o23AlhlWB1xKkwtQAKIBsesbp+NX9ugChgKBwdKVKUAyfneLU2WM0VTECoo70GPYZdAMdGHFRT+GUSZiTviieV6LXIyPIHM7rfwQ1QT40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpN4P4i5; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpN4P4i5"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a54700a46eso2191816f8f.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 03:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751969520; x=1752574320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EkJfKkbYpQEUHS2NwuGR7bkV7c8hGOiSosKy3DzMYS4=;
        b=lpN4P4i5HJVYVvS1Aozl9ke/hJVNdlQrsl7Lnm+Hu4UKpTnpXBf0X0MvIOSnvGRf1+
         mgQ4aTr2vD+9TgdmQd8zyz2nkT8S3DhXXDKGAlnJPrrGWSEL9TgEcx8+1wSXQ9dE2VVW
         NyhD/WK1XBbxWYYW5a4SOLjKK/Yl5T0OpymAR5fdWiWHViFcBGVl2yFTrjZFUSNB4ac4
         8bFjqa2QmoCy+ka4xA3uEwD2sdykQj7JAoBb5TkDFkF7SyV3kIqDTU69KEzESGly2th7
         T+KA/qCiT7W7U/2aPbEk5eJ5YS8mXqXifpiPUo4KLc9vz6qEugCYw3d9zs/2NhK2g2br
         5AyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751969520; x=1752574320;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EkJfKkbYpQEUHS2NwuGR7bkV7c8hGOiSosKy3DzMYS4=;
        b=Ae9jp5l94V3Mi9IEXTZ/OwXAiY6h1mq0QLl0RAj9ZPkhhewwLyOkVxlQhcZi+1n5RZ
         mKySI4Zwqrc6gl/JKD7v/8bDGQD390S401hOdqmEGcSXr8TChRj8An8IBIgzJsLUJAlP
         5S3N8V17S5aKnqgnyrsVONxyvdSAqVHpEM+CPJYdQhjszxZW0+ebXvEiZe0hIDVa1TSd
         Wz1Z1LUA2Ld/HsnjZ2ME6nPg12uyRYTm5T2siHQtGyWeAXZrYvooklu9N1FhTp/tNH9s
         v63C1AU1mFpUPLXqdSPfJFeuBccoJkzICKh2MHwbkMNJxv72uAOcCyPlX8BRLNWux3DJ
         Hsrg==
X-Forwarded-Encrypted: i=1; AJvYcCXQScCxZrhSUW8Jd8VM291WaV8aIA0JQJuVtWjMRSC0B5TavdeT+SZk6lO8paidXNrEaR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvNxLxfA4WXtXxJuLjeqZqEWYjAiWhSTkc9W2ribgLp12crHrU
	XKDPDhEYptct0P3Tg1fQG2ClevdhPnFe176EiZKi2CHA4o/KvD17lLV3
X-Gm-Gg: ASbGncsRFIAJ47IZ3zD8f/IyVGcztWttxZXwypLdBDJ08FyTakTI0lH24F0xtUtzSys
	QBXuUmjONznJOo7RT209Qc4HHRYWhpw2TAFJFTumNDQr56u4Dir6SISskvsyyEkIMCArb/lcsRI
	MroU2oIRD7tiVSZmx1L2e87USrjLkoqXJpvnSWNsuwX8vlNj4zm2tTC+6HmIoLPyRK45/yEY6ZA
	oHZ+9WBV9Yn9RfVZZGelMKrT4HOUelES0w6kIuv6xjeDPCHsazqlaXSEYau+OtuLOukzOVmHvJH
	Mjbp8J3mwJb2+yx3gkNgJqgc1VRby0Vpa3vkTd5kFT++CfRZgDm0a2sAkr3DGKyd+K6ZzcYgVZi
	NH7UAm/+2FYlL9FXx9H3NnJhpxZfUYkEWIlovdrF0xrtL7NE=
X-Google-Smtp-Source: AGHT+IGhxzBuqw9CIzdwCwA0oia3fSgI/A8XxFxZaxa0tft6xaWY6w9Y6CGceqgXrntiuLmXdAUn7Q==
X-Received: by 2002:a05:6000:4304:b0:3a4:ee40:715c with SMTP id ffacd0b85a97d-3b5dde94faemr1842730f8f.14.1751969520243;
        Tue, 08 Jul 2025 03:12:00 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:414b:41bc:10fc:30d3? ([2a0a:ef40:700:a501:414b:41bc:10fc:30d3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3dd150sm17702125e9.40.2025.07.08.03.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 03:11:59 -0700 (PDT)
Message-ID: <c1f871ec-96a0-4dbc-b84b-4add36bec682@gmail.com>
Date: Tue, 8 Jul 2025 11:11:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC RFC PATCH v3 0/5] repo-info: add new command for retrieving
 repository info
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, karthik.188@gmail.com, ben.knoble@gmail.com,
 gitster@pobox.com, phillip.wood@dunelm.org.uk
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250706231938.16113-1-lucasseikioshiro@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20250706231938.16113-1-lucasseikioshiro@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lucas

On 07/07/2025 00:19, Lucas Seiki Oshiro wrote:
> Hi!
> 
> This is the third version of the patchset introducing the new Git command
> called `repo-info`, which will return repository information currently stored
> under git-rev-parse using machine-readable formats.
> The main changes since v2 are:
> 
> - Documentation for git-repo-info has been added.
> - The `--allow-empty` flag was removed. In this version, repo-info no longer
>    returns a default set of data when called without parameters. However, an
>    `--all` flag is planned for a future version.
> - The `plaintext` format was replaced by a null-terminated format, following
>    the syntax of `git config --list -z`.

These all look like good changes. Looking through this series I do think 
that it would be more readable and maintainable if you adopted the table 
drive approach suggested by Junio. That way we would avoid the nested 
switch statements and each piece of information only needs to be 
retrieved once rather that having to retrieve it separately for the JSON 
and plaintext output. Below is a sketch of might look. Each key is 
handled by a callback and we have a table that maps key names to 
callbacks. For the json output we use one json writer per category to 
build output for each category.

Best Wishes

Phillip


enum format {
	FORMAT_JSON,
	FORMAT_PLAINTEXT,
};

enum category {
	CATEGORY_LAYOUT,
};

static const char *category_name[] = {
	[CATEGORY_LAYOUT] = "layout",
}

struct context {
	struct json_writer *writer[ARRAY_SIZE(category_name)];
	enum format format;
};

static struct ensure_writer(struct context ctx, enum category cat)
{
	struct json_writer *writer = ctx.writer[cat];

	if (!writer) {
		writer = xmalloc(sizeof(*writer));

		jw_init(writer);
		jw_object_begin(writer, 1);
		ctx->writer[cat] = writer;
	}

	return writer;
}

static void handle_layout_bare(struct context ctx)
{
	int bare = ...;
	
	if (ctx->format == FORMAT_JSON) {
		struct json_writer *writer =
			ensure_writer(ctx, CATEGORY_LAYOUT);

		jw_object_bool(writer, "layout.bare", bare);
	} else {
		printf("%s\n%s\c", "layout.bare", bare ? "true", "false", '\0');
	}
}

static int cmd_repo_info(int argc, const char **argv, sturct repo *r)
{
	struct context = { 0 };
	struct {
		const char *key;
		void (*cb)(struct *ctx);
	} handler = {
		{ "layout.bare", handle_layout_bare, },
	};

	/* parse options */

	for (int i = 0; i < argc; i++) {
		/* TODO use bsearch()? */
		for (size_t j = 0; j < ARRAY_SIZE(handler); j++) {
			if (!strcmp(argv[i], handler[j].key) {
				handler[j].cb(&ctx);
				break;
			}
		}
	}

	if (ctx->format == JSON) {
		struct json_writer writer = JSON_WRITER_INIT;
		jw_object_begin(&writer, 1);
		for (size_t i = 0; i < ARRAY_SIZE(category); i++) {
			if (ctx.writer[i]) {
				jw_object_end(ctx.writer[i]);
				jw_object_sub_obj(&writer,
						  category_name[i],
						  ctx.writer[i]);
			}
		}
		jw_object_end(&writer);
		fputs(writer.buf.buf);
	}

	context_release(&ctx);
	
	return 0;
}

