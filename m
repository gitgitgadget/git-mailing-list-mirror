Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EB5C433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 01:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC0A923C18
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 01:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389753AbgLKBet (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 20:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731632AbgLKBej (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 20:34:39 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55621C0613CF
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 17:33:59 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r3so7425431wrt.2
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 17:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tWD5tW/O/cJKumJXPqcSkO6J4KNzzQnwfj6+52yWmuI=;
        b=AzgH1WKg+1ig5W3W2Y63ad8PFKNn9Lvu+YzyemZ6yCTJzl9ielbgtt3AWnPSQTl766
         OrWWyzdsLd2YniO9Nq07AbebetB7B16huT93S/5DISH8OCjCaAmKqdT/gcJt318mlb7A
         Tc1xPQ10wCutJ6/WwCCDiYWW1MASyxkpGsfSMR9Qez4NGDsjh3pMyOUXQuGLetDYrwqm
         /FbcxAALnkpaLDUZxJnH31g0BGJ86myrHjlmA5hHpu9KVtV9RHOT9yT/o2rztpTQ0Qia
         dCWS3BL25mQDLRDdwLUiLnoe7ym9dxrwzQkdkblC39i5W4RLt+Ykr/JoAHDqA0NHsNop
         jUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tWD5tW/O/cJKumJXPqcSkO6J4KNzzQnwfj6+52yWmuI=;
        b=czcymLqVwLm40vfXIroCPEEppiA4JWVP6BSrMiDHQMDeJsL14alImMHm4fy0rAg1Yx
         03/zvDBwLjhqA26vfC+e9yAEZrkW5FoTo1wpDCqs+GQUylJLs5qayToM+fJ0ym4kGhBH
         Sl7JKkYvR6SeMBJ+f3ueiszBKJGNLZ0eTmOnlWT0k/NVM99JUNxQL0RlHSdHNsVCvqR9
         Pf8qgun58rUoLOAIO8PH1E8/VIJursWDZA/737eeD6PVCWPd6pjvnldFmYGDPY8H3Y1e
         w/We7TdzeK0Rkcz1KAsYsVcism74kRPeAzjRY5cvk/BKJ/jWQIuTW8qXMP+jdwJ276y+
         +ueg==
X-Gm-Message-State: AOAM5329O/mwjKhvOzAKy+3sHHnUsrYmbjXlKNPg/QhF95lZhPHpePTE
        7/YcM3B1IJq4TZum3tQC0ARtuXamykIOnJ4208U=
X-Google-Smtp-Source: ABdhPJzjgKD3ekt83WoKmL1CbrmoUcb/Gn/vlAni86xNDNl1N/ookxMkjWqJii1rs1WwhvC7Qnsa+fl24lQolM9d5fc=
X-Received: by 2002:a5d:68c9:: with SMTP id p9mr11115152wrw.139.1607650438075;
 Thu, 10 Dec 2020 17:33:58 -0800 (PST)
MIME-Version: 1.0
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2012091502000.25979@tvgsbejvaqbjf.bet>
 <xmqqk0tq1xf3.fsf@gitster.c.googlers.com> <20201210152715.GQ52960@mit.edu> <xmqqim99wm61.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqim99wm61.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 10 Dec 2020 19:33:46 -0600
Message-ID: <CAMP44s2Po25VyHs-xQG0_oKhAOvPK_PNu5edQkYYsScZeBw1nw@mail.gmail.com>
Subject: Re: fc/pull-merge-rebase, was Re: What's cooking in git.git (Dec
 2020, #01; Tue, 8)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 10, 2020 at 12:28 PM Junio C Hamano <gitster@pobox.com> wrote:

> It however doesn't give useful input to help us answer the questions
> Johannes raised: is it sensible to force users to tell "git pull" if
> they want to merge or to rebase explicitly, instead of defaulting to
> merge like we currently do?

Yes. As evidenced by the fact that this topic comes back again and
again. There's the "Pull is Mostly Evil" thread, there's countless
blog posts urging users to avoid "git pull" altogether, and many
questions in Stack Overflow like "How to avoid merge commits from Git
pull when pushing to remote" [1].

You didn't answer my previous question: "Do you want me to dig a
decade of discussions and coalesce those conclusions into a summary so
we can decide how to proceed?" [2]

I'll take your pondering about how sensible this solution is as a "yes".

However, we would not be doing that *today*.

> how much damage are we causing to
> existing users who expect the command to work the way it currently
> does?

Zero. Because my proposal does *not* make the pull fail, it merely
prints a warning that it will change in the future.

After introducing "pull.mode=ff-only" we have all the time in the
world to ponder if this is really the default we want.

In the meantime users can already start to move to this new behavior.

Zero people will be affected negatively, as the only thing that
changes is the wording of the warning.

Cheers.

[1] https://stackoverflow.com/questions/30052104/how-to-avoid-merge-commits-from-git-pull-when-pushing-to-remote
[2] https://lore.kernel.org/git/CAMP44s13YFZeOMz6V5sPdOnLXD-v3aQZiP7vvXXNfQLZP4Puwg@mail.gmail.com/

-- 
Felipe Contreras
