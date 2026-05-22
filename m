Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB65D37AA8B
	for <git@vger.kernel.org>; Fri, 22 May 2026 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779469061; cv=none; b=mT9ywJS3vsi+tbW+m9lWLr6OJ1wjzqXLGaaZn5jfH386Zb5F5RpSn08HY1LTrZlzR6QrITiTz11PsYR0tlsiQ3+cmfB4+6r1Rmm0ZGgdQc7Z8mTwRm3cmrFvR+cQS9jExmajABZ92YnFa2NZEIcGfNTGkR2eQm3vQGJ+aZwfQV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779469061; c=relaxed/simple;
	bh=rzQkhLDa+ml/PsinfZyYe0aBLVxjUuZvJN2uAH6IZpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ad7cY1y24f4DqFF4gYjD/xxQV3KF5ZCYMwI646Z84wQD6QBtLf8jdpR/ox/8dQbDfUzbCbaD5m5KJbFQc3/1l+zkiF9fmEoVkToSgO/7LtOtDs6zErrW4MYORpydWJBRFOkb5VxSmgUiIVFByJGI0UIbuX1wN96Ntdi7LONyFdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fr4MOvJ7; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fr4MOvJ7"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-914c1ced558so11721085a.3
        for <git@vger.kernel.org>; Fri, 22 May 2026 09:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779469059; x=1780073859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TAdQcqlFDApTTi+wxzCgoDfR5Nslr8aKKOnOHj8Phus=;
        b=fr4MOvJ7ZvgG58djrKosRsU+q/Re5FfwL6l39ZaSLDyICnuylt9wcEN2srPL/HnJH8
         7FhykqU5XQqvmvpR6/qlNbcL0DbhL0yRwyvwN57a+TorosPO2M9Fmd0ofa1nvo6XgUbN
         H98QxbUp1u0r1fhFiY9vHVLT1qO75jrjNXpHfP5Y4fFVkhPWx6I68quyfdpm7s0eAsiS
         MJxOEbSvtjxu1uBpG2C9vS04qzBEmvxFKM6BaqLRmW9Bi9PHlOQh1TiphSUgaWyGWAe+
         bIe6LBhLvqeaoALVy5Z0UBFQHtRI/HkYK5GggkxT0+QzgBs1GrlTM0UpwasrLex2E3Wq
         AjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779469059; x=1780073859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TAdQcqlFDApTTi+wxzCgoDfR5Nslr8aKKOnOHj8Phus=;
        b=b6FMJrH2DRJdX4iTX8vf40Wkq8i2EHm08ZlBOy1Zgx+9YQqhk22ma+CmWakLzkh3q5
         xoFyBK5+mKxGjDsYlWXf7pR27lNV2cbHa2WOI52HfxbpowmN2SbmjRNbhR1MfyZUty1v
         eFfdIDPWX6oqbBssAW3p5W0cOQEnYjn9tXSHu1rufChFHzw2bBQ243bNfZFt/1dkSTwJ
         J9oqkBHJxkzmNbcKtxc88bcz64n3UpOCr8jTkZa79u8rg5r2Z/gtMB3YTCq+miNA1JMU
         i+B7sOWEXHjmaXGd97ZxTnWClJrPZYk+xky1Y8d61VnqfVUvq3QlA6F1GlwNkFc59w5L
         /S1A==
X-Gm-Message-State: AOJu0Ywqtje49zpYI9C6n6nnCU5RHpVXt7pT1zMxxlaBQabxSFTnNrHH
	Oma6CIL7QpCv039kugVKsqWv2VcmTzb27RFVrALWbrlecarzP7TsH7YM
X-Gm-Gg: Acq92OE1NP4g/8gTuv9HpRzvc7QufXq6GYZl4G5Qa1ZVFRGBTgpnkVNUAHDiq+Kgysc
	yk4Rxv2BbqmxG6xttkspM41TYcnL9xTm/30bVc5Lt8d9vx7PeKX+5peLBEdIDwYjTJW0RWSCFON
	r7vAmjKFaXvJx2VFlstFX1nGw/Kay11DVJ9hbciUIDloHnyfd3u8wsFnSgbZWvvpuaWuGd/NGNj
	TYp4GDZpcO9MzPY9AB7NSdL4MvLUkh67RGpCh4YTo6yAI+85oJmkLHNJihC5Zvh0pLqoCqICGpT
	8nYLq3MkudSNUWnCujQlwDLwPAUnT7oVXXsnZ2aFTn+jhamv3J2EbxsdsQVPfWeznFntcNh+AKp
	NgxDpVcRjhEQoIH0xFYYKdBgGjq2MIny+yDgUykxVk7JUvt3wv2pCwpYnUWwGKgyIp0QW6ssy7t
	nw0iUjNurWTThASIW8VV217EVyewsQ4SXMzuB5VnxkNgFUrNkc70qDG3UpauBGosMzfVoS0og=
X-Received: by 2002:a05:620a:1708:b0:912:c611:8110 with SMTP id af79cd13be357-914b49da8f9mr629672685a.46.1779469058592;
        Fri, 22 May 2026 09:57:38 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb9d63a3sm176476585a.23.2026.05.22.09.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 09:57:37 -0700 (PDT)
Message-ID: <8d03455a-82dc-4d32-aa57-af3d92714e31@gmail.com>
Date: Fri, 22 May 2026 12:57:37 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] git-gui: try harder to find worktree from gitdir
To: Shroom Moo <egg_mushroomcow@foxmail.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
 Aina Boot <bootaina702@gmail.com>
References: <tencent_9FA5CF10A1D7CAC770366E84AD5CA9A2D107@qq.com>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <tencent_9FA5CF10A1D7CAC770366E84AD5CA9A2D107@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/22/26 11:09 AM, Shroom Moo wrote:
> On 5/22/26 1:45 AM, Mark Levedahl wrote:
>>> Additionally, [file exists {gitdir}] checks for the gitdir file in 
>>> the current working directory. Since the function has not yet 
>>> switched to $_gitdir when this check runs, it is almost impossible 
>>> to find the file. Consequently, this logic never triggers, preventing 
>>> linked worktrees from being recognized. 
>>>
>>> Maybe the identification of linked worktree should not directly look 
>>> for the gitdir file, but should check whether there is a.git file and 
>>> its content points to... /.git/worktrees/... ? Anyways, using the 
>>> literal {gitdir} to search in the current directory lead to risks. 
>>>
>>> Shroom
>>>
>> We cannot get to this code if not inside the gitdir, and if the user set GIT_DIR and/or
>> GIT_WORK_TREE to do something clever, that either worked or the code already threw an
>> error. git, without GIT_WORK_TREE set, uses the current directory as the worktree, or the
>> parent directory containing .git. So, we must be inside the gitdir if this code path gets hit.
>>
>> Mark
> The relative path issue with {gitdir} is indeed difficult to trigger 
> in practice. To trigger this problem, the following conditions must 
> be met simultaneously: 
> - git rev-parse --absolute-git-dir succeeds (the repository is valid). 
> - git rev-parse --show-toplevel fails (the working tree is 
> undetectable).
> - The current directory is not $_gitdir.
> - A gitdir file exists under $_gitdir (i.e., the gitdir of a linked 
> worktree). 
>
> Unluckily, this occurs in:
>
> ```MINGW64 Shell
> # Firstly, enter a test folder
> mkdir test-main
> cd test-main
>
> git init
>
> echo main > file.txt
> git add file.txt
> git commit -m "initial"
>
> # In feature branch
> git branch feature
>
> # Add worktree
> git worktree add ../test-feature feature
>
> cd ../
> cd test-feature
> cat .git
>
> cd ../
>
> mkdir outside
> cd outside
>
> export GIT_DIR="/(PREVIOUSPATH)/test-main/.git/worktrees/feature"
> unset GIT_WORK_TREE
> git gui blame HEAD file.txt --trace
> ```
>
> ```Wish
> puts $_gitworktree
> ```
>
> The current directory is "outside", not the expected linked worktree. 
> [file exists {gitdir}] in find_worktree_from_gitdir searched in the 
> current directory but failed, resulting in the inability to identify 
> linked worktree. The blame mode can still work without worktree. 
>
> Shroom
>
You exported GIT_DIR pointing to a valid gitdir, and as documented git takes your current
directory ("outside") to be the worktree. This is working as expected. Had finding a
worktree failed, git-gui would issue an error message and stop because you defined GIT_DIR.

Mark
