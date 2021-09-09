Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F28FC433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 11:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CF9261104
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 11:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbhIILWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 07:22:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:60489 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234216AbhIILV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 07:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631186441;
        bh=nVcIUkWtzWAf99ySkBp6dabSAslgKw0WmBSK+xKCjLw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cs3giM62OtZisAdbYimZWNxqrNNko5m1hbHR2yu83W0wkvtKobil0yVWmlwtqXL91
         1BGfaVYPi1zqo74iDKDIlrR827ZNFmcceyuIW7K0yNnOZyVx1UqPbsWsRcFtnccc4M
         L2SxP6rPe81s77AsOqghMrlTPFXnv20ovmmCY4Wc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.174] ([213.196.213.44]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5mGB-1mzjPv3rwp-017AYj; Thu, 09
 Sep 2021 13:20:41 +0200
Date:   Thu, 9 Sep 2021 13:20:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/2] pull: release packs before fetching
In-Reply-To: <xmqqh7eu3mjb.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2109091319170.59@tvgsbejvaqbjf.bet>
References: <pull.1032.git.1631089771.gitgitgadget@gmail.com> <0e956ae7bba906277c77103ae329bce6d6da4cfe.1631089771.git.gitgitgadget@gmail.com> <xmqqh7eu3mjb.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dGoINlB9NsaZ6CBLFMVr1cczZGXnqiq/a6ADF5DOEyguWDV0p3n
 sYJuxWa0BICbNk58G9V8sj9EQO711B0ezufRo4YN2huM9CrM3icE+EYorpnT3ix+P205H/m
 TouPsG6mbm2kG4gNRokportV+Ex6whFLRHmKBKnnCGWJ+xAQaToXxonx2VNCYBzNc3IT6Jc
 a1WTdZHFed/QUttferuhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BgUR0bY6KPs=:fLF0oBIYYIbPmBiH8gHBS2
 rDSHdQReGaswbicVUOhacOGUe3BnjLiBe4qdw748DSq23sSX4yKamDicLky5WWBpeuwl3aufR
 dm4o3Yl2wP3bYWwJ7K2Fii2a90JgiZz3k4HtcrHiK/JQvkBVccpHuXhEo/XJOZaI5LsqwWYvW
 KCG7Jbziz/HmWAbRtb/Q8bnRCw8Ruc4UJqBrQXFfS2rOrE43cKVfrkE+eujstVR2VhmYAM4jA
 y1XG4KvZaqagNPGDa6rBj+u2M3vbxSGML2rHkBL01V46MBZmkERMplN40f7IlLPSghxCjB+yW
 amIyv72pSNWnsAbBufWAko/9PTNNWy3FFr0lpGtRYAoX90YyMx35fwsB2oANan9+cqmNyXaR1
 YBreCW0/T+5apMdM9pVbxJlgKLtfGzVlgsjuBjSIkWVq+fO6X5zKxAakdGiWrKXFRjWx/N/2C
 sRHIHkPrG5poOnOZl5WjBaEcyHbK8LJVk3Y0UgsMBu7P0s4dFw+W7gCJJ1j/DRPLQX/LCVMmx
 wwlvMUanZNjyXHVOs/bTlr4V4E/pGP2acZuK8zDPHqTp5peh1gEgNSWcfQ6UD1FUnupM6Mhdm
 Y3/UHtFb3Ca/du4jbZw5DomorXpav65/gYecj1yUL+FqbZ8ncWY1mpiuzBUXQXFcm/9bwminU
 D1LJl/S/ROF326YKAEautCLI6bkPY/cEvCYxk8WA1Ej6nn3+DmKy59mYsyO7DcrC9wikllN5U
 DJKQyqDUy6f0JgMMI7ZBaiyJvmNqJNMYKH4HH4T+dIZncMH80ngbItqsO59ngCbj6aHELYO1F
 f+ysDajWQRca8Tas45I7vLNoJzSLyaHjihbwC45ZKfr4pIKa7ofS/dMPB/98PiCHmRugR2u0t
 Aiyxv8VMRQVaSSp1yyf1Ioi9O10bTOP0XAYBdcwhdLEE1l4P854J2qt+Sw25b0X2lF+Rc7TzJ
 3E8nM1ciWrIg93VRbT29RkzK9zRncFbW+epoB0lNZhEdkBHqtjgVc/4XoxU3ZuMfjeAP5PS0L
 U1zcfANyKeg55lU+BbzySoHEB2FxP51LL744+3BhSuZWzmEUsBgP7cKK6H/YRo8K5uAtik7sx
 W8rgMg4kpBjQ8k=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 8 Sep 2021, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > On Windows, files cannot be removed nor renamed if there are still
> > handles held by a process. To remedy that, we try to release all open
> > handles to any `.pack` file before e.g. repacking (which would want to
> > remove the original `.pack` file(s) after it is done).
> >
> > Since the `read_cache_unmerged()` and/or the `get_oid()` call in `git
> > pull` can cause `.pack` files to be opened, we need to release the ope=
n
> > handles before calling `git fetch`: the latter process might want to
> > spawn an auto-gc, which in turn might want to repack the objects.
> >
> > This commit is similar in spirit to 5bdece0d705 (gc/repack: release
> > packs when needed, 2018-12-15).
> >
> > This fixes https://github.com/git-for-windows/git/issues/3336.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/pull.c | 2 ++
> >  1 file changed, 2 insertions(+)
>
> After run_fetch() returns, we then go on to access objects from our
> object store (that's natural---after all, we fetched because we
> wanted to access the objects we have plus objects they have to offer
> to us) and the object store is transparently reopened for us.  Which
> may make a bit confusing API to newbies, but is an easy one to use,
> once we get used to it.
>
> A few general comments.
>
>  * Right now, run_fetch() does not do anything that needs to access
>    objects, but there is no reason to expect that will continue to
>    be the case, and once we added an call to an innocuous helper
>    function that happens to access objects, the close_object_store()
>    call made by the caller before run_fetch() was called becomes
>    moot.  The more we can delay the call to close_object_store(),
>    the better.  And the absolute last point we can defer the call to
>    close_object_store() is where immediately before run_fetch() calls
>    run_command_v_opt() to spawn "git fetch".
>
>  * Which makes me wonder if we may be better off having a bit in the
>    flags word the run_command() API takes to make a call to
>    close_object_store() for us.  run_fetch() that uses the
>    run_command API can use that bit without having to worry about
>    making a call to close_object_store() itself and when.
>
>  * Hits from "git grep -A2 close_object_store()" shows a notable
>    pattern.  Before run_auto_maintenance(), we often see a call to
>    it.  It almost feels (but I didn't dig it deeper) that a call to
>    run_auto_maintenance() that does not call close_object_store()
>    before doing so is a bug (there is one in builtin/commit.c).
>
>  * Which in turn makes me wonder if these many calls to close before
>    run_auto_maintenance() should be moved to run_auto_maintenance()
>    itself (which in turn can use the new flags bit in the
>    run_command() API).
>
> Sprinkling yet another call to close_object_store() as we discover
> need for doing so like this patch does is certainly OK, but as we
> add new hooks and higher-level commands, it will get messier and
> messier.  It probably may make sense to go in and clean it up,
> hopefully guided by the above observations, either before this
> "fix", or soon after it graduates before we forget.

I like those ideas, and submitted a follow-up patch series.

> Will queue, but will not merge down to 'next' until I hear an Ack on
> the commit-graph stuff.

Thank you.

For procedural reasons, I would like to keep the current patch series
as-is, because that will free some mental space for me maintaining Git for
Windows (where I already merged them, after a contributor verified the
fix).

Thanks,
Dscho
