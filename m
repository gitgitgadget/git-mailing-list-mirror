Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5751CC2D0D5
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297EC20643
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkvdPH1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfLWSuG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 13:50:06 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43673 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfLWSuF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 13:50:05 -0500
Received: by mail-ed1-f65.google.com with SMTP id dc19so16103491edb.10
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 10:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7y0XQf0BqMvqoUIMKb7DFIsP3AfCkOybUtRWD2iGmyI=;
        b=bkvdPH1lboMxjbdcbQ7zVecl3LJpFc7AY/Ob6JC6e/et1q9xwgIBh5PnihJUspQLme
         mGzN7qVOXN5gnIqe5ilHi/Bsj3fntBFxGf8q3tiT5mEU6RifVgDrqxRbZJn/wld2SmEe
         gEqUMsR5BmMX0KVIKxkdyvF/wlweTBlhpHeOLDGZY1jiR5oE/EZryOjSQUS8oBAdQ3c7
         R6yGVuijTF/tbl6ksmP8K3C5907yGrZIQHYggj+HcfUaMbpgU5m2yQi2lFKkBnMJHUeP
         /6OJPpoVClFUytKEbRlDKaEeCi9nGo68dE01l+GnWjqTHbTLX4zZpLIyX+ykX5VwIOab
         672Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7y0XQf0BqMvqoUIMKb7DFIsP3AfCkOybUtRWD2iGmyI=;
        b=AvPIKlfbtcPMVIZ3JdUBofZuO40i0+MWGRU72sq4lv78L8GJWtu32A+MMsMfkh0WQ9
         n0d+sTFRhvQPlt5kAPobrotE5We4jseHm7/KVS+l2Siaw01FyoZ9FjIKo1hq4S7IvFcg
         26Z1vYF/1O+ZasaUj8SeSf+AjdE2qcs1Q+jQBXPNbL5feMlfDHKCLfkxz5WNwZ68rt2X
         foOdTgxeAeh5YgU6rVD/tSFvXOMhJej4CGNnU6iZhqJtKSM5a8VM8aju+SRHXdOiTFIQ
         sBnMOzcTR6HwSO95bnwMX1U86c2S+SZ1fXoB5n7ixieMotxgvUSVXiQnw4NrqKtlV/6L
         5LtA==
X-Gm-Message-State: APjAAAWJNqmjzRKXMkUo4JxxbJPJrIn16N5QDBKgSWRT2j91m7cdZXbE
        yPCNzcflUtxkf4EU6jA8cem149Gk
X-Google-Smtp-Source: APXvYqxrncK/h9ipizQ5wq1Y85WsJ9LJ8t+2/hdRzNqW0fBac7TEippSRUTQo3uLXCZQramyouCS2A==
X-Received: by 2002:a17:906:eda9:: with SMTP id sa9mr32357013ejb.297.1577127001432;
        Mon, 23 Dec 2019 10:50:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s16sm2392707edy.51.2019.12.23.10.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 10:50:00 -0800 (PST)
Message-Id: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Dec 2019 18:49:44 +0000
Subject: [PATCH v2 00/15] rebase: make the default backend configurable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series does a lot of work around making the default rebase backend
configurable, and switching the default from the am backend to the
merge/interactive one.

See the cover letter for v1[*] for a more detailed motivation for the
series, the type of changes being made, and areas I'd like to reviewers to
focus on.

Changes since v1:

 * Made some cleanups to the empty type parsing, as suggested by Junio
   (Patch 1)
 * Changed the shell prompt for all rebases to just be "REBASE", as
   suggested by SZEDER (Patch 11)
 * Correctly check that work was done (by checking that reflog grew, patch
   6); flagged by Denton

[*] 
https://lore.kernel.org/git/pull.679.git.git.1576861788.gitgitgadget@gmail.com/

Elijah Newren (15):
  rebase: extend the options for handling of empty commits
  t3406: simplify an already simple test
  rebase, sequencer: remove the broken GIT_QUIET handling
  rebase: make sure to pass along the quiet flag to the sequencer
  rebase: fix handling of restrict_revision
  t3432: make these tests work with either am or merge backends
  rebase: allow more types of rebases to fast-forward
  git-rebase.txt: add more details about behavioral differences of
    backends
  rebase: move incompatibility checks between backend options a bit
    earlier
  rebase: add an --am option
  contrib: change the prompt for interactive-based rebases
  rebase tests: mark tests specific to the am-backend with --am
  rebase tests: repeat some tests using the merge backend instead of am
  rebase: make the backend configurable via config setting
  rebase: change the default backend from "am" to "merge"

 Documentation/config/rebase.txt         |   8 ++
 Documentation/git-rebase.txt            | 150 ++++++++++++++++----
 builtin/rebase.c                        | 177 +++++++++++++++++++-----
 contrib/completion/git-prompt.sh        |   4 +-
 rebase-interactive.c                    |   4 +-
 rebase-interactive.h                    |   2 +-
 sequencer.c                             |  80 ++++++++---
 sequencer.h                             |   6 +-
 t/t3400-rebase.sh                       |  36 ++++-
 t/t3401-rebase-and-am-rename.sh         |   4 +-
 t/t3404-rebase-interactive.sh           |   2 +-
 t/t3406-rebase-message.sh               |  19 ++-
 t/t3407-rebase-abort.sh                 |   6 +-
 t/t3420-rebase-autostash.sh             |   2 +-
 t/t3421-rebase-topology-linear.sh       |   4 +-
 t/t3424-rebase-empty.sh                 |  89 ++++++++++++
 t/t3425-rebase-topology-merges.sh       |   8 +-
 t/t3427-rebase-subtree.sh               |  16 ++-
 t/t3432-rebase-fast-forward.sh          |  54 ++++----
 t/t3433-rebase-options-compatibility.sh |  13 +-
 t/t5407-post-rewrite-hook.sh            |  12 +-
 t/t5520-pull.sh                         |  27 +++-
 t/t6047-diff3-conflict-markers.sh       |  13 +-
 t/t7512-status-help.sh                  |  12 +-
 t/t9106-git-svn-commit-diff-clobber.sh  |   3 +-
 t/t9903-bash-prompt.sh                  |   8 +-
 26 files changed, 577 insertions(+), 182 deletions(-)
 create mode 100755 t/t3424-rebase-empty.sh


base-commit: 12029dc57db23baef008e77db1909367599210ee
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-679%2Fnewren%2Frebase-fixes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-679/newren/rebase-fixes-v2
Pull-Request: https://github.com/git/git/pull/679

Range-diff vs v1:

  1:  13e2056e78 !  1:  1c2b77e94d rebase: extend the options for handling of empty commits
     @@ -219,28 +219,24 @@
       	return 0;
       }
       
     -+static long parse_empty_value(const char *value)
     ++static enum empty_type parse_empty_value(const char *value)
      +{
     -+	if (!value)
     -+		return EMPTY_UNSPECIFIED;
     -+	else if (!strcasecmp(value, "drop"))
     ++	if (!strcasecmp(value, "drop"))
      +		return EMPTY_DROP;
      +	else if (!strcasecmp(value, "keep"))
      +		return EMPTY_KEEP;
      +	else if (!strcasecmp(value, "ask"))
      +		return EMPTY_ASK;
     -+	return EMPTY_UNSPECIFIED;
     ++
     ++	die(_("unrecognized empty type '%s'; valid values are \"drop\", \"keep\", and \"ask\"."), value);
      +}
      +
      +static int parse_opt_empty(const struct option *opt, const char *arg, int unset)
      +{
      +	struct rebase_options *options = opt->value;
     -+	long value = parse_empty_value(arg);
     ++	enum empty_type value = parse_empty_value(arg);
      +
      +	BUG_ON_OPT_NEG(unset);
     -+	if (value < 0)
     -+		return error(_("option empty accepts \"drop\", "
     -+			       "\"keep\", and \"ask\""));
      +
      +	options->empty = value;
      +	return 0;
  2:  47ea99fb30 =  2:  bd3c5ec155 t3406: simplify an already simple test
  3:  b99feebae1 =  3:  49388b79fd rebase, sequencer: remove the broken GIT_QUIET handling
  4:  66bee10d1c =  4:  478479358f rebase: make sure to pass along the quiet flag to the sequencer
  5:  b84faa8684 =  5:  ee26f5a161 rebase: fix handling of restrict_revision
  6:  9b1ad46c58 !  6:  34a69def33 t3432: make these tests work with either am or merge backends
     @@ -37,9 +37,8 @@
      -			# Must check this case first, for 'is up to
      -			# date, rebase forced[...]rewinding head' cases
      -			test_i18ngrep 'rewinding head' stdout
     -+			wc -l .git/logs/HEAD >old &&
     -+			wc -l .git/logs/HEAD >new &&
     -+			test_line_count '-gt' $(($old + 2)) .git/logs/HEAD
     ++			old=\$(wc -l <expect) &&
     ++			test_line_count '-gt' \$old .git/logs/HEAD
       		elif test $what = noop
       		then
      -			test_i18ngrep 'is up to date' stdout &&
     @@ -108,10 +107,3 @@
       test_rebase_same_head success noop same success work diff --onto master... master
       test_rebase_same_head success noop same success work diff --keep-base master
       test_rebase_same_head success noop same success work diff --keep-base
     --test_rebase_same_head failure work same success work diff --fork-point --onto B B
     --test_rebase_same_head failure work same success work diff --fork-point --onto B... B
     -+test_rebase_same_head success work same success work diff --fork-point --onto B B
     -+test_rebase_same_head success work same success work diff --fork-point --onto B... B
     - test_rebase_same_head success noop same success work diff --fork-point --onto master... master
     - test_rebase_same_head success noop same success work diff --fork-point --keep-base master
     - 
  7:  a4073df910 =  7:  f2c92853b4 rebase: allow more types of rebases to fast-forward
  8:  90e8927ea0 =  8:  b307340f7c git-rebase.txt: add more details about behavioral differences of backends
  9:  5c31d664f3 =  9:  7c3f2e07f3 rebase: move incompatibility checks between backend options a bit earlier
 10:  340bf71c5c = 10:  1df11f0b51 rebase: add an --am option
 11:  1c3f8ba328 ! 11:  94b5a3051d contrib: change the prompt for am-based rebases
     @@ -1,17 +1,38 @@
      Author: Elijah Newren <newren@gmail.com>
      
     -    contrib: change the prompt for am-based rebases
     -
     -    The prompt for am-based rebases was REBASE, while for interactive-based
     -    rebases was REBASE-i.  A while ago, we switched merge-based rebases from
     -    using REBASE-m to REBASE-i via re-implementing the merge backend based
     -    on the interactive backend.  We will soon be changing the default rebase
     -    backend to the interactive one, meaning the default prompt will be
     -    REBASE-i rather than REBASE.  We have also noted in the documentation
     -    that currently am-specific options will be implemented in the
     -    interactive backend, and even the --am flag may eventually imply an
     -    interactive-based rebase.  As such, change the prompt for an am-based
     -    rebase from REBASE to REBASE-a.
     +    contrib: change the prompt for interactive-based rebases
     +
     +    In the past, we had different prompts for different types of rebases:
     +       REBASE: for am-based rebases
     +       REBASE-m: for merge-based rebases
     +       REBASE-i: for interactive-based rebases
     +
     +    It's not clear why this distinction was necessary or helpful; when the
     +    prompt was added in commit e75201963f67 ("Improve bash prompt to detect
     +    various states like an unfinished merge", 2007-09-30), it simply added
     +    these three different types.  Perhaps there was a useful purpose back
     +    then, but there have been some changes:
     +
     +      * The merge backend was deleted after being implemented on top of the
     +        interactive backend, causing the prompt for merge-based rebases to
     +        change from REBASE-m to REBASE-i.
     +      * The interactive backend is used for multiple different types of
     +        non-interactive rebases, so the "-i" part of the prompt doesn't
     +        really mean what it used to.
     +      * Rebase backends have gained more abilities and have a great deal of
     +        overlap, sometimes making it hard to distinguish them.
     +      * Behavioral differences between the backends have also been ironed
     +        out.
     +      * We want to change the default backend from am to interactive, which
     +        means people would get "REBASE-i" by default if we didn't change
     +        the prompt, and only if they specified --am or --whitespace or -C
     +        would they get the "REBASE" prompt.
     +      * In the future, we plan to have "--whitespace", "-C", and even "--am"
     +        run the interactive backend once it can handle everything the
     +        am-backend can.
     +
     +    For all these reasons, make the prompt for any type of rebase just be
     +    "REBASE".
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ -19,26 +40,46 @@
       --- a/contrib/completion/git-prompt.sh
       +++ b/contrib/completion/git-prompt.sh
      @@
     - 			__git_eread "$g/rebase-apply/last" total
     - 			if [ -f "$g/rebase-apply/rebasing" ]; then
     - 				__git_eread "$g/rebase-apply/head-name" b
     --				r="|REBASE"
     -+				r="|REBASE-a"
     - 			elif [ -f "$g/rebase-apply/applying" ]; then
     - 				r="|AM"
     - 			else
     + 		__git_eread "$g/rebase-merge/msgnum" step
     + 		__git_eread "$g/rebase-merge/end" total
     + 		if [ -f "$g/rebase-merge/interactive" ]; then
     +-			r="|REBASE-i"
     ++			r="|REBASE"
     + 		else
     +-			r="|REBASE-m"
     ++			r="|REBASE"
     + 		fi
     + 	else
     + 		if [ -d "$g/rebase-apply" ]; then
      
       diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
       --- a/t/t9903-bash-prompt.sh
       +++ b/t/t9903-bash-prompt.sh
     +@@
     + '
     + 
     + test_expect_success 'prompt - interactive rebase' '
     +-	printf " (b1|REBASE-i 2/3)" >expected &&
     ++	printf " (b1|REBASE 2/3)" >expected &&
     + 	write_script fake_editor.sh <<-\EOF &&
     + 		echo "exec echo" >"$1"
     + 		echo "edit $(git log -1 --format="%h")" >>"$1"
     +@@
     + '
     + 
     + test_expect_success 'prompt - rebase merge' '
     +-	printf " (b2|REBASE-i 1/3)" >expected &&
     ++	printf " (b2|REBASE 1/3)" >expected &&
     + 	git checkout b2 &&
     + 	test_when_finished "git checkout master" &&
     + 	test_must_fail git rebase --merge b1 b2 &&
      @@
       	test_cmp expected "$actual"
       '
       
      -test_expect_success 'prompt - rebase' '
     --	printf " (b2|REBASE 1/3)" >expected &&
      +test_expect_success 'prompt - rebase am' '
     -+	printf " (b2|REBASE-a 1/3)" >expected &&
     + 	printf " (b2|REBASE 1/3)" >expected &&
       	git checkout b2 &&
       	test_when_finished "git checkout master" &&
      -	test_must_fail git rebase b1 b2 &&
 12:  bcac3b77e8 = 12:  c905d288bf rebase tests: mark tests specific to the am-backend with --am
 13:  81d0f18b3e = 13:  0287881361 rebase tests: repeat some tests using the merge backend instead of am
 14:  04db4472d3 = 14:  ec782e711c rebase: make the backend configurable via config setting
 15:  999587933b = 15:  7adcbc0bc5 rebase: change the default backend from "am" to "merge"

-- 
gitgitgadget
