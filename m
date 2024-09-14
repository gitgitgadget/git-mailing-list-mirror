Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A4A1754B
	for <git@vger.kernel.org>; Sat, 14 Sep 2024 23:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726356486; cv=none; b=PsTfrPjgN0DjVubqkv/nbxbXX7jDYTGnaulV6lhII1lyxiOIMhvFWLPOiTwSGqxVM+HpSBkFu9TpzjA9ZYoReKPWjZ7BI9B9aFijHn0lfUoT2QyWwLLKC4NrzjF9Ic98TDtk9M1lQrdHaU8dC0BFq+gLrlqWkhjcbiAJHWs2YNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726356486; c=relaxed/simple;
	bh=zTMOQyOCLKgERK3gtUopgvnZvZoOQ/YccYMCwn2LoY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UuIhs7nKFKEUSnc6UjtMg+7rTGcvCKCUSyme3BTRgMhaPFzZ0S1RKCkf2pHaz2yjcNhfWRgGW02VpJ8SnqfmuTEGV6D2yiz0ov2z8fCWRRTrFesrqUnAh/G35mDz0tmHO9ZFA5hLgmov5L4I9HGF3X7mOIalRQUkk88QrEqMvmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sl0BHh88; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sl0BHh88"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8a789c4fc5so700423466b.0
        for <git@vger.kernel.org>; Sat, 14 Sep 2024 16:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726356483; x=1726961283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTMOQyOCLKgERK3gtUopgvnZvZoOQ/YccYMCwn2LoY8=;
        b=Sl0BHh88p9rsc2H0f8CENsAKR0BqpWWoN8W3T2YyucHd5Pg3MuzvkgJVvDYQb0L/nh
         WrsfwimsW93P1zLp/3qSaYkiljbhzsTrb0bn387+BxnXW1Lh9f6UMstmgHk+Ma/W671P
         ajpVwFxcFYD7foXYwM4H86xm8Cb54QwRhJ1Yuwfb0ApkWxmKB9+F8IjO4OvLXlVAKmEW
         FwNqAkh5uQWohWIh5b63ZXvSUGLJXBdA91/+vg10kXh90cQKHxaj+CUZCcQmR/7hRiow
         1NpE/QlVT8TakTMhf0Ue3MAvGhcP7f8jDpllxw2j43IOOK6evoRUCnLyWNbu03sdeIe3
         FTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726356483; x=1726961283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTMOQyOCLKgERK3gtUopgvnZvZoOQ/YccYMCwn2LoY8=;
        b=SGw5hU2ibQ9S2wLD1iwpoEiCbZAQwgkZ74KucMyruLKUrZkIDEiEBWWwQq0KicrTes
         SdYa68R7odgOv0NcBE8VJSBVR6sy5DqB7Tpk/2Hw2jvLp4Xycwzq3EfsvC3MraSCB1Kp
         UEs4gU/95rjrcLCF+Z9pRV0Hr65nZRvqpQL6azcqdyI4XODDDjFU+778q4mkvzOsGWgg
         8sfo9gUMR8OGdKEB4DvjoyvzkURKD73mFwr9U079ZufcQ4KIv9U1Jj80TgjvlJzKxS9L
         FjO6BrVlP/G3rXE6eRJaDf5J4ALvN8fx2E6wgw2/Qg3zpFzIdo6PWGatmZnfhvArRsAU
         KCng==
X-Forwarded-Encrypted: i=1; AJvYcCXyT3w35iTr3HWTj1kHl9EwHpV/xSGIeciyp2yk+FfS6z66AW1gYknmqtNEZtGti4bxChY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHuJe/IWf+Zi7XBj4fGyUEGQiV8XHzTO4GN6F9HTvq8yPURoJ5
	iflLgBj6V3vWEFU3oPd9WGIpNoIjUOrEWTzerAZg4rLUPzcrmun/A5lCBesrCra422Y6qpnlH/P
	wBjWUwjuqWZlG/MNJmiDQN6mnosRDmg==
X-Google-Smtp-Source: AGHT+IH/txj+RlP3ZAhh3GQSecDKi4xyhtkVBYCSL53CWpDEEWT8Xh53yQ2J2DuJobaNZjUw6iyrCrq01G36aWN1oEw=
X-Received: by 2002:a17:907:3f91:b0:a8d:5f69:c839 with SMTP id
 a640c23a62f3a-a8ffabbcc0cmr1707282266b.15.1726356482310; Sat, 14 Sep 2024
 16:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqmskbwe1a.fsf@gitster.g> <20240914064130.GA1284567@coredump.intra.peff.net>
In-Reply-To: <20240914064130.GA1284567@coredump.intra.peff.net>
From: Chris Torek <chris.torek@gmail.com>
Date: Sat, 14 Sep 2024 16:27:50 -0700
Message-ID: <CAPx1GvePRNzt_LFJAf+_-abdt--075LG8-DA=2YW_0R1soXz_w@mail.gmail.com>
Subject: Re: [PATCH] t5512.40 sometimes dies by SIGPIPE
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just a quick note for background:

On Fri, Sep 13, 2024 at 11:41=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> I really wish there was a way to ignore SIGPIPE per-descriptor (or even
> tell which descriptor triggered it in a signal handler), but I don't
> think there is. Some environments like "go" claim to do this, but I
> think it's really that they ignore SIGPIPE, and then assume all writes
> are going through their wrapper, which converts EPIPE into the signal.

It's more complicated than that (and varies on MacOS), but it's true
that the Go runtime wraps all OS-level write() operations. The reason
for that is that Go has its own internal "thread" (g/m/p things, really)
scheduler and does *all* I/O as non-blocking calls. Anything that
potentially blocks an actual OS-level thread has to be handled
specially. It's quite messy and You Don't Want To Go There (no
pun intended) if you don't have to.

(The Go scheduler is especially complex since it's doing M:N
multiplexing of goroutines to OS-level threads within a single
OS-level process. It also has to allow calls in and out via the
Go scheduler and foreign-function interfaces. When making
a blocking system call, it will create a new OS thread, increasing
past the normal GOMAXPROCS thread limit.)

(Also: I'm not steeped in the internals of Git's transport code
but Peff's patch looks good to me.)

Chris
