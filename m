Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27361BD508
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934788; cv=none; b=f0oLkXL7UrvGqWZVnPNglr9vEm22o4VDEb69cXA0brcRid5lIf8TffZRChPf5Wo4mGosNucMMxczKS9XHGm7nS1HqEY42fALObLMhDdxb9FWrIp1VlrI3K5adXdf95a0te8otTis5hyg4YnfwywSUNL6Y5r1JdABRK/M3/i8JQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934788; c=relaxed/simple;
	bh=XNHqBuZcwuXZ9C9SUm2otTPyC9P9mZiFszsstRihIi0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bc11axenXtAPBnDycmo23LETE1WZheQ984BC1UWKi1cxspsjcQRLZXKCYQaKb9Gx+VBY8X2oongi4LXRrUAr1Z/lTjHD9HH6eamvDshN//DoZq0ow9o2umEI3pwMYvUdBZKV8bts6YURWbMUS2ZN9S1lCTY879xxKVAsRoi8bzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DiCMl0/U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XJAJ2fO9; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DiCMl0/U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XJAJ2fO9"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1DC4F138FCCA
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 04:59:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 06 Aug 2024 04:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722934786; x=1723021186; bh=f71kXdzcDB
	u72qvYvk2BETMdoYrZixQpu96iCp8tu+I=; b=DiCMl0/UOK5Qa8wW4tLfKqDgws
	vyNeZhcnzAPy27c7L2uOBZhJuQQA/V0vFuZNOHLRgI+PRiEkVuCIRi9RsJXd33EJ
	3REv18sWvd9qLYSKpoNJAuZd/lmuRw2IhvQT6Qk6eYrZudxrDMPvMxsmFJUoApNy
	T3WWewNLdsXbDN2tZF9A/wwDgr1JTNCIQGXyXPb2S7WJvJxJNwrKbPrjg0RDO/QP
	Pq432kydnscVJoiZIwD6lzvjgL09HDK1oRYnsXzlLONvNJrQlE7idMGkBnmjQV1k
	pR5erfQgPnig4aAJ3ARwmdTsTNGksqQ34qBp5D7UOBeRupQTsdbl0Ud40nVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722934786; x=1723021186; bh=f71kXdzcDBu72qvYvk2BETMdoYrZ
	ixQpu96iCp8tu+I=; b=XJAJ2fO9mPenqiOocYtjSFU7QbBIpUqA4jOI4fuFCg0+
	X965qh3Im0hXd7DMStnSaB59OzTRuZulPfeN3WtYCxGSIdakiE2xLEBXtM85zWJZ
	F6LHKgzOt5ioMkbDz34bkhmfFL++S/S9KfdLf+ugFEhD2gTsJd8a4IVrPnjJqqiq
	eWdqAiiTaYS3RUMYVhLMTyus3cwuwNtIunIseU68nJ6651T4Tp2irWDE36/oMLI0
	o+PyOSShYB9zSCU+Cv1qXLy7CFYZ7mWLIuVzGLss7qo/G8aUjmzNypmVVonWtZPa
	eLm3rf2w/C8KXiUCUJh5mqVLN+6maWRQMHBkDxlyyA==
X-ME-Sender: <xms:AuaxZhlzI0QWcIQCFPJXFFRPI-jegeAJ170eQrO2hjsgcpVuOCel1w>
    <xme:AuaxZs2Tgu0l7Gtz433mIQpKSQEOgt-d0jXlcgNX9vI7HFW2lNtmYUJ1mpZ4_n0IA
    SqaxzhseHYeDDFr0g>
X-ME-Received: <xmr:AuaxZnp0v2-f6MVcBwA9oWt_n_HbE-_yjMtH5-hvVazzlRim2Hhu2xA3LBNdQxf5wiGM4EZCerUfiGBhGSL64heOUiTvpCv8OBjXHteTEMkb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:AuaxZhmghQgwC5PMeHu_wPWhv3hPB6OK79DZY2aCCV0EEBKaai5j5Q>
    <xmx:AuaxZv1kCzCiUxumLYoJg0LNwuJm7gv0GSY0DxeLexnBnmArnhyNyA>
    <xmx:AuaxZgvqt7EOGrHAqnbAW8awp4oPWqgMCvztBiq-TBymMKiHxZc3jg>
    <xmx:AuaxZjUaVqYtoM0Fb8phs7BMg9gUXr4iDtxAisKtTdr496a9BRgiNQ>
    <xmx:AuaxZo81nd3BwGQkJm3wVd_YHW40AltTQ5RKp9Jf_7sQ8acDCCIKwR5D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 Aug 2024 04:59:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f9c1e295 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 Aug 2024 08:59:43 +0000 (UTC)
Date: Tue, 6 Aug 2024 10:59:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 02/22] git: fix leaking system paths
Message-ID: <9574995a246d96b90f03827bf0ba591593d6c4d9.1722933642.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+A8rind2ASF/B3v/"
Content-Disposition: inline
In-Reply-To: <cover.1722933642.git.ps@pks.im>


--+A8rind2ASF/B3v/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Git has some flags to make it output system paths as they have been
compiled into Git. This is done by calling `system_path()`, which
returns an allocated string. This string isn't ever free'd though,
creating a memory leak.

Plug those leaks. While they are surfaced by t0211, there are more
memory leaks looming exposed by that test suite and it thus does not yet
pass with the memory leak checker enabled.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index e35af9b0e5..5eab88b472 100644
--- a/git.c
+++ b/git.c
@@ -173,15 +173,21 @@ static int handle_options(const char ***argv, int *ar=
gc, int *envchanged)
 				exit(0);
 			}
 		} else if (!strcmp(cmd, "--html-path")) {
-			puts(system_path(GIT_HTML_PATH));
+			char *path =3D system_path(GIT_HTML_PATH);
+			puts(path);
+			free(path);
 			trace2_cmd_name("_query_");
 			exit(0);
 		} else if (!strcmp(cmd, "--man-path")) {
-			puts(system_path(GIT_MAN_PATH));
+			char *path =3D system_path(GIT_MAN_PATH);
+			puts(path);
+			free(path);
 			trace2_cmd_name("_query_");
 			exit(0);
 		} else if (!strcmp(cmd, "--info-path")) {
-			puts(system_path(GIT_INFO_PATH));
+			char *path =3D system_path(GIT_INFO_PATH);
+			puts(path);
+			free(path);
 			trace2_cmd_name("_query_");
 			exit(0);
 		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
--=20
2.46.0.dirty


--+A8rind2ASF/B3v/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax5f0ACgkQVbJhu7ck
PpTwoA/+MifcACf226vjj/vrjSdg0pdWKzjoL60fqFDAxvTexIrEIVdKEwOmoASZ
1A8vg6zJjbdoZxAbpfTjJGr4rU5ZJOzqOfuA1/lYBt922bZP9GkFBwbRuPGY0Onr
A/HgKmw+hNbd3ogkapgpDs9Ge2FTStDHstRwXI4yQEbWvsJ4hm1h3+4+z3DIWu/o
dmrt3UFxsJe/Ac5bKNic/f5aYCSO3rjmEKaRG62cre5MkPE8H36mMW8XvKdD9/M3
rEzhc3YaVOIYQH+hlL6uQPQGDTf2MYztOCaO3Q6eM+9P2PfBvTaDM7iXN47X5YTi
RiBEw9fNZ+VbW9QB0Ktb5kGydYt65tu+wYKJQsn47qnw+mA1uDi5s/fiWnxhVUvr
7/KbqiSfp7PYvC0OLJ6mxmPObpU3K3ywZ4FM8ofAMbxx8d0MqCCMSUONmW7L3rTA
TL/QLuKCdVP1kuA2sAX5x1QwwM4Cfat8ZIf8VG6OfnNXg0XgnoxAI9M/ee1m8Q7R
VVgVdO5mU2N8YMZ0CpplihiWjsiftB/mJ5wxIU2Vtd7g3vZqH9leeqKEmShdZ5ft
FPjiSJLgSdUGU6B6XXolxvFBgwV4VJtO7YFucMki37AtEYrDN0RnwgH2xgDcin8i
cI7RliocSDqpcZrhFqQ0V0XTlUPNZUYbXnPHRYLEbIi7PeN8vak=
=yFzc
-----END PGP SIGNATURE-----

--+A8rind2ASF/B3v/--
