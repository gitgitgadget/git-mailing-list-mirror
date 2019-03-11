Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4416C20248
	for <e@80x24.org>; Mon, 11 Mar 2019 11:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfCKLrt (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 07:47:49 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:56215 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCKLrt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 07:47:49 -0400
Received: by mail-it1-f194.google.com with SMTP id z131so6702282itf.5
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 04:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ntP4vSdZDazK7V4jPTWwDEcaSiuM7CywRdjZ4r3/8T0=;
        b=lXpBaKbQAxiZzy4TjFEZX/WDFONUwSNDEG6orCEByZs74BkUZv3iqCc/JfCGNHFEOB
         dJfAHv/CR1HdkSFLEfNxS9x/PAOsG3WmB2z1mMwSbVTuFU3sXvv7mVqSjuCykctu2roV
         LP6AO53x3y1HA4EeHtEwAa7RFqKn7rUyC9Ek4YZNjKIIB8ib853dbuFM+XXJm6eL4xUH
         Frue9HtvMyteBbHBNqdHr5ar1clARhmWYAbouaLokFnsN5wIs2nFC0wpdCVGUMu7qb2Z
         Xyx9snWAq85UPnP369259oxdiN3CQ89PtlGOqVacS16eRGEu5nFsZ4+yiUfrHQAd/BwK
         zNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ntP4vSdZDazK7V4jPTWwDEcaSiuM7CywRdjZ4r3/8T0=;
        b=OBQKd++QABEJ1pVA5PKLhd9Rg59KnVibjv28kyrLyeBDJnSLQlLwZDdrKB463jYOO3
         VETXFZI/bVtDN7WyZjFWhYFcO+ik6MsXMWixSOAeBz3zRPLXCpPYRaWK3vyGhtCA2dJj
         zogkthVnTK4OyqWPMZIodNdQEixAweG1aPEHBgLS6Eb5jTW/IKzzCRkFKT3rObqLPpQa
         +2ZaHmLf/3OamBP0G9Zn70nm4s6yOhZE6YTCKQmMGYZ9F1XUGFmNjN+Gz/OvxkNR5cbl
         xoVi5FSQ7XVvyf3jOaBuxmYaxAVBysDgeqnCYtAaPIsxsN671Hhk1j5cuZlaFCzRsDmT
         PohA==
X-Gm-Message-State: APjAAAVBTyDR5DI1U3L9nqruLDTTbu7ZtmTMRcVvE86Ls3oFuksrwvdO
        GGUS10ouBBn1sFxDVN9nylT3MjK/92CydT20EOA=
X-Google-Smtp-Source: APXvYqyk8pwDsJjSj0MYo+5Nlt60jRPsFgrh1xHtfmsY6a4t/+cKCvBaxLjb678K78hrhuNcROtvJKDl74zLbPFukvc=
X-Received: by 2002:a24:7542:: with SMTP id y63mr15562667itc.70.1552304868201;
 Mon, 11 Mar 2019 04:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
In-Reply-To: <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 11 Mar 2019 18:47:22 +0700
Message-ID: <CACsJy8DrrEg++wUszU2B1zJ_gvO1WC8MXXa53ZpMnObgqy=AeQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 6:16 PM Phillip Wood <phillip.wood123@gmail.com> wr=
ote:
>
>
> Hi Duy
>
> On 08/03/2019 09:57, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> > "git checkout" doing too many things is a source of confusion for many
> > users (and it even bites old timers sometimes). To remedy that, the
> > command will be split into two new ones: switch and
> > something-to-checkout-paths.
>
> I think this is a good idea, thanks for working on it. I wonder if it
> would be a good idea to have the new command refuse to checkout a new
> branch if there is a cherry-pick/revert/merge/rebase in progress (with
> an option to override the check) as switching branches in the middle of
> one of those is likely to be confusing to users (if I do it it is
> normally because I've forgotten that I've not run 'git whatever
> --continue').

Interesting. I think this would be a good default if we have an escape
hatch (which could even come later). I often wander off to some other
branch and go back. But then half the time I end up forgetting I'm in
a middle of something and just "git rebase --quit" :P

Of course with git-stash (*) and git-worktree, I guess there's little
reason to just switch away from a something-in-progress worktree. I'll
try to implement this in the next round, unless someone objects.

(*) I hope git-stash remembers and restores "something-in-progress"
status. Dunno. Never used it much.

> > +-C <new-branch>::
> > +--force-create <new-branch>::
> > +     Similar to `--create` except that if `<new-branch>` already
> > +     exists, it will be reset to `<start-point>`. This is a
> > +     convenient shortcut for:
>
> If we're renaming the options to be more meaningful then maybe we should
> consider a different name for this one - it has nothing to do with
> creating a branch. Maybe --reset or --update?

-C can also create a new branch like -c though. --reset or --update
does not convey that (and --update sounds a bit too safe). Another
option is --recreate.

> > +-f::
> > +--force::
> > +     Proceed even if the index or the working tree differs from
> > +     HEAD. Both the index and working tree are restored to match
> > +     the switching target. This is used to throw away local
> > +     changes.
>
> I'd always thought that --force meant "throw away my local changes if
> they conflict with the new branch" not "throw them away regardless"
> (which is better as it is deterministic). Maybe we can come up with a
> clearer name here --discard-changes? At the moment --force does not
> throw away conflicts properly (see the script below in my comments about
> --merge).

Yeah if you want to redefine --force, now is a very good time.
Personally I'd rather have separate options than the "one catch all"
--force (or worse, multiple of --force). I'll leave this for the
community to decide.

Adding Elijah too. He also had some concern about "git restore
--force". Maybe he's interested in this as well.
--=20
Duy
