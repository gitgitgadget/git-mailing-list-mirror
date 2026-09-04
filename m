Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006254E80DC
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534214; cv=none; b=uoKO104iRik+Lgv4rSxwBmAQPe8icYkOlqnek4y5sYtfhSXIoCvvt0UJpM6fsfWpg8xYiuForn/ascqFxmHXmcyTZKacHOLQ7lTxkeTFpnYqGOjFPQEQO6fc7XqvSI/3Vk4a6dZvaycwRJfI1vPO7qFFWsSeFChfHXq+hkIv1ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534214; c=relaxed/simple;
	bh=JeA831CBnkXkNWq2jjXoENGeZPIAbmPOjutjhozAqhs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=diHUVlfL909XpbMB1/03rPKVDnYrJUz14nyt70UMO8V0tGrgBoQJEAineTRMqyzdUT6vByF2ga8lplFsHrtKbxfEKOU4TeS+OAUZqPzDOqhJufbBUhbkVYhtU3D1Dorxb/wx0/DJJFk94gnarBhl4Mhbhj0Sv2vposu2DrRjWzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFzq7nCD; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFzq7nCD"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69c108fee7fso1536255a12.3
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 08:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788534211; x=1789139011; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mn7fBgfY1l9bdB+xkMwLwWsEMO8NXfUu4GGfhlrumBg=;
        b=HFzq7nCDmfRmm7CTwBZFyeVXMEGmeW2LUtxxQSQ9KPxbVO5Q4rjFY15+MEXmDz5Qav
         G0ygxWF7wIT3L8ke2EGQ1oCNtDo2hJL57H1qTwKyC9npk7Wnz0eReCOLQ6WNfJ4EiyS6
         cpDaB2BF8jpRHxmR6s5W2MGY5JbAEzt4JW5QqEK7ggRznDHTRosWEGkFoClnRf20BlJ4
         6KwmlNLEyvTRtoQYE8zVU2AujYgkEPqIc+N7Ld2vybp1TvHj4FfY54f94fsPcOCgIa7s
         ZTjSbJBvKpcOtBv8VcFEkFYFxAsGdTiG1G0qye4PQi3ikOsrm2WsYURF51BCwSImjvTR
         oqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788534211; x=1789139011;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mn7fBgfY1l9bdB+xkMwLwWsEMO8NXfUu4GGfhlrumBg=;
        b=goX7pQMTLXsxCIW8g6lIJCvP07x79boBqCUDANp4j3lY6gYLbvRAxR16rWdIMQ6N/a
         pDt1M/SmPnloSLJiyL4w4j5zbiFklF4VhllqLGqk+qhZkMjTXmgUZ5ZnEmRXAHhooP5V
         /sV1LZ4GPxcN6TS27ryr1W7ytVo4oeFZParSIKEAmjcJk7EzsN7DQc+xVYfwG9p1lGZq
         Odqpu1DjT8mXqFME8OY9zGinxgPaRHLrEjbnKkbhcbGWE4tZKvyuLZekdZc6KI/qVVRn
         3UURHDrmVDAwgRCLhL+EQuplMbk2dhOZ2vKSXGKLkDgSygi4Qcd62ulou3nvJUUrQuhP
         ji4A==
X-Forwarded-Encrypted: i=1; AKwUvBwW+oqGdI8lhU5H1cg5wji5FF1Jq2N1ukkHnlzIFKbQPakk7eFfS8BDpEeM691QACOASyc=@vger.kernel.org
X-Gm-Message-State: AFuF++m4bIXj9VOHI7kXen1DLaOkge9u6zU7zXvWQbqV4+DAuY6zEPu/
	UKj2mPgGidFnKA1OFqZn7D9+/mLUaMYAAoB+K17pq4jj4Vl212ECq3Np
X-Gm-Gg: AYBFou1FkDfhSUKROfXLqBlVcbwfj2IjVUtiK26jNldBAHINdDsc3h7f41a8XqSMoSF
	Vb9eLu1Mb9SRA7RmVIuaZSCwmLmBDt43vWCEDAEGznh67OCQkrJ8DfERVPPB+T3WBrUjiA71EF5
	4jzRzvdmHspDOsfLs8Ov7yXvpybZkPFmxRMQ+hXbaArdITL0DqaAGBVjkcx+fNDvPzYsmeve4GV
	74W7BOEsd0H/yZZMc+T0/C9rzwE6pBIp36pdpmrAPr/X1JMfBr6lNNfDIjOadb8ne1uVcF235E8
	RRaw+CeZc5uobfvPnrNrwarc0NwhBjiuxcKhW4RwEUgjAuWMaauEEbZ/Ki8RfrnWUcqgncZlSgm
	TiW1ZmI5j2An6uJ7XgFLBTIiK2SmSNJqxhVvA4EvgUWl5xyfLaXbkNOJMLAvXDiXsIcAlggwTe6
	9BnTfnIJD+SEx6OksPwcQkoDO/0UHvOGYDWbcp2/OOfinK1Kqr9t4hWLWwIHkNwBxk7cx7Q2z46
	aU3xot+AGntPdy3sQVxquju2iAVNgWWZwRN8BixZxo=
X-Received: by 2002:a05:6402:3789:b0:6a7:ea54:393 with SMTP id 4fb4d7f45d1cf-6a7ea542680mr1630541a12.36.1788534210303;
        Fri, 04 Sep 2026 08:03:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6bee8e8sm1409524a12.23.2026.09.04.08.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 08:03:29 -0700 (PDT)
Message-ID: <845f8476-3105-4174-af51-9dd74147ea33@gmail.com>
Date: Fri, 4 Sep 2026 16:03:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: run auto maintenance once a rebase is done
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt
 <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>,
 Thomas Bachem <mail@thomasbachem.com>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <3415a4dcbf3c83f85aed3d806d897f5f4906715d.1788508426.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <3415a4dcbf3c83f85aed3d806d897f5f4906715d.1788508426.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thomas

On 04/09/2026 08:53, Thomas Bachem via GitGitGadget wrote:
> From: Thomas Bachem <mail@thomasbachem.com>
> 
> The apply backend runs "git maintenance run --auto" from
> finish_rebase() once it has applied its patches, and so does "git am"
> on its own. The merge backend reaches finish_rebase() only on the
> paths both backends share in builtin/rebase.c: an abort, a branch
> that is already up to date, and a fast-forward. A rebase that
> replays commits never runs maintenance at its end. It creates most
> of its commits in process, and only the "git commit" it spawns for a
> resolved, reworded or squashed pick, the "git merge" a "rebase -r"
> spawns for an octopus merge or with a strategy, and whatever an exec
> command runs kick maintenance off, in the middle of the rebase. Run
> it where the sequencer finishes a rebase, after the autostash is
> applied, as finish_rebase() does, so that both backends end a rebase
> the same way, and so that the next commit can keep it out of the
> commands a rebase spawns. builtin/rebase.c could run it instead once
> run_sequencer_rebase() returns, but the sequencer is where the rebase
> finishes, and the autostash and the state cleanup that surround the
> run in finish_rebase() are there as well. prepare_auto_maintenance()
> closes the object database before the spawn, so the sequencer holds
> nothing a repack would need to replace.

It would be nice if the two backends shared more of the cleanup code, I 
don't think there is a good reason for them not to share the code that 
copies notes, applies the autostash and switches HEAD back to the 
branch, but that is outside the scope of this change. So adding a 
separate call to the sequencer code seems reasonable. I wonder if we 
should do this for cherry-pick and revert as well; certainly cherry-pick 
can create a lot of loose objects and does not necessarily call "git 
commit". If cherry-pick does call "git commit" and trigger background 
maintenance it is susceptible to the same problems as rebase, so we 
should probably treat them the same.

Thanks

Phillip

> 
> Assisted-by: Claude Fable 5.1
> Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
> ---
>   sequencer.c                | 5 +++++
>   t/t3418-rebase-continue.sh | 8 ++++++++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 65afd100d9..f58ad254be 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5297,6 +5297,11 @@ cleanup_head_ref:
>   			run_hooks_opt(r, "post-rewrite", &hook_opt);
>   		}
>   		apply_autostash(rebase_path_autostash());
> +		/*
> +		 * We ignore errors in 'git maintenance run --auto', since the
> +		 * user should see them.
> +		 */
> +		run_auto_maintenance(r, opts->quiet);
>   
>   		if (!opts->quiet) {
>   			if (!opts->verbose)
> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> index cb5c3a1cb5..2c34cf8a01 100755
> --- a/t/t3418-rebase-continue.sh
> +++ b/t/t3418-rebase-continue.sh
> @@ -395,4 +395,12 @@ test_orig_head () {
>   test_orig_head --apply
>   test_orig_head --merge
>   
> +test_expect_success 'rebase runs auto maintenance at its end' '
> +	git checkout -b one-exec main^ &&
> +	test_commit F4 &&
> +	test_must_fail git rebase -x false main &&
> +	GIT_TRACE2_EVENT="$(pwd)/finish.txt" git rebase --continue &&
> +	test_subcommand_flex git maintenance run --auto <finish.txt
> +'
> +
>   test_done

