Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5B02BD04
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070506; cv=none; b=JmChWBuxoJMCzGP8U535OnjBxQXNteXoDfIhf1i7vdzYYtIeQO1Uyrxedx2QGJxd+NFeqLnZ5KnIacd/ONcfVkyFD13CfubdsjCEiMSrke7cu0ZtcZc+61PoxVwq4VHbcfUZ3qIpiA343rURhWSNbZojozUB6Hi27fCAMZIHXS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070506; c=relaxed/simple;
	bh=z7Y83xZrq6mssftZeLbKhQ1aSoTED2LokNJ+7qiRm2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UHzKAZcwsAfHJ09/yWKxLYHB+mK2uonn8nECZ7WE5HW2fRg5VGlbpUg1qPfqzp967E+LqS5FuakfnmjxzxX+h9wX6yMb+6Mb6exmxPs7w5//0UK9r4VXw9LupQ+wANDB5aILwIdCvB4Yzan0FRumb86m9pzi/uyHvYJnqZDRuL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTtwQfPi; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTtwQfPi"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so4274002f8f.3
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 07:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752070503; x=1752675303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z/9uxljPCPaGMds4cugQtBa95EN/c2Jxc6TokVEKo4g=;
        b=ZTtwQfPiFrEJ85VHXyLC8yhqPWBRmgMuVBO97+bnWepR6oCAzKlIx+rakpzuijKZ+f
         ySW2jD25lFoYHUPQ12Y16esW2B82pV7/liE29X7vUjj37LxF5sOk2GV709nhK4lRjsUr
         p1XICcZoLlxqbvk3XH60cmLcuCBQ2demwQSsFvrfGtS5D8lKCWW80XLBE8Mp9kP8KkfY
         qt5ZBqxYFi5ESzmcBhVbqQFI/4uN78IAYaucAtffCXJInnEQ9GoZL66Gk2q43bdo9u3H
         5KA1YVAhSuYebL8ZTnVc7J/OQPzZC1ESfNVRqzFNNeqQNzcrssi/LgvXP5hbvm68Tp7W
         CTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752070503; x=1752675303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/9uxljPCPaGMds4cugQtBa95EN/c2Jxc6TokVEKo4g=;
        b=M1+DR5kXVFqQOYBw3iqe+63FqC6EXunVAKZpp+J0cx/dBIWzHrLRvnSmdgNzgVRMy9
         t1GFZILds3U5C79PeV1fbue+yiUvGD4eH36Iz0Cr65vrguqfagBdaJJ7Tn41Rh3keTsA
         yYJ88F9tzNAE7o+jccvBBWX98B5PFobqXnushsX49uE4tl3Z6/SiwaGVwQI29h/bKN2C
         NC8i3pMuFOwKZIIahnmo84bFXq4Nl3H0SfaP476dN9Rw7iP1IeX3jk0nBJZu6W4U8BKx
         kO5MZ2a7GVnyd4WEDSVsJOwpdJqAdjHyM2r7nLPehIN8h7cDikbqG+334p6jiL8VsSOZ
         GsQA==
X-Gm-Message-State: AOJu0YxJrHjn7pUP+dl8CZwJrtxU7A/80XTtn1qUjJxJVpmeT4jXpzPe
	62+FDbKcfM2B4bB8h8BRxyfulY0We1O9VDk61bimnau+9bSpqDMR7wR0
X-Gm-Gg: ASbGncvHssAb79VCmt0GsVOgywL7/YW2SRSsVcC1M2iiuSAh/Qbt1p5VvXycJtux6CJ
	yYTdWoShhV5zn6kc7bqCmv+VchrUufZ0PyBjvm27dzITJTgbj482dAtpTBPzbj8dQR4CPp9QjL9
	OJ8xwQKn3/6otcIZQ5tmkztuOpnRH3Temjyy403ak7lFzEfnWDi1xWW9LEQ6Lwsrm/JV6JD+ps6
	RgJyFWbwOx7imQgW2OQbOG4TTrW9UoqmeoyJNPJnUOmsDtBhoeXk0vRbEMbqAQ9rF6MWJN+fq2U
	flLbYm3ggHHx0pWvgu2bBt6CxVMYcBIErpuER+/XW0TryBnsoK5ZnHsLuU/fQvNdN7wmPpZSkt1
	anYNkACLn7Hx89HPsL2JrPzDHiMFGoLvwuYoTdQ==
X-Google-Smtp-Source: AGHT+IGECV3Qe9ffppt6RY45lpXln4xzlKegR2VnzvgFpOC6H3U74vPsVFUwp7Gb6k9jMYfYqFEW4g==
X-Received: by 2002:a5d:5d0c:0:b0:3b4:9c09:1aa2 with SMTP id ffacd0b85a97d-3b5e450560bmr1956850f8f.13.1752070503066;
        Wed, 09 Jul 2025 07:15:03 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d099esm15735867f8f.21.2025.07.09.07.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 07:15:02 -0700 (PDT)
Message-ID: <299f547b-635d-4a2c-958e-7ef6200ea69c@gmail.com>
Date: Wed, 9 Jul 2025 15:15:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Jul 2025, #02; Mon, 7)
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, j6t@kdbg.org
References: <xmqqplebzgm7.fsf@gitster.g>
 <vl7ahhcqgci3xemqhtdugdhar24ewl7mu4wqwxnc3jag5blpoo@l7b24mahadyi>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <vl7ahhcqgci3xemqhtdugdhar24ewl7mu4wqwxnc3jag5blpoo@l7b24mahadyi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/07/2025 11:41, Carlo Marcelo Arenas Belón wrote:
> On Mon, Jul 07, 2025 at 05:11:12PM -0800, Junio C Hamano wrote:
>>
>> * cb/daemon-reap-children (2025-06-26) 4 commits
>>   - daemon: explicitly allow EINTR during poll()
>>   - daemon: use sigaction() to install child_handler()
>>   - compat/mingw: allow sigaction(SIGCHLD)
>>   - compat/posix.h: track SA_RESTART fallback
>>
>>   Futz with SIGCHLD handling in "git daemon".
>>
>>   Stalled?
>>   cf. <dba9ae0d-1e43-4345-a7ec-b57a07d45a07@gmail.com>
>>   source: <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
> 
> I don't think so, but definitely missing reviews (specially for patch 2)
> and slightly controversial.
> 
> I wasn't planning any further changes,

I'd very much like to see a re-roll cf. 
<b1027221-3e17-40d2-b293-4b1625fa095d@gmail.com>

Thanks

Phillip

> and while I have some for the
> "related" patchset which enhances the notifications by using a self pipe
> was holding them (as well as the related feedback) to allow for this to
> mature on its own.
> 
> On the rationale on why this is independently useful, note that we are
> currently relying in at least 2 "unspecified" behaviours:
> 
> 1) using signal() means that it is implementation defined if SA_RESTART
> will be enabled or not for that signal, and
> 2) if SA_RESTART is enabled, it is implementation defined if we might get
> interrupted in poll().
> 
> both are resolved by using sigaction() instead, and it is up to us to
> decide if SA_RESTART is enabled or not (which might make patch 4 obsolete
> if we decide against).
> 
> Carlo
> 
> CC: Johannes Sixt on feedback for SIGCHLD in mingw which uses 17 instead
>      of 22 (cygwin and others) and therefore seem to cause signal to err
>      without setting errno as it should.
> 

