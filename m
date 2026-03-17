Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3C53E6DD6
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760450; cv=none; b=IgQBSFYy82qyIz0fLMKAbLhn5WEECcIIsa5Vm0AeH1QOGSWuZeaglrGMdvIrxjXIj+1XVZNf4fnRNojEuWTBi5BN1Jslewl3WfqMuCaBCGmG5vugQ0gfhxLIKm8K8nWTyEm4AzlbrHo16qvZtIZLlnfqdQPT6c/JKRFAygaSsoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760450; c=relaxed/simple;
	bh=5LoCbX9EVR8CuqQFKqC0g/0ukWX1lR9hgELUcm+mPSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l68LsnrtocI9crD4cT+tRVnAHsK9t75aACoMmamGb58TqVuNKUjLn14gQEQsNo4VOQJV0Q/JuDcXOwXezfyTUQ/aLZehY68JQEPbDzvBlIFnH7Av1+YnpppxuF99jR8G4BmzF+AfYz+YGf5Fd5cn4vOOMQW+quBNtXIbadiLsqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1gOJSN8; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1gOJSN8"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-829a568f3ccso3317794b3a.0
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 08:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773760449; x=1774365249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pfbuVP5anej5inin+pvk0vlx5dW/tXgAZI2UZKcukg=;
        b=S1gOJSN8XJ6pbigqnwq+KTLGXL1z68QF8c/OlPCaFE0KZNjnr5czlpdVXKIqJFwA1z
         yX3pxJtvrnfVBNn/cLgept493Vm7bWdwodIoEIbmboNaT75VKHx8OHik8IedAenWLFlC
         yYaYXT05XuGuo1F4Lb2NyRElVEyKiBrlueD6otqafg0DpNrFzMqqQs3ZHx9ErDc5i7Lp
         cGuDa0nHYMnfk0931dxe60sBmMPzAyA6BZIjm1zDfOV1ea9uvsbcwC6oAsoimJ6/oM+r
         dr0ncdephMOxIOexMn0iGtR17V9rL7epCcTFhcT6BmRwcfcmcUFRhqTkfooOLA+W9htF
         LRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773760449; x=1774365249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2pfbuVP5anej5inin+pvk0vlx5dW/tXgAZI2UZKcukg=;
        b=EAgxM+rSVKd9BbQRU2LvhC8kF56qZL0sxyzScB1W0kEveorUjG7SgYh7OtGMy3mjOm
         Nt7sKXr3SV1mFvhGG25NknGifB0S4IaU/qJxK6zMbWinSxNw1Z9TGfCkGj1iwUAAi+cn
         15EIIznpiIcqtQy+R1dDKIWInG5abLwmpokjWNRjxfnZS6Hd/I7s5sFIQrbQ/ZPTI+vC
         dLJ3ybvuwmi4BpL2VdNKdkUfxsgF+rp6LuMhzZhn+7Ge+tlbqc4kO8s78Z7hLDFvk1GT
         GrwhxAq2v+0ukEf+pLt/MTOSLcqAW5Z0JSytT+MoRD9za0Oz6MFxve0vZPiEKoHx8wEM
         PzFg==
X-Forwarded-Encrypted: i=1; AJvYcCVNLZP3v4hr8ROvXLny2BSf2kyZoiO6P3Kl3nfL5D/B4whMxA4YJvu2owYGoAB4MYjddos=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmQ8I+kTWxVcwXdK0ltUQrrsZ6i2r+G+KBfnX1gfFj7+poaSLg
	lCMWYpnkWk61IlJaGa4yKl2bU3rwsc+d92QFHSMmWpSIOQW1ZyZ9xHAg+JzNRqzGfemu4Q==
X-Gm-Gg: ATEYQzy8HMQ2bh7xFAh6O4lDoQa1QapqpXN9OHhMdehgRsqn2e/XhKdzghbSuVFL5Uw
	saTiPv4UCpmYgY8fGdYLZpn4H8SzYN3iCvB37v+eGGXgPHNGDhy4Jml+7xA3e98IwhZJGarl5OZ
	eDDikyQJ9DQuP50KPStaWlxKUI+CF0wcmzrO86CxfKeNvcxQOVXVqn4EZBewa3bxPXKAJaYJyWd
	gXf+vXAAAkLeLfBN2nHFPhxpsZu12tsopD/92Xz7vtFU2akX5qtUibzYZ2QZ589/+tHKv5zKJIl
	4OsNtYeqii1hUXzlYYePB91ccyscGnVuZ1OU4AmXwYVrcKLAmIDdXcdYLqHL/4E8kF4e3rQ4obk
	5+34nRRburAwPPoIvsGvCyYFKlhw2y5/vHc7Bg+45LOr7h3nHp0oZA9D+kax3xFliH4+i50HNkS
	YizFaosHDYPcN2UszwHjX/t/ApzWQX9TL8dNw7aV1BKkl9+BSLIfTghVmUazNCvjQiSc9hHp9KA
	V6tvWBM+bHLiWASDUZ5J26vuOOEnSMXjYwUszNsNZrcUQvTVw9EKmFRQZ4pqp9U2LHdAQFjc+hW
	pSQtbjPSFz+lnlY72Q==
X-Received: by 2002:a05:6a00:2495:b0:821:78ae:9dcd with SMTP id d2e1a72fcca58-82a19703f47mr13596170b3a.13.1773760448907;
        Tue, 17 Mar 2026 08:14:08 -0700 (PDT)
Received: from localhost.localdomain ([2409:40e2:2a:942a:806c:cd9c:a577:892b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0736e64bsm16605055b3a.50.2026.03.17.08.13.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Mar 2026 08:14:08 -0700 (PDT)
From: SoutrikDas <valusoutrik@gmail.com>
To: karthik.188@gmail.com
Cc: ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	christian.couder@gmail.com,
	git@vger.kernel.org,
	jltobler@gmail.com,
	siddharthasthana31@gmail.com,
	valusoutrik@gmail.com
Subject: Re: [GSOC Proposal] Complete and extend the remote-object-info command for git cat-file
Date: Tue, 17 Mar 2026 20:43:40 +0530
Message-ID: <20260317151340.85141-1-valusoutrik@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAOLa=ZQhzvgA2bpmUgx2qMTrxFaR5_6GET8e1y+A=m2nboDAiw@mail.gmail.com>
References: <CAOLa=ZQhzvgA2bpmUgx2qMTrxFaR5_6GET8e1y+A=m2nboDAiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi there,

> As far as I can recall, the command allowed users to enter multiple OIDs
> in a single line to reduce the to-fro with the server. But you could
> still fetch single OID info.

Yeah that was what I meant, but from Chistian Couder's feedback, I realized
that cat-file is not a good home for such a subcommand. 

> Nice, have you tried with a more recent 'master'? I assume there are
> merge conflicts?

Yup, I will add these issues in my proposal v2.

> Any idea how much work is left post v11?

From the v11 thread 
- a lot of design decision fix , like comment alignment and blank lines
- the max remote obj info logic is a bit wrong as Junio pointed out [1]
- one test case for max obj limit
- use of size_t for looping
- the placeholder check ie the even with only objectsize the checking of
formatting string is a bit incorrect [2]
- Implementing an allow list for placeholders
- print empty string for unsupported placeholders, ie those not on the
allow list
- remove usage of split_cmdline since neither url nor oid will have spaces
in them, so a strchr would suffice, I think ?

Above is for just for part 1 ie to get eric jus patch accepted

> As per the guidelines, it says
> 
>   Any work done on the Project prior to acceptance of the Project
>   Proposal will not be considered for Evaluations.

I meant like in the May 1-24 duration, which is after the acceptance
of the project ( april 30 ) but before coding officially begins (may 25)

This is the timeline on gsocs page [3]:
> April 30 - 18:00 UTC
>   Accepted GSoC contributor projects announced
> May 1 - 24
>   Community Bonding Period | GSoC contributors get to know mentors, 
>   read documentation, get up to speed to begin working on their projects
> May 25
>   Coding officially begins!

I was planning to also ask design questions in this period.

> How will you manage reviews, considering generally they take a long
> time?

I will adjust the timeline to give more time to rebase previously done work.
I was wondering... I cannot start on part 2 ie adding support for more object
fields without first integrating old work ... so about 50% of time will go to
rebasing and 30% to adding new fields ? and 20% for emergency or any mishap.

> I do agree that something like that would be useful indeed, I'm not sure
> of what that design looks like though.
> I do see benefits of this too. But I do wonder if 'git rev-list' is a
> better command for something like this.

I will clarify questions at the beginning of gsoc duration.


> What I missed from the proposal:
> 1. Where did the work from Eric and Calvin stop at, what review comments
> need to be addressed.
> 2. How do you plan to handle reviews and iterations taking time.

Will update the timeline as well as mention the current outstanding tasks,
as far as I have understood them.

Thank you for your feedback.


[1] : xmqqo6yr3wc4.fsf@gitster.g/
[2] : 20250224234720.GC729825@coredump.intra.peff.net/
[3] : https://developers.google.com/open-source/gsoc/timeline
