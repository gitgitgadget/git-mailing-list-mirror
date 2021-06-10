Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4954C48BCD
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 03:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C31613C8
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 03:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhFJD2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 23:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFJD2W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 23:28:22 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42683C061574
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 20:26:12 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so26168991otg.2
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 20:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=YIV/km7W1itUzdY2cggytw/SDUl0SQjDizJsd7TwOx8=;
        b=A1Ka1ki4jJkPTF7tnT+Eblux3/+A24hLIsBI5w9A9ZG3l73vfBWbFTT15AJ1sS2gzq
         v2Bopk11fpAggxUc46ZQInybAd51/X8kiH8XTMi7zV+QhPeavqC61cTYmrRJFZ3gk6W6
         PjPG360s2gnjyqbLdsLywxnXXeEkFkxBPnCJGw3J89bzcDj2oz7RARPp2NwRZ0Z6T+cv
         9gOhAgWJY4FtVFk8mxi71ulwJYo+UWxFtD0cczSEbKQb7J2EVJLHsAmDbfK4iRbeN2Me
         phtNonhejQlcwlAMhXMKUZMrIsILwKvnB0kwhC+YtS+Gfwd+NZrk4glOEjQAJGYo+HOK
         s+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=YIV/km7W1itUzdY2cggytw/SDUl0SQjDizJsd7TwOx8=;
        b=SJiU36aTllnSwtX0bKlfurpbi4B7PPq06ShZjjx9C00LgxJbbBpaTw6kd0JSNLmSjl
         fcPWTSZ8AiejSMJqiBb2ZjoFjZDx9ZdIGIPlPsOVLe9i36qi5uMiv2StVKEF9Xmo6b1B
         1JUxRspANBCtF3ZyRhXSbc5i0y5XVTcHxx4PWDXXBc6Mgi4NXatIXbeOGs335T9fOQ6s
         G9Wkfjjm2Jo0vNxo6wGcGOinGP2p7I3qrKHnESt84c7PYsXBIp0vHzWHiFO3kEfbj6U2
         lvRrP/5R/uBYEKh7OnGsKm6gIQurkHcIVYItJT8y9At6pTKsNFuFTv5mSKca6hccORqB
         J5nQ==
X-Gm-Message-State: AOAM533hheInB97EaJSmAyRWCST2pbc+Zi3Bcl1DBmaaU61Cx1zkPPfd
        KmKjBzxv7+Wm0nHjVAr4kgY=
X-Google-Smtp-Source: ABdhPJwbH0jHji06oFw90rwDyJDUJwKSIJ8xwE6S7JyiCJZMapSu+4yRnv3sXSkV0sJzX3iH9np7Mw==
X-Received: by 2002:a9d:7254:: with SMTP id a20mr658990otk.142.1623295571596;
        Wed, 09 Jun 2021 20:26:11 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 184sm338527ooi.3.2021.06.09.20.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 20:26:11 -0700 (PDT)
Date:   Wed, 09 Jun 2021 22:26:09 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "Kerry, Richard" <richard.kerry@atos.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60c18651e2e78_af4cf2086a@natae.notmuch>
In-Reply-To: <AS8PR02MB7302955796AAEF8B9063505E9C379@AS8PR02MB7302.eurprd02.prod.outlook.com>
References: <20210605011339.2202-1-felipe.contreras@gmail.com>
 <87czt059sn.fsf@evledraar.gmail.com>
 <YLv8NWL7WfBRkiGe@coredump.intra.peff.net>
 <60be41f6473e2_39c0a208f6@natae.notmuch>
 <YL8KiiGXF8LdGmQ2@coredump.intra.peff.net>
 <60bf1997b1a72_1a2ac520865@natae.notmuch>
 <AS8PR02MB7302DF058D13CAE11A1086FD9C379@AS8PR02MB7302.eurprd02.prod.outlook.com>
 <60bf36f24d2e2_1a848720836@natae.notmuch>
 <AS8PR02MB7302955796AAEF8B9063505E9C379@AS8PR02MB7302.eurprd02.prod.outlook.com>
Subject: RE: [PATCH] branch: make -v useful
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kerry, Richard wrote:
> > Do you always push to the same remote branch you pull from?

> [RK] Yes.  There are two people doing most of the work , me and one other.  We each mostly:
> [RK]  1.  Are not working on the same things.  Ie we don't generate many conflicts
> [RK]  2.  Pull and push to the same branch.  Ie each of us has a branch that we work on.  He uses "master", I have my own (It is a single very long-lived branch - I know that isn't a recommended workflow but that's where we are for the moment)

I call this a two-way workflow.

If I understand correctly each of you have your own branch, but you both
pull and push to your corresponding branch (he to his branch, you to
your branch).

> > How about rebasing or merging? Do you use the same remote branch?

> [RK] Merges are infrequent, but because we are working in different areas, we merge to "our own" branch (few conflicts, usually) and push to its remote.

This is crucial. Is the local and remote branch always the same?

In other words: do you always pull from "origin/topic", and push to
"topic"?

Or do you sometimes pull from another branch?

> [RK] I have never yet done a rebase, but need to do so soon as there is work in an area that we have both worked on.  Then it will be pushed to the usual place - ie the two branches mentioned above.

When you involve another branch is sounds like you will be in a
triangular workflow.

You would be fetching from remote branch B, merging to local branch A,
and pushing to a remote branch A.

> [RK] So basically, no, not triangular at all, if I understand the meaning of triangular (pull and push to different remotes).

No, once again: triangular workflow doesn't necessarily involve a
different remote (although it usually does).

You can pull from branch B from a central repository, and push to branch
A from the same repository, and that would be triangular, not two-way.


It's understandable that users are confused about this--since in fact
many developers are confused too. It would be nice if git had some
documentation about the different workflows, alas it doesn't at the
moment.

Basically in my view there are four workflows:

  1. Central - two-way: push and pull the same branches from the same
     repo.
  2. Distributed - two-way: push and pull the same branches, but from
     different repositories (master <-> origin/master,
     topic <-> github/topic)
  3. Central - triangular: push and pull different branches from the
     same repo.
  4. Distributed - triangular: push and pull different branches from
     different repositories.

It sounds to me you are mostly in #1, but soon dabbling into #3.

Cheers.

-- 
Felipe Contreras
