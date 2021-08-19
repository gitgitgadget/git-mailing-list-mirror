Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F4BC4320E
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 08:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CE3361131
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 08:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbhHSItp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 04:49:45 -0400
Received: from mout.gmx.net ([212.227.17.20]:46777 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237503AbhHSItY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 04:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629362914;
        bh=5LjNxVpIyps0J/sjSXul2ov6LEFOKQEpXa2qe0KyUIw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dTqsjTTHWwE7K6wIer7io4WY6/tjnL/EuskGPGtVPP7xSSgTvbGsKHv6xFihxCl/S
         6Q0LvdomiJIM+cvKz3sQuldl53xJrUOT4nc+SN1SSWWaFvHdb06Zn7Zax43lhjOjKK
         igoXvp599/KuQOODWyWtWQvi0gslciFZgwkLSN+o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.229]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPGVx-1mQrWO385V-00Pd3t; Thu, 19
 Aug 2021 10:48:33 +0200
Date:   Thu, 19 Aug 2021 10:48:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        matheus.bernardino@usp.br, stolee@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 8/8] sparse-checkout: clear tracked sparse dirs
In-Reply-To: <febef675f051eb08896751bb5661b6deb5579ead.1629206603.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108191015260.55@tvgsbejvaqbjf.bet>
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>        <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com> <febef675f051eb08896751bb5661b6deb5579ead.1629206603.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:sCc8lubg5axQjSWOYD7k8rzHwgbWzPlb59yBAHG2n8AGkbTJPrb
 Pyy6TR4OJEwi/UMdAF82GYD3gRtjLRziramVCQEznVa9Hch5cNXZ43DQVu+NlKFaWEwfQaJ
 pymVD5i8/4jM+jkD37frjXOov5QFTk0qS32Z6yVOwZaydnJZHpDrvton8nISpcpVkNLHAPL
 gO+F28RLO1+Bv4VqcmAZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HzTZc0+Lhk0=:yfqBHJNFh0Ds/s/ZdcNyRH
 ie6Y1Vy2VsS1LT3YDZz4XuXT68FPFs1JDtWxKh261K0ea9GZBu4eo/pE+rk4+unBkOPODkWsS
 Axh6eUcLOt7tKB8SKQNTyl6Z1YKVY32Ur6fguv7mvJUsOrY1jkekiRxfHfstV89YAWc0aA1lb
 UqTUyScHvv6Nnh6/XCmdGREZYwnYHOEl7jnPo1K8fy8S+MAm7SoQCe8v9fObAyArvi+lkQHo8
 lD3Mu/mKlW5LLuVhLRHQDXEs8RYgSY8Dl4V7hQ4NqoX0gpYVRXxn/che7nw25AyhdQIVdQoYN
 8hNIT8vB8+apwFLrZ8JaUZEbsG7fd7iYFgB/wcDQk+HEPgxXCKOuyrGlb90L08X5YDUfKY0LI
 cf+zvqMoyDbHQMLSwNFRu4084o1kMVuQvWP0qruWq4QuvNoGmUldxqR17ACABSOKGdPR4xk8Z
 qNp64Hj0Q5hN7/zSwYeGSNac4VNDTNL5yXJPNqg2fU+HPQK7f7bWcC06YIJCTfwlya1vS+S+L
 fjCjWoyX/xGyWBYEsvowU9YeUlshyypV8t8c/fYfHDsgNX/utRmLtnqFrKtY/pT1pOnd79tEf
 8AOwL7BIq2++D42lOao5KLYsrb4dN5ncIO2wedN2Gz5uUleFkEVgPQhMC8A9y2miWHV6Ma6N1
 RTQXoJzhb204ZGyo4K0hSCL22gQY23Gao4AfJKMOYCjVzvpcUwqN7wHRuti6KNWlibGNsvYHC
 rw5t3W1pwoKEIxQtWUP0TYjRQ/ZzulyNJCJHPJq329CPU1M305ViVEx4Qy+KXLruSbiXlMzua
 Q9N+VH08mCrC+8VzYEvWPTp3NyM55WOqznVugyO9rVJFmQxp2AW4kLtlP+Pa0f+UAbD0mvoKY
 ATFclQ6DRY3Sq10obN6HgqDecBJLaC4KQSrVlFIuHdNOSbiY2BWW3G95vLfUeA+LOXwBphP6x
 C2np34g+BtxR22L9jyfY2sq8jJ5JrOk2smWAVGaJWkp0iI3eP9Bsgzu1X6HMVl18hZ6B7PwvH
 Dm+jXhWLqdiMid41tqgLJjiw94MHtw4bkOVltpfef0UZ6528UBzPis+JziOa3WdeRdMZ7bihC
 209sVu6V8cxoEk0tnjZClD1Pmjvjlh0T5jkq4t4eaZL+d0JwzSpPDWifw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Tue, 17 Aug 2021, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> When changing the scope of a sparse-checkout using cone mode, we might
> have some tracked directories go out of scope. The current logic removes
> the tracked files from within those directories, but leaves the ignored
> files within those directories. This is a bit unexpected to users who
> have given input to Git saying they don't need those directories
> anymore.
>
> This is something that is new to the cone mode pattern type: the user
> has explicitly said "I want these directories and _not_ those
> directories." The typical sparse-checkout patterns more generally apply
> to "I want files with with these patterns" so it is natural to leave
> ignored files as they are. This focus on directories in cone mode
> provides us an opportunity to change the behavior.
>
> Leaving these ignored files in the sparse directories makes it
> impossible to gain performance benefits in the sparse index. When we
> track into these directories, we need to know if the files are ignored
> or not, which might depend on the _tracked_ .gitignore file(s) within
> the sparse directory. This depends on the indexed version of the file,
> so the sparse directory must be expanded.
>
> By deleting the sparse directories when changing scope (or running 'git
> sparse-checkout reapply') we regain these performance benefits as if the
> repository was in a clean state.
>
> Since these ignored files are frequently build output or helper files
> from IDEs, the users should not need the files now that the tracked
> files are removed. If the tracked files reappear, then they will have
> newer timestamps than the build artifacts, so the artifacts will need to
> be regenerated anyway.
>
> Use the sparse-index as a data structure in order to find the sparse
> directories that can be safely deleted. Re-expand the index to a full
> one if it was full before.

This description makes sense, and is easy to explain.

It does not cover the case where untracked files are found and the
directory is _not_ removed as a consequence, though. I would like to ask
to add this to the commit message, because it is kind of important.

The implementation of this behavior looks fine to me.

About this behavior itself: in my experience, the more tricky a feature is
to explain, the more likely the design should have been adjusted in the
first place. And I find myself struggling a little bit to explain what
files `git switch` touches in cone mode in addition to tracked files.

So I wonder whether an easier-to-explain behavior would be the following:
ignored files in directories that fell out of the sparse-checkout cone are
deleted. (Even if there are untracked, unignored files in the same
directory tree.)

This is different than what this patch implements: we would now have to
delete the ignored and out-of-cone files _also_ when there are untracked
files in the same directory, i.e. we could no longer use the sweet
`remove_dir_recursively()` call. Therefore, the implementation of what I
suggested would be much more complicated: you would have to enumerate the
ignored files and remove them individually.

Having said that, even after mulling over this behavior and sleeping over
it, I am unsure what the best way forward would be. Just because it is
easy to explain does not make it right.

It is tricky to decide mostly because "ignored" files are definitely not
always build output. Apart from VIM's temporary files, users like me
frequently write other files and/or directories that we simply do not want
to see tracked in Git. For example, I often test things in an `a1.c` file
that -- for convenience -- lives in the current worktree. Obviously I
don't want Git to track it, but I also don't want it to be deleted, so I
often add corresponding lines to `.git/info/exclude`. Likewise, I
sometimes download additional information related to what I am
implementing, and that also lives in the current worktree (but then, I
usually am too lazy to add an entry to `.git/info/exclude` in those
cases).

Now, I don't want to over-index on my own habits. There are so many users
out there, and most of them have different preferences from mine.

Which leaves me to wonder whether we need at least a flag to turn this
behavior on and off? Something like
`core.ignoredFilesInSparseConesArePrecious =3D true` (obviously with a
better, shorter name).

Ciao,
Dscho

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-sparse-checkout.txt |  8 +++
>  builtin/sparse-checkout.c             | 95 +++++++++++++++++++++++++++
>  t/t1091-sparse-checkout-builtin.sh    | 59 +++++++++++++++++
>  3 files changed, 162 insertions(+)
>
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-s=
parse-checkout.txt
> index fdcf43f87cb..f9022b9d555 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -210,6 +210,14 @@ case-insensitive check. This corrects for case mism=
atched filenames in the
>  'git sparse-checkout set' command to reflect the expected cone in the w=
orking
>  directory.
>
> +The cone mode sparse-checkout patterns will also remove ignored files t=
hat
> +are not within the sparse-checkout definition. This is important behavi=
or
> +to preserve the performance of the sparse index, but also matches that
> +cone mode patterns care about directories, not files. If there exist fi=
les
> +that are untracked and not ignored, then Git will not delete files with=
in
> +that directory other than the tracked files that are now out of scope.
> +These files should be removed manually to ensure Git can behave optimal=
ly.
> +
>
>  SUBMODULES
>  ----------
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 8ba9f13787b..b06c8f885ac 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -100,6 +100,99 @@ static int sparse_checkout_list(int argc, const cha=
r **argv)
>  	return 0;
>  }
>
> +static void clean_tracked_sparse_directories(struct repository *r)
> +{
> +	int i, was_full =3D 0;
> +	struct strbuf path =3D STRBUF_INIT;
> +	size_t pathlen;
> +	struct string_list_item *item;
> +	struct string_list sparse_dirs =3D STRING_LIST_INIT_DUP;
> +
> +	/*
> +	 * If we are not using cone mode patterns, then we cannot
> +	 * delete directories outside of the sparse cone.
> +	 */
> +	if (!r || !r->index || !r->worktree)
> +		return;
> +	init_sparse_checkout_patterns(r->index);
> +	if (!r->index->sparse_checkout_patterns ||
> +	    !r->index->sparse_checkout_patterns->use_cone_patterns)
> +		return;
> +
> +	/*
> +	 * Use the sparse index as a data structure to assist finding
> +	 * directories that are safe to delete. This conversion to a
> +	 * sparse index will not delete directories that contain
> +	 * conflicted entries or submodules.
> +	 */
> +	if (!r->index->sparse_index) {
> +		/*
> +		 * If something, such as a merge conflict or other concern,
> +		 * prevents us from converting to a sparse index, then do
> +		 * not try deleting files.
> +		 */
> +		if (convert_to_sparse(r->index, SPARSE_INDEX_IGNORE_CONFIG))
> +			return;
> +		was_full =3D 1;
> +	}
> +
> +	strbuf_addstr(&path, r->worktree);
> +	strbuf_complete(&path, '/');
> +	pathlen =3D path.len;
> +
> +	/*
> +	 * Collect directories that have gone out of scope but also
> +	 * exist on disk, so there is some work to be done. We need to
> +	 * store the entries in a list before exploring, since that might
> +	 * expand the sparse-index again.
> +	 */
> +	for (i =3D 0; i < r->index->cache_nr; i++) {
> +		struct cache_entry *ce =3D r->index->cache[i];
> +
> +		if (S_ISSPARSEDIR(ce->ce_mode) &&
> +		    repo_file_exists(r, ce->name))
> +			string_list_append(&sparse_dirs, ce->name);
> +	}
> +
> +	for_each_string_list_item(item, &sparse_dirs) {
> +		struct dir_struct dir =3D DIR_INIT;
> +		struct pathspec p =3D { 0 };
> +		struct strvec s =3D STRVEC_INIT;
> +
> +		strbuf_setlen(&path, pathlen);
> +		strbuf_addstr(&path, item->string);
> +
> +		dir.flags |=3D DIR_SHOW_IGNORED_TOO;
> +
> +		setup_standard_excludes(&dir);
> +		strvec_push(&s, path.buf);
> +
> +		parse_pathspec(&p, PATHSPEC_GLOB, 0, NULL, s.v);
> +		fill_directory(&dir, r->index, &p);
> +
> +		if (dir.nr) {
> +			warning(_("directory '%s' contains untracked files,"
> +				  " but is not in the sparse-checkout cone"),
> +				item->string);
> +		} else if (remove_dir_recursively(&path, 0)) {
> +			/*
> +			 * Removal is "best effort". If something blocks
> +			 * the deletion, then continue with a warning.
> +			 */
> +			warning(_("failed to remove directory '%s'"),
> +				item->string);
> +		}
> +
> +		dir_clear(&dir);
> +	}
> +
> +	string_list_clear(&sparse_dirs, 0);
> +	strbuf_release(&path);
> +
> +	if (was_full)
> +		ensure_full_index(r->index);
> +}
> +
>  static int update_working_directory(struct pattern_list *pl)
>  {
>  	enum update_sparsity_result result;
> @@ -141,6 +234,8 @@ static int update_working_directory(struct pattern_l=
ist *pl)
>  	else
>  		rollback_lock_file(&lock_file);
>
> +	clean_tracked_sparse_directories(r);
> +
>  	r->index->sparse_checkout_patterns =3D NULL;
>  	return result;
>  }
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkou=
t-builtin.sh
> index 38fc8340f5c..71236981e64 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -642,4 +642,63 @@ test_expect_success MINGW 'cone mode replaces backs=
lashes with slashes' '
>  	check_files repo/deep a deeper1
>  '
>
> +test_expect_success 'cone mode clears ignored subdirectories' '
> +	rm repo/.git/info/sparse-checkout &&
> +
> +	git -C repo sparse-checkout init --cone &&
> +	git -C repo sparse-checkout set deep/deeper1 &&
> +
> +	cat >repo/.gitignore <<-\EOF &&
> +	obj/
> +	*.o
> +	EOF
> +
> +	git -C repo add .gitignore &&
> +	git -C repo commit -m ".gitignore" &&
> +
> +	mkdir -p repo/obj repo/folder1/obj repo/deep/deeper2/obj &&
> +	for file in folder1/obj/a obj/a folder1/file.o folder1.o \
> +		    deep/deeper2/obj/a deep/deeper2/file.o file.o
> +	do
> +		echo ignored >repo/$file || return 1
> +	done &&
> +
> +	git -C repo status --porcelain=3Dv2 >out &&
> +	test_must_be_empty out &&
> +
> +	git -C repo sparse-checkout reapply &&
> +	test_path_is_missing repo/folder1 &&
> +	test_path_is_missing repo/deep/deeper2 &&
> +	test_path_is_dir repo/obj &&
> +	test_path_is_file repo/file.o &&
> +
> +	git -C repo status --porcelain=3Dv2 >out &&
> +	test_must_be_empty out &&
> +
> +	git -C repo sparse-checkout set deep/deeper2 &&
> +	test_path_is_missing repo/deep/deeper1 &&
> +	test_path_is_dir repo/deep/deeper2 &&
> +	test_path_is_dir repo/obj &&
> +	test_path_is_file repo/file.o &&
> +
> +	>repo/deep/deeper2/ignored.o &&
> +	>repo/deep/deeper2/untracked &&
> +
> +	# When an untracked file is in the way, all untracked files
> +	# (even ignored files) are preserved.
> +	git -C repo sparse-checkout set folder1 2>err &&
> +	grep "contains untracked files" err &&
> +	test_path_is_file repo/deep/deeper2/ignored.o &&
> +	test_path_is_file repo/deep/deeper2/untracked &&
> +
> +	# The rest of the cone matches expectation
> +	test_path_is_missing repo/deep/deeper1 &&
> +	test_path_is_dir repo/obj &&
> +	test_path_is_file repo/file.o &&
> +
> +	git -C repo status --porcelain=3Dv2 >out &&
> +	echo "? deep/deeper2/untracked" >expect &&
> +	test_cmp expect out
> +'
> +
>  test_done
> --
> gitgitgadget
>
