Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620B28C07
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731144787; cv=none; b=ER/qLMTDv1PdhhL7upt98Sb0gFDP0kMVLHxskgJMXrHqt40+UtfrtNSrAMRsSeRnT//VupblsdPrH0st3+2V1jQzhaLOAZqOITx3D8K11a6XOHX98F46nxhOHSMdn0asP4oWNsaaM6yLkNnMYM6KKFVEpk2YbVZUzcr98e8VkZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731144787; c=relaxed/simple;
	bh=qxb1Cym9ik4MPobrCqnJ3b/nOfNRsTZBqtTpU8EmVT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZKw/Wx/kqPuRMM0ZGfA3XU4DTGFyNPZ5IXZAcvjfBeXy/nSZhYsk9k9aZdTCkNNxU+HAwStEXlYreRJ02QfgEop/r0hB4GADAjF3Oj+LocWjwursIw/Dr2a/mkKGLrlerzcaj1qL6R7+bsUTdcpYcKGMzlK91kcXIJS5LlaAspc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjFvRiuP; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjFvRiuP"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-512259c860eso1066372e0c.2
        for <git@vger.kernel.org>; Sat, 09 Nov 2024 01:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731144785; x=1731749585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxb1Cym9ik4MPobrCqnJ3b/nOfNRsTZBqtTpU8EmVT4=;
        b=mjFvRiuPresiRusX19ISEo7cIoIqe16rvUuUmLGmIsPGwAz8Vw3bf/j1FH+nMmpJzo
         PdioRFW8/wVh4GPAeSOmx5Rd2MPHjxmVd52iQT+sAmPGZZVMCeVrAzV0wmf4Du9V2Brd
         l3rjxGkCwod36d80WyhL5LY4Db3Lf6nheFgfFq2/r3V4AgHUWlvWBQX7OKPKPgD3QkDD
         Wd+XN9gfGYyvdUT9jYisvS0a7l1azuR/WKiq5XM8cB52gc+BhGS0Xv/x1rf6nllSy2AQ
         x8no0CzGlHfZCfZYp9eTVu8DhVdm9oquCpXIIxxj1P1wAqZdnE8nTiaFSV7Qem9i00bD
         UqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731144785; x=1731749585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxb1Cym9ik4MPobrCqnJ3b/nOfNRsTZBqtTpU8EmVT4=;
        b=HrwNafdWzKQ1+PnB44gxEyUP01Eje/Ci1C/WK8NRXq0gSAlnaILSZkSaGEoECX6q/M
         V61hbpyPlnjBZX9lCcO72iYYe3UqM7f6UodylYYHiixHTlF17hk2KkTpfWXCkZpsVSzj
         fOEv8ftCYA+8GXs0XU/uQThF05cn5ZJHpjf3erin4MmE0LLzazFpIddHKu3Lj6nlt2B0
         lYpfQ10XWp3wBNhWJuvlWx/tYkzyH4CCePr0t1T30SJvl1svvy4Yj3dD6YHWOBGPTR5Z
         tfWpaDKTYS+i3Q9G6W4jPofV71yUt+ZxJc2xWgvzSp3SIb4GgY7m2UPNdO3IruVJqbdJ
         MjpA==
X-Gm-Message-State: AOJu0YyjjCgDVfUmUMdhL9Xma/XQDvEK0tGpdxNO6fHBhA4ZT2Dw+xap
	NR8WWNOpdFQ6u+GcrrRsIyguzatIfxPkpFKYdxRsUZHioCbkOsHfIqcBtZlPpEOffarWM6viMv9
	g2kRLqgBroUJ/npcbhIV6zuZz7WQdKxBgWQo=
X-Google-Smtp-Source: AGHT+IHquJ6NAzs8IM5E96irsCqlw+VIAkS9HOgdBQNqZ2pkL49z2GCCwCDLJZfz9ikUwe/jqZ3TLzxeRbM5ODZ2IYA=
X-Received: by 2002:a05:6122:468f:b0:50d:3ec1:154b with SMTP id
 71dfb90a1353d-51401b901aemr6075106e0c.3.1731144785095; Sat, 09 Nov 2024
 01:33:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSxiM9GZLKNbyCmgpz6b7Z-MLe8TfMaatR8FPNwvsHA411dtA@mail.gmail.com>
 <CAP8UFD1-HsYsPRQwWMo8ipf-VdqF+9=HUTTr4BhEArR=V3ucxA@mail.gmail.com>
In-Reply-To: <CAP8UFD1-HsYsPRQwWMo8ipf-VdqF+9=HUTTr4BhEArR=V3ucxA@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sat, 9 Nov 2024 04:32:54 -0500
Message-ID: <CAPSxiM9UGLVrOh6XR5fn38ginCVKMOc7yQMcm+qsaF3bi+anSw@mail.gmail.com>
Subject: Re: [RFC]: Test Were failing on Fedora Linux.
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 3:12=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Sat, Nov 9, 2024 at 7:02=E2=80=AFAM Usman Akinyemi
> <usmanakinyemi202@gmail.com> wrote:
> >
> > Hello,
> >
> > I was trying to build the Git project on Fedora Linux. I just
> > installed the Fedora.
> >
> > I followed through the steps in the Submitting a Patch. About 42 tests
> > were failing.
>
> Please tell us how exactly you ran the tests and what was the output
> that showed some tests failed.
>
> You can run each failing test with some options like -i and -v to get
> more information, like for example:
>
> $ ./t0000-basic.sh -i -v
Hello Christian,

I was using make before. I tried to run the single test as above, the error=
 was
ERROR: ld.so: object 'libc_malloc_debug.so.0' from LD_PRELOAD cannot
be preloaded (cannot open shared object file): ignored
I tried to check this online, but, all the solutions I found were not
resolving it.

I look for libc_malloc_debug.so.0 and it is located in /usr/lib
uniqueusman@fedora:~/git/t$ sudo find / -name "libc_malloc_debug.so.0"
find: =E2=80=98/run/user/1000/gvfs=E2=80=99: Permission denied
find: =E2=80=98/run/user/1000/doc=E2=80=99: Permission denied
/usr/lib/libc_malloc_debug.so.0

Thank you.
Usman

>
> > I noticed that there are some directories created that did not get dele=
ted.
> >
> > *'trash directory.t0000-basic'
> > 'trash directory.t0001-init'
> > 'trash directory.t0003-attributes'
> > 'trash directory.t0004-unwritable'
> > 'trash directory.t0008-ignores'
> > 'trash directory.t0012-help'
> > 'trash directory.t0017-env-helper'
> > 'trash directory.t0018-advice'
> > 'trash directory.t0020-crlf'
> > 'trash directory.t0021-conversion'
> > 'trash directory.t0027-auto-crlf'
> > 'trash directory.t0040-parse-options'
> > 'trash directory.t0041-usage'
> > 'trash directory.t0061-run-command'
> > 'trash directory.t0070-fundamental'
> > 'trash directory.t0090-cache-tree'
> > 'trash directory.t0202-gettext-perl'
> > 'trash directory.t0203-gettext-setlocale-sanity'
> > 'trash directory.t0210-trace2-normal'
> > 'trash directory.t0300-credentials'
> > 'trash directory.t0301-credential-cache'
> > 'trash directory.t0302-credential-store'
> > 'trash directory.t0303-credential-external*
> >
> > Any idea of what I am missing ?
>
> When a test fails, the directory where the test was run is not deleted
> so that it can be inspected to see what went wrong in the test. So it
> is to be expected that these directories were not deleted if the
> corresponding tests failed.
Ohh, thanks for this.
>
> Best,
> Christian.
