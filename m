Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B1219B3EC
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753539773; cv=none; b=q6MZxhwzBWHQyP8rA7kRw/ntX+FNiTWgj4XAKeXNAFUEnegdq2IzWtncSZrq+uVoVhpaYh9NAoJgCvYGc0yEoXoS7AADE9JZH6wbgleEZE7RX5JX68KcRaoa9deBpaGlvv95knjN3Z+p047AnQkUrlfVmb1XNk+Z0RYZ0keCG80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753539773; c=relaxed/simple;
	bh=6kOP46wjNj+oTwKEnTKs1WY3AzXQXtso0EKNO7IpC2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P5g4Z3i/5vsAF8eSmzxq1bBZ2ippbGxjVZrGUyjjGHdQe131nXq65kxSknGRJGLwAjb7TwqCS+hBsPLfcfvzkIWmtK1uGVYfuYt6kkojk3yCcUHzmpudmc2HyNN/1NRvAvWnIp3MXQG1rGqYB5src8oJfNDs5OdXNQDjbdPmsbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5h2Y0oQ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5h2Y0oQ"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-612a338aed8so4825434a12.1
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 07:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753539770; x=1754144570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlE2zgD95Aun2hldfDd2G/IJtxOMO+5oVK6luPo+gpM=;
        b=a5h2Y0oQrjF06WZ22I8wUVG+V1L8+rV0TYqaVI0I82qAjhEmRVzfJVb3f7kPkbVh5m
         4/MxB1GVYk2cNpFXtsR4txyRO00a2QI2vt1S5/IWYXJGsP1Ql0jTtbhnYDG6o15AXfI8
         /YYzOQIlSQZN+CDMtBJxiD+erlR0uMp84g+U+GfcrdtA0yIudxXpv3YNoFUJ20e/TRi9
         n7G2YoBi9fquzdMCZrbcab++1Pdsp5ynKavd3JKGeUWLqGpI1wZ7XU5hFIiFR8VmXKe7
         uhO23iXW4yOLtVXBeM+lXHbyN9d+M0CboRaTLV3tF8LypWR5E/ze6aadauXjy5zhqUXx
         TEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753539770; x=1754144570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlE2zgD95Aun2hldfDd2G/IJtxOMO+5oVK6luPo+gpM=;
        b=NVpHTcfNenDb5uYFIFpEa80+PjIdt3Jb/BTI74siuDmU07+A6MpsBNlBXH9HzGI5LZ
         TWzJdRisrYz4Oc5pR0OKaQGe5kXEe4enPnTp28iCU+ej8O75eie2hQhEPBg+GT43xcvw
         880laCtLnXlLeAfrurnhmv+9YaExI6vSf+mq/HQ4iZxR5Apo+mBUP8NBnuw5s1Whflgk
         eTnrRGjZWsdvNEIlF82TNWnCEZTvYl3i724RTnU//NFOIFcQ6PGer8/Ze1FjFtCk9/YO
         a4JYJ1okmVkam+UdPTK/BpSZd+Xsz6fYJzarqw2f87tIsyjYvb2pziNF2Na/R7qwn6YC
         5HFw==
X-Forwarded-Encrypted: i=1; AJvYcCVpb7C4js/v22X3xkrIrGPV0DXTgl74917ojeZWAf9yFg5BjqVWQybYFSIzNsvoHlbmSA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQEsWv2X1ZJ2Nj6MRxNBLBHJTcXgN4iD3DG7MQe2thww8DSk/S
	rb9V8z/xo6617X9ti3caHw2XPCChtLAPbu76xD3W5D2/omVAUIWNVlFyVfHN0P3aJjqhj0EzK6M
	12ASr3932eYTH4xg2RUqZg7krLpwoxgw4WlzA
X-Gm-Gg: ASbGncvW2YjuQVQ1S/bnhKlFZqpXHcxz/czZDsF08pivDWP6XvJxW44JT2Ug8yLmg1l
	+JwtYhzn3Yj4DLVadsTTRnrHvQBxq91eQ7ohj/VB3MUC+DD7mKDTEoRbxAA9qsQvVEVm6HvP3oY
	8HegWhiwaSHXR2FTPS3GmAZfm8PczZJBcgS+D4dbx1fMwCaFvOqm4CsRXgtTllYMlLXxRVi/qyF
	fuAQvzkVX5QlVwGy1j6vai+fFFkDoz203LkqeA2+w==
X-Google-Smtp-Source: AGHT+IFFPAIXvZ0gMsGAqW5YLWcCw6E6elEHtaZvJdg836prT33Acz9qreKFrTshiysUAoWD4P5FeklGhNMTSvdex2E=
X-Received: by 2002:a17:907:7e9d:b0:ae6:b006:1be with SMTP id
 a640c23a62f3a-af61740d575mr642359866b.5.1753539769985; Sat, 26 Jul 2025
 07:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1c3a0463-36ee-4a2d-92e0-fac9c0bf77da@arm.com> <a35dc2bf-015c-472d-9528-6763f7aac180@web.de>
 <xmqqqzy33k1j.fsf@gitster.g> <20250726081254.GA3042329@coredump.intra.peff.net>
 <CALnO6CA2qSYePJzqXjdW6c2zC4KQJSKzsCFCzc9si0OJ8E_ohw@mail.gmail.com>
In-Reply-To: <CALnO6CA2qSYePJzqXjdW6c2zC4KQJSKzsCFCzc9si0OJ8E_ohw@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 26 Jul 2025 10:22:38 -0400
X-Gm-Features: Ac12FXzbLT3lwWefzwEb5_QQ1zAuyMWHHs7l-CBGL-b14cLKcOdJqI8Bv1jwsdo
Message-ID: <CALnO6CCcYfzHUif=qQHxODnj_kGvGrYYV==4gJKWwxcKS+2JBA@mail.gmail.com>
Subject: Re: [PATCH] git: show alias info only with lone -h
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, git@vger.kernel.org, 
	Rasmus Villemoes <ravi@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 9:12=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>
> I have a few (unsent) patches I've been working on that touch the help
> mechanism, so I have some thoughts below.
>
> On Sat, Jul 26, 2025 at 4:13=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> >
> > On Fri, Jul 25, 2025 at 04:52:40PM -0700, Junio C Hamano wrote:
> >
> > > When it redirects to our commands, it is less risky as we aim to
> > > make all our commands honor a single "-h" via t0450.
> > >
> > >    $ git -c alias.c=3Dcheckout c -h
> > >    'c' is aliased to 'checkout'
> > >    usage: git checkout [<options>] <branch>
> > >       or: git checkout [<options>] [<branch>] -- <file>...
> > >
> > >        -b <branch>           create and checkout a new branch
> > >        -B <branch>           create/reset and checkout a branch
> > >    ...
> > >        --pathspec-from-file <file>
> > >                              read pathspec from file
> > >        --pathspec-file-nul   with --pathspec-from-file, pathspec elem=
ents are separated with NUL character
> > >
> > > But then, it may not be such a good idea to pay attention to "do we
> > > have extra '-h'?" when alias expands to our commands, e.g.
> >
> > Another interesting case: even for our own commands, the alias itself
> > may add extra arguments, which confuses things further. So:
> >
> >   $ git -c alias.gi=3D'grep --cached' gi -h
> >   'gi' is aliased to 'grep --cached'
> >   fatal: no pattern given
> >
> > runs git-grep, but even though the user said only "-h" the alias added
> > another option which prevents the help-mode from activating.
> >
> > In this case it is not too harmful, but you can come up with
> > pathological cases where it actually runs a real command:
> >
> >   git -c alias.grep-for-foo=3D'grep -e foo' grep-for-foo -h
> >
> > which runs a real grep.
> >
> > I guess one way to deal with it would be if the user runs "foo -h", and
> > alias.foo is "bar --other arguments", then we run just "bar -h",
> > dropping the extra arguments provided by the alias.
>
> This is intriguing: it would mean that an alias is not purely a
> textual replacement? That's true for ! aliases today, but other than
> shelling out it's pretty close.

One other thing I've just remembered: "git help alias" shows the alias
information without running it. So I don't know if special-casing "-h"
adds much?

--=20
D. Ben Knoble
