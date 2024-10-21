Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9857C1EBA18
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 12:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512453; cv=none; b=sY1HgA6QmYx6tRUxip/1eaGYNXY/hyOYiYBj51J3LTJMvgL3YdqtoT3gv6P6xycynaNWPBRpXXScqr2qmMCGCADMoGaycSG0aiYnfwzuNnVZFPdGtErJXIC/iDwhpYclIkGBGMr26MCC1XhDvs6lKBElvjBOWkAxsiTIe6JYa8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512453; c=relaxed/simple;
	bh=sivCKMT+I3X4oZmfy5MJajbNXGODRzjL4D5GWEt+d8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqOocDR+V3Lva+24QMSvvKWb0aKxpzVZ3itpdAi1ld7pCeA5X+TLhJJ2zxJtjUA/KhpL8fMAIWOLgDI/PFqPNzQW/o0vbc0x5lqLqTpPeussgtDbzy5UYNkQXHakQ1G464j0g2fBWxZcs5cVRfH9qjJvzpN4OTlfc0a2Nqpc13M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8xBALjI; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8xBALjI"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e607556c83so1264827b6e.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 05:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729512450; x=1730117250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sivCKMT+I3X4oZmfy5MJajbNXGODRzjL4D5GWEt+d8A=;
        b=l8xBALjIct0wbgprr1/YrOPKKW296Ya/SF3QgUnwDfr9TOFf9zZOD+8+qHHyPJTRnB
         KgQ1ahAktO5OB2SUaGvwHIuUrN6cuPTldTwBn869kZssAnKuJNVY7hKf0Gfx37F/sAFx
         qvYleuMbG2Fum8sq9SXorbkJzb+RRfsrw626oAV1HuHenCGiTrxu9Erzd+Fw9NM9+11R
         yhl8ZhQJedX8k0gRt9h4W0vLAkAEKYHFukYZGPdG1WflnM2LWycdyA6i9DKoieJG0Qyv
         Uvl81X7d8I1f80q9nA1/223vT5DW80ilL9sOki5iyR1KLqA414Jku2LUJEp7fvxkuBvj
         yR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729512450; x=1730117250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sivCKMT+I3X4oZmfy5MJajbNXGODRzjL4D5GWEt+d8A=;
        b=hA/wsqd5pfwIRyMfIw7GsYB+gqcNZhfI2SMG/zAC+KG5jPyJ02/YLfGLzsH2Vf/uDZ
         Ee9O+3EFUMCqNrkjUhDXt+u30w12+8h2U/3sm7EGgi0b1HfCzlVvtPBeJlTID97SgpxG
         iZTZkwGyM8H4cPPHdDbHuGblP7FGPqQGOqwh5Fxw2ykFslvTI9bVIPlgKGungn9qQ72i
         56naO7EZxEL35qrzXZWvaIyZKa1BbcHmKzRA9AY9M6UcpaQL9CVhPzZTjkvhUaCd94wC
         4Y6ztBT5tHq0Nk3QpY4on/1x1tvB9J28PGZrJ34DViZBN+7nNwbmqUsJD0xogK5U3vDW
         H3vg==
X-Forwarded-Encrypted: i=1; AJvYcCWd8B2qODSn11ev+v7lL2f9yig4+eUFKVikeDCrVMptGiKcb2kWO0LYDHZuPUQJkGiFvBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy62fhybmKENdmzcl+Or/bln9lT1jgGa/IfBAgGT4LSUsds23YL
	69rxmgOtNMPRfKJVspMoZP+KVscgYe6wKOCnbYz7ObtxWCx3oBvsQzyhqLRBnS3oS2cDTCyLPkZ
	ERKcF1Au6ARimkJxejAer08EYJWV2xveh
X-Google-Smtp-Source: AGHT+IGKZC/rvGjGMohPgWAMRPnlBWMy/RoFwgEB9cUm1Ejpq1X10/NBU/Jwer/J6CpSnel7LFhHbABlH08/3pFo5rI=
X-Received: by 2002:a05:6808:4444:b0:3e0:483a:380f with SMTP id
 5614622812f47-3e602bcc0ffmr11021624b6e.0.1729512450527; Mon, 21 Oct 2024
 05:07:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <705912536.3510460.1729265181938.ref@mail.yahoo.com>
 <705912536.3510460.1729265181938@mail.yahoo.com> <CAPSxiM_4nBcB53+pfvC4YUsVz5wtJYgFEVuWQdCdo=2VWLj=Tw@mail.gmail.com>
 <1075918304.3566148.1729271777281@mail.yahoo.com> <CAPSxiM8sXud=J9pQro28=F9UCbf-PR_gmEp=uyp6d6prCHHxzw@mail.gmail.com>
 <1692736727.3717090.1729300501716@mail.yahoo.com> <CAPSxiM9=k8NQ1ExkRS49=1A6GwMn+A3wu-dkv+0R=2vOVDGvzw@mail.gmail.com>
 <ZxZCbGeBubPb43t8@pks.im>
In-Reply-To: <ZxZCbGeBubPb43t8@pks.im>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 21 Oct 2024 12:07:18 +0000
Message-ID: <CAPSxiM9aCRWvR4eyKQeBAtAbf0t_-ruE97t8uPkqN4qDiZDoOA@mail.gmail.com>
Subject: Re: Oureachy: Microproject (Modernizing a Test Script in Clar Framework)
To: Patrick Steinhardt <ps@pks.im>
Cc: "shamimkhanum@yahoo.com" <shamimkhanum@yahoo.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 12:00=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Sat, Oct 19, 2024 at 03:48:58AM +0000, Usman Akinyemi wrote:
> > On Sat, Oct 19, 2024 at 1:15=E2=80=AFAM shamimkhanum@yahoo.com
> > <shamimkhanum@yahoo.com> wrote:
> > >
> > > Can you please share me little bit method how I can search previous m=
icro project? I search it show me multiple folder. And you also tell me I c=
hoose this topic " Modernizing a Test Script in Clar Framework" can someone=
 else work on it or not? Please verified this and guide me. And mentor show=
 me ideas link for micro project we choose those idea or new idea?
> > > Pleasure for me if you guide me.
> > Hi Shamim,
> >
> > This is a link to some microproject as shared by Patrick -
> > https://git.github.io/SoC-2024-Microprojects/.
> > If you want to search what other people have been working on, you have
> > to go to the mailing list (https://public-inbox.org/git/)and filter it
> > by outreachy. The results which contain the PATCH tag are the
> > microproject that has been worked on by the other contributor. As I
> > understand, no one is yet working on the topic, since it is what is
> > supposed to be worked on during the internship.
>
> Thanks for answering their questions, Usman!
Always happy to help in my little capacity.
>
> Shamim, please let me know in case you have more questions. I'd also
> strongly recommend to use reply to all recipients of the mail so that
> you don't lose the Git mailing list as recipient :)
>
> Patrick
