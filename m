Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0788DC0018C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 20:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D870D233E2
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 20:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgLPUon (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 15:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729065AbgLPUon (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 15:44:43 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891A4C061285
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 12:43:43 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cw27so26303750edb.5
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 12:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i5OlR8v2Y2tD794I8WCNOutxVKLEW3GEtY3moHczwSQ=;
        b=sFFF8u0GG2Jq99XZuoHLXlp/f5qZ3szUQ0l+8SYq9aXPhI8r5luNQp5mJ1lLs0p4wJ
         HpG15Ij97AxpWMFyS278ojoT1DSqGLwN0VO4SrglcKVCxXpt+yhHEa3cw1N+EPf2gcAS
         yw5s51LHxGMhMXXi3eckl3JKZwaszuxb9utJBgWHvMb4GP0FQUi6kY5+HGlBlHJiansJ
         bH3EurNkBSqUu7ctF4xA9NovCG+zY43GtVp49/gmPUDo8OV8fB7UdDmaGef7meg9sHgI
         W+ttOh4wTDputqyWv8MT42f/XpshHT5v5Vb4NykHlsX8T6Sd0bg67zl6GPbn6fhw1eM8
         5gbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i5OlR8v2Y2tD794I8WCNOutxVKLEW3GEtY3moHczwSQ=;
        b=PmW9Lqjdyleto9tGnlQKZa7r9jE5fHuNh4qliEPyBbAFc+KY07lKbsSjUcqzDeT67H
         A51sNkgpYqKSmtWfSjVKFmUrG2SRWAQrIxMm3mp+yx1oD38/7NJfDK2KI1yVz0vv8PBG
         re66zM0RwoC8yj3eXQuSo4qiwUXSV9FARO7+4wcnni1pGbvUMTCvDuiSj7lwKv7IjO75
         yeL77flZuG898q7fZHMiuN8pHO+iX/J2fDpchTbc2Xf5SxnFxadSP54aWTLvwEgvHKMc
         zmXJZlqR0sVQtSZo5NCpP6WH6CDH+tEM/AvAOfdjmUE4Txe46G1AUSZxmLcnUSDS1N2f
         PduA==
X-Gm-Message-State: AOAM532XKGXero7xk92i+2Jy9wfcCMZykVqY8IPYCcND7kqKAfCIUGsd
        0QPle/OMTg4NRcCjYmu2qkajYu6+rkyw5yGajHk=
X-Google-Smtp-Source: ABdhPJyn7x/z1uJn8T79GIxwax6IPjk/s7iMnXQ9h2zWM66wWWWi4ExxNsFr7GPG+pfwYgXmawDKxpUmUqa1lOHz46E=
X-Received: by 2002:aa7:dac5:: with SMTP id x5mr36248447eds.198.1608151422340;
 Wed, 16 Dec 2020 12:43:42 -0800 (PST)
MIME-Version: 1.0
References: <CAPQE4+qq11W9VzftJ6y+cbdJ1x64c8Astjwd4z4M-oc5hv1jeA@mail.gmail.com>
 <xmqqczza7lpm.fsf@gitster.c.googlers.com> <X9pe119edtL5KQTU@coredump.intra.peff.net>
In-Reply-To: <X9pe119edtL5KQTU@coredump.intra.peff.net>
From:   Stuart MacDonald <stuartm.coding@gmail.com>
Date:   Wed, 16 Dec 2020 15:43:31 -0500
Message-ID: <CAPQE4+rhWT9kgusNXOw5cnJ-oFq++4G1FMaXvQ3wppQ0GE0hSA@mail.gmail.com>
Subject: Re: [Bug report] includeIf config is not displayed in normal directories
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 16, 2020 at 2:24 PM Jeff King <peff@peff.net> wrote:
> Perhaps. I have no objection to adding an option like that. But I don't
> think it solves the fundamental issue in this bug report, which is
> asking "what will the config look like in a repository that I created at
> this path via git-init or git-clone?".

My fundamental issue was "git is using a conditionally included config
option core.sshCommand while outside of a git repository, but git config
is not displaying that config option when I ask it to". The good news is
given the discussion in this thread I can now say that I was labouring
under a misconception about how git clone works, and what I thought
was a bug is normal expected behaviour.

My old understanding of git clone:
- create sub-directory
- create subdir/.git and whatever initial states are needed
- clone the repo from origin into the directory
- all never having left $CWD

It's actually:
- create sub-directory
- cd subdir
- create ./.git and initial states
- clone the repo _while inside_ a gitdir
- cd ..

I would like to suggest that the documentation for either or both
git clone and includeIf could be improved to talk about this case so
that others having trouble with a conditionally included sshComand
during cloning will not have to relearn the wheel.

I believe my misunderstanding was partially misled by the fact that
despite the documentation for includeIf talking about it being a gitdir
the part of that path being matched is not itself within a git directory;
~/work/git/git/.git was the end result, ~/work being the matched on
part of the path and not in a git directory.

> Maybe Stuart really would prefer to change his config to "whenever I am
> in this directory root, repo or no, use this config". It does have weird
> corner cases around "git --git-dir=/path/to/repo", but doing that from
> another directory is perhaps rare enough that people using a cwd:
> conditional would be happy to ignore that.

I do not. Hopefully this thread will also assist future includeIf
trouble-havers.

Thanks all, very much appreciated. I consider the matter settled
as 'working as designed'.
