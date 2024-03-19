Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6736850A67
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710832888; cv=none; b=bmras0CGfeQaTVkgnMPUbIQ3WAyY733jumlvVKiI0CwUpNOeokGklKcjHdJ5IDOtl31CHwk30PGXy/YaE1NL755wSp/TV2aS6lmUt3G5HBkYlFU5l4Bi+ZfQH+B0dlj+IRHB4qcIRCTgI75ni5PA7gdrzuti5rCyjXD64gpHrJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710832888; c=relaxed/simple;
	bh=em18NISPIUG02tbbCOXHYz+K4CWoVTiWYkClJPTpgeo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mDD0DfQgJ90OZNAzu/xaHZKwvP4pLpHYuK1poVny9ZO+ulShUAMykS/tphlDvxQlWqSxLOdUHkZMWUNURm7Y+s8JuReUM50PxsO93ls365iFlgWFQVIXZa6I3YF62/e95D1QZCQsTJ2wciSnNdSqFhOBn+7ae36iX2H/wZjPZNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ngkAAwp; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ngkAAwp"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-29dfc072e95so2722167a91.3
        for <git@vger.kernel.org>; Tue, 19 Mar 2024 00:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710832886; x=1711437686; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EfP2CdBzf76s/JhPJbu1cHnW2jrGIOAqADLqu3m5h2w=;
        b=3ngkAAwpuRwKOZFQy2sAmWG8x3BywCUK0ndBAKSi2eo9OMY5OpSwpzzfNWH4SmutRr
         3+m4pjylJeeKyr30elmBuVGhXtOuWgeqamX15mz1nKKNSINilSN25ubBTnOjKH0bOy1Z
         5I243Xudd5yaFSWI7DQNkpQIduWL1DM9FCTNFKqC3CtBz4Lzz+6jCD2N2EIKJtula9ZA
         Nx6Cq4sJ90hNlSwzOZ63qfmi/snS7O3Qu8RCUZVxtxzC8IorslngZfQlzOUzQ6iSOsJK
         xSbYmf7IoWd50is1jJd7PF/boANPGfqW6svrZ7K4X8KTP0KF5OEkKrBaPXFRhE99tzQV
         dH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710832886; x=1711437686;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EfP2CdBzf76s/JhPJbu1cHnW2jrGIOAqADLqu3m5h2w=;
        b=UfIkzzWCFMz5lIEC14PWcx6AnvDQ5Qmunh4ufL3rQxJL2I2IZFdiGK0pKR7nzzSM1L
         hDH834EVbOVrDzIrZ3+07F9NvYsHM/JykrQOH6wW4c0sgLt1huDQzmj3dJbNho8Ycbzx
         86AJjsr58IL1zNORO9uqrONj5LY5JOevvcfNVFEpZv11HNQzBiaLLkeoCuxzxvVwxzUd
         OxZ8iC+XfzAFBGEVB08+LIJXteyPxjRVk4py4OU/Dy0hKMAr8FrRhrWBdhvm5yTPFyO3
         iMtiapI5iTO+7DXT4Y1Efax7vxH1nl3+QIEgtvi79v1+6asyi0pDVgchGmT0a/WzjT3l
         hg8w==
X-Forwarded-Encrypted: i=1; AJvYcCXaMMD3gI1LSJmnA+3EQBqVAck7XuAMcUNAqWT8uYNjJcy91QLC0KBQEwT+p60VFkmERbCBq7Qjy6olXBH6pmS6u+G7
X-Gm-Message-State: AOJu0Yy/bDjtdVhyTtP8w/WETYaDOT3wKDC/JsK9hVj1q5QbqbTTndu0
	IZG3lY6EUFze27bqEqXRNiykn7tfaXAYRGUoLTlpqvDZOiBjcL83+6B16YLssMcP57vYlg9sUVr
	Qkw==
X-Google-Smtp-Source: AGHT+IEJhZCc2/S0SHMS5aALmVyS4R1VuURCm7JfO5k+Rrshl5kwPt8cL8kQIQ849OjEDgJztDJvu/SKgyw=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:90a:8047:b0:29b:6d9:7a2d with SMTP id
 e7-20020a17090a804700b0029b06d97a2dmr4254pjw.2.1710832886444; Tue, 19 Mar
 2024 00:21:26 -0700 (PDT)
Date: Tue, 19 Mar 2024 00:21:25 -0700
In-Reply-To: <xmqqh6h3jzp1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <17bdc28ea2b88503.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
 <owlyv85k2gts.fsf@fine.c.googlers.com> <xmqqh6h3jzp1.fsf@gitster.g>
Message-ID: <owlyle6e3cwa.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] docs: correct trailer `key_value_separator` description
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Brian Lyles <brianmlyles@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Linus Arver <linusa@google.com> writes:
>
>> WRT line lengths, probably 80-ish columns is the (unwritten?) rule. The
>
> Your patches will be reviewed on the mailing list.  If you keep your
> line length to somewhere around ~70, the line will still fit within
> the 80-ish terminal width after a few rounds of review exchanges,
> with ">> " prefixed.  That reasoning is mostly about the proposed
> commit log messages, but the same would apply to things like
> AsciiDoc sources.

Agreed.

> It is true that we do not write it down.  Perhaps something like
> this is in order?
>
> diff --git i/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
> index e734a3f0f1..68e9ad71a1 100644
> --- i/Documentation/SubmittingPatches
> +++ w/Documentation/SubmittingPatches
> @@ -280,6 +280,14 @@ or, on an older version of Git without support for --pretty=reference:
>  	git show -s --date=short --pretty='format:%h (%s, %ad)' <commit>
>  ....
>
> +[[line-wrap]]
> +
> +Just like we limit the patch subject to 50 chars or so, the lines in
> +the proposed log message should be around 70 chars to make sure that
> +it still can be shown on 80-column terminal without line wrapping
> +after a handful of review exchanges add "> " prefix to them.
> +

I would tweak it slightly like this:

    [[line-lengths]]

    Just like we limit the patch subject to 50 chars or so, the lines in
    the proposed log message should be around 70 chars. This helps avoid
    line wrapping on 80-column terminal displays, even after after a
    handful of review exchanges add "> " prefixes to them.

>  [[sign-off]]
>  === Certify your work by adding your `Signed-off-by` trailer
>
>
>> text files aren't really meant for end-user consumption (that's what the
>> manpage and HTML formats are for), so I think it's OK if the line
>> lengths are roughly in the same ballpark (no need to worry too much
>> about exact lengths).
>
> Yes, too.  And it is one way to reduce patch noise and nicer to
> reviewers, when used moderately (i.e. removing a word and making a
> line to occupy only 50 columns when ajacent ones are 70 columns may
> still be better than reflowing.  Leaving only a single word on such
> a line may not be reasonable and tucking the word after or before
> one of these ajacent 70-column lines would work better in such a
> case).

Agreed. Thank you for kindly putting into concrete examples what I was
too lazy to write out in my earlier response to Brian. :)

Speaking of reducing patch noise, perhaps it deserves a callout in
SubmittingPatches, something like this (first bullet point)?

    [[optimize-for-reviewers]]

    To help speed up the review process (and to incentivize would-be
    reviewers), avoid introducing unnecessary noise in your patch
    series. The following are some things to avoid:

    . Avoid _reflowing_ (i.e., adjusting where lines start and end in a
      paragraph) around chunks of prose such as in documentation or
      comments, for relatively minor changes. For example, given a
      paragraph with lines about 70 characters long and where your patch
      wants to change the content of one line, consider changing only
      that one line (and leaving the surrounding lines as is) --- even
      if doing so would make that one line go under or over 70
      characters. This makes the patch (now just a one-line diff) easier
      to read, versus a reflowed version where N lines are modified.

    . Avoid _extraneous changes_ (however small) in your patch that are
      not called out in the commit log message. Reviewers read your log
      message first, then read the diffs; if there are things in the
      diff that do not line up with your log message, it will surprise
      reviewers.

    . Avoid _breaking tests_ in your series, even if you fix them up
      later. Consider flipping the broken tests to expect to fail
      temporarily, and then changing them back to their original state.
      Making sure that all tests pass (at every patch in your series)
      helps to keep the history clean, which can potentially help things
      like git-bisect later on.

    . Avoid having _too many patches_ in one series. Aim for a maximum
      of 5-10 patches in your series. If your series requires additional
      patches, consider breaking it up into multiple series (where each
      series achieves one major objective). Wait for reviews of the
      first series to be accepted before sending up the next series.

I took the liberty of documenting some additional "what not to do"
lessons I learned from reviewers from my time on the list so far. I
assume the "reflowing" thing happens more frequently than the other
bullet points, so I put it first.
