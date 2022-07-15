Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E22FC43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 13:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbiGON3P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 09:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiGON3N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 09:29:13 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3704629836
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 06:29:08 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eq6so6286938edb.6
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 06:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=hJvTH+IWV2FJM29MBCVpSoanNCbtE+v64bfipaOXo8Y=;
        b=bGy1CdtpAIcnaRoxNQ44hsA8mSGXFUmoaau/uIs6pqF+L6aS6KMEgsTlpkOxP2BOdV
         7EiVj7v9FxOxQX1bQwUGxBGQNq8TiPbL+IxP3FUfCtyRccPR7JqJx3iiI3hAjhjtYan0
         mYXPuhNbyMjPel9NLM8RBuOh/6gjujnWAF/rc+slw2ZnL+a/aBse2y67sxw8/thVv1jf
         9tRQQJqd0NY8Ck602j65L0T6U141BSt5vFl3dXPkYI/ZifZP4Q0XTXwy3InHZS9Z05zI
         I7cCirw89bkkeJ7Pt7/em4MPYINppcwg4Xvd92z0evfCFT8fSDRC0PSx3sMiTTxFKLpc
         lrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=hJvTH+IWV2FJM29MBCVpSoanNCbtE+v64bfipaOXo8Y=;
        b=Y3ygDi6J4/QyAInlRD4TjCSIMDRpWRzcrHWKHa16Vmjrfr+44mvjFV6HY6IqV5dQiy
         fKIx0BAuylgaxr1BXhOGEjAsFm+8hzEmu63J5qYy6EDs30wunkxZescbthfgrGtpEhyP
         oWh4JnevwdCPdl88i21ro5K0p1HBBnUladj5xhybNitN5LzVvrWes1bdZPcWel2MRjvH
         y2zlDNaX8Z8xhkGrTrhP2CVsOlXbzID4DRi3Xl90cyDqiwj9bNbCsqVKAb9y9iSVrejO
         CrWOeGysmlAlwqFUe4NmXXBEPRAUGTOCj5kaVYQY2JjeJu3z1Mw2A8kGBB+AJzqujXAw
         Pc6w==
X-Gm-Message-State: AJIora+TGGvjBCHooN2Vf7A3Ny35yIesDoTRNTwteyILSr/0W8CqNLUc
        XhO8m9+x3sUqDamGUkCZGAV27PJ0LsWlgQ==
X-Google-Smtp-Source: AGRyM1vqi4XqZL0HkI1JCi4rQEdZSzxn596onEXCghAEaFkxgzE/dEUllNJVF4EMt9545lzj/ExNLA==
X-Received: by 2002:a05:6402:2741:b0:434:fe8a:1f96 with SMTP id z1-20020a056402274100b00434fe8a1f96mr19165396edd.331.1657891746639;
        Fri, 15 Jul 2022 06:29:06 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709066d5500b0072a4bb6bce8sm2028336ejt.168.2022.07.15.06.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 06:29:05 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oCLNQ-002kgm-BJ;
        Fri, 15 Jul 2022 15:29:04 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sim Tov <smntov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git: detect file creator
Date:   Fri, 15 Jul 2022 15:22:23 +0200
References: <CA+X_a+ycefqvz0LaO0KK1LuTqgE=iUhooPRXeo3mq-zXkp+nCA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CA+X_a+ycefqvz0LaO0KK1LuTqgE=iUhooPRXeo3mq-zXkp+nCA@mail.gmail.com>
Message-ID: <220715.86fsj2zeqn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 15 2022, Sim Tov wrote:

> Hello,
>
> I run a book digitizing project and pay people certain rate per 10K
> characters for the text files they upload to a git repo. Till now I

It's nice to see that someone still believes in The Mythical Man- Month
:)

> was using following command to detect files authored by CertainEditor:
>
>     git log --use-mailmap --no-merges --author="CertainEditor"
> --name-only --pretty=format:""
>
> Then I would pipe this output in `wc -m` and get amount of characters
> authored by CertainEditor and pay him accordingly. Usually editors do
> not touch each other's files and everything worked well. However
> recently one editor spotted a typo in somebody else's file and
> corrected it. This behavior is actually good and I would like to
> encourage it. However, now the command above lists the corrected file
> also as his, and so he gets paid for all the characters in the file
> while he changed only one of them. This, obviously, is not good.
>
> 1. Do you have an idea how can I list all the files **created** (not
> authored / committed) by a user, so I can implement a fair characters
> counting?

If you want to adapt your current script perhaps --diff-filter helps,
but...

> 2. Maybe some commit hooks can be used that will check whether the
> Author of a new commit is different from the previous one and if true
> - override it to the previous Author?

..it seems you should fundamentally stop using it, and instead iterate
over the commits, and pay for a "diff". Then you'd get the original
change, as well as the change-on-top.

> 3. Those small changes by a non-creator may be left not paid for (as
> this action is not so intensive and may be reciprocal), but if you
> have a good idea how I can pay for the "diff" the non-creator provides
> - it would be nice!

Just wc -l on the changed files(s) before & after, and pay the abs()
difference.

> Do you think this "diff" should be deducted from the creator? And if
> yes - how?

You could walk it back with "git blame" I guess.

But you might want to consider the economic & social mis-incentives of
lifting money from your co-workers coffers by pointing out a mistake to
them...

