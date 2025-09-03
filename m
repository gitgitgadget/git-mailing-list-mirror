Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEE32C08CC
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756936543; cv=none; b=CYMLfxBjC4qzeMMLNrA78c+we5lco1VlF+GZheAM+SNPiDCBXlMM699RCdI4kQVhRAXsU63YetqWrJrigMXck8T5+SisA8LZ6/V68/zYABp+wa2kcnuwYY9NS36f3wdOfiLLk8Gfa8EIdppzIIktEVT7Z/obMiEprOA8/VvwECQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756936543; c=relaxed/simple;
	bh=uuSFFMVhWqpb1xatzsDS+zBF+4UB8jqGXErz9tdWSNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDNL2ggYZLlY8Eaxgid3iJbyB+Pfc2rvE50sJCEyrG/iG+S3E4JgqLShMV9nMtTgIEGIETP/nyMayrhy6bWZLcQLjoy2WvGduuE6n9dGf5mjD5NvCaHeLFokMnX3rSe3expmyZjo9pjwMpmW4sTh3Xw5r+9dy0xgdSMtnK8+iCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2cp3QbA; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2cp3QbA"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b0449b1b56eso59535066b.1
        for <git@vger.kernel.org>; Wed, 03 Sep 2025 14:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756936540; x=1757541340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOQulw3unx2X3zpt/F62AZldKQW56NwXyiSUscqFCXc=;
        b=R2cp3QbA1j8c6t5pPLAIZsC0QjVeX2BsttEoVqpvD9/uSkexHBF6CpUPef+y6h4ztq
         COk2WB66y6wsdBODvSJSJNjU6ecklzY8amshbjxEHJVwkNGEnyTxF4Rcj81+Z/w7t75W
         nIOfzgZWB3RIo+ZsyZRLcopDVhCeiP6fTcdsk9gB+2mq5jRiExkiSE1WiTKgrXNmVFF7
         rlTB1CfcNIR7zvg8o0mfZNug+pqKYGDWJfxR+AoEQz6lzCzWEoxz1pZCp+MBRY6s+vWz
         Ek0MW0H/PxcplWydMUGInWi7DqSGLWlzmKgUMYzNNpXLXTx8TNgldgdxb0HYOBmO9BN4
         kL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756936540; x=1757541340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOQulw3unx2X3zpt/F62AZldKQW56NwXyiSUscqFCXc=;
        b=s6I22f9Uilj1SnrkaVAFr2Jfi8yR81CVXpMUuIdoRKFalXNG3dtK8Kq+ctnU4az4kK
         O/sTDOtXagaWZZnpl4xKZawHr0rs0/dl7KDRXu1rmK3BHZstM2CcCkeuUTowEKBJNbJs
         p3NR0RQJdwNhJAvxqhXWcxpInfyyDZIXKAjSKHO8RhYbjZFBvvf4drOU/sQPyjrzMvnz
         b3fcjFFQVSBY+J63+KBD5V/sOJwhkw0ub84b0/Sbxl74FuI5L+D4uAA49zqWyFsLlTIz
         PgXvIRYClJ9QnS3yfCQ3YlwBAEnTvBg7mt8Sq2bZmqiyujYvWySirGqm/86cRWvuycDk
         Nzcg==
X-Gm-Message-State: AOJu0YwgJskeKjoU9AszHr8UFV8V7mJGVSvbRUwFoQ/YrNATzBXGpn8P
	8+irZyPlYKlfMlh1rBpf+vffDdEE+xm2TYpfVmpQTMuH6TQBic6DIeziV1noSAhLN9n6eBk+UxR
	Vq8UmGBBLNboeOb9bnQETS0FeSXYJzSQ=
X-Gm-Gg: ASbGncvsSPI47dVyW61CLSEBDUZUT+GC/fA2wsbgv/T78deGGy3QKh/LslucN6HOVjF
	w+n7eS460U66cJP5qPFoIK/8tqYclXBAQCDu23fP6QU0pHPusbgPMPa4DehcpkjW0zRcR/Yeek5
	xmsq5QmUN6VVs6BiRAnFIqQUk+i/B0qEkR4KqImHq+02c3tUCQt9HYJlHv7O2o9quGnm6rSypXb
	b220j8Trfi8UNKoShwNC2NGSQsUKOI0oxjQhuabn8KPOYXsSTP5
X-Google-Smtp-Source: AGHT+IHLUYNSQ4ypY6nU7Qaqd8lbcmGGMPN/zSIzu9PLaqlVstBMSRYryyJEVA99CpDPBAZ8Pk59x4njHJnfDdc2ijQ=
X-Received: by 2002:a17:907:6e87:b0:b04:5895:fe8e with SMTP id
 a640c23a62f3a-b0458960044mr676131366b.36.1756936539531; Wed, 03 Sep 2025
 14:55:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
 <20250824-b4-pks-history-builtin-v2-15-964ac12f65bd@pks.im>
 <CALnO6CBRv-Jvm1FsUAkDSyaNNRXtMukReKzefvCw5-vj=-pnCA@mail.gmail.com> <aLgygyUuQCmR25qU@pks.im>
In-Reply-To: <aLgygyUuQCmR25qU@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 3 Sep 2025 17:55:28 -0400
X-Gm-Features: Ac12FXwfAzA1K5Qiqc3NTAtEPo8jc-fLGSeSKj6T4fWZ8VX4zIQ5qk1c2FIaseM
Message-ID: <CALnO6CAjv0=99AcBLU=z71hGrk0fXp9pWm7wiBF-a1Xd_efrdA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 15/16] builtin/history: implement "split" subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 8:20=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Tue, Aug 26, 2025 at 09:14:49AM -0400, D. Ben Knoble wrote:
> > On Sun, Aug 24, 2025 at 1:44=E2=80=AFPM Patrick Steinhardt <ps@pks.im> =
wrote:
> > > diff --git a/builtin/history.c b/builtin/history.c
> > > index 16b516856e..6d3f44152c 100644
> > > --- a/builtin/history.c
> > > +++ b/builtin/history.c
> > > @@ -517,6 +527,285 @@ static int cmd_history_reorder(int argc,
> [snip]
> > > +               wt_status_collect_changes_trees(&s, old_tree, new_tre=
e);
> > > +               wt_status_print(&s);
> > > +               wt_status_collect_free_buffers(&s);
> > > +               string_list_clear_func(&s.change, change_data_free);
> >
> > I think I'm supposed to see the changes between the old and new trees,
> > right? Does this only happen if I use the interactive machinery to
> > edit a hunk? When I try accepting some changes and leaving others for
> > the next commit I get no diff in the template.
>
> Yeah, it's supposed to show the diff between old and new tree indeed. So
> in theory you should see something.
>
> > I did try to add new diff lines to a hunk, and nothing showed up=E2=80=
=A6
> > maybe I'm holding it wrong? I'm pretty sure I compiled this version.
>
> Do you maybe have a reproducer for this? It seems to work alright for
> me, but I wouldn't be surprised if there was a bug here. The wt-status
> interfaces are quite something and I was tearing my hair while trying to
> figure them out.

Hm. I have a copy of these patches at
https://github.com/benknoble/git/tree/ps-jj. After "make DEVELOPER=3D1
-j $(nproc)" on that branch, I did

    bin-wrappers/git history split @~3
    <input y,q> # once I even used "e" and added new diffs to the patch
    <type commit message> # no status info
    <exit editor>

Then it looks like the 2nd commit gets created automatically. Maybe
I'm just missing how this should work? Thanks for looking at it.

--=20
D. Ben Knoble
