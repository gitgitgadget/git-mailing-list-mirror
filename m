Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD5446B8
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 03:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728964181; cv=none; b=bB8wqnxZgiGZRn9uLwtk+7YJtmMDRaExR7B3zXy2Rih4/muwelhYhRfp/JFVJGYbivvv2+IkuJOJTcwJRq+Da/KtAVCsuHKEl7lj/ERQT8BPaASuXfE2fY1hJIs8xt5yKhu8SMuTs7+LYt/XKdDokaBBQ77u4qKaUqsNK2Hh118=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728964181; c=relaxed/simple;
	bh=G37HtJK/MQUHZTObtWcYdTs2rFXKysijQ9IqTiGPtzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gUEMuG5v7PXn1PBMt46T/SCh7CI+fpUhew4ZfnAyTi8LunILDRIQwKTfWqYmmtnScmLYKtNRSn5J70W08Rxl78kdLSgU8EpeZQsTY3VRdd8VVTN2YvICf6Tqi5lbxti1vL7ctosV3K5J1uDg+4xMjHpaW7I/RekwVp0FxUvuIz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHnhSvJe; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHnhSvJe"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-50d4780a24eso672013e0c.3
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 20:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728964179; x=1729568979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDBjG1t6IjEbIkqwoSZzlVGWj9TCUHhKLoQndT8CuXs=;
        b=hHnhSvJeR6U6+R3J3ANoefC0CtNKvgB/4mMw8bQ1l0beUv7gz9fjtqFqS4oyw1CJpK
         r8Vz1y41z6LgwWDeyzt1Ahc4nvY0s9bHpcIARH+cnOKtLEUT6tQHconnq5cfBgnV4oVu
         Y9KMVjBOSUxuQKnWPOPHT7b+9trNPrzyr9pNUWWmpAhrPQCPWgDHIkSjMknqKnyzPxwt
         /riNnTHFuGeqhnUBLNKKiJmRMzj8Mh4/vrqTmxzqtPk1eaQGeluAbkxCsI79Li3wbD7X
         9DMZMZq07RVIf/AMXBmCjoSkmMnvZyrrjXOaafWIdZJ/KKb3N4rFiYMbEGJwichDi+4G
         vffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728964179; x=1729568979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDBjG1t6IjEbIkqwoSZzlVGWj9TCUHhKLoQndT8CuXs=;
        b=jPan3/5jal8kdXc3wi23VlUTw+eqPS795UQDnMDa17XaZnGgDJsJkDgMq0yAQC9mpn
         Sa+H5iC1uLaUbDfCxfH12A9uDaz6PYLjSTIybgQitoMZNBzqo072igNiiTR+iTlbjCk+
         CkbVz6Qy6POQF+ODbyswjqtzrpzJAqgCWTW0uSXjUQMzpakaRLZHxw1HqUOWYIl+s2Bh
         jCoH2SyxS8XauK8uw37DnhQnXa56kpkW385mqcRDMUNL73yM3dbO0OYutASrGulaEP4n
         PIwTHxUu7aSptIjedi1iNfXjrkIp51jzQo5CT/iOV41aoXSJ/v8wWLhlBuxcgDKf+tn8
         TWQQ==
X-Gm-Message-State: AOJu0Yx6rg4+tpRr43JH+SXrl2ZX1T4rrqAz66h2KAYGMWRKN85cNyfB
	/q5ney5BYfiNgo/x+y1TYpSisClg+szBsvgdKHNPluZIfhbLoghSfSTl/1pexnRsSEq/fndYzak
	hYfKv1KOlyQS5eXuPtsmq9z4Huss=
X-Google-Smtp-Source: AGHT+IEtJLRGxYAOS7em28rOD0cvgnNjWR6BLgdhkfAkv7no8aAUV8rrOgdrCL9qvOL8KemBEBbLbx2xpprprcMIrBM=
X-Received: by 2002:a05:6122:2189:b0:509:e5b5:d133 with SMTP id
 71dfb90a1353d-50d376b651emr5250157e0c.6.1728964178692; Mon, 14 Oct 2024
 20:49:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSxiM9FoGBhsnBE4E0Fvq-x_HvyFGGkkhaLNoRdVkvE6CpaZw@mail.gmail.com>
 <ZwqcHDzaR2U2JNu0@nand.local> <CAPSxiM_U5ffBCsTrbBqsJK0jUZtAuWSLook8CLKat46CX0QC7g@mail.gmail.com>
 <Zw26bU17+2SRfv8L@nand.local>
In-Reply-To: <Zw26bU17+2SRfv8L@nand.local>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 15 Oct 2024 03:49:28 +0000
Message-ID: <CAPSxiM9jHn-RQ3FXJRQNKAE9xPr_4yJbWB--oWgQeKhEMLmE4Q@mail.gmail.com>
Subject: Re: [RFC Outreachy] Leftoverbits, which involve replacing atoi with
 strtol or strtol_i or equivalent.
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Patrick Steinhardt <ps@pks.im>, 
	phillip.wood123@gmail.com, Christian Couder <christian.couder@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 12:42=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrot=
e:
>
> On Sun, Oct 13, 2024 at 03:46:05AM +0000, Usman Akinyemi wrote:
> > On Sat, Oct 12, 2024 at 3:56=E2=80=AFPM Taylor Blau <me@ttaylorr.com> w=
rote:
> > >
> > > Hi Usman,
> > >
> > > On Sat, Oct 12, 2024 at 11:21:13AM +0000, Usman Akinyemi wrote:
> > > > Hello,
> > > >
> > > > I was looking at some #leftoverbits which I can work on and I came
> > > > across this conversation.
> > > > https://public-inbox.org/git/CAC4O8c-nuOTS=3Da0sVp1603KaM2bZjs+yNZz=
dAaa5CGTNGFE7hQ@mail.gmail.com/
> > > >
> > > > I followed the conversation and came accross
> > > > three instances where I think atoi can be
> > > > converted to strtol or strtol_i or parse_timestamp().
> > > > These are the three files which I think the atoi can be
> > > > replaced with.
> > >
> > > This seems like a good #leftoverbits to use as an Outreachy
> > > contribution. From a brief skim, it looks like this is going in the
> > > right direction.
> > >
> > > But to get help from the rest of the list, please submit this change =
as
> > > a patch or patch series, following the instructions in:
> > >
> > >   - Documentation/MyFirstContribution.txt, and
> > >   - Documentation/SubmittingPatches
> > >
> > Thanks Taylor, I already went through these as I already sent my first
> > patch before.  Also, I already sent a patch as you suggested. Thank
> > you very much.
> > Usman Akinyemi.
>
> I must be missing something... I don't see any patches from you that
> touch e.g., merge-ll.c, which is the first file you mention in this
> thread.
>
> Try searching the list archive for:
>
>   f:'Usman Akinyemi' dfn:merge-ll.c
>
> Is this different from the other patches you have sent to the list? My
> apologies if I am missing something here.
>
> Thanks,
> Taylor
Hi, Taylor

Thanks for the reply. There is a little confusion going on.

This is what happened. I had two patches which are entirely different
from this leftoverbit. Both has been reviewed by other maintainer and
integrated into seen by Junio through
https://github.com/git/git/commit/4dae47e02757333b7d6a6508e36ccb5463b6ad92
 and https://github.com/git/git/commit/dfdc6a71e76c7a1dab22fc9d9e437c858cfe=
a6dc.
I submitted this leftoverbit patch but I made the mistake of basing it
on top of the previous branch which I use for the two above commits.
This is the commit which has the leftoverbit and the previous two
commits which have already been integrated into seen.
https://public-inbox.org/git/pull.1810.git.git.1728774574.gitgitgadget@gmai=
l.com/T/#t
That is the reason why you saw it again. Also, I noticed you also
integrated the two patches again into seen and gave some comments. I
think that might not be needed again. Thank you.
