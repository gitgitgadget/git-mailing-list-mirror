Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F43A23CB
	for <git@vger.kernel.org>; Mon, 13 May 2024 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715617330; cv=none; b=Om4LRbXZbgYzrbmqGEiIhkmVrQqPA+KErIIWp91IIFdR3v4APeTEkLHMlGao2K6vzZw98Pw3jhfGPs+VHt2BRMP2vr/gMsQBkF/1XPwDmdHDyVHmLA+R/ipfuoBM85aI0DTKwdHt0yAtGr8LFtGc/KQhGP2+YXw5QT6FgRMTYTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715617330; c=relaxed/simple;
	bh=B4C+bzCBJn7JJ0ZbZc/ZmFWcQBLUs3f86lUYeH3ZZu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULIT5/IXmq56DkrL05rDllNd+sVmW3W2DWV+AEPTqY6DvxeEcLTSTfskPZAxbKSx5qkiZTQ7sPcWTnWBW7Dt9USbRYBrR5UvEAnLwfaczVTmQQOUcKv3zSXCkCUiyg0LNLTA0vi/Ajta1eMS/pnW7/Y402R4j2uqP4uW0518qRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l20YW1J/; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l20YW1J/"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-43dfa9a98d2so342021cf.1
        for <git@vger.kernel.org>; Mon, 13 May 2024 09:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715617328; x=1716222128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5PSK7xWfi/SX9s79/5XDVGHGa2PEySdB1Wso4W0690=;
        b=l20YW1J/c+by76JyXxk4oCqPVdQHy/J6Z5F0nHya/UmXPNjXK3YcrndJWosPwvOCFe
         6DlRsv8fcaLhO5igXwGJuTQe97ef/587zjJ4Ue7xCgmkxZme+FMs2Qc7nvQDl8lJgUqE
         fMUs3Z9WRaJ8/CMmmpflX7+IrbV/RWNKW80D/3vV+O6a/KVIK2Zxo5iRprHH/9/kkRzz
         zbdHGK40vNPZjSpVVUoAKCQyfruUr5vH2YP2+rPQxPa7VXVr/VX8XVSXa/92aUssCCMz
         uww+DjZASEP7H8D99Z6DBXs+mLJEj92JClA5yFaAjbNILar7jQHnwY0qMUQeBXH73Iqh
         aJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715617328; x=1716222128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5PSK7xWfi/SX9s79/5XDVGHGa2PEySdB1Wso4W0690=;
        b=Ggcosn8FJeDNpKwisUhk++CY7VsgskKi81o5ul+Dk8dnU83o1wG2qHKymJ7NKVGX8Z
         HyCp+Lr2aOitQI2tHjax+ISwZ2MkeI2ATVoBDt0OW9wEPAJGaZF8fM4UiECR1oEWDEex
         8BTbUIOis/wluZAS4x9VMYAIFRPQmlUk1Sz/Mfj18BT2FXg5bWStLt7OzTIqkuyo08iy
         mbtFIoY9uHDO2+rppWQbnpwecnZFbqB3vP1aA9/8IkhX8SClO246AJG4PrMKbVWxxMw9
         FwpYTw6F4cf0EqvsQreWXncS/k2BpxfdyUo45CGl993R+bLkTXT45z70lD/MtKufQt8j
         AxFg==
X-Gm-Message-State: AOJu0YxV8gpVq99LEchDPlDdwKR/bf5wDMZ58rfGUPeR9mQpmBvGCYhS
	1y4JEo9gGcG1GI8ppHWytGjkjUQ+hXK/P6cDGfRnVom+HDw/k59pcxNpj3cchOQwL/m6T09fq29
	7LNBUVK/pRje0VU3iAyPeESsa5RMKO/Tthm2YMQ68pEHEJ00sElPROG0=
X-Google-Smtp-Source: AGHT+IGJDnEZbD0gJymBoBGydqKIKMgAsyZgwAq0XLeo9yyW3yJfrrgm1nRQijmbNVtrALtCTP0dzjtd1IB6NZNDpOU=
X-Received: by 2002:a05:622a:5c07:b0:43a:db0c:ed9c with SMTP id
 d75a77b69052e-43e0a22ce28mr4375331cf.15.1715617328061; Mon, 13 May 2024
 09:22:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510172243.3529851-1-emilyshaffer@google.com> <20240510194118.GA1954863@coredump.intra.peff.net>
In-Reply-To: <20240510194118.GA1954863@coredump.intra.peff.net>
From: Emily Shaffer <nasamuffin@google.com>
Date: Mon, 13 May 2024 09:21:54 -0700
Message-ID: <CAJoAoZmdU281buNTm+K0wHMunsbzbZ6NXFdqh=PkDUwQKfpYEg@mail.gmail.com>
Subject: Re: [PATCH] trace2: intercept all common signals
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 12:41=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Fri, May 10, 2024 at 10:22:43AM -0700, Emily Shaffer wrote:
>
> > From: Emily Shaffer <nasamuffin@google.com>
> >
> > We already use trace2 to find out about unexpected pipe breakages, whic=
h
> > is nice for detecting bugs or system problems, by adding a handler for
> > SIGPIPE which simply writes a trace2 line. However, there are a handful
> > of other common signals which we might want to snoop on:
> >
> >  - SIGINT, SIGTERM, or SIGQUIT, when a user manually cancels a command =
in
> >    frustration or mistake (via Ctrl-C, Ctrl-D, or `kill`)
> >  - SIGHUP, when the network closes unexpectedly (indicating there may b=
e
> >    a problem to solve)
> >
> > There are lots more signals which we might find useful later, but at
> > least let's teach trace2 to report these egregious ones. Conveniently,
> > they're also already covered by the `_common` variants in sigchain.[ch]=
.
>
> I think this would be a useful thing to have, but having looked at the
> trace2 signal code, this is almost certain to cause racy deadlocks.
>
> The exact details depend on the specific trace2 target backend, but
> looking at the various fn_signal() methods, they rely on allocations via
> strbufs. This is a problem in signal handlers because we can get a
> signal at any time, including when other code is inside malloc() holding
> a lock. And then further calls to malloc() will block forever on that
> lock.
>
> We should be able to do a quick experiment. Try this snippet, which
> repeatedly kills "git log -p" (which is likely to be allocating memory)
> and waits for it to exit. Eventually each invocation will stall on a
> deadlock:
>
> -- >8 --
> doit() {
>         me=3D$1
>         i=3D0
>         while true; do
>                 GIT_TRACE2=3D1 ./git log -p >/dev/null 2>&1 &
>                 sleep 0.1
>                 kill $!
>                 wait $! 2>/dev/null
>                 i=3D$((i+1))
>                 echo $me:$i
>         done
> }
>
> for i in $(seq 1 64); do
>         doit $i &
> done
> -- >8 --
>
> I didn't have the patience to wait for all of them to stall, but if you
> let it run for a bit and check "ps", you'll see some git processes which
> are hanging. Stracing shows them stuck on a lock, like:
>
>   $ strace -p 1838693
>   strace: Process 1838693 attached
>   futex(0x7facf02df3e0, FUTEX_WAIT_PRIVATE, 2, NULL^Cstrace: Process 1838=
693 detached
>    <detached ...>
>
> This problem existed before your patch. I imagine it was much less
> likely (or perhaps even impossible) with SIGPIPE though, because we'd
> see that signal only when in a write() syscall, which implies we're not
> in malloc(). Whereas we can get SIGTERM, etc, any time.
>
> Obviously the script above is meant to exacerbate the situation, and
> most runs would be fine. But over the course of normal use across many
> users and many runs, I think we would see this in practice. I think your
> test won't because it triggers the signal only from raise().
>
> So I think before doing this, we'd need to clean up the trace2 signal
> code to avoid any allocations.

I started to look into doing this, and it's actually really tricky.
I've got a sample diff here
(https://github.com/git/git/commit/bf8a5084ede2b9c476e0cf90b7f198c52573fba7=
);
I'll need to do it for the other two trace formats as well. But, the
entire trace2 library relies heavily on strbuf, which doesn't have a
stack-allocated form. I'm also not sure how we can guarantee the
no-alloc-ness of these - maybe there's some flag we can give to one of
the analyzers or something? - so I'm worried about backsliding in the
future.

Anyway, I won't have time to work on these again until the end of next
week. If this looks like a reasonable direction I'll pick it up again
then; otherwise, maybe it makes sense for the fn_signal() dispatcher
to just time out if the handler process doesn't terminate in, say, 1s?

 - Emily

>
> -Peff
