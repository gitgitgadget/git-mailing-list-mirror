Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1464A60EE3
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 09:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419995; cv=none; b=tSB4Eo82RWTtSJUF2kI5NveTk67sol8RZvOYY7ikbz7KsZQVEIlqdtpDhcmbz4xdAfQftbr/0Av0zySyRKCK36XEv7Xo+mvaeVDbVHBGAEHXSHigwCG9l5qwjvTDFoGhuDmI+IOtnpARHwjNzLy6+rhh0gE+kWx6g9fbjzrL/r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419995; c=relaxed/simple;
	bh=Fa5op0+yjRc9hfzxhhWzx9Xpr4dHzGhPob0JkO4R0AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T43ND6Qub76OGTe/YsYPm4DGOi0cAxbfwvq3i9Qrjbfl8CPmVATD4x3br6c2rW2LVx7n6fsC2QVk+iESSdrWjmifd7YWW/l34anMlUXFbliXB308FQ95QkWlwGxFtgLTvXBBcwt/dHG4LbrvZI0p0auaB9iewRLNOpj7d62D4is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pZqvHqaq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aRn9fRMS; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pZqvHqaq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aRn9fRMS"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 36EB81C000AD;
	Tue, 20 Feb 2024 04:06:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 20 Feb 2024 04:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708419992; x=1708506392; bh=EI8QJ8sSkF
	mZdbTHrCGrFE18VpOynePNIOs0ruYt3+0=; b=pZqvHqaq1yH2s0hKw+8yEBv1xv
	nMBSOI2zJVKvuv3aLQP4/sLe+xjOJJJq7lB8n8Syyu0Z8qPh3ala4Ge0cARhmJ9M
	EEK68JC1RKTCtXwRui+qDtcLx0yTovBgr+GcuhuN3EsCgmPpV5fnRCDfiCsx+sHw
	AnxgBGZ+Yv3fx67xCL9DeRnEF9T4cv3hrGFEpI8dj1/T/9mhQG2BU3X5rnHOyIf9
	z9mY0/OJyRBpIQx0WDv1/QAIII87mvpzkOYSqQqPTaMwywXQCuE9OvIeSDw9gPHo
	jSp/xBS2YsfEqz0lfV56lKTbdE7eFlDQQq4HZQMy0aMqsiU17xqzOGrGkm4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708419992; x=1708506392; bh=EI8QJ8sSkFmZdbTHrCGrFE18VpOy
	nePNIOs0ruYt3+0=; b=aRn9fRMSpxslvBSGpze8KEM5DokkYurTsVWOEvKG/a+W
	/mnc6fTzSIOw/YTepd72B3t7faKb2BGay2v/wwkSR5ZqqxepFItuhIjxDNlO3+tr
	zTjFhtYvuxGnmRnLcr2iambOVDK3PuW5e/B33EwuCAxh45NwIbyLdLc0XKcNAPm8
	pzrejtR9x+GnSN0czcJBIU35jnBL9zhaMEnXmzDygcd5mt110rXnHswYzANuBF4z
	NieVE457/EqOjCT2Ma+/gMMip0S/0K/kahiesfO/CGjpkqQEG1/9e69jlcoWjXeM
	e0MWH9Y0SX1lA7eU7XxJbi6ofIt+C29rjGcw585iNw==
X-ME-Sender: <xms:mGvUZZlVpZPXptj68eN78-_oaUaSVXLyYnwF_lPv6Y9rRnORYKlH2A>
    <xme:mGvUZU0ET0erDBvIZg5vXzKg2bU2AnFH2pAbK5GojpRvIBw85JeBjKb21sw2gKcTc
    XoCvgr24U--I-xxuA>
X-ME-Received: <xmr:mGvUZfpa3g6KDalUqvzrb0wFQ1oGbUZR4rJ9IDaNRLxT6FaxuEa5A3cWs20Oj9l5SVm8ccJbNJ0LXQAVuVBhlLgXbz2qsZe8MEY824g3f77TpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfe
    efgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:mGvUZZnExAlswTBgXJK9hCXjpmPe7PYr1HzyO3iv1qCQRbOK-C0xug>
    <xmx:mGvUZX3vuBilaA6jrszPyHXbnTBM5WJHOLzPTPgd3QD1apEHwopCRw>
    <xmx:mGvUZYviClzutwxKqVMITnlEnGn8a8uEBAjdg7JVu_YcjHufMEzZgA>
    <xmx:mGvUZVCPcQkjR57Iw3r40Jjm7Br6tkRkWf8oldAbi5SjCtq_5ZhNTGnxvNU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 04:06:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 53703527 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Feb 2024 09:02:30 +0000 (UTC)
Date: Tue, 20 Feb 2024 10:06:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/7] refs/files: sort reflogs returned by the reflog
 iterator
Message-ID: <32b24a3d4b91a6073bb1a677080c74da828811a3.1708418805.git.ps@pks.im>
References: <cover.1708353264.git.ps@pks.im>
 <cover.1708418805.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dgid/olNU9lZfpLb"
Content-Disposition: inline
In-Reply-To: <cover.1708418805.git.ps@pks.im>


--dgid/olNU9lZfpLb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We use a directory iterator to return reflogs via the reflog iterator.
This iterator returns entries in the same order as readdir(3P) would and
will thus yield reflogs with no discernible order.

Set the new `DIR_ITERATOR_SORTED` flag that was introduced in the
preceding commit so that the order is deterministic. While the effect of
this can only been observed in a test tool, a subsequent commit will
start to expose this functionality to users via a new `git reflog list`
subcommand.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c           | 6 +++---
 t/t0600-reffiles-backend.sh    | 4 ++--
 t/t1405-main-ref-store.sh      | 2 +-
 t/t1406-submodule-ref-store.sh | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 75dcc21ecb..a7b7cdef36 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2193,7 +2193,7 @@ static struct ref_iterator *reflog_iterator_begin(str=
uct ref_store *ref_store,
=20
 	strbuf_addf(&sb, "%s/logs", gitdir);
=20
-	diter =3D dir_iterator_begin(sb.buf, 0);
+	diter =3D dir_iterator_begin(sb.buf, DIR_ITERATOR_SORTED);
 	if (!diter) {
 		strbuf_release(&sb);
 		return empty_ref_iterator_begin();
@@ -2202,7 +2202,7 @@ static struct ref_iterator *reflog_iterator_begin(str=
uct ref_store *ref_store,
 	CALLOC_ARRAY(iter, 1);
 	ref_iterator =3D &iter->base;
=20
-	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable, 0);
+	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable, 1);
 	iter->dir_iterator =3D diter;
 	iter->ref_store =3D ref_store;
 	strbuf_release(&sb);
@@ -2246,7 +2246,7 @@ static struct ref_iterator *files_reflog_iterator_beg=
in(struct ref_store *ref_st
 		return reflog_iterator_begin(ref_store, refs->gitcommondir);
 	} else {
 		return merge_ref_iterator_begin(
-			0, reflog_iterator_begin(ref_store, refs->base.gitdir),
+			1, reflog_iterator_begin(ref_store, refs->base.gitdir),
 			reflog_iterator_begin(ref_store, refs->gitcommondir),
 			reflog_iterator_select, refs);
 	}
diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index e6a5f1868f..4f860285cc 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -287,7 +287,7 @@ test_expect_success 'for_each_reflog()' '
 	mkdir -p     .git/worktrees/wt/logs/refs/bisect &&
 	echo $ZERO_OID > .git/worktrees/wt/logs/refs/bisect/wt-random &&
=20
-	$RWT for-each-reflog | cut -d" " -f 2- | sort >actual &&
+	$RWT for-each-reflog | cut -d" " -f 2- >actual &&
 	cat >expected <<-\EOF &&
 	HEAD 0x1
 	PSEUDO-WT 0x0
@@ -297,7 +297,7 @@ test_expect_success 'for_each_reflog()' '
 	EOF
 	test_cmp expected actual &&
=20
-	$RMAIN for-each-reflog | cut -d" " -f 2- | sort >actual &&
+	$RMAIN for-each-reflog | cut -d" " -f 2- >actual &&
 	cat >expected <<-\EOF &&
 	HEAD 0x1
 	PSEUDO-MAIN 0x0
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 976bd71efb..cfb583f544 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -74,7 +74,7 @@ test_expect_success 'verify_ref(new-main)' '
 '
=20
 test_expect_success 'for_each_reflog()' '
-	$RUN for-each-reflog | sort -k2 | cut -d" " -f 2- >actual &&
+	$RUN for-each-reflog | cut -d" " -f 2- >actual &&
 	cat >expected <<-\EOF &&
 	HEAD 0x1
 	refs/heads/main 0x0
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index e6a7f7334b..40332e23cc 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -63,7 +63,7 @@ test_expect_success 'verify_ref(new-main)' '
 '
=20
 test_expect_success 'for_each_reflog()' '
-	$RUN for-each-reflog | sort | cut -d" " -f 2- >actual &&
+	$RUN for-each-reflog | cut -d" " -f 2- >actual &&
 	cat >expected <<-\EOF &&
 	HEAD 0x1
 	refs/heads/main 0x0
--=20
2.44.0-rc1


--dgid/olNU9lZfpLb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXUa5UACgkQVbJhu7ck
PpRFyA/+LY1Sb4zYtTrRJkLhx5Ea/Yvoukz093tHOf7SEqUWHegGcCh5O3Nxk6OY
8c1ANqmAMVa0KZeTNAbDrmakuzSLHUCyyggbbXWB1BD8tsRSHD4EKSJc1DQD6BD/
Oe2nMbMMrsmfevg6+c3Mum6+OzozdzuhIkGC+z8UG6brX08l2sa6gF4p6m2ezCXX
h40ym663c93UEEK7VmAWekIxv07zczXMQXpTJgDARlrfpAFz+eVOrCfyPt+AL6YH
j4FjLWl3qi6ZEzEKgC2N3B43p4AsQpkaydyKkxXXzwkdkAjySk4JbmbRC5AnhVGp
tgSAToDKidHvyo5wWdOkJjVNohWkbsefPHejrCMlSFUP7BCnEnU90JCSz/3fwdnD
KRPD+hYnT0ehg2FFDbV4Nu6hMbIiHleYHO7EiyjaFObM0G8I9h3lWcFoZYoJ5/f4
X2FmGOqU/SngAi8JwNq+/BXJtFHjn9IpLwSJbG3fghaqMMFtgW3VR/yECxn1Fhsc
LBAoOoyUaGaDe0/ou3HgIutqa5ATkDb1ocYlNgLg1bJL8CZNZtLL9NObKOz2ZIaM
BVO4LzMiCjlq2jG9P3e2AJgAIaD9rrROZ/fY0iC+ydsWsqTOyN/iKG+5u9KEYyCK
/d3KWmuNOUGBprRNOYCfqScsHYi1I/MhDMh4IecJGV6CeJ8JkUE=
=ZsNT
-----END PGP SIGNATURE-----

--dgid/olNU9lZfpLb--
