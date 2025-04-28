Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8BD1DF735
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745826089; cv=none; b=ouG2wxkUSO3OBITctDVAL7Fxg9VtWcZ0PcGXoB8UCcFppR5RhHf9LF8Q8cOGHpcRuSckWlBHZqW9VmBe1cxocMuaIbKRupCORQLsX7atMo7WmkNbiu9mEC7If/eRurCrKv/TFFQEAFrGz5JivUD+i2BPrhSrTE4FSRpM5T0S7F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745826089; c=relaxed/simple;
	bh=lmQszGdp+nBMr0UB4Be5n2I+ru4+PbRtcAi6+OTgtug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixR1a2mMj3oXiEvQMwAlDNuD2UiaFIvtD4MxCcQU5UvGYdmsHoD9MEUvEFx1IJ1RqXn8gQ5LgMXnrHAfFb8RENmtMMaZ9GExBHsphXDo4iIp9D5iizIAe5d3B9fNFxkn0AIqTUwSKbznv7TRVy8nc9Uln6EzVfv+SAFnapQ037c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoMdMhn/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoMdMhn/"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb1eso3858257a12.0
        for <git@vger.kernel.org>; Mon, 28 Apr 2025 00:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745826086; x=1746430886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmQszGdp+nBMr0UB4Be5n2I+ru4+PbRtcAi6+OTgtug=;
        b=NoMdMhn/2UeEgDeOTPXbJ4wWoMkGsVRyvY9gBcJYVrZogkUtEI0RxXPqyyF8Vh8qB/
         T9kBhVK9dEy2XTfTLs336XiKU6+e92bEnaLB0ddvHJ1EOyVUBvsjI46xTLg56vfeMPRy
         WDBFDGW7NUnNQ5XecqQUEIpOY5UEqAu1VbY6aLd7nTyA5aPg++VjD2zplnO03Xr6izhX
         6nm0uox1XGsVPMTtv5JE3WZXHQ6Sti9tupJUfpcOulolw0xZCG3PL3lfRWHfdUKAivtB
         1H4kjiq/zbFVX8qiGefVu8MaNS2S9JWNvzayxD61co0PJ/wJc7ndMOzuXqhikob/7wwA
         myFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745826086; x=1746430886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmQszGdp+nBMr0UB4Be5n2I+ru4+PbRtcAi6+OTgtug=;
        b=mUV8NZlXb8fszqThkox3M5MTzVySEq1HKF1Pe4S4JcTf7OXmZYcBxMSZcpYnxodf7l
         wzma6nfBJjc3q5rcsgSx/7/vPJBeBVPCroA37DnQ7Wh/rx4RtV9CwPAfHQPp698IiYoC
         uScDAn6KzZNKaZpVYFFZ0s5noQ4nobSI3npDkhFVjlrbYCVL3KsrBHIPuHnfJJpfjDYX
         Im4BSiPMwjRri1rSDQ/kiUzFXuo0d/rKxAcMUWsXyJDue3LaUEw0H4i/VFMjnbtkiu9I
         iaGMmi6cDuh5roZ+Z03ehZKaEh7Pb5eog+ErICsJmYWmBuv4IgCXWofUxXPzi5Tp6hD7
         YNCA==
X-Gm-Message-State: AOJu0YwCXIgLx6dLRy/lbIISV0syKYMuP3ZrKiQkwgXqedHw1mc/R7uq
	uKmU00i/+I6Y7gM/dPzOacMHpD5GR1QcjC7CZGsz81Q49w92NfrDmbNyp7NYrULNG+kmPNI6Ydx
	/6fSpnCggX88hXVRlDb/546tuwCNdMghN
X-Gm-Gg: ASbGnctwIZVCj0DQMCjJXoUpg7Xv+wmMgupRVK1G2g8AJE8dflspVqB9Sg6bsJXlzsi
	4Jl9G7blYlTax/L2g3Xt31LfPWbwqQDadZcgoeSSqEkY3ldhjxsMrTr5CU7ec3WmMG2dAZKwUxc
	1PtvuX68R4+kLGFlM8TZ6bl+H7kjULIznZILaAFWgecP3ruOcQ3DKMzlKADnazz5Wvkw==
X-Google-Smtp-Source: AGHT+IHZZ5URwkjfKAgQ5OVHkK0ajG6H7njsXf0WoBslqVAtYMTUUgT9DC4Q34hSYtk9tjbyy/SVy4RdD54NtV6vE6k=
X-Received: by 2002:a05:6402:3490:b0:5e5:854d:4d17 with SMTP id
 4fb4d7f45d1cf-5f6ef1f7f96mr13043203a12.11.1745826085912; Mon, 28 Apr 2025
 00:41:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <02671927-2e65-4bd3-904b-b564849d1fa5@engmark.name>
In-Reply-To: <02671927-2e65-4bd3-904b-b564849d1fa5@engmark.name>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 28 Apr 2025 09:41:13 +0200
X-Gm-Features: ATxdqUG17StiLD0_XORvKozgr_HtX5lIrC3Fq7FVf8ppPAMrci7NdNzvHHIuBB0
Message-ID: <CAP8UFD1fzLjNdrhv8yuGJmjKsJRU0kaa4rtV=ur+3CMYZD2wzA@mail.gmail.com>
Subject: Re: Workflow for bisecting with test in a branch
To: Victor Engmark <victor@engmark.name>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 27, 2025 at 10:18=E2=80=AFAM Victor Engmark <victor@engmark.nam=
e> wrote:
>
> I'd like to bisect using a test I've written in a different branch from
> the one I'm bisecting. But to do `git bisect run ./test.bash` I have to
> keep the new test file and an old test suite file the same during the
> whole `bisect` process. This turned out pretty cumbersome:

[...]

> Is there a more streamlined way to achieve the same thing, that is,
> forcing some checked-in files to not change while bisecting?

You could perhaps use worktrees (see
https://git-scm.com/docs/git-worktree) to have a separate worktree
with the checked-in files that shouldn't change, while performing the
bisection and building in the main worktree. If all the needed files
and directories are properly set up on the separate worktree, you
could copy them over using a single `cp -a ...` command.

Also I think that conceptually it's more the responsibility of your
build and test system, rather than the SCM, to provide you with clean,
out of source builds and tests.

Best,
Christian.
