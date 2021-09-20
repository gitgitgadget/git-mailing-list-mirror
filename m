Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF3AC433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 10:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9964B60F6D
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 10:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhITKUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 06:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhITKUh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 06:20:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C6BC061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 03:19:10 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w29so28055010wra.8
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 03:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gzvmf3t3QmJhHL+v3Rxt/dGQSyYNw9PAzWVpauPrc0I=;
        b=hQzGYZTAnSwUJAdkY6xQkYFdwAFe4y8X+cPvadYNJDmXKUTFZCEneT1U4X573tsN7F
         L40bR46VW0BdSB3UGyiGbmdj+BR/ow2IGjngTsFyi2k0iwSulEzJqnR27egfR3XIlf6C
         JPoik6Ve9T6PdkSdSjHr8RM9q9R3jL3jwBXMcFXpjfkk0NyIec6B5IPQeoVnjPLo9VtS
         32FOP9roS0/sFmQ1YJRi2S9azv4cYZjbUE6qC+yWm8NCodvNNhffKB3vWuOngkxiii3K
         BksNNUDYJvsRbQ07TzLiaMYDhkWHKUZYKhkb8havCOFNtYTeyEXK314qEkqx/MbOwqxe
         a2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Gzvmf3t3QmJhHL+v3Rxt/dGQSyYNw9PAzWVpauPrc0I=;
        b=gTXkod+X51ejMYifrHD0jJ8RrHNj5U0Fcxdwo1Sb3MQtjF67ndUHu7z91smmgTD0k+
         rH9ks5oXlXVs9a4zht9W0tvO0mfgdz0XY8RaJ7agFU9EgDClS2MSLp4FBpZp5GWIBWco
         XLnSiLqFoTbp1Rldz2tqww8xqZ+PIFA/8rzSpv7Xpby5tmiW6dwZ26C1kmajswIZfZDj
         4ii1Bjz8kAvAwYUbIJe2IwZz4n8/f4Is0eemAEvpQVgeNkAeuBbBZKZ3/xV1Jzoh0zhV
         FyW4H2M4jxCEw4Txw5Nm7Gd6Uvy1KP890rywcUdBB6qsbhCaGBSy04recK3LQM9cFGy+
         kDhQ==
X-Gm-Message-State: AOAM533XPHD8WTOSc4gDOQfqeEFCPP1DpaEZ5eKA8AjFxFp+Epb5TOgT
        jZj7uHCLw3hlf8iLLvEBHxU=
X-Google-Smtp-Source: ABdhPJxkSvzk86wBmPSO4Byk0LavhYWQps04mJjHLITbLwBc0/hsXGuuqjo4CfGSlp9+5VvrglulRA==
X-Received: by 2002:a05:600c:3b97:: with SMTP id n23mr4670956wms.93.1632133149171;
        Mon, 20 Sep 2021 03:19:09 -0700 (PDT)
Received: from [192.168.1.201] (178.2.7.51.dyn.plus.net. [51.7.2.178])
        by smtp.googlemail.com with ESMTPSA id v18sm14636804wml.44.2021.09.20.03.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 03:19:08 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/6] Split unpack_trees 'reset' flag into two for
 untracked handling
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
 <45bd05a945f034d03555f04a1ba85835482dc591.1632006923.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <acef3628-9542-d777-2534-577de9707e15@gmail.com>
Date:   Mon, 20 Sep 2021 11:19:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <45bd05a945f034d03555f04a1ba85835482dc591.1632006923.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/09/2021 00:15, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Traditionally, unpack_trees_options->reset was used to signal that it
> was okay to delete any untracked files in the way.  This was used by
> `git read-tree --reset`, but then started appearing in other places as
> well.  However, many of the other uses should not be deleting untracked
> files in the way.  Split this into two separate fields:
>     reset_nuke_untracked
>     reset_keep_untracked
> and, since many code paths in unpack_trees need to be followed for both
> of these flags, introduce a third one for convenience:
>     reset_either
> which is simply an or-ing of the other two.

See [1] for an alternative approach that used an enum instead of adding 
mutually exclusive flags.

> Modify existing callers so that
>     read-tree --reset

it would be nice if read-tree callers could choose whether they want to 
remove untracked files or not - that could always be added later. This 
patch changes the behavior of 'git read-tree -m -u' (and other commands) 
so that they will overwrite ignored files - I'm in favor of that change 
but it would be good to spell out the change in the commit message.

>     reset --hard
>     checkout --force

I often use checkout --force to clear unwanted changes when I'm 
switching branches, I'd prefer it if it did not remove untracked files.

> continue using reset_nuke_untracked, but so that other callers,
> including
>     am
>     checkout without --force
>     stash  (though currently dead code; reset always had a value of 0)
>     numerous callers from rebase/sequencer to reset_head()
> will use the new reset_keep_untracked field.

This is great. In the discussion around [1] there is a mention of 'git 
checkout <pathspec>' which also overwrites untracked files. It does not 
use unpack_trees() so is arguably outside the scope of what you're doing 
here but it might be worth mentioning.

> [...]
> diff --git a/builtin/read-tree.c b/builtin/read-tree.c
> index 485e7b04794..8b94e1aa261 100644
> --- a/builtin/read-tree.c
> +++ b/builtin/read-tree.c
> @@ -133,7 +133,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
>   			 N_("3-way merge if no file level merging required")),
>   		OPT_BOOL(0, "aggressive", &opts.aggressive,
>   			 N_("3-way merge in presence of adds and removes")),
> -		OPT_BOOL(0, "reset", &opts.reset,
> +		OPT_BOOL(0, "reset", &opts.reset_keep_untracked,
>   			 N_("same as -m, but discard unmerged entries")),
>   		{ OPTION_STRING, 0, "prefix", &opts.prefix, N_("<subdirectory>/"),
>   		  N_("read the tree into the index under <subdirectory>/"),
> @@ -162,6 +162,11 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
>   	opts.head_idx = -1;
>   	opts.src_index = &the_index;
>   	opts.dst_index = &the_index;
> +	if (opts.reset_keep_untracked) {
> +		opts.dir = xcalloc(1, sizeof(*opts.dir));
> +		opts.dir->flags |= DIR_SHOW_IGNORED;
> +		setup_standard_excludes(opts.dir);
> +	}

Does this clobber any excludes added by --exclude-per-directory?

> diff --git a/builtin/reset.c b/builtin/reset.c
> index 43e855cb887..ba39c4882a6 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -10,6 +10,7 @@
>   #define USE_THE_INDEX_COMPATIBILITY_MACROS
>   #include "builtin.h"
>   #include "config.h"
> +#include "dir.h"
>   #include "lockfile.h"
>   #include "tag.h"
>   #include "object.h"
> @@ -70,9 +71,19 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
>   		break;
>   	case HARD:
>   		opts.update = 1;
> -		/* fallthrough */
> +		opts.reset_nuke_untracked = 1;
> +		break;
> +	case MIXED:
> +		opts.reset_keep_untracked = 1; /* but opts.update=0, so untracked left alone */
> +		break;
>   	default:
> -		opts.reset = 1;
> +		BUG("invalid reset_type passed to reset_index");

There is no case SOFT: but in that case we don't call reset_index() so 
we're OK.

> diff --git a/reset.c b/reset.c
> index 79310ae071b..0880c76aef9 100644
> --- a/reset.c
> +++ b/reset.c
> @@ -1,5 +1,6 @@
>   #include "git-compat-util.h"
>   #include "cache-tree.h"
> +#include "dir.h"
>   #include "lockfile.h"
>   #include "refs.h"
>   #include "reset.h"
> @@ -57,8 +58,12 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
>   	unpack_tree_opts.update = 1;
>   	unpack_tree_opts.merge = 1;
>   	init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
> -	if (!detach_head)
> -		unpack_tree_opts.reset = 1;

Unrelated to this patch but this looks dodgy to me. For 'git rebase 
<upstream> <branch>' where <branch> is ahead of <upstream> we skip the 
rebase and use reset_head() to checkout <branch> without 'detach_head' 
set. I think this should be checking 'reset_hard' instead of 'detach_head'

> diff --git a/unpack-trees.c b/unpack-trees.c
> index 5786645f315..d952eebe96a 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -301,7 +301,7 @@ static int check_submodule_move_head(const struct cache_entry *ce,
>   	if (!sub)
>   		return 0;
>   
> -	if (o->reset)
> +	if (o->reset_nuke_untracked)
>   		flags |= SUBMODULE_MOVE_HEAD_FORCE;
>   
>   	if (submodule_move_head(ce->name, old_id, new_id, flags))
> @@ -1696,6 +1696,13 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>   	if (len > MAX_UNPACK_TREES)
>   		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
>   
> +	if (o->reset_nuke_untracked && o->reset_keep_untracked)
> +		BUG("reset_nuke_untracked and reset_keep_untracked are incompatible");
> +
> +	o->reset_either = 0;
> +	if (o->reset_nuke_untracked || o->reset_keep_untracked)
> +		o->reset_either = 1;

<bikeshed>
o->reset_either = o->reset_nuke_untracked | o->reset_keep_untracked
</bikeshed>

> diff --git a/unpack-trees.h b/unpack-trees.h
> index 2d88b19dca7..c419bf8b1f9 100644
> --- a/unpack-trees.h
> +++ b/unpack-trees.h
> @@ -46,7 +46,9 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
>   void clear_unpack_trees_porcelain(struct unpack_trees_options *opts);
>   
>   struct unpack_trees_options {
> -	unsigned int reset,
> +	unsigned int reset_nuke_untracked,
> +		     reset_keep_untracked,
> +		     reset_either, /* internal use only */

I think I prefer the enum approach in [1] but I'm biased and I'm not 
sure it's worth getting excited about. Thanks for working on this it 
will be great to have git stop overwriting untracked files so often.

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/20190501101403.20294-1-phillip.wood123@gmail.com/


>   		     merge,
>   		     update,
>   		     clone,
> 

