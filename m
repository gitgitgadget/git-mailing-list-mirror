Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAE33FBA7
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407638; cv=none; b=VNMsnefNxs12leIM0V1Z62/sZJwAMGi60I4Jz8JdsgSfLCghdFYvKhuEcnwaqiZB/1NhXyxChhKErE+1Mr7oa5BeEyfZEEG6qqXC+TBjvaR0jL1N8ebu18CoyIJy3yTcpruJrPdSGrJ6QXoTi3QQ9xoM37QBS/s2iYow7/BtmZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407638; c=relaxed/simple;
	bh=CN2OdGkqZy15m+++hBYKtJokuSVPPlGmq4Cwla/pTdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOSrUyMoASPqxorEuuS9k6/fM1ubO6HBtnP9LDMs+TFWuOsx54cnMclk3D4ZAUrOw3PnZxwv23+seqHE+30e3xL2F59jWf1puwNqKzMQ447gCoB98IiNdKsvWfeP/EHN8tYIzZitoNtrOGWGJd8LuuLHvjjnLpELtB3ny/rUHkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RYU/bYdc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ITxwbbzZ; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RYU/bYdc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ITxwbbzZ"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 381A21800101;
	Mon,  3 Jun 2024 05:40:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 03 Jun 2024 05:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407635; x=1717494035; bh=8/ue8saYbO
	VZ9RHqmDK1LRdwm8yPmoj+7y1nP8/58Pc=; b=RYU/bYdcygMlVPAocNc0OgC0HN
	SP5/3ytLkKd/ehSg0OwUkocHK690OawZ2M9aruMx3xbiVzSnVktmb3K4QJNzYX+5
	WicqC/cl8ieiPK+1x7jY+4An94s1NLaQ8SKtP3cJgCdc4bsYPn9lqwYx20+4cVQC
	9ylGhYhQ3LVdoxtUQWl08s/OKYVIaCHG9uJzYx/xswyP15fwL8as7Oh0sVAzP1BR
	R70zw/+o2Reb9OwKeBLv3hIqccKVGfIx2UhRGk42dU+7EDkmHWlauI+UY4xxds68
	F9Srq8laHk+fz2yorqRK6ZT7k0RP4RIfqrIYpA4cXRzMdazN+j20LMyBDl+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407635; x=1717494035; bh=8/ue8saYbOVZ9RHqmDK1LRdwm8yP
	moj+7y1nP8/58Pc=; b=ITxwbbzZUYqUUNcIn7XWNncEP/ukteyW5VrQASiC5PF5
	OZ8XwrGe4qIcUdZTmDu653pK/wP+5KNcyrKi/DZJm0VIEjmQIO8FmfTU5iotgcNu
	y5PZC+/eATG3BNhEFU9BTl9qr6mA+T15X7oycWrPZ0rIxNm8S4wHb4r/WT0eygXx
	JrCTp5Z8frtdy/HlcBB1AAq070uC4ChuHpriq5JKWGGwT5RnvTnO0WTKH6BBAw5U
	6K8RI4nXAa1LpGWPZZjmdpwAt0LA0H4+p/QRtChKbt2OZNZEXemULClgnlZBVXoY
	agANusHy/fuFfgYizOTEWsE5yGqFlmT4GCXLGHJ5gg==
X-ME-Sender: <xms:k49dZgoPqz9ZJmh1gEdIS0QaG8J-m3Izqr0Z6efaIrB6gAk3cac6mw>
    <xme:k49dZmp_hpywKbF73aUSY9NjlvVc3MEnl49MczfNpMMFPHsDcBfp7cB9hJfSIw3YZ
    mZGM9DRI1spKtIBIg>
X-ME-Received: <xmr:k49dZlPU1dQj0_YL8WeHSTXGvIAQVGc2mCyaoeBSSN6hSMnD7mrxMHQJAmtoC37EWfnV2vJWvQ3vxfYDgFimpZu2qL2ECub_z9emQ6i4W1-Y6lJo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:k49dZn5lNbfZkXoQ4L375BBwQ67pPFm4C77vuOKgAzMYzzbKBW-Wmg>
    <xmx:k49dZv4uVwvNEEHxbAryz5Uv24rNm9GFN2OYj7D0j1IhU3LZt6YoIg>
    <xmx:k49dZnjSZT_FtbrjtSiNCq07awROh--7Qibog0bJ8w5MFmU-Ogr9_w>
    <xmx:k49dZp7-rwJDIK68h3E1pMZCzlm4JzI9ATsjhKxqxvW_hIXAZ6Xtfw>
    <xmx:k49dZhkP2UKbtgDwJP2C-oQSGmeMAzyMhNTxcesowPX4uQeDpWqZjzH6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:40:34 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5c5b7514 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:40:10 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:40:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 20/27] revision: always store allocated strings in output
 encoding
Message-ID: <077f10d0dc80124e3c76e5918ba07241e29b5f28.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2n4JH1xe8dcKMrc3"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--2n4JH1xe8dcKMrc3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `git_log_output_encoding` variable can be set via the `--encoding=3D`
option. When doing so, we conditionally either assign it to the passed
value, or if the value is "none" we assign it the empty string.
Depending on which of the both code paths we pick though, the variable
may end up being assigned either an allocated string or a string
constant.

This is somewhat risky and may easily lead to bugs when a different code
path may want to reassign a new value to it, freeing the previous value.
We already to this when parsing the "i18n.logoutputencoding" config in
`git_default_i18n_config()`. But because the config is typically parsed
before we parse command line options this has been fine so far.

Regardless of that, safeguard the code such that the variable always
contains an allocated string. While at it, also free the old value in
case there was any to plug a potential memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 revision.c             | 3 ++-
 t/t3900-i18n-commit.sh | 1 +
 t/t3901-i18n-patch.sh  | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 7ddf0f151a..2ee6886078 100644
--- a/revision.c
+++ b/revision.c
@@ -2650,10 +2650,11 @@ static int handle_revision_opt(struct rev_info *rev=
s, int argc, const char **arg
 	} else if (!strcmp(arg, "--invert-grep")) {
 		revs->grep_filter.no_body_match =3D 1;
 	} else if ((argcount =3D parse_long_opt("encoding", argv, &optarg))) {
+		free(git_log_output_encoding);
 		if (strcmp(optarg, "none"))
 			git_log_output_encoding =3D xstrdup(optarg);
 		else
-			git_log_output_encoding =3D "";
+			git_log_output_encoding =3D xstrdup("");
 		return argcount;
 	} else if (!strcmp(arg, "--reverse")) {
 		revs->reverse ^=3D 1;
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index f27d09cfd9..db7b403bc1 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -5,6 +5,7 @@
=20
 test_description=3D'commit and log output encodings'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 compare_with () {
diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index 4b37f78829..5f0b9afc3f 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -8,6 +8,7 @@ test_description=3D'i18n settings and format-patch | am pip=
e'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 check_encoding () {
--=20
2.45.1.410.g58bac47f8e.dirty


--2n4JH1xe8dcKMrc3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdj48ACgkQVbJhu7ck
PpQcjw//WA6xqag5k79v5vZEBI2OUiSU1bRKFjnRzgUVRWnPmFoawCIdyAFoeE4x
Q05YvMn5uHXuyrN9AKlVnL2E+Kxp8+19TnxKsrqgoYMpiRTktTeM2EL3yLvmd6Of
S+1PQJN7XZHVpG3Qot1R6oJhRWzPvf/EHYNNzjaq/HOrapMKDc7KQdUwESOFd9Dn
R3fjJR7ss4ht+IdVWwyTe0wE5ccO+nGJEVDdilC/1mMpd8q8RkT1CgaDsgpWcjrA
gFMhdA2BjA7FqdzBembOKBLYuDebmod4NlN1chYaApLdKXkC1CCPAoGKlyc3M6xx
n7pLcoEYeKH9BApkZad+b+454NOT703yT+Z+lTUtrg5KtkItpVmu3s8Wvp2dGLSk
IUefZqVERfEwW9LKLzIhvYjHwTxC2CxSTntRy8OyfE2ZqA5x8RXcyhHqZZ4u4YwX
wDuiR3k1SMOzrcL/lGzzYO6pyjuEv7cGcYkPlpasC/uzREnAkBUoSFVXYQe91PzT
7O85HTulK/cu9dKBynKYkZMxpxzEfNTQWUn32pzr3/TlunQBRGU2k6RBWEiWsrup
VXX8VjSG0vcZGvIydv3J+OuXHJf2SjbhcRu7QzduohW3cF5LXCMna0Axu6t/OLGX
YAYHSzJqB7hRvIQQT/+H4ZdrvExuN2soGded4edXHZoybSUiteE=
=Trvk
-----END PGP SIGNATURE-----

--2n4JH1xe8dcKMrc3--
