Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C775112C465
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727945707; cv=none; b=iR1EC467DHOMOfoPp8Pp8wprpel9Ivqmj3WAxMEfbDEdsGUd8pyZOfyclMV9DCoqPgILlNnnNHcWJ/DOx2rHK52nMVyhC9MHj1pO0tWh+N8W9DMjMq3VrjFvP3ual8qqGq/K/+CrAqyp7bDFCaMpdZVXWXe9Jeeg2U0sNAI0z/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727945707; c=relaxed/simple;
	bh=LKn8LK52tij9db9EQiImz4H8Am4wO6CcLP4xM0Fo8GU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IG8n3+waWM/469MJo82lrLbIB3w3Gssl9TSFVptUv6sLbwrUY2Wy2fOpASkz+AOXfK9vOLgPsZPFG2P58Bnh0UbOQCQ/y3V8CZFKm0TqZD3HCCK8+q+DXm2G8jbEaQusKbshimN2Ri+pgjY2cfiQsHvizmorYwu1rgeRMtpVY1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b=OIN3Gb7O; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b="OIN3Gb7O"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e25d405f255so633217276.2
        for <git@vger.kernel.org>; Thu, 03 Oct 2024 01:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree-net.20230601.gappssmtp.com; s=20230601; t=1727945704; x=1728550504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wP6hH19t68RMAhuqr/McYn2pHFhcSmT1h/7EET6B5PA=;
        b=OIN3Gb7OCMutPJjJ84WvrE6tOk1R0skdpwG0jXom1QI1J2bgvxAHgv9Mnw5lxKP0oT
         D+7K77qpea5V0OUkBqxIIKmr0Qjt3v4f/bzzGlnPeEvEQwC3PykU5pl8cDcAckJJGdkS
         Ces1d4CRML8mc6qUNcJtqd1mD7C9PpWGp40ppbV+RkHCau7U7DCOfys8Hn3QBrtuf/iB
         DYW/Wu/NdSKrNKnck+1f7m/TITfcMIxWCAWc7E0kh4IUM+aYwwLuqdG+vzzM7wq96qfJ
         D5HiYNebRyGzrNzrx0UTw8mkGUzMS6VDH7yPwaqa348ARxRBZXl0o1YVJDTUC5zIGfj7
         VOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727945704; x=1728550504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wP6hH19t68RMAhuqr/McYn2pHFhcSmT1h/7EET6B5PA=;
        b=IloCZYrfkxODkMSz9g78wzE8E52r43GSf5LX5FG0y/iE0KQYRaUwQOPvmudyLMmNym
         HKNXrsMb1GkP++nWLsoHlartNESZvAUvEGa9Doi9Zf5t84etazumnQyE7bg1p+dw/MpE
         gnQhL6lfkkNr4AMo0vlKnjd1GIXEI3ECv9rhG2iMlX0EJ52+YeMDk2ng9vsOr907fowC
         e+MozdjrfXgzVxlqQ9tduYWZuOaPw6u5D5t1Idtgl+wgA66muwHrbaKatF3D/G7eBGZl
         ys0PRQk4XPdDjt4PB53o/SPYP2ycw2QlGwyIUsiZi2vYMHfFmXPjXl/5320rRMboXxKs
         8Oiw==
X-Forwarded-Encrypted: i=1; AJvYcCWULr4CBJbuEOHOAPAWUxab0yQmaEEjChzeNMXSXHpgGAiEJ0YC07sv7li+e24dAr4nFRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7/hp0o6uFuCZzwhh4L17DxQGxJjxaANsd2Ds34vydthxe9vwu
	yLZQliw4gGx78tvOzYxtWcj+mPtB30Lw4alGJTnos1W9pgS3/SeG5YFAPDh0sJ8Ha3N827XqDgz
	Fmy1cDiYO7RpaPBZ73LcPIwJXJfn7OMLV4XQ4ErGuMfZsekZww+hsNF0XOkcfCZFGMsX1iZaS/W
	xOvomJH3pQXTo85ZiuAhRJyMNMGiAnXCAAo1AHzXsMQ8j/XwCK5yOhsBupgnMQomvLywmq7M9/4
	AiKPy+ZzALqtyrq0WuQwhx4vL55Sky3QVf/sBaq8SPiUfqo9/6juxJhGs9i10qQE9wgiVZpaxMw
	t4MzoyLv+TSG9aIZ4z/w/TkswqY=
X-Google-Smtp-Source: AGHT+IGVJVogb8XRYrgjDUqQbxPXs0W1OsWMj2yaFIf9Pe6UOq2gbTgdPvtyhtBuMK6UBDJabp4W58vZeLbSMLEx3Uk=
X-Received: by 2002:a05:6902:1207:b0:e28:6e18:7c96 with SMTP id
 3f1490d57ef6-e286e187e55mr2394216276.3.1727945703536; Thu, 03 Oct 2024
 01:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1802.git.1727577690390.gitgitgadget@gmail.com>
 <pull.1802.v2.git.1727759371110.gitgitgadget@gmail.com> <xmqqwmis11f7.fsf@gitster.g>
 <CAOTNsDyg2SB-wd+a7vrctXck46jyfqV4uME6nf4YQZEafWbxMw@mail.gmail.com>
 <xmqqmsjnya1c.fsf@gitster.g> <CAOTNsDz=gV1TQ=N+8V+CdhWkPSogNM-42B+vzhDNWdM-Wz9CfQ@mail.gmail.com>
 <CAOTNsDygwBkNdFX4K_ixL5kP-AvDxWWVXkvfkmV4Kh04ozdYkA@mail.gmail.com> <xmqqploimkx1.fsf@gitster.g>
In-Reply-To: <xmqqploimkx1.fsf@gitster.g>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Thu, 3 Oct 2024 17:54:52 +0900
Message-ID: <CAOTNsDwSTO_iXqG7-ez0O0Y-xbDbEBa6-EiAL-DL=PR1nbM6Zw@mail.gmail.com>
Subject: Re: [PATCH v2] fsmonitor OSX: fix hangs for submodules
To: Junio C Hamano <gitster@pobox.com>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 3:14=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>> On windows, there is no process group so the test cannot run
>> correctly. As hangs corrected with the patch occur only for darwin, I
>> would like to skip MINGW in the test. Is it okay?
>
> Surely.  But can we do so without spelling MINGW or WINDOWS out?
>
> That is, if your test requires process group features available, can
> we come up with a lazy prerequisite and use that to decide if we
> skip the test?

I tweaked fsm-listen-win32.c to cause hangs and tested on windows. I'm
sorry that simply saying "there is no process group" was not quite
correct. Each mingw process has a process group and its win32
subprocesses can be killed by "kill -- -$pgid"

For example, when a hang occurs, the following processes remain.

      PID    PPID    PGID     WINPID   TTY         UID    STIME
        COMMAND
    56782   40923   56782       9484  pty0     1052296 16:23:22
        /mingw64/bin/git
        # mingw git process
    78100       0       0      12564  ?              0 16:23:23
        C:\git-sdk-64\mingw64\libexec\git-core\git.exe
        # win32 process
    86108       0       0      20572  ?              0 16:23:23
        C:\git-sdk-64\mingw64\libexec\git-core\git.exe
        # win32 subprocess
    73328       0       0       7792  ?              0 16:23:23
        C:\git-sdk-64\mingw64\libexec\git-core\git.exe
        # win32 fsmonitor

> Earlier in the discussion, you said who are left behind if we did so
> on systems with process groups, but I wonder what happens when we
> throw a signal at the top-level "git" process on Windows, and if it
> behaves better, perhaps we can implement stop_git differently where
> process groups are not available, instead of skipping the tests
> altogether?

If we do "kill 56782" or "kill -- -56782" for the above example, most of
processes are terminated except the win32 fsmonitor. This is because the
win32 fsmonitor is detached by FreeConsole().

I also tried "git fsmonitor--daemon stop". It was able to communicate
with the win32 fsmonitor and the internal status of the win32 fsmonitor
changed, but the win32 daemon didn't terminate.

Because it's getting complicated, how about the following:

* specify MINGW
* note in the commit log:
  The test is disabled for MINGW because hangs treated with this patch
  occur only for Darwin and there is no simple way to terminate the
  win32 fsmonitor daemon that hangs.

Koji Nakamaru
