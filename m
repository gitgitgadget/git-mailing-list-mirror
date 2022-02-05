Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83517C433F5
	for <git@archiver.kernel.org>; Sat,  5 Feb 2022 00:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354386AbiBEAk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 19:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiBEAk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 19:40:26 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3D8DF8E3CE
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 16:40:20 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d65-20020a256844000000b00614359972a6so16183862ybc.16
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 16:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=YF+v4PUAtjsM3WKL4BINH7x7UOtNCN46xTWkg4Rcmws=;
        b=GcqFpAN8VcdLsP3Vu/r5UTrKVcoEHB+yz+uiY5WYyn8e+qJV1O72w1bBODH8xSpYd1
         4GnL+ARJuF10YXLJoz19DfUXacjeKUKX9E/37af3VlpgqqpUBFY7hg/6qxjeDkBmljT4
         72UYruLEiMtS08kOyuMOpSnVLrVFEBG71g2FJgcUoLEY9faEO8vznFfvS/iskyylaCgm
         cTqFJf7L1XCgSVaFaW//JUvMKNIDrIHFqRZFlhgx1gF1uAO7lnkhSe96GyJQtCA8S5ug
         0+Mw7xerxKe3TYsL3KolnWje1wXfEp7jM2/5+CDSR7Ch0HP1dgwVEk+uANfyshMZArLG
         XCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=YF+v4PUAtjsM3WKL4BINH7x7UOtNCN46xTWkg4Rcmws=;
        b=jxV/Cj2TKMHqN+NpJMaCehQ+h4gHhE8prpWLf7Y7wxE4sbnOgUhxafHkjcfR21bW23
         lf8JbM1P3dFVh+Qz/wETbEMx1SHThUuMk8GaXxCAsggeKsz6bzCD2bwpQHtDDkudsl3O
         LQS7YZVisrYiIWO9hCTADANfRGFGiraJ9/ls3h2VDdS9gX7RDaCONFQ3/FYCexFg5V3x
         zGtrld6iVCg8Bo3jYrR+O6Nldj+ZmL9VQferqqX3Y/okXrvMDoxtSLNNCVwcge89wWxX
         /FccMabpnK+zIiVzc20W7UxA3Dqhbr3p0Pyk+orytzfTkzFII7m2XQ68W5FdGg4JaOU9
         K/Iw==
X-Gm-Message-State: AOAM532Dk8Dw+UXh8OruLYSRr6WgU+IDFujjg+wOxi0rzQmqLCTwSUmv
        3i+7h1SOSGL6JxDPqVYhbmeJK01Ts8NyMsh3M3FbVKYG4eH6GtGFZ90uoM6KxhLnNnC2EsyniCb
        NbwlueEcRAOWtMbIqCesVHy5B03JjxwDjhI7LvMp2tXuEKr5cPS8Di6Vfgv7KEI4=
X-Google-Smtp-Source: ABdhPJyEZS3fMOb+L9JlkMT4FBBsUc5bn89xy3YQ7IPtsq+MchFguCWrScggXKzOba+blhPadVRba45WD1OZyA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:8562:eb15:bb84:ce64])
 (user=steadmon job=sendgmr) by 2002:a0d:c7c2:: with SMTP id
 j185mr1601110ywd.105.1644021620150; Fri, 04 Feb 2022 16:40:20 -0800 (PST)
Date:   Fri,  4 Feb 2022 16:40:18 -0800
In-Reply-To: <50ebf7bd39adf34fa4ada27cd433d81b5381abe5.1642735881.git.steadmon@google.com>
Message-Id: <8678e721c2ddd785e866df972af734e422b95039.1644021221.git.steadmon@google.com>
Mime-Version: 1.0
References: <50ebf7bd39adf34fa4ada27cd433d81b5381abe5.1642735881.git.steadmon@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v2] clone, submodule: pass partial clone filters to submodules
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cloning a repo with a --filter and with --recurse-submodules
enabled, the partial clone filter only applies to the top-level repo.
This can lead to unexpected bandwidth and disk usage for projects which
include large submodules. For example, a user might wish to make a
partial clone of Gerrit and would run:
`git clone --recurse-submodules --filter=3Dblob:5k https://gerrit.googlesou=
rce.com/gerrit`.
However, only the superproject would be a partial clone; all the
submodules would have all blobs downloaded regardless of their size.
With this change, the same filter can also be applied to submodules,
meaning the expected bandwidth and disk savings apply consistently.

To avoid changing default behavior, add a new clone flag,
`--also-filter-submodules`. When this is set along with `--filter` and
`--recurse-submodules`, the filter spec is passed along to git-submodule
and git-submodule--helper, such that submodule clones also have the
filter applied.

This applies the same filter to the superproject and all submodules.
Users who need to customize the filter per-submodule would need to clone
with `--no-recurse-submodules` and then manually initialize each
submodule with the proper filter.

Applying filters to submodules should be safe thanks to Jonathan Tan's
recent work [1, 2, 3] eliminating the use of alternates as a method of
accessing submodule objects, so any submodule object access now triggers
a lazy fetch from the submodule's promisor remote if the accessed object
is missing. This patch is a reworked version of [4], which was created
prior to Jonathan Tan's work.

[1]: 8721e2e (Merge branch 'jt/partial-clone-submodule-1', 2021-07-16)
[2]: 11e5d0a (Merge branch 'jt/grep-wo-submodule-odb-as-alternate',
	2021-09-20)
[3]: 162a13b (Merge branch 'jt/no-abuse-alternate-odb-for-submodules',
	2021-10-25)
[4]: https://lore.kernel.org/git/52bf9d45b8e2b72ff32aa773f2415bf7b2b86da2.1=
563322192.git.steadmon@google.com/

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
Changes since V2:
* Fixed a shell-quoting issue in git-submodule.sh
* Added a new clone flag (--also-filter-submodules) and config
  (clone.filterSubmodules) so that the default behavior remains the
  same, but users who want this option generally can set-and-forget it
  in their global config.

Range-diff against v1:
1:  50ebf7bd39 ! 1:  8678e721c2 clone, submodule: pass partial clone filter=
s to submodules
    @@ Commit message
         clone, submodule: pass partial clone filters to submodules
    =20
         When cloning a repo with a --filter and with --recurse-submodules
    -    enabled, the partial clone filter only applies to
    -    the top-level repo. This can lead to unexpected bandwidth and disk
    -    usage for projects which include large submodules. For example, a =
user
    -    might wish to make a partial clone of Gerrit and would run:
    -    `git clone --recurse-submodules --filter=3Dblob:5k
    -    https://gerrit.googlesource.com/gerrit`. However, only the superpr=
oject
    -    would be a partial clone; all the submodules would have all blobs
    -    downloaded regardless of their size. With this change, the same fi=
lter
    -    applies to submodules, meaning the expected bandwidth and disk sav=
ings
    -    apply consistently.
    +    enabled, the partial clone filter only applies to the top-level re=
po.
    +    This can lead to unexpected bandwidth and disk usage for projects =
which
    +    include large submodules. For example, a user might wish to make a
    +    partial clone of Gerrit and would run:
    +    `git clone --recurse-submodules --filter=3Dblob:5k https://gerrit.=
googlesource.com/gerrit`.
    +    However, only the superproject would be a partial clone; all the
    +    submodules would have all blobs downloaded regardless of their siz=
e.
    +    With this change, the same filter can also be applied to submodule=
s,
    +    meaning the expected bandwidth and disk savings apply consistently=
.
    =20
    -    Plumb the --filter argument from git-clone through git-submodule a=
nd
    -    git-submodule--helper, such that submodule clones also have the fi=
lter
    -    applied.
    +    To avoid changing default behavior, add a new clone flag,
    +    `--also-filter-submodules`. When this is set along with `--filter`=
 and
    +    `--recurse-submodules`, the filter spec is passed along to git-sub=
module
    +    and git-submodule--helper, such that submodule clones also have th=
e
    +    filter applied.
    =20
         This applies the same filter to the superproject and all submodule=
s.
    -    Users who prefer the current behavior (i.e., a filter only on the
    -    superproject) would need to clone with `--no-recurse-submodules` a=
nd
    -    then manually initialize each submodule.
    +    Users who need to customize the filter per-submodule would need to=
 clone
    +    with `--no-recurse-submodules` and then manually initialize each
    +    submodule with the proper filter.
    =20
         Applying filters to submodules should be safe thanks to Jonathan T=
an's
         recent work [1, 2, 3] eliminating the use of alternates as a metho=
d of
    @@ Commit message
    =20
    =20
    + ## Documentation/config/clone.txt ##
    +@@ Documentation/config/clone.txt: clone.defaultRemoteName::
    + clone.rejectShallow::
    + 	Reject to clone a repository if it is a shallow one, can be overridd=
en by
    + 	passing option `--reject-shallow` in command line. See linkgit:git-c=
lone[1]
    ++
    ++clone.filterSubmodules::
    ++	If a partial clone filter is provided (see `--filter` in
    ++	linkgit:git-rev-list[1]) and `--recurse-submodules` is used, also ap=
ply
    ++	the filter to submodules.
    +
    + ## Documentation/git-clone.txt ##
    +@@ Documentation/git-clone.txt: SYNOPSIS
    + 	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
    + 	  [--recurse-submodules[=3D<pathspec>]] [--[no-]shallow-submodules]
    + 	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--[no-]reject-=
shallow]
    +-	  [--filter=3D<filter>] [--] <repository>
    ++	  [--filter=3D<filter> [--also-filter-submodules]] [--] <repository>
    + 	  [<directory>]
    +=20
    + DESCRIPTION
    +@@ Documentation/git-clone.txt: objects from the source repository int=
o a pack in the cloned repository.
    + 	at least `<size>`. For more details on filter specifications, see
    + 	the `--filter` option in linkgit:git-rev-list[1].
    +=20
    ++--also-filter-submodules::
    ++	Also apply the partial clone filter to any submodules in the reposit=
ory.
    ++	Requires `--filter` and `--recurse-submodules`. This can be turned o=
n by
    ++	default by setting the `clone.filterSubmodules` config option.
    ++
    + --mirror::
    + 	Set up a mirror of the source repository.  This implies `--bare`.
    + 	Compared to `--bare`, `--mirror` not only maps local branches of the
    +
    + ## Documentation/git-submodule.txt ##
    +@@ Documentation/git-submodule.txt: If you really want to remove a sub=
module from the repository and commit
    + that use linkgit:git-rm[1] instead. See linkgit:gitsubmodules[7] for =
removal
    + options.
    +=20
    +-update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow]=
 [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--d=
epth <depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--] [<path=
>...]::
    ++update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow]=
 [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--d=
epth <depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter <=
filter spec>] [--] [<path>...]::
    + +
    + --
    + Update the registered submodules to match what the superproject
    +@@ Documentation/git-submodule.txt: submodule with the `--init` option=
.
    +=20
    + If `--recursive` is specified, this command will recurse into the
    + registered submodules, and update any nested submodules within.
    ++
    ++If `--filter <filter spec>` is specified, the given partial clone fil=
ter will be
    ++applied to the submodule. See linkgit:git-rev-list[1] for details on =
filter
    ++specifications.
    + --
    + set-branch (-b|--branch) <branch> [--] <path>::
    + set-branch (-d|--default) [--] <path>::
    +
      ## builtin/clone.c ##
    +@@ builtin/clone.c: static int option_dissociate;
    + static int max_jobs =3D -1;
    + static struct string_list option_recurse_submodules =3D STRING_LIST_I=
NIT_NODUP;
    + static struct list_objects_filter_options filter_options;
    ++static int option_filter_submodules =3D -1;    /* unspecified */
    ++static int config_filter_submodules =3D -1;    /* unspecified */
    + static struct string_list server_options =3D STRING_LIST_INIT_NODUP;
    + static int option_remote_submodules;
    +=20
    +@@ builtin/clone.c: static struct option builtin_clone_options[] =3D {
    + 	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
    + 			TRANSPORT_FAMILY_IPV6),
    + 	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
    ++	OPT_BOOL(0, "also-filter-submodules", &option_filter_submodules,
    ++		    N_("apply partial clone filters to submodules")),
    + 	OPT_BOOL(0, "remote-submodules", &option_remote_submodules,
    + 		    N_("any cloned submodules will use their remote-tracking branch=
")),
    + 	OPT_BOOL(0, "sparse", &option_sparse_checkout,
    +@@ builtin/clone.c: static int git_sparse_checkout_init(const char *re=
po)
    + 	return result;
    + }
    +=20
    +-static int checkout(int submodule_progress)
    ++static int checkout(int submodule_progress, int filter_submodules)
    + {
    + 	struct object_id oid;
    + 	char *head;
     @@ builtin/clone.c: static int checkout(int submodule_progress)
      			strvec_push(&args, "--no-fetch");
      		}
     =20
    -+		if (filter_options.choice)
    ++		if (filter_submodules && filter_options.choice)
     +			strvec_pushf(&args, "--filter=3D%s",
     +				     expand_list_objects_filter_spec(&filter_options));
     +
      		if (option_single_branch >=3D 0)
      			strvec_push(&args, option_single_branch ?
      					       "--single-branch" :
    +@@ builtin/clone.c: static int git_clone_config(const char *k, const c=
har *v, void *cb)
    + 	}
    + 	if (!strcmp(k, "clone.rejectshallow"))
    + 		config_reject_shallow =3D git_config_bool(k, v);
    ++	if (!strcmp(k, "clone.filtersubmodules"))
    ++		config_filter_submodules =3D git_config_bool(k, v);
    +=20
    + 	return git_default_config(k, v, cb);
    + }
    +@@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const c=
har *prefix)
    + 	struct remote *remote;
    + 	int err =3D 0, complete_refs_before_fetch =3D 1;
    + 	int submodule_progress;
    ++	int filter_submodules =3D 0;
    +=20
    + 	struct transport_ls_refs_options transport_ls_refs_options =3D
    + 		TRANSPORT_LS_REFS_OPTIONS_INIT;
    +@@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const c=
har *prefix)
    + 	if (option_reject_shallow !=3D -1)
    + 		reject_shallow =3D option_reject_shallow;
    +=20
    ++	/*
    ++	 * If option_filter_submodules is specified from CLI option,
    ++	 * ignore config_filter_submodules from git_clone_config.
    ++	 */
    ++	if (config_filter_submodules !=3D -1)
    ++		filter_submodules =3D config_filter_submodules;
    ++	if (option_filter_submodules !=3D -1)
    ++		filter_submodules =3D option_filter_submodules;
    ++
    ++	/*
    ++	 * Exit if the user seems to be doing something silly with submodule
    ++	 * filter flags (but not with filter configs, as those should be
    ++	 * set-and-forget).
    ++	 */
    ++	if (option_filter_submodules > 0 && !filter_options.choice)
    ++		die(_("the option '%s' requires '%s'"),
    ++		    "--also-filter-submodules", "--filter");
    ++	if (option_filter_submodules > 0 && !option_recurse_submodules.nr)
    ++		die(_("the option '%s' requires '%s'"),
    ++		    "--also-filter-submodules", "--recurse-submodules");
    ++
    + 	/*
    + 	 * apply the remote name provided by --origin only after this second
    + 	 * call to git_config, to ensure it overrides all config-based value=
s.
    +@@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const c=
har *prefix)
    + 	}
    +=20
    + 	junk_mode =3D JUNK_LEAVE_REPO;
    +-	err =3D checkout(submodule_progress);
    ++	err =3D checkout(submodule_progress, filter_submodules);
    +=20
    + 	free(remote_name);
    + 	strbuf_release(&reflog_msg);
    =20
      ## builtin/submodule--helper.c ##
     @@
    @@ git-submodule.sh: cmd_update()
     +			shift
     +			;;
     +		--filter=3D*)
    -+			filter=3D$1
    ++			filter=3D"$1"
     +			;;
      		--)
      			shift
    @@ t/t5617-clone-submodules-remote.sh: test_expect_success 'clone with =
--single-bra
     +# do basic partial clone from "srv.bare"
     +# confirm partial clone was registered in the local config for super =
and sub.
     +test_expect_success 'clone with --filter' '
    -+	git clone --recurse-submodules --filter blob:none "file://$pwd/srv.b=
are" super_clone &&
    ++	git clone --recurse-submodules \
    ++		--filter blob:none --also-filter-submodules \
    ++		"file://$pwd/srv.bare" super_clone &&
     +	test_cmp_config -C super_clone 1 core.repositoryformatversion &&
     +	test_cmp_config -C super_clone blob:none remote.origin.partialclonef=
ilter &&
     +	test_cmp_config -C super_clone/sub 1 core.repositoryformatversion &&
     +	test_cmp_config -C super_clone/sub blob:none remote.origin.partialcl=
onefilter
     +'
    ++
    ++# check that clone.filterSubmodules works (--also-filter-submodules c=
an be
    ++# omitted)
    ++test_expect_success 'filters applied with clone.filterSubmodules' '
    ++	test_config_global clone.filterSubmodules true &&
    ++	git clone --recurse-submodules --filter blob:none \
    ++		"file://$pwd/srv.bare" super_clone2 &&
    ++	test_cmp_config -C super_clone2 1 core.repositoryformatversion &&
    ++	test_cmp_config -C super_clone2 blob:none remote.origin.partialclone=
filter &&
    ++	test_cmp_config -C super_clone2/sub 1 core.repositoryformatversion &=
&
    ++	test_cmp_config -C super_clone2/sub blob:none remote.origin.partialc=
lonefilter
    ++'
    ++
    ++test_expect_success '--no-also-filter-submodules overrides clone.filt=
erSubmodules=3Dtrue' '
    ++	test_config_global clone.filterSubmodules true &&
    ++	git clone --recurse-submodules --filter blob:none \
    ++		--no-also-filter-submodules \
    ++		"file://$pwd/srv.bare" super_clone3 &&
    ++	test_cmp_config -C super_clone3 1 core.repositoryformatversion &&
    ++	test_cmp_config -C super_clone3 blob:none remote.origin.partialclone=
filter &&
    ++	test_cmp_config -C super_clone3/sub 0 core.repositoryformatversion
    ++'
     +
      test_done
    =20
    @@ t/t7814-grep-recurse-submodules.sh: test_expect_failure 'grep saves =
textconv cac
     +	git init super/sub &&
     +	(
     +		cd super &&
    -+		test_commit --no-tag "Add file in superproject" super-file "Some co=
ntent for super-file" &&
    -+		test_commit -C sub --no-tag "Add file in submodule" sub-file "Some =
content for sub-file" &&
    ++		test_commit --no-tag "Add file in superproject" \
    ++			super-file "Some content for super-file" &&
    ++		test_commit -C sub --no-tag "Add file in submodule" \
    ++			sub-file "Some content for sub-file" &&
     +		git submodule add ./sub &&
     +		git commit -m "Add other as submodule sub" &&
     +		test_tick &&
    -+		test_commit -C sub --no-tag --append "Update file in submodule" sub=
-file "Some more content for sub-file" &&
    ++		test_commit -C sub --no-tag --append "Update file in submodule" \
    ++			sub-file "Some more content for sub-file" &&
     +		git add sub &&
     +		git commit -m "Update submodule" &&
     +		test_tick &&
    @@ t/t7814-grep-recurse-submodules.sh: test_expect_failure 'grep saves =
textconv cac
     +		git -C sub config --local uploadpack.allowanysha1inwant 1
     +	) &&
     +	# Clone the superproject & submodule, then make sure we can lazy-fet=
ch submodule objects.
    -+	git clone --filter=3Dblob:none --recurse-submodules "file://$(pwd)/s=
uper" partial &&
    ++	git clone --filter=3Dblob:none --also-filter-submodules \
    ++		--recurse-submodules "file://$(pwd)/super" partial &&
     +	(
     +		cd partial &&
     +		cat >expect <<-\EOF &&
    @@ t/t7814-grep-recurse-submodules.sh: test_expect_failure 'grep saves =
textconv cac
     +		HEAD^:super-file:Some content for super-file
     +		EOF
     +
    -+		GIT_TRACE2_EVENT=3D"$(pwd)/trace2.log" git grep -e content --recurs=
e-submodules HEAD^ >actual &&
    ++		GIT_TRACE2_EVENT=3D"$(pwd)/trace2.log" git grep -e content \
    ++			--recurse-submodules HEAD^ >actual &&
     +		test_cmp expect actual &&
     +		# Verify that we actually fetched data from the promisor remote:
     +		grep \"category\":\"promisor\",\"key\":\"fetch_count\",\"value\":\"=
1\" trace2.log >/dev/null

 Documentation/config/clone.txt     |  5 ++++
 Documentation/git-clone.txt        |  7 ++++-
 Documentation/git-submodule.txt    |  6 ++++-
 builtin/clone.c                    | 36 ++++++++++++++++++++++++--
 builtin/submodule--helper.c        | 30 +++++++++++++++++++---
 git-submodule.sh                   | 17 ++++++++++++-
 t/t5617-clone-submodules-remote.sh | 41 ++++++++++++++++++++++++++++++
 t/t7814-grep-recurse-submodules.sh | 41 ++++++++++++++++++++++++++++++
 8 files changed, 175 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/clone.txt b/Documentation/config/clone.tx=
t
index 7bcfbd18a5..26f4fb137a 100644
--- a/Documentation/config/clone.txt
+++ b/Documentation/config/clone.txt
@@ -6,3 +6,8 @@ clone.defaultRemoteName::
 clone.rejectShallow::
 	Reject to clone a repository if it is a shallow one, can be overridden by
 	passing option `--reject-shallow` in command line. See linkgit:git-clone[=
1]
+
+clone.filterSubmodules::
+	If a partial clone filter is provided (see `--filter` in
+	linkgit:git-rev-list[1]) and `--recurse-submodules` is used, also apply
+	the filter to submodules.
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 984d194934..632bd1348e 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
 	  [--recurse-submodules[=3D<pathspec>]] [--[no-]shallow-submodules]
 	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--[no-]reject-shall=
ow]
-	  [--filter=3D<filter>] [--] <repository>
+	  [--filter=3D<filter> [--also-filter-submodules]] [--] <repository>
 	  [<directory>]
=20
 DESCRIPTION
@@ -182,6 +182,11 @@ objects from the source repository into a pack in the =
cloned repository.
 	at least `<size>`. For more details on filter specifications, see
 	the `--filter` option in linkgit:git-rev-list[1].
=20
+--also-filter-submodules::
+	Also apply the partial clone filter to any submodules in the repository.
+	Requires `--filter` and `--recurse-submodules`. This can be turned on by
+	default by setting the `clone.filterSubmodules` config option.
+
 --mirror::
 	Set up a mirror of the source repository.  This implies `--bare`.
 	Compared to `--bare`, `--mirror` not only maps local branches of the
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.=
txt
index 7e5f995f77..4d3ab6b9f9 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -133,7 +133,7 @@ If you really want to remove a submodule from the repos=
itory and commit
 that use linkgit:git-rm[1] instead. See linkgit:gitsubmodules[7] for remov=
al
 options.
=20
-update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|=
--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth =
<depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--] [<path>...]=
::
+update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|=
--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth =
<depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter <filte=
r spec>] [--] [<path>...]::
 +
 --
 Update the registered submodules to match what the superproject
@@ -177,6 +177,10 @@ submodule with the `--init` option.
=20
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
+
+If `--filter <filter spec>` is specified, the given partial clone filter w=
ill be
+applied to the submodule. See linkgit:git-rev-list[1] for details on filte=
r
+specifications.
 --
 set-branch (-b|--branch) <branch> [--] <path>::
 set-branch (-d|--default) [--] <path>::
diff --git a/builtin/clone.c b/builtin/clone.c
index 727e16e0ae..fb605e4c8d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -71,6 +71,8 @@ static int option_dissociate;
 static int max_jobs =3D -1;
 static struct string_list option_recurse_submodules =3D STRING_LIST_INIT_N=
ODUP;
 static struct list_objects_filter_options filter_options;
+static int option_filter_submodules =3D -1;    /* unspecified */
+static int config_filter_submodules =3D -1;    /* unspecified */
 static struct string_list server_options =3D STRING_LIST_INIT_NODUP;
 static int option_remote_submodules;
=20
@@ -150,6 +152,8 @@ static struct option builtin_clone_options[] =3D {
 	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
 			TRANSPORT_FAMILY_IPV6),
 	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
+	OPT_BOOL(0, "also-filter-submodules", &option_filter_submodules,
+		    N_("apply partial clone filters to submodules")),
 	OPT_BOOL(0, "remote-submodules", &option_remote_submodules,
 		    N_("any cloned submodules will use their remote-tracking branch")),
 	OPT_BOOL(0, "sparse", &option_sparse_checkout,
@@ -650,7 +654,7 @@ static int git_sparse_checkout_init(const char *repo)
 	return result;
 }
=20
-static int checkout(int submodule_progress)
+static int checkout(int submodule_progress, int filter_submodules)
 {
 	struct object_id oid;
 	char *head;
@@ -729,6 +733,10 @@ static int checkout(int submodule_progress)
 			strvec_push(&args, "--no-fetch");
 		}
=20
+		if (filter_submodules && filter_options.choice)
+			strvec_pushf(&args, "--filter=3D%s",
+				     expand_list_objects_filter_spec(&filter_options));
+
 		if (option_single_branch >=3D 0)
 			strvec_push(&args, option_single_branch ?
 					       "--single-branch" :
@@ -749,6 +757,8 @@ static int git_clone_config(const char *k, const char *=
v, void *cb)
 	}
 	if (!strcmp(k, "clone.rejectshallow"))
 		config_reject_shallow =3D git_config_bool(k, v);
+	if (!strcmp(k, "clone.filtersubmodules"))
+		config_filter_submodules =3D git_config_bool(k, v);
=20
 	return git_default_config(k, v, cb);
 }
@@ -871,6 +881,7 @@ int cmd_clone(int argc, const char **argv, const char *=
prefix)
 	struct remote *remote;
 	int err =3D 0, complete_refs_before_fetch =3D 1;
 	int submodule_progress;
+	int filter_submodules =3D 0;
=20
 	struct transport_ls_refs_options transport_ls_refs_options =3D
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
@@ -1066,6 +1077,27 @@ int cmd_clone(int argc, const char **argv, const cha=
r *prefix)
 	if (option_reject_shallow !=3D -1)
 		reject_shallow =3D option_reject_shallow;
=20
+	/*
+	 * If option_filter_submodules is specified from CLI option,
+	 * ignore config_filter_submodules from git_clone_config.
+	 */
+	if (config_filter_submodules !=3D -1)
+		filter_submodules =3D config_filter_submodules;
+	if (option_filter_submodules !=3D -1)
+		filter_submodules =3D option_filter_submodules;
+
+	/*
+	 * Exit if the user seems to be doing something silly with submodule
+	 * filter flags (but not with filter configs, as those should be
+	 * set-and-forget).
+	 */
+	if (option_filter_submodules > 0 && !filter_options.choice)
+		die(_("the option '%s' requires '%s'"),
+		    "--also-filter-submodules", "--filter");
+	if (option_filter_submodules > 0 && !option_recurse_submodules.nr)
+		die(_("the option '%s' requires '%s'"),
+		    "--also-filter-submodules", "--recurse-submodules");
+
 	/*
 	 * apply the remote name provided by --origin only after this second
 	 * call to git_config, to ensure it overrides all config-based values.
@@ -1299,7 +1331,7 @@ int cmd_clone(int argc, const char **argv, const char=
 *prefix)
 	}
=20
 	junk_mode =3D JUNK_LEAVE_REPO;
-	err =3D checkout(submodule_progress);
+	err =3D checkout(submodule_progress, filter_submodules);
=20
 	free(remote_name);
 	strbuf_release(&reflog_msg);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c5d3fc3817..11552970f2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -20,6 +20,7 @@
 #include "diff.h"
 #include "object-store.h"
 #include "advice.h"
+#include "list-objects-filter-options.h"
=20
 #define OPT_QUIET (1 << 0)
 #define OPT_CACHED (1 << 1)
@@ -1630,6 +1631,7 @@ struct module_clone_data {
 	const char *name;
 	const char *url;
 	const char *depth;
+	struct list_objects_filter_options *filter_options;
 	struct string_list reference;
 	unsigned int quiet: 1;
 	unsigned int progress: 1;
@@ -1796,6 +1798,10 @@ static int clone_submodule(struct module_clone_data =
*clone_data)
 			strvec_push(&cp.args, "--dissociate");
 		if (sm_gitdir && *sm_gitdir)
 			strvec_pushl(&cp.args, "--separate-git-dir", sm_gitdir, NULL);
+		if (clone_data->filter_options && clone_data->filter_options->choice)
+			strvec_pushf(&cp.args, "--filter=3D%s",
+				     expand_list_objects_filter_spec(
+					     clone_data->filter_options));
 		if (clone_data->single_branch >=3D 0)
 			strvec_push(&cp.args, clone_data->single_branch ?
 				    "--single-branch" :
@@ -1852,6 +1858,7 @@ static int module_clone(int argc, const char **argv, =
const char *prefix)
 {
 	int dissociate =3D 0, quiet =3D 0, progress =3D 0, require_init =3D 0;
 	struct module_clone_data clone_data =3D MODULE_CLONE_DATA_INIT;
+	struct list_objects_filter_options filter_options;
=20
 	struct option module_clone_options[] =3D {
 		OPT_STRING(0, "prefix", &clone_data.prefix,
@@ -1881,17 +1888,19 @@ static int module_clone(int argc, const char **argv=
, const char *prefix)
 			   N_("disallow cloning into non-empty directory")),
 		OPT_BOOL(0, "single-branch", &clone_data.single_branch,
 			 N_("clone only one branch, HEAD or --branch")),
+		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 		OPT_END()
 	};
=20
 	const char *const git_submodule_helper_usage[] =3D {
 		N_("git submodule--helper clone [--prefix=3D<path>] [--quiet] "
 		   "[--reference <repository>] [--name <name>] [--depth <depth>] "
-		   "[--single-branch] "
+		   "[--single-branch] [--filter <filter-spec>]"
 		   "--url <url> --path <path>"),
 		NULL
 	};
=20
+	memset(&filter_options, 0, sizeof(filter_options));
 	argc =3D parse_options(argc, argv, prefix, module_clone_options,
 			     git_submodule_helper_usage, 0);
=20
@@ -1899,12 +1908,14 @@ static int module_clone(int argc, const char **argv=
, const char *prefix)
 	clone_data.quiet =3D !!quiet;
 	clone_data.progress =3D !!progress;
 	clone_data.require_init =3D !!require_init;
+	clone_data.filter_options =3D &filter_options;
=20
 	if (argc || !clone_data.url || !clone_data.path || !*(clone_data.path))
 		usage_with_options(git_submodule_helper_usage,
 				   module_clone_options);
=20
 	clone_submodule(&clone_data);
+	list_objects_filter_release(&filter_options);
 	return 0;
 }
=20
@@ -1994,6 +2005,7 @@ struct submodule_update_clone {
 	const char *recursive_prefix;
 	const char *prefix;
 	int single_branch;
+	struct list_objects_filter_options *filter_options;
=20
 	/* to be consumed by git-submodule.sh */
 	struct update_clone_data *update_clone;
@@ -2154,6 +2166,9 @@ static int prepare_to_clone_next_submodule(const stru=
ct cache_entry *ce,
 		strvec_pushl(&child->args, "--prefix", suc->prefix, NULL);
 	if (suc->recommend_shallow && sub->recommend_shallow =3D=3D 1)
 		strvec_push(&child->args, "--depth=3D1");
+	if (suc->filter_options && suc->filter_options->choice)
+		strvec_pushf(&child->args, "--filter=3D%s",
+			     expand_list_objects_filter_spec(suc->filter_options));
 	if (suc->require_init)
 		strvec_push(&child->args, "--require-init");
 	strvec_pushl(&child->args, "--path", sub->path, NULL);
@@ -2498,6 +2513,8 @@ static int update_clone(int argc, const char **argv, =
const char *prefix)
 	const char *update =3D NULL;
 	struct pathspec pathspec;
 	struct submodule_update_clone suc =3D SUBMODULE_UPDATE_CLONE_INIT;
+	struct list_objects_filter_options filter_options;
+	int ret;
=20
 	struct option module_update_clone_options[] =3D {
 		OPT_STRING(0, "prefix", &prefix,
@@ -2528,6 +2545,7 @@ static int update_clone(int argc, const char **argv, =
const char *prefix)
 			   N_("disallow cloning into non-empty directory")),
 		OPT_BOOL(0, "single-branch", &suc.single_branch,
 			 N_("clone only one branch, HEAD or --branch")),
+		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 		OPT_END()
 	};
=20
@@ -2540,20 +2558,26 @@ static int update_clone(int argc, const char **argv=
, const char *prefix)
 	update_clone_config_from_gitmodules(&suc.max_jobs);
 	git_config(git_update_clone_config, &suc.max_jobs);
=20
+	memset(&filter_options, 0, sizeof(filter_options));
 	argc =3D parse_options(argc, argv, prefix, module_update_clone_options,
 			     git_submodule_helper_usage, 0);
+	suc.filter_options =3D &filter_options;
=20
 	if (update)
 		if (parse_submodule_update_strategy(update, &suc.update) < 0)
 			die(_("bad value for update parameter"));
=20
-	if (module_list_compute(argc, argv, prefix, &pathspec, &suc.list) < 0)
+	if (module_list_compute(argc, argv, prefix, &pathspec, &suc.list) < 0) {
+		list_objects_filter_release(&filter_options);
 		return 1;
+	}
=20
 	if (pathspec.nr)
 		suc.warn_if_uninitialized =3D 1;
=20
-	return update_submodules(&suc);
+	ret =3D update_submodules(&suc);
+	list_objects_filter_release(&filter_options);
+	return ret;
 }
=20
 static int run_update_procedure(int argc, const char **argv, const char *p=
refix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 652861aa66..87772ac891 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -10,7 +10,7 @@ USAGE=3D"[--quiet] [--cached]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...=
]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|=
--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--refere=
nce <repository>] [--recursive] [--[no-]single-branch] [--] [<path>...]
+   or: $dashless [--quiet] update [--init [--filter=3D<filter-spec>]] [--r=
emote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]r=
ecommend-shallow] [--reference <repository>] [--recursive] [--[no-]single-b=
ranch] [--] [<path>...]
    or: $dashless [--quiet] set-branch (--default|--branch <branch>) [--] <=
path>
    or: $dashless [--quiet] set-url [--] <path> <newurl>
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>=
] [commit] [--] [<path>...]
@@ -49,6 +49,7 @@ dissociate=3D
 single_branch=3D
 jobs=3D
 recommend_shallow=3D
+filter=3D
=20
 die_if_unmatched ()
 {
@@ -347,6 +348,14 @@ cmd_update()
 		--no-single-branch)
 			single_branch=3D"--no-single-branch"
 			;;
+		--filter)
+			case "$2" in '') usage ;; esac
+			filter=3D"--filter=3D$2"
+			shift
+			;;
+		--filter=3D*)
+			filter=3D"$1"
+			;;
 		--)
 			shift
 			break
@@ -361,6 +370,11 @@ cmd_update()
 		shift
 	done
=20
+	if test -n "$filter" && test "$init" !=3D "1"
+	then
+		usage
+	fi
+
 	if test -n "$init"
 	then
 		cmd_init "--" "$@" || return
@@ -379,6 +393,7 @@ cmd_update()
 		$single_branch \
 		$recommend_shallow \
 		$jobs \
+		$filter \
 		-- \
 		"$@" || echo "#unmatched" $?
 	} | {
diff --git a/t/t5617-clone-submodules-remote.sh b/t/t5617-clone-submodules-=
remote.sh
index e2dbb4eaba..f7208b0565 100755
--- a/t/t5617-clone-submodules-remote.sh
+++ b/t/t5617-clone-submodules-remote.sh
@@ -28,6 +28,13 @@ test_expect_success 'setup' '
 	)
 '
=20
+# bare clone giving "srv.bare" for use as our server.
+test_expect_success 'setup bare clone for server' '
+	git clone --bare "file://$(pwd)/." srv.bare &&
+	git -C srv.bare config --local uploadpack.allowfilter 1 &&
+	git -C srv.bare config --local uploadpack.allowanysha1inwant 1
+'
+
 test_expect_success 'clone with --no-remote-submodules' '
 	test_when_finished "rm -rf super_clone" &&
 	git clone --recurse-submodules --no-remote-submodules "file://$pwd/." sup=
er_clone &&
@@ -65,4 +72,38 @@ test_expect_success 'clone with --single-branch' '
 	)
 '
=20
+# do basic partial clone from "srv.bare"
+# confirm partial clone was registered in the local config for super and s=
ub.
+test_expect_success 'clone with --filter' '
+	git clone --recurse-submodules \
+		--filter blob:none --also-filter-submodules \
+		"file://$pwd/srv.bare" super_clone &&
+	test_cmp_config -C super_clone 1 core.repositoryformatversion &&
+	test_cmp_config -C super_clone blob:none remote.origin.partialclonefilter=
 &&
+	test_cmp_config -C super_clone/sub 1 core.repositoryformatversion &&
+	test_cmp_config -C super_clone/sub blob:none remote.origin.partialclonefi=
lter
+'
+
+# check that clone.filterSubmodules works (--also-filter-submodules can be
+# omitted)
+test_expect_success 'filters applied with clone.filterSubmodules' '
+	test_config_global clone.filterSubmodules true &&
+	git clone --recurse-submodules --filter blob:none \
+		"file://$pwd/srv.bare" super_clone2 &&
+	test_cmp_config -C super_clone2 1 core.repositoryformatversion &&
+	test_cmp_config -C super_clone2 blob:none remote.origin.partialclonefilte=
r &&
+	test_cmp_config -C super_clone2/sub 1 core.repositoryformatversion &&
+	test_cmp_config -C super_clone2/sub blob:none remote.origin.partialclonef=
ilter
+'
+
+test_expect_success '--no-also-filter-submodules overrides clone.filterSub=
modules=3Dtrue' '
+	test_config_global clone.filterSubmodules true &&
+	git clone --recurse-submodules --filter blob:none \
+		--no-also-filter-submodules \
+		"file://$pwd/srv.bare" super_clone3 &&
+	test_cmp_config -C super_clone3 1 core.repositoryformatversion &&
+	test_cmp_config -C super_clone3 blob:none remote.origin.partialclonefilte=
r &&
+	test_cmp_config -C super_clone3/sub 0 core.repositoryformatversion
+'
+
 test_done
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-subm=
odules.sh
index 058e5d0c96..48ab7a05c4 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -544,4 +544,45 @@ test_expect_failure 'grep saves textconv cache in the =
appropriate repository' '
 	test_path_is_file "$sub_textconv_cache"
 '
=20
+test_expect_success 'grep partially-cloned submodule' '
+	# Set up clean superproject and submodule for partial cloning.
+	git init super &&
+	git init super/sub &&
+	(
+		cd super &&
+		test_commit --no-tag "Add file in superproject" \
+			super-file "Some content for super-file" &&
+		test_commit -C sub --no-tag "Add file in submodule" \
+			sub-file "Some content for sub-file" &&
+		git submodule add ./sub &&
+		git commit -m "Add other as submodule sub" &&
+		test_tick &&
+		test_commit -C sub --no-tag --append "Update file in submodule" \
+			sub-file "Some more content for sub-file" &&
+		git add sub &&
+		git commit -m "Update submodule" &&
+		test_tick &&
+		git config --local uploadpack.allowfilter 1 &&
+		git config --local uploadpack.allowanysha1inwant 1 &&
+		git -C sub config --local uploadpack.allowfilter 1 &&
+		git -C sub config --local uploadpack.allowanysha1inwant 1
+	) &&
+	# Clone the superproject & submodule, then make sure we can lazy-fetch su=
bmodule objects.
+	git clone --filter=3Dblob:none --also-filter-submodules \
+		--recurse-submodules "file://$(pwd)/super" partial &&
+	(
+		cd partial &&
+		cat >expect <<-\EOF &&
+		HEAD^:sub/sub-file:Some content for sub-file
+		HEAD^:super-file:Some content for super-file
+		EOF
+
+		GIT_TRACE2_EVENT=3D"$(pwd)/trace2.log" git grep -e content \
+			--recurse-submodules HEAD^ >actual &&
+		test_cmp expect actual &&
+		# Verify that we actually fetched data from the promisor remote:
+		grep \"category\":\"promisor\",\"key\":\"fetch_count\",\"value\":\"1\" t=
race2.log >/dev/null
+	)
+'
+
 test_done

base-commit: b56bd95bbc8f716cb8cbb5fdc18b9b0f00323c6a
--=20
2.35.0.263.gb82422642f-goog

