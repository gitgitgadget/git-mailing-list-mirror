Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A4DC2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 23:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DCBC2222B
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 23:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRKuCPY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgKQXRH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 18:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgKQXRH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 18:17:07 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA2BC0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 15:17:05 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id c17so25280397wrc.11
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 15:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1+Jdqevhv3GViwNf1jl3RNvqxCItBTLejrV0G0qRBow=;
        b=iRKuCPY4CivJ2is+in/eOAmT7VHs7pMJyV3fYIB8zR571x9LYmVRQ5OaajHq/Pmu0k
         0o4GOU0C+MRHfZYOXwP8z0vxxBttobJAVPUgAZPk8cW+ms8LDg9rGOL1wMyx2hNxggtI
         EIydknoynwwaZiUDdYxNPW85GsAkrjViOJb7+4I5tdMxmO/yPJ3y5bFIWa57fyozwTQl
         6jQFOgVkjqAGRJ5k2h/RdaYYtz4QiC6vS/f4jgDBQCXhVg080oukhwMN2j5NVbY3xrdK
         Fs9DWiuvMpKCvlRvUjeIBjncgWqQsqWfdMlqAVr0cHEfUBtnVlSbFjXvhQsHEWPZHh50
         Jbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1+Jdqevhv3GViwNf1jl3RNvqxCItBTLejrV0G0qRBow=;
        b=FxF673pPUMqPK+v6JCTTrP52DKBuysUN6V9rHnl5tsoeQm/O2leL4ecgGwhYJJkSx9
         Kmf8juiXiMvGiCgXUqwElRphEVN2bHuVwW1rpHkFNZ7VbL9X21zlV4GqxAPrLvdsM5qf
         +7dNGYgvDFdPTM60wRDKCEsSKq1uxZCXtjmynyTTQ2o/u3gqKwqIgSgffkAi0HL7llnT
         DBBlid5DOFdT0sX82u+I7EOK+lxcRmpNyeDv7PiJ7tigM+Uvu7lD3Qd+HGFzfER8oXGu
         THpWdOSUVN+7A0zGu2Ip+XWoxKNM+hxruiLT3fXNoHKpZDyjTZJ8KHBANwfdHJlSoHPp
         ejNQ==
X-Gm-Message-State: AOAM5320S5IjOE7IIdIGY2qXpeYlJEhtYFy205Ll2tN+YCYnR4dIjmAu
        9mlV9tfLEXHbg+vtrn6aJ2YfgiTUhE20K3rpodI=
X-Google-Smtp-Source: ABdhPJyDusY8K1Ki/rrLd11UJGjlkKL90vYCs+FOghOhGboEzT2F4W9JzSg1noPXPokr0zCFnFUOjaOWD9N7mQpgp/Y=
X-Received: by 2002:a5d:4349:: with SMTP id u9mr1766680wrr.319.1605655024305;
 Tue, 17 Nov 2020 15:17:04 -0800 (PST)
MIME-Version: 1.0
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
 <87r1oraewl.fsf@x220.int.ebiederm.org> <xmqqv9e34mq5.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqv9e34mq5.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 17 Nov 2020 17:16:53 -0600
Message-ID: <CAMP44s3750bSdmw4A=KU=UgffOPiQwB8ECk9YRPe8mh50Og8Ow@mail.gmail.com>
Subject: Re: [PATCH 00/28] Use main as default branch name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 17, 2020 at 4:57 PM Junio C Hamano <gitster@pobox.com> wrote:
> ebiederm@xmission.com (Eric W. Biederman) writes:

> > - The branch name that is somewhat meaningful to the creator of the git
> >   repo.
> >
> >   I have at least two repos where I wound up doing this by hand.  So at
> >   least for me it is something I am doing anyway.
>
> Direct "other side" of the coin is that the name meaningful to the
> creator may be different from project to project, so those who want
> to try peeking projects that are so far unknown to them will have to
> guess what that meaningful thing is.  When visiting a random github
> repository and presented by 47 different branches, it would be more
> helpful for such a visitor to have a reliable "this is likely to be
> the primary integration branch" cue.  Not having a convention is
> worse than having a convention some folks may find suboptimal from
> usability's point of view.

But a convention is just that: a convention.

If we already know "origin/HEAD" is very likely pointing to the
integration branch, then why do we need to know what that branch is
called in that particular project?

Just refer to that branch as "origin/@", or just "origin".

That would work for projects that follow the convention, and those who
don't. Why does the tool need to care?

Cheers.

-- 
Felipe Contreras
