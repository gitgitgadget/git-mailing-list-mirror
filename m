Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0224C433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 11:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8812A61183
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 11:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhJTL0j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 07:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTL0i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 07:26:38 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070E7C06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 04:24:24 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r18so25127939edv.12
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 04:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=lgS0dPETzk6YCxUNRS+MmMOO21vsqkJh8zoEsZZl6LU=;
        b=Mv6E5MfhmSBsvlyv5RStyKSNlgQxN+OVr/BQEsqTbhKodXtoHzipY9/2UOnwGlSljc
         5M/kx6Sysgx3cfEMsDGU7EZbj4eV7HNmAZFileHM+iZQAV3gmEKybmatk2rnbnEzbh5G
         nCAVtqyLzyRzlbQ7ZG61ksJoyhl/LpLQ/PjeI8+JMQoRl8Wb+J8VU0YzYeQeCb6TF6Y9
         wxsixHP80FgRqFeoDLvMXuMkKWjyyYjonMDrxVOEXkZNqLoS9PKiQEVKjWRzbisWCBSs
         VXdDvuUJIiJbp3hfksbt5+L5Yp42I0sYBJ5VVBq6Xr6fQW7iEp5lzGCR6+7cbWYqqsqe
         nHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=lgS0dPETzk6YCxUNRS+MmMOO21vsqkJh8zoEsZZl6LU=;
        b=eJL6pNq0eN2ZfPKfaFISYCajkloChBA+gQ0QngZxURyU5dt/5LgCM6J2ui82RwfhCY
         5YAWMPTX5ihfkenFTF33P51Akuod/Y1VohPdkHb0CNw/EhloyHwpFTA0/mjZlQC0bHKD
         tHVrikMZy7Q9p6oNAEqgFwLIhusLPDM3kz2EewZMp9s2cRAQUWnjXQrMDdSRgkqDl0Ef
         VwzeEO7swOPFeP11OXUxTlKXbfkyPLOLREVoX26RXUWA07u6SYADmOfvOhMDjgpAjAkk
         dI3DD1EBgwZIZ5goyu33pPCLiV/T81WN8NqB+g0jdJamN4+ieAPWd47e5qZIoZv2uphJ
         KyRw==
X-Gm-Message-State: AOAM532ihnNdLZzOfUmyrAX+cA3IxBZXdw2HoFeSc8JkMkeDn7igTyI5
        DGsVGyjW9byLdjPjsIn2vpo=
X-Google-Smtp-Source: ABdhPJzDC5VyrtAIiFlpGQYSM086dMeLOuoVrChBYeqGYm7Y1q74lPoTKb6I2Cr9ElG+aEA6wjMgxQ==
X-Received: by 2002:a17:906:1f95:: with SMTP id t21mr44641024ejr.234.1634729062174;
        Wed, 20 Oct 2021 04:24:22 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q9sm913297ejf.70.2021.10.20.04.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 04:24:21 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1md9hl-000eBp-45;
        Wed, 20 Oct 2021 13:24:21 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/4] gitfaq: add advice on monorepos
Date:   Wed, 20 Oct 2021 12:54:47 +0200
References: <20211020010624.675562-1-sandals@crustytoothpaste.net>
 <20211020010624.675562-2-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <20211020010624.675562-2-sandals@crustytoothpaste.net>
Message-ID: <211020.86h7dcndlm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 20 2021, brian m. carlson wrote:

> +[[monorepos]]
> +Should we use a monorepo or many individual repos?::
> +	This is a decision that is typically made based on an organization's needs and
> +	desires for their projects.  Git has several features, such as shallow clone,
> +	partial clone, and sparse checkout to make working with large repositories
> +	easier, and there is active development on making the monorepo experience
> +	better.
> ++
> +However, at a certain size, the performance of a monorepo will likely become
> +unacceptable _unless_ you use these features.  If you choose to start with a
> +monorepo and continue to grow, you may end up unhappy with the performance
> +characteristics at a point where making a change is difficult.  The performance
> +of using many smaller repositories will almost always be much better and will
> +generally not necessitate the use of these more advanced features.  If you are
> +concerned about future performance of your repository and related tools, you may
> +wish to avoid a monorepo.
> ++
> +Ultimately, you should make a decision fully informed about the potential
> +benefits and downsides, including the capabilities, performance, and future
> +requirements for your repository and related tools, including your hosting
> +platform, build tools, and other programs you typically use as part of your
> +workflow.

In the context of git development we're typically talking about really
big repos when we're talking about monorepos, saying "monorepo"
communicates among other things that the user of that pattern is
unwilling to use splitting up as a way to address any scalability issues
they may have.

But a monorepo doesn't really say anything about size per-se, and it
would be confusing to conflate the two in a FAQ. I may be wrong, perhaps
the term has really come to exclusively refer to colossal size, but I
haven't seen or heard it exclusively (or even mainly) used like that

My understanding of what a monorepo in the context of software
development is a collection of all your "main" code and all its
dependencies in one repository, such that a person working on it rarely
or never has to worry about N=N dependencies between different pieces of
that collection, they'll all move in unison. You are able to atomically
change a function and all its users.

I think people have a different understanding of "all its
dependencies". Some monorepo users really mean it and try to e.g. fold
their system configuration system that might manage files in /etc in
with their monorepo, others might have "another monorepo" for that
software, etc.

I bet that the vast majority of monorepo users are never going to
experience scaling problems, e.g. having your laptop dotfiles and
automation of /etc in one repo is a "monorepo", and most companies/teams
that use monorepos I'd bet are in the long tail of size
distribution. They're not going to grow to the size of a MS's, FB's
etc. monorepo, but they might benefit (or not) from the monorepo
/workflow/.

Anyway, all of the above can be read as a suggestion that we should
split any discussion of "large repo [that runs into scaling issues]"
from "monorepo", the latter should of course make a passing reference to
scaling (as the pattern will lead to that sooner than not), but IMO not
conflate the two.
