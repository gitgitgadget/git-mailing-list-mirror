Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1322A3C13E3
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 12:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736770; cv=none; b=d1yojcYkoxan4Osu0OJMX/yL1otlK1GQfuE6+FKquSRD/Ad0MEGPMv2dHTXgtiq+XcJzH/sT33bX9PWhL8EJTRqDpc2fy9Ai2Wn+f3io62Ile5q+gfJLDAMcK7D7jaL3ny0JlUFzgY0qDJDdWEgWJrLskULzmui2xl70Kf+ozYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736770; c=relaxed/simple;
	bh=e18KNpDEK6jeXvnNJG4c4Q7ZnufrBBMtwwbAyrbibsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZsq5lNtShNwf731HzKzTcol1BdQ7HozpChKU6ArvAXEm6FA095TAwUy6QrKpd0qn3AOgCQhGEAZjsLIjGe9FZPM6PioNuItEiavYJWzq7qpgrtJnXZX8q3sRmNwBhGgOVl9O77TQ01KuHArXevWwknPVBu5vTX5JS4G45aZ8gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pvLL/1rb; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvLL/1rb"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a0fc5e2c59so802717e87.1
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 05:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775736766; x=1776341566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t90CIrH8G5jvih5kmDfB+hCF6Xyv10GJErPsAtynqbE=;
        b=pvLL/1rbspo+IhlH28Ru3zsuq2SiEMt+nTltI7/U2v09jL+OgGmpO077D+ZxOIHHhf
         uSCnbycSlJFoV4MjPNWLD0csDz88Q0HJFsqfL0QaNOUmZsx3jvTo3tsRcPokxTxEcwU4
         TW9Fwm3SdclgD1Qtgwep4mCnl+N3zE0G+gKIiRM4+K3iHsjnHKpV7G6PwBgj6WXRtEwq
         JdnVgCp/FfawajU54z7OpAxDUjZ0JYgXdhB1yzPvNr/qJ1sK1bs/nR5xypz4YU66upcr
         w0JxmK/UYas23zstl/nY/mJACo6Vcyj/QnW+rbzVIIwybIgY2KmCk8Ds7/8iE291mc5a
         7rjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775736766; x=1776341566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t90CIrH8G5jvih5kmDfB+hCF6Xyv10GJErPsAtynqbE=;
        b=Hs9RdHGrewQkZHYk2EtQdZXTusOyoicoK0DxP3rJ4HxuqTuaV2QQHY2JReps2bE68C
         +e281Lg4r/GJCslQFPYNM2hfb4fWtX9QZgi6xomZk2nVxueQyR30UjltY+2Oz05HAfHk
         +E8rouSwDXl9yYaIvCazUYaSfa+uayYb5nSe8/I+zbIGEM39t5eh+Xy89U6+Iqqcit/9
         vlE0vvIjOIxhNzEkZSKz7krm2Gvh9H2H9bz7HHurG5H5mt+kdQwmoptioXbbR7KNCEh6
         C/UVEINBhtwZyy5+/gpFYWgZrRCmiDyprSVb88hrpxaKuNaPtX9gvEAyeIae4exMNnjQ
         /3rw==
X-Gm-Message-State: AOJu0YwyzoMJZfwftLEMTD4Xb8irkZfVt2a1Uu9HFRmJQsz7hW2y9o1q
	R5NVxh5/mtNqoo3nlm40AOz6NV+XsfRZjUVfzTRy/e9z0I7XlwsMmlYk
X-Gm-Gg: AeBDieuaxyT+mlqGQSrMzmYH4KxaYLdXUOoHvR9D1ZpSO/em/6Evwb20mZfC14AnMyU
	uf0zx/w/uz0Gw8jidPwv0qaPUwdvCJ8h8sGoGXn0AVJ2E5iP24rxp0VX94WQN+aCZZomDXOxSF3
	rNL3qZHaM+OFkh1YA7+rilx8b9ftDEVjjZENXP35YGvSnUlf0a6ksbqpt8QqfG9tfGDtQAQDDel
	kaUbZsOOEs5Q6huPQX8lkAh3Lf3BZ3lCWfc+MHsuELUIt2Zc+9VLoLxkLLXaehDsOIdALMRDRwb
	CGXGMqvnfvDDT9cXOoI/NdVDT8XZXjNm5FssF6Z8AIZK6DnHOXKbRNBSsqAtf9muqZ3/7zbKbsU
	bQBKxpFFXNVROkli4oOHCOtm7/Oz1KyTrbp5Z9wes40LqD8kTDC68vW0QioGGq1jIisuWguPuMC
	hefidNFtKOoLQG5DuJg1f/l+xh9SRgZqNr8lnNB13Sh2DIaOnRf39P7XpsAR3YVrwvlQ1lk3DUf
	lTgWZPOjjyVLmn3
X-Received: by 2002:a05:6512:234c:b0:5a2:c1aa:143c with SMTP id 2adb3069b0e04-5a33756ac73mr8739814e87.17.1775736766075;
        Thu, 09 Apr 2026 05:12:46 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6ccc9fasm5328898e87.63.2026.04.09.05.12.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Apr 2026 05:12:45 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: haraldnordgren@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Thu,  9 Apr 2026 14:12:44 +0200
Message-ID: <20260409121244.19197-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260331121633.14907-1-haraldnordgren@gmail.com>
References: <20260331121633.14907-1-haraldnordgren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> FWIW, I very much like what I see in 
>> 
>>    $ git checkout hn/git-checkout-m-with-stash && git diff @{1}
>> 
>> output.  It is great that we do not have to do any dry-run, because
>> the "real" run safely aborts, we can do the "stash && merge && unstash"
>> dance as a fallback instead.  All the credit goes to Phillip and you
>> for the idea and the execution of this.
>> 
>> I do use "checkout -m" a few times a week, but I do not do anything
>> complex with submodules or run the command with unrelated local
>> modifications, so there may be changes in behaviour I haven't seen
>> in corner cases that I do not exercise.
>
> I wonder if my implementation is not really up to par. I have ran into a
> few "conflicts", were 'git stash pop' simply worked afterwards.
> 
> So not quite production ready.

Update on this: I realized that the issues I ran into was happening
because of a sub-shell, so it's resolved by running like this:

    export GIT_EXEC_PATH=/Users/Harald/git-repos/github.com/git/git && \
      /Users/Harald/git-repos/github.com/git/git/git checkout -m -

So thus, it's not a real problem.

I think this is ready to be reviewed, does anyone have time to take a look?


Harald
