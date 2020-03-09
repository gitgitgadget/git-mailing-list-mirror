Return-Path: <SRS0=lsTH=42=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC615C10F27
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 15:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993FC20578
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 15:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syv9rGvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgCIPuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:50:55 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:33901 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgCIPuz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Mar 2020 11:50:55 -0400
Received: by mail-ot1-f48.google.com with SMTP id j16so10040175otl.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2020 08:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KzjjdZu9HmtwtnjkgKGQzbTA0MI6tIQOF/2J7K6FRco=;
        b=syv9rGvKBStQjWJVBWcxCWIK5L0UOU1cmA43YUlxoukOoiPecPkM84r4aca/FZVlcs
         UVbl4bxlyJcooNF19CBMMLfo/V18pOyNYxqaTOM81KJ6+ax53JBmOkQGpdKWwTnionVJ
         g0Hs54pvPce7CE34YsFUR5Uy7/K46IlhcJ/LThmH/k51VG4kQ91isSKPWrJunttwl+zC
         0XYaWNoSW2TaN4h5dNrjtnkS5zP7FkqA7Jev4NaE5Uj8Yeh3/vFrmcZ9kfqOOd2wZxTp
         CAnrFzFDbRWpA+IHwf1fi4ZiC6bnqzdNl+7jMkflLJPCbKHHx9H7WR5voPb9QMU3i4ie
         f0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KzjjdZu9HmtwtnjkgKGQzbTA0MI6tIQOF/2J7K6FRco=;
        b=MEj4r079aZWI3lnFEssOUktVqPc9Oh9EY2f7SS7FZX4OAQ76gspKRqkfk+Jo8t3QEa
         +hD9ZNzvW4AzbHO6ZUAs8YqxPiGjGwubeP+Tx5xn6u+CwWmza0J8zUOHREex30H54bQP
         jNitn+u4hBkZOzUSPnbDPL6ZqSarBUaLjZWWdNw8N8q9/RrDpHPpDSMexcl1khTxMzy0
         aOwzKG5r3YcYmsVG+GK6ND3nwnhStiHdlyxapJlkh0DDg8xs4ypSpvQVAjcnSgk908gf
         Htk2mbrWU7r7Rhl4YISL4E9WuB16hfUbGXl3OUfFm0ckynRJAAHy9MWkzXbBAJY2xpoJ
         c/pg==
X-Gm-Message-State: ANhLgQ0mklbuh7M5Q6Qmuy7gGIeFasMI5U2hBqeET0G8TOkFBbfkXLNx
        YqLEb7DPBXT36XZ0mLL+0o+t4iSd6K4hg1BWkJ5p4A==
X-Google-Smtp-Source: ADFU+vsqg24EhsV02+d1Smn6sAmttySeFipybwXr+xEeBqHfIwJw5ZTzz7uT+qt9dfTpvT6DsG80lnBj+Xi4z2qsG80=
X-Received: by 2002:a9d:7b4c:: with SMTP id f12mr13711822oto.345.1583769054512;
 Mon, 09 Mar 2020 08:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BHk0TyxEgudMX_-zzpFsUPHCmRkvZezN_49J2ivi2-N+w@mail.gmail.com>
 <3165171583586403@sas1-2bf44b70450e.qloud-c.yandex.net> <CABPp-BECOarg+G-_oz83i0EuKuypJQA=wyjnfG4U0heG=0L0hg@mail.gmail.com>
 <3207561583597253@iva2-fa9fd5fad11f.qloud-c.yandex.net>
In-Reply-To: <3207561583597253@iva2-fa9fd5fad11f.qloud-c.yandex.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 9 Mar 2020 08:50:47 -0700
Message-ID: <CABPp-BGyz2uRtmw05uCFVACq9aXS9fwcLwEEvw4EU9toixwf2w@mail.gmail.com>
Subject: Re: Git Merge 2020 slides and reproducibility
To:     Konstantin Tokarev <annulen@yandex.ru>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 7, 2020 at 11:38 AM Konstantin Tokarev <annulen@yandex.ru> wrote:
>
> 07.03.2020, 19:03, "Elijah Newren" <newren@gmail.com>:
> > On Sat, Mar 7, 2020 at 5:38 AM Konstantin Tokarev <annulen@yandex.ru> wrote:
...
> >>  However, when testing my previous merges which had to be done with helper
> >>  script, I've encountered case of
> >>
> >>  CONFLICT (directory rename split)
> >>
> >>  Is there any way to prevent conflict in this case if files are the same, and
> >>  merge their contents if there are differences? I think it would be reasonable
> >>  to assume that move done in newest commit should win, and allow user
> >>  to change strategy via command line option, provide explicit hint where files
> >>  should be moved, or maybe even decide it interactively.
> >
> > This conflict message is known to trigger in some cases where it
> > shouldn't; it may be that you're just experiencing annoyance from
> > that. Let me fix that issue before worrying about workarounds.
>
> Well, in my case a directory of files was moved path A in one of merged heads
> and to path B in another, so I guess it was legitimate.

The point of directory rename detection is to allow new paths on the
unrenamed side of history to follow the directory rename.  So, while
there may have been an ambiguous directory rename, if there were no
new paths to be moved by it, then that directory rename is irrelevant
and shouldn't be reported as a problem.  (If you did have new paths on
the unrenamed side in that directory, then yes, it's legitimate.)

> Are you going to continue development in the same branch?

Nope, the branch exists for reproducibility of the demo.  Right now,
my plan is to work on the 'ort' branch (which the git-merge-2020-demo
branch was a snapshot of), but I reserve the right at any time to push
up code to that branch that doesn't even compile or is known to be
horribly broken.

> When do you expect it to be ready for review?

Good question.  There's other work I've been pushing off with the
excuse of preparing for the Git Merge 2020 conference, and working on
those other things may limit my time on this and make it harder to
give good guestimates.

I'm hoping that _parts_ of it will be ready to review a week or two
after 2.26 is released.  That will not mean I'm done with development
at that time, just that I'm trying to get feedback in parallel with
doing further development.  Besides competing priorities, there's
another reason to be somewhat cautious about the timeline: I don't
want us to replace one area of the code that only one person is
willing to touch with a different scary beast that no one wants to
touch.  So, I need to put some work into high level algorithm and data
structure documentation, splitting up patches nicely, etc.  And the
purpose of writing those documents isn't to put the design in stone,
but rather to make review easier -- at which point I expect at least
one big change or two (and dozens of small changes) to be requested
for maintenance/performance/API-design reasons.  I'll be disappointed
if I don't get that kind of feedback, as I'll be worried we're just
putting a new black box into place.

I happen to think that the basics of the new module are nicer than the
old merge-recursive module I'm replacing, but the performance work
complicated things a fair amount and I want to make it more
approachable.  So, we'll see.

I know this is horribly vague.  Sorry.

Elijah
