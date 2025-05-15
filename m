Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A949A284662
	for <git@vger.kernel.org>; Thu, 15 May 2025 10:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747303743; cv=none; b=DK0EnSSsceXlqzwZ2X3f+yiAIhUOF8pguMO8bmpnqwockThZCxZowNiYpGL8fn7PydK0GNHleId6n6YlDrERQKZTQ33bSc8Y1ieku1Lw1dnVKrPAnMz8Fg+/wPXPndidKk7QdWjYwB4DPixjP8N7pdMRRwEw43Y4coZZdbEG2FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747303743; c=relaxed/simple;
	bh=FN9KDttQnwV5lLRsejYezF9ju/L6GTuULBYjuvQklBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVFpeUkuVz4P0SvIBPZOaeQglqdTIyc/cDmYS5BOenkCbLUudZcwAXp3TeOznmP8WpsiFU12+vBRnsVANSxoA2QuJ+zETF7yGANx2I77/SXPKTcmyVQyU681staJFSDJexnzA1n7dXL376LVGar0QrSNuW+2V50p6Hu9NoXzkxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQOrVNaM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQOrVNaM"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf680d351so11188915e9.0
        for <git@vger.kernel.org>; Thu, 15 May 2025 03:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747303740; x=1747908540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dmBiCiCD0s+db4E3sCvwghxFDL/EY5MUIGeEUQEo5s4=;
        b=BQOrVNaM9grANCojjkOsVIYVRV66wLV3Uc4Lvv/sjoPrd5LfcVRrRwlpb+3K10/BlM
         vVKSWxapD/zCIZav7Z0vbkwAUOxuJmUWoZTVrpNq9SGv0YhCmqLo9qofyJbfR28tD6IB
         v/WgfdPp8/qLayGK/84NZ92tMlC7mJB4NZ4GrrmwtuT8SX3nLQyMAgxWY7VLol+bUroj
         h2JFrx4EBNPyoQsNqks3hE+ezio+n9tym67rHDzgB6HtXQ9tzkJ3KMGMcH22y7owIbBl
         NhRENi1xMfl32AjuHmYsbED9QzaoeyGh23PjW7D31YPPke4qhDvWuM9e0ooMbuG3lYQI
         IRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747303740; x=1747908540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dmBiCiCD0s+db4E3sCvwghxFDL/EY5MUIGeEUQEo5s4=;
        b=JJ3cdUjekqZmbNNGHgkbYFqmkqiG7sBYDOln+GigjJeCHf/3nAuhuGFfo+jmtqYnlt
         CXbt5eDDa6As/Z3IpG8PdnygaBHqEb+C83LDq1LYfSH5XnOOZTDir3lXzt/zUX2tme2x
         wEOImVPTXjjJzxZj6eiTnbWjaGMM6BZMffyoMYUzGXOWoTrRu/0uMyFGap/q7LyF61j8
         3/8orll0oYwahY8s4evFAK57IS6L3OAlnkqS8d5TuAkl45K+R1hlYANJvai5xbD7Wmwd
         VkHsx0YzCZwI4Jxii3baK31p64nmRlDwGiDB8kpcKEEs3YHLu5CMvrKqHOy7wW1pwTEe
         VRUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2dWOXtBvcvmlGsceMoamcmUet7Pp+O4PTPTPIRm3LBnJWn+y/bKREocnxRk0cD1Kz2Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPqBRgiYzWwXWjeLceLED4gxXhJUG6yGsDvOEoGVY4wFjvYQaJ
	yRSWpXPkuUGAwu8rPJJa2zGWebDkj9hr4CX43cU5V3pUn15zBBTUtJXH
X-Gm-Gg: ASbGnct39Q9PNgb+bzOuWdeA51P2F25T+PBIXjag608w2daKuim6ZH2H5DuQin2INpW
	1WNHXhctyTJ7bes+kxf/GoQRXG5oEL1vcg5ntzqmfH6pkO9zq54Ud/kgTsgUWU0Im8W0ONVW1TA
	aJ3AUD0NX3IZctj7aUWikhjdyRW/Z6HqsNR+ZuOF1w3oV6viPuRPD3PxbUBoL6pY1xXLOfKQMzI
	KNDQxhwEqCgcUlN5rfvY6q4+Tpzf4vxAwmZb8NqLjEe6yjlRFb9b1LKmpltf3aJ0b15/cvGDbfv
	GjY6/Mnzu86nK2K67ePQ4KDHJb/i/Xol+ikc4La5cPS+yUTtDDyYEQCCyRZv3M/eL1alzBsHYlW
	L
X-Google-Smtp-Source: AGHT+IEHJuCPUqawpb1aT+avoFyP3kTYg3gpvwyIKc4w/nAH6NKzfxHIQ1kWLFr5YYYc4SMZ32eShg==
X-Received: by 2002:a05:600c:3e8d:b0:43d:174:2668 with SMTP id 5b1f17b1804b1-442f844e5d4mr26009205e9.0.1747303739644;
        Thu, 15 May 2025 03:08:59 -0700 (PDT)
Received: from [192.168.1.194] ([84.64.112.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f6f9b309sm41897065e9.30.2025.05.15.03.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 03:08:59 -0700 (PDT)
Message-ID: <52e0a717-f7f0-401d-b621-f1f6e028e595@gmail.com>
Date: Thu, 15 May 2025 11:08:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sequencer: fix memory leak if
 `todo_list_rearrange_squash()` failed
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>
References: <pull.1965.git.git.1747230808770.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1965.git.git.1747230808770.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/05/2025 14:53, Lidong Yan via GitGitGadget wrote:
> From: Lidong Yan <502024330056@smail.nju.edu.cn>
> 
> In sequencer.c:todo_list_rearrange_squash, if it fails, memory
> allocated in `next`, `tail`, `subjects` and `subject2item` will leak.
> Jump to cleanup label before return could fix this leak problem.

You could mention that you're adding the cleanup label.

I suspect reaching this condition is a bug as well because we should 
only rearrange the todo list when the rebase starts. However I'm not 
100% sure that it is impossible to trigger this condition so lets free 
it as you suggest. The code changes look good.

Out of interest how are you finding these leaks?

Thanks

Phillip

> Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
> ---
>      sequencer: fix memory leak if todo_list_rearrange_squash() failed
>      
>      In sequencer.c:todo_list_rearrange_squash, if it fails, memory allocated
>      in next, tail, subjects and subject2item will leak. Jump to cleanup
>      label before return could fix this leak problem.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1965%2Fbrandb97%2Ffix-sequencer-todo-leak-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1965/brandb97/fix-sequencer-todo-leak-v1
> Pull-Request: https://github.com/git/git/pull/1965
> 
>   sequencer.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index b5c4043757e..5fb7b68a7ab 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -6596,6 +6596,7 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
>   	char **subjects;
>   	struct commit_todo_item commit_todo;
>   	struct todo_item *items = NULL;
> +	int ret = 0;
>   
>   	init_commit_todo_item(&commit_todo);
>   	/*
> @@ -6626,8 +6627,8 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
>   		}
>   
>   		if (is_fixup(item->command)) {
> -			clear_commit_todo_item(&commit_todo);
> -			return error(_("the script was already rearranged."));
> +			ret = error(_("the script was already rearranged."));
> +			goto cleanup;
>   		}
>   
>   		repo_parse_commit(the_repository, item->commit);
> @@ -6729,6 +6730,7 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
>   		todo_list->items = items;
>   	}
>   
> +cleanup:
>   	free(next);
>   	free(tail);
>   	for (i = 0; i < todo_list->nr; i++)
> @@ -6738,7 +6740,7 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
>   
>   	clear_commit_todo_item(&commit_todo);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
> 
> base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75

