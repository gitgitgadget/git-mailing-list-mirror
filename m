Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012A6C433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC8CA20780
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkwabsFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732725AbgFWRIo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgFWRIo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 13:08:44 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1FDC061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:08:43 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id p82so8703839oif.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RlVA3PBJJVBj4kz8zG3VxgGcVtDBZYSsIEDe+ImVfvY=;
        b=EkwabsFQq83riuCYBVeP60ICgqBvuBL/5V4f22TQq0QwPibGzqucSnVVh9ee3IjwMv
         02ymPcVKlFrquM2roT2z63OZfCAHHBDzj7znJxj/7ZSzRIugHN9lcI2etUnp47YD8vQ4
         TDZqMGhBWqQa7Mja5vzqWr1h85Qfc5AvKhclXTx0y0i95Ja3piZzeZ22Dsf/iYN7BZr1
         ydqgKV78KSYTuB/WyN1EOk280pPQXnmFvQ8uAHspIdjB6llA57ceNRdSg3xUH2GlGfU5
         fOH04bgqIw6H3Z1B6/xqY0J2M3obfZ+Fio15F4/uRK9jAixdhTM3c/ATGShdJbGVEWbo
         tYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RlVA3PBJJVBj4kz8zG3VxgGcVtDBZYSsIEDe+ImVfvY=;
        b=Q0N+uEaBrKRPihpQX0ffFpA7NJKj+oORHQOyvswzbDbYea33rSkXQ2sFdhwS6NoV5N
         w/+BdFDk55uY5Y9WqWLA4EDrSStw6rS/aRVrBe6fkvUKcAJhK9SZBih0mNsIgPB8DLU0
         VunsYVwSoH7zF/AV09FowmEc3aS+iWhqva2aDvRKWQ4220c+f5qh/ry/YGwHRZ5A1N9g
         D9Kw8UPraiV9U5uXBdqHQHrelUS7GoLBPWesMLSxd70RO9RAEecuFkdEnpvPvcR4yPyW
         gWIE7p65Z/QuMT/aGU6koBwGUkDgWRNxSe/b3A3AXPNAipvEndB5fHXrhaqWIpeMORVQ
         U3Bg==
X-Gm-Message-State: AOAM530xiK6d2B4xtDQ6je/6zPEfbgt5uC6jaxjwbthnV+WrVSCHs6Yu
        A+AU/6bSuLYO75gwL/Okl9Fg2chkLp95IEJDc+U=
X-Google-Smtp-Source: ABdhPJycKFXiPN1NzePDal4xQgU113Jw9Nn/MHOEnAtBFpNCVp1CZ8tOv6fRxz9sLyo9yk+y/mx8Ufn2F7Iv8I7t4FQ=
X-Received: by 2002:aca:6287:: with SMTP id w129mr17737128oib.167.1592932122231;
 Tue, 23 Jun 2020 10:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR11MB27958B80E3994CEEF13971ECE5990@DM6PR11MB2795.namprd11.prod.outlook.com>
 <20200622194122.GN6531@camp.crustytoothpaste.net> <871rm6x86y.fsf@osv.gnss.ru>
In-Reply-To: <871rm6x86y.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Jun 2020 10:08:30 -0700
Message-ID: <CABPp-BHa=jppGtoDiTz_NCXrd2zhTfALb_UrQjcF-VDcv+vuNA@mail.gmail.com>
Subject: Re: Request for adding a simple mechanism to exclude files from Git
 merge operation
To:     Sergey Organov <sorganov@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tiran Meltser <Tiran.Meltser@mavenir.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Amir Yosef <Amir.Yosef@mavenir.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 23, 2020 at 5:47 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> > On 2020-06-20 at 18:21:40, Tiran Meltser wrote:
> >> Hi,
> >> This topic is quite common in various use cases (e.g. production
> >> configuration vs. staging one) and there are quite a few talks about
> >> it in the web.
> >> Nevertheless, there is no specific solution to this problem, only
> >> partial workarounds (including the famous merge driver =E2=80=9Cours=
=E2=80=9D).
> >
> > In general, this is a hard problem.  When you perform a merge, you're
> > asking to incorporate changes from both heads against a common merge
> > base.  What does it mean when you want to merge two branches together
> > but not make any changes?  Which version do you want, ours or theirs?
>
> I believe we basically need support to apply different merge strategies
> to different files.
>
> I had similar problem a few times when I merged a long-standing branch
> and, after I saw the result of merge, I was basically satisfied, except
> I needed to revert a few sub-directories of the project (that gave huge
> number of conflicts), to their original state, either of my current
> branch, or of the branch being merged, depending on particular case. You
> see, I knew exactly what I needed, yet I was not able to achieve my goal
> without resorting to nasty kludges.
>
> > Normally merges are symmetric, so if you want non-symmetric behavior,
> > you have to define what it's supposed to be.
>
> Yes, I'm ready to define what it's supposed to be. The problem is that
> "git merge" won't let me, due to lack of support to apply different
> merge strategies to different files.
>
> As I see it, first step of improvements could be to support
>
>   git merge -- <files>
>
> where selected strategy applies only to <files>, and the rest of files
> are kept intact (effectively applying "ours" strategy to them), along
> with
>
>   git merge --exclude=3D<files>
>
> , to be able to exclude specific files (apply "ours" only to them)
> rather than include.
>
> [ As a side-note, please notice that after such changes, the "ours"
> strategy could be deprecated (not that I think it should), as either:
>
>    git merge <branch> --
>
> or
>
>    git merge --exclude=3D. <branch>
>
> would do the trick. ]
>
> The next step would then be to support
>
>   git merge --force -- <files>
>
> that would force to re-merge <files> with given strategy no matter what
> their current status in the index is.
>
> Even though such support would be enough for my specific use-case, it
> doesn't provide suitable way to configure the default behavior. As a
> more generic solution, a new syntax for "git merge" to specify what
> merge strategy to apply to what files could be designed, and then
> ability to put that syntax into a file for "git merge" to pick would
> solve the problem of quasi-static configuration problem. Alternatively,
> even more generic .gitignore way of doing things apparently could be
> re-used to some degree by adding support for .gitmerge files.

I think you'd have an uphill battle to convince me that this isn't
net-negative value:
  * You can just do "git merge --no-commit ...; git restore
[--source=3D<side>] -- <pathspec>" to do what you're talking about
above.  I don't see the need to add extra functionality to merge,
especially not functionality that duplicates restore's functionality.
  * The "ours" vs. "theirs" wording means you're going to have
intrinsic problems with rebases.  Several users will like your choice
of what "ours" means, the other half will complain that you've got it
all wrong.  I think you need to let the users decide on a case-by-case
basis, and we have a handy "git restore" command for letting them do
that already.
  * The pathspec limiting is going to be a bug factory for renaming
handling.  (The simplest form of which is just renaming a special path
to a non-special path or vice-versa and modifying both sides of
history.)  Rename handling can already get some pretty hairy corner
cases without dumping more in the mix.  I'd rather have users decide
what to do with paths that switched from being one of the special
"ours" paths to being a normal 3-way-conflict marker path.  Luckily,
we already have a command that users can use to do this: git restore.
  * I've run into "branch-specific" files in the wild and even
supported repositories that used them for years.  In my opinion, they
are almost always nasty code smells that are artifacts from
CVS/SVN-like thinking.  Although I wanted to stamp them out
immediately, there was opposition to it.  However, over time, people
removed those branch-specific files from the repository (and it wasn't
just by me or at my prodding either; many were cleaned away by others
without my involvement as other folks just found better ways to handle
things over time).  Giving special support to bad practices will just
enshrine them, which I'd rather avoid.

If someone wants to spend their time here, I can't stop them.  Just be
aware that personally, I think it'd be a bad idea to make any
merge-recursive or merge-ort changes to support this kind of thing.
(Alternatively, if you're still convinced this is a good idea, you can
consider this email a heads up about potential problem areas that you
need to address and areas where you'll need to craft some good
arguments to win over those who are skeptical.)

Hope that helps,
Elijah
