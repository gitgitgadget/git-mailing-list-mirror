Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BAAC433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 22:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiJZWPI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 18:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiJZWPG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 18:15:06 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562BC61722
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 15:15:04 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id c10-20020a170902d48a00b001825736b382so11141364plg.15
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 15:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EPfzFRK2Sz1w0aiTJDaN2ceKtlAOqGXOWogmiHOR3XY=;
        b=gpnqUVqkC7hCm8AT0+GBIP6pf9O3UZNSwvN3DAuV/GCMA8YaQ4p3hHqOHflgnBuoDJ
         2/CU8YWQ5MnFxO+qXaplwsdX/46skPPFX7Ewk3MEhwIAJSw2lw5f9y2cPpjlD72h9nca
         jmWzpP1/FAsjdGpOYkDQPTeDKs8/qpt3YonmLfhIAXvFNAiU7/9Am2ThIWf7frXAquA7
         NJNir5sNPCPJ33Hy2LFLgeRLA7xeFUUiGMKpvQ51oOLtK4skAE50p6622jkRVYAmxr17
         HSP3kji33beRxDYyHyIkODwcvXzFjvHNAbW8u7hdpqsT3yMVjfEroha/wnJI7pEvdQjv
         fJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EPfzFRK2Sz1w0aiTJDaN2ceKtlAOqGXOWogmiHOR3XY=;
        b=m8eekR1/TXZGMgXdQbaJ91zN8QPArqtWnscECmPkAmAoj7hc4HnfW3wYGc009ZhX5V
         5MrWZSjPXy8qfEdD5x1vp1laaAOQbk440ZgnwOdUbwGJjrWcPjuje3llSFjCsG2fBG+O
         AiES+Se/a7dUh34ybQ+q7eF32lwDXXIfX+Yi2dJS32vH8FjekIguwb2wJ1M+nv8nsEFd
         t88flL5qlfgSFUVFmrvzmLJt5RkputvXmWYDKC93uaM/w7f3S4uAa/OAyZyjO4o+iSJJ
         51Fhslzis59ZN6/mDXw2hoyJDRszDRu4cdoApkOdbpBnNmyhToHceY1HwJ4snPjxZ02X
         bB+A==
X-Gm-Message-State: ACrzQf13oVTd5v1P1yD9yyhk2c3fF3u7bycCn8JkOx3a8uyhZ0i/RbfD
        wYYiDe/w4jN/jpyf7adxpZQ94+y53rDaAw==
X-Google-Smtp-Source: AMsMyM6baiUaEXNQRbes7r4QJ6Rcu/pqfXVxXUhTm1n95fWfqCcN4lHRkQLsF6BKZcYyizjSHDZ6BEZ5SEQcSQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:9565:0:b0:56c:8860:bce1 with SMTP id
 x5-20020aa79565000000b0056c8860bce1mr1620890pfq.31.1666822503824; Wed, 26 Oct
 2022 15:15:03 -0700 (PDT)
Date:   Wed, 26 Oct 2022 15:14:55 -0700
In-Reply-To: <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com> <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
Message-ID: <kl6lr0yuqlk0.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 0/9] archive: Add --recurse-submodules to git-archive command
From:   Glen Choo <chooglen@google.com>
To:     Heather Lapointe via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     "=?utf-8?Q?Ren=C3=A9?= Scharfe" <l.s.r@web.de>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Heather!

We covered this series in Review Club [1]. We will leave review on
this thread, though you may find the notes [2] useful.

[1] https://lore.kernel.org/git/kl6l35bbsubq.fsf@chooglen-macbookpro.roam.c=
orp.google.com
[2] https://docs.google.com/document/d/14L8BAumGTpsXpjDY8VzZ4rRtpAjuGrFSRqn=
3stCuS_w/edit?pli=3D1#

"Heather Lapointe via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This makes it possible to include submodule contents in an archive comman=
d.
>
> The inspiration for this change comes from this Github thread,
> https://github.com/dear-github/dear-github/issues/214, with at least 160
> =F0=9F=91=8D=F0=9F=8F=BB 's at the time of writing. (I stumbled upon it b=
ecause I wanted it as
> well).
>
> I figured the underlying implementation wouldn't be too difficult with mo=
st
> of the plumbing already in place, so I decided to add the relevant logic =
to
> the client git-archive command.
>
> One of the trickier parts of this implementation involved teaching read_t=
ree
> about submodules. Some of the troublesome areas were still using the
> the_repository references to look up commit or tree or oid information. I
> ended up deciding that read_tree_fn_t would probably be best off having a
> concrete repo reference since it allows changing the context to a subrepo
> where needed (even though some of the usages did not need it specifically=
).
>
> I am open to feedback since this is all quite new to me :)

The Review Club participants generally agreed that this is a really
well-structured and easy-to-follow series :) As far as new contributions
go, this is really good.

I think this series broadly makes sense, i.e.:

- the implementation of plumbing "struct repository" through read_tree()
  (this might also be really helpful for future work)
- the interface (using "--recurse-submodules")
- the expected behavior

So I can see this going through with a bit of polish. The others have
covered style issues quite thoroughly, so I won't comment on those.
