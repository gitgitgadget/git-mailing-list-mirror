Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2250C0015E
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 09:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbjGMJvQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 05:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbjGMJvO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 05:51:14 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B1C2686
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 02:51:12 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbf1b82d9cso4069275e9.2
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 02:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689241871; x=1691833871;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sHtzEXH3KjvF+0oAQwZSABUHbYJetR/+kBZdulQ1Z6k=;
        b=iiRaamTp7YROV2oVNl1pA1+holAA7vaxjGPx3DeYa2c3Y2qD+7lBXBmOq8IOCFqzjp
         uu7QOeuCq5WgYw3h5f1BskN2Kc7/aJsm20LQ37nCBVRpLgsIdqmDHq7hidQ7vive5dGe
         tNw3+DnKlbHTWdtO+hbBKamvcpltNpgsefNG5HodFh4a1J6jf5Sm6zZRwkucUhsfwOBT
         plA71KR1kTLxYp/4GEJTq97o4Rdru1kQvamB1EqBA9MKAviHw5qdi5XM/umk16nKe1/Y
         CzNWxV+1b0xaGqPyDPLeUDdRyOI7Vvu4NM+GjfnjV4m+ubHPTTACZAQzLJjAN92g0pbd
         tfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689241871; x=1691833871;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHtzEXH3KjvF+0oAQwZSABUHbYJetR/+kBZdulQ1Z6k=;
        b=i2CwM0ngoWj0AQz6QmL8Kr07YhzduT3DDAjZIRLAMxMfi6nlKOQctBOtBjDHXG9phr
         HpHnIgSI0R0FXCDFKFNNnqCRtclK+Xkb+k2y8QgqcENf2YCeJyWUJfjxUGF91Xf7aGgG
         wka3V5UbD8mbXoHFrT+/irIBw9XG7uqu+pzgwqofzRsJ+Pg8/H+nD1tl//OUu9g9oXu1
         mwfP2uX0nqeUD8Pe6tRBbuRYPsN2/P7dQlMwnkZVBX2H8Z1GCZkatCzh2sRTbNjOXp5C
         PXwjHdqw1KmbkDIaqUGr0pfk+Zu4ErRdOuRbOMPbgs2NmEIG3S7W1MgwNQ1LzemRmMmN
         RF+w==
X-Gm-Message-State: ABy/qLacY2Mo9+vlORwz9g1TRZvauaj18os/BvLHyPMCSEwCJbpb/qKu
        Ym3h4TkyefJqZ7dTGZh3G5b0f7KQKN4=
X-Google-Smtp-Source: APBJJlE18cbcVlmuDXGy3jp+uIFG7hMq3JaVg5c9azcqPN/WJoRq3MzkUGjfSY//+K7wd+53GyZeTw==
X-Received: by 2002:a7b:cd95:0:b0:3f7:3699:c294 with SMTP id y21-20020a7bcd95000000b003f73699c294mr902023wmj.29.1689241870825;
        Thu, 13 Jul 2023 02:51:10 -0700 (PDT)
Received: from [192.168.1.195] ([90.242.235.211])
        by smtp.googlemail.com with ESMTPSA id q5-20020a1ce905000000b003fc07e1908csm7281428wmc.43.2023.07.13.02.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 02:51:10 -0700 (PDT)
Message-ID: <919d1ba8-bb8b-a77b-cef3-db14f168ed4a@gmail.com>
Date:   Thu, 13 Jul 2023 10:51:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/3] don't imply that integration is always required
 before pushing
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        git@matthieu-moy.fr, christiwald@gmail.com, john@keeping.me.uk,
        philipoakley@iee.email, phillip.wood@dunelm.org.uk
References: <20230707054257.3366355-1-alexhenrie24@gmail.com>
 <20230713044128.3771818-1-alexhenrie24@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230713044128.3771818-1-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 13/07/2023 05:41, Alex Henrie wrote:
> Many times now, I have seen novices do the following:
> 
> 1. Start work on their own personal topic branch
> 2. Push the branch to origin
> 3. Rebase the branch onto origin/master
> 4. Try to push again, but Git says they need to pull
> 5. Pull and make a mess trying to reconcile the older topic branch with
>     the rebased topic branch
> 
> Help avoid this mistake by giving somewhat more general advice that does
> not assume that the user always wants to do reconciliation.
> 
> Changes from v4:
> - Don't show divergent branch advice in the middle of `git commit`
> - Soften the advice, but don't specifically mention force-pushing

All three patches look fine to me, they are definitely an improvement on 
the current advice.

Thanks for working on this,

Phillip

> Alex Henrie (3):
>    wt-status: don't show divergence advice when committing
>    remote: don't imply that integration is always required before pushing
>    push: don't imply that integration is always required before pushing
> 
>   builtin/checkout.c |  2 +-
>   builtin/push.c     | 24 +++++++++++------------
>   remote.c           |  8 +++++---
>   remote.h           |  3 ++-
>   t/t7508-status.sh  | 48 ++++++++++++++++++++++------------------------
>   wt-status.c        |  3 ++-
>   6 files changed, 45 insertions(+), 43 deletions(-)
> 
> Range-diff against v4:
> 1:  9626721c13 < -:  ---------- remote: advise about force-pushing as an alternative to reconciliation
> -:  ---------- > 1:  e84989c4a6 wt-status: don't show divergence advice when committing
> -:  ---------- > 2:  9bb643df7e remote: don't imply that integration is always required before pushing
> 2:  209e86588a ! 3:  5ff9ecb51b push: advise about force-pushing as an alternative to reconciliation
>      @@ Metadata
>       Author: Alex Henrie <alexhenrie24@gmail.com>
>       
>        ## Commit message ##
>      -    push: advise about force-pushing as an alternative to reconciliation
>      +    push: don't imply that integration is always required before pushing
>       
>      -    Also, don't put `git pull` in an awkward parenthetical, because
>      -    `git pull` can always be used to reconcile branches and is the normal
>      -    way to do so.
>      +    In a narrow but common case, the user is the only author of a branch and
>      +    doesn't mind overwriting the corresponding branch on the remote. This
>      +    workflow is especially common on GitHub, GitLab, and Gerrit, which keep
>      +    a permanent record of every version of a branch that is pushed while a
>      +    pull request is open for that branch. On those platforms, force-pushing
>      +    is encouraged and is analogous to emailing a new version of a patchset.
>      +
>      +    When giving advice about divergent branches, tell the user about
>      +    `git pull`, but don't unconditionally instruct the user to do it. A less
>      +    prescriptive message will help prevent users from thinking that they are
>      +    required to create an integrated history instead of simply replacing the
>      +    previous history. Also, don't put `git pull` in an awkward
>      +    parenthetical, because `git pull` can always be used to reconcile
>      +    branches and is the normal way to do so.
>      +
>      +    Due to the difficulty of knowing which command for force-pushing is best
>      +    suited to the user's situation, no specific advice is given about
>      +    force-pushing. Instead, the user is directed to the Git documentation to
>      +    read about possible ways forward that do not involve integration.
>       
>           Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
>       
>      @@ builtin/push.c: static void setup_default_push_refspecs(int *flags, struct remot
>        	N_("Updates were rejected because the tip of your current branch is behind\n"
>       -	   "its remote counterpart. Integrate the remote changes (e.g.\n"
>       -	   "'git pull ...') before pushing again.\n"
>      -+	   "its remote counterpart. Use 'git pull' to integrate the remote changes\n"
>      -+	   "before pushing again, or use 'git push --force' to delete the remote\n"
>      -+	   "changes and replace them with your own.\n"
>      ++	   "its remote counterpart. If you want to integrate the remote changes,\n"
>      ++	   "use 'git pull' before pushing again.\n"
>        	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
>        
>        static const char message_advice_checkout_pull_push[] =
>        	N_("Updates were rejected because a pushed branch tip is behind its remote\n"
>       -	   "counterpart. Check out this branch and integrate the remote changes\n"
>       -	   "(e.g. 'git pull ...') before pushing again.\n"
>      -+	   "counterpart. Check out this branch and use 'git pull' to integrate the\n"
>      -+	   "remote changes before pushing again, or use 'git push --force' to delete\n"
>      -+	   "the remote changes and replace them with your own.\n"
>      ++	   "counterpart. If you want to integrate the remote changes, use 'git pull'\n"
>      ++	   "before pushing again.\n"
>        	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
>        
>        static const char message_advice_ref_fetch_first[] =
>      @@ builtin/push.c: static void setup_default_push_refspecs(int *flags, struct remot
>       -	   "(e.g., 'git pull ...') before pushing again.\n"
>       +	N_("Updates were rejected because the remote contains work that you do not\n"
>       +	   "have locally. This is usually caused by another repository pushing to\n"
>      -+	   "the same ref. Use 'git pull' to integrate the remote changes before\n"
>      -+	   "pushing again, or use 'git push --force' to delete the remote changes\n"
>      -+	   "and replace them with your own.\n"
>      ++	   "the same ref. If you want to integrate the remote changes, use\n"
>      ++	   "'git pull' before pushing again.\n"
>        	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
>        
>        static const char message_advice_ref_already_exists[] =
>      @@ builtin/push.c: static const char message_advice_ref_needs_force[] =
>       -	   "to integrate those changes locally (e.g., 'git pull ...')\n"
>       -	   "before forcing an update.\n");
>       +	N_("Updates were rejected because the tip of the remote-tracking branch has\n"
>      -+	   "been updated since the last checkout. Use 'git pull' to integrate the\n"
>      -+	   "remote changes before pushing again, or use 'git push --force' to delete\n"
>      -+	   "the remote changes and replace them with your own.\n");
>      ++	   "been updated since the last checkout. If you want to integrate the\n"
>      ++	   "remote changes, use 'git pull' before pushing again.\n"
>      ++	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
>        
>        static void advise_pull_before_push(void)
>        {

