Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A835EC433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 23:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DAFD61213
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 23:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbhKDXwZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 19:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhKDXwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 19:52:25 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A466C061714
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 16:49:46 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id o6-20020a170902778600b0013c8ce59005so4237340pll.2
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 16:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=kklKHdSCrMFxLA0fmuWZCFVVcpg7XOdmSjvEBrp5HFk=;
        b=WtjoQWcqy73bHkD1HITcvkpV8OIaICei8YujMqxBffmg9NNPfwNhAVv0jDA19KYxxB
         8fZ7GKr4Zp75RGwi9O37kNz2gVAWPlpFFyA5AcCKDsPzF9QtuuLtHqCznF1I49wfxjXS
         7+xOLIbBMVnZzKyS/dvBKnZ1w4AtFq7XvH4eZH3DOSmLjOV4wlGfY0B1UrFBNL133BT1
         Quw5DYZjSgxdJmdPgSkHvcoIuPs+DrgXc054GNp6OsSPFkKnE/xpCzVvDReT3yIz4vpQ
         /K6Tm4RxRQNpZkKvaWUmQgM6yD001Q20tuTemVA4kQKpAsnAvB+7IfT0kLHVrfdYCBGI
         Ks1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=kklKHdSCrMFxLA0fmuWZCFVVcpg7XOdmSjvEBrp5HFk=;
        b=UOmBJ5OfShWVe38j4+vQUhG+3URZKEPFrmhAav3XQPBYPTKk9FDTV7y3OTCuKhqx0F
         o4g+X60r3TJHTACwneXElKSKxcQrukg4OqOlQHl7FVtIz0BcGgKjrtyIB8H6sNurjv0W
         VKDdf/eabBpvlCUS5OpX6+7LNhup7SpL6Tobzhh90NJVdjgogxyujbl3S8yFPxGJ8p6+
         vOMMANaz2yC52Z+Hfkz35Jw6JxgP1JoSwJ4RFe6+lCNknNN2gRZ7ROLNd1irwwTj6FBR
         BNAbovlAo82Gkzjq+vnob46On8GID1DaLHJaG0NIPeIlQCTTTy0BWvAL7/mkMW4IIbDR
         arJw==
X-Gm-Message-State: AOAM5309TLqjnZA122fdJO7yn16F/7FkwnTStwzmd+7nb3VNS059jFdg
        ZPuDMgFGxuVl5b/s2/wg5LFIOWbqZ9UPpVZTUynusWtgaERz9X9c3mzGQhaSSjT38f0M2Xnjv2T
        inmIKOSSYDQQ4dES68C7RAuXDC4C5CeERngIqKCqXTgw8qqw4qBJqaNzH6cBcQA+TzKhYwKTDtw
        ==
X-Google-Smtp-Source: ABdhPJwzEU+tcoH3B/YHQK3dJnX1Vx+8XaSQPW2VFANudOMbSqpeMPUVnFWOQfwspwKguLlxS15u8jXfjZXAnyAtOIU=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:35a1:c171:b6f3:d46c])
 (user=emilyshaffer job=sendgmr) by 2002:a17:90a:3045:: with SMTP id
 q5mr25868927pjl.58.1636069785836; Thu, 04 Nov 2021 16:49:45 -0700 (PDT)
Date:   Thu,  4 Nov 2021 16:49:38 -0700
In-Reply-To: <20211014203416.2802639-1-emilyshaffer@google.com>
Message-Id: <20211104234942.3473650-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v5 0/4] cache parent project's gitdir in submodules
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For the original cover letter, see
https://lore.kernel.org/git/20210611225428.1208973-1-emilyshaffer%40google.com.

The CI run is here:
https://github.com/nasamuffin/git/actions/runs/1423475715

It shows a broken (pedantic,fedora) test, but those are known broken:
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2111040007170.56%40tvgsbejvaqbjf.bet

[v4 cover letter]
Since v3, a pretty major change: the semantics of
submodule.superprojectGitDir has changed, to point from the submodule's
gitdir to the superproject's gitdir (in v3 and earlier, we kept a path
from the submodule's *worktree* to the superproject's gitdir instead).
This cleans up some of the confusions about the behavior when a
submodule worktree moves around in the superproject's tree, or in a
future when we support submodules having multiple worktrees.

I also tried to simplify the tests to use 'test-tool path-utils
relative_path' everywhere - I think that makes them much more clear for
a test reader, but if you're reviewing and it isn't obvious what we're
testing for, please speak up.

I think this is pretty mature and there was a lot of general agreement
that the gitdir->gitdir association was the way to go, so please be
brutal and look for nits, leaks, etc. this round ;)
[/v4 cover letter]

Since v4:

The only real change here is a slight semantics change to map from
<submodule gitdir> to <superproject common git dir>. In every case
*except* for when the superproject has a worktree, this changes nothing.
For the case when the superproject has a worktree, this means that now
submodules will refer to the general superproject common dir (e.g. no
worktree-specific refs or configs or whatnot).

I *think* that because a submodule should exist in the context of the
common dir, not the worktree gitdir, that is ok. However, it does mean
it would be difficult to do something like sharing a config specific to
the worktree (the initial goal of this series).

$ROOT/.git
$ROOT/.git/config.superproject <- shared by $ROOT/.git/modules/sub
$ROOT/.git/modules/sub <- points to $ROOT/.git
$ROOT/.git/worktrees/wt
$ROOT/.git/worktrees/wt/config.superproject <- contains a certain config-based pre-commit hook

If the submodule only knows about the common dir, that is tough, because
the submodule would basically have to guess which worktree it's in from
its own path. There would be no way for '$WT/sub' to inherit
'$ROOT/.git/worktrees/wt/config.superproject'.

That said... right now, we don't support submodules in worktrees very
well at all. A submodule in a worktree will get a brand new gitdir in
$ROOT/.git/worktrees/modules/ (and that brand new gitdir would point to
the super's common dir). So I think we can punt on this entire question
until we teach submodules and worktrees to play more gracefully together
(it's on my long list...), and at that time we can probably introduce a
pointer from $ROOT/.git/modules/sub/worktrees/wt/ to
$ROOT/.git/worktrees/wt/....

Or, to summarize the long ramble above: "this is still kind of weird
with worktrees, but let's fix it later when we fix worktrees more
thoroughly".

(More rambling about worktree weirdness here:
https://lore.kernel.org/git/YYRaII8YWVxlBqsF%40google.com )

 - Emily

Emily Shaffer (4):
  t7400-submodule-basic: modernize inspect() helper
  introduce submodule.superprojectGitDir record
  submodule: record superproject gitdir during absorbgitdirs
  submodule: record superproject gitdir during 'update'

 Documentation/config/submodule.txt | 12 +++++++
 builtin/submodule--helper.c        |  4 +++
 git-submodule.sh                   | 14 ++++++++
 submodule.c                        |  9 +++++
 t/t7400-submodule-basic.sh         | 54 ++++++++++++++++--------------
 t/t7406-submodule-update.sh        | 12 +++++++
 t/t7412-submodule-absorbgitdirs.sh | 50 +++++++++++++++++++++++++--
 7 files changed, 128 insertions(+), 27 deletions(-)

Range-diff against v4:
1:  2ff151aaa2 = 1:  6ff10beaf2 t7400-submodule-basic: modernize inspect() helper
2:  ed5479ad5d ! 2:  d4f4627585 introduce submodule.superprojectGitDir record
    @@ Commit message
         superproject directory around on the filesystem without breaking the
         submodule's cache. And by using the path from gitdir to gitdir, we can
         move the submodule within the superproject's tree structure without
    -    breaking the submodule's cache, too.
    +    breaking the submodule's cache, too. Finally, by pointing at
    +    "get_git_common_dir()" instead of "get_git_dir()", we ensure the link
    +    will refer to the parent repo, not to a specific worktree.
     
         Since this hint value is only introduced during new submodule creation
         via `git submodule add`, though, there is more work to do to allow the
    @@ Documentation/config/submodule.txt: submodule.alternateErrorStrategy::
     +
     +submodule.superprojectGitDir::
     +	The relative path from the submodule's gitdir to its superproject's
    -+	gitdir. When Git is run in a repository, it usually makes no difference
    -+	whether this repository is standalone or a submodule, but if this
    -+	configuration variable is present, additional behavior may be possible,
    -+	such as "git status" printing additional information about this
    -+	submodule's status with respect to its superproject. This config should
    -+	only be present in projects which are submodules, but is not guaranteed
    -+	to be present in every submodule, so only optional value-added behavior
    -+	should be linked to it. It is set automatically during
    -+	submodule creation.
    ++	common dir. When Git is run in a repository, it usually makes no
    ++	difference whether this repository is standalone or a submodule, but if
    ++	this configuration variable is present, additional behavior may be
    ++	possible, such as "git status" printing additional information about
    ++	this submodule's status with respect to its superproject. This config
    ++	should only be present in projects which are submodules, but is not
    ++	guaranteed to be present in every submodule, so only optional
    ++	value-added behavior should be linked to it. It is set automatically
    ++	during submodule creation.
     
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: static int clone_submodule(struct module_clone_data *clone_data)
    @@ builtin/submodule--helper.c: static int clone_submodule(struct module_clone_data
      				       error_strategy);
      
     +	git_config_set_in_file(p, "submodule.superprojectGitdir",
    -+			       relative_path(absolute_path(get_git_dir()),
    ++			       relative_path(absolute_path(get_git_common_dir()),
     +					     sm_gitdir, &sb));
     +
      	free(sm_alternate);
    @@ t/t7400-submodule-basic.sh: submodurl=$(pwd -P)
     +	# Ensure that submodule.superprojectGitDir contains the path from the
     +	# submodule's gitdir to the superproject's gitdir.
     +
    -+	super_abs_gitdir=$(git -C "$super_dir" rev-parse --absolute-git-dir) &&
    -+	sub_abs_gitdir=$(git -C "$sub_dir" rev-parse --absolute-git-dir) &&
    ++	super_abs_gitdir=$(git -C "$super_dir" rev-parse --path-format=absolute --git-common-dir) &&
    ++	sub_abs_gitdir=$(git -C "$sub_dir" rev-parse --path-format=absolute --git-common-dir) &&
     +
     +	[ "$(git -C "$sub_dir" config --get submodule.superprojectGitDir)" = \
     +	  "$(test-tool path-utils relative_path "$super_abs_gitdir" \
3:  60e6cf77c5 ! 3:  2dae297943 submodule: record superproject gitdir during absorbgitdirs
    @@ Commit message
         Already during 'git submodule add' we record a pointer to the
         superproject's gitdir. However, this doesn't help brand-new
         submodules created with 'git init' and later absorbed with 'git
    -    submodule absorbgitdir'. Let's start adding that pointer during 'git
    -    submodule absorbgitdir' too.
    +    submodule absorbgitdirs'. Let's start adding that pointer during 'git
    +    submodule absorbgitdirs' too.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
     
    @@ submodule.c: static void relocate_single_git_dir_into_superproject(const char *p
      	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
      
     +	/* cache pointer to superproject's gitdir */
    -+	/* NEEDSWORK: this may differ if experimental.worktreeConfig is enabled */
     +	strbuf_addf(&config_path, "%s/config", real_new_git_dir);
     +	git_config_set_in_file(config_path.buf, "submodule.superprojectGitdir",
    -+			       relative_path(absolute_path(get_git_dir()),
    ++			       relative_path(absolute_path(get_git_common_dir()),
     +					     real_new_git_dir, &sb));
     +
     +	strbuf_release(&config_path);
    @@ t/t7412-submodule-absorbgitdirs.sh: test_expect_success 'absorb the git dir' '
     +	test_cmp expect.2 actual.2 &&
     +
     +	# make sure the submodule cached the superproject gitdir correctly
    -+	submodule_gitdir="$(git -C sub1 rev-parse --absolute-git-dir)" &&
    -+	superproject_gitdir="$(git rev-parse --absolute-git-dir)" &&
    ++	submodule_gitdir="$(git -C sub1 rev-parse --path-format=absolute --git-common-dir)" &&
    ++	superproject_gitdir="$(git rev-parse --path-format=absolute --git-common-dir)" &&
     +
     +	test-tool path-utils relative_path "$superproject_gitdir" \
     +		"$submodule_gitdir" >expect &&
    @@ t/t7412-submodule-absorbgitdirs.sh: test_expect_success 'absorb the git dir in a
     -	test_cmp expect.2 actual.2
     +	test_cmp expect.2 actual.2 &&
     +
    -+	sub1_gitdir="$(git -C sub1 rev-parse --absolute-git-dir)" &&
    -+	sub1_nested_gitdir="$(git -C sub1/nested rev-parse --absolute-git-dir)" &&
    ++	sub1_gitdir="$(git -C sub1 rev-parse --path-format=absolute --git-common-dir)" &&
    ++	sub1_nested_gitdir="$(git -C sub1/nested rev-parse --path-format=absolute --git-common-dir)" &&
     +
     +	test-tool path-utils relative_path "$sub1_gitdir" "$sub1_nested_gitdir" \
     +		>expect &&
    @@ t/t7412-submodule-absorbgitdirs.sh: test_expect_success 'absorb the git dir in a
      '
      
      test_expect_success 're-setup nested submodule' '
    +@@ t/t7412-submodule-absorbgitdirs.sh: test_expect_success 'absorbing fails for a submodule with multiple worktrees' '
    + 	test_i18ngrep "not supported" error
    + '
    + 
    ++test_expect_success 'absorbgitdirs works when called from a superproject worktree' '
    ++	# set up a worktree of the superproject
    ++	git worktree add wt &&
    ++	(
    ++	cd wt &&
    ++
    ++	# create a new unembedded git dir
    ++	git init sub4 &&
    ++	test_commit -C sub4 first &&
    ++	git submodule add ./sub4 &&
    ++	test_tick &&
    ++
    ++	# absorb the git dir
    ++	git submodule absorbgitdirs sub4 &&
    ++
    ++	# make sure the submodule cached the superproject gitdir correctly
    ++	submodule_gitdir="$(git -C sub4 rev-parse --path-format=absolute --git-common-dir)" &&
    ++	superproject_gitdir="$(git rev-parse --path-format=absolute --git-common-dir)" &&
    ++
    ++	test-tool path-utils relative_path "$superproject_gitdir" \
    ++		"$submodule_gitdir" >expect &&
    ++	git -C sub4 config submodule.superprojectGitDir >actual &&
    ++
    ++	test_cmp expect actual
    ++	)
    ++'
    ++
    + test_done
4:  df9879ff93 ! 4:  f0412d6d34 submodule: record superproject gitdir during 'update'
    @@ git-submodule.sh: cmd_update()
      			;;
      		esac
      
    -+		# Cache a pointer to the superproject's gitdir. This may have
    ++		# Cache a pointer to the superproject's common dir. This may have
     +		# changed, unless it's a fresh clone. Writes it to worktree
     +		# if applicable, otherwise to local.
     +		if test -z "$just_cloned"
    @@ git-submodule.sh: cmd_update()
     +			sm_gitdir="$(git -C "$sm_path" rev-parse --absolute-git-dir)"
     +			relative_gitdir="$(git rev-parse --path-format=relative \
     +							 --prefix "${sm_gitdir}" \
    -+							 --git-dir)"
    ++							 --git-common-dir)"
     +
     +			git -C "$sm_path" config --worktree \
     +				submodule.superprojectgitdir "$relative_gitdir"
    @@ t/t7406-submodule-update.sh: test_expect_success 'submodule update --quiet passe
     +	 git -C submodule config --unset submodule.superprojectGitdir &&
     +	 git submodule update &&
     +	 test-tool path-utils relative_path \
    -+		"$(git rev-parse --absolute-git-dir)" \
    -+		"$(git -C submodule rev-parse --absolute-git-dir)" >expect &&
    ++		"$(git rev-parse --path-format=absolute --git-common-dir)" \
    ++		"$(git -C submodule rev-parse --path-format=absolute --git-common-dir)" >expect &&
     +	 git -C submodule config submodule.superprojectGitdir >actual &&
     +	 test_cmp expect actual
     +	)
-- 
2.34.0.rc0.344.g81b53c2807-goog

