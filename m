Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E4F10E5
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 05:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717564627; cv=none; b=THK5G2lC/NLRo5ysdQEXriXjfh4yhXD0xH1w8Om99EAH1yaF3JX32vmYT0mCR4qaofPSHR9duKpLDuWAy7jxF/Bfte+VuomxNS/pMzbf4MwzuHrX2OhzAJnAT4Nb6qVehwqbWesXOs8SFQ0T/jxi/c3go9SEgMcUsEV2SdKrH5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717564627; c=relaxed/simple;
	bh=8MiUU1COJE7M2Fvw/aMpxPChx+aRB/+11iWxHrfmT08=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgBK2IwjdRmGjh2sgbiQabut+cl9JM3MAyTi4WJKUSzf5FbsTv+HmkzJJGYbAkibDDM+/zC1fzLDw34m/zaouBEONmcQcImWTvRrTOMiRnwJLQ23SfYmZPRsfk2pjBwyausmLRed11bMe5OFdo+MzfsW249nrLMnOoz3kHEJLiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DrTXfx3q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LtoxyJMd; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DrTXfx3q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LtoxyJMd"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 74C811800092
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 01:17:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 05 Jun 2024 01:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717564624; x=1717651024; bh=vyf1K9R1M/
	tf/CxWEQ/FtENYi7h/77Kw6HGRez1rs7o=; b=DrTXfx3qvK0VsjkTchnyayt5Va
	bQ5A/hq/OegI4ovVDs8+RuOZO45p5hneVjt1IVXKPCzLQ97ND20lBS0ddt/TgU+L
	aUtqT0Fxvl/NtEMP+t5s19Ur3VtCvqCjl9hKO2qgdJs5pJ7HYMGetRSn7/IKPRya
	GBwR3VNCE+y64zla1Dg0nj1bkT2/ZTVgSalz2JcC15yCGj3E/BXnXqEtj9NWwKEG
	fGc1plCO2Z64QKIXqOHg+dOssPG+Oxm12n95NWoamVC7KTu6vpcgApLV9MIqNbI1
	rKfNKdiLh37pi6xLhhL7fic5QgzXRJ1+5S+KabVX1ajrGkBHKpPYGmXSozVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717564624; x=1717651024; bh=vyf1K9R1M/tf/CxWEQ/FtENYi7h/
	77Kw6HGRez1rs7o=; b=LtoxyJMdI+tT5WkZbxHbYr4cync2xDWojWO7cwHIEOX7
	mVeEGo847fp+pfowZhql3/er//NP7nWi0+6rPh1CBJJrbtoUEFXU036TDB/C/can
	u8Q1CnxLzsEKuYj5o8gMHaJOZYL19P00xR9wqmQWb5n1i+PZ0HO+KzTeBPsrBxTh
	03WqX1jelgV3LqcC5D1UFIXWM2MZ+7e7y4+iJYXI6EgKbC/ik3RQa5iYERcvKjXL
	M4Xp9UDAWc2wL8ElXqWdoFWM+GAW8yWg5s9RCy2ljoUGvsBqYuIOFeyoSFBVrD4J
	K+LIinG/+AlIWMZeSci/7dJ1hdU3TXVcqo1wd6V8YA==
X-ME-Sender: <xms:z_RfZp__eQSJ3XmYp2I9pHsHWR_AB8GzYyRfTEQP95Qd6EcKAT_q5w>
    <xme:z_RfZtvMJFSK2_S6IuKpbNlwdjukLRylvAwS5iMwZoRhUsY41kQP5LtBSkXySAjKA
    AjSYi5zU34W3VmTcw>
X-ME-Received: <xmr:z_RfZnBT_J76uSXG4-whUGfGHroLZGfa6X42KUxZlTnrv7N3UFEaogn22QvYHwyXN83NwVxeU6OTdVev2NS_teTElVLCJX4dl73Vlk6zjJ1YGuiVpc0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepfffftddvhedutddviedthefhvdfgkefgje
    eukeelueeuhfduleffveevveffvefhnecuffhomhgrihhnpehphihthhhonhdrohhrghdp
    ghhithhhuhgsrdgtohhmpdhrvggrughmvgdrmhgunecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:z_RfZteSibRZD4yjxYQ8UVa7dVUmji7pisq7wW2eklF5NzouL4TViA>
    <xmx:z_RfZuNz-ISFdTp1U2fHK1c6Fnu1Ig1pIA-cupBLcLfsHjOk1Xhbhg>
    <xmx:z_RfZvnlEQZNgu4w1k7Mysp-5qwNKNX7Xgulj-GS5F8suVfpwSWuqg>
    <xmx:z_RfZosyZgyKap4QMSRSImwOLgW66VgbAAOket4xibEQewgevoqTvA>
    <xmx:0PRfZg2CWZV7c1a20BxTeqc4jqqiqMGA2k67x6pE-e6S27BcyMypwo9F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 5 Jun 2024 01:17:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d38578b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 5 Jun 2024 05:16:35 +0000 (UTC)
Date: Wed, 5 Jun 2024 07:17:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 4/4] ci/test-documentation: work around SyntaxWarning in
 Python 3.12
Message-ID: <c758b45282f8eb5fec401da6021d7ded6cebb243.1717564310.git.ps@pks.im>
References: <cover.1717564310.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aEvHRae36KZr5/+z"
Content-Disposition: inline
In-Reply-To: <cover.1717564310.git.ps@pks.im>


--aEvHRae36KZr5/+z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In Python 3.6, unrecognized escape sequences in regular expressions
started to produce a DeprecationWarning [1]. In Python 3.12, this was
upgraded to a SyntaxWarning and will eventually be raised even further
to a SyntaxError. We indirectly hit such unrecognized escape sequences
via Asciidoc, which results in a bunch of warnings:

    $ asciidoc -o /dev/null git-cat-file.txt
    <unknown>:1: SyntaxWarning: invalid escape sequence '\S'
    <unknown>:1: SyntaxWarning: invalid escape sequence '\S'

This in turn causes our "ci/test-documentation.sh" script to fail, as it
checks that stderr of `make doc` is empty.

These escape sequences seem to be part of Asciidoc itself. In the long
term, we should probably consider dropping support for Asciidoc in favor
of Asciidoctor. Upstream also considers itself to be legacy software and
recommends to move away from it [2]:

    It is suggested that unless you specifically require the AsciiDoc.py
    toolchain, you should find a processor that handles the modern
    AsciiDoc syntax.

For now though, let's expand its lifetime a little bit more by filtering
out these new warnings. We should probably reconsider once the warnings
are upgraded to errors by Python.

[1]: https://docs.python.org/3/reference/lexical_analysis.html#string-and-b=
ytes-literals
[2]: https://github.com/asciidoc-py/asciidoc-py/blob/6d9f76cff0dc3b7ca21bdd=
570200f8518464d99b/README.md#asciidocpy

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/test-documentation.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index de41888430..02b3af3941 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -11,6 +11,7 @@ filter_log () {
 	    -e '/^    \* new asciidoc flags$/d' \
 	    -e '/stripped namespace before processing/d' \
 	    -e '/Attributed.*IDs for element/d' \
+	    -e '/SyntaxWarning: invalid escape sequence/d' \
 	    "$1"
 }
=20
--=20
2.45.2.409.g7b0defb391.dirty


--aEvHRae36KZr5/+z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZf9MwACgkQVbJhu7ck
PpR7EA/9F2NrE4/q6ZKl2crBE9cMhXTfOrWesuIxxDrVYC+KUVwrrZvGrnaSkQeL
yb5WY2OLplP1lm2jFdhKo0mJMA/U2fbpePAKGrUMuFizubH2s8VX5nowTMWraGUH
QsKzN84VKKh8jCcW30ezkJBd6Tvw6maP1nQp/g+p33YTUDsz2Jno3mm5Y+Z1dJ+b
S2ccM5dDxCJsUYUvTl+s7yeIV8+fhdZOZhI6rqi4YecY08HJqe51zqU79TefNF45
Ss6LjnzLwnMhGHyJgpeiqOw3PwnK5qHFtfbKtaG4wRxesovZrng+S8tsAQYY/N34
wW/5alwnsnANai561uIlWNSxCkmtEXa0EeTMyzUEZccB501QS00CMYwxXvctCMgV
0NOYz+JIGnK2l4FsNsdobWu0SXbetZlhY822oaKBJMQ4FEjXa+Xn0m+kF4OEjqca
Rs+oXtvpdwJFlW/mEb3e1E8owSKVpa62/YvcuEH9hM11AuUL1mwHpNDnbU9u1xQ1
cHG+qzqoGIUSVac9g9bbApLgOiDTscSQkwa6+KbGHqtwUQb9jo/uo2qOSUFlvwxT
fE5aHKM0lHs+a23ixx/f2gbhkHF9MwZcGWoYR4IYTD75l+GkTBnhvpB3XJtMadH3
OTqKNFPMgcFFZSjGd+rLaEO11wP1sAY4GGv3DvdIX0ymqvkAE3Y=
=QE9j
-----END PGP SIGNATURE-----

--aEvHRae36KZr5/+z--
