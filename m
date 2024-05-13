Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86060146D5D
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588305; cv=none; b=kMdlOJHWPnwlTimoA6uCi7ZuiG4VdvaQznRisoET71+gpf2sT51bnfGwLFoB/m1/AyD7zy1RyN5EevZJ7H8H1HW0hM2rpprxXS+Wy9bH9MAMArgR39VsrGbPH8YdVujX6dTzWnSK5+4n7KCxTl780YnbqTd5jRNLwQgT9nPoC2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588305; c=relaxed/simple;
	bh=XQR5yLqmZSmLzaHqnT0zaTXQh0Dw2+Qxo8Db5XoWjgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7v6t6r6BAYM3DVmVvVN02EDVwQIu8F++k0lb/3pbKsJ8E/2iLucLYiRx+YBnd/odtPFDnu6YFdpcrwqSky0t5UTWtWHPIM/MLrJk5bS9GdNB7RHLeCxNo3NDf1d0WAWVgcaAlYzoAhIJZtfFkKLPDJfs63sll0epGCZkZyHStA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mj22e9iV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=joE56jZN; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mj22e9iV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="joE56jZN"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id CE9551800105;
	Mon, 13 May 2024 04:18:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 13 May 2024 04:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715588302; x=1715674702; bh=+/Hzv9gnSv
	70yU7tvLjErEnGZhAaJpD+jENrr3I0c0k=; b=Mj22e9iVtiLZRj2Jb86DzKWU75
	yF/mWgyXkSNUxd/kOOGEYrONoo2yZ9YXF+JmSo2X8h5B3b2ikGVaTmBDZApr2+yk
	rlMIfiGaB7NTiqhVXlwGqKDBne6vRSW9tmseoGp3LBZNYgQuq8HBpLA7He/qc9e2
	DT+kDFNnyqlVDqBeXUhsR6XaEI/TLFVBoArNB5E6Yu/HLblGWUr1vkDESUA4kGcv
	vtczcxN8DspitaZA5itmnk1ZgFzPB9QZikCUr7SgyJ5jgrgn5Fhd23yvwNsRz7Sh
	G45SLG61sEzhzVqUwOTu9XKHBBOKFILug5N0Za/lT0SKFMMh4MvnmPFo3gaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715588302; x=1715674702; bh=+/Hzv9gnSv70yU7tvLjErEnGZhAa
	JpD+jENrr3I0c0k=; b=joE56jZNs7vxELkVoFhRadzVskqGV312KZU0I5JsmUQG
	DfhwPn49Wb5Muof509ifOIIT2fvzD8P1mFkd9wLOLDohXUgO4xGH4f7qoFnAjsP3
	gxf1jIpxYAlnGVRTOCT+v010/14KrCF6Y/b+SlqL7ge8SqDiHUEVeXhS8dWG/9fp
	Di/KqKZmTfAxfQfD4AWKD1N+RhoiVx90FxZowHimtSGWmnHzMBwve8229FXzOqXb
	yOzd9VoI0V4e0XvAw6PAN93e7ppkMvqBBCCip3WeNdj4cjbPHdjN78LyqMfqzztI
	Jb4mXIV9j+JjDB+0QSl8ynsGBdqxAaP1HrlWvyoebw==
X-ME-Sender: <xms:zsxBZnXzSJs7QEO_3mykbohlafGVFy6NAZqtuK0K5GQERf4xR0puEA>
    <xme:zsxBZvninNYAvB4reujpfb2eBstgkKHj0lH9Rq0IE-rr0bLa5ehgxGXg4znfr8KEK
    MP67fz11SVDDGHw_Q>
X-ME-Received: <xmr:zsxBZjaypHcp2hEIoIxlqCUb8FWm7pu23Lw27l_UFlQF5lZjK58iKq0nHkHjIftiEbvihOmvRtK1IBPVUCV6wUqtrl_zxVx1R1sDM8v9gou-2KQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:zsxBZiXR50ttPRbxmw2nXcIfihg6a1cS9msh1JeAD3am4zlrud-rhA>
    <xmx:zsxBZhkP-7eH_MbDG92CsVS1fnrnfi7pLlO_BFDs1uB13eMRtpoq5w>
    <xmx:zsxBZvd_aP8JOSiXwk1uoRjUDNaEWnY2levsOtuQduMQtK_VrRfccA>
    <xmx:zsxBZrH3xz46fj-gqOLtw9Webu6U3KvLZEp33FbQjIPy4AFA_uBN-A>
    <xmx:zsxBZqBrJFvM0l825KOyH4PkNk-0jjTLOxISLS4n4tAtpslDEHEA19LI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 04:18:21 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5defbb1d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 08:18:03 +0000 (UTC)
Date: Mon, 13 May 2024 10:18:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 06/11] refs/reftable: allow configuring block size
Message-ID: <70720af4d3476e30eba2a85c2691d664e02ade31.1715587849.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715587849.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5GZLktwLRVymGiWD"
Content-Disposition: inline
In-Reply-To: <cover.1715587849.git.ps@pks.im>


--5GZLktwLRVymGiWD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add a new option `reftable.blockSize` that allows the user to control
the block size used by the reftable library.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config.txt          |  2 +
 Documentation/config/reftable.txt | 14 ++++++
 refs/reftable-backend.c           | 31 ++++++++++++-
 t/t0613-reftable-write-options.sh | 72 +++++++++++++++++++++++++++++++
 4 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/config/reftable.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6f649c997c..cbf0b99c44 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -498,6 +498,8 @@ include::config/rebase.txt[]
=20
 include::config/receive.txt[]
=20
+include::config/reftable.txt[]
+
 include::config/remote.txt[]
=20
 include::config/remotes.txt[]
diff --git a/Documentation/config/reftable.txt b/Documentation/config/refta=
ble.txt
new file mode 100644
index 0000000000..fa7c4be014
--- /dev/null
+++ b/Documentation/config/reftable.txt
@@ -0,0 +1,14 @@
+reftable.blockSize::
+	The size in bytes used by the reftable backend when writing blocks.
+	The block size is determined by the writer, and does not have to be a
+	power of 2. The block size must be larger than the longest reference
+	name or log entry used in the repository, as references cannot span
+	blocks.
++
+Powers of two that are friendly to the virtual memory system or
+filesystem (such as 4kB or 8kB) are recommended. Larger sizes (64kB) can
+yield better compression, with a possible increased cost incurred by
+readers during access.
++
+The largest block size is `16777215` bytes (15.99 MiB). The default value =
is
+`4096` bytes (4kB). A value of `0` will use the default value.
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index f8f930380d..8d0ae9e285 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1,6 +1,7 @@
 #include "../git-compat-util.h"
 #include "../abspath.h"
 #include "../chdir-notify.h"
+#include "../config.h"
 #include "../environment.h"
 #include "../gettext.h"
 #include "../hash.h"
@@ -228,6 +229,22 @@ static int read_ref_without_reload(struct reftable_sta=
ck *stack,
 	return ret;
 }
=20
+static int reftable_be_config(const char *var, const char *value,
+			      const struct config_context *ctx,
+			      void *_opts)
+{
+	struct reftable_write_options *opts =3D _opts;
+
+	if (!strcmp(var, "reftable.blocksize")) {
+		unsigned long block_size =3D git_config_ulong(var, value, ctx->kvi);
+		if (block_size > 16777215)
+			die("reftable block size cannot exceed 16MB");
+		opts->block_size =3D block_size;
+	}
+
+	return 0;
+}
+
 static struct ref_store *reftable_be_init(struct repository *repo,
 					  const char *gitdir,
 					  unsigned int store_flags)
@@ -243,12 +260,24 @@ static struct ref_store *reftable_be_init(struct repo=
sitory *repo,
 	base_ref_store_init(&refs->base, repo, gitdir, &refs_be_reftable);
 	strmap_init(&refs->worktree_stacks);
 	refs->store_flags =3D store_flags;
-	refs->write_options.block_size =3D 4096;
+
 	refs->write_options.hash_id =3D repo->hash_algo->format_id;
 	refs->write_options.default_permissions =3D calc_shared_perm(0666 & ~mask=
);
 	refs->write_options.disable_auto_compact =3D
 		!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1);
=20
+	git_config(reftable_be_config, &refs->write_options);
+
+	/*
+	 * It is somewhat unfortunate that we have to mirror the default block
+	 * size of the reftable library here. But given that the write options
+	 * wouldn't be updated by the library here, and given that we require
+	 * the proper block size to trim reflog message so that they fit, we
+	 * must set up a proper value here.
+	 */
+	if (!refs->write_options.block_size)
+		refs->write_options.block_size =3D 4096;
+
 	/*
 	 * Set up the main reftable stack that is hosted in GIT_COMMON_DIR.
 	 * This stack contains both the shared and the main worktree refs.
diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-opt=
ions.sh
index 462980c37c..8bdbc6ec70 100755
--- a/t/t0613-reftable-write-options.sh
+++ b/t/t0613-reftable-write-options.sh
@@ -99,4 +99,76 @@ test_expect_success 'many refs results in multiple block=
s' '
 	)
 '
=20
+test_expect_success 'tiny block size leads to error' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		cat >expect <<-EOF &&
+		error: unable to compact stack: entry too large
+		EOF
+		test_must_fail git -c reftable.blockSize=3D50 pack-refs 2>err &&
+		test_cmp expect err
+	)
+'
+
+test_expect_success 'small block size leads to multiple ref blocks' '
+	test_config_global core.logAllRefUpdates false &&
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		test_commit B &&
+		git -c reftable.blockSize=3D100 pack-refs &&
+
+		cat >expect <<-EOF &&
+		header:
+		  block_size: 100
+		ref:
+		  - length: 53
+		    restarts: 1
+		  - length: 74
+		    restarts: 1
+		  - length: 38
+		    restarts: 1
+		EOF
+		test-tool dump-reftable -b .git/reftable/*.ref >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'small block size fails with large reflog message' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		perl -e "print \"a\" x 500" >logmsg &&
+		cat >expect <<-EOF &&
+		fatal: update_ref failed for ref ${SQ}refs/heads/logme${SQ}: reftable: t=
ransaction failure: entry too large
+		EOF
+		test_must_fail git -c reftable.blockSize=3D100 \
+			update-ref -m "$(cat logmsg)" refs/heads/logme HEAD 2>err &&
+		test_cmp expect err
+	)
+'
+
+test_expect_success 'block size exceeding maximum supported size' '
+	test_config_global core.logAllRefUpdates false &&
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		test_commit B &&
+		cat >expect <<-EOF &&
+		fatal: reftable block size cannot exceed 16MB
+		EOF
+		test_must_fail git -c reftable.blockSize=3D16777216 pack-refs 2>err &&
+		test_cmp expect err
+	)
+'
+
 test_done
--=20
2.45.GIT


--5GZLktwLRVymGiWD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZBzMoACgkQVbJhu7ck
PpQulg/4rCL4gM2asMCFYd2avtzDy9OAELCzDt6kuuo/OzDaO5n9KEEqtc2OfQH+
0nNpdDs+tOa2ypsrcss1T3St+s3JOFWhbTUxb2Ghe/sTBHknOQhKUlJ2V/8ohazD
ypdTD7antKicf2Pv9p02DPtCCUxwbX6qJg+7LgeiULZQdakS6OeoqV4blul90hXV
sdTjDgZ1PIoE9pBE/Sgftcv+Yk+I8Co3azTRQEb34VqL3/V2JQN4JwdVTFvSKQA8
6tNCq1SEDYeafMQjJ5FRF3V8vhWw7TVdJ4lz9jKTfR3ZZAH3W5ewBcx9hRgjvC3n
uvNcUivDjxf0hXsbeMGJW6G550a+X1jbtZoNF0dWF5RItIt3ZgPioSCPxXQcDRh6
2ShGJhoKjlVb63f2j8Vh7N6kDsHAolTsvCYex28dagxmnaAPkRiudGGiRtF6iyZy
0Uo3PNGnNAmDNKer73ceUIsiK8RPi68LJHqb643OVf+bHuS90H/o76llHuCf9naA
ExuGFRxIShtXhVb3jElan3C6Mx+sKoWzrxElom4/uBCbOhleVMfiJ9+Ssz4BE17C
opGZzyRd1fA9S9NUJQ99ryaSV60ciBRQNcjhM3IDaDcsHEcgky27ICpWrVUJvuIc
gtd0sNzukY5txXi9jsE2d3euI0FTpv1GiGKqYFSa4SFud6pK9A==
=iFMl
-----END PGP SIGNATURE-----

--5GZLktwLRVymGiWD--
