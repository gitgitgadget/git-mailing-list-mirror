Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EBE3BCD2A
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465413; cv=none; b=oeS0lYVXi1t/KPBglMvLtHohPWBqcyNghR7vxpP3I8kB+Acoovun9e0t0nxhQjOT+Cqy2K9/BFL7IZBYFWfxoOVaMeX/kG11HIjd03fzOT8lEIzzPlsy9C4C8pq7mcrzkWKIsqZQvqauokAVEtZKyVluN3dgQMBpDTOyC/s/Nds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465413; c=relaxed/simple;
	bh=KnF1p6RzcTWMzEW8sEkPaFrYBW6m0VpZ5Q+TOHowdTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRtjAvpmOSefmW8AzP/es2j0QcSZm/emZkCjYmlGkSqxi9fV6hnMCMYEKl+mLmvBe3KBDdsZ5AMISr64i5qkuEQF+/q5PhGvAD6TN2O47voiYbEWeeNrlydKQ5OL/zujr9jMfQ2Mnv93Pa950C+27rA9mpDo8U+V+7+I220jCBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=djFwqq7w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cSF69yu8; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="djFwqq7w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cSF69yu8"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id AB38CEC021C;
	Tue, 11 Aug 2026 12:23:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 11 Aug 2026 12:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786465410;
	 x=1786551810; bh=s248YKketYW1Jvf85A+Q1wPUCX7ZtEXcULHxO4rZukg=; b=
	djFwqq7wY76iY8kPu050k2snu73vrgaLBd+9CbYUq+4xmPw1lL3r9KExjNd7b7gT
	EZ3JDdvs2t5GrHnyNuBnU7piSEofmMobgyq1SrwanuJllU2fPVpQhcCWCL2Heae+
	2IhvWPli2t/NI43sT0g8aUPgXpzSTFMj0An6HzJ4ByD/eG+JmJ2HjGwknFdBZkdi
	imJnI/ERkxDQE/44hnXWjRxUl/N399LP4ND/rR+Hi+kQaPLsMAYOm3o8v/7MSoiI
	/Cs//71BbqEfnIQEMImX/tmNTV9MU5/VcVxpd8pNUPewIqAedcoiLO8C3uMh2v9s
	w98QtogZyktINNSkYr097A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786465410; x=
	1786551810; bh=s248YKketYW1Jvf85A+Q1wPUCX7ZtEXcULHxO4rZukg=; b=c
	SF69yu8jpX1JrJrg0/Lo+qpBOIDFdvLdgaQcRU2iNPDhK0T6gpSp4zOgOxHmQYzo
	/ZLmhY2XdlgZRUGpOqzO4PE28feyRcK32+pDeGBhAm53tzptKSqJeSKkBVKyCDO5
	DNBAwJ7AP5C/3jCDzDq6LPNtoKfDEAoMzvLv4gCE3NihYSUw0fT+lKSvEPVmEnJs
	JYO3XxPE8Jg3bUgTR+ILGXF/lI6wvbipHJVKatOw659lGswOKFrLVYVX319wsPar
	j8CLwSXzF/zzLled1JtPDTeDjbkIfIvtQz2FmILpTpVSpI+205DnlFGZdtQ0aM2K
	V0z/7jEAONf2kARDddSVw==
X-ME-Sender: <xms:gkx7ansCp2L1FRtUrLoD8ITs_x_yEQ3y-Z12bC4eryFsqfW8tgV46Q>
    <xme:gkx7arBwbjPEUHTQAJpn0K5GuzINaCNR6KqaV9ch-GXzxk7GaHSWB2oGG14WqEkVB
    1Jo1s2F28XCqKk0QDenU2FFbN54AaJaBeNueqyKW0peYJYMNbgw>
X-ME-Received: <xmr:gkx7aubvoSh2lbRS3LnejjRvBBSgGc8s8AVHrjWo4G9orPDHq2fOY2tmlevlIUzrCBbTzSILot5kov0EYUvSMTkG8JPlkZwySAIqxEYKZg>
X-ME-Proxy-Cause: dmFkZTF+5tVmnSOOTwQsUobzlvwPM+WJsIHnMqB3tsdu1shmz0yEf4bwBUPnUr3B+sNnMB
    E41JKGv9sbnRQgpjgge1oeI4c+ZApmcFKU5bWjOvs2nHGO4T92kE1KxHOy77UaciNmQaMW
    0JzOFf3AhMp7shpmf9Zmmqbn4B7rYn2EZhoOHjzrc8IHolvyOUxW1pQurH2BfyxssSxGo6
    Tx92et/Zqsc+quUG5musMql7XpLiOH3UvKuvz7zM32sojJAgPCwkPtLrj2AlATnmNk028c
    oXcQRa5M5lrTndtAkRIWpzlgZfFRkU6EVEn2kI+co2F2Go2MU1EEWHRkvXrKPFVsoXq5js
    gudA7MabieE+X6/LqqNn3M9MeAyDqdW2j4Uq6QSPxO6G039x2S3r0Rthip0d+eKPVKZ5GP
    bjR7byHennhi5foKJgxG71mvFamwYBQMBBSKNA1majIOauiHF7tKiqaS7wOdwsGdOCheTW
    n3g+pYvRkdQE26BuwRFdNk+Gr5++4S+Ppm52sElEesvHBL9riR6DakT89+nKhTOdNi0OJw
    JM5pAZeIzSs4rduos8CeMEcJ0KcSbET291mjkWVLb0NO5/dcMpyZCVK6C9sGc1IfxOyQA1
    2lnjWBdq9IrhUN/yo4QWyiP5UxwAX6C+q5ChTOd64PDCnucXIqAAG44Cfr6w
X-ME-Proxy: <xmx:gkx7amV-EHTbMC0TzZVOrPfR785DUYNHh7fAr-l5Vb28weT0yVDO_w>
    <xmx:gkx7atO-MNkVSBv2E6wYKbxoKcWEgxWc_DG1H8-wzz5TwbbjsbdtMg>
    <xmx:gkx7agaIWDsYxM7o-RGGpD8TsNr4CJ8sXi2b5NuJRYOP0O9sHRSysw>
    <xmx:gkx7as9KdjHJHF0k5UmxG08eCMMRunnBMND2L80HpwHr4dPXNuo16A>
    <xmx:gkx7atmHNnQxdBzjBgKC2VbJhEiDSW-WdA8yU933SzL0kXmNSGpOkNfS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 12:23:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1f07295f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Aug 2026 16:23:27 +0000 (UTC)
Date: Tue, 11 Aug 2026 18:23:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
	Paul Tarjan <github@paulisageek.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH] fsmonitor: flush pending FSEvents before cookie wait
Message-ID: <antMfAYVSPX9QAk1@pks.im>
References: <20260721-fsmonitor-darwin-cookie-flush-v1-1-357dc5e32040@gmail.com>
 <anLtSOKqgcCrrNHo@pks.im>
 <CAJ-ks9=+4rxxx8+7fOF1aLFW67=hdxjhQsHqse1GGBLwZUh2BQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9=+4rxxx8+7fOF1aLFW67=hdxjhQsHqse1GGBLwZUh2BQ@mail.gmail.com>

On Tue, Aug 11, 2026 at 11:22:01AM -0400, Tamir Duberstein wrote:
> On Wed, Aug 5, 2026 at 3:59 AM Patrick Steinhardt <ps@pks.im> wrote:
> > On Tue, Jul 21, 2026 at 05:04:56PM -0400, Tamir Duberstein wrote:
> > > 56cef9cb1a (fsmonitor: use pthread_cond_timedwait for cookie wait,
> > > 2026-04-15) limits the cookie wait to one second so that a filesystem
> > > which never delivers events cannot hang fsmonitor clients. A client that
> > > times out receives a trivial response and scans the entire index.
> > >
> > > FSEvents can defer delivery while it batches notifications and does not
> > > guarantee that its queue is drained in one latency interval. A loaded
> > > macOS system can therefore time out even though the event stream is
> > > working.
> > >
> > > On an Apple M4 Max (16 cores, 128 GiB RAM) running macOS 26.5.2, two
> > > worktrees with a 1,001,178-entry index timed out 484 of 545 and 297 of
> > > 365 fsmonitor requests. One status call performed 934,519 lstat() calls
> > > during a 47-second preload and took 52 seconds overall.
> > >
> > > Ask FSEvents to flush pending notifications after creating the cookie
> > > and before starting the timed wait. Use the asynchronous form because
> > > the client handler holds main_lock, which the listener callback also
> > > acquires. Keep the timeout and the behavior of the other backends
> > > unchanged.
> >
> > I cannot really say much about the FSEvent interfaces, but to me it
> > feels quite reasonable to flush the queue when we are waiting for events
> > to be delivered. And that's exactly what `FSEventStreamFlushAsync()`
> > does: it basically overrides the latency we have configured (which is
> > 1ms) and asks the kernel to flush stuff immediately.
> >
> > > diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
> > > index 4161dd8282..8e32b5ae5e 100644
> > > --- a/builtin/fsmonitor--daemon.c
> > > +++ b/builtin/fsmonitor--daemon.c
> > > @@ -206,6 +206,9 @@ static enum fsmonitor_cookie_item_result with_lock__wait_for_cookie(
> > >       close(fd);
> > >       unlink(cookie_pathname.buf);
> > >
> > > +     /* The listener callback takes main_lock, so this must not block. */
> > > +     fsm_listen__flush_async(state);
> > > +
> > >       /*
> > >        * Wait for the listener thread to observe the cookie file.
> > >        * Time out after a short interval so that the client
> >
> > Okay, so we've unlinked the cookie file and the next thing is that we're
> > waiting for all events to have been processed. As said, it feels
> > reasonable that we're flushing all events before we start waiting for
> > them.
> >
> > What I find surprising though is that this is supposed to make a
> > difference at all. The latency we pass to `FSEventStreamCreate()` is
> > 1 millisecond, and we wait up to 1 second for the cookie event. I would
> > have expected that batching events for 1 milliseconds should be totally
> > fine when we're waiting for a full second anyway.
> >
> > So given that I cannot verify this at all and that I have no clue about
> > the FSEvent interfaces... do you have any explanation why the flush
> > seems to help regardless?
> >
> > I _think_ you're already hinting at this in the commit message, where
> > you say that it's not guaranteed that the queue is drained in a single
> > latency interval. Is there any documentation that tells us what the
> > provided guarantees are?
> >
> > Other than that the code changes look sensible to me, thanks!
> >
> > Patrick
> 
> The following was generated by my coding agent and fact checked and
> edited by me mainly to address you in the second person.
> 
[snip]
> 
> Hope that's helpful.

Sorry, but that's not quite helpful. The questions I'm asking are to
verify whether you understand the consequences and subtleties around the
code area that you're proposing to change. If I wanted to only learn
about this myself then I could simply ask an agent myself, but that's
not really the intent of a code review.

So what I'm looking for is _your_ explanation, not the explanation of
AI. Your explanation may of course be informed by AI. But if so it's
your responsibility to double-check its assumptions, build your own
model and then share your informed opinion with us.

Right now I don't yet have the feeling that you understand why this
fixes the underlying issue.

Thanks!

Patrick
