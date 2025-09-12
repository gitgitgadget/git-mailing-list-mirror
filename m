Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0109324B25
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 18:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757701579; cv=none; b=JcH2PcnnNNIlcmrpHfEJOMQoQbzvvXqmIW/FqkemOkH8d2QMO4n8/T0tV3GeN9nj77ri+78YsWSGOYU/SfIAcQf26851sj6Ey+DbdIO/wYgrGejAOShSqbD5RW73/yv6zqlw2Cxd215A9iGl+0HixsP44zIfuHsyrMhIJRl+xGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757701579; c=relaxed/simple;
	bh=cphyJiXYPJoH5lDkywuK1zh3rEP3Wqz1+3sBK73W7jM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rf+vO3qiddk6O+dIeTHPC2w1W7i8Q2kI4hbz+heTfAGPQtyCdvzIbB5oIZtMrGKJwnxYRU74MeLtWMBe2/B/+MDhqTBWy+YsPy6+7GwVTRdK7Y2Zc/zbgJkanhJm5QcYyU5zJ1FwKKSAEgjfvm33RS9qQ7k5+Tm517iqHSsuJvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHa3kXHd; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHa3kXHd"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so3703532a12.2
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 11:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757701576; x=1758306376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKFb5pK6LBMnwNIEUNk1oWRfSvMliaFa07yY/AYfkJg=;
        b=NHa3kXHdi6gfbyTl8YFKSPvky6P7CdpF+yLM5bg17Mgkkukl3k7+x5hX0Mv4gf5yJH
         ojL+ovO24z4QwW8dbTw+No+GU2lA/Mmxx0WehuO1u05c+nXsvNyiurfBz3ysAoIAkQ+k
         MRMB6jRId5dNa1hs9LXJ1iH6OstpAuTxrn+ZUVrzxZ1NbTIfID4qXfrhKwQFqUOfPsBG
         cTNWtLtX/BWeUp8GudFrldD+U9eoWAMfgPCjV/vKw2cLtzRQJA5BiMEISOQOS2Uc37xh
         82nLLr9Qc1/IZZ5NWh5ZXdcHF2vXW0PgtNwbYUrNB1wdx6GhhJyvHM9pH9cU6n5UOBnx
         mGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757701576; x=1758306376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKFb5pK6LBMnwNIEUNk1oWRfSvMliaFa07yY/AYfkJg=;
        b=bs+dYjJLFMIb8mAOa2l9zSfvyDPe25oJ9vUxDq2MwsJ1dJGRMcN+WiJs9RJ1+10SXh
         CIEPLz5c+68K72vDrLK1mu+f98a4wNUzNCIf8lOsw+8QlO6P6BChVrPBHrlwk0D2HH9E
         rwhpax+DMKFtn9GGa8dFLDAahqwxMrxfizxdUWCMDX++N6A4Ouug5iS4Hut9SNlMoMG5
         UlJI8wiv/5gMeoU3kIhNerxngbFfE3/KV8O/+hupFaO3TDkwg9N8A3z/TgVi1RSbq9yy
         W6mU0uBaenCOpPHIrUJyp00CdMNAX+PxM+k13iGQi3vN/a2bXKBNZbNNB5o0XGt7y+Ie
         kVVg==
X-Gm-Message-State: AOJu0Yw/HTYzgfkhBIbF9qYowWb8lUpbn/YRUPKRCxrePygHg00dSX7W
	CF5bJj8apBc/iiT05s33GAkz6v/DdZ/D3Gh1bx5zUxZXG9Et6Fy1NArDPaXsdkg1qrb+wUbVyvd
	mnjNwcpzN8iZswPoAubj4UKjagtwaSzs=
X-Gm-Gg: ASbGncu86PEYgT/Fe6FBzQBrUHm0Avyb24pqJrqX3eJgX+L3czdtTI1kxN981PSoDZE
	1p5BaGyB4Q2qLkpD53Iu9FEiC49Kf/42j0aZxIeWDwsji2ljLIEfSwGAAUrP/CG7uEAoXzryPym
	HOSnz9hSukvo9TxSJp8ecQPv4Zu7Ay49IxYRYPUFEb164jvSyJUZxZLAWM6KUjkd5aY3exPx6V0
	PLdDUKBZ9Udcd3gxjszSmmrJj+ZFOThzkEC4su/EVC+RdOAp3PVeH4tT+eXJcc=
X-Google-Smtp-Source: AGHT+IGBTpc6dSAT6s2MGle0RTU6oF2r6O6jqessjytIks27fRnfQqsU5TzmRI45vgjnwVdO5wsNKpiSWdv0394qI2k=
X-Received: by 2002:a17:907:968a:b0:b04:a289:7b with SMTP id
 a640c23a62f3a-b07c347f8cemr388875366b.4.1757701576006; Fri, 12 Sep 2025
 11:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
 <20250824-b4-pks-history-builtin-v2-15-964ac12f65bd@pks.im>
 <CALnO6CBRv-Jvm1FsUAkDSyaNNRXtMukReKzefvCw5-vj=-pnCA@mail.gmail.com>
 <aLgygyUuQCmR25qU@pks.im> <CALnO6CAjv0=99AcBLU=z71hGrk0fXp9pWm7wiBF-a1Xd_efrdA@mail.gmail.com>
 <aLmMycWf-SMBw2bX@pks.im>
In-Reply-To: <aLmMycWf-SMBw2bX@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 12 Sep 2025 14:26:04 -0400
X-Gm-Features: AS18NWCv7BnDuHI0of5be6PAVVaZn6_LmladwoZLc8AyzPg3Iu3tVLffI_3dG1M
Message-ID: <CALnO6CCG=8JeRxgVfM9ayaQ6oY1iZQe3277sh=FG2YRkbbUj=g@mail.gmail.com>
Subject: Re: [PATCH RFC v2 15/16] builtin/history: implement "split" subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 8:57=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Wed, Sep 03, 2025 at 05:55:28PM -0400, D. Ben Knoble wrote:
> > On Wed, Sep 3, 2025 at 8:20=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
> > >
> > > On Tue, Aug 26, 2025 at 09:14:49AM -0400, D. Ben Knoble wrote:
> > > > On Sun, Aug 24, 2025 at 1:44=E2=80=AFPM Patrick Steinhardt <ps@pks.=
im> wrote:
> > > > > diff --git a/builtin/history.c b/builtin/history.c
> > > > > index 16b516856e..6d3f44152c 100644
> > > > > --- a/builtin/history.c
> > > > > +++ b/builtin/history.c
> > > > > @@ -517,6 +527,285 @@ static int cmd_history_reorder(int argc,
> > > [snip]
> > > > > +               wt_status_collect_changes_trees(&s, old_tree, new=
_tree);
> > > > > +               wt_status_print(&s);
> > > > > +               wt_status_collect_free_buffers(&s);
> > > > > +               string_list_clear_func(&s.change, change_data_fre=
e);
> > > >
> > > > I think I'm supposed to see the changes between the old and new tre=
es,
> > > > right? Does this only happen if I use the interactive machinery to
> > > > edit a hunk? When I try accepting some changes and leaving others f=
or
> > > > the next commit I get no diff in the template.
> > >
> > > Yeah, it's supposed to show the diff between old and new tree indeed.=
 So
> > > in theory you should see something.
> > >
> > > > I did try to add new diff lines to a hunk, and nothing showed up=E2=
=80=A6
> > > > maybe I'm holding it wrong? I'm pretty sure I compiled this version=
.
> > >
> > > Do you maybe have a reproducer for this? It seems to work alright for
> > > me, but I wouldn't be surprised if there was a bug here. The wt-statu=
s
> > > interfaces are quite something and I was tearing my hair while trying=
 to
> > > figure them out.
> >
> > Hm. I have a copy of these patches at
> > https://github.com/benknoble/git/tree/ps-jj. After "make DEVELOPER=3D1
> > -j $(nproc)" on that branch, I did
> >
> >     bin-wrappers/git history split @~3
> >     <input y,q> # once I even used "e" and added new diffs to the patch
> >     <type commit message> # no status info
> >     <exit editor>
> >
> > Then it looks like the 2nd commit gets created automatically. Maybe
> > I'm just missing how this should work? Thanks for looking at it.
>
> Weird. I used the exact same branch, command and input and did have
> status information in my editor.

Hm. I've pulled down v3, built it, and pushed to the same branch. The
tip is e91e23546b (builtin/history: implement "reword" subcommand,
2025-09-04).

Now, a heavier-handed recipe:

    GIT_CONFIG_NOSYSTEM=3D1 GIT_CONFIG_GLOBAL=3D/dev/null bin-wrappers/git
-c commit.verbose=3Dtrue history split @~5
    <input y,q> # once I even used "e" and added new diffs to the patch

I see the usual instructions:

# Please enter the commit message for the split-out changes. Lines starting
# with '#' will be kept; you may remove them yourself if you want to.
# Modifications qui seront valid=C3=A9es :
# modifi=C3=A9 :         add-patch.c
#

And finally I might know what happened, ha=E2=80=A6 if the "modified files"=
 is
the status information, then it has been there all along! Meanwhile, I
was expecting a _diff_.

I'm actually _still_ expecting a diff with v3 and commit.verbose set,
but I apologize if I've led you down a wild goose chase for the rest
:)

> Note that for now the editor only asks
> for the commit message of the first commit. The second commit is
> basically retained from the original: both tree and commit message are
> the exact same, only difference is its parent.

Sensible, though I might agree that the 2nd message should be edited
(mentioned elsewhere).

--=20
D. Ben Knoble
