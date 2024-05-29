Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157ED4C70
	for <git@vger.kernel.org>; Wed, 29 May 2024 12:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986710; cv=none; b=d5nEYCHaahfScP5LEr7XCpppjoaQ5s8lYQ7ikuB10SUaVfvrL96HYNeVxb96jGpuyx4s/LfSHTu6wid9oa2ZY4WUj6paYZtqbKDeHMzLZ44UjeLvS5M4eHL6sWhTPsZugH8XGKpLSvZMbj+fH10ZLLbC2cVIplEC81MnigB8Pyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986710; c=relaxed/simple;
	bh=CjYT7DSaBFC1tJIOFf4qc5KYMyG7XXDpMMctdL7lJKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kb4q7MytiXyR5TgLUB9rKmM/N6kyw/cmDiiNcs5w1vQR80Qgi5xNF8ZbTfkn6O5Tg+Tm2O/brcgeO3eTYvQV3Ddci6a4flAeR5LGkRgA4HM1xOFhxW4BNA3e019/8uml586u1lgBt4xgCswRvm7qs3PiMJwvTQGtfpUvbzZT2iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D8Lhw6Ie; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=blgytz0h; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D8Lhw6Ie";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="blgytz0h"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 802F51C00111;
	Wed, 29 May 2024 08:45:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 29 May 2024 08:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716986708; x=1717073108; bh=05lJR+/xSF
	8qj52MRptMuBQ6L5ekr/o6aEwo96BjKdA=; b=D8Lhw6IeJxOHcei2NYqJ62l4JH
	GxKm7dlMsNEqolJ8sC8vvvIEQZsanAZOlVQEuUzRukLAH8beFzxk/5uLOujEEK9q
	wFA75doQtNdm8oj2GX97F/VzxQG3wdDUg6azyax1H7Y3SknJ9V9HfNLQ9ondeOVg
	6hx1xKE75C+YHZFYuBcYUmsGAS+zeRjqp7R3C1raT4hKnw2yqO7Sjt1G9cc/sAgW
	NyepamQLCDp/lfmcM7RgEKENaN9/3dEHM28snhAUcN6nwB5msPKw/+4eAKLabpim
	p5Wngf5wa22vkccAjvZ+vWF/dW+PKFdEBWxz8pNsLzl9JQlIeac0X0rNMJgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716986708; x=1717073108; bh=05lJR+/xSF8qj52MRptMuBQ6L5ek
	r/o6aEwo96BjKdA=; b=blgytz0hJYk+jt45+UP/DLD/7QVPX1me41yOGSLiOQEF
	fSSqWRzhtGKsUCLutFyrH+9AzGEZaYhdCfSGyjsJH48gkHMZ7WmF343AzgAOEyev
	HB7V3gdjdpmDzKsTelh9i2caziuY97lErDBuVnV4/2rdkMspIQjuTs6defnos7vg
	nFwwOCj/tsgTwgPzfKeycrGumGw+Sea9977mWkewehCX7zdLPzoEFrL0rRX5zT/2
	Y3K49axQ19RJX7Wt1t43Y5q38eSGTiHh5NQUIhH4id7MZEqaZoWyBeAzojNvsDsv
	jy5NaF7km3827FS+yqQQsLp9lVE292CDhcqcxLeXeg==
X-ME-Sender: <xms:UyNXZivb8FYcWva9Nq6FdvurBEy7PaeLPiin32HtY-DlrVvMh2_7Rg>
    <xme:UyNXZncPEAdzFaaYICZwLLuxeI7Ixw7IPYW4NZOHRM727W10Ze2ShjDLEDrsQMsVn
    IWJnT7HmbHy_GPdvA>
X-ME-Received: <xmr:UyNXZtzXz9q6RGtgCx307e12vR3bue3iW07wYrT-NhEH5DSZZTAk1vXKvzSJ8wJYN5UCNZpIGODwIyZXV1MT8g0f0kmpw-I-0dCB5g9c6PPrFxIv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedvnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:VCNXZtP8IfLSKG0lZAD5ps5YglrdVu8d5KkPwvc8uCSEesj0U0UICA>
    <xmx:VCNXZi_8Zepew3XnAFfK_-MTHdsQwg5Sn4KB2rDKt2A75i_oODKdbA>
    <xmx:VCNXZlU2OSzinWmjtq3mBm5-kJ5_YQiPqbOeKlveTVGfJqSNBY0xjA>
    <xmx:VCNXZrcRJnpQ7A09esmhN5BS9SS5Wy70Vv7cHPKlr7kEKo9EcvrapA>
    <xmx:VCNXZkLAXO-yVangYqNJMXTLkB9vw2_XMD_t0jTZE7t9uDUAruKfFIeS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 08:45:07 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5eb3e4c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 12:44:52 +0000 (UTC)
Date: Wed, 29 May 2024 14:45:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 13/19] revision: always store allocated strings in output
 encoding
Message-ID: <68a7d24e4a715eaf60414373636860215d27e643.1716983704.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JuBZ5b2pjVTTdRwK"
Content-Disposition: inline
In-Reply-To: <cover.1716983704.git.ps@pks.im>


--JuBZ5b2pjVTTdRwK
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
2.45.1.313.g3a57aa566a.dirty


--JuBZ5b2pjVTTdRwK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZXI08ACgkQVbJhu7ck
PpRjmBAAmmRLnS+7BZ00YFZpRQwpQcLr9qYm2yirlRSzeG2+RoOFjRKQjzmaMirf
A1jOF5k4EJl8miv8+vCocfIVW/+hxPrZYIfQvUW7zPmEEoFG+KudKBbgmdSbcQpy
fE/lOES5OTEKZS/MNBVCR6JMqzt8e2JY6UC8gMc/HHVRS+9QEY2eZy8ntyJnAPjw
CpnfJ/Xt3tCpWG29Ptk1lTSBOFpZiXej5ZeXxXrZfPxDA0wDmlZAnyly8RqY6Kba
MbLe0LoMu1XaLHmrkeDbNUyw+YIBFoqmWGKyfvSGuvf5LHch2J8Mz6oGM2ESmAZG
DdyeFoEJyrsDIuNWMt0aJNbW55LIKh4KzYZBfwM8FYSxvEdw8HiBG7RTMi38pEF2
2ZSsasIxC4bPIXl9vx6IRMu0hN0ecteIe1hrkSO+4pR6EqoblUWdQJt0RKFVFLNX
BDwtTLn26UGF81J2QOE95q7kCe6A7e8jbqVv+D6TD+6VkjOdXLy1aLCrKDAJ6nDg
79s/NBP8SGWJwWHHbyzTOUmrWxpi9WTKq2qAIvjOfCMOIEy/m6nxArOIMhtZNbd/
qAulWDAV0PWMPZoWcOThXrl1rsJtPWAw8DyqkfcZIK5vj+HQ8uAUsYk/P2WS8CKi
bCaVCVSpOSlx7aAfZVsFp+kIYDm9O2kT643ybdHqduTXjURVFn0=
=NnZl
-----END PGP SIGNATURE-----

--JuBZ5b2pjVTTdRwK--
