Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A6992047F
	for <e@80x24.org>; Sat, 30 Sep 2017 17:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbdI3RUy (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 13:20:54 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:45623 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbdI3RUx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 13:20:53 -0400
Received: by mail-wr0-f182.google.com with SMTP id m18so1448964wrm.2
        for <git@vger.kernel.org>; Sat, 30 Sep 2017 10:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=vG7mZijtxO8uJfLHsU6ObZMkLWzHUfXoWtf0eYfqDfA=;
        b=h3WkDj5ZYQAr7Oy8+43GLmq8Cu7h2HN1I6LqiVLHxcJG0vjb/w6FNK7HgIMRdCQ0bT
         Y82X+6lYsECWE5y6a6IjgWnh+YRhbPomTRl7LCZZzq5hSUz2xhEE6AXXInv6iF81QJUK
         J3lDS6T7ybcJq2+rcYh/Oc/zZxTPaextBxND5bHfGudktEt9Gj1OOlbeY0cGu8emLy4T
         k2y8WLOxm6TaR7n/8b4ZhVh2VTemAFcEexQ5gJufngi9I9mCIiIbflrUzqNhj6+HjcOL
         HQRWWos0cE0T3qLurV68izjWp8RmBiaMevucQ24XoqN2msTo244UU6/6s3JzPODNzwv/
         oqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vG7mZijtxO8uJfLHsU6ObZMkLWzHUfXoWtf0eYfqDfA=;
        b=dh9Dfx02KBZ8TzSPrXPP+ZUSupqicd7SEAGPK3qin/71Cz2i8PthUOjwc54/P75lk3
         g0+NnVpgcjR+K4B/kCPOhqgfU5mDCpS4JhJFRWeEObHxZbBlfzM71yaFdEN/jdCdbyss
         asgNvextypKZR+Hy8Vx683HkJhs/UpHHpARtqD1QGqScAmXnbBEVc+AECkMZ192LdnNi
         aWi5Jbl+aV3eOTnR3Xmxzw9EJH2OR9WbNEEaJl1FRl4Rp6FKzkaMhAoV93xXBMIjm+WU
         PhrCImVJDnNWjIrsJfJ0hmaQ36YZkUwIhLiuaYeuqGhfd9xURb27j4fqxo4uaQMmj8Fr
         nJiw==
X-Gm-Message-State: AHPjjUjo8LfVmkJ4uF7fOS2Tw/WOoLmgyHot2U7hX0ErUXV20mbri0+0
        F+oRIFKLIyKHYiG46dI2yeVjoIVigkfsBEgrx0EO4Q==
X-Google-Smtp-Source: AOwi7QAIg2OxaG173jjYrE3ntZ0eb3HKtXLh2cT2INE8qwgt+1FMYfGEM9xogYtqZL90FW5YSFHupb//JEhCqLKqTQA=
X-Received: by 10.223.135.58 with SMTP id a55mr10174273wra.109.1506792051728;
 Sat, 30 Sep 2017 10:20:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.162.153 with HTTP; Sat, 30 Sep 2017 10:20:50 -0700 (PDT)
From:   Thadeus Fleming <thadeus.j.fleming@gmail.com>
Date:   Sat, 30 Sep 2017 12:20:50 -0500
Message-ID: <CAA4Wa2sVddG_SS70Dy_womGLKW0ipAjsxR4g+yjMKscjErRjvQ@mail.gmail.com>
Subject: git submodule add fails when using both --branch and --depth
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm running git 2.14.2 on Ubuntu 16.04.

Compare the behavior of

> git clone --branch pu --depth 1 https://github.com/git/git git-pu

which clones only the latest commit of the pu branch and

> mkdir tmp && cd tmp && git init
> git submodule add --branch pu --depth 1 https://github.com/git/git \
  git-pu

which gives the error

fatal: 'origin/pu' is not a commit and a branch 'pu' cannot be created
from it
Unable to checkout submodule 'git-pu'

Investigating further, there is indeed only one commit in the local repo:

> cd git-pu
> git log --oneline | wc -l
1

But that commit is the head of master.

> git branch -a
* master                                 remotes/origin/master
  remotes/origin/HEAD -> origin/master

This appears to be because git-submodule--helper does not accept a
--branch option. Using the --depth N option causes it to only clone N
commits from the default branch, which generally do not include the
desired branch. Thus, the next step,

git checkout -f -q -B "$branch" "origin/$branch"

fails, and provides the rather confusing error message above.

I'd suggest that git-submodule--helper learn a --branch option
consistent with git clone, and if that is impossible, that
git submodule add rejects the simultaneous use of both the --branch and
--depth options.



--tjf
