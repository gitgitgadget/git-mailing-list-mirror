Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F0083A14
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 01:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752025969; cv=none; b=cidEfgaDNuarMmIZPX41jIPE5ZSGxKI2F/RY5MF+VqZB4D3hRXqtmCzM07kArE1HwFefgktiJ/R6Dw1Kk+dowKq5lowWQ7zIQlTlLsoV7WXU+Y2T7jGTU6SAsPCXaQYHCdZdPEA/ZfN0hNTCQuYZ97Pab9Dm2KBkZR7oiEL0iaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752025969; c=relaxed/simple;
	bh=uPbsGCmOYQ5OEHlTN4p5z2/uil1dqeASw7cmxrYJfRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LscFRU5+mAWNi1Q0fENgod+AlDYRpuCW6AVFfd/pMYd0vDB+kcgl0xXWzzRg13kJNKd+K+9WUfcE346gW6vlnybziEEYrTzO7+k7aaj5rXrJ0mYoRI3CXtF87Rp4QHiCbDb2D5V+2afpG+7qtM5X6pg+pJ+4XMDL10yNe3wXaao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgdJFdUT; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgdJFdUT"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74af4af04fdso391174b3a.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 18:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752025967; x=1752630767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wA8CodLGOe0DpM5H+WS3Aj20XBL98tv4LMN9+6/gc+4=;
        b=ZgdJFdUTrbLr0g6PHsWRQRa5OPRem9rlod5Ver1iRK2SBrH8fd+e3Y7ZVAxH49/x8G
         xc+2W74L1cqLl8sq4nkMDqP4k8CNPL6iNYwlbFB2onLSijRHGG+DYRKGiQ3H3koJ3qEZ
         CG4OLUztwuu5sTnvUAg6RO5Xn3h1M9MbkhcYJmQI1B5/lrbf8lyDiPxqkMrOCnMHWyWh
         4umixWEo6CxkQz6tbWv3fN5IeqEwhTaE9gIaS1c4xbv/orzAdg5fD4lmRPNvAT4ljeLB
         oiPBi50IBwtitpdJyV0M8ptHqGhckJzGsXovAlOnM4N5RVq9tb9N/D6KIhex7qMkpRVv
         23bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752025967; x=1752630767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wA8CodLGOe0DpM5H+WS3Aj20XBL98tv4LMN9+6/gc+4=;
        b=lE7UJQy7QbctC+rajimXgbpOuAp93uRakGOMlgvNi62MA6nuQRrUtP988VTyOBteyw
         hJch1D0aMh7pdXJvW460PWlsKYjHjCkRwKiAFzSJVKKCFMWZiRJfx2UflxrYhU8abq2X
         3T+/etsL+JgmVp7zfsvTn/dx3Hdv7QRa/O7CCm1iA803c3njtNVMpnFbyLO1JG81PLuv
         EYGg1iXpSe7doWp/yXLlQhCqzB1rzY+xWGVxv0sIXRA8886WgAFVd7sWUHaSkWiKhNoV
         xKic6dDoo5VWx1yuMWndTOBl7wwbtYpRGmYy52PiPAaFXkLz1iLt/JMBNEC4O+n/BL/n
         e+yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXho4KGBXLv2bwdq628/4/N+pFDuxYGsMyXMVzGZvrhFvVIcUP8QEdZCjUoimKlnRS0Lo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJDdjTBaKG0iw3Z0QNwI9vAzhkRk6IagTjsrIbDvBk3Ss5uw14
	7LLxs6al0qpPIH7U02pYMAzltx2SAIB/XN+oTyeQ7wF1GIaZv+XqM6m4kJC8CA7sNRRI2HlvF2M
	pAjXvwPwNoMB3bdG6bbUTvd28mkGoJlc=
X-Gm-Gg: ASbGncv/G/6VJlOVHVNwRwjLpDveGCvgoD1qVcwFFx852n7WPIqb9rogmyRTGxtOe3P
	j1XEiZM5KAOl9Cdfd7rFTq1edYEnHHZIgz2xyEMDDQJ1tihnHojCtbVI+P7C+oLgAeeFVWvKpG/
	qP2r4PxKdy4QEM0xC+vV8lpxzY6fq+5tp7NMxLygv3VTC/SU14aDnvlJdgiAEyvFKatXZnD68W7
	3zqYQ==
X-Google-Smtp-Source: AGHT+IFri8JnuoeSTH7JxLiQQ8w6gmjHRHpzTj2QJC8ktaO8+9J13WT1ErSoDaQEai9Qds+L4dgq3xkumMuZ5wBTzAQ=
X-Received: by 2002:a17:90b:5291:b0:30e:3737:7c87 with SMTP id
 98e67ed59e1d1-31c30662b9bmr860799a91.5.1752025966907; Tue, 08 Jul 2025
 18:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk> <xmqqy0syp30y.fsf@gitster.g>
In-Reply-To: <xmqqy0syp30y.fsf@gitster.g>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Wed, 9 Jul 2025 07:22:35 +0530
X-Gm-Features: Ac12FXyPJ_1jhbdTa7LNaPAz1XMXvRdbUPXTUdk0TmxWycgySJTRERaPqFzdr38
Message-ID: <CAE7as+bN53MrA5_kF7pXD2V7dT8vNgJK0dn9r1Hq5vus7JaFtQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] breaking-changes: deprecate support for core.commentChar=auto
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, 
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, Taylor Blau <me@ttaylorr.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 6:57=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > This series implements the plan to deprecate and remove support for
> > core.commentChar=3Dauto outlined in [1]. This feature has been the
> > source of a couple of bug reports recently [2,3] and as explained in
> > the first patch the design is tricky to fix.
>
> FWIW, this fails some tests that expect "# commented lines" by
> treating "auto" too literally.
>
> https://github.com/git/git/actions/runs/16157263228/job/45602188411#step:=
10:2970
>

The failing test is a test which I added in the bug-fix patch: [1]
I don't understand what you meant by "treating auto too literally".

> I wonder if our braincycles are better spent to actually perform the
> "tricky"[*] fix than deprecating the feature and then perfecting the
> deprecation process (which does not seem to be without cost either).
>
>  - We can and should keep the "auto" magic and use '#' when it gets
>    specified, if we really wanted to do this deprecation.  I am not
>    a huge fan of it, though.
>
>  - Or leave it as a known-broken feature in certain corner cases,
>    which may motivate some future developers to tackle these
>    "tricky" code paths.  If we were to go this route, the first step
>    would be to document what works and what does not as "known
>    limitations".  I am slightly more in favor of this than "we punt,
>    because we cannot fix it", but not by a large margin.
>
> So, I dunno.
>
> Thanks.
>
> [Footnote]
>
>  * Essentially we would need to collect all information (like hook
>    output and template files) before we produce our own message to
>    be commented out because we need to know what symbol is
>    available.  Such a change may mean a major reshuffling of some
>    code paths (or worse, some code paths may have to be made to fail
>    and retry).  As long as the damage is limited to the case where
>    "auto" setting is used, such a "solution" is acceptable.

[1]: https://lore.kernel.org/git/20250630182527.69167-1-ayu.chandekar@gmail=
.com
