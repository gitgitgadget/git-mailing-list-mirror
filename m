Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C51F41C6E
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737740752; cv=none; b=HRvqQ4ZFYBY0/k8ckGNlM+XNvcjEjcoyUFlg+v6BTJdlt+vUT0wuNYl7oPy4kOWpoSqV9a0LD6qPxkPf1GJZJ8G0DZxs75D2RK6wrNmKSqt2NQzyeZYBhd/FLEEd/jBvUaQBL4PzYs98nym8IN+MvSsg8JvLjAhKqC+xtlwDw2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737740752; c=relaxed/simple;
	bh=7+P/JrzVldJZUnidxCHZqb8nDQ1HFEjaAujn4cFErpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUL2ueZxGZ3tczqifejuC8WU8f9Vd4pm7xnLwEl6rNvi0FAtqexymj3Z9GPl+x/Qc+/UVB0Hu5iw1bZgzIzvMwLEi7r1hcoLA2QOCWqgWyS/aB6yRwk4MgpsUXrxli3p4LoK5rswzn8k+kTkCBA6lvD7UdD4vWi6iwm/rjayCJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyRkzR/G; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyRkzR/G"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e54d268bc3dso4430375276.1
        for <git@vger.kernel.org>; Fri, 24 Jan 2025 09:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737740750; x=1738345550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lyn7r0+AVbm+DALgWJrFRWa5p3/WBh7Yl6i59WCFUMY=;
        b=PyRkzR/GX9ycMCT2w0GVQ2eeTh86pjXpolfKPhPxFVHgRUAsfeA1BQ4ehfXnYjaLYm
         2j7zxh7sALVqoydhyQfzPD6Z2iB+IAo6VRacnjvVAfgp3EPIojKsDlxNqhPMFIHvqtDp
         TwFketHgNinfp0QObePPEm0f6zyPaQ326wxCyafoNT9UvVyfiSt71qUaeZAoMCwFW5F3
         8YnIy2FXL9IJHsPjKGoFnvrxdi8+ORiw+W+pA4g8OynQS/K/RwsaCzM2OKlXGxnO+0az
         fTKto6y/HU/yf61l2s1o2dtcHpRqpg5LrnZPgoLTRSMRqsrEz0W2YGdXI+WovuuThbDq
         jo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737740750; x=1738345550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lyn7r0+AVbm+DALgWJrFRWa5p3/WBh7Yl6i59WCFUMY=;
        b=bw1pZ8MRzO4rrzm/UCOMOdKHrzyOPKpKZObUKRqLv+9OtYvW0lTz7Ac/6k9hc8YCg3
         PAEwxGhxTLl/BYpnfYRpvxnR+qvsRnK0XopnTXuuXettYkOfUbRO9CqyCSkVwukrK+V+
         6jZqrlm6RdLpybT5Kn224y4lYFkVFfm5/wkSgOiEct40XXNtasRHdlp5LV4FMqOdNDx7
         JiPW9ddgsaDXvTfkumhfCvVUl9QmdyrWoFxm4H4B8w6e2+r60rtIrwmB+T2FZ4Mh11VB
         cyqeJE7yCtmNaCWGtCCyuhpXjinNrnqA350wFe/q/45lM9pGUy7EVs1Mkl/L9sCFlGM6
         VhaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuiaFRwmB9+8SYcL9qGxtD16mYuWTBq7QQUOCJhqBo41I9QSQvPcwxmYz6LQgaruyAsZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOfg/0r5abBp19VpSb5kMDvgitbVI2QAhkk/fiNQCOg3bDvtsk
	ngPD0azyIS10xf+yZuOmXyYX159tct01u2olaB/5GjIwwD3kFToG/OTVqf2y
X-Gm-Gg: ASbGncvHUlWPilE4+LV/ySHT03mc3fysKKUgFtw3kkzrnBdoGG6LZQH65pg8vJY2PSA
	W8tCQ5re/rAPN7Q7Aag9+It9Z4VvMQ6Pi/BEEMd67CAiLQmfCxdHktNmQ0r90TrSiu0NejBwjFI
	KlVwe5YIj0YF20iKK4VfXDN0uJnHGcvhqS4zG88FQcs4SeHGEEF8KB+K2SbLBDwY1EKS74IRtIl
	LT7zZjnK4o833BRt7KsiMQE3UU9+9L9mhp2Lq45rSVMacs4ebt/14eeNBgU5aRlxfkCfwi9kMlT
	whZMQENgeO4/Wny+jFuour1BzyjUjNy48Tn7cnFfHLLjRmtN1FxedbGiKEqkHwNByvsQ
X-Google-Smtp-Source: AGHT+IE7y0ejx+In3Q582lVOWCiYGwR6fL7dJ7fhbKZlJaVXex6rEbRofZWNPe7uxK2zM0s/DntbGQ==
X-Received: by 2002:a05:6902:1501:b0:e58:1412:95e5 with SMTP id 3f1490d57ef6-e5814129711mr9617946276.32.1737740750130;
        Fri, 24 Jan 2025 09:45:50 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:c52c:1d3e:3dc2:a210? ([2600:1700:60ba:9810:c52c:1d3e:3dc2:a210])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e583b88db9bsm420171276.48.2025.01.24.09.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 09:45:49 -0800 (PST)
Message-ID: <7fe5f33c-4923-42a4-b98e-e7c2116a2782@gmail.com>
Date: Fri, 24 Jan 2025 12:45:49 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] pack-objects: Create an alternative name hash
 algorithm (recreated)
To: Taylor Blau <me@ttaylorr.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
 jonathantanmy@google.com, karthik nayak <karthik.188@gmail.com>
References: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
 <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
 <35026c72-f9b4-40a3-b528-1c28b1238972@gmail.com>
 <Z5F/JdnSAYqUBJ8s@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <Z5F/JdnSAYqUBJ8s@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/25 6:28 PM, Taylor Blau wrote:
> On Tue, Jan 21, 2025 at 03:21:15PM -0500, Derrick Stolee wrote:

> Sorry that I punted on reviewing this for way longer than I should have,
> and thanks for bearing with me.

I wanted to give people time to recover from release mechanics before
poking this series again. Thanks for reviewing so quickly after my
message.

> I left a handful of comments on the patches themselves, but they are
> mostly cosmetic. 

Thanks. I have prepped a v4 with those cosmetic updates and will intend
to send it on Monday, unless there are more comments before then.

> After reviewing, I think the idea of having a versioned name-hash is a
> good one, and I agree that it'll make the eventual .bitmap changes much
> easier to implement.

Thanks!

[I reordered a paragraph below]

> My idle thought before having a chance to review this
> series is that the --name-hash-version option was handing over too much
> control to the user without clear instruction on when to use one version
> over the other.
...
> So I think in that sense exposing a `--name-hash-version` is the right
> thing to do. My feeling is that we should probably just add Jonathan's
> "v2", since it appears to be a improvement in nearly all cases against
> v1, and more often an improvement than not when compared to v3. In that
> world, just introducing v2 leaves us with less code to maintain and
> fewer, clearer options presented to users.

I think these ideas are related. The thought that really convinced me
that v3 isn't worth it right now is that users won't know which version to
use without some kind of opinion being voiced by tooling. If users assume
that "newer is better" then they may accidentally get into a worse
situation by defaulting to v3 over v2. It's unsatisfying to say "try both
and see which is better" especially when v3 is rarely better.

I'll drop the last patch in the next version, but I'll keep it in my fork
for possible future resurrection.

Thanks,
-Stolee

