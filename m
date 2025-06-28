Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465ED21B8FE
	for <git@vger.kernel.org>; Sat, 28 Jun 2025 06:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751091564; cv=none; b=sb8HaZXIMdN4eB7azyJff1qpTU8mJ3ChqQcX2+LEIMn5IVSxerjBrLpwO3rJFPgXhHhjAPuXzEsFrnZX71pYhvMbQezEhR4Z6BMZCs+KbIUi1u5i9plcO4QhqjGBsGqP989Oa2X4wKHs7ETkbfNF5Iu8MoCNG0z0iHJMbN1xl6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751091564; c=relaxed/simple;
	bh=f3CQdj98idA6LwxsnFH1OYUVUMNiwJchf1e1SBpTud0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alSRR5pk5FiC+j268TAb3WCb5YvKiMZFCTPkNkoug58kGvOgwIUGqwsCq4IKWnPGYsZ+JOQur1IxAaD/ZdyEWEwz2bKyftA3XblVPxXaMIkCituBWo3Bvf7A/U69HJtPSqmI/LbqhqAuf+zPWZSp5YV1Y84xDUa9X1N+WkKsWjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9ZMwpUq; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9ZMwpUq"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2350fc2591dso24701065ad.1
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 23:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751091562; x=1751696362; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z8x3oc5iKCt0fYtzn4S880pcvPDJY7fBPHuadIbEGPc=;
        b=F9ZMwpUqW5K9YTlT7y1UUtw2REQG6xhHMGZjN9qbhILNYPz3VSrY1iUPUNmoh/ia78
         4N2ROIxQxSXbWssSiotWICxGG0e37Pp13l/65b8ivXPgSI2FFhqAYBhIRlu7MRqHEuDJ
         5RoN3SSjl0/UN/faiG9X5QWN2Zi/XXb7fj9kAA/9pw2IKsX1Ai4f9x4wvqXW+30OG3rr
         Lbhfh1X5m0lTpl/xza/mVrXIYzB9RYo74pXfxqG5+UZPlYC0TKDYQ6KTu9ZgM6vknOW3
         YePfK91WP3YryzZAo4IbzaAJUW+nza9EZlamxcd9UX3IpBVMf4pzJkcSt1eke4rz4YH7
         IbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751091562; x=1751696362;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8x3oc5iKCt0fYtzn4S880pcvPDJY7fBPHuadIbEGPc=;
        b=HMx6bdvxhRTFRph+2myqfRaCwMEmYrUN2pc5eJrasFVq8JBEAHMN7I2p/6xqWF3zQF
         sAMmuVOIlRH3/EYX/KsiSSwRa81+XPmBXpttfHPHjILmnZBuuCWsvL4TiFmlaewcRJHz
         2cLAl+QMJpKcbl+HKHeD9oPzxPaYDBjKruYX9udcZ+KqqD0KhLDX1akZ5xbMxAXmRO5o
         oU13gMmu92G8dpw02d7FloPhaOlAWnzY61obXblcqchixnll/DY7jk2MyHHAmtgnx/v5
         cE4TnCw1Aojms7u3iwit1syMMJeIZvZovOyJ/sVj17Azhwbre67fTZWLtK/CPvyNdEIn
         HepQ==
X-Gm-Message-State: AOJu0YyX4/yhcZaMkT/L6U8D2TIzOnZxfT8fLDQyR05VbhBQ7IZUnltQ
	fk8C5+E7jxQ/Gt8AuZk4qk1HkvW1639dIV0R+DGjeFjDAAbdo8bnN+EU
X-Gm-Gg: ASbGncvp9WgtXXT9cVMVIHUBPE66ZhCVs1lXAlVbesVvBAMAVgFUMCx2ZOF0YFvp8CH
	8CWhHHh7bNfnIb9GgmNYigAqPOcmevcgsGNS/tjRUMkhZe7fowCVD0u4/bieX7cE6f4eOK7S6vy
	owaaW7BiqIb/Md1cQXc4DHd1WR5VUm7m70vvltx+bzUnYkRl20uVbYrXGkHS9NKhNejnB9bcbSR
	FX8/mU5LFLxKItUEDlEEA26P+Q85ZgqaxZwdRDbMZFKKy2E1au/ryBFq4HBhFs9yVI2BB2ekLgl
	RF6LsNm0SW1a0m4ozWlud6G4U9GsiCcxWdDhPgpV3SIg5wTE4qjVEkG5YdZ3cvH43rSK/OM+JuJ
	15uiGFCQYN/9emEMnm+jDM38=
X-Google-Smtp-Source: AGHT+IE7pI4iUQXBUPYBiflpWkefqqjn+vDB1piDPdhshrdVrx5vxNf163eeeW7SFOLZsHudEHSrcw==
X-Received: by 2002:a17:902:f78f:b0:235:efbb:9537 with SMTP id d9443c01a7336-238e9e04734mr145637055ad.3.1751091562221;
        Fri, 27 Jun 2025 23:19:22 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:fdae:9b06:496e:5a9c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c54b8sm32533895ad.217.2025.06.27.23.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 23:19:21 -0700 (PDT)
Date: Fri, 27 Jun 2025 23:19:20 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, chris.torek@gmail.com, gitster@pobox.com
Subject: Re: [RFC PATCH] daemon: add a self pipe to trigger reaping of
 children
Message-ID: <zy6xtfqnncs3kuipgvdb7jiu7ynodbf7mld4r2ojy3jwkkthm6@jtnzecikxda2>
References: <c314cd2d-8fdd-4386-bda0-881ff87d9204@gmail.com>
 <20250626182432.87523-1-carenas@gmail.com>
 <59087d2d-6034-44d4-9fa0-c51d4bd60683@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59087d2d-6034-44d4-9fa0-c51d4bd60683@gmail.com>

On Fri, Jun 27, 2025 at 09:38:36AM -0800, Phillip Wood wrote:
> 
> On 26/06/2025 19:24, Carlo Marcelo Arenas Belón wrote:
> > 
> > I had a prototype (only the bare minimum) that I thought was more
> > efficient and that would instead remove completely the need for a
> > signal handler which I would post (only for RFC) later.
> 
> I'm not sure injecting an fd into each child process is a good direction.

I don't either, but frankly don't think it is as much of an issue, if we
consider that all the children are known internal processes we also own.

Was hoping that by producing a working (albeit ugly in purpose so changes
to the current code would be minimized) prototype, we could have a
discussion of the potential issues/benefits that would be a little more
verbose.

Indeed I posted this an the other series both as RFC, and as replies of
each other hoping to give them both a chance to be evaluated as alternatives
together.

> > diff --git a/daemon.c b/daemon.c
> > index d1be61fd57..d3b9421575 100644
> > --- a/daemon.c
> > +++ b/daemon.c
> > @@ -912,14 +912,17 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
> >   		add_child(&cld, addr, addrlen);
> >   }
> > -static void child_handler(int signo UNUSED)
> > +int poll_pipe[2] = { -1, -1 };
> Maybe call this signal_pipe? I'm not sure what poll_pipe means.
> 
> > +
> > +static void child_handler(int signo)
> >   {
> >   	/*
> > -	 * Otherwise empty handler because systemcalls will get interrupted
> > -	 * upon signal receipt
> >   	 * SysV needs the handler to be rearmed
> >   	 */
> >   	signal(SIGCHLD, child_handler);
> 
> I think from Chris' email that it is conventional to do this at the end of
> the handler.

It really depends on which flags the signal was expected to use.  For maximum
portability it would seem better to have it at the beginning to minimize the
inherent race condition from when SA_RESETHAND is on effect (which was more
of a SysV signal() tradition).

Will move it to the end, regardless, as it won't be needed once the call is
setup using sigaction().

> As I said above we could add an additional commit that moves
> this into the event loop to fix the infinite recursion on AIX.

Not sure I understant what you mean by this.  I think Chris made clear that
the AIX issue comes from the handler being expected to do the wait() calls,
so the only way to "solve" it would be to move the `check_dead_children()`
logic back to the handler (which will require a lot more changes), using
sigaction() seems like a simpler solution.

> > +
> > +	if (poll_pipe[1] >= 0)
> > +		write(poll_pipe[1], &signo, 1);
> 
> write() might fail so we should save errno around it. Conventionally one
> would re-try on EINTR as well though in this case the most likely reason for
> that is another child exiting which means the pipe would be written to
> anyway.

EINTR shouldn't be possible here from SIGCHLD, because that signal is
blocked here, I wrote it this way because it was only meant to be used as
a fallback to the EINTR being triggered in poll() and so it wouldn't matter
if it was lost (for example because of a SIGPIPE).

Once we move to sigaction, SIGPIPE could be added to the mask for this
handler, but that code can't be implemented on the current base.

> >   }
> >   static int set_reuse_addr(int sockfd)
> > @@ -1121,20 +1124,43 @@ static void socksetup(struct string_list *listen_addr, int listen_port, struct s
> >   static int service_loop(struct socketlist *socklist)
> >   {
> >   	struct pollfd *pfd;
> > +	unsigned long nfds = 1 + socklist->nr;
> > +
> > +	ALLOC_ARRAY(pfd, nfds);
> > +	if (!pipe(poll_pipe)) {
> 
> If we cannot create a pipe here then things have gone pretty badly wrong and
> I think it is unlikely we're going to be able to accept incoming connections
> so it would be best to die().

True, but since this is "optional", there is no harm on letting this continue
even in failure.

> > +			int flags;
> > +
> > +			flags = fcntl(poll_pipe[i], F_GETFD, 0);
> > +			if (flags >= 0)
> > +				fcntl(poll_pipe[i], F_SETFD, flags | FD_CLOEXEC);
> I think we should probably close the pipes if we do not set FD_CLOEXEC.

Why?, worst case is that we leak a pipe to the children, that wouldn't know
of it and woule be able to work either way.

Carlo
