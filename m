Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A61219DF6A
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728483728; cv=none; b=SAGld+PBgy+CFWHwOgdZcxD5GAj2m6xdSDIQxmDZ0OYyW4h72KmBWFwdZIG9K4JfHOfZ2+YGoudRBFihTj2jW3S+c/UybkoQ6VYPBfWjpf73bWvmV47jSQtsw1wxJG/YwoRV1N+wVfRN86SLOM0PTF0v/h/9Ilkgh07YF1+Tbz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728483728; c=relaxed/simple;
	bh=ssz6Yupt6yKCwiVCL4ID2ojClbm5tzAfR5guY5GI/Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ph5Nwanh9XElyRo0sGW3xhU/wnDQWsZP58XyGdfjhTA2cUHlfWNOfHCH1jCVDovEWUUzG65Q+WLlUoEYR328EmMxMo9FJ0V/OtrVAfvmCyEOYSs0H/xwHKfMbx+0mIM987URIubkErpnhpUUjIdkzsPRxj58bL/tbURoiz3Ee/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3grw1j/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3grw1j/"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4305724c12eso12345175e9.1
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 07:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728483725; x=1729088525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1Pc2OJnKGOq0d4e3aFgCXZiqVJOcDkR6HXAhzQ1IDMU=;
        b=S3grw1j/1wUYAclQLdvuWk2g55NXWnh3n8YrZeMF5Bhb8nZnUTsRyZV9I0i9Yp2AE3
         WioW5FxVza3rSdghpUbGwmrAIibdpJIvKOFPENjG22sRUcTV+th8f88WM5I5FI3CNpK7
         dHcanp1DFYcwhLPzltDLN+RFDZdRbU73VbPeOHRRUEw+CQ3sResn/KBd2bmKY8w9YMc3
         g23UBacCtP/O1iTPHtdomDjZ86HDNwqooGLme6mNijGFg+v6QA964VxLtuPU4386MY2p
         F/pqGId/+X0M3Ki2P2dtI72wquFHL+tS0DyUvcgZU+zZHkBGkNAgl4rmyH4Tdr2FlrL4
         m8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728483725; x=1729088525;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Pc2OJnKGOq0d4e3aFgCXZiqVJOcDkR6HXAhzQ1IDMU=;
        b=A7bXQTZIWPkfEO8QkL3JSwfqoS3qHqF7jVdrqid24OCU+MtOhxa7jao8o7aMxe07Uy
         ph0Ob0JGo5o6BqXo4BXaeJbkWwkmUuSWN93JLMBeRciYhXREFfsvgy0uzt+H+T3vy3yB
         6/scvxYRWzfa87A8hSrP9xkNQbRi3pbIbwSKxZwJW0Re1HNwxhCG0DfzD/ivPPzfCsF2
         iLvuHToZ6LPs9q/dbMbkjBr1UPxV+uwaEXh0oIvsxpAGHDErkwr6+WsQIaB7QEmqrWvt
         3UTm8vkpKtvGDC/6TsJrRKI47OlJjsSZp3n2/1BPhSUJTFv8lqsP6Sv5PAO7d0NyfjTL
         BAFg==
X-Forwarded-Encrypted: i=1; AJvYcCVx6nF07MPo6XUBmjSGoiEa2AonhL8rBprVoZ+RoS50V42TTifUy2wsX03iuHKqDgpcHOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkEZ5a9nKcI6q4FyozjH+KYDAG5wtkt8MCOiAe6Yfwm6ustoL8
	xM0Vq+dfg8nH+uXnr+xaGACeo+8dC1+FzrCqFEY1sZl243Ocp+yVPhLBlg==
X-Google-Smtp-Source: AGHT+IHDVIisaP4u1zaiEp895DmU9wDH0j1v8MAUAvEyf2ole347g7Y0Sk4T4KAHNzZ52x7FFBbQCw==
X-Received: by 2002:a05:600c:4f0c:b0:430:57f1:d6d with SMTP id 5b1f17b1804b1-430ccf1b08dmr20889635e9.1.1728483724393;
        Wed, 09 Oct 2024 07:22:04 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf60b2bsm22128575e9.28.2024.10.09.07.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 07:22:03 -0700 (PDT)
Message-ID: <c94213e3-f8a6-4f16-9096-f83dbd4e7b7e@gmail.com>
Date: Wed, 9 Oct 2024 15:22:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/3] rebase-merges: try and use branch names for labels
To: Nicolas Guichard via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Nicolas Guichard <nicolas@guichard.eu>
References: <pull.1784.v2.git.git.1728084140.gitgitgadget@gmail.com>
 <pull.1784.v3.git.git.1728460700.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.1784.v3.git.git.1728460700.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Nicolas

Thanks for working on this. This version looks good to me

Thanks

Phillip

On 09/10/2024 08:58, Nicolas Guichard via GitGitGadget wrote:
> When interactively rebasing merge commits, the commit message is parsed to
> extract a probably meaningful label name. For instance if the merge commit
> is “Merge branch 'feature0'”, then the rebase script will have thes lines:
> 
> label feature0
> merge -C $sha feature0 # “Merge branch 'feature0'
> 
> 
> This heuristic fails in the case of octopus merges or when the merge commit
> message is actually unrelated to the parent commits.
> 
> An example that combines both is:
> 
> *---.   967bfa4 (HEAD -> integration) Integration
> |\ \ \
> | | | * 2135be1 (feature2, feat2) Feature 2
> | |_|/
> |/| |
> | | * c88b01a Feature 1
> | |/
> |/|
> | * 75f3139 (feat0) Feature 0
> |/
> * `25c86d0` (main) Initial commit
> 
> 
> which yields the labels Integration, Integration-2 and Integration-3.
> 
> Fix this by using a branch name for each merge commit's parent that is the
> tip of at least one branch, and falling back to a label derived from the
> merge commit message otherwise. In the example above, the labels become
> feat0, Integration and feature2.
> 
> Changes since v1:
> 
>   * moved load_branch_decorations to re-use the decoration_loaded guard and
>     avoid pointlessly appending "refs/heads/" to a static string_list, as
>     pointed out by Junio C Hamano (thanks!)
>   * fixed a leak in load_branch_decorations found by making the filter
>     string_lists non-static
> 
> Changes since v2:
> 
>   * style changes (true/false -> 1/0 and // -> /* */)
> 
> Nicolas Guichard (3):
>    load_branch_decorations: fix memory leak with non-static filters
>    rebase-update-refs: extract load_branch_decorations
>    rebase-merges: try and use branch names as labels
> 
>   log-tree.c                    | 26 +++++++++++++++++++++++++
>   log-tree.h                    |  1 +
>   sequencer.c                   | 36 +++++++++++++++++------------------
>   t/t3404-rebase-interactive.sh |  4 ++--
>   t/t3430-rebase-merges.sh      | 12 ++++++------
>   5 files changed, 53 insertions(+), 26 deletions(-)
> 
> 
> base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1784%2Fnicolas-guichard%2Fuse-branch-names-for-rebase-merges-labels-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1784/nicolas-guichard/use-branch-names-for-rebase-merges-labels-v3
> Pull-Request: https://github.com/git/git/pull/1784
> 
> Range-diff vs v2:
> 
>   1:  6250a7f6d6c ! 1:  e030ddd91f3 load_branch_decorations: fix memory leak with non-static filters
>       @@ log-tree.c: void load_ref_decorations(struct decoration_filter *filter, int flag
>         				normalize_glob_ref(item, NULL, item->string);
>         			}
>        +
>       -+			// normalize_glob_ref duplicates the strings
>       -+			filter->exclude_ref_pattern->strdup_strings = true;
>       -+			filter->include_ref_pattern->strdup_strings = true;
>       -+			filter->exclude_ref_config_pattern->strdup_strings = true;
>       ++			/* normalize_glob_ref duplicates the strings */
>       ++			filter->exclude_ref_pattern->strdup_strings = 1;
>       ++			filter->include_ref_pattern->strdup_strings = 1;
>       ++			filter->exclude_ref_config_pattern->strdup_strings = 1;
>         		}
>         		decoration_loaded = 1;
>         		decoration_flags = flags;
>   2:  167418d10d1 ! 2:  1dad6096eb7 rebase-update-refs: extract load_branch_decorations
>       @@ log-tree.c: void load_ref_decorations(struct decoration_filter *filter, int flag
>        +		string_list_append(&decorate_refs_include, "refs/heads/");
>        +		load_ref_decorations(&decoration_filter, 0);
>        +
>       -+		string_list_clear(&decorate_refs_exclude, false);
>       -+		string_list_clear(&decorate_refs_exclude_config, false);
>       -+		string_list_clear(&decorate_refs_include, false);
>       ++		string_list_clear(&decorate_refs_exclude, 0);
>       ++		string_list_clear(&decorate_refs_exclude_config, 0);
>       ++		string_list_clear(&decorate_refs_include, 0);
>        +	}
>        +}
>        +
>   3:  dfa1f0a7648 = 3:  19d8253da07 rebase-merges: try and use branch names as labels
> 

