Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D977146A6D
	for <git@vger.kernel.org>; Mon, 13 May 2024 07:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715584515; cv=none; b=i/lynzUg66I0V0yssiTx/2HO22CoK/hZJbSY6S1nKUJvSgVswn4pWg2asMqlol5VOitSfyoNtk0LQObNUwulNMJNFOyTHael24uZ3/2+7dQQb9NeCmQ8HPgiepk2AfMk6DRU4ALN/85hsiJxylIZ+9jAdTGUucvtx3ZFLXCqLLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715584515; c=relaxed/simple;
	bh=sspqcdNnO/q9j8VdLery3iG+dNU/IVdP1JfQZHR601U=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFIBndOkEWaxL6hiassFHIdiylvvLG1+qPLSEAnhWw+cjf4jF4IVlbUyUk9E2z1qyXlf4zEUtiqL/ib4iy4JQ5U4yn1/xfxXGaRP9ABttXPBwSsM5G0k3S95k5NHpy2AxUkxZ1znVLV5ClXIcbN/YgaERnZu6P47CzDPEV/Smgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MSe3hNQD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RovyOj7/; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MSe3hNQD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RovyOj7/"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 683A91800103
	for <git@vger.kernel.org>; Mon, 13 May 2024 03:15:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 13 May 2024 03:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715584512; x=1715670912; bh=ZfBMD2FaJo
	rOMUYHQIByqqDdg8VSFLnTvRspMuv0sdI=; b=MSe3hNQDzbRUXmkkr0cff+T3Je
	k5HaOd3XyqrkM6HXXXGP65KIlDH4zeaqVeqHr9lG6ebNkxvQtiATE6bdUgbIU5yu
	kBXos8kvBA4CrRPOB3AaRBW9nQOGA04fpcYHSn038Z/2ONNQ7cYnCDMu+87+UpYu
	kcxBsxwCe0KKa4INJ1R8qtGL7HFgj4N2VLurAKnBCs7X79fgsqV/eW/9QKW3Dc1O
	TVZZZaekxtsaag3hjEkKAxFMNPDgTVlnW6FFXRnWfB3eBwmRroi3K2TbK7ndBrBx
	PmJKnzXeSCdi3DRJQuCIIpGSr8k/aehM38DlxW5kHbXYTIf+QaJ97KokH+yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715584512; x=1715670912; bh=ZfBMD2FaJorOMUYHQIByqqDdg8VS
	FLnTvRspMuv0sdI=; b=RovyOj7/CQoOkQPOlH6e05qdlP8MglX6jgaDmBcVD0Yj
	7QklbuJqNPGF/G5U0ocJvvqdpDpZVJOrT0mXN52EDg67ZRYuB0g+HSYZJBdiJrGC
	wHTYA/2ZIREHvcHc7GKwOuaAHGuLQy14dJcXvl2BzJb9oPYAK2HvMj8g1GOiB8OF
	3XFSmo9w2LtlT490CY0tglHY9Ytwtn5yfr33t0hHhFv9vjpbtYLTzRkq+RcG2jx4
	PH0CatUG8XHiMO+3AT+doDYnsKqGJs9Bx8yrEUexgtQODdywqXZ4rMohb7YvA2Hk
	DOO27dpfZJL75ZHcEBIFZ/smJV2Ac4AKUyG4hiAf9A==
X-ME-Sender: <xms:_71BZoIz7E-jr5-C3dIq-gmD5eLvEsYmEuHHQHp9vXCNRxfkY_NjLQ>
    <xme:_71BZoLWpr3AU3F4Mgr45DGsVuUat57d_e5A1Q7IVI7O2t_i4eW9FK1S2OGEgDG2p
    mJjOAXjWf_UGJxp3w>
X-ME-Received: <xmr:_71BZot5-hfnHOaMQs3kBBxD_kfh72hmDd4RN9RAXcVIEuJN3fAl68IHRNrDTUyV_v26QsmlhhtlYQfvKNOR1gIXyObnutANX7zkrC3ZzU6Dhg8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegfedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgfejueevjeetudehgffffeffvdejfe
    ejiedvkeffgfekuefgheevteeufeelkeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:_71BZlYO4BmIHwsGP9-s7SvQon3ESgZMH3-HGZzFmywnw0twpbsiaw>
    <xmx:_71BZvYi01g0MkQoFMTZFMwTacISFy1OrzSNJz81h_nsnDQsIwUPYA>
    <xmx:_71BZhCD_ZIKuAKs6pWKKb4d8t0C0rZjqeHgEEgg0Dzg3Mq6qz9gzg>
    <xmx:_71BZla_Dn_fDEvvrh0IV8pb19Wv2N1UkwRhX0hK8S16DYeqxQd_0A>
    <xmx:AL5BZmxOjhacy9ciY4_wf2TFnyCH2_u1PtwbuUbUGBEdoxWM0bJKsUEs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 13 May 2024 03:15:11 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 25908023 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 13 May 2024 07:14:53 +0000 (UTC)
Date: Mon, 13 May 2024 09:15:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/2] builtin/patch-id: fix uninitialized hash function
Message-ID: <3200dcad2372fef3bcb4da599b44043bcf5b3692.1715582857.git.ps@pks.im>
References: <cover.1715582857.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pJ2MJvfwztlOHASV"
Content-Disposition: inline
In-Reply-To: <cover.1715582857.git.ps@pks.im>


--pJ2MJvfwztlOHASV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In c8aed5e8da (repository: stop setting SHA1 as the default object hash,
2024-05-07), we have adapted `initialize_repository()` to no longer set
up a default hash function. As this function is also used to set up
`the_repository`, the consequence is that `the_hash_algo` will now by
default be a `NULL` pointer unless the hash algorithm was configured
properly. This is done as a mechanism to detect cases where we may be
using the wrong hash function by accident.

This change now causes git-patch-id(1) to segfault when it's run outside
of a repository. As this command can read diffs from stdin, it does not
necessarily need a repository, but then relies on `the_hash_algo` to
compute the patch ID itself.

It is somewhat dubious that git-patch-id(1) relies on `the_hash_algo` in
the first place. Quoting its manpage:

    A "patch ID" is nothing but a sum of SHA-1 of the file diffs
    associated with a patch, with line numbers ignored. As such, it=E2=80=
=99s
    "reasonably stable", but at the same time also reasonably unique,
    i.e., two patches that have the same "patch ID" are almost
    guaranteed to be the same thing.

We explicitly document patch IDs to be using SHA-1. Furthermore, patch
IDs are supposed to be stable for most of the part. But even with the
same input, the patch IDs will now be different depending on the repo's
configured object hash.

Work around the issue by setting up SHA-1 when there was no startup
repository for now. This is arguably not the correct fix, but for now we
rather want to focus on getting the segfault fixed.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/patch-id.c  | 13 +++++++++++++
 t/t4204-patch-id.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 3894d2b970..be5a85e71c 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -5,6 +5,7 @@
 #include "hash.h"
 #include "hex.h"
 #include "parse-options.h"
+#include "setup.h"
=20
 static void flush_current_id(int patchlen, struct object_id *id, struct ob=
ject_id *result)
 {
@@ -237,6 +238,18 @@ int cmd_patch_id(int argc, const char **argv, const ch=
ar *prefix)
 	argc =3D parse_options(argc, argv, prefix, builtin_patch_id_options,
 			     patch_id_usage, 0);
=20
+	/*
+	 * We rely on `the_hash_algo` to compute patch IDs. This is dubious as
+	 * it means that the hash algorithm now depends on the object hash of
+	 * the repository, even though git-patch-id(1) clearly defines that
+	 * patch IDs always use SHA1.
+	 *
+	 * TODO: This hack should be removed in favor of converting the code
+	 *       that computes patch IDs to always use SHA1.
+	 */
+	if (!startup_info->have_repository)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	generate_id_list(opts ? opts > 1 : config.stable,
 			 opts ? opts =3D=3D 3 : config.verbatim);
 	return 0;
diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index a7fa94ce0a..605faea0c7 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -310,4 +310,38 @@ test_expect_success 'patch-id handles diffs with one l=
ine of before/after' '
 	test_config patchid.stable true &&
 	calc_patch_id diffu1stable <diffu1
 '
+
+test_expect_failure 'patch-id computes same ID with different object hashe=
s' '
+	test_when_finished "rm -rf repo-sha1 repo-sha256" &&
+
+	cat >diff <<-\EOF &&
+	diff --git a/bar b/bar
+	index bdaf90f..31051f6 100644
+	--- a/bar
+	+++ b/bar
+	@@ -2 +2,2 @@
+	 b
+	+c
+	EOF
+
+	git init --object-format=3Dsha1 repo-sha1 &&
+	git -C repo-sha1 patch-id <diff >patch-id-sha1 &&
+	git init --object-format=3Dsha256 repo-sha256 &&
+	git -C repo-sha256 patch-id <diff >patch-id-sha256 &&
+	test_cmp patch-id-sha1 patch-id-sha256
+'
+
+test_expect_success 'patch-id without repository' '
+	cat >diff <<-\EOF &&
+	diff --git a/bar b/bar
+	index bdaf90f..31051f6 100644
+	--- a/bar
+	+++ b/bar
+	@@ -2 +2,2 @@
+	 b
+	+c
+	EOF
+	nongit git patch-id <diff
+'
+
 test_done
--=20
2.45.GIT


--pJ2MJvfwztlOHASV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZBvfwACgkQVbJhu7ck
PpR5rhAAk+3sFOkjvMS++Dr1ngSgKeLTUceBtJvyXZeQaIUz/XxdtPXaoxdHXHnM
+1ynW/kNGQRUbXWgIXqoZf7+oFeUWFsm4m7hjXFPsuyoaVfY8EcPFKhkN758/N8g
Q6Y6JaIXanpJu661F1XmknfbEVXa6iObw/VYN9YM9pjkaTf3ZToJT0OGQlqBfUoS
EHyEFgsW2dEaTFfnT0CD3yt1QgcjDk6uNfLLIIfhB6kd+AOjDx2yh5NSB9bYzqQl
vP4FJHerSNrWxmCvtO61klgo6ZIEqamuzqfuYaqF7no6Ij0gvH4WvFS8CI+2VKbV
xYiaePi0vFe4w694cpESe+FGiFg+vS1MMyQjSt8uoFnGJg5VOXoN5T/lmCdZTDxa
9RYf9oJ8ZBYexg6DxfuHbfmKssVuZ+u3hySP/ZFmG9BGtewb5PySfqB7J7zQSvYC
gLPAAFzAsq26BLKyK46E9PzfpEH153Uff16aFiUBw7N3l6309i+guBSK3SsVa1xM
1omu5paPgPzBnjGxFVlx9uL7Fdw8NiK/X4Y7n1GzkeYMDPyubtIBRl5eCNZlqPnP
aFJVq9W6OL2PqNsDp2MsZgYuoqp93rII5/VMUFjRSgILZ0tgGa+tWzDm8wCCbug/
rkUW892SgUJiUuhWVqOm63BOlsvE7ORZr0M6RRiJFViBoyU7kWE=
=QZ48
-----END PGP SIGNATURE-----

--pJ2MJvfwztlOHASV--
