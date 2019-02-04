Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9820E211B5
	for <e@80x24.org>; Mon,  4 Feb 2019 13:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfBDNps (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 08:45:48 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:40531 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfBDNps (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 08:45:48 -0500
Received: by mail-wr1-f49.google.com with SMTP id p4so14428754wrt.7
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 05:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=zmnQ2eOMuSe8PSPtwn1ozHB5wkoqVGbSFpRwZWzGnw4=;
        b=JN/vFDiEUv3NI/H4oHZK7OYMR2vqFyKbLYAR6ShkyK4kekgMx5QXfxFNseEwnnbhfj
         8RCLiFAqzWlAY7wdJw5qyLjX/ZJWBi8HoST4sCtmjRTVGyD+qFG3kBCDThJOZR6JX4ci
         C+iJVjhKerAwvnFyxd9ba8JfOCq70sBX039P8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zmnQ2eOMuSe8PSPtwn1ozHB5wkoqVGbSFpRwZWzGnw4=;
        b=BlMghvGkGf2zeV9yJkCPhfIdVGO7RnLAuJ3CTUGYKVWzSzLRYELoNzhjD+BwXPB5VD
         jH7KCg2bm4lvt7ryFr99tKFCUOKnLe4/jKHvdLR7rh1kGuBVWNHQYvmzWEjs14WWGqV7
         J32cBRP4hFgMJ8kWXlTrZaTyJISlQXt7ZZYss+BUd4d6XCSzJVMDtd6QmA5JzNdKUEcX
         NiccsV5ZUlxxHApzzgU4UnqmN16jTamllXqM/L7cQraLO4USUi3anQJ2nDpiMfk9piGp
         mijiLB2HlAm9IsNWq51gW7tmDAVeyCffPK24zvtbqF4Brq+OIarp/MmU5w/Mf5sUyZh9
         RSOQ==
X-Gm-Message-State: AJcUukfB9kRE4MMaOqSH3pW57DDajE/6nHZzURLHjF0XJwJlRVvCWdxn
        N2NN9FNn3XRgADVS6yqfdoumOkwQNW/9oORirKoHrpZMalr59g==
X-Google-Smtp-Source: ALg8bN4ZcI7ilZKGai0+mQ0t5pfbaeTqpSDb58XxuAZtqvnHEVXQHWBNZVERnunUIbFFiEZqHtYWN5+L2tg/ssvowoI=
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr48726012wro.35.1549287946044;
 Mon, 04 Feb 2019 05:45:46 -0800 (PST)
MIME-Version: 1.0
From:   Luke Diamand <luke@diamand.org>
Date:   Mon, 4 Feb 2019 13:45:35 +0000
Message-ID: <CAE5ih7-Gi6i8ZRDjsVELLesTORRDxvrLYf00DYTBRFUWUmAAdw@mail.gmail.com>
Subject: Partial clone - bad pack header?
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I tried to do a partial clone, but it gave me a "bad pack header". Is
there anything I can do to debug this?

I did "git config uploadpack.allowfilter true" in my repo.
Then I went to a scratch directory and did:
$ git clone --filter=blob:limit=10M ssh://localhost/~/git/my_big_repo
remote: Enumerating objects: 1619425, done.
remote: Counting objects: 100% (1619425/1619425), done.
remote: Compressing objects: 100% (362435/362435), done.
remote: Total 1619425 (delta 1225623), reused 1604277 (delta 1211975)
Receiving objects: 100% (1619425/1619425), 10.34 GiB | 35.61 MiB/s, done.
Resolving deltas: 100% (1225623/1225623), done.
Note: checking out 'a943f529b4781f34602f1ad5aab99a8699975c29'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

  git checkout -b <new-branch-name>

fatal: the remote end hung up unexpectedly
fatal: protocol error: bad pack header
warning: Clone succeeded, but checkout failed.
You can inspect what was checked out with 'git status'
and retry the checkout with 'git checkout -f HEAD'

$  git checkout origin/master
fatal: the remote end hung up unexpectedly
fatal: protocol error: bad pack header

$ git --version
git version 2.20.1.611.gfbb209baf1

There's plenty of disk space left.

Thanks,
Luke
