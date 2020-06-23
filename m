Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63934C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 10:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2446320771
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 10:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irf2m31g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732219AbgFWK2W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 06:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732145AbgFWK2U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 06:28:20 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27126C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 03:28:19 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id dp10so9368350qvb.10
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 03:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ouCe3EXd2bCBzK33u7Nsuq61pX1adKEe36xeDSsLCYw=;
        b=irf2m31gw0Z99P6/mzXyyuqsIi6wnFw9DfOejdJtoocZkIbk7CpZ3OFdsRROU8xF3L
         GzKbGjXu1cy/JrRgDjc1l1vF5daoYtrTtCJMYfnsCbfGMHWH8WpXkkrTaoK98rreO4uJ
         3ymeyAjVJhfzv8ehORCuVvZWXf7z+3wl9L5tZKQyIKYgbRLDLAijsKmAaBkEfz6LX+ZK
         XTWudMOdyMjVnUPghSiv2E6Rt4U91JR0oA+wQ96Lck6ZlMluOXtA83oBRVEVmE1w8FvQ
         V19tzIMeKDVu7ZcVc49QI6ceYashdTDHuP/lpoKgvavItmnyyqQN7KAS8wFfKSK+YEYu
         GPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ouCe3EXd2bCBzK33u7Nsuq61pX1adKEe36xeDSsLCYw=;
        b=lA+sMda+AnlnPBcbrkJIQCJINnS+VmCdvb3VsxPTiBTa3Eh3tl0ZWn9TM3cfGyOOjk
         A0LyLTdJfAq9ElhHVT4GQ4v0qopemENmiKQp5/YO1+PDpj1dPBKkG6ka42lpoHEvkZ9x
         GQBEAKv1ovt8IZcn7XSyy4PLdyb4kLBSdInTmDn/vFHDmU+r8fDOGtvvvP3DxdOn26Mn
         8tHS0auWFkM0JTEymb81MPVZ6cZbps1kgdm7wjCE8ZO+uJQbg1gmuGtEQyU7GPuYVXv4
         575Tz1vvWXAoCkWrcn0CuHjkwlKbg8VjDhCZbJoJ5Y/TBUcFfsNwSRhwwac9vmESgQV8
         GG+g==
X-Gm-Message-State: AOAM533H0ziN76AbvjtfwKcno9oYquCf8or9JFURaBvm4eSYJccPu9Kz
        MAQkwtakQEM5AG+LW8DTZl3qgJPnV6Y=
X-Google-Smtp-Source: ABdhPJxIEg7Sd/1GtRHy3rqxgwoKat67puHJzWBWEhHnZU4yeixio47NL0+/UBlu6pabZMceac0RMQ==
X-Received: by 2002:a0c:b4af:: with SMTP id c47mr10332458qve.233.1592908097009;
        Tue, 23 Jun 2020 03:28:17 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id a126sm153795qkc.82.2020.06.23.03.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 03:28:16 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v5 0/4] t: replace incorrect test_must_fail usage (part 5)
Date:   Tue, 23 Jun 2020 06:28:01 -0400
Message-Id: <cover.1592907663.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.132.g321788e831
In-Reply-To: <cover.1592470068.git.liu.denton@gmail.com>
References: <cover.1592470068.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

I've taken your suggestions and rerolled the last patch. Notably, I
combined $before and $command into a single function and then passed in
`test_must_fail` as the second argument if it's expected to fail. I also
decided to use a helper function to reduce the duplication of the
calling logic but it's still a little verbose because I opted to make
use of argument passing over global variables where possible.

One thing that I'm leaning towards is completely removing $after. We can
combine $after with $command like I did in the first few iterations of
this series and just write it as:

	git_test_thing () {
		# before...
		$2 git do-the-thing "$1" &&
		if test -n "$2"
		then
			return
		fi &&
		# after...
	}

but I'm also okay with leaving it as is.

Also, one problem that's present is that for tests that use
test_submodule_switch() and test_submodule_forced_switch(), $command
will be listed as git_test_func, which might make debugging more
difficult. I think I'd prefer the version we currently have queued for
this reason (and why I did the whole song and dance of $OVERWRITING_FAIL
in the first place), but if you think that this is fine, I'm fine with
this approach as well.

Thanks,

Denton
---

The overall scope of these patches is to replace inappropriate uses of
test_must_fail. IOW, we should only allow test_must_fail to run on `git`
and `test-tool`. Ultimately, we will conclude by making test_must_fail
error out on non-git commands. An advance view of the final series can
be found here[1].

This is the fifth part. It focuses on lib-submodule-update.sh and tests
that make use of it.

The first part can be found here[2]. The second part can be found
here[3]. The third part can be found here[4]. The fourth part can be
found here[5].

Changes since v1.2:

* In "lib-submodule-update: pass OVERWRITING_FAIL", use if-then return
  to reduce the amount of code churn

Changes since v2:

* Replace the OVERWRITING_FAIL approach with callback functions as
  suggested by Peff[6]

Changes since v3:

* Simply handling of empty $before and $after

* Add more comments on the usage of the helper functions

Changes since v4:

* Combine $before and $command back together

* Use a helper function to call the callbacks

* Replace eval with proper argument passing

[1]: (may be rebased at any time) https://github.com/Denton-L/git/tree/ready/cleanup-test-must-fail2
[2]: https://lore.kernel.org/git/cover.1576583819.git.liu.denton@gmail.com/
[3]: https://lore.kernel.org/git/cover.1577454401.git.liu.denton@gmail.com/
[4]: https://lore.kernel.org/git/cover.1585209554.git.liu.denton@gmail.com/
[5]: https://lore.kernel.org/git/cover.1587372771.git.liu.denton@gmail.com/
[6]: https://lore.kernel.org/git/20200521182928.GA1308647@coredump.intra.peff.net/

Denton Liu (4):
  lib-submodule-update: add space after function name
  lib-submodule-update: consolidate --recurse-submodules
  lib-submodule-update: prepend "git" to $command
  lib-submodule-update: use callbacks in test_submodule_switch_common()

 t/lib-submodule-update.sh        | 107 ++++++++++++++++++++++---------
 t/t1013-read-tree-submodule.sh   |   4 +-
 t/t2013-checkout-submodule.sh    |   4 +-
 t/t3426-rebase-submodule.sh      |   8 +--
 t/t3512-cherry-pick-submodule.sh |   2 +-
 t/t3513-revert-submodule.sh      |   7 +-
 t/t3906-stash-submodule.sh       |   7 +-
 t/t4137-apply-submodule.sh       |  10 +--
 t/t4255-am-submodule.sh          |  10 +--
 t/t5572-pull-submodule.sh        |  16 ++---
 t/t6041-bisect-submodule.sh      |   7 +-
 t/t7112-reset-submodule.sh       |   6 +-
 t/t7613-merge-submodule.sh       |   8 +--
 13 files changed, 127 insertions(+), 69 deletions(-)

Range-diff against v4:
1:  ba2f642e0f = 1:  ba2f642e0f lib-submodule-update: add space after function name
2:  16d0a3eb9a = 2:  16d0a3eb9a lib-submodule-update: consolidate --recurse-submodules
3:  09446be5b9 = 3:  09446be5b9 lib-submodule-update: prepend "git" to $command
4:  35d07117e6 ! 4:  250eee1dd3 lib-submodule-update: use callbacks in test_submodule_switch_common()
    @@ Commit message
         intended behaviour.
     
         Instead of invoking $command as one monolithic helper function, break it
    -    up into three parts:
    +    up into two parts:
     
    -            1. $command which is always a git command.
    -            2. $before which is a callback function that runs just prior to
    -               $command.
    -            3. $after which is a callback function that runs just after
    +            1. $command which is a function containing a git command.
    +            2. $after which is a callback function that runs just after
                    $command.
     
    -    If the command requires a filename argument, specify it as `\$arg` since
    -    that variable will be set and the whole $command string will be eval'd.
    -    Unfortunately, there is no way to get rid of the eval as some of the
    -    commands that are passed (such as the `git pull` tests) require that no
    -    additional arguments are passed so we must have some mechanism for the
    -    caller to specify whether or not it wants the filename argument.
    +    If the command requires a filename argument, it will be passed in as
    +    the first arg.
     
    -    The $before and $after callback functions will be passed the filename as
    -    the first arg. These callback functions are optional and, if missing,
    -    will be replaced with `true`. Also, in the case where we have a
    -    `test_must_fail` test, $after will not be executed, similar to how the
    -    helper functions currently behave when the git command fails and exits
    -    the &&-chain.
    +    The $after callback function will be passed the filename as the first
    +    arg. This callback function is optional and, if missing, will be
    +    replaced with `true`. Also, in the case where we have a `test_must_fail`
    +    test, $after will not be executed, similar to how the helper functions
    +    currently behave when the git command fails and exits the &&-chain.
     
    -    Finally, as an added bonus, `test_must_fail` will only run on $command
    -    which is guaranteed to be a git command.
    +    Finally, as an added bonus, `test_must_fail` will now only run on git
    +    commands.
     
         An alternate design was considered where $OVERWRITING_FAIL is set from
         test_submodule_switch_common() and exposed to the helper function. This
    @@ Commit message
         using a signalling magic environment variable might be too indirect.
     
      ## t/lib-submodule-update.sh ##
    +@@ t/lib-submodule-update.sh: test_submodule_content () {
    + 	)
    + }
    + 
    ++test_command () {
    ++	command="$1" after="$2" arg="$3" &&
    ++	$command "$arg" &&
    ++	$after "$arg"
    ++}
    ++
    ++test_command_fail () {
    ++	command="$1" arg="$2" &&
    ++	$command "$arg" test_must_fail
    ++}
    ++
    + # Test that the following transitions are correctly handled:
    + # - Updated submodule
    + # - New submodule
     @@ t/lib-submodule-update.sh: test_submodule_content () {
      # Removing a submodule containing a .git directory must fail even when forced
      # to protect the history!
      #
    -+# $1: The git command to be eval'd and tested. The submodule being operated on
    -+# will be available as $arg.
    ++# $1: The function which contains the git command. It will be passed two
    ++# arguments. $1 will be the submodule being operated on. $2 will be
    ++# "test_must_fail" if the git command is expected to fail, else the empty
    ++# string.
     +#
    -+# $2: The function that will run before the git command. It will be passed the
    -+# submodule being operated on as the only argument. This argument is optional.
    -+#
    -+# $3: The function that will run after $1. It will be passed the submodule
    ++# $2: The function that will run after $1. It will be passed the submodule
     +# being operated on as the only argument. This argument is optional. It will
     +# not be run when testing a case where the git command is expected to fail.
      
    @@ t/lib-submodule-update.sh: test_submodule_content () {
      # or test_submodule_forced_switch() instead.
      test_submodule_switch_common () {
     -	command="$1"
    -+	command="$1" before="${2:-true}" after="${3:-true}"
    ++	command="$1" after="${2:-true}"
     +
      	######################### Appearing submodule #########################
      	# Switching to a commit letting a submodule appear creates empty dir ...
    @@ t/lib-submodule-update.sh: test_submodule_switch_common () {
      			cd submodule_update &&
      			git branch -t add_sub1 origin/add_sub1 &&
     -			$command add_sub1 &&
    -+			arg=add_sub1 &&
    -+			$before "$arg" &&
    -+			eval $command &&
    -+			$after "$arg" &&
    ++			test_command "$command" "$after" add_sub1 &&
      			test_superproject_content origin/add_sub1 &&
      			test_dir_is_empty sub1 &&
      			git submodule update --init --recursive &&
    @@ t/lib-submodule-update.sh: test_submodule_switch_common () {
      			mkdir sub1 &&
      			git branch -t add_sub1 origin/add_sub1 &&
     -			$command add_sub1 &&
    -+			arg=add_sub1 &&
    -+			$before "$arg" &&
    -+			eval $command &&
    -+			$after "$arg" &&
    ++			test_command "$command" "$after" add_sub1 &&
      			test_superproject_content origin/add_sub1 &&
      			test_dir_is_empty sub1 &&
      			git submodule update --init --recursive &&
    @@ t/lib-submodule-update.sh: test_submodule_switch_common () {
      			cd submodule_update &&
      			git branch -t replace_file_with_sub1 origin/replace_file_with_sub1 &&
     -			$command replace_file_with_sub1 &&
    -+			arg=replace_file_with_sub1 &&
    -+			$before "$arg" &&
    -+			eval $command &&
    -+			$after "$arg" &&
    ++			test_command "$command" "$after" replace_file_with_sub1 &&
      			test_superproject_content origin/replace_file_with_sub1 &&
      			test_dir_is_empty sub1 &&
      			git submodule update --init --recursive &&
    @@ t/lib-submodule-update.sh: test_submodule_switch_common () {
      			cd submodule_update &&
      			git branch -t replace_directory_with_sub1 origin/replace_directory_with_sub1 &&
     -			$command replace_directory_with_sub1 &&
    -+			arg=replace_directory_with_sub1  &&
    -+			$before "$arg" &&
    -+			eval $command &&
    -+			$after "$arg" &&
    ++			test_command "$command" "$after" replace_directory_with_sub1 &&
      			test_superproject_content origin/replace_directory_with_sub1 &&
      			test_dir_is_empty sub1 &&
      			git submodule update --init --recursive &&
    @@ t/lib-submodule-update.sh: test_submodule_switch_common () {
      			cd submodule_update &&
      			git branch -t remove_sub1 origin/remove_sub1 &&
     -			$command remove_sub1 &&
    -+			arg=remove_sub1 &&
    -+			$before "$arg" &&
    -+			eval $command &&
    -+			$after "$arg" &&
    ++			test_command "$command" "$after" remove_sub1 &&
      			test_superproject_content origin/remove_sub1 &&
      			test_submodule_content sub1 origin/add_sub1
      		)
    @@ t/lib-submodule-update.sh: test_submodule_switch_common () {
      			git branch -t remove_sub1 origin/remove_sub1 &&
      			replace_gitfile_with_git_dir sub1 &&
     -			$command remove_sub1 &&
    -+			arg=remove_sub1 &&
    -+			$before "$arg" &&
    -+			eval $command &&
    -+			$after "$arg" &&
    ++			test_command "$command" "$after" remove_sub1 &&
      			test_superproject_content origin/remove_sub1 &&
      			test_git_directory_is_unchanged sub1 &&
      			test_submodule_content sub1 origin/add_sub1
    @@ t/lib-submodule-update.sh: test_submodule_switch_common () {
      			cd submodule_update &&
      			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
     -			test_must_fail $command replace_sub1_with_directory &&
    -+			arg=replace_sub1_with_directory &&
    -+			$before "$arg" &&
    -+			eval test_must_fail $command &&
    ++			test_command_fail "$command" replace_sub1_with_directory &&
      			test_superproject_content origin/add_sub1 &&
      			test_submodule_content sub1 origin/add_sub1
      		)
    @@ t/lib-submodule-update.sh: test_submodule_switch_common () {
      			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
      			replace_gitfile_with_git_dir sub1 &&
     -			test_must_fail $command replace_sub1_with_directory &&
    -+			arg=replace_sub1_with_directory &&
    -+			$before "$arg" &&
    -+			eval test_must_fail $command &&
    ++			test_command_fail "$command" replace_sub1_with_directory &&
      			test_superproject_content origin/add_sub1 &&
      			test_git_directory_is_unchanged sub1 &&
      			test_submodule_content sub1 origin/add_sub1
    @@ t/lib-submodule-update.sh: test_submodule_switch_common () {
      			cd submodule_update &&
      			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
     -			test_must_fail $command replace_sub1_with_file &&
    -+			arg=replace_sub1_with_file &&
    -+			$before "$arg" &&
    -+			eval test_must_fail $command &&
    ++			test_command_fail "$command" replace_sub1_with_file &&
      			test_superproject_content origin/add_sub1 &&
      			test_submodule_content sub1 origin/add_sub1
      		)
    @@ t/lib-submodule-update.sh: test_submodule_switch_common () {
      			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
      			replace_gitfile_with_git_dir sub1 &&
     -			test_must_fail $command replace_sub1_with_file &&
    -+			arg=replace_sub1_with_file &&
    -+			$before "$arg" &&
    -+			eval test_must_fail $command &&
    ++			test_command_fail "$command" replace_sub1_with_file &&
      			test_superproject_content origin/add_sub1 &&
      			test_git_directory_is_unchanged sub1 &&
      			test_submodule_content sub1 origin/add_sub1
    @@ t/lib-submodule-update.sh: test_submodule_switch_common () {
      			cd submodule_update &&
      			git branch -t modify_sub1 origin/modify_sub1 &&
     -			$command modify_sub1 &&
    -+			arg=modify_sub1 &&
    -+			$before "$arg" &&
    -+			eval $command &&
    -+			$after "$arg" &&
    ++			test_command "$command" "$after" modify_sub1 &&
      			test_superproject_content origin/modify_sub1 &&
      			test_submodule_content sub1 origin/add_sub1 &&
      			git submodule update &&
    @@ t/lib-submodule-update.sh: test_submodule_switch_common () {
      			cd submodule_update &&
      			git branch -t invalid_sub1 origin/invalid_sub1 &&
     -			$command invalid_sub1 &&
    -+			arg=invalid_sub1 &&
    -+			$before "$arg" &&
    -+			eval $command &&
    -+			$after "$arg" &&
    ++			test_command "$command" "$after" invalid_sub1 &&
      			test_superproject_content origin/invalid_sub1 &&
      			test_submodule_content sub1 origin/add_sub1 &&
      			test_must_fail git submodule update &&
    @@ t/lib-submodule-update.sh: test_submodule_switch_common () {
      			cd submodule_update &&
      			git branch -t valid_sub1 origin/valid_sub1 &&
     -			$command valid_sub1 &&
    -+			arg=valid_sub1 &&
    -+			$before "$arg" &&
    -+			eval $command &&
    -+			$after "$arg" &&
    ++			test_command "$command" "$after" valid_sub1 &&
      			test_superproject_content origin/valid_sub1 &&
      			test_dir_is_empty sub1 &&
      			git submodule update --init --recursive &&
    @@ t/lib-submodule-update.sh: test_submodule_switch_common () {
      # below to 1.
      #
     -# Use as follows:
    -+# $1: The git command to be eval'd and tested. The submodule being operated on
    -+# will be available as $arg. Do not include the leading "git".
    - #
    --# my_func () {
    -+# $2: The function that will run before the git command. It will be passed the
    -+# submodule being operated on as the only argument. This argument is optional.
    ++# $1: The function which contains the git command. It will be passed two
    ++# arguments. $1 will be the submodule being operated on. $2 will be
    ++# "test_must_fail" if the git command is expected to fail, else the empty
    ++# string.
     +#
    -+# $3: The function that will run after $1. It will be passed the submodule
    ++# $2: The function that will run after $1. It will be passed the submodule
     +# being operated on as the only argument. This argument is optional. It will
     +# not be run when testing a case where the git command is expected to fail.
     +#
     +# The following example uses `git some-command` as an example command to be
     +# tested. It updates the worktree and index to match a target, but not any
     +# submodule directories.
    -+#
    -+# my_func_before () {
    + #
    + # my_func () {
      #   target=$1
     -#   # Do something here that updates the worktree and index to match target,
     -#   # but not any submodule directories.
    -+#   # Prepare for git some-command to be run
    ++#   $2 git some-command $target
      # }
     -# test_submodule_switch_func "my_func"
     +# my_func_after () {
     +#   target=$1
     +#   # Check the state after git some-command is run
     +# }
    -+# test_submodule_switch_func "some-command \$arg" "my_func_before" "my_func_after"
    ++# test_submodule_switch_func "my_func" "my_func_after"
      test_submodule_switch_func () {
    --	command="$1"
    + 	command="$1"
     -	test_submodule_switch_common "$command"
    -+	command="git $1"
    -+	before="$2"
    -+	after="$3"
    -+	test_submodule_switch_common "$command" "$before" "$after"
    ++	after="$2"
    ++	test_submodule_switch_common "$command" "$after"
      
      	# An empty directory does not prevent the creation of a submodule of
      	# the same name, but a file does.
    @@ t/lib-submodule-update.sh: test_submodule_switch_func () {
      			git branch -t add_sub1 origin/add_sub1 &&
      			>sub1 &&
     -			test_must_fail $command add_sub1 &&
    -+			arg=add_sub1 &&
    -+			$before "$arg" &&
    -+			eval test_must_fail $command &&
    ++			test_command_fail "$command" add_sub1 &&
      			test_superproject_content origin/no_submodule &&
      			test_must_be_empty sub1
      		)
    -@@ t/lib-submodule-update.sh: test_submodule_switch_func () {
    + 	'
      }
      
    ++git_test_func () {
    ++	$2 git $gitcmd "$1"
    ++}
    ++
      test_submodule_switch () {
     -	test_submodule_switch_func "git $1"
    -+	test_submodule_switch_func "$1 \$arg"
    ++	gitcmd="$1"
    ++	test_submodule_switch_func "git_test_func"
      }
      
      # Same as test_submodule_switch(), except that throwing away local changes in
      # the superproject is allowed.
      test_submodule_forced_switch () {
     -	command="$1"
    -+	command="git $1 \$arg"
    ++	gitcmd="$1"
    ++	command="git_test_func"
      	KNOWN_FAILURE_FORCED_SWITCH_TESTS=1
     -	test_submodule_switch_common "git $command"
     +	test_submodule_switch_common "$command"
    @@ t/lib-submodule-update.sh: test_submodule_forced_switch () {
      			git branch -t add_sub1 origin/add_sub1 &&
      			>sub1 &&
     -			$command add_sub1 &&
    -+			arg=add_sub1 &&
    -+			eval $command &&
    ++			test_command "$command" true add_sub1 &&
      			test_superproject_content origin/add_sub1 &&
      			test_dir_is_empty sub1
      		)
     
      ## t/t3426-rebase-submodule.sh ##
     @@ t/t3426-rebase-submodule.sh: git_rebase () {
    - 	git revert HEAD &&
      	git status -su >actual &&
      	ls -1pR * >>actual &&
    --	test_cmp expect actual &&
    + 	test_cmp expect actual &&
     -	git rebase "$1"
    -+	test_cmp expect actual
    ++	$2 git rebase "$1"
      }
      
    --test_submodule_switch_func "git_rebase"
    -+test_submodule_switch_func "rebase \$arg" "git_rebase"
    - 
    - git_rebase_interactive () {
    - 	git status -su >expect &&
    + test_submodule_switch_func "git_rebase"
     @@ t/t3426-rebase-submodule.sh: git_rebase_interactive () {
    - 	ls -1pR * >>actual &&
      	test_cmp expect actual &&
      	set_fake_editor &&
    --	echo "fake-editor.sh" >.git/info/exclude &&
    + 	echo "fake-editor.sh" >.git/info/exclude &&
     -	git rebase -i "$1"
    -+	echo "fake-editor.sh" >.git/info/exclude
    ++	$2 git rebase -i "$1"
      }
      
    --test_submodule_switch_func "git_rebase_interactive"
    -+test_submodule_switch_func "rebase -i \$arg" "git_rebase_interactive"
    - 
    - test_expect_success 'rebase interactive ignores modified submodules' '
    - 	test_when_finished "rm -rf super sub" &&
    + test_submodule_switch_func "git_rebase_interactive"
     
      ## t/t3513-revert-submodule.sh ##
    -@@ t/t3513-revert-submodule.sh: test_description='revert can handle submodules'
    - # first so we can restore the work tree test setup after doing the checkout
    - # and revert.  We test here that the restored work tree content is identical
    - # to that at the beginning. The last revert is then tested by the framework.
    --git_revert () {
    -+git_revert_before () {
    +@@ t/t3513-revert-submodule.sh: git_revert () {
      	git status -su >expect &&
      	ls -1pR * >>expect &&
    --	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
    + 	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
     -	git checkout "$1" &&
    -+	tar cf "$TRASH_DIRECTORY/tmp.tar" *
    ++	$2 git checkout "$1"
     +}
     +
     +git_revert_after () {
    @@ t/t3513-revert-submodule.sh: git_revert () {
      
      KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
     -test_submodule_switch_func "git_revert"
    -+test_submodule_switch_func "checkout \$arg" "git_revert_before" "git_revert_after"
    ++test_submodule_switch_func "git_revert" "git_revert_after"
      
      test_done
     
      ## t/t3906-stash-submodule.sh ##
     @@ t/t3906-stash-submodule.sh: test_description='stash can handle submodules'
    - . ./test-lib.sh
    - . "$TEST_DIRECTORY"/lib-submodule-update.sh
    - 
    --git_stash () {
    -+git_stash_before () {
    + git_stash () {
      	git status -su >expect &&
    --	ls -1pR * >>expect &&
    + 	ls -1pR * >>expect &&
     -	git read-tree -u -m "$1" &&
    -+	ls -1pR * >>expect
    ++	$2 git read-tree -u -m "$1"
     +}
     +
     +git_stash_after () {
    @@ t/t3906-stash-submodule.sh: git_stash () {
      KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
      KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
     -test_submodule_switch_func "git_stash"
    -+test_submodule_switch_func "read-tree -u -m \$arg" "git_stash_before" "git_stash_after"
    ++test_submodule_switch_func "git_stash" "git_stash_after"
      
      setup_basic () {
      	test_when_finished "rm -rf main sub" &&
     
      ## t/t4137-apply-submodule.sh ##
     @@ t/t4137-apply-submodule.sh: test_description='git apply handling submodules'
    - . ./test-lib.sh
      . "$TEST_DIRECTORY"/lib-submodule-update.sh
      
    --apply_index () {
    + apply_index () {
     -	git diff --ignore-submodules=dirty "..$1" | git apply --index -
    -+create_diff () {
    -+	git diff --ignore-submodules=dirty "..$1" >diff
    ++	git diff --ignore-submodules=dirty "..$1" >diff &&
    ++	$2 git apply --index diff
      }
      
    --test_submodule_switch_func "apply_index"
    -+test_submodule_switch_func "apply --index diff" "create_diff"
    + test_submodule_switch_func "apply_index"
      
    --apply_3way () {
    + apply_3way () {
     -	git diff --ignore-submodules=dirty "..$1" | git apply --3way -
    --}
    --
    --test_submodule_switch_func "apply_3way"
    -+test_submodule_switch_func "apply --3way diff" "create_diff"
    ++	git diff --ignore-submodules=dirty "..$1" >diff
    ++	$2 git apply --3way diff
    + }
      
    - test_done
    + test_submodule_switch_func "apply_3way"
     
      ## t/t4255-am-submodule.sh ##
     @@ t/t4255-am-submodule.sh: test_description='git am handling submodules'
    - . ./test-lib.sh
      . "$TEST_DIRECTORY"/lib-submodule-update.sh
      
    --am () {
    + am () {
     -	git format-patch --stdout --ignore-submodules=dirty "..$1" | git am -
    -+create_patch () {
    -+	git format-patch --stdout --ignore-submodules=dirty "..$1" >patch
    ++	git format-patch --stdout --ignore-submodules=dirty "..$1" >patch &&
    ++	$2 git am patch
      }
      
    --test_submodule_switch_func "am"
    --
    --am_3way () {
    + test_submodule_switch_func "am"
    + 
    + am_3way () {
     -	git format-patch --stdout --ignore-submodules=dirty "..$1" | git am --3way -
    --}
    -+test_submodule_switch_func "am patch" "create_patch"
    ++	git format-patch --stdout --ignore-submodules=dirty "..$1" >patch &&
    ++	$2 git am --3way patch
    + }
      
      KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
    --test_submodule_switch_func "am_3way"
    -+test_submodule_switch_func "am --3way patch" "create_patch"
    - 
    - test_expect_success 'setup diff.submodule' '
    - 	test_commit one &&
     
      ## t/t5572-pull-submodule.sh ##
     @@ t/t5572-pull-submodule.sh: reset_branch_to_HEAD () {
    - 	git branch --set-upstream-to="origin/$1" "$1"
    + 
    + git_pull () {
    + 	reset_branch_to_HEAD "$1" &&
    +-	git pull
    ++	$2 git pull
      }
      
    --git_pull () {
    --	reset_branch_to_HEAD "$1" &&
    --	git pull
    --}
    --
      # pulls without conflicts
    --test_submodule_switch_func "git_pull"
    -+test_submodule_switch_func "pull" "reset_branch_to_HEAD"
    +@@ t/t5572-pull-submodule.sh: test_submodule_switch_func "git_pull"
      
    --git_pull_ff () {
    --	reset_branch_to_HEAD "$1" &&
    + git_pull_ff () {
    + 	reset_branch_to_HEAD "$1" &&
     -	git pull --ff
    --}
    -+test_submodule_switch_func "pull --ff" "reset_branch_to_HEAD"
    ++	$2 git pull --ff
    + }
      
    --test_submodule_switch_func "git_pull_ff"
    --
    --git_pull_ff_only () {
    --	reset_branch_to_HEAD "$1" &&
    + test_submodule_switch_func "git_pull_ff"
    + 
    + git_pull_ff_only () {
    + 	reset_branch_to_HEAD "$1" &&
     -	git pull --ff-only
    --}
    --
    --test_submodule_switch_func "git_pull_ff_only"
    --
    --git_pull_noff () {
    --	reset_branch_to_HEAD "$1" &&
    ++	$2 git pull --ff-only
    + }
    + 
    + test_submodule_switch_func "git_pull_ff_only"
    + 
    + git_pull_noff () {
    + 	reset_branch_to_HEAD "$1" &&
     -	git pull --no-ff
    --}
    -+test_submodule_switch_func "pull --ff-only" "reset_branch_to_HEAD"
    ++	$2 git pull --no-ff
    + }
      
      KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
    - KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
    --test_submodule_switch_func "git_pull_noff"
    -+test_submodule_switch_func "pull --no-ff" "reset_branch_to_HEAD"
    - 
    - test_expect_success 'pull --recurse-submodule setup' '
    - 	test_create_repo child &&
     
      ## t/t6041-bisect-submodule.sh ##
    -@@ t/t6041-bisect-submodule.sh: test_description='bisect can handle submodules'
    - . ./test-lib.sh
    - . "$TEST_DIRECTORY"/lib-submodule-update.sh
    - 
    --git_bisect () {
    -+git_bisect_before () {
    - 	git status -su >expect &&
    +@@ t/t6041-bisect-submodule.sh: git_bisect () {
      	ls -1pR * >>expect &&
      	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
    --	GOOD=$(git rev-parse --verify HEAD) &&
    + 	GOOD=$(git rev-parse --verify HEAD) &&
     -	git checkout "$1" &&
    -+	GOOD=$(git rev-parse --verify HEAD)
    ++	$2 git checkout "$1"
     +}
     +
     +git_bisect_after () {
    @@ t/t6041-bisect-submodule.sh: git_bisect () {
      }
      
     -test_submodule_switch_func "git_bisect"
    -+test_submodule_switch_func "checkout \$arg" "git_bisect_before" "git_bisect_after"
    ++test_submodule_switch_func "git_bisect" "git_bisect_after"
      
      test_done
-- 
2.27.0.132.g321788e831

