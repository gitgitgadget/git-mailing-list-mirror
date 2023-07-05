Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FEDEB64DD
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 14:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjGEO2A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 10:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGEO17 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 10:27:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AA212A
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 07:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688567272; x=1689172072; i=johannes.schindelin@gmx.de;
 bh=+/lV/0yEyxXJCEbVmN0jMycfx2Ape4WgFTXAjd5RYRs=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=dippGurT2N6fwqQtoaVJ3BMthx3HVxeHvqkuwyu9aP9/4pghiDftQImTfKrjFHU4qj/QcgD
 g6advAwqLeZjbI7Ik0YEl8i4Rc6yiPaP9ukY6bQWy/N3yck13Ttre+Mhsww5q/h8HDFQsu16B
 J4t68kHLnLVaRNy8czYrrSmiS7uTRwMJCQvLfsZUXiBwT+TnHNsGWT0hrAeIuhvP/iJkHR5Rs
 1/Hst7VfwBx0lmgD4g33KUGdfy/+YwT3j5THDzEMBQ0T7oqlk1qT88J5D9rSIu4PdQ99tkOrT
 FZnVmn4yVrEb661DxHzItjNKfUu0PJUGMVKBpsHu3x5E4Zse9+BA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.64]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2f9b-1qIPzj0wPP-004DG4; Wed, 05
 Jul 2023 16:27:52 +0200
Date:   Wed, 5 Jul 2023 16:27:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jeff King <peff@peff.net>
cc:     Tiago d'Almeida <tjamadeira@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: index.skipHash doesn't work with split index, was Re: Bug
 Report
In-Reply-To: <20230629083859.GA585934@coredump.intra.peff.net>
Message-ID: <3b9165a7-e37e-f429-bbcb-1b95aa9731fc@gmx.de>
References: <CAO=RawtAvOna1xrBNY+T-fo4UQe-ipC6OvFODvOSdu4wUML3Ng@mail.gmail.com> <20230629083859.GA585934@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8taY+v8JWriDBlw+ZLHY3tYh9hE7oBUADFP4WT7pVJC6VehZblm
 eWZdYUvQAqU9U1gT+jxWU5nwFmmwSClKd+WlrzWAmVNKNJ/QxDVOGA/aOlZ7/z2kc/skP26
 LOkgUVohGKZ+5XcRfL/3hnoBSIMauJ6adATYyqlZuDAU99AZ37+glNJlfzBzlpNlXDwGE2b
 Xw9zCI4Rk3HJeZ2I3Ne6w==
UI-OutboundReport: notjunk:1;M01:P0:pIDGhccIxTQ=;8A+Q4PnCpTPrldHhifgKW5FhDQz
 NCEe2XV9aForsNDm5RuPOD0iAxUO7EuO2MxBQJZMsPwPso7ggUotAd3HoD9XZuwWH1NKMTPkm
 TbbkXnAoMj48VfIoceasMnIed/igPc7Sqo+fIKffb8yLdUEQgDZzoPoos4y1UTvq01mxjoT4P
 fpxi8I3LhzLoEKlcFAT4DEHo+CDUkBVxKfCcES81CqHEu0E2a+3MiAzqGaWN3GLn+Ms2fqzSK
 2Lqvx30xdeIJRVyCxH39uVzp1+OI625xj7fATQrkH11QvsNOsDIwNJmsVsqyBWVoSh6Fm1GGJ
 /gmItCaya2YaVe/BAsr916ABD3VweC7+I0yNyxGNou86qN5mJiJa3/E2UZ35IFeRj198qxwdT
 jvcU+cIhtpalii6lR/EAC64jkgxDeuKcU+lAVVqKwa/mlQfBkPOpiDPNA0VU+0AXV2uh1yGfT
 asMSc7DF30w7JQLrj7jyGECeRMCoWdudASbM1Vxm/GmQIvreJXyr7P8La5qMKTZyqVBUtaPHK
 LVfBBNhNkpZkUIxFynKesnnqziFqL+d/+TxMpL9GcpDE/nLS+MHR/6LCrU/H/boRH21rs4ZYe
 a3rdfI1hwfRVPYhoXCpbmGfGk3IJnjnZ9xmjB9l+7Mt4h6R49MKssi7e7/XFuMjQ+RI7EeR45
 +GcUo4ZZ+IG4VzzVff+QGz2mp31NBuW5wQTOqjWUfEygK5PueYXgzZr9fUvSGHLPF9BwLCumA
 gtERqe11MsMas/2Mi76L94i1Nf0gZAE9Zjsy4g1iwyh7TW9Zgrn1LeBqSDTSsomgtw+4+Nzrp
 4HliCbsQwvos7tRnBQJp2hMrJaIvHtQ8+23MJqsmOyGd/79yselc9vOqkFRK+7/fZBNCg+j9N
 Bk7TF4vOnHtSJSJJUNj6kUM/fxtVzIPo8F33JAbFhw226xvNW4E0FNgqbXxiANPYPSyPc8NyX
 0WfGIskXKs2R+tUYOMDohk1wwEw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 29 Jun 2023, Jeff King wrote:

> On Tue, Jun 27, 2023 at 05:02:30PM +0100, Tiago d'Almeida wrote:
>
> > Attached to this email follow the `git bugreport` and global `config`
> > files, and the git_bug repo.
>
> Thanks for providing your config; it was very important to reproducing.
> The bug comes from the combination of "core.splitIndex" and
> "index.skipHash" (the latter is triggered in your config by
> "feature.manyFiles").
>
> Here's a quick reproduction:
>
>   git init repo
>   cd repo
>   touch file
>   git -c core.splitIndex=3Dtrue -c index.skipHash=3Dtrue add file

I ran into this issue while debugging the `commit -am` issue I worked on
in https://github.com/gitgitgadget/git/pull/1554.

The reason is that `write_shared_index()` calls `do_write_index()` without
any additional flags (see
https://github.com/git/git/blob/v2.41.0/read-cache.c#L3300) and
`do_write_index()` heeds the `index.skipHash` setting always (see
https://github.com/git/git/blob/v2.41.0/read-cache.c#L2900).

I briefly experimented with this diff, which is ugly and should not be
used as is, but it seemed to fix the issue for me:

=2D- snip --
diff --git a/read-cache.c b/read-cache.c
index ee6bcf40351..92a4aa2f25a 100644
=2D-- a/read-cache.c
+++ b/read-cache.c
@@ -3292,14 +3294,17 @@ static int write_shared_index(struct index_state *=
istate,
 			      struct tempfile **temp, unsigned flags)
 {
 	struct split_index *si =3D istate->split_index;
-	int ret, was_full =3D !istate->sparse_index;
+	int ret, was_full =3D !istate->sparse_index, saved_skip_hash;

 	move_cache_to_base_index(istate);
 	convert_to_sparse(istate, 0);

 	trace2_region_enter_printf("index", "shared/do_write_index",
 				   the_repository, "%s", get_tempfile_path(*temp));
+	saved_skip_hash =3D si->base->repo->settings.index_skip_hash;
+	si->base->repo->settings.index_skip_hash =3D 0;
 	ret =3D do_write_index(si->base, *temp, WRITE_NO_EXTENSION, flags);
+	si->base->repo->settings.index_skip_hash =3D saved_skip_hash;
 	trace2_region_leave_printf("index", "shared/do_write_index",
 				   the_repository, "%s", get_tempfile_path(*temp));

=2D- snap --

The reason why this is needed is that the shared index _must_ have an
identifer that the split index can use, and that's that index hash.
Skipping it breaks that pattern.

Probably a much better idea than above-mentioned diff would be to add a
new flag as a sibling to `COMMIT_LOCK` (i.e. here:
https://github.com/git/git/blob/v2.41.0/cache.h#L346-L348) and use that
only in `write_shared_index()` to force the index hash to be computed and
written.

I won't have time to work on this, though.

Ciao,
Johannes

>
> That should add "file" to the index but doesn't. Removing either the
> splitIndex option or the skipHash option makes it work. I didn't dig
> further than that.
>
> Adding the author of skipHash to the cc.
>
> -Peff
>
