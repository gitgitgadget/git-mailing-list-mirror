Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FACC43219
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 17:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiJMRzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 13:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiJMRyk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 13:54:40 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96F715381E
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 10:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1665683625; bh=sti7Xjx3ZDmpH/KaYnBzd5t1KiNu8AL42yNGFqSdKk8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=e4G+7uQTZUU+1ds929XWTQZ0JoPdodvj5ZXsW0J6uLBVPZzHMrR/Tp+Qb9Y7W1oW3
         S8Lvv7LpREODop6a26AwSDWOyQhw+yfMLYgYrEwt0GcRkkoEgDKks/tIfEaR2eLp97
         37uRnfPtdNkFASrnxlmdlur2TFE88e6cl0xheQjpmvi30SOdPxlClMJqZVzU+fYfw0
         H7cRIC5Ap8Yd2Cen+ZGSNEdJYsZsdIlpCdTynM96LIaHobhkYQTr2PXvW6lxqkUJvC
         +tiDG5d8HcpwqS+z3MuMMh0jShRCUZLIMU4U/xJxZnXXQ47FqGWod8bYT/uYkOAug8
         Zbp3yudeONwyg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.161]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M28WJ-1oh7ei1dhB-002Nm9; Thu, 13
 Oct 2022 19:53:45 +0200
Message-ID: <97a82675-22bb-b996-deac-3f13a91f3df4@web.de>
Date:   Thu, 13 Oct 2022 19:53:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH v2 0/2] archive: Add --recurse-submodules to git-archive
 command
Content-Language: en-US
To:     Heather Lapointe via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Heather Lapointe <alpha@alphaservcomputing.solutions>
References: <pull.1359.git.git.1665597148042.gitgitgadget@gmail.com>
 <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1T8AnlenQLbZksr93xOwKsBboyuS7Z3eTeHZXktYostAdo+0KAX
 BdSma8p7bIDxRtZqa9heut1017bGH3P/J44CL8lG4UfDB7j/GIbbUeLBZtUPG/bqmndaUdb
 xXoaaJqMrqgS+BMfKstgyKOjtB8YLGMYx/EZYPLwo+0ZOfrHkgXNSB9GOrv3CYllq902AhG
 de8oBGNUFFz8y98WvTlPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KjzV2xa1G/I=:E5Swl2uRwQRpe5vfMxUPgr
 gC0VFB77fzkVSy1B3BBKSV2atJ1HkMPqq0VIJYlco4kfaAA5YCDE+KMGoi576R8gHYPO4pLyi
 17kyCUcuKRppAWJHZzvtuCClGMql/VVTlyerw421lao3AEgas8YRsGX8QuVlvEW/jBgIsNrUE
 jPPXXzLzkBEfjU1bVwZlUvt5Heoswq1k4l4/FxXCIZ2NPdZQpLZXwoAALQiJdZuX5dRcmdmyk
 NBORKIfuXVEs5/zrRE269DkC9ylcyYjlbpUtWJhRu9DK+1j+T7KoYMpu3SOWxEW9bZvTYzCow
 X3Tf7mz3c5jECP4GBeR2zt8jk06QFeV7ZnTDIQBxZbSL2eaLfvJzHX7lQPBJZBN3Oxs2I9Aay
 At5rsNIoSsWrakOOzXFOUf8B+wUGOeigAENHsbXSsNPP3mmVSfTP3BZy9Y/Dg63pAX7YlKDpm
 w9844kKDH9S3fveovQwHdG7nqZdSpnNnBigiGVKM71h6JB8JWiLZTSSY5wsUMo5u5E91VWJne
 dg8rjho0ev1DJJub9DlC3uirhKgr2KVOxp9laSxcUzvLZndXNom7g+4zMIaGeACnrmUJIfucR
 M4bK/b5mRoFsLnK9w2QCfn8KsW6W2aFlwVKwMKl8Sbg1cG7YvyXJQabqCTCydtLVcuh4niMjx
 6BH16S/+bEm25WomghQoiVzvXzqBf1m2RZwaVilEOwO8yqa5Hv4nua6ovWnmenzW7KlLUtOes
 QGWFw5Tu87ez/bkZtFBseE9xOPvA5cyP+YeeymbMAfoTH+Q2qQn18UMX/CBsm06g8P6eFIUDy
 KGDoWP7n6ThMNgb/C5JP545HOtUV64c0JaUhKBPctaDVX5aSQA3o29wqYdmxogVIgSgkPoQTy
 7EpJN1dU7mWlKw1Kk/Muzj8HvoqpY++YXNAcTDPy9TA7UPkXtrZRpjvT5vGMwLSmiMf/PQvST
 KiSWEJ5SDnsqOIz2+/h8GiHk/DMphQ8RP1SycW4weuuwsqCrHTo0XU3l2hrIAI3T2+O5vzjyY
 vbec0v7gjun5GMmeBywbOJptjDj3sdGQ9L1Wi7N6fBdoIrv2UBocpkbeAvoUsUoxFmokOkcpC
 yYDkusYcgDbj1sUhm1poRmfDGjPADZrzlBggs12Lubc1IyVG48P6hlDroSaN74QcR0reSjsRt
 r4Fp3iaRQ/XIrgz8yFPJip5SRGvz65vcUVRBjcsIWTTjBcKEPojk+O9PVaW/mOFOwnDJ567Qv
 4pOESq/bjNs9qNrUfW9VajuXBakpmMrpnSRhQua6DosJ+vcFfnjn457iSpkW8KTCOsF3dNhSf
 JPfQOtPD5LsAo8RoBtMUlqazCn7gXdkaVZmZNRCdyE3OEuMqTJUEJ8g+QHa/UywnBTcqpLss8
 gir0RNLUAn+2gNFmMpl0Prb6bORXC4GzzNmiOQkrRJaO/f3z5mOKumyMyQBTvkkcDwhKX07iU
 LcRBqKP+cHjR1cEUVu/wb0qnJX95K8i++j312bkdVmCTSlZAXJerGHs7w2DTTtriJYAXItU8Y
 KWX+11JsNjroqHypUvTn6mDG4cZxqbMbitFDmadE0EB9m
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.10.22 um 13:35 schrieb Heather Lapointe via GitGitGadget:
> This makes it possible to include submodule contents in an archive comma=
nd.

Great!

> The inspiration for this change comes from this Github thread,
> https://github.com/dear-github/dear-github/issues/214, with at least 160
> =F0=9F=91=8D=F0=9F=8F=BB 's at the time of writing. (I stumbled upon it =
because I wanted it as
> well).
>
> I figured the underlying implementation wouldn't be too difficult with m=
ost
> of the plumbing already in place, so I decided to add the relevant logic=
 to
> the client git-archive command.
>
> One of the trickier parts of this implementation involved teaching read_=
tree
> about submodules. Some of the troublesome areas were still using the
> the_repository references to look up commit or tree or oid information. =
I
> ended up deciding that read_tree_fn_t would probably be best off having =
a
> concrete repo reference since it allows changing the context to a subrep=
o
> where needed (even though some of the usages did not need it specificall=
y).
>
> I am open to feedback since this is all quite new to me :)
>
> TODO:

This list confuses me:

>  * working implementation

What exactly is not working, yet?

>  * valgrind

What's up with it?  Does is report errors or leaks?

>  * add regression tests

This series adds a new test script.  Do you plan to add more checks?

>  * update documentation with new flag

That I can understand: Indeed Documentation/git-archive.txt would need
an update.

>  * submit to mailing list

But you already did submit two iterations of this series to the Git
mailing list!?

>
> Alphadelta14 (2):
>   archive: add --recurse-submodules to git-archive command
>   archive: fix a case of submodule in submodule traversal

We prefer to keep known bugs out of the repo.  It helps when bisecting,
for example.  So it would be better to squash the fix into the patch
that adds the feature.  But...

>  archive-tar.c                 | 14 +++--
>  archive-zip.c                 | 14 ++---
>  archive.c                     | 99 ++++++++++++++++++++++++-----------
>  archive.h                     |  8 +--
>  builtin/checkout.c            |  2 +-
>  builtin/log.c                 |  2 +-
>  builtin/ls-files.c            | 10 ++--
>  builtin/ls-tree.c             | 16 +++---
>  list-objects.c                |  2 +-
>  merge-recursive.c             |  2 +-
>  revision.c                    |  4 +-
>  sparse-index.c                |  2 +-
>  t/t5005-archive-submodules.sh | 84 +++++++++++++++++++++++++++++
>  tree.c                        | 93 ++++++++++++++++++++++----------
>  tree.h                        | 11 ++--
>  wt-status.c                   |  2 +-
>  16 files changed, 269 insertions(+), 96 deletions(-)
>  create mode 100755 t/t5005-archive-submodules.sh

... this is all a bit much for a single patch, I feel.  Giving
parse_tree_gently() a repo parameter, adding repo_parse_tree(), using
it in read_tree_at(), adding a repo parameter to read_tree_fn_t,
letting read_tree_at() recurse into submodules and adding the new
option to git archive all seem like topics worth their own patch and
rationale.

You probably have all of that in your head right now, but at least my
attention span and working memory capacity requires smaller morsels.

>
>
> base-commit: e85701b4af5b7c2a9f3a1b07858703318dce365d
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-13=
59%2FAlphadelta14%2Farchive-recurse-submodules-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1359/=
Alphadelta14/archive-recurse-submodules-v2
> Pull-Request: https://github.com/git/git/pull/1359
>
> Range-diff vs v1:
>
>  1:  41664a59029 =3D 1:  41664a59029 archive: add --recurse-submodules t=
o git-archive command
>  -:  ----------- > 2:  68f7830c6d9 archive: fix a case of submodule in s=
ubmodule traversal
>

