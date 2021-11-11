Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D845AC433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 12:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCBDC6109F
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 12:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhKKMRT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 07:17:19 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40911 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230358AbhKKMRR (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 11 Nov 2021 07:17:17 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 69C875C01F1;
        Thu, 11 Nov 2021 07:14:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 11 Nov 2021 07:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=lKB7jyWiLCW5s5TtXfpYGFwFl5E
        itWqm3Zqgp8Yd3wE=; b=WYx+CFpcYYuoF9pC/u4+49K6mkTge/7SYSzJlk4fKgz
        tT8CM1Xycdosuzz/23LQYOBswuOvti5XmwZVIYu5fh8p0l9cccigQl0RqCQorV6u
        TkwBNqldal4cn8NkI+u8vlYO9JHc30z4TIQaTev+Pj+R9nI+rhDhMxjmE++ZmSv9
        a+GRy1YCinxW4iP3pGE5Gv2TlWLEZii/JEraZ2XsoFroHI6smhOkUYd/eZeh+00y
        nZzHacWbW8uEQ4VvWlt0Wj3CKcKdZvwcaEAU+ieElUuZLq2inQyJ9FRnbPDkytpo
        zEJjpSEao0Ud9pZn2+RevSlNMSIsp8u5kKtAcLrkn5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=lKB7jy
        WiLCW5s5TtXfpYGFwFl5EitWqm3Zqgp8Yd3wE=; b=mlMzJ5d/64gGZwLuvYbzt7
        DVGPfhRKoGdCZ1dyFmf2mttSeQ0uVVKt72QWG5rpM7XXpz8GbQUZnuh2rBY2uWRa
        4t/bQZdZBfK5z9zMBOuNfXtH2+ndwi9orPkoDCC2fY8/qbARzzag+/yJfM2Oa9Wu
        DqEyPe61RI/YbA/bGj7zt/06yDSkSmvOhR7wecSut3+JAg387tPyF8ZmiPOFT9ev
        cnbzmrHy+zShUEgrckr8EllTbSeC5M8qvX0T44HnSdhssMAquUYC25PoDsjCqyZt
        9JDgDwICslFzhMrJTc+Tsb4sayXzczpsWAMlU0msd4PgYVvkZMtrJNb8UvdaYJKw
        ==
X-ME-Sender: <xms:JAmNYU7hNcBh7n8D-lhh8g1_QmCKEUKasE-oeM0jZKdIwJloUa_WcQ>
    <xme:JAmNYV4eO9-1LK7X9rOfzIERSyQYK56d4ObSIFvJf2ctdGNn2kqifv0UhYZ9weOEA
    2Ss8skvb5N43ovcsg>
X-ME-Received: <xmr:JAmNYTe6fKN_jcCXbdodddXYqcsX7aTz5RhH9V6S5i7j6Qf5YyMxJA-7YGlyS3V9yr2-25a_NkD3lHVOIp6ID6aK_blU1MLpy9Wfmc_AMufSFlcnZpZNHkY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrvddugdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    eptdffjeeiudduleehvdfgteeifeelheejtedvteduiedttedvtdffffefhfdvgffgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:JAmNYZIfAE2N96YJJQTjPcIQfjHOGsItRG7dh4YXkKRAegfSrMGrWg>
    <xmx:JAmNYYJhRtguYe4RQtb0l7kMgRz6qExMcJbP68HkxQO4UvMiFPDJ9w>
    <xmx:JAmNYazsUHKMqHuo19NinXRkG7WFhxYsLH55hdRBha19hOcT77tyLw>
    <xmx:JAmNYRr8QBn-i5ejQ9_S16vaKxpHBGd_U2RsaSD-6cD5FjraPAxu2Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Nov 2021 07:14:26 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 2cd449eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 11 Nov 2021 13:58:57 +0000 (UTC)
Date:   Thu, 11 Nov 2021 13:14:03 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Neeraj Singh <nksingh85@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 3/3] refs: add configuration to enable flushing of refs
Message-ID: <YY0JC/zS/2rqbZIp@ncase>
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
 <cover.1636544377.git.ps@pks.im>
 <d9aa96913b1730f1d0c238d7d52e27c20bc55390.1636544377.git.ps@pks.im>
 <211110.86v910gi9a.gmgdl@evledraar.gmail.com>
 <20211110191533.GA484@neerajsi-x1.localdomain>
 <211110.8635o3rbdc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kaJEFsHN9X35hjfT"
Content-Disposition: inline
In-Reply-To: <211110.8635o3rbdc.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kaJEFsHN9X35hjfT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 10, 2021 at 09:23:04PM +0100, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
>=20
> On Wed, Nov 10 2021, Neeraj Singh wrote:
>=20
> > On Wed, Nov 10, 2021 at 03:49:02PM +0100, =C6var Arnfj=F6r=F0 Bjarmason=
 wrote:
> >>=20
> >> On Wed, Nov 10 2021, Patrick Steinhardt wrote:
[snip]
> >> ...[continued from above]: Again, per my potentially wrong understandi=
ng
> >> of syncing a "x" and "y" via an fsync of a subsequent "z" that's
> >> adjacent on the FS to those two.
> >
> > I suspect Patrick is concerned about the case where the worktree is on
> > a separate filesystem from the main repo, so there might be a motivation
> > to sync the worktree refs separately. Is that right, Patrick?
>=20
> But he's syncing .git/objects, not .git/worktrees/<NAME>/refs/, no?

That'd be a bug then ;) My intent was to sync .git/refs and the
per-worktree refs.

[snip]
> > In my view there are two separable concerns:
> >
> >     1) What durability do we want for the user's data when an entire 'g=
it'
> >        command completes? I.e. if I run 'git add <1000 files>; git comm=
it' and the
> >        system loses power after both commands return, should I see all =
of those files
> >        in the committed state of the repo?
> >
> >     2) What internal consistency do we want in the git databases (ODB a=
nd REFS) if
> >        we crash midway through a 'git' command? I.e. if 'git add <1000 =
files>' crashes
> >        before returning, can there be an invalid object or a torn ref s=
tate?
> >
> > If were only concerned with (1), then doing a single fsync at the end o=
f the high-level
> > git command would be sufficient. However, (2) requires more fsyncs to p=
rovide barriers
> > between different phases internal to the git commands. For instance, we=
 need a barrier
> > between creating the ODB state for a commit (blobs, trees, commit obj) =
and the refs
> > pointing to it.
> >
> > I am not concerned with a few additional fsyncs for (2). On recent main=
stream filesystems/ssds
> > each fsync may cost tens of milliseconds, so the difference between 1 t=
o 3 fsyncs would not
> > be user perceptible. However, going from a couple fsyncs to 1000 fsyncs=
 (one per blob added)
> > would become apparent to the user.
> >
> > The more optimal way to handle consistency and durability is Write-ahea=
d-logging with log
> > replay on crash recovery. That approach can reduce the number of fsyncs=
 in the active workload
> > to at most two (one to sync the log with a commit record and then one b=
efore truncating the
> > log after updating the main database). At that point, however, I think =
it would be best to
> > use an existing database engine with some modifications to create a goo=
d data layout for git.
>=20
> I think that git should safely store your data by default, we clearly
> don't do that well enough in some cases, and should fix it.
>=20
> But there's also cases where people would much rather have performance,
> and I think we should support that. E.g. running git in CI, doing a
> one-off import/fetch that you'll invoke "sync(1)" yourself after
> etc. This is the direction Eric Wong's patches are going into.
>=20
> I understand from his patches/comments that you're not correct that just
> 1-3 fsyncs are OK, i.e. for some use-cases 0 is OK, and any >0 is too
> many, since it'll force a flush of the whole disk or something.
>=20
> Even when git is is operating in a completely safe mode I think we'd
> still have license to play it fast and loose with /some/ user data,
> because users don't really care about all of their data in the .git/
> directory.

I think we need to discern two important cases: the first case is us
losing data, and the second case is us leaving the repository in a
corrupt state. I'm okay-ish with the first case: if your machine crashes
it's not completely unexpected that losing data would be a natural
consequence (well, losing the data that's currently in transit at least).

But we should make sure that we're not leaving the repo in a corrupt
state under any circumstance, and that's exactly what can happen right
now because we don't flush refs to disk before doing the renames.
Assuming we've got semantics correct, we are thus forced to do a page
cache flush to make sure that data is on disk before doing a rename to
not corrupt the repo. But in the case where we're fine with losing some
data, we may skip doing the final fsync to also synchronize the rename
to disk.

Patrick

> I.e. you do care about the *.pack file, but an associated *.bitmap is a
> derived file, so we probably don't need to fsync that too. Is it worth
> worrying about? Probably not, but that's what I had in mind with the
> above-linked proposed config schema.
>=20
> Similarly for say writing 1k loose objects I think it would be
> completely fine to end up with a corrupt object during a "git fetch", as
> long as we also guarantee that we can gracefully recover from that
> corruption.
>=20
> I.e. 1) we didn't update the ref(s) involved 2) we know the FS has the
> sorts of properties you're aiming for with "batch".
>=20
> Now, as some patches I've had to object*.c recently show we don't handle
> those cases gracefully either. I.e. if we find a short loose object
> we'll panic, even if we'd be perfectly capable of getting it from
> elsewhere, and nothing otherwise references it.
>=20
> But if we fixed that and gc/fsck/fetch etc. learned to deal with that
> content I don't see why wouldn't e.g. default to not fsyncing loose
> objects when invoked from say "fetch" by default, depending on FS/OS
> detection, and if we couldn't say it was safe defaulted to some "POSIX"
> mode that would be pedantic but slow and safe.

--kaJEFsHN9X35hjfT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGNCQoACgkQVbJhu7ck
PpQJcxAAioDvOa3nK+wANnSMAgRMFH+BMDiNAOn0ikj/ilHgusjGTGbDEzES5pRH
yiPNUa0qB7EoHTXlVlmTrVjDYrEK2Ldce9HY44BTeoax6VRYiL2xoSyFADPycqa+
yL2ofCelf0pq0YFAt2yWtXgRJmDOaRVzYYKcNYByFGFHbMpWeLwo6S5SvxglJ0Du
h7A9SDYGIdhJiuzQ5ZSKqJDeDMy7qM98IoZAvY+aJhBrbKaatKUfhBs/9/SM4wKS
m2ZVLtk6BOqdLhKxNfnVlsZOzCmJ4PbUKv6UUkQBlNUHPDo91rAwUXWOpqTGO3nK
oFXQi/miOtt/eyJiuynE+zJD39Tg7WnRgS2cFIXoTDUYAtaYAIxTQmQHc06kBMC8
e9phrgghDypc4Ht8LvXLSrZWDW906UTYsGqUnBUT6RQqNqi7HCNLVxPCUqeAAfoc
vvuJ2Juem0163oG+NwRJi1BItrCh8HDkQ/ijxhsZt44o9uDwj2yFAo2wAKGafOiF
lBa38fwxJs8fItpeKnJ8mz3AspJzkRkuHwXrlSk75ZaV9u2Sndu1HjKRprELf1te
2hU/tSf8wUMJWHc42+sXeuyIY4b7mzY67DxIxoUhWfEMAV4X6Tjr4G1Yr7rc+rCG
qbixtG1wf2rnLVdH3M3u7zqpun7UCL2DdIm6uuhzaFfkAUmoohI=
=ET1R
-----END PGP SIGNATURE-----

--kaJEFsHN9X35hjfT--
