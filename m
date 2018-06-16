Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B15B71F403
	for <e@80x24.org>; Sat, 16 Jun 2018 20:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932874AbeFPU0k (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 16:26:40 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38820 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932554AbeFPU0j (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 16:26:39 -0400
Received: by mail-wr0-f194.google.com with SMTP id e18-v6so13007750wrs.5
        for <git@vger.kernel.org>; Sat, 16 Jun 2018 13:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GiN7rU94Wr6yvq+GHkpucpDOm8zUg17t+ErdL5ueex0=;
        b=nzBl8wXFKGVVMkYA4BX17SmutDDnPzuXqCmt/AB0Xpm5CRG589FqkxLShR8aPVW0sr
         lSjzmZ5ee2FR4/iJjfa1w9mXcaOSXefEYF1KeHHqRvI7SIYx8ctimfbWBhHBrSOfNmvY
         Gk8GI+lki4amA6BBRWwzNxhvB0P9J+q4sWj3qvGV2b0BuJoV11+yxmzI3O5lCKkC5j8M
         sShThGNSlnc7GGJ70fxdALLME/XiIDxikqVHtzfBcOMcjUZNZFHoQ+u7U7BuYYIq2Hcx
         HHjhhxLAUojD5C22HpXWjCHQQxilRN/9curInWXrirm0MqXFc6Y6Hwjo4IqiW2cRslPd
         Kayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GiN7rU94Wr6yvq+GHkpucpDOm8zUg17t+ErdL5ueex0=;
        b=Uv31sUbX7wF5ZPZwzFcZv+zCu2mEHwGIdMwThkOHrW0uXgkTSSUuLchRo+TZL9NVVq
         BSaJijwM6njNBg75G5XOkOKfHpA7LqZwgwub2SCtNKkQslQC8auyAx6/gnFu4lQVHZEB
         z3NW/DDl3ia1FbhG+IQb7W2WzofxxlkSX6b/h/cclFfPhAQBjQs/BXEPz1i1M0lYR8mc
         01SNi7BlaayYdEBtTZJZzsSFIlzuobJgxz1QsMWp4RbFWCkHj1qy3+Y+HwwocUUFR0qk
         xaleSkegJDRh21D1LZEdHuQhVtANS3Rav+x2VqbzB4PRAs8weHlCIOAEWCawKBpfc6P1
         621Q==
X-Gm-Message-State: APt69E2jk8+I+RvavZvnVo6xok3UCxg0ETtmhWgw0ZY6RoqhGWn3gMtt
        YtF9Hg60b4iEBDnsNq7abDU=
X-Google-Smtp-Source: ADUXVKLxfACDjWR5kdEWMZODN59EZWX7t7u2MouOu0FDERGpqWU3cWlUXNsSgoB/RcUjPKLRuCqMGQ==
X-Received: by 2002:adf:8361:: with SMTP id 88-v6mr5364587wrd.17.1529180798461;
        Sat, 16 Jun 2018 13:26:38 -0700 (PDT)
Received: from localhost.localdomain (x4db06e4b.dyn.telefonica.de. [77.176.110.75])
        by smtp.gmail.com with ESMTPSA id a15-v6sm9774124wrs.26.2018.06.16.13.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Jun 2018 13:26:37 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/3] submodule: ensure core.worktree is set after update
Date:   Sat, 16 Jun 2018 22:26:28 +0200
Message-Id: <20180616202628.9208-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.207.ga6211da864
In-Reply-To: <20180612235825.12271-3-sbeller@google.com>
References: <20180612235825.12271-1-sbeller@google.com> <20180612235825.12271-3-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +static int connect_gitdir_workingtree(int argc, const char **argv, const char *prefix)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	const char *name, *path;
> +	char *sm_gitdir;
> +
> +	if (argc != 3)
> +		BUG("submodule--helper connect-gitdir-workingtree <name> <path>");

So this aborts when it's invoked with the wrong number of cmdline
arguments.

> +
> +	name = argv[1];
> +	path = argv[2];
> +
> +	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
> +	sm_gitdir = absolute_pathdup(sb.buf);
> +
> +	connect_work_tree_and_git_dir(path, sm_gitdir, 0);
> +
> +	strbuf_release(&sb);
> +	free(sm_gitdir);
> +
> +	return 0;
> +}
> +
>  #define SUPPORT_SUPER_PREFIX (1<<0)
>  
>  struct cmd_struct {

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 78073cd87d1..6596a77c5ef 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -615,6 +615,11 @@ cmd_update()
>  			die "$(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
>  		fi
>  
> +		if ! $(git config -f "$(git rev-parse --git-common-dir)/modules/$name/config" core.worktree) 2>/dev/null
> +		then
> +			git submodule--helper connect-gitdir-workingtree $name $sm_path

The path to the submodule, $sm_path, may contain spaces, so it must
be quoted.

I'm sure you would have noticed this already, had you checked this
'submodule--helper's exit code :)  In t7406 the test 'submodule update
properly revives a moved submodule' does update a submodule with a
space in its name, and thus executes 'submodule--helper' with one more
argument than expected, causing it to abort, but since there is no
error checking, 'git submodule update' continues anyway, and in the
end the test tends to pass[1].

I think it would be prudent to check the exit code of all
'submodule--helper' executions.


[1] I wrote "tends to", because e.g. on Travis CI the aborting
    'submodule--helper' often dumps its core, and the extra 'core'
    file shows up in the output of 'git status' and 'test_cmp' notices
    it.


> +		fi
> +
>  		if test "$subsha1" != "$sha1" || test -n "$force"
>  		then
>  			subforce=$force
> -- 
> 2.18.0.rc1.244.gcf134e6275-goog
> 
> 
