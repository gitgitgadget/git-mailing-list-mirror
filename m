Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F5146B8
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 03:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728964503; cv=none; b=gkrkNb5IV/HNRlUccvKKuLgJnclLTLJ/g4HEaL7nHjxay4d112S97GawinqpxOYYQoAhellf3f4qLNxDQ+gXTE81QJBPIv61912O3d5gBqJW18Xx8tUkYMsVVuJDAsGZLaXb0KODCg6pwVksEL80zdshMIAD6jWZiklauDOxAKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728964503; c=relaxed/simple;
	bh=McN+uttxkje57rRU8h9TNq2vjdBIP8Cn+FsNGXMtkz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O52XvhwWCZbRfwMkwiL/hyVx9XC4zf+vY0Haew2daIbNOjv/ScZRIXrYNZtH3YxZvosLt3f84kN1Xy+pH4xJKC/eIAzDTcCeUeBUrj5xdiaAmMQzwDAtpeBwKTKzqcVMqHDiGp+OCyw/Xw3DFw2ixcmKn2lelwFM5+ZxpD/PYDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lO+3mX2k; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lO+3mX2k"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-50d73699e13so270535e0c.1
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 20:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728964501; x=1729569301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yj0Ksvi/uq8neniwzq/sZzoY4ZXwA8QgboiLoyBuaVA=;
        b=lO+3mX2k6Q6k7nUH1NvzQzUEjKYeiv2xPTPb1foK6Y7wdXSoaeewmf8q1YwE0diRDJ
         bLJIpSwuCUyhLXyewMldaOs3v6uCQL3w91B+sBD856RVtiWXbSNnp0HttH5QCW2+Z5t0
         PS3WJfkx/P3AK5rkm3GUWSOXGASKUh9TEuE08wRypgHfqXIkxyrMCHSK+AExLNZ1+AGG
         83YQLE59jJDYaxeHwvQSCJx5paafDt83PC6wMG9wbNwPcIDPfaQ4byukFQxkHR5aqI4j
         /M5eOBvcQfOLWi2kZYBo0alGsQbgjEA7nE6D2etqXNwW9/xDaIrIm/4Sg3WcVSW1+s2F
         ZCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728964501; x=1729569301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yj0Ksvi/uq8neniwzq/sZzoY4ZXwA8QgboiLoyBuaVA=;
        b=DYv5AXD8FfpQFuneOrSiJ1dcPUpTJR+b049KoDSYduLEK5qPh6yE3FOkqXRACh5olY
         sXFdO0MHCWVuFcixkEoe/MTW/SUxEKqNY87WyPZHvLf9CpUWgnTBTFjT71LGXFzui8E8
         PiNZOIboLbca5GVKpfyEaSjGeCKpufmyc5K1toY2Eyq7HuH9f3e3POkWYJ4W8K1oZhIX
         CTwg1mi8oURf1GiCGuhdA6KLQLEir2TUrQtIMgCwTNgYC6yiqO64KFB0CS35wcJwxzy9
         gW77lzvSUCmh7JssiUqsAhFmzfmZZXR1DeU49Qr8W/pT0YspdJQB9qcWn8PrrfdjvQmy
         +wOg==
X-Gm-Message-State: AOJu0YxJ3bjYAM3OEoq/GcAaOssESuDfurJpzwbjK91o2NBbc5oeXDnQ
	5sjPGBZtt6yC6nqX4FlhyLrWc9LgghbZTPJx/vySEV0qH2yegmXanUE43NdxSRmCKAuMDPhsoEx
	budmyH+JUVneNbidgeNdqzPxCJTk=
X-Google-Smtp-Source: AGHT+IF3TKC+dagC54Y5kuBUNpETo9wgVWVaODWYRJr2xonvKpiLnI40tBASG2XPKG1kSme54nWej8RUlrPK5yykZdI=
X-Received: by 2002:a05:6122:1059:b0:50d:5754:c903 with SMTP id
 71dfb90a1353d-50d5754cbb8mr3561741e0c.4.1728964500933; Mon, 14 Oct 2024
 20:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSxiM9FoGBhsnBE4E0Fvq-x_HvyFGGkkhaLNoRdVkvE6CpaZw@mail.gmail.com>
 <ZwqcHDzaR2U2JNu0@nand.local> <CAPSxiM_U5ffBCsTrbBqsJK0jUZtAuWSLook8CLKat46CX0QC7g@mail.gmail.com>
 <Zw26bU17+2SRfv8L@nand.local> <CAPSxiM9jHn-RQ3FXJRQNKAE9xPr_4yJbWB--oWgQeKhEMLmE4Q@mail.gmail.com>
In-Reply-To: <CAPSxiM9jHn-RQ3FXJRQNKAE9xPr_4yJbWB--oWgQeKhEMLmE4Q@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 15 Oct 2024 03:54:50 +0000
Message-ID: <CAPSxiM_qw0akVoG5cJRgwk6oP1q519zBp2m6GmFYGmrrc3jXfg@mail.gmail.com>
Subject: Re: [RFC Outreachy] Leftoverbits, which involve replacing atoi with
 strtol or strtol_i or equivalent.
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Patrick Steinhardt <ps@pks.im>, 
	phillip.wood123@gmail.com, Christian Couder <christian.couder@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 3:49=E2=80=AFAM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> On Tue, Oct 15, 2024 at 12:42=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wr=
ote:
> >
> > On Sun, Oct 13, 2024 at 03:46:05AM +0000, Usman Akinyemi wrote:
> > > On Sat, Oct 12, 2024 at 3:56=E2=80=AFPM Taylor Blau <me@ttaylorr.com>=
 wrote:
> > > >
> > > > Hi Usman,
> > > >
> > > > On Sat, Oct 12, 2024 at 11:21:13AM +0000, Usman Akinyemi wrote:
> > > > > Hello,
> > > > >
> > > > > I was looking at some #leftoverbits which I can work on and I cam=
e
> > > > > across this conversation.
> > > > > https://public-inbox.org/git/CAC4O8c-nuOTS=3Da0sVp1603KaM2bZjs+yN=
ZzdAaa5CGTNGFE7hQ@mail.gmail.com/
> > > > >
> > > > > I followed the conversation and came accross
> > > > > three instances where I think atoi can be
> > > > > converted to strtol or strtol_i or parse_timestamp().
> > > > > These are the three files which I think the atoi can be
> > > > > replaced with.
> > > >
> > > > This seems like a good #leftoverbits to use as an Outreachy
> > > > contribution. From a brief skim, it looks like this is going in the
> > > > right direction.
> > > >
> > > > But to get help from the rest of the list, please submit this chang=
e as
> > > > a patch or patch series, following the instructions in:
> > > >
> > > >   - Documentation/MyFirstContribution.txt, and
> > > >   - Documentation/SubmittingPatches
> > > >
> > > Thanks Taylor, I already went through these as I already sent my firs=
t
> > > patch before.  Also, I already sent a patch as you suggested. Thank
> > > you very much.
> > > Usman Akinyemi.
> >
> > I must be missing something... I don't see any patches from you that
> > touch e.g., merge-ll.c, which is the first file you mention in this
> > thread.
> >
> > Try searching the list archive for:
> >
> >   f:'Usman Akinyemi' dfn:merge-ll.c
> >
> > Is this different from the other patches you have sent to the list? My
> > apologies if I am missing something here.
> >
> > Thanks,
> > Taylor
> Hi, Taylor
>
> Thanks for the reply. There is a little confusion going on.
>
> This is what happened. I had two patches which are entirely different
> from this leftoverbit. Both has been reviewed by other maintainer and
> integrated into seen by Junio through
> https://github.com/git/git/commit/4dae47e02757333b7d6a6508e36ccb5463b6ad9=
2
>  and https://github.com/git/git/commit/dfdc6a71e76c7a1dab22fc9d9e437c858c=
fea6dc.
> I submitted this leftoverbit patch but I made the mistake of basing it
> on top of the previous branch which I use for the two above commits.
> This is the commit which has the leftoverbit and the previous two
> commits which have already been integrated into seen.
> https://public-inbox.org/git/pull.1810.git.git.1728774574.gitgitgadget@gm=
ail.com/T/#t
> That is the reason why you saw it again. Also, I noticed you also
> integrated the two patches again into seen and gave some comments. I
> think that might not be needed again. Thank you.
I meant for those particular two patches, since it is integrated into
seen already,
I can probably wait for it to be merged then work on the review which
you gave or what do you think should be done ?
Thank you.
