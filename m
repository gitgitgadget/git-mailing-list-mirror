Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009BC51016
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716452721; cv=none; b=cWyAeXTFZGFUoGg1HK4Ga5+k8dalffNbDGW2yxALeQOMXphrdNg3KSh7VKaxBwi/Me4Io0rjwWovYxF/6gKzFUR5fl2brNzLSeVqRatA4nH6eTGtT8muNYi9D3hFJ8+LPaBom3RhEMzqs+V4m4+r6guf35103CwYu/2LVMHj/8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716452721; c=relaxed/simple;
	bh=LmSuzTVQyqxBYQ4wIaYTTPMI7iSMuKr0/4Yd6/d+Y+E=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pMB2Se5ouwQMOUseZ61iViORgzX4Rydvd05UMYEuFcz8bmgVNww2/SpJH2/2wgEI+nbvsRBaAw0GeEvO/zTy/1I1Jh8v6i6LjvBcSPkMqYFuzAY0zD7+VbsmgchXUFvCacce/1Y+tJz2Oe68RtbPESDIvddAykuc/poZTLPgWf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fu1r1aEB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZoPYBKml; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fu1r1aEB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZoPYBKml"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 28F551C000FE
	for <git@vger.kernel.org>; Thu, 23 May 2024 04:25:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 23 May 2024 04:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1716452717; x=1716539117; bh=vlESdS4t6FSZbLxCpkHz8yL2GC0NhWJf
	d4ecUnR2LSk=; b=fu1r1aEBEAkn+EocZoFDA3CKwi0lOHPkAW00BnI0pq8Unssm
	zF3eTP3UQNdXJJiLdFRGWPZfCcIwBVe7uSVy/EmyBRKNVZ2H7KQ8rA+kF8tcDtMH
	LfM1A1uS4Cy4y2iOUxaseH/M/fSlh/Oha00snInHYD6ZfkFlt0O1dJ8GR0fNQUtu
	r9PPb4kH6vpd2M4Z6xCluquUK1exKEYKx0wnb4pQaGIqNT9TfijlmvpTVnveKOnO
	toYJ8q1nq8NpwGNsNVafo4d9PO81gpmOQBgR7pp3XQLA3/pYUw0J0nk0pQV8NZCO
	RuHAKrC75I1paFs1w2R2TVl8RY971/ENuDOoyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1716452717; x=1716539117; bh=vlESdS4t6FSZbLxCpkHz8yL2GC0NhWJfd4e
	cUnR2LSk=; b=ZoPYBKml8nptoZa9DekzbEOD7wsQoO279lGNEUVzKy3mAF69Y3B
	/NuOq28ojHuwUIGz+PaT5Wq3isK8ISsWNRhl9cifjsQOdEFeknu+Lgf/yvX613e4
	9Uk8A3q3MfJbiDktpxVo/o8v3V+pvJPIieXBx82duaCJ44Yc3lnFKmeiGVlWJREb
	DNV1X6ODeDr2EbhNW0/Jk51JbxtEOSszNZ/avC39DdOIIm5cAWjCnraLHJ7dHfhe
	XuhHhJbfjLLRudkOQ8WzeOPDzs5G8aU3i6fndX7awCD8cRD5HhREWbhH5du+XCRO
	/Zd4mHhEb879WZ3B4i90do/1LB6+dJdFomQ==
X-ME-Sender: <xms:bf1OZj1r1wK_kwNo2sQPpQhZcCgY89NdwZq0fpfTwm0tp8N62uD9eA>
    <xme:bf1OZiGTQ8rX8m4dm0MZTrkYwTWTbUqiEnPjHdXTkYWPeB2sRGfJ4CQzg8pxx7Ijf
    Gk0EKykVcKrzwwA7A>
X-ME-Received: <xmr:bf1OZj6jwQxIsBS2RmQE-sBNukoK9FUfLWAZBZjGm-zY8beXMOqEubuhyGppR7fJNg9jKEt7-w52prKhwUnsJZ4LMxsie-79xLXksS5QsfNGp0W1eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffejhedvgfdufefffeffleeukefgveeikedtje
    dvudekueegkeduhedtudffffejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:bf1OZo2hJ-1XTA7Y9DRZbG8IhCR5A7s93F7ShHewNKx4aJNjRQQ62A>
    <xmx:bf1OZmE7RAU--GlRZev6xEMiZvDQy5wAhxmBQRaKwXK0sLb6mgkXzw>
    <xmx:bf1OZp8Kuee_rnMR9SOiP4U6Tqk_sbYGqlv6tiBwMi7kS0Dx_Qm8Zw>
    <xmx:bf1OZjnxhQgzhHDGoRR2RXJhDxV7OWUIWHC4xKnQjMgVUv4f5wlJgQ>
    <xmx:bf1OZoNxKje5Bwf0GzI2iEp6USCUJzndwG451V7940fsKOthZ84psjF9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 04:25:17 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3ce0b349 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 08:25:09 +0000 (UTC)
Date: Thu, 23 May 2024 10:25:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/9] refs: ref storage format migrations
Message-ID: <cover.1716451672.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dpoxloTZNkipQuN6"
Content-Disposition: inline


--dpoxloTZNkipQuN6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series implements migration of ref storage formats such that
it is for example possible to migrate a repository with "files" format
to the "reftable" format. The migration logic comes in the form of a new
`git refs migrate` subcommand. As mentioned in [1], I do have plans to
extend the new git-refs(1) over time.

In the current form, the migration logic has three major limitations:

  - It does not work with repositories that have worktrees as we have to
    migrate multiple ref stores here, one for every worktree. I wanted
    to avoid making this series too complex right from the start.

  - It does not migrate reflogs, because we have no interfaces to do so.
    I want to eventually address this by adding log-only updates to
    transactions.

  - It is not safe with concurrent writers. This is the limitation that
    is most critical in my eyes. The root cause here is that it is
    inherently impossible to lock the "files" backend for writes. I have
    been thinking about this issue a lot and have not found any solution
    that works. There are partial solutions here:

      - Create a central lockfile for the "files" backend -- if there,
        the backend will refuse to write. If that lock needs to be
        acquired during the "commit" phase of transaction though then we
        would essentially start to sequentialize all writes in the
        "files" backend, which is a non-starter. If not, then processes
        which are running already may not have seen it, and thus the
        issue still exists.

     - Pack all loose refs, remove "refs/" and create a "refs.lock"
       file. This isn't safe though because root refs can still be
       written.

     - Create a log of concurrent writes and apply that to the migrated
       refs once done. This is a lot of complexity, and it's unclear
       whether it even solves the issue with already-running writers.

     - Create a temporary "extensions.refMigration" extension that is
       unhandled by Git. New processes will refuse to run in such a
       repo and thus cannot write to it. Again, unsafe with running
       writers.

    Another alternative is that we could just make this a best effort.
    The "reftable" backend supports locking, and for the "files" backend
    we could just lock "HEAD" and call it a day. I'm not sure whether it
    is preferable though to have a "partial" solution compared to having
    none at all, as it may cause users to be less mindful. That's why I
    decided to just have no solution at all and document the limitation
    accordingly.

    If anybody has ideas here I'd be very happy to hear them.

Anyway. The current state of this patch series is sufficient to migrate
repos without reflogs and worktrees, and thus mostly applies to bare
repositories, only. This is somewhat intentional -- as a server operator
this is of course our primary usecase at GitLab. We do plan to also
upstream support for writing reflogs though, but in a later step. We do
not plan to implement support for migrating repositories with worktrees,
but I'd be happy to help out with the effort in case somebody else wants
to.

The series is built on top of 4365c6fcf9 (The sixth batch, 2024-05-20).
It pulls in the following two dependencies:

  - ps/refs-without-the-repository-updates at 00892786b8 (refs/packed:
    remove references to `the_hash_algo`, 2024-05-17). This is mostly to
    avoid conflicts.

  - ps/pseudo-ref-terminology at 8e4f5c2dc2 (refs: refuse to write
    pseudorefs, 2024-05-15). This is a functional prerequisite because
    the migration logic relies on the new definition of pseudorefs.

There are two minor textual conflicts when merged to "next" or "seen".
One is a conflicting added header in "refs/reftable-backend.c", and one
is a conflict with added functions in "refs.c". Both of these conflicts
are trivial to solve by accepting both sides.

Thanks!

Patrick

[1]: https://lore.kernel.org/git/ZkNJaaKTTKbns8wo@tanuki/#t

Patrick Steinhardt (9):
  setup: unset ref storage when reinitializing repository version
  refs: convert ref storage format to an enum
  refs: pass storage format to `ref_store_init()` explicitly
  refs: allow to skip creation of reflog entries
  refs/files: refactor `add_pseudoref_and_head_entries()`
  refs/files: extract function to iterate through root refs
  refs: implement removal of ref storages
  refs: implement logic to migrate between ref storage formats
  builtin/refs: new command to migrate ref storage formats

 .gitignore                 |   1 +
 Documentation/git-refs.txt |  59 +++++++
 Makefile                   |   1 +
 builtin.h                  |   1 +
 builtin/clone.c            |   2 +-
 builtin/init-db.c          |   2 +-
 builtin/refs.c             |  75 +++++++++
 git.c                      |   1 +
 refs.c                     | 319 +++++++++++++++++++++++++++++++++++--
 refs.h                     |  41 ++++-
 refs/files-backend.c       | 121 ++++++++++++--
 refs/packed-backend.c      |  15 ++
 refs/refs-internal.h       |   7 +
 refs/reftable-backend.c    |  37 ++++-
 repository.c               |   3 +-
 repository.h               |  10 +-
 setup.c                    |  10 +-
 setup.h                    |   9 +-
 t/helper/test-ref-store.c  |   1 +
 t/t1460-refs-migrate.sh    | 243 ++++++++++++++++++++++++++++
 20 files changed, 913 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/git-refs.txt
 create mode 100644 builtin/refs.c
 create mode 100755 t/t1460-refs-migrate.sh

--=20
2.45.1.216.g4365c6fcf9.dirty


--dpoxloTZNkipQuN6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZO/WgACgkQVbJhu7ck
PpTKwA/8DYPMFVFOEKvBjpyR2U+5jUy+ESAUop2TgN5oTG/AVuWkzoOV8VFLa0Bb
1GRkyKboRY3zT7mDvXCIYmbArnkEU4DOhol0qevDSdkcYQcsGj3RKa320G9RHdM1
GMmTKEkKS1aPbUVzO0zAzgrkHM8+POjYA+ngRC9Z8JElnfbSS0oAAWMe64gmqZBS
Mus77kyrcX3sTk/Ia/wigKO4VfPs4n2mqybLkSeVtM2h4qiccD0kMYRXmfGT06wA
Q90TfKpYEVw9wrmlcco6GUT2umIp6qRq5RXxJYm+R9mKaVmQ8gRw9mp1w1I3qGty
vibKkhzY2do4sicmRjBvUfY0/KJXLOR9nDJLhh1vX4/Gxp42mriCS9y7L6CJ1/Fq
t/6FTPgCHtwfT6aXVXYV76hTwB3KBc0dWveJjV3gsKIxQkqJtshJDWR8vNw4jD4/
9OinPAh9nZzwJIjejgWIVw0CVhnWjbphLBUNgDMowhYY12UahDXn8JSy98WUMYjq
tzm40adwyu9kq/6KSdx9suQugVItL/8jSj78I6qiiUkhDj3OMTTqZ75djGtIh88B
zrJi3vkuksxfkQWx5DWhRlmYSF1Mxrh+a0adjuoqgMNZiHEPkjPiiXkwBszh9/Lw
SMwLg+scAMF7CGyQB4ApTR+qF1dPDu9w7XylYKQNWvRPmlueuaY=
=7Lq8
-----END PGP SIGNATURE-----

--dpoxloTZNkipQuN6--
