Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCCC2E888C
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 08:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773304193; cv=none; b=aMMvsfXa14G/5Icp6nmm7greMqliqJPc33LZuQFSl0oyaYe6WHuZDVQXp1wQH7j+8sIIRbhCdnIAWz6UXEV+cxjQJThWAakdGAUYZyMdKt6M9ibKoG8nB3psRDjV9N5TtXkQ70Iun+82kQRVtjgDUWSvWE8rIxognXqrPYZlQjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773304193; c=relaxed/simple;
	bh=mSX4/URtssf3fH6YMDUUhIXzWrBXql4q+BOO/n/56+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CQeqinMSqkePMD47vcz+WhNUV0BfvnRrigQ43kWNltuG6hg7HgA6tnZarYl36C0fSzVPLEtY08DKI855WJGMdoCr6mfs/kqFOcJIXxjx0PM5C0gk7jNv5WpbqWcmMHFtt58mmZ8j6Bbk7KnkI01mSgdShmOc+aVpJC1F2UOczfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=odoo.com; spf=pass smtp.mailfrom=odoo.com; dkim=pass (2048-bit key) header.d=odoo.com header.i=@odoo.com header.b=JUB6X5o1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=odoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=odoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=odoo.com header.i=@odoo.com header.b="JUB6X5o1"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48534b59cf3so6372745e9.2
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 01:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=odoo.com; s=google; t=1773304189; x=1773908989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WiT8g0s04/WYGrxXkZY2/SQFvf7Xh83rSDf96rdsK/U=;
        b=JUB6X5o1cjOz/Dve0XwD/W+0iar/LE8VUh3cY09tz4szLPG5SZ+9qhlh9QB1OA2JN7
         1BkNG2iEwXFhr0pZtO7G+i1VvEXCJ78509cM/j6SN+iJuOr5Fg3T5IJZ4RzvggPFWxgC
         82CizCw9ZxZkgitCbtrFJh/+IRcIkdk2gxzJf52vZEKMhsrOXE0UFGV/vC0GA2kYQdIW
         XcdReZ0fZpI7cdbjp4YVT2fAblkbRvl9dOPxSZ4fSvMhI9/+B9gx7KHoYGNLYgd7Gn53
         hU3vdfi0xs1ixR/4pdetqCFF4mLBqj3WuJ1vEUNrJi3YE6NuO2s+kV6fRNCFejnUe1tm
         ezAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773304189; x=1773908989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiT8g0s04/WYGrxXkZY2/SQFvf7Xh83rSDf96rdsK/U=;
        b=KuQ0HR/hhIONycWfBar/tW4/pWNy+D/WQDKWUVzs7d7nLhoCJ1QoDajwuZkQrAAOmJ
         yxwTVVfNYUfDBYFJ1r4RJb008E/rN5YFP0RAOn4j05PLtQGOxLYAigc2tnzX/SoVTqty
         5UDm/lj48k9nIRncjg3T62zcvwafvSXKmQUBraFRzn1tlYmTmtR35F1UsNyLVioZn/VE
         d3bwUIngSliKd+ue4YbUO3eUXY3jxFAe9dddnecsE8ThKUG0YS+J7Wqsyv2lREmA9ciV
         /KELrkTZlHe+ilD715cYVke0lzXAUGQgH0Zbox7rDQiYwyoLMcJphcaUGFz5yS6mqwiD
         z3Xg==
X-Gm-Message-State: AOJu0YxuY2JAGLvik/XAUXNQJVjN5MXkBhJyb7QFxKarwDKgnDGRrOOp
	BUbPatIyuX66tjuiarvM9zyEiZzruSLso6LTYwUCOxSrBfdri+TO6J7vVAY+LYNMqBTDcqc0RCO
	ZLXPD
X-Gm-Gg: ATEYQzwf+uePp1/epF6oTSa4QUM/W2eU39SkA6rk/5FwhR/DqZXO+h5gCDC6845S8+A
	6eDnq6d0Ocv+vI+7Gd8edumFrIqJbPCBBEKBxGfEwzCBqRWr/8+EFWPqMy7cGqhmOkXmUMfdnhQ
	ymJuMwGAoNhZgy++I6LySL6mIGq+VOhG89BaTuAXE6Hs+eK55E9b4isfHwJiF15Nr1ipQIZlSaL
	kqmTs9GXzmDRuH2XUYUZzuO0p9Dcdji4wtNI3/FtF692Dq9ceqOgCbzUQLhoKnKfsD+uzat44jA
	d5f2awn3cdArRUVg1cxpdpa7yzSx120ujtX3E/DJ7TCp+RuE69QB8aNX/8e24ZJMJEkKzHIycjk
	Gm69jgWkjAcFIJYAVxZO4sTq2aRXFFl9CcCtMVbR4tEN4YudJnhahlHJ1xEFE0FMdWFFTi9ft7u
	e39rTQJmIeujy7ht976RUR7YsRIId8jNAPU/7h8FxK8KCKI1+O+5CsrnLGfrUFtUY7Bt4=
X-Received: by 2002:a05:600c:3114:b0:485:4526:ee06 with SMTP id 5b1f17b1804b1-4854b0bb7dbmr88698405e9.11.1773304188728;
        Thu, 12 Mar 2026 01:29:48 -0700 (PDT)
Received: from [10.30.68.14] (ip-94-140-170-249.reverse.destiny.be. [94.140.170.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b47145dsm109089405e9.0.2026.03.12.01.29.48
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 01:29:48 -0700 (PDT)
Message-ID: <53b70129-7619-4b48-b77f-b7dcc9d4366f@odoo.com>
Date: Thu, 12 Mar 2026 09:29:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git submodule using worktrees?
To: git@vger.kernel.org
References: <5152ce98-b0ce-42f2-bd34-1cc324042f88@odoo.com>
 <d8e84ca2-2e86-4cdf-a1db-b6d466677fc3@app.fastmail.com>
Content-Language: en-US
From: Xavier Morel <xmo@odoo.com>
In-Reply-To: <d8e84ca2-2e86-4cdf-a1db-b6d466677fc3@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/03/2026 09:20, Kristoffer Haugsbakk wrote:
> On Thu, Mar 12, 2026, at 09:13, Xavier Morel wrote:
>> I have a number of fairly large projects I work with, for that reason I
>> have a bare clone for each and fork off worktrees as needed in order to
>> avoid unnecessary duplication and pulls between them. That works just fine.
>>
>> However when I tried to use submodules to provide a unified view of some
>> of those projects I found out that there's seemingly no way to have
>> submodules created as worktrees (off of a shared repository), at least
>> not built-in. It seems like the submodules do set up some sort of bare
>> repository / worktree situation but do not support passing in an
>> existing repository to worktree off of.
>>
>> `--reference` with `--dissociate` does avoid unnecessary fetches on the
>> initial clone, but they do duplicate objects (and without `--dissociate`
>> has all the issues of a non-static shared alternate), and do require
>> duplicate fetches afterwards to update the submodules, even if the
>> central local repository already has everything.
>>
>> Q1: is there any way to massage the submodules into working off of a
>> central shared repository? Poking around and messing with `.git/modules`
>> didn't really work out but I may have just not poked the right bit,
>> having to set up the submodules by hand (or via a bespoke script) is no
>> issue.
>>
>> Q2: is there any chance submodules will gain more first-class support
>> for worktree-ing off of a local repository in the future
> 
> Does this also not work if these are regular, not-bare clones?

As in make worktrees off of non-bare clones? I don't think that would 
make any difference, to the extent that I tried things out `git 
submodule` does not seem to accept a worktree reference (a file with a 
`gitdir:` path) as repository (in `.git/modules`). Although I may have 
interpreted the error incorrectly.
