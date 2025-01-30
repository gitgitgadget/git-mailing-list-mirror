Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD56F51C5A
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738226284; cv=none; b=tZDqlGgtlYaynaduhxc3a0cM6lyVlCUQ5ZBGibXljBqsCHNx0Fe1eUaSP/vJrvSbA844CRm81Fn5y1iryi0oOsDZaHfGDahj2Hqt5HEJ7abbOmM726AOa3CD8ZolcGUQENzCaVmFoAeVlFndfV2M70U/hNAB+8tXh/X75itTbZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738226284; c=relaxed/simple;
	bh=t1GvorwWDc3eixJlzPQv9lniCJB01KYd2DT+sRgvT+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJOgBGZXNv58HOvpjfa2Bp1I5gJSglXpJ4zP/9dL9HQf5gtFZiWj56sqmFbM8PhCxLDUT/L//Yr9172FBHykG3lTShkgF1HbbAAmzr2sYG0/crlUP7+sJ65NafFrxl7n/c7v2st8iHesjrdN5hw53bfF7BZmmEmv163bP5sOQ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItF59dqU; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItF59dqU"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dc10fe4e62so914780a12.1
        for <git@vger.kernel.org>; Thu, 30 Jan 2025 00:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738226281; x=1738831081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHWR5joUz4eUnrKDKSYm6gv240sACaUAlflIRMQZ4+w=;
        b=ItF59dqUAY/zkOE7AHVfA1EGawqzYLJ/BP2f+YxcK0/MeAAyYd9g/cU2GGZFvw6Kfv
         aQUg+FLtT5p+FnlYgzLn98Bo5sJ3+7mpsqo4fEOD6GofB/1cjWyd5qveazWiuQnrIQZU
         NVNyJ51QlgVYpQd6Y8NQYAQXDe2v+VkyNEGs4AO1ybG37e2ICwK5icGnrKzOQBvfkFhm
         JfaNuWZgUrpAKLo0nhxhhyW72X4X9Qsu6/JhVliQ64FCFn2OnqRr3ajsSvT9J97gEKxv
         B6HEV9lBW+quqzvy8YuupvvqUsq2wX9WC/67eqkC3ooADBL2gsjF2ESjkur9JMCl/zxc
         /IqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738226281; x=1738831081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHWR5joUz4eUnrKDKSYm6gv240sACaUAlflIRMQZ4+w=;
        b=Fazj/B9c4eJVs6mMHP4w6CEaXQTWMH+ta0VT+p1OeCNaj6Pb/9u1z/TJExscjQtfuY
         rcNixlD8UmiRrUZ5J1Ue74VqCuJHvI7L9WAK8//8Iksj4f80hi3Iq3QxpvdP9VmoZTns
         ky2oavw+iEaiE7T73TRIiopzvv4LfBWJGsz8VGkAb+Hyza11lpJkcc7p1mr6t7+1pGQu
         KdEzmyaVItngJRvdMVw578Ez3XUsOTlqKPcVEwvdMLzXhUs/gPAGIYy1R8AasqCTITsO
         Bgb9oc21r6WQ7EibyDs/FSa8YJAAm2GX8MuYcRQIGcVSigIPxXwSIBDef+4wAg6hQsfq
         g8qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOdfdwLjF7lb2M7m+rnhAtA1mV147BekKFhP0SZMGCpGzg1KcpxdeoIlpZp1bKNad0fPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy15EWdEllaWj3UJyJG9cHu+UnD8Du4CFUgE08wu5YqA9NyLb5j
	IYyEZr0Pc6I9tLR2q9kZpGTIP84EjcNEhjbDN1w95Pf3RVwUn+T1YbUdl55SyT9KfGtoi9O0GCT
	/Pt45+bTzZEdSZXJonEGy8vI8zy8=
X-Gm-Gg: ASbGnctjcd4Ef6evJtaxNSGkfgco3rPEJ+gKH79zC/VE72h+zRVL17TgdjwROZW5lhG
	bwogJK1Hokr/Uum4TaY9zxWi8k8cp5ru7yhEqSxLVcM7GN6wSMLjMPwQCWdUvKpBz1NI3cVFTth
	0=
X-Google-Smtp-Source: AGHT+IFfl+X9HFyxQhlCaakKCguJPsKAle9YmX9CnJlKDWjvtyO64iuXJP+Nlk5a//qvm3khBS+yiNrJfazsDRY8jA8=
X-Received: by 2002:a05:6402:520e:b0:5d0:aa2d:6eee with SMTP id
 4fb4d7f45d1cf-5dc5efe6376mr5794258a12.26.1738226280815; Thu, 30 Jan 2025
 00:38:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <CAP8UFD3PkyaQBLYPryePk=e54VtsQwjbyvvTsKEBFJnns_jZyg@mail.gmail.com>
 <Z44u7od-mDiKcKVZ@pks.im> <xmqqr04vzyz9.fsf@gitster.g> <b784f612-4b6b-414a-9742-86611c50c55f@gmail.com>
 <Z5srHBSPKQlsuH53@pks.im>
In-Reply-To: <Z5srHBSPKQlsuH53@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 30 Jan 2025 09:37:47 +0100
X-Gm-Features: AWEUYZl-ExS_veY6K-i8huNuuzSkaooI3V2MpqmEhU-eQHFN972JSpKmHEvaOXo
Message-ID: <CAP8UFD0s1nOr5EDx0MW=u7grpmywRTpGzx0v_d4PSjmgJ0ZBbQ@mail.gmail.com>
Subject: Re: Git in GSoC 2025
To: Patrick Steinhardt <ps@pks.im>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 8:32=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Thu, Jan 30, 2025 at 11:14:06AM +0530, Kaartic Sivaraam wrote:

> > We could certainly curate it from time to time. I wonder how
> > we could set the timeline for a microproject idea, though. Would it mak=
e
> > sense to fix a rough timeline such as 1 year or so and remove any idea
> > whose age is more than the same?
>
> That'd be fine with me. Ideas don't necessarily have to get removed
> immediately, but may get "refreshed" in case they are still accurate.
> So personally I'd frame it less like an expiration date and more like
> the following:
>
>     Every topic added to the list will need to be checked regularly for
>     whether it is still accurate so that we can avoid an ever-growing
>     list of stale topics. As such, every topic needs to be accompanied
>     by a "best-before" date that indicates when the next check for this
>     topic is due.
>
>     It is the responsibility of the owner of the topic to determine
>     whether it is still accurate. This check should happen close to the
>     noted best-before date and come in the form of a patch that either
>     bumps the date in case it _is_ accurate, or alternatively removes
>     the topic from the list in case it is _not_ accurate anymore.
>
>     In case the topic owner does not send such a patch, contributors
>     other than the owner are encouraged to send a patch that removes the
>     topic, putting the owner into Cc.

Thanks for this. I will use something similar.

> Well... maybe it _is_ an expiration date. I dunno, I don't mind which
> exact term we use for it.

I don't mind much either.

> In any case, my proposal would be to add this paragraph or a variant
> thereof to a preamble explaining the purpose of the document as well as
> how to use it. This is somewhat similar to how our "BreakingChanges.txt"
> lays out expectations, which I think should be an inspiration for the
> new document, as well.

Sure.

> > Also, the current list of ideas could roughly be seen here:
> >
> >
> > https://github.com/git/git.github.io/blob/2025-microprojects/SoC-2025-M=
icroprojects.md#ideas-for-microprojects
> >
> > The topics are:
> >
> >   - Fix Sign Comparison Warnings in Git's Codebase
> >
> >   - Modernize Test Path Checking in Git's Test Suite
> >
> >   - Add more builtin patterns for userdiff
>
> This one doesn't feel like a sensible addition to me as it is
> open-ended.
>
> >   - Replace a run_command*() call by direct calls to C functions
>
> This one, too.

We could put those two in a section for projects that are a bit larger
than microprojects though. It might help those who have already worked
on a microproject and want to do something a bit more involved.

It happens more and more often that people who want to apply to the
GSoC or Outreachy start getting involved early, which is nice. They
often have time, after their microproject and before working on their
application, to work on something a bit more involved. So it would be
nice if they could easily find something else to work on like those
two ideas and others similar to them.

> >   - Avoid suppressing git's exit code in test scripts
> >
> >   - Use unsigned integral type for collection of bits.
> >
> >   - Modernize a test script
> >
> > Do share your thoughts on which of these you find being relevant
> > currently. That would help in preparing the first version of the in-tre=
e
> > project ideas list.
>
> All the other topics are ongoing topics indeed and would be a good fit
> from my perspective.

I agree.

> Note that Chris is also preparing such a doc right now, so you might
> want to coordinate with him.

Yeah, I need to prepare a draft for the next Git Rev News edition
first, but I will work on this really soon after.

Thanks.
