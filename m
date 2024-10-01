Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E241B253A
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 04:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727755928; cv=none; b=Q2bOcVDDJbrY3tJsz+RDBf0iRFUoW+FsKP6z/364DnJcleCsZM7dovzgq3JRpg/ePXBLhEgsEzkFKJsfa//x6NA3hBEyYNnoFgNRqJZe1PPyzYQfzeyjWOnGpG8um5JjRsLp+H1XMbgZelnsw8dMg8I0XmC+1DmuaqcH+Xv+/nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727755928; c=relaxed/simple;
	bh=HbQVkl8iVjgZhPHCZbDrQVTu07QZZ9xgo6JoOSyGCs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQkE7MKXYCIzZcxxZUatEPDvP2FjD5iZRBBSzAcAJuOkYqN6YucrcJpT/YUnk7CmB7FvnCr1USmq2kf/tj5srpzTastyukc9uoLLMicPZMie39BHofchavaFiAXL0m6VThr37aQYoOsLRFiZ6CwiUvA4rLy0YyijCQkobXjIPA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b=U/5psSJb; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b="U/5psSJb"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6d6a3ab427aso38910637b3.2
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 21:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree-net.20230601.gappssmtp.com; s=20230601; t=1727755925; x=1728360725; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s0gQ/6PkMqeQ5eL5e1gUEsxsinnu8fniP80BcMrwHhI=;
        b=U/5psSJblH2umf5X4YP3EzDmDNDxsR4ow0vGYno9NcJqdWwnpYRJqIV1pZLEW/GlCP
         bmWdwCqQ7+5Y3mjL0GZUnHjuUhLodZZJFMuhawy4HE1rfoBCFgP5ZkXxQq279oic0FsY
         qtZVxvqbkKtLT2YlpfcMbpBobBW1R9zniuX1s0RmPhzwx0AykmHqlwLK5y+6XrpbNwpZ
         j8/YO2fEJJcNdXDIb/GpKz7N01NxzZ+XX6/Pbgblxzg+gZzhxJcxsKVWQ/XbkfShxUt0
         oMo23LfspW1D+JM8doeCjwOiFhuKNTQVz3ZffLmKyUYRa98e6vfKQHgH7syuiqBsKuh3
         C58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727755925; x=1728360725;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0gQ/6PkMqeQ5eL5e1gUEsxsinnu8fniP80BcMrwHhI=;
        b=g9WNSjx9xShGE0A5V5vNjbCPSXIse2fMKtC8OEFeXZ8ZpSQOKfkLJMPzfgy5tYwgdk
         h/3XBfGbo+zKfVvb0J1SftMtJyDeoZwxho+rVQ/D0pvvz+det/4CHZzBWeWRwpMe5s02
         K2XomS5ASvIhSeHejpnYpEkx6ELIc99NfJUBL/kKm63MMERZLLb+6QBkpNtE5dUubVz9
         dXA+K6NraeuwQtol6wjl1QhhBVXr5bLiE39anZSx3rTmuhv2lfQXnhvoi6xCwi97UJ0H
         +mbkliJBVmGzPG2/dOC58r+Mm+6nE4yHP66QNaXNlMwyGQoCGBx6szYv20rl6wbgeyhh
         AqCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi9Ezwit+829k5Kgis9Em4GGpXGNxDgzgTLNIJL9tgNN1WRVgmdKQK7GDq5YW6pVEAwrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIAkiZ5PTNBse5a23LyPJE8riHK7a6QMI2WWV1hl026LAotHQr
	hYf6cB3E/4zhYQXJ9DukVJsK52UShBS04QxTQIK1CTmjVx/ijS5zhVBbbc2L9EZ0XYzNl+L8FzF
	HwOspeqZ+stBnirzNKO/5QenhUpZCVl+BxXLRqBLqyep4VcJN9fYiM6zHU2pa3rvAKJLH4BqAbj
	49NWJF3gUDK+xvadzyR84SZEvwD/j3lvR7Ptw5b+2RWSb2RXs1NmK9torTdL+lfopRc7/woURVq
	GqGwODIVmydr7fR/tHV3xilpUkV+JiG4rH/krAEImplu7rDvKiSy5W6+pqijHqgh4LYIysrSXwC
	tBFnmHhAhm0bDtYzqL4mYQ==
X-Google-Smtp-Source: AGHT+IH3Rm9Hax6df9soziWjlP57yZFQ1Lt1lWQGNUrPuHcTlzii57jtHTJWVDZ8NwtXzxYlXUv6GQhPpFKhqzB8C3M=
X-Received: by 2002:a05:690c:4d01:b0:6e2:1393:1545 with SMTP id
 00721157ae682-6e24761323amr121814487b3.37.1727755925230; Mon, 30 Sep 2024
 21:12:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1802.git.1727577690390.gitgitgadget@gmail.com> <xmqqcykl82fr.fsf@gitster.g>
In-Reply-To: <xmqqcykl82fr.fsf@gitster.g>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Tue, 1 Oct 2024 13:11:54 +0900
Message-ID: <CAOTNsDwe=RXy5sH7myzj6g4JZpVfHm7F1ch38jqVE+YUV=Efmg@mail.gmail.com>
Subject: Re: [PATCH] fsmonitor OSX: fix hangs for submodules
To: Junio C Hamano <gitster@pobox.com>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you very much for carefully checking the patch and suggesting
better ways. I'll later revise it and submit a new one.

> > +}
> > +
> > +stop_git_and_watchdog () {
> > +     kill $git_pid $watchdog_pid
> > +}
>
> This sends a signal and let the process die.  Without waiting to
> make sure they indeed died, at which point we can safely remove the
> $TRASH_DIRECTORY on filesystems that refuse to remove a directory
> when a process still has it as its current working directory.
>
> Shouldn't it loop, like
>
>         for pid in $git_pid $watchdog_pid
>         do
>                 until kill -0 $pid
>                 do
>                         kill $pid
>                 done
>         done
>
> or something?  Or is there a mechanism already to ensure that we
> return after they get killed that I am failing to find?

I agree that we have to wait for pids. I also realized that we should
run git in another process group and kill the group for killing all git
child processes. I'll fix the code.

> >  test_expect_success 'explicit daemon start and stop' '
> >       test_when_finished "stop_daemon_delete_repo test_explicit" &&
> >
> > @@ -907,6 +929,23 @@ test_expect_success "submodule absorbgitdirs implicitly starts daemon" '
> >       test_subcommand git fsmonitor--daemon start <super-sub.trace
> >  '
> >
> > +test_expect_success "submodule implicitly starts daemon by pull" '
> > +     test_atexit "stop_git_and_watchdog" &&
>
> Hmph, this is _atexit and not _when_finished because...?

This is because README describes _atexit to run unconditionally to clean
up before the test script exits, e.g. to stop (kill) a daemon. More
appropriately, we should kill git before "rm -rf cloned super sub" in
_when_finished and kill watchdog in _atexit. I'll adjust the code.

> > +     test_when_finished "rm -rf cloned; \
> > +                         rm -rf super; \
> > +                         rm -rf sub" &&
>
> Makes me wonder why it is not written like so:
>
>         test_when_finished "rm -rf cloned super sub" &&
>
> which is short enough to still fit on a line.  Is there something I
> am missing that these directories must be removed separately and in
> this order?

There is no special reason, I simply followed the style used in
t7527-builtin-fsmonitor.sh. I'll fix this part.


Koji Nakamaru
