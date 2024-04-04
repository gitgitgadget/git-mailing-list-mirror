Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E633C1339AB
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712259903; cv=none; b=HOUrDQ3xxIvVmgEZcZbsiEVU9g3OSjwwlOCvy2DjKf7cVo0JLxtnJ3zUEI8Qcq1DvN8PcfDBixJs9+DVHP7KBJfG8a0JIC+jeCVKxfvuEDCQV+wolP2y5yeYSxKjPnePwqvQdfjJCHtqC02fAopyi+W7ZSbwNteGoJpn9mauThQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712259903; c=relaxed/simple;
	bh=5AgX0Iubq+jEXk6wP8S9aEHY/Tz8gUUVGfmiq+yGHwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJ1GKZMcVbEkHmzhcNPO8/RLbu9Rgvqdy3YoKkSk9LY22Yq1WrnebaBd0Bh+tYRS5uvOSeYCURgx6CcD3N/bkSgTgB8rdfdiBxQk04ocvrqcjHSq3bG+Hen0HYR0PvIsd6wPKtlTUQvwq/Sge7cgY3KcKY5q3hbbO0nLPUcuEcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cfs7qTJ2; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cfs7qTJ2"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-343b92e54f5so740855f8f.0
        for <git@vger.kernel.org>; Thu, 04 Apr 2024 12:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712259899; x=1712864699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FpOTBXlNMebsPrR2Cpioe+/ry+moi0pH2OInT40J1uw=;
        b=Cfs7qTJ2puU089dNnIuT3JJJRxbqKAj4r1oW9q3SA0EYwMCh7BlBJHvG/4CUVn36Zd
         ZwucjgfUHYVRsgy2bl0O3ycG8jm1B2ajdoXzrDEsxjEyEmKgUsDwVRV1qmt6ff4cKv+k
         wsKhiVyRnFrCN/7lD4tuf/0LgQmhyj3j/42Nhy3hclQoRy0whBsKaIRz2ZgMQnYyO10/
         2bpnYqZrvfXW8n2ihX1vdQWhSlbP2wSM00zSf5Wncl1g1tycPG4/St+66Yh5AysGjzfS
         rSvphXTqBm4+UctpeV4kxe6ExLkmYyVJubSZnvuXjMTNaqfOR3jCaURq5GItA7dEwefQ
         vmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712259899; x=1712864699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpOTBXlNMebsPrR2Cpioe+/ry+moi0pH2OInT40J1uw=;
        b=AQmgII9n+iVSRmyCM1IcdGqJb6XIBiD3ve4vh3Qghrh6uc1/MdZfCi5BV804RA5Mj7
         qspv37M2vXXJs4xFt3b8OH7pm0Tbs1JSbwBDPn3w1p2/Ge9rk7Y+h1yanu9x8lTbz2kt
         nfBLH7PopkHakctIwA/1KbmmTdf/9lfn/gFVqrjVCVwr0+hvwJH1kjohOSdpWZ/UrCZM
         N4MJU8T0o1C1s7m2BQsFE/31BPdw+vnUw0uf07vSlnQ5JzKUrwgNTolaahPfu0OaEtLD
         3LkL8HN99Vnp4kHovmaflUP0WI4W5PLvAbrSiOBVvhWgSChSNX7T+liJ8KPjzLwVMlCK
         3kRw==
X-Forwarded-Encrypted: i=1; AJvYcCVE0OQea+5IfuWTGsThX9Lm4wTNDXBmvGernNpcUe0OwpnZT1c0EAgOsXjCCMPgO650Dmdl+WEKQceHqxNBZ30hMWZz
X-Gm-Message-State: AOJu0Yyelzxm2hvRbhIv2a+IHtK999WWp9+0ak33AnOdLWCfkXetU83S
	k3s73Pfw3RM/32aOiW1ME2m0k/q2GaM3eB8CDywfuOf6Ep/lDOez
X-Google-Smtp-Source: AGHT+IEsFG/wvPnmmtCbX2Nv71Knm96iv1EQf4oA74C+j0yiOEySA8Y5/mKi7QqtK7c8R7kN++seWg==
X-Received: by 2002:adf:e38e:0:b0:343:94a8:8edc with SMTP id e14-20020adfe38e000000b0034394a88edcmr357264wrm.56.1712259898847;
        Thu, 04 Apr 2024 12:44:58 -0700 (PDT)
Received: from gmail.com (4.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.4])
        by smtp.gmail.com with ESMTPSA id n6-20020a5d6606000000b0033e745b8bcfsm143614wru.88.2024.04.04.12.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 12:44:58 -0700 (PDT)
Message-ID: <57462d2e-e255-4d35-b778-176f03675df0@gmail.com>
Date: Thu, 4 Apr 2024 21:44:53 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rebase -i: improve error message when picking merge
Content-Language: en-US
To: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Stefan Haller <lists@haller-berlin.de>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1672.git.1708945087691.gitgitgadget@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <pull.1672.git.1708945087691.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Feb 26, 2024 at 10:58:07AM +0000, Phillip Wood via GitGitGadget wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> The only todo commands that accept a merge commit are "merge" and
> "reset". All the other commands like "pick" or "reword" fail when they
> try to pick a a merge commit and print the message
> 
>     error: commit abc123 is a merge but no -m option was given.
> 
> followed by a hint about the command being rescheduled. This message is
> designed to help the user when they cherry-pick a merge and forget to
> pass "-m". For users who are rebasing the message is confusing as there
> is no way for rebase to cherry-pick the merge.
> 
> Improve the user experience by detecting the error when the todo list is
> parsed rather than waiting for the "pick" command to fail and print a
> message recommending the "merge" command instead. We recommend "merge"
> rather than "exec git cherry-pick -m ..." on the assumption that
> cherry-picking merges is relatively rare and it is more likely that the
> user chose "pick" by a mistake.
> 
> It would be possible to support cherry-picking merges by allowing the
> user to pass "-m" to "pick" commands but that adds complexity to do
> something that can already be achieved with
> 
>     exec git cherry-pick -m1 abc123
> 
> The change is relatively straight forward but is complicated slightly as
> we now need to tell the parser if we're rebasing or not.
> 
> Reported-by: Stefan Haller <lists@haller-berlin.de>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---

Hi Phillip.

The change makes sense, but this is confusing to me:

With this ...

	$ GIT_EDITOR='echo pick 17381ab62a >' ./git rebase -i HEAD
	error: 'pick' does not accept merge commits, please use 'merge -C'
	error: invalid line 1: pick 17381ab62a
	You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
	Or you can abort the rebase with 'git rebase --abort'.

... I find these repeated messages confusing:

	$ GIT_EDITOR=: ./git rebase --edit-todo
	error: 'pick' does not accept merge commits, please use 'merge -C'
	error: invalid line 1: pick 17381ab62a
	error: 'pick' does not accept merge commits, please use 'merge -C'
	error: invalid line 1: pick 17381ab62a
	You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
	Or you can abort the rebase with 'git rebase --abort'.
