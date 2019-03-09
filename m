Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6251720248
	for <e@80x24.org>; Sat,  9 Mar 2019 12:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfCIMQ2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 07:16:28 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39303 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfCIMQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 07:16:27 -0500
Received: by mail-it1-f193.google.com with SMTP id l15so388030iti.4
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 04:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A/dc3l2DquH4UJJzKS40WFyL4ZOKZzPXAKi8qlhjH30=;
        b=RjuJ5gyLjaUOHVfx0eAs0pXJdCr8+6tdrxMtouYtSTdejkvALJ7wi6GX890UBhDlNt
         tBDcKQTwf9n47aviNCHfWDzazBST83FyMrJp/W7daY/XIR5oN60MHU8OGZRvPLD+LaTL
         45VeYXTAAgItLmvHKkGnQodVFixasNRiPVuTZaiEzWqjzeybNar+7ufIdpqEBtUL8X6W
         Cj+TlC6F+mfHOQJCAJZL0jmu0240K2ocKzb2BkqGf/+afwGIGB9Zofx1Vgt9M4QKaXtW
         lmRCtXITvnlGBW8SGI41ByrXahwOm5hHhbk9CM+uhfMh2J6ubxnNchcwxrg9PhxwNzUS
         fNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A/dc3l2DquH4UJJzKS40WFyL4ZOKZzPXAKi8qlhjH30=;
        b=ZFvp+C9fheoSkaFCikCj6PNIoQgvWRez4/AXoyFyn3ix7tYgUR1WsgCJcWrFlIPNJ+
         L25+kFAfRhXVRusd6yfvIKQEjC5HXz8SGwz0gYW4N3kbmniYGWn9MqAilOWP2fdoeo2D
         u5cvk1cioUx1mYEUfgjfr3J+pfBujHyHp1eWBEcHIbOr3CTYYh8GywHLvNxhs2LD4cJX
         0qnlsRCF+WWk6eQta6KPlDbDs+jYpj5Isz7574hTIAlQC5nNTdrPWZQyhQ8jRB/bOCVW
         +rAkdu7iyci4nF33Zy+5FJFScZlNomOjB8sO/pSuuGhLvHtSdt9caw9W2HpU8CvXVka4
         hxZg==
X-Gm-Message-State: APjAAAWyjFtoSOSLfKmnv1IpaY7mfB/ATFz/wcFW1Dd7tlO+g8qoXLWg
        n9yzBKNIvFRVKtXxcggjT6jhiKqdOyZAY3qVTxw=
X-Google-Smtp-Source: APXvYqw5ft6nKIHO/HXJmGk9WYW+j3/0h781EoyAXYVjBu9x4YzwvsHcEvC0EHj3XpBUznXx988Al805f/8KxmND6po=
X-Received: by 2002:a24:3b0a:: with SMTP id c10mr9471325ita.10.1552133786555;
 Sat, 09 Mar 2019 04:16:26 -0800 (PST)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-2-pclouds@gmail.com>
 <CABPp-BFXZMorrHph3hGFnqfceHs68byWNgffNKGp1ov6X5-o5A@mail.gmail.com>
In-Reply-To: <CABPp-BFXZMorrHph3hGFnqfceHs68byWNgffNKGp1ov6X5-o5A@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 9 Mar 2019 19:16:00 +0700
Message-ID: <CACsJy8D4tvm_zLo0DcnjmcBeKDRDR+HGAxd1PsUMSBcgR59DPg@mail.gmail.com>
Subject: Re: [PATCH v1 01/11] checkout: split part of it to new command 'restore'
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 9, 2019 at 1:01 AM Elijah Newren <newren@gmail.com> wrote:
>
> Thanks for working on this; overall looks really good.  I've got a few
> comments here and there on the wording and combinations of options...
>
> On Fri, Mar 8, 2019 at 2:17 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> > +SYNOPSIS
>
> It might be worth adding some words somewhere to differentiate between
> `reset` and `restore`.  E.g.
>
> `git restore` modifies the working tree (and maybe index) to change
> file content to match some other (usually older) version, but does not
> update your branch.  `git reset` is about modifying which commit your
> branch points to, meaning possibly removing and/or adding many commits
> to your branch.
>
> It may also make sense to add whatever description you use to the reset m=
anpage.

Good point.

> > +--------
> > +[verse]
> > +'git restore' [<options>] [--source=3D<revision>] <pathspec>...
> > +'git restore' (-p|--patch) [--source=3D<revision>] [<pathspec>...]
>
> So one cannot specify any special options with -p?  Does that mean one
> cannot use it with --index (i.e. this command cannot replace 'git
> reset -p')?  Or is this an oversight in the synopsis?

Oversight. -p can be used with either --index or --worktree or both.

> > +
> > +When a `<revision>` is given, the paths that match the `<pathspec>` ar=
e
> > +updated both in the index and in the working tree.
>
> I thought the default was --worktree.  Is this sentence from an older
> version of your patch series that you forgot to update?

Oops.

> > +-q::
> > +--quiet::
> > +       Quiet, suppress feedback messages.
> > +
> > +--progress::
> > +--no-progress::
> > +       Progress status is reported on the standard error stream
> > +       by default when it is attached to a terminal, unless `--quiet`
> > +       is specified. This flag enables progress reporting even if not
> > +       attached to a terminal, regardless of `--quiet`.
>
> I'm assuming this means there are feedback messages other than
> progress feedback?

There could be. This is carried over from git-checkout. I suspect this
is about warnings that we print from time to time.

> > +-f::
> > +--force::
> > +       If `--source` is not specified, unmerged entries are left alone
> > +       and will not fail the operation. Unmerged entries are always
> > +       replaced if `--source` is specified, regardless of `--force`.
>
> This may be slightly confusing, in particular it suggests that --index
> (or --worktree and --index) are the default.  Is --force only useful
> when --index is specified?  If it has utility with --worktree only,
> what does it do?

Well, this is 'git checkout -f' behavior which only concerns the
index. So yeah it only matters with --index.

> Also, what happens when there are unmerged entries
> in the index and someone tries to restore just working tree files --
> are the ones corresponding to unmerged entries skipped (if so,
> silently or with warnings printed for the user?), or does something
> else happen?

If -m is also specified, then we recreate the conflict. The from code,
if an unmerged path is skipped, there will be warnings.

> > +
> > +-m::
> > +--merge::
> > +       Recreate the conflicted merge in the specified paths.
> > +
> > +--conflict=3D<style>::
> > +       The same as `--merge` option above, but changes the way the
> > +       conflicting hunks are presented, overriding the merge.conflictS=
tyle
> > +       configuration variable.  Possible values are "merge" (default)
> > +       and "diff3" (in addition to what is shown by "merge" style,
> > +       shows the original contents).
>
> Should you mention that these are incompatible with --source and
> --index?  And perhaps also make sure the code aborts if either of
> these options are combined with either of those?

I will make sure that the code aborts. Not so sure about mentionging
every incompatible combination though. Will it be too much? I think we
catch and report plenty invalid combinations but I don't think we have
mentioned them all (or maybe we have, I didn't check the document
again)

> > +       Just like linkgit:git-submodule[1], this will detach the
> > +       submodules HEAD.
> > +
> > +--overlay::
> > +--no-overlay::
> > +       In overlay mode, `git checkout` never removes files from the
>
> Why are you talking about `git checkout` here?  Shouldn't this be `git re=
store`?

Oops.
--=20
Duy
