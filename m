Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE0216D317
	for <git@vger.kernel.org>; Fri, 10 May 2024 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336991; cv=none; b=ZFI5qRCMEJShzN2khF56wMDT0GfM7Y7nQ6rBO9gFrP9H3ssDx4zrnINcp1n3Xye6/WBoswBWISyFNNdoOO/2PXwESocdjzWDFmei40fQNRgywfW3rsMm0EVxKFkrHGybk70eieVkI04yYqrXDnnCGHxi6yfMWlq+vFUM5GlBmqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336991; c=relaxed/simple;
	bh=txZBop4l8BE+ntN/zQjxlXqmJbPYgXMgnSYrKyAM+bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V609kvVwDNCyU+L6eiJ0/QOmbg25XqQs5bMIz7aDkC24aKLkQ5TMHSMldWVo98kYbo1cYGiSdAwsS6ZKIeA3Hg4ZKvp11hzNxfRFz6GARgMzG6BYeT3HrZBSperBYg2fJHQmJA6xZKuvIty8h9hrOBrq7GpFwv1XQL8BWtVIcn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BzxfeRv3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fmCq2qGj; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BzxfeRv3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fmCq2qGj"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9BC291800080;
	Fri, 10 May 2024 06:29:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 10 May 2024 06:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715336988; x=1715423388; bh=IkmrLE/mUs
	OJ9WJn0TX40aMWkv8lzFxIra/xRyUWJSA=; b=BzxfeRv3dbyM2IOh6QUaowH/J4
	x6DxwNOnz6e8WwlhYquhccUgyz7RJ+dR7rCV0/gQRGZc2Pp2zi8sy5Ocdy/RGgCy
	R/J2sdZn2or2kjREflpq9tHq2jKYc/a19CmUpLWPJGS6QpK9Z6D4fMAV6xqYs/YX
	EwZ6j9Vo4S/4RsFFNV9LxqJoJgibY6ftP1Qkw8Y+pvsfMR48KAQhJxV28yrJMyXV
	jhpqFmyMPMhDmWg3TY5c7Zkw2PnLWy/nfq+wOWDk6uJ8DVPEotFhaOdqkgaE1m79
	snOud9rfFJk2UPVoCaEj3I6oTtxxELEpBeIfTjRw0ZADZfxUd3Nkv9qlXW0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715336988; x=1715423388; bh=IkmrLE/mUsOJ9WJn0TX40aMWkv8l
	zFxIra/xRyUWJSA=; b=fmCq2qGjoshmAJWM78kQWPsjvxH0c1Y6NwRwrxxGFkTK
	elHs6kq4H+3qEPmndYazpu6pNCiiN95ork/EPySAtVkFohfRJTDwC2YNmJIKdRJt
	nllhG5y8qZBtjlqZnI8W6bldh0h0QSBtXXhY64rxjH0c7C9q+vQYUg4rnEpzzr9U
	Al/2047c3okkkJ29b1n+9BdI8PB64NkZuCSYnTuliSm+PEa7eNhzzMUiX7B9MzOK
	sUh0e2LUdL5H6cvmBaaqz/OwvMnnOA9/CwicZqHCrwr0x809takoka3ZAa58ixfp
	uvu5cJeZ07dwKuVRwfN92RRufss79JAWPcMC2innVw==
X-ME-Sender: <xms:HPc9Ztkod6dmcPV7vzjKoEV44ocbaM40TKfxYDSRMY4kgblSq-5tzA>
    <xme:HPc9Zo12cXo4xTeLx4gwQKm4lSgaET3Gjq3VQNBnizaudFKfQuHfytr8eQcHG6Em3
    6_VY8HiszIw7Dvdhg>
X-ME-Received: <xmr:HPc9ZjqALpqtJs-ms9LtAlFTK61F-l4cuaGXLLz9ENe_MrqWCflH01Q1f8uTgr3WOmyJA4hwDm0UFNXmmyHnrY6gY4a6vVzEoXn5-dKEMpO2Am25KA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:HPc9ZtkgXDNeel8YYm6WiYQ8gd8naXC0U6XETWleUk43Kh91o-aTGA>
    <xmx:HPc9Zr22DFZEwUW9bemXPB_mgtQhPpdwoukkbpDecORHtnLtM_E3Dg>
    <xmx:HPc9Zss4uuzvvhyYCQsvj1agDM-deKqBJ2_fDc4qzlinKK_EpfBCHg>
    <xmx:HPc9ZvUhEvK3ORNvBAZ7LRhuv2SmDhr991UKInxNVtsUK6hdnwrjgg>
    <xmx:HPc9ZszMRl01PUwzbu9WivaqvUK4Iyl15V1Hw7GETEvvmeawcD-y7AtB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 06:29:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 861b7430 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 10:29:35 +0000 (UTC)
Date: Fri, 10 May 2024 12:29:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 06/11] refs/reftable: allow configuring block size
Message-ID: <be5bdc6dc13510890dbc9ed06e2de6dd866c29e5.1715336798.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715336797.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bcCqtRIcCe3ggrGJ"
Content-Disposition: inline
In-Reply-To: <cover.1715336797.git.ps@pks.im>


--bcCqtRIcCe3ggrGJ
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
index 70b448b132..fa1469e5e7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -497,6 +497,8 @@ include::config/rebase.txt[]
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
index 1cda48c504..bd9999cefc 100644
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
@@ -230,6 +231,22 @@ static int read_ref_without_reload(struct reftable_sta=
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
@@ -245,12 +262,24 @@ static struct ref_store *reftable_be_init(struct repo=
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
2.45.0


--bcCqtRIcCe3ggrGJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY99xgACgkQVbJhu7ck
PpS1jQ/+NiI22u1bt3BmmYgXuYiLWkHSFJQoqiFmqM/Fs6ZqyVA/oVOcw+yl6q1N
4+fR5dse1wH6wYBTUs3B146Abfrcsyh+czuXhhvJb8sF/gJp375H5CW2zLKWwl9C
bdJixvnLBBKzGEWp7dX2HUcuj95jGO2f4VYUH8bm4NBtbG/bNCy9GEevumag6Ywt
4JA6nAW/z/sNV+P+SGe0almakG673zsx18QoBbYx8Y55s4J/xalH2sm8dnYLJmMc
CDSC8Ga5tqztGk468iaJUC68dG1b8v5e4G7vaCA90gu/m4utPagLVFSs2qlTIqcM
ruQf+cI5PfvoVMCPWDMriWnT3pEn8Kx9dbyUo9YFh4LTzQ17WPjO9mDuaLCe6N2R
AfGsBtOgk10sx+KeeC2H7sx83QPELFAC9Y1QdtxTkUvIHA6/v6rvwj6Qq6DWzCr9
sacKrN4nzfRZRgz2/TLUj8r2Ik9nt5eTNk1QADdJmwNQOfVLiTES2TZi054sVsGN
068RioW03bbifsORYwD5h8DZM1EvCheRPJCqlmPpR5nBVR7po29E8gyNJSLACd5x
Qq/sIZrEuWhVlWl2mXqTj2LIiEPON5/oGPaZBT0hgGXEICJJ3nT1YkW9N/wljzFp
R3wbrrQEvRj5ODrNy/TVzNzJH6FTY73L1IaIp5+RoXohscdJUBA=
=Esyh
-----END PGP SIGNATURE-----

--bcCqtRIcCe3ggrGJ--
