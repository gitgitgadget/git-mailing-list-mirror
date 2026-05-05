Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165C7270540
	for <git@vger.kernel.org>; Tue,  5 May 2026 03:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777952453; cv=none; b=j9AFqgth8eBB4UDbfI+t7PBdNRwCE8II/w6b4kphaoFGcwgnq2a52G8TqYpxYhRYgTc9540rgpRTy8fHd+/N0DtmJn7Asp6QPIeswKeOvQYJntcIwW18SQbstMCm2s+Ikq9/rtsHvVtZ+zDNHqlTiaXeAc408i+ZSezw+l4BLyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777952453; c=relaxed/simple;
	bh=s+AIKR+eC5c05UN0Nf4i0YQHING3XW7E57pNc5fYSxM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mD3cCcp6IuODi/OFkV87TXaBaNwADyOHJOwzxGzoFLpaGBTGuqZnWA7v3CnbNAMLjQsbzWI5Tma8TztdCyfKTdD7CPxgbmvMZ3BXvrwfTt1LiBDCPWwINKBWovKEcDZ4gFFZhL6q/o32fi/GpXnhtSaTKRRGL5+UDvH3ZiKRvmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZthNpmP; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZthNpmP"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8b81586dff3so28343766d6.1
        for <git@vger.kernel.org>; Mon, 04 May 2026 20:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777952451; x=1778557251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s+AIKR+eC5c05UN0Nf4i0YQHING3XW7E57pNc5fYSxM=;
        b=bZthNpmPR8ONKAOdmvDKsPCabNjaNSLRu98FrLkVqoOU4zGiuRpJbYUKbPqOQC9Xqm
         bgD51xfScvC+41mgy66h43njWnKI/JSkhn/J1QD6DfLm4/oM91bZv58QhszyVyHn+vw8
         J9P1b2CYvBamxWzt5zms5Gwbrc1aB90bwPetrhkho7nq8dLhE0Wy0eJKBxpglfxMkxCD
         hOnYWnqqU15dl3G4kMnf3w3MLVGFWAc0EytUBs6C4+wRoIq1BjS6g8K2cPU+ftI9d4YK
         KF8Q+kC2EaYMJukk4Pe71e8WOgWciZwVHHphrcEdH6lqIyqVrX6GDVZpPcCKyZ/Sq8JF
         bncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777952451; x=1778557251;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+AIKR+eC5c05UN0Nf4i0YQHING3XW7E57pNc5fYSxM=;
        b=j2jSefawF1II+8C+UOga2exqq0gKqBUz1rUJbSKDfaqWC9XqE4JDCZJ9/Ehq9+mK8K
         OAkOI/dwlMSUpRLbJXNDLa+EUozrIHbpiLPAIc9yhkyxVzOUz/u0RQbKbIHOuBjPjzzt
         +r91mTx+MDRd41YP0WMwAW8TA+mRvY6D/gDl2fNfmukUUnkbj3ZUFwk47M1ChQtQajKh
         RvRanp5ir/w+6dQvAh0r3twtcF+RpLdwf7+sO85n4myKJWFfLJmaVG2pjofjRdivn1g8
         FEPNJjYQhBEbd5+d6r5XNGeB+zLcHNk+zVUg/2rlKO60+F6AaqC1p2XnIJMQbjSMc2ck
         O5bA==
X-Gm-Message-State: AOJu0YwGEj8ckVKW+Tdn/9HRv8UqhJ5n/YNw1fCwzwJPSZZNMBE8/Fqg
	oJE4zSJjddSy5ogTqi0rEF/KzO5L7Y0E4ioUuX/xIrPs4TrLaizQpKcRRJu4tfSj
X-Gm-Gg: AeBDievTXFS4rIsS7yw3TroIocbdfRjCyqUdBuH3jslmy3ldFuC0Jto0pBiIet8Wd92
	AvDA9j3FNRtvxcfv5P0SC33xasyrXUhXQOn5VhTVEzpDD404Oot4h2O2e1Zb41LxUyCpuDHqdSL
	nHrxtU+mhyJQzLT3s753YdEEn4+yNLUfoD/jvDiG3Mvlr0mm83IoGMCCb9BBNjI+pO0U7aGZASb
	Xh6HtbgdZgnHArIM3N+y7ViKLy9wjUO3oDcekmM78cvK2Tnzm4uNaCqcFXGqipfVD/KUNm5JiMn
	WSoI3qc4AMXiu6dNqxEJZ0psXBYr7ic+tjYA0gmphc+vB/fMzPRONtdEVnM2x7TmqHZwOv9iV7C
	BfpF9wWzlry+bRnAavS4vOLhUxvCMymuoxcGewzXBuBnc7deoyOuZAGoEkzPknaWBDToWnQx+pV
	87e5mKuA/ap7E53xQvqWjthE/jhMZswZfxmUM8LAIO6xaS
X-Received: by 2002:a05:6214:3204:b0:8ba:942:3e38 with SMTP id 6a1803df08f44-8badaeca19fmr22936226d6.19.1777952451039;
        Mon, 04 May 2026 20:40:51 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100::59a? ([2600:4040:264b:4100::59a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b534ac8ef3sm143547236d6.0.2026.05.04.20.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 20:40:50 -0700 (PDT)
Message-ID: <f01d89c0-12ae-43b0-84a5-9e4132f584f8@gmail.com>
Date: Mon, 4 May 2026 23:40:50 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] git-gui: handle missing worktree and separated
 gitdir
From: Mark Levedahl <mlevedahl@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, Shroom Moo <egg_mushroomcow@foxmail.com>
References: <tencent_AEE968E8E785907BA55A383977C8968ED406@qq.com>
 <tencent_8A236D9D4A8D8CCA7DAA083157AA8543700A@qq.com>
 <3b0b37ed-1a5d-4fe1-b2b4-7db67a62a06d@gmail.com>
 <77219c75-7968-413f-a642-0446145c8023@kdbg.org>
 <a1a7237c-ffed-4a7a-ae58-55769aaa4453@gmail.com>
 <93e1c61f-e58b-4a0c-8ece-7a8d945fa900@gmail.com>
 <73b99b54-1d39-45c1-bd06-26ac1008fddb@kdbg.org>
 <7d5cf952-badb-4071-a0eb-af9443fa8b5b@gmail.com>
Content-Language: en-US
In-Reply-To: <7d5cf952-badb-4071-a0eb-af9443fa8b5b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>
> On 5/3/26 4:53 AM, Johannes Sixt wrote:
>> But perhaps there is a simpler solution: Let's present an error if
>> --show-toplevel fails except in the case where the startup directory is
>> named '.git' (and is a valid Git repository) and is not bare (then the
>> worktree is the parent). I insist in this exception, because this
>> use-case was considered important in the past (87cd09f43e56 "git-gui:
>> work from the .git dir", 2010-01-23).
>>
>> -- Hannes
>>

I've restructured startup code in line with what I suggested before, allowing operation in
a worktree or a gitdir, and with various combinations of GIT_DIR and GIT_WORK_TREE
environment variables set. Unfortunately, git-gui's blame and browser commands simply do
not now work without a valid worktree. The error(s) are not obvious to me, and bisecting
requires git version 2.24 or earlier to remove 2d92ab32fd ("rev-parse: make
--show-toplevel without a worktree an error", 2019-11-19) to even start: many gcc and
git/git-gui version compatibility issues are certain to arise. I won't be doing this.

So, I believe your suggestion above is the best path, leaving behind dead code that
purports to support operation from a gitdir but does not.

Mark


