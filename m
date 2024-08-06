Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C3018D630
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722953691; cv=none; b=uJddZQDR/wEpRjhxAUryXoYG3acigVhXnK76Ov23NSBATo4ylH/P1M7X24foEI6gbMPRCPxoEe7AlZnuVqY9UeqmDp1BWzO/SQSM47rr+hk51qoPauwBgBCKiO3DndP1FncKOJX9O+lZlHN8GWzUqd56tUIcqTQjcIMLiLRqTdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722953691; c=relaxed/simple;
	bh=pDMoWw9PjqtMynckR+PN4XbHrQa6sX3eiNPQMYOsEHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ralQl4sk9qFobPH0xz95yDKVrc2SMGpFhZa4TaVwgfbXtgy77Z4/NnulBQGl7fzyw7oOamhb6KDA6DEI6ew7ByroBSucMEmZtSGA+IHAhKnwm0QHgOe0mXq95g87BpAIJYNq0tSABh0WXDhwCN6/zlkE+bCTYA/mynASIKCd4BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aQ9CXm7o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OQZ2P9cS; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aQ9CXm7o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OQZ2P9cS"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A0FC71150DE1;
	Tue,  6 Aug 2024 10:14:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 06 Aug 2024 10:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722953688; x=1723040088; bh=qYMQLJ5obz
	MTtm+TUnMZ6j7toLN++flW+ZevZAGu3RQ=; b=aQ9CXm7ogXvDY6jw/9S6Hqr38r
	FRS4JYnJkiL0OEHgJ2A9yvTfoTNYOoCwHGnMDRwJ6VAsOOxdTVYeY/6lWhGhaHa2
	a1lGbx3B3hcv9G7yyfo4mwUWsQt8tViMJWj9XV26Fj9ezgpqOoV54sPr2jyzXBkj
	CrNUYYiNbSP+fyDsgHjctijPz2jKSzE/1izBMLCHETc7aLW2OfFyJ4vT3uMDk8RT
	Bg35NgFU8XklqHq79ejrA2H5eBKRHeptEBh7xkM8lRyAufG90hV55QROSZu6wYub
	K9b/fYqcs57rqIzIA4BEQwJsAkVy9X8vqGZFUSJXmcpLURv+skBShrxXyhmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722953688; x=1723040088; bh=qYMQLJ5obzMTtm+TUnMZ6j7toLN+
	+flW+ZevZAGu3RQ=; b=OQZ2P9cSySMnBRif0ahFQTiJpOVURjfp98dNvszZnVGB
	Cqy3+L5AcmIR8ZiNnmj8ISYFkCZQ0LqnDdU2bCUB1IMi7Z4klykWqopt4T1jg6yj
	V0T3vfoYf1ayhlz/jOynMeJejIDv6Ljkwi+eqImSeji/tV7O6yLAr65KYM+2+rHr
	p6bYjGGu53MIcHv+1L53YEiToHtkx4XwoduAtuKpX7uToPxXyvVhkgQMwo54iNsB
	gohoxlkGR6CxZSbKD2QVABA8wH0v3Ke/GUzCyQASxDArhuqN8dRINNyt1XL3ooYb
	9cmLUgV8GRgmekhZLTOJ4tYBVK9AkyxfdPLGO9dWpA==
X-ME-Sender: <xms:2C-yZtSRzcLhDlH2RHZChrFHjK79eWAKER6URA3HEj-OtUmRLt8NdQ>
    <xme:2C-yZmyr8TH7rutDmMKkfczymvVOruZuq48vkdRP5FRwrUHN3qM6-s2hudRkSL-bj
    _CGPMVkiF-a9zqyyA>
X-ME-Received: <xmr:2C-yZi1d2Qrtfyamr4Bn3BPVAVSYLvsDxawFBhcpYpuV4kyt9T0o033k9GkXTvTiyYsE6MvGeN0ea44v1ytSnEIEAhMLTssxrkaeX4zXBM9M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeljeetffevheeggeetkeetieduieeiieegieegtdffheegkefhjeehfeekhfevleen
    ucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    td
X-ME-Proxy: <xmx:2C-yZlCGohg5YuOuZ7a-Xm5WHMIy9yWlwlc7SmwRUUC8fyjQ3rotew>
    <xmx:2C-yZmjU4u8Y3dE8wawfHFU5-dT8A-ZgcZJVCmn5Wt54lAo_IkF9QQ>
    <xmx:2C-yZpp8MG9aAFhaeUT9Zz9JmsOmmN-3uhbzBGZNqeMxkoPFSBUtuQ>
    <xmx:2C-yZhj7LMSqsosWyvzKJxn5-zzUFQ3PCpDtjFUvJeilA4NofknTbg>
    <xmx:2C-yZvXq_cNGSsnXIvbOF3oEUMLGHB0SApvu4OrKyrnntEsLunYzNFSS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 10:14:46 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 81cf0c11 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Aug 2024 14:14:43 +0000 (UTC)
Date: Tue, 6 Aug 2024 16:14:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [RFC PATCH v2 3/7] t/clar: fix whitespace errors
Message-ID: <a52ee59bf4115acf29a70ebb62e94e880698df26.1722952908.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1722952908.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hz+f6srJb8gaENco"
Content-Disposition: inline
In-Reply-To: <cover.1722952908.git.ps@pks.im>


--hz+f6srJb8gaENco
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix whitespace errors in the clar that make git-apply(1) unhappy. This
has been cherry-picked from the upstream pull request at [1].

[1]: https://github.com/clar-test/clar/pull/97

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/unit-tests/clar/clar/sandbox.h  | 5 ++---
 t/unit-tests/clar/generate.py     | 1 -
 t/unit-tests/clar/test/.gitignore | 1 -
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/t/unit-tests/clar/clar/sandbox.h b/t/unit-tests/clar/clar/sand=
box.h
index 0ba1479620..7c177f3525 100644
--- a/t/unit-tests/clar/clar/sandbox.h
+++ b/t/unit-tests/clar/clar/sandbox.h
@@ -25,9 +25,9 @@ find_tmp_path(char *buffer, size_t length)
 	static const size_t var_count =3D 5;
 	static const char *env_vars[] =3D {
 		"CLAR_TMP", "TMPDIR", "TMP", "TEMP", "USERPROFILE"
- 	};
+	};
=20
- 	size_t i;
+	size_t i;
=20
 	for (i =3D 0; i < var_count; ++i) {
 		const char *env =3D getenv(env_vars[i]);
@@ -151,4 +151,3 @@ const char *clar_sandbox_path(void)
 {
 	return _clar_path;
 }
-
diff --git a/t/unit-tests/clar/generate.py b/t/unit-tests/clar/generate.py
index 931b4d60d9..80996ac3e7 100755
--- a/t/unit-tests/clar/generate.py
+++ b/t/unit-tests/clar/generate.py
@@ -264,4 +264,3 @@ def write(self):
     suite.disable(options.excluded)
     if suite.write():
         print("Written `clar.suite` (%d tests in %d suites)" % (suite.call=
back_count(), suite.suite_count()))
-
diff --git a/t/unit-tests/clar/test/.gitignore b/t/unit-tests/clar/test/.gi=
tignore
index 3e8ae0a3a5..a477d0c40c 100644
--- a/t/unit-tests/clar/test/.gitignore
+++ b/t/unit-tests/clar/test/.gitignore
@@ -2,4 +2,3 @@ clar.suite
 .clarcache
 clar_test
 *.o
-
--=20
2.46.0.dirty


--hz+f6srJb8gaENco
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmayL9MACgkQVbJhu7ck
PpQ0gg/7BenOs2jX0wZqSTaT3a0Q6mnWGE5iQg/PegG8ORD8jtfyx8vpbnd6KcHq
uKFswrp7rXnnLaxNMhyJlNW04BcGsDpXSJbDIjmOuZsL/8wI8RtbGXa5Vs8OHasa
DatUSshcgBHkhY2q36OnJ6xmS+Po9P7rgBAK8hs2cLRWwHxGfth45tNkPO3MjOq8
NsgPUuTl97tM+D0jlbeASocmDPu0uGqolG9eVoNT9hmmOYqOmq2Dxyc7FgTW2Fop
QrUxewFVuP1HsZii9W1SNtLXdc5HtK1wuapamMbQSNkuZarRqKJUnqPImz2QsYrx
qHtSRZy7hFTwDip4tZRj8Vnhd+YwiSZnOmYjYOvt9bHCUjQzijZ0m9cvL0J/mPql
2d3y94d2oKrbs+B2l3/YrjIx37sA1WWRkiSdPMzcLcViBX/MAVQrL0CRsRJ8IQcX
QEHbGYhiywpd6qQpzNkiaaA+D1A5W+FWBjOvpsHWpt6xgb/C+CVmX5j/GP4lSV3R
goPhgAm+gT5OslphAPc7AG63mJGqYRSwY3M8gqwUMX4MINBQSm0vqUrtevw6/sub
ww+DMFrYqbdiNfPdAip56nqzNFRkYPkdlPyzgmtTPqQpgndGyfKjfLVWwUOD8FSD
GIlkGrLtcfB4UC0twvoqtqCT/6Qp7Bn5LmE7BqQ1nwfBSfxHMMU=
=n6YJ
-----END PGP SIGNATURE-----

--hz+f6srJb8gaENco--
