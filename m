Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213E025D8EF
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 22:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740609080; cv=none; b=Ip6avlzg0lEuRAayva+00RcOI+lbN3WyMPWsWFTJw9I1MXxIJg3nrG79YE2kmwdVrUH0tGb/JSsCAkKGoc7XFlFgN+SFO5izqVBFdByegpUj1jJvEp6XNBZwc5yq5RSMDAncSnP0GTRLWLs5yv0D8CWtdyMrVTE16PL83VIz/QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740609080; c=relaxed/simple;
	bh=G6j7oezvSscfDjH5Tq5ELmyv6O/ekdENp3KK5h1YcOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FU1ODA4NF/VFgtezOXDuwG+86653wYIp0VFA0yZbMnlBlKpUCcuFpqFHspYRLrp7B/jcMxPc6jtszg6kJYLF5hZsUAzIipLDuZ17CuQ0C9kU/fAH6VLakYtiVsfgCuhElxJ2O88asTuWFGaisR3InqnvwMkdXKphOQ2gZfL5hZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFOOZ/Kx; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFOOZ/Kx"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e549be93d5eso305525276.1
        for <git@vger.kernel.org>; Wed, 26 Feb 2025 14:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740609078; x=1741213878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6j7oezvSscfDjH5Tq5ELmyv6O/ekdENp3KK5h1YcOM=;
        b=fFOOZ/KxUtXLPLrXfxIbxIneH+SAZPY4b8SCmFuE16OZi27l0LvRGx+62CN5W1SAhd
         InmUQZyhe+B6GSTy7uuGV1omrZauIQ19FVJBmPEkxoeXwm6bvWaHbkPIu+stv+W5KXc1
         wN6lSWNobL8E4daT1zpAGyfMKc5xWFHYjCj8CUwIaPAq1P+R3UolSZGsQeLiHloYaZDr
         yxog46ldqDRSl8vPueJZMEf4zl4o5hze722NLAtHQge18e/SNi8nIkQtUcKAmTvZjZ7/
         MEybvI/A/hp8KcrerXYvMtU9OBNqQZGuarESJecxKBqnKVM0rJKJXM2IbccGnSREJMaR
         EtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740609078; x=1741213878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6j7oezvSscfDjH5Tq5ELmyv6O/ekdENp3KK5h1YcOM=;
        b=xTCIm0ai7SFUV5X6QS4A8Q9NvZajjxt5ptAkcSOd72lB1hhu5HOINyjtRBZF3KDj9E
         l7NmHkHDAkcw67fXyu/c0MGuv1EQeRkyz+2ApWjrojG7d7AfgbEf7nl2d4XJANeK0lvb
         U9vr0p8lEhfZbavCx2Zew4nMpGe1gV0DsZNObtHW0xx/7FaJsEi/1H5kXtwKMOyABqU0
         rH26z7uNa7B5J2t0fBTyE9goQN7fhFtUuKJf18emJ/0jKWjyHSlN5X5wy6EKJ8m+tPuO
         I4kz4TOq+bXKXX9A2NfAQgUe2RLLlDaQtefpa7lWfdMOTRVF6GEcgd8E1yatAkGDwoKP
         +cuA==
X-Gm-Message-State: AOJu0YxjaH+KqOcBtxEdaiCbDOCNLYNcGxIZNu9+6w/1APUzZkrJQDr5
	EcR0iW73Ijt+BJ017A3PAKbSx3Ry+9BWgbwZkK35L5E/8UjwjfOK1P6dLXjQ77l29eWTiIfHyqh
	8BsCMEmYpi3Y63QAF9RMUyygSASg=
X-Gm-Gg: ASbGnctZIslYb6sPHBnrC4XhdDLvbV2S26COaQGN8WNUm0PgukFoIvnCqd8ZzWfsGGB
	xd1C1XHplrf57fYtS3lAzodk+sH1DnDyYCBZjpkMDAqg+QUe93Ta+u4XuyrD7wxtIQ0J5lJSvVQ
	2cLprjpw==
X-Google-Smtp-Source: AGHT+IH9vbMMVtmm47BoJbccJaLHPPaooMwaVYCYfLQzYycvxcM/lBr/SlHJcHbB+5zdgDQII4Rwe1ZTvU+lu4UvcnE=
X-Received: by 2002:a05:6902:200f:b0:e5d:cc41:75d with SMTP id
 3f1490d57ef6-e607a4fde0emr8236746276.26.1740609077962; Wed, 26 Feb 2025
 14:31:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXAcUxHp3LnyqR=NM0coh6wG-1uy4GB3FdeZEg8mPHu-vt0bQ@mail.gmail.com>
 <CALnO6CA2j60gpPhUjxOY6_q5WdU7MHoL1GLDN_AVwWVNx_JddQ@mail.gmail.com>
In-Reply-To: <CALnO6CA2j60gpPhUjxOY6_q5WdU7MHoL1GLDN_AVwWVNx_JddQ@mail.gmail.com>
From: Clement Moyroud <clement.moyroud@gmail.com>
Date: Wed, 26 Feb 2025 14:30:41 -0800
X-Gm-Features: AQ5f1JqjtxgmDJz9JZXEaWrg-XHbLFhtDLdWrKOZtXFiSCguMvliEckJW7JzJ7U
Message-ID: <CABXAcUwHd2Rr8iOZ7F2k5DGiBNH87pwG3oyRWLrP40=MgD91-w@mail.gmail.com>
Subject: Re: 'git rev-list' commit ordering issue
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 10:58=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.co=
m> wrote:
>
> On Tue, Feb 25, 2025 at 8:44=E2=80=AFPM Clement Moyroud
> <clement.moyroud@gmail.com> wrote:
> >
> > Hello,
> >
> > I've come across an issue with `git rev-list --no-walk=3Dsorted` commit
> > ordering when
> > two commits have the exact same commit date. In that case, `git rev-lis=
t` will
> > leave the two commits in the original order, preventing automated
> > cherry-picking.
> >
> > To reproduce starting from the attached repo archive created with `git
> > bugreport`:
> > git rev-list --reverse HEAD | git rev-list --no-walk=3Dsorted --stdin
> >
> > You'll see that the order of the two middle commits is incorrect and
> > does not match
> > the order returned by `git rev-list HEAD`
> >
> > Since both commits have the same commit date, `git rev-list` should use=
 another
> > criterion to do the sorting - namely, use the parent/child topology.
> >
> > If there are better ways to sort such a list, let me know. This is a mu=
ch
> > simplified test case. In our real-world application, we start from a su=
bset
> > of commits that we want to cherry-pick from a branch, for the purpose
> > of creating
> > a customer-specific patch build. For the automated cherry-pick to work,=
 we need
> > to have these commits sorted in topological order. I do not see an opti=
on to
> > `git rev-list` that only sorts the commits in stdin topologically - the
> > `--no-walk` option only does date-based sorting.
>
> Is `--topo-order` of no help here?

Unfortunately no, because it'll look at the ancestors. I get more
commits (400k+ extra
commits in my real world case) than I have on stdin:
$ git log -1 --pretty=3D%H 2025.2 | git rev-list --stdin --topo-order --cou=
nt
417776

--
Clement

>
> >
> > Below is the system info gathered by `git bugreport`.
> >
> > Take care,
> >
> > Clement
> >
> >
> > [System Info]
> > git version:
> > git version 2.48.1
> > cpu: x86_64
> > no commit associated with this build
> > sizeof-long: 8
> > sizeof-size_t: 8
> > shell-path: /bin/sh
> > libcurl: 7.87.0
> > OpenSSL: OpenSSL 1.0.1e-fips 11 Feb 2013
> > zlib: 1.2.3
> > uname: Linux 4.18.0-553.33.1.el8_10.x86_64 #1 SMP Thu Dec 19 14:28:01
> > UTC 2024 x86_64
> > compiler info: gnuc: 6.2
> > libc info: glibc: 2.28
> > $SHELL (typically, interactive shell): /bin/zsh
> >
> >
> > [Enabled Hooks]
>
>
>
> --
> D. Ben Knoble
