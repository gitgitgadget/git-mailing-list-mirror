Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CA8224B14
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 07:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104617; cv=none; b=nQPhntBdTax5SDOVhUQEpy+FBFJW1RZDaVOhrcP/+3ppLK8W5FwRTayYoq2KpqRa6brF5k0yB5dWywYxQfNLRaXWCbPsHaHKwmIdkVBMInyNCcDPp+iSmFRSjqwqeXt/iobmhNy4Dckpbwwv7xWQdvWE15KY8ubos2L+jZXDYxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104617; c=relaxed/simple;
	bh=f84XmffWV238gb4yPPJEJ7L5EuOAT+4VMJ0B42H2AaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LuXxnF5XmNxSMbMWE+dXEfLAZC3YAmQ9P/LXIj/qyk6buHLhgO+hWj4oVerA2UNVO7i4fd2dOmRO6lGndHjr/PelSFeQRnZ7WZM854Nc2WIaPKnMJQUaoWMF6P2Z/YQxS+K/lYaO+3njqihv2O9yCpLkRVzqwN5Q5Yrr4Y7ysY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b=BCtwimSo; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b="BCtwimSo"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b98983baeacso669825a12.1
        for <git@vger.kernel.org>; Thu, 13 Nov 2025 23:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree.net; s=google; t=1763104615; x=1763709415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMH0h6QdrESZPlv74dAPoPteKjzVnDjb+0uDSaxH8Dw=;
        b=BCtwimSokVFF68BNUSKP4RIv/iVqYkCmh+gW7H2l7MOWFEd0aNEj+A3GUBhc678ZuM
         rcXHwvioMXXacq3E98eV2ZpUnH2dw4pDHedk0VCjb3nirXuWMgSfRcMZpCiiuMMIwXF6
         fXuKC/FMLifTpXie9n1mCuyrlUa1C+56pMsTkb1VqluIYDn25BNEywiQZb/kvV+JP/w9
         nEMgF6/oobW5EdgU9oZW8QQMr8DJMFnykRAsmI8pgnAXTcJZauxHaMbTfokxEs2l79cM
         HyOKZSY57WDqrTYN2ebjly79j/9SOZ9y5ZycLpSemV/ULdbv/XQ5Cay7HzSd3UXeLSKG
         loCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763104615; x=1763709415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fMH0h6QdrESZPlv74dAPoPteKjzVnDjb+0uDSaxH8Dw=;
        b=lwmw+GPvXGqhIB3aFYARtbJGXRReluoXt0401GfxGMfRUYNEazcDcLJ4uuwPRUHIu/
         EzLsyh18snRHxQCT1D7rBriAuG+M75FQ5jtbF5K6dBbKozcNI72EvCTHG1o7s1RbIdQw
         dYJrqLrZXG9a5SURyMZI8/TirZgUmNank325bPUx1/g6H+rLaY3Q6PrcF4JUafoskyPZ
         qW0V7VCAbpEBg0YMGXuSXTHwtxKefHRnyQfCJOSDytzFbqYpDKvsX3omfkm4hzRnMxpS
         yG95jwHp84og3MjGPXUyUgI04/gR17sjM32GuQFsjUs5YtpSZdE4FgX7VVhR73f4O+/n
         DZ3g==
X-Gm-Message-State: AOJu0Yyir0KMbUDWLd+zGg4rUVeyhdEguVGqLtSZSOIqv654T9kYMK8i
	cef7F1ooO+4RAYA30EjKZwwtDI7V1xTORyL7jOqL8IAFX785RQkA5n11X170qbXtLzZfIshfNNW
	biXFnW+1NydYd1GNcU16Lf/PR7aOSIwDvBLozjKwj+sDMRLKXsTlQB1Mz/MRvP9zvIe+Y6UYQNl
	A4qAHOg8EBWgHthVd1caMng17iEF++aVNOb80OOap6CzXF0RCLxlyX3u2EJxm4E8JkW9b1sB5J1
	dJFhDYrvfsMpOYsabd1xmF6xNrEmgzvN1BKBts4HaBzUlTULOD/AaQOqxK6K7PjXvBPj5hp01gH
	Jyh4l6ww1rprprVlV4e+1sfVN/TvEOY=
X-Gm-Gg: ASbGncsQMxYQVDo9ag8kpxt2riN68SjFAMQOWSA4DuaeoifQ4E1lLUMXd30HV6ZYSzx
	/TJjO1B37jh4sWq1uN6B97x+PvnMD5y/gKUHN+ITNvoHmdEfpKytO+DJuPfduvkQ2kCks3vrjj9
	xUWFXC6LGHSOWtZwyp/UBiTwqAifviXtT9dpwEbXmeOKqmg3inixxwzotV/lBlE4LVXc+DNf4Vz
	lFZTFNlyQhj8ev1x4fEl3LUg0zCaAHi5mUHZuKy3cIE6kJQC9XBm6ijPxUXphXsxEpR1wbJ
X-Google-Smtp-Source: AGHT+IHjqK86Ef9uTF9WIzv2XDgtY5IYFYuru2gFcElDxzWQGkaiMYMxFBwNiAYCE7gY+vc5/PT165AuswjCngQH+EQ=
X-Received: by 2002:a05:7301:4b11:b0:2a4:3593:ddf3 with SMTP id
 5a478bee46e88-2a4abd90a1dmr663147eec.32.1763104614604; Thu, 13 Nov 2025
 23:16:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMqCmsYb409G0CuL+4xZit4V4wqOzD8DtNBe9hmRquBm0Xuevg@mail.gmail.com>
In-Reply-To: <CAMqCmsYb409G0CuL+4xZit4V4wqOzD8DtNBe9hmRquBm0Xuevg@mail.gmail.com>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Fri, 14 Nov 2025 16:16:43 +0900
X-Gm-Features: AWmQ_bknPEAkk8L6Ri6KB76_JjThP3n3Rr4lbbm21ZRutit7Nq_IXtl8i-KNOfg
Message-ID: <CAOTNsDy7Zf6XnjkND3-rXEDXEDWpi6fF4-KhCydBaEqk7OWU6Q@mail.gmail.com>
Subject: Re: Git fsmonitor daemon processes spawn detached on macOS 26 Tahoe
 and never terminate
To: Jono Spiro <jono@lostinrecursion.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 6:55=E2=80=AFAM Jono Spiro <jono@lostinrecursion.net=
> wrote:
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> 1. Enabled git fsmonitor: git config --global core.fsmonitor true
> 2. Used git applications (Xcode, VS Code, GitX, terminal with Starship)
> 3. Performed normal git operations (open repository, stage files,
> navigate directories)
> 4. Quit applications
>
> What did you expect to happen? (Expected behavior)
>
> fsmonitor--daemon processes should terminate when no longer needed, or
> at minimum when
> parent applications quit. Expected one daemon per active repository or
> so. I am seeing dozens and some users of gitx (which I am a maintainer
> on) are seeing thousands of orphaned git processes pile up after
> upgrading to Tahoe.
>
> What happened instead? (Actual behavior)
>
> fsmonitor--daemon processes spawn detached (not as children of parent
> application) and
> never terminate. They accumulate indefinitely (dozens to hundreds over
> time). All show:
>   git fsmonitor--daemon run --detach --ipc-threads=3D8
>
> Processes must be manually killed: pkill -f fsmonitor-daemon
>
> What's different between what you expected and what actually happened?
>
> Daemons are spawning detached with no parent-child relationship. They
> never receive
> termination signals when parent applications quit, causing accumulation a=
nd git
> index.lock files to remain locked, blocking further git operations.
>
> Anything else you want to add:
>
> - Only occurs on macOS 26.0+ (Tahoe) - not present on earlier macOS versi=
ons
> - Affects ALL git builds: /usr/bin/git, Homebrew 2.51.2, Xcode Command
> Line Tools

The "git fsmonitor--daemon --detach --ipc-threads=3D8" command runs in the
background and doesn't terminate when its parent process, such as
VSCode, terminates. This behavior is observed even on macOS Sequoia
15.7.2 (my environment) and previous macOS versions. You can stop it by
the "git fsmonitor--daemon stop" command or using pkill (as you
mentioned).

Setting "git config --global core.fsmonitor true" quickly leads to many
fsmonitor processes, so I avoid using it. Instead, I enable fsmonitor
only for specific large repositories.

> - Affects ALL git applications: Xcode, VS Code, GitX, Starship, any git c=
lient
> - Side effects: system resource exhaustion, locked repositories
> - Workaround: git config --global core.fsmonitor false
> - Related issue: https://github.com/gitx/gitx/issues/485
> - Apple Feedback: FB20956467
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.51.2
> cpu: arm64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> libcurl: 8.7.1
> zlib: 1.2.12
> SHA-1: SHA1_DC
> SHA-256: SHA256_BLK
> default-ref-format: files
> default-hash: sha1
> uname: Darwin 25.2.0 Darwin Kernel Version 25.2.0: Sat Nov  1 18:04:14
> PDT 2025; root:xnu-12377.60.50.0.2~95/RELEASE_ARM64_T6000 arm64
> compiler info: clang: 17.0.0 (clang-1700.3.19.1)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/zsh
>
>
> [Enabled Hooks]
>

--
Koji Nakamaru
