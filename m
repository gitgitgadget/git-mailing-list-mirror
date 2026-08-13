Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0B82931EB
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 01:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786583989; cv=pass; b=FC0v9kc3Me4aWgQHZUk8Fw1zgke+4/fbwkffxXdoVO5ciIhTJYhNYeZzJvFaIAJdFrcIl2gwBV77mS2bZe0aI48AiaPPMDbrDGLMf7BYS051Dl2nMIeRRfni+nZsZ0GSx/qzqnyZiuaaMCgg2BHFERiduQbgCCX7SXfK1i24Obw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786583989; c=relaxed/simple;
	bh=Eov6Z7Lq9X4EkEChOGAf35vYShAglbPnojq4gD//qX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7/bXGi7HQmgyIRizN8i1GxnrZCeIC5cx/MnUIXTzxILXkgu8ooT/5Rzsto9qwpOHQer3cQzsMAYelqvkH562uoEzWD77kqX/DdbfvK35BVjKxk0LLzKqC1jPm+DFoLS7B1tgyO8bAZnT3ZvYVZQIsREpoJvAMO/7lBu6BXrSig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UA2l1qLH; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UA2l1qLH"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a0faa764beso10932251fa.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 18:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786583985; cv=none;
        d=google.com; s=arc-20260327;
        b=LJpCJ9wKuGjO88z96nQ4Tsb8ju1PixkQ6WdgI31aEK3hNbIel1YreCeTmdGPiB/c3+
         /eZ6gmCaFXI9qC7ybdysr4WTvEBsHiojuO5hD1qrm9gmP0w/Wd5B4DtBbOScAFzYPFSG
         dg+x349+ThoIAxEDxHsOSDpkB/bGAhuz9bAcZVMOD26b0z1qE0aEF319wwEcOtkys0f2
         WqfhsZ4Aky4/mz0pYQDMSI+UUC5s7jJCMLz/zlfgXyy9U8M0n+9U05V3mtVo1JaZ3leL
         0DLePjOisn6vQR2Rm6NyPxFwP0Bs/LnNBDqOweyApBXvFeNFjNyjTBQZivKt3SRICxZc
         lEFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xpWRUIU/Y/2pUFFQUtYALKZzUQXl1+OYk4C6yxTz+c0=;
        fh=QYRbzD/v5g3QPzx0HoYunBXD2RFnzMOkMce5boAXN3I=;
        b=mVoUSBVWxBg3cxbsLSQoRpk83SCkFCIWxObnp23sjK5AJdyyDdXdIFVS56eNXxN1Ue
         8v/R7RP8cX6U15uonJ/vih4t+lEdkcs4ciYjpW9D5rqCsvMJN/MsAWeU5Zip1gojk7v2
         pvXJT/JrQKoTFhul8X+LeTx2gwi2MfxHM2+dusqgpfjiTfEfs4KpNG5YQbrJWSTMagw2
         L7dEYIgO/Pqo5WzNgLD2MMDyiSMWXq1p2lASyaWyTSL2EtZSCRMK8xB70G0GnZkbeceh
         Xh49tQXeh4C5FlJvGT9Il5E6m3w81v8lV0j2crcNFOrAZUZxUBtxVcRM+/fyuZo+Fu1u
         x/fQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786583985; x=1787188785; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xpWRUIU/Y/2pUFFQUtYALKZzUQXl1+OYk4C6yxTz+c0=;
        b=UA2l1qLHnV1T6kiC70Hb7o3AlI/nV0amqcLWCs22wXLjdS/rDWfqEN+7cZBQiNMl2M
         hmA1d3M/sPt6159auu8kYzaQJGYF+rlOvQlYddk03/Grt6BMxiG47sJNToApjwlhjG/9
         eyYn7ySOf1xMMH6VqLz98onVLnp7cIfzZBPa1tOSFYCS3fOWYo3LR5tG2ulJUqWJ9NsX
         cF2cJJ1pjAHZzqklvoMYsvlhJAM57YOApBoUnqW6VvL+lmG1FRwiqQtbzsd9Lh3Vhmrj
         ZE3b0r3hCZojuwiLJX9hnm0pwa8OS8qLsZe6UtSLNbq/5qYhrKF3sjNEzP/HC735C1Jb
         HOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786583985; x=1787188785;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xpWRUIU/Y/2pUFFQUtYALKZzUQXl1+OYk4C6yxTz+c0=;
        b=ROShOS/5u7ihWeCzIoe0j8amu459Dlg1w46lKIBKzjFeip58irH594LctK4hYk2yxu
         bmeaD47LDm7XPGgHBF82cxWlt0g2LRTmPPe+12MFQqlpOBvI+xy1/Ir3qMdI0CyBMBeD
         pzh9fzE2eoeuFz0GjPz5o3JwYj6hHB97+YS8tJtlXuDXlrsHpK8AcgOwmkQJ0VMNeZZa
         rgJKYblFidpPa/F41zEHOS5ByW3FcR5D/rQynIF2JZ6MmIqmDXRnzMPl+pw6LU8ntE7D
         6funSP1d9ZbYaV38p5HR8fyw2E9mtF8eSTUtVb+o2qboNzN/gle5pKcXAGkhtlxXcwJy
         Qx/g==
X-Gm-Message-State: AOJu0Ywg8aH/n01+61040lqoOgbiBu85wlN2YqltafRgQinmVgJdB607
	TQBFNHbGH1+CoEWZaTqI13ZeJ2o6VQLFTh1AjZy3DrlNK7JSUFg2lXRYaD1S4PAY4zeWceplvRr
	5iB1vaq0nn5OF9z8Hy84K+8WRhUriqOs=
X-Gm-Gg: AR+sD106YzEjWd6n7df2Go7JBjvzip2VCGVtjWukUK+/2XqGZ+uTs7B1c+kFaMdQNUW
	MlLBPNH5Bflw3Xg7hax3uQwj9FYikRPby5hxCIaeJXqgY/8Xlt4EoFZD+qsFPgDcrSle/fMc1aR
	sRQOIUc+OUaSvwIXwYQ4SojqiRgQkgxg3+CUyFWAW/uVeAzlfve+3vJwFUEEWLpgxkq9hZ+eyRx
	BsM7iatvB+q/Vi2hMiWI7EfMdp/1UQbukHiuFB+zpk+CKWPZMg+TqVoWFykXzVRqePXApbBzdu2
	WtOUmSoYSenjEuStlQvEte0VBv7ig46ykPweQeOgZ7rsCH8ms/8eFNri9kZYc2pKW+OqtW0zA6L
	WyNgTmrawV4uU0DCbm0dlnbYeDs7xpiQxhTNXRyI8Cutp/tgDmNg7vchDAg==
X-Received: by 2002:a05:651c:1c8:b0:39c:7d57:a3ae with SMTP id
 38308e7fff4ca-3a11a064594mr2508931fa.0.1786583984951; Wed, 12 Aug 2026
 18:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721-fsmonitor-darwin-cookie-flush-v1-1-357dc5e32040@gmail.com>
 <anLtSOKqgcCrrNHo@pks.im> <CAJ-ks9=+4rxxx8+7fOF1aLFW67=hdxjhQsHqse1GGBLwZUh2BQ@mail.gmail.com>
 <antMfAYVSPX9QAk1@pks.im> <CAJ-ks9=oV4SQSjTHNEOGBaQb8Rb4xBqVSp4wYum6yzU-zx3YtQ@mail.gmail.com>
In-Reply-To: <CAJ-ks9=oV4SQSjTHNEOGBaQb8Rb4xBqVSp4wYum6yzU-zx3YtQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 12 Aug 2026 21:19:08 -0400
X-Gm-Features: AUfX_mwTQ9XGPll6E2OD2uGj5fF_XRse3LvEylgddTlCANtrCozs3QFjUlN3bEQ
Message-ID: <CAJ-ks9kQR77vH-56eS9tT-iXEnih+Z7SPRMs1gD_wTyg_6gZ_w@mail.gmail.com>
Subject: Re: [PATCH] fsmonitor: flush pending FSEvents before cookie wait
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Paul Tarjan <github@paulisageek.com>, 
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Koji Nakamaru <koji.nakamaru@gree.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 12:45=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> On Tue, Aug 11, 2026 at 12:23=E2=80=AFPM Patrick Steinhardt <ps@pks.im> w=
rote:
> >
> > On Tue, Aug 11, 2026 at 11:22:01AM -0400, Tamir Duberstein wrote:
> > > On Wed, Aug 5, 2026 at 3:59=E2=80=AFAM Patrick Steinhardt <ps@pks.im>=
 wrote:
> > > > On Tue, Jul 21, 2026 at 05:04:56PM -0400, Tamir Duberstein wrote:
> > > > > 56cef9cb1a (fsmonitor: use pthread_cond_timedwait for cookie wait=
,
> > > > > 2026-04-15) limits the cookie wait to one second so that a filesy=
stem
> > > > > which never delivers events cannot hang fsmonitor clients. A clie=
nt that
> > > > > times out receives a trivial response and scans the entire index.
> > > > >
> > > > > FSEvents can defer delivery while it batches notifications and do=
es not
> > > > > guarantee that its queue is drained in one latency interval. A lo=
aded
> > > > > macOS system can therefore time out even though the event stream =
is
> > > > > working.
> > > > >
> > > > > On an Apple M4 Max (16 cores, 128 GiB RAM) running macOS 26.5.2, =
two
> > > > > worktrees with a 1,001,178-entry index timed out 484 of 545 and 2=
97 of
> > > > > 365 fsmonitor requests. One status call performed 934,519 lstat()=
 calls
> > > > > during a 47-second preload and took 52 seconds overall.
> > > > >
> > > > > Ask FSEvents to flush pending notifications after creating the co=
okie
> > > > > and before starting the timed wait. Use the asynchronous form bec=
ause
> > > > > the client handler holds main_lock, which the listener callback a=
lso
> > > > > acquires. Keep the timeout and the behavior of the other backends
> > > > > unchanged.
> > > >
> > > > I cannot really say much about the FSEvent interfaces, but to me it
> > > > feels quite reasonable to flush the queue when we are waiting for e=
vents
> > > > to be delivered. And that's exactly what `FSEventStreamFlushAsync()=
`
> > > > does: it basically overrides the latency we have configured (which =
is
> > > > 1ms) and asks the kernel to flush stuff immediately.
> > > >
> > > > > diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--dae=
mon.c
> > > > > index 4161dd8282..8e32b5ae5e 100644
> > > > > --- a/builtin/fsmonitor--daemon.c
> > > > > +++ b/builtin/fsmonitor--daemon.c
> > > > > @@ -206,6 +206,9 @@ static enum fsmonitor_cookie_item_result with=
_lock__wait_for_cookie(
> > > > >       close(fd);
> > > > >       unlink(cookie_pathname.buf);
> > > > >
> > > > > +     /* The listener callback takes main_lock, so this must not =
block. */
> > > > > +     fsm_listen__flush_async(state);
> > > > > +
> > > > >       /*
> > > > >        * Wait for the listener thread to observe the cookie file.
> > > > >        * Time out after a short interval so that the client
> > > >
> > > > Okay, so we've unlinked the cookie file and the next thing is that =
we're
> > > > waiting for all events to have been processed. As said, it feels
> > > > reasonable that we're flushing all events before we start waiting f=
or
> > > > them.
> > > >
> > > > What I find surprising though is that this is supposed to make a
> > > > difference at all. The latency we pass to `FSEventStreamCreate()` i=
s
> > > > 1 millisecond, and we wait up to 1 second for the cookie event. I w=
ould
> > > > have expected that batching events for 1 milliseconds should be tot=
ally
> > > > fine when we're waiting for a full second anyway.
> > > >
> > > > So given that I cannot verify this at all and that I have no clue a=
bout
> > > > the FSEvent interfaces... do you have any explanation why the flush
> > > > seems to help regardless?
> > > >
> > > > I _think_ you're already hinting at this in the commit message, whe=
re
> > > > you say that it's not guaranteed that the queue is drained in a sin=
gle
> > > > latency interval. Is there any documentation that tells us what the
> > > > provided guarantees are?
> > > >
> > > > Other than that the code changes look sensible to me, thanks!
> > > >
> > > > Patrick
> > >
> > > The following was generated by my coding agent and fact checked and
> > > edited by me mainly to address you in the second person.
> > >
> > [snip]
> > >
> > > Hope that's helpful.
> >
> > Sorry, but that's not quite helpful. The questions I'm asking are to
> > verify whether you understand the consequences and subtleties around th=
e
> > code area that you're proposing to change. If I wanted to only learn
> > about this myself then I could simply ask an agent myself, but that's
> > not really the intent of a code review.
> >
> > So what I'm looking for is _your_ explanation, not the explanation of
> > AI. Your explanation may of course be informed by AI. But if so it's
> > your responsibility to double-check its assumptions, build your own
> > model and then share your informed opinion with us.
> >
> > Right now I don't yet have the feeling that you understand why this
> > fixes the underlying issue.
>
> Got it. I agree with you that the flush call feels unnecessary under
> the interpretation that passing 1ms to FSEventStreamCreate is the
> equivalent of asking it to flush every 1ms. Empirically, though,
> that's not the case, as described in the commit message.
>
> There's more precedent for this technique (found by agent, sorry):
> watchman fixed a similar issue here:
> https://github.com/facebook/watchman/commit/d1795de4ecab33672a89802318fe6=
f0122462194
> and the documented it here:
> https://github.com/facebook/watchman/commit/2f80886991ce81585ac0679c2b019=
fa0e4d9e9dd
>
> I agree this is unsatisfying.
>
> Does that help?

I did a bunch more digging and I'm withdrawing this patch. I haven't
succeeded in proving that this fixes the performance issue. I'll
resend in case this changes.

Thanks all for pushing back!
Tamir
