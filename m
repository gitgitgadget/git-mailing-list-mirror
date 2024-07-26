Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCA817BB24
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999499; cv=none; b=RnZ9Sm3u5PDAMaeIdx7163pGHbJtusVVGYwudTlCuLtsTxzod1EMfUJeqzhg/W3OmKQeMSmtvUjgjAQV7jyato4isnqaPSo3FHMVyj6cIPwjDh8RQpOjBp4y8xRzgZI73PNs0qNrNqqtRY5Xa3KV2zr8EYUMTi6E7JYDovTq72s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999499; c=relaxed/simple;
	bh=74vh5hQdbA+g3vyZxx2VDtzL/d4x1IndDO2BEMDZqBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BkJ622wRRp9b+iticR5fNjZSJvH5v170zELI+d4s8Vtl3k0a9XjXuRJYqw13rxNCzymMcq4NN5twBUwDmrXKbzC/uU0LcmTeTe/GkNzf7Wud1hEOD9s21hPU5ZB6t22FiGl/McsQkrnoVtGjvXlt+GufA9jsHk2+bDjM5UhMwAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FefKRUNd; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FefKRUNd"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-368440b073bso1303742f8f.0
        for <git@vger.kernel.org>; Fri, 26 Jul 2024 06:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721999496; x=1722604296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BuVnFIdQUt5Kh6L88eLju7pSjY/RaoSNcYsz6Oxm+wE=;
        b=FefKRUNdUxgSJ0JrnwT/QyD4TjW4TSfFfx4KTxbA4jU4bC9s9klsbvdVs3W/MTSmzC
         s+vYC6bN0evskXNh5P78bbv+rp+PshiWfETo+9M0SXeroqpN3PxB6CAi/hl1rzkj3olb
         QbQYgFIfB6skE2BNqk4W+kW+lEgGTYeJXxevzFciV+BzrCbW6LF83H6b2cwxJkbjPUuz
         4tEaGThL80NYoxAjTdC6vYVwE07A+L6EHTc7iemxoktHFtxmAmhCErVYEVL28fE2IA8H
         BQmlCStndRRoUU6lR8rez95MOmcX6Wg+AhEu3NE8W2wOKl7y6UYG2b+yczIMIWkAKOaj
         5/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721999496; x=1722604296;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BuVnFIdQUt5Kh6L88eLju7pSjY/RaoSNcYsz6Oxm+wE=;
        b=YX6U31OqH8slTampIybXxlnyEBNlT17/j2RdQxShQkGsVCawq+v4mUcxROPV9Dncpf
         MVI/xGaqNbSOz9lHRDgEci3TFQd+H+Y3ZVhFYlSGAuSzSLiUirA4cgHWtZ2ITvUciLcB
         cBKTFybeWsYeZoOyDwYCW6yWlnG5+GNjHoRZXIt1E+lJyKIL77clxCRPeT1g+M2UMUvc
         1a8NJNZ87llLcuCvQmmJM9kNRMIerXeZkb2yaX30Eq3BpbxekETR0M5r5WFHg06e/Srs
         eyPc9F/D7YRAcc7mB2WpFIrcMkkEgU+ta6wrZdYDVuWWz7qZGZ/vygqnQTyyWNwQhLXt
         E6WA==
X-Forwarded-Encrypted: i=1; AJvYcCXyc45Ag86SNVc7UcAOUM/s97dBTBHYLjxmxXt6CoD6UHlrG6NT7if6LBWYHjkxXnWRlNNHl06Mhvg3hdgQHERSvtjI
X-Gm-Message-State: AOJu0YzIXhKXAAf2LVVw2DNnHx1X6VyaeGo9voRqktWYyfBn4EFAh+uV
	g2WPVyXvqsWa7+20C0qikJDUfr7bRlnkiOADz/wnhyggpnm5T1SG
X-Google-Smtp-Source: AGHT+IFI5ikbgJEbhGRE5ZdAXS7/ORWji6uCLUTCSbECTdLA8XS2RJYHE44+bPuZdtkTgnXUv8SW0Q==
X-Received: by 2002:a5d:6847:0:b0:360:866f:5083 with SMTP id ffacd0b85a97d-36b31baa861mr4202560f8f.32.1721999495431;
        Fri, 26 Jul 2024 06:11:35 -0700 (PDT)
Received: from gmail.com (155.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fde8asm5126647f8f.54.2024.07.26.06.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 06:11:34 -0700 (PDT)
Message-ID: <9d96b89f-f4e4-49f4-aa59-2c229d3988e4@gmail.com>
Date: Fri, 26 Jul 2024 15:11:34 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] check-non-portable-shell: suggest alternative for
 `VAR=val shell-func`
To: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Kyle Lippincott <spectral@google.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20240722065915.80760-1-ericsunshine@charter.net>
 <20240726081522.28015-1-ericsunshine@charter.net>
 <20240726081522.28015-5-ericsunshine@charter.net>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <20240726081522.28015-5-ericsunshine@charter.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, Jul 26, 2024 at 04:15:21AM -0400, Eric Sunshine wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
> 
> Most problems reported by check-non-portable-shell are accompanied by
> advice suggesting how the test author can repair the problem. For
> instance:
> 
>     error: egrep/fgrep obsolescent (use grep -E/-F)
> 
> However, when one-shot variable assignment is detected when calling a
> shell function (i.e. `VAR=val shell-func`), the problem is reported, but
> no advice is given. The lack of advice is particularly egregious since
> neither the problem nor the workaround are likely well-known by
> newcomers to the project writing tests for the first time. Address this
> shortcoming by recommending the use of `test_env` which is tailor made
> for this specific use-case.
> 
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/check-non-portable-shell.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
> index 179efaa39d..903af14294 100755
> --- a/t/check-non-portable-shell.pl
> +++ b/t/check-non-portable-shell.pl
> @@ -50,7 +50,7 @@ sub err {
>  	/\blocal\s+[A-Za-z0-9_]*=\$([A-Za-z0-9_{]|[(][^(])/ and
>  		err q(quote "$val" in 'local var=$val');
>  	/^\s*([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
> -		err '"FOO=bar shell_func" is not portable';
> +		err '"FOO=bar shell_func" is not portable (use test_env FOO=bar shell_func)';

When someone blames this line in the future, the message of this commit
will appear and be informative.  However, I think the message of the
previous patch [3/5], which also touches this line, would also be
relevant for this context.  And it won't be so obvious to get to that
message.  Therefore, it might be worth combining this commit with the
previous one.  But I'm not sure the change is worth it to have a new
iteration of this series.

Anyway, the change in the err() is a convenient improvement.

>  	$line = '';
>  	# this resets our $. for each file
>  	close ARGV if eof;
> -- 
> 2.45.2
> 
