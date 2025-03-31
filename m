Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FBE21D595
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743435543; cv=none; b=kG5gZigbBs23zsP//hUAn298PiBGrwgxeYrCdP3gfNnz7pwcCJyPI6Ch1u0NPC8uzEWWpl1xYA/SNHTgvFlrc0xaK1aIk+8ciXtfZyP5jPVnHRfMliWGh4CjqzbCz9bDBbXzhyA6Qe78q50+t0Wo9qnACl26zTgWGaJQ2nx8t68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743435543; c=relaxed/simple;
	bh=ClSF2shHmpXiXCA9XXaD3fSFbWY41NXP9hazq+Lsxho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxr7K9h1DbTk/XZ0qPPpCQIudk8OlVe5/ffclQGr4cgxV9BE33+1jMqQALJVEh+YKTpmOcSw6/RUblJe2Pdkp5bizVXg6TfDTCKeasC7VoXNI2gsPbPTxevTI5L5kOUCL4UtquBENRic/i0tk5fr6yNJjzdgr3oVZE+z2HUeBV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daWUcCRe; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daWUcCRe"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3913d129c1aso3390424f8f.0
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743435540; x=1744040340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yiacPRJbHstB1gdJ0Ia4xcUUzIjJ0flX4JrmJB2COtY=;
        b=daWUcCReDovEexl7MSeid3zn7NFTMNM7DjRG9AUE3I8cbOa14WjQwBM5ZvAWsjCj21
         6H/lRudY7GXmVH9w7o4xgc2T583tVktyOTzd340wUt6Y9LEOhkh4CtZrjPXAhAwvM1CD
         iWhpKZR8x4PFRm0Dd5Bn3xEfHf9iiWripL9XlXurmRl4aM9amcpE6f3wU/7n3fAaWfC8
         H8zBZ+IVsJ0aLpb6tOR2jBaPtb+4McvixFf+k9pifg9nI3NlRKgO3Jb8DoLHrkIiICCI
         BMc6D16r+rhSPSOiTjwGJ2aFIfGue8qAAw5O+O5AhzwwxBtwhFxYceafRo13yZXAZdYE
         xE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743435540; x=1744040340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yiacPRJbHstB1gdJ0Ia4xcUUzIjJ0flX4JrmJB2COtY=;
        b=EXY3hV68kdBhK6nv++Du6vumMEyJFzF2TQL5SO47EXqfUFTxt2dz/+hCJQMzabHHy5
         CRwNfY6mzBe47uswPmj2OfRD78O1v/a4FofvgTs4bNtJDQNUfgV96OAN/ooj3qL+ybkl
         0buuxX1uhRJrgFxT90d+Eh7R0BrSTQjl10mpUkFW75MZHsKsHT0eCEHwipZz27uefrIC
         7hsSR8mjP7SPeuD9D8CEbO1tocJJ4xQxMrNhoeO0WZ+SuzzhQHmdC6XE5pNIhrZwPU5I
         cP3IY37MubHh2GRwlinr0myWY8gUH0UzwS7tMpQfqEdF9boBCrnUHgm8VnVvZ+FNwqso
         4kHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWblaAvms39SYbJmsk4L3GED4IMSrW8iKzjg1W+iecptCC6OAUHPfsSUyxf1PIeRxnexEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwl2qesBfURgWuApNLJ1GrpxtKo8V5kOoxgxG3hdZu0R97URwa
	AuXNmotT8Ay9hdfAXX2Wxh7mXj2ipWEWbA6YJ0LXajFT6BgYw5lp
X-Gm-Gg: ASbGncu+KbEFGixaRzk5CP/EmmbvD0E0qIKPZAS0xvgK7HMyqPu3a/RlfpuLjP7NGXc
	yMNK2tQ+5GyPo97tLCe1kAi+YiWjHrJn7y67e2pbpQvvulrprVBUKoEtthhGx14LtLiqC2mAI2x
	b9I4jdxiKII6ZYo066ElT4lRYnletNTDwSrvcyJg6L9GGx4WzMKM5qXRYaaT1dzmGzacVMCWj3k
	mPOVc3WtIWXfozHQX8hikjoOjLBxDVSAovJ7C18AOJHRpODU8WLGl6fuqAtOYHwwdpHzCXUBl58
	E3bEYbMj+PxutmoPpENl5VXNVPyqCmBfdw9XLqWTMcKyb2sXbBlKFCAWIpe0ujf7nrhTyoIIHRu
	PCM7IpeLRwtsMNMeVXz+o
X-Google-Smtp-Source: AGHT+IGoBzcvid4NRkzLdQaHvlXTK9bYEGvN6AQABNrOaSgOIWiJz6X0JFLcO0Vfeg27Nb1w0t6pQQ==
X-Received: by 2002:a05:6000:1acd:b0:391:1218:d5f4 with SMTP id ffacd0b85a97d-39c11b9d025mr7767019f8f.23.1743435540215;
        Mon, 31 Mar 2025 08:39:00 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b79e136sm11623730f8f.67.2025.03.31.08.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 08:38:59 -0700 (PDT)
Message-ID: <31f658d2-1665-4cda-9625-2c9503d549b5@gmail.com>
Date: Mon, 31 Mar 2025 16:38:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/3] rebase -r: a bugfix and two status-related
 improvements
To: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Philippe Blain <levraiphilippeblain@gmail.com>
References: <pull.1897.git.1743181401.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1897.git.1743181401.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Philippe

On 28/03/2025 17:03, Philippe Blain via GitGitGadget wrote:
> Hi,
> 
> this series started as only 3/3, which I wrote when I noticed that 'git
> status' suggested 'git commit' instead of 'git rebase --continue' to
> conclude a merge, and doing that I lost the original authorship of the merge
> commit.
> 
> 2/3 is a small improvement I noticed along the way, and while testing these
> I discovered the bug which I fix in 1/3. I guess 1/3 could go in a different
> series, if we prefer, but for simplicity I'm submitting them together.

Thanks for working on this. I've left some comments but the fundamentals 
of this series look sound.

Best Wishes

Phillip

> Philippe Blain (3):
>    rebase -r: do create merge commit after empty resolution
>    wt-status: also abbreviate 'merge' and 'fixup -C' lines during rebase
>    wt-status: suggest 'git rebase --continue' to conclude 'merge'
>      instruction
> 
>   sequencer.c                |  3 +-
>   t/t3418-rebase-continue.sh | 24 ++++++++++++
>   t/t7512-status-help.sh     | 75 ++++++++++++++++++++++++++++++++++++++
>   wt-status.c                | 49 ++++++++++++++++++-------
>   wt-status.h                |  1 +
>   5 files changed, 138 insertions(+), 14 deletions(-)
> 
> 
> base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1897%2Fphil-blain%2Fstatus-abbreviate-merge-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1897/phil-blain/status-abbreviate-merge-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1897

