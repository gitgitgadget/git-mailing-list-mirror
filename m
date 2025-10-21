Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5A4F9EC
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 21:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761082605; cv=none; b=h/0Ux9Ier4DQxK83o1OkQ87WFTaE2B3OMPwJ1BOb40S3f7ug60qGoZweNOZLYl8aQ6fPTYO9BJE91ST2/S7yDCgnCshO1+HBuZjw7w+1ADtKknFF+41lZ4/uOMbuCCQMhHn0WstT00gcewg8IT4UHJmWkkeKpWVLa0M0ICFlgIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761082605; c=relaxed/simple;
	bh=XvbYWxueqmKo3Dfxe7Uuey4SD3ZvneBI5jucGnhO9o4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=do9+Nrh0zeFSiEmZIaeAP4cT4K7JwiM2YJumkT0JNydNyygXolkdL4m5dvjYqlT1XNeIyGaUx/DCYSVyZAWhdwO136f2Q8HpNewKz9oTmFeGATecXVMVBTEXabGqeChhK+N96mw0P5Z12NG1FnTmZveMqX9P7fu857n+TZuRtmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8zpS27q; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8zpS27q"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63c523864caso8497520a12.1
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761082602; x=1761687402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdpznjcHaSJOJhYaRwXqkc/DR5ShkzeFTQQM+kvATS0=;
        b=L8zpS27qwYEZCPJcczD0ehQ6TlSRzuhZCclvqiFYgWR2inHclEQUgkqQWEfdqAA5Ld
         jep+tN2Zc13PNF+QXdwpn0Hp+QZwqp7b3tlC6jW9o7tWOtQ4YBH5xVNn+rRpM5FVSWXR
         XxhsMHljcRaaPzzLxUS6o9EU8qtmiLK6SZbIyt4pTT7Ln1S1RJc2+TbruAxsQq6EdJX6
         0Sss0sPKueD65Vq1DpJuyEr/2fA0JCjAM360VumGZecXny2F1r3OituDlG0RYpromN+E
         74uOon7S8U23DvAd5gWKYqBNsfbf5ThadF/i6CDimvqTrQrnyla4HWX21DfspY0acg/+
         s5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761082602; x=1761687402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdpznjcHaSJOJhYaRwXqkc/DR5ShkzeFTQQM+kvATS0=;
        b=oyY4NgDTWMBeq0UMhBAnXaX0X+Bgoku9/qNGfKbStIOCCt/nP3rBByADFkz8ncoFSW
         7LpV2kEXkw9N9Vb9x3n/laBtGOOvOrtGUcGHuIGifVi0aVHRB9P9P6vUCc8QGGvD+yYF
         tG7px8aO5j2BYNTxghRX8p4ygeBCEPQg//P4ZGmp3Fb2lQUsNkFmHHlGZ+qBdyBc2ffJ
         Oe54wokqSovhDF3xNqN3tvde0+T9bISd32+KA/4BXBx87EcIME7bf9cpyq8hQVNA6RQJ
         5Sz55ir1MKyMTcenEmTq9azhPRfPCVFyJ4gDNiCSsgrAkytWUf5GHHBXtdEHrJuswZLw
         M7yA==
X-Forwarded-Encrypted: i=1; AJvYcCVXsAW5Agj7KPYE/GRVBzXs5WGY6MMluNLqVXUwB3vA3xzxIcad8EUwGUB4fRDXUmgBudA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaA7CNUNFbL2fbA1LBXcDMX+3K+Z/sxp0qloov88DbxQkX63DP
	IzPR6MslUhtfsOHRSVC3NZqDrUKStMDyIR8rJgRUCPMMD6BUqCoUQFKpFwGkvrvbtSAWtxjxxtT
	elB0B27hAybw48y1bPpJXxUuC14CQGxA=
X-Gm-Gg: ASbGncvWH3vGGJ309GC/3sRPt4etpIdLL8vca+yx3U9A6wCVMIBhzdDKhfFFv3lTVJs
	K643kXTOctQrmMvZdDOzmy17ura1Px/AdcoPEViXx3a6sEW5GXF5ZW381VEeLAUGonnmsllcn4i
	blKHTxiaLJqKWjyc1NBn+OR6zrcCvIDRTD1Ib9wW6OXIbRYdVVeIKDuIcToQLhhp6kjzZTYrYX3
	p2XkZx8537wuTxbnguvJVR5fSyKUv367Z81itPQRguV5KGedWD6m+Pa0tADhtm8eFH8qh+6CTUg
	ucBkXXsbUarMQ+PiqcU=
X-Google-Smtp-Source: AGHT+IF2e8AdlikomdineLarxIWFp9bUseyDy5aU7hB/yr51e1ywiafwN1VoiVF+lAf1TDUJX4GK67VYArpTmiRmo7g=
X-Received: by 2002:a05:6402:5186:b0:634:5db4:8fab with SMTP id
 4fb4d7f45d1cf-63c1f628d92mr18005349a12.6.1761082602004; Tue, 21 Oct 2025
 14:36:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqldl4und1.fsf@gitster.g> <ecf21e8d-acff-47fb-b972-59cd7b8f3146@app.fastmail.com>
In-Reply-To: <ecf21e8d-acff-47fb-b972-59cd7b8f3146@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 21 Oct 2025 17:36:31 -0400
X-Gm-Features: AS18NWB_NDs_c1WmR-xElZIb7II2mkxU23A3qcHBWEr-DNRchLm0UhYwBuFIk6k
Message-ID: <CALnO6CAjhgsGS-zoL_EQO0CXyg1gVH70TSqnbThNmJYarU71EQ@mail.gmail.com>
Subject: Re: [rfc] flip rerere.enabled default to be "on" at Git 3.0 boundary?
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 2:56=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Tue, Oct 21, 2025, at 20:21, Junio C Hamano wrote:
> > A good default matters, and people who find out how useful a rerere
> > database is would say "gee, that sounds great but why they do not
> > enable it by default?  It is too buggy and they wanted to reduce the
> > number of support requests?"  Yes, the reason it is not enabled by
> > default initially was exactly that, i.e. those opt into the feature
> > was used as guinea pigs to polish the feature.  But we forgot to set
> > the graduation criteria and never said "ok it is mature enough, so
> > let's turn it on for everybody".
> >
> > Perhaps Git 3.0 boundary is a good occasion to do so?
>
> This sounds nice.
>
> Sometimes I make bad resolutions and my cache gets in the way.  But I
> know it=E2=80=99s a directory or file somewhere that I can delete manuall=
y.  So
> that=E2=80=99s nice.  And if I didn=E2=80=99t know I think I could have f=
ound it on
> StackOverflow.
>
> I don=E2=80=99t think the =E2=80=9Creused resolution=E2=80=9D is super cl=
ear for things like
> rebase and merge.  I will get output like
>
>       CONFLICT
>       CONFLICT
>       CONFLICT
>       Reused recorded resolution for ...
>       Reused recorded resolution for ...
>       Reused recorded resolution for ...
>       YOUR STUFF IS CONFLICTED
>       DO THIS AND THAT
>
>       this is from memory :p
>
> And the =E2=80=9Creused=E2=80=9D messages are kind of =E2=80=9Crandomly=
=E2=80=9D placed in the stderr
> stream of consciousness.  Could they be colored maybe?

Seconding this: it's too easy to miss the rerere messages, which can
make other moments more confusing. (IIRC, git-status still says we
need to "approve" the resolution, but for folks not used to rerere it
might be obvious how to check the resolution? Idk, can't recall
offhand.)
