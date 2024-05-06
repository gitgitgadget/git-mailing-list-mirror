Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084A0158873
	for <git@vger.kernel.org>; Mon,  6 May 2024 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025523; cv=none; b=quRmLG4aWmhpqaBo3ZWC2i5fqBBu7gnjz5YAX3GZX8348XYgbcF9hEEK3ZmWgOGInvZ6pfBEwlXwpRRiPE5X7YPMFSFpLZEO7hcIDCFeV9K/myCgYKo1Xld0jeeuIKt5YeA4ipBDl22u7/lyNGTL2QwTL0hfVi0JhZP+aswIXZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025523; c=relaxed/simple;
	bh=N7nydKfkeMGz57BjSBmMJ7c9KaZTP2PjSJpmY7jpFBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbxQIjhjkzZgmsNpTMDGtQx5oSwEZnDTbuBxD066godz0waAIeX9v0xXFHzvGwYhT2iQtg5RFTQsK7jYya3BzwufWgJ0dqvbSl1lX2vEwQ2JUrG2cvMG8jAvGXFOe6eNBiqa4mJ0mMl9WsxrTfUHc1QooMgLg5nIbaIn78K/QSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3AIjOr3f; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3AIjOr3f"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a2da57ab3aso1841726a91.3
        for <git@vger.kernel.org>; Mon, 06 May 2024 12:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715025521; x=1715630321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOTzAIcOoUy+ZCN+TGRs+uAF46mGkLn7E1n372ShyGE=;
        b=3AIjOr3fQRdJWDxO9+GCzCdyiTOcZrjZIHXvTRU7TLk2/Et9AGs51l4eohMJOnyNSj
         tCT8ZAIouQw1vn/kKzP873+jDaXQWvk4mZUeYCFFzMHunGctwsquw7ktBS0aHWP5YIou
         GMhTA9M+JWHTEqhmLbN6WEh/4vVX6kKYtVHC6thVNECXit49MWeXnCG9prIxcBnZRrYt
         9KnVfKqSlQoPpkkr5trZoD9xj0TtEYDDsGVJrplPvkhgj6fV9JyHBOirGtlnkPvI/yOc
         2TlwmwzGObhtMeeSsD8RksvtP7F4+7yDUUSOWmRifAggS3CD7QFxfeM2d7igiXgq3+Qw
         X1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715025521; x=1715630321;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gOTzAIcOoUy+ZCN+TGRs+uAF46mGkLn7E1n372ShyGE=;
        b=dF5rPYJv9hZ/nnQNxxS+JAVRSISr4rh9F0swZfqIDeUSWI0HvvggNni5DC4u6gYfCl
         EgqCcys7F0yOKbl+DnJmX8Zf8UfEN/uoV+LAoEvnG8ETUe4OE/joKkQrMI0Nffn1U1sS
         tHSYJ3mlg74eaUoTmpl21J+YcgcvMEbH/68mqP9/1qwPjwlZo8HbFcOvCsXedPU4mUAi
         jJg98ETU/uCJol3cxSfKb2m1n5JhaRqVhrdJqJhwUotNq27/sDP0TpOjtqOiW1Schqgc
         Wd+yDkA3zl7tYTv1PALNsDvrH/yJHSvQQptdNOt6Pa/WldfKy7bX7n/gXSpCoJ67lrhy
         2POA==
X-Forwarded-Encrypted: i=1; AJvYcCW2N3/2C5o2IUwPYuN1r0gmc+3Q4ZkPFBJhYdDpFSGR1FHLKrv+OGycZsiec1wvJOoDrbyyUaGj8HtLhLz2Mjm2lYew
X-Gm-Message-State: AOJu0YwBbuTQrmiMarSE/1B3gwAUhBuRyD8TbETujYHLHBM8M8lzZioR
	pz80FpZ6zZaCVNNHH8WtJduwC6xIdyYQwspdSCBRhesKFgGOpiQLEKqPc9V5Fw==
X-Google-Smtp-Source: AGHT+IGoFK7SAETQ1+MlemJjQI8SuuZ9Nl3ui36AU9e5Q3Ad7Jg9IRIuICrO4xcZvMuPj7wy5Y11sg==
X-Received: by 2002:a17:90a:17c1:b0:2af:d8cd:6709 with SMTP id q59-20020a17090a17c100b002afd8cd6709mr7712703pja.41.1715025520858;
        Mon, 06 May 2024 12:58:40 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:cf3e:6b4e:994:dc81])
        by smtp.gmail.com with ESMTPSA id ay12-20020a17090b030c00b002ade3490b4asm8555568pjb.22.2024.05.06.12.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 12:58:40 -0700 (PDT)
Date: Mon, 6 May 2024 12:58:35 -0700
From: Josh Steadmon <steadmon@google.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 6/7] t/Makefile: run unit tests alongside shell tests
Message-ID: <z3k5phrp5cbxyorie3fhkvhewltz5z7lqumgraxiieur3gm5qr@ei753rpieyyf>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cover.1705443632.git.steadmon@google.com>
 <cover.1713985716.git.steadmon@google.com>
 <0e32de1afe9cbab02c5d3476a0fc2a1ba0151dcf.1713985716.git.steadmon@google.com>
 <xmqqo79yxxk7.fsf@gitster.g>
 <20240503180239.GA3634479@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503180239.GA3634479@coredump.intra.peff.net>

On 2024.05.03 14:02, Jeff King wrote:
> On Wed, Apr 24, 2024 at 02:25:44PM -0700, Junio C Hamano wrote:
> 
> > Josh Steadmon <steadmon@google.com> writes:
> > 
> > > +case "$1" in
> > > +*.sh)
> > > +	if test -z "${TEST_SHELL_PATH+set}" ; then
> > > +		echo "ERROR: TEST_SHELL_PATH is not set" >&2
> > 
> > Style.
> > 
> > As an empty string is not a reasonable value for this variable (and
> > you do not quote ${TEST_SHELL_PATH} when you use it in "exec" below),
> > 
> > 	if test -z "${TEST_SHELL_PATH:+set}"
> > 	then
> > 		echo >&2 "ERROR: TEST_SHELL_PATH is not set or empty"
> > 
> > may be what we want here.
> 
> If we are using ":+" to handle the empty string, I think just:
> 
>   if test -z "$TEST_SHELL_PATH"
> 
> is sufficient, no?
> 
> (not that the other is incorrect, but whenever I see something like
> ":+set" I wonder if something more clever is going on, and of course I
> get nightmare flashbacks to looking at generated autoconf code).
> 
> -Peff

Fixed in V6.
