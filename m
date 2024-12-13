Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025A01DF759
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101608; cv=none; b=dkwKnIScwvc6uTuG87cW/ilimSzgZ1X+s/n0lGh+QEuGJVQkCtvMYfeiPcfDitANousug/Qxnz7s9xsX6X+KD6TQAPzzktJcLU9duFrC28hfuPKhQOMroLWauxuh2l1UAFzcPlA98s6v+a+CoCF3Lo/r1t4V+CRZuKPUuTvKPh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101608; c=relaxed/simple;
	bh=fe4PULHbt+iPCTAUCOQj0zBgHFqOvI4MlG0VlxXI84A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rQ8ISu8qwtKfZ//YoPf9eSoTvM5bUquCikNULrNtcTH0rxIc0ty5jZq/PO2DWjxC5vBzbmZE9JM0KjPZNk/ynDMbdZeeEhDiuR4jlAKJfw/AVCZLntnu/LZ7qH060d3kqfKqVfrB84iaVYmEWoO/Kbtais6suIXrTxYPfPeyzHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8ttLtbq; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8ttLtbq"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385deda28b3so1370857f8f.0
        for <git@vger.kernel.org>; Fri, 13 Dec 2024 06:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734101605; x=1734706405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JJhn1KkaH2wJnyyvDwEbIYIEFwp9hGHJ1u7zCJ4HEhY=;
        b=W8ttLtbqt5TkMxP9FPmAd+nOrr7u28cJywO0uQCxWBwBf8LTZRaTIxyMU2I2MTQlFS
         XYkSkGlzlSn2nC9UQXyM79GVyoxSJRwtoRNl5l+IakuTXQmfD2bYMo3XacDTuEx0kUJp
         4JY8ab3QIgk3lnwHfqYyD3FhDHzQzTgf+BLHkUnAc95vMS3EX/k/2MIBIwxRPU6Nn2ti
         siER84aD7SoqbF7imnZn8ZSyv79ZuwGZykhD0BreuNYo6Qz//TtXJqqqOvNMJ00QBDpq
         p8BTbCW8+fGLIw2BuOkWxsrz5WaEqYUWF4S53vSsBKN2FkwPSKDvlpn2osOi8ThTnuqQ
         nTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101605; x=1734706405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJhn1KkaH2wJnyyvDwEbIYIEFwp9hGHJ1u7zCJ4HEhY=;
        b=rdzKpGTsInHD6dKGYquUoD4j/uRVYtkbVsrKfd8l9YwTK0T52FJXvZsHVogMHC1+oA
         kv1fyi2dPSpIg78h6Vg1coQSufD+Do3d7hoOWG0vZNtr6iMvsAitsoloJC8TeAbG9lLA
         InUEzopNFGtRR7dZqCOtq0Ll81OlMXWXb4zzUDMWPwwtyz9ID5q5LAcUKxInE2u/gqBR
         blpyKZnc0XF0UCYPG79qn/rzgeQJkofEZ0cOcFPzROBdmeTm+B7goZHpgyUaPYLmZfeC
         9Rbe34QyXqlQKq9uc+ZExyTqDSs97BFf9yjP0cuX8Ut1Vr7khDW0EpHV13+0jG8FFRIo
         q8DA==
X-Forwarded-Encrypted: i=1; AJvYcCXcrKHAv3w8x4M6y7AyiZm5Uh5lmeTcikTJGnHbBCA5E82bj5bc4cjoYBmV1oj8Yw2qK5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvIvrdQi4vu5bp+KUoIrW7kw38YtI8SgC1XR/w6ltxhETnmKYK
	rlEput7beQ6ROmcVduIvLl05oLMJlOeenk3GDq90HjykYGOrin+8C3PbMw==
X-Gm-Gg: ASbGncvS94Db8NsSu+sTc7Ktrk6Wl09royYhq54d3Re7N6Pj8BJT2EuxekqtraLunry
	RzCVJ9s59gTMND+PS/DP2r3BtHQQouXrDo9XSpRmFeGaGDrY2ZGUa941x/mT2FfCiNPF9RzOf7W
	8KoTKDlq6ixA2y+XEPvKgymwSRGjoNZxRZOS/aazMIlF6f5duejRrqL/mjCtObtbHJrmN8At6NG
	aUVPuNyQpPxbEfujBUqp9J+FY2/kQR3uL06GmJuwnbOd5Ez4umtGSQvGmrvzS6xG29QVIV/Lwk7
	XpqrPuFLyZVqOjnHs+W7DubFP8GxZoFuJhA=
X-Google-Smtp-Source: AGHT+IHPqlZlAx/xFbkPudLj9ZuOV+LzybX40/bKo/oiot135VIFTZcvQyvTC67QIwngRcR7slOb0A==
X-Received: by 2002:a05:6000:18ad:b0:386:3e65:5a58 with SMTP id ffacd0b85a97d-38880acd57bmr2325018f8f.20.1734101605025;
        Fri, 13 Dec 2024 06:53:25 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:62a:6d01:db19:6b99:fd5f:b9c2? ([2a0a:ef40:62a:6d01:db19:6b99:fd5f:b9c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514d35sm7429757f8f.74.2024.12.13.06.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 06:53:24 -0800 (PST)
Message-ID: <e56b3047-3af2-4353-a0ac-d3af65fe70eb@gmail.com>
Date: Fri, 13 Dec 2024 14:53:22 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: failed to read .git/worktrees/test-worktree-xdrphX/commondir:
 Success
To: Brendan Jackman <bhenryj0117@gmail.com>, git@vger.kernel.org
References: <CAJUwWUMQF_tN_hyBMh+F4NtAHVAx1z+g0HYY=PD9-jd5RdcR9g@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAJUwWUMQF_tN_hyBMh+F4NtAHVAx1z+g0HYY=PD9-jd5RdcR9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brendan

On 12/12/2024 20:23, Brendan Jackman wrote:
> I am developing a tool that uses Git via its CLI. The tool creates a
> bunch of worktrees on startup and tears them down on shutdown.
> 
> When running its tests, it does this a lot. Sometimes, the git
> worktree add command fails with exit code 128. The output just looks
> like:
> 
> failed to read .git/worktrees/test-worktree-xdrphX/commondir: Success
> 
> Naturally, whenever I try to strace anything, the bug stops
> reproducing.

How annoying, I suspect it is slowing things down enough that the race 
condition triggering this error does not happen

> [...]
> Any idea what's going wrong here? Is what I'm doing (i.e. creating
> worktrees in parallel) actually legit?

Unfortunately with the current implementation of "git worktree add" it 
isn't. When git tries to add a new worktree it first checks to see if it 
already exists. As a worktree may be on removable media it cannot simply 
check that the directory does not exist, it also has to check that there 
isn't a locked worktree at that path. To check for a locked worktree it 
has to list all the worktrees in the repository and if another process 
is creating a new worktree at the same time the process trying the list 
the worktrees ends up seeing an corrupt wortree because the other 
process hasn't finished creating all the required files yet. I think 
this is fixable in principle by teaching the code that lists the 
worktrees to ignore ".git/worktrees/*.lock" and creating new worktree 
under ".git/worktrees/$id.lock" and then renaming "$id.lock" to "$id" 
once all the files are written. There are probably some subtleties 
though as we would need to ensure the processes that are spawned to 
setup the worktree use the temporary ".lock" directory.

> Anything I can do to help narrow down the issue?

If you're interested in fixing the problem the relevant code lives in 
worktree.c and builtin/worktree.c. The easiest solution is probably to 
try introduce some locking in your program so you don't run two 
instances of "git worktree add" at the same time.

Best Wishes

Phillip

> .:: Details
> 
> I've built git from next on Ubuntu 24.04.1 LTS, here's the git
> bugreport output:
> https://gist.github.com/bjackman/3377add9e8d7b747d9f74b52518e9101/edit
> 
> But, I also experienced this issue with the Ubuntu packaged version of Git.
> 
> The application with the hacks to add logging of Git commands is here:
> https://github.com/bjackman/limmat/tree/git-bug
> 
> Here's an example of the test failing in CI:
> https://github.com/bjackman/limmat/actions/runs/12303338582/job/34338222752#step:5:337
> 
> If you're willing to try and reproduce locally, in theory it should be
> enough to put your Git build in $PATH, clone my repo, install Cargo
> (https://doc.rust-lang.org/cargo/getting-started/installation.html),
> and then from the base of my repo run  `cargo test race` in a loop, in
> my case it usually fails relatively quickly.
> 
> Many thanks,
> Brendan
> 

