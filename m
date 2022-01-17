Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E863AC433F5
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 07:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbiAQH4i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 02:56:38 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45699 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235240AbiAQH4h (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Jan 2022 02:56:37 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 3F1705C005F;
        Mon, 17 Jan 2022 02:56:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 17 Jan 2022 02:56:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=JVkSnNLOx2w0G2Fwil1r9KXmY9j
        LbdkGiUXqMZ74fFc=; b=vaujYqT2a3AAK1vVdGfZIzmAvpcwbNBHqMeJ9nC6q3e
        Xk+Hd+zDRQmVnQhiRbDdKxy3qHmEJaBfLl8gCkNHZ89BESvoCA2OazVLiX0UZFhO
        m9nO0kFZ53NtAI+HO7YMc0CzcFqdhDgGgLQTuuWBAy7oR6IbopCvlEnvnP5jNkyq
        W6lZHvlVqzawQU871B/om0E4w9BTMuIA01vPOh3JFUnr6DVQLkiWy3MorKnPIToP
        AlKbiNjTS+qzV4lvqdJffpoOEhOsQDodFt8MLH4QDAUULU8P88nSBYXFufwwLXVB
        ohKi5PZ7d7Bcrr99ouJBclVTCLWZkw2+oUcIGaMGiZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=JVkSnN
        LOx2w0G2Fwil1r9KXmY9jLbdkGiUXqMZ74fFc=; b=Y0FdNC7AFDwTAfPgGCPcdQ
        Hor+si4a1i7PGEgjiAaUhQoVIabI6sWi2sJcP5t+urvdoaMWLtg9vhdgltiYdlhf
        SZedLOEG9ysClRy5VGJFVno2g2GfVKBWc8RmdgBjV7VxWBgx25TMtDTBkrcPt2qc
        Lt1ChWVWRDpuHkRjq/Ib0AU8RMucbR/UcXgU+fp5JYTNPyIxmCwYCylQauUvdUTR
        ukkvQWCpixkKUx1CS+VcF1HmDjGge34q8r6J/HclqND4QtOzEnzGPP/1BDfTf22W
        O2wya65v5HNhmlyG4Bc6g6YqIfexJy4tNvcBkAHuZvLFINLLXh6eqTBBmrVmoZcA
        ==
X-ME-Sender: <xms:NSHlYWC8_MTyhueuVecAYSskyp7ZFklckhlzl2uDGR7cwjU-L-V91Q>
    <xme:NSHlYQiRUCF38lICkxE3c4--O-wZ5rjLspXRHBUgXM3TffVvEoNB-UR87SFkgs0Ar
    I4M2wKrnWX3C_VXTw>
X-ME-Received: <xmr:NSHlYZlIWyx8GDMRWwak4FGedEvkPjfhCpaIj-yL_OHw6_EJbqnnFFW_rsVmk9VI1Uev36NbB7GxZ8N-ntO98AgeayOHuHuUm1V9ETFpXgmtX95wHHe_bA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedtffejieduudelhedvgfetieefleehjeetvdetudeitdetvddtfffffefhvdfggfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:NSHlYUzLBsbqG2ADaSUsu-8xv2XzN_dI24IJdcmunJ6KUd-csnYNkA>
    <xmx:NSHlYbSb3vlG7K-Gf8wBRxGEaB4fTHtzO94V8GMkoqQGFEN4ouh2bA>
    <xmx:NSHlYfafgoY2PBcld7t2ZK873-0fzBWj4kgZ-0IZ45ae5F-A0zDJlg>
    <xmx:NSHlYZOk79kLhBJ7UUR0Z1R6JP8j4gzwCiUW4SqRTs1UkX2l-zBH-A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jan 2022 02:56:35 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 7a00b1c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 17 Jan 2022 07:56:33 +0000 (UTC)
Date:   Mon, 17 Jan 2022 08:56:32 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 6/6] refs: skip hooks when deleting uncovered packed
 refs
Message-ID: <YeUhMPSlC/X6HRBF@ncase>
References: <cover.1641556319.git.ps@pks.im>
 <cover.1642054003.git.ps@pks.im>
 <279eadc41cda9ceea4c5317d6a4c358c18d50ce9.1642054003.git.ps@pks.im>
 <220113.868rvjvkyn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ly0PiR4Rl4jVrxY3"
Content-Disposition: inline
In-Reply-To: <220113.868rvjvkyn.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Ly0PiR4Rl4jVrxY3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 13, 2022 at 02:04:38PM +0100, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
>=20
> On Thu, Jan 13 2022, Patrick Steinhardt wrote:
>=20
> > [[PGP Signed Part:Undecided]]
> > When deleting refs from the loose-files refs backend, then we need to be
> > careful to also delete the same ref from the packed refs backend, if it
> > exists. If we don't, then deleting the loose ref would "uncover" the
> > packed ref. We thus always have to queue up deletions of refs for both
> > the loose and the packed refs backend. This is done in two separate
> > transactions, where the end result is that the reference-transaction
> > hook is executed twice for the deleted refs.
>=20
> But do we (which would be an issue before this series) delete the loose
> and and then the packed one, thus racily exposing the stale ref to any
> concurrent repository reader, or do we first update the packed ref to
> the valu of the now-locked loose ref to avoid such a race?

We first commit the packed-refs file so that the stale ref is not
exposed.

> > [...]
> > Fix this behaviour and don't execute the reference-transaction hook at
> > all when refs in the packed-refs backend if it's driven by the files
> > backend. This works as expected even in case the refs to be deleted only
> > exist in the packed-refs backend because the loose-backend always queues
> > refs in its own transaction even if they don't exist such that they can
> > be locked for concurrent creation. And it also does the right thing in
> > case neither of the backends has the ref because that would cause the
> > transaction to fail completely.
>=20
> I do wonder if the fundimental approach here is the right
> one. I.e. changing the hook to only expose "real" updates, as opposed to
> leaving it as a lower-level facility to listed in on any sort of ref
> updates.
>=20
> In such a scenario we could imagine adding a third parameter or
> otherwise flag the update as "real" to the hook, so a dumber hook
> consumer could ignore the more verbose inter-transactional chatter.
>=20
> I say that because this change does the right thing for the use-case you
> have in mind, but if you e.g. imagine a more gentle background-friendly
> "gc" such a thing could be implemented by backing off as soon as it sees
> an ongoing transaction being started.

I've mostly been acting on the original report by Waleed. And I tend to
agree with his report given that we also got a workaround at GitLab
which filters out reference transactions which only consist of force
deletions because they're likely to be pruning refs in the packed
backend which are about to be uncovered. The result is that execution of
the reftx hook is dependent on how well-packed a repository's refs are:
when refs are packed we execute the hook twice, whereas we execute it
once when it's not well-packed. This is surprising behaviour, even
though one can definitely argue that it's just working as intended.

I think ultimately the question boils down to whether we want to treat
the files backend as a single compound backend and whether the reftx
hook should treat it like that. If we treat it as a single backend, then
we shouldn't report a change in refs when pruning about-to-be-uncovered
refs given that it wouldn't have been visible, but it's only internal
cleanup. And neither should we report ref changes when repacking refs
into a single file given that from the backend's perspective nothing is
about to change.

Patrick

> With my ae35e16cd43 (reflog expire: don't lock reflogs using previously
> seen OID, 2021-08-23) not getting that more chatty data should be be OK
> for such a hypothetical hook.
>=20
> But we might have more avoidable tripping over locks as the gc and ref
> transaction race one another to lock various things in the repository.
>=20
> Or maybe nobody cares in practice, just food for thought.

--Ly0PiR4Rl4jVrxY3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHlIS8ACgkQVbJhu7ck
PpQICw//ccSLG4kNtAa7zxJcEwTvuNlB/dpZIjASukeZbSO6XWt2V5/SSnF5aLS0
r68+jpx7kGnRU5SavvUXWxBJrQ3YoQkvAOxkhy86u9DLt1z61pgsUHMjC5m3qRsb
cIKIV2NUc4eAAdBJJTKXsNnYtFyjZFVYA11zNBxHmjuyXvYlsHT1Ls4J171Br616
M3cnjvIAo6BgX5P3yNozkCz/4VcDS+dvud/kc0IjTrOmz2raPWyJFRDzcdij+Tna
7R4k/CWs/mhqIpbtY7AjWbEodiiJQEgQvB4lxr10QCsMw+tkKDMl32Z33OEaqnYq
IUtI8V07kKTVlfwgwkOtz/DgHbEsZJMrv2h3yU5Gm1tvEPA+6x/aCtFN6+NSN5Lq
kIuL5oABVHQKzpifBIl8KXzqjHiOLvJlbhkq5dUbVm8P8hUFeHMQ9Dr7CH9y3pl4
7+SUq2BcJCl0ISU4HYjdL2zss53riwKKN/O2R6LsQP3e8eYk+OFLU4F6pYImBu4U
juBdRVk7pfs6BBJanaFJ64MWnZ7um2VMIRnefVp3uWj/2r+KMtAQ7yIw80uXXUxi
EDsYadgZrekkk6MlxAhQ5WtP9+LutuK2DY9mieFJcLtLclnFmM8qd8A6NxOW+erx
DXFue136FfYmEJOXDANq0oObr2pXynOXeDy4kQ+rBRP/qnkGmyM=
=fubH
-----END PGP SIGNATURE-----

--Ly0PiR4Rl4jVrxY3--
