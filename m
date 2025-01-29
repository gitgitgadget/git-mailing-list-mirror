Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216131DF975
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169510; cv=none; b=l62Qusn44/49SzHA1JBaCuNuXQSdfE5+LyNSDncVCNJxPIPv5/CFtA/eemM30yqutcRwHZVtr0au1cOoSrHY1TyQ6QFuZwpQ8ljwZ9dnyErm5DnpFoYy6TR2gqNfK2ZcBLyQmDSfMxGsR/RCo86ykTBaIylvnGDqrLXViVmz3JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169510; c=relaxed/simple;
	bh=L0EuA6dDcRTlmq4NuWFUGLa2FbBSUy20c1NMOGb89Mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPOG8j/SUYUiuBNfkv09Yd87qaLoqVj03ce+23RukCu5esCvk3vzlbzBbwWpl6d1WJCJ2Z/3ZvGaYi2V5B5As25FLzhYpRP+rf+p7ATXke87KmadzZelripVRecg/GUs1j3x4mJesWxGjUpW4NObHVu0gV/VM1bcvFnIkS5uhE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgWR0ddQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgWR0ddQ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso49121305e9.0
        for <git@vger.kernel.org>; Wed, 29 Jan 2025 08:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738169506; x=1738774306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=70YoucDq1szVoO4mPVKnkuFYUi8Z4FzOXEcL3LlSM9M=;
        b=cgWR0ddQeRIeUdZr9pm4BVUVQ6B7cFHKG0ieMTuFq3x7vmIECPzSxmkfAdr4CpBWSu
         YFdBNDEp2bqUsPy+owZ9cGx0BGb1ny7MMl+JjT1RpC+Vif4Nk96snzbcrq2QbbMYTKT4
         oRTRmOU0j1o4hDEKzZ8ehrKvfC11rNt3Nh6Zno1BSHxA+g8Uy+Sl5V4KwgxW6vrKt9ll
         lrWR9gPDKXLlR++V4dS4IOzwIm42HLjhFdcKYHGIMX9+3Ef6JxMcPcRe1XZEQH5cgPBn
         U7rZKfWS6iY2DH3XRLFau7HwmNOzqZwGb0NpKegbRLM3JRc/eHzJzKUA2y/7whBjZLwT
         oDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738169506; x=1738774306;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=70YoucDq1szVoO4mPVKnkuFYUi8Z4FzOXEcL3LlSM9M=;
        b=LdlbGeKZtmsDvfbcwrfWkYpfCdYNEI2l2cwxEhzl/GXH/OCtV0vugPgEf2jQZSSzp8
         2wdtBi2xZ9bRuXAMsCWoyVY3cnXVBFds0vO8aQ/c80KkGgKITtXTs+sEf2K5lMY2mRkM
         sguY3tYsNHQe2uuYY6LfpQ93G38lPrw+fwdYj8c1FlQmRJ71DOR2XDJS54FEnmRVoJdl
         RgcbaSBmCltVjIajdFLLJvwcRKTjYYEh4AgRgW1UKT17x4BfWpgEF3Q9O6SWxMJjEJv2
         pvB3Z97anQTNK02JGEK3njG67GM0oOtlq1v/+Hbkqk57NZn3rjHs0ngaXinQIbiqGU7S
         /AcA==
X-Forwarded-Encrypted: i=1; AJvYcCXVCBEyYmHVCwYNR+JIuI9EQz/6Kbw1FKcTCJlQKdRPCfYsdD7PiAcj7n/aA44JtHMcvB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhvGSPhG+DpOBZBSlaqi7GvEiHfSTP1gy4iIs0z/1w51nYoPbc
	W9wUX7n08wFnro6hD9KRPlfiHzOEQo/T6nzjbOowc1BIx/NTqbOO
X-Gm-Gg: ASbGncsLqZ1Rut//wRe+cikrSU0sQQb+S2H2yaJCoW5s1PZC7W0fGhkjTuJJu1eTcRw
	PYNXlVIzSTJ1VXk0LzPq6bsR7qpWWqMHCwavPmk/dm3Lf35aIZiXqtrWykzRweS6ci5AEjEQ+/N
	XwPwOWnI4VCeakK3xfe2UpX4rXR4mOZvQcz6ZHqwlL4DdN/7mhqUrCx+1EHoTPAwFxTVVGtdp45
	4t5NxJMcBRTGeBguTlF2W2Iy5As+qgINeOG1VJvNortOc554TAjOS9Bmpr06GZzkoI+ZYjzEIdT
	MLjQWyKiZjFxNzmrwxvZDnJu/tFvAVl3YPIBINkEbi3Y4b1XOR1AK5umVZo8IR41BqTpPg==
X-Google-Smtp-Source: AGHT+IFgvxZ/y4BXZnB+emym/8474SEsC0yt97xvmHmJuH2i0+e4kDUAI/qLvSaOwtxbLR2Q/YHisA==
X-Received: by 2002:a05:600c:3b98:b0:434:a4fe:cd71 with SMTP id 5b1f17b1804b1-438dc3be214mr35531505e9.12.1738169505904;
        Wed, 29 Jan 2025 08:51:45 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc1315esm28107745e9.6.2025.01.29.08.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 08:51:45 -0800 (PST)
Message-ID: <6a251603-25bc-415d-ab8c-ae698bd7977a@gmail.com>
Date: Wed, 29 Jan 2025 16:51:42 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/4] add-patch: Fix type conversion warnings from msvc
To: CAPig+cQ49Hdc_8=mRhhJDTny_Kqo6Wg6Nr98rsBN_YXmBrQ6kA@mail.gmail.com,
 git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, sunshine@sunshineco.com,
 =?UTF-8?Q?S=C3=B6ren_Krecker?= <soekkle@freenet.de>
References: <20250126125638.3089-1-soekkle@freenet.de>
 <20250126125638.3089-2-soekkle@freenet.de>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20250126125638.3089-2-soekkle@freenet.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sören

On 26/01/2025 12:56, Sören Krecker wrote:
> Fix some compiler warnings from msvc in add-patch.c for value truncation
> form 64 bit to 32 bit integers. Change unsigned long to size_t for
> correct variable size on linux and windows.

I'm afraid I'm still not convinced this is a good idea for the reasons I 
explained previously [1] together with an alternative approach to 
silencing these warnings. What makes "unsigned long" an incorrect choice 
when that's what "git diff" and "git apply" use?

[1] 
https://lore.kernel.org/git/e396131c-1bd3-46d0-bae6-cd97ca9710d8@gmail.com

> Add macro str_to_size_t for converting a string to size_t.
> Test if convertion fails with over or underflow.

That is welcome, but the implementation needs tweaking. If you look at 
other uses of strtoul() in our code you'll see that (somewhat unusually) 
one needs to set errno to zero before calling strtoul() as one cannot 
tell from the return value whether there was an error or not. As errno 
may have been set by a previous function call it needs to be cleared 
before calling strtoul() so we can be sure the error came from strtoul().

Best Wishes

Phillip

> Signed-off-by: Sören Krecker <soekkle@freenet.de>
> ---
>   add-patch.c       | 53 +++++++++++++++++++++++++++--------------------
>   gettext.h         |  2 +-
>   git-compat-util.h |  7 +++++++
>   3 files changed, 39 insertions(+), 23 deletions(-)
> 
> diff --git a/add-patch.c b/add-patch.c
> index 95c67d8c80..4fb6ae2c4b 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -242,7 +242,7 @@ static struct patch_mode patch_mode_worktree_nothead = {
>   };
>   
>   struct hunk_header {
> -	unsigned long old_offset, old_count, new_offset, new_count;
> +	size_t old_offset, old_count, new_offset, new_count;
>   	/*
>   	 * Start/end offsets to the extra text after the second `@@` in the
>   	 * hunk header, e.g. the function signature. This is expected to
> @@ -322,11 +322,12 @@ static void setup_child_process(struct add_p_state *s,
>   }
>   
>   static int parse_range(const char **p,
> -		       unsigned long *offset, unsigned long *count)
> +		       size_t *offset, size_t *count)
>   {
>   	char *pend;
> -
> -	*offset = strtoul(*p, &pend, 10);
> +	*offset = str_to_size_t(*p, &pend, 10);
> +	if (errno == ERANGE)
> +		return error(_("Number is too large for this field"));
>   	if (pend == *p)
>   		return -1;
>   	if (*pend != ',') {
> @@ -334,7 +335,9 @@ static int parse_range(const char **p,
>   		*p = pend;
>   		return 0;
>   	}
> -	*count = strtoul(pend + 1, (char **)p, 10);
> +	*count = str_to_size_t(pend + 1, (char **)p, 10);
> +	if (errno == ERANGE)
> +		return error(_("Number is too large for this field"));
>   	return *p == pend + 1 ? -1 : 0;
>   }
>   
> @@ -673,8 +676,8 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
>   		 */
>   		const char *p;
>   		size_t len;
> -		unsigned long old_offset = header->old_offset;
> -		unsigned long new_offset = header->new_offset;
> +		size_t old_offset = header->old_offset;
> +		size_t new_offset = header->new_offset;
>   
>   		if (!colored) {
>   			p = s->plain.buf + header->extra_start;
> @@ -700,12 +703,14 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
>   		else
>   			new_offset += delta;
>   
> -		strbuf_addf(out, "@@ -%lu", old_offset);
> +		strbuf_addf(out, "@@ -%" PRIuMAX, (uintmax_t)old_offset);
>   		if (header->old_count != 1)
> -			strbuf_addf(out, ",%lu", header->old_count);
> -		strbuf_addf(out, " +%lu", new_offset);
> +			strbuf_addf(out, ",%" PRIuMAX,
> +				    (uintmax_t)header->old_count);
> +		strbuf_addf(out, " +%" PRIuMAX, (uintmax_t)new_offset);
>   		if (header->new_count != 1)
> -			strbuf_addf(out, ",%lu", header->new_count);
> +			strbuf_addf(out, ",%" PRIuMAX,
> +				    (uintmax_t)header->new_count);
>   		strbuf_addstr(out, " @@");
>   
>   		if (len)
> @@ -1066,11 +1071,13 @@ static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
>   
>   	/* last hunk simply gets the rest */
>   	if (header->old_offset != remaining.old_offset)
> -		BUG("miscounted old_offset: %lu != %lu",
> -		    header->old_offset, remaining.old_offset);
> +		BUG("miscounted old_offset: %"PRIuMAX" != %"PRIuMAX,
> +		    (uintmax_t)header->old_offset,
> +		    (uintmax_t)remaining.old_offset);
>   	if (header->new_offset != remaining.new_offset)
> -		BUG("miscounted new_offset: %lu != %lu",
> -		    header->new_offset, remaining.new_offset);
> +		BUG("miscounted new_offset: %"PRIuMAX" != %"PRIuMAX,
> +		    (uintmax_t)header->new_offset,
> +		    (uintmax_t)remaining.new_offset);
>   	header->old_count = remaining.old_count;
>   	header->new_count = remaining.new_count;
>   	hunk->end = end;
> @@ -1354,9 +1361,10 @@ static void summarize_hunk(struct add_p_state *s, struct hunk *hunk,
>   	struct strbuf *plain = &s->plain;
>   	size_t len = out->len, i;
>   
> -	strbuf_addf(out, " -%lu,%lu +%lu,%lu ",
> -		    header->old_offset, header->old_count,
> -		    header->new_offset, header->new_count);
> +	strbuf_addf(out,
> +		    " -%"PRIuMAX",%"PRIuMAX" +%"PRIuMAX",%"PRIuMAX" ",
> +		    (uintmax_t)header->old_offset, (uintmax_t)header->old_count,
> +		    (uintmax_t)header->new_offset, (uintmax_t)header->new_count);
>   	if (out->len - len < SUMMARY_HEADER_WIDTH)
>   		strbuf_addchars(out, ' ',
>   				SUMMARY_HEADER_WIDTH + len - out->len);
> @@ -1625,10 +1633,11 @@ static int patch_update_file(struct add_p_state *s,
>   			else if (0 < response && response <= file_diff->hunk_nr)
>   				hunk_index = response - 1;
>   			else
> -				err(s, Q_("Sorry, only %d hunk available.",
> -					  "Sorry, only %d hunks available.",
> -					  file_diff->hunk_nr),
> -				    (int)file_diff->hunk_nr);
> +				err(s,
> +				    Q_("Sorry, only %"PRIuMAX" hunk available.",
> +				       "Sorry, only %"PRIuMAX" hunks available.",
> +				       (uintmax_t)file_diff->hunk_nr),
> +				    (uintmax_t)file_diff->hunk_nr);
>   		} else if (s->answer.buf[0] == '/') {
>   			regex_t regex;
>   			int ret;
> diff --git a/gettext.h b/gettext.h
> index 484cafa562..d36f5a7ade 100644
> --- a/gettext.h
> +++ b/gettext.h
> @@ -53,7 +53,7 @@ static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
>   }
>   
>   static inline FORMAT_PRESERVING(1) FORMAT_PRESERVING(2)
> -const char *Q_(const char *msgid, const char *plu, unsigned long n)
> +const char *Q_(const char *msgid, const char *plu, size_t n)
>   {
>   	if (!git_gettext_enabled)
>   		return n == 1 ? msgid : plu;
> diff --git a/git-compat-util.h b/git-compat-util.h
> index e283c46c6f..bb9a6c2bc4 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -292,6 +292,13 @@ static inline int _have_unix_sockets(void)
>   #include <sys/sysctl.h>
>   #endif
>   
> +#if SIZE_MAX == ULONG_MAX
> +#define str_to_size_t strtoul
> +#else
> +#define str_to_size_t strtoull
> +#endif
> +
> +
>   /* Used by compat/win32/path-utils.h, and more */
>   static inline int is_xplatform_dir_sep(int c)
>   {

