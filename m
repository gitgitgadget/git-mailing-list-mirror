Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6877415533B
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 20:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720731460; cv=none; b=CVbchMHHLOWf0pyc3E0OC2a/hN4Ratg1BBHeSEocDytYFhmjsyABtVsb9Fm5Xij69UVGH5/IojkRXGRfuZzMncNEF0LnGS6azN7GuUqLRnh613A5/6TBw4iBB9QpMw9cxKe6h+NeqE+/JiM6UGWYxWNGbgia7WrOiWkoaa3Rp40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720731460; c=relaxed/simple;
	bh=yP7o3vj2C9GOALG9wra3VjAQks72PY23bt+xamTlgJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0QtyrSKGKZoSIfmMnUnB8fVe76meqhWq/7XxoBf4+ipLIiQaqUrW3C4BFQtfWftpGzw2weKmChiDAbdMwijQXjOdeuxHhWE/zOYNEekFBQNpxYt4u9femhiWh+JUjldLgvvSCZnYR6iHmkmhyyZgjSOiXKvdc4BMKqK+tVcYvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zdlna7dG; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zdlna7dG"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44a8b140a1bso75961cf.0
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 13:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720731457; x=1721336257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zErR5mwLN6n60PW9f1piH4NhiKlneBz4ZuFA+TFxV7Q=;
        b=Zdlna7dGXHIyC6Fy9i0UNz1YShwTUVO256yH4vNheSz7VrZMrqVCloU5YsESRlQh0p
         TQlsiQ2rMu49KvWHkEgdwJ9WPCiWEoDF5lwYRV2/97ZyegJqqMr9VQnRzOnRvLbf6K23
         jhLEEOw9LvCOJfTAaUxWFGnp7o8kpD0gDGIGnR/9akLe0dTfvhqyBHay3YpipiZhheGh
         m/B1B1Ykw5I3W6Sc3db6vyPs6f2ZrWgjsCG9Dz6yFDr0vHN/6p5WUFPyCv30/Kwn87kP
         LgMWmGlEd52GkIKX5TByRS9C4U6DYm8womS3aICv7vAhjAWpoC5JwPRjeW4sNcHsk6cy
         hNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720731457; x=1721336257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zErR5mwLN6n60PW9f1piH4NhiKlneBz4ZuFA+TFxV7Q=;
        b=Jah1nT4xZtLIE1lvQcb9hRijAosZs0dOYpFT7+TqZ10igKmONoOEzxYCMazGqm7cZw
         LMk62EK+xdBrwlgF32yD38qnsj5bPBrYaAIg3zR0gHiRkS3QeYdas08BHr8cbDTCVIBw
         Tfq/5rdpQKtGs25eLU/d+CT23zzwcxeWCgwYvs5H1bp2v5BCv2nT7cf3cS6Gw6SMRmNm
         5lS4tcSzZnsdeUeHbfzZlgVZ+s5wwu6rIPDTGo3miFZloQHwY2+NnG/Vtip4oTCm/F5G
         6f12RJ5T6YSM4FSeNyZu8BPsPM3JuSrjAcg7KFo+7IYmcIFSb+3Pl2lcE5cQQ5wmGx6X
         wP6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbwoSsp5QVZ3KZ8X+P+v1roPWEe/hza9AWV5QewMkrnvA+aEhRnOHjvTyl16s1H8wufCfao+lJIGa9Ujo4UHhEAjpF
X-Gm-Message-State: AOJu0YxPfdlFZWOrt8F5ooCdncvJsXsgzigm3zd//k95mg/q3rkJU08R
	qK0UQ3pnmDELT8zgnWtax/qV7zhqL382s/43W3NZPfZT5vYhfrqG8JQdqyvyzs8mUquNFbOQLkv
	Z4mGg5wcbWiTyY6X90L3owRksJTQfJPZGTxTx
X-Google-Smtp-Source: AGHT+IG9V0RRbIueZBIr7eNDAS04ARSVVolxyfZcfqy2JU3I28Py49gM3TcX5P3lUFBLqSxMinH4+NlvR8glr+S8UEM=
X-Received: by 2002:ac8:5ad6:0:b0:447:ec33:f488 with SMTP id
 d75a77b69052e-44e7341af84mr1008311cf.4.1720731457315; Thu, 11 Jul 2024
 13:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709225042.2005233-1-emilyshaffer@google.com>
 <Zo3EvvSI999ngrLn@tapette.crustytoothpaste.net> <CAJoAoZmq=TyQxnVJvGxqKJj7XqvOxX4osa5Q5K4=w1NMWECBOQ@mail.gmail.com>
 <CAO_smViKbb5pKKsfEV9nMLNJEjJ34HU0fUZmG8EPJjXq2fnviQ@mail.gmail.com>
In-Reply-To: <CAO_smViKbb5pKKsfEV9nMLNJEjJ34HU0fUZmG8EPJjXq2fnviQ@mail.gmail.com>
From: Emily Shaffer <nasamuffin@google.com>
Date: Thu, 11 Jul 2024 13:57:23 -0700
Message-ID: <CAJoAoZmUXGO7U+ee+-Uz0qFib3xEdOy9Bp+RChC6=XoU=7NPbQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: add platform support policy
To: Kyle Lippincott <spectral@google.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	"Randall S. Becker" <rsbecker@nexbridge.com>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 1:12=E2=80=AFPM Kyle Lippincott <spectral@google.co=
m> wrote:
>
> On Thu, Jul 11, 2024 at 11:15=E2=80=AFAM Emily Shaffer <nasamuffin@google=
.com> wrote:
> >
> > On Tue, Jul 9, 2024 at 4:16=E2=80=AFPM brian m. carlson
> > > I think it's also worth discussing what we require from a platform we=
're
> > > willing to support.  For example, we might require that the platform
> > > pass the entire testsuite (ignoring irrelevant tests or tests for thi=
ngs
> > > that platform doesn't use, such as Perl) or be actively pursuing an
> > > attempt to do so.  We may also want to require that an OS be actively
> > > receiving security support so that we don't have people asking us to
> > > carry patches for actively obsolete OSes, such as CentOS 6.  Finally,
> > > some sort of time limit may be helpful, since some Linux vendors are =
now
> > > offering 15 years of support, and we really may not want to target
> > > really ancient versions of things like libcurl.
> >
> > I sort of wonder how much of this is taken care of by expressing
> > "fully supported" as "can run in GitHub Actions". Even if an LTS
> > distro is 12 years old and using ancient curl, will GitHub still be
> > able to run it in a VM/container? Maybe there's no such guarantee,
> > since you can hook up self-hosted runners (which sounds more appealing
> > if someone's got something weird enough it doesn't run well in a
> > container).
> >
> > I'm not sure which of these requirements we'd want to enumerate - but
> > does it make sense to tack it onto the end of this doc? Something
> > like:
> >
> > """
> > Minimum Requirements
> > ------
> >
> > Even if tests or CI runners are added to guarantee support, supported
> > platforms must:
> >
> > * Be compatible with C99
> > * Use curl vX.Y.Z or later
> > * Use zlib vA.B.C or later
> > ...
> > """
>
> My concern with actually listing what the minimum requirements are is
> that we then need a process for raising the minimum requirements. For
> C specification, I can see that rightfully being an involved
> conversation and achieving consensus that this is the right time to do
> it. For things like library versions, I'm less comfortable with it
> because if we have to raise the minimum bar for some urgent reason,
> there's the potential for additional friction with these platforms
> claiming that we stated we'd support them (ex: we say you need to be
> able to use libfoo v3.x.x (v4.x.x had some breaking changes, but
> coexists with v3, so we just stuck with v3), and some security fix
> that we need to receive only exists on the v4 version, so now we need
> to port to using v4 so that we get the security fix).
>
> I think it's probably fine to list minimum requirements, as long as we
> have something conveying "and possibly other criteria". I don't want
> this interpreted as a "do this, and we will try hard to not break
> you", it should be interpreted as "if you can't do at least this, we
> won't even look at patches/tests/CI to unbreak you/keep you unbroken"

Yeah, I agree that I'm somewhat uninterested in enumerating a set of
deps/criteria that will then magically assure it works - that does
sound like a hassle to keep up-to-date, and in fact I think would set
us backwards from the goal of this doc. We'd feel tied to that
criteria without any ability to move forward, which would probably be
our current status quo or worse.

So, I'll make it clear to reflect the second thing you're saying in the rer=
oll.

 - Emily
