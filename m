Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBD8C1F404
	for <e@80x24.org>; Fri, 24 Aug 2018 16:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeHXUPF (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 16:15:05 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:46886 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbeHXUPF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 16:15:05 -0400
Received: by mail-vk0-f46.google.com with SMTP id b14-v6so4571043vke.13
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 09:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=RrWRmWfxa32VompwugSZ/bgwjNScZjHPbP05ybkvL6g=;
        b=eUhrZT3GYWNhjSxj5bMSIuP5iFOCSfNm7RG+RiPcE4Cu7pcxiIiFKHs9vXa+AqNBDa
         9gl8wTHpJL3Rt27SEFgpfOxshywvDL1Ne1AvVchbdl7as6gI9CqoSwE9FLsEmqnU7Nq3
         LU8+CyVG89E41EWHklqGJco+dOReef1Zk8LvOoOVGbV3qOa7/bkUbPhCJE1+MVhhoN0n
         xmtttKkeYWUR8/cw12wTLSeIvidOWtmxpMYG3lIdVAUOMIQjNjymoKHLshyRIwMtot9w
         4WUh4UudfW5rUTfJHM6hNLLu6ipXpbceKroLO0PRsjA5KK+319LhQxW+bKlB1CCg+Ag6
         T18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RrWRmWfxa32VompwugSZ/bgwjNScZjHPbP05ybkvL6g=;
        b=Q6K708Vq/CI1JydPj11MHrawFBnW4ANijvv4Rhuh2/oDAy7eOYPrY5wwYlm0h3PhOG
         kg4t4Ye6RWghyj8Jei3b3F/xgfFgY9ahKIrsscqGSNeCMJIxpUG6PIeDlMrBtvNqbfvR
         Vj4F80Yag9WzHaCAD+re+BRX+dGOBFNJyNr9rx4pSFWjWpZt7/MA98qGKKPZO0pRTdGJ
         yhGBcZWfufnCKGJ0A5ZIzJxZINDeUeRT+IFxbCE19ud8q9hZyH/dDUISTtGzTVKALtfX
         c7REZEgO6cz57rJiA5MFfh+IypXm5OzhzPsDGvwtvUpkryB1lPVdHxVuihOM0YX4rafh
         z3fQ==
X-Gm-Message-State: APzg51Ceqz9qCUQRGOxJ9iGqi7hpZ7n/F+MdG15OK4IHi75HyE6a7Lhv
        6yALmxTb91WbO0ZSQpqiEhZ/nocs6V1eYoBYWXVnUxY1
X-Google-Smtp-Source: ANB0VdbUIh8E3/wc2bMZKFy6TedDGr/LN78TV2RSLYRKQ7QG1fFghG5KkDWV7m6mgfjjq5T8R7lIwvctx6/a/eDjLjY=
X-Received: by 2002:a1f:e1c7:: with SMTP id y190-v6mr1349405vkg.129.1535128778870;
 Fri, 24 Aug 2018 09:39:38 -0700 (PDT)
MIME-Version: 1.0
From:   Scott Johnson <jaywir3@gmail.com>
Date:   Fri, 24 Aug 2018 11:39:27 -0500
Message-ID: <CAEFop40OJ5MRwM8zxE44yB0f2Fxw9YsUdM1e-H=Nn9e=sAGJ=w@mail.gmail.com>
Subject: Would a config var for --force-with-lease be useful?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Everyone:

I'm considering writing a patch that adds a configuration variable
that will allow the user to default the command:

git push --force

to:

git push --force-with-lease

As discussed here:

https://stackoverflow.com/questions/30542491/push-force-with-lease-by-default

Now, I understand that there are downsides to having this enabled,
namely that a user who has this enabled might forget that they have it
enabled, and, as such, on a machine that _doesn't_ have it enabled (of
which they are unfamiliar) might then run the more consequential
command "git push --force", but my thinking is that adding this as a
feature to the git codebase as an _optional_ (i.e. not enabled by
default) configuration variable would then save some of us who use a
"rebase-then-force-push for pull request" workflow some time and
headaches.

Of course, I don't want to submit a patch if this is a feature that
isn't likely to be accepted, so I wanted to get some thoughts from the
mailing list regarding this idea.

Thank you,

~Scott Johnson
