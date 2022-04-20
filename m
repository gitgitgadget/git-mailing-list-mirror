Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D1FC433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 10:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242339AbiDTK04 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 06:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiDTK0y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 06:26:54 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1A23F310
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 03:24:08 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id s25so1620818edi.13
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 03:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=XHNdigU2EyhlBkgVbdVajAEBx8b5DzRS//CSPbV1iKs=;
        b=OL/pejEd23XIu4ITs1IYzXYGHTGXmGdRzd+eB3wNBuil6K8g4kQNQ+xNeE1UoRR4VK
         2lu820C77zDdUMkNWtbynxFf8O8a/m9UU1QtnMqD1G/LVhB3SrbcQA1vgwCMekH9s/79
         vxl91roJxJAzj/rcPpTrUs971vtuLqLc/110Ze1JG6lkBEvKIDW7nALf8gUkMgpQyq55
         jy/7cm9yuthdX9E+RnliaZ/Fr2HlkMZKWjblrz10CxNsbpJtpgEvsNj7vYlSfkrWRazC
         +uCwrezlRpZdXBuu+xelIC1PMP7n/lWgkuN/Dz1SOO74WH7G6iJflyByebmjIKpJnjhz
         FVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=XHNdigU2EyhlBkgVbdVajAEBx8b5DzRS//CSPbV1iKs=;
        b=ysrcqAki2W8oZRO4uplMPnI3YUA9rc9U3HMtxm06+gtP0KFmaL/7HK3w6NvxlWnLpG
         XMHfssVWecX4jDJxMFXejYz9bHZxGrztV7THvONZm/yH7WBxKr9P6pZpmE1tdcEhaWU7
         fNQOCOSaEiwuIP1CiimASzLGu6BfOiUDkj+mZunB1vgMfUNhf+V5AkUPlGCdXuJjA7/p
         D4VtYRRW6Sb2JexcdIAlx68FeFmTYauznV5b+/BKTKa2o4ydxNyqXB8bu+IGafj0duQa
         4BflKGnEBHt5LsJ20nJR/VOPh5WdT/uAVfzlQFLWtEa3SYF944X31cMkpY8IEk5U1tAl
         QCOQ==
X-Gm-Message-State: AOAM5304hmzKEgPzzyDTRZsNXzX1dWJj3TNNUPfrhQz3DboykU2WFAJ8
        TifY5t5sw/d110uNDK0fJa7/+cnJF3s=
X-Google-Smtp-Source: ABdhPJyseC3LV0otHKiCj3vHsU3HBDERmS1Ay8AmgK5BZUMUwNV2QdPBM6/UY13FoSLQZH7I0Pm1Ew==
X-Received: by 2002:aa7:d3c7:0:b0:41d:805a:153a with SMTP id o7-20020aa7d3c7000000b0041d805a153amr22399320edr.316.1650450246202;
        Wed, 20 Apr 2022 03:24:06 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k15-20020a50ce4f000000b00420119333c1sm9909957edj.62.2022.04.20.03.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 03:24:05 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nh7VF-007FyG-5t;
        Wed, 20 Apr 2022 12:24:05 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 6/8] rebase --apply: make reflog messages match
 rebase --merge
Date:   Wed, 20 Apr 2022 12:22:54 +0200
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
 <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
 <95161f21e0004cff1bb0915aa39200b286e592e5.1650448612.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <95161f21e0004cff1bb0915aa39200b286e592e5.1650448612.git.gitgitgadget@gmail.com>
Message-ID: <220420.865yn4833u.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 20 2022, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The apply backend creates slightly different reflog messages to the
> merge backend when starting and finishing a rebase and when picking
> commits. The choice of backend is really an implementation detail so
> it is confusing to have the same command create different messages
> depending on which backend is selected. Change the apply backend so
> the reflog messages from the two backends match as closely as
> possible. Note that there is still a difference when committing a
> conflict resolution - the merge backend will use "(continue)" rather
> than "(pick)" in that case as it does not know which command created
> the conflict that it is committing.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/rebase.c          | 9 +++++----
>  t/t3406-rebase-message.sh | 2 +-
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index e50361fc2a9..678339c7bf7 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -580,10 +580,10 @@ static int move_to_original_branch(struct rebase_options *opts)
>  	if (!opts->onto)
>  		BUG("move_to_original_branch without onto");
>  
> -	strbuf_addf(&branch_reflog, "%s finished: %s onto %s",
> +	strbuf_addf(&branch_reflog, "%s (finish): %s onto %s",
>  		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
>  		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
> -	strbuf_addf(&head_reflog, "%s finished: returning to %s",
> +	strbuf_addf(&head_reflog, "%s (finish): returning to %s",
>  		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), opts->head_name);
>  	ropts.branch = opts->head_name;
>  	ropts.flags = RESET_HEAD_REFS_ONLY;
> @@ -613,7 +613,8 @@ static int run_am(struct rebase_options *opts)
>  
>  	am.git_cmd = 1;
>  	strvec_push(&am.args, "am");
> -
> +	strvec_pushf(&am.env_array, GIT_REFLOG_ACTION_ENVIRONMENT "=%s (pick)",
> +		     getenv(GIT_REFLOG_ACTION_ENVIRONMENT));
>  	if (opts->action && !strcmp("continue", opts->action)) {
>  		strvec_push(&am.args, "--resolved");
>  		strvec_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
> @@ -1763,7 +1764,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		printf(_("First, rewinding head to replay your work on top of "
>  			 "it...\n"));
>  
> -	strbuf_addf(&msg, "%s: checkout %s",
> +	strbuf_addf(&msg, "%s (start): checkout %s",
>  		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
>  	ropts.oid = &options.onto->object.oid;
>  	ropts.orig_head = &options.orig_head,
> diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
> index bb2a4949abc..5c6cd9af3bc 100755
> --- a/t/t3406-rebase-message.sh
> +++ b/t/t3406-rebase-message.sh
> @@ -88,7 +88,7 @@ test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
>  write_reflog_expect () {
>  	if test $mode = --apply
>  	then
> -		sed 's/(finish)/finished/; s/ ([^)]*)//'
> +		sed 's/(continue)/(pick)/'
>  	else
>  		cat
>  	fi >expect

I like the new message better, but I wonder given that the old message
has been with us since 6fd2f5e60d4 (rebase: operate on a detached HEAD,
2007-11-08) whether this will break anything in the wild.
