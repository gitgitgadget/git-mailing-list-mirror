Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F96C2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 22:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD2D2083E
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 22:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbaYV8Zp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgDJWML (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 18:12:11 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35707 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDJWMK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 18:12:10 -0400
Received: by mail-ot1-f65.google.com with SMTP id v2so3207220oto.2
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 15:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ABAqF5dFxeE4YPuEd85xWjP3F6iIZXuVi29oSZfTvw4=;
        b=pbaYV8ZpUaNv1+DJU/UuFacYD0pZLr32v+aClXFOFprph9YH24WCGytF0nqrQIiVZQ
         egveYP6GsnvxEFFy9pP/doEr2o6zwboba6681pYinmmKVIozeOzrAU8p/VD8AUfKbdC+
         l2CJvXBNnZGyyxbGqjG4CH0oEh6nNCaetcsYV2V2N0JIK888j+36UBM9o4HVznN9CwLZ
         DUNwcdlovSki3AI+FyuOg4JeSyQdAvcLnN009tP+SWcQpTeCTe3t+KS2kkMRNTCBDmh1
         0UFBB7evtAT++KbMztqrttwKpMI0n4eRYD8Vmp8dkUbtJC83Oxp12bgChwhYPCiNxbPr
         B/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ABAqF5dFxeE4YPuEd85xWjP3F6iIZXuVi29oSZfTvw4=;
        b=rIrZrvr2Rd43fTRk4ZFmORErV8FMKIP012uQQWCQTSVBfo6L74ImHhaelIgzSmlcyF
         BKdErB/2zmOSZHgXJkr89Ki8ncZ3xEvWXLem3nAFWTd6v56Pkx0MFLesA8LvYQW/kv4W
         pUYlCEf19sLi2OfcCYs3gumNqNByAn7LUnhqw7A4PodGYKloAQXwr0BncnO9iwuhuXA1
         UpXEPut12HaKuHCvVvbknAo2YaeRAfdKehwTZRN9wbKs+iF0m7+xS/xUknGUWpsc6QpA
         /9wh4ze38lhOP/6vSatUvPUeAWTXs0J9Rzmfy+qKWw0NOg0UxCf4p2ykK4WZBymfVzt/
         mBSg==
X-Gm-Message-State: AGi0PuYewuih4uKiAmxSKMIGCleM3Y6CAp/VN+MRk9piF+y2MzDlDBMe
        +vPcEj1VO7xP8MC/EdID1SdShRTy3E7zP9d97SM=
X-Google-Smtp-Source: APiQypICN4QtD/ShgFtymdqA/8Aau7+60U1A8ExLdIz+t5HtPBwoQyG3EiIWJ2B6amfa5/QucO2WTyzV5OOSRRk5QLg=
X-Received: by 2002:a9d:6097:: with SMTP id m23mr6053702otj.316.1586556728734;
 Fri, 10 Apr 2020 15:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.757.git.git.1586474800276.gitgitgadget@gmail.com>
 <pull.757.v2.git.git.1586541094.gitgitgadget@gmail.com> <xmqqpncfhy3g.fsf@gitster.c.googlers.com>
 <xmqqlfn3hx1v.fsf@gitster.c.googlers.com> <xmqqh7xrhwlu.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7xrhwlu.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 10 Apr 2020 15:11:57 -0700
Message-ID: <CABPp-BECuio43GScBsPx3er60nHmrYnLMzOtibdodJW+KGFU5Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] rebase -i: mark commits that begin empty in todo editor
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bryan Turner <bturner@atlassian.com>,
        Sami Boukortt <sami@boukortt.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 10, 2020 at 2:14 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > This is a total tangent, but when I tried to rebase
> > jt/rebase-allow-duplicate that builds directly on top of v2.25.0 to
> > a newer base, after resolving conflicts, "commit -a" and "rebase
> > --continue", somewhere I seem to have mangled the authorship.  It
> > could entirely be a driver error, or it may be a bug in "rebase",
> > especially with recent backend change.  I am planning to come back
> > to it later to figure out if there is such a bug, but I'd need to
> > recover from the authorship screwup first, so it may take some
> > time.
>
> I think I know how it happens now.
>
> 52e8d1942c662 == jt/rebase-allow-duplicate
>
> Attempting to rebase this on top of the 'master', i.e.
>
>     $ git rebase --onto master 52e8d1942c662^ 52e8d1942c662
>
> results in a merge conflict, but it is easy to resolve in the
> working tree.  Then after "git add -u" to record the resolution
> in the index
>
>     $ git commit
>     $ git rebase --continue
>
> gives me the authorship credit.
>
> Back when the default rebase backend was 'apply', making the above
> "mistake" was not even possible; "git commit" would have given me an
> empty log buffer to edit, without pre-filling anything, to help me
> realize that I shouldn't commit.

"was not even possible" and "to help me realize that I shouldn't
commit" seem slightly at odds, but I think you're saying that the UI
was a bit better at helping you abort before you continued with such
an accident.  Perhaps it could be improved even more while we're here?

> With the sequencer backend, however, the above procedure happily
> records the commit under the author's name, it seems.
>
> I am not sure if that is a bug.  I am inclined to say so.

I am inclined to say so too, but it does get a bit more
complicated...with just a few cases I can think of off the top of my
head.

In the case of the merge backend, specifically with --interactive, it
does make sense to use "break" or "edit" commands and then allow the
user to run "git commit" in a stopped rebase.

It also could make sense in some cases to hit a conflict, allow the
user to run "git reset HEAD" and then start fixing and staging pieces
of the changes for a commit and then manually commit the pieces (which
then gain a different author and different commit message and
rearranged/subsetted/modified contents, with the expectation that
they'd probably do a Patched-based-on-work-by tag or equivalent).

But if we're in the middle of a rebase-apply, or in the middle of a
rebase-merge and resolving a conflict (i.e. not cases like the "break"
or "edit" or just ran "git reset HEAD" cases), or in the middle of a
cherry-pick and resolving a conflict, then I'm inclined to agree with
you that calling "git commit" represents an accident by the user that
should result in an error.  For my purposes here, "git add -u"
shouldn't mean we're no longer "busy resolving a conflict" (otherwise
git commit would have already stopped you); that state shouldn't go
away until "rebase --continue" or "cherry-pick --continue" or "git
reset HEAD" is executed.  But it gets slightly weird, though, since
"git reset HEAD" operates differently in merge and apply modes (with
apply still attempting to commit something afterwards and merge
realizing that a reset means that commit was tossed).  So it might
take a little more care and history digging to make sure that the
various cases are handled sanely.
