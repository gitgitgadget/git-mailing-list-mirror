Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D4D3C13E1
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735436; cv=none; b=ekUtIE4DuZDrrKOm92Aw1Xj5cZdHu2pG/fBRQswPd+cU2MU0Sf+5h27yk7tFa65U/bCTk4oyH60GC5IWEketYkRLxTJlrUIttyAQOcTsEe/fdv+XjXaka6gsv5t+WnMITYN1NiarbUt+PUJaUIcjRevXzRBByTlgGUqP6Fiaj/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735436; c=relaxed/simple;
	bh=e18KNpDEK6jeXvnNJG4c4Q7ZnufrBBMtwwbAyrbibsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKKns/Sqpd9LqqAzOUYkpndf156mUQx5Hq5paPAIUnLooNOvFufRfAp+Sj5zsotBYJzOKa5MWe4bfFsYljxD+gp6+rXE/0doAqcIU1bnrqg+f4yAEYoszXqCXWKAXncIhVF5Yiipb2vwIOMc3IMsT5vwYFLMXcb4cpaBjWC7Wjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKbVo7MV; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKbVo7MV"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a2c77c62d7so857041e87.0
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 04:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775735433; x=1776340233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t90CIrH8G5jvih5kmDfB+hCF6Xyv10GJErPsAtynqbE=;
        b=OKbVo7MVX6DMOgPHD4tvNP0e5TbSwZSaPmYU+TmGqBW3uCoyAD4zcVYA/poMO3D4UZ
         gcTdnMSD9j2aUAImkv15afrcPcttQVVhp8KknKs1rraHYT5azIfONP03Yu1hxfL1j8MS
         YGF1pQeod/QZ/lb3+VR520kl02bsY1y9Zpow/RYnvNFuiOiBADWZyJ0eXWlqTFvJ4j63
         3IZ9tA7a/wNqqJw5SwZRy+cj4qTV3Ax5BmG9Db022Xb4azubQAMWL7NwfqIMAvVnnS1O
         aLPRY7UcqoheS+CMNVXYIz8XzkB1A2Rqg5ZEeApp83LUXsQjeOthZPjpQGiWVXLzKjVQ
         94rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775735433; x=1776340233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t90CIrH8G5jvih5kmDfB+hCF6Xyv10GJErPsAtynqbE=;
        b=DU8ZddLWMaNYx4AnrK3giq4U1jINUlP0frGoK6vj2DwW1y8YMuwnyKqu3LLmeBb+So
         o/zqDh9j15nD/ysngZK+8/LpIkdnVQ8x/mIzw3T1gx6Tkb51zVMY98sF4blSaQ4a+EkC
         kF3FvT/oYwv0zw6Gb8+n594gDRiyko1pBLe7RmwOenxgA8DGcUCzKVMDvo5PJFLiMSMh
         +aBhjPcQ2XW/g5X3Wck+qskRlq06ObwYxEPruqmW+2Wn11UHgZFRKMqOlm+1aOxvaEzo
         AM1NuCKgRKIceIQFioCyn5kSiBGbT/YKz5bM/DPeLm17bCNzMybnp7NwPnIlaF9a0DWj
         8O9w==
X-Gm-Message-State: AOJu0YwOD3uJ/kj/tzkTIM6EzAjtlMoPf6kuBd+D6PF9mYYVido77vC+
	Q10vjlIyP6ZLE3ke5phWfw6M8hd7T8KdpqVyzzc3kklyGup0QvW/2lVr
X-Gm-Gg: AeBDieutdffQwK8GZCd5FiPZ5DCo8vBwP+JRzF3Bb8N0YIUAD7nWsocxmxGgTNqUHgU
	y7sJZmstdfEGKQt2hBXX+9QFpYrlhhN78Qc8Z6CyzMzwaNapSjQwfCsXbuhOtexn9p1v1qM5dCK
	Xs973+uK/BrChhkCXiKlheZCwJjSNCa7mAagYVYxL/sX+sWJ81vJzP5gJ6cJeF2ODTsxdf8AIAF
	lRzQkZmhgglmaDx6D5zciKpaYTsYUevnYQ0mnuIlr/hK7vAZFkRbuVpUuT8UAeHC/OxJf5vivaw
	1IXfkZTTo7WfdQOqe0UA8krEIt23qKe0YCo14s2GyZV48X2/No73Wn/uxctz+tfT/0HeGz0RwA+
	/7ZNdHgK6NyZ5ruHa8MQLGsY9UZtHk6ihVfBv4lB8lV5p9wSzAk9mLy7U6qqwS7F8pUkHZTUYSO
	ekDzjnAvqK8njJCUJuWbfzoL5cyFDDanQkNYZYt61nPRdtwPaFSQ4U2LQmM+lnLywQmUvi2zOv5
	Qs3OK2Pivb3fH+m
X-Received: by 2002:ac2:4c47:0:b0:5a2:c0b6:444e with SMTP id 2adb3069b0e04-5a3e7a242e6mr1000256e87.11.1775735432589;
        Thu, 09 Apr 2026 04:50:32 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6c951a6sm5357427e87.10.2026.04.09.04.50.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Apr 2026 04:50:31 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: haraldnordgren@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Thu,  9 Apr 2026 13:50:30 +0200
Message-ID: <20260409115030.95376-1-haraldnordgren@gmail.com>
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
