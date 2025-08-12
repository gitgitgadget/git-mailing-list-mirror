Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C73280A56
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005349; cv=none; b=PLdk2qQKsPAlethUcH5E6tgWxWss9A6CrtM+xqBWoHFRRi4WHxlPxu6QBV/i0RARcebwA6FNJtwWq5amxC1AZ7dYzPvAnT15bq12adxuLq61QzXBntw9NdXfxYnaEBBCd56zT6yFy2v+oTuq2AzpmwadPkVKiBFKptGiMTUOiHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005349; c=relaxed/simple;
	bh=I4rFSGQfg4t9Zwx73R4Ep38KDwU60xqT+B1gc8nK2uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tq5ECeT3Rcb85vqCFZbBiTYgmCRgjwcntugZKh9jNgwi7dH3PFHf24RSHvjO02jTKWahkzovbGhdUx3oc5XhU6XnUWHTXW7+umQ1+VoGJaeTsOaG7LjHls9VpYFlJU70aooHQ8P82VoUM+sVJu7GILcwy0nHN+eYEW7ZKZpb4SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNCkpRcS; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNCkpRcS"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e849d7a28eso269089185a.3
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 06:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755005347; x=1755610147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bc80mnizuUHVXadKCbhGUOg8fZrvPkLxtNcPsqvB3wY=;
        b=fNCkpRcSijzMk8pGMRBfKGQ0A2CuRp3Se/bDDtSKznrQk5E5ORugRKNLFm0Im2J9YW
         SuomIp97Hx3qqfmpWbeElPP8oj7voH/Bu3aOxvi+gqjnJL3f/8NSZcftXJR89YtBjCtG
         76f2uYzal4YIUuOkPxE9cilexkOive2ZbDAwBOf/IZU9A4RRNw8QhWCRc+n6CPV7AQdt
         Ym8KusERdUhrxzqsSUBjnJBrhWW1sVUTB+oNRg7FOy+RH2ak+3owHuyL3/odqcOzjGsE
         TTTGAuvnbq9aF7QFn3KsBjQdVEOV/XqOPmfoUZ+UG+EFJAEZZtJ0YlFynxkHAUg8GbDN
         OIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755005347; x=1755610147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bc80mnizuUHVXadKCbhGUOg8fZrvPkLxtNcPsqvB3wY=;
        b=FW5OQVjxCXtIpozaECxBLqDWxeHzggJ/K6kisbsWsn27HJbQiuhbnRKWuLs4KLwqT+
         0OMQySKPM8RV/bUD04WMwFMGr+3NWLKsVD7FWSzJ7mvO0bDUWmXndwUWndNbSkWc8YVt
         81kFNgEBH3I231gnTR36PXZF4HF6sMw+efyGOLqkypDY0N3cztstrMReg2L3qQJUfUmB
         zZJdThaRRfC4dCY1RJbiZ/3scQn6531NoOQK7r9zaDvilW3lq6mOR3xICHDueYSTPHXm
         BWUHrwsZ9Mgj8JUrtWxUM5a4bgjrrvNHev7ywaymynxqFLs/T81bF5+K/K0oy4jymlLF
         bH3A==
X-Forwarded-Encrypted: i=1; AJvYcCWmmDaKOgSF+EdQiyjH7rb6uCIsfXhWM+J/GA8HAhquAokLgYmhwZgwPKpm2VARX+g40xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyURYLYXS82R6yPQ79XjAG0IcpiiB5MsFZK7ENIXqfnP2uoz1BX
	UD/UmPJHEI3q+SeQEfnnsX+UlrPnvJ+o6wt46VxiyUbmx9PatcQoXQPB2Jdqkw==
X-Gm-Gg: ASbGncsWPJ/tQ++4+gwp/jowWHkTcPHiVKBEli9EorQ0pXt47tt1/7KdlSXhS/F6nvw
	XMjTLYTyKaFYYwvEDBtvVX6VtNuUaukKNbxrUuVG8f6Q2K0R42hDzXU9roQDhEJVmXEsmqlAf77
	MZDcF6qEOk4n2la0BEc00nJKPvTGdn2zqkeAsGQhqvpj2EZSpNPDXddLUyARmSjkiaGw9dLSmv9
	+j9Sr1qvek9fpA5BRkXqtPPizKuhyN+5lMlEbWTsHAcE7DU3fnmf73pZlSCwbdfy1q4jnWqMvak
	oTLwfK8IhUAmVtOinYFRQLi82FWOSM6aM1SZ0e0Lp6Nd6ptqBFWN0mS5YrW+lN+ZEMN+7RLdpci
	2rOxCT2iJ96XuM5Ywsh5jga8QlWCJ77tnaMQ=
X-Google-Smtp-Source: AGHT+IEPheBSOtCfU9KB/EtVFGYmIt4Et1eIWf+VSkO7K3l3UC5zH5bYOLlCaRny+5wKEUTs7Uj7zw==
X-Received: by 2002:a05:620a:851a:b0:7e6:dc81:41d0 with SMTP id af79cd13be357-7e85882fc06mr348631285a.21.1755005346576;
        Tue, 12 Aug 2025 06:29:06 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.70.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e82a1ccbfesm830782985a.51.2025.08.12.06.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 06:29:06 -0700 (PDT)
Message-ID: <55cbc80e-2585-49dd-80e9-33f200a9fac1@gmail.com>
Date: Tue, 12 Aug 2025 09:28:43 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] abbrev: allow extending beyond 20 chars to
 disambiguate
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Jon Forrest <nobozo@gmail.com>
References: <xmqqfrdx517b.fsf@gitster.g> <xmqqzfc51xvk.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqzfc51xvk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/2025 3:06 PM, Junio C Hamano wrote:
> When you have two or more objects with object names that share more
> than half the length of the hash algorithm in use (e.g. 10 bytes for
> SHA-1 that produces 20-byte/160-bit hash), find_unique_abbrev()
> fails to show disambiguation.
> 
> To see how many leading letters of a given full object name is
> sufficiently unambiguous, the algorithm starts from a initial
> length, guessed based on the estimated number of objects in the
> repository, and see if another object that shares the prefix, and
> keeps extending the abbreviation.  The loop stops at GIT_MAX_RAWSZ,
> which is counted as the number of bytes, since 5b20ace6 (sha1_name:
> unroll len loop in find_unique_abbrev_r(), 2017-10-08);

Wow. My first Git contribution.

Some style issues that you're opportunistically cleaning up are
due to my newness, for sure.

> before that
> change, it extended up to GIT_SHA1_HEXSZ, which was the correct
> limit because the loop is adding one output letter per iteration
> and back then SHA256 was not in the picture.
> 
> Pass the max length of the hash being in use in the current
> repository down the code path, and use it to compute the code to
> update the abbreviation length required to make it unique.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  object-name.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/object-name.c b/object-name.c
> index 11aa0e6afc..8f9af57c0a 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -680,6 +680,7 @@ static unsigned msb(unsigned long val)
>  struct min_abbrev_data {
>  	unsigned int init_len;
>  	unsigned int cur_len;
> +	unsigned int max_len;
>  	char *hex;
>  	struct repository *repo;
>  	const struct object_id *oid;
> @@ -699,12 +700,12 @@ static inline char get_hex_char_from_oid(const struct object_id *oid,
>  static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
>  {
>  	struct min_abbrev_data *mad = cb_data;
> -
>  	unsigned int i = mad->init_len;
> +
>  	while (mad->hex[i] && mad->hex[i] == get_hex_char_from_oid(oid, i))
>  		i++;
>  
> -	if (i < GIT_MAX_RAWSZ && i >= mad->cur_len)
> +	if (mad->cur_len <= i && i < mad->max_len)
>  		mad->cur_len = i + 1;

This logic is all about not extending the abbreviation
length to beyond the length of the hex array, so your
limits make sense. Moving the comparisons here helps
with readability.  
>  	return 0;
> @@ -864,6 +865,7 @@ int repo_find_unique_abbrev_r(struct repository *r, char *hex,
>  	mad.repo = r;
>  	mad.init_len = len;
>  	mad.cur_len = len;
> +	mad.max_len = hexsz;

This new parameter required for allowing SHA256 is valuable.

I agree that we shouldn't need a test case to guarantee this
in the future. Good to clean up unnecessary uses of the
macro limits.

Thanks,
-Stolee

