Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29346374745
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615319; cv=none; b=dxxcXZOEB6idKZLcM27VfqlqocLC+B39VlNWPVjzc7q9JF41v2VLyg8DGYgLgdVPuFwkV3oQ7baat5yw1lVoS9pjfNmQULokOQuwHf+V1VswiPX4vwY/4wMW/M/ylL+FANBmlsUG8ChFeHCAOqYBKPlNBIimRtPY+2vL1QxAUB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615319; c=relaxed/simple;
	bh=ChR/HYAL7qwcjBXJNjMWAM5vH3UoQPheDhjg8TRwKUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLYuOcmRSAtjTzM9KaYdIoJXN7el1eSJRwZXC6i7ryta1TCZHyNVTPMSbjAxGAun/dctg9rHVnA71//i+mREV8I3J0OlU5P6YXn3xy02eE3mo66I8BBfQ03x6ZH4ofcugyYt7IalX4tIsnobQDLWxW+Vo4JH/zRcrqxAzDp2BBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/rO1OO7; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/rO1OO7"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-68bd9fce347so8225805a12.2
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 06:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781615314; x=1782220114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5C4I3q69ZyiHjTlIvTpnUuLqg5C+w/tsyWKLNyUGKfg=;
        b=j/rO1OO7+xBqcKt8R6NchaiAjsrsqrZ77MtWgKl2Y8OIjLy+go9gvXQXBjZNyH0NwV
         b8Qx4NgLqsx6Te7rssigYFjJLdc6AXoOtT/WISVup7NGtWdRAdhmwqhOXGUqanb6SmIi
         RF1NfpAh4PRoGSRnG/tln/onV1QGNXoScE4ggfKoSZ5f9px076PsBj5CKs8aPBNTsivn
         Gw8MDdWwIHvgMcYlBE21ac/W7ZkGWJv40JE4wtko3NOl1Dfw5dLetgqHFbYZ/77ZkV2Y
         QNZPV09zFGF4HsDW80vvhzPSHAqkK3oblfBPAL4+OgXYFtfi+TuvGw4GCat4K9wy+73m
         Dp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781615314; x=1782220114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5C4I3q69ZyiHjTlIvTpnUuLqg5C+w/tsyWKLNyUGKfg=;
        b=dqqy8KTOTKQjp4twO3E1ME6dLya93RuZi0xKr1V2Hhy4FZE0J/jQ3mhUAbiB+8/5Vt
         u5t+vC2h/q+mnNAegQ0o85Oew5L7MBfFI1r9XKdfppatFO2X3IEJ1gsSQ6yd2qyFrtln
         7ujWCMIE8S4xfEfh2CHS/5HraxUDRX0dpCfHrxMxyu0z7gwzmm4cpZivY9lbfyaYIxDM
         kUzslZqVEaj4wZylptShAQGqd9B2zg7ShUC0Z6MCYV/gr3IhdPIf5ksYUjOncfn9kGZ9
         OoKx5Xa4BHPd9b7R7xi6LxU/fPeeekV+S7dABA/5BsqG5KiZ8O9pEdzOEFHVXxUJWbXY
         iLMA==
X-Forwarded-Encrypted: i=1; AFNElJ98XJw46HUdtoooutU4O+UUjKqu2oKjfpL9GpuZKurFmfUaxp+b+dh5K1715NioorNtkoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyydaYNgn0VhWTvK7d8Awt0uhVI7sma263Pwe/Xwp3mIZ2AHuA1
	QZHw93SZ/Vzb/+iyjd+AOwGJEccfFyNDCfVEecTDRU07t4n0SHaA+oE5
X-Gm-Gg: Acq92OEy//t1nkCZHDJIYMZyVSnqsAyK1ByHNEkux2d/UAYcI/8t5IXjsZEIEoDrRxo
	d/92/fiqSPDdeYz207u+H1BvjGyjE3svZu6Wzdk1RuW4aY3KXPeZnPQK3xvzG6eqxaORHrFjoPu
	jS9Hhv34larRyORvnXR8vMbjAoV5J4gv8wvyaLBqFBOgaEk/SNNntSczAXwVZTo0ClcN37A34Fr
	kbYpuEiuyXIKfUFKVSSbL9qlJp1cd3wCBksfc8+kCma/rtzZK0l4tr1Vih60HimPfp6mKoQSdSa
	Ni14vEXgT6QhGLQUZkCyeepTQJpfQAfs5Xq7eW4zfu6cTY5KRVsnum86VkXBNoURuPtN3iLkdwc
	txH/R7mUhPUSxefvWi+9FkGiv3ARIjOl8iLcvOOTKy6oaQ5TUiq/fR9ACOtv0Sno5c6SKRzScq0
	P4IjUHNxoj/4f4vlRD3ubpDLedfNEG70a6EG0Mc96Vy7xfm9tYy75wS5TrB1ZBWUcvuzdABs5fB
	ncC0zAPFro=
X-Received: by 2002:a17:907:7615:b0:bd5:40d9:c6c9 with SMTP id a640c23a62f3a-c041381222fmr170606866b.0.1781615314031;
        Tue, 16 Jun 2026 06:08:34 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:537b:c4f5:ba6d:96c6? ([2a0a:ef40:69a:b801:537b:c4f5:ba6d:96c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb83428a8sm656473466b.44.2026.06.16.06.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 06:08:33 -0700 (PDT)
Message-ID: <c58d3b78-985e-4fce-a605-14e693ebef61@gmail.com>
Date: Tue, 16 Jun 2026 14:08:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC Patch v5 1/4] path: introduce append_formatted_path() for
 shared path formatting
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, git@vger.kernel.org
Cc: jltobler@gmail.com, lucasseikioshiro@gmail.com, gitster@pobox.com,
 phillip.wood@dunelm.org.uk, sandals@crustytoothpaste.net,
 kumarayushjha123@gmail.com, a3205153416@gmail.com
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260616044953.184806-1-jayatheerthkulkarni2005@gmail.com>
 <20260616044953.184806-2-jayatheerthkulkarni2005@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260616044953.184806-2-jayatheerthkulkarni2005@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/06/2026 05:49, K Jayatheerth wrote:
> The path-formatting logic in builtin/rev-parse.c is tightly coupled
> to that command and writes directly to stdout, making it impossible
> for other builtins to reuse.
> 
> Extract the core algorithm into append_formatted_path() in path.c
> and expose a path_format enum in path.h so that any builtin can
> format paths consistently without duplicating logic.

Sorry I haven't had time to look at this series recently, it is looking 
much nicer now that we have a single enum. It would be helpful to 
explain why we need PATH_FORMAT_DEFAULT that acts exactly like 
PATH_FORMAT_UNMODIFIED. Looking at the next patch it seems this is still 
a wart in the api due to rev-parse wanting needing to distinguish the 
unmodified case from the default case.

Thanks

Phillip

> Mentored-by: Justin Tobler <jltobler@gmail.com>
> Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>   path.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   path.h | 36 ++++++++++++++++++++++++++++++
>   2 files changed, 106 insertions(+)
> 
> diff --git a/path.c b/path.c
> index d7e17bf174..5e83e3e4f6 100644
> --- a/path.c
> +++ b/path.c
> @@ -1579,6 +1579,76 @@ char *xdg_cache_home(const char *filename)
>   	return NULL;
>   }
>   
> +void append_formatted_path(struct strbuf *dest, const char *path,
> +			   const char *prefix, enum path_format format)
> +{
> +	switch (format) {
> +	case PATH_FORMAT_DEFAULT:
> +	case PATH_FORMAT_UNMODIFIED:
> +		strbuf_addstr(dest, path);
> +		break;
> +
> +	case PATH_FORMAT_RELATIVE: {
> +		struct strbuf relative_buf = STRBUF_INIT;
> +		struct strbuf real_path = STRBUF_INIT;
> +		struct strbuf real_prefix = STRBUF_INIT;
> +		char *cwd = NULL;
> +
> +		/*
> +		 * We don't ever produce a relative path if prefix is NULL,
> +		 * so set the prefix to the current directory so that we can
> +		 * produce a relative path whenever possible.
> +		 */
> +		if (!prefix)
> +			prefix = cwd = xgetcwd();
> +
> +		if (!is_absolute_path(path)) {
> +			strbuf_realpath_forgiving(&real_path, path, 1);
> +			path = real_path.buf;
> +		}
> +		if (!is_absolute_path(prefix)) {
> +			strbuf_realpath_forgiving(&real_prefix, prefix, 1);
> +			prefix = real_prefix.buf;
> +		}
> +
> +		strbuf_addstr(dest, relative_path(path, prefix, &relative_buf));
> +
> +		strbuf_release(&relative_buf);
> +		strbuf_release(&real_path);
> +		strbuf_release(&real_prefix);
> +		free(cwd);
> +		break;
> +	}
> +
> +	case PATH_FORMAT_RELATIVE_IF_SHARED: {
> +		struct strbuf relative_buf = STRBUF_INIT;
> +
> +		/*
> +		 * If we're using RELATIVE_IF_SHARED mode, then we want an
> +		 * absolute path unless the two share a common prefix, so don't
> +		 * default the prefix to the current working directory. Doing so
> +		 * would cause a relative path to always be produced if possible.
> +		 */
> +		strbuf_addstr(dest, relative_path(path, prefix, &relative_buf));
> +		strbuf_release(&relative_buf);
> +		break;
> +	}
> +
> +	case PATH_FORMAT_CANONICAL: {
> +		struct strbuf canonical_buf = STRBUF_INIT;
> +
> +		strbuf_realpath_forgiving(&canonical_buf, path, 1);
> +		strbuf_addbuf(dest, &canonical_buf);
> +
> +		strbuf_release(&canonical_buf);
> +		break;
> +	}
> +
> +	default:
> +		BUG("unknown path_format value %d", format);
> +	}
> +}
> +
>   REPO_GIT_PATH_FUNC(squash_msg, "SQUASH_MSG")
>   REPO_GIT_PATH_FUNC(merge_msg, "MERGE_MSG")
>   REPO_GIT_PATH_FUNC(merge_rr, "MERGE_RR")
> diff --git a/path.h b/path.h
> index 0434ba5e07..6aca53b100 100644
> --- a/path.h
> +++ b/path.h
> @@ -262,6 +262,42 @@ enum scld_error safe_create_leading_directories_no_share(char *path);
>   int safe_create_file_with_leading_directories(struct repository *repo,
>   					      const char *path);
>   
> +/**
> + * The formatting strategy to apply when writing a path into a buffer.
> + */
> +enum path_format {
> +	/*
> +	 * Represents the default formatting behavior. Treated as
> +	 * PATH_FORMAT_UNMODIFIED by append_formatted_path().
> +	 */
> +	PATH_FORMAT_DEFAULT,
> +
> +	/* Output the path exactly as-is without any modifications. */
> +	PATH_FORMAT_UNMODIFIED,
> +
> +	/* Output a path relative to the provided directory prefix. */
> +	PATH_FORMAT_RELATIVE,
> +
> +	/* Output a relative path only if the path shares a root with the prefix. */
> +	PATH_FORMAT_RELATIVE_IF_SHARED,
> +
> +	/* Output a fully resolved, absolute canonical path. */
> +	PATH_FORMAT_CANONICAL
> +};
> +
> +/**
> + * Format a path according to the specified formatting strategy and append
> + * the result to the given strbuf.
> + *
> + * `dest`   : The string buffer to append the formatted path to.
> + * `path`   : The path string that needs to be formatted.
> + * `prefix` : The directory prefix to calculate relative offsets against.
> + * Pass NULL to default to the current working directory where applicable.
> + * `format` : The formatting behavior rule to execute.
> + */
> +void append_formatted_path(struct strbuf *dest, const char *path,
> +			   const char *prefix, enum path_format format);
> +
>   # ifdef USE_THE_REPOSITORY_VARIABLE
>   #  include "strbuf.h"
>   #  include "repository.h"

