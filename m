Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C188C433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 16:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51E89603E9
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 16:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbhJZQZC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 12:25:02 -0400
Received: from mout.web.de ([212.227.17.12]:40413 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231880AbhJZQZB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 12:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1635265348;
        bh=KeyjsKhLCbKe70OwisuaKabFMfe5a0RbsDkdUGpIWoE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=eyrpuXyntdX++hawxoJqvh8QO0z1CRJpEcQvOAwTI7v7OIw55yfbDJGlC1NMZGdx9
         U6kRa6xxTjvJ7TG4f8WlubciYj+tmtyeIft2pwTSBw653E4TV+FLArueooQYD7IaSK
         0Li0sNx6PLF2ofvgvJdH2TrU+hXu6MPAIWKTPbso=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MPpE6-1mbZTC0usU-0054PI; Tue, 26 Oct 2021 18:22:28 +0200
Subject: Re: [PATCH v2] add, rm, mv: fix bug that prevents the update of
 non-sparse dirs
To:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, stolee@gmail.com,
        vdye@github.com, derrickstolee@github.com,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Sean Christopherson <seanjc@google.com>
References: <5e99c039db0b9644fb21f2ea72a464c67a74ff64.1635191000.git.matheus.bernardino@usp.br>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ca1c6a86-23ab-57ae-b1ca-64a9851d72db@web.de>
Date:   Tue, 26 Oct 2021 18:22:26 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <5e99c039db0b9644fb21f2ea72a464c67a74ff64.1635191000.git.matheus.bernardino@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:klfXImfYIWuY07zDxrrrol8NVbACM4ZY/NwY0o4xr5VmdkwuQDG
 uGYHMuiw9vcfeR5OSldulbmiB+noQ7gC0in7UE4+jMWjxFiiBdhlgGhDAR5ZN0F9PbymjnF
 IqAUjeNijfiIcvO2jNefk5k5PU4s6stPf2B3R5lFF4NR0lrF264C+1I4iqGjFrsKRvxavjh
 2yWOouEpj6QubHxcSFzzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W9flnUo3NMg=:KerJMN49UKpEacy5HRhO9R
 awgoFsQyb1B7aF/SYSYl1sv7KmLPFQ1P1SYqQ2RywQjdozUxNI4rPkDueZHPrlUX9ByFwtkxL
 V/MlmnJyRPcxIc5KrzvkmDDWnQJ3YRlpY23ukwci86dvXzRIgut/x0NqOexAvbnK4S28RqwKV
 rXrjKt3aM8pY/OHLoKvevv0XLtBVqnbK6s+I4725YECLu7MpebiDYuc0aD+Va3pUN/LOC8oI5
 g46gvON8cR3aNCmuGu+Yh2QsY2UzJouxgSWXAtlXK2/bD7k8sOgtQ7DpgEgBpogCRzuktm/0N
 tYXSBMKnR0shOtVrpcrEfJ5IiDhxehMSrjOKEUViVEMNqOC/6LhhBtRLjrBSolisoY48xREIp
 ns53zpLmhqCWHG4Avr8HBhGP22POiDEKk6uTb7N8F+uLVhuzvVyHJTdzxfS+CNCVhMxpRIc3X
 kLM0IM2+x3fTU00lHofRh3oE/12c+yzTcf80fP8SmJUivmomwaqbN4lASn6wswnLmRG+V0cDE
 gMK14EnOFHkZbv8DDvwt8InOTxelRN9w5hbp0mLAiB3Qed3X9I2AkvA2dUZheT/5ttECUs0EC
 tEKKuHIOiH8WAE2+xg8xICxH3yzeEighn7MMfII97QmepPjf/rz7HzEEu+F83iCfe4v1kq6FT
 BVio6E/MDMbmPjJvIVz1t98taKzRlecrNBmx8X5IzF/upLdZw8r1qW2OewerqJbg3kZ2Fni8s
 cG5rC3PDUGJwDO5Pr4TneFjwigSV2nwpIDQSM+scdILMFGvOsZxUJ/Q62cLtACMPx7Fp7hz6S
 Iy1QB/gFQ7NvmkSxttuofvPAfORnTLTwaW595IVOaM/zGchHiVggFiKZmKTy+MP7aCkvEHk2/
 5ylRubZPY049jR02i+urvf3Swb+Ws7+w1Lp8IbJWBMx/x72CJzRj6zIzr7iLrkh9uHNvTqAS9
 ZIF+Zonna+vOzTdnvnzOZwgqwJwKToVTjGWiIzmx+ntwTJwTzKdUH57ZPM+u56BUXmFwmP33m
 vxNSEJiwrm80R9o6BvxDji9Uk8krN3capu73ee0qRANorwyiMmVum2sGAQilE5JKAQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.10.21 um 23:07 schrieb Matheus Tavares:
> These three commands recently learned to avoid updating paths outside
> the sparse checkout even if they are missing the SKIP_WORKTREE bit. This
> is done using path_in_sparse_checkout(), which checks whether a given
> path matches the current list of sparsity rules, similar to what
> clear_ce_flags() does when we run "git sparse checkout init" or "git
> sparse-checkout reapply". However, clear_ce_flags() uses a recursive
> approach, applying the match results from parent directories on paths
> that get the UNDECIDED result, whereas path_in_sparse_checkout() only
> attempts to match the full path and immediately considers UNDECIDED as
> NOT_MATCHED. This makes the function miss matches with leading
> directories. For example, if the user has the sparsity patterns "!/a"
> and "b/", add, rm, and mv will fail to update the path "a/b/c" and end
> up displaying a warning about it being outside the sparse checkout even
> though it isn't. This problem only occurs in full pattern mode as the
> pattern matching functions never return UNDECIDED for cone mode.
>
> To fix this, replicate the recursive behavior of clear_ce_flags() in
> path_in_sparse_checkout(), falling back to the parent directory match
> when a path gets the UNDECIDED result. (If this turns out to be too
> expensive in some cases, we may want to later add some form of caching
> to accelerate multiple queries within the same directory. This is not
> implemented in this patch, though.) Also add two tests for each affected
> command (add, rm, and mv) to check that they behave correctly with the
> recursive pattern matching. The first test would previously fail without
> this patch while the second already succeeded. It is added mostly to
> make sure that we are not breaking the existing pattern matching for
> directories that are really sparse, and also as a protection against any
> future regressions.
>
> Two other existing tests had to be changed as well: one test in t3602
> checks that "git rm -r <dir>" won't remove sparse entries, but it didn't
> allow the non-sparse entries inside <dir> to be removed. The other one,
> in t7002, tested that "git mv" would correctly display a warning message
> for sparse paths, but it accidentally expected the message to include
> two non-sparse paths as well.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>
> Changes since RFC/v1 [1]:
>
> - Inverted the loop direction to start from the full path and go backwar=
ds in
>   the parent dirs. This way we can stop early when we find the first
>   non-UNDECIDED match result.
>
> - Simplified the implementation by unifing the code path for cone mode a=
nd
>   full pattern mode. Since path_matches_pattern_list() never returns UND=
ECIDED
>   for cone mode, it will always execute only one iteration of the loop a=
nd then
>   find the final answer. There is no need to handle this case in a separ=
ate
>   block.
>
> - Inside the loop, made sure to change dtype to DT_DIR when going to par=
ent
>   directories. Without this, the pattern match would fail if we had a pa=
th
>   like "a/b/c" and the pattern "b/" (with trailing slash).
>
> - Changed the tests to use trailing slash to make sure they cover the co=
rner
>   case described above.
>
> - Improved commit message.
>
> [1]: https://lore.kernel.org/git/80b5ba61861193daf7132aa64b65fc7dde90dac=
b.1634866698.git.matheus.bernardino@usp.br
> (The RFC was deep down another thread, so I separated v2 to help
> readers. Please, let me know if that is not a good approach and I will
> avoid it in the future.)
>
>  dir.c                          | 25 +++++++++++++++++------
>  t/t3602-rm-sparse-checkout.sh  | 37 +++++++++++++++++++++++++++++++---
>  t/t3705-add-sparse-checkout.sh | 18 +++++++++++++++++
>  t/t7002-mv-sparse-checkout.sh  | 24 ++++++++++++++++++++--
>  4 files changed, 93 insertions(+), 11 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index a4306ab874..248f72e732 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1504,8 +1504,9 @@ static int path_in_sparse_checkout_1(const char *p=
ath,
>  				     struct index_state *istate,
>  				     int require_cone_mode)
>  {
> -	const char *base;
>  	int dtype =3D DT_REG;
> +	enum pattern_match_result match =3D UNDECIDED;
> +	const char *end, *slash;
>
>  	/*
>  	 * We default to accepting a path if there are no patterns or
> @@ -1516,11 +1517,23 @@ static int path_in_sparse_checkout_1(const char =
*path,
>  	     !istate->sparse_checkout_patterns->use_cone_patterns))
>  		return 1;
>
> -	base =3D strrchr(path, '/');
> -	return path_matches_pattern_list(path, strlen(path), base ? base + 1 :=
 path,
> -					 &dtype,
> -					 istate->sparse_checkout_patterns,
> -					 istate) > 0;
> +	/*
> +	 * If UNDECIDED, use the match from the parent dir (recursively),
> +	 * or fall back to NOT_MATCHED at the topmost level.
> +	 */
> +	for (end =3D path + strlen(path); end > path && match =3D=3D UNDECIDED=
; end =3D slash) {
> +
> +		for (slash =3D end - 1; slash >=3D path && *slash !=3D '/'; slash--)
> +			; /* do nothing */

slash can end up one less than path.  If path points to the first char
of a string object this would be undefined if I read 6.5.6 of C99
correctly.  (A pointer to the array element just after the last one is
specified as fine as long as it's not dereferenced, but a pointer to
the element before the first one is not mentioned and thus undefined.)

Do you really need the ">=3D" instead of ">"?

> +
> +		match =3D path_matches_pattern_list(path, end - path,
> +				slash >=3D path ? slash + 1 : path, &dtype,
> +				istate->sparse_checkout_patterns, istate);
> +
> +		/* We are going to match the parent dir now */
> +		dtype =3D DT_DIR;
> +	}
> +	return match > 0;
>  }
>
>  int path_in_sparse_checkout(const char *path,
