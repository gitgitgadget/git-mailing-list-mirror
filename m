Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BC622067
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 04:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726461335; cv=none; b=Haloi7tC3fwjxap5XXZ3Xy/WgrD4OGzWvlDaM0QXf4+VB7RRAPmgRtP4upGQqi0h3yUS266itBs+pu4CHuevX9X6dMzcZi2EYZGeGSZ1r3i0pIslky0Nv2OMQjG2OBRgqDbzXbKi2+KeQvbi4pSs+z1XQvPDd1HBxK4pyfXDYyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726461335; c=relaxed/simple;
	bh=FgzFHYlPGkAGmYzFkKAHbcDrTn6t283NuVSk3Fjwn7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+gaHQkUP2FR2d7MCI/Ny1zez23HW9D48ubWjtMCiFrYeE5nuoAy7wKtZ7zV4dE9alJaCeSOYZM3Q1avwv7WpxjZVUinETIdxroUqDcyclyATn81fZKDHTklnJepSeJ52IRPCR3Q6aD7T7zFdxKx/RS929dnoBmYBlzo26WY1LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tw5mJORu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tw5mJORu"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20792913262so19175975ad.3
        for <git@vger.kernel.org>; Sun, 15 Sep 2024 21:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726461333; x=1727066133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euthNIF9uGbruHVKcUGekoiB95XM9ppi4Qr//CWo4kI=;
        b=Tw5mJORuwXohsKH9Qvk9+tad3pg1gFg/XgFOEhLabHhmi9AeK6EUvhpsb6bb9BR53r
         M1XbfVZ8jeHhXi0R+7xRNiBlX+QBf7lomBmvnRVNMwy4Ms+MAdCR3hTn+xKs6+saY82h
         YcADacvM3Ljhn3za8QBP0xkhayBAlRN/f9akYHpg3PQH+RPUnjHoiI9P4LQ92PRKjAPB
         FAUECItjqJuk8v7WRxQB0yXXQs6U5CZvmjOj2MK9sf468N1QyuYouS+ZcIjmJbn/shHc
         OYn1qWv++d2HtuFLre4jwgFSLZd7EeX13N2s6ROag53TuSTbbRUeDN42yr/GMq4XDGmC
         Y3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726461333; x=1727066133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euthNIF9uGbruHVKcUGekoiB95XM9ppi4Qr//CWo4kI=;
        b=RET4hM4v+pA144XgPeL1VyOi8oycctvxbCFeGDFKdiMsXi2mnj3vG3ZGXsOudGlEHu
         x98oMzK0IpiQ+67mXoTC0qgurn7TIqh1OdLZGrSHQSjQACLbLO1nfXkBcxhWOFEsS61G
         BH+y8iB2yd2ezxBBQuPfY4JkMH+akO4koPHTxjsfH5KWHupYCwRvqXrkhdEE5XarnNUw
         Kwd6FEhDPNzi+wFgENd6dBChWOr/J+FPfcloUB91062yAqFXVzaylOJW1yvtmzoLrK9u
         fsr/IXNDyeXDGNJhHDdwMyzbM0ky7JusClYykkQ4CxMUCQxcOndAn+5gLimfdVFCd4ZK
         klng==
X-Forwarded-Encrypted: i=1; AJvYcCWY9genpO8uAvV9LIwq2B3V5+B4plJQOdGVQxcSgkA2HB8DjtVvWT0mBzxO4uTreWZhOZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS8u30wj1zqgAyFMUxysLyzzFKNitEEBxLOUXlzkoZ4qRtv4Qq
	K+NOcFu6zfj9RA6ScHzbuwk+j1mdCaBabX0sOqUqEBznxdf4z2u1t/4JEkWmOObvn+oGbOyQ/ft
	xR3xn/179mUtFWthVTytzME1S4Xk=
X-Google-Smtp-Source: AGHT+IG+M2+iiJvbNEygv2YxNPNb8C6kAdUYGvGRehKudvsoInkArxTMWItGmRYzU9+hG35D8VliAFnDU4PyJwHLzJM=
X-Received: by 2002:a17:90b:1292:b0:2d3:bd6f:a31e with SMTP id
 98e67ed59e1d1-2dbb9f3a24cmr14424592a91.28.1726461333105; Sun, 15 Sep 2024
 21:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1782.git.1725875232922.gitgitgadget@gmail.com>
 <xmqqzfogsrqo.fsf@gitster.g> <CAG=Um+0GvFzdAZrCgoS52xh9DF2pntQ+7i+vqYMFQf-MWr3H5A@mail.gmail.com>
 <xmqq5xr4r818.fsf@gitster.g> <CAG=Um+3WSckyZ2P2o2igQr4hbMyMNTDZ_kqjrfdufvL6hUhMjA@mail.gmail.com>
 <xmqqplp7ze0h.fsf@gitster.g> <CAG=Um+2e7kSL8wGFJcJtFAJt8AxyNwpemJNnxDNfsrm1SVVw1Q@mail.gmail.com>
 <xmqqo74qro6f.fsf@gitster.g> <xmqqbk0osxp0.fsf@gitster.g>
In-Reply-To: <xmqqbk0osxp0.fsf@gitster.g>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Mon, 16 Sep 2024 10:04:56 +0530
Message-ID: <CAG=Um+1OQFUuHS0yEV65=D4eW3Ezr8f==WN4umppqS6pFAQRSw@mail.gmail.com>
Subject: Re: [PATCH] remote: introduce config to set prefetch refs
To: Junio C Hamano <gitster@pobox.com>
Cc: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"Patrick Steinhardt [ ]" <ps@pks.im>, "Derrick Stolee [ ]" <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 9:42=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Existing logic filteres them down to what matches configured
> > remote.$name.fetch variable.  filter_prefetch_refspec() may further
> > reduces the result by removing those whose .src side begins with
> > "refs/tags/".
> >
> > Now you only look at what survived the above existing filtering, and
> > further narrow it down by picking only ones that match the prefetch
> > condition.  If the refspec that survived the filtering by the fetch
> > refspec (and existing logic in filter_prefetch_refspec()) does not
> > satisfy the prefetch condition, it won't be prefetched.
>
> Sorry, but I misread the code.
>
> By the time filter_prefetch_refspec() is called by get_ref_map(),
> this caller has "remote_refs" linked list that describes each ref it
> is going to fetch, so conceptually what is left for the prefetch
> logic to do is to selectively discard the elements on this list that
> are not worth asking the remote to send new object data for and use
> the remainder of the list in remote_refs list, and the logic to
> further limit this list with the prefetchref configuration would fit
> well here, but filter_prefetch_refspec() does not work on this list
> at all X-<.  So the prefetchref limitation needs to come outside the
> function.

Sure, can you take a look at the latest diff (shared in the last reply)?
Moved the prefetchref filtering to `get_ref_map` where advertised refs
are available.
