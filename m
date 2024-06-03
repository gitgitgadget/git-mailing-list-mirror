Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A6485279
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407628; cv=none; b=T/8mLoQaLoBXmZRbRfgYe7rySTCkvTRja7SVfuYnzIz4gsCNJpZDkp7o3kRJDzOmxSfLSf24mAIZyvMyUmmchdryqHZAukBUa8YxHhpiW5hZS/9Pv4pKB6Np7FOaRZAtmvzpDWlsNj+e3u+1cFI5VqPMebSpHxtJ5dM/VlF8S0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407628; c=relaxed/simple;
	bh=1vJRZtDDeIuGD6SlTWliu5ouCcas3f7gL6VD80fyYKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+OtNg3GZRnKWWgZAD35hFcIarSMfXbqT+1CwJBfwI+T0uAXVF3wRulS6DIF1kNgRvRwypPvWBCY/YH3ycSwD4+JonWyD0I2ecAPnDseOy/LW4xT8twEATOW1CQN8e0ZOjvbWYeTIGHJgCKfXWIAxZWYvS1RrRKW5gcVRb3LS7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gsTt3tef; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pReCktC6; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gsTt3tef";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pReCktC6"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 84BFA180009D;
	Mon,  3 Jun 2024 05:40:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 03 Jun 2024 05:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407626; x=1717494026; bh=IzbmM1IHqI
	XjxyIo0vqc+WSTwuRTplPh0C3J6Fx6CPA=; b=gsTt3tef4euCkM6H1hT+SFnOI2
	IOKUCjkhy9+CjviqiMky4XhWAOVqt4NJCkJleoZ+yYH/DW7hGxGGTLBEk5MXbiOF
	KpRRrBKW8BCREvYtjPZq0jjyAKI+elReIVNC79yj5+yqIv0t4G/TfrOFRpHurd9Q
	xYAbKxN8cmQQZ8yNSSdrVPC+1yOIgVZ7atvLxziPrWaCLBW5AdlFRcipPmGhFUJS
	TAWroenXVF+eoDoUGezxquTNhgWFfdKFXLsKeEgQhxRosDcRVNARcX0t3aVWeQpj
	xZcWjuaW48bdjhb4tsSSBhjOd9RhZ1eEaUKJ+DzigPJGCMmaJdyamt1DrSHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407626; x=1717494026; bh=IzbmM1IHqIXjxyIo0vqc+WSTwuRT
	plPh0C3J6Fx6CPA=; b=pReCktC6QGnUgaH04lxUCyZ/9nvLGLZfWZcxKZIj10/x
	/y/+LGnyCzAHqA719TbekMWu0PTiz0BYu0XYbkEgHa7aKk/6f4tek+euGR/CAb3N
	wDsgDaFdstS0d26hLLuLl0nV/DEkFEHo57iv6FwRYwk8It7sF/r1FWWBcxJj/NUX
	9DcnUh5rYIz7y50N7O/W4XDXhYg3aKkKD1+GA0hYfToA1mqwY+hpW+ovFDj3QF2o
	hnsVmot+Yqdw55n8E0YLhGVToe40gLPY/GSH5FnkUvWTMeN4kil+eJL7ioP4wm5R
	0b+RAqXHfyhFVl9reGocHb2PJG5/hnH0BRHY47invQ==
X-ME-Sender: <xms:iY9dZt0rk6E-DcsUOZMdLmbjo647eIXQPBWnHOMuTLBhlD41Sj5EfQ>
    <xme:iY9dZkFXxGIXdgYDROfXeZjVShpsX_7eWWEEM8Sa_jce2ZZF4inEPtUEZ5YLRq4n2
    JQ6WwTPXwxwWtxdfw>
X-ME-Received: <xmr:iY9dZt7kSTmdUKJh4rjAiw529WR6GgHEOJ8UzXelVV9EvCn8KXqCjBfRmT5yyoXGdU9fjUCakBcKhX0d1Yk4F2ZEbyeLao24u1X0Ng4GBX2i0m9o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeegnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:io9dZq1SoY1hXd2OdQ0OmF7JZPbVyn1IDfqzxR6TF7ONiFh9eNbaMg>
    <xmx:io9dZgFmt7cBoq5cViHm7GHMYyGqfMlaeb3qF_jVB3-5LphyDwk3wA>
    <xmx:io9dZr_wjWZFfXj5BtWpMMnHYdsjFYzh009lxUS9Pbb-RxgqTOdNXw>
    <xmx:io9dZtmsbDVBYov9kuNI1OIk-Su3bwgQXVz6MYSyspWaOmcanzMJWw>
    <xmx:io9dZkAPFrM0-yHD3C3Gvmh_nZgR0rR7iU7FkH3dV4t3x-MW5HZ6LTB7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:40:25 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 16b60205 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:40:00 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:40:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 18/27] send-pack: always allocate receive status
Message-ID: <e3227bd3f33ea395b083d13a25ee74a08315bf50.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T/9MKIiMsNxnzpIO"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--T/9MKIiMsNxnzpIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `receive_status()`, we record the reason why ref updates have been
rejected by the remote via the `remote_status`. But while we allocate
the assigned string when a reason was given, we assign a string constant
when no reason was given.

This has been working fine so far due to two reasons:

  - We don't ever free the refs in git-send-pack(1)'

  - Remotes always give a reason, at least as implemented by Git proper.

Adapt the code to always allocate the receive status string and free the
refs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/send-pack.c | 2 ++
 send-pack.c         | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 3df9eaad09..17cae6bbbd 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -336,5 +336,7 @@ int cmd_send_pack(int argc, const char **argv, const ch=
ar *prefix)
 		/* stable plumbing output; do not modify or localize */
 		fprintf(stderr, "Everything up-to-date\n");
=20
+	free_refs(remote_refs);
+	free_refs(local_refs);
 	return ret;
 }
diff --git a/send-pack.c b/send-pack.c
index 37f59d4f66..88e96d000b 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -259,7 +259,7 @@ static int receive_status(struct packet_reader *reader,=
 struct ref *refs)
 			if (p)
 				hint->remote_status =3D xstrdup(p);
 			else
-				hint->remote_status =3D "failed";
+				hint->remote_status =3D xstrdup("failed");
 		} else {
 			hint->status =3D REF_STATUS_OK;
 			hint->remote_status =3D xstrdup_or_null(p);
--=20
2.45.1.410.g58bac47f8e.dirty


--T/9MKIiMsNxnzpIO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdj4UACgkQVbJhu7ck
PpQP5A/+Ou0mjDObiAL32U3K58mXBcOEvyQxjy9BM29nIVFXKeS4xyEtk3fVEuww
3M8zQo/u3NM1XPZzPbfB99aD8Tiv9HbnirzCd+lobWT9IxB4zyrDkjTvukCDpoCw
MaDblMxbN3VH2ZdS5DKLhSq8/VCBi0m2As0dd8BYYmzYJfqNlpr8t5Q7tHqt2Asw
dSVsZQOaEEpoZQXb9jtdv0Q3z4GwmmUoR3Pz6Wn5faCqP9Eq40aboskj0ScBBfxR
w3hTyTsvusiO3zDB8ApjX53URMIp21gRz95b1eE5Io2P/VaBLyUXJb6kP8Hl9Z8n
e9affGyCuWg/Ce/9xsbzkG6PqFTFwMZKwQiJGpdoP+BSCOcA3LR8RHqtX754QPa/
JO072+73pw+WiR/H6krI9XPXWSM/iJehvhZS8nxylWdNkIZeuE3By+qktU2VAjnv
PsqvGldvDbBg4JZG7wKW+wuXujQcCdwPoUdAVbfRRYhetPCdI/li4GUen/t76TxV
OhS5ip1rrrD5sfGQ9mZTncRjhrJhQhDytnw+LKRmouEANt/WkTGrYf/ucYaNrsDm
FmvKuFu+NGLFSJlAXoug7E8czZ3WKyaMa+9T6i+lDN7U299NP9l0reOZK0urUFtq
/vEM5XxlGTvCPcU/n/zIBQz+TVvSHIbhWlOJI8+qEgIPMkqA8j4=
=ympj
-----END PGP SIGNATURE-----

--T/9MKIiMsNxnzpIO--
