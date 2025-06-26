Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BDC28C5A9
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750952012; cv=none; b=q0jZexoaOjOgEq+uw/F3UcqhscJ2u3i4ftgQWqy4nWlPU8kG71fY3zmGE0igUrj/dYaidHdDF8qTMoi5ow2tgTChpZT18AB/EtY6G9MsZEWXBcHIKF4elGCCP6W2/6Lzywl0EIikWGSjV62qcML3M6HQer7qxgB835FYDXUoSOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750952012; c=relaxed/simple;
	bh=55MKrqcmJ6Qxz2tzWwX+lHTv7tz300UaoCutJQwEuho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZOe093kXUsFpN4gimtLm9tGeaF3gh3cHzRbSjB/EbovKC4cFRNpzubbSovS+4R/p549s3IQlrXRZ4bl3baF6+Vf1K+/lKl0dXauro/uQ9uwZ9h0LXtBu8Px6qt2f7Dwz2ew+IVtP5f9a7ag829PIuXZVfJLM46/3cRMKLgWuX0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbWGRDrn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbWGRDrn"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2350fc2591dso11654295ad.1
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 08:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750952010; x=1751556810; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3WDVYtWkBLaUF7meLJbVBIrIWbudvOSdBq7we0ZJujc=;
        b=CbWGRDrnq9UNAUZciunfMYOrRTZZihe1RGcRjJx5esSQ6xXFf7tlHfhkLm1IIVpAiw
         qTnGvsBeTDD7eeemqrXrPC7H7THO7ByeKea45hD32vMbqlKViArq0Kwkayec79aK6hg1
         Uev3ukF26TvXHJtVtSsKpBc7uY48CgMOEvM4tnZ8IKfS3kArqcPDZX+Y5dUVbjh9wkBJ
         alSSymVqh/6ac/g5hdtqFPyrbPfLKOwQDplVY9iiYO7pB5VY17t+/Wlmk0vXbLTnG8Iq
         GbnMNX08OU5lauymxAVTN+X3JYckUxcOEe/g0qvw+/dhJG4zEctfSaTLbE5DBmwIQndk
         m4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750952010; x=1751556810;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3WDVYtWkBLaUF7meLJbVBIrIWbudvOSdBq7we0ZJujc=;
        b=JCpoIItxS2VfBKtSRhGlaTibm3AiYAHahmvFWyHjWijbsdkihjXgRi5OQp95ZV5/IT
         FRr2l39Ifd5omOEJTccGB2iUMQP0KjBOSf7z8Scf/gQirub13Xa5x70p1jQcOBOplgHZ
         9yag1n0oJqsYUPRTpPoi1cdN0qetJfOVavUYBs0FKVX4r/rUodr4l8cTZseQgy6WZCXP
         wIvQQtUNGqpulywOufTAjGJE6HJfWv0XIM7JbbQfyDh51WvDO/+GQZhDeN1ptse3CkCr
         NNR8AStz4IX7SsfgVFxtFE3zghPkdCvi58UWit9KmDABNTRaZUgjwaWzP7Mng3v0f9vY
         GrQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbN8bLgmzV85xbaX9DNV54wKNuRAWJhVGnSBTeQvkxYVGlT+I58vEGJqbxbzTLC/t6SRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK+7FdN/QjUbr1W2zXKrMyH4s4S51yQu03tII44F53SJPtw2TO
	rytzF8l8BYUjPrFAZF0a89EyLm5Q4gCWXtIhVbmGlGiJ5CoKO/c12NxacrV3Hw==
X-Gm-Gg: ASbGncvw3qIWmcbk4dYKpBk6f6nS6FzbEvtcbZQPwWj0+GZFIi76JJEm6ifyVY78ooj
	nzQv4TncZN7Ef+g/+4pbD3SO3t+xSVL6WDaucSA6vstijYGayj5W+RHPNhu4hb4QNLAOQSzAcHr
	tnWgXTXwCk9QjartxH5kMXEtlis6dqGKDSH5i8lfn9ixw+T17YANF+E6P+JkUy9ul08xSskrNde
	y9/rJ0IdcNx9gjAOaQteCzgYyp/7PiA/Wtqaa6HmNZGI30L9NBjkJWmf43BHTUd7ZHSqikBALhd
	mYnv7v3mqKvy9scIV7KQPn2bk/xJkDzyPIXnFLsREMwFZdgdBKXK1R1fDpgfTr5K9Xi3lLA9Qi3
	wN5WYSU6asUoa76u9dyrXQjh6i84=
X-Google-Smtp-Source: AGHT+IGHTcqjxFSTlNG3/DB7S8h/BgkhqHkfq3iU9WJsjFtaTjJJFQLQAPb0cIQb7y3j8o0hQh/Qfw==
X-Received: by 2002:a17:902:da8d:b0:215:a303:24e9 with SMTP id d9443c01a7336-238e9e21ae0mr55407105ad.3.1750952010164;
        Thu, 26 Jun 2025 08:33:30 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23abe3128aesm1062685ad.49.2025.06.26.08.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:33:29 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?=
 <carenas@gmail.com>,
  Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v3 3/4] daemon: use sigaction() to install child_handler()
In-Reply-To: <d7c86948-e0b0-4864-88f8-fd1222e0dffe@gmail.com> (Phillip Wood's
	message of "Thu, 26 Jun 2025 14:11:52 +0100")
References: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
	<pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
	<c66bda461f45791d278779fb0021f1e0369fe889.1750927989.git.gitgitgadget@gmail.com>
	<d7c86948-e0b0-4864-88f8-fd1222e0dffe@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 26 Jun 2025 08:33:29 -0700
Message-ID: <xmqqy0teplfa.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Only because you have chosen to use SA_RESTART here. I think it would
> be better to drop that and instead say something like
>
>
> POSIX leaves several aspects of the behavior of signal() up to the
> implementer. It is unspecified whether long running syscalls are
> restarted after an interrupt is received.  The event loop in "git
> daemon" assumes that poll() will return with EINTR if a child exits
> while it is polling but if poll() is restarted after an interrupt is
> received that does not happen which can lead to a build up of
> uncollected zombie processes.
>
> It is also unspecified whether the handler is reset after an interrupt
> is received. In order to work correctly on operating systems such as
> Solaris where the handler for SIGCLD is reset when a signal is
> received "git daemon" calls signal() from the SIGCLD handler to
> re-establish a handler for that signal. Unfortunately this causes
> infinite recursion on other operating systems such as AIX.
>
> Both of these problems can be addressed by using sigaction() instead
> of signal() which has much stricter semantics and so, by setting the
> appropriate flags, we can rely on poll() being interrupted and the
> SIGCLD handler not being reset. This change means that all long
> running system calls could fail with EINTR not just pall() but rest of
> the event loop code is designed to gracefully handle that.
>
> After this change there is still a race where a child that exits after
> it has been checked in check_dead_children() but before we call poll()
> will not be collected until a new connection is received or a child
> exits while we're polling. We could fix this by using the "self-pipe
> trick" but do not because ....
>
>
> Then we can drop patches 1 and 4.

Thanks for a suggestion.  I really like the "everybody in these code
paths are prepared to receive and handle EINTR just fine, so we do
not have to do the SA_RESTART" observation very much.

