Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7441ADFEB
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728923191; cv=none; b=hP9stp/qiIJgmfBFjBnOJhdkGRdb98B7KxFXbL+DkQ3TkjKcSqNBFVU/nYwd8swv95w9MeklqS2FdIC+akEvf++LsCXiHjuRczabQhFxUC23H3WBpCrsPcFVrMEcJ7Xv6M6d/p5A4Ve/O2snF0uwkrD60UYlO3etEXEcVmRoTR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728923191; c=relaxed/simple;
	bh=oSxmpOvFKqV4i49MhDfQ2jMSDEmjUOg7LMNviNOOWXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IP9z9XpbUc0S7IkwaaPiYrDZ+CrdBBZpDZqPIzTrFM4lRc+yWcCR0M7V8KA2uULub19k6LNvHQ6KbB3ShD31xvGEofHKYRfnc3VzThKvHVvyttKfQbnb2/vcOZ5avmSlqHJwfxJXfHCtTAl0PL7aWfP5wf2f0QiaukmyQAsGCtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eH0G0r4M; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eH0G0r4M"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4a46fc2d520so740164137.3
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 09:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728923188; x=1729527988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMxUptVU4DGEFrqaaEOrd8FCFBKL7Uep8+HmYswgiXM=;
        b=eH0G0r4MhfVXeaIfTUPjQjgNB27O4rEaWZqWRyZlW1V8k2VlOwrHBpCoCxvbdNkHVy
         tphAA3nnk5GJuGQIqxkSbbNmhYqC2wBKubJ0IFNLs+7K1rcb6TWGaFPFOaYHZ2YP+UyH
         IslauhRkMu+pNdUBLd6Du5Ecr/Wzp5aH1aY+tKSxVmneDpulpbrHjQC7hR8y46DX8vlV
         0UHGkofZ9scXixo9olXPR9AuQKOq+Dy6Z44HiqLKbsHABIqnHu7BYD6QypC2iIHouPmp
         8+rmffnA9UsSL5dTRdkFOk42H5CgvE3zcV4ZRtT9Ra1MGq4cRVABY2J5Qb7dhZhqM0nc
         xKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728923188; x=1729527988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMxUptVU4DGEFrqaaEOrd8FCFBKL7Uep8+HmYswgiXM=;
        b=DilXTqBabI/pajQAEoE6jP8GfTlgJWx9w4PfU34zchbXWjPbhYtOu7SxR/q0p2nNt9
         in+JfNKbtWXfQLX36pUCduCb/jRKRRLe5G18oJZa88I4l3pAOt0rzo4VLyLq6yYRYYwa
         2pHiNg8ObdQecEWHl6izejiVLlHeuswuzcDrd8wMzyItXw6I7DwhSTfjK6YqMwYGvfDj
         kp5yrqiWCYeLxIfeH2jFnFDQPh6h9b+KtauAzYuUFfkaYopkvpIQmBocgIib/zZecHgG
         wRcaFdDMfHvTv/uVQ2Zh29MMtU+/kqI8mDCKlg7+bLr1UvOUUSqTpQp/c2Cskq9KU7Uj
         URmA==
X-Forwarded-Encrypted: i=1; AJvYcCXZSVM06F+h2jQ6X+pD3njt4ggkcw6Oxodk9iBFhBE6yqKNlpbGHH/xIAxkbthKM/yUmvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMvUC2CemK1uhBya5YU8zXW9/xp914Hf+mraMP5LAN4MiE0ssZ
	g8gFb4GOgQ09Z/UG3wnUIoDICgvC6WcT7Sy8wH11LHt9hZLr7YKs6qx79JSwkaevS78eNWDyxMY
	nQvkGuKEtQmBbyoYk9Oe4u0o225M=
X-Google-Smtp-Source: AGHT+IEEVo1DpC2P0VmL9TTOdAZ8hfj/qUFb5+BLNvrRIwQDKgr0Tj29kgOyP0VDRp8z1Gp2gvJaS7YeSOaJI2n8x8E=
X-Received: by 2002:a05:6102:2ac6:b0:4a4:8fc3:9b7 with SMTP id
 ada2fe7eead31-4a48fc318eamr1963575137.14.1728923188075; Mon, 14 Oct 2024
 09:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
 <CAPSxiM-V1qOB9QXUY3aDh+_nGdDHBWXJZ54U9p_XxKfHoODu7A@mail.gmail.com>
 <Zwz4B4osJnYJw6pd@pks.im> <2a937b6f-a3fb-4f2a-997b-5508f0e20e65@gmail.com>
 <Zw0kGLZ-mcYjb6Je@pks.im> <2160f8ea-5f00-49d9-8e02-d71d4d827d39@gmail.com> <CAPSxiM9ncwaZ3HF72wsRwmen7joWk3mjipsu78WxKEzLX607sw@mail.gmail.com>
In-Reply-To: <CAPSxiM9ncwaZ3HF72wsRwmen7joWk3mjipsu78WxKEzLX607sw@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 14 Oct 2024 16:26:17 +0000
Message-ID: <CAPSxiM-aptyjesMX1H-P5QJjA-6CUonA01Bo84cq2_t==TqFgw@mail.gmail.com>
Subject: Re: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and strtol_i()
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 4:13=E2=80=AFPM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> On Mon, Oct 14, 2024 at 2:55=E2=80=AFPM Phillip Wood <phillip.wood123@gma=
il.com> wrote:
> >
> > On 14/10/2024 15:00, Patrick Steinhardt wrote:
> > > On Mon, Oct 14, 2024 at 02:57:13PM +0100, Phillip Wood wrote:
> > >> On 14/10/2024 11:53, Patrick Steinhardt wrote:
> > >>> On Sun, Oct 13, 2024 at 09:42:41AM +0000, Usman Akinyemi wrote:
> > >>>> On Sat, Oct 12, 2024 at 11:09=E2=80=AFPM Usman Akinyemi via GitGit=
Gadget
> > >>>> <gitgitgadget@gmail.com> wrote:
> > >>>>>
> > >>>>> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > >>>>>
> > >>>>> Replace unsafe uses of atoi() with strtoul_ui() for unsigned inte=
gers
> > >>>>> and strtol_i() for signed integers across multiple files. This ch=
ange
> > >>>>> improves error handling and prevents potential integer overflow i=
ssues.
> > >>>>>
> > >>>>> The following files were updated:
> > >>>>> - daemon.c: Update parsing of --timeout, --init-timeout, and
> > >>>>>     --max-connections
> > >>>>> - imap-send.c: Improve parsing of UIDVALIDITY, UIDNEXT, APPENDUID=
, and
> > >>>>>     tags
> > >>>>> - merge-ll.c: Enhance parsing of marker size in ll_merge and
> > >>>>>     ll_merge_marker_size
> > >>>
> > >>> To me it's always an indicator that something should be split up ac=
ross
> > >>> multiple commits once you have a bulleted list of changes in your c=
ommit
> > >>> message.
> > >>
> > >> Agreed, but I think in this case there is a common theme (converting=
 atoi()
> > >> to a safer alternative) and the problem is with the commit message l=
isting
> > >> which files have changed rather than unrelated code changes being gr=
ouped
> > >> together. This patch could be split up and if there were many more a=
toi()
> > >> conversions it would need to be split to prevent it being too long b=
ut I
> > >> don't think its essential to do so.
> > >
> > > In theory I agree. In practice I think we should have better
> > > explanations why the respective conversions are fine and whether this=
 is
> > > fixing a bug or not. And if it is fixing bugs I'd also like to see te=
sts
> > > added to the tree.
> >
> > I'm not sure if I would describe any of the changes as fixing bugs. The
> > option and config parsing code becomes stricter so I guess you could sa=
y
> > it was a bug to accept any old rubbish and treat it as zero before. The
> > imap code that's changed all rejected zero anyway apart from the tag
> > parsing so maybe accepting the changes to the tag parsing are fixing a =
bug.
> >
> > > And by the time we got there it makes sense to split up commits.
> >
> > Yes if we start adding tests then it is worth splitting them up, I'm no=
t
> > sure we have anyway of testing the imap changes but it would be worth
> > testing the other changes though.
> >
> > Phillip
> >
> > > Patrick
> > >
> >
> I got this from a leftoverbit which the main issue was reported as
> bug. https://public-inbox.org/git/CAC4O8c-nuOTS=3Da0sVp1603KaM2bZjs+yNZzd=
Aaa5CGTNGFE7hQ@mail.gmail.com/
>
> For the test, I should have the test as another patch right ?
> Thanks.
Also, do I need to add the reference which mentions the leftoverbit in
the commit message?
