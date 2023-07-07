Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39902EB64D9
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 08:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjGGIt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 04:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjGGIt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 04:49:27 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3200B1FE4
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 01:49:26 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so4619870a12.1
        for <git@vger.kernel.org>; Fri, 07 Jul 2023 01:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688719764; x=1691311764;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yS3IOWWnyq2XqKGKM6HM2/Z5EJxw3B5kQr7p6abvsCI=;
        b=YxglRh6DJAVxd8B6aIR/7noyjQCeZ2I6vHtK+JxrbwLdQqa2ZpjzWLBurbU1ehfAbM
         Zr31fYl5Ele6+Pv+wtK6uu+qgvcmK7mwazQjRN/4O2aDxIZcrg22lVEB6t96SledITbL
         WLYhDdFr/9LvxFO17YB2juHHGnysM/JdKLClZLFXddguhf1l8yutpIKEsmQXDFJkl09k
         X0MNKkVIhZZ+yOcwPY/JlndL9lblCK1FIrzlKFoVtNfOI61iGdChoJvTCnpWuH/v6vr5
         Oo54kIUqmvuWOybascA/Cj9z83gXkaySf22PNv6b4wBGf09KcdbypBYnowYXCHRwj9kh
         6zqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688719764; x=1691311764;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yS3IOWWnyq2XqKGKM6HM2/Z5EJxw3B5kQr7p6abvsCI=;
        b=P/Ybhwzqddas/kLMUqUflJRj96tnJRuu0SVW8LrchQBrzIYYMUtFXWG6CW+/RL8Dpt
         za+ryjkzscfo03W3yzCnUDm2V5sk2Ry6hSd6RsDRx9a3l7PJ2CdtUBBc/CHvOqw0FUz5
         ThhDP0EB8yKfgVW6O0WnQctv8ctuFUFLhBaXwvjMSF4MxCrwKSgRThSkqNDyUeFq92Sa
         aNv9PFDcWrZUMZ3KZhW+HpRR4SuZi+7lyNMVRxXn0GUA+ZWatNbvJJVJ5/qH+0gRg64y
         UA1HoIk5+B3nsi5VuLLVf7x332II+Eo9P90InD4BNL99ASbBCpueHPT2Hb8Gs7t88ue4
         okpg==
X-Gm-Message-State: ABy/qLZDj3pcp/ElbfAwA992T63ERlOTWjaD/5EeFe0wlJJnugRUDyNE
        VPhUwl5UcU1Lrg/r3O5YVX1Uz39WcDw=
X-Google-Smtp-Source: APBJJlF/jlGVSPM/vkPARJ9jqrO+kIx/G+YyR+7kBPoZwVQ2WP2W1KnO9UARcpPVdhgKp04fa1j5gA==
X-Received: by 2002:a17:907:97d6:b0:978:8979:c66c with SMTP id js22-20020a17090797d600b009788979c66cmr7953915ejc.18.1688719764357;
        Fri, 07 Jul 2023 01:49:24 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id u23-20020a1709063b9700b009928b4e3b9fsm1897045ejf.114.2023.07.07.01.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 01:49:24 -0700 (PDT)
Message-ID: <82255166-49ac-3c10-1744-27d6d436822e@gmail.com>
Date:   Fri, 7 Jul 2023 09:49:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] push: advise about force-pushing as an alternative
 to reconciliation
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        git@matthieu-moy.fr, christiwald@gmail.com, john@keeping.me.uk,
        philipoakley@iee.email, gitster@pobox.com,
        phillip.wood@dunelm.org.uk
References: <20230704194756.166111-1-alexhenrie24@gmail.com>
 <20230706040111.81110-1-alexhenrie24@gmail.com>
 <20230706040111.81110-3-alexhenrie24@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230706040111.81110-3-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 06/07/2023 05:01, Alex Henrie wrote:
> Also, don't put `git pull` in an awkward parenthetical, because
> `git pull` can always be used to reconcile branches and is the normal
> way to do so.

This message would also benefit from adding explanation as to why this 
change is desirable.

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>   builtin/push.c | 27 +++++++++++++++------------
>   1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/builtin/push.c b/builtin/push.c
> index 6f8a8dc711..b2f0a64e7c 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -301,21 +301,24 @@ static void setup_default_push_refspecs(int *flags, struct remote *remote)
>   
>   static const char message_advice_pull_before_push[] =
>   	N_("Updates were rejected because the tip of your current branch is behind\n"
> -	   "its remote counterpart. Integrate the remote changes (e.g.\n"
> -	   "'git pull ...') before pushing again.\n"
> +	   "its remote counterpart. Use 'git pull' to integrate the remote changes\n"

This is much clearer than "(e.g. 'git pull ...')"

> +	   "before pushing again, or use 'git push --force' to delete the remote\n"
> +	   "changes and replace them with your own.\n"

I think it would be good to give a bit more context here as to when 
force pushing is a good idea. For example something like

     If you have rebased the branch since you last integrated remote
     changes then you can use
     'git push --force-with-lease=<branch-ref> --force-if-includes' to
     safely replace the remote branch.

     If you have deleted and then recreated the branch since you last
     integrated remote changes then you can use 'git push +<branch>' to
     replace the remote. Note that if anyone else has pushed work to
     this branch it will be deleted.

It makes the advice longer  but the user get a specific suggestion for 
their current situation rather than a generic suggestion to delete the 
remote changes without discussing the implications. In this case we know 
that it was the current branch that was rejected and so should fill in 
the branch name in the advice as well.

My main issue with the changes in this series is that they seem to 
assume the user is (a) pushing a single branch and (b) they are the only 
person who works on that branch. That is a common but narrow case where 
force pushing is perfectly sensible but there are many other scenarios 
where suggesting "push --force" would not be a good idea.

Best Wishes

Phillip

>   	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
>   
>   static const char message_advice_checkout_pull_push[] =
>   	N_("Updates were rejected because a pushed branch tip is behind its remote\n"
> -	   "counterpart. Check out this branch and integrate the remote changes\n"
> -	   "(e.g. 'git pull ...') before pushing again.\n"
> +	   "counterpart. Check out this branch and use 'git pull' to integrate the\n"
> +	   "remote changes before pushing again, or use 'git push --force' to delete\n"
> +	   "the remote changes and replace them with your own.\n"
>   	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
>   
>   static const char message_advice_ref_fetch_first[] =
> -	N_("Updates were rejected because the remote contains work that you do\n"
> -	   "not have locally. This is usually caused by another repository pushing\n"
> -	   "to the same ref. You may want to first integrate the remote changes\n"
> -	   "(e.g., 'git pull ...') before pushing again.\n"
> +	N_("Updates were rejected because the remote contains work that you do not\n"
> +	   "have locally. This is usually caused by another repository pushing to\n"
> +	   "the same ref. Use 'git pull' to integrate the remote changes before\n"
> +	   "pushing again, or use 'git push --force' to delete the remote changes\n"
> +	   "and replace them with your own.\n"
>   	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
>   
>   static const char message_advice_ref_already_exists[] =
> @@ -327,10 +330,10 @@ static const char message_advice_ref_needs_force[] =
>   	   "without using the '--force' option.\n");
>   
>   static const char message_advice_ref_needs_update[] =
> -	N_("Updates were rejected because the tip of the remote-tracking\n"
> -	   "branch has been updated since the last checkout. You may want\n"
> -	   "to integrate those changes locally (e.g., 'git pull ...')\n"
> -	   "before forcing an update.\n");
> +	N_("Updates were rejected because the tip of the remote-tracking branch has\n"
> +	   "been updated since the last checkout. Use 'git pull' to integrate the\n"
> +	   "remote changes before pushing again, or use 'git push --force' to delete\n"
> +	   "the remote changes and replace them with your own.\n");
>   
>   static void advise_pull_before_push(void)
>   {
