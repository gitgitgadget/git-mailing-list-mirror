Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0D330C632
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338092; cv=none; b=FZhxxDv+ERX6F5SQOcx4lDlEf9sXSyoFAwh6AdloSLMzGIUocOvH99ryzK0/F52oRclXu7JDvRALkwVb0pxp9CLcdw8UxTU9ZtXXfTXakK35fMFj1OtAoLSpz8GtzOIevY5DLpN6E6SN6Ln0OiRVzdSPYaX36TEvKR3raQGTM58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338092; c=relaxed/simple;
	bh=8DOjOt/8gDtjd5T9V2gxXNCw/m1NmkN5eyM6PVtDW7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E/LALNM4zMcaJLu5Zqq15rzxiret93Pewi5Pnn5hmojGQX+80lsmiqSKbKje5b6oPrLFKHtqHfsFaeW/pLoHm2+HmHsr2mivY1A5dzzGGhCJQzGulC1Ep9d0kuS4COPAxBs0V54V7GGKpseFOcdHzaQrF/mgLoBz6w+IpHZaNmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZ6mZvjp; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZ6mZvjp"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69fdcb13fdbso2391789a12.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 08:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785338089; x=1785942889; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c900AvK+hFxpL20VVE/WjhEOCJIsags/2aLem2w7kS8=;
        b=PZ6mZvjp9+RBQlGUBhCkGKaTvZfwMnPk6m6XYYS9g1ejZ7gxNyaC0dpg6TKVrVXvyr
         4gICuFNiZK+kCAbslEdjbFGT13/DCpGSiroGNvg91ktXsnRB8q8y+exQEYtjqEQeybra
         BS2Ikn+jqJ8Izxlz7v0Fmc3Oe/5B43yJNYdYTM+QR5xT6F8fg9UboT3jzCjPavTkWVS/
         kSMNPTC6gTWVFhzFP1o22pGJD4gAPdHiEahUGpns8Sm8MpBNOMedPRmdHN7ApF8YEt4j
         NQPsD+77PpIEx3rszdPazQaiPRrJJhTxgW05UWM3NJpshMcJZnjcs6e8NVqhHNVWswTN
         01mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785338089; x=1785942889;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c900AvK+hFxpL20VVE/WjhEOCJIsags/2aLem2w7kS8=;
        b=gwT5MNeAbL2IiURkCwQNqbwuE7d3DkEsCBjWO2LYGCYGmgkXuGUUWBuVVLzrcN+8Wv
         iQzzilO6xNHDxfklieEO0yR/9ZUv+EqDH1gwUOL8l6H2S41lT9hm0XtW00uYdazw4lgr
         11hyGNHq4/ZLl8mqTyytQf+y+4gtoXnlravgwN1XNoqT6utW3Rr8B7mWSa+7uN9Xd+w1
         146zXxMYLgsqmkp7RARZlAhqmkwlOr5KyGA6ak4bKkwiGqUdvDQj1/LPcz6k54/bPEip
         T9ZG1DbHoVLhMFQDef6iMIzfR4hq5Uxd9tgphbcF03A4zFnVbKzkreNePyHH5nukS8jJ
         9Cgw==
X-Forwarded-Encrypted: i=1; AHgh+Rpq3GJrXB8nDKkiGWe+E8S/pebhnWYAb3MneAofPPhir0JR/F58230nRdRJrkBTNKTfowk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnEzqS/X5nNlpXecnCp42oaLG2ZOtn5PqdtnMCfKOhbpOi370+
	TOOZzvSadPkVJt0iHwVDvxH9JHj1CGZzNw7NI+TAB8S7IWGEHxIq9zpT9KZzIg==
X-Gm-Gg: AR+sD1340jHfYeJGoxWMtvaMj1rV7pbGv9ThukKGW0eRQPCB24cSdD20mwxwIv5UXfC
	+VXLxIvH3uMWkxK7PQ6lsaXOJFfd4JOENdkrFDlFkKIebqwklI96NmS/0SbRNbtjmJ1Bw32eeCP
	K001Rnb/M6T8qAsp2D0Nz/WqhzTJMOn+DfBAVW1AJGMTzhIWmic55G9WSYXFNzP6bWrYhBhxPsN
	33J2Fjj6zgc+B4P3Qxg1WTqdkCDaCg5XBi3tipRqdL8dINK01/3WoEKVyHPik1K+i9RhTxVUZSJ
	dgnRv66O40WX+qSOOepSphdkbGfiUIXcC1HPthNZV2fj51QUeyHKJXUd/PsbPiUo2GwQCELAflQ
	8JPBHlRsaqh725GZwnYyjtcL+/tnCIz1H/eul0QXodGIX4ZtKnMPB6JYnQoNus7Rm8hXIlZa8D5
	6aCWywa+IchQMgLSZtt6AJF6LN4Dbpl02rwxReVjmLeVL0LCoGHB/gg0efXGG7Ltx215U4vDGG8
	Z3GF5uQSVr4oenI7K8k+1X4N/sIYDawWwaBQsji6lY=
X-Received: by 2002:a05:6402:3116:b0:69a:3652:9d33 with SMTP id 4fb4d7f45d1cf-6a05300fe35mr1205002a12.19.1785338088813;
        Wed, 29 Jul 2026 08:14:48 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a050c6d06asm1073082a12.28.2026.07.29.08.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 08:14:47 -0700 (PDT)
Message-ID: <80bd230e-7b8c-41d3-af1c-fa84b0c7b1c4@gmail.com>
Date: Wed, 29 Jul 2026 16:14:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Jul 2026, #12)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqfr15ruw7.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqfr15ruw7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/07/2026 04:09, Junio C Hamano wrote:
> 
> * hn/branch-delete-merged (2026-07-25) 7 commits
>   - branch: add --dry-run for --delete-merged
>   - branch: add branch.<name>.deleteMerged opt-out
>   - branch: add --delete-merged <branch>
>   - branch: prepare delete_branches for a bulk caller
>   - branch: let delete_branches skip unmerged branches on bulk refusal
>   - branch: convert delete_branches() to a flags argument
>   - branch: add --forked filter for --list mode
> 
>   The 'git branch' command has been taught the '--delete-merged' option
>   to remove local branches that are already merged into their tracked
>   remote-tracking branches.
> 
>   Will merge to 'next'?
>   cf. <xmqqy0ez14s9.fsf@gitster.g>
>   source: <pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com>

I've just left some comments on this. It is almost there, but the way it 
checks if pushing a branch updates its upstream looks dodgy to me. The 
behavior wrt branches that are merged but are upstreams of other 
branches has changed so that the entire hierarchy is now preseved. I 
preferred it when we only kept the branch that was the upstream of the 
unmerged branch and deleted everything underneath but I'm happy enough 
if others prefer this new behavior.

Thanks

Phillip

