Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A91C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 21:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E85B64E28
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 21:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhBPVPb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 16:15:31 -0500
Received: from mout.gmx.net ([212.227.15.19]:59091 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhBPVPb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 16:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613510030;
        bh=p3O7VsrFLdC4051olNp7yipIIiCS8anMlcop957PsmY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KXBtPZYxNsC+ruWjz4DVSpLCKsQDqLcn2hWfKTYBSQQGfPiKVIThO/Ts2NQjRaXKK
         MNrFiPElF4MR/NjPhr5kesLQMi29tu+S49od9UMZwpL4Wk9nDNIOMlGz3P9kD+vb0d
         rJIA18Oj093H9geht5HRzBvhndC4CZp9VFAjABrU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.185.182] ([213.196.212.209]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3W0-1lR2yu0eVi-00LTin; Tue, 16
 Feb 2021 22:13:50 +0100
Date:   Tue, 16 Feb 2021 22:13:49 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] t/perf: handle worktrees as test repos
In-Reply-To: <YCwnPVFsYDa0SNmG@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2102162211050.52@tvgsbejvaqbjf.bet>
References: <YCwnPVFsYDa0SNmG@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Ve/u3zHi0XJjHJETIXp5EipNF6nqDfMxDC0SueSGpCZDsMsk1Bi
 uQYD3jYql0KWOVgiTIRUgwW58DlAltygLVvBGliNDP9uTI/xKhYuIMx/eUN83X1+9t55c57
 /mkmMxEgQtMuirk3RfthzEA5Zb9sNVQYtDMLI2gEQFjxU8WNWCm3+iWC64bZwrOJFgf1rkd
 QNcxjZCRXv1v64WYoVLPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F3q47tgTWtU=:dlXs56KrpKqFmm3GdSJGRP
 txGJHnZnKTOKHIGEs41Pqjhc01yH6loWLdUiGrZ7sJxxhXkrb2Ed4QLjEprU/QUokBXN0xVHn
 vVaV/5UWB/QEsDkj/v6mnWttKNBNHL42obQzlsZHNsxHnt9lUS6NqGR9QZuPEQGSunNHp345l
 +8gQeSPRWAEWrz0Tx8HV1j+YOk6ZlEhGf86EicHL9VmCFDH+fRfDIN8SwoN+H+K0NyHQORGPz
 2h8iVR2yrKYzJQ7Sj7H29CXcglxr6u3KtytLmnnfDz5t9KfyUz0z9wURoSi1Omn3l7P7dVQwi
 XDNjZmuGd1oD3nUU3j/ChsekWtBv607Lzy+8pz1TVaejlBj5Krr2VOfyWiKYlq6KaV2HwhP7z
 qGkVHU2BxrupB8YIQxWXbssiYCTGQTFecAE4xC0hxG2Xcxw0ODDSx9G9uBnqCQc5Fd//gQON/
 Yy9P4aaRbioVJgTGzvzXCyphoruMeK+v+wBEa5XtAD3QRbbE8Fi7Ou1/4wzD8YjGnk+zn/lPf
 Q1RRCVlhC9+FHRlpp5EMXCYXkuAOgbeyslQ8J3r243prBZCWY1sHhxOEGLDW9+BB5Rj2G5BDe
 2aF3hIh6gjCp5BBCOAHsHyVOw216Wa5IplCIssPCCCDCADirJJPvRKMIk9oRN0/sF1jCAkehi
 Db8LHcSnteL3rulola+xb7+/CbruhdZW7mWzZ4ztdz6Rzy/j04zkZDV4rNInF7kCvh2GtZGSm
 k6NxYL2BvrcFyICPPsdpgZEoQDsaeR7Rv9pjzbrjCplg4Fdc2huHG4jKIUqMG0yGMMN4Qq4hj
 6KQ6tduZ9tmsgQ1+BcphtcOKgcm1b/A73N1ZgVfaOfd28swzK64aFEAll0On8JPrH/SSCbarF
 bOk5cIggUON+KK29M1c6IbxISdU6ObsnVYLICkQmI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 16 Feb 2021, Jeff King wrote:

> The perf suite gets confused when test_perf_default_repo is pointed at a
> worktree (which includes when it is run from within a worktree at all,
> since the default is to use the current repository).
>
> Here's an example:
>
>   $ git worktree add ~/foo
>   Preparing worktree (new branch 'foo')
>   HEAD is now at 328c109303 The eighth batch
>   $ cd ~/foo
>   $ make
>   [...build output...]
>   $ cd t/perf
>   $ ./p0000-perf-lib-sanity.sh -v -i
>   [...]
>   perf 1 - test_perf_default_repo works:
>   running:
>   	foo=3D$(git rev-parse HEAD) &&
>   	test_export foo
>
>   fatal: ambiguous argument 'HEAD': unknown revision or path not in the =
working tree.
>   Use '--' to separate paths from revisions, like this:
>   'git <command> [<revision>...] -- [<file>...]'
>
> The problem is that we didn't copy all of the necessary files from the
> source repository (in this case we got HEAD, but we have no refs!). We
> discover the git-dir with "rev-parse --git-dir", but this points to the
> worktree's partial repository in .../.git/worktrees/foo.
>
> That partial repository has a "commondir" file which points to the main
> repository, where the actual refs are stored, but we don't copy it. This
> is the correct thing to do, though! If we did copy it, then our scratch
> test repo would be pointing back to the original main repo, and any ref
> updates we made in the tests would impact that original repo.
>
> Instead, we need to either:
>
>   1. Make a scratch copy of the original main repo (in addition to the
>      worktree repo), and point the scratch worktree repo's commondir at
>      it. This preserves the original relationship, but it's doubtful any
>      script really cares (if they are testing worktree performance,
>      they'd probably make their own worktrees). And it's trickier to get
>      right.
>
>   2. Collapse the main and worktree repos into a single scratch repo.
>      This can be done by copying everything from both, preferring any
>      files from the worktree repo.
>
> This patch does the second one. With this applied, the example above
> results in p0000 running successfully.
>
> Reported-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

I think you'll also need the equivalent of:

=2D- snip --
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 22d727cef83..0949c360ec4 100644
=2D-- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -84,7 +84,7 @@ test_perf_create_repo_from () {
 			cp -R "$objects_dir" "$repo/.git/"; } &&
 		for stuff in "$source_git"/*; do
 			case "$stuff" in
-				*/objects|*/hooks|*/config|*/commondir)
+				*/objects|*/hooks|*/config|*/commondir|*/gitdir)
 					;;
 				*)
 					cp -R "$stuff" "$repo/.git/" || exit 1
=2D- snap --

> Having written that, it occurs to me that an even simpler solution is to
> just always use the commondir as the source of the scratch repo. It does
> not produce the same outcome, but the point is generally just to find a
> suitable starting point for a repository. Grabbing the main repo instead
> of one of its worktrees is probably OK for most tests.

Good point: we probably also need to exclude `*/worktrees/*`, but that is
a bit trickier as we would not want to exclude, say,
`refs/heads/worktrees/cleanup`.

Ciao,
Dscho

>
>  t/perf/perf-lib.sh | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index e385c6896f..1226be4005 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -70,27 +70,40 @@ test_perf_do_repo_symlink_config_ () {
>  	test_have_prereq SYMLINKS || git config core.symlinks false
>  }
>
> +test_perf_copy_repo_contents () {
> +	for stuff in "$1"/*
> +	do
> +		case "$stuff" in
> +		*/objects|*/hooks|*/config|*/commondir)
> +			;;
> +		*)
> +			cp -R "$stuff" "$repo/.git/" || exit 1
> +			;;
> +		esac
> +	done
> +}
> +
>  test_perf_create_repo_from () {
>  	test "$#" =3D 2 ||
>  	BUG "not 2 parameters to test-create-repo"
>  	repo=3D"$1"
>  	source=3D"$2"
>  	source_git=3D"$("$MODERN_GIT" -C "$source" rev-parse --git-dir)"
>  	objects_dir=3D"$("$MODERN_GIT" -C "$source" rev-parse --git-path objec=
ts)"
> +	common_dir=3D"$("$MODERN_GIT" -C "$source" rev-parse --git-common-dir)=
"
>  	mkdir -p "$repo/.git"
>  	(
>  		cd "$source" &&
>  		{ cp -Rl "$objects_dir" "$repo/.git/" 2>/dev/null ||
>  			cp -R "$objects_dir" "$repo/.git/"; } &&
> -		for stuff in "$source_git"/*; do
> -			case "$stuff" in
> -				*/objects|*/hooks|*/config|*/commondir)
> -					;;
> -				*)
> -					cp -R "$stuff" "$repo/.git/" || exit 1
> -					;;
> -			esac
> -		done
> +
> +		# common_dir must come first here, since we want source_git to
> +		# take precedence and overwrite any overlapping files
> +		test_perf_copy_repo_contents "$common_dir"
> +		if test "$source_git" !=3D "$common_dir"
> +		then
> +			test_perf_copy_repo_contents "$source_git"
> +		fi
>  	) &&
>  	(
>  		cd "$repo" &&
> --
> 2.30.1.989.g5e01c2f281
>
>
