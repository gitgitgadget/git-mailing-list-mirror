Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CF991F462
	for <e@80x24.org>; Thu, 25 Jul 2019 19:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfGYTli (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 15:41:38 -0400
Received: from mout.gmx.net ([212.227.17.21]:41537 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfGYTli (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 15:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564083692;
        bh=mH+3iNCCXuz0r5r2qsWpBvOTdKkNLl6ZIIT8YugOzcw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WzcUgHln/JXD4aIPKuEJwdLBgdwUst6gU65+ndeqi62D1LcAHSGKiAiV4HEvaaDMa
         EblYlhPTpmP4o/n2FPIV4RzBEkCYGYiYzioSfiiQKgctvzEh5dddRTieB7BhGoD5/r
         pjLep5EIfYlolx9YpPij0NU0NtmdUJCV9kqrfeUs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ld0E0-1iHIvU16VE-00iEc6; Thu, 25
 Jul 2019 21:41:32 +0200
Date:   Thu, 25 Jul 2019 21:41:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/19] Ensure index matches head before invoking merge
 machinery, round N
In-Reply-To: <20190725174611.14802-4-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907252120300.21907@tvgsbejvaqbjf.bet>
References: <20190725174611.14802-1-newren@gmail.com> <20190725174611.14802-4-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:b7wKjZur+rnPpnmVIJhRLYRrTOHe2972hIVmat+H9BK03NgaJj5
 JLgMWIlIfAki6hHaoCc9vv8VrhnrxPVlIciQM308DMMMVkvTvZJoEkFTObGoOt3/ZzRk3Cx
 i6QXCsy8MnIzPLrvsXnzw63xf4jzKuoQX7DbuK1j5T2cqX4ARJPa5GDWEmLA33xpcsTrjLO
 bvgSPN77vAwSTg8lUtETg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OdrcUmdYtY0=:URV1RT27gRR/3bMyrszcoR
 jLAq5by8PlWqp4FMHuveU33YnEAE79PDBYIsdMG6O1eAKMYYqzpwjtqI13Qzr+8qXn+ZIldZA
 8ypPM1CvYlCoLAhypm2UMZxrE8vJgeCpInr246ZOsXmkfdfwzxttLrBOyPiHn2OXDTpGyNxJW
 0NHUFYER7nfL/x54rYg2Nzc9Ma9wiS7sc1plLqfdE+Eb1/0o9AQROs8MqtX6Wb0pFcPM+zHet
 duc1AzExYmv0MPCCm9QiMeDQ7MBv6SblsBvThix8VljJgF8Y7AJ4j5KvFle5HsnMWf5LLYfWZ
 xhFzuf99LpxJ3j8KJ3oR6CxHRnoerVkDVwtaAkjFTOm3flYfCvR1h4c9zETjaXoflQJ5m34Or
 NVHuoNeSjBzTSnuCKvabfaNQEZrGGwoyoYsZYfKvJjHLOwQs1heKuPrGWtftqaQfFyVX1C9p3
 rqwIp9iEoes65xH/AFZfiM+5xJsdC6PmxTfgkDOMWE5KZTnevrsIpXkg6ucYhmPN3CbX69RXm
 0PylS45go45Ccioe7T6r+NrtP2DwFg+MApP5A4r2YswyLBPTYS3Uww8u/TPo7M8BdvO+Qd9l8
 LCX9rW6EbiCe1A2v+s7iVFkFodGUcSjXrRc9cI4Q//GASbleJNpbmxa8zeVFwiwfNGaYPU4t2
 vOC+hivSPvKIFXQxC6s/Cfn6tHtlpYaOgvbWLHPxgY9ayC7eog7KQUG4sAqSzQEhury2w11uq
 PZ62DiIdIliOuCvv2Uh+RKyiaaAIngmt4n4fxfKWjEQEacm2bODeVg7+gDZk1NjHZfMHLwPaR
 B6yNJYWHNsaE8e8DOrv4IUnV3+jfdI5Gz7v0t5nkrdc14feNTlIFlZ3NhZafFMaFA6sdPrnkF
 dgzb5O8Rh3/U1FYESr15Won8+K8o+jIRdKTLEDhT1vZ4CyAp+7/SWrm6rMQtCA8ZY4NeIr4xr
 8vlpFLpGQHNR+c9aBTKDdOg/7Sp/20yZ1j/DZqBRGsLHLgvaaB74XIX1dSZiGSKwOnNLaRUzc
 /MWnKSOm6NS/RIYon5tSZkx+oq3+0Q240NKYRz6Jqr3hSKNXmGqKvnYesbefRBwBEJfPHhHY3
 p61jg4qbDLY7DnXjSoGCXLoJtgE6d3H7weS
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, 25 Jul 2019, Elijah Newren wrote:

> This is the bug that just won't die; there always seems to be another
> form of it somewhere.  See the commit message of 55f39cf7551b ("merge:
> fix misleading pre-merge check documentation", 2018-06-30) for a more
> detailed explanation), but in short:
>
> <quick summary>
>
> builtin/merge.c contains this important requirement for merge
> strategies:
>
>     ...the index must be in sync with the head commit.  The strategies a=
re
>     responsible to ensure this.
>
> This condition is important to enforce because there are two likely
> failure cases when the index isn't in sync with the head commit:
>
>   * we silently throw away changes the user had staged before the merge
>
>   * we accidentally (and silently) include changes in the merge that
>     were not part of either of the branches/trees being merged
>
> Discarding users' work and mis-merging are both bad outcomes, especially
> when done silently, so naturally this rule was stated sternly -- but,
> unfortunately totally ignored in practice unless and until actual bugs
> were found.  But, fear not: the bugs from this were fixed in commit
>   ee6566e8d70d ("[PATCH] Rewrite read-tree", 2005-09-05)
> through a rewrite of read-tree (again, commit 55f39cf7551b has a more
> detailed explanation of how this affected merge).  And it was fixed
> again in commit
>   160252f81626 ("git-merge-ours: make sure our index matches HEAD", 2005=
-11-03)
> ...and it was fixed again in commit
>   3ec62ad9ffba ("merge-octopus: abort if index does not match HEAD", 201=
6-04-09)
> ...and again in commit
>   65170c07d466 ("merge-recursive: avoid incorporating uncommitted change=
s in a merge", 2017-12-21)
> ...and again in commit
>   eddd1a411d93 ("merge-recursive: enforce rule that index matches head b=
efore merging", 2018-06-30)
>
> ...with multiple testcases added to the testsuite that could be
> enumerated in even more commits.
>
> Then, finally, in a patch in the same series as the last fix above, the
> documentation about this requirement was fixed in commit 55f39cf7551b
> ("merge: fix misleading pre-merge check documentation", 2018-06-30), and
> we all lived happily ever after...
>
> </quick summary>

Whoa. What a story.

> Unfortunately, "ever after" apparently denotes a limited time and it
> expired today.  The merge-recursive rule to enforce that index matches
> head was at the beginning of merge_trees() and would only trigger when
> opt->call_depth was 0.  Since merge_recursive() doesn't call
> merge_trees() until after returning from recursing, this meant that the
> check wasn't triggered by merge_recursive() until it had first finished
> all the intermediate merges to create virtual merge bases.  That is a
> potentially HUGE amount of computation (and writing of intermediate
> merge results into the .git/objects directory) before it errors out and
> says, in effect, "Sorry, I can't do any merging because you have some
> local changes that would be overwritten."
>
> Trying to enforce that all of merge_trees(), merge_recursive(), and
> merge_recursive_generic() checked the index =3D=3D head condition earlie=
r
> resulted in a bunch of broken tests.  It turns out that
> merge_recursive() has code to drop and reload the cache while recursing
> to create intermediate virtual merge bases, but unfortunately that code
> runs even when no recursion is necessary.  This unconditional dropping
> and reloading of the cache masked a few bugs:
>
>   * builtin/merge-recursive.c: didn't even bother loading the index.
>
>   * builtin/stash.c: feels like a fake 'builtin' because it repeatedly
>     invokes git subprocesses all over the place, mixed with other
>     operations.  In particular, invoking "git reset" will reset the
>     index on disk, but the parent process that invoked it won't
>     automatically have its in-memory index updated.

Yep, the idea was to move fast to a built-in, and then continue by
converting all those process spawns to proper calls to libgit "API"
functions.

Sadly, that did not happen yet.

And you're absolutely right that failing to re-read the index after
spawning a `reset --hard` causes problems. IIRC I fixed them all,
though, see
https://public-inbox.org/git/nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaq=
bjf.bet/

> So, load the index in builtin/merge-recursive.c, reload the in-memory
> index in builtin/stash.c, and modify the t3030 testcase to correctly
> setup the index and make sure that the test fails in the expected way
> (meaning it reports a rename/rename conflict).

Makes sense to me.

> diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
> index 5b910e351e..a4bfd8fc51 100644
> --- a/builtin/merge-recursive.c
> +++ b/builtin/merge-recursive.c
> @@ -1,3 +1,4 @@
> +#include "cache.h"
>  #include "builtin.h"
>  #include "commit.h"
>  #include "tag.h"
> @@ -63,6 +64,9 @@ int cmd_merge_recursive(int argc, const char **argv, c=
onst char *prefix)
>  	if (argc - i !=3D 3) /* "--" "<head>" "<remote>" */
>  		die(_("not handling anything other than two heads merge."));
>
> +	if (repo_read_index_unmerged(the_repository))
> +		die_resolve_conflict("merge");

For a moment I was unsure whether `_unmerged()` is the right thing to do
here, as it specifically allows to read the index even when there are
conflict stages. But I guess it does not matter too much here. I
probably would have opted for `repo_read_index()` instead, though.

> +
>  	o.branch1 =3D argv[++i];
>  	o.branch2 =3D argv[++i];
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index fde6397caa..bec011c1bb 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -427,6 +427,8 @@ static int do_apply_stash(const char *prefix, struct=
 stash_info *info,
>  				return error(_("could not save index tree"));
>
>  			reset_head();
> +			discard_cache();
> +			read_cache();

I was honestly puzzled why this is necessary, at first. The preceding
context expands to this:

                        discard_cache();
                        read_cache();
                        if (write_cache_as_tree(&index_tree, 0, NULL))
                                return error(_("could not save index tree"=
));

So basically, we already discard the index, read it again, then write it
as a tree, then reset and then we have to discard the index again?

But of course, if there are uncommitted changes, this would write a tree
different from HEAD, then reset the index to match HEAD, so indeed, this
discard/read dance is necessary.

So this hunk is good.

>  		}
>  	}
>
> diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
> index ff641b348a..a37bcc58a0 100755
> --- a/t/t3030-merge-recursive.sh
> +++ b/t/t3030-merge-recursive.sh
> @@ -667,15 +667,22 @@ test_expect_success 'merging with triple rename ac=
ross D/F conflict' '
>  test_expect_success 'merge-recursive remembers the names of all base tr=
ees' '
>  	git reset --hard HEAD &&
>
> +	# make the index match $c1 so that merge-recursive below does not
> +	# fail early
> +	git diff --binary HEAD $c1 -- | git apply --cached &&
> +
>  	# more trees than static slots used by oid_to_hex()
>  	for commit in $c0 $c2 $c4 $c5 $c6 $c7
>  	do
>  		git rev-parse "$commit^{tree}"
>  	done >trees &&
>
> -	# ignore the return code -- it only fails because the input is weird
> +	# ignore the return code; it only fails because the input is weird...
>  	test_must_fail git -c merge.verbosity=3D5 merge-recursive $(cat trees)=
 -- $c1 $c3 >out &&
>
> +	# ...but make sure it fails in the expected way
> +	test_i18ngrep CONFLICT.*rename/rename out &&
> +

This is obviously a good change: it strengthens the test case by fixing
a subtle bug.

Thanks,
Dscho

>  	# merge-recursive prints in reverse order, but we do not care
>  	sort <trees >expect &&
>  	sed -n "s/^virtual //p" out | sort >actual &&
> --
> 2.22.0.559.g28a8880890.dirty
>
>
