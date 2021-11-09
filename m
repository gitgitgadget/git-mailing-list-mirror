Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AEDC433FE
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 16:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1D976103C
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 16:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239166AbhKIQZn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 11:25:43 -0500
Received: from mout.gmx.net ([212.227.17.22]:42529 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238397AbhKIQZn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 11:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636474967;
        bh=bOSNuwVvyNfCXrJfGx+idNzhYum+z3NaiOclqYcVM2I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DqLuWV0trbwYNgy+4ns5wApa1WWdHRYJKZwTPLQ9Jjwoywl9kijW09aA7v/mrJucb
         4MA3wsApF3T0MU/Ix9TT7wqDveEb/5nZocVeeqdTYRR2T+iNSFKX/mdbt6p+myjIJ0
         ajXZK/FTYswoOJ65iEGsa2iFsts4eyQIfJZ3/+is=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.22.201.164] ([89.1.212.10]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McYCb-1mAKra1uRh-00d2Ef; Tue, 09
 Nov 2021 17:22:47 +0100
Date:   Tue, 9 Nov 2021 17:22:45 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Anders Kaseorg <andersk@mit.edu>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: Re: [PATCH v4 3/4] receive-pack: Protect current branch for bare
 repository worktree
In-Reply-To: <20211109030028.2196416-3-andersk@mit.edu>
Message-ID: <nycvar.QRO.7.76.6.2111091717230.54@tvgsbejvaqbjf.bet>
References: <a25d105a-875b-fa6a-771a-37936779f067@mit.edu> <20211109030028.2196416-1-andersk@mit.edu> <20211109030028.2196416-3-andersk@mit.edu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1285032407-1636474967=:54"
X-Provags-ID: V03:K1:kszj6UAaQBKlXb+X1YoHDKX2Lbrie1K9IYlmXMRgq8cAvDW8j/e
 6GeCWQ77/1AEyQ5FzjfeRaom+vYRBN7Vf3rFyiXeL0asJRrGueN6uVz8AULR3CJSs8M51TQ
 382KPe8XZjEpTk3RVDk8CF7PE2NLedf5foHld5jJoBCu2cliYpV3pLRkTI3odEaequYchuC
 qFzRqL4JLs4mMwmdbckHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LVxamuheNcI=:Trbdm3KB8qNSy89AIncpPN
 QF+DHbKR5C/pSe9MC+t2WdpHCoxyoB7Haata6J81V20+V6xiRez7XjwTT0y2czJcMqP1Gpzm/
 Luos3NUIh081IhhTsWW2UkN3pXRGXuwdoHSKQJHGhB8eHekkycaP2PcsVkq0HEDit3EHXeyoq
 KaSW8RX2/WD5gSh4Alx2SB7FMast6+DLevhy7/vgs2DFHf/atNbD2LkY4vU/4NHfj/H7tH5OD
 J2I2HUPimgZUC9xgVkBXKxeo8dVtq10OUbLXeLRgbjjaSIj3e3WI+Yc1BNmOux3IS1/Oliuid
 QCCYCToHJn/YEqiIkTRiSUpnZkRo8Wd31upbJUiEOEF8+zyV8hLSyHQOgdqw7iA8kkjKJewle
 QLf5j1/QS6OICL4LFcMPXQN41FZUHrCZJ8k+4EiI21yTrsfa+PeJCVKOhHT6KtpywZAiCWlEb
 Tbeb2c7DCFt+C75a6iA2qS+BOp+JS+8Zvz26L1NfQ3sfujUW4XqZmfaWZIRPyNz3jfkFGZM2i
 asfQXif7QGCPxH0aMYr1Nk+P4zoctFkCGLOAJT4TfcWVaxkdWERAm7eHAS4/JlYksH3mFqHIR
 1IwDfB9+Oom8wVBNpAZpIjEDbPHRI2DwWTbHLkP6jJpI7BOsIgHYH6xGxskJZj03F2pVmEYq9
 xghLZqLjMC+osGmUUUuJlvHNNk+nUo4j+TBJq5zkSH84CWNQEUVsfSNVctBYPywQ7QGGkcOqi
 vSP/f55B3z0TIUjH7dqaxl/3Ofzy3mCmBv/k5jXdN+wMty2vOl+u3kVFgKDMQrvh3bgg0ml/Z
 DNKYX3lXEKArXXxXLRV2bpDa2JJKene4my2HhJwGvJUlWALoc/O9bt+oHrGrD3Dm5PqwDtjTI
 YPCcvbHgld7m9KJrAQ7FXxau64k5EUF6djh5NTzzY5FFY9ATefCgZ+xXfCyLlgSYdK3W4dM3g
 WRj3IzTwLsyXRFUbrWGoAonE3QVff0WGNKqNkG/P+ZoVtQgNK//CCmCxjFAIBGaSafJ4aI+XX
 aFDRetP2RfZsfWD8zUh2n1cTFeDG53kpwASG4ERCc/eBXWRv1AnMJOgDA76kAndQsE7h3R83b
 iT/wwASo6n83x8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1285032407-1636474967=:54
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Anders,

On Mon, 8 Nov 2021, Anders Kaseorg wrote:

> A bare repository won=E2=80=99t have a working tree at "..", but it may =
still
> have separate working trees created with git worktree. We should protect
> the current branch of such working trees from being updated or deleted,
> according to receive.denyCurrentBranch.
>
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> ---
>  builtin/receive-pack.c |  4 +---
>  t/t5516-fetch-push.sh  | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index cf575280fc..5a3c6d8423 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1452,8 +1452,6 @@ static const char *update_worktree(unsigned char *=
sha1, const struct worktree *w
>  	const char *retval, *git_dir;
>  	struct strvec env =3D STRVEC_INIT;
>
> -	if (is_bare_repository())
> -		return "denyCurrentBranch =3D updateInstead needs a worktree";
>  	git_dir =3D get_worktree_git_dir(worktree);
>
>  	strvec_pushf(&env, "GIT_DIR=3D%s", absolute_path(git_dir));
> @@ -1476,7 +1474,7 @@ static const char *update(struct command *cmd, str=
uct shallow_info *si)
>  	struct object_id *old_oid =3D &cmd->old_oid;
>  	struct object_id *new_oid =3D &cmd->new_oid;
>  	int do_update_worktree =3D 0;
> -	const struct worktree *worktree =3D is_bare_repository() ? NULL : find=
_shared_symref("HEAD", name);
> +	const struct worktree *worktree =3D find_shared_symref("HEAD", name);

While `find_shared_symref()` currently won't return a `worktree` with a
non-zero `is_bare`, to future-proof the code we might want to turn the
`if (worktree)` below (8 lines outside the current diff context) into `if
(worktree && !worktree->is_bare)`.

>
>  	/* only refs/... are allowed */
>  	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) =
{
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 2c2d6fa6e7..06cd34b0db 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1772,6 +1772,18 @@ test_expect_success 'denyCurrentBranch and worktr=
ees' '
>  	test_must_fail git -C cloned push --delete origin new-wt
>  '
>
> +test_expect_success 'denyCurrentBranch and bare repository worktrees' '
> +	test_when_finished "rm -fr bare.git" &&

While `wt/` will be created inside `bare.git` and therefore be removed,
the branch `wt` won't. Maybe add `&& git branch -D wt`?

> +	git clone --bare . bare.git &&
> +	git -C bare.git worktree add wt &&
> +	test_commit grape &&

I like fruit, too! Apple, banana, grape, yummy. I wonder what's next :-)

> +	test_config -C bare.git receive.denyCurrentBranch refuse &&
> +	test_must_fail git push bare.git HEAD:wt &&
> +	test_config -C bare.git receive.denyCurrentBranch updateInstead &&
> +	git push bare.git HEAD:wt &&

Maybe make sure that `bare.git/wt/grape.t` exists? We do want the worktree
to be updated, after all...

Thanks,
Dscho

> +	test_must_fail git push --delete bare.git wt
> +'
> +
>  test_expect_success 'refuse fetch to current branch of worktree' '
>  	test_when_finished "git worktree remove --force wt" &&
>  	git worktree add wt &&
> --
> 2.33.1
>
>

--8323328-1285032407-1636474967=:54--
