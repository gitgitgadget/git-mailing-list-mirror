Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7307113A898
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660880; cv=none; b=WuTxYhCixiC8MCkDJl1NW0M0+Qq/5Elacd1jHYRs0TWOxN45u3XwuyFzBENO+fyXw2TOMYBmtAty760QMnmPtTLIW/spkc3zRqSbVbppyVoiPLYq7G1SR6M9FSj5WHvETkYJDgDVOfXoQcN8dQYbgIBIFn/tszrsxG8b8IJhN40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660880; c=relaxed/simple;
	bh=hDczqB6exrPwW8XHqamgecKeqcKNKtzSw7LAYfMcK3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n62Rjjn7HnQkmmyjTvLTjMYFcWnSXx6Sp7K+ZV39eSY44gL2nAZog0Pny4ta+Mf0+9EhtKzSzWkgTWvem+n2lxP4IatUuyyJ7yQ6JcHrSZmu9BBUfYsqxFC15O3PkQSw7i2YvuB/U2T0BpgVxXLNgYiNS6w3MMrWvDQBQ/EcKWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RGEGaxCC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oQtmAeXX; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RGEGaxCC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oQtmAeXX"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 98C6411400BF;
	Thu,  6 Jun 2024 04:01:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 06 Jun 2024 04:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717660878; x=1717747278; bh=mlSqQsQOeK
	wVHu0oNI7QyNheH1Gmrd4Tsw0R2SIhrNw=; b=RGEGaxCCXaYk8nBPoxeDEz2A2J
	cTJHrAx1db4IvHbowO5Vb/sPbS4e0/xnlcoBfUQtfDJG7mXmY1Dpy7NOYClpFy0M
	iwojnvsB4n7cDaOBlYHKgxb1vVqBgJZ6c53eSIXzdk5qkHXW71D+Q5+MRLCFlBNT
	0oTf00mvOc8OyqZ08rSY7sUfTznOeW+FG8+2r0CJz1y77r5eikiziNVL0TC+1FZg
	5uLv+bQ/59ZOc5q76QCZieJIMOlX0B2h4+VSK1IUCWCIYhXBNYdxsTVI6jSg6cv7
	Ziss9xWZ0BKceei2zN8tqccUsRXKqJKXVJUl2l4H6310tsXKgIftE7Xyop/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717660878; x=1717747278; bh=mlSqQsQOeKwVHu0oNI7QyNheH1Gm
	rd4Tsw0R2SIhrNw=; b=oQtmAeXXNGJBbCaQgtVWkXEFMeo+LXOc1w7yc6TUipdt
	H/8YzHoMno2fAriKPmjpl3bT4Axcu6OL5/kq5E+Xad2oy68DwwWvWY55tzkNYv0l
	3ydOx/6S5C3H1JFe7KJF3HxKRSbbiTeJ4mMRdamJVTF0PK2jhkq/1wTKUclSkU06
	VBtX+3gX8SI+D+JU2Cpoz3J8W6pEFfEDS/nCO8Jx3N1sSUo0iEuW1IISDDGHuVL3
	fSI7FpEuEUrg91fd1X8uodGG3sKViwKzuaVzYI1ZXfBM4huIt2STAFKRkZ+48229
	7VrpflvTEDXjf1czd9faVqv8YZ80nxFaP3LmIiz6BA==
X-ME-Sender: <xms:zmxhZjEEY_esPlT0NDo8hnaz_-MfeNQmuOnxNCH3tUr_yEEnOtJn_g>
    <xme:zmxhZgXrDu7QhAcfTf_gXgEs1K8oKdjxEHg1rpQ97XS0Q4sButyyOphI99kvVlDJ9
    utD2liJkwBwxrqF_g>
X-ME-Received: <xmr:zmxhZlLnfLlg35TiHFJCvMSXvHEzx41-jURa2kTk9unVmZexRjqZkCQk2q2ARqIsVhTCF9cLTM7RQk-ZtzacSmNY-pzJZOSTFxA648eHsjj5l7g0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeevtdegieeutefgtefftefgfeelveelgedttddttdegteeiudeuvdevtdeujeel
    teenucffohhmrghinhepphihthhhohhnrdhorhhgpdhgihhthhhusgdrtghomhdprhgvrg
    gumhgvrdhmugenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:zmxhZhGWfdKHY6no5lD8L0csOz4VFH-68VbdcOgVkgRAIomGO2KyaA>
    <xmx:zmxhZpXvO8Z6s-MUw6EXJSpzpFbZGR3k-xsWbSTze5zb6Rlqmn-tXw>
    <xmx:zmxhZsN8B9UBWR6wxzSwrwydiHO5bpSxIrG5mr0J0H_iN36AENvnSw>
    <xmx:zmxhZo3iqP4ueA9Dk9jGCKnwpNTGxNaLNxZhoux17AA-7HP5IEV6HA>
    <xmx:zmxhZsSXSyczCTNr6PLsgJrFi5tjQlskiYuWWSeqABJqjXK-adgfLqbN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 04:01:17 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7085fd9e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 08:00:46 +0000 (UTC)
Date: Thu, 6 Jun 2024 10:01:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/4] ci/test-documentation: work around SyntaxWarning in
 Python 3.12
Message-ID: <c13fed9ebf2ff4a68e12661c31ac4be4405028b3.1717660597.git.ps@pks.im>
References: <cover.1717564310.git.ps@pks.im>
 <cover.1717660597.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vLd39K4Iyj/d4yTn"
Content-Disposition: inline
In-Reply-To: <cover.1717660597.git.ps@pks.im>


--vLd39K4Iyj/d4yTn
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


--vLd39K4Iyj/d4yTn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhbMkACgkQVbJhu7ck
PpQQMBAAn5ZEWZgaoMyB7HRXNZRsvpgIGciMBC0VwNjPC31H3nCSB8RCHZ5n9/zd
zv+akCl+UzvaWnpUak/fskFo1Y75qo5PwxCEriXWiwDwmNZsiD38J+pC8LG0Ds4w
+GLVnjTJUX7WybTngUx97gsA+PvARXZ3i+cf8o0QG/vCXTiX37A9W+pe78yyx1F+
8MXoUhp113FRTHH69MY0JGh/a07fX10NhU1wi/efTZmEgckDCkq4GmgaJn7VynZW
7qNwieSKT0Px0FDAGcxtJxuCaaQP4G/86RmPPa0C2ZdT4lLyq6OJqWzFVgz3o4MW
qCRVAzLYS/pYqLmBoPffNYItJ7BlyUl4tNSK8vHE8CL30dDdm+jzEGbPfxYvYPdt
a1eUi0dG4E88B7C0HD47QdqW9cyPrDoKz0hDPUAKpBFGwhoMjEtPsEnQGzJXIK2T
iaDa3WbczzCAALxM4iba9hH4WfhAd6Zi3latPzL94Im70DKptitk0SUoiV1VuJAv
9gf8GKro3YS5Sxb/4Ya7dQy5oI4ssdZ7evspktAobMa2Io+gJx83JptrJjQ4lUX/
HchXyOpfmZX4DNC/CSRmACOXUQsrwekM5P+CxITMriKDmL3FopoWl91Zrhbf97f9
PDBIbeRSjIh6mW45ux+NuzWqs6cF7BRkCAYCks56ml5FSfZEbtM=
=SHcV
-----END PGP SIGNATURE-----

--vLd39K4Iyj/d4yTn--
