Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1BCC433EF
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 18:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7366D600D0
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 18:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbhIDSdX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 14:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237320AbhIDSdW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 14:33:22 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06096C061575
        for <git@vger.kernel.org>; Sat,  4 Sep 2021 11:32:21 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id t190so2559337qke.7
        for <git@vger.kernel.org>; Sat, 04 Sep 2021 11:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZZ4y1HgO1zhMfw3nVkg90PB1EuYsZ4QnuIRzoOHIAsk=;
        b=af8OU1GnVlicxx+bIWpZymOgZ8Z3THpJRvnDnhgjTEIO713mtb0dodfq7382sSlWw1
         UcqwoUXREpWHn9JFfEHAoytREVPe8Sh3ih8T4KfcCOqy9+7apAhnm1IUBlGFOXKEsn/s
         a1meKtXr10TV0pmmDWIjXCd9LZ6bvLYgfd9vADc1AsA0+l2PiIIGSoHVn2r8ThmSAvdj
         ow+mHhYYyZIM+rAkQJ9OQQ+b3GO5gKXtwzV8mR8FLSesmtPuSTvPpw03NjWz0rJAF8vo
         YM/wJAcd+fp3Ohm5CQYrZGXs3szAr6S9+Xd8Rzii11OZXb+mv98sc05aMsJBEBzJmJiB
         rJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZZ4y1HgO1zhMfw3nVkg90PB1EuYsZ4QnuIRzoOHIAsk=;
        b=L6WS+SZkOspjJqr+swEvQEv4HZsLuTFHpwZTYEps6kGyc/30n8vfQluF5UiCDQ+tak
         FPdgoz4cEJcU1H2FJg5i4Z21Eus/Mmj622UQNMBFQYyYW1ssG59XIGJEcE9BPNjYJVw7
         qQkLtcOM0TC/56bMnyK8DQobLnWIVPoZzmU1HFgnP0jn4wfmw3+4PlNpzmPj7X+5pfmu
         brOCB1vxBUYuCThHL60wjb2p/vKekEId+uiODs11QZ4grM8jsXo3bVEV8LqgtedgseV1
         6lpkghbs7AlCtXlK4ZtC3YNu8dRohq4oDGHKZMDbJ/VqVSY5MxYxB9D1WtS2yLf0O6p4
         V0QA==
X-Gm-Message-State: AOAM531CLSIBSNHwlNWcbtXOhaHqBZuZ5M8PindoxL0rq0nU+d4WbXH9
        /zGH6uqv4wJoUqwu1z0oFA7MJHvufRMtr3+u+iE=
X-Google-Smtp-Source: ABdhPJzAz1xJk2mFP1G5WAeW3NqOfSwCTK7pNNwLfWPzB8oVSdqxn5O4WLc5LSMfbrpt9AlBx1zwlg+0HnPUqYmMHb8=
X-Received: by 2002:a05:620a:2008:: with SMTP id c8mr4280977qka.493.1630780340053;
 Sat, 04 Sep 2021 11:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAG2t84Uaw-Kdp+EXU8CY1QYfykFQj-hGLJnTSH8MYO8Vi_yqgA@mail.gmail.com>
 <C357A648-8B13-45C3-9388-C0C7F7D40DAE@gmail.com> <dbe7d88d-4174-e080-03df-e35d0ac6004f@gmail.com>
 <YTNA6Qo6Yj5o9NmQ@coredump.intra.peff.net> <CAG2t84Xe2XwdwdAK42bRrwAeNaB3-A+WhgSsJGOoW9-rG1S9Xg@mail.gmail.com>
 <CAG2t84WY35RvieOc5mhRJExwHdXuaiBafB4S4APkrnGiBM_t_g@mail.gmail.com>
 <CAG2t84Ud9AFfHhCxyKWvcqVUKTrkRufdMsQL93cdUUvVAyNpzA@mail.gmail.com> <YTNJeY2U6tcOQiCh@coredump.intra.peff.net>
In-Reply-To: <YTNJeY2U6tcOQiCh@coredump.intra.peff.net>
From:   Fedor Biryukov <fedor.birjukov@gmail.com>
Date:   Sat, 4 Sep 2021 20:32:09 +0200
Message-ID: <CAG2t84WrV7OZ_0KqOXsNCevEt046hyd-CAHCbWFBY4uBCFjLDg@mail.gmail.com>
Subject: Re: Aborting 'rebase main feat' removes unversioned files
To:     Jeff King <peff@peff.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Actually it's the same on all operating systems. I just forgot to add
a new base commit in main in the reproduction scenario - there was
nothing to rebase...
Here is the correct scenario along with the output.

+ git init -b main repo
Initialized empty Git repository in
/Users/ted/workspace/git-abort-bug/repo/.git/
+ cd repo
+ git commit -m base --allow-empty
[main (root-commit) 3299694] base
+ git checkout -b feat
Switched to a new branch 'feat'
+ echo feat >readme.txt
+ git add readme.txt
+ git commit -m txt=feat
[feat c9dc9b4] txt=feat
 1 file changed, 1 insertion(+)
 create mode 100644 readme.txt
+ git checkout main
Switched to branch 'main'
+ git commit -m new-base --allow-empty
[main c5c292c] new-base
+ echo precious > readme.txt
+ git rebase main feat
error: The following untracked working tree files would be overwritten by merge:
readme.txt
Please move or remove them before you merge.
Aborting
hint: Could not execute the todo command
hint:
hint:     pick c9dc9b4d5aca461f1a1bedd3b99b5c8533d5ef10 txt=feat
hint:
hint: It has been rescheduled; To edit the command before continuing, please
hint: edit the todo list first:
hint:
hint:     git rebase --edit-todo
hint:     git rebase --continue
Could not apply c9dc9b4... txt=feat
+ cat readme.txt
precious
+ git rebase --abort
+ cat readme.txt
feat

-Fedor

On Sat, Sep 4, 2021 at 12:24 PM Jeff King <peff@peff.net> wrote:
>
> On Sat, Sep 04, 2021 at 12:03:49PM +0200, Fedor Biryukov wrote:
>
> > Here's the output from Windows, where everything works as expected.
> > [...]
> > PS> git rebase main feat
> > error: The following untracked working tree files would be overwritten
> > by checkout:
> >         readme.txt
> > Please move or remove them before you switch branches.
> > Aborting
> > error: could not detach HEAD
>
> Interesting that it behaves differently than the mac and linux versions.
> There are some changes between Git for Windows and regular upstream Git,
> but looking over the diff between the v2.33.0 releases, I don't see
> anything that might cause this discrepancy.
>
> If the problem used to occur on v2.31 and now doesn't, it might be
> interesting to bisect it.
>
> -Peff
