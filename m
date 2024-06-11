Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D621791FC
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107151; cv=none; b=d8vbjLxQc4rAIsStwZxt/qWQmpy2mdNohyTM35UJFoOJockqlLF0a+hZDLpcbVrcxH1Le2EUvejuwxTewwdUNsCv7UBhqhGHqyW07pE/lqZatE0PSlKdHyFtidKEfacOTCRi3j9MsKUziHmflYBaXRQ4PoAu1nlBQXA4lgNgZ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107151; c=relaxed/simple;
	bh=g8n9fbS9PoJSwboy0R0RG+xlTa1mJfdiieMXK5lVbmE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYkqlVOzl0Cu+vFBoM9CokW8jBLo5ycNS9viNY5QjVVAyIlzdpdqxptptJts06t3CjWGu3ft1nbgTp5of0sYtptDYgMeyRq582/dWEZ13dhHKV6+bJq4slE+RJoMjixmjSJoA/Ru0QSsk1H+xYOKF13cMDkxrhhSLnwO0fEUmCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eBFPS00m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fAtrkxE9; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eBFPS00m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fAtrkxE9"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 548891C000F7
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 07:59:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 11 Jun 2024 07:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718107148; x=1718193548; bh=qxBxef0hWF
	enmkaaQaBMN+DPGKYiWvdVOb4qn0SMfAE=; b=eBFPS00m8BGFqxZ4Hvcy4UITuI
	3kapXc09IwYJte/53Tjj22QNmAUyP05y6RE2aXPtyboig9p4F6OXywlYZZ0PVjRk
	AFCS1MeTpsvNs3uVV1YBvTL5y3XIHg1rd222FlMJGT8mNWjLQM/tmBtEor2fR3Xm
	Dlrlx5C+WsvfMwfiDoB6LU7bps7F+P0eROlCrT7e1XvZnUfh1rPGNmzeGnDNn/Qi
	r6RpXkDEauMWqbXyaFtBtes6RdbIpDkQLjOB2dox8YgZgj465bbxose10hcDI0HN
	PwYMcnhW3RCMU0g8z473pS5uWeCVe9QOThxWh2rGMSCsWU6BfRYkm8+pTJbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718107148; x=1718193548; bh=qxBxef0hWFenmkaaQaBMN+DPGKYi
	WvdVOb4qn0SMfAE=; b=fAtrkxE9Uw3eJM0rvlx3Trf/Td0jFAuOgwDHeRq4ecsn
	bbI06uMpMPBOa/nH81zjns7J/a9UU1EL1alv4fvmvQ0ek330aJjSDYi3Jk3PuYuE
	Nfi/IFKT50YkRl4xBLAnWev+EHSY4C0qL507/WNLP8NgXo9og4hjY6fVhojb9dyb
	EjsfZuTU2juTHg3XUx9CR9NOIkFV/mX7cDL63LMDEVTrSTYlmy4f2HREXKfq3c7m
	IW2BPwtUiDzQL2ZNwGtfRSmqTrcyd2BsiARgTXbRll9sjtRQo/xwCITr2hoOww/+
	Mb6vQ7Mtw+fAd3nA3AYzqNdrt7MD0znKTYV4Nnzd2g==
X-ME-Sender: <xms:DDxoZuzcEqnz01z-iHzmfveAXGHAwhU3ycPmgmXtpG9Al3951cbxRQ>
    <xme:DDxoZqQ0CokFkmTexLR4svooCMyDHuo5fr0demiBwLBRkC3xbl-SAaOvqtu5fay_t
    fYK6w_GiCeELhjRUQ>
X-ME-Received: <xmr:DDxoZgUaNDu1UEprURMg_G-Pf5LywFXUFrz4HbRfXaAcMvkROReWAxtUocoTSunTc63TejjiiwOssIQ-BwandI_xo8TvqZPcFEJa4oCNVxmjleFJHYsj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:DDxoZkj-Dpx3OwkW5huxSgxSm6pbIStIQq65HFNzDB5lprP_-5fUtA>
    <xmx:DDxoZgC5egHEuuz5GPGsEOT59goi3HBLwy-PuCXBZS8S02f-aNDgfg>
    <xmx:DDxoZlJhXfDz2nWaMr2HthqPix7-JWGDmwhNBjst-mlxvDwF1gvlhg>
    <xmx:DDxoZnCtZ4Mg6fjfOfo8wI0kjHrO0NTl761bA34J6PiaI7bcNk6Iqg>
    <xmx:DDxoZp6KnAHMaWgukF8d_bQ9QgWb19a5B_0v0t7ush45-xb_eziuqPFX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 11 Jun 2024 07:59:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d55004ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 11 Jun 2024 11:58:59 +0000 (UTC)
Date: Tue, 11 Jun 2024 13:59:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 20/21] t/helper: remove dependency on `the_repository` in
 "proc-receive"
Message-ID: <97fa3051fac18aa57b2930425271935762814462.1718106285.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LhdyQurOlskOdSyW"
Content-Disposition: inline
In-Reply-To: <cover.1718106284.git.ps@pks.im>


--LhdyQurOlskOdSyW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The "proc-receive" test helper implicitly relies on `the_repository` via
`parse_oid_hex()`. This isn't necessary though, and in fact the whole
command does not depend on `the_repository` at all.

Stop setting up `the_repository` and use `parse_oid_hex_any()` to parse
object IDs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-proc-receive.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
index f30022d222..29361c7aab 100644
--- a/t/helper/test-proc-receive.c
+++ b/t/helper/test-proc-receive.c
@@ -3,8 +3,8 @@
 #include "hex.h"
 #include "parse-options.h"
 #include "pkt-line.h"
-#include "setup.h"
 #include "sigchain.h"
+#include "string-list.h"
=20
 static const char *proc_receive_usage[] =3D {
 	"test-tool proc-receive [<options>]",
@@ -92,9 +92,9 @@ static void proc_receive_read_commands(struct packet_read=
er *reader,
 		if (die_read_commands)
 			die("die with the --die-read-commands option");
=20
-		if (parse_oid_hex(reader->line, &old_oid, &p) ||
+		if (parse_oid_hex_any(reader->line, &old_oid, &p) =3D=3D GIT_HASH_UNKNOW=
N ||
 		    *p++ !=3D ' ' ||
-		    parse_oid_hex(p, &new_oid, &p) ||
+		    parse_oid_hex_any(p, &new_oid, &p) =3D=3D GIT_HASH_UNKNOWN ||
 		    *p++ !=3D ' ')
 			die("protocol error: expected 'old new ref', got '%s'",
 			    reader->line);
@@ -128,7 +128,6 @@ static void proc_receive_read_push_options(struct packe=
t_reader *reader,
=20
 int cmd__proc_receive(int argc, const char **argv)
 {
-	int nongit_ok =3D 0;
 	struct packet_reader reader;
 	struct command *commands =3D NULL;
 	struct string_list push_options =3D STRING_LIST_INIT_DUP;
@@ -154,8 +153,6 @@ int cmd__proc_receive(int argc, const char **argv)
 		OPT_END()
 	};
=20
-	setup_git_directory_gently(&nongit_ok);
-
 	argc =3D parse_options(argc, argv, "test-tools", options, proc_receive_us=
age, 0);
 	if (argc > 0)
 		usage_msg_opt("Too many arguments.", proc_receive_usage, options);
--=20
2.45.2.436.gcd77e87115.dirty


--LhdyQurOlskOdSyW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoPAgACgkQVbJhu7ck
PpR04A//UWLqd2vpMrAfAseiNUWvwo1zPfz4bSNWPijc6xIwi1r3DwJNAZKcbwbb
u9vQdd3lqIo+UBnlv3YbTUV+Z+Y2BSYf24QSZ5DZuNPY+V8xVHEqHvYn31IPRQpv
3sFyIKDOxbhKCwVHh/EzWMpqnDLqkNuZK3vDxcS/vbz3RKMo4ZTH+35EC7jd0xJN
a8E7YtMCxQcW3Dxgz3mANs9i0KawpAMbeFngA70eNPr8Lsiy6j7rfe9ag88cFMLz
mWjlCw+wxu0IIyqa6VHRRoDh0EwB99qqsTp2E8NwJrRk7u9x7iLTyFf2wJPrFtxo
/WzmeEOIGipHw+24h6QfvOzfai00MLebV8uBVa+O0lncdCbdDGpC/Q2pRvSqdSmB
aC1EAt9qSnPJTSFHNWM04Atv2XXfvasxGDvk+s7vLGaNw5m2ZG8OA8NqFf8l7ji0
RJJ5GUXB/YpS0YhAA369fhOa/rIPqpWKQry+JMaqNgoewk1nqDLaDfPRwvSA86nN
vfbClzA0ITWVuBDAY7wbIKXnoC/n4T3xuqbOtxDQ+YOziTwEwZB9C3Ru369V2yaO
YLItPc2quEdiIize+ypI7xMVijFp7JSaKf6fSNqRUeSZR4R+isP8N5ljHq9cqbHk
AjQg3qL1OLjTMgexioz2/m4HBHlfocG9yqxjBJLVpPagboHo7Mw=
=nBqs
-----END PGP SIGNATURE-----

--LhdyQurOlskOdSyW--
