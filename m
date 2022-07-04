Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCECC43334
	for <git@archiver.kernel.org>; Mon,  4 Jul 2022 10:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbiGDKqb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 06:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiGDKqa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 06:46:30 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B345ADFB3
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 03:46:28 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 9EAA2320091D;
        Mon,  4 Jul 2022 06:46:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 04 Jul 2022 06:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1656931584; x=1657017984; bh=PyletIQ7NV
        shMYSzXdSXK//D0IKF+IKDIjDVIfooPRA=; b=fP0xMCXbsrt/H+PbO6n/GIKooM
        TIZkxE9RcVRUy7A+6rUiLhldKm/gwL2TOUq6Ro2ZpQ4/ue6Ky2CLFOi+EVz3kTwT
        q/yxTW3jjvfgsAp++cctXnrwmazhN6a/K4jDA0eIWOaZfavg1ZGQgpe8N+IpTBvo
        ptUoUQXNWaRGZDUDizwAw0cFeJXtA+A9nZ6Uq4OGR7sFUPRM2sYq2KU+kC6zMaDv
        t3aH05IaK/IoAVGTMynP7WVtKXXSbRy+zTtFoenS+XybNkNLsCocB2cToAP3zX7j
        29vXm4QjRjip+Ui/xS6Ooi+1kBPTlgAA56XAOQPFis6tqsln41zGdDGAkL8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1656931584; x=1657017984; bh=PyletIQ7NVshMYSzXdSXK//D0IKF
        +IKDIjDVIfooPRA=; b=cK9kh0JmLkarU7BHlquqYCbyjGiFF1yTjPF/U3mlJ+dJ
        W+xklv2HX5X9Iu5cFOrlzMNUuC0sVAws10kwNLaGuF9fjmNgnrWgF7rs0OCcHCaB
        4Ncw++OPGv33okf4sbYnJufseCxwI+bRKzmogWvyIXzErLqaX+ZtHXfZnAMMxGzT
        gzb+qwyYdiLWU4ayKYCA79OydTKDsEYrsNn7r7J1zvuzBtFKI6h8O8uhGguJZONu
        QywkW73lbKwgxlP9xhOxnnrlXVPf0d0C0XYp2ca8F2ZJKa+M3ylRWluWGunV1cFE
        D2F7kkFRopqnzdYQYnz3THDCE7LE8K+6n/VyFZUZsA==
X-ME-Sender: <xms:_8TCYp5EK7vXGulGDdoHPMSX3J7WY_EK-uZkSRxLD1Q6VXBfwFKZSg>
    <xme:_8TCYm5HsB7je5Ddlr9lbkJ2MhpY6aagAURwuy1zR8yItfIXWsZhPsl9wlSs0khYX
    1fgoBHTSCg57-42mA>
X-ME-Received: <xmr:_8TCYgeWA6YwZTF_GIT8POb-vcaongO7gVea0wU64n_3WTrPF0L_30yKBD0Iv3_DwxALZ5NYkUDuj-mx0RB3gAKtRnW9mLiZAIsE2qPVNdZrbZTQvFKn-36q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehledgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepiedvieevueegjeelhfejffdtgefgudehueeuheekueeiheeggfelgeehgefghefg
    necuffhomhgrihhnpehpvghffhdrnhgvthdpphhusghlihgtqdhinhgsohigrdhorhhgpd
    hgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:_8TCYiKXqI2nqQyC6XZNJHRsab7PkIdcEgdsMLpQmPwdeAfZZMeOFA>
    <xmx:_8TCYtKpLNSg2rTsd5dmVcCTwjM5Vu7vR8tTZtKTAff7ThZOtNLl9w>
    <xmx:_8TCYryWFaLZCA8_X9dF0ey0q3WMDXspuT2JNRrEXp7qk0ksmxsKxQ>
    <xmx:AMXCYrik2gmJmCDXSdcGMAgGSxfCLZ1kzLh2TadoHMll9HOTvPRDOw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Jul 2022 06:46:23 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 3ac443ff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 4 Jul 2022 10:46:17 +0000 (UTC)
Date:   Mon, 4 Jul 2022 12:46:16 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: commit-graph overflow generation chicken and egg
Message-ID: <YsLE+DVa5Hd/NqdD@ncase>
References: <YqD5dgalb9EPnz85@coredump.intra.peff.net>
 <581c7ef2-3de4-eb8a-bfbb-d4bca3522a2d@github.com>
 <YqEuE2iAmMVLlUSu@coredump.intra.peff.net>
 <Yr7jY6GjUkOzHNh6@ncase>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GdTyhHBGeXpTkZ2T"
Content-Disposition: inline
In-Reply-To: <Yr7jY6GjUkOzHNh6@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GdTyhHBGeXpTkZ2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 01, 2022 at 02:07:03PM +0200, Patrick Steinhardt wrote:
> On Wed, Jun 08, 2022 at 07:17:39PM -0400, Jeff King wrote:
> > On Wed, Jun 08, 2022 at 04:08:03PM -0400, Derrick Stolee wrote:
> >=20
> > > I'd love to see the full binary, but for the sake of sharing on the
> > > list, could you give the following output?
> > >=20
> > > 	xxd .git/objects/info/commit-graph | head
> > >=20
> > > or any other command that shows the first few hex bytes along with
> > > their ASCII equivalents. Here is one that used Git 2.34.0:
> > > [...]
> >=20
> > Interesting. My earlier email was a bit misleading. I do in fact have a
> > GDA2 chunk. And looking at the timestamp on the commit-graph file, it's
> > from May 24th. I hadn't been keeping the repo up to date regularly, but
> > I did occasionally pull and rebuild. So I think it was a much more
> > recent version of Git that built the problematic file, though it's
> > possible it was carrying forward bad data.
> >=20
> > So 6dbf4b8172ef may be a bit of a red herring, if the file has a GDA2
> > section that was simply ignored before that commit.
> >=20
> > Looking at my reflog, my best guess for the version of Git that produced
> > the file is e46751e96fa.
> >=20
> > > However, the lack of the large offset chunk could be due to the bug f=
ixed by
> > > 75979d9460 (commit-graph: fix ordering bug in generation numbers,
> > > 2022-03-01). Perhaps that was the thing that was missing from your ve=
rsion?
> >=20
> > So I _think_ I would have had that, though there's a good chance that an
> > older version of the commit-graph file was written using a version of
> > Git without it.
> >=20
> > > But otherwise, I'm stumped. I'd be very interested to see a repro fro=
m a
> > > fresh repository. That is: what situation do we need to be in to writ=
e such
> > > an offset without including the large offset chunk?
> >=20
> > Not exactly a fresh reproduction, but you can grab my broken file from:
> >=20
> >   https://peff.net/tmp/broken-commit-graph
> >=20
> > Dropping it into a fresh clone of git.git shows the problem.
> >=20
> > I tried a few obvious from-scratch reproductions like building a file
> > with 75979d9460^ (so with the generation number bug), and then jumping
> > forward to e46751e96fa (so bug fixed, but now we write GDA2), but
> > couldn't get it to trigger.
> >=20
> > It may not be worth spending too much time on, if this is a weird
> > one-off caused by a mix of buggy unreleased versions of Git. If real
> > users aren't seeing it, and we know the nuclear option is "rm
> > commit-graph", then that may be enough.
> >=20
> > -Peff
>=20
> I have also repeatedly run into the same problem. I had already
> discussed this with Derrick in the past in [1], but back then we also
> declared bancruptcy and said that this seems to only be caused by some
> weird in-between states of Git versions.
>=20
> I have experienced the issue again in git.git now, again without having
> a clue how I arrived at that state. The funny thing is that I explicitly
> tried to reproduce the error in that repo a few days ago, without any
> success at all, by writing commit-graphs with different Git versions.
> Only today when I got back to it completely unsuspecting did Git start
> to complain.
>=20
> But more imporantly, we started to see the issue in one of our repos in
> our staging systems as well [2], where we're currently running with a
> mixture of Git v2.35.1 and v2.36.1 with a small set of patches on top of
> them. None of the patches are related to commit-graphs though. The repo
> in question is a pooled repository (like last time I reported the bug),
> where the pool itself has a single commit-graph with GDAT chunks and the
> pool member has a single commit-graph with GDA2 chunks.
>=20
> I spent a lot of time today to try and come up with a reproducer to get
> to this state from a clean repo, but again with no success so far. Also,
> staring at the code for extended periods of time didn't result in any
> insights.
>=20
> This issue continues to puzzle me.
>=20
> Patrick
>=20
> [1]: http://public-inbox.org/git/Yh3rZX6cJpkHmRZc@ncase/
> [2]: https://gitlab.com/gitlab-org/gitlab/-/issues/365903

While I still haven't been able to reproduce the error, I did find a
different error. Here's the reproducer, which works with Git v2.37.0 and
older:

```
+ rm -rf /tmp/repo
+ git init /tmp/repo
Initialized empty Git repository in /tmp/repo/.git/
+ cd /tmp/repo/
+ GIT_COMMITTER_DATE=3D'2000-01-01T00:00:00 +0100'
+ git commit --allow-empty -mx
[main (root-commit) 62ebc8d] x
+ git branch other
+ GIT_COMMITTER_DATE=3D'1970-01-01T00:00:00 +0100'
+ git commit --allow-empty -mx
[main c628d6d] x
+ GIT_COMMITTER_DATE=3D'2040-01-01T00:00:00 +0100'
+ git commit --allow-empty -mx
[main 0d73218] x
+ git commit-graph write --reachable --split=3Dreplace
+ git switch other
Switched to branch 'other'
+ GIT_COMMITTER_DATE=3D'2000-01-01T00:00:00 +0100'
+ git commit --allow-empty -mx
[other 7d03e12] x
+ git commit-graph write --reachable --split=3Dreplace
+ git commit-graph verify
commit date for commit c628d6dc7292b6d481f0ec4ed39ed2bb4a8cff49 in commit-g=
raph is 17179865584 !=3D 18446744073709548016
Verifying commits in commit graph: 100% (4/4), done.
```

I may have a look at a later point at what's happening, but for the time
being I'll continue to hunt down the other bug. Still wanted to document
my finding out here.

Patrick

--GdTyhHBGeXpTkZ2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmLCxPcACgkQVbJhu7ck
PpQEeA//UZcLeKWWiD0PvJ9y5PxfFgmcSHF2hojHwSQKmPl9zt3frQ7tBuek8ZtI
ekWcoP6GMmKObmUTsuRqawEw1XoWnwbZsZWiIGsUOocTNXodkbwFsWltxAwlxtk/
7QVzr1gsVbkr2+4Bqtj/JwY11uHzkQoBvw/a1+zBAkTXH7nYf/9F+5xsYJfCaj3i
6xdXa1VV7zPAi64FY+zzUhI7FA18YoDUXJv3TtjW6+W9beLs1K8J1TlJ46/lKJiJ
ivC1xdetZmluvmUXziAWlG3O81XAesZZtdFHPOE1qCvIGoVld4YW6tgOPaPUr/n+
a5u6K1HpouGwl9kFE4JA75/sFeA0ryeKAwsfeFr1B3bEFLmpbRr6iIGGibO26lvt
nQJNDqkl47rz1ishCU8NBwIyVH94NUb2zIZY/x7eqPBRoW782oZ4LoP/oOMbVb8B
lO3GvS8S2ELfAElfFlc8oigEhHK5XUq1ezV6M86VJZEPGz+Nl+PSJIsBSy1CnOiJ
4xJfWS+tC22YrMuKRghh/Ff7o2b289Ss/3cIWUJC1tfr7hJhZM8WPDFnbAQgSB4t
wYX/H5wfZAKkBroBbIZmID+sozMXTCXtP/RW1XEnD/3c7IrAKijY0cILi3u+wPg1
Y19FHW+Riuv6VJwEk8Rz1CdcHo03f6MAJeVMjQbAuAJ624K7duM=
=VzOk
-----END PGP SIGNATURE-----

--GdTyhHBGeXpTkZ2T--
