Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C9D91F731
	for <e@80x24.org>; Wed, 31 Jul 2019 22:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbfGaWN2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 18:13:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:56851 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfGaWN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 18:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564611200;
        bh=aEZSsO4Y8YZvtHpdzMfeUWitPdNtlGMRaxc3/zzU2eY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LzVWddGHRa/dL9H1FvFCyBJrYOFrOfw9Fu3UYEccjqibxNHn6xtRTcuPxsBFeqXO2
         ZJks8xXu1bNAjLvb7V9V9FUjwozZEavhCkhw/0yxmSAmsdoQME9BlF3KbkhgnR+YdA
         unep8PfnnuNAZpVRTZ7aQHFZ/ssOiB/OmL+XEX7o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8IuM-1iEaEk02eQ-00vwEy; Thu, 01
 Aug 2019 00:13:20 +0200
Date:   Thu, 1 Aug 2019 00:13:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] config: work around bug with includeif:onbranch
 and early config
In-Reply-To: <20190731220204.GA1933@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1908010004130.21907@tvgsbejvaqbjf.bet>
References: <pull.300.git.gitgitgadget@gmail.com> <pull.300.v2.git.gitgitgadget@gmail.com> <ea1a746113b85bde5319c410f68fe3dc75f8a328.1564603600.git.gitgitgadget@gmail.com> <20190731220204.GA1933@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qfsMx9SRP1YcUZrLxljGXvFmVizyt6MlFpXwL4sLFsqRoErrCRH
 BYeILgyTtXt03N/uGZ/StoU3toFiE0Z416QS1m6efNpFj0IdjhYnSQdzH+vC+EW8Rxm1dDS
 PAapOzvtfgMv+00OqM2bhXjwQydHwoPF2lTSEXR3cYrvkYDhfgw7em8P8PlGr2hhO20OmIt
 bTu8wSk+Hs9fVO6gXRXCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hgFYz4UowDU=:gvDAjcZSYQHi1XrTfh/tPz
 RazgsG5/HbPP6ieduF6SmppB3iOe+Da0aL1vzf33cUSz0MDcn6OJ+s00KMAiLG99LWJC55wuf
 GVIiy/qxGTP75I2yCULolz7BdOtiOJbEWP5xtADUK7EOdHdH1orfFP5q0RljhiE2QBCD5xrDA
 V0E+7+aAEUUbpFsYPiifaY1pInXMjhURlnmX1xrZQLcs2DoQ49ts98Gmxc3DJM9fpTy/MFhiW
 v5ZMC+Q4fTru8j1yuOVhYATvAm7O0DlDLyALSxvC723IHtIS3qZYL4IiqySs9qp/X/+derxgV
 cANkXYw8LePq3LffvUkzpDyKBLgi/NIqFkJbvsVmucY80gYanQs2Xll0s9w1ATFU+l086U2wg
 nQqPH9sIKdwyUjw5IBpWT+67WE0suAuhEvZoy8DfXOec0RUkVn4XSZpOt/w8ngHbX9beNwMUD
 FTdHJWcR/gBGeLdzWWjHJHnQVLCkFVYUIlVkO6gtikLawwFEJqft4W4Pne8vpyRqsjB6J+6GO
 wQqZ1YKdClczqBR5YmlxI9RDu/7zrVar+o3NYhUU74MVOKGsPWui3If7bNcXqAHirEuYhTJPZ
 k7C8PZ1wgVQshFnt8nKyJQXAGktwu3dTs69f0AKaSC7AZ/te+BDuPqpuEOOur6ekNQDAXYHh0
 Sc3ZG8dOZLZHEw+qLOY8FDt02n0Wroz5UEfESimdluSTsruXpI/YPc3vzw3oU18A8/RD/bLrG
 pJt6aFmp5m2K4klVOKzj5Ila6J4Qtjtgnpz3GeUbd1QlKWQAKKcr6cgIybDpgAgNda5O85xHt
 ZXAaPUGn0QGDxEk0uYX2CS5uHiGihVzLgDU2rKVRcJG+0sZ33HCBSxY2e0yI06OJBGiFOH2UU
 1hG8f8ly2HxIhI3KlA/a6BMprdzaWrYLTFm7QeRF83AIf3FS6syJjIpJquSelW+eXriwzI8Q4
 tezOvy7eR27yWPp1zVDk64S/yReIxEyJtz2lRTvP7VkbqcNWA1Grm9twLS9YJq2LDdLf0YMqj
 qisEMSmPwrYBrwi7iWnR7FvM8g5qOwDCXVRzTXeLX/g5ZAZbme340Gug1UNWzvBuB/1X8dZ19
 Dnos4lzNTj+SSgjop+47peHENBzHmWhLU8e
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 31 Jul 2019, Jeff King wrote:

> On Wed, Jul 31, 2019 at 01:06:42PM -0700, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > Technically, there is a way to solve this properly: teach the refs
> > machinery to initialize the ref_store from a given gitdir/commondir pa=
ir
> > (which we _do_ have in the early config code path), and then use that =
in
> > `include_by_branch()`. This, however, is a pretty involved project, an=
d
> > we're already in the feature freeze for Git v2.23.0.
>
> This gets tricky, because some commands are intentionally avoiding the
> normal lookup procedure (e.g., clone or init, and probably things like
> upload-pack that want to enter another repo). So I think it is OK as
> long as the early-config code is explicitly saying "and please look at
> the refs in this specific direectory now", and it doesn't affect other
> possible code paths that might look at refs. I _think_ that's what
> you're suggesting above, but I just want to make sure (not that it
> matters either way for this patch).

I think we already have the `git clone` problem with
`includeif.gitdir:`. AFAICT we _will_ discover a Git directory when
cloning inside an existing Git worktree.

> As a workaround, I suspect in many cases it might work to simply do a
> gentle setup (e.g., in "help"), but we simply weren't doing it before
> because there was no use case. That obviously wouldn't work for
> something like clone, though.

Right.

And as you say, there was no use case, and I would even contend that
there still is no use case. In the cover letter, I tried to concoct
something (using a branch-dependent pager) that sounds _really_
far-fetched to even me.
>
> > diff --git a/config.c b/config.c
> > index ed7f58e0fc..3900e4947b 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -275,7 +275,8 @@ static int include_by_branch(const char *cond, siz=
e_t cond_len)
> >  	int flags;
> >  	int ret;
> >  	struct strbuf pattern =3D STRBUF_INIT;
> > -	const char *refname =3D resolve_ref_unsafe("HEAD", 0, NULL, &flags);
> > +	const char *refname =3D !the_repository || !the_repository->gitdir ?
> > +		NULL : resolve_ref_unsafe("HEAD", 0, NULL, &flags);
>
> I think the_repository is always non-NULL.

No, it totally can be `NULL`. I know because my first version of the
patch did not have that extra check, and `git help -a` would segfault
outside a Git worktree when I had an `includeif.onbranch:` in my
`~/.gitconfig`.

I tried to explain that in the commit message, but obviously did a poor
job:

    Note: when calling above-mentioned two commands _outside_ of any Git
    worktree (passing the `--global` flag to `git config`, as there is
    obviously no repository config available), at the point when
    `include_by_branch()` is called, `the_repository` is `NULL`, therefore
    we have to be extra careful not to dereference it in that case.

> The way similar sites check this is withV
> "!startup_info->have_repository" or have_git_dir(). The early-config
> code uses the latter, so we should probably match it here.

Quite frankly, I'd rather not. At this point, it is not important
whether or not we discovered a Git directory, but whether or not we have
populated a dereference'able `the_repository`. Those are two different
things.

>   Side note: I suspect there are some cleanup opportunities. IIRC, I had
>   to add have_git_dir() to cover some cases where $GIT_DIR was set but
>   we hadn't explicitly done a setup step, but there's been a lot of
>   refactoring and cleanup in the initialization code since then. I'm not
>   sure if it's still necessary.

Yeah, well, I am not necessarily certain that we always ask the right
questions, such as asking whether we found a startup repository when we
need, in fact, to know whether `the_repository->refs` would cause a
segmentation fault because we would dereference a `NULL` pointer ;-)
>
> > diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
> > index 413642aa56..0c37e7180d 100755
> > --- a/t/t1309-early-config.sh
> > +++ b/t/t1309-early-config.sh
> > @@ -89,4 +89,9 @@ test_expect_failure 'ignore .git/ with invalid confi=
g' '
> >  	test_with_config "["
> >  '
> >
> > +test_expect_success 'early config and onbranch' '
> > +	echo "[broken" >broken &&
> > +	test_with_config "[includeif \"onbranch:refs/heads/master\"]path=3D.=
./broken"
> > +'
>
> OK, so we know we didn't see the broken config because we'd have barfed
> if we actually included it. Makes sense.

That was the idea :-)

Thanks for the review!
Dscho
