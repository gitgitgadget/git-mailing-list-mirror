Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F185DC4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 10:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA24D60F38
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 10:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239553AbhHQKIG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 06:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239678AbhHQKIA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 06:08:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8243C0612A4
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 03:07:01 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k4so13338423wms.3
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 03:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fmwqJXvBWw76h4Kw+M4DKi0+8C+B0f+vpNhEzv2rmPo=;
        b=DNYoaOyfInpeSQcPe5/lYAMfslFE3bsMF0lMRjjLUCtlfOYk6E3e9kuPZ8Y/KXD7ui
         p61tOVQtNzmqba7jAb8LBo1H5L2GjDxtmUXELf1vD3Nv4+1+9EORvtKxGOw3BgY9Tm4e
         wBwSz7V0Tn2Dxom5AYOL47enfUxWalDvrY9Ta7/HsExdXk9IFKaFCCdUHlLusg4KkcGV
         mP6MYezoYxc/aMVei2kOQuJaueKhc68hd6qO97+QBSl+L5jl87HPTuN/RBbY22zhFlM6
         v61f+zmX6Q7Kwsn8GRtWYurzP2yDCYCy3hdi5NmSaPwWMnGM9HG2/HQBubvFJy79DnO6
         bx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fmwqJXvBWw76h4Kw+M4DKi0+8C+B0f+vpNhEzv2rmPo=;
        b=PKux4u7zL/y7Bv74UUgvW8Vut/frg7oIJ6b970PtNq0Cg/yuaiGcLiOU+JY2UTXXNJ
         8xlfSM3razLQRpyUiZSD8wNMw0lq89N72SFjEVcgtWPwBzS61GOIGTi6L74ahV3z3di9
         EkwmNkfLd9nNHc8bgILNPKdbbHY1jgmvFki3zheRuHvgTNmW6zMTHY62mcVzfGzAbYRA
         U+I7ig9yq09Qv41MAxcDvGN27IX4CCzj93ibI/xKvQKwdrD46wDAS4l+IloLR0lRQiZo
         CpxKCh7aA6JkXB69glu48sFD9gWhxcYzH3lXCLhTjcuTnDYraTzd7k+2etjWd8B05GjM
         CoWQ==
X-Gm-Message-State: AOAM532XjwrpkcylZ6Rjr6ORGNVqByLF5gTfUbISO5xMLKBmyi/Yc5Sx
        Ype8yR6lth/ertznunl1wGA=
X-Google-Smtp-Source: ABdhPJwBJi9xshjUYTPEl4Luy3/LyQAtP3jTo9/wsnVnPO4xl6+Qb/G4c1fZPiMLZDCQcBDo3wqybA==
X-Received: by 2002:a7b:c0c6:: with SMTP id s6mr2464301wmh.21.1629194820351;
        Tue, 17 Aug 2021 03:07:00 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id h9sm1504244wmb.35.2021.08.17.03.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 03:06:59 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5] commit: restore --edit when combined with --fixup
To:     Joel Klinghed via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Joel Klinghed <the_jk@spawned.biz>
References: <pull.1014.v4.git.1628769334197.gitgitgadget@gmail.com>
 <pull.1014.v5.git.1628977230247.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <24356b20-45e2-5d60-434c-4f04d1b2055c@gmail.com>
Date:   Tue, 17 Aug 2021 11:06:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <pull.1014.v5.git.1628977230247.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joel

On 14/08/2021 22:40, Joel Klinghed via GitGitGadget wrote:
> From: Joel Klinghed <the_jk@spawned.biz>
> 
> Recent changes to --fixup, adding amend suboption, caused the
> --edit flag to be ignored as use_editor was always set to zero.
> 
> Restore edit_flag having higher priority than fixup_message when
> deciding the value of use_editor by moving the edit flag condition
> later in the method.

This version looks good, thanks for revising it

Best Wishes

Phillip

> 
> Signed-off-by: Joel Klinghed <the_jk@spawned.biz>
> ---
>      commit: restore --edit when combined with --fixup
>      
>      Recent changes to --fixup, adding amend suboption, caused the --edit
>      flag to be ignored as use_editor was always set to zero.
>      
>      Restore edit_flag having higher priority than fixup_message when
>      deciding the value of use_editor by only changing the default if
>      edit_flag is not set.
>      
>      Changes since v1: Added test verifying that --fixup --edit brings up
>      editor.
>      
>      Changes since v2: Clarify if condition and use write_script helper in
>      test.
>      
>      Changes since v3: Simplify test.
>      
>      Changes since v4: Using cleaner fix by Phillip Wood instead and added an
>      explicit verification to a test for --fixup without --edit.
>      
>      Signed-off-by: Joel Klinghed the_jk@spawned.biz
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1014%2Fthejk%2Ffixup_edit-v5
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1014/thejk/fixup_edit-v5
> Pull-Request: https://github.com/gitgitgadget/git/pull/1014
> 
> Range-diff vs v4:
> 
>   1:  0c0cb647e03 ! 1:  1c608daf0cd commit: restore --edit when combined with --fixup
>       @@ Commit message
>            --edit flag to be ignored as use_editor was always set to zero.
>        
>            Restore edit_flag having higher priority than fixup_message when
>       -    deciding the value of use_editor by only changing the default
>       -    if edit_flag is not set.
>       +    deciding the value of use_editor by moving the edit flag condition
>       +    later in the method.
>        
>            Signed-off-by: Joel Klinghed <the_jk@spawned.biz>
>        
>         ## builtin/commit.c ##
>        @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
>       - 		} else {
>       - 			fixup_commit = fixup_message;
>       - 			fixup_prefix = "fixup";
>       --			use_editor = 0;
>       -+			if (edit_flag < 0)
>       -+				use_editor = 0;
>       +
>       + 	if (logfile || have_option_m || use_message)
>       + 		use_editor = 0;
>       +-	if (0 <= edit_flag)
>       +-		use_editor = edit_flag;
>       +
>       + 	/* Sanity check options */
>       + 	if (amend && !current_head)
>       +@@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
>         		}
>         	}
>         
>       ++	if (0 <= edit_flag)
>       ++		use_editor = edit_flag;
>       ++
>       + 	cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor);
>       +
>       + 	handle_untracked_files_arg(s);
>        
>         ## t/t7500-commit-template-squash-signoff.sh ##
>       +@@ t/t7500-commit-template-squash-signoff.sh: EOF
>       +
>       + test_expect_success 'commit --fixup provides correct one-line commit message' '
>       + 	commit_for_rebase_autosquash_setup &&
>       +-	git commit --fixup HEAD~1 &&
>       ++	EDITOR="echo ignored >>" git commit --fixup HEAD~1 &&
>       + 	commit_msg_is "fixup! target message subject line"
>       + '
>       +
>        @@ t/t7500-commit-template-squash-signoff.sh: test_expect_success 'commit --fixup -m"something" -m"extra"' '
>         
>         extra"
> 
> 
>   builtin/commit.c                          | 5 +++--
>   t/t7500-commit-template-squash-signoff.sh | 9 ++++++++-
>   2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 190d215d43b..854903ad113 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1246,8 +1246,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
>   
>   	if (logfile || have_option_m || use_message)
>   		use_editor = 0;
> -	if (0 <= edit_flag)
> -		use_editor = edit_flag;
>   
>   	/* Sanity check options */
>   	if (amend && !current_head)
> @@ -1337,6 +1335,9 @@ static int parse_and_validate_options(int argc, const char *argv[],
>   		}
>   	}
>   
> +	if (0 <= edit_flag)
> +		use_editor = edit_flag;
> +
>   	cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor);
>   
>   	handle_untracked_files_arg(s);
> diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
> index 7d02f79c0de..8515736003a 100755
> --- a/t/t7500-commit-template-squash-signoff.sh
> +++ b/t/t7500-commit-template-squash-signoff.sh
> @@ -270,7 +270,7 @@ EOF
>   
>   test_expect_success 'commit --fixup provides correct one-line commit message' '
>   	commit_for_rebase_autosquash_setup &&
> -	git commit --fixup HEAD~1 &&
> +	EDITOR="echo ignored >>" git commit --fixup HEAD~1 &&
>   	commit_msg_is "fixup! target message subject line"
>   '
>   
> @@ -281,6 +281,13 @@ test_expect_success 'commit --fixup -m"something" -m"extra"' '
>   
>   extra"
>   '
> +test_expect_success 'commit --fixup --edit' '
> +	commit_for_rebase_autosquash_setup &&
> +	EDITOR="printf \"something\nextra\" >>" git commit --fixup HEAD~1 --edit &&
> +	commit_msg_is "fixup! target message subject linesomething
> +extra"
> +'
> +
>   get_commit_msg () {
>   	rev="$1" &&
>   	git log -1 --pretty=format:"%B" "$rev"
> 
> base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
> 

