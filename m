Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28253C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 15:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381727AbhLCPZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 10:25:58 -0500
Received: from mout.gmx.net ([212.227.17.22]:38159 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245140AbhLCPZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 10:25:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638544945;
        bh=xuW2K90yp04yF9cDiI8YuRGo4djD351UsONNTlpNVo8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ONX/hEBtGme0Gt56jvYX+xM8bzV0nz2d7+CN5OctNNgyaM+VhsBdl2K/AYjcr8moj
         SZVZjm0/i1C6C2LItEUx52Ugu0dyWDjp5w1DXDZ0zJQH0qfYSlMlujlEsKpFOoq2wj
         KrpwGQRNkJ+q8wdNwjFJB36c6ErGUJKidMDYuQec=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.223]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mplbx-1mEpsy0HAD-00qBha; Fri, 03
 Dec 2021 16:22:25 +0100
Date:   Fri, 3 Dec 2021 16:22:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     James Limbouris via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, James Limbouris <james@digitalmatter.com>,
        James Limbouris <james@digitalmatter.com>
Subject: Re: [PATCH] subtree: fix argument handling in check_parents
In-Reply-To: <pull.1086.git.1638324413653.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2112031610590.63@tvgsbejvaqbjf.bet>
References: <pull.1086.git.1638324413653.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CsDDRJIxi/jsYJs4016uFQ3wxjzoX3483gMlJ065atlPbjlDC2Z
 vyw9+MPCMtcyg6793ogrJ0Oh55V2n4VopQX9ctAuqSvJGldVP0WkV+yZAZvA5TydsZcExQ5
 IJLTERqb27F04jB8uYDGqCEBxDudx0xFBygVd+Uoag3udNi7bbT/wYoz7T9T2UohsCUn2Lp
 aEupH6oi3a/XI1JvSPeHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PTfCNzmpEsA=:8CYED+/ILYr+CiwvhhWWSm
 7FsVZPvarNTeTsSdKel5hz4Ogz0OKEERwDx72nrZqjaLE5km5EcJhUL0T7ezJ+IL/QQnmk7B3
 ejQgaVlIM2VtJPVTdkZITITKLMLykurJEcg0D0iNFBywikYp/6BIF1WZ3jEira/vOqGJ0FqDM
 tV1RFHs+hYADD5KXbc9b/gXZGBbgvdAmTkPI4JFSMQVG2V6h7Hf6VeSwgXSMHQ9/loktrin1i
 1pRcXX7lUUy2dxE1+ZIItCHgbvQkv96yAExeODaea6vwMMdQHyWDnG1Zb2gc1tDmGwBBk1Ff9
 pt2ITcS8mDiPhQYK7tOeqX1HJCGFuLibKtLs0zBK1gi1PGeqHZ6QOjllCU7mu3IzMniI8jzBR
 GXs1WOPEykkYqu+5lC5w/lX8cRFtbpXK65DKOysOh64W5hQpFLC1XbIQM0asOtpjyOxRhb3p1
 62HlMuzf6fzpbLa5MMv5/7jn7k6Dv9n+PzqFe2QHEO7/htH7EJmb1MzMLiUVc100iOu9LVYe9
 1EEKvbjYoa/gHD+u0MFI6SGPQACmgol1kCcyAWTfz4goMEm7n012ptQNNpaGv2z7ArBeOQ6G5
 GGTc2QYZWO60j/vwGP9prWTE40k92VOb67wJrqFUjFBipQLQg+t21sD4ekLXixyfQ7G4GmiuR
 v/8tE0fx1cbTqEhVuKw304KGZVKQKvoo8/OweRywANlE/Sz7psQmlRHGwaibdEypX+HiqK3mC
 pAuMOgubDC1Ws91Ma6zgrrb8f7Hl+9P/5xD8DoC2zHLN5JrfWEBGrofAltaBX3hcb6JxmuO70
 b/M2ndLKC0cFXMAfXaXaEWjrNee7/1m5vpY5Oie09QfO01a/hWFDe269piQG/WHlggXinGEqA
 4hEwZcqA3MhQLVAehcHvONljLczJseGdKQ6uHVlP0XR6SBhGz3B1DIASGzOY1ywrJOFxI4Dma
 B2h8vxf8vUOfJuCB0pxw7dGETqdEZXkKEkVVNe6z3jo+quR+xsiiLes2hwZqBalajPx8DEEZl
 l3cIeUR2dtueboS/XxFPXZCuMr3rhPa+ObA7/QmR4zFcXnnNIevhaDQ5La0ia5nwIfjXgUp2K
 Lb+uy35MTlDAtU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi James,


On Wed, 1 Dec 2021, James Limbouris via GitGitGadget wrote:

> From: James Limbouris <james@digitalmatter.com>
>
> check_parents was taking all of its arguments as a single string,
> and erroneously passing them to cache_miss as a single string.
> cache_miss would then fail, and the spurious cache misses it produced
> would hurt performance.
>
> For consistency, take multiple arguments in check_parents,
> and pass all of them to cache_miss separately.
>
> Signed-off-by: James Limbouris <james@digitalmatter.com>
> ---
>     subtree: fix argument handling in check_parents
>
>     Hello git developers. Please consider this small patch that fixes a =
bug
>     introduced during a coding style cleanup of the subtree command. Cha=
nges
>     to the argument handling were causing check_parents to fail when mor=
e
>     than one parent was supplied, which led to a small loss of performan=
ce.

When I look through the commit history of `git-subtree.sh`, I see that the
change was introduced in 315a84f9aa0 (subtree: use commits before rejoins
for splits, 2018-09-28) (which was not really a coding style cleanup).

The change was actually not done right, if I read the commit correctly,
because it added a new parameter _to the end_, even if the
`check_parents()` function took an arbitrary number of parameters already.
And indeed, it changed the `"$@"` into a "$1", pretending that only one
parent would be passed.

Now, I do not really understand under what circumstances multiple parents
could be passed to `check_parents()`, but I think that it does not matter
whether you use `--format=3D%P` or `^@` (the former was changed to the
latter in 19ad68d95d6 (subtree: performance improvement for finding
unexpected parent commits, 2018-10-12)), you can always get an arbitrary
number of parents that way.

The natural thing, now, would be to move the added `indent` parameter to
the front of the parameter list, but I see that there was some cleanup in
e9525a8a029 (subtree: have $indent actually affect indentation,
2021-04-27) which _removed_ that `indent` parameter.

So I _think_ your change is correct, even if I would love to see an
easy-to-understand description of the scenario where more than one parents
might be checked.

Another thing I would like to see is probably even more important: rather
than using $*, we should use the original "$@" instead (with
double-quotes). It should not matter a lot right now because we know that
the parameters are the output of `git rev-parse "$rev^@"` (which provides
them as a list of full object IDs, i.e. containing no white-space except
to delimit the IDs), but it still the correct form to use "$@" instead.

Thanks,
Dscho

>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1086%2=
Fjamesl-dm%2Fmaint-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1086/jame=
sl-dm/maint-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1086
>
>  contrib/subtree/git-subtree.sh | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtre=
e.sh
> index 7f767b5c38f..56f24000c2c 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -296,10 +296,9 @@ cache_miss () {
>  	done
>  }
>
> -# Usage: check_parents PARENTS_EXPR
> +# Usage: check_parents [REVS...]
>  check_parents () {
> -	assert test $# =3D 1
> -	missed=3D$(cache_miss "$1") || exit $?
> +	missed=3D$(cache_miss $*) || exit $?
>  	local indent=3D$(($indent + 1))
>  	for miss in $missed
>  	do
> @@ -753,7 +752,7 @@ process_split_commit () {
>  	fi
>  	createcount=3D$(($createcount + 1))
>  	debug "parents: $parents"
> -	check_parents "$parents"
> +	check_parents $parents
>  	newparents=3D$(cache_get $parents) || exit $?
>  	debug "newparents: $newparents"
>
>
> base-commit: e9d7761bb94f20acc98824275e317fa82436c25d
> --
> gitgitgadget
>
