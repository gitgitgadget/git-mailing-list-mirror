Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40C3F1F804
	for <e@80x24.org>; Fri, 28 Dec 2018 20:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388029AbeL1UMS (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 15:12:18 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37695 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388008AbeL1UMS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 15:12:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id s12so21806699wrt.4
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 12:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=NX/k5m4j8HQGkMjKSTYO1/NMvIBoxd/H97ImQhPKduU=;
        b=u7yQ4TKstWmQ6Liq/rGCV5qNnlIo2zXEzV/YD6BJJQx/5pay2jnqMjI4lvYmlD3E7J
         /omifopPE13NfBkMmMZFxQFvKHJi7L8dO2Dv7S9pL6mTZ1cSevJlqtgzuH8M4aS/PdIq
         4Bkvi/5yE6kDuVlD1Yq2moWrVbMwtsQmJP/wXeiyuvWL6oFyFjLRM4WSRDgxPxiXvxK+
         Ib9pXlHiovs7OSE0LWz+bn5kCUE/U3WJXg5xdxJwZzMWtR9XeFS8cS3FlVDTB4KRg3+V
         hUr6RBp91NAnSTrcuIy7q+auXcFzUYq4+1zUIQWbJSiGJJuu81QpVG8qw5UeMbgeS0XW
         PwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=NX/k5m4j8HQGkMjKSTYO1/NMvIBoxd/H97ImQhPKduU=;
        b=uM/XmTzF2snb1ICFTqtRVSQiTWJYcdk7VRoHukYLVFy0KGieamO8/iKAeIX+hAmhuy
         enyC0b5ueJelavSDg4tEajiaeytn7T3S16lbUArO85e0bGnFRXq4OwUQqZex496Ajx3m
         cLboSnV4ZAn46iGfHi6ch8hRXfbGGjR08AXtT32KXMNwTofjS/vGQ9bVn1vvlyfjqDD/
         0b5WuP9+M5E/7OnE5Zev5UKxPuNEe44KsTt6XoF+uKwMr/YhqY4iQeeP8y2eqpb1h/vu
         Psp08RGsMM++8kFD57fgkEZy10bphLf420c+aZGQuIkbSo6/IAUkwieZQADk9bg5sgMj
         l6MQ==
X-Gm-Message-State: AJcUukd6txR3S4U+/1nsuWKU9yqnFE/bLF7hhM0im1dyBMEu8ASoqNlN
        YznzWCkH7uZuHdAh2fCnGT0=
X-Google-Smtp-Source: ALg8bN6txU3uf5Fl/JQYNvvSH5FHKcp4b+RnYGEnBtHCp7fpp/9NF9c5615qSOL1TrYuZ1TLXpM8AQ==
X-Received: by 2002:adf:9ec8:: with SMTP id b8mr27445957wrf.164.1546027936158;
        Fri, 28 Dec 2018 12:12:16 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a17sm18300978wma.15.2018.12.28.12.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 12:12:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] submodule: unset core.worktree if no working tree is present
Date:   Wed, 26 Dec 2018 10:27:11 -0800
References: <xmqqefas8ss4.fsf@gitster-ct.c.googlers.com>
        <20181214235945.41191-1-sbeller@google.com>
        <20181214235945.41191-3-sbeller@google.com>
Message-ID: <xmqq8t09o1gg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> 2018-09-07). The revert was needed as the nearby commit e98317508c
> (submodule: ensure core.worktree is set after update, 2018-06-18) is
> faulty and at the time of 7e25437d35 (Merge branch
> 'sb/submodule-core-worktree', 2018-07-18) we could not revert the faulty
> commit only, as they were depending on each other: If core.worktree is
> unset, we have to have ways to ensure that it is set again once
> the working tree reappears again.
>
> Now that 4d6d6ef1fc (Merge branch 'sb/submodule-update-in-c', 2018-09-17),
> specifically 74d4731da1 (submodule--helper: replace
> connect-gitdir-workingtree by ensure-core-worktree, 2018-08-13) is
> present, we already check and ensure core.worktree is set when
> populating a new work tree, such that we can re-introduce the commits
> that unset core.worktree when removing the worktree.

Cleanly explained.  Will queue.  Thanks.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c               | 14 ++++++++++++++
>  submodule.h               |  2 ++
>  t/lib-submodule-update.sh |  3 ++-
>  3 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/submodule.c b/submodule.c
> index 6415cc5580..d393e947e6 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1561,6 +1561,18 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
>  	return ret;
>  }
>  
> +void submodule_unset_core_worktree(const struct submodule *sub)
> +{
> +	char *config_path = xstrfmt("%s/modules/%s/config",
> +				    get_git_common_dir(), sub->name);
> +
> +	if (git_config_set_in_file_gently(config_path, "core.worktree", NULL))
> +		warning(_("Could not unset core.worktree setting in submodule '%s'"),
> +			  sub->path);
> +
> +	free(config_path);
> +}
> +
>  static const char *get_super_prefix_or_empty(void)
>  {
>  	const char *s = get_super_prefix();
> @@ -1726,6 +1738,8 @@ int submodule_move_head(const char *path,
>  
>  			if (is_empty_dir(path))
>  				rmdir_or_warn(path);
> +
> +			submodule_unset_core_worktree(sub);
>  		}
>  	}
>  out:
> diff --git a/submodule.h b/submodule.h
> index a680214c01..9e18e9b807 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -131,6 +131,8 @@ int submodule_move_head(const char *path,
>  			const char *new_head,
>  			unsigned flags);
>  
> +void submodule_unset_core_worktree(const struct submodule *sub);
> +
>  /*
>   * Prepare the "env_array" parameter of a "struct child_process" for executing
>   * a submodule by clearing any repo-specific environment variables, but
> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> index 016391723c..51d4555549 100755
> --- a/t/lib-submodule-update.sh
> +++ b/t/lib-submodule-update.sh
> @@ -709,7 +709,8 @@ test_submodule_recursing_with_args_common() {
>  			git branch -t remove_sub1 origin/remove_sub1 &&
>  			$command remove_sub1 &&
>  			test_superproject_content origin/remove_sub1 &&
> -			! test -e sub1
> +			! test -e sub1 &&
> +			test_must_fail git config -f .git/modules/sub1/config core.worktree
>  		)
>  	'
>  	# ... absorbing a .git directory along the way.
