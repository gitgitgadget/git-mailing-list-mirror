Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7DB61F453
	for <e@80x24.org>; Thu, 25 Apr 2019 10:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbfDYKdS (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 06:33:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45000 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730384AbfDYKdS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 06:33:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id c5so20687119wrs.11
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 03:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PM9K6BuFbollN8zmBRKvM0k11KMCw1PKijTqaMC3Dlw=;
        b=er0QTHYX/78E9yuIdrWuBTQy3hm4a0piwiklmvphZp9j4FjHps+ARS9+QFNo50ZQqr
         /8S/3KE/G6OiWstcreKkx/9xRA7I1OyR0SuHTefWMNJdIk4WZphcX7keK/3CbY98cBng
         E4K61W+ty1c9kfTsDLr/GoE6LA8gz1DF5ojtjxdqpzEi1D4iVb6bI973MXiTzGD8OxEa
         Hv3KJVDwuoghFgooq/mYLClJBlBCm5NEIZiCbFPcz8WDxl9MHWcIf++wG2zQGNHGE86C
         ToLnMjuce2cU5w1PbwXk3AqVoRhC5xM6CTT7+tMj4yqJySdg1p6xGEZS5F0WcU4Ubi/C
         bvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PM9K6BuFbollN8zmBRKvM0k11KMCw1PKijTqaMC3Dlw=;
        b=MW7+riGnK0uwbgtvJS9AoBD5C7lhcjLrken+4VHuRdd4xk9HMPHKsYG23vBiylIWz8
         7kdLTxiK7M0P8YJKejmKlfQ2f4BxfvFKUAjaRsmG9d9kR0C8JKMATd14dpKyV8uCyryb
         ib3ys70j/prqEyGBbmfYPwan7ktSE5kKSz6Up6AIdQO0p+n49Q0r+YSMA4ZDdkP2kD5k
         Gs5ukP04HjtLuSUx9VkIQVca9QawtrE4/JWPcgTlJ+MQzWpfHf7A17qq4r+muaJ28Rld
         D4zyyyyDTb5bMm5ME5nq0uEsHa/U0fg/o0Jqh9QsVbF+zvwP2YqIYfgNmrV9jwkuihBp
         PfJw==
X-Gm-Message-State: APjAAAXm44vLM2TycX0tMBuPATI0mJmFX8ZWD06wr7Weh9zHP2MK0QZ/
        QVKhvERgUkWM1KaGm6Q+sUY=
X-Google-Smtp-Source: APXvYqyKcfqeOZ7/v7RXJq1gvvfBgGMZ1zZ0odWHXz8hUBGka9F+nLADJh7OpXfco16qx9Q3HGaA9A==
X-Received: by 2002:a5d:62cf:: with SMTP id o15mr3867658wrv.45.1556188396141;
        Thu, 25 Apr 2019 03:33:16 -0700 (PDT)
Received: from [192.168.2.201] (host-92-26-127-169.as13285.net. [92.26.127.169])
        by smtp.googlemail.com with ESMTPSA id t74sm30469725wmt.3.2019.04.25.03.33.14
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 03:33:15 -0700 (PDT)
Subject: Re: [PATCH v6 23/27] switch: reject if some operation is in progress
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, rybak.a.v@gmail.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
References: <20190321131655.15249-1-pclouds@gmail.com>
 <20190329103919.15642-1-pclouds@gmail.com>
 <20190329103919.15642-24-pclouds@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <78c7c281-82ec-2ba9-a607-dd2ecba54945@gmail.com>
Date:   Thu, 25 Apr 2019 11:33:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190329103919.15642-24-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/03/2019 10:39, Nguyễn Thái Ngọc Duy wrote:
> Unless you know what you're doing, switching to another branch to do
> something then switching back could be confusing. Worse, you may even
> forget that you're in the middle of something. By the time you realize,
> you may have done a ton of work and it gets harder to go back.
> 
> A new option --ignore-in-progress was considered but dropped because it
> was not exactly clear what should happen. Sometimes you can switch away
> and get back safely and resume the operation. Sometimes not. And the
> git-checkout behavior is automatically clear merge/revert/cherry-pick,
> which makes it a bit even more confusing [1].
> 
> We may revisit and add this option in the future. But for now play it
> safe and not allow it (you can't even skip this check with --force).

I think this is a good compromise, lets see how it goes (I think I
broadly agree with Elijah's suggestion to allow the switch if we can
safely switch back again if we want to add --ignore-in-progress in the
future).

> The
> user is suggested to cancel the operation by themselves (and hopefully
> they do consider the consequences, not blindly type the command), or to
> create a separate worktree instead of switching. The third option is
> the good old "git checkout", but it's not mentioned.
> 
> [1] CACsJy8Axa5WsLSjiscjnxVK6jQHkfs-gH959=YtUvQkWriAk5w@mail.gmail.com
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  builtin/checkout.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index f7967cdb7c..5f100c1552 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -24,6 +24,7 @@
>  #include "tree.h"
>  #include "tree-walk.h"
>  #include "unpack-trees.h"
> +#include "wt-status.h"
>  #include "xdiff-interface.h"
>  
>  static const char * const checkout_usage[] = {
> @@ -56,6 +57,7 @@ struct checkout_opts {
>  	int accept_pathspec;
>  	int switch_branch_doing_nothing_is_ok;
>  	int only_merge_on_switching_branches;
> +	int can_switch_when_in_progress;
>  
>  	const char *new_branch;
>  	const char *new_branch_force;
> @@ -1202,6 +1204,39 @@ static void die_expecting_a_branch(const struct branch_info *branch_info)
>  	die(_("a branch is expected, got '%s'"), branch_info->name);
>  }
>  
> +static void die_if_some_operation_in_progress(void)
> +{
> +	struct wt_status_state state;
> +
> +	memset(&state, 0, sizeof(state));
> +	wt_status_get_state(the_repository, &state, 0);
> +
> +	if (state.merge_in_progress)
> +		die(_("cannot switch branch while merging\n"
> +		      "Consider \"git merge --quit\" "
> +		      "or \"git worktree add\"."));

I'm not sure merge --quit exists, 'git grep \"quit origin/pu' shows
matches for builtin/{am.c,rebase.c,revert.c}. The --quit option for the
sequencer command does not touch the index or working tree (that's the
difference between --quit and --abort) so the switch can still fail due
changes in the index and worktree that would be overwritten by the switch.

Best Wishes

Phillip

> +	if (state.am_in_progress)
> +		die(_("cannot switch branch in the middle of an am session\n"
> +		      "Consider \"git am --quit\" "
> +		      "or \"git worktree add\"."));
> +	if (state.rebase_interactive_in_progress || state.rebase_in_progress)
> +		die(_("cannot switch branch while rebasing\n"
> +		      "Consider \"git rebase --quit\" "
> +		      "or \"git worktree add\"."));
> +	if (state.cherry_pick_in_progress)
> +		die(_("cannot switch branch while cherry-picking\n"
> +		      "Consider \"git cherry-pick --quit\" "
> +		      "or \"git worktree add\"."));
> +	if (state.revert_in_progress)
> +		die(_("cannot switch branch while reverting\n"
> +		      "Consider \"git revert --quit\" "
> +		      "or \"git worktree add\"."));
> +	if (state.bisect_in_progress)
> +		die(_("cannot switch branch while bisecting\n"
> +		      "Consider \"git bisect reset HEAD\" "
> +		      "or \"git worktree add\"."));
> +}
> +
>  static int checkout_branch(struct checkout_opts *opts,
>  			   struct branch_info *new_branch_info)
>  {
> @@ -1257,6 +1292,9 @@ static int checkout_branch(struct checkout_opts *opts,
>  	    !new_branch_info->path)
>  		die_expecting_a_branch(new_branch_info);
>  
> +	if (!opts->can_switch_when_in_progress)
> +		die_if_some_operation_in_progress();
> +
>  	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
>  	    !opts->ignore_other_worktrees) {
>  		int flag;
> @@ -1514,6 +1552,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  	opts.only_merge_on_switching_branches = 0;
>  	opts.accept_pathspec = 1;
>  	opts.implicit_detach = 1;
> +	opts.can_switch_when_in_progress = 1;
>  
>  	options = parse_options_dup(checkout_options);
>  	options = add_common_options(&opts, options);
> @@ -1549,6 +1588,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
>  	opts.switch_branch_doing_nothing_is_ok = 0;
>  	opts.only_merge_on_switching_branches = 1;
>  	opts.implicit_detach = 0;
> +	opts.can_switch_when_in_progress = 0;
>  
>  	options = parse_options_dup(switch_options);
>  	options = add_common_options(&opts, options);
> 

