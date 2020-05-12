Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AC0C2D0F7
	for <git@archiver.kernel.org>; Tue, 12 May 2020 21:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45E5620753
	for <git@archiver.kernel.org>; Tue, 12 May 2020 21:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MYKj6059"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbgELVAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 17:00:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53639 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELVAC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 17:00:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB10B5A98E;
        Tue, 12 May 2020 16:59:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kjClRK0q5OuqUlbsBVw9dTNGQX8=; b=MYKj60
        59/xxQRbJzqRGIM+MuCifbmhmy9aM0T5UFYGk24nnNBhY+kwuSL1J9KFb+IaS3Ie
        YuPWtYHoVjoWmCQRvzHg56m8ZewuqAucBTeHJuE1tLfQBssLsgxNBTBtPdXdyGpx
        yEvDfA71+T9DHVqyb+ExbmyTE1DytTxB4Uqtc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=db8zPUeE5EOao+guNOorJTEZ44NabzHV
        0r8YQolF+UeGI5B825Ae4Nu7jkFF6K35PwzC9xlADvXkBxEczO4ssK03/WnOcsRv
        Mt68r7MKP/3Oqc6IXORwDUQXfnEH+MwEq3NR1/TVFVzfTMndLd/5ElNcHzVNoka9
        6nLdO6LwLY4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2D985A98D;
        Tue, 12 May 2020 16:59:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.99.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4167E5A98C;
        Tue, 12 May 2020 16:59:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH v2 01/11] Introduce CMake support for configuring Git on Linux
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
        <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
        <70ab1f03dd5413256166bf9db47be47b746ea6b1.1589302254.git.gitgitgadget@gmail.com>
Date:   Tue, 12 May 2020 13:59:54 -0700
In-Reply-To: <70ab1f03dd5413256166bf9db47be47b746ea6b1.1589302254.git.gitgitgadget@gmail.com>
        (Sibi Siddharthan via GitGitGadget's message of "Tue, 12 May 2020
        16:50:44 +0000")
Message-ID: <xmqqo8qsc1it.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 881BA048-9493-11EA-A6DC-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> To make this a little less awkward, the Git for Windows project offers
> the `vs/master` branch which has a full Visual Studio solution generated
> and committed. This branch can therefore be used to tinker with Git in
> Visual Studio _without_ having to download the full Git for Windows SDK.
> Unfortunatly, that branch is auto-generated from Git for Windows'
> `master`. If a developer wants to tinker, say, with `pu`, they are out
> of luck.

'pu' or 'next' are not to be built upon, so this is not a good line
of reasoning to complain that generating only for 'master' is bad.

> CMake was invented to make this sort of problem go away, by providing a
> more standardized, cross-platform way to configure builds.

I think everything above this point (including Makefile, autoconf
etc.) can be replaced with a single sentence

	The build infrastructure for Git is written around being
	able to run make, which is not supported natively on
	Windows.

without anything else.  That will flow naturally to

	Add a build script that uses CMake to help developers on
	Windows to build git.

and then you can continue the current state, like this paragraph.

> This is only the first step, and to make it easier to review, it only
> allows for configuring builds on the platform that is easiest to
> configure for: Linux.
>
> The CMake script checks whether the headers are present(eg. libgen.h),
> whether the functions are present(eg. memmem), whether the funtions work
> properly (eg. snprintf) and generate the required compile definitions
> for the platform. The script also searches for the required libraries,
> if it fails to find the required libraries the respective executables
> won't be built.(eg. If libcurl is not found then git-remote-http won't
> be built). This will help building Git easier.
>
> With a CMake script an out of source build of git is possible resulting
> in a clean source tree.


> Note: earlier endeavors on the Git mailing list to introduce CMake ended
> up in dead water. The primary reason for that was that reviewers
> _expected_ CMake support to fall out of maintenance, unless the
> contributor would promise to keep an eye on keeping CMake support up to
> date. However, in the meantime, support for automated testing has been
> introduced in Git's source code, and a later patch will modify the
> (still experimental) GitHub workflow to continually verify that CMake
> support is still complete. That will make maintenance reasonably easy.

I am not sure this belongs to the log message.

> Note: this patch asks for the minimum version v3.14 of CMake (which is
> not all that old as of time of writing) because that is the first
> version to offer a platform-independent way to generate hardlinks as
> part of the build. This is needed to generate all those hardlinks for
> the built-in commands of Git.

This does, but I do not think hardlinks are not required for our
build.  On Unix filesystems, it is not just possible but convenient
to use, and that is the only reason why we use hardlinks.

If hardlinks are possible but inconvenient to use on Windows, you
shouldn't force your target audience to use it.

> Instructions to run CMake:
>
> cmake `relative-path-to-srcdir` -DCMAKE_BUILD_TYPE=Release
>
> Possible build configurations(-DCMAKE_BUILD_TYPE) with corresponding
> compiler flags
> Debug : -g
> Release: -O3
> RelWithDebInfo : -O2 -g
> MinSizeRel : -Os
> empty(default) :
>
> NOTE: -DCMAKE_BUILD_TYPE is optional
>
> This process generates a Makefile.
> Then run `make` to build Git.
>
> NOTE: By default CMake uses Makefile as the build tool on Linux, to use
> another tool say `ninja` add this to the command line when configuring.
> `-G Ninja`

I find it curious that from the instruction, the most important
platform, the primary reason why we are reviewing this patch, is
missing.  Don't Windows folks need to be told how to run CMake to
build?

In any case, all of the above "Instructions" should go at the top
part of CMakeLists.txt in a comment, and not in the log message.
"git log" output is not an easy way for your target audience to
learn how to use what the commit adds.  Think what they need to do
when they discover there is CMakeLists.txt in our tree in three
months.  Don't force them to run "git blame" to find this commit
that added the support.

> Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> ---
>  CMakeLists.txt | 528 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 528 insertions(+)
>  create mode 100644 CMakeLists.txt
>
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> new file mode 100644
> index 00000000000..73703bd321f
> --- /dev/null
> +++ b/CMakeLists.txt
> @@ -0,0 +1,528 @@
> +#
> +#	Copyright (c) 2020 Sibi Siddharthan
> +#
> +
> +cmake_minimum_required(VERSION 3.14)
> +
> +#Parse GIT-VERSION-GEN to get the version
> +file(STRINGS ${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN git_version REGEX "DEF_VER=v(.*)")
> +string(REPLACE "DEF_VER=v" "" git_version ${git_version})
> +string(REPLACE ".GIT" ".0" git_version ${git_version})#for building from a snapshot

Hmph, I'd really prefer to see the logic in GIT-VERSION-GEN not
bypassed like this.  People know they can create a text file 'version'
and record the version name they desire in it and expect GIT-VERSION-GEN
to pick it up, for example.

Later in this file, you seem to depend on the shell to do things
like generating config-list.h file, so I'd rather see the same
technique used here a well.

> +set(libgit_SOURCES
> +	abspath.c add-interactive.c add-patch.c advice.c alias.c
> +...
> +	zlib.c)

Hmph.

> +set(git_SOURCES
> +	builtin/add.c builtin/am.c builtin/annotate.c builtin/apply.c
> +	builtin/archive.c builtin/bisect--helper.c builtin/blame.c
> +	builtin/branch.c builtin/bundle.c builtin/cat-file.c builtin/check-attr.c
> +	builtin/check-ignore.c builtin/check-mailmap.c builtin/check-ref-format.c
> +	builtin/checkout-index.c builtin/checkout.c builtin/clean.c
> +	builtin/clone.c builtin/column.c builtin/commit-tree.c
> +	builtin/commit.c builtin/commit-graph.c builtin/config.c
> +	builtin/count-objects.c builtin/credential.c builtin/describe.c
> +	builtin/diff-files.c builtin/diff-index.c builtin/diff-tree.c
> +	builtin/diff.c builtin/difftool.c builtin/env--helper.c
> +	builtin/fast-export.c builtin/fetch-pack.c builtin/fetch.c builtin/fmt-merge-msg.c
> +	builtin/for-each-ref.c builtin/fsck.c builtin/gc.c
> +	builtin/get-tar-commit-id.c builtin/grep.c builtin/hash-object.c
> +	builtin/help.c builtin/index-pack.c builtin/init-db.c
> +	builtin/interpret-trailers.c builtin/log.c builtin/ls-files.c
> +	builtin/ls-remote.c builtin/ls-tree.c builtin/mailinfo.c builtin/mailsplit.c
> +	builtin/merge.c builtin/merge-base.c builtin/merge-file.c builtin/merge-index.c
> +	builtin/merge-ours.c builtin/merge-recursive.c builtin/merge-tree.c
> +	builtin/mktag.c builtin/mktree.c builtin/multi-pack-index.c builtin/mv.c
> +	builtin/name-rev.c builtin/notes.c builtin/pack-objects.c builtin/pack-redundant.c
> +	builtin/pack-refs.c builtin/patch-id.c builtin/prune-packed.c builtin/prune.c
> +	builtin/pull.c builtin/push.c builtin/range-diff.c builtin/read-tree.c
> +	builtin/rebase.c builtin/receive-pack.c builtin/reflog.c builtin/remote.c
> +	builtin/remote-ext.c builtin/remote-fd.c builtin/repack.c builtin/replace.c
> +	builtin/rerere.c builtin/reset.c builtin/rev-list.c builtin/rev-parse.c
> +	builtin/revert.c builtin/rm.c builtin/send-pack.c builtin/shortlog.c
> +	builtin/show-branch.c builtin/show-index.c builtin/show-ref.c
> +	builtin/sparse-checkout.c builtin/stash.c builtin/stripspace.c
> +	builtin/submodule--helper.c builtin/symbolic-ref.c builtin/tag.c
> +	builtin/unpack-file.c builtin/unpack-objects.c builtin/update-index.c
> +	builtin/update-ref.c builtin/update-server-info.c builtin/upload-archive.c
> +	builtin/upload-pack.c builtin/var.c builtin/verify-commit.c builtin/verify-pack.c
> +	builtin/verify-tag.c builtin/worktree.c builtin/write-tree.c)

Can't we do a bit better here?  

Perhaps grab this out of our Makefile?  The same command applies to
huge lists of sources we have seen.

Or do the equivalent of $(wildcard builtin/*.c) if CMake has such a
feature?

> ...
> \ No newline at end of file

Double check and make sure you have a text file without an incomplete
line at the end.

Thanks.
