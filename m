Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F18179206
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097620; cv=none; b=AFSQy0tL3vEJOgCL7bzfwd6bFQFnkVfBeqKAao/jhcF/NO7DjNH0iIKw5pV6g/8P19XaqHAH7beW4FBvLTgT4mjsP7uXYfTXSEb8d4Go7fSec7W88QKfi5sDb846sn6DwsT6mXNgjV1FpM6ZhNZWx+QERnh7N3TKkg7o+VaTKgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097620; c=relaxed/simple;
	bh=zCZS8Qe4WJxH2vfUNVzjjnhFbZtYTgFnMVTAOMyj9dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qr4SZNgs2fnLwvxVqZ5RYbU/fENWT2eg7/0aMsSIywailqvZU+zYTar678cYZg8xzWXMDUfvHYiRRlah9ofK63rfMT1HdDBAWUZv+6D5TRHcUaUJx6W30eKGiKsB8bfCw49kWAkhs5gg0NevgyhyqV1csG8nb7NxAQLnYBn4l3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bWx9xY8Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oodQ2xwk; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bWx9xY8Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oodQ2xwk"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 532101800118;
	Tue, 11 Jun 2024 05:20:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 11 Jun 2024 05:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097617; x=1718184017; bh=0jaj2aiZ+m
	OE82IoRAEcBU30W9vaYTVh5x72NcCSF6Y=; b=bWx9xY8QEmrZsM6anh/c0wDLRl
	CirDtLCd9G+srWJwE8yz4VACkDsXDgfQ/+uQ8aRaIkf48shVzf+CP9u4dVW347GS
	FsPzELoaMNr1nr8jkp3qtwatfZV2BwBOH+o5a2Bf5c+0B6wxiaIAAaIdLS0A8t7i
	Dljp5JGRXLMC6F5MPPl2JAqDRHZDLQEm4Yx90FV4hAymEtbUfVfJFXkOwwmwg/9o
	zq7xyL6VLjK85hJBNeOtajLWIorVVInOxWFM9PDeJX90xVjOGT+qnE0fbxL+kB58
	5oKS9VgQ57tNHqSrb/WIt+6XKLu3ofYgzA7tIhCGdXbGqb4j5vmg4JiDCyJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097617; x=1718184017; bh=0jaj2aiZ+mOE82IoRAEcBU30W9va
	YTVh5x72NcCSF6Y=; b=oodQ2xwkMktVJcDDGAlAq2OTNWVLMR+9jWzUCaWA2Ohr
	+DrAxPtfPL23DMe8dA86ZZs8Z8pO5WP/ObKOMadWGJtZ4cdaXE/oXu9Buic6pTK2
	vPeiyK3/CT2voxdks9NQA12tbDMA8dVNorLgqqc97plIvwnvu1TrmsG8fzspFt7B
	3gOlyzP8L9Ey1Zy2Z0dHarDUEF1XczBaME5V1HxPMei5m1oFJd1/e6PAplAqgwUQ
	4/KvgXQVDhg3afE1ykSa65itXFwiX7v9rvP1PaYCApK+YQo7+k5fvsfRB+PNBT59
	Bge/tuP/0HPSV/GeDlPnXLsUINTZ8pf5GRJYR/CoHA==
X-ME-Sender: <xms:0RZoZqScA1YXRRZe0ak1ji04Lnc0BKSddwSpeMXSL_fPJcIc5sc0BQ>
    <xme:0RZoZvwla8UxB_tiO8EvEEM5wp-6BwOSuqmeekmdyzw0ZATaa1RZnYc3XGgP-PD7q
    z_hyjijen_6aOuE-w>
X-ME-Received: <xmr:0RZoZn3sb9ZOYnLEy7C5XNKxW6DalJN1F6gqRsGjPghHeMYsI7aSnOxTEjWFmMAXPMmD_xamxJvIUFYlPjx336HohR8iywPW5gL7cOfx0Y8FK1eX8TGd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:0RZoZmBrP4rQyXP87L60GykixC9NBUCuZKOvkishP4HYySRKUykrLA>
    <xmx:0RZoZji8PFBVRGqzs8fAvrnAqii3MleBC4BYJUgZa0bGfBalwunC_Q>
    <xmx:0RZoZioQfU8EZKNSmyC-ZeMisbHxjanSg9JEOwIrONaXjMbbqvY-gA>
    <xmx:0RZoZmgvG_qUuEhEVaPC1s0HW68fwMcdTpH8j3NthFXBo1vv2eKNWw>
    <xmx:0RZoZguR4z1hivwQFMb-ZYxr67l1mkr5w0MwVeKUbhEyKxHacLsHVmoK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:20:16 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 57eeee1e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:20:08 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:20:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 13/29] merge-recursive: fix memory leak when finalizing
 merge
Message-ID: <b6540e4aff9a355a62700983681efc3ea4419a05.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="faoHnR0L15yTkljj"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--faoHnR0L15yTkljj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We do not free some members of `struct merge_options`' private data.
Fix this to plug those leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 merge-recursive.c               | 3 +++
 t/t1004-read-tree-m-u-wf.sh     | 1 +
 t/t1015-read-index-unmerged.sh  | 2 ++
 t/t3509-cherry-pick-merge-df.sh | 1 +
 4 files changed, 7 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index eff73dac02..832c8ef3f3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3800,6 +3800,9 @@ static void merge_finalize(struct merge_options *opt)
 	if (show(opt, 2))
 		diff_warn_rename_limit("merge.renamelimit",
 				       opt->priv->needed_rename_limit, 0);
+	hashmap_clear_and_free(&opt->priv->current_file_dir_set,
+			       struct path_hashmap_entry, e);
+	string_list_clear(&opt->priv->df_conflict_file_set, 0);
 	FREE_AND_NULL(opt->priv);
 }
=20
diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index 11bf10424f..2b9720b0fe 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -5,6 +5,7 @@ test_description=3D'read-tree -m -u checks working tree fil=
es'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
=20
diff --git a/t/t1015-read-index-unmerged.sh b/t/t1015-read-index-unmerged.sh
index 55d22da32c..da737a32a2 100755
--- a/t/t1015-read-index-unmerged.sh
+++ b/t/t1015-read-index-unmerged.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'Test various callers of read_index_unmerged'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup modify/delete + directory/file conflict' '
diff --git a/t/t3509-cherry-pick-merge-df.sh b/t/t3509-cherry-pick-merge-df=
=2Esh
index f4159246e1..171cc6d76b 100755
--- a/t/t3509-cherry-pick-merge-df.sh
+++ b/t/t3509-cherry-pick-merge-df.sh
@@ -4,6 +4,7 @@ test_description=3D'Test cherry-pick with directory/file co=
nflicts'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'Initialize repository' '
--=20
2.45.2.436.gcd77e87115.dirty


--faoHnR0L15yTkljj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFs4ACgkQVbJhu7ck
PpRq6Q/+NfgxZQ7DPXGrnesmtvUavoaZJKb8fIKISRZ8MIpIcXkd8TvLzjKeMFml
bcx5RrCsjFtQqu1udXPUTcz4DENKYrkqjMS51UGyXI6OdnAivlfTw3zCdXV7/+t4
SsW3NTi61ucw83wssuWoB2WD98pAyiLHXybvBKKwNz137TCrwCDHSKUgukAMhUYo
bfZYMOlUPhAnGzqAoYKE5rradzTMjpGKQWrmciNFdmhBd5FYTSSnPHFjzoic7smD
omPcg1ZuPUuVYVQ7HOZ4V3dTmAAn9/jMQwxxkmUgko32r9sn+E5oo1VSzeqUTXxK
GTcXTn98iVvnDyCdjr0lCno8sJYW1VQHr+NT4oW/JUz3dwPxkldev7YSNYGsYAau
Rz7InAdQ4zePAxaPncf1C89lXKQBouH+ZmR+F+kGsGcscvIIAgAMN4Y1OwHrMlfn
qbUBSc2mPYDC15hWXAoPLT7WnKhzFSAVksdm2wsgo7ZOrZRtprXgy3Zz4Gac8vev
OXZsYSjuAo9q1JLd9Z+FJNsfrKD4lR/RFX9qY486xdqmztH1SexqPmgET66lPVCp
yuwfIVtTC0+bWZPayM498fvMCYiy+aC3J1xJb/s9UwGkbJ/EkDauruw/tj7CKNai
MZCkK8XgqG/zgAuMFd9IoqJ9I3RhIckQX03UM3jRQFo/3ites0U=
=mGC+
-----END PGP SIGNATURE-----

--faoHnR0L15yTkljj--
