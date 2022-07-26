Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E940C433EF
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 02:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiGZCio (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 22:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiGZCim (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 22:38:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9222629826
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 19:38:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id e1so1588767pjl.1
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 19:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TLTsPyADVnRFYMiIK6fqXLVO5q9E7e0mPGJNK1zwdS4=;
        b=KbPUCp2w5kLv6nZc0fVzu2I6Ep22MtXsIyEM3QnGzHYwLkPv1j/Z6hIArH590C9S8j
         FjQEiMprGwUY2P4Rbrye6hjpNKj64cXBvfs9lKsRGUbG16GaXCdrWOlyYLz2y8+yuigD
         +Fyg4mmZcIbnUBgjOl9PY8sJvIfPQ/qCcUwT4lJDr6QjuM+KuTUbRnCdtu9rSGzhDY44
         29T3EB6zkIufkv1AZyUJUWgU1dsWz2eG50tOpCjZ8rhPuqMDTnTaHpgRYnDoYk6AOft2
         oBoO4o/7wcLXvMdiD+MKUKcxE5uRbGND6joieot577BcxEOf1HRK6Di5iNBeo8xy7WO0
         GwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TLTsPyADVnRFYMiIK6fqXLVO5q9E7e0mPGJNK1zwdS4=;
        b=wawbzyUWRpUoy4ariheRb4urwnG5+sUjpk7MFjurniWMCmNrfqRho1ReGJlEV2Ggc9
         NPmcLelbpQNOhfg1PXYTylth+Cl97JIaUFkLekHqkQ/nqxtktO7g6mWeS1Be4pmCdep/
         ZyzfTI8vInIZ+U5gxCTQuJtn2mVeJ+dk2ipY1lBkznOZoLL3tLWPIf8HlUPKwf2WEaiG
         UkuDqCBwEI241dQjF8v/ullJ1hAfXA1DvrJO5SkJJndWW1yIrSIflhIUdcfSEhZLwn4C
         japsaWJGEFxJ0XALOgSroVZ2UZ4ijWtoKBUmda8fEGiuPJaIoKDS6pZPmnc3v34xpKjV
         NeHA==
X-Gm-Message-State: AJIora/PUi7u1lwIve3SlkAN+9WjC/CrW6irWC9yfYRipAWgcZD/UXKK
        zZQ9KJOjzvrlPVAg/VWsljLAM3T+Lmy60DFByBEndohQhmK8
X-Google-Smtp-Source: AGRyM1sEuVYi4D/s4qs83RtT0pIIGvJlrxnrrjfsflVdQGUYlWCY01Du+SSfbvYbE2BuOREbG3+MHf0NVr4FLuHd4KY=
X-Received: by 2002:a17:902:a710:b0:16c:5305:2244 with SMTP id
 w16-20020a170902a71000b0016c53052244mr15278611plq.125.1658803120950; Mon, 25
 Jul 2022 19:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhVC3acU06uBDAjd5LEiCvuf8=XW_1RYVVt7CdKr-JqB7cRFA@mail.gmail.com>
 <YtwH7pOnDgv+MYmh@tapette.crustytoothpaste.net> <xmqqczdvaegs.fsf@gitster.g> <xmqq7d43adzz.fsf@gitster.g>
In-Reply-To: <xmqq7d43adzz.fsf@gitster.g>
From:   Yuri Kanivetsky <yuri.kanivetsky@gmail.com>
Date:   Tue, 26 Jul 2022 05:38:29 +0300
Message-ID: <CAMhVC3aNHpqvG2AQ4yfS34sX67-Z-f3dyyxNRqtdiS_D4z_jbQ@mail.gmail.com>
Subject: Re: Dropbox and "Your local changes to the following files would be
 overwritten by merge"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm not sure if it's appropriate with mailing lists, but I'd like to
respond to you all with one email. Correct me if I'm doing it wrong.

A couple of points first. The issue happens sometimes. And if my
memory serves me right, it might be that at some point it fails, but
then I repeat the steps, and it succeeds. Then, there seems to be no
reason for Dropbox to change the files. That is, it just failed, I'm
in the middle of a rebase, and Dropbox says that all devices but one
did something at least about a day ago. The laptop is up for a while
now. And anyway, it's the only machine where I change the repository.
If I did change something on other machines, that was long ago.

rsbecker, it fails particularly when Dropbox is up to date. In case it
matters, I don't do merges, I do rebases. And if I were to expect
Dropbox to change the versioned files, I wouldn't do the git stash
thing.

brian, I'm planning to move the repository out of the dropbox, but
first I'd like to figure out what exactly is happening. Move it out to
confirm if it's a Dropbox issue? That wouldn't be a 100% proof. But I
bet it'd succeed. Anyway, it does seem like a Dropbox issue. And I'm
planning to keep an eye on whether it happens only with dropbox
repositories (most of my repositories are not in the dropbox).

> You may want to additionally run "git fsck" to see if that finds any problems other than dangling objects.

I'm in the middle of an issue, so to say, rebase stopped and `git
fsck` reports one missing tree, besides dangling objects.

Junio, thanks for the suggestion to use bundles. I didn't know about
them, and it looks like an interesting option I should consider. But
again, first I'd like to figure out what exactly is happening.

Actually, I also tried to build git to add some debug statements, but
got stuck with some missing dependencies.

At the end I'd like to provide details about the latest case. Maybe
you can infer something from it. It looks like it tried to apply a
commit it already applied a second time. I have a hard time
interpreting the current state. It's at commit "b", but
.git/rebase-merge/stopped-sha points to commit "c", and
.git/rebase-merge/done says it applied commit "b" twice. Although I'm
not sure I'm interpreting it right.

What I did:

$ git rebase -i --root # and changed the first pick into edit
$ git add some-file

$ git rebase --continue
error: Your local changes to the following files would be overwritten by merge:
        some-other-file
Please commit your changes or stash them before you merge.
Aborting
hint: Could not execute the todo command
hint:
hint:     pick 0008743 commit c
hint:
hint: It has been rescheduled; To edit the command before continuing, please
hint: edit the todo list first:
hint:
hint:     git rebase --edit-todo
hint:     git rebase --continue
Could not apply 0008743... commit c

$ git log --all --graph --oneline --decorate
* 3774372 (HEAD) commit b
* 2ccb75d commit a
...
* 9adb050 commit d
* 0008743 commit c
* 3e0cc95 commit b
* 6df3ef9 commit a

.git/rebase-merge/done:
edit 6df3ef9 commit a
pick 3e0cc95 commit b
pick 0008743 commit c
pick 3e0cc95 commit b

.git/rebase-merge/git-rebase-todo:
pick 0008743 commit c
pick 9adb050 commit d
...

.git/rebase-merge/git-rebase-todo.backup:
pick 6df3ef9 commit a
pick 3e0cc95 commit b
pick 0008743 commit c
pick 9adb050 commit d
...

.git/rebase-merge/message:
commit c

.git/rebase-merge/msgnum:
3

.git/rebase-merge/rewritten-list:
6df3ef9 2ccb75d
3e0cc95 3774372

.git/rebase-merge/stopped-sha:
0008743

Regards,
Yuri

On Sat, Jul 23, 2022 at 9:19 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > E.g. after finished working at a site, prepare to take the "latest"
> > to the next place you will work at in a bundle,
> >
> >     $ git bundle create 2022-07-23.bndl --all HEAD
> >     $ mv 2022-07-23.bndl $my_dropbox_directory/.
> >
> > and when you get to the next place to work at, you'd "fetch" from it
> > into the repository you keep, or you can choose *NOT* to maintain
> > any local copy there at all and "git clone" from the bundle every
> > time you restart at a different place.
>
> A practical real-world solution would certainly involve keeping
> reasonably fresh copies of repositories at each work location, and
> "git fetch --mirror" into it from the bundle.  The "bundle create"
> command would most likely have some bottom revisions to reduce the
> size of the resulting bundle files, i.e. if you know that all copies
> of repositories you'd work with surely have the version you tagged
> "v53.8" a few weeks ago, then the "bundle create" command may have
> "--not v53.8" at the end.
>
> In other words, the above is *NOT* meant to be a full solution, but
> merely to illustrate a possible direction to go in.
>
>
