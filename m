Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FF82E2663
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 08:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767775801; cv=none; b=hFD+RkOiSkzwT3CCX9CX6k936rVx9d8I6VGxT0rUG0uXaRSHCYUM+EdaY0E/WX42iLRkN9USXuSdKvFA94gz+dIoSkcVYz9WiflMpiCrcqvNRx8a+3qW4DUTbw7v5vJcaC58tffWAUIEKIB1raVNji3ga8+5DFW/OtnD4dwdUo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767775801; c=relaxed/simple;
	bh=4InisJbteqL78Xz5EecWqgjmvI6q4V+P5CodzcilMm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aSZq2GWOFuTF1g4ppK8i2Z7De6WS3dTIrUl6Qf2PQ0zDc+RZP/i9rfgWyE4/8otqQRWOWLwifuVvXPU8M4vianfSTCsfp83tFD1iY4tyMAOaWYg84WCvlT0b4FF443AxqwXaChVzGgN+ChONtoZ3C00FCaGw3558gfKIC9Zcs+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMa98kjy; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMa98kjy"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5dfcfbcbcc0so640915137.2
        for <git@vger.kernel.org>; Wed, 07 Jan 2026 00:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767775796; x=1768380596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4InisJbteqL78Xz5EecWqgjmvI6q4V+P5CodzcilMm4=;
        b=bMa98kjy2jX/hRD4KR7gDBKelZrsokIetBObxURcXMfJTS48mcV0Ahdnx5zXtEYur5
         vzk2ePqWsgbKREpjz30Zd7NqZEsHkEehLcrDIfA4T7qVDW8/RtJh7m9R7zYUtefMOLWI
         SPGwAgFCQsvuDAI/iUTAojFvq6He5R2hIpuYhxNpRu0XoEOn+RjXbPF15upeC4yXm9HP
         OxRx5/CXkxaCkUi+TjpVZ8jp8zlszsproSc57q9s7g8NvKhwWqMKbgjLQ0jFZ7Nb/D3Z
         qQby6NpI6uBBLePG/1m4whjJr0TN6T+JE4EAKDqHJZcnhSMjt1RY8Sphg8HsOepRzPPK
         knwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767775796; x=1768380596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4InisJbteqL78Xz5EecWqgjmvI6q4V+P5CodzcilMm4=;
        b=iH2Fj9SuyJmGfgu6tsgEu8O4czH6hQhp3rOQtRSCXGQ811594HXmbhyYGp1m1y1GQ4
         0Tgg22wrt/aM/HCkH8/V8OxmxXLqohUmIJevJztl6VsJxhIW83e5lXIbeuHWEoV2/YJv
         4Bs9MxpCkrCp6Q3sMRV11+alB/YTbbp0RDxuxMaqY6oxu/IKqLyx+O2R9B3g3a6bnGTA
         FWrQ5Jg5++t7Ycz/LhcvLDLdaerfYMr3HztKv8eogygyoab5I35meVueUTS8FaL7y4fR
         pNmVmV+1keUx9+s9ozFz8R16HGR1suk9/ouqsmuZe7vOTbTLMTbhxh9lMPPDq1dYX5pM
         14BA==
X-Gm-Message-State: AOJu0YxWPSIK7aMkyLSy4lp9NooDDACPnXBtbdqbSyNr+Zv2wszyHD4t
	uH5R+MrIdfoFgt1WL9prNXQzbzVtGDP/8uLCXVl6gsH6DVrt2NN9v03Tc5jK/PTPMV7+OiURpmK
	6RQ2arbTjLsHE1WvvUAZIRajYaZojhdo=
X-Gm-Gg: AY/fxX6vyIOTGAWZG7TS/GSO4iCxUVRh+g5F37WK9Obf0jtXFOICquNQYHG3nnVCL0k
	m/JS7uFJ8VyCef7bCYRUxovhkoZY3bnYmPaUoWt0iYjz3HFsL2IeTZ0M1EtujWBFaXtBoGlbvVJ
	hG4vVxWcsz5R79pFb+JEo0gGimFeAIsY93zZXNzHk0kVfxoRsenK32VQ0JYBqUpAiAn/I9XTiq0
	GMNDmrO4hhZVCraBZyzv/00NWqWf2HrNAdoejmgPO4K6GToRzOQ1rTytBs35zbEG/BrPuY=
X-Google-Smtp-Source: AGHT+IGAvixP2YnofxjEiKl/aMz589q/PfvmOIER9Ofk5xrO73k3x6VRpFsHtc9esYI66L3G+52v3HoF7fXDDDs2r7A=
X-Received: by 2002:a05:6102:c4a:b0:5d7:de08:dcd6 with SMTP id
 ada2fe7eead31-5ecb5cbba99mr645331137.2.1767775795870; Wed, 07 Jan 2026
 00:49:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aVz5kf6eLsMZ6WQQ@Adekunles-MacBook-Air.local> <54e48ac4-7151-4378-b95f-8f22279d6761@gmail.com>
 <CADYq+fafH-cwc7Ego1fDdNRgSnrOeGzCz_vCqszajVYEx1FV-w@mail.gmail.com> <CADYq+fZDyJWzuJ_DZUc0-uEXJnJc-3mjg=xecaRZ+XqOF1zd1w@mail.gmail.com>
In-Reply-To: <CADYq+fZDyJWzuJ_DZUc0-uEXJnJc-3mjg=xecaRZ+XqOF1zd1w@mail.gmail.com>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Wed, 7 Jan 2026 09:49:57 +0100
X-Gm-Features: AQt7F2r36lzYETcRQ3oLUzIEn5OMh5Z0uBD6YxeXo3iFIJL_koMDjLaplaWVAsc
Message-ID: <CADYq+fYRbdMOo-bZ9bQ0uVpthNKrxKB-fDama5xN-kukprS01w@mail.gmail.com>
Subject: Re: [GSoC PATCH v6] add -p: show user's hunk decision when selecting hunks
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 11:19=E2=80=AFPM Samuel Abraham
<abrahamadekunle50@gmail.com> wrote:
>
> On Tue, Jan 6, 2026 at 11:02=E2=80=AFPM Samuel Abraham
> <abrahamadekunle50@gmail.com> wrote:
> >
> > On Tue, Jan 6, 2026 at 5:10=E2=80=AFPM Phillip Wood <phillip.wood123@gm=
ail.com> wrote:
> > >
> > > Hi Abraham
> >
> > Hello Phillip,
> >
> > >
> > > On 06/01/2026 12:01, Abraham Samuel Adekunle wrote:
> > > > When a user is interactively deciding which hunks to use or skip fo=
r
> > > > staging, unstaging, stashing etc, there is no way to know the
> > > > decision previously chosen for a hunk when navigating through the
> > > > previous and next hunks using K/J respectively.
> > > >
> > > > Improve the UI to explicitly show if a user has previously decided =
to
> > > > use a hunk (by pressing 'y') or skip the hunk (by pressing 'n').
> > > > This will improve clarity and aid the navigation process for the
> > > > user.
> > >
> > > I like the idea of telling the user if the hunk is currently selected
> > > but say "(previous decision: use)" makes the prompt rather long (some=
 of
> > > the prompts in the tests below are 80 characters long). I wonder if w=
e
> > > can find a more compact notation. "(currently selected)" is a bit
> > > shorter and takes us under 80 characters but is still longer than I'd
> > > like - maybe someone reading this will have a better suggestion.
> >
> > Thank you for the review
> > So I previously used selected/deselected. But Junio was not okay with t=
hose
> > choice of words because they did not clearly tell If the user selected
> > to skip or
> > or selected to use the hunk.
> >
> > But how about
> >
> > Stage this mode change (you chose: use) [y,n,q,a,d%s,?]?
> > Stage this mode change (you chose: skip) [y,n,q,a,d%s,?]?
> > Stage this deletion (you chose: use) [y,n,q,a,d%sm,?]?
> >
> > or
> > Stage this mode change (choice: use) [y,n,q,a,d%s,?]?
> > Stage this mode change (choice: skip)[y,n,q,a,d%s,?]?
> > Stage this deletion (choice: skip)" [y,n,q,a,d%sm,?]?
> >
> > or
> > Stage this mode change (use: yes) [y,n,q,a,d%s,?]?
> > Stage this mode change (use: no) [y,n,q,a,d%s,?]?
> > Stage this deletion (use: no) [y,n,q,a,d%sm,?]?
> >
>
> Also "(you chose yes)" i think is an option also.
> Stage this mode change (you chose yes) [y,n,q,a,d%s,?]?
> Stage this mode change (you chose no) [y,n,q,a,d%s,?]?
> Stage this deletion (you chose no) [y,n,q,a,d%sm,?]?
>
> Abraham.

I also think "(was: y)" or "(was: n)" is considerably shorter
Stage this mode change (was: y) [y,n,q,a,d%s,?]?
Stage this mode change (was: n) [y,n,q,a,d%s,?]?
Stage this deletion (was: y) [y,n,q,a,d%sm,?]?
