Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AA6C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 20:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65D7621582
	for <git@archiver.kernel.org>; Mon,  4 May 2020 20:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSuqqlpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgEDUEN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 16:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgEDUEN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 16:04:13 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ED6C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 13:04:12 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id v192so124654vkd.3
        for <git@vger.kernel.org>; Mon, 04 May 2020 13:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JStnEQLtn2lqA1wD9rr2/0OIUaIxS8u3TBZd26gEELI=;
        b=pSuqqlpAnBtUyLGzyuiCNcklUNTI8OJfWrWHbpRq99GFmaIi99S80rJEuYxzPRYJyY
         /7BMYwvAxsvbh8LR1u97EzSiojjQupbmMGpQOz3ts2a6569g643o0kO2/Pxnd8/hxcS9
         9f1Br3db/cIMvf1TmMlJS0zb6WxHWVw1ymMo9pJoZLl+tjbThho1kS44xx5Uq7NmZCdt
         e9AZazP416pkPrWVDUWHL7qb0ytpQlrrkhVEycFXXwcNwTZqQkr3NToBTp13nSapSPNM
         1kwwANOOmaiB2NEu8rjcLiPrLVPn7O6Q89a5XBvO2WKpuo6cw4EQqK9ezwMF4Ejwyq2/
         aEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JStnEQLtn2lqA1wD9rr2/0OIUaIxS8u3TBZd26gEELI=;
        b=chRIYHTNi7pxa4N9s6MIpmcIvE21go3OADQBfTy0uzY4faicENsn2fBJWZOHd6YUWh
         5H84KiqZYo1YLnfU+A54LRLdLOhpbefX2ODO+TsHTDFt291VwLhkwZ0hhyfLhiPImpsI
         LO35383a1tm8gtRNMN4pfmKaZ0WoZ0d5/DzFxce913zcPDYjGKGvBeWgqX++nAYVwfdL
         BsE1aK1X9A8VkLAxXm7/BMFvYZX9QsufgiwjJIMqUUETsDYompYkhONTNYqYDlqecYGR
         Fn9RKDmGmk5KSpi2pkotaRNN90NzbwEiisBEJ70duejmod2/zy00Gglh7WCXwO5gO3b8
         wGfA==
X-Gm-Message-State: AGi0PuZ5QBkNCsAdQqYcBMzdgrFJRDwPgNjWVs0HfVtvrlQGd7GJL6iC
        cfPI9IVsVr6F2bIDuXRm5+9lG7yYr46JmdyPrA==
X-Google-Smtp-Source: APiQypLtqH/HTxjilPZxUFxy/BXWrCnL2uKf7x+O9ugIcxx/+b3npXJX8XylVPmF9oa3kUVCNKgcpBEZ2AuW0Z6PGJk=
X-Received: by 2002:a1f:2010:: with SMTP id g16mr1010740vkg.50.1588622651870;
 Mon, 04 May 2020 13:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAEoQP9iY-0+=ETA0vrHL0HngccwtNA_3KX4WSSokJpOgJDGUeA@mail.gmail.com>
 <20200504055530.GA13290@konoha> <CAEoQP9hyMi=oj18atTJo+dR3ve_zzrLQoOja0CKAAVHei6rA0g@mail.gmail.com>
 <20200504120024.GA3372@konoha> <CAEoQP9gs-a1NanNpYiFQgTs0C+CeYhbD8rMjoFVat1ZSijNA2A@mail.gmail.com>
 <874ksvei1r.fsf@osv.gnss.ru> <CAEoQP9guAWg8E95Pi4MOih7z5rPg7OCB+_jZ6EMhJxpFsM3A1A@mail.gmail.com>
 <87o8r3cwcn.fsf@osv.gnss.ru>
In-Reply-To: <87o8r3cwcn.fsf@osv.gnss.ru>
From:   =?UTF-8?B?RXdhIMWabGl3acWEc2th?= <kreska07@gmail.com>
Date:   Mon, 4 May 2020 22:04:00 +0200
Message-ID: <CAEoQP9ic7yU01JWkjiNT40gtq0WyUW7sBAJPRRdBRw93dhRw9w@mail.gmail.com>
Subject: Re: file is showing as modified even that it was never commited
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I don't know why would something be broken in my repo. As I wrote, I
simply clone it (empty) from bitbucket and than started adding code,
really nothing extraordinary.

"Is it the .gitignore that tells git to ignore all files in
.idea/?" - no, it contains some default-ignored by idea files.
The one that I'm using (or at least intended to) is on the main level.

This is the output of the commands you wrote me to run:

mac:.idea noelo$ git log -- .idea/sonarlint/issuestore/index.pb

mac:.idea noelo$ git check-ignore .idea/sonarlint/issuestore/index.pb

.idea/sonarlint/issuestore/index.pb

mac:.idea noelo$

So it still seems like the file was not committed and it is ignored as
far as I understand this.

On Mon, 4 May 2020 at 21:51, Sergey Organov <sorganov@gmail.com> wrote:
>
> Ewa =C5=9Aliwi=C5=84ska <kreska07@gmail.com> writes:
>
> > Hi Sergey,
> >
> > Thanks for engaging here.
> >
> > Actually, I gave some details in the first email, I'm not sure if they
> > were even noticed.
> >
> > About asking second time: I emphasized this because I felt this part
> > was ignored and I didn't like it.
> >
> > I wanted to describe problem more generally and gave you the commands.
> > But now I will paste the console full output as you demanded:
> >
> > mac:lp3rater noelo$ git status
> >
> > On branch master
> >
> > Your branch is based on 'origin/master', but the upstream is gone.
> >
> >   (use "git branch --unset-upstream" to fixup)
>
> This is something I've never seen before. Dunno how this happened to
> you, but to me it rings a bell that something weird goes on in this
> repo. Maybe it's in fact nothing, but then you may get all kinds of
> nasty behaviors if repo is indeed broken.
>
> >
> >
> > Changes to be committed:
> >
> >   (use "git reset HEAD <file>..." to unstage)
> >
> >
> > new file:   .idea/.gitignore
> [... a lot more new files ...]
>
> Interesting. Is it the .gitignore that tells git to ignore all files in
> .idea/? If so, it's not a good idea for .gitignore to ignore itself.
> It's very confusing at minimum.
>
> Many new files also tells that you somehow, apparently by mistake, added
> all these files to staging (that will be committed at the next commit).
>
> Also, apparently you already did this same thing before, so there are
> some more files from .idea/ that are already there.
>
> [...]
>
> > Changes not staged for commit:
> >
> >   (use "git add <file>..." to update what will be committed)
> >
> >   (use "git checkout -- <file>..." to discard changes in working direct=
ory)
> >
> >
> > modified:   .idea/sonarlint/issuestore/c/0/c02b58f69e810278d2d423bdee55=
7628145ed943
> > modified:   .idea/sonarlint/issuestore/f/b/fb31951790c271e26d568f9ac5b7=
681e7f0804ec
> > modified:   .idea/sonarlint/issuestore/index.pb
>
> These were likely already committed at the previous commit(s) and now
> have some changes. Try, say:
>
> $ git log -- .idea/sonarlint/issuestore/index.pb
>
> to see what commit added the file.
>
> In addition, try:
>
> $ git check-ignore .idea/sonarlint/issuestore/index.pb
>
> to check if the file you think is ignored is in fact ignored, as it'd be
> the simplest explanation of your troubles if it isn't.
>
> HTH,
> -- Sergey
