Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613472C6AE
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 22:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708122639; cv=none; b=CNktYFlf1V6ewJrRRjtBUsbHTLaoqPYWeIElUyZy16yhoS1g479IF24twNdQmDNZbgrQHysFsnQdJ6ov6gVeYVSfMaHMc/d9XnGuAGnuyQ+CR08et9mZbpe+1/KFFzYCeMMdSgyGh4CNMoRcYOI7B1TAYLjt34oJ0BDRAlqr/Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708122639; c=relaxed/simple;
	bh=117mR1h3q3oL6qgDi6gcwsQk/M4fTVi6OV/IMK+oAOw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wk2lqHM+CysrN+sJX74ppsZMVJQZTj4tcN8tlt+iTQrmBQqDozt4NLdYGSRJvyx4yAXqfuRYLOx9rjollATvNL6M6lDTcvWhSS0uPscJ/LiNnJwepR2y3CiC76wHolruRHst1ejlYHXpHv0ebJKBNKBCamz9aqdnkyEr//Gm1y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OUZzld9z; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OUZzld9z"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1d542680c9cso34975095ad.2
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 14:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708122637; x=1708727437; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VUAEmvF8NqykQpzE1LbSUZdWwcuRwDrW/wt1EF2osV4=;
        b=OUZzld9zsTlXe/iuQtOULikN3drN6lCMsB0Ksx/AUJp4Jc6gpRNuFlpIEcX6Tb45ox
         8aCCcqZCUP5qswqL566xbWtJcCSHT4qDv0TV3MZdes7q8b1QyK8JgjXxDZJLdqYPoZgC
         WA18xg+ZzEoILKv0vo3+m+SE9gOO/g6EqhVMjAhjxHU0mRWIFz8Ylkrq71ChSi+gr0QX
         8rT691AXtnx5N7/14kAQj11syrz+FX9+CAglKZQQv2CBBfDk3Z/Mvfs00iU9zNkLlQfA
         ytoZ4/9F/Kie4VmckSlPJMyNDjkJdsupqr5OK5PbdJfsZutPDYU/gWhyB/9Hs2jDeafy
         aJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708122637; x=1708727437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VUAEmvF8NqykQpzE1LbSUZdWwcuRwDrW/wt1EF2osV4=;
        b=raBOA1xU2OAIGZ6db9dxxLp6aBiw+4Pw0ytBDliRgZ+aE3OEolZ0jKRPzf7jDHIf77
         qlQy0Y1p1MtKXbNejh7BNRs31OfpdepTZmzQsBYogTHcUgmtT/u4QNJQFP+grWZJod4N
         sngsrA7+BwMiEPg0Nf2SEJUTjJtVpzHWOGcJO3OOwk//l2kLiAj//Djxzrk/8c8k9Wec
         1Xpdfldy/bH+PGA+BuzCaH5qYkb70Pf5KZcl1F1mQdXgzoJeotqrzr6oFgDXNbySIWlF
         CaJN1j2NYA7jjVmieUmvsYFrces+3IcQ6AGCpJH60ohvJnm43joxUx7QuHVIDa2fh9Pc
         R5QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvmHlMlJ/hP8yAZwmjY5U6I26KxpD6x5sUke/wtGMw4V6ZxTQZQ9TOQhy6bD6R4KpbTOkygBdidBBDSn7i81Tb1sO2
X-Gm-Message-State: AOJu0YylWZTRRgizYLW/3Hn8pocePWzwibNk+lrlnzQ/TFysOfwBvlMp
	aSk17EXHszEWtl6nya7ZUYPiiaejhUksf98oN86UALSFcRVgTcvYXMsD8TYerDGda9IGcaPHQWB
	2wA==
X-Google-Smtp-Source: AGHT+IGgycx0L4S9fRSddKAvihnsmHpZRJwcfl4ZP1q7R0qJukDaPShJQdH6oVKAs7O7SCutsiy8jDqpDT8=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:e5c6:b0:1db:b4be:2bc5 with SMTP id
 u6-20020a170902e5c600b001dbb4be2bc5mr107956plf.6.1708122637618; Fri, 16 Feb
 2024 14:30:37 -0800 (PST)
Date: Fri, 16 Feb 2024 14:30:35 -0800
In-Reply-To: <xmqqr0hcglpk.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <xmqq1q9mmtpw.fsf@gitster.g> <20240215053056.GD2821179@coredump.intra.peff.net>
 <xmqqv86pslos.fsf@gitster.g> <xmqq1q9cl3xv.fsf@gitster.g> <xmqqr0hcglpk.fsf_-_@gitster.g>
Message-ID: <owlyh6i882k4.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] git: extend --no-lazy-fetch to work across subprocesses
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"


FWIW, I see some typos. Otherwise this patch along with your "git:
document GIT_NO_REPLACE_OBJECTS environment variable" one both LGTM for
wording/readability. I must defer to Peff and others for "is this patch
actually doing the right thing?" ;).

Junio C Hamano <gitster@pobox.com> writes:

> Modeling after how the `--no-replace-objects` option is made usable
> across subprocess spawning (e.g., cURL based remote helpers are
> spawned as a separate process while running "git fetch"), allow the
> `--no-lazy-fetch` option to be passed across process boundary.

s/boundary/boundaries

> Do not model how the value of GIT_NO_REPLACE_OBJECTS environment
> variable is ignored, though.  Just use the usual git_env_bool() to
> allow "export GIT_NO_LAZY_FETCH=0" and "unset GIT_NO_LAZY_FETCH"
> to be equivalents.

s/equivalents/equivalent
