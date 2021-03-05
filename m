Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4053AC4332B
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 17:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE056509C
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 17:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhCERI2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 12:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhCERIO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 12:08:14 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17F5C061756
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 09:08:13 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id c16so1737183ply.0
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 09:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qYWngMD5x1u5WxC5b6JqdMZ4OU/J+IO09UXg83AH7Hg=;
        b=kSB3cQGTMr/JfquqvA+d3DTmRMnDLX18Ju7qd9bkp0IfzowiyNH/wBdnbJo/tg5hdR
         kO8EX/x066J6MeCdOkj6QAGUNumgucYqRsiLQkPdHCZaOT/w3Nwhpxn+FSCFIkXqwEMj
         CLZ7XNiyioqxKUafb8BdwUQ/GM0ON0hTaiGrkE0os6OgneciVychHMhYfdEnb0EK5yTV
         qWbj2bRBYPYnBixECfujqtdie0+DSttJ8IxKom8Gz6PijZel3l8spqy4OhKulsWJcxI6
         d+kdkPjDtPmI1I2ytPvn83prpViPgHryFUdBdm8calFd+WPWzJx5p6RThxW35ELMjL41
         wPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qYWngMD5x1u5WxC5b6JqdMZ4OU/J+IO09UXg83AH7Hg=;
        b=Pnu/Uy+wPi2HiWpn27fZZABq2ReYSLVhi9V7OthPaTqKskrTYEXW+SopiQikU3p9C5
         Z24BTX5+aYd1fmORMJrFWNE9Xpt0G3nW7ri2O5axZrKEQqxf64WT9HVm4JD2qNWjx2sC
         HPowlW4NDBIos1P4bf4oYQfiiVBEnqm7VH7sO0z5Evrz5ZIzSit3N0MZlke3X3VrB3hA
         IjoNmgFPJwg0FuUw1zAgggoiNtwd5Cq9mxxbouJ3khLbulFEbPKH3ds0n1eCFSJyt2G5
         TeW3UES/Qv96+s7AY8Gz7CIBmyzbAQ53zLgZZhFYn2K1K4C/+G6nkaC51DH508XCfpYz
         7kig==
X-Gm-Message-State: AOAM532Fi0zFAN68fIYf2f2JWVNAQ9bn0SWLKfBOxlKsolaGtlUHVftz
        s75fA0gtxrYNOJtNkiv+Z5IyIk0EXFBySMYabVX/GyYkR6Y=
X-Google-Smtp-Source: ABdhPJzCj8otonJTIEP36gUTudCsfRGHbI7Nxj2e3vlgABuTaM/Jlvx3KMXqRStuDfopHxOrsoKg/YhMPsHxP+GdVwM=
X-Received: by 2002:a17:902:bc87:b029:e3:aae4:3188 with SMTP id
 bb7-20020a170902bc87b02900e3aae43188mr9961168plb.56.1614964093597; Fri, 05
 Mar 2021 09:08:13 -0800 (PST)
MIME-Version: 1.0
References: <CAPhpCMJ-u+W5+6ckazo7JkeaPhkpGP_6hOSJcggor0CcYgU95Q@mail.gmail.com>
In-Reply-To: <CAPhpCMJ-u+W5+6ckazo7JkeaPhkpGP_6hOSJcggor0CcYgU95Q@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 5 Mar 2021 18:08:00 +0100
Message-ID: <CAN0heSoE2-xPaAZSB5A12=QDOPZpsGoR-FqmFKuc7OC79wH=FQ@mail.gmail.com>
Subject: Re: Found error in documentation, looking for advice on how to start contributing
To:     Dominik Lameter <dominik@graphe.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dominik,

Welcome to the list.

On Fri, 5 Mar 2021 at 02:04, Dominik Lameter <dominik@graphe.net> wrote:
> I don't know if this is the place for this question, let me know if I
> should send it elsewhere.
>
> this would be a simple place to start. I've read through the readme
> and Documentation/SubmittingPatches document, however with the
> https://github.com/git/git repository being publish only, what git
> repository do I base my changes on for documentation patches?

You can certainly clone from github.com/git/git, no problem, or make a
fork. The "publish only" remark means that commits/patches don't reach
that repo through pull requests, i.e., they don't really enter "through"
GitHub. Rather, they reach Junio (the maintainer) through this mailing
list. He'll carefully collect the various topics flying around here and
turn them into branches, and publish those at various places, one of
which is github.com. Thus "publish only". Anyway, long story short,
you've found the right place. :-)

And all that said, there is a way of making a GitHub pull request in a
way that it reaches this mailing list: GitGitGadget. I saw that Emily
referred you to MyFirstContribution.txt -- you'll find more there.

By the time you feel ready to submit a patch, feel free to cc me and
I'd be happy to try to review it. And even before then, if you have any
questions, just ask. :-)

Martin
