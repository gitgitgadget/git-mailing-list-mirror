Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9F0249F5
	for <git@vger.kernel.org>; Fri, 31 May 2024 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717142208; cv=none; b=i8sCgrAbqPw3PT2t5MNmPk2ubV3n9NUmH6x8ippfKowFN5iczoWRGri8FixIjiMFcIY1RSBKkH5l7bWi/n+XQmK+0ra+GiqnMU5nMS6B/9aVHd1FnEM++GuMP2gLF/jRsauN3os1pzbcGteGJBX+yHB5ND9JuEmDIExj3wyYN/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717142208; c=relaxed/simple;
	bh=Sn9SWXpQaJ2xQK0FoCUN/mp0TKZvbmqti34i9WMPvxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiyGvpKRcvGijt7pt7apbfnMwxrzvgXrWQqqT2upXsiBnQlB4j7y+hd6coTs1QpNoOQgByrG3GAMK5RjwdZ8GKTulPMU6FoZ0wUAdPgwTIYgC09IIYmOO4u0YxiMfUPM6vA2nhQg8C0yhCOmFn/ngxnyfTe0M1oLOBJ7t4lJxx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MVxkHbkW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BBG7DmcL; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MVxkHbkW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BBG7DmcL"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 955291380117;
	Fri, 31 May 2024 03:56:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 31 May 2024 03:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717142205; x=1717228605; bh=QmznWf3Rwu
	PveYjck0NoQC/qccvQ9116Fy4VNy9c2aE=; b=MVxkHbkWLue4L6NqsYi5NnaQy2
	WVazP0VTP/3oUfYfr/Y4pLZiQWpCr1MHH8bytvfiHbQ8xyJiMnWBvwLbV/AWmHCt
	g29hl5C6BT79GZ/+gWRoYD0tyJVhucz116lIHSQhX//wzXl/VCwD+cI1/o/xG7oj
	6oyCuqCkJhWfvyKeUyJJZh+LOQ4XqsCyKNhI0DUpqGrV3kBNR8Hg2E1sDHG4xgVb
	SMDrCBYCr8SdrnY+KUQrMVTcJtkdjgh0FA8mp4lFVfhbQWy70to71bS8h4wdhbh2
	iln3TYKK1iR55z4c+oatcgjq6szXKMHhsDBPAqLGTl8U6zARu2uhT7k2gChA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717142205; x=1717228605; bh=QmznWf3RwuPveYjck0NoQC/qccvQ
	9116Fy4VNy9c2aE=; b=BBG7DmcLORa4AjXlp/goDFuT2Wm+a/cD0mOjGxXnB2rY
	N2e4xRdmVqLwefCJqEEUI+evAMzD02f6+O5L4Pn8ZXOtmo5aNrOm0CkLuuL5gx3Z
	HGge7fGv5/8JCheDKHrE+dHoh3AXGOizAP89U2hmsuGn6NUVfojCBnaQ3t3JzLWw
	2VJo1xsJRkNvUyMqbsjDOWUyS0rZF2hdts6K526J9PU7UkzuAQMufl0wmuGlmruJ
	ZXz9kcOBjNkx8JoHla6SsLdfiY2LQ2zwr1kXjfPiRqThOxX8yBXHwo+trLw6RQuE
	5/Z42ku/cuStKMQy2quGtkTDfXioj55WGKNnuqazBA==
X-ME-Sender: <xms:vYJZZqeJd8rlwGuzh1vHdakKubvP_147x1h6J2xo4bN-a3DfzlLrOQ>
    <xme:vYJZZkPCe5oy6y1Z8WCkwUWA3f2CtS1A-LYCZjEeGghO7-sJj9MNSFa5-RXDZcUpM
    v6YSCWPgMwY_rmyEQ>
X-ME-Received: <xmr:vYJZZrhAXh6BXLrT8KSLZUsr83eXICiq2zZLkCs6apOeg_cS9XVsm7uuc5lYJWrRwfovP0W_dPW4V3oXWKXCskfTx45u4oHbc_Vm9P2A6E_ZN9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekhedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:vYJZZn9Kyhojkq1JVIXNDAPfMQq0S9gHOU_z4006O_8rDzDpVkDJoQ>
    <xmx:vYJZZmuWZzK7vbL1w6Pjod0LeZNxp7-WmTPhIb1OdH5dK2QO7G6sBg>
    <xmx:vYJZZuHJyXxP7lQzwHeeUFpU14lev7xCCTtX7qmR8kahZYO1dDr5Ng>
    <xmx:vYJZZlOsVBkOqir65koZgtcKU51AxjhHmD5lxgVdYmpArU63E0ESZg>
    <xmx:vYJZZj9jtknIoBPAs5cAZz3ZfB0AvymxGXEAAzgJvDzEsMk5SEvrGRjg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 May 2024 03:56:44 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a674f896 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 May 2024 07:56:26 +0000 (UTC)
Date: Fri, 31 May 2024 09:56:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 3/4] BreakingChanges: document removal of grafting
Message-ID: <91d78490c2358b417e32694d8dc125b93a4e389d.1717141598.git.ps@pks.im>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1717141598.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6CrT2cTIkCCsF6Mh"
Content-Disposition: inline
In-Reply-To: <cover.1717141598.git.ps@pks.im>


--6CrT2cTIkCCsF6Mh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The grafting mechanism for objects has been deprecated in e650d0643b
(docs: mark info/grafts as outdated, 2014-03-05), which is more than a
decade ago. The mechanism can lead to hard-to-debug issues and has a
superior replacement with replace refs.

Follow through with the deprecation and mark grafts for removal in Git
3.0.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/BreakingChanges.md | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/BreakingChanges.md b/Documentation/BreakingChang=
es.md
index 1b0a357e65..14c0972b08 100644
--- a/Documentation/BreakingChanges.md
+++ b/Documentation/BreakingChanges.md
@@ -85,6 +85,14 @@ be changed to or replaced in case the alternative was im=
plemented already.
=20
 ### Removals
=20
+ - Support for grafting commits has long been superseded by git-replace(1).
+   Grafts are inferior to replacement refs as the mechanism can lead to
+   hard-to-diagnose problems when transferring objects between repositorie=
s.
+   They have been outdated since e650d0643b (docs: mark info/grafts as out=
dated,
+   2014-03-05) and will be removed.
+
+   Cf. <20140304174806.GA11561@sigill.intra.peff.net>.
+
 ## Superseded features that will not be deprecated
=20
 Some features have gained newer replacements that aim to improve the desig=
n in
--=20
2.45.1.410.g58bac47f8e.dirty


--6CrT2cTIkCCsF6Mh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZZgrkACgkQVbJhu7ck
PpRkNhAAmPKiuwLR+plaP8dj5CsbCtHvygFdyOqwYja37Z6tHbYLRwD40BVUm5vs
WXsUGKBFQ+hvgEmYmlEtMZoW03bGWIYax1TXge1E1zyD2AkJNcjBd5Kwfn98VYUP
pASyNErKPnjNlNQRzdXinBHbLqMh5dudoCMLk9x7roESVUHuOAJceHheZIqXe6Lq
qaacOt4i7y2vgtj/jCHYPQh3mZZ/BPcEREwqKVeQdiKlaoncU2wgJpEW66P5dKUV
pGVjFrmCJ2S0pvNf1yRmzUFP3nGe8/SISGvX73E/tF71i+HmbZ7YI9P5+Tzv4KPO
tmy+dfPyMCzHd5rb7ZHRgWr7i3rHDKamfg1AYSYiByG15pyilpk7fJZ/hsuAuKVB
PA0bAnRC08P5e0wZZhHqfwy3jyWMEE5B/kHlEcgpaJR67MZ23w9QJYI5Upha53uO
H7A4/dhENeLzGKO5QrmVnYpKz0Rbu4dHFyY0CKoI9PIX4EtdtMvylHT7I7TE4pZ4
MuUdL92MyxTKDrlFYXwKPMf9Gmt1aFHVJZcLt1AvgztvP5DvfgwC6H5vGahWbYsR
80e8odOcVI67Nq+r4ot3oJ189olECRtxlQbt0WqMEtdokAHsWkUlnfql5NnVG6jO
m7QbMKXvY+8U2pPYHY9Bj4bposaXEOUneLd12zdd5zaw9ye0VnQ=
=Zhq6
-----END PGP SIGNATURE-----

--6CrT2cTIkCCsF6Mh--
