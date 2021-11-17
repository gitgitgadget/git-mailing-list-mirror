Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1578CC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 00:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E317D61BFA
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 00:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhKQBAG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 20:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhKQBAF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 20:00:05 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985E6C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 16:57:07 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id f16-20020a170902ce9000b001436ba39b2bso281002plg.3
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 16:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=bSGt3pFoNxzf3WAaQz2V2wHnVbk4g9ZVAKViCb1sJAg=;
        b=mw1q2SnL02+HAI107xeIGI7QLgkMMudvor69JqKrIaYglHQEtQ1I60cX2Ct/g2oKKy
         akdFEd8cNyHv+SQfY3qsG8AuyufyF6PS26Z6MAVLbWt84t+oEbM1BmPFwNmHV37ZmfjA
         AmAhSku2unMxtebLt/vVuYHyiftYe1+eunDDUuSfRMbbPOLLooacHQuLECH0TZrFf598
         Fg3jIw0xn5rE8Tdu/bZRVCZDP2CLtQ6nnrDozXg6lizMd5H1U8IGLtC4VLjzR7puocE/
         G3kWXBaJEfH+zNo4M0eJ+w+cSzSa6udgEJ+qsX13uKP8vc4FsbmPUZYFQ11qnfOY+plc
         glmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=bSGt3pFoNxzf3WAaQz2V2wHnVbk4g9ZVAKViCb1sJAg=;
        b=cBSIGOghfO9OXNUuL/xW3JvpKeWh/rWiEGkV2sct3KpNF8Oc24+CHw7QSGQQ6dgmgQ
         H29yq8Zjxc6W2NeNzSvCOwsJvxknwjr/CnQhWjcwx0C1FDewAmhYCJ5/pKP4diowpnB9
         5lrAiE8DKN/KML+fm1EDp6YdDm81jA4TJVUzNQ+O5lL9+I6cVXRZu+U8qK3UtMDJ+78l
         I85mc129867dEjEbhDmyVd1ObvI2v5Y4Zy2XFW25A4rri3jm5BT5fGMJXHvhn0NJLBNW
         9wdLfZH+K0QJY0pDIip78cT3JhJ9xbkbADgGVSJzznI0kS6lgXRXdNB2Qrb3hZOAv5uU
         CSdQ==
X-Gm-Message-State: AOAM530/Cnsoe5EYBAaG18hkZv4EGg+w7sx9CYOoCk4/UGWPevjmEDLK
        pZn/diEBarFqHXg/CSMGaRBm+05HjTLTNV8gBtnMROA6butq5bOdxctX8u0blTElo5EDAYtJlMT
        sLEKFz5QzySCKtBJqgzHyILQpdD73l2p09JgHFPjN9oPAQBuyB/SDA8vdp+os90/Uq+Z+DZgApA
        ==
X-Google-Smtp-Source: ABdhPJyzg7V11BL0yivf/W7bC//DLUZ3+gZIB/hLhM3Woy/WOARdDEE6EHMHWbhn4LmZGH2vv5zGp1FsmtJxcPJWr7I=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:205d:7edd:a3da:3608])
 (user=emilyshaffer job=sendgmr) by 2002:a17:90b:1a87:: with SMTP id
 ng7mr4266434pjb.230.1637110626417; Tue, 16 Nov 2021 16:57:06 -0800 (PST)
Date:   Tue, 16 Nov 2021 16:56:56 -0800
Message-Id: <20211117005701.371808-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v6 0/5] teach submodules to know they're submodules
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For the original cover letter, see
https://lore.kernel.org/git/20210611225428.1208973-1-emilyshaffer%40google.=
com.

CI run: https://github.com/nasamuffin/git/actions/runs/1469463328

Since v5:

A couple things. Firstly, a semantics change *back* to the semantics of
v3 - we map from gitdir to gitdir, *not* from common dir to common dir,
so that theoretically a submodule with multiple worktrees in multiple
superproject worktrees will be able to figure out which worktree of the
superproject it's in. (Realistically, that's not really possible right
now, but I'd like to change that soon.)

Secondly, a rewording of comments and commit messages to indicate that
this isn't a cache of some expensive operation, but rather intended to
be the source of truth for all submodules. I also added a fifth commit
rewriting `git rev-parse --show-superproject-working-tree` to
demonstrate what that means in practice - but from a practical
standpoint, I'm a little worried about that fifth patch. More details in
the patch 5 description.

I did discuss =C3=86var's idea of relying on in-process filesystem digging =
to
find the superproject's gitdir with the rest of the Google team, but in
the end decided that there are some worries about filesystem digging in
this way (namely, some ugly interactions with network drives that are
actually already an issue for Googler Linux machines). Plus, the allure
of being able to definitively know that we're a submodule is pretty
strong. ;) But overall, this is the direction I'd prefer to keep going
in, rather than trying to guess from the filesystem going forward.

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
$ROOT/.git/worktrees/wt/config.superproject <- contains a certain config-ba=
sed pre-commit hook

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

Emily Shaffer (5):
  t7400-submodule-basic: modernize inspect() helper
  introduce submodule.superprojectGitDir record
  submodule: record superproject gitdir during absorbgitdirs
  submodule: record superproject gitdir during 'update'
  submodule: use config to find superproject worktree

 Documentation/config/submodule.txt |  12 ++++
 builtin/submodule--helper.c        |  11 +++
 git-submodule.sh                   |  15 ++++
 submodule.c                        | 108 ++++++++++++++++++++++++++++-
 t/t1500-rev-parse.sh               |   9 +++
 t/t7400-submodule-basic.sh         |  54 ++++++++-------
 t/t7406-submodule-update.sh        |  27 ++++++++
 t/t7412-submodule-absorbgitdirs.sh |  82 +++++++++++++++++++++-
 8 files changed, 290 insertions(+), 28 deletions(-)

Range-diff against v5:
1:  6ff10beaf2 =3D 1:  f1b08a7057 t7400-submodule-basic: modernize inspect(=
) helper
2:  d4f4627585 ! 2:  d46c8439ab introduce submodule.superprojectGitDir reco=
rd
    @@ Commit message
    =20
         By using a relative path instead of an absolute path, we can move =
the
         superproject directory around on the filesystem without breaking t=
he
    -    submodule's cache. And by using the path from gitdir to gitdir, we=
 can
    +    submodule's pointer. And by using the path from gitdir to gitdir, =
we can
         move the submodule within the superproject's tree structure withou=
t
    -    breaking the submodule's cache, too. Finally, by pointing at
    -    "get_git_common_dir()" instead of "get_git_dir()", we ensure the l=
ink
    -    will refer to the parent repo, not to a specific worktree.
    +    breaking the submodule's pointer, too. Finally, by pointing at the
    +    superproject's worktree gitdir (if it exists), we ensure that we c=
an
    +    tell which worktree contains our submodule.
    =20
         Since this hint value is only introduced during new submodule crea=
tion
         via `git submodule add`, though, there is more work to do to allow=
 the
         record to be created at other times.
    =20
    -    If the new config is present, we can do some optional value-added
    -    behavior, like letting "git status" print additional info about th=
e
    -    submodule's status in relation to its superproject, or like lettin=
g the
    -    superproject and submodule share an additional config file separat=
e from
    -    either one's local config.
    +    Once this new config is reliably in place, we can use it to know
    +    definitively that we are working in a submodule, and to know which
    +    superproject we are a submodule of. This allows us to do some
    +    value-added behavior, like letting "git status" print additional i=
nfo
    +    about the submodule's status in relation to its superproject, or l=
ike
    +    letting the superproject and submodule share an additional config =
file
    +    separate from either one's local config.
    =20
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Helped-by: Junio C Hamano <gitster@pobox.com>
    @@ Documentation/config/submodule.txt: submodule.alternateErrorStrategy=
::
     +
     +submodule.superprojectGitDir::
     +	The relative path from the submodule's gitdir to its superproject's
    -+	common dir. When Git is run in a repository, it usually makes no
    ++	gitdir. When Git is run in a repository, it usually makes no
     +	difference whether this repository is standalone or a submodule, but=
 if
     +	this configuration variable is present, additional behavior may be
     +	possible, such as "git status" printing additional information about
    @@ builtin/submodule--helper.c: static int clone_submodule(struct modul=
e_clone_data
      		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
      				       error_strategy);
     =20
    -+	git_config_set_in_file(p, "submodule.superprojectGitdir",
    -+			       relative_path(absolute_path(get_git_common_dir()),
    ++	/*
    ++	 * Set the path from submodule's new gitdir to superproject's gitdir=
.
    ++	 * The latter may be a worktree gitdir. However, it is not possible =
for
    ++	 * the submodule to have a worktree-specific gitdir or config at clo=
ne
    ++	 * time, because "extensions.worktreeConfig" is only valid when set =
in
    ++	 * the local gitconfig, which the brand new submodule does not have =
yet.
    ++	 */
    ++	git_config_set_in_file(p, "submodule.superprojectGitDir",
    ++			       relative_path(absolute_path(get_git_dir()),
     +					     sm_gitdir, &sb));
     +
      	free(sm_alternate);
    @@ t/t7400-submodule-basic.sh: submodurl=3D$(pwd -P)
     +	# Ensure that submodule.superprojectGitDir contains the path from th=
e
     +	# submodule's gitdir to the superproject's gitdir.
     +
    -+	super_abs_gitdir=3D$(git -C "$super_dir" rev-parse --path-format=3Da=
bsolute --git-common-dir) &&
    -+	sub_abs_gitdir=3D$(git -C "$sub_dir" rev-parse --path-format=3Dabsol=
ute --git-common-dir) &&
    ++	super_abs_gitdir=3D$(git -C "$super_dir" rev-parse --absolute-git-di=
r) &&
    ++	sub_abs_gitdir=3D$(git -C "$sub_dir" rev-parse --absolute-git-dir) &=
&
     +
     +	[ "$(git -C "$sub_dir" config --get submodule.superprojectGitDir)" =
=3D \
     +	  "$(test-tool path-utils relative_path "$super_abs_gitdir" \
3:  2dae297943 ! 3:  63ddaf5608 submodule: record superproject gitdir durin=
g absorbgitdirs
    @@ submodule.c: static void relocate_single_git_dir_into_superproject(c=
onst char *p
      	char *old_git_dir =3D NULL, *real_old_git_dir =3D NULL, *real_new_gi=
t_dir =3D NULL;
      	struct strbuf new_gitdir =3D STRBUF_INIT;
      	const struct submodule *sub;
    ++	struct config_set sub_cs;
     +	struct strbuf config_path =3D STRBUF_INIT, sb =3D STRBUF_INIT;
    ++	int tmp;
     =20
      	if (submodule_uses_worktrees(path))
      		die(_("relocate_gitdir for submodule '%s' with "
    @@ submodule.c: static void relocate_single_git_dir_into_superproject(c=
onst char *p
     =20
      	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
     =20
    -+	/* cache pointer to superproject's gitdir */
    ++	/*
    ++	 * Note location of superproject's gitdir. Because the submodule alr=
eady
    ++	 * has a gitdir and local config, we can store this pointer from
    ++	 * worktree config to worktree config, if the submodule has
    ++	 * extensions.worktreeConfig set.
    ++	 */
     +	strbuf_addf(&config_path, "%s/config", real_new_git_dir);
    ++	git_configset_init(&sub_cs);
    ++	git_configset_add_file(&sub_cs, config_path.buf);
    ++	/* return 0 indicates config was found - we have a worktree config *=
/
    ++	if (!git_configset_get_bool(&sub_cs, "extensions.worktreeConfig", &t=
mp))
    ++		strbuf_addstr(&config_path, ".worktree");
    ++
     +	git_config_set_in_file(config_path.buf, "submodule.superprojectGitdi=
r",
    -+			       relative_path(absolute_path(get_git_common_dir()),
    ++			       relative_path(absolute_path(get_git_dir()),
     +					     real_new_git_dir, &sb));
     +
    ++	git_configset_clear(&sub_cs);
     +	strbuf_release(&config_path);
     +	strbuf_release(&sb);
      	free(old_git_dir);
    @@ t/t7412-submodule-absorbgitdirs.sh: test_expect_success 'absorbing f=
ails for a s
     +	# absorb the git dir
     +	git submodule absorbgitdirs sub4 &&
     +
    -+	# make sure the submodule cached the superproject gitdir correctly
    -+	submodule_gitdir=3D"$(git -C sub4 rev-parse --path-format=3Dabsolute=
 --git-common-dir)" &&
    -+	superproject_gitdir=3D"$(git rev-parse --path-format=3Dabsolute --gi=
t-common-dir)" &&
    ++	# make sure the submodule noted the superproject gitdir correctly
    ++	submodule_gitdir=3D"$(git -C sub4 rev-parse --absolute-git-dir)" &&
    ++	superproject_gitdir=3D"$(git rev-parse --absolute-git-dir)" &&
     +
     +	test-tool path-utils relative_path "$superproject_gitdir" \
     +		"$submodule_gitdir" >expect &&
    @@ t/t7412-submodule-absorbgitdirs.sh: test_expect_success 'absorbing f=
ails for a s
     +	test_cmp expect actual
     +	)
     +'
    ++
    ++test_expect_success 'absorbgitdirs works with a submodule with worktr=
ee config' '
    ++	# reuse the worktree of the superproject
    ++	(
    ++	cd wt &&
    ++
    ++	# create a new unembedded git dir
    ++	git init sub5 &&
    ++	test_commit -C sub5 first &&
    ++	git submodule add ./sub5 &&
    ++	test_tick &&
    ++
    ++	# turn on worktree configs for submodule
    ++	git -C sub5 config extensions.worktreeConfig true &&
    ++
    ++	# absorb the git dir
    ++	git submodule absorbgitdirs sub5 &&
    ++
    ++	# make sure the submodule noted the superproject gitdir correctly
    ++	submodule_gitdir=3D"$(git -C sub5 rev-parse --absolute-git-dir)" &&
    ++	superproject_gitdir=3D"$(git rev-parse --absolute-git-dir)" &&
    ++
    ++	test-tool path-utils relative_path "$superproject_gitdir" \
    ++		"$submodule_gitdir" >expect &&
    ++	git -C sub5 config submodule.superprojectGitDir >actual &&
    ++
    ++	test_cmp expect actual &&
    ++
    ++	# make sure the config went into the submodule config.worktree
    ++	test_file_not_empty "$submodule_gitdir/config.worktree"
    ++	)
    ++'
     +
      test_done
4:  f0412d6d34 ! 4:  33a582ef13 submodule: record superproject gitdir durin=
g 'update'
    @@ Metadata
      ## Commit message ##
         submodule: record superproject gitdir during 'update'
    =20
    -    A recorded hint path to the superproject's gitdir might be added d=
uring
    +    A recorded path to the superproject's gitdir might be added during
         'git submodule add', but in some cases - like submodules which wer=
e
         created before 'git submodule add' learned to record that info - i=
t might
         be useful to update the hint. Let's do it during 'git submodule
    @@ git-submodule.sh: cmd_update()
      			;;
      		esac
     =20
    -+		# Cache a pointer to the superproject's common dir. This may have
    -+		# changed, unless it's a fresh clone. Writes it to worktree
    -+		# if applicable, otherwise to local.
    ++		# Store a poitner to the superproject's gitdir. This may have
    ++		# changed, unless it's a fresh clone. Write to worktree if
    ++		# applicable, and point to superproject's worktree gitdir if
    ++		# applicable.
     +		if test -z "$just_cloned"
     +		then
     +			sm_gitdir=3D"$(git -C "$sm_path" rev-parse --absolute-git-dir)"
     +			relative_gitdir=3D"$(git rev-parse --path-format=3Drelative \
     +							 --prefix "${sm_gitdir}" \
    -+							 --git-common-dir)"
    ++							 --git-dir)"
     +
     +			git -C "$sm_path" config --worktree \
     +				submodule.superprojectgitdir "$relative_gitdir"
    @@ t/t7406-submodule-update.sh: test_expect_success 'submodule update -=
-quiet passe
     +	 git -C submodule config --unset submodule.superprojectGitdir &&
     +	 git submodule update &&
     +	 test-tool path-utils relative_path \
    -+		"$(git rev-parse --path-format=3Dabsolute --git-common-dir)" \
    -+		"$(git -C submodule rev-parse --path-format=3Dabsolute --git-common=
-dir)" >expect &&
    ++		"$(git rev-parse --absolute-git-dir)" \
    ++		"$(git -C submodule rev-parse --absolute-git-dir)" >expect &&
     +	 git -C submodule config submodule.superprojectGitdir >actual &&
     +	 test_cmp expect actual
     +	)
     +'
    ++
    ++test_expect_success 'submodule update uses config.worktree if applica=
ble' '
    ++	(cd super &&
    ++	 git -C submodule config --unset submodule.superprojectGitDir &&
    ++	 git -C submodule config extensions.worktreeConfig true &&
    ++	 git submodule update &&
    ++	 test-tool path-utils relative_path \
    ++		"$(git rev-parse --absolute-git-dir)" \
    ++		"$(git -C submodule rev-parse --absolute-git-dir)" >expect &&
    ++	 git -C submodule config submodule.superprojectGitdir >actual &&
    ++	 test_cmp expect actual &&
    ++
    ++	 test_file_not_empty "$(git -C submodule rev-parse --absolute-git-di=
r)/config.worktree"
    ++	)
    ++'
     +
      test_done
-:  ---------- > 5:  a8b5d40a77 submodule: use config to find superproject =
worktree
--=20
2.34.0.rc1.387.gb447b232ab-goog

