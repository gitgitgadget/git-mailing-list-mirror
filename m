Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AD61C9EDD
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569302; cv=none; b=px9fsc8UucVCoSy2iN00ApDCDQMC9tmD8W5nn62sk1DmNAzt+mchWGvHI1sCGX827GJTZI8/vBjesBXaq6ADSd7Bpx7Art+cGohz9o+zq424rTUUvex1p0uycsQcMMEIJDa6EwDWjjcZIWqIeNJivJvJfPlBohzIFc7c8sZ3lvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569302; c=relaxed/simple;
	bh=0n+qGPT3Kc/+dvNiEWH7kBtjXPdg07gSOdeANYaZppI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MQFgeCyZPUJGNMWp/OWGFGw8JsnlHhRm8rGkfjyWp5XxLA9FM/zJkxURbkuueJIbxm24jAqN+WZ/no7uQYVTzYXxRH5oVLirKk1bjyHFJPxqp3bJ8UKSM6OealH+JN7NFvdWzM977zIfmdlggCb2KN/5XZ7xywJ8YQfKAUUXQ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1EOtejj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1EOtejj"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-430558cddbeso6416655e9.1
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 07:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728569299; x=1729174099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qImADKJd6mGkz0b8um38m4pPCVmwmz7JhYPzQb/FJ0Q=;
        b=I1EOtejjIbZ876yWsdYj2pCR9PP8xkfaiIkD+cY2/VDsPw5voU2oOduIhUT4onENqO
         9z97h0S5QlklA7AroDiJpB+VPo16hHvnl7SnaWXrkS789CmuFFhUVkyInPZmIwWhfoiB
         xZJzQwRZgoUhmOLlp/6MEn/W5P1fYZMaiY46DKy3/sXT06R468sJTYilI7i6qSG6k2r3
         q6/a9r26CXKAFRNrv9ySNSE4syTxh0bgS65ojg/CV5k2yfOVS5mShkv7ZAWH9QNMlYdf
         fFjLxMXnaAx9tWnZH8KTO+9cNE5P3dhYt3ABqG3TmyjpXPb15gnANkkgacC8s7ukwmJu
         oucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728569299; x=1729174099;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qImADKJd6mGkz0b8um38m4pPCVmwmz7JhYPzQb/FJ0Q=;
        b=t43FCiit5Tgkkfv1oQ8N9rKggNrR1evE93z2I44GxKkDZcRksJZbXF96hYcemULjPF
         +T7YtEPV7ApA0gLPqMQOk2KYH4zDW8+wL+G1OEUxrN12s0AEzWtux62J7Yb87oIuww58
         9wOmFEVeESX7M5t+6YB+F8imyz4hz5rvEjFr89psh1malpybP7nz1GDYTuzr4cFTRI8x
         V2aig4b+Q0EEg06lJQCEM6pl+fE2v+W7mKcDCQdx2d9PK810CqghR6IK15c6eqwizWTJ
         ojSdgb1GQ0GkcdCgpXciaMEA6cRtlyey2kS1IB8A0NMcRrxYTzza81i1gVVljo74SOW1
         ePDw==
X-Gm-Message-State: AOJu0YwVRFLa6nA5xzzd5AHUAcDCpFRWxH+mTVBRG86bbD9C+XFaMqrJ
	Rx5PFSOWRIKb3jv8FyNYe2hIPRpT120RSUpjmn6MbfrcLyIoyBPeToPdbw==
X-Google-Smtp-Source: AGHT+IEQ7CqwSIaOZza12fug06C20RHVND77AGCZb5SU271/ISVPF0WzVKlTmrouTI6RoBU00vQ0dw==
X-Received: by 2002:a05:600c:5107:b0:426:63bc:f031 with SMTP id 5b1f17b1804b1-43115a9d77fmr26730635e9.1.1728569298960;
        Thu, 10 Oct 2024 07:08:18 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4311835d8f6sm17521915e9.44.2024.10.10.07.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 07:08:18 -0700 (PDT)
Message-ID: <90dea722-0762-4a37-a216-6883f4889c67@gmail.com>
Date: Thu, 10 Oct 2024 15:08:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy][PATCH v2] t6050: avoid pipes with downstream Git
 commands
To: chizobajames21@gmail.com
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk, ps@pks.im
References: <20241008162117.6452-1-chizobajames21@gmail.com>
 <20241010063906.51767-1-chizobajames21@gmail.com>
Content-Language: en-US
In-Reply-To: <20241010063906.51767-1-chizobajames21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chizoba

On 10/10/2024 07:39, chizobajames21@gmail.com wrote:
> From: Chizoba ODINAKA <chizobajames21@gmail.com>
> 
> In pipes, the exit code of a chain of commands is determined by
> the downstream command.

I would perhaps say "final command" rather than "downstream command" as 
in a pipeline "cmd1 | cmd2 | cmd3" cmd2 and cmd3 are downstream of cmd1 
but it is the exit code of cmd3 that will be used

> In order not to loss the entire result code of tests,
> write output of upstreams into a file.

We're interested in checking the exit code of git, but not other 
commands so it would be helpful to make that clear. Usman's patch [1] 
has a good explanation of this.

This patch also changes instances of "grep" to "test_grep" so the commit 
message needs to explain the reason for that change which is that it 
gives a better debugging experience if the test fails.

The patch is looking pretty good, most of the conversions look correct. 
I've left a few comments below


[1] 
https://lore.kernel.org/git/bfff7937cd20737bb5a8791dc7492700b1d7881f.1728315124.git.gitgitgadget@gmail.com

>   test_expect_success 'replace the author' '
> -	git cat-file commit $HASH2 | grep "author A U Thor" &&
> -	R=$(git cat-file commit $HASH2 | sed -e "s/A U/O/" | git hash-object -t commit --stdin -w) &&
> -	git cat-file commit $R | grep "author O Thor" &&
> +	git cat-file commit $HASH2 >actual &&
> +	test_grep "author A U Thor" actual &&
> +	git cat-file commit $HASH2 >actual &&

You don't need to repeat this command now that we are saving the output 
of "git cat-file commit $HASH2"

> +	R=$(sed -e "s/A U/O/" actual | git hash-object -t commit --stdin -w) &&
> +	git cat-file commit $R >actual &&
> +	test_grep "author O Thor" actual &&

>   test_expect_success 'push branch with replacement' '
> -	git cat-file commit $PARA3 | grep "author A U Thor" &&
> -	S=$(git cat-file commit $PARA3 | sed -e "s/A U/O/" | git hash-object -t commit --stdin -w) &&
> -	git cat-file commit $S | grep "author O Thor" &&
> +	git cat-file commit $PARA3 >actual &&
> +	test_grep "author A U Thor" actual &&
> +	git cat-file commit $PARA3 >actual &&

We can drop this line for the same reason as above

> +	S=$(sed -e "s/A U/O/" actual | git hash-object -t commit --stdin -w) &&
> +	git cat-file commit $S >actual &&
> +	test_grep "author O Thor" actual &&

> @@ -260,14 +291,14 @@ test_expect_success 'fetch branch with replacement' '
>   		cd clone_dir &&
>   		git fetch origin refs/heads/tofetch:refs/heads/parallel3 &&
>   		git log --pretty=oneline parallel3 >output.txt &&
> -		! grep $PARA3 output.txt &&
> +		! test_grep $PARA3 output.txt &&

test_grep will print an error message the pattern does not match. In 
this case we expect it not to match so we want to print an error if it 
does match. We can do that with

	test_grep ! $PARA3 output.txt &&

>   test_expect_success 'index-pack and replacements' '
> -	git --no-replace-objects rev-list --objects HEAD |
> +	git --no-replace-objects rev-list --objects HEAD >actual &&
>   	git --no-replace-objects pack-objects test- &&

This command has lost its input - you need to use '<actual' to get it to 
read output from "git rev-list". This test itself could probably do a 
better job of checking that index-pack does what we expect but that is 
outside the scope of this patch.

>   	git index-pack test-*.pack
>   '

Everything that I've not commented on looks correct to me.

Best Wishes

Phillip
