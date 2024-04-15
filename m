Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516931E896
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189323; cv=none; b=XqgvQ68q71w7kxxYPe4HZPvYJNLtBp9c01D0Q8itPC1rQmTFtPrvg/dJhbOJm1Ag8cn+cr1e2eZP7M5rSKRERdyIklJnYYmNVqY6BUVIbMNgUb3NsQMG3FJL4eyU0Hejm+pQSET2MMz1NgJvNeNoyP7Is/kFjOmkWJZ2GUVeMNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189323; c=relaxed/simple;
	bh=Wt1U0ZJGzOKsra7FKe2iPWkOSfHw26gIEZNWDq6GbWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Dujl6W2nX5ZGAJ2IOGNMb+dViYQSICYSiwFEHSsrBeiKiVKNqvaptrzFyPONWch1SfgNlILQxeju7CtIrYuIOXgf6CD4KwQZ/+04Gk3WnbfVVD2aOrfySCiUYdFavKqls6f3nsAG/dT57UfrM/Km5FtHhsdClCE6GDy7KjXu6K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvjjR1gX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvjjR1gX"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41884e97008so215595e9.3
        for <git@vger.kernel.org>; Mon, 15 Apr 2024 06:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713189321; x=1713794121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/B0Xok/EIi1D+vzKSqpImTORcn5k6KlWRi9CTS4VRg=;
        b=DvjjR1gXPxfqvrkaL789jKZNShiaKXYbynQGGyb4Jzs7dbMuZBB4UIvpYGv0dr0jS+
         Z9nquE5/va2fgpp3auc6Op9moF0yko3iosSBzjNMNuj1MVe4vqEB4zHFkP4uX1wQyBI8
         VRiE0DWsIhrqDXq6WDw812W4pulA1/QR5yEOjZ126SN0zwRwt9UfmQIc1Z9jXAnxFwai
         j34E1id9SK2xbjzroxToYPSrZoVVhnDaO5eGG5bvFBPT1E0Xvh6vJCS3GmCuqBBFvt54
         Ds2MUmbvheJsq6EMPbpwaK8hr/puTDCOpDypviG9rpDWH6AQkQldIudjjLb0NLa1+/jM
         8fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713189321; x=1713794121;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/B0Xok/EIi1D+vzKSqpImTORcn5k6KlWRi9CTS4VRg=;
        b=LrcQarKMgyDriXe5X9t3iWudv7NZRVK2CEQyngtm7k+Y/UtA/vp4gwal2CD2TyJhl9
         qGUDrkouwBr5UtWEZCrndkXsMWbLPSo56719sMeKLZT6uaowLx57Zna875TYFDpTXxHm
         MEcYma7RI/joNcd2D9tJnq8Xu5H2aLmO7xNfZKUtEK2RVQR4XK2f9fcEb36Xifg+JPV2
         n+A8G9pg+qxh55AVdNpQzTgujfj6sgKu6MrQfdXA4Pni2jaIk+UmJQIss22XD1dvm5UA
         yRrc1QuLS6/3rqZR83lrWEcyipeb9vu8YscWMJSZcw2gs+gSP36RHl0nlMF4bTDYdkMD
         7QcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYEZ5MWKAN0MlEWrhdjPfVo/q8NaYYMVmWBegyDpkx+EaS5WiuM76j10TmG2Z3t+1zgBexzox8cz8VeQD2TyHi1PT5
X-Gm-Message-State: AOJu0YzMCYXhQFuOE1ys3o8PCyKgUANSCa0F1W4EU8KOa9y4XYujk4bB
	Kvy+meX1mx7RmkD7UKahuS0X2AkcDpNPEukTAsz52Oetb3ZO/zJnH3VVXw==
X-Google-Smtp-Source: AGHT+IEk/g8zI8rD/Y1CgFS9TOEghIXYUa01ALQEx0AHZ0xl8dGI7f0MrFDOHBUQjST2gf56yTrZSQ==
X-Received: by 2002:a05:600c:3b98:b0:417:e00c:fdb8 with SMTP id n24-20020a05600c3b9800b00417e00cfdb8mr8518886wms.1.1713189320591;
        Mon, 15 Apr 2024 06:55:20 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c4f4600b0041875ff29adsm2022229wmq.2.2024.04.15.06.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 06:55:19 -0700 (PDT)
Message-ID: <28541f00-9054-4aa0-8e47-348043b5f863@gmail.com>
Date: Mon, 15 Apr 2024 14:55:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/5] global: drop external `the_index` variable
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1713180749.git.ps@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <cover.1713180749.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 15/04/2024 12:42, Patrick Steinhardt wrote:
> The motivation of these patches comes from the introduction of the ref
> format extension. I found it really hard to reason about the state of
> `the_repository` and would like to continue its deprecation in favor of
> explicitly passing down a `struct repository *`. Getting rid of
> `the_index` is a first easy step into that direction to make things more
> self-contained.

Maybe I've got the wrong end of the stick but my impression is that it 
is the use of "the_repository" in library code (i.e. the files outside 
builtin/) that causes most of the pain. With that in mind would be we 
better focusing contributor and reviewer effort on eliminating 
"the_repository" from those files instead? It would need to be done in 
carefully in stages but would bring real benefits.

Best Wishes

Phillip

> Patrick
> 
> Patrick Steinhardt (5):
>    t/helper: stop using `the_index`
>    builtin: stop using `the_index`
>    repository: initialize index in `repo_init()`
>    builtin/clone: stop using `the_index`
>    repository: drop global `the_index` variable
> 
>   builtin/add.c                        |  48 +++++------
>   builtin/am.c                         |  36 ++++----
>   builtin/cat-file.c                   |   3 +-
>   builtin/check-attr.c                 |   5 +-
>   builtin/check-ignore.c               |   7 +-
>   builtin/checkout-index.c             |  22 ++---
>   builtin/checkout.c                   |  87 ++++++++++---------
>   builtin/clean.c                      |   7 +-
>   builtin/clone.c                      |   7 +-
>   builtin/commit.c                     |  81 +++++++++---------
>   builtin/describe.c                   |   3 +-
>   builtin/diff-tree.c                  |   3 +-
>   builtin/diff.c                       |   6 +-
>   builtin/difftool.c                   |   4 +-
>   builtin/merge-index.c                |  17 ++--
>   builtin/merge-tree.c                 |   3 +-
>   builtin/merge.c                      |  31 ++++---
>   builtin/mv.c                         |  68 +++++++--------
>   builtin/pull.c                       |   4 +-
>   builtin/read-tree.c                  |  15 ++--
>   builtin/rebase.c                     |   3 +-
>   builtin/replay.c                     |   1 -
>   builtin/reset.c                      |  32 +++----
>   builtin/rev-parse.c                  |   6 +-
>   builtin/rm.c                         |  40 ++++-----
>   builtin/stash.c                      |  45 +++++-----
>   builtin/submodule--helper.c          |  21 +++--
>   builtin/update-index.c               | 122 +++++++++++++--------------
>   builtin/write-tree.c                 |   6 +-
>   repository.c                         |  32 ++++---
>   repository.h                         |   3 -
>   t/helper/test-cache-tree.c           |  17 ++--
>   t/helper/test-dump-cache-tree.c      |   5 +-
>   t/helper/test-dump-split-index.c     |  11 ++-
>   t/helper/test-dump-untracked-cache.c |   3 +-
>   t/helper/test-lazy-init-name-hash.c  |  39 +++++----
>   t/helper/test-read-cache.c           |   9 +-
>   t/helper/test-scrap-cache-tree.c     |   7 +-
>   t/helper/test-write-cache.c          |   3 +-
>   39 files changed, 420 insertions(+), 442 deletions(-)
> 
