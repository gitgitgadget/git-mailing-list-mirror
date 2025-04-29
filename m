Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1437B25334C
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 20:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956943; cv=none; b=oAeoylmKU/PJmdShXuKIITerPxPO6xOcLMmxcywgQOV+Ve5es4HhB9vBv/ICP7mDMlPjz6baPWYMim3IwH3cSg/q5zYbhTqcL6isOMy7++YzgLx3sbzBq2EiNAE08gQfEo120haDqqKzFuG2Gvc8O4EZU2isIlzXNcq+CiE0TRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956943; c=relaxed/simple;
	bh=iyQN1mer6JXDm8CMQs1dB/l/vlwKX2skMTOv+LntCO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kZcZPInTjGLonpcHyFDt3avy+Fah148hj8l0Q52jqxj5bDspAmNG9jpzzdxDVVz0hsF7QXvgSelP3o3V6mkZxSdwtT9vsJUNrP3cmmUllI8Fp3lDein5e7LJpxAMZoSnO39dmAIX576RMO98PDf+4rc+pE81/q1/DScbbHvub6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtLPhi8e; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtLPhi8e"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70427fb838cso53745247b3.2
        for <git@vger.kernel.org>; Tue, 29 Apr 2025 13:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745956941; x=1746561741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mw9MoYfErjRn6pXrkIumWnDGweYpxqf+c3cxYGapy1o=;
        b=LtLPhi8eoSrt2KQZINP1GCL+QMEJyveI4btZ/oKWp+cS08Xd/vVdws72eYXXztQK33
         33yVxV9YqwTGJWViw9M0okBcuVV4AMnuJyfGPzv56hp/kY1bH+M0Yjg3TbjtdSviJxmo
         2CGrdhzwnXVf/RDf1/LPTvydZsM8ZE9cjWwv9mwGK7ozAzmh2PqBlqz8zCOF/28RV0kb
         ojlA5xV4jETwxDHuRMEqv1fGfn4sQvNzLB7sgfB//Ik5eg4SjoismOjcScWhW0nijd2k
         8ReVl3Tjfq30q3mUbIWBrwuW4cXGndxUyj8EEV0smAxYwTsVDBoxHJZRFVV/Ly8XOjqa
         fkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745956941; x=1746561741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mw9MoYfErjRn6pXrkIumWnDGweYpxqf+c3cxYGapy1o=;
        b=LkuQFRRnOqKPcGd4TGx1oqytgjt4R8FNq8z67xgd5qnx4O30x9X7mgjDmr40E4NV1Q
         Fc1Navwjx3DKF6amMlh/6gXYS8qgtpsgbHw4HeCLrGW74ABw4MY0MHJsa1JoUqPMOTRv
         89aGUJ8k4qjPWhzNE7KDNna1LjozM/1WUMzUh886k1snTfoPtSyurOhWlDf5FdaNrfsQ
         LXEgRHFfk14Z0wUfzuSr/Ro7bSgjody5ExcTUJ+34G5XUJNaf7I+LXU1qkMPZjWwbhko
         3Rh9l3BDSa7jRMHNkMfckoUWv8abMCFPjLYtAasti7trYT5myFm+2o/O4i31NZSzCYII
         VvAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq/fNbCwHlz0rj9NAWCDiHTgtbPDoTxQVtWvDl1B6gJFW915ZFY9zLwK8g6lTumHWcwFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHAyoUtfaGDMqRxonWiMnyuY+lqqShC6lL4O1XxIBRWtKtrjS4
	V/ID7tX/HJiJTEgzLJIvCiFoqXSvZe8Y5V0xghRv0V9AUvAD1d+PcNxOEA==
X-Gm-Gg: ASbGnctpRGz5oBwNTOnrD/dQCZA1vs2RMD710AJnThS5W62WrdD12dsMFM5TpUrkdld
	KZmTiiIx9Ezjyk4vB1ixRbgCmuLAPPvk/eBbhLMNl1P9KWxFfQlj7U37crepBMyHBPwGhtQfXyf
	85eK4lh2eRDJe1KLY8rGb8nRzH63LPpLBxXy/18+Zioz5d6dk0r8XEM5SRG0Mh8YE3GSj89KbIr
	7EPVJ0DBopk/vn50lpiL/BLHxSuD60ID4+OzCXEyUC4z9hKBZkS0SeQ/H0kXa4u0ATrULYs4CV1
	klHG3IJZiGyY/WF7zEVgaIGHXanXxfrI2RGgb0zHajgerb+tepPKeZDAjlcVNS4WwacZUDk1IgY
	6KYEpvsEAkPW8oMwQ
X-Google-Smtp-Source: AGHT+IEkc9tqKuw4s25bEkUAM+Hu83XWdX1NDSSOZGcxHKyLQ/lft4etRopuq1uZhy6UBoeW1v5Wvg==
X-Received: by 2002:a05:690c:64c1:b0:708:16b0:59c3 with SMTP id 00721157ae682-708abe467a3mr10877407b3.33.1745956940820;
        Tue, 29 Apr 2025 13:02:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:ad95:6981:343a:ce99? ([2600:1700:60ba:9810:ad95:6981:343a:ce99])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708ad0f5d7dsm314437b3.114.2025.04.29.13.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 13:02:20 -0700 (PDT)
Message-ID: <3cc1ef7b-40d5-4802-9bf9-ff28824ce563@gmail.com>
Date: Tue, 29 Apr 2025 16:02:18 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] builtin/maintenance: implement missing tasks compared
 to git-gc(1)
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/2025 3:29 AM, Patrick Steinhardt wrote:

> Right now, git-maintenance(1) still executes git-gc(1). With these last
> gaps plugged though we can in theory fully replace git-gc(1) with finer
> grained tasks without losing any functionality. The benefit is that it
> becomes possible for users to have finer-grained control over what
> exactly the maintenance does.
> 
> This patch series doesn't do that yet, but only implements whatever is
> needed to get there.

Thanks for putting this together. I think this is a noble goal, allowing
users and system administrators more options to fine-tune the best ways to
optimize their repos.

I wonder if any of these fine-grained steps would be valuable to add to
the default background maintenance schedule (perhaps as a follow-up)?

> Patrick Steinhardt (7):
>       builtin/gc: fix indentation of `cmd_gc()` parameters
>       builtin/gc: remove global variables where it trivial to do

These first two patches are simple cleanups. Thanks for isolating them.

>       builtin/gc: move pruning of worktrees into a separate function

This is a nice refactor with a clean method body extraction.

>       worktree: expose function to retrieve worktree names

This one is a bit messier, but still really good as it makes the
prune_worktrees() method in builtin/worktree.c less complicated. There's
just no way to make the removal of those variables look clean.

>       builtin/maintenance: introduce "worktree-prune" task

This is where we start getting into new behavior. More comments on the
patch itself.

>       builtin/gc: move rerere garbage collection into separate function
>       builtin/maintenance: introduce "rerere-gc" task

These are a nice one-two punch for this new task.

Thanks,
-Stolee
