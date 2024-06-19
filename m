Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2118B770F5
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788123; cv=none; b=P9xU+C4YXztmFcTGABrxdbo98abrg9zh2p9LmMD6pbz2uABT+g3Tz6OhQwpNptRAznwySj6ODNuJ6pgiQIPuwxFbXaB/7jm7VjUtQ233gPlnsdmcsYLYDEG/TVoYrYuHE9lzPxNlPQ1QeLwU/oOZXNtM/IXDd5FL1QiDgbTbirI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788123; c=relaxed/simple;
	bh=bLBM1SA/JWz7B1hNyNaJvqWaEWoCooPnADZNXAOlh40=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=JS8hPzyNwoXXkn4GfLRB7ev589GIkh2bvlE1py/vo09P07AW77QbKfFN52IFYuCLXOFIpcrGnjug80BE2bj2Omcod8FYs58y0pZZmDYSs6Gt4/+aJVAF0rYXre63800BlcznT8WupkKZiwuousSXqmf0sAbDi7edJKMQEFYnDjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAFifiwO; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAFifiwO"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3621ac606e1so436122f8f.1
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 02:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718788120; x=1719392920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E5+XSQiN0bv9jcb1ons69Z2jgoD+s8A9sAGMo4N1pMU=;
        b=OAFifiwOzZytV1IXDKVHsbrhtsn6pYw/1Fn0Y37xEvxhjpJd7Maoxz8J8TlYJeQ76V
         +Qab4tsRUlGbOPpyvaMTq8rvSnlUseeHyNnFQ5SChjPv4r7bezxVEdT15ICd1W8wtEMY
         7G9vezqYOQ/VWHfFBPYc8P/PtXeGlD8x+pZIm3w1tFdEnTMBLp8YG5KQpPW7+T8sOANI
         1tWcof9fr45ARU11AQV79JJGRAWWn9I0WmscT6g9dvGPoRGvAIlTZqEqvjBzDcDt7yyU
         7eQjQOQZZyHttNfMhM4ARjFd7uv+MOcs9Yub8qETv5P5jgfruyuVIqZb+zRON6tPtK2t
         J2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718788120; x=1719392920;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5+XSQiN0bv9jcb1ons69Z2jgoD+s8A9sAGMo4N1pMU=;
        b=Z/db4s+WtKmW/CcvYsrH9kxm6MZNPXFv0Ma35RslEJROBz+ZsM8YM4NOEC9oY5gQCN
         RnF6G1qNpnthzyGTIwGVX0Nz/l9LnaMJXY+jCyBgQlK60Ya3Bp67dP31VThIK5/0/qz5
         TTxJzbRSq0fVlxJBx8RU8f7e2kXP3doEngW+x1lK7ylBXh+4hqryvC+sFvr1gl9jVpre
         tISympiIbOSGG+0rbnfHnKmorZb5cBbq4Edjf+QZFNRB6It3riiTcKqlt5+2Fvb/PGUC
         a/jLxo4+8t7cNoDP2FKNwUWX/I813pr6XQOVoJ1AWZgJ32z+caQlLbCi3vy6I1SvwEcD
         GFXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3SEyJo9RxjQSvy/+Xyz7wMyX7VMV5r02elDKU7C0CLGmHJAXj1SOlY+bLCSsjXB5e5zHAxu4hjPT/PJ9AIu1BP32G
X-Gm-Message-State: AOJu0YykczTxlOqXdxwAB5sHwVEbRYM6sd9H5xm4hCeqJuPlIGmh3T0M
	HqVpO/e515e9yO56yJg1qIZxt14dwZTUYlCLtsMliNGLq+KvfQw1
X-Google-Smtp-Source: AGHT+IGYlVx29kBJtQKGPe2G8t+jxCtUM13fh9p8un5q2M7gKfNBUOoUN9jDwd9YsPKTtupR2Xoi1Q==
X-Received: by 2002:a5d:504f:0:b0:361:94d9:1e9e with SMTP id ffacd0b85a97d-362ff0b2c1cmr2238036f8f.6.1718788120238;
        Wed, 19 Jun 2024 02:08:40 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3635077a4c9sm1622460f8f.96.2024.06.19.02.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 02:08:39 -0700 (PDT)
Message-ID: <6e80eea5-b6ce-4218-8c43-dde2b5a698f5@gmail.com>
Date: Wed, 19 Jun 2024 10:08:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] t9700: ensure cat-file info isn't buffered by default
To: Eric Wong <e@80x24.org>, git@vger.kernel.org
References: <20240617104326.3522535-1-e@80x24.org>
 <20240617104326.3522535-3-e@80x24.org>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
Cc: Junio C Hamano <gitster@pobox.com>
In-Reply-To: <20240617104326.3522535-3-e@80x24.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Eric

On 17/06/2024 11:43, Eric Wong wrote:
> +# ensure --batch-check is unbuffered by default
> +my ($pid, $in, $out, $ctx) = $r->command_bidi_pipe(qw(cat-file --batch-check));
> +print $out $file1hash, "\n" or die $!;

It's been a while since I did any perl scripting and I'm not clear 
whether $out is buffered or not and if it is whether it is guaranteed to 
be flushed when we print "\n". It might be worth adding a explicit flush 
so it is clear that any deadlocks come from cat-file and not our test code.

> +my $info = <$in>;

Is there an easy way to add a timeout to this read so that the failure 
mode isn't "the test hangs without printing anything"? I'm not sure that 
failure mode is easy to diagnose from our CI output as it is hard to 
tell which test caused the CI to timeout and it takes ages for the CI to 
time out.

Best Wishes

Phillip

> +is $info, "$file1hash blob 15\n", 'command_bidi_pipe w/ --batch-check';
> +$r->command_close_bidi_pipe($pid, $in, $out, $ctx);
> +
> +# ditto with `info' with --batch-command
> +($pid, $in, $out, $ctx) = $r->command_bidi_pipe(qw(cat-file --batch-command));
> +print $out 'info ', $file1hash, "\n" or die $!;
> +$info = <$in>;
> +is $info, "$file1hash blob 15\n", 'command_bidi_pipe w/ --batch-command=info';
> +$r->command_close_bidi_pipe($pid, $in, $out, $ctx);
> +
>   printf "1..%d\n", Test::More->builder->current_test;
>   
>   my $is_passing = eval { Test::More->is_passing };
> 
