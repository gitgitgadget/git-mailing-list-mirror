Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F5C4409
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 20:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760646791; cv=none; b=lpEzK13To4st//JEzI87rTOWh/bxQCor10gNHdsY5mmtk3WgSfrZLOFfOzZgD7lqfdiN5ZOyA9MlPL/DOwKeG+jeLTT6ZBpQ+d5Ttmt/5r41nZsBGpBe2ZwJUJ/2KwJuUHRMcLv5GWz695QH00/tVPBWWcgwAYVU4Kxpc3eliVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760646791; c=relaxed/simple;
	bh=JzIGAKR1fwLMurf2DDCsvzaCN+230lfxtxlIxhafu88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myhKQQFoOs9/N5NAjl6dWjZ2zzzooKFOdid3qhr8FJ07T/kohIFUDbesIS6W5D9HWHe2Hl0QY7K/9Y+c/cRQDrSQ2nD/hIKS2hFt8AUC74XKJ+7vRKir2ARcqt19XAUaLrxsOfg5BzCLnYVEYGZgS4Mvs7ADUkTvXeQNZMIpZh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+TDVZXN; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+TDVZXN"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6394938e0ecso2059861a12.1
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 13:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760646788; x=1761251588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4sqYxTmeGz+znzPSI8MkVBduQ0nGNdtL035sB3pfM4=;
        b=E+TDVZXNP2Gd5FK/3qPO6y+XtUigbvJFvq8iAfe4ic48opAUyaAaL3eBNchlsQcaxe
         rgxgAaLAup/YTRiWF2udtqde2GOCzI8SnG4p+UQBOkgGpP5/2XmrQ70c5VtysueuMj/e
         HddMWYOl2Ll1hukWGBt+vP9w1wvc9YXwOzpWsZQ53476puWLj6wpyjknszybhsr7Ju+y
         GFB/9Ptbl45I4ywvLpmlNXE64MaDZurp9WbISISe0kc9c8pQNzdDaAD88jVC0eRu/N8j
         U1cyvNnY6wdQu3XfiQguSDjz6ZY9VKLDzP7vbWLh4vOKxGd1NnHnjh20vZ5bhaJTWm0n
         /0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760646788; x=1761251588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4sqYxTmeGz+znzPSI8MkVBduQ0nGNdtL035sB3pfM4=;
        b=nQ3xw21TbJp4z91Falz3ywN+SABfeaRMG7VnNVExOU9CRuBVSD5wGhYJfzDf/CjWFY
         oGb1Tf+b+HXa/zzzY1gn8wZ8RJVNWkJi+FtYevFRpwTQ3COPsRK8IIqYoIVifW9i19qB
         fYwpPI8D9rc/scr1aKSqyDqrAXZXzaqQZzOmpUZJ2edlVqkJUT6o1POGJT1hwRJrPicH
         L9cRi1PO2Y/wPtyuqAUqu0ypBWwdT3ztiL3RH4alOTRSX7Hv1BgB/egr8ML+d3QV7EwR
         PYYE3LgVhqO8MZG4G1boAff+/btnm7wo07hSeLqEQEAGSyE7f99AcWupO9Ups6oCwe0A
         OHPA==
X-Forwarded-Encrypted: i=1; AJvYcCV6qY2Jshtsgh+D0M6uZXCpvHzXnWRX2aoJ++vDHLu6tWo7Kt0sxJuIRzwF6GGCNAaMpyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAaclv+IVP6RMLfN16/evqpDXEiaevG2JQMhT6jVpziTwvWaTe
	xyVs3LWar/uMCwtpIrI+Bhr2P5GRmod9XbIKiAKdB1i3kcsYJGkEYDUCRKZH5G4tDkBj8ZanSd5
	VuuEaawfajbvlUSWyDqJ9Q+dQ3v8NIK0pxQ==
X-Gm-Gg: ASbGncv8XaKuhoniPIeAkdT261VKANgmXzqzpQksg+hD/Fy4ROI73pVXJYgpxSFuD5u
	pW+Nx/NIAvtqEwH5HJtUy19lqxPNJASGIK8xueNyu9U+8b68rHMXMazQOuttmwB8ufDUJFHIoJU
	GZOhswXTWITp/YuRgOYRtgG/8t3KLDHVLdxDF4/QfJlDoWgpDNNuyvw3rhr7hO0dLWo9iMcG4On
	HQJmGOfHmDnkynMgxhvEI4jHALelEwOD5h2RnfrZ/07qZL5+Z5x00y3G+DUFSDphlQ4dHencSZC
	v3kWi1nivDynL4uJt0LLMdJGBaGs
X-Google-Smtp-Source: AGHT+IEFYbd/omVouwAOOabXUe6ycz8JOUdCYk3a2/ZMIUcL8YNkm5tm8f1SShqwVp6YeIo46BcGLW5INsx4u+iVgss=
X-Received: by 2002:a05:6402:1445:b0:63c:2750:ef4c with SMTP id
 4fb4d7f45d1cf-63c2750f073mr116436a12.19.1760646787814; Thu, 16 Oct 2025
 13:33:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1989.git.1760566054455.gitgitgadget@gmail.com>
 <xmqq4irzu7st.fsf@gitster.g> <CAESOdVAHt8nUQRE64RXwS4FiO1=Qy8EPamDwaPqUrHvx7bKCEQ@mail.gmail.com>
In-Reply-To: <CAESOdVAHt8nUQRE64RXwS4FiO1=Qy8EPamDwaPqUrHvx7bKCEQ@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 16 Oct 2025 16:32:56 -0400
X-Gm-Features: AS18NWDKSjh6UTguHmqCMo6KViI-CRlJvfD0AVa4iRGl7wUtSOmVhl5r7qWP3jY
Message-ID: <CALnO6CBaTUzFFB+h5aXN2GuNwm2oyk5ZNEy8u9=80zwQjdfsOQ@mail.gmail.com>
Subject: Re: [PATCH] BreakingChanges: say that `git diff X..Y` syntax will be
 removed in 3.0
To: Martin von Zweigbergk <martinvonz@google.com>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Martin von Zweigbergk via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Martin von Zweigbergk <martinvonz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 7:07=E2=80=AFPM Martin von Zweigbergk
<martinvonz@google.com> wrote:
>
> On Wed, 15 Oct 2025 at 15:19, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > "Martin von Zweigbergk via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> >
> > > From: Martin von Zweigbergk <martinvonz@google.com>
> > >
> > > The `git diff X..Y` syntax is quite misleading because it looks like
> > > it shows the diff of the commits in the X..Y range but it actually
> > > shows the diff from X to Y. IMO, if that syntax is supported, it
> > > should show a diff from the merge base of X and Y to Y. I hope Git 3.=
0
> > > is a good time to remove support for the current syntax and
> > > semantics. Then we can perhaps add the syntax back later with less
> > > surprising semantics.
> > >
> > > Signed-off-by: Martin von Zweigbergk <martinvonz@google.com>
> > > ---
> > >     BreakingChanges: say that git diff X..Y syntax will be removed in=
 3.0
> >
> > I like it in prinicple and I do wish that we didn't do the lazy
> > thing when we did the command line parser for "git diff" (we had
> > revision range parser, so we just reused it instead of doing our own
> > for "git diff").  But real life may bite us back.
>
> Ah, so that's where it came from. Thanks for explaining. Speaking of
> revision range parsers, teaching Git something like Mercurial's or
> jj's "revsets" languages is one reason I would like to get rid of the
> `git diff X..Y` syntax here. I haven't done a comprehensive analysis
> but this is the only place I've noticed where we would need a breaking
> change if we ever wanted to teach Git revsets. (I'm not volunteering
> my time to work on such a project. I just think it would be nice if
> someone did :) )

Buried in my todo list is a goal to teach Git about JJ's "::" syntax
:) Fortunately, I don't think that requires this particular change
(which I'm otherwise in favor of).


--=20
D. Ben Knoble
