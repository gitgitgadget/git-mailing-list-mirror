Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3BE35F0C
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759152; cv=none; b=VWaBLaRYHO08wAkruLwBoYN7gGZdcnj0Qv8M/oyyzlpMpILFHaz2JepEEKiGVbygbudSHzdk2S+48hleHqU5u/A8/ZzDoyVZsw1jWejYUKnIrhrGMP12SRKjLvlv1pWkS4ik6W2dvJtYtBnLh8ZSGni2oeMllwok4RnQ6jHvEs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759152; c=relaxed/simple;
	bh=m+S6WodJRZbrKhnwYzMx4pTtak1gOTATtXyWui1cT3s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FvTi09WYi6KUvpYd1bflIudj0qxjOiawsdCdkTb2RjaTgYpQOaQ0a6jHCO+DKpoxS5ffV/g+qq+Tg4NAI7QpSdpXLqs/Hk+LDl9mjtwF21n0nz9Y0T/L1I526x9+BShO1rrt17ZECeI/IGnU1Rz/72nsr5NI/dMqpdu1WEyzwZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZHF9HUoi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J93ZZREy; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZHF9HUoi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J93ZZREy"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4A45211400B7;
	Mon, 18 Mar 2024 06:52:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 18 Mar 2024 06:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1710759148; x=1710845548; bh=4SNxqBcRr76zHcaUvaT6ec52iOcILoFg
	94Zhi58hGaA=; b=ZHF9HUoi7rSxKUUimje/8ONE16Wf/v5fKuS2cjVDCfw1RSwZ
	kkZ0cb2dPE6t9Q7y1QcN1eEUKDIoefPsDcyOcXxYsR6rEFC8cm+YfSoamipRR5tU
	z8/paYoHB67KMYcs4WMroIh5ZC9BxMKiuvMa4uyZ8v+AzpaJmc21m1g0AIKMdb03
	HUvyEoolFB3WTrr42/noDUSYUP6XygHEVVNR2OBq7iMych0HAvWGoryDznGZahh/
	+yKkmJEC2NOFmHzDl8eCQXLJwEZHdb+RVUKWp04NOdeS9KTE9kqIQ4leeqfZrgHf
	o5zhh9Kq59LSDsupHcazA5uhM4Z+48dwBYV0ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1710759148; x=1710845548; bh=4SNxqBcRr76zHcaUvaT6ec52iOcILoFg94Z
	hi58hGaA=; b=J93ZZREyzolVuP0cmo8j9QBI3tlZw1Z+6ac29tzzVL3yYs19KT8
	MwodT9p0rPfUTBgXUIhQD9oUgandIXJTMprnFsIs45RA5ZY5XtUpSdpGKulLyRo8
	JZTMp13pX8hUGrYbkiK5Ac6TAPGDzCf85nObEv3uG8g40VJDPVB15EZbxsiFMqGx
	JMN3OZ5ScMdZuR97avLsLyX6H3UduCYKbIoApScQD6Y0N3z5pvuDEVF1xB7N6HG3
	nVw9+NXzaW7NIFNQldMcDBmm1WRbSoLp/0YFjbUWOYnzM6lsh54nWhcjEsLiiMXJ
	0AOvFYZ+nb5Ps7OPxlnAizyBXeuMOejLJMg==
X-ME-Sender: <xms:6xz4ZYx4CG0CBdHXnNy5iB0UBrUadTa7w-sk4hFMt8axtov2OmN7PQ>
    <xme:6xz4ZcQ379lVD67jrDCeG5u4GmObFmB_0KtkKSsUABnsJWngd6HABO-s0xFfe5WU_
    BanloAYl9s50Pqvew>
X-ME-Received: <xmr:6xz4ZaUuBQ9zNF6TdTUynA2b7V9PqTxCkdc3TQ-fiYnNN-hgOQ89QzwDSKawVF1xlV6QUglwciyL0B8K3KVUQWbEdeq_fr2a_jjoa6WIMEL3jw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfggtggusehgtderredttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    eugfeutdeuieehteelveegudejkeejheeljeejhffhgffhvefgkeeukeejtdeijeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:7Bz4ZWiGHGjHTzUMBrK7AodN_XY9xpCY7f4T1EIfEozH_GHrqTbCIg>
    <xmx:7Bz4ZaBuCkkBqwjEMsRrURCLcqQbpm3-zgIRSMUwf_ro3H23zr6mEw>
    <xmx:7Bz4ZXJ2O7Xxz-ERON9ppaxCnRgIOM9Amuq7m_BaIn_bWhDDM9MaEQ>
    <xmx:7Bz4ZRBscRZpIZJQdWXu6KGUKLlqgB20f1dxqN6ajUiZtsB2sCS_lQ>
    <xmx:7Bz4ZVN4XR16hfq1ytUuk4BwnYIMH2wkll0RHp7jUWKB74vvk5MgAQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Mar 2024 06:52:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 362547a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Mar 2024 10:47:33 +0000 (UTC)
Date: Mon, 18 Mar 2024 11:52:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 00/15] refs: introduce `--auto` to pack refs as needed
Message-ID: <cover.1710706118.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WUWcy/uAiKv3N5GH"
Content-Disposition: inline


--WUWcy/uAiKv3N5GH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

right now, it is left to the caller of `refs_pack_refs()` to decide
whether or not to repack refs and how exactly to do it. This is
inefficient at times given that the caller typically has no idea whether
or not the refdb is close to optimal already. So even if the refdb is
already in a close-to-optimal state we would end up repacking all of it.

This patch series aims to address this shortcoming. It introduces a new
flag `PACK_REFS_AUTO` that tells the ref backend to repack refs as
needed. For the "files" backend we don't honor this flag yet and thus
end up behaving the exact same as if that flag wasn't set. But for the
"reftable" backend we will use the same auto-compaction algorithm that
is already used during writes to the refdb. Thus, in most of the cases
it wouldn't actually do anything except when the refdb is suboptimally
packed.

Eventually we'll probably also want to wire up heuristics for the
"files" backend to honor the `PACK_REFS_AUTO` flag. Using something like
a ratio of packed-refs size/number of loose refs might be viable. I
punted on that though as I feared that it might lead to bikeshedding and
thus distract from the main goal of this topic, which is to prepare the
ref code and relevant commands to perform optimizations as required. I'm
happy to add such a patch to this series though in case anybody feels
strongly about this.

The `PACK_REFS_AUTO` flag is exposed via a new `git pack-refs --auto`
flag. It is wired up in both `git gc --auto` and `git maintenance run
--auto`.

The series is structured as follows:

    - Patches 1 - 5: Bugfixes and improvements for the reftable-specific
      compaction code. These are issues that I've found while working on
      this series.

    - Patches 6 - 8: Refactorings to drop the `PACK_REFS_ALL` flag,
      which isn't actually used by the ref backends anymore and confused
      me multiple times.

    - Patches 9 - 15: Handling of `PACK_REFS_ALL` in git-pack-refs(1),
      git-gc(1) and git-maintenance(1).

The patch series is built on top of 2953d95d40 (The eighth batch,
2024-03-15) with "ps/reftable-stack-tempfile" at 60c4c42515
(reftable/stack: register compacted tables as tempfiles, 2024-03-07)
merged into it due to a merge conflict in "reftable/stack.c".

Patrick

PS: I polished this patch series while traveling and am still out of
    office until Thursday. I'll thus only get to respond to threads that
    are waiting for my input at the end of this week.

Patrick Steinhardt (15):
  reftable/stack: fix error handling in `reftable_stack_init_addition()`
  reftable/error: discern locked/outdated errors
  reftable/stack: use error codes when locking fails during compaction
  reftable/stack: gracefully handle failed auto-compaction due to locks
  refs/reftable: print errors on compaction failure
  t/helper: drop pack-refs wrapper
  refs: move `struct pack_refs_opts` to where it's used
  refs: remove `PACK_REFS_ALL` flag
  refs/reftable: expose auto compaction via new flag
  builtin/pack-refs: release allocated memory
  builtin/pack-refs: introduce new "--auto" flag
  builtin/gc: move `struct maintenance_run_opts`
  t6500: extract objects with "17" prefix
  builtin/gc: forward git-gc(1)'s `--auto` flag when packing refs
  builtin/gc: pack refs when using `git maintenance run --auto`

 Documentation/git-pack-refs.txt | 15 +++++-
 builtin/gc.c                    | 86 +++++++++++++++++++--------------
 builtin/pack-refs.c             | 31 +++++++-----
 refs.h                          | 20 ++++----
 refs/reftable-backend.c         | 11 ++++-
 reftable/error.c                |  4 +-
 reftable/reftable-error.h       |  5 +-
 reftable/stack.c                | 34 +++++++------
 reftable/stack_test.c           |  2 +-
 t/helper/test-ref-store.c       | 20 --------
 t/oid-info/hash-info            | 12 +++++
 t/t0601-reffiles-pack-refs.sh   | 30 ++++++++++--
 t/t0610-reftable-basics.sh      | 79 ++++++++++++++++++++++++++++++
 t/t6500-gc.sh                   | 30 +++---------
 14 files changed, 255 insertions(+), 124 deletions(-)


base-commit: f94fee98b456ef39a5f85fff5802f4e538a4dc7b
--=20
2.44.0


--WUWcy/uAiKv3N5GH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX4HOEACgkQVbJhu7ck
PpSzPg//Xcwf9GMzgdpofx78S4RQ0KbAVuY9emIQ2YCmK9Ktp7A0R/M+dOdc/uvL
GQaaZhCz0fuSyPETSWkjIZ6xSTX1QwHAouf68BTY+4FJ/zcSrTsa5DaTRLf5tvJV
C/Vqs/pkUAQOlVjxKtKnDOxp+5QQsLKStTMN75Jjd3Fwir4ByMutDtxWjChqvl+R
4M+6EvZN0tJsE9Dix/5cxzatnd7tigZthfrw+1cWGhAx/1RLkBllFe3lRdOlsC5u
P5zMN/+SwJwOGz61x5k6fjoX124Xlkz5RbBUcxnZG6R2y9esxTBrbyQLiNUOxeWl
YpjCNJJ0K8NZ31OVVMOEIicrDKHwVeXZ1sfpoE0w+Umosr5ICB0ix9vZDeQueXPj
0fzuQbmvwB5TF9eqckz+Iqi4wNzs8B3ixd/PR6xfVu9PdPWFREr0RKnCbN09wtvC
53g3WFs5b3YOhqhzIAwrjA/PMKMcjW60CZts08y7YoJoeE/A3Sq8rvJxZbKBFHd8
nhhOPbsAvvTUutC9o86snAwphhrWu4co4yUVyar+4CMi6bItMkQhSA9c5nxO3V1c
qOTLxiWOEvC3ugurCrRDBduEzbRIpXgDiuxgZ78am4FLL/vIaQyEAE7yJGAEOR5d
bN+1HUvdDBb1x5RYZOs+cy5WNkwkIMTbtcK/3xp7xI/ZymnZWJQ=
=fXsS
-----END PGP SIGNATURE-----

--WUWcy/uAiKv3N5GH--
