Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6FBC43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 17:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066362077D
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 17:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afTz6/t8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390087AbgDBRke (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:40:34 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33926 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390082AbgDBRke (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 13:40:34 -0400
Received: by mail-ot1-f68.google.com with SMTP id m2so4367733otr.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 10:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6lPIgW6PmyPpHuQFdyrgDYB1bkpXfXHFGrN06MziFnM=;
        b=afTz6/t8Ql12w7gG09yyNnGYZghsGA3+ru+7Zo3/+OJ7pZk79OfnIgAIB/Gs/pAKop
         uL9WOnxRwO0dwOXFaMWV46dExBEjzqNn8F1//uTIjk4TwHcBmWoH0ur0eUgvqhOWt1tc
         Y3L2ew1qvnRAcbLOGIKyyc8b64OaYG4SHbNO68EdyhoMntE3z5+3fJ8GgczzAFeIKymo
         qy+M6thJSczDxYV1wC95wxBrLXlzj9j8hhbg12jwUtpUQMmFSizbkzTTHbyin+S9mqic
         ECfsZ/4MfgHEgbOkynuAcRy+ZegrSrGOd5FDnGXdjjJfDsMhCK/YEUao5wbrLE7rdzpR
         tHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6lPIgW6PmyPpHuQFdyrgDYB1bkpXfXHFGrN06MziFnM=;
        b=NGADofC3TxlTRI4yNFTmQJs5BNwR5obPdEBnKEsvyDlIuUV1t5b2dxyv6RxzwiD4F1
         WbSoWrB2DfNte3l7t2m7JkDaIdpF9AcCwlFXgtBocrlrbnTLceGSgK60NiiTp5oU7GXe
         A+xIlXWPReshI3vm9v1Q0zOMDO+szfr7RiYfoIESHPY4lSn/WYAXomRt6exqLVu0yVxZ
         Fh4kl3ZxYAg3RoScbuJBK6kYegzmmuq726/cI5fUa8iaAsjLcAW5xtCZIupnzAjF2haH
         JofxdDvghWUwvN5l8/+Mei58P/L99NtAGrnCWKfO0wJ6SG+ZsXbRGMsJv8KxeYRLfyc+
         i8Sw==
X-Gm-Message-State: AGi0PuYVddVIMCDlJwhyLCcVZi3S3N6XqhT+M8TbNZf5fkk79iP1j7vR
        gVFv6Tv7LYhGOgF9LpzWoLvAGkUMYlHEvjjzR5U=
X-Google-Smtp-Source: APiQypJV7W2wMe/n4WFQHiAMTQup/AWORDCu1Bbndw0hAPNhSSRLUS7urrtA9tjIB9SULanjsHTa+PM+BRCPu45it7g=
X-Received: by 2002:a9d:5e0d:: with SMTP id d13mr3408478oti.162.1585849233291;
 Thu, 02 Apr 2020 10:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.746.git.git.1585773096145.gitgitgadget@gmail.com>
 <24197.9157.362143.972556@chiark.greenend.org.uk> <CABPp-BGo=6W5wfba7us8ca3eAfz04v8WxyOQ96DkoXn2fV=J1Q@mail.gmail.com>
 <5c5532ac-7df5-e8ef-9122-f015783427c2@gmail.com>
In-Reply-To: <5c5532ac-7df5-e8ef-9122-f015783427c2@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 2 Apr 2020 10:40:22 -0700
Message-ID: <CABPp-BGPFTOX75CfWwJxcoBMs_DC3xBXOBDeqFE5439v0fqBZw@mail.gmail.com>
Subject: Re: [PATCH] sequencer: honor GIT_REFLOG_ACTION
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Paul Gevers <elbrus@debian.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, Apr 2, 2020 at 2:39 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 02/04/2020 06:15, Elijah Newren wrote:

> > As a heads up, though, my personal plans for rebase (subject to buy-in
> > from other stakeholders) is to make it do a lot more in-memory work.
> > In particular, this means for common cases there will be no subprocess
> > invocations, no writing of any state unless/until you hit a conflict,
> > no updating of any files in the working tree until all commits have
> > been created (or a conflict is hit),
>
> I'm with you up to here - it sounds fantastic
>
> > and no updating of the branch
> > until after all the commits have been created.
>
> We only update the branch reflog at the end of the rebase now.
>
> > Thus, for the common
> > cases with no conflicts, there would only be 1 entry in the reflog of
> > HEAD the entire operation, rather than approximately 1 per commit.
>
> This I'm not so sure about. In the past where I've messed up a rebase
> and not noticed until after a subsequent rebase it has been really
> useful to be able to go through HEAD's reflog and find out where exactly
> I messed up by looking at the sequence of picks for the first rebase.
> Specifically it shows which commits where squashed together which you
> cannot get by running git log on the result of the rebase.

Interesting.   Hmm....

> > I
> > have a proof-of-concept showing these ideas work for basic cases.
>
> Sounds exciting

Feel free to take a look: See
https://github.com/newren/git/blob/git-merge-2020-demo/README.md and
https://github.com/newren/git/blob/git-merge-2020-demo/builtin/fast-rebase.c

Sadly, between sparse-checkout, expoential slowdown in dir.c, and
various reports about rebase for 2.26, I haven't been able to work on
that stuff since the morning of March 4.  And I've been ignoring some
non-git stuff that I really need to work on.  But hopefully I'll get
to start cleaning things up soon and sending them on to the list for
review.  I keep hoping...
