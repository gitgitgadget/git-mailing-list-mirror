Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36BDC64E7C
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 15:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 619E621D7A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 15:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbgLBPur (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 10:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbgLBPup (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 10:50:45 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47929C0613D4
        for <git@vger.kernel.org>; Wed,  2 Dec 2020 07:50:05 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id d18so4417410edt.7
        for <git@vger.kernel.org>; Wed, 02 Dec 2020 07:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=DITKmTkJTpXJMLylxh73UiV925SdNE05iyrZzWGj7so=;
        b=K62YWkaRgM6hdFvl1fuocZCw/jWLNMuK5MKCd0MZixg28LUUVe2Z1YSi5nkd8T70o3
         TYw+gQalvGA7vq0Xlyka9Q47C19P3xnREPsDBDoYaFopJu7zOtGdcc0Kb3DK55GP5nhN
         6TqxLA1akijr7eLQGQSxDMpEA5LU2WCG6EjnEB9xdXFFc4YKQg4v+XKnvKxEnq/WyPHi
         KXtRvlu5ReJqc++EmdULRFOhWjFPXMFwyfRZzYX987M1sKd7yZV0j7h4igk1ieDzlDCp
         xSs3JEpFnEL2rMscfPk5q/OKXvb23IUO4Ape2KDw4XtO8E95CwByirSu4nlkN4xmHZ1E
         Nn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=DITKmTkJTpXJMLylxh73UiV925SdNE05iyrZzWGj7so=;
        b=ubeK6nrKkeDGZITb6Hxt4ScFsSndxRhUGVAkA8noDj9WrQDOsp0+7c7CURx69CwzCs
         IWWRa/Y4gPNdTlzFoRbNgdGrir5PW3iALlmaF0wX/kMjs8BuG4+yoWJbh805neG3aKLD
         7yqyWTKgqXRH00gjuN5jQL5XNdRH6BxQfNwO20jldXXid4Wt6g0mYn/P48QXkXqd9+Mw
         fkwOnGvoJESTlbU0l8/moXGAmKP6KrijAkdxipHxuDEhvoKSxwRraYhRgldZ6uxACdSR
         S/rfHO37hWP+Magrp6hIz4QgEQDt6uz66kp0Jwr0McFgts1iuO0I0QArhb/oZ/huwflD
         QAPQ==
X-Gm-Message-State: AOAM5315SEEn2W0ugRX9J73d6FUIy6jFQkqQUaHM2dkuTm6ohv/mX1hS
        49h4Yrz5SOgYm84oy8clUAFNJwTMk5o=
X-Google-Smtp-Source: ABdhPJwStdMMjbB02siTRHelIwNgvkQtQyOUCbIxR1L8yzMdBlkE+BN0sHVFLV0QETIWjFPwnunMcw==
X-Received: by 2002:a50:e0ce:: with SMTP id j14mr552760edl.18.1606924203769;
        Wed, 02 Dec 2020 07:50:03 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id s9sm218905edt.51.2020.12.02.07.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 07:50:02 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Kerry, Richard" <richard.kerry@atos.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Can I Insert some Ancient History into a repo?
References: <AM0PR02MB40811C5C2E8B13B63D06E4B49CF30@AM0PR02MB4081.eurprd02.prod.outlook.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <AM0PR02MB40811C5C2E8B13B63D06E4B49CF30@AM0PR02MB4081.eurprd02.prod.outlook.com>
Date:   Wed, 02 Dec 2020 16:50:01 +0100
Message-ID: <87o8jcus0m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 02 2020, Kerry, Richard wrote:

> I've read up on merging repositories and I can easily get L1 into the
> same repo as L2, as a separate line of development.  However, merging
> it is not the right thing to do, as that leaves me with L1 and L2
> having separate starting points, with a merge leading to there being
> only one head.  That's the opposite of what I want - I want to keep
> one starting point (that of L1), and branch L2 off it (with L2 ending
> up as master).

I've brought in existing repos into other repos like what you describe
you shouldn't be doing, "git merge --allow-unrelated-histories" exists
for a reason, you can just use it.

I do think you're starting from the wrong starting point though, maybe
not in your thinking, but your post just says you want to combine these,
and how to do it.

The reason I've done this in the past is for some practical
reason. E.g. you might want to arrange it so a "git blame" or "git log"
on a file traverses down the right path & history, or to be able to
refer to commits by SHA1.

Depending on what you actually want to with the end result merging or
using grafts might not be the best thing to do. E.g. a perfectly OK
thing in some cases is to just have a side-repo somewhere to keep the
old history, you can add it as a remote to do some ad-hoc inspection,
but never need to push a merger of the two to the current active repo.

