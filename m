Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF508C8C7
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721659611; cv=none; b=Vx7kNGpoghY9HWzn5RpORQRVWW8UmoExS24EVLprRLqBudGiiE4VcXnh376pE4yfNHlbE/lE3xdTsor1EcwODGv1VGnBxN19UGgQdowSm0H1uAFG1YUcHGnMxYnIsMgur8cstGF3PVJbSxrmmtmM3Gt3+/i8lK7S4bDeqaWrr7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721659611; c=relaxed/simple;
	bh=RWXvrVW6lNX11Pb3JufoRGiJJK8P9liXe+/d0U8u4Qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZGw+tsDUWZY/L0Lu7H1XLaqRfn1lA9L+SH+6Aw2Nk112Roa2fGlLSS5aSOdWuonnVM0jdAM8M3wd4+N9dwqo+LNMXJD235BnXle0wmFO6bQnX7RHBHxlyAklTV7GzOugPU4q9Ps1LBJSrJFlelCJ1TfNB5diALyeYZZYsJI33s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRcOXuKC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRcOXuKC"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4266edee10cso29170345e9.2
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 07:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721659608; x=1722264408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NhNALg2IzD6JCJUhJ4+h48A+/e4VzGwbC7tkFwQCrmM=;
        b=WRcOXuKCGvTqDuixXtfXLrAoEuTDDBd8VT8torXYVzDlUlmyoP2HMakPRQ56lZgJ2I
         DkapmEMoMvR8KeVd4J8YdB5E1P4ucEyMarVoU29NCyrK88j3lHBCgC+cpYfhOTx31IzI
         MACjsxfXTlMfszDkHkNCxf6gFmSpa6+r05s6zL2osNGJDU0Gt63tmIxiRVCeC5WndAJ3
         k/ulolwUc0OlP92MzZ/gxg0TSw8yhchRg3JN/kPtp98oLoX5mLrJnZF6KQW+jYI9Zl4o
         GdxZAYYc5LC9LQEr4gk+xCayaeJ9oWYdR6w4m1Cmy2CmW1Wv2pwkpsc5pbt6rWpjSQFE
         cIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721659608; x=1722264408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NhNALg2IzD6JCJUhJ4+h48A+/e4VzGwbC7tkFwQCrmM=;
        b=VhUkopVNMyjaTm1TCC4WFyWNqu3L76PVqVt+a/u69oSuiKsG9ABmWX4i7Rm3PgOcuO
         E+dWyyq4OagNbtUxfHWmZMFSliFUK0cxEhlS3WMGKimvVXIc5GWVQdvrwR2PROEU65MW
         MhYLPVSWl6FrgMfc59f84ZMpn47+5qV/Rm1x3tjpSEDOdjYFGNdkDZPysK/9LT12jf/U
         XW6SIiSE8fGqluSJIWr9xSAOoI5dSkqu8zeXURlSQoygG9P7/QtX6JQGDu7q3QTnYiYa
         FZ7dDMTlkI7ER29wdUkPyslep70VOLAw/mIOzjK/uFmK6CaRn9SCtyghl8G6gL8K7BvW
         kRpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP+QhUqg/jdFbgGijOzFd6rDYlvjZ7YzZJcKxWnSecjZa0P0v4zFIC8k/fg3qbJyDbnNeuYwTrGCo9pvdwv7Dz4qlz
X-Gm-Message-State: AOJu0YwyHq53TWbLambR9lIP3f0uzJ8cUVhpgZNJQcaI8lZds4chtzKA
	PcqF5NWn0Ewy4kW0+iebdtVTHXndUzGoMwFihX1S+SetMjiKA/DEOcRdUwYN
X-Google-Smtp-Source: AGHT+IHl+niR3OWCQ1bP0p6oDpdeQpKD25wMYh+p/Row7IKL5pYtlhmqxj2evHK2m958VPu6osekIA==
X-Received: by 2002:a05:600c:1382:b0:426:59fe:ac2d with SMTP id 5b1f17b1804b1-427daa67bf1mr61952445e9.32.1721659607860;
        Mon, 22 Jul 2024 07:46:47 -0700 (PDT)
Received: from gmail.com (89.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687868b262sm8691103f8f.30.2024.07.22.07.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 07:46:47 -0700 (PDT)
Message-ID: <8c6559cd-d18b-442d-b692-f1611f1907f4@gmail.com>
Date: Mon, 22 Jul 2024 16:46:46 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] check-non-portable-shell: improve `VAR=val
 shell-func` detection
Content-Language: en-US
To: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20240722065915.80760-1-ericsunshine@charter.net>
 <20240722065915.80760-4-ericsunshine@charter.net>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <20240722065915.80760-4-ericsunshine@charter.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Jul 22, 2024 at 02:59:13AM -0400, Eric Sunshine wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
> 
> Unlike "VAR=val cmd" one-shot environment variable assignments which
> exist only for the invocation of 'cmd', those assigned by "VAR=val
> shell-func" exist within the running shell and continue to do so until
> the process exits. check-non-portable-shell.pl warns when it detects
> such usage since, more often than not, the author who writes such an
> invocation is unaware of the undesirable behavior.
> 
> However, a limitation of the check is that it only detects such
> invocations when variable assignment (i.e. `VAR=val`) is the first
> thing on the line. Thus, it can easily be fooled by an invocation such
> as:
> 
>     echo X | VAR=val shell-func
> 
> Address this shortcoming by loosening the check so that the variable
> assignment can be recognized even when not at the beginning of the line.
> 
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/check-non-portable-shell.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
> index b2b28c2ced..44b23d6ddd 100755
> --- a/t/check-non-portable-shell.pl
> +++ b/t/check-non-portable-shell.pl
> @@ -49,7 +49,7 @@ sub err {
>  	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (use FOO=bar && export FOO)';
>  	/\blocal\s+[A-Za-z0-9_]*=\$([A-Za-z0-9_{]|[(][^(])/ and
>  		err q(quote "$val" in 'local var=$val');
> -	/^\s*([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
> +	/\b([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and !/test_env.+=/ and exists($func{$4}) and

Losing "^\s*" means we'll cause false positives, such as:

    # VAR=VAL shell-func
    echo VAR=VAL shell-func

Regardless of that, the regex will continue to pose problems with:

  VAR=$OTHER_VALUE shell-func
  VAR=$(cmd) shell-func
  VAR=VAL\ UE shell-func
  VAR="\"val\" shell-func UE" non-shell-func 

Which, of course, should be cases that should be written in a more
orthodox way. 

But we will start to detect errors like the ones mentioned in the
message, which are more likely to happen.

I think this change is a good step forward, and I'm happy with it as it
is.

Thanks

>  		err '"FOO=bar shell_func" assignment extends beyond "shell_func"';
>  	$line = '';
>  	# this resets our $. for each file
> -- 
> 2.45.2
>  
