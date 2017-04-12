Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21FD81FA14
	for <e@80x24.org>; Wed, 12 Apr 2017 16:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755312AbdDLQ7D (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 12:59:03 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35140 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751035AbdDLQ7A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 12:59:00 -0400
Received: by mail-pg0-f47.google.com with SMTP id 72so9161463pge.2
        for <git@vger.kernel.org>; Wed, 12 Apr 2017 09:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oHHHxEsONjTmEI3AXcxnrtc83Xa8VBzI2D4Ly0CaqgA=;
        b=jaWEUN4mFaPQvEyCY5Bnniygez2IkoumVU+laUon+JVZ3FHZv5O3rcq+eruYvukS17
         E46sG7+0Wc5rY+KPqOs5w6Nu5+H5/c9+t8y2uRmaoiWtXDlV8Ri6Vm/P0A66Sggtq1q4
         1fOpr52mkxBtOz5QGDoyKHWwCUcBO33PcuO1mtI14Tg08i27F1LVTdck0tX4QJ14rSKB
         TMbOThnj9jwfdeD60p5BLyw7WjY1+1oEm06uEdUDf0dWWtfvVEeX83tKlLJaqK1YamdP
         B7QPsFA4e2bY8EnqmgV2XEodMvKmijdFt0epqXu6VApJYIkJ/M4grSF13DzTymR8zJrP
         3huA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oHHHxEsONjTmEI3AXcxnrtc83Xa8VBzI2D4Ly0CaqgA=;
        b=SkDdhcEzhf5Q3k4jwPVLRnxvwbi5ljjqirkzojlDDu+Ump1EQPy4H2LcOGApr7t6QO
         vFtYVKT3bqdCJSv3+ct/U1D3T9ZM5uDVj+QSk7C+ErEACLneXet2jLGY5Bet5lGqS/GE
         5TsT+brDC0NWfxTCJqGDQDzhQg2UDDJDlfvr7mClBFNypFElsbx6M9hfMWRl98uuQBBy
         UCoC7Qy1/N2sjwsjwF0TOSKakohMIjhaEx6+/6pEdBmYLMy9CELECRQkMKJJoTLqXE/Q
         HQ26eVckwcgEQaYrLcUMjNKan701561a+V9fgCaBI6GaAk6ct+ULnJEjyieT2U6TDf8J
         UumA==
X-Gm-Message-State: AN3rC/5kzVwzdhN9QWvFWBzlLhv45x1EGvvBXlJZ4b8OchF9ATHn+eKbF15D1exOgi44WNcU
X-Received: by 10.98.23.23 with SMTP id 23mr15083240pfx.30.1492016334065;
        Wed, 12 Apr 2017 09:58:54 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:ec58:2634:958b:ef])
        by smtp.gmail.com with ESMTPSA id f6sm5054709pfe.57.2017.04.12.09.58.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Apr 2017 09:58:52 -0700 (PDT)
Date:   Wed, 12 Apr 2017 09:58:51 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] ls-files: properly prepare submodule environment
Message-ID: <20170412165851.GA79499@google.com>
References: <20170412003911.1142-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170412003911.1142-1-jacob.e.keller@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/11, Jacob Keller wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
> 
> Since commit e77aa336f116 ("ls-files: optionally recurse into
> submodules", 2016-10-07) ls-files has known how to recurse into
> submodules when displaying files.
> 
> Unfortunately this code does not work as expected. Initially, it
> produced results indicating that a --super-prefix can't be used from
> a subdirectory:
> 
>   fatal: can't use --super-prefix from a subdirectory
> 
> After commit b58a68c1c187 ("setup: allow for prefix to be passed to git
> commands", 2017-03-17) this behavior changed and resulted in repeated
> calls of ls-files with an expanding super-prefix.
> 
> This recursive expanding super-prefix appears to be the result of
> ls-files acting on the super-project instead of on the submodule files.
> 
> We can fix this by properly preparing the submodule environment when
> setting up the submodule process. This ensures that the command we
> execute properly reads the directory and ensures that we correctly
> operate in the submodule instead of repeating oureslves on the
> super-project contents forever.
> 
> While we're here lets also add some tests to ensure that ls-files works
> with recurse-submodules to catch these issues in the future.
> 
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> I found this fix on accident after looking at git-grep code and
> comparing how ls-files instantiated the submodule. Can someone who knows
> more about submodules explain the reasoning better for this fix?
> Essentially we "recurse" into the submodule folder, but still operate as
> if we're at the root of the project but with a new prefix. So then we
> keep recursing into the submodule forever.

The reason why this fix is required is that the env var GIT_DIR is set
to be the parents gitdir.  When recursing the childprocess just uses the
parents gitdir instead of its own causing it to recurse into itself
again and again.  The child process's environment needs to have the
GIT_DIR var cleared so that the child will do discovery and actually
find its own gitdir.

> 
> I also added some tests here, and I *definitely* think this should be a
> maintenance backport into any place which supports ls-files
> --recurse-submodules, since as far as I can tell it is otherwise
> useless.
> 
> There were no tests for it, so I added some based on git-grep tests. I
> did not try them against the broken setups, because of the endless
> recursion.

There are tests for ls-files --recurse-submodules in
t3007-ls-files-recurse-submodules.sh, though it looks like this
particular case (which triggers this bug) maybe didn't have any tests.
I'm actually unsure of why the existing tests didn't catch this (I'm
probably just bad at writing tests).


> 
>  builtin/ls-files.c                     |   4 +
>  t/t3080-ls-files-recurse-submodules.sh | 162 +++++++++++++++++++++++++++++++++
>  2 files changed, 166 insertions(+)
>  create mode 100755 t/t3080-ls-files-recurse-submodules.sh
> 
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index d449e46db551..e9b3546ca053 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -15,6 +15,7 @@
>  #include "string-list.h"
>  #include "pathspec.h"
>  #include "run-command.h"
> +#include "submodule.h"
>  
>  static int abbrev;
>  static int show_deleted;
> @@ -203,6 +204,9 @@ static void show_gitlink(const struct cache_entry *ce)
>  	struct child_process cp = CHILD_PROCESS_INIT;
>  	int status;
>  
> +	prepare_submodule_repo_env(&cp.env_array);
> +	argv_array_push(&cp.env_array, GIT_DIR_ENVIRONMENT);

Yes these lines need to be included in order to prepare the environment.
Thanks for catching that.

> +
>  	if (prefix_len)
>  		argv_array_pushf(&cp.env_array, "%s=%s",
>  				 GIT_TOPLEVEL_PREFIX_ENVIRONMENT,
> diff --git a/t/t3080-ls-files-recurse-submodules.sh b/t/t3080-ls-files-recurse-submodules.sh
> new file mode 100755
> index 000000000000..6788a8f09635
> --- /dev/null
> +++ b/t/t3080-ls-files-recurse-submodules.sh
> @@ -0,0 +1,162 @@
> +#!/bin/sh
> +
> +test_description='Test ls-files recurse-submodules feature
> +
> +This test verifies the recurse-submodules feature correctly lists files across
> +submodules.
> +'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup directory structure and submodule' '
> +	echo "foobar" >a &&
> +	mkdir b &&
> +	echo "bar" >b/b &&
> +	git add a b &&
> +	git commit -m "add a and b" &&
> +	git init submodule &&
> +	echo "foobar" >submodule/a &&
> +	git -C submodule add a &&
> +	git -C submodule commit -m "add a" &&
> +	git submodule add ./submodule &&
> +	git commit -m "added submodule"
> +'
> +
> +test_expect_success 'ls-files correctly lists files in a submodule' '
> +	cat >expect <<-\EOF &&
> +	.gitmodules
> +	a
> +	b/b
> +	submodule/a
> +	EOF
> +
> +	git ls-files --recurse-submodules >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'ls-files and basic pathspecs' '
> +	cat >expect <<-\EOF &&
> +	submodule/a
> +	EOF
> +
> +	git ls-files --recurse-submodules -- submodule >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'ls-files and nested submodules' '
> +	git init submodule/sub &&
> +	echo "foobar" >submodule/sub/a &&
> +	git -C submodule/sub add a &&
> +	git -C submodule/sub commit -m "add a" &&
> +	git -C submodule submodule add ./sub &&
> +	git -C submodule add sub &&
> +	git -C submodule commit -m "added sub" &&
> +	git add submodule &&
> +	git commit -m "updated submodule" &&
> +
> +	cat >expect <<-\EOF &&
> +	.gitmodules
> +	a
> +	b/b
> +	submodule/.gitmodules
> +	submodule/a
> +	submodule/sub/a
> +	EOF
> +
> +	git ls-files --recurse-submodules >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'ls-files using relative path' '
> +	test_when_finished "rm -rf parent sub" &&
> +	git init sub &&
> +	echo "foobar" >sub/file &&
> +	git -C sub add file &&
> +	git -C sub commit -m "add file" &&
> +
> +	git init parent &&
> +	echo "foobar" >parent/file &&
> +	git -C parent add file &&
> +	mkdir parent/src &&
> +	echo "foobar" >parent/src/file2 &&
> +	git -C parent add src/file2 &&
> +	git -C parent submodule add ../sub &&
> +	git -C parent commit -m "add files and submodule" &&
> +
> +	# From top works
> +	cat >expect <<-\EOF &&
> +	.gitmodules
> +	file
> +	src/file2
> +	sub/file
> +	EOF
> +	git -C parent ls-files --recurse-submodules >actual &&
> +	test_cmp expect actual &&
> +
> +	# Relative path to top
> +	cat >expect <<-\EOF &&
> +	../.gitmodules
> +	../file
> +	file2
> +	../sub/file
> +	EOF
> +	git -C parent/src ls-files --recurse-submodules .. >actual &&
> +	test_cmp expect actual &&
> +
> +	# Relative path to submodule
> +	cat >expect <<-\EOF &&
> +	../sub/file
> +	EOF
> +	git -C parent/src ls-files --recurse-submodules ../sub >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'ls-files from a subdir' '
> +	test_when_finished "rm -rf parent sub" &&
> +	git init sub &&
> +	echo "foobar" >sub/file &&
> +	git -C sub add file &&
> +	git -C sub commit -m "add file" &&
> +
> +	git init parent &&
> +	mkdir parent/src &&
> +	echo "foobar" >parent/src/file &&
> +	git -C parent add src/file &&
> +	git -C parent submodule add ../sub src/sub &&
> +	git -C parent submodule add ../sub sub &&
> +	git -C parent commit -m "add files and submodules" &&
> +
> +	# Verify grep from root works
> +	cat >expect <<-\EOF &&
> +	.gitmodules
> +	src/file
> +	src/sub/file
> +	sub/file
> +	EOF
> +	git -C parent ls-files --recurse-submodules >actual &&
> +	test_cmp expect actual &&
> +
> +	# Verify grep from a subdir works
> +	cat >expect <<-\EOF &&
> +	file
> +	sub/file
> +	EOF
> +	git -C parent/src ls-files --recurse-submodules >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_incompatible_with_recurse_submodules ()
> +{
> +	test_expect_success "--recurse-submodules and $1 are incompatible" "
> +		test_must_fail git ls-files --recurse-submodules $1 2>actual &&
> +		test_i18ngrep -- '--recurse-submodules unsupported mode' actual
> +	"
> +}
> +
> +test_incompatible_with_recurse_submodules --deleted
> +test_incompatible_with_recurse_submodules --others
> +test_incompatible_with_recurse_submodules --unmerged
> +test_incompatible_with_recurse_submodules --killed
> +test_incompatible_with_recurse_submodules --modified
> +
> +test_done
> -- 
> 2.12.2.776.gded3dc243c29.dirty
> 

-- 
Brandon Williams
