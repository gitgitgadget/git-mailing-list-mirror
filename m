Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0020FC433EF
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 13:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239741AbiBFNac (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 08:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239584AbiBFNab (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 08:30:31 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FF5C06173B
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 05:30:30 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id k18so20258949wrg.11
        for <git@vger.kernel.org>; Sun, 06 Feb 2022 05:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0cKeUQZc1hos7IShuccHQFY1Ws6CSX9AHxRUezLIBOM=;
        b=K1D6Du9bsiEa49+8+egHA43KYuAOyNZXx7cP+hsqdzhVnrkdWcFD4Zo2EGQwszu26U
         WCeTEcqwcgg1Uo688vykQOAwIvoOjdEiMhTvHgD18kLqflKOgtYmV53TzVuzWcjpGvpQ
         JhoEMwvU4qEtWKRzlK35GG9JmhSslpj8HisE8oKlLFaPi4yo4aqbMoNcXBGK2bzn8eaK
         UYi+UMnON317MEPm1NhcaiwdqDTzY0UY+CPjEDZm2NVxlmGIlS+8QWzD0kT2uAXU5qyF
         29BjUo/70E0y+pBmVTKBxL7k2CwNePAEDD14C9yuhGVH47YjA1/IxDjd+16f5wRzIeu9
         +n4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0cKeUQZc1hos7IShuccHQFY1Ws6CSX9AHxRUezLIBOM=;
        b=J4f3py+weixwZwxUvdzfcpu1urECRRqmbzxHxXQSv2eDmyYQ+Q9PzM15QKoqjCWCxh
         1lytG1CdBCVPh7l+GYrlwbhzUTx75EqZt5tgMuPDUu6M7HioJGZrW7yCFfSLKInB3XEQ
         8E3VMtuwCtWPhXitx2P9z+YFXQRe980fMeNRO1pCASAu/mZLck2x9dCmW+Zz4bK+5o2i
         rk0Ik0XOsQ95sbu7+AbJN3obetS7qeAN5AY8gZb0ZvM37OVmGT6kkRT0ihxNFJTLbipf
         MTKZSqwYKcPaT7+KH1PNKGngJAs+WkG3ix0vYtdD2KHSpsRaTqMG5R7A6IX6J08GKuiC
         Lykw==
X-Gm-Message-State: AOAM531eAZE2GXDHhDmvdiVl6Sm/4tEb6e5223TuOY1zWg8Ctii+FNCM
        RnZMSMhkH1sWj4FYg7QQfr1LBC0pFqQ=
X-Google-Smtp-Source: ABdhPJxr195nClVQEB1mgnCnQ4/FJvXxEuSBukvJVFyg3JHqELDCeLuTaNTBTk/vWMHtU7EtJCvtxg==
X-Received: by 2002:adf:dcc9:: with SMTP id x9mr6220157wrm.591.1644154229044;
        Sun, 06 Feb 2022 05:30:29 -0800 (PST)
Received: from szeder.dev (94-21-146-211.pool.digikabel.hu. [94.21.146.211])
        by smtp.gmail.com with ESMTPSA id f16sm7392856wmg.28.2022.02.06.05.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 05:30:28 -0800 (PST)
Date:   Sun, 6 Feb 2022 14:30:26 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Hongyi Zhao <hongyi.zhao@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?utf-8?B?Sm/Do28=?= Victor Bonfim 
        <JoaoVictorBonfim+Git-Mail-List@protonmail.com>
Subject: Re: [PATCH v2 2/2] completion: add a GIT_COMPLETION_SHOW_ALL_COMMANDS
Message-ID: <20220206133026.GB1936@szeder.dev>
References: <patch-1.1-5f18305ca08-20220125T124757Z-avarab@gmail.com>
 <cover-v2-0.2-00000000000-20220202T111228Z-avarab@gmail.com>
 <patch-v2-2.2-2e2e3569e02-20220202T111228Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-2.2-2e2e3569e02-20220202T111228Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 02, 2022 at 12:15:10PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Add a GIT_COMPLETION_SHOW_ALL_COMMANDS=1 configuration setting to go
> with the existing GIT_COMPLETION_SHOW_ALL=1 added in
> c099f579b98 (completion: add GIT_COMPLETION_SHOW_ALL env var,
> 2020-08-19).
> 
> This will include plumbing commands such as "cat-file" in "git <TAB>"
> and "git c<TAB>" completion.

I've tried this a couple of times in the last dozen years or so...
and ended up hating it every single time, because it too often made
completion of frequently used porcelain commands more cumbersome, and
quickly reverted it.

Since 6532f3740b (completion: allow to customize the completable
command list, 2018-05-20) it is possible to include and exclude
certain commands from the list offered for 'git <TAB>'.  So if you use
some plumbing command frequently, then you can add them to the
'completion.commands' config variable, and they will show up for 'git
<TAB>', too, without any of the other plumbing commands to get
annoying.

To complete only rarely used plumbing commands in a non-intrusive way,
in my experience, it's best to first attempt to complete only
porcelains and aliases, and fall back to complete all commands,
plumbing included, only when no porcelains match the current word to
be completed.  E.g.:

  $ git d<TAB>
  describe   diff   difftool
  $ git diff-<TAB>
  diff-files   diff-index   diff-tree

  $ git p<TAB>
  prune   pull    push    
  $ git pa<TAB>
  pack-objects     pack-redundant   pack-refs        patch-id 


  ---   >8   ---

Subject: [PATCH] completion: list all git commands as fallback

---
 contrib/completion/git-completion.bash | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3edd1cade6..67978e6f22 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3465,6 +3465,9 @@ __git_main ()
 				__gitcomp "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
 			else
 				__gitcomp "$(__git --list-cmds=list-mainporcelain,others,nohelpers,alias,list-complete,config)"
+				if [ ${#COMPREPLY[@]} -eq 0 ]; then
+					__gitcomp "$(__git --list-cmds=main,others,nohelpers,alias,list-complete,config)"
+				fi
 			fi
 			;;
 		esac
-- 
2.35.1.482.g3282949ee0

  ---   8<   ---

I've been using 'completion.commands' and the patch above for a few
years now, and this combination worked out the best so far.

> Without/with this I have 134 and 243
> completion with git <TAB>, respectively.

Those numbers include all your aliases and additional 'git-foo'
commands in your PATH; I only get 74 without this patch.  To show the
effect of this patch I think it would be more relevant to count only
Git's commands.


> It was already possible to do this by tweaking
> GIT_TESTING_PORCELAIN_COMMAND_LIST= from the outside, that testing
> variable was added in 84a97131065 (completion: let git provide the
> completable command list, 2018-05-20). Doing this before loading
> git-completion.bash worked:
> 
>     export GIT_TESTING_PORCELAIN_COMMAND_LIST="$(git --list-cmds=builtins,main,list-mainporcelain,others,nohelpers,alias,list-complete,config)"
> 
> But such testing variables are not meant to be used from the outside,
> and we make no guarantees that those internal won't change. So let's
> expose this as a dedicated configuration knob.
> 
> It would be better to teach --list-cmds=* a new category which would
> include all of these groups, but that's a larger change that we can
> leave for some other time.
> 
> 1. https://lore.kernel.org/git/CAGP6POJ9gwp+t-eP3TPkivBLLbNb2+qj=61Mehcj=1BgrVOSLA@mail.gmail.com/
> 
> Reported-by: Hongyi Zhao <hongyi.zhao@gmail.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 13 ++++++++++-
>  t/t9902-completion.sh                  | 31 ++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 377d6c5494a..2436b8eb6b9 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -49,6 +49,11 @@
>  #     and git-switch completion (e.g., completing "foo" when "origin/foo"
>  #     exists).
>  #
> +#   GIT_COMPLETION_SHOW_ALL_COMMANDS
> +#
> +#     When set to "1" suggest all commands, including plumbing commands
> +#     which are hidden by default (e.g. "cat-file" on "git ca<TAB>").
> +#
>  #   GIT_COMPLETION_SHOW_ALL
>  #
>  #     When set to "1" suggest all options, including options which are
> @@ -3455,7 +3460,13 @@ __git_main ()
>  			then
>  				__gitcomp "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
>  			else
> -				__gitcomp "$(__git --list-cmds=list-mainporcelain,others,nohelpers,alias,list-complete,config)"
> +				local list_cmds=list-mainporcelain,others,nohelpers,alias,list-complete,config
> +
> +				if test "${GIT_COMPLETION_SHOW_ALL_COMMANDS-}" = "1"
> +				then
> +					list_cmds=builtins,$list_cmds
> +				fi
> +				__gitcomp "$(__git --list-cmds=$list_cmds)"
>  			fi
>  			;;
>  		esac
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index c9805f2147d..c6d6d6ef896 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -2440,6 +2440,37 @@ test_expect_success 'option aliases are shown with GIT_COMPLETION_SHOW_ALL' '
>  	)
>  '
>  
> +test_expect_success 'plumbing commands are excluded without GIT_COMPLETION_SHOW_ALL_COMMANDS' '
> +	(
> +		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
> +		sane_unset GIT_TESTING_PORCELAIN_COMMAND_LIST &&
> +
> +		# Just mainporcelain, not plumbing commands
> +		run_completion "git c" &&
> +		grep checkout out &&
> +		! grep cat-file out
> +	)
> +'
> +
> +test_expect_success 'all commands are shown with GIT_COMPLETION_SHOW_ALL_COMMANDS (also main non-builtin)' '
> +	(
> +		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
> +		GIT_COMPLETION_SHOW_ALL_COMMANDS=1 &&
> +		export GIT_COMPLETION_SHOW_ALL_COMMANDS &&

This variable only affects the completion script itself, but none of
the commands invoked by it, so the 'export' is unnecessary.

> +		sane_unset GIT_TESTING_PORCELAIN_COMMAND_LIST &&
> +
> +		# Both mainporcelain and plumbing commands
> +		run_completion "git c" &&
> +		grep checkout out &&
> +		grep cat-file out &&
> +
> +		# Check "gitk", a "main" command, but not a built-in + more plumbing
> +		run_completion "git g" &&
> +		grep gitk out &&
> +		grep get-tar-commit-id out
> +	)
> +'
> +
>  test_expect_success '__git_complete' '
>  	unset -f __git_wrap__git_main &&
>  
> -- 
> 2.35.0.913.g12b4baa2536
> 
