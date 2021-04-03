Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DB1C43461
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 14:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 339906120F
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 14:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbhDCOGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 10:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236380AbhDCOGX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 10:06:23 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3B2C0613E6
        for <git@vger.kernel.org>; Sat,  3 Apr 2021 07:06:20 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id r20so8237077ljk.4
        for <git@vger.kernel.org>; Sat, 03 Apr 2021 07:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uGzqotFSylMnqwVWTXxIWkjpIfKnmc2VyxH74M7Z1UU=;
        b=Bv9Pn5bltR5tZHCoVhhGmAkvw0ixh0rxnymWO4taM4PpHjAK8Frblu/HJp3gqhPa1J
         ou9VQ/PNWfc4vl8uhv5zuLRA9Fp87VwLCem/p1CpqMaxbyiR9lFJumGYGaZ7iUmCOYlh
         HtYBGS1LGsmx1nkNi+Xim7RWQDFmc0YHL1/Vqqp4hP3hn5VuFmX3bZ0x7Z0D+AklwzbP
         +JQqJ0uP3e3VxVizb7indcamgYW/7MrqH+btB/Nr1OTNuYby1zmkqPgrZGKPW4f5+cLL
         OEjKsKWHmbfYpEgZ2CrWH9DNNx8Snd0H0U4htfnnhSUWXiAe6XdOIIqp+bmetdxgPPxS
         9V+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=uGzqotFSylMnqwVWTXxIWkjpIfKnmc2VyxH74M7Z1UU=;
        b=huU9cG5E1Ub6Q9SeYs9TKKyGwi4hTnozuREwjk9ULu//AcePA68Vom4lpqlIMIRef+
         aQlSYv4V0BVMUVzeR7GWoQ4rMDKzq9TAF1OBqz6QVgVoNm1wQyoHypW22CCf/u4wCg/Y
         1FLcXV07FhN+az9Uoa6PnFCcy6LUuCLHchBL99W0fWsRqw0AbkDuz4QnkgAh2YlKtOLT
         DADiIKuYOOV53o5Lb/vuHFDyk9mntAoKbe2FgOGdbOH0AL37g65HTKCAExx8/EOf5wma
         1o+u2gEjlfj+7pKg+Ygp/MVnFycs3d20PFvk5Il8uorYDS5gaDIxakhIgkoBByGx42XR
         gnUA==
X-Gm-Message-State: AOAM532lA/ANVLeNHDxQs7g6Kvb4hg1hv56gHOO74nCrgruR6OwaYd0r
        RmnproMY5idYdPYYBGosRoe87O92FRQ=
X-Google-Smtp-Source: ABdhPJz0nnjwBg3MCXhfXVBws6MbMZneHjwlykQAX/MZgPGdovMv7BfUNSoH6oere6n8UxXnLy9DQQ==
X-Received: by 2002:a2e:908a:: with SMTP id l10mr11391062ljg.38.1617458778351;
        Sat, 03 Apr 2021 07:06:18 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id i4sm1152566lfv.161.2021.04.03.07.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 07:06:17 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     ydirson@free.fr
Cc:     git <git@vger.kernel.org>
Subject: Re: git rebase --rebase-merges information loss (and other woes)
References: <1874143044.520636715.1617442122946.JavaMail.root@zimbra39-e7>
        <1054682599.520899173.1617446548600.JavaMail.root@zimbra39-e7>
Date:   Sat, 03 Apr 2021 17:06:16 +0300
In-Reply-To: <1054682599.520899173.1617446548600.JavaMail.root@zimbra39-e7>
        (ydirson@free.fr's message of "Sat, 3 Apr 2021 12:42:28 +0200 (CEST)")
Message-ID: <87zgyfmpif.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ydirson@free.fr writes:

> I've been going through a couple of "rebase -i -r" lately, and would
> like to share a couple of thoughts, starting with something looking
> like a bug.

I feel your pain and sympathize deeply.

>
> 1. when a merge has been done with "-s ours", rebase replays it without
> any special options, I proceed with the manual resolution, and if I just
> --continue, the rebase mechanism believes I want to drop the commit, which
> could not be more wrong.  I can still be careful myself, and use "git commit
> --allow-empty" before --continue, but this feels awkward.
>
> Is there any compelling reason not record the merge here ?

This looks like rather easy case to fix indeed. I mean empty commit
issue, not the original cause of the problem.

>
> 2. more generally, when a merge has been done with special options, it
> would be a useful help in solving conflicts if rebase could use the same
> options.  Maybe we could allow the rebase "merge" instruction to use more
> merge options.  The user would still have to edit the instruction sheet
> manually for those, however, and we could then want "rebase -i" to fill
> them automatically, but that would seem to require recording the merge
> options somewhere to start with - maybe in a note.

That could help now an then, but doesn't solve the problem in general,
as, first, the behavior of merge algorithms could change over time, and,
second, the merge could have been performed with external merge
algorithm in the first place, including entirely manual merge, and after
all, the person rebasing may have no idea at all how the original merge
has been achieved.

Recording information about merges at merge time has similar problems to
recording information about renames, both being "obvious" solutions that
in fact end-up being sub-optimal.

Fortunately, we still have the original merge handy, that Git simply
doesn't care to take into account, see below.

>
> 3. while it's made clear that any conflict resolution and amendments
> have to be redone, maybe we could provide some support for a common
> use case, namely "sink that commit/fixup down".  The conflict
> resolution would then be like "checkout $OLD && cherry-pick -n $FIXUP".
>
> Maybe this could be activated by a merge option in rebase-interactive
> instructions, like "merge -C$OLD --fixup $F1 --fixup $F2".
>
> Would that seem reasonable ?

I still (as this has been already heavily discussed some time ago)
believe that the most reasonable solution to all this is to rebase
merges rather than to throw them away. Redoing them, as Git does, is
wrong choice in most cases as what it means is that Git, despite the
option name --rebase-merges (and even better old name
--preserve-merges), simply still throws away your precious merge
commits, only then it substitutes something potentially entirely
different for them, often silently.

In addition to the problems you've encountered, silent drop of user
content is possible, and what's worse than that for a content preserving
tool? As a result, to be on the safe side, with current approach to
handling merges during rebase, any non-trivial merge that is expected to
be rebased (and how would one be sure it never will?) is to be very
carefully performed in 2 commits: merge itself and fixups, otherwise
chances are high fixups are silently lost during rebase.

Further, even this two-step approach doesn't solve all the problems. For
instance, issues with merges being originally performed with non-default
algorithm still remain (as in your case 1.) Moreover, if we notice that
default (or any thereof) algorithm itself could change over time,
inherent problems with the policy of recreating merge commits from
scratch during rebase get even more obvious.

Overall, to get this right, Git should finally refrain (at least by
default) from generally hopeless attempts to re-create merges from
scratch on rebase. Instead it should try to actually rebase existing
merges when user asks to preserve history shape. When and if automatic
rebase fails, one of the options to resolve the issue, besides fixing
rebase conflicts, is indeed to redo the merge, but then the user will be
perfectly aware of particular re-merge, and will be responsible for the
end result himself.

-- Sergey
