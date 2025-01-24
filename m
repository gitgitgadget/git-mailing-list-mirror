Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3314A1D
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737748034; cv=none; b=gw3GEYhoBySRoL0M8UICM20sXAJuA6BK+gNTUAuPLx0UJl3kcJbU983O2D/RLN4a04krFj86UizV5RlJbrdyuuCaIAg5qFBdfngsl1ItJ4UiS+Bc43xW5aR5hLFUMeEgmQ618DemeTMmIjePXQjYFrN+U6Qj7bk7gT/qCKOGYNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737748034; c=relaxed/simple;
	bh=PXiNW6NIh6qPRjhsop9GLQySLpg2SXx/qp2lZjVL6bQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kq1JZ0ATCKwawBIYwWCfiqutbb8K0FGawCuUc4FtlxLZ8+nykqSe85dUT2GzZiVKq+8tWzpXdk6tEXN1anHcSOwCxFVXj+8bygL5QrTsrDoU8HTEDifB59CvN+InTvKwoOmSgBj6qlDtz7AOLz5tfHOZ26X5cpJKgek1NFXyvGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gft64GUd; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gft64GUd"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5402ec870b4so354577e87.2
        for <git@vger.kernel.org>; Fri, 24 Jan 2025 11:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737748030; x=1738352830; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PXiNW6NIh6qPRjhsop9GLQySLpg2SXx/qp2lZjVL6bQ=;
        b=Gft64GUdZz9SHQDN9K+xQI+6AWG0t32AR4mHz1aCVuymnshCPPf5aFrDaR8a1hYvd3
         CJtshqfCVET1lQRQljhiwtoG9CgbPYxSC/q8sL58uxKsrjMpLfCtkYjuWwmvgCzd8+VR
         8Td8lSXUxrMO4ZqzGgbr1+6KEUad3xMBvx408NMae2DTGl/vzYzsMGFzBiots5afGPbi
         2tMEbs4n7yulQ+7wxjwWzh+FhVf7KHlpzdZpBQ0LnosQMfOtoAX/Q/D2vkQtYub/ydpn
         0/klj/2EG1R9jNkoaR+3uGK0vSVpKD2x2tgIAFWNeYN6njApHLhSqAP5JSwYsE2LfhmW
         QgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737748030; x=1738352830;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PXiNW6NIh6qPRjhsop9GLQySLpg2SXx/qp2lZjVL6bQ=;
        b=Nqz1asat+k19obD9wfpkQNF8DW2gUs32w8xVvYnBp+cgfFx8V14eB/hrRIAGMsdT4D
         1vlHG3LtEdmFuuW2ZLn5sPd6+n/HRyqjn9pnZG2yys4riQeggFFo6CeOCYfSn5wDkvhb
         oQnB6Ra3J1BD0yaBHVA8BF/6faAuAgVZXNkIixqySKrAe1bgzAeejpezG8AUhDRk3/lg
         G07DlqgSoIPnhbZfX15PbFvTrjcLi+wsW7Q12Epil/mGiSW56dZHBbBxOtkMrAN1GKTE
         LWa1WDyMfJ//CXkHbnRfVlzzwtmFJzQQuLxq1Z0luE0Ub1+lOq0jaKS0+or8S95KGd4p
         GTiA==
X-Gm-Message-State: AOJu0YzK1maIP/rZvxIWymQ96Kv+chRK6uf1prhhiAWcoDbaAY7uG7Om
	zzUVIn+YASfAoqQ6fsPLrT0v41x+4djJNNhdr3XTJAgKOvP0Y0a3v9OydtV1ofDhGIys5hg19cC
	ovPWD4VeNLCmhAatF8xC5zxvjGMI1aTx66iQ=
X-Gm-Gg: ASbGncvh9+2JzH2/iVlE/xpQXb1gMZi/ivtzCl5Lluq0LA7GFVHf+f6WTb5qnFdIlQI
	t+lhUC4a0N15LwP4X1S3QcKdZli/BPs1Accjwzn34gmHtK5LSJEpr9P4g1uySasgg
X-Google-Smtp-Source: AGHT+IGYCZ+1TOqN8+/XFoip3Ym31YwYJTAgWJxUQ3NWrkzQ9hg04vaDDu+4PFdef4z3PhGcgyx+8Yur2H1OVELlKOc=
X-Received: by 2002:a05:6512:3b1f:b0:542:2998:bbaf with SMTP id
 2adb3069b0e04-543bb33b438mr1695743e87.2.1737748029809; Fri, 24 Jan 2025
 11:47:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Perez=2DLopez_=C3=81ron_Ricardo?= <perez.aron@gmail.com>
Date: Fri, 24 Jan 2025 11:46:58 -0800
X-Gm-Features: AWEUYZnYTJnpjEVJS2J29VMqqvwddvWRkfMfsUCezLkVt_iy8HSE63oSCsFKa5s
Message-ID: <CAL_k5jZkYG0evQ2L+bCNvPAnePj=WdU-36GujfjRDwm3iX8ynQ@mail.gmail.com>
Subject: Bug report: parallel fetch tries to unlock SSH keys over and over again
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)
git fetch --all --tags --prune --jobs=10

What did you expect to happen? (Expected behavior)
Being asked for the password of my SSH key, then git updating all of
the remotes.

What happened instead? (Actual behavior)
I get asked for my SSH key many times over, and the fetch does not succeed.

What's different between what you expected and what actually happened?
I should only be asked to unlock my SSH key once. All fetch jobs
should wait for this and then use the unlocked (cached) key.

Anything else you want to add:
If I do just `git fetch` and unlock my key (once), it does get added
to the SSH agent properly, and afterwards I can execute the command
above with no issues.

[System Info]
git version:
git version 2.48.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.11.1
OpenSSL: OpenSSL 3.4.0 22 Oct 2024
zlib: 1.3.1
uname: Linux 6.12.10-arch1-1 #1 SMP PREEMPT_DYNAMIC Sat, 18 Jan 2025
02:26:57 +0000 x86_64
compiler info: gnuc: 14.2
libc info: glibc: 2.40
$SHELL (typically, interactive shell): /bin/bash

[Enabled Hooks]
