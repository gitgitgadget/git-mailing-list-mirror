Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D365FA3741
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 16:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236240AbiJ0Q5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 12:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236194AbiJ0Q5g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 12:57:36 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDC316DC0E
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 09:57:34 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id g129so2065291pgc.7
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 09:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RU2w+6ZOoC4D33fWejGmr8+5dzhG57BFBQhxiKaoH1w=;
        b=pVd/d6wmW7z9IwyFeb7x0FmJEvjqmHAoFUwKiFjrvGNsdfx1Sl7uaH5AOdJU5O8FPH
         vayPe0NSsr5AVP+cmVGiZ72zb7cEdL5rMFXrR/j1eKrhLIG9MUds+6LsuQZxWmzfwblD
         BE8KfiYprbjPUuu8EV9YalBxKl2rrUqrlwJpRG9LtsN5KRHhP7lSyoSkAahFfchVmonn
         IvPnTYGuaq6J3omeKWSnLpUgLGrE3u68pHWTpwyWl7T79QeU6VUnSrnCXxd4KzYq2tk3
         1vCJStGB2NQmerZ/9y5JA4joziVOe3XIu32pq4bj9VcBGPZiUkLPXzUJnkdcheD2LKLe
         a4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RU2w+6ZOoC4D33fWejGmr8+5dzhG57BFBQhxiKaoH1w=;
        b=5XW2USjrTktKrumBZvFHNy/5xVAn7kyRY9OGvT19Q3SG2SI4MRGzy6QhQ7jYK1S3Q/
         AvcWcNkdvtVuRGJKhDPJfj9cjrHD+0OJIunpc84haAK17hk+rdAJOyYkSDjBpeFkQ1bD
         rad9MGqGQV1yqlGUxlkO09Hmy2MSi2DxcHcoxCmg14CpmDMJHx0h2qlPAY8JNovCAhxZ
         9xFq0N7FxmhKYCeDAOaDJ4s1K4iIjsptc0dmNYR9az/YmPJOt4nJQYnaAWMuTGirC+uo
         ZzE05i0j+T8bEt9wJx2Ki2y1D97h+LD8hperhwmVgp/nb8CJrVsHG5R0UByJtraFXBKa
         spog==
X-Gm-Message-State: ACrzQf3Vcp6fp5hhl9I9UrOXLaN46n+uuv7LTdiw9Xs4Y4NSFIzwxKHT
        Sp5BwxvYAK2R7aozhYsSMOKORtb46ZT4moZ4NH5hgcKRs7Q=
X-Google-Smtp-Source: AMsMyM7Llcg4WXdIDV51+Ln9W4NLAx1Z7uHgu0rMVJq2FjgOU0knKWPLLJ0+yAU/qu8COcgCvQcqymlPLhfKNNzcq90=
X-Received: by 2002:a05:6a00:1256:b0:563:ce4b:f525 with SMTP id
 u22-20020a056a00125600b00563ce4bf525mr50325805pfi.72.1666889853906; Thu, 27
 Oct 2022 09:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAB9Jk9Ay2PPEYKve3DXVmG__yZjO1mgh1MxaKA+wfsF0ZvKRqA@mail.gmail.com>
 <b0008377-2cb5-72ff-e94b-8182065b3436@iee.email> <CAB9Jk9BBddd5d0wKFB0eJw1OMMAQj88J9Bn1Yn1rbK_F1mEs1A@mail.gmail.com>
 <2ed22fa1-4d9d-e50a-18cf-048007272729@iee.email>
In-Reply-To: <2ed22fa1-4d9d-e50a-18cf-048007272729@iee.email>
From:   Angelo Borsotti <angelo.borsotti@gmail.com>
Date:   Thu, 27 Oct 2022 18:57:21 +0200
Message-ID: <CAB9Jk9DPdVmmb2DPDKPm5FLGr-XJa5kNouCYmcjh534Y2z1rVQ@mail.gmail.com>
Subject: Re: Git add documentation error
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip.

I have git 2.38.0.windows.1 on  windows 10.

I have then changed again C2.java, and made only one git add, and a commit

     > git add C2.java
     > git commit -m "commit2"
     [master 8ec0c2f] commit2
     1 file changed, 1 insertion(+), 1 deletion(-)

Then I displayed the contents of both commits, and seen that it is pretty much
the same:

D:\gittest>git show --pretty="" --name-only 91ef45d
C2.java

D:\gittest>git show --pretty="" --name-only 8ec0c2f
C2.java

If there is any difference in the files, probably it is under the hood.

-Angelo

On Thu, 27 Oct 2022 at 18:16, Philip Oakley <philipoakley@iee.email> wrote:
>
> Hi Angelo, please use 'reply all' so others can participate.
> Also, in-line replies are preferred.
>
> On 27/10/2022 16:28, Angelo Borsotti wrote:
> > Hi,
> >
> > I have tested this in the following way: I have two files: C1.java and C2.java
> >
> >     > git status
> >     On branch master
> >     nothing added to commit
> >     > ... edit C2.java
> >     > git status
> >     On branch master
> >     Changes not staged for commit:
> >     (use "git add <file>..." to update what will be committed)
> >     (use "git restore <file>..." to discard changes in working directory)
> >         modified:   C2.java
> >      > git add C1.java
> >      > git add C2.java
> >      > git commit -m "commit2"
> >      D:\gittest>git commit -m "commit1"
> >      [master 91ef45d] commit1
> >      1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > In commit1 there is only one file, which is C2.java.
>
> It does say "1 file changed", which is true.
> What it fails to mention is all the other files that are included within
> the commit, but are unchanged.
>
> Maybe have a look at
> https://git-scm.com/docs/git-ls-tree#Documentation/git-ls-tree.txt---name-status,
> probably with the -r option (check the command's description)
>
> What Git version & OS are you on?
> > This is a useful feature: one can stage all its files without
> > bothering to remember
> > which one had been changed, and then make a commit, and place the commands
> > to do it in a script to be used each time a new commit is needed.
> >
> > -Angelo
> >     ...
> >
> > On Thu, 27 Oct 2022 at 17:10, Philip Oakley <philipoakley@iee.email> wrote:
> >> Hi,
> >> On 27/10/2022 12:53, Angelo Borsotti wrote:
> >>> Hello,
> >>>
> >>> the reference manual for the "git add" command does not
> >>> specify what that command does when applied to an
> >>> unmodified file.
> >> I presume that this file is already tracked..
> >>> By testing this, I have seen that it does not add the file
> >>> to the index,
> >> How was this tested?
> >>
> >> If you have no changes, thaen the status diff will have no mention of
> >> that file.
> >> Perhaps change the tracked mode bits to see if that is noticed (note
> >> though, not all mode bits are tracked..)
> >>> and consequently it does not add it when a
> >>> subsequent commit is done.
> >> I suspect this is a subtle mental model misunderstanding about the
> >> distinction between a commit as a snapshot, and a commit being reported
> >> as the diff relative to its parent (and here, there is none, if the file
> >> is unmodified)
> >>> I think that this should be documented.
> >> A test script with sample output would help here.
> >> --
> >> Philip
> >>
> >>
>
