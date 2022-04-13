Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DC8C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 23:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbiDMXrM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 19:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiDMXrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 19:47:09 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10A13C4A1
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 16:44:46 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id g5-20020a62f945000000b0050578328060so2112829pfm.17
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 16:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Zj5dSxMoI38W/atjfbQKEyvVi9NPpLkLjbAcIZXuExU=;
        b=WZGOUM+YNNSjOOgMTkX5ZyCY3q8uvD+q/kZIFaOObqgfYhs2/ehqN5hjQiLBibD4tu
         sfiST3Pkj8fEVgG18zGZpkOX4OjaabAG91EX39dbiK9MM71DzgvQbASo11MlQX/sCZmR
         69ykX2onO1BQl0M9yjU//e6jyQA5TsZ0atmhwnWcFSlBNOFwaLrlx+faXPxQNn8XFOLF
         hUSdHkO8k3q7LKzNPwqhp2yHa4Jiu4obsjOS6s6L7C8hPob7xNGwufd3u2kXAzARf4ix
         3AnTq31aved3j5zemd9/MQ91k4pJbOnxhpYboGL7QQn4LmhBbE3xC1SStdJwAh3r0YaI
         gAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Zj5dSxMoI38W/atjfbQKEyvVi9NPpLkLjbAcIZXuExU=;
        b=IzoCsRDlf80WggPyb8gCy18R57aLi+i24d7RW4/PGFlMfWBFlyJJfbAyizBkhZ6Ecz
         qw1crwPukR9T8RQyJEvjg+8pFW+OsCo0+PIoJu1yNoLeg6k7+7i5f+L0oFp/WuMrIbtt
         Gl3zPv4xvrT8vv7QNk5OTQalln87BuC2HErhNvLKxSAtKgp+vvMBpJLWp/RGZXJ1EV/J
         WUmNyxg6HaMClsmQIlcs/ZyO/YQVJanLgjFHqo1Ve3SC8wimm+SoKoUU7FGevBro89y5
         6qOVrDVY07HUCkQ7bvO4zvfnfHVmcAkSb0k0z4Yhc3KY39CzB0kAKtdh0Gjr+6q+Tqgn
         ruhg==
X-Gm-Message-State: AOAM530XZipxiKqNx6zK1bFTas4ZqJtDQZ6b/m2gx1dAJZDK/Ts+6Ywh
        9hNKajy17O5bYqp6MyrQP7HFNAGxcUFQww==
X-Google-Smtp-Source: ABdhPJzt8uVSAV0T7KSswSCJH/fwtSCaY3UZnvWP0TVVQuTAV/RYRIPSlC1zYPrq0FsrgfoQrugEEWofaNAUog==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:8c82:b0:158:b701:c2a4 with SMTP
 id t2-20020a1709028c8200b00158b701c2a4mr1231962plo.66.1649893486289; Wed, 13
 Apr 2022 16:44:46 -0700 (PDT)
Date:   Wed, 13 Apr 2022 16:44:43 -0700
In-Reply-To: <Yk9hONuCIVIq6ieV@camp.crustytoothpaste.net>
Message-Id: <kl6lmtgo8s5w.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <Yk9Wcr74gvhtyOi7@camp.crustytoothpaste.net> <CAHZU0ySHqc7f9qB0+ZrMWHHJiWsS-_hsUzomwNrGNMTF6qwcOw@mail.gmail.com>
 <Yk9hONuCIVIq6ieV@camp.crustytoothpaste.net>
Subject: Re: Bare repositories in the working tree are a security risk
From:   Glen Choo <chooglen@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Justin Steven <justin@justinsteven.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Thanks a lot for chiming in, especially for advocating on behalf of
users of embedded bare repos :)

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2022-04-07 at 21:53:26, Justin Steven wrote:
>> Hi all,
>> 
>> I'm the author of one of the articles linked in Glen's mail. Thank you
>> Glen for summarising the problem beautifully and pushing this forward.
>> 
>> Brian said:
>> > As mentioned elsewhere, git status doesn't work without a working tree.
>> 
>> This is correct. However, it is possible to embed a bare repo that has
>> its own core.worktree which points to a directory within the
>> containing repo, satisfying the requirement of having a working tree.
>> This is covered in the article [1] and looks to be accounted for in
>> Taylor's reproducer script which admittedly I haven't run.
>> 
>> > Instead, I'd rather see us avoid executing any program from the config
>> > or any hooks in a bare repository without a working tree (except for
>> > pushes).  I think that would avoid breaking things while still improving
>> > security.
>> 
>> Due to the fact that the embedded bare repo can be made to have a
>> working tree, this won't be an effective fix.
>
> Then we'd probably be better off just walking up the entire hierarchy
> and excluding worktrees from embedded bare repositories, or otherwise
> restricting the config we read.  That will probably mean we'll need to
> walk the entire directory hierarchy to see if it's embedded (or at least
> to the root of the device) in such a case, but that should be relatively
> uncommon.

IIUC, the difference between your suggestion and (3) in the original
email:

  == 3. Detect that we are in an embedded bare repo and ignore the embedded bare
  repository in favor of the containing repo.

is that we only walk the hierarchy in the event that the bare repo has a
worktree? If so, then yes that seems relatively uncommon and wouldn't
break most bare repo users.

What I'm unsure about is whether or not this reduces the attack surface
enough; it protects the highest value target, `git status`, but I'm not
sure about the following:

* How well does this protect other, existing commands (e.g. `log`,
  `branch` and `remote` fall into the same category of commands that
  appear informative and harmless)?
* How well does this protect other, abusable configuration directives
  (`core.pager` perhaps)?
* How future-proof is this? (if someone removes a dependency on
  core.worktree, is the command vulnerable again?)

There's a similar argument to be made about restricting the config we
read - we'd be running the risk of either missing some abusable config
that already exists or will exist.

And if my understanding is correct (and it very well might be wrong),
then this seems too piecemeal to be worth the effort.

> I'd definitely like to see us make a security improvement here, but I
> also would like to avoid us breaking a lot of repositories, especially
> since we lack alternatives.

Agreed, leaving existing users high and dry is an awful outcome.

>
> If git fast-import could 100% correctly round-trip all commits and
> repositories, I would be much more open to blocking this in fsck after a
> deprecation period, but as it stands that's not possible.  Perhaps
> improving that would be a suitable way forward.

