Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0E31482FC
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 06:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347871; cv=none; b=fnFgil5n3LaRSVa5uL8udpqr3nHq8jVt31rJqhkH+/K7xExbdqAl54tf1KuuHtD57ZWdTT5HFtuPg1ELm7sFmQLMjZXgnR4mXLyJ8WRbu+FpB3nKKjMuGcTzcn3zPC7mMjtiGQh38aZkm759ELIPEysYwdz2xfMUsCQ082R9CTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347871; c=relaxed/simple;
	bh=0LrE+lb45CPVrnENsIgSmbq1i9rUQHQfcTpxgxrFd3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPM0Ksslk9f9SKtrBFu1xrC56xHslklsJ2Yy3awDfoFAfTJL5eegUgk50NsAPLYuGmKZOtjtEw25xCix3WExZIbV9wa+Rz342n1iAugKDrkGcBv6zh2tFOzWgeHdJSBoGjVrgqhoN4GxI3WjINm8njla4nnrtbJLEyWqDsZpiGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IRAvPMqY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gyQ1E0QG; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IRAvPMqY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gyQ1E0QG"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id D5B1613803EE;
	Fri, 14 Jun 2024 02:51:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 14 Jun 2024 02:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718347868; x=1718434268; bh=Ie2WJ3ZF62
	yAeYlZf8VyotyNOkpaUHTB1mdyxJSnY6U=; b=IRAvPMqYKkSzMOelheerwvsPUM
	TsDcpH+ItvSPZc8DTX2m3unNUQC0RKP9TjesK9m6+aGlkUW62yhCM9NNbjq7uvAQ
	0Xe3Hu+D43CVxymIcNgad1lS30pyRkyXUk8ezkjTuThQWNy31xk4yGlltYuIszXf
	wn++m0k46MnqUUIrrmwDkcPyeIJznDp+mmP44GJcBklJINMezSgpQ+EMjyCv+5yY
	qsbwe+wcOQX0LyGzS1fQ+sf92jgAYXNEaZor/Fmniw3ZMnhrfNJKzbeSa9WCaYie
	1kmArUXLwf4RnG6NK9TBwffQ9Pl0/1kQpUaUJDGC3lqH8QZpBp9IxTs5QoIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718347868; x=1718434268; bh=Ie2WJ3ZF62yAeYlZf8VyotyNOkpa
	UHTB1mdyxJSnY6U=; b=gyQ1E0QGt+1922QaCXrkwC7JBnBRVvxV4m0p3T+lg0m9
	PvuLaBD8JhMHtG5ioVdL25IYECUzRhl9dvDi7dqD+sXIkz6YT8J7SzgmMqdTBhQe
	55NZ9QTzhq3TUjUGyHKEv6ELSFoNJj4igVMNVRg08VjC95O8+XLKpC3yuerhWzAB
	N2fi+IgqmntIo/RrjYxL13fAYxRDeEg0Btc7eADa6SoEszJhH/DhprJ29NOEb5lc
	909kxIYOwvCoqY4JXrP7hdroPgAsUV5kdYkmmFL7jp32ZPXEz+1uE5EDtnjcEE+8
	ERL7yjda1OHzpfRiX0YsrZmbrd4ivBY2yQIrdYCEIA==
X-ME-Sender: <xms:XOhrZgWqxr4DRSiPc83UmwyWH1c_0wGht-YcV00ljvJxqHTYrk7dIQ>
    <xme:XOhrZkn-6BHsotRiR3G2csw56QA6RctLpsq73psGkYtfm_In4sCJLzfbddGuJWMp9
    J1HLJwOicVQGom7_Q>
X-ME-Received: <xmr:XOhrZkYzVqVvbboUFL62pHAUlm5mmsAUuBOhiTKJkspZJXwP6nyDd0h8IEOC45MIeRFQ37vcrN9iVf1AeMW1GfKgKaDQpZBPcUpD8hLoyzP1oQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:XOhrZvUkMBVyNCpfCK5RNZUBuNhFLEV7bhPOqVe5pXzLyfZeqTLpFw>
    <xmx:XOhrZqme0woTrvHZyPA-bLfKDhl7eqjKrm6zl5chtuFGvkYdeH6yKQ>
    <xmx:XOhrZkcAWQ_IVZ4NaCVWmTyMZhimp6p4PMjE6zA4FDrgMq2GjvXCig>
    <xmx:XOhrZsF5NsVKrInJP5q3zCAxxBaWwMksvth0vJ-qVVxj1gEYJIeUsw>
    <xmx:XOhrZhuUbdNQd7c8-V8bYAdqyizsQQUiBFbeneE_9UiNUtidxTq_43w2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 02:51:07 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 486223d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 06:50:53 +0000 (UTC)
Date: Fri, 14 Jun 2024 08:51:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 18/20] t/helper: fix segfault in "oid-array" command
 without repository
Message-ID: <a488363bcb22dd1be4e1d8f89de8acc4a95e2f6c.1718347699.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718347699.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Gv7xgHMmjwKPISZ6"
Content-Disposition: inline
In-Reply-To: <cover.1718347699.git.ps@pks.im>


--Gv7xgHMmjwKPISZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The "oid-array" test helper can supposedly work without a Git
repository, but will in fact crash because `the_repository->hash_algo`
is not initialized. This is because `oid_pos()`, which is used by
`oid_array_lookup()`, depends on `the_hash_algo->rawsz`.

Ideally, we'd adapt `oid_pos()` to not depend on `the_hash_algo`
anymore. That is a bigger untertaking though, so instead we fall back to
SHA1 when there is no repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-oid-array.c |  4 ++++
 t/t0064-oid-array.sh      | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/t/helper/test-oid-array.c b/t/helper/test-oid-array.c
index aafe398ef0..076b849cbf 100644
--- a/t/helper/test-oid-array.c
+++ b/t/helper/test-oid-array.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "hex.h"
 #include "oid-array.h"
@@ -17,6 +19,8 @@ int cmd__oid_array(int argc UNUSED, const char **argv UNU=
SED)
 	int nongit_ok;
=20
 	setup_git_directory_gently(&nongit_ok);
+	if (nongit_ok)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
=20
 	while (strbuf_getline(&line, stdin) !=3D EOF) {
 		const char *arg;
diff --git a/t/t0064-oid-array.sh b/t/t0064-oid-array.sh
index 88c89e8f48..de74b692d0 100755
--- a/t/t0064-oid-array.sh
+++ b/t/t0064-oid-array.sh
@@ -15,6 +15,24 @@ echoid () {
 	done
 }
=20
+test_expect_success 'without repository' '
+	cat >expect <<-EOF &&
+	4444444444444444444444444444444444444444
+	5555555555555555555555555555555555555555
+	8888888888888888888888888888888888888888
+	aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
+	EOF
+	cat >input <<-EOF &&
+	append 4444444444444444444444444444444444444444
+	append 5555555555555555555555555555555555555555
+	append 8888888888888888888888888888888888888888
+	append aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
+	for_each_unique
+	EOF
+	nongit test-tool oid-array <input >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'ordered enumeration' '
 	echoid "" 44 55 88 aa >expect &&
 	{
--=20
2.45.2.457.g8d94cfb545.dirty


--Gv7xgHMmjwKPISZ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZr6FgACgkQVbJhu7ck
PpTVeg//Yqv0Dwq8WHnWCQ4tXgzenfm2sqbMQTvFEaqwafDLglMHrFcnMd1pul9n
mdBgCWh4xJ7aQsdQ8f2BvjAN3A8EleiSNiagGOjIk8OOV8qnnf8SN4d1g6zN9sZb
cCTGxqm77L4bEiPcmv26DJNfGfqnYqWoGhts/nQKqFrlEzYrPDO3T8wVgVnstRUP
FZUCdFG51ZoSMynvR5pkyqD5aHLAxI9DgcGvwCGHjdkHSXbp0IApitt8OCfu6ZZn
rDeYGPEJYI9J0DmYzJPzq7N+7qgwi+JJtLn9MHWfgY5Gh+45gnkm774OQChTAwCQ
RGMeBY3/DpigzPi8NL0SLcBtGgnRmOBsmkhUtXzm9WAQEdWi11NAyUYxVLfjg4qw
gvMCWEkDPwhixGImOhUkFxvrL+V11daW6PMJVYhXn2Pjo6rXcT1yn1AOMmZXLEjI
ExxCIedbQEgLjNNcvhlCnE0NGZaWQdE+IUc/Y/K5yxqzp9ApjVnyIfyJfMlNAms9
c7fsijVPn1bokEsyvrOAnK+4E555AvS2JnvvB6vssbWVPH8MGdfb8ejSJ6b8bL+J
3i34/vlf75TfrZRRnMxg4MkU5rCL4IXYOOCqsFXt0xkshvs6EZfP2K6RdtwHfEPg
7XqCIk1xfWpT5brv1lAZbXVDgeFEWfPoFrXkapFoTk6whVFkkGk=
=EzhC
-----END PGP SIGNATURE-----

--Gv7xgHMmjwKPISZ6--
