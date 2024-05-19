Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D94B4C80
	for <git@vger.kernel.org>; Sun, 19 May 2024 03:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716087757; cv=none; b=QSZNwJ6A+tN+LDkLBKmBu3iwXmnEde38SzrtTy6+y0Gsh+3sm2QEq8rRa+4xZT9dmE+57RpWoe20R4u+aUKA9UYp6w+TWG/UPoM9tst2emfgNfcSz9EF5xCwu3WuiXfK9a6xa9QqufkWEPwamgRDZZeiVp+jQ/IKEVe/a1C1LKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716087757; c=relaxed/simple;
	bh=M8hud7L4vnkXTi6UrUUSKo3IH8+eNYmT5H8cxES04l4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=A0cmD/5zU6/xqw6U/2rFRGwM6rPc3P8HVk5Jji8WyZQU4CugiA0UjLyI+zXiUkAN4MAtKfNvXboqQ/tBbjjMNHmclzZkaeVgOh12NBZMVzHYcI5k6FVijciih8MgJNA0D3iHR33ccICz+MLdeJg90DOTXUiYsVopm+I12fFFydY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUYaDIro; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUYaDIro"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e2c70f0c97so22653961fa.0
        for <git@vger.kernel.org>; Sat, 18 May 2024 20:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716087753; x=1716692553; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M8hud7L4vnkXTi6UrUUSKo3IH8+eNYmT5H8cxES04l4=;
        b=RUYaDIro5ZYey4aQET8bKSC1mIfry7xBRFj44+lVOu1AWwK45/NUusDDemWbMbaeNj
         AtbR1kfmhacDnhaAITCpPLJpFBVYDm3ydK8Py4KlJJTogABPP8s+KppLk0R++QpAtjCD
         q4ZdyW4Xhb3GQHjVs/LiWa6UJxWqjpQvy+0JtmXNxKLix79s6dCgk94XBNrsURJ9gbh+
         rjYZKcrTkVHoMWXQaw2oE1k6xKdX++n5pcLtfyEmlfMyPQvI5RkQzwqgCFXaKCpVuNkf
         XgyhiKvOdMY1MeQG911GF+Brd+3WniOikkLqJxdcRn6yjJ9Hb709p9u6rcCdDfDybWpJ
         UFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716087753; x=1716692553;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M8hud7L4vnkXTi6UrUUSKo3IH8+eNYmT5H8cxES04l4=;
        b=tQI1GdEMFGXsqJEGSrjjECkbooER7cdp/JSJ++XZjD1ZZMtuKbXL4GQNZbVmM++tgJ
         rg9iKZmpBBpAB9DS3UdXTdp3oT4VxE4wZj+B5Edtdil93jGyeaA/vgLos4gr9kVgDr/s
         8MJ45DocG5vlewO/81exQjkfzRBlatwwvi6YGeD05eWeXUoEhPYXePkujO1jip2JcEUv
         0ES6prGGjn1xq1IPuCwHE3kmkLO3tr1KP2p3r5u3pqp3x5DRUmj3C1XIx6Krv2i5jRuh
         ZJutCIaK8bFkeu7bOWp2LRDLyVyd0CHq30Vo7g86qV/QifviNJUdLOtTqLvz7q9IEIRp
         srEQ==
X-Gm-Message-State: AOJu0YzdgXpNugUwvMS+fbG42ovbthHmMbavXwDuHUXjZN2bKyiumsod
	a4dzjSkWjEmVhjJQMN0zFYJ9PBS59SwjhNpukV2jQ2hYCHisdqZdWG4vepuoexxD1zBcuXifpaY
	WhHEVVVKH88p4c24AyxsPjBtSz3E1mgjy
X-Google-Smtp-Source: AGHT+IECjI9sLMIdcjBWq53W5EtJfkKmGX7TZkHNOlbGjSzMmQPpJeG4ikYe89ZVGKVVK/JpIQtuSkqrXXdmRRXZE1M=
X-Received: by 2002:a2e:720d:0:b0:2e0:69b4:d655 with SMTP id
 38308e7fff4ca-2e51fe52731mr170744001fa.3.1716087753184; Sat, 18 May 2024
 20:02:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: jake roggenbuck <roggenbuckjake@gmail.com>
Date: Sat, 18 May 2024 20:02:19 -0700
Message-ID: <CAEUC8gmgq_yViedLGHOeSyvR9rQK+O-8Fh9wzds=2+326ngUjw@mail.gmail.com>
Subject: bug: Segfault with git diff
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.

I have found a segfault when running git diff.

> What did you do before the bug happened? (Steps to reproduce your issue)

1. After running `git diff`, git showed me that object files were empty.
2. I deleted the empty object files, and ran `git diff` again.
3. I continued deleting the empty files until `git diff` segfaulted.

> What did you expect to happen? (Expected behavior)
An error message of some type or a graceful exit.

> What happened instead? (Actual behavior)
A segmentation fault.

`Segmentation fault (core dumped)`

> What's different between what you expected and what actually happened?
Instead of closing gracefully, there was a segmentation fault.

> Anything else you want to add:
git log displays:
fatal: bad object HEAD

git branch displays:
fatal: missing object 7610511b1b4db888e8e6bb8d0ff158f932961345 for
refs/heads/main

Neither log nor branch causes the segfault.

[System Info]
git version:
git version 2.45.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.7.3-arch1-1 #1 SMP PREEMPT_DYNAMIC Thu, 01 Feb 2024
10:30:35 +0000 x86_64
compiler info: gnuc: 14.1
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

Best,
Jake Roggenbuck
