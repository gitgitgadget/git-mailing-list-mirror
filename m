Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC54C39768D
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388500; cv=none; b=WqhOAeJ90HMD6yWaWBc9mcC+InpLlaUE1/+iRBpNP6nscMjcbM4xIo/q8et57SGG/sLMebfDZUDeU+q6ell07Y/vmZdb1ZWB5bZY0hKgQ2Y2vbE/l/8gt5EbvuGhFm6mMT4/bP+RsBxWoZuWfCFVNKR/dr6zSXLwVxqDKxY5J1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388500; c=relaxed/simple;
	bh=fx3IP+TV37AFks5KziCmc7xf/oZC5Qkoul0wsa8YUw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dyvx7D2PyIDCRJoFnlYSNRAy3+dKSC9F4nJ0a6Nr/ZmBYtQBYQyJiTVW5kGLbXzQcRbyNjysTzYkyhWzms+qETyk/QeGVuiRIFAUzP7uqRJXKeDTqFM3PaldKnNtIMH9kDRJdAHvOxypn9c+wbBMck6ZFoNYpnHCXSr+1vp+b8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNkb4815; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNkb4815"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-479dd56d016so6682538b6e.3
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 08:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777388498; x=1777993298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WM7/vSwLpXvb99PvUw1704JcggGbgnw37ph3GAkO4aU=;
        b=cNkb4815lhKzhvBCgmy2KWfLhNNaNBabW3+HxVMNMwLY6uHC004/XnbhAGu+V3fUdK
         4Yat74+pulLZ/uMudbx0vKA75yhBMqM45Www/jMnQPwRs7wCFpKJZj4ecnLgwaeD3Ni5
         /oaVGyuD4zH3DNow52YCs8ONQamdcGaltfrXLNr2fC8K7JqJvcYzHVTsXK7gttpwzndr
         ckYl0r+G/p6IatD69f/MFrPHWCE8UQ1W3sLbGxQqvNphL+iu3DVOjk9ouJkA2LtZwjMg
         fTQoZhOLoTil/1PcgYkQSzOBL4EIEGiSbglfU8myyVtqDyV4gA2Q6nfObjVu0dhCg9io
         VpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777388498; x=1777993298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WM7/vSwLpXvb99PvUw1704JcggGbgnw37ph3GAkO4aU=;
        b=C2l79Rvrnjru1vbK8JEhy4/uJ37K4j83yDUpvoUCbAgmeAjIFS5kWhmx1MgN2JPMwZ
         OGXaFApq6V+NgQehWVxqPw8lJVKTmewumtoR8qo/iPc8wUIpTidguVufLT2hRIvJv+ZA
         /8xkHsAHLirLUg1W6M5hrOviERA0v1yE3zn4qAIvcYXkqWEGeWNPSql59iKd4L/67rLF
         JdfHVKmeUs5P58AQon013ANXBV9gqvNB1YF48PuoBhtA2PB0SacYS7Hu4BUHUls2J3q9
         2Vf1gStM8VutzpebqsB2ATSQpF9ob059t+LKxCAq7bKvZZzldAVyRzq1CQN69v1u6Hhv
         J8Wg==
X-Forwarded-Encrypted: i=1; AFNElJ8Q0YbeyNVaotkIv9PCQe0ehAgH9fq0vZkqVh9hUOuDyg8+c6duIvvbvGntq/JXqzwt7ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAIjIIEZPiU5iOtAd/7mPSOrQtu9zUcY/VrmZAMQWr9c1WiZDA
	yd2G/S74TpkYGqoIufJln0briiHfMhXQx1HUe9nq9fUsMtbwApVtvlNl
X-Gm-Gg: AeBDietUY+UfLAUxOjqO7hQ3wOapy77nvG55J5LT6+02Wy4LknxRjeI2KSuVYilHMgJ
	dSt2wfINzKMSYDYVzFDJYI4XnvHYnA4uWMP6QQwHkGxzRLwCSP4jD6FMvtqFYxGd6c2knQW6OwB
	Rikmzt2SQKXKfqYVIFLZXn+A8WbgPl5SPmrR6IaeftJPIJHEkZR3J70F6SSDjrrnK48r3gIua4t
	GUi5u+UtsUX8lO/cApp90Pz1+gPC/q/3ygT2t5ygMSFR7aXKEgfDcgt3ivwRbtlJzi2y3CuNlHp
	X+JBFYhyLXK20tKmfMaI+cvaE1DqSAjKYiC4wQg4SHKR+RTGAl8TsE7Ah1I+5C2drLuRJNXB/X/
	pHvcctOvfsEHzSGDqfLzXx+UwoIXz1WCytC75yCATOmaizag4zz43+vnP0nFYnELzkQMDikf4Sp
	mXnebGzWh5bjSd7tSTCrJYjOkhEGIRN3Z9VXt3XdnkXXa7iO4Ovjlr+8qxyDtY995IsrO0VtxBs
	rUmJFVm
X-Received: by 2002:a05:6808:2f18:b0:467:4fb:f225 with SMTP id 5614622812f47-47c28db726amr1692889b6e.9.1777388495792;
        Tue, 28 Apr 2026 08:01:35 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c48c79b5sm217562285a.8.2026.04.28.08.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 08:01:35 -0700 (PDT)
Message-ID: <5c358919-0dcf-41c8-bdf7-912c41f77c31@gmail.com>
Date: Tue, 28 Apr 2026 11:01:34 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] maintenance(geometric): avoid deadlocks on Windows 10
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2103.git.1777380768.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2103.git.1777380768.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/28/2026 8:52 AM, Johannes Schindelin via GitGitGadget wrote:
> On Windows, maintenance_task_geometric_repack() opens pack index files via
> pack_geometry_init() (which mmap()s the .idx files), then spawns git repack
> as a child process without setting child.odb_to_close. The parent's mmap()s
> prevent the child from deleting old .idx files.
> 
> On Windows 10 builds before the POSIX delete semantics change (between Build
> 17134.1304 and 18363.657, see https://stackoverflow.com/a/60512798), this
> results in Unlink of file '.git/objects/pack/pack-<hash>.idx' failed. Should
> I try again? during fetch-triggered auto-maintenance with the geometric
> strategy.
> 
> The fix adds the missing child.odb_to_close = the_repository->objects line,
> matching all other maintenance tasks.
> 
> The first commit introduces a GIT_TEST_LEGACY_DELETE environment variable to
> simulate legacy (pre-POSIX) delete semantics on modern Windows, so the
> regression test can verify the fix even on Windows 11.
> 
> This fixes https://github.com/git-for-windows/git/issues/6210.
Thanks for these patches. I reviewed their equivalents in the
git-for-windows/git fork so I'll give my LGTM here, too.

Thanks,
-Stolee
