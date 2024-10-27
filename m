Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC4017C61
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 22:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730068281; cv=none; b=Ts0FJ+6l2rSaMRznpu/nVgdnyHRNma98R9nvJuzjVeWIbBG+phLbiRirG8mUSRCeHY8dZtSMA3XPruW54ej4N5V15I8bLhDCxf2cYQt41l440j9GyKKgwypEtsZzgwAb3IoqGYdBbN9NqbE75i2u3vTpkXXo0qBagIMvU/8VG0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730068281; c=relaxed/simple;
	bh=kvbx5xD9qpNQ+B+lHKsxwQl2ykgqvXiEL2nQI2QqcnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=n1wVPysoOCZXk9sOOtVbxJ7Fps71Tbnf+6ehSpHFvtBK6VGjJ1+2RqhxFalDUviB0q0XJFf9X2rURe3kHzDfHk7ZrqiJKiWbIgFmEU/W3Nw622UwOFNhObOLmt5bYTwM+nVIE2Az2nBOFlxqTHdR/tlKKHiog8isOELVB4Rxx58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UX6PoB9R; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UX6PoB9R"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539fe76e802so4331275e87.1
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 15:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730068277; x=1730673077; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kvbx5xD9qpNQ+B+lHKsxwQl2ykgqvXiEL2nQI2QqcnA=;
        b=UX6PoB9RSd1DdlNnsrVO1xdP6KOL0NYsMOcUtRFEaU110Fi13gx2s3iBRxavTGbRuu
         xXQ4rIMlZ/MmJFdADMzYiUZ7H867XjxZtvdswhPqYRlOft4VR85+91adq9MYMmbKxlTg
         NvhXsisQgWH0Ozn90aPjyk6MZmAFr4zb+TrdwIC1kTw4vaLH+FfDZEZSGpmRF13Yza1F
         2J1NlIv+r6HObBaNb8Fl31/HMl/7DkyZ50+QozoopdRNK+r1Ar/wzZDEzHIpaiBx+ZBB
         rTi575nuO40cycLw1bO1Rfq1wWqZF9uDNz43JpP6h48btiPbsOBjaGR8BkUzLYij0kd8
         k1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730068277; x=1730673077;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kvbx5xD9qpNQ+B+lHKsxwQl2ykgqvXiEL2nQI2QqcnA=;
        b=FDZvd6AHHVoetwL1ZOGj4iKTxNHJpVDb94hajr8CHfFE9xVssZdHnYUPEjAH9eSLLm
         5GagBPlabSJVEEB1fO/s+fQ+r4Y9mp/iVrjPA96QTmmEp56C+LbeTEHrSl64pOJO4cGR
         E1xRlTHA11zprxMbq23D2ezHe0YmSUeP28ZrazTP0UOKXG0a39unK4GFjz32b4ykd0Ap
         c7lD3mjyHYGhO+AznJES1V1g8o8p7RW7APP+SKLPTtzgBpXzDAl9E9trbv3q7wgwAu1+
         39QDud16ZSrksi8zbJzdXf5tCiHk16yJfpEfLVDsKX2UGATqfVUrqMv1SiNw9mwHKyjm
         qnPQ==
X-Gm-Message-State: AOJu0YyNJ0sPGNIQuIm0sxJ7RdtNsrlAfXXV2ZkfPxc0rheaLY3/keCX
	naRXiDMX54tHuZtMohD63LNvxoxlw/FmXOn0Y+RDUYZ8jhNxWrazKF63wwDLfUAWuV70p5NGDAx
	p1NFdYlv7h3ujpsXeWlsD80tDGEwCm00V
X-Google-Smtp-Source: AGHT+IEJmUVpYEew9wg7GGBmSqNu7+52U1b9AXiFpvUtf4YAvq9+zu5ZJtsaDomctUlohIernzhMI0ptJ38M1qDHfhI=
X-Received: by 2002:ac2:4c41:0:b0:52c:9468:c991 with SMTP id
 2adb3069b0e04-53b348cf0c0mr2196170e87.14.1730068277019; Sun, 27 Oct 2024
 15:31:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANM0SV0KKd+WN4MQ1_8fEvFyD4tYY3qAUsUh9Njcy1xo1hNSBw@mail.gmail.com>
In-Reply-To: <CANM0SV0KKd+WN4MQ1_8fEvFyD4tYY3qAUsUh9Njcy1xo1hNSBw@mail.gmail.com>
From: Devste Devste <devstemail@gmail.com>
Date: Sun, 27 Oct 2024 23:31:05 +0100
Message-ID: <CANM0SV0Muk8KT6Mv=14ui07c6OzaNDDQwg2bUVRb8JyJWTyHnQ@mail.gmail.com>
Subject: Re: 2.43+ git checkout --theirs on stash error - no alternative?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Turns out the previous behavior can be achieved with
git restore --source='stash@{0}' -- "some-file.txt"

On Sun, 27 Oct 2024 at 23:16, Devste Devste <devstemail@gmail.com> wrote:
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> git checkout 'stash@{0}' --theirs -- "some-file.txt"
>
> What did you expect to happen? (Expected behavior)
> Checking out the file exactly as it is in the stash with any conflicts
> resolved using the stash's data
>
> What happened instead? (Actual behavior)
> fatal: '--merge', '--ours', or '--theirs' cannot be used when checking
> out of a tree
>
> What's different between what you expected and what actually happened?
> Error and unresolved conflicts
>
> Anything else you want to add:
> This behavior was changed in 2.43
> https://www.spinics.net/lists/git/msg463600.html
> However, I think this change is wrong. Since using --theirs still
> makes sense, if you want to restore a file to the exact state it was
> in the stash.
> While the change probably had in mind that this should be used: git
> cherry-pick --no-commit --mainline 1 --strategy-option=theirs
> 'stash@{0}'
> This leads to different results than git checkout --theirs, since it
> tries to resolve the conflicts and is not correctly using "theirs" to
> automatically resolve them
> How can the pre 2.43 behavior be achieved?
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.43.5
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.14.0-162.23.1.el9_1.x86_64 #1 SMP PREEMPT_DYNAMIC Tue
> Apr 11 19:09:37 UTC 2023 x86_64
> compiler info: gnuc: 11.4
> libc info: glibc: 2.34
> $SHELL (typically, interactive shell): /bin/bash
>
>
> [Enabled Hooks]
