Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592EA215F72
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 07:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749538873; cv=none; b=bnUDqcT6ZA6K5pRXWu/aCqCbmzK6g7vM4HAQUbhKa7gfh4HVtOXaYvzjL7KWv0lUqg2OydQL9kAx+jERZDtsNHAfbkwjWjDFDw3QVSzi4UW0mQtQLwH9PYv5brHNMAIcXhU+WSam/HNrr/vYWgArNzHBQGyODLoMGk2/ugatpso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749538873; c=relaxed/simple;
	bh=rVAtIwbUVQCEPJf6G+YOh1pp/vjAdjE0DDA7r6ra+10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uP2VHKem9rUdERbe56X6Vbn43O6Pb7rcp2lTmsVwpQ8JW2rJLHy9ByMQRCo2qOTTORcqI2KoIs3OuCsbEVWoCaeFF78nra6r6hh6ms0o/VX9W5BKC7S5S60cFqPapHSo9ZIkHr8W6FKNK6wS0ld6tfguQh2U5qXr4dE02Izlj8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fa/sai6T; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fa/sai6T"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-adb37582eb5so64913566b.0
        for <git@vger.kernel.org>; Tue, 10 Jun 2025 00:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749538869; x=1750143669; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l9TMHdNRGj2/Ns61Fc0LhfATReuabBvVimmws26KKK4=;
        b=Fa/sai6Tbw+mjT5zVZJTt2tzPf9eu3R/bBr0CIDSXhwBPqMDnNnzDvtIvae9CmPIHr
         jvYqca1ATGfv4KGo45Qfl0WIXd101WU0ZEZa7GQijL/ZeR3HkESuF/eCbHBnsFKLsJ2i
         MH5zRfFog+SHa/chqWCA0ILaIBYoIP254qmL79fj16cnJaQ8O/6ze3PCiWE9+9ZWr8Hw
         +p0gSKJVUQ64UISRUdKHzH2ju6mBjCY2EAcXSWmmhbEhJhFmFOP/CXaLR0yE5OAmnSRv
         yA/CEeKVL+i9HL0vqvzWDjdn3wTcechE1BJ+lLfCm9EXz/GWbVkGNxjJhLBwQ/7voRIR
         6GlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749538869; x=1750143669;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9TMHdNRGj2/Ns61Fc0LhfATReuabBvVimmws26KKK4=;
        b=FpMwUm43pu3Kaq7yDvk2HV5bdsQ3CYZpqA3488p43J62l7Fa3xmBkG/v90pmxP6iif
         VE8ZmP2htZR7zhxekolqEujzcTwMdJQNL66kdrAggB5Xvi6fzqEJNW44WRwB8y9lfGC2
         LSltiUa0K22Qfwo39mZb1yF2OC9wK7jZwfUkOQRzjKCeBFieeJ43vaLG5OiZB4ZtufUX
         MFYPmM7tpQttBproI6KDuL1lF8U/HFQo/jaS3x3d1aV+dLyWD798raNefkn/WjawJ8Pf
         3+qfgCVYsAX9VFUcAWV7mUNk1F1Os4MxkTtOM16o2mpTWT062hzlbJ7MS8JMgu8j70O8
         YWbw==
X-Forwarded-Encrypted: i=1; AJvYcCXI9977lkcOPf5yIhpNZvyla67xxsr+oJMPIu9j1ZhFsWF76Z/Tnb1PBtFMpkKmN5G5aoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl6rK/kndCKXyYYMrvdBrq3yxSaf9WW1d34NW636A4a2GZviST
	BrhhDOgTuR10HMHi0arvCPxL2DbTpobBJI/IWFa6Vc+YJL1cv4zTset4ETqXIkTPEwOpW/cryVZ
	S9v9LjkTO7QwXed5FKtd0kHfOzOwDzgA=
X-Gm-Gg: ASbGncvsFLqPNkTet3MBkZ7hUeB+rF9DVJ9ledbehgbsfeCcosAwkQjVYHlQSEijN33
	765Rhiq6mGoJxT68dqBvYCvjm0DjTGgBEk26hu83gCQOvRhaz1EYt6+CPsqlxdceAOuAfKbKfbo
	SkA3qxkJuJjPJhMHq+hCFOOlTD3fN1nYm+tvCBB+CasJwTtKh51iNDJgZCUjmP6aqp4AmXpjEi
X-Google-Smtp-Source: AGHT+IGSAJyB+TjdGLyfeVBLzy9TCA12jM7mAMPo+ZE5HxGJ7JQOOHcrXMcs/hwrsyr8f3Ny//KDp4riCAgnHSkuSuw=
X-Received: by 2002:a17:907:948a:b0:ad8:84f6:d896 with SMTP id
 a640c23a62f3a-ade22bb51e8mr490945766b.15.1749538868310; Tue, 10 Jun 2025
 00:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGJzqsnvTnp3k8Ab2exaBAw5pszQRz00UcucnK=ECtY5vhG+1A@mail.gmail.com>
 <xmqqcybcrc2u.fsf@gitster.g>
In-Reply-To: <xmqqcybcrc2u.fsf@gitster.g>
From: M Hickford <mirth.hickford@gmail.com>
Date: Tue, 10 Jun 2025 08:00:00 +0100
X-Gm-Features: AX0GCFtwF37KXHAIW9mWCTCZeAfPLwt5N2uaJ9_2nkghjoKvWSqMYzN0bdkM6cI
Message-ID: <CAGJzqskj803dUcEuV+P-yuWdT0tiaidb7h3YxQSCgYHWgBfaWA@mail.gmail.com>
Subject: Re: Suggestion: error "tag ... already exists" should distinguish
 between tagging different or same commit:
To: Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Jun 2025 at 19:42, Junio C Hamano <gitster@pobox.com> wrote:
>
> M Hickford <mirth.hickford@gmail.com> writes:
>
> > Hi. Presently, the error "tag ... already exists" doesn't distinguish
> > between tagging the same commit or a different commit:
> >
> >      >git tag hello v1.9.5
> >
> >      >git tag hello v1.9.5
> >      fatal: tag 'hello' already exists
> >
> >      >git tag hello v2.0.0
> >      fatal: tag 'hello' already exists
> >
> > To inform the user, it would be nice to distinguish these cases, perhaps:
> >
> >      >git tag hello v1.9.5
> >      fatal: tag 'hello' already exists pointing at
> > d4e6038a068d0aecd5ec28c83afbfc6d4903092f
> >
> >      >git tag hello v2.0.0
> >      fatal: tag 'hello' already exists but points at
> > 18a07354e33f86c8349ffdc300d9087876658264
> >
> > The second error is typically more concerning than the first.
> >
> > What do you think?
>
> Not interested.  When the user gets that "fatal" message, the
> existing tag did not get modified, so they can just do whatever
> check they want (like "git range-diff v1.9.5...hello") themselves.
>
> Besides, in the above examples, is d4e6038a something the user
> immediately recognises as the same as v1.9.5 or the object existing
> v1.9.5 tag points at?  I somehow doubt it.  So after getting the
> error, there needs some digging to figure out how v1.9.5 and
> existing hello are related to each other _anyway_, I would think.

Good point. How about just changing the second error message?

>git tag hello v1.9.5

>git tag hello v1.9.5
fatal: tag 'hello' already exists

>git tag hello v2.0.0
fatal: tag 'hello' already exists but points at a different commit
