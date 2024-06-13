Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE7213774D
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 06:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259285; cv=none; b=bgfkdzv9IPfEpIRCHhPe5Nj7uuORvEIhLpPsqF3wcsY/XsIO/E2Ve7ELIYGOjdBjCi9/mQ0MWeGJG0hCCWJhXdJrcE/s9sJXHkAYTaE2WPoGLXZxH4t1pTK0xeVL7iFl8a4PMwr+GGM5RbuNdmEZ/tGCO7iUULb75d/k1rt44kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259285; c=relaxed/simple;
	bh=v5L9+t6f9hYnO0SjHNiIRUmn0PQHxDhgdnl2uWVwSG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crWwOYJKikNdQdvZgBFFdEiVhSmtrrAD6eebz7eyj79n15+TNFYonLa1Tw2uJt5DR4fUWsG88Un0awXWiqsukpOxRBjZEVn2Gw2WsG2d2ipzNaoxIhnm4+M8TRdgW9eS7OkkxPaTUnfJa+s3JqJTuONzGRvtvdKLrrDrSK3C8Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P3o+98jU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G1UOiYu3; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P3o+98jU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G1UOiYu3"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4598018000AC;
	Thu, 13 Jun 2024 02:14:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 13 Jun 2024 02:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718259282; x=1718345682; bh=drili+VLs4
	rkVAtTYz9iGRI0i53OdrEWU9GK//clySo=; b=P3o+98jUVFinuFtYyBXsfYUFvQ
	AUprhMP3xSi3+LGJE/p1T24vFUovaLTg2uJMDx+NUaXejYhuE1koOHbg+SP6qfXT
	iCNAP+B69Zjj5pqlVGX/AfoH3pKKwwXlMyyawVBv+rF9jf48lIEt3OsfxhRLaiee
	T0VHWngYJlzlcKG/gzQwuV/KAwL3P9uHqSbKQD/rkqGlYJDNzOzSfdQtAVi+TDni
	llY4okcMzNYbKF0okZelydrjQCixBG0i0cAU19Srq5bJ4tPOQuarrBJztI6RpiDC
	F6fcOXvgc1zxOqBLBuDVc3OC9f2gITs5hCpH8P7nm4wOc3VM7c7NL+aQA7+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718259282; x=1718345682; bh=drili+VLs4rkVAtTYz9iGRI0i53O
	drEWU9GK//clySo=; b=G1UOiYu39P4QjjxPW/lEpbgqqSc0YKTPM7yY9SRT2M5A
	ml+pO03KQwnweSDe8/TPnYYpbxPIsnwl/c0JJ5iqUMIhEI+axwB+k7PGALRsW70F
	MxF1Gj3D0qCIr3v6snA3nfNgsmZI5ABkkb+ViSNXPmd3iP+DawsxoVXXM0pGtu6g
	Y1g2de0KjqhAs3QY3wvV8M1Jm8ytZvVFTXrXRiw2MwTP/ZLtb9faqEhNMX+DwY05
	cm2N909JTgnSOam11UMJywxUp3cQMDZ1iNX6Sq2weEvogGLFfPVdGLd45DB99f70
	J51FO+2oX3aea2vo08IS2nTJZuYJhuCz/ZR30k6Z9A==
X-ME-Sender: <xms:Uo5qZpvBuJOrQYPr15_y67peiTfIuTHC5ezQhOppJYIE12MQcJkOyw>
    <xme:Uo5qZifNdRB2tavdWlBhlAFxnyQjWqVu-z2eLo_VS6I4PWUuc-QAWicpioJGgyLHf
    qWuw7PW2KTWdyvH4w>
X-ME-Received: <xmr:Uo5qZsy7zcGKU0NStnXhNtrIQ6OJng593s1z2ioqdFs-bEEX-tvBsuRDSZF9LlR3JLQA__tVDiB4AjhH1nzww2DVair2hs_pvsFExJqHeMa9TwcWxDk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduiedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Uo5qZgOqRahG-g6qRdv493BlXhfW0mdMJZ8QK7Q3U6O52Bv1DZl0vg>
    <xmx:Uo5qZp_Zb83BPbAU3XAALklqBRhiCQmHyHzu8R7VFPTbprOM8IbTuQ>
    <xmx:Uo5qZgUfn_fqjByhupOUpgK4s5yDpo5RCvXr1p5KasYGajA1JxJMJw>
    <xmx:Uo5qZqdE2MUNbp7xl6IXQCLn5LTqHpQ8VaPr7tVFnQY-rZ-wsuBv1g>
    <xmx:Uo5qZkaAKDxAkmWS7ST3WvlJGFJ9wJqnOlghx_EDioyGpx8Cv_0-Ypot>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 02:14:41 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d2bd5e26 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Jun 2024 06:14:28 +0000 (UTC)
Date: Thu, 13 Jun 2024 08:14:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 16/20] compat/fsmonitor: fix socket path in networked
 SHA256 repos
Message-ID: <3ceb726655e72f8bca0864b5bc3978df5b011e19.1718259125.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718259125.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9+yhtxWhK9lzoKaa"
Content-Disposition: inline
In-Reply-To: <cover.1718259125.git.ps@pks.im>


--9+yhtxWhK9lzoKaa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The IPC socket used by the fsmonitor on Darwin is usually contained in
the Git repository itself. When the repository is hosted on a networked
filesystem though, we instead create the socket path in the user's home
directory or the socket directory. In that case, we derive the path by
hashing the repository path.

But while we always use SHA1 to hash the repository path, we then end up
using `hash_to_hex()` to append the computed hash to the socket path.
This is wrong because `hash_to_hex()` uses the hash algorithm configured
in `the_repository`, which may not be SHA1. The consequence is that we
may append uninitialized bytes to the path when operating in a SHA256
repository.

Fix this bug by using `hash_to_hex_algop()` with SHA1.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/fsmonitor/fsm-ipc-darwin.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-d=
arwin.c
index 6f3a95410c..52f4f29720 100644
--- a/compat/fsmonitor/fsm-ipc-darwin.c
+++ b/compat/fsmonitor/fsm-ipc-darwin.c
@@ -17,7 +17,7 @@ const char *fsmonitor_ipc__get_path(struct repository *r)
 	git_SHA_CTX sha1ctx;
 	char *sock_dir =3D NULL;
 	struct strbuf ipc_file =3D STRBUF_INIT;
-	unsigned char hash[GIT_MAX_RAWSZ];
+	unsigned char hash[GIT_SHA1_RAWSZ];
=20
 	if (!r)
 		BUG("No repository passed into fsmonitor_ipc__get_path");
@@ -41,9 +41,10 @@ const char *fsmonitor_ipc__get_path(struct repository *r)
 	/* Create the socket file in either socketDir or $HOME */
 	if (sock_dir && *sock_dir) {
 		strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
-					sock_dir, hash_to_hex(hash));
+			    sock_dir, hash_to_hex_algop(hash, &hash_algos[GIT_HASH_SHA1]));
 	} else {
-		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));
+		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s",
+			    hash_to_hex_algop(hash, &hash_algos[GIT_HASH_SHA1]));
 	}
 	free(sock_dir);
=20
--=20
2.45.2.457.g8d94cfb545.dirty


--9+yhtxWhK9lzoKaa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZqjk4ACgkQVbJhu7ck
PpRmlA//eRpBquWePLvrswjk5NJjUDa0MIGxu2c8a0/wecun6gQMoDLE5DYUnscj
o7XYVP3SaHiUTY02UsKNZtB6287000ziLvOe+TM3StThSv86z9mYBt0cNBqx80ci
AJN9BvAvk1XpxNquzVRA/eVA7pAL6Laobh84mSFYlSElWxEu/lY/a+whKqtfuab6
aDrwzNRhRdUbMj/RepUzlyzkF4RItlD5UT4HnY1h/mUwGjLHFQOZz596ry8icjlz
tFvqWGa77WCO4gVW+57RMQ4vM6vmgNn6BoqKIDw5k84xcEoMlW0q8c+gRtmLT4fa
oj5UPeH+8xmmLQh5pf/F7zFDZ3hzeZyzkLWzVUE4LLIEAEA+FdrZfUrysqAjt7VS
wIVdmSFJYVrqyK0fI6vtbDxxeDA0EuUFr/ha3PE4GN7tnmcZb8UZqNlb+ouwDMfL
aJF2ddYCOl98ePXgA0f9GqxtyQ7xst+rMEN9c5Ilrap1jVCj5eCoX9vGR8bmLUkl
dwHMR6tYz3s0PgjB/nmiiX0AnC3yeHb7KRChFBIshx/XuZDpGcQwbRt85ztBdzsc
K1fqtq3cQbMCNdDSUUAyv1pQGcUVoUapSfoydq76mftAb4nUQRX04cLKjZmN+gnW
WSRi6rb3Lwbf1tdXRJlZEQY/sUP55+gZHz8EgO2LqZnclcakzzY=
=JruA
-----END PGP SIGNATURE-----

--9+yhtxWhK9lzoKaa--
