Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2490C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B893F610A8
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240558AbhIMPy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhIMPy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 11:54:57 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07703C061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:53:42 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id w144so14602949oie.13
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NR1gfOgAtKNBxuiVaQFzikrgQ4Ch4ukX2ZBK6/2DJc4=;
        b=gpdUkXFzmbaAcxneSQUxTdCyWaT54fhVZqauiQsErzajl7pfI1NF6F26o5Jxx31TwE
         UrWRqfIbDOGBhCKL9TH6YnNotKbpJRa3o4hdz5dqIjbxvCuCHZMgR/OFtgw4aNVQuoJM
         qlCf71qvKaeoL+CdKu3bnxHeG0TXbxMoRl9liVmwho/+ynAFVGsq9PPkwC3SofnZknLa
         v7pa1rH4+S3YDUtuqdp4xuNMi7Hv3FbzKvI3fSIpeqby+tRnbHurF8UDRdQjOntcvnsj
         lw3fv2C3SJzZzQ5SWZyIsgEvDKMQFlKYI5v4cSF021glLIMiXhoYRvTFYG5BJQYq9+af
         B7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NR1gfOgAtKNBxuiVaQFzikrgQ4Ch4ukX2ZBK6/2DJc4=;
        b=OoSu5i8Wl9Xl7nd145lvVrI0xIAbwOWuXYiUcrdzJ/NZaqBkzBgd/pMs/emMF9sktb
         jXSfpGB+kCYZa4QCADX+F/YeIIoG+gEHAybFqZNaTSnVqhg0e589qYoOnwWPtj0h/96C
         83wvWsPM0M/jO1OurFRe8k5niLLAMLNshbhWChWVcaj5RNRaLhwC9U5mTwyRnIwl+Om+
         864yJbWvrqdUSkjd5NhHQ4sfn/75cbQ3cvCLRYk/iEgywgoY2UCEldcTWI7DC9pj+KW1
         ih7tyNTq+fs+eoyMlJkfMcZm4mldGRCB0m6Ly07nfK0i5Cwwx5ENUN/0PnNSpPZfUKm+
         MwBA==
X-Gm-Message-State: AOAM5322H+kMwFFdJUxU/pHuM/2cvjGKT7L7Vk8ceNIyd2GdI2lP8ECd
        INVN/wHDwLa6C6B25I987d3lOlH2BnKibP6qICA=
X-Google-Smtp-Source: ABdhPJzRo0AbnTg52qQ7T2UtBauppdrc1DMSwcO6Z0AmYXcvGKi0VeI7XQmWnod9wH17EcLK3zuHLgUkVC+amn7ohas=
X-Received: by 2002:aca:bfc6:: with SMTP id p189mr8154549oif.167.1631548421316;
 Mon, 13 Sep 2021 08:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
 <pull.195.v2.git.1630497435.gitgitgadget@gmail.com> <xmqqk0k0ndbq.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2109021616300.55@tvgsbejvaqbjf.bet> <4e998676-4975-8ac2-35a0-34416938b62e@kdbg.org>
 <nycvar.QRO.7.76.6.2109071930080.55@tvgsbejvaqbjf.bet> <CABPp-BFZfa7cchRTycdyMbnwb_f=vHxQYLA5QswuM0ExfxeMAQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2109101325410.59@tvgsbejvaqbjf.bet> <CABPp-BHWVO5VRhr1-Ou60F1wjKzJZ1e_dC01Mmzs+qB9kGayww@mail.gmail.com>
 <nycvar.QRO.7.76.6.2109131319020.55@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2109131319020.55@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Sep 2021 08:53:29 -0700
Message-ID: <CABPp-BHp+d62dCyAaJfh1cZ8xVpGyb97mZryd02aCOX=Qn=Ltw@mail.gmail.com>
Subject: Re: merge-ort and --rebase-merges, was Re: [PATCH v2 0/7] Drop
 support for git rebase --preserve-merges
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 4:24 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Fri, 10 Sep 2021, Elijah Newren wrote:
>
> > On Fri, Sep 10, 2021 at 5:08 AM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > On Tue, 7 Sep 2021, Elijah Newren wrote:
> > >

[...snip...]

> > If I've understood that all correctly, then my idea will give you the
> > following conflict to resolve:
> >
> > ==> rebase-of-original-merge, before conflict resolution:
> > int hi(void) {
> >     printf("Hello, world!\n");
> > }
> > /* main event loop */
> > void event_loop(void) {
> >     /* TODO: place holder for now */
> > }
> > /* caller */
> > void caller(void) {
> > <<<<<<< HEAD
> >     greeting();
> > ||||||| auto-remerge of original-merge
> >     core();
> > =======
> >     hi();
> > >>>>>>> original-merge
> > }
>
> That looks very intriguing! I would _love_ to play with this a bit, and I
> think you provided enough guidance to get going. I am currently preparing
> to go mostly offline for the second half of September, read: I won't be
> able to play with this before October. But I am definitely interested,
> this sounds very exciting.

If you start working on it, let me know.  I was thinking of playing
with it, but don't know exactly when I'll get time to do so; very
unlikely before October, and reasonably likely not even before the end
of the year.

While I've provided the high level details in this thread which are
good enough to handle the simple cases, I think that the interesting
bits are the non-simple cases.  I have not thought all of them
through, but I'll include below some notes of mine that might be
helpful if you get to it first.  Note that I focus below on the
non-simple cases, and discuss content-based conflicts before covering
path-based ones:


* We're doing a three way merge of merges: pre-M, M, and N to get R; M
is the original merge, pre-M is (automatic) remerge of M, and N is
automatic merge of rebased parents of M.

* Note that N is what current rebase-merges uses, so we have all
information from that merge and can provide it to the user when or if
it is helpful.

* Both pre-M and N may themselves have conflicts.

* We need to programmatically handle conflict marker length when pre-M
and/or N have nested conflicts.  (must modify merge routines to return
the maximal conflict marker depth used)

* Special case that pre-M matches N (per hunk): If both pre-M and N
have conflict markers, but they happen to match, then we know to take
the version from M and the result IS clean (at least for that hunk).
So, you can still get a clean merge even if there are conflicts in
both pre-M and N.

* Special case that pre-M matches M (per hunk): Usually in the
three-way merge of "Base, Left, Right => Result", if Base matches
either side then you get a clean merge.  However, if pre-M matches M
but N has conflicts, the result is NOT clean.  Another way to look at
this is that conflict markers are special and should be treated
differently than other lines.  (And path-based conflicts probably need
special handling too, as discussed below.)

* In the case of complicated conflicts, consider providing user with
both R:resulting-file and N:resulting-file (and point them at `git log
-1 --remerge-diff M [-- resulting-file]`)

* Having either binary files or path-based conflicts (e.g.
modify/delete, file vs. directory vs. submodule, switch to symlink vs.
switch to executable, rename/add, rename/rename -- either 1to2 or
2to1, directory rename detection, etc.) in either pre-M or N -- or
both -- are going to need special care.

* One example of path-based conflicts:  Let's say pre-M had no
conflict at path P, and that pre-M:P and M:P matched.  Let's say that
N:P had a modify/delete conflict.  Note that for modify/delete
conflicts we tend to print a message to the console and leave the
modified version of the file in the working tree.  Here, despite the
fact that pre-M:P and M:P matched, we cannot just take the modified
file from N at P as the merge result.  The modify/delete conflict
should persist and the user given an opportunity to resolve it.
Representing the modify/delete might be an interesting question,
though since...

* If both pre-M and N have conflicts, then pre-M would have had up to
three versions of file in the index at higher stages, N would have had
up to three versions of file in the index at higher stages, and M
would have one.  We cannot represent all 7 versions of the file in the
index at the end, which means conflict representation might be tricky.
content-based conflicts are easier to handle here than path-based
ones, since content-based conflicts can just do similar to what
rename/rename(2to1) conflicts do today: just stick the result of the
preliminary three-way merges into the index.  path-based conflicts get
more interesting because you can't do a preliminary merge of binary
files or a preliminary merge of a modify/delete, etc.

* If both pre-M and N have path-based conflicts, but of different
types, how exactly do we mention that to the user?  Just list all the
types?  (This probably qualifies as a case of a "complicated" conflict
where we want to (also?) provide the user with N:resulting-file
instead of (just?) R:resulting-file.)  We may also need to modify
merge machinery to return types of conflicts per-path, an extension of
what my "merge-into" series (not yet submitted) provides.
