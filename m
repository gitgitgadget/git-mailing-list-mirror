Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681E91D130F
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028897; cv=none; b=Xt3UcnUc03s+k3Ad69+n0PZPHfjT2JaFgymiO84pjYilTNyQkn5RrsudTcsoJn4PYqtSjuwjOwzghxiqoY8GsRnPlAszMUfdT+UUeVveNsG8KXlyPS1FfHofCWi7mO2423zacYOPI0KH1Tv+6za9uvzuBCUr1z8axCV6XpNyLiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028897; c=relaxed/simple;
	bh=SMrFRv4pxqY9KJ3pWI01vpn9audo0uUQrYpJ9AzE4Sg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Oc/dexGfuy0Z8EqdcHFdYFVlpCja113ot1DhvTaStMRTIY3WdonIyODCQ/5Ok8/WoUVYu8+m7GevOwbYNqKWNHPUS/tSzq8VG5NqOPqjud7wx5DmHnbBEnKzqC0dBlB9GjpNBOfoN7k75Y0veWybOjbfbTwVYHS23q7MrSD9knY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUFX+GIe; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUFX+GIe"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so39753995e9.2
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 07:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732028893; x=1732633693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hRQmX86GGqbkFOk4to93AnBBsczafTc2ejDZCUWhUkA=;
        b=gUFX+GIeE64GD6Pnd0JqkN9yLnnJZk4ErIy4QNxD8u3bbkKccNpDLFCcuGgjOGPTEL
         BxiI1pJ7B2CopdDFuAQ6KU1KcIFgJr9rHlf8sZq8Bke5MZVMz2rdAfPLSTfuQAo3oqLG
         FX7I1Qw/5Fz6Xk/b5a1mR7Wb/XK1pZsONAzx0HwE6sCMn3CAdZCpMSHGtsSRTgd8bzgM
         3M655MB7MpdMn6IFokzgmQBi/a0U4VfC1ZdDo2bJidtJdalhb2HV5dkl2TdcYN527AIO
         MD/Fngw4AnEH0wm+NGv8qOJzOxOfHTiRD4kSKRkUFGTW1w7RI9nP0i76M47YGzCZveIV
         CApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732028893; x=1732633693;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hRQmX86GGqbkFOk4to93AnBBsczafTc2ejDZCUWhUkA=;
        b=NtBs+FiR2l0i51XK5LZwewj872LJtoa7ucefKXfOsxnOCE/PNhUs5BPeZKD5QdU/Z1
         aU/w5RFUO0R+y8BNatUFOUi+weC9pn8xeoUgtfWydaGAI/y3oiqsVSWJH/NSH0zqONnZ
         piAd0ULsl3hwP1xloqDeUs9xh5TwEtoa32M/zLhgokRmfqU9DEFWffWKtX9CyxcZDFYc
         Ntr9joCSwV7l7f444T0S2Kh3tW+9vD6fwg4b/GSqniK1wC9vRbI1lYfWA5rM0ip5afRz
         yBeQBJhXPVSjOjptgMFr2wdXHTsE7WGZzkZ9vuTT7o3g+l5PfhHl0zbhGxPxk8KmFVQO
         u92A==
X-Forwarded-Encrypted: i=1; AJvYcCX0ex70Ajs+hr2FNIU8lTCjSoBZ6lD+KwcqElrSdiEoN+yWS87nr+RULZrNQuEfrPLGq+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6qfTjDuJ1o+CRRN2Zcs72tscPHRPefplLHYOHZFRzKWbBQngn
	m8ExB9SaNKDGPp7NHEzYue/JLVeVTStMDwqwMyi607NzKdW/ktkpRIIIfA==
X-Google-Smtp-Source: AGHT+IF3d/8qIU/SK9f13ydSDcRsA4H4C54acJnLl904rEmakGZXviwYtdLPGdNQxLqJrRCSqeCYQA==
X-Received: by 2002:a05:600c:3491:b0:431:58bc:ad5e with SMTP id 5b1f17b1804b1-432df7901femr119025505e9.28.1732028892571;
        Tue, 19 Nov 2024 07:08:12 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6a8:b801:610:d596:f87c:e591? ([2a0a:ef40:6a8:b801:610:d596:f87c:e591])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da27fc8esm203471835e9.21.2024.11.19.07.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 07:08:12 -0800 (PST)
Message-ID: <977c1e75-1fef-4827-91ae-cc1a6ce7508e@gmail.com>
Date: Tue, 19 Nov 2024 15:08:11 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 3/8] worktree: refactor infer_backlink return
To: Caleb White <cdwhite3@pm.me>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
 <20241031-wt_relative_options-v4-3-07a3dc0f02a3@pm.me>
Content-Language: en-US
In-Reply-To: <20241031-wt_relative_options-v4-3-07a3dc0f02a3@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Caleb

Thanks for splitting this out into a separate patch

On 01/11/2024 04:38, Caleb White wrote:
> -static int infer_backlink(const char *gitfile, struct strbuf *inferred)
> +static ssize_t infer_backlink(const char *gitfile, struct strbuf *inferred)
>   {
>   	struct strbuf actual = STRBUF_INIT;
>   	const char *id;
>   
> +	strbuf_reset(inferred);

I think the code was clearer when we reset the buf just before using it. 
That way it is easy to see that we add the path to an empty buffer.

>   	if (strbuf_read_file(&actual, gitfile, 0) < 0)
>   		goto error;
>   	if (!starts_with(actual.buf, "gitdir:"))
> @@ -741,18 +744,16 @@ static int infer_backlink(const char *gitfile, struct strbuf *inferred)
>   	id++; /* advance past '/' to point at <id> */
>   	if (!*id)
>   		goto error;
> -	strbuf_reset(inferred);
>   	strbuf_git_common_path(inferred, the_repository, "worktrees/%s", id);
>   	if (!is_directory(inferred->buf))
>   		goto error;
>   
>   	strbuf_release(&actual);
> -	return 1;
> -
> +	return inferred->len;
>   error:
>   	strbuf_release(&actual);
>   	strbuf_reset(inferred); /* clear invalid path */
> -	return 0;
> +	return -1;

Why don't we need to update the callers of this function to account for 
the new return value?

Best Wishes

Phillip


