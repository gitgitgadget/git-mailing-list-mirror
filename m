Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C2E14F70
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713705519; cv=none; b=qMutuaXcvcpOdN6vSDPkpSChPwCKdqCgjoDdjic2U1EDuqDsF6+R6m+bkqE/vSx/x4JvAhdRmQqlaamCo0Z3LIirBvyVjE3QlmMkook/Do3mWcf2Voa4ZQiVnxfYyPqsTP5oobodPhGwyOlHr3Y7jf/FdAo7tB3FJjea51v9Zvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713705519; c=relaxed/simple;
	bh=JqA7puztn2UY4xUHcKnP4HH6sUy/HDv80r9o8iENwe4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DcXPdchY83C+oJQVAbtkYJWF9NA+3442GiBgr/7qfJ3taNYY0TMTMulF5fXgk5pIFz1E2dNCjqSxeHjhSza4ZRTVP0QlLmXjm/cMOqdKDqzWg7Ng91FdSNXCiL09nXxHzKEChOcuYTVkUFaISdmMmuQAg9dgYfT+227VZ5OuiYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=as2VRTLz; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="as2VRTLz"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-346f4266e59so2563695f8f.3
        for <git@vger.kernel.org>; Sun, 21 Apr 2024 06:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713705516; x=1714310316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xpwA5kTsxdvDHK/i/xaScHGqPT58nT+PUh9aJv9ner8=;
        b=as2VRTLzHqGCFhH/BPYRBhTOvblcvgSG0qyyXhZuQ9ALAuZF1Pc+eiZSPLbkbyF0wK
         bNYINaXZqjCcNzLxgwo7ANXkdhrPwtCfLwASksmoBw6k704sHIWcGs1DTZO6JR6Z7Da/
         3oQulqvoIJILtRaZfS0JLIX0SP/uOFOGBngxkZcw621Q8LhVZw/6fJYFd9H1et/qPUaN
         eqkHzdsSmXfaNp3DDcelIAEHYiUPY7/8NcMPv/NjKnHbwZKX7uZv/mQUA3/06OeAl3io
         YbPIkr/f5AIbxKfe6KGSPveJiSFZ580ohBFrRizGKMscDKZ6CcGA+lirnC745YwZlqMv
         vgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713705516; x=1714310316;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xpwA5kTsxdvDHK/i/xaScHGqPT58nT+PUh9aJv9ner8=;
        b=HQKrxtxjt732biSvRV5Iu3OaxHTc/K4R01hah/1dYEy73WSHpskpntSyJp1Crl3SVK
         ul0gV60M4y/rf0Qf2zg0jZ2K+Fh+ItGiAN/cI7kk3ftb5qjmR16vW7uevdWx090Fdup9
         LLKLMTmxIysvkpwf2yupZwQ9mr1djjeHEXDbi9vgGMg1RNNLfYm7IGPmerSjpZXO/hyE
         vJksVeWXbJ6xPmFkVTQfXXf8wOq8fsU2Rw6xYrGpgLBjbzXbym/5gTbnnnvhrOwPMqb7
         P7Ax2rk3Pf3DVWZDlBAzC4wy5D6XODZqySB6EaW88pfuE4/gqFWuG2XNeQz2+yypufRo
         hxgw==
X-Forwarded-Encrypted: i=1; AJvYcCW+JOW2PU4PqDNxnR7lgn7j0jz1sCDaoLamFqfgS9YCvVm9+4ryN7hin8cnzPeEBm6vT6LylyFYi0oSQc365/qnY1sR
X-Gm-Message-State: AOJu0YzCPQPFCheAjfyqwZ4p6qrqZU2Fu4Ow352rStwXfGFBUJCAm198
	75GO9vWV0p51w3FRVwFdgF7S1OBcLm3fg9i6g2/JmT6NPB1u2Ejj
X-Google-Smtp-Source: AGHT+IE/44kCbTgfRN+XKAXtZidRu7xTj4sSOv/+19S/d1TnQsO2BjdMCHcoB1OaoqFfMTrzLA5EOw==
X-Received: by 2002:a05:600c:4ed2:b0:418:16c3:499 with SMTP id g18-20020a05600c4ed200b0041816c30499mr4665106wmq.37.1713705515591;
        Sun, 21 Apr 2024 06:18:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:701:9864:4109:be00:6ff6? ([2a0a:ef40:62a:701:9864:4109:be00:6ff6])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c3b8600b0041892e839bcsm13391296wms.33.2024.04.21.06.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 06:18:35 -0700 (PDT)
Message-ID: <b1c725f3-0e92-4723-a7ca-8d001d60b89e@gmail.com>
Date: Sun, 21 Apr 2024 14:18:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] add-patch: response to unknown command
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt
 <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
 <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
Content-Language: en-US
In-Reply-To: <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

This is looking good, I've left a couple of comments on the test.

On 21/04/2024 10:51, Rubén Justo wrote:
> When the user gives an unknown command to the "add -p" prompt, the list
> of accepted commands with their explanation is given.  This is the same
> output they get when they say '?'.
> 
> However, the unknown command may be due to a user input error rather
> than the user not knowing the valid command.
> 
> To reduce the likelihood of user confusion and error repetition, instead
> of displaying the list of accepted commands, display a short error
> message with the unknown command received, as feedback to the user.
> 
> Include a reminder about the current command '?' in the new message, to
> guide the user if they want help.
> 
> Signed-off-by: Rubén Justo <rjusto@gmail.com>

> +test_expect_success 'unknown command' '
> +	test_when_finished "git reset --hard; rm -f command" &&
> +	echo W >command &&

I find separating out writing this file from where it is used makes it 
harder to see the input to "git add -p" using test_write_lines as you 
did in v1 matches the existing tests and is perfectly fine.

> +	git add -N command &&
> +	cat >expect <<-EOF &&
> +	diff --git a/command b/command
> +	new file mode 100644
> +	index 0000000..a42d8ff
> +	--- /dev/null
> +	+++ b/command
> +	@@ -0,0 +1 @@
> +	+W
> +	(1/1) Stage addition [y,n,q,a,d,e,p,?]? Unknown command ${SQ}W${SQ} (use ${SQ}?${SQ} for help)
> +	(1/1) Stage addition [y,n,q,a,d,e,p,?]?$SP
> +	EOF
> +	git add -p -- command <command >actual 2>&1 &&
> +	test_cmp expect actual

It is really good to see us testing the whole of the program output now 
but have you tested this with GIT_TEST_DEFAULT_HASH=sha256? All the 
other tests use diff_cmp() to avoid test failures caused by the index 
line depending on the hash function. Alternatively you could run "git 
diff" to create that part of the expected output.

It is a shame we're not testing '?' as we have changed the 
implementation - before this commit '?' was just another unknown command 
as far as the implementation was concerned, now we treat it differently. 
It would be nice to see some test coverage for the 'p' command you 
recently added as well at some point.

>   test_expect_success 'setup patch' '
> -	SP=" " &&

Nice attention to detail, this is not needed now SP is defined at the 
beginning of the test file.

Best Wishes

Phillip
