Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957ADC433EF
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 17:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 671B5601FF
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 17:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbhIDRWF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 13:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236896AbhIDRWF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 13:22:05 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A06EC061575
        for <git@vger.kernel.org>; Sat,  4 Sep 2021 10:21:03 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id t9so2006963qtp.2
        for <git@vger.kernel.org>; Sat, 04 Sep 2021 10:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NZZP75vZ3z9O1+zDIXgjcBuHuB4gTE3IzZMu61/0NHo=;
        b=Gf4Ewmnu3pkSEXQDtw31UdjI6/oCp77X4j8KI6ATcAraif+IOMAW9PP3BHunznMBL9
         j1lqvPJfRqw9+d7lF5w/0WlFUjcyUP+fAS4d3nxSoOB52f6IlEJh8h24I+FNXj5s9OAH
         5ngAdFQrU6+/bFxcQx4/HZjrW1yXHjOrM9yR6xD4LnTTe4zK2FLAvlvwia35e2yMSFcE
         FNKBgri+RCC6tq9jx3OYt1HSTUU/vlvSZu9yS/HM4mfVfdx+mXKEmVhjynCRw2dKiBrT
         dkhk+dIjTamiwaf1XHVY52x9vSBArxkLYaK24qJc1tk9XWHfd6YMXDqPer5CxZo0YOa9
         SJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NZZP75vZ3z9O1+zDIXgjcBuHuB4gTE3IzZMu61/0NHo=;
        b=I/9gijqaRxT7pKuG/qlmLeQU5edcYeXkz3AiI62bO4rcs5orfaLFh3DFb53kzUGcgD
         byx5NPv4GrwEwVfvxjIB2w78D3mEA2RAZUVz9ckiXUeeiOAaoLjLKJdEBtWMHcs+kUOC
         TQCBdPY5EHGjrqAyJHeqY43bguYB/f2PvQrFYP1cPAlCMFERuOhKLFIA7HgxCiFyaVs3
         DuRiq5t7XNSRbtqh/IRqZWY4WHkoyAUWQcUbkmaBNttRhdas4H1680kRMoQ74xt45kBo
         xvEacSYd0iu8vJ3PlEufrp553t5TJJ10WnPYzC3WIomddBhGnc8QCL4yeZMeA0YAIZ1j
         3LBQ==
X-Gm-Message-State: AOAM533lumZJjkR9tEQmJdjHK5M4tUi0lkkByvVZy9KxsKfqvqPGBTqn
        xmClni8MwLBpY73BCtXNPW3VXg==
X-Google-Smtp-Source: ABdhPJyP9JGfgp+kaLVjqGwl8vQiHROkQUC5aHZA0DHHXvwtS6+1djuoNEObAesZI+ShOFeSV8Zxbw==
X-Received: by 2002:ac8:5a81:: with SMTP id c1mr4316129qtc.210.1630776062155;
        Sat, 04 Sep 2021 10:21:02 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.116.19])
        by smtp.gmail.com with ESMTPSA id x83sm2052363qkb.118.2021.09.04.10.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 10:21:01 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 2/4] introduce submodule.superprojectGitDir record
Date:   Sat,  4 Sep 2021 14:20:51 -0300
Message-Id: <20210904172051.2858-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210819200953.2105230-3-emilyshaffer@google.com>
References: <20210819200953.2105230-3-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> wrote:
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index d55f6262e9..d60fcd2c7d 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1910,6 +1910,10 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
>  					   error_strategy);
> 
> +	git_config_set_in_file(p, "submodule.superprojectGitdir",
> +			       relative_path(absolute_path(get_git_dir()),
> +					     path, &sb));

This will be executed when cloning a submodule with
`git submodule add <url/path> <path>`. Do we also want to set
submodule.superprojectGitdir when adding a repository that already exists in
the working tree as a submodule? I.e., something like:

git init super
git init super/sub
[ make commits in super/sub ]
git -C super submodule add ./sub

I don't know if this workflow is so commonly used, though... It may not be
worth the additional work.

Another option, which I believe was suggested by Jonathan Nieder on the Review
Club, is to change the code to absorb the gitdir when adding the local
submodule. Then, the configuration would already be set by the
`absorb_git_dir...()` function itself.

>  	free(sm_alternate);
>  	free(error_strategy);
> 
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 4bc6b6c886..e407329d81 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -108,14 +108,18 @@ test_expect_success 'setup - repository to add submodules to' '
>  submodurl=$(pwd -P)
> 
>  inspect() {
> -	dir=$1 &&
> -
> -	git -C "$dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
> -	{ git -C "$dir" symbolic-ref HEAD || :; } >head &&
> -	git -C "$dir" rev-parse HEAD >head-sha1 &&
> -	git -C "$dir" update-index --refresh &&
> -	git -C "$dir" diff-files --exit-code &&
> -	git -C "$dir" clean -n -d -x >untracked
> +	sub_dir=$1 &&
> +	super_dir=$2 &&
> +
> +	git -C "$sub_dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
> +	{ git -C "$sub_dir" symbolic-ref HEAD || :; } >head &&
> +	git -C "$sub_dir" rev-parse HEAD >head-sha1 &&
> +	git -C "$sub_dir" update-index --refresh &&
> +	git -C "$sub_dir" diff-files --exit-code &&
> +	cached_super_dir="$(git -C "$sub_dir" config --get submodule.superprojectGitDir)" &&
> +	[ "$(git -C "$super_dir" rev-parse --absolute-git-dir)" \
> +		-ef "$sub_dir/$cached_super_dir" ] &&

To avoid the non-POSIX `-ef`, we could perhaps do something like: 

	super_gitdir="$(git -C "$super_dir" rev-parse --absolute-git-dir)" &&
	cached_gitdir="$(git -C "$sub_dir" config --get submodule.superprojectGitDir)" &&
	test "$cached_gitdir" = "$(test-tool path-utils relative_path "$super_gitdir" "$PWD/$sub_dir")" &&

(We need the "$PWD/" at the last command because `path.c:relative_path()`
returns the first argument as-is when one of the two paths given to it is
absolute and the other is not.)

One bonus of testing the cached path this way is that we also check that
it is indeed being stored as a relative path :)
