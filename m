Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D25A225D6
	for <git@vger.kernel.org>; Thu,  2 May 2024 06:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714632722; cv=none; b=hQCqIIDArSSCfLvEenEdCZU9orzlK9MFJ004FiuMRRJwp0uPu5XgicKvpy3dTPmuDCTYTr00A2drQuFxkglHekYy37DjTbV4FYVdbjehpg6UpvwKD8S5qNbBOj/SSJEPoGYzaiAcDzQ4MCTHBxdiWhK3Zd9P7uyUHxkxJo021sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714632722; c=relaxed/simple;
	bh=XLoPOw/8E5VFsaZPOZv/blGplVCS3/mNkcnhwGbWY9o=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnBpOQo8yxdn10rXwo+PIT3PP+C2u1VJDiZd3yiLwzSBNY5UAm2HJY77ySAuPA96A65EGi0RSD42nd8RKbim/yopYIQxID6NDpf+9tKUjiBBnov/1wDkkAVnS15bIgaD7RZLD2qcHpGBoCxqhY6AEnHoOFo/kfbfbo/sqjg1ZHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ARfQSHQv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UN2uD4rf; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ARfQSHQv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UN2uD4rf"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8E4261380394
	for <git@vger.kernel.org>; Thu,  2 May 2024 02:51:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 02 May 2024 02:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714632719; x=1714719119; bh=QjDF2hIjlH
	PeCZW8wPvM7UFTJ8TyyVUGAGGAghgCHqc=; b=ARfQSHQvl5sykd9F+wSUfBIHBu
	B/TNQd/3TdOLdnBhm0LT/EF13sP4vWsdNmxWbwGQbQPRZP1d+mdmOjzOFw0GGSj6
	LwKaWtWxc8QyY5069eQBnkjZ8qN3GchUU4u9j2OAdEvIf6dOHRbpmo+EMAT3N1zv
	06hIaEePiCDbCqywY7vk1k9FctwT+6n4N5Q7vvBrQNcVx63zFGPzS8TQAhxepmRV
	nIVa7YtpjK6jjJCPszu9A1VcnrhXFFgTSGfvsLF41q5nWyBctRBGsPLi8D4siY/x
	foUjug5b8/+LRlQcMofNYJ0eEsfOhBbq+8NZHj/VmeXfB2Xhr/P2PJAGxvKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714632719; x=1714719119; bh=QjDF2hIjlHPeCZW8wPvM7UFTJ8Ty
	yVUGAGGAghgCHqc=; b=UN2uD4rfWhb244SltUKEhs7pjGfQRxygeGaTXm3sme3A
	mmAURdthIv1u027JumdmV3wtoxxiyQy94vkTN+iKVv6XbcvJGkqfpkgrTmQetmvk
	SbOU8oHsGKtenqU655k/dk5UoLswc4t/w3kKKX9zTghxDX4WPHIkLCPnJugSgH6/
	hyGkmYUb+OuXGPioPyfxhMLf6+5NAW/sWILTZ5rFTt1iMKPUPWa/eukuLv2mEkBt
	4M8+b+w6UQlscBuPhYILQ8RX7XigOw3uH8MAnJ+bkIChYY2H9dIiUsPU1beu3N8U
	D5u5UgpWoq/iKOOsaERpJgEvBnyG7H4Dc9bB5ffdAQ==
X-ME-Sender: <xms:DzgzZh5ibyTZ5wRoKp-8llT8ofx4Tm2nBIqbq43bxyp8velrlY2ccg>
    <xme:DzgzZu7WMVVCgzIXIppitO9giJ0wezAzIidOtIKwtJk-vyLwiek-NNVmYU7nratUV
    ocRfJh3mpkkHMBfRA>
X-ME-Received: <xmr:DzgzZoevGoz5jlUTYoyPsyn5srYDI_NVLPW-yqQ2_6Hm8uIU_RGB74SeKl3ULC3fyV9czPcNltuLGIneV21B7Fr547bQZwebslHVFcahSNA6tIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddujedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:DzgzZqJyZ8jLz94tdpUfWlbg3vVveWNbX5PHg2HHcqhSNVz83ODhQw>
    <xmx:DzgzZlIfpapKA0CY8LJdERyl7pGcdfsMemTIhb92hqWCJIbUmySqig>
    <xmx:DzgzZjye8H75_yg88TT1f4nksJWscfj0kOrNbsnm78_UsQzxBQ_-Gw>
    <xmx:DzgzZhLZipRKmPxWMKbwlzKwoCb7KTjm8KhB3B6-2jUa0-IoqiMF3w>
    <xmx:DzgzZjhwSWBLg3IhBJW-9Aop3lhIekQyARpG47lhgAVCnr4G1JfZrXJp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 2 May 2024 02:51:58 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fc33b6c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 2 May 2024 06:51:33 +0000 (UTC)
Date: Thu, 2 May 2024 08:51:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 06/11] refs/reftable: allow configuring block size
Message-ID: <b4e4db5735beb106511980adca48dc416c4b0d95.1714630191.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4ah/na9Ljoe5tuEf"
Content-Disposition: inline
In-Reply-To: <cover.1714630191.git.ps@pks.im>


--4ah/na9Ljoe5tuEf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add a new option `reftable.blockSize` that allows the user to control
the block size used by the reftable library.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config.txt          |  2 +
 Documentation/config/reftable.txt | 14 ++++++
 refs/reftable-backend.c           | 32 +++++++++++++-
 t/t0613-reftable-write-options.sh | 72 +++++++++++++++++++++++++++++++
 4 files changed, 119 insertions(+), 1 deletion(-)
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
index 1cda48c504..c2c47a3bc1 100644
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
@@ -230,6 +231,23 @@ static int read_ref_without_reload(struct reftable_sta=
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
+		return 0;
+	}
+
+	return 0;
+}
+
 static struct ref_store *reftable_be_init(struct repository *repo,
 					  const char *gitdir,
 					  unsigned int store_flags)
@@ -245,12 +263,24 @@ static struct ref_store *reftable_be_init(struct repo=
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


--4ah/na9Ljoe5tuEf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzOAsACgkQVbJhu7ck
PpSUGg/+OvYRh+NNYkzGDh9c/jEn0PiiyMeCZYudd25xGXVXFDwQWEJM2LwNi2wa
G6T5vccEnyAwNOR1jqBvpJSfyJQiaaxYsiPl8+6e8DZJPsG5CYIv3H2PP3CpNO8/
K/+orjAJ2cQZqAhBmhVjX2DM8Tz206TFhgJAusqIJdBcoZr+2cQW8sigmx+ZlCcx
QvZ8czI4l4+wIfJPU+Lll3k+w7sXbWosI4P8I8n1Wtlt3sCI/BeVe0FUytQvXeHI
lRgQnvRpGyotVTfenL2MfgfL2eNRHpGcLdA5zbEcn6mkpLLdb2MCAzivglEWt4xf
5+CaXzhyyAHE8NUtX/jvy1zemcmD/KFbEVKsRjMphFDtJIMg50PLBcwxJQbkfhEn
RX/oIQPad9HyAbUYxD8D/RUMl5RJPEHfDW1Nt/vKsqPXzKbnexSWyhzPKWrh1saB
4LoW6HEOAzOhemg7VP/lfG3mPJnuTqpt1WAU3d43JAnlN83li2s9MZzXaC+XUnjI
GmqBPYqjtF5PhGBQivKGvrSEvQ1wTjvH8VybJf2idkuDUiY0WZCIN0pJ2P8V4dhb
oZ138/73BWzUKnbrXnzKAmzAkzr9hu7KSvuRiL86r4KzpugcJzZYZ9pL2q+VKLNb
JfryXbkjMYODpmQEGnVmj0s6umfW0cL8Q/3pzNq4AaY7oh8dBbI=
=NKZK
-----END PGP SIGNATURE-----

--4ah/na9Ljoe5tuEf--
