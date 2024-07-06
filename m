Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA10518C22
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 05:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720244619; cv=none; b=E7EwH5eJW8rboNvsIdTueuqv2AVm4D1HsfYQvEWbi8uQMLsrAr5ee+savNpmM0vGa0CMV/6AhxfmgpcMXEOgOe0vj077nhnCfSBkkXcIvmuCpwiaujSk1LuT5LRcPzlrCbYvwv0v9cWM3l9Azrd4h19tv4WKwHIkIydaHPGhqZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720244619; c=relaxed/simple;
	bh=pMbq0YgpZeFVx1LMH3N1q12CETOnSgSN7kpWFI3pxC4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UjGN6De1JgNw94HyOgFFMtfW4nXxmUDlmNmmC/0LPmfHzvI637gM0VxKgU8PgmKjocr4oSknshMdUkHwEPH5V+m0fsTVeKv4LknSDK6SyMB9hbXRcFk/A+1EOWP2fBQDAqPjG+e6O9rCQ2gvB0j9M5tr04864F9csplg14Xgqlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5fWrb78; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5fWrb78"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70b05260c39so1360360b3a.0
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 22:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720244617; x=1720849417; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vylhXUWt/pLilYLgKRwdiEhdi1GAW/LZFPsCl+rJEg=;
        b=P5fWrb784nB+1nkPlM7bQbZhyRMngF3CTA61w63Np2LkDkGvGLIOtoHXDZm0XhCWBT
         i510oID9rAjaEdrsqCfJxXXi/+tzs0C6T7dSl5+i6et53+Zd7yZyYezuRxFLnv0aPoE4
         xEtQ9q2TfTvPXcK6lZdSB1uB9Ckfty7/rd9favLECTgeR5SQB8vzKOXzdBlux7P1Uf2M
         V4QrjMSrKlTvRCt1DYD3sMZSiagJ2vFXYYJu0apkI5eCD7bwEZMfnrKy6a4n/nemohaO
         awfiRBd1wciegL0zeQwnQMUlgtE5gCz6t69HNLeKZUvHIt4dfdxW1mIQ8TIvU1UHJcVP
         6tFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720244617; x=1720849417;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6vylhXUWt/pLilYLgKRwdiEhdi1GAW/LZFPsCl+rJEg=;
        b=Gk9U/lw8FexcSn1UbwwCtEpQer5q54AwJXW5jYgGnt/43qKdzVXlnsRcZD/MQEbzEJ
         sH4+KVsqUYed5/8vtgNu3SL7zTCFAKcAUYldX6FSLn31MpwHJ8PWIbWMxxpOLeKDsSRK
         a6o3UsiByabAUM3vBkXBBdbvqHv3oIKD4T8IqWG3JyExb/yZo58cjxPYWLoSgPXitVyU
         nfpX99//uovhwCq7JLPtCdhjjtA5y0x23hcPew2aLuIf8DAt5hWpftXrc3SEblXIRFLC
         wwDhFFi5RQoCRfqcYF04j332CyTMX5o0qs5gUt1aHm7WQ81BK2vg4s3Yp1KKaRf6BbmK
         m+WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmR3HaG1AbfNyYBj8dUpmYvkf8Dwf7nNoaGM4PbNejRLA7sQA/IcJm0YDhLAbVw0lDdZeFUkaXVuitcGPXuzSmP+Db
X-Gm-Message-State: AOJu0YyX3Cn5aCeZo8bn4294Dy1Ucclk6kjqjpGKm1jNJLqY8VD1Z5Lp
	/4lsZTeoNqLV8PitW1HZgqvMYIOqnp44XfXz9JawhUgzfvIl+eDPTyf/gQ==
X-Google-Smtp-Source: AGHT+IFGjOkf/hrq2cHiF/up67xIANH0y4s1Wc0O7fHRVHzt9u5reFmTuPSnQiTc8l7T+tNhHMD8SA==
X-Received: by 2002:a05:6a20:a120:b0:1be:c786:556 with SMTP id adf61e73a8af0-1c0cc736f55mr7323265637.7.1720244616736;
        Fri, 05 Jul 2024 22:43:36 -0700 (PDT)
Received: from localhost (236.219.125.34.bc.googleusercontent.com. [34.125.219.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb55747980sm18429275ad.281.2024.07.05.22.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 22:43:36 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Emanuel Czirai <correabuscar+gitML@gmail.com>,  git@vger.kernel.org
Subject: Re: `git diff`/`git apply` can generate/apply ambiguous hunks (ie.
 in the wrong place) (just like gnu diff/patch)
In-Reply-To: <CABPp-BGVdQZCr=0NzY9vpUJqaH+5yxJdpvfUqqhtWB4V=nkwDw@mail.gmail.com>
	(Elijah Newren's message of "Thu, 4 Jul 2024 13:07:52 -0700")
References: <CAFjaU5sAVaNHZ0amPXJcbSvsnaijo+3X5Otg_Mntkx2GbikZMA@mail.gmail.com>
	<CABPp-BGVdQZCr=0NzY9vpUJqaH+5yxJdpvfUqqhtWB4V=nkwDw@mail.gmail.com>
Date: Fri, 05 Jul 2024 22:43:35 -0700
Message-ID: <xmqq5xtj5b3s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> Yes, this is already known.  In fact, it was one of the big reasons we
> changed the default backend in rebase from apply to merge.  From the
> git-rebase manpage:

Not exactly on topic of the discussion, but I see a few things
problematic in this part, and as I already invested some time
reading it, I'd leave #leftoverbits comment here.

> ```
>    Context
>        The apply backend works by creating a sequence of patches (by calling
>        format-patch internally), and then applying the patches in sequence
>        (calling am internally). Patches are composed of multiple hunks, each

`am` should be some marked-up to stand out.  It would be even better
to spell it out as `git am`.

>        with line numbers, a context region, and the actual changes. The line
>        numbers have to be taken with some fuzz, since the other side will

    "fuzz" -> "offset"

In the context of discussing patch application, `fuzz` is a term of
art.  It is the number of context lines you (the patch applicator)
allow the machinery to allow to be different between the patch and
the preimage.  Git allows *absolutely* no fuzz and there is not even
an option to loosen this (this is philosophical design decision
originating back in Linus's days).

This part is talking about something different.  `offset` is another
term of art and refers to the difference between the beginning line
number recorded in the hunk header, and the actual line in the preimage
the patch applies to.  Unless you are applying to the same preimage
as where the patch was taken from, `offset` being non-zero is
perfectly normal, but Git (and other patch applicators) try to
minimize the offset.
