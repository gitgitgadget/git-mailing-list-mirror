Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA8A170A37
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508827; cv=none; b=f6CTp8K3LzJvhtDf9UzbbYAyWR3/lyRD6cLx3CUqMybsQIn5MxQ1BAQAkyjHDISCunWwJkh7UTkKEjExkjwgnnDSpj7b96Gyy5C1hZ5TnjFG17KJvRT6mJN6duRD0cr9PTrTpEQVwPlf2/bmFPMm7DXFI2e5E1dQLcqzJEoq2BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508827; c=relaxed/simple;
	bh=MsyvqIJImmYrk/N/gbvJ+kfwNtmF/pDzCtTaMyuhKIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rs+fSmQhtJ6RZobtdPAproXxDz9sxmKCVSuNJXDF6uMnGa60hfv/NpV0pz7O4lRPJabzTbd9MRgzAbr+ALFwfKkwVT8n9ccz+olFlUczGgfnWtBDX2IKEIzPcLr2K+OZR02mkrJbx7Fd0W/u3Q2J9TsJDzG6a36JFwwSyOcuDWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PK8OSMx2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NyU5wdOH; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PK8OSMx2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NyU5wdOH"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 23CBE1388015;
	Thu,  1 Aug 2024 06:40:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 01 Aug 2024 06:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722508825; x=1722595225; bh=Lz6+bQErON
	SkVnPLEu/e0DC6ehcFzq3A+MhfAMl1RQs=; b=PK8OSMx2ATHL8Jfgt5NubUFDt3
	dJtL7QYz8oVTD8Qusy5qf8PrjjCTROY6achtNtPQD45uXFTe2CTmlpOknYCmfHkB
	fdRoRxbRIOJpUhRW/tLN/WM80Yp6veQiaC7JdguBavxZFk/FqTKYg+U7SFBjUHiW
	rB2w3XvukMqQynem+W6dubs8WWP3/kRP7rLK9ye9m4bsvM4pgyC0lL52Xqzh1SFB
	mexgDgakU9I1LM3tP+P8wGG0WqZ3no1Haq33ZWHhs8YEt3OCyQsoiqPGJcl23FSo
	QqGnIOK4LhUPOFSNT8SLZMZu0rV23odRiroK9zcwHKC7jCEpcY0jErYvktEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722508825; x=1722595225; bh=Lz6+bQErONSkVnPLEu/e0DC6ehcF
	zq3A+MhfAMl1RQs=; b=NyU5wdOH8czmHvH45IMxmo977kD+lw2IVBypHoGu+FnL
	nn4BUL1vMs2ZZ781+r9a8qSy7EvUOzrrx8ZyA76KozCZQBnoh2cizLetbFpG7Xw+
	VRwMKnw6A2BduBeLX/0BNipvR2hcmgltR2pJREQyJSRuKuLoGbsXg58kgvRH8PqV
	/d2sJNWZkr5Jye19szoHcI9vf+vbrWboMF5OWKt/8rY46A7aElPWANcx6aTcix9n
	44bpdhseuNNJsAsOZJM/pu4EHWmwAVAil/teRbB7skLe39p38g5wOKWn0UmpHhB0
	up4FNUNDzGKfIGmED7T6oOzj5Yx7jOux3oSkZIcHcQ==
X-ME-Sender: <xms:GWarZprAhEm41ioQUW3FiD3nBpMROCCdnXIUiO2YlYMTe3J9KkdChw>
    <xme:GWarZrp5fvT2k98m_l3YLPhBqaf0uVs_C2C-wlaF3xYsqMaCl9Gy9LvWQRA4-YLtz
    19FRxO6USNIcHoZMQ>
X-ME-Received: <xmr:GWarZmNIDzY_7hvpG4hlIqER-yUfoXGR0oe5y1cbNnE1zt_y5iFcUWO4QpIaeSdzow-3uymDOH2AQCyAuADdGQbFciIZ1L9YPJRMEUK5qJdqEcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:GWarZk4wspkP_rWjxCI8Flr6VLKolzDC-XITckLM1YplezOX9nZCVg>
    <xmx:GWarZo5pcPDygmNeVchJ915mqA_ZmEqdlPrs7YNfp4zx23Q5-z4uyA>
    <xmx:GWarZsghgVJ8Cdv0vgTKmoAD_kt8EXCO90E4c2fj694MhYcUbpusWA>
    <xmx:GWarZq6jUizH2cedPJISMfdSvrvjzGJkT-ngvXwlLBtrRa1HUsd9Hw>
    <xmx:GWarZiQQAs0epidOtEtBaKm_OL1_pS4A1Srhs65kLF6gAKVis8z2EKoQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 06:40:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 712c7e06 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 10:38:52 +0000 (UTC)
Date: Thu, 1 Aug 2024 12:40:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH v2 13/24] builtin/rev-parse: fix memory leak with `--parseopt`
Message-ID: <034c416d4693701cecc3201b9f8d9839fd99c1ab.1722499961.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
 <cover.1722499961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aUBpITW5qVaGLfL3"
Content-Disposition: inline
In-Reply-To: <cover.1722499961.git.ps@pks.im>


--aUBpITW5qVaGLfL3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `--parseopt` mode allows shell scripts to have the same option
parsing mode as we have in C builtins. It soaks up a set of option
descriptions via stdin and massages them into proper `struct option`s
that we can then use to parse a set of arguments.

We only partially free those options when done though, creating a memory
leak. Interestingly, we only end up free'ing the first option's help,
which is of course wrong.

Fix this by freeing all option's help fields as well as their `argh`
fields to plug this memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rev-parse.c           | 5 ++++-
 t/t1502-rev-parse-parseopt.sh | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 2e64f5bda7..5845d3f59b 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -553,7 +553,10 @@ static int cmd_parseopt(int argc, const char **argv, c=
onst char *prefix)
 	strbuf_release(&sb);
 	strvec_clear(&longnames);
 	strvec_clear(&usage);
-	free((char *) opts->help);
+	for (size_t i =3D 0; i < opts_nr; i++) {
+		free((char *) opts[i].help);
+		free((char *) opts[i].argh);
+	}
 	free(opts);
 	return 0;
 }
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index b754b9fd74..5eaa6428c4 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'test git rev-parse --parseopt'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 check_invalid_long_option () {
--=20
2.46.0.dirty


--aUBpITW5qVaGLfL3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarZhUACgkQVbJhu7ck
PpRw3w//eh07fL8r6hOYxCH9EB2KCidN8Z6NdiWSLpOvXpfNkxKy27+97eHRSjQ6
OZ2jqfGDwBUSXYjfFlsFbDe0N/KDWC3kUSCgfYEWIaAG9NBd9fPnhR5TVze14V2J
h+EA2U/obRll75PdaXKnzEXMtqwPQ0d4cXbCKPglG2U+HXrWF+gmO02Ty1O+HI4K
DrZTcDPnpPXCyWDVWdT/8eGKyBn9dsoV0HHu0f7jWeAG44eMd7nsrRqp6JjHy5n9
TCRv1dh04utAY1NL75f3nRDdvnRsWBeRlzI1zsbxsArX5EiQDGTEDriIy90yLxrw
CH+aSRgFnQ2a0+XoBTvrAN6pVCFfy9Pz5uWYCtEIxvts2Dxco16dMtI0tmOY+UH/
OUKiFe/RhB7yr3Gi/gtzKwj6yRkBBZULuU7tdsIIber6k/ymnbdZYK5qbtXPVOUS
jRmpj4e66sbKOfiOnPLdrTHgJBPmOK5Wv2xaG9geGe3KRd1UPBj3m0LU6E7MQPvn
tOMFxkqOApwsineN0Bts25rV0f2BW3mY/6qnv+n/rnw0pD+2TMVZ6jR4E8kIrCXP
eH1vJBc6T2f3qfu28SULITbpexzCa4am8HFUZPso9udN3o/M9yvcXMnJJyEO+cfl
B+Ae7IYxkivyferFzYKlelXfYIZZPUe+tBIdEovHoPhKD+/xd/w=
=iPuq
-----END PGP SIGNATURE-----

--aUBpITW5qVaGLfL3--
