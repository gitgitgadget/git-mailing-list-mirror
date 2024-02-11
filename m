Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC99C1EEE9
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707649918; cv=none; b=ILWzL6FrduE1DP8KfpDDyW8Ol3Im2rWjyN/DSZAgfh04YucAqedBHzr5GbfNRCfF848ULIOK9ERPCKXO+jRS3zMM70tsRJ5P8KHzPxbmX5h4erbG82gQcyLfylHTuY3rIWim1RWAtZYI+/Vabjl5RYtV6+2i+NNxa4dOVHQR21M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707649918; c=relaxed/simple;
	bh=mkIN5E8MONoJ31PqtxrBOBO1j8Nt483k+UvCs5dAmQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+pJdsSeP0zguNSnMzWX/kM0yvjjDQeABba7jsfq7RzOCdc7ZdZhyKGI3TI3/nzfHgLlaHqfbllmUwqOKXItZPw9P2As2PGI+cQChUGC97JWWuF8f8uD6tZzecGkmXhVCAu4KK23IJlugoL4wiwrvtzBW1id5r5pnE9zlvnw+c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fr3KATNK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fr3KATNK"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41090edfeb3so7094745e9.2
        for <git@vger.kernel.org>; Sun, 11 Feb 2024 03:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707649915; x=1708254715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4AP/eVDvF/DVdjxDf4IfDF9Lx63V5kUlMjpv2smQUVo=;
        b=fr3KATNKak2hQ6ZwJk4sFMl6qIuWECH7sPl2gbx5FvPjfLd3B4VeUWjJXijKVKDnq1
         JTGK/jm5XcQYdLPrDOY8A46tE6ttRHG+7rAAeN3EmNBcN7uS7KPMCND5ElZhNZTJuPHH
         bAcpMJzOcUTt3noQRRo4bcN4qyEch3nO8deoXMst+EKfAflsq1i91hIttX88oyKVRl7+
         nu39ZuD9i6oxofAqfFZS61+qEWVfZn1bh3sZBWr+pe8hBGpmhut+EmudK61T7LDXY7i0
         xmqdR+pvBJ6L3CI81jvpXKMkOnXLNeLgfuAyWdvZECIaQffAF7KSscbUOVYhlzDhFQNJ
         v+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707649915; x=1708254715;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4AP/eVDvF/DVdjxDf4IfDF9Lx63V5kUlMjpv2smQUVo=;
        b=fF7iCdvYOHxrvHKhr/0ulfBcV5uI6esZ2vAMcPW6SDFkdvf2Ojd4vcobkPpnn/he//
         3xIPOCT45jPLMd30LGiEQtKNntsdhklZThrGRYiICUp89C3H/FPg5By5udTL4u8uTgNQ
         dUR1qZsGL4DdqbIttuudcWryLuFZO+k7cz+10OVWGjv5tW7BR89wF8FTL8+6MsyKBTmB
         h2GEHwCVUl4LEGzAaj0DTQWHWSJR7Y1SPaeY6Y+s78lJey/riE4ECzC9A5YyZvk3xIBX
         3OAhT9V4zIDIetFOCsovh57RJPc264fXir04qn3tW+9BIP9uLzWEmM/NB54puS60Trnf
         Vkkw==
X-Forwarded-Encrypted: i=1; AJvYcCVjA/OnThjTRRU7WVpzmy+IoBPQAuGnnyxg3j0Te4ue+VW6/TLWGxHEJCrtfx+KtcapqQBp3U5b5I7WpkxZiiqCev+e
X-Gm-Message-State: AOJu0Yx2qgdrPXpeiOkLcNKplB1uVpoCTWVKgF1SslfbBnvYMmLMhfPS
	0wc/ngOmHPUM/XiNbGct1+EjzBMmGSfKAFgFJRcoGfbHJnryiSi6
X-Google-Smtp-Source: AGHT+IHLwpKlk2Wa6jTFgDUogwD57BslF9Y2J1ftNdOzR6/KjYCxmDP3YbZ4+Az78/KaxSs1lWcCfg==
X-Received: by 2002:a05:600c:6543:b0:410:10d1:b91e with SMTP id dn3-20020a05600c654300b0041010d1b91emr2872777wmb.14.1707649915026;
        Sun, 11 Feb 2024 03:11:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVyAayU4ZHn30raEhl12BgQIc4ZO7Yfy6OyeoWqrlQPtS7/K7HdKr9MNaKc0eRAHO2Eyu4LiMsaurbHyb/x+SObOnmtmtfjU3bON2z6K0sDffT+/rmPoKhYzdWIxKZFcAyFcLUcgP4IczPzclrFCUo8Gw==
Received: from ?IPV6:2a0a:ef40:62e:a901:386f:d8d1:628a:e68d? ([2a0a:ef40:62e:a901:386f:d8d1:628a:e68d])
        by smtp.gmail.com with ESMTPSA id hi7-20020a05600c534700b00410be9b8b96sm1084211wmb.37.2024.02.11.03.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 03:11:54 -0800 (PST)
Message-ID: <4073b764-ab6a-4b4b-a8a3-2e898620b2f5@gmail.com>
Date: Sun, 11 Feb 2024 11:11:52 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] sequencer: unset GIT_CHERRY_PICK_HELP for 'exec'
 commands
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Vegard Nossum <vegard.nossum@oracle.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org,
 Jonathan Nieder <jrnieder@gmail.com>
References: <0adb1068-ef10-44ed-ad1d-e0927a09245d@gmail.com>
 <20240205141335.762947-1-vegard.nossum@oracle.com>
 <ebe188e5-7289-4f7b-b845-d59a47cd06fe@app.fastmail.com>
 <xmqqy1bymru0.fsf@gitster.g>
 <b3ec5d0b-ac17-4d1e-a17d-d5adfbfc6ccf@oracle.com>
 <xmqqcytal01i.fsf@gitster.g> <4e6d503a-8564-4536-82a7-29c489f5fec3@gmail.com>
 <xmqq8r3wcjq2.fsf@gitster.g>
 <ae8d96b7-93b0-4460-b7ed-ffebaddd6f97@oracle.com>
 <eaf511ff-f9e0-47ac-ae2e-3de0efa928dd@gmail.com> <xmqqv86yoot3.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqv86yoot3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 08/02/2024 17:20, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> I think that typically for small suggestions like that we just add a
>> Helped-by: trailer but feel free to add my SOB if you want.
> 
> Thanks, both.  Here is what I assembled from the pieces.
> 
> ----- >8 --------- >8 --------- >8 --------- >8 -----
> From: Vegard Nossum <vegard.nossum@oracle.com>
> Date: Fri, 2 Feb 2024 10:18:50 +0100
> Subject: [PATCH] sequencer: unset GIT_CHERRY_PICK_HELP for 'exec' commands
> 
> Running "git cherry-pick" as an x-command in the rebase plan loses
> the original authorship information.

It might be worth explaining why this happens

This is because rebase sets the GIT_CHERRY_PICK_HELP environment 
variable to customize the advice given to users when there are conflicts 
which causes the sequencer to remove CHERRY_PICK_HEAD.

> To fix this, unset GIT_CHERRY_PICK_HELP for 'exec' commands.

The patch itself looks fine

Best Wishes

Phillip

> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   sequencer.c                   |  1 +
>   t/t3404-rebase-interactive.sh | 12 ++++++++++++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/sequencer.c b/sequencer.c
> index d584cac8ed..ed30ceaf8b 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3647,6 +3647,7 @@ static int do_exec(struct repository *r, const char *command_line)
>   	fprintf(stderr, _("Executing: %s\n"), command_line);
>   	cmd.use_shell = 1;
>   	strvec_push(&cmd.args, command_line);
> +	strvec_push(&cmd.env, "GIT_CHERRY_PICK_HELP");
>   	status = run_command(&cmd);
>   
>   	/* force re-reading of the cache */
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index c5f30554c6..84a92d6da0 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -153,6 +153,18 @@ test_expect_success 'rebase -i with the exec command checks tree cleanness' '
>   	git rebase --continue
>   '
>   
> +test_expect_success 'cherry-pick works with rebase --exec' '
> +	test_when_finished "git cherry-pick --abort; \
> +			    git rebase --abort; \
> +			    git checkout primary" &&
> +	echo "exec git cherry-pick G" >todo &&
> +	(
> +		set_replace_editor todo &&
> +		test_must_fail git rebase -i D D
> +	) &&
> +	test_cmp_rev G CHERRY_PICK_HEAD
> +'
> +
>   test_expect_success 'rebase -x with empty command fails' '
>   	test_when_finished "git rebase --abort ||:" &&
>   	test_must_fail env git rebase -x "" @ 2>actual &&
