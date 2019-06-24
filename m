Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DCEE1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 14:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfFXOzp (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 10:55:45 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46451 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfFXOzp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 10:55:45 -0400
Received: by mail-io1-f66.google.com with SMTP id i10so696011iol.13
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 07:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k0c2vCemgqvN5geezqSNJedg82lj+0oRtJ48INqHNec=;
        b=R7W7hBNm80vv6jCSMDe6XwHUeB736MLNzPz58SmTOQN9y3Ts93vS28H7+I+Yhaocp+
         Z4aGHA37xNZxBnEJ8YjbRM6EaIkjF0cxXu2qV4xuvYSNcGGWDs4nF+hVmNBuZinlIbCC
         tLRR0XrauuXxuPBqS/gKnkOU0zBvFw3VVeOmAUfT1kAJ51FW5MogFEeydtomudzlvOFE
         gVAXgFhUaFaESKr/10yns+ouIuneWOHnJwk1mz1ajKFjktjsL83i5Li3/j2mCtHsepU2
         7HmWKEhIqh9vOPMmE5gruC/wssTnV7E4sy7FgFYfqG5N49uKXt7JGEk+aGT//Byrt9j0
         T0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k0c2vCemgqvN5geezqSNJedg82lj+0oRtJ48INqHNec=;
        b=Oxdv4Hnq0oTV/tZL640jmih+f5e6uJAQ0pQgPVS7TXWQoVzAl2vnDkA6EO88GaDxqr
         qb3+EKZSpGlBJyVXz8Z4YqIvoZzGtdNnEkPoiZt3i+s3eWk6n6RxpvnKaBxCPu4Yhfgm
         hPqvdEDiP7kH/oyae3ayj71U13sT6nIvFymX73NKf1IHJM6fpFwAtNnb6e0rnCJMW8dM
         S9pDbQBku4XHEwNDXQpYGe75CbPshEkvaNwTPTeK5uwA2MFyh9AWFgmU08+KOlW28aRF
         NdriQ4JuBqvWiSb1k2urVmPBiwd5KGEfnbqpI19nzB69NGAmM5T27de1hCjSMuNO1NEA
         2AhA==
X-Gm-Message-State: APjAAAVdb85WO1jVvbTScAtI5vuVdX/FpcIPayNrdyut38rwcni+SLCU
        yLeBAgbsW9yPLI51mpM0U4/QTcUpoiEkuUc1K0s=
X-Google-Smtp-Source: APXvYqyUbZ/9hHVcar+/6AL9Svani7yfZR94bKHUvnuVTbx6PU+oPzcYuFjwmH1IEJWFfXZG1l9CMcQ1f+8STFKtSGc=
X-Received: by 2002:a6b:f711:: with SMTP id k17mr2934395iog.273.1561388144829;
 Mon, 24 Jun 2019 07:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190624095533.22162-1-pclouds@gmail.com> <20190624095533.22162-4-pclouds@gmail.com>
 <0f13008e-bdf1-70cb-c4ff-e4c572cd5703@gmail.com>
In-Reply-To: <0f13008e-bdf1-70cb-c4ff-e4c572cd5703@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 24 Jun 2019 21:55:18 +0700
Message-ID: <CACsJy8CaUHTfUS9tMDTNC+S10Bpqz_-rujR6Jr0689AJHpf=UQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] tree-walk.c: remove the_repo from get_tree_entry()
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 24, 2019 at 9:20 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/24/2019 5:55 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> > ---
> >  archive.c              |  4 +++-
> >  blame.c                |  4 ++--
> >  builtin/rm.c           |  2 +-
> >  builtin/update-index.c |  2 +-
> >  line-log.c             |  7 ++++---
> >  match-trees.c          |  6 +++---
> >  merge-recursive.c      |  8 +++++---
> >  notes.c                |  2 +-
> >  sha1-name.c            |  9 +++++----
> >  tree-walk.c            | 18 ++++++++++++------
> >  tree-walk.h            |  2 +-
> >  11 files changed, 38 insertions(+), 26 deletions(-)
> >
> > diff --git a/archive.c b/archive.c
> > index 53141c1f0e..a8da0fcc4f 100644
> > --- a/archive.c
> > +++ b/archive.c
> > @@ -418,7 +418,9 @@ static void parse_treeish_arg(const char **argv,
> >               unsigned short mode;
> >               int err;
> >
> > -             err =3D get_tree_entry(&tree->object.oid, prefix, &tree_o=
id,
> > +             err =3D get_tree_entry(ar_args->repo,
>
> If I'm reading this correctly, this is a place where we previously conver=
ted
> to using a custom repository pointer but this function boundary reverted =
us
> to the_repository anyway. I know we have some tests around the commit-gra=
ph
> that ensures it works with an arbitrary repository (and I frequently stum=
ble
> over them when I add new dependencies). How can we add more testing aroun=
d
> these new conversions?

Right now it's really patchy. There's no guarantee that the_repo is
not used somwhere in the callchain (or will not be in the future). My
main aim is _not_ break it when used with the_repo. These new
conversions hopefully will get more used outside the default the_repo
setting (e.g. new developments in git-submodule, or git-worktree).
Eventually the_repo should be gone (or referenced in very few places),
then the conversion will get more coverage. Really mixing repos though
will not be as well tested until actually used (by submodule and
friends).
--=20
Duy
