Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DAA41754
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780318248; cv=none; b=MMTWz34FyEKVJ4SkxAvpZ72rGdAX6oh98cEAn7s7GIHhX1eFVYMd0sSQenMujQnx4x/ePXRHclQtNMoyDGEkK1jFARyvAjWeCuQL+PmlReckd61ERguGqIJFCe/C9Eo6Jv/TE/wdjSVdGzEXWxeXMwVz8fUWqwEzIpl/yhTOAUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780318248; c=relaxed/simple;
	bh=xOjdYfflqpoMB/FV7B5Jov/JJWpxyJgNTF3yB9y+824=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMnL4wZx/EXJin2xW0zCwp/osbYzaRYaGrVx59VbSIE1GUY5JOmjXXtMY1rfpezs+HH/WIDhE+B+bhELBM14YQKMPuJC3Q2QQnkeqjIKqqYmykxAUt7d7/0l/nqNgi8ZY7Ll6ruGQ88+ZOINjx3O1VuxmKUXsMU1Zqd0gv/ZpY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrlRbefr; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrlRbefr"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8cce8873b56so28864516d6.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 05:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780318246; x=1780923046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CTrkxbDRVYvg1EvT6MZCHj/XGbDyIfeKv1TKdmNIL7c=;
        b=lrlRbefr+EZ4zu5NQeY2BQojTe1dfDwVmWu5NFZzoXfrM4JE9liRvFqB+OEuJCHoBh
         tcJ7oB8Zxxk1PtrsGHVYHZM/NT4h93VQsPWp9I0Ztge9Z+5oZBfdWunOcypkv24/8J6z
         HKmrOR2llZ8IJlIGe7t/O5Sl3p43czTgrK1mmDeZLCNI0oYJ6l3xwNkd88JFUeukf4oS
         ++1gUMkK82ercjUR1XntGlW2A1OBxE4E9j+ZLtC66ojmUz6ZO0kZTxsuBIdIdkxXBkJ8
         lIazgSHArkWysALJNr1mUDopNgucMSX24AHgcMphsychk1CZ7O70x+sgPldqv8tf9Nfu
         Tg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780318246; x=1780923046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTrkxbDRVYvg1EvT6MZCHj/XGbDyIfeKv1TKdmNIL7c=;
        b=qu2EZw05c8OXfdHG1E7Gm+4+RJVQC9sb0SElTQifjDjQicIQIzsOexP/s51N92V+B3
         p3O1NQ3dDgDBcI8G0RBXZtC2LSQeUSwXJI/54IDAOpfQ6u07a6hmpPiJbvpLFyLfgvK4
         0Gw259EYIjUwH81Yu53swaPYpDiW0HOIlctTB49WCn/R96zJwVq9qsR7g3RC0gc+yvFI
         y9ABW/HK955gxlxFK2VE10gVC8cJHqpm/4AUkZKI/onSgJkVKvixQEN3u2i8/dPgRPkD
         TXYBIc+yqfjYJvcsK647a3O+CPq1PR5uJPVdjprtCNslhkDEug9Dzw45VunLVQOU9Voe
         ZD0w==
X-Forwarded-Encrypted: i=1; AFNElJ863TlLSrYJ/hLUW68L2jY2A1ou9BGf1sdSuTHPoUjcUAdeiSRyQuG0WnSyAbMopBz+g6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZTIdgpxGbyGSSID7n8JRs43Af8hzz6aw8HpewtgZlRzKDk7ab
	UJhFWB2Nl2taOdh/wbMeMyGnzE4CfBrkgIDaxrk4lOutKyfYSugEFgWb
X-Gm-Gg: Acq92OHE19I/aUcYN/+8Eh39UCC1jZj9Ahuk2sdDpOX8XcwN49PQQBcz8YZQpFjt13E
	Ude9nM3QgLCHBOCpN/gYbPklS99kP+tMz1eloUyKLoSRdenO+ZIH8hhR6qzp2aVp5wN3fRTL/Ly
	zUvyycoobNrr8nMJgwQAy0rR6SVJ+YqKBBQe4OuV0zzNa7d8fOpX0kMsc36PJZFJkmRQjgZ1SiK
	u1wmB+rv8H9f5DtvshM/f/pxppuXCsQcqhmHE9Jx3RfeS9dvSzApCZ3tjCH4vwFEJpiE4oyVCI6
	446jJqrPsDk5s+dUyy12aXMFJ22B/bnotV1YDaFDP9bQKDuSv4wgcTzEQcYtW0gSYy3r15CwPNm
	qmhlzVLPfCKhsSRvKv5XaWGMxGm64ZuEKerql3pF/iuoFYlrPrLSa59KzpqkPp5Lo+JW+hK7U9g
	zMoVlz88iyCO8ynEw8ZPiY/QJo6lQbhNMHMs5VO2QDqPdbQEwrnUitwOk7ZpG5E7P/zdXvwhlag
	Q0C9YbwNArQpD/qwxQ=
X-Received: by 2002:ad4:5ba2:0:b0:89c:8353:1fa0 with SMTP id 6a1803df08f44-8cce4ac8640mr196070066d6.4.1780318246335;
        Mon, 01 Jun 2026 05:50:46 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea2163b0sm93468446d6.38.2026.06.01.05.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 05:50:45 -0700 (PDT)
Message-ID: <4882be43-9bc5-48cf-b74c-4a05453b2fef@gmail.com>
Date: Mon, 1 Jun 2026 08:50:44 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] index-pack: retain child bases in delta cache
To: Arijit Banerjee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Arijit Banerjee <arijit91@gmail.com>,
 Arijit Banerjee <arijit@effectiveailabs.com>
References: <pull.2131.git.1780070763044.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2131.git.1780070763044.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/29/2026 12:06 PM, Arijit Banerjee via GitGitGadget wrote:
> From: Arijit Banerjee <arijit@effectiveailabs.com>
> 
> When resolving a delta whose result has children of its own,
> index-pack adds the result to work_head, accounts its data in
> base_cache_used, and calls prune_base_data(). It then immediately
> frees that same data.
> 
> This bypasses the existing delta base cache policy and can force later
> descendants to reconstruct the queued base again. Let the existing
> delta_base_cache_limit pruning policy decide whether to keep or evict
> the data instead.
> 
> Signed-off-by: Arijit Banerjee <arijit@effectiveailabs.com>
> ---
>     index-pack: retain child bases in delta cache
>     
>     Speed up the local pack indexing phase of clone/fetch for large
>     delta-compressed packs by keeping reconstructed delta bases available
>     for reuse when they are queued for later delta resolution.
>     
>     When index-pack reconstructs a child base and queues it for resolving
>     descendant deltas, it currently frees that data immediately. This can
>     force the same base to be reconstructed again. Instead, keep it in the
>     existing delta base cache and let the existing delta_base_cache_limit
>     policy decide whether to retain or evict it.
>     
>     This does not add a new cache or increase the cache limit. The object
>     data is already accounted in base_cache_used, and prune_base_data() is
>     already called at this point.
>     
>     Correctness:
>     
>      * t/t5302-pack-index.sh passed all 36 tests.

Is there any chance that you ran this also with SANITIZE=leak to make
sure that we aren't introducing a memory leak? (It's hard to tell just
from the patch context, though your description is convincing.)

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2131%2Farijit91%2Findex-pack-retain-child-base-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2131/arijit91/index-pack-retain-child-base-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2131

Indeed, this PR has a passing linux-leaks build that exercises this
test script. [1]

[1] https://github.com/gitgitgadget/git/actions/runs/26605615549/job/78399938323?pr=2131#step:9:1405

>     Benchmarks on a quiet Ubuntu 24.04 VM, 16 vCPU, 32 GiB RAM, local SSD:
>     
>     pack baseline patched wall-time change RSS change linux blobless 69.17s
>     57.98s 16.2% faster -0.0% linux full 280.72s 236.32s 15.8% faster +1.9%
>     
>     Five-repeat public-repo medians also improved: git.git 13.1%, libgit2
>     14.0%, redis 13.5%, cpython 4.8%.
>     
>     Perf on the linux blobless pack showed the same direction under
>     profiling: 76.64s baseline vs 61.09s patched, with similar RSS.
A lot of this information that is in your cover letter would be helpful
to include in your commit message, for posterity.

Also, I prefer to see performance numbers for these repos reflected in
results from our performance test suite. We have a test for this purpose,
so you could try running this from t/perf/ for your local copies of these
repos:

  GIT_PERF_LARGE_REPO=<path> ./run HEAD~1 HEAD -- p5302-pack-index.sh

And this should result in a standard comparison table that will help
present your results in a way that is familiar to Git contributors.

> @@ -1212,7 +1212,6 @@ static void *threaded_second_pass(void *data)
>  			list_add(&child->list, &work_head);
>  			base_cache_used += child->size;
>  			prune_base_data(NULL);
> -			free_base_data(child);
>  		} else if (child) {
A nice and simple change. Good find!

Thanks,
-Stolee

