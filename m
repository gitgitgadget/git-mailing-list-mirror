Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0008FC433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 10:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240603AbiFNKLE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 06:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiFNKLD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 06:11:03 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5EE3F324
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 03:11:01 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x17so10567734wrg.6
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 03:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eUWuKVVrAGTuDKefCAabry8YF8+P5/Ld1uod3qoUTP0=;
        b=pmJFDcShXWRthtkETzUwNJvpKyzt7Ztqw7vFBt79ejJK3PQHhdembrE2351mzKyPwI
         SppsLKtvEKIKHVtM2GwwUoMFcpS9EJJnMBstsUj90gZMhNMTRd7H8DUZCgAOyLynl4uV
         3UYsaS9U5vB6e21532v4MyHf3OvJ37ZIjPOeyf3JUVbfGiG7MUViqmoonZah/jIf4UN3
         2Gd5nukEM/tNxouG1t4J8B23G3Bxc+KjJ2kgM/eqYjA7WD8IcQbll0JHfhqq48127dP5
         slJS2yu1YQW2kA50hjmdK1OBNfkrmtv82yYjabXL1DlrJcjCeIcCgGuOE1av2C5WpjER
         d7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eUWuKVVrAGTuDKefCAabry8YF8+P5/Ld1uod3qoUTP0=;
        b=zJ3FyOii/QuPgycc3YvzNXChaD6XVE7Hol0OnPo485U7PX5aF7BxIhfaglM7dlnXHY
         D/+UmC52eX2jXtLbWTxnaFgbdTA4HTeg0M6ZpBdDlcYCxCpDFkMEsUVbK8Ia4zzUTovU
         SvS7unchTfMH9WOr7MHrNLdxO0L75Xb3hCVGf3RnJUqu2sWBjLMsF334dOCaLvlBWHSq
         3qjI22QK+fuD2XU34zwoAoJcvMg5M3MOL/zLPRYdnk6I9N99Mb89clnsCiFlIzrCyNG5
         wIgE/2UZP5F1HZdHJ2jPZfxXgBiNaOGqPxjHwoaYtmp1CXM6z2slTFYVcshR8L5sSabL
         Li4A==
X-Gm-Message-State: AJIora/mT9tebsYYaeuih/3XTQGJ25to7RbbaTD8kQfkxUA6ryC30SuI
        SidgrHP/eOGN6udlr2KEckw=
X-Google-Smtp-Source: AGRyM1t1lI22WKvrzADuYnl8NL4jZAFVE9jLYiOqaRWqDCB4uewtZRSM1xmMXVJWd9BILsAdvGBnlA==
X-Received: by 2002:a5d:4646:0:b0:210:3e3c:86dc with SMTP id j6-20020a5d4646000000b002103e3c86dcmr4154536wrs.277.1655201460348;
        Tue, 14 Jun 2022 03:11:00 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id z10-20020a05600c0a0a00b003974b95d897sm19639873wmp.37.2022.06.14.03.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 03:10:59 -0700 (PDT)
Message-ID: <5137243d-ff20-e184-493b-29af64c408d9@gmail.com>
Date:   Tue, 14 Jun 2022 11:10:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/4] fetch: use new branch_checked_out() and add tests
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
 <4540dbeed385341f8c5b45134e1a65dc48c75b0c.1654718942.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <4540dbeed385341f8c5b45134e1a65dc48c75b0c.1654718942.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 08/06/2022 21:09, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> [...]

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index ac29c2b1ae3..1ba56240312 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -885,7 +885,7 @@ static int update_local_ref(struct ref *ref,
>   			    struct worktree **worktrees)
>   {
>   	struct commit *current = NULL, *updated;
> -	const struct worktree *wt;
> +	char *path = NULL;
>   	const char *pretty_ref = prettify_refname(ref->name);
>   	int fast_forward = 0;
>   
> @@ -900,17 +900,17 @@ static int update_local_ref(struct ref *ref,
>   	}
>   
>   	if (!update_head_ok &&
> -	    (wt = find_shared_symref(worktrees, "HEAD", ref->name)) &&
> -	    !wt->is_bare && !is_null_oid(&ref->old_oid)) {
> +	    !is_null_oid(&ref->old_oid) &&
> +	    branch_checked_out(ref->name, &path)) {
>   		/*
>   		 * If this is the head, and it's not okay to update
>   		 * the head, and the old value of the head isn't empty...
>   		 */
>   		format_display(display, '!', _("[rejected]"),
> -			       wt->is_current ?
> -				       _("can't fetch in current branch") :
> -				       _("checked out in another worktree"),
> +			       path ? _("can't fetch in current branch") :
> +				      _("checked out in another worktree"),

I'm confused by this, isn't path always non-null?

Best Wishes

Phillip

>   			       remote, pretty_ref, summary_width);
> +		free(path);
>   		return 1;
>   	}
>   
> @@ -1434,19 +1434,16 @@ cleanup:
>   	return result;
>   }
>   
> -static void check_not_current_branch(struct ref *ref_map,
> -				     struct worktree **worktrees)
> +static void check_not_current_branch(struct ref *ref_map)
>   {
> -	const struct worktree *wt;
> +	char *path;
>   	for (; ref_map; ref_map = ref_map->next)
>   		if (ref_map->peer_ref &&
>   		    starts_with(ref_map->peer_ref->name, "refs/heads/") &&
> -		    (wt = find_shared_symref(worktrees, "HEAD",
> -					     ref_map->peer_ref->name)) &&
> -		    !wt->is_bare)
> +		    branch_checked_out(ref_map->peer_ref->name, &path))
>   			die(_("refusing to fetch into branch '%s' "
>   			      "checked out at '%s'"),
> -			    ref_map->peer_ref->name, wt->path);
> +			    ref_map->peer_ref->name, path);
>   }
>   
>   static int truncate_fetch_head(void)
> @@ -1650,7 +1647,7 @@ static int do_fetch(struct transport *transport,
>   	ref_map = get_ref_map(transport->remote, remote_refs, rs,
>   			      tags, &autotags);
>   	if (!update_head_ok)
> -		check_not_current_branch(ref_map, worktrees);
> +		check_not_current_branch(ref_map);
>   
>   	retcode = open_fetch_head(&fetch_head);
>   	if (retcode)
> diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
> index 12faca7f655..f3f8b0b2b79 100755
> --- a/t/t2407-worktree-heads.sh
> +++ b/t/t2407-worktree-heads.sh
> @@ -10,6 +10,15 @@ test_expect_success 'setup' '
>   		test_commit $i &&
>   		git branch wt-$i &&
>   		git worktree add wt-$i wt-$i || return 1
> +	done &&
> +
> +	# Create a server that updates each branch by one commit
> +	git clone . server &&
> +	git remote add server ./server &&
> +	for i in 1 2 3 4
> +	do
> +		git -C server checkout wt-$i &&
> +		test_commit -C server A-$i || return 1
>   	done
>   '
>   
> @@ -21,6 +30,16 @@ test_expect_success 'refuse to overwrite: checked out in worktree' '
>   	done
>   '
>   
> +test_expect_success 'refuse to overwrite during fetch' '
> +	test_must_fail git fetch server +refs/heads/wt-3:refs/heads/wt-3 2>err &&
> +	grep "refusing to fetch into branch '\''refs/heads/wt-3'\''" err &&
> +
> +	# General fetch into refs/heads/ will fail on first ref,
> +	# so use a generic error message check.
> +	test_must_fail git fetch server +refs/heads/*:refs/heads/* 2>err &&
> +	grep "refusing to fetch into branch" err
> +'
> +
>   test_expect_success 'refuse to overwrite: worktree in bisect' '
>   	test_when_finished test_might_fail git -C wt-4 bisect reset &&
>   
> @@ -31,7 +50,10 @@ test_expect_success 'refuse to overwrite: worktree in bisect' '
>   	) &&
>   
>   	test_must_fail git branch -f wt-4 HEAD 2>err &&
> -	grep "cannot force update the branch '\''wt-4'\'' checked out at" err
> +	grep "cannot force update the branch '\''wt-4'\'' checked out at" err &&
> +
> +	test_must_fail git fetch server +refs/heads/wt-4:refs/heads/wt-4 2>err &&
> +	grep "refusing to fetch into branch '\''refs/heads/wt-4'\''" err
>   '
>   
>   . "$TEST_DIRECTORY"/lib-rebase.sh
> @@ -47,7 +69,10 @@ test_expect_success 'refuse to overwrite: worktree in rebase' '
>   	) &&
>   
>   	test_must_fail git branch -f wt-4 HEAD 2>err &&
> -	grep "cannot force update the branch '\''wt-4'\'' checked out at" err
> +	grep "cannot force update the branch '\''wt-4'\'' checked out at" err &&
> +
> +	test_must_fail git fetch server +refs/heads/wt-4:refs/heads/wt-4 2>err &&
> +	grep "refusing to fetch into branch '\''refs/heads/wt-4'\''" err
>   '
>   
>   test_done

