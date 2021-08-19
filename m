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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D61C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 08:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0348B6113A
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 08:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbhHSIIc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 04:08:32 -0400
Received: from mout.gmx.net ([212.227.15.18]:59099 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236766AbhHSIIc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 04:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629360468;
        bh=fcSsf0y+089/v79erAW1Z9n+sAbaFDCt3WQOLYebJmc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dxHfDFHr7CW34QvyEm1rb/r1CEdW+pEhkW1Ix6+s7G0HhECSBdcDasacFUJiycxb8
         u1kN39w+naPbjz4cVBcqvqTmyaTJLciDC7msekXvN+FwNAKgfbocS9ymr6da+55iVc
         WZUJMPsQFqj5Cg0cTRe1g6sgSlGZMFF519Mv0B4o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.229]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQe5k-1mSEiY2kqM-00Nl7P; Thu, 19
 Aug 2021 10:07:48 +0200
Date:   Thu, 19 Aug 2021 10:07:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        matheus.bernardino@usp.br, stolee@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 5/8] sparse-checkout: create helper methods
In-Reply-To: <5d28570c82af19b4bda4253e72ace3760dfe2606.1629206603.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108191005560.55@tvgsbejvaqbjf.bet>
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>        <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com> <5d28570c82af19b4bda4253e72ace3760dfe2606.1629206603.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rJVho/hj+dG/q3XV5ulbxKWYXfhQkxlVj2jd8+BKwzD7aAe8HSc
 eB1b2K+Q357zLm/IfM/782yzRMjw5CxUjwv7ojxcwto/tHSoWxz/k4uS+N3u17YUeYjO8pu
 pknTZ0mwPVfjDberWATGCBtHb6Gc6WrLbMSzhcivqhsXZt7jmymg614AUwz4g2NdNsAMjdC
 aea4D0vUu6ysHwykNKE/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oVUZK5QLoRU=:w2mvE4fVCj75/ZOVpEJCvs
 wWZpm8FdzTez8WfP+zxb+C6p55rJav67A2CG0Jb3CANtPnz0+4sILIyc+RnIg2NuvS281ixf+
 8WORmjmDJb1p0bprZMt5SX2p8Fr7+kqjuVRCLKbjLYOYgpbdBWOOtb2p6okk/reOAwrscD/cv
 DuDG1CZAUGEZT+lECiKLC2nb6cHHaytj8DTmL85I6k4AnDb0boEvHYhmDnpugVrqwBn20Ex/1
 5M/573bmRpScXmqvWA76XmpDwCgeyhKjyq9N4q/ioOjmAAjeYkvJ44/JVpuw5ZPi+qRHdI6sZ
 k9smJVGn8PB+S6j58qN10nRpCsF4O3qtym5JJQt+5EAXu6dPatGjRQNFhMWZoobbRYsGicxv8
 IShjcQ/HXU2PGO6PDQVGV5pWjj0d5y6VMTveYNpUMU4CMK/SyeoFH7bxojfeu2OEtBxAbynRB
 5uMR4KfswWhruHQkhM30476KVG6GZ8UxrHuEcjaXtrqDrO7cdPW7TFHUDL7Msn6LrbsbLATQR
 rXWaJ7NnddvlpHA/CctUkn/1UeWMRpc2+AyLTwZ9GWyNi54GBM8car3G25JlAZJh2Skjybx2f
 qbRduMpaaQMbKJvqsp1XJmInK96y/sBgYmk9up2CWgdqe3OJ57Qn9+YsucvP1uHKq2KSDCflr
 S6taen+lXiIlEwKMphc5N3ZE4FzOof0PT/E2VyvlP0Ob3uODZDNp5ZVqYsEDZVd4r8UzbQlHC
 lYWj7I0sbot4JN87nc1ArgKbCYLUs4rztDo/9H815vBAb5302Oj68RxaAymJ41ILwUuosV0G6
 YAvljxzfKJCGC6ncVJ4H7bGZkYMAALE1tEupIHahAKJKXMZQKsh71noSpixvuxwnk9MnPjK7d
 /1Q8BfSF5q4kKKXikqRbsLdpePz6N4VM+JVS6tQHG2I4YOD8DnUSEnZP9rNUxd/uB3YzZlAIv
 zlb19EFzss+aVdmtyj62mghgi49P8YgKrf15SbMNDN/Wg0nKc8UF/S+ny2sA5Rm1z8+1GI2qb
 AVN1MjGELFW5Ed9H9OslUeR65iSarDWAs4EFqf5uZ5rvQ5E8RPYPeqQ/7QFwT8YX+vhuiQ81m
 tjLAUeLo804JU4JNAphCgAeQZ1fGas9UaT+ciLB0w5aGo42geIP41GYlw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Tue, 17 Aug 2021, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> As we integrate the sparse index into more builtins, we occasionally
> need to check the sparse-checkout patterns to see if a path is within
> the sparse-checkout cone. Create some helper methods that help
> initialize the patterns and check for pattern matching to make this
> easier.
>
> The existing callers of commands like get_sparse_checkout_patterns() use
> a custom 'struct pattern_list' that is not necessarily the one in the
> 'struct index_state', so there are not many previous uses that could
> adopt these helpers. There are just two in builtin/add.c and
> sparse-index.c that can use path_in_sparse_checkout().

Very good!

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/add.c  |  8 ++------
>  dir.c          | 33 +++++++++++++++++++++++++++++++++
>  dir.h          |  6 ++++++
>  sparse-index.c | 12 +++---------
>  4 files changed, 44 insertions(+), 15 deletions(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 17528e8f922..f675bdeae4a 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -190,8 +190,6 @@ static int refresh(int verbose, const struct pathspe=
c *pathspec)
>  	struct string_list only_match_skip_worktree =3D STRING_LIST_INIT_NODUP=
;
>  	int flags =3D REFRESH_IGNORE_SKIP_WORKTREE |
>  		    (verbose ? REFRESH_IN_PORCELAIN : REFRESH_QUIET);
> -	struct pattern_list pl =3D { 0 };
> -	int sparse_checkout_enabled =3D !get_sparse_checkout_patterns(&pl);
>
>  	seen =3D xcalloc(pathspec->nr, 1);
>  	refresh_index(&the_index, flags, pathspec, seen,
> @@ -199,12 +197,10 @@ static int refresh(int verbose, const struct paths=
pec *pathspec)
>  	for (i =3D 0; i < pathspec->nr; i++) {
>  		if (!seen[i]) {
>  			const char *path =3D pathspec->items[i].original;
> -			int dtype =3D DT_REG;
>
>  			if (matches_skip_worktree(pathspec, i, &skip_worktree_seen) ||
> -			    (sparse_checkout_enabled &&
> -			     !path_matches_pattern_list(path, strlen(path), NULL,
> -							&dtype, &pl, &the_index))) {
> +			    (core_apply_sparse_checkout &&

Do we need to test for `core_apply_sparse_checkout` here? Or does the `if
(!istate->sparse_checkout_patterns) return MATCHED;` early return in
`path_in_sparse_checkout()` suffice to catch this?

The remainder of the patch looks good to me.

Thank you,
Dscho

> +			     path_in_sparse_checkout(path, &the_index) =3D=3D NOT_MATCHED)) =
{
>  				string_list_append(&only_match_skip_worktree,
>  						   pathspec->items[i].original);
>  			} else {
> diff --git a/dir.c b/dir.c
> index 03c4d212672..6fd4f2e0f27 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1439,6 +1439,39 @@ done:
>  	return result;
>  }
>
> +int init_sparse_checkout_patterns(struct index_state *istate)
> +{
> +	if (!core_apply_sparse_checkout ||
> +	    istate->sparse_checkout_patterns)
> +		return 0;
> +
> +	CALLOC_ARRAY(istate->sparse_checkout_patterns, 1);
> +
> +	if (get_sparse_checkout_patterns(istate->sparse_checkout_patterns) < 0=
) {
> +		FREE_AND_NULL(istate->sparse_checkout_patterns);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +int path_in_sparse_checkout(const char *path,
> +			    struct index_state *istate)
> +{
> +	const char *base;
> +	int dtype =3D DT_REG;
> +	init_sparse_checkout_patterns(istate);
> +
> +	if (!istate->sparse_checkout_patterns)
> +		return MATCHED;
> +
> +	base =3D strrchr(path, '/');
> +	return path_matches_pattern_list(path, strlen(path), base ? base + 1 :=
 path,
> +					 &dtype,
> +					 istate->sparse_checkout_patterns,
> +					 istate) > 0;
> +}
> +
>  static struct path_pattern *last_matching_pattern_from_lists(
>  		struct dir_struct *dir, struct index_state *istate,
>  		const char *pathname, int pathlen,
> diff --git a/dir.h b/dir.h
> index b3e1a54a971..b899ee43d81 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -394,6 +394,12 @@ enum pattern_match_result path_matches_pattern_list=
(const char *pathname,
>  				const char *basename, int *dtype,
>  				struct pattern_list *pl,
>  				struct index_state *istate);
> +
> +int init_sparse_checkout_patterns(struct index_state *state);
> +
> +int path_in_sparse_checkout(const char *path,
> +			    struct index_state *istate);
> +
>  struct dir_entry *dir_add_ignored(struct dir_struct *dir,
>  				  struct index_state *istate,
>  				  const char *pathname, int len);
> diff --git a/sparse-index.c b/sparse-index.c
> index b6e90417556..2efc9fd4910 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -34,17 +34,14 @@ static int convert_to_sparse_rec(struct index_state =
*istate,
>  	int i, can_convert =3D 1;
>  	int start_converted =3D num_converted;
>  	enum pattern_match_result match;
> -	int dtype =3D DT_UNKNOWN;
>  	struct strbuf child_path =3D STRBUF_INIT;
> -	struct pattern_list *pl =3D istate->sparse_checkout_patterns;
>
>  	/*
>  	 * Is the current path outside of the sparse cone?
>  	 * Then check if the region can be replaced by a sparse
>  	 * directory entry (everything is sparse and merged).
>  	 */
> -	match =3D path_matches_pattern_list(ct_path, ct_pathlen,
> -					  NULL, &dtype, pl, istate);
> +	match =3D path_in_sparse_checkout(ct_path, istate);
>  	if (match !=3D NOT_MATCHED)
>  		can_convert =3D 0;
>
> @@ -153,11 +150,8 @@ int convert_to_sparse(struct index_state *istate)
>  	if (!istate->repo->settings.sparse_index)
>  		return 0;
>
> -	if (!istate->sparse_checkout_patterns) {
> -		istate->sparse_checkout_patterns =3D xcalloc(1, sizeof(struct pattern=
_list));
> -		if (get_sparse_checkout_patterns(istate->sparse_checkout_patterns) < =
0)
> -			return 0;
> -	}
> +	if (init_sparse_checkout_patterns(istate) < 0)
> +		return 0;
>
>  	/*
>  	 * We need cone-mode patterns to use sparse-index. If a user edits
> --
> gitgitgadget
>
>
