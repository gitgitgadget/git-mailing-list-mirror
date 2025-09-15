Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375B821CC71
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950569; cv=none; b=CQjJ89OJf7JAoMRfuEiAzRiSgNWzOTH8gVQV0Hss5+RRtnm7m1ThkQkD+KzXyD8toUDPA8XtoLm+PMbDsGxN59fpQfm6PykyaE1oGEHfryIBUl+DLbW2+TsT2r/7sx92JjEliWrBOHKAQiRXH1d6le2Lsf99hesMCFt3OFQf5k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950569; c=relaxed/simple;
	bh=xQgSMHjMpuoxAbamp1OZoEJKezQMcnXzcgijmZTTIVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIIXtszXd3JN5QF7GZggXlZOlDAYtEuj0lw1Z0oni0EvPgIsEFXmzaqp/YiRwU/hPqb+94G/Nq5FjiHI5XWWbhKpi035VIt/HhCfY2FWy6svN3NeclAZBWW8GOF3TXXBK98pk361FHXx9Fnx4ItcwPpQJb7Wsuae/TZCzgMu6t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O56ypGpy; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O56ypGpy"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62f1987d53aso2256499a12.0
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 08:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757950565; x=1758555365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/pUuAYQDEcOxIyjicCh6nI/hO+ZOoTUjNFY1sLHyRM=;
        b=O56ypGpyEAbNru366RQI/MGmDqQ2rQ38O7J/FRTquLR+gNbGsXYhj5Mz4xT5qorEaT
         sdhIJ1y+tN0P4Jy8OAasDd1TMFMQwTpXnf4eQGs8CdHdSRXkcJvSqs+jPuzjZJSnelrz
         eLfJ6Q9VnVYUlRQKOeM+Ex2rxJlI4awE0AUEAHhfMBP/tdc7p2Gy6Zy8UppbdbFkcEdu
         JCKMIQ89q9aK608KrlHaOouFfBlwToZQT07IY22Kx5m3PDEHzDRthMBJIgeDoA9HHfiG
         xW7nFQwju5DdF02lcxzEAx2U4qdSqYa5iJ8J0kr6RSYbHdvy5jW/N33euUosHLpuoZIp
         1JUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757950565; x=1758555365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/pUuAYQDEcOxIyjicCh6nI/hO+ZOoTUjNFY1sLHyRM=;
        b=qxB9NXVpQ9pQcZz8faRTPT3YN6hM8mJj/ui4g0/U03QqYvmi0FP1RcEN16AhRzbjFM
         EsCAm3kYw3D8tXLkWxWky1o0HeC5TDRFPlidwSIFs3hCqxraA7MVZWp2GKQzSi0Rrnw0
         gQheRkQiSEJcz8fIII9if5Tz9Df2FWmK6yExlIvnFqNj3HFjAt1JpwNDOOiskF+QPX88
         hy50nLjqyi/KbeJv2KKMPnb8jY3A6tll//2M6390MU4AbKipHBofEGMjcYisaDPA0mjm
         xTzeN/mLfgD+7E8YdUqHmpqlK1LfkJRoSRY2debqd2UrjHGNrLZGrbN5nBChCq3wIFwK
         Haaw==
X-Forwarded-Encrypted: i=1; AJvYcCUHJbjw3jeAFec/hXkUB61RbVZ2pPnYzbBrvRFviOKarDxJWqUY08fUeP2s2nPKKwdQ1OY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBZIKQt2P0ONODKJNM/248hF1cfhQYFlkjPbsZEAqYEiFL9PSk
	fr4qdPAAdVj4y+zH/9F7Wq42VLrk85apFiBtVIhmrIBeF2TE/+TzFnsVVru+8Xf8Wt750FoGAQV
	bDOB+p88ba2fM9Iut9nfwWampsKK2DeVf/NAP1JA=
X-Gm-Gg: ASbGncsiQAS+dW5/I8fkgFB0pxjBDlCp1seXo+PJnx+M1pCUWIimKCboXbW1MkDFxUI
	fyMIhHKyEretdZWXCriTry8teZSRVD77YGPrGDEKy9XjR7RJMhMuvg8Y6D1V4/0kecrjQjDfxTZ
	bEeYkRkG1ugPAdM0pJkUzZamH96/ochh/CVo42kbK3dmtdSMN9Vp4RBmGAAJBoG5Z8eQHLKSecl
	VVSUL1ioeCem8Z9hrJnjlQUy7kbLcjQwzhH8CQvcw==
X-Google-Smtp-Source: AGHT+IHw2hIQfexCa4iWgrsAffmKoVgv72PHIEX9aE/eTXafr/okEH2DHdRPn3Wwid2Xi30OdggqPcQYNvEwbttVs3c=
X-Received: by 2002:a05:6402:354b:b0:620:bf3a:f6e8 with SMTP id
 4fb4d7f45d1cf-62ed7eccfc7mr11384622a12.4.1757950565277; Mon, 15 Sep 2025
 08:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <074901dc2422$2039a910$60acfb30$@nexbridge.com>
 <a5e01f0f-1789-427c-83c3-90644fa234c9@kdbg.org> <000201dc24bc$a1b8d9d0$e52a8d70$@nexbridge.com>
 <9a03a436-8240-4566-9383-7afbf740719e@kdbg.org> <004101dc250d$18173950$4845abf0$@nexbridge.com>
 <a57d5857-b096-4d92-993a-3f09d15cdcb9@gmail.com>
In-Reply-To: <a57d5857-b096-4d92-993a-3f09d15cdcb9@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 15 Sep 2025 11:35:53 -0400
X-Gm-Features: AS18NWDA-OfeSA_nfJw2ylHUpCNi9xWU-q2tn6TZRvJ7PnBy6sS5j1QDpU6wUlQ
Message-ID: <CALnO6CDqDWLHfitqxHqOtL5Ej9XMfZUmC9j1dgQG6xiZGHQZMA@mail.gmail.com>
Subject: Re: [QUESTION] mergetool environment variables
To: phillip.wood@dunelm.org.uk
Cc: rsbecker@nexbridge.com, Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The text of this reply sat in my drafts, so my apologies for getting
it out later than I intended. I agree with Phillip's reply below, to
which I've moved the text so it makes sense :)

On Sun, Sep 14, 2025 at 9:51=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Randall
>
> On 14/09/2025 01:18, rsbecker@nexbridge.com wrote:
> > On September 13, 2025 5:04 PM, Johannes Sixt wrote:
> >> To: rsbecker@nexbridge.com
> >> Cc: git@vger.kernel.org
> >> Subject: Re: [QUESTION] mergetool environment variables
> >>
> >> Am 13.09.25 um 16:42 schrieb rsbecker@nexbridge.com:
> >>> Let me try to infer what is happening and please correct me if my
> >>> assumptions are wrong:
> >> I'm sorry to say that I can't help. I tried to disentangle what is goi=
ng on, but this
> >> stuff is far too convoluted to be understood in a few minutes. I canno=
t tell if it is
> >> possible to write a mergetool that is not installed with Git.
> >>
> >> I would just copy one of the existing tool scripts and run `make insta=
ll` from the Git
> >> source directory.
> >
> > Yes, it needs to be in the git install area. Adding export BASE export =
LOCAL, etc.,
> > works to resolve the situation. I wonder whether that should be documen=
ted.
>
> Looking at t7610-mergetool.sh I think you can use mergetool.<tool>.cmd
> to call a user defined merge tool. The value of the config variable is
> eval'd in the shell so if you run
>
>      git config mergetool.my-tool.cmd 'my-tool "$BASE" "$LOCAL" "$REMOTE"=
'
>
> then
>
>      git mergetool --tool=3Dmy-tool
>
> will run
>
>      my-tool <base-file> <local-file> <remote-file>
>
> on each unmerged file
>
> Thanks
>
> Phillip

I run a custom merge tool, and I am fairly certain it has access to
these variables. But I pass them in the config defining the tool to
the =C2=AB main =C2=BB command in the versions where I use them.

See history around
https://github.com/benknoble/Dotfiles/blob/4a4fe9678bdc5b34dc826058fbe85d29=
cc4d7722/links/gitconfig#L130.

Otherwise this would seem an unfortunate interface.

--=20
D. Ben Knoble
