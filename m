Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60ACC433E1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 21:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C394B619D6
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 21:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhC3Vbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 17:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbhC3VbI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 17:31:08 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAEBC061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 14:31:07 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id i25-20020a4aa1190000b02901bbd9429832so4115512ool.0
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 14:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GXhor/Fvt5I8acqjqE3HS6LV+I9iQpVih/46KgC22Iw=;
        b=rGWIke/EiYFsyFrS4eJ0VkLghE/QzA3d8AlvHNgXIf429jJijhwt0ekLhbUG8pzxxA
         7wAwv/Y2eLKpOercsQ9PHiq6+5fTt+rz7L1tlIVf8T6gelgUHInHRAjZY9nmq+h4Kr9J
         AbvJ4gErorN/Ou/N0oMbXdM9Bc/fLE2KLEIvhHuwPlZgm8UVExTThGC17o+U8DIqsN7R
         UQF7kPz4WYQtlTPnkTVK0+LZQeFkh/F/y7Hsa1QTl0ExMZ6Mf8zKo1sehGjQSSCz9KAW
         GTKbYa24tq5vjehW2DQ9ObZVMWIH4KKoEf8h/G/uN2sy5PId019kcYqSJClnPNEWnLA+
         MtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GXhor/Fvt5I8acqjqE3HS6LV+I9iQpVih/46KgC22Iw=;
        b=p/cYKr9pXY3ETCp/o+nyUjjl1fMrWjOevmmp/BU8AvAtCPfhCb2DaISpvSqQh5jRUd
         BAvjuqgbe6h5KUGXkqnWBzP/HAPDvHfHQSVc71nSL93ksAiouGoEQsgrSwXqAD/xuqxM
         MYfaPCMlbL+z8WDzzu8VhZCNZS6QsTGfOxrjUZ578u2AAAA4JxS1eP9EK32cZOiMxigj
         WJcIru6MZWfQS0/kzHRrD2EK2WDP9ZVkyiHvdsgA9e66PBlJBdcIzp51JVyGfqetZtud
         UbnNHBab7uPx0mAm36ZeBMUvl5TkuassZbm+aP8Tcc1f9M7J6Ut3ka1qAkcNLSF1P0fZ
         WM6g==
X-Gm-Message-State: AOAM532NJb6ekiPOpgVxOQZQ40TzYbpyI/TNbhPBOt83FmoK0b+dtWAm
        TNwmUTwwre+hAYvT1PTuXr3QvBXs/Bi8lIW4cl2TTvSeL4SYPg==
X-Google-Smtp-Source: ABdhPJyWPOF5enLxadrTlfngRp+X5SQjapHdTnnnVioWaUIGcgQFVK30efiEsexemMD8rfyZtuQxvI/0KqcBdkAAdb8=
X-Received: by 2002:a4a:9101:: with SMTP id k1mr42606oog.7.1617139867207; Tue,
 30 Mar 2021 14:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BEAbN05+hCtK=xhGg5uZFqbUvH9hMcCNMcBWp5JWLqzPw@mail.gmail.com>
 <YGLNBFJv8NKmrbvz@coredump.intra.peff.net> <xmqq35wceae6.fsf@gitster.g> <CABPp-BEE0eksCJSAviDh5GyqsOu=i_mW3VY6SEULa4kx0NsUMg@mail.gmail.com>
In-Reply-To: <CABPp-BEE0eksCJSAviDh5GyqsOu=i_mW3VY6SEULa4kx0NsUMg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 30 Mar 2021 14:30:56 -0700
Message-ID: <CABPp-BFewHGOx-RCVtDKhn3=0QC9YWdA--Wtbb_MTHQbu3FQcw@mail.gmail.com>
Subject: Re: Bug report: git branch behaves as if --no-replace-objects is passed
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 30, 2021 at 2:19 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Mar 30, 2021 at 11:58 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Jeff King <peff@peff.net> writes:
> >
> > > ... though if we go that route, I suspect we ought to be adding both the
> > > original _and_ the replacement.
> >
> > So "branch --contains X" would ask "which of these branches reach X
> > or its replacement?" and "branch --no-contains X" would ask "which
> > of these do not reach X nor its replacement?" --- I guess the result
> > is still internally consistent (meaning: any and all branches fall
> > into either "--contains X" or "--no-contains X" camp).
>
> I'm not so sure about this interpretation.  Based on the documentation
> in git-replace(1):
>
>        Replacement references will be used by default by all Git commands
>        except those doing reachability traversal (prune, pack transfer and
>        fsck).
>
> I would have thought that
>
> * "branch --contains X" would ask "which of these branches reach X's
> replacement?"
> * "git --no-replace-objects branch --contains X" would ask "which of
> these branches reach X?"
>
> and if folks really wanted to check whether either X or its
> replacement were reachable then they'd need to run both commands.
>
> The only place outside of reachability traversal where I think it
> makes sense for a command to distinguish between X being a replace ref
> for Y and Y itself is in `git log` where it can show the "replaced"
> moniker.
>
> > > I'm not entirely sure this is a good direction, though.
> > >
> > >> and possibly worse, if I create a new branch based on it and use it:
> > >>
> > >>     $ git branch foobar deadbeefdeadbeefdeadbeefdeadbeefdeadbeef
> > >>     $ git checkout foobar
> > >>     $ echo stuff >empty
> > >>     $ git add empty
> > >>     $ git commit -m more
> > >>
> > >> then it's clear that branch created foobar pointing to the replaced
> > >> object rather than the replacement object -- despite the fact that the
> > >> replaced object doesn't even exist within this repo:
> > >>
> > >>     $ git cat-file -p HEAD
> > >>     tree 18108bae26dc91af2055bc66cc9fea278012dbd3
> > >>     parent deadbeefdeadbeefdeadbeefdeadbeefdeadbeef
> > >>     author Elijah Newren <newren@gmail.com> 1617083739 -0700
> > >>     committer Elijah Newren <newren@gmail.com> 1617083739 -0700
> > >>
> > >>     more
> > >
> > > Yeah, that's pretty horrible.
> >
> > I am not sure.  As you analize below, the replace mechanism is about
> > telling Git: when anybody refers to deadbeef, use its replacement if
> > defined instead.
> >
> > And one of the points in the mechanism is to allow to do so even
> > retroactively, so the HEAD object there may be referring to deadbeef
> > that may not exist does not matter, as long as the object that is to
> > replace deadbeef is available.  If not, that is a repository
> > corruption.  After all, the commit object you cat-file'ed may have
> > been created by somebody else in a separate repository that had
> > deadbeef before they were told by Elijah that the object is obsolete
> > and to be replaced by something else (Git supports distributed
> > development) and then pulled into Elijah's repository, and we should
> > be prepared to seeing "parent deadbeef" in such a commit.  As long as
> > replacement happens when accessing the contents, that would be OK.
> >
> > So, I do not see it as "pretty horrible", but I may be missing
> > something.
>
> I think you're focusing on git commit, or perhaps on git checkout.
> I'm focusing on git branch; what it did does not seem fine to me.
> Using your own words:
>
> "the replace mechanism is about telling Git: when anybody refers to
> deadbeef, use its replacement if defined instead."
>
> git branch didn't do that; it put deadbeef into refs/heads/foobar.

Perhaps I should also add why it not only breaks expectations, but why
that broken expectation causes problems:

* People tend to have commit hashes stored in lots of weird placed --
bug trackers, reports, emails, etc.  These tend to be important for a
short time period, but the number of these references make it harder
for folks who want to rewrite history to fix various past issues (very
large binary blobs and other misdeeds).

* filter-repo uses replace refs to provide users with a way to access
new commits using old commit hashes, to help them through this
transition period.

* Additional refs (especially one for every commit) will cause some
slowness.  So it's nice to be able to provide these replace refs for
short term transition, but tell users they can simply delete the
replace refs when they no longer need them without consequence.


The fact that git branch puts deadbeef into refs/heads/foobar, leads
to a chain where new commits now rely on replacement refs.  In the
best case, others will not be able to pull from this user and the user
will not be able to push the new commits anywhere -- and that user
will have some work to do to rewrite (rebase?) the commits
appropriately.  In the worst case, the users do succeed in
distributing this new history, and now all users everywhere will be
mandated to keep all replace refs for all time (or at least until the
next major repository rewrite)...
