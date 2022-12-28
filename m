Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81001C4332F
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 08:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiL1IFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 03:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiL1IFT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 03:05:19 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7908DDF24
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 00:05:17 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ud5so36789474ejc.4
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 00:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XZJW2tzjZ2v51M2vLLzq7YJ7jbiAT9T4MD6IAFfdAs0=;
        b=kfhpL3KcW1miW8to7aHWFE0cRayv0mwE5SGwh/ZLCyHPphad9TI3S73ZKLiHAl7jdH
         qy1YrPkjtBWliwqdvayyZgS6Ac8XzhLaaEW9EXOlgTaGMwK4uytLuoe/lJsbezsbkqhB
         s+HyHMGJyfY1vRncDSvG//sD+JxxpuVRdhEzsGTCNViMCWjXrzJu68AMMQRbvQ7GZQhT
         a7WAGVRtMN2IVtYePwZgGHMvcWwVk2WYUqpu5E4I33CWWvgs3sFrRw04jfvg3s/LJFvM
         X4Re4PVa5D4riqggvyfb6h3ddOC9kIL8lSXtKkdNUOCsWJDC37TEK/X0NgLhraMou/HA
         nwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZJW2tzjZ2v51M2vLLzq7YJ7jbiAT9T4MD6IAFfdAs0=;
        b=5pi9cE/GMMwr8xqT9w0WuHT12I0iZFPYGgZ4lqzCRgrpgMwxjjuSQOknrwclTEdKDc
         oPBEWX/87J+FrfmC89hwDdOzI5ASYctLvLDkzSQbCa02yQwCzlgf5jpdhbKdRWW0vqQ3
         G7xl0TtSRSSrvVHa9u434liYOuSl+gw47BHg97UJyP3I4kmupdQu6g8HefgOV7YrqVom
         8y2wEMYtn21HxTGN6Uc9DC9TADerhtkl5kzVZNdXSUlSH9uHZMt1BZ3pKz5LChTCoZBk
         5tI5V79xGvPmiTfKSEUNGkLOvNp8UxJgKG4qL/QKAcffyiie33lJsgk3WtMlituOhktI
         KjmQ==
X-Gm-Message-State: AFqh2krNm70+AFi94wgYFWFxrnnEDBtzh9I3y6U5AL/8XDzftpIKItSl
        70QfHedFACNkC9sFAlNiOaHeQSgwPryXZw==
X-Google-Smtp-Source: AMrXdXuDRwN9c8wpvl6v5/dpFjBrpwqSdJRAGCYQ64T7YI2N/7Ph58EV5L9nZq/lZ5WyxxcdqU6tnA==
X-Received: by 2002:a17:906:2ccc:b0:7c0:e23d:12c4 with SMTP id r12-20020a1709062ccc00b007c0e23d12c4mr19146115ejr.63.1672214715834;
        Wed, 28 Dec 2022 00:05:15 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id q2-20020a1709063d4200b0082ddfb47d06sm7177537ejf.148.2022.12.28.00.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 00:05:15 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pARR4-009Vth-1c;
        Wed, 28 Dec 2022 09:05:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v6 0/4] worktree: Support `--orphan` when creating new
 worktrees
Date:   Wed, 28 Dec 2022 09:01:16 +0100
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev>
 <20221212014003.20290-1-jacobabel@nullpo.dev>
 <20221220023637.29042-1-jacobabel@nullpo.dev>
 <20221228061539.13740-1-jacobabel@nullpo.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221228061539.13740-1-jacobabel@nullpo.dev>
Message-ID: <221228.868risuf5x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 28 2022, Jacob Abel wrote:

>   * Added save_param_arr() to preserve "$@" from being reset by
>     test_expect_success() in test_wt_add_excl() (2/4).
> [...]
> 2:  3d8b26f9d6 ! 2:  c03c112f79 worktree add: refactor opt exclusion tests
>     @@ t/t2400-worktree-add.sh: test_expect_success '"add" no auto-vivify with --detach
>      -test_expect_success '"add" -b/-B mutually exclusive' '
>      -	test_must_fail git worktree add -b poodle -B poodle bamboo main
>      -'
>     --
>     ++# Saves parameter sequence/array as a string so they can be safely stored in a
>     ++# variable and restored with `eval "set -- $arr"`. Sourced from
>     ++# https://stackoverflow.com/a/27503158/15064705
>     ++save_param_arr () {
>     ++	local i
>     ++	for i;
>     ++	do
>     ++		# For each argument:
>     ++		# 1. Append "\n" after each entry
>     ++		# 2. Convert "'" into "'\''"
>     ++		# 3. Prepend "'" before each entry
>     ++		# 4. Append " \" after each entry
>     ++		printf "%s\\n" "$i" | sed "
>     ++			s/'/'\\\\''/g
>     ++			1s/^/'/
>     ++			\$s/\$/' \\\\/
>     ++		"
>     ++	done
>     ++	echo " "
>     ++}
>     +
> [...]
>       ## Documentation/config/advice.txt ##
>     @@ t/t2400-worktree-add.sh: test_expect_success '"add" worktree with orphan branch,
>       	test_cmp expect .git/worktrees/orphan-with-lock-reason/locked
>       '
>
>     -+test_wt_add_empty_repo_orphan_hint() {
>     ++test_wt_add_empty_repo_orphan_hint () {
>      +	local context="$1"
>      +	shift
>     -+	local opts="$@"
>     ++	local arr=$(save_param_arr "$@")
>      +	test_expect_success "'worktree add' show orphan hint in empty repo w/ $context" '
>     ++		eval "set -- $arr" &&
>      +		test_when_finished "rm -rf empty_repo" &&
>      +		GIT_DIR="empty_repo" git init --bare &&
>     -+		test_must_fail git -C empty_repo worktree add $opts foobar/ 2> actual &&
>     ++		test_must_fail git -C empty_repo worktree add "$@" foobar/ 2> actual &&
>      +		grep "hint: If you meant to create a worktree containing a new orphan branch" actual
>      +	'
>      +}

The rest of this looks good to me, but this bit looks like you went down
the rabbit hole of responding to Junio's feedback in
https://lore.kernel.org/git/xmqqsfhawwqf.fsf@gitster.g/

I think as we're not dealing with any quoted arguments here it's not
worth copy/pasting some code to do shell quoting from StackOverflow,
i.e. for this series this squashed at the tip passes all the tests:
	
	diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
	index f43de591173..e5b01583cf2 100755
	--- a/t/t2400-worktree-add.sh
	+++ b/t/t2400-worktree-add.sh
	@@ -298,33 +298,11 @@ test_expect_success '"add" no auto-vivify with --detach and <branch> omitted' '
	 	test_must_fail git -C mish/mash symbolic-ref HEAD
	 '
	 
	-# Saves parameter sequence/array as a string so they can be safely stored in a
	-# variable and restored with `eval "set -- $arr"`. Sourced from
	-# https://stackoverflow.com/a/27503158/15064705
	-save_param_arr () {
	-	local i
	-	for i;
	-	do
	-		# For each argument:
	-		# 1. Append "\n" after each entry
	-		# 2. Convert "'" into "'\''"
	-		# 3. Prepend "'" before each entry
	-		# 4. Append " \" after each entry
	-		printf "%s\\n" "$i" | sed "
	-			s/'/'\\\\''/g
	-			1s/^/'/
	-			\$s/\$/' \\\\/
	-		"
	-	done
	-	echo " "
	-}
	-
	 # Helper function to test mutually exclusive options.
	 test_wt_add_excl () {
	-	local arr=$(save_param_arr "$@")
	-	test_expect_success "'worktree add' with $* has mutually exclusive options" '
	-		eval "set -- $arr" &&
	-		test_must_fail git worktree add "$@"
	+	local args="$@" &&
	+	test_expect_success "'worktree add' with '$args' has mutually exclusive options" '
	+		test_must_fail git worktree add $args
	 	'
	 }
	 
	@@ -398,21 +376,20 @@ test_expect_success '"add" worktree with orphan branch, lock, and reason' '
	 '
	 
	 test_wt_add_empty_repo_orphan_hint () {
	-	local context="$1"
	-	shift
	-	local arr=$(save_param_arr "$@")
	+	local context="$1" &&
	+	shift &&
	+	local args="$@" &&
	 	test_expect_success "'worktree add' show orphan hint in empty repo w/ $context" '
	-		eval "set -- $arr" &&
	 		test_when_finished "rm -rf empty_repo" &&
	 		GIT_DIR="empty_repo" git init --bare &&
	-		test_must_fail git -C empty_repo worktree add "$@" foobar/ 2> actual &&
	+		test_must_fail git -C empty_repo worktree add $args foobar/ 2> actual &&
	 		grep "hint: If you meant to create a worktree containing a new orphan branch" actual
	 	'
	 }
	 
	-test_wt_add_empty_repo_orphan_hint 'DWIM'
	-test_wt_add_empty_repo_orphan_hint '-b' -b foobar_branch
	-test_wt_add_empty_repo_orphan_hint '-B' -B foobar_branch
	+test_wt_add_empty_repo_orphan_hint DWIM
	+test_wt_add_empty_repo_orphan_hint -b -b foobar_branch
	+test_wt_add_empty_repo_orphan_hint -B -B foobar_branch
	 
	 test_expect_success 'local clone from linked checkout' '
	 	git clone --local here here-clone &&

Note also that you lost the &&-chaining.

If we do want to be slightly paranoid about it, doesn't just creating a:

	local args_str="$*" &&

And then using that in the description argument to test_expect_success()
also address Junio's feedback, without the need for this quoting helper?
