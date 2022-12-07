Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F29C4708D
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 00:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiLHACV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 19:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiLHACT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 19:02:19 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7655BD62
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 16:02:17 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i15so50507edf.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 16:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UpgW92SpQawh7/XxFA6YAZQaPCluL+QJtRnnA22jX8Q=;
        b=YwSGEBstBfR22Qc0J8sUn5NOzO7NjvTSMC+RTHsxjkzuwPAOkJBzzefyDOp+IcEibE
         PD7FdukcpENvgmgix0WvNOP0kbpusI7qS8hDUj1xqRvLeO15wJHHh80PphwLIhJbo2ly
         jFoUvKB0yBl42jxOanpc/NzWBlskFvIAT6YDL27vN4mqKzaQX0e2dSpXAnIwhSSmJw7A
         yjIyg5+9SaWpdHnMsA990mVU4NsSt/oC0xpUopBFFQ8xQuOTofdGxh/SVY2IK9qsRMsb
         vnw0O6OTQ386gXrQRLBTVbl7bPjN39lfkPPfkLRHkKENy2rhHICyyMUvpOkiYkCWo/XB
         3Qkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UpgW92SpQawh7/XxFA6YAZQaPCluL+QJtRnnA22jX8Q=;
        b=GZJ3iPpuq5Zzf1MPZDdBrjfdJTS9gcN2t3STsClv7TBPnckdkClYbgyK1eHMGftdOF
         2vsOmfkZr60ZWlnilqPSN64RHkKYRSLwntdjNPvkBVs/83M51gsAOFUar17y15d7AHd9
         tYYNe5eqyg1xR8BYq72PKw7Vc6g903JTEJrOmSRhHKzGqLedpf1kuAenuW0D2LGCsrGS
         ii4wozxBLD0CvcnkBQRcuW4TjhiFzZpLBI/S3CjXmtHwMFaaV+ET8x7iSYVPCDpOmQTj
         +EVd6P7aJNrTxSB6G1pPjxMXUlI5MLuKZM6ekUgqSydCUSJ9NkLTU70hDUYYT218DoDW
         CTfw==
X-Gm-Message-State: ANoB5plbbMgSl/U7MpcCYiCplKYQ8UXydHbAPNdGTy1gi3MswGnzIIFy
        W46XshVrf96uDLWiIuwnBk6SJkrH8FEaKw==
X-Google-Smtp-Source: AA0mqf4yDnNY7RDyOoh4bkrtkOE6A9RGjaikBu9lv0YNJMKE1iXEJBCL71AeVqHN7RLegmsCTdjKdg==
X-Received: by 2002:aa7:c917:0:b0:46d:8aeb:bc03 with SMTP id b23-20020aa7c917000000b0046d8aebbc03mr631803edt.22.1670457735507;
        Wed, 07 Dec 2022 16:02:15 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id p4-20020a05640210c400b0046c4553010fsm2798577edu.1.2022.12.07.16.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 16:02:14 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p34Mg-004iPn-0x;
        Thu, 08 Dec 2022 01:02:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        johncai86@gmail.com, Taylor Blau <me@ttaylorr.com>
Subject: Re: Question: How to execute git-gc correctly on the git server
Date:   Thu, 08 Dec 2022 00:57:45 +0100
References: <CAOLTT8Tt3jW2yvm6BRU3yG+EvW1WG9wWFq6PuOcaHNNLQAaGjg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAOLTT8Tt3jW2yvm6BRU3yG+EvW1WG9wWFq6PuOcaHNNLQAaGjg@mail.gmail.com>
Message-ID: <221208.86a63y9309.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 07 2022, ZheNing Hu wrote:

> I would like to run git gc on my git server periodically, which should he=
lp
> reduce storage space and optimize the read performance of the repository.
> I know github, gitlab all have this process...
>
> But the concurrency between git gc and other git commands is holding
> me back a bit.
>
> git-gc [1] docs say:
>
>     On the other hand, when git gc runs concurrently with another process,
>     there is a risk of it deleting an object that the other process is us=
ing but
>     hasn=E2=80=99t created a reference to. This may just cause the other =
process to
>     fail or may corrupt the repository if the other process later adds
> a reference
>     to the deleted object.
>
> It seems that git gc is a dangerous operation that may cause data corrupt=
ion
> concurrently with other git commands.
>
> Then I read the contents of Github's blog [2], git gc ---cruft seems to b=
e used
> to keep those expiring unreachable objects in a cruft pack, but the blog =
says
> github use some special "limbo" repository to keep the cruft pack for git=
 data
> recover. Well, a lot of the details here are pretty hard to understand fo=
r me :(
>
> However, on the other hand, my git server is still at v2.35, and --cruft =
was
> introduced in v2.38, so I'm actually more curious about: how did the serv=
er
> execute git gc correctly in the past? Do we need a repository level "big =
lock"
> that blocks most/all other git operations? What should the behavior of us=
ers'
> git clone/push be at this time? Report error that the git server is perfo=
rming
> git gc? Or just wait for git gc to complete?
>
> Thanks for any comments and help!
>
> [1]: https://git-scm.com/docs/git-gc
> [2]: https://github.blog/2022-09-13-scaling-gits-garbage-collection/

Is this for a very large hosting site that's anywhere near GitHub,
GitLab's etc. scale?

A "git gc" on a "live" repo is always racy in theory, but the odds that
you'll run into data corrupting trouble tends to approach zero as you
increase the gc.pruneExpire setting, with the default 2 weeks being more
than enough for even the most paranoid user.

The "cruft pack" facility does many different things, and my
understanding of it is that GitHub's not using it only as an end-run
around potential corruption issues, but that some not yet in tree
patches on top of it allow more aggressive "gc" without the fear of
corruption.

So, I think you probably don't need to worry about it. Other major
hosting sites do run "git gc" on live repositories, but as always take
backups etc.
