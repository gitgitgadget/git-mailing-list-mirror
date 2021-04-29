Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E99C433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 07:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EFFB61456
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 07:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbhD2HuC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 03:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhD2Ht6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 03:49:58 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B8DC06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 00:49:12 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id 72so3290609uaq.10
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 00:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4d53/cPoGbQmmYqwq45gOZZ0r7wz5S42rOElHvL017c=;
        b=mymJx8OeLhks2QdLrTlv/PVXAYeUe2D812gVRSKkjvKf+gFPFhEGTP+BmMw5anO3bP
         T8wcg31jjGZcrvQa900C4Wl62zJG+zNYEtU7fZT+tttuGVW1cYN2ZyrSWpGaBZUmAFzt
         INdkiUYu/2PsMTZYOXIFJGjiepUYilhoJr3zwD2m6SV4pdveiyGQxiOYVCON7neoCpgQ
         qekQT6iREKCeOoCQOvb4USPTHd0kAkMKqEaAnb+4maOvpsH6kgxShNtZKrdeP7S1Xz/F
         52cdTxvL8Suwb/FTkaMcJXcHnEcOOMDKhGIMXWJlv6iFaFOViTUP56BxMp8N3H9gdgss
         WfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4d53/cPoGbQmmYqwq45gOZZ0r7wz5S42rOElHvL017c=;
        b=XyvzBcowyGpGXMe8fvCE0DaKEpHtssvEQLCk5hXzF+SAvGXSxDX3+mjWOZONV0RbzI
         iKEMljnNV7hv2WKrr7PqqOFNknEqM8OlYYQsWmcX+Bzha6eivycyspWjoPJvONOsn/Jh
         uZfR5SGYWBgNXayVhM4SnElJlkL+UPUvGO6PxKWdgqPU2QdgxBNpg78z1CGRbTCyuHf/
         BsNecvbQ/pu+hlQdoOv8wW9OhdLRDD4VokmlAU6oFFKNmTgbxgqOA4pXu5KN9ymCyaMC
         J0bSHls7Wfeg7KOnoVeyElQa+gAfKU1J3JECNnFR3rCDx71pRUTYhB+GX3CwBW9zxXGq
         yHyw==
X-Gm-Message-State: AOAM533jY3vtjtkh4S0JGs+uxORgtyFig90KW2JYQZR9BoUGjLv+FfST
        mixcQ0sA8v/4OGe/9VRBgmzul5pdQqfUzhjR1HMdja5w
X-Google-Smtp-Source: ABdhPJx+ML04f25G5VsTuIXeBdWPUbvoa0atWPDfl83elaTQ/sysZhCBLgpdEFE6ZItSg3B69IzPh1wlzd+Vy/5dRwM=
X-Received: by 2002:ab0:70d4:: with SMTP id r20mr27885756ual.38.1619682552032;
 Thu, 29 Apr 2021 00:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1013.git.git.1619640416533.gitgitgadget@gmail.com> <xmqq5z05akyf.fsf@gitster.g>
In-Reply-To: <xmqq5z05akyf.fsf@gitster.g>
From:   Joachim Kuebart <joachim.kuebart@gmail.com>
Date:   Thu, 29 Apr 2021 09:48:34 +0200
Message-ID: <CAJGkkrQJFaLPfCBTVn6k1v9cCwF4wEUxr+ZyzebUBQJB8qLaWg@mail.gmail.com>
Subject: Re: [PATCH] git-p4: speed up search for branch parent
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Joachim Kuebart via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Luke Diamand <luke@diamand.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 29 Apr 2021 at 04:22, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Joachim Kuebart via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Joachim Kuebart <joachim.kuebart@gmail.com>
>
> Thanks.  As git-p4 is not in my area of expertise, I'll make a style
> critique first, while pinging Luke as an area expert (you can learn
> who they are with "git shortlog --no-merges --since=18.months.ago
> git-p4.py").

Hi Junio, thanks for your timely and thorough review and for putting
up with my greenhorn mistakes ;-)

> > Previously, the code iterated through the parent branch commits and
> > compared each one to the target tree using diff-tree.
>
> It is customary in this project to describe the problem in the
> present tense.  In other words, whoever is writing the log message
> still lives in the world without this patch applied to the system.

I will rephrase the commit message and give better details as you
mentioned. Thanks a lot for your suggestions!

> When making a claim on performance, it is helpful to our readers to
> give some numbers, even in a limited test, e.g.
>
>     In a sample history where ~100 commits needed to be traversed to
>     find the fork point on my Windows box, the current code took
>     10.4 seconds to complete, while the new code yields the same
>     result in 1.8 seconds, which is a significant speed-up.
>
> or something along these lines.

I will add some measurements.

> > Signed-off-by: Joachim Kuebart <joachim.kuebart@gmail.com>
> >  git-p4.py | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/git-p4.py b/git-p4.py
> > index 09c9e93ac401..dbe94e6fb83b 100755
> > --- a/git-p4.py
> > +++ b/git-p4.py
> > @@ -3600,19 +3600,19 @@ def importNewBranch(self, branch, maxChange):
> >          return True
> >
> >      def searchParent(self, parent, branch, target):
> > +        for tree in read_pipe_lines(["git", "rev-parse",
> > +                                     "{}^{{tree}}".format(target)]):
> > +            targetTree = tree.strip()
>
> It looks very strange to run a commit that you expect a single line
> of output, and read the result in a loop.  Doesn't git-p4.py supply
> a more suitable helper to read a single line output from a command?

You're absolutely right that this isn't very readable. I had a quick
look around for a function that reads a single-line response, but I'll
look again and come up with a clearer solution.

> > +        for blob in read_pipe_lines(["git", "rev-list", "--format=%H %T",
> >                                       "--no-merges", parent]):
>
> This is not a new problem you introduced, but when we hear word
> "blob" in the context of this project, it reminds us of the "blob"
> object, while the 'blob' variable used in this loop has nothing to
> do with it.  Perhaps rename it to say 'line' or something?

Will do, thanks!

> > +            if blob[:7] == "commit ":
> > +                continue
>
> Perhaps blob.startswith("commit ") to avoid hardcoded string length?

Yes, that's the name of the function that I can never think of when I need it.

Thanks again for your comments,

Joachim
