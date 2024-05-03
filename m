Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E174282E5
	for <git@vger.kernel.org>; Fri,  3 May 2024 06:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714717685; cv=none; b=T8UoBM1Y8nIr+rGkp54H9TaKEyzr77dJRazJQnUsd5mFgmQJ2SQHNpqsWVGNTGhzsxaCTJUhGSVEmjQUiax57JpsS6Xe9IGMhA5R5mD4TBkDCky8si9X2wyD9fUMGIs/JBhoOU3jIhkqAt9RfYL3bwvxZLMmscA6CFSXKO6vrAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714717685; c=relaxed/simple;
	bh=1l93kzTgta25Atz4lSm9rGG5o5+AwYOoHoPyJfWBlKk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WOFFG5tVTAEh5JECvqqqNRXIhXvSkVyYtG0gOIBXbEBuJVSYDiIKOEaO0jruYDXI1Sw/8RQWdC0g74e52HzRiemmXz1M7bLgqFuBrSC8CauFWrBfH+lSyAjxzftlTKmhzUzhLOHHm9b5Pr+aw4lrQ76qiXBYA0La3teME2wKeXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Iz06tMP1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=keQYv9Ab; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Iz06tMP1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="keQYv9Ab"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 5B5C41C000F1
	for <git@vger.kernel.org>; Fri,  3 May 2024 02:28:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 03 May 2024 02:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1714717681; x=1714804081; bh=5pxX1vXmTixhyBgPQO0ItaHQFLATBula
	Q5nxdgjL0pI=; b=Iz06tMP10sBfKvFnlodCQAJtRBKkQcat78HD05Rj3bm2Vd8h
	OVw5w/yekHoIBU4Bmk6xTwtCxGQIyMHcs/rfkDczbVnsGh1wME5rT8EkCU9WxBi6
	d+22XxsUK/yBSS5hDpYXxZ5xs4nPywBAmjlg4WhI5oFFNGwUdmN7ix81bXja4lc1
	lydWGiHJZX8BBs35zyQQ3GOe6axBpg5ZuXP7857eRPGYBe9q3Q6OnSWe81bXW53Z
	OOW1YBChU637/DRyfniGpTyr4u/RwtHZRXOvNETW5+X8bWtwLSRW/vApG9myD+I2
	7rxhByO43umH0OXlW34O85BRzLGCBbcr5JYDxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1714717681; x=1714804081; bh=5pxX1vXmTixhyBgPQO0ItaHQFLATBulaQ5n
	xdgjL0pI=; b=keQYv9AblZZqRabbHzR+zEbS/ik5dxVg9GYF+Pb7qWi1FUlKVfn
	tV+lG27kPaOlQywe507hvKZF2e+BvkRNV5tINaYBCLvA2GmqIy8J1ktlOHo4zP2p
	qKmA04mwqnV1vphOpfSaexZbkTGOinlKJSkGXw1ww8Rzw1BMOWXiFXEOYSJ4QV0z
	3g8MuNOaoiAsmY2+EVvlYeh07Af4Yg2K3Fb8RuPR+KfVPHSwmZUTySsnLyoKKNKm
	LZuac3UP2nrZNMI9g5i0UFRME/q9H6XYvdnn0HBDKOBfXK6M/z4GsTwxIQGszgL+
	nPxQ8i7Mwqn+ka5jp9qKsi7Jtf9VaGuKmqw==
X-ME-Sender: <xms:8IM0Zhpbo8igyQ_aw7VelEoFRP6M6hQwEKEbodcfjMj7BuzW1efGOA>
    <xme:8IM0ZjpCVQFfOiXInr-RCyT5Fz60JaTiq_yS6vmP8_g39l4ZHI_HyYJLgIIKlUDq-
    G_laYJ6lticGgkANg>
X-ME-Received: <xmr:8IM0ZuOmpXvQB0C2_i-AowlRJwmh3nE5jX3A1ZdwV1BLnOyC04lzs7cLtvmpOLdEmssAPOQgqsgv7dYVNWv857GhflBC5tNmADQH6NtwvJseNJ53>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduledgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:8IM0Zs5sn3G6o_rpqWMmO6KyxM3VmXCT_8N4ZWOB4SrU_3jLJwxG6Q>
    <xmx:8IM0Zg4szsoz21eoSeCE87Qn96q4DGGVyQY9sH6PwMuWAYRPd_oypw>
    <xmx:8IM0ZkjyK9ePMo4ad5uSJm3bQy8LPusMpglJWDrlCFxSqkddmwOtjg>
    <xmx:8IM0Zi5qYFZ0j_dDMYpZBxQXkdmccunsPyn38et7anuP9-wWMoJzZQ>
    <xmx:8IM0ZuQDPnGWf28Zr67ph-2kIkH4mVCcbytSAMKLYWP4c18nNpq-ZH9j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 May 2024 02:28:00 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2ad6a2bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 May 2024 06:27:30 +0000 (UTC)
Date: Fri, 3 May 2024 08:27:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/5] refs: remove functions without ref store
Message-ID: <cover.1714717057.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M8SJt4Xi8JOM25qP"
Content-Disposition: inline


--M8SJt4Xi8JOM25qP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series aims to convert the ref subsystem to rely less on
`the_repository`. The focus of it is to remove those cases where we have
two variants of the same function: one with a `struct ref_store`, and
one without. There are still other cases in "refs.c" where we implicitly
assume `the_repository`, but those require a bit more thought and will
thus be handled in a subsequent patch series.

The biggest part of this patch is a set of new Coccinelle rules added by
patch 3. Those rules are applied in patch 4 and the now-unused functions
that do not take a `struct ref_store` are then removed in patch 5. This
of course results in quite a lot of churn, but given that it is fully
automated via Coccinelle I don't think it is particularly bad.

It is quite likely that this patch series will impact in-flight patch
series. I'd be quite happy to drop the last patch that removes the old
interfaces to make this a bit less painful.

Patrick

Patrick Steinhardt (5):
  refs: introduce missing functions that accept a `struct ref_store`
  refs: add `exclude_patterns` parameter to `for_each_fullref_in()`
  cocci: introduce rules to transform "refs" to pass ref store
  cocci: apply rules to rewrite callers of "refs" interfaces
  refs: remove functions without ref store

 add-interactive.c             |  17 ++-
 bisect.c                      |  25 +++--
 blame.c                       |   4 +-
 branch.c                      |   5 +-
 builtin/am.c                  |  38 ++++---
 builtin/bisect.c              |  44 +++++---
 builtin/blame.c               |   4 +-
 builtin/branch.c              |  49 +++++----
 builtin/checkout.c            |  35 +++---
 builtin/clone.c               |  36 +++---
 builtin/describe.c            |   3 +-
 builtin/fast-import.c         |  11 +-
 builtin/fetch.c               |  20 +++-
 builtin/fsck.c                |  11 +-
 builtin/gc.c                  |   3 +-
 builtin/log.c                 |   6 +-
 builtin/merge.c               |  34 ++++--
 builtin/name-rev.c            |   5 +-
 builtin/notes.c               |  26 +++--
 builtin/pack-objects.c        |  10 +-
 builtin/pull.c                |   2 +-
 builtin/rebase.c              |  18 +--
 builtin/receive-pack.c        |  15 ++-
 builtin/reflog.c              |  25 +++--
 builtin/remote.c              |  37 ++++---
 builtin/repack.c              |   7 +-
 builtin/replace.c             |   9 +-
 builtin/reset.c               |  13 ++-
 builtin/rev-parse.c           |  25 +++--
 builtin/show-branch.c         |  22 ++--
 builtin/show-ref.c            |  19 +++-
 builtin/stash.c               |  23 ++--
 builtin/submodule--helper.c   |   7 +-
 builtin/symbolic-ref.c        |  13 ++-
 builtin/tag.c                 |  11 +-
 builtin/update-index.c        |   2 +-
 builtin/update-ref.c          |  21 ++--
 builtin/worktree.c            |  19 ++--
 bundle-uri.c                  |  12 +-
 bundle.c                      |   2 +-
 commit-graph.c                |   3 +-
 commit.c                      |   3 +-
 config.c                      |   3 +-
 contrib/coccinelle/refs.cocci | 103 +++++++++++++++++
 delta-islands.c               |   3 +-
 fetch-pack.c                  |   6 +-
 fmt-merge-msg.c               |   4 +-
 help.c                        |   5 +-
 http-backend.c                |  13 ++-
 log-tree.c                    |   9 +-
 ls-refs.c                     |  10 +-
 midx-write.c                  |   3 +-
 negotiator/default.c          |   3 +-
 negotiator/skipping.c         |   3 +-
 notes-cache.c                 |   6 +-
 notes-merge.c                 |   2 +-
 notes-utils.c                 |   7 +-
 notes.c                       |   5 +-
 reachable.c                   |   5 +-
 ref-filter.c                  |  35 ++++--
 reflog-walk.c                 |  27 +++--
 reflog.c                      |  20 ++--
 refs.c                        | 200 ++++------------------------------
 refs.h                        |  84 +++-----------
 remote.c                      |  38 ++++---
 reset.c                       |  29 +++--
 revision.c                    |  27 +++--
 sequencer.c                   |  61 ++++++-----
 server-info.c                 |   3 +-
 setup.c                       |   2 +-
 shallow.c                     |  16 ++-
 submodule.c                   |   6 +-
 transport-helper.c            |  29 +++--
 transport.c                   |  16 ++-
 upload-pack.c                 |  20 ++--
 walker.c                      |   6 +-
 wt-status.c                   |  22 ++--
 77 files changed, 845 insertions(+), 680 deletions(-)
 create mode 100644 contrib/coccinelle/refs.cocci

--=20
2.45.0


--M8SJt4Xi8JOM25qP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY0g+YACgkQVbJhu7ck
PpSZkg//RSs/m1z/nG3sj0igyjnnKmIu82/mRF1RFSVWm9hqVvFAl8ExFhd1Kgh9
N//Fc8ZVPXSUzCyMsBKY3FzZEXL2uXyUq3GZ4E+r/O8PFvxjS9m3gLXaz2aPKpXC
dSfzNSr/i4/8pnf1AGo/SKwuF8XmQUNXbFlnSwIbPSPpdm/2Ew3sKsYiZ8LubZJO
ExqV80N9lvJmB1BMDlVRThXPqIL/H+HBjvn74jjoA42Zt8KoDZ0P84+34p5gigh1
kgKHp/0wDRO6Pl7n1lWtPmp6tOs3nVWzj7V1WheFijzzJdqjPuz7NQf8hMlfhsLW
q+E1bziCew0CirZtjAjc5/9R0kX6QXNCmXEbWGT7m2Bhcfl7+Zllzbiqm8wtPTJd
g2FTErqjFXRD6IJGxh0OmNTg0rTBeKEYzdzGBpqQr9qpzDogbhUCx2uUJ4y9yxFs
4vkWZALLnveOzCSB/hti1e2pT5mdu2nPBkcbQ0mTCOWOE9hdn3jlh0Jc6fRw/O+X
sEuHxDtvxoYHlcQvpAsYaCojQZOi/aj+lfSRdXfUPZ4GCjphTk/9oICmfqViOeAj
jaipuhpCy3E6uzbMJj86osNmrv9Rj/kpYRVX8wHkWLT7DXf2AXCpEMWXOGQvOCzr
rFtbP+RoKUbiTYj8XjNSJsB8rxhDbRS9A5oreRj4Dqhny60GxhQ=
=YG7J
-----END PGP SIGNATURE-----

--M8SJt4Xi8JOM25qP--
