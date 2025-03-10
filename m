Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3517722154C
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627284; cv=none; b=QgOIPAm7IShrWmkQ0zG1FYzb2EY8+IJ3VFPeDiTj6X6OvUUyvvGeK9XWD4q8PIKPhCaDDGQ4YytJ2Ghtt7rgLs8RBtFhge19dRg5IJI+RvKRnb1Yf3a6mD13pOlLjUkOp5SP9I+kb25Cm9LrnWB2Cx6Wapnw/DhGzsrlekxvlpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627284; c=relaxed/simple;
	bh=mjSPhtKIXh6iH9gH+wXeSMZoIjhEWSTAm6e4m5dDp2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uD27WFDBJVikSPY/NdRZabEzj4LnxdsZHL2l+xj/whXE6yf1a6bE0xBQGvq3R+pCeBxtFwzT/w2q5BnBYt9Iiy7/MIGUPuEstxBUGGPO7YCxlneFy86zuEBKVcui9H8eMfCLBv0AsG9PF4mNOmoUzfNR7r+oOsUPGadoKAijSW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOAbYrbh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOAbYrbh"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22403cbb47fso86149235ad.0
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 10:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741627282; x=1742232082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKe4TDNHmLaDCrugA27is402iupih8vVFXhQMjJmccM=;
        b=jOAbYrbhbJJYBCkojOO5Xy52DwL9D4vW6i0Zb3P5c2D9c79MJOpDg1ZmfIP820nOhB
         rvdf0ACgYNVl5sFEzhc/J7b7qqFd0Ge9e2M3MZThQoHiiARxiWfrquBvFezMC4VAz/d0
         De1jN74rmRt7snv4ISvmsQ856zIkfaGZr4TuAfm2TAPMB62vFh1KrFgA90Ms83aaIbRO
         0BuXfQARRgI2h2p4gbLDgq3G36mchMvB7ZlsFvYTjaO/NDVvuUR5f7BoLHa4kaBsQ2oF
         togzYDOeSuOgpSj1xYAZg6F2hnPhdfQ8K4+Q77OS3O+CNJeZOn9CbkVyIX8oO4an5kso
         7ICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741627282; x=1742232082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKe4TDNHmLaDCrugA27is402iupih8vVFXhQMjJmccM=;
        b=ip1+FNJIJuVcvtyqyssdllCGHlkV4WCIhJ16yio6sKnplzM1xoh5mnXQdwXzAj/8KQ
         zsbZLR4W772XZOXYtx3LIfJpUxM8OzNjvjGTI6tXKQQrYGaOYjQzOkqU83kWFXZK6cZD
         PV9lDjA4NBKI1hJXVM6eeoZS4npfrLlCcqbXvsZsSdes2/5PZnaa86AulDr95qW/5f/+
         YMQw1Y5bnizEezxy/dL3eliTUvXXHXsmDi9mX38XRpvVuAsiTKCg/lKJpuD8OBiDSVT5
         kAIaxUf49H+EKHV5jYdWmIYXNHY65Mi08XtYHE6kEznz5oTfewGXGa/Eil01w4v0k3O9
         7qxw==
X-Forwarded-Encrypted: i=1; AJvYcCXBkm114KH93enKalYefxnrv+MGEVwg3U0TIl7GUrm2hph+/TlWmQkui2xBytRrbApN35w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYnoPJ8u88fsMy6q/ZMRb7b0un3tdz4g51bF5sp8z5Qgbx01sX
	lc+oXwOStK9v6wldLNp9i4jVqqIRmOgjId69FpGRn85kMTVhXAwCFzPMK7cFH5raeZc5q8QDpHg
	mukV51paGOprPkQ39DRGcaeqMw1tUsnaiBdZjPQ==
X-Gm-Gg: ASbGncs4X5WkG9MH5smX93a07c4kDfIqA7KL2Eg7VlCvLtEIVdfq+yYSe0RDkBcgA1x
	YsE5hRrMtSXpoFbm0/MEYFVHNhcaF7EHzs1Yo5dLuRFQPz0SzvULr/p4Ze4tW1ZC+3XWncUttnc
	dU3a4n06vSeFBT2AUTEO9hNVbpXcc=
X-Google-Smtp-Source: AGHT+IFRxZk9qPs0gLCE4Q7kNi0dw8Benf6KUnjleNPb9ZdtStC/mIe8PtvDaGKaiV5c59BLVKN3fevNr4z5D+LMxWE=
X-Received: by 2002:a17:903:32c6:b0:224:826:279e with SMTP id
 d9443c01a7336-22428bf1937mr201248775ad.50.1741627282211; Mon, 10 Mar 2025
 10:21:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309153321.254844-1-ayu.chandekar@gmail.com>
 <Z86PUkJ1sbSH2VTU@pks.im> <xmqqwmcw97z2.fsf@gitster.g>
In-Reply-To: <xmqqwmcw97z2.fsf@gitster.g>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Mon, 10 Mar 2025 22:51:11 +0530
X-Gm-Features: AQ5f1JrqkMD6DTVULiSBKQ9tvkXxuXCuX1S1GEjkU5xqHhXWuTyDtn0l0g5K5RA
Message-ID: <CAE7as+aSRuo9sFxSX8M66HB3EOH+_OwugAnAJfN800_6GiDqBQ@mail.gmail.com>
Subject: Re: [PATCH] environment: move access to "core.attributesfile" into
 repo settings
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, shejialuo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Another thing that felt awkward about this change is actually
> larger.  The current attributes globals are built around the notion
> that the functions involved work on a single set of attributes at a
> time.  Even in a single repository, when you are checking new contents
> into the object database and when you are checking objects out of
> the object database, you'd need to switch the direction manually,
> which means you always have two sets of attributes active that you
> can switch between (one is from the working tree and the other one
> is from the index, if I am recalling correctly).
>
> But step back and think.  What does it mean to make them belong to a
> repository instance?  Whose index and working tree does the attribute
> set that belongs to a repository that is not the_repository come from?

I'm trying my best to wrap my head around this. I definitely don't fully
understand your review yet since I'm still quite new to the codebase.
I get what you mean when you said which repo does it belong to.
But in the long term, isn=E2=80=99t our goal to get rid of the_repository a=
nyway?
So at some point, wouldn't we need to either attach attributes to a
repository or have the attribute set know about its repository?

Thanks,
Ayush:)
