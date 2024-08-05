Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14865165EE5
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722882941; cv=none; b=gXIdklzxJ2eGo6u+oDl8R9lhNiI0zQ0TsUkeWS/MMm7gGYzhTHOZeTwPbqmTuiFIcrj0cf5R4XrWhHjuMAEgzgaj6gGsbKYDsETeBsG6ps2jeGzzdLqxmsgW61vjORR2JHEBFXYFagE5/snvbWsA794iUbcJFCKc883UqjTbhwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722882941; c=relaxed/simple;
	bh=jTBf/JuA11oqOs7dVcT7nFPjEGhR/OW5y2oVKA8O6zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRZdExYrLlj1FXSzodbNaiRQ/ECNTI8OhpB2VfdQzNOfpNYWPX2u9qS+/ex+fTvV73eH3g/OqBaFtb+wOFd3DFKb1hzLAJ3aRqV/OZvaqElaCxNuUjKIaZRbsG35WzWDHoONSXOrLYRiCxNRvtYbux1upoGTEJoz/NAVD6Lt4Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIxsSKmU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIxsSKmU"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fd66cddd07so78963675ad.2
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 11:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722882939; x=1723487739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K3tbuFw+LNgbKuiDkk+uu9bT16wOSEDJITOuNuUR/xQ=;
        b=EIxsSKmUifLq/Ad2VBAAovAmfEwb6Jr8HScTYeh3CiCfrrl8E1CeM5BbQqLHfH6tqj
         ctTimR4PB3fVT0uZA01yH/v99uQgQeZWlsM61wXrhOcSHyjTCF9bhbLQiCcEViaXNwvu
         clFzjYJ6nYWbwR4v/nbIJMKGvknLBfKjPBPMhbI6Si8GNPDGI+Y3WmYw9bFMLQvxDjkh
         Qv0NB4aIk/pSgQUWhjb5cVYsjPsBye5IsqOV+aabFOASddVS0o6+fceAGN19IILoVNx0
         xZcxMydtpo6v6S1+HhR6GUidqomeNcc0esuOgwIj5ASK3V1SpLoReJBHE+dgUZ0FHn1N
         92Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722882939; x=1723487739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3tbuFw+LNgbKuiDkk+uu9bT16wOSEDJITOuNuUR/xQ=;
        b=a+4u7bQYOiSP9L4uytMIVdNY5vJmbZcXvhcNxOszn4Ju7ESdZl3S+IIEBXb+w+61Nj
         lJtBNsmzu8WZge4R+M70EGQOZfNxadGUF8ARiaZbyQHYB43EPN0XtiUSGySUO+hbtjeC
         4kI/Sc5qw9FMxQgymNWp+BZXeqhKQaOtkP/U2eYYoSxjqIaSIG1boAuXIvNS5St4Y3HV
         9TfPH/PFIuzY3+rlPcGcW7ehdtmXTxlyzUWLPmE3Dwdp2IrnTwRUD33gMAd/p8lC4BQV
         6uf0gz/Q0fGAYYl9qSCKSSqTFBOUDmG0U9S/57UKUqF0Zc+7QBFu5UOZO561WNML/TU+
         fygg==
X-Forwarded-Encrypted: i=1; AJvYcCVkEpQ0ZmIZABnlqZmIRA0pVcpe+dWI1PjJmO396jLX4EywjFbUOxQICnbGWvpGAAhAgvfJqnNzGFeFtCy5U9s1vIqn
X-Gm-Message-State: AOJu0YxRFQJ2nrJed6H2jTPeiT+UhzrbSsW8trVMhGKhpFIDyjnt2j0l
	iF9nN6CPcy9tTP0lV6KDI0PhzCXNBb3/Phtn3nMexL1XejkTM+Jn
X-Google-Smtp-Source: AGHT+IGTD9ybHfkCw61KqdyeNN9IkvCAms5sNRvTX/Lq/3NIhJzzQBN850P6r53yc7AYnV+nwfDjuA==
X-Received: by 2002:a17:902:d2ce:b0:1fa:fbe1:284e with SMTP id d9443c01a7336-1ff570ed054mr150687575ad.0.1722882939228;
        Mon, 05 Aug 2024 11:35:39 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f556c8sm72193935ad.94.2024.08.05.11.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 11:35:38 -0700 (PDT)
Date: Tue, 6 Aug 2024 02:36:06 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v14 09/11] builtin/fsck: add `git-refs verify`
 child process
Message-ID: <ZrEbllB6WjLfWqNZ@ArchLinux>
References: <ZqulmWVBaeyP4blf@ArchLinux>
 <ZqumdJz3-0mqh6Rc@ArchLinux>
 <ZrDMdEJR6DV5HyLD@tanuki>
 <ZrDtVJYoJJZDesB4@ArchLinux>
 <xmqq4j7y3kmt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4j7y3kmt.fsf@gitster.g>

> 
> Hmph, I am fine with the approach to take it slower.
> 
> BUT.
> 
> Here is what the diffstat for the whole thing in the updated round
> v15 looked like.  Do most of these changes outside refs/ still
> needed if we do not give any way to even optionally enable it via
> "fsck" for those who feel adventurous?  Should we still be touching
> fsck.[ch] and other fsck related infrastructure in the series?
> 

From my current standing, regardless of whether we run the "git refs
verify" subprocess inside "git-fsck(1)", we must change the fsck
infrastructure illustrated by the following:

From the development of this series, we can know the main problem is
that fsck error message is highly coupled with the object checks. Even
if we don't perform "git refs verify" in "git-fsck(1)", we still need to
follow the fsck msg framework when executing "git refs verify". We
cannot avoid this.

The content we change for "fsck.[ch]" is mainly the fsck msg part. We do
not change anything about the objects.

I agree with you that it would be strange if we do not expose any
interfaces for user who are adventurous. Actually we may simply add an
option "--refs-experimental" or simply "--refs" to allow the users check
ref consistency by using "git-fsck(1)".

I guess the concern that Patrick cares about is that we ONLY make refs
optional here, but do not provide options for other checks. It will be
strange from this perspective.

>  Documentation/fsck-msgids.txt |   6 ++
>  Documentation/git-refs.txt    |  13 +++++
>  builtin/fsck.c                |  17 +++---
>  builtin/mktag.c               |   3 +-
>  builtin/refs.c                |  34 +++++++++++
>  fsck.c                        | 127 +++++++++++++++++++++++++++++++++---------
>  fsck.h                        |  76 +++++++++++++++++++------
>  object-file.c                 |   9 ++-
>  refs.c                        |   5 ++
>  refs.h                        |   8 +++
>  refs/debug.c                  |  11 ++++
>  refs/files-backend.c          | 116 +++++++++++++++++++++++++++++++++++++-
>  refs/packed-backend.c         |   8 +++
>  refs/refs-internal.h          |   6 ++
>  refs/reftable-backend.c       |   8 +++
>  t/t0602-reffiles-fsck.sh      |  92 ++++++++++++++++++++++++++++++
>  16 files changed, 480 insertions(+), 59 deletions(-)
