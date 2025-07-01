Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B6425BF1C
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 07:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751353250; cv=none; b=aAiJhDRjoO0xSM1mrwu4FGk8LynYfZeZl8EGtPnRDKiWz/TTMr388Fk4EVW5hEQZDQUK7wvG9/sBU2KocIxKFJCgVl9wokvqQWObxer9GQ3xjfIa4O8Qxpnh/RecdCRrnw7E+L0dElXu5v8r4VE7Mopt2/95LqwCKEL49KD3/zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751353250; c=relaxed/simple;
	bh=Nub52wc5Ygziq4KGcoyacKceyssRzo18kcXo4WMwzSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8Ue8vmEM9UAmm6aGP+9KUifvO1rR2nIYhhaDfY9AzFeDWax9UmadCxJ6arf37M753O9gksZFttWn4jcm5Sxb7/bu4f57+rFrhIrvpg7Gy6QUJJPIiIECu13N2ou5pcDYr+i28ElLtP0C9OxRflnu4wwq/rG/1KUUSKW2VMJLpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKMspiqu; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKMspiqu"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0bf1616b9so81170166b.0
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 00:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751353247; x=1751958047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yBM3q8x7N1jsYiHosXn+702Yup7Knb+6qq2PSvXOi/s=;
        b=nKMspiqunfb5V6TeRr2m5kJjthWCHh8h3AsjfR1Vggp3nq1dS+50SyOJQDjzNBsJ0Q
         nq0ZyDa9HwlK3ASAPA1KA92++0VrJumNARNRuPq8tq8A0D1qenCuNe7Vg7yR9kcAyv/q
         vWREAi8hRoielzIkZd6kPRZiRvzXri0eKCR7gomYnb39ODFq1rvFMEkLwnyqxhEJ4XyG
         1gCR8oTgJ/gdDCkei+CfUUzL46MgqEXDXdAMl0qpPtHJA9YfkUBRUnez7Ig+2jybyhmh
         pWR4D3GnJonT6R1FrQaQxBfLWH5+cQl3SsUZ9q4A4lMgsa7Rhv9l++f1QhXXOlwEz0fP
         2fDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751353247; x=1751958047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yBM3q8x7N1jsYiHosXn+702Yup7Knb+6qq2PSvXOi/s=;
        b=ans4hC/V3IUDp45aOHa0wWsdjMqPazN3duZVhfkPjwNn6CGrsqUb2OgsaI6mUrV8bM
         xponQjY/gW3oinq9WVKD03lO/5e5KorKhXQGo0p8ryhEosiZN8dd1x72wVqQvtgNxcBA
         Ocr9BYNCJ8EpqW2PTiMWWA6EKv+uikS3FJDnrVqDUL9NuizmpI2Xf//f7nAOi1893c6A
         a236gzYOEL/2WOKZtl04gjAjHyGEsFxQ0DoBBLMd4t5L3BlFFtpWPrn6luFrxg9Ob9DC
         jb5tkgoQjlL+jmXLZ2ibSJybYgqq/jmHgZ+ft17bNAZvK0ZA1fvXXhk8CeFYesAaEAD2
         5HRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGCGRH2xnmPCaAdFhJm37H+sy7EhNO4af0hIf3m5eSyx8+Dv9qsAS0awh/eRlp/g9nXTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDsw0mnxX4vfxXZKa6sUrRfEURv7KXTzFpw+S5JeZwvp4q+nxF
	sqSkZAs3wc14aPeUUBFw+HsPXX6cOC7zv+SCr+t2/J9HseeDZveNFqRmgecWBKQpQV8V3u3WLWr
	xq1PVvy4axda/7TDu7l8av6Oznn+3UOVVgB9y
X-Gm-Gg: ASbGnctE7JYhJ/QQVr4UIDrqK2MtIS4MHc2cW+lh4bPdH6krG1qEkHHK3hQ9XIf+Hag
	C3E2pSZOcoAa5wpJ5gC16A16P7FcYyF7Tl1tBMhgkaqUkklAJOVjk+Ji4+AV2WJ8F6YDOAm1YFd
	m8moI7MTQqNBZhBVeF84XrXAZzEb/ElG6SbBUmOWGWg7c=
X-Google-Smtp-Source: AGHT+IGNO61XOPOHBB5BzqGkvBDAttDZ+9nRft1yWpABvgC6N7LAqseVSAMIVM1gL/+nMmRrCaWcIrgJcm0h2NWjdMY=
X-Received: by 2002:a17:907:7f22:b0:ad8:84f6:d896 with SMTP id
 a640c23a62f3a-ae3acfd0d1dmr68510766b.15.1751353247001; Tue, 01 Jul 2025
 00:00:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGJzqs=kJtPcMrWC8Dayd+VW7BvC1rmzS0zT+EwQXfLOpZ3Tfg@mail.gmail.com>
 <CAGJzqskDumbMSbC3rdYT8fZ8gNJ5MOjR_o8RAo9QS-nuvbBinQ@mail.gmail.com>
 <xmqqtt4u86x2.fsf@gitster.g> <CAGJzqsksmQmY4o-_7DoPFK8VP-h59ANUjroVv2+++ZG3gDBdUA@mail.gmail.com>
 <xmqqtt4puhwq.fsf@gitster.g> <CAGJzqs=Xur+=0=KUSR6TQA-A3zt-Bpyd5-T52_ntuV+mCUrAQA@mail.gmail.com>
 <xmqqjz5ijo97.fsf@gitster.g>
In-Reply-To: <xmqqjz5ijo97.fsf@gitster.g>
From: M Hickford <mirth.hickford@gmail.com>
Date: Tue, 1 Jul 2025 08:00:00 +0100
X-Gm-Features: Ac12FXy3e35-7lszlgQPFThKb-bytR-mqjUp5Iy7yorGDvLiyysfEO15Xwo4urw
Message-ID: <CAGJzqskku=BSx_rZx0EgLLS-E2uJKLxu0rfqkKFTVSJ3Su749A@mail.gmail.com>
Subject: Re: Fetch remote only if remote hasn't been fetched recently
To: Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Jun 2025 at 16:23, Junio C Hamano <gitster@pobox.com> wrote:
>
> M Hickford <mirth.hickford@gmail.com> writes:
>
> > To support Git users with sporadic connectivity, might it be useful to
> > add an option to git fetch? Perhaps  `git fetch --offline` or `git
> > fetch --complete-prefetch`?
>
> "offline catch-up" is probably the phrase I would prefer to see in
> the documentation page to explain the concept of the operation than
> "complete prefetch".

That makes sense to me.

> In any case, to present it as a first-class option to end-users,
> there needs a lot more thinking and a bit of work need to go into
> the way "prefetch" works.  For example, the longhand I gave would
> work as a good solution only when the user _knows_ that the prefetch
> is more recent than their actual remote-tracking branches.  If
> refs/prefetch/remotes/R/* is older, then you wouldn't be bringing
> yourself closer to the present state of the remote at all with such
> a fetch, but as far as I know, a normal "git fetch R" from the
> remote R would not clear refs/prefetch/remotes/R/* when it
> completes.  There is no "last time we fetched from there" record
> kept anywhere in the repository either.  So offhand, you'd at least
> need to do these:
>
>  - teach "git fetch" that updates remote-tracking branches to remove
>    the corresponding ref in the refs/prefetch/ hierarchy;
>
>  - decide on what option name to use for this new operation and
>    document it;
>
>  - implement the option "git fetch --that-option nickname" to
>
>    - figure out the remote-tracking hierarchy for nickname and call
>      it R
>
>    - when refs/prefetch/remotes/R/* exists, do an
>
>      $ git fetch . "+refs/prefetch/remotes/R/*:refs/remotes/R/*"
>

Thanks Junio for your insight.

I shall leave this as a feature request, perhaps suitable for a
microproject #leftoverbits
