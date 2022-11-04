Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495F9C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 01:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiKDBhn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 21:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiKDBhl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 21:37:41 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4210B1F2D7
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 18:37:40 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x2so5658575edd.2
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 18:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e16sYZlLtfnQ06O0Dnq1LkIssIjuZkdsSiLgF3gtVII=;
        b=i/XUmopNyORpG4ONLCdVkNT1+NOtQYGrFgHmR2u82gDmklaRK1+kOv5zW39Pi/lju3
         5fXsxKL2er38zuN3JtIZTxM1CjcMnkehJk386jQEpwVODXKEyLg4r23+8B0TJh9lcQqn
         MEV0WE43VAXCx6j1rCpdsqZjz0gS0C6JVLHaBlac6pE729HgRwFNeATTBwg+DNey0xxN
         89L8+V/UH3h0f3joCH1NabyQmkLll4v4GDD+YQVY8skri7TS29szy6IxPTggctBV9JSl
         vu2GAdD9IYa6nxcZTSPvxtHKFV9JivRFXLoAUGW/z+Ber0YwknRW/Zjuc2di8g+fmmQ1
         t0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e16sYZlLtfnQ06O0Dnq1LkIssIjuZkdsSiLgF3gtVII=;
        b=z9Xxlv19OXdIMayPTaC/B59AGgrBzJKs/Grq0G5A3S+UUKsBAtSI4/K8c87GjA3jhw
         yNOCBGZy/XvVw0Eg+7FGr0W4gal9HZth1F4AOwT2S0SPD8EAY2gqKcVV5sD6hxTLdsUa
         0Bc4NgJeXwLQxh3dhowNZOkX6en/SkmIM8kMDYW0Ycto3YYuaF22hcjfN8987MV1nX//
         /o34s6F8E6UeILWAW7A6pLgYjzGLgVy+n367nwNX9KftM/5uE9JAzvT5CY9GfGHCO6d8
         15FJSXMI/UQe9CVUuA4uoj3DMIJev6gcSxGVj2BT+FmErY852bNqazYvgEtvPXqWrZsC
         AjVg==
X-Gm-Message-State: ACrzQf3aI//26JisHhn2eLLs8PCTGK9xSA6u+GRPNnuWxQG6uw3Aj4OE
        2Gn9LzTuzBRU0PJPBH+KyykaolU47v+SEA==
X-Google-Smtp-Source: AMsMyM5oRFMoF+25OUMa77GrBiBMQFVUEvc5kxVhQwbtSwvwlVq+h6bPgBi+6mtaTC4st6D/77Ss2g==
X-Received: by 2002:a05:6402:3457:b0:463:2017:ae64 with SMTP id l23-20020a056402345700b004632017ae64mr29262775edc.218.1667525858773;
        Thu, 03 Nov 2022 18:37:38 -0700 (PDT)
Received: from gmgdl (j84064.upc-j.chello.nl. [24.132.84.64])
        by smtp.gmail.com with ESMTPSA id ky6-20020a170907778600b007adaccb9d83sm1126454ejc.193.2022.11.03.18.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 18:37:38 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqleL-00D1nk-2b;
        Fri, 04 Nov 2022 02:37:37 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] worktree add: add --orphan flag
Date:   Fri, 04 Nov 2022 02:33:36 +0100
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221104010242.11555-4-jacobabel@nullpo.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221104010242.11555-4-jacobabel@nullpo.dev>
Message-ID: <221104.86o7tnzehq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 04 2022, Jacob Abel wrote:

>  	commit = lookup_commit_reference_by_name(refname);
> -	if (!commit)
> +

Here.

> +	if (!commit && !opts->implicit)
>  		die(_("invalid reference: %s"), refname);
>
>  	name = worktree_basename(path, &len);
> @@ -482,10 +487,10 @@ static int add_worktree(const char *path, const char *refname,
>  	strvec_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
>  	cp.git_cmd = 1;
>
> -	if (!is_branch)
> +	if (!is_branch && commit) {
>  		strvec_pushl(&cp.args, "update-ref", "HEAD",
>  			     oid_to_hex(&commit->object.oid), NULL);

And here we have a stray style change, in this case conforming to our
CodingGuidelines (it's agnostic on the former), but IMO better to keep
this out, or split it into a "various style stuff" commit, makes this
harder to review...

> -	else {
> +	} else {
>  		strvec_pushl(&cp.args, "symbolic-ref", "HEAD",
>  			     symref.buf, NULL);
>  		if (opts->quiet)
> @@ -516,7 +521,7 @@ static int add_worktree(const char *path, const char *refname,
>  	 * Hook failure does not warrant worktree deletion, so run hook after
>  	 * is_junk is cleared, but do return appropriate code when hook fails.
>  	 */
> -	if (!ret && opts->checkout) {
> +	if (!ret && opts->checkout && !opts->orphan_branch) {
>  		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
>
>  		strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
> @@ -608,33 +613,52 @@ static int add(int ac, const char **av, const char *prefix)
>  	const char *opt_track = NULL;
>  	const char *lock_reason = NULL;
>  	int keep_locked = 0;
> +

ditto, we don't usually \n\n split up varibale decls.

>  	struct option options[] = {
> -		OPT__FORCE(&opts.force,
> -			   N_("checkout <branch> even if already checked out in other worktree"),
> -			   PARSE_OPT_NOCOMPLETE),
> +		OPT__FORCE(
> +			&opts.force,
> +			N_("checkout <branch> even if already checked out in other worktree"),
> +			PARSE_OPT_NOCOMPLETE),

This is just a stray refactoring of existing code to not-our-usual-style
(first arg is on the same line as the "(", rest aligned with "(").

>  		OPT_STRING('b', NULL, &new_branch, N_("branch"),
>  			   N_("create a new branch")),
>  		OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
>  			   N_("create or reset a branch")),
> -		OPT_BOOL('d', "detach", &opts.detach, N_("detach HEAD at named commit")),
> -		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
> -		OPT_BOOL(0, "lock", &keep_locked, N_("keep the new working tree locked")),
> +		OPT_STRING(0, "orphan", &opts.orphan_branch, N_("branch"),
> +			   N_("create a new unparented branch")),
> +		OPT_BOOL('d', "detach", &opts.detach,
> +			 N_("detach HEAD at named commit")),
> +		OPT_BOOL(0, "checkout", &opts.checkout,
> +			 N_("populate the new working tree")),
> +		OPT_BOOL(0, "lock", &keep_locked,
> +			 N_("keep the new working tree locked")),

Ditto, these look like they're too-long in the pre-image, but please
resist re-flowing existing code while at it.

>  		OPT_STRING(0, "reason", &lock_reason, N_("string"),
>  			   N_("reason for locking")),
>  		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
>  		OPT_PASSTHRU(0, "track", &opt_track, NULL,
>  			     N_("set up tracking mode (see git-branch(1))"),
>  			     PARSE_OPT_NOARG | PARSE_OPT_OPTARG),
> -		OPT_BOOL(0, "guess-remote", &guess_remote,
> -			 N_("try to match the new branch name with a remote-tracking branch")),
> +		OPT_BOOL(
> +			0, "guess-remote", &guess_remote,
> +			N_("try to match the new branch name with a remote-tracking branch")),

ditto.

>  		OPT_END()
>  	};
>
>  	memset(&opts, 0, sizeof(opts));
>  	opts.checkout = 1;
>  	ac = parse_options(ac, av, prefix, options, git_worktree_add_usage, 0);
> -	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
> -		die(_("options '%s', '%s', and '%s' cannot be used together"), "-b", "-B", "--detach");
> +
> +	opts.implicit = ac < 2;
> +
> +	if (!!opts.detach + !!new_branch + !!new_branch_force +
> +		    !!opts.orphan_branch >
> +	    1)

The continued "if" is mis-indented, and that "1" is on a line of its
own...
