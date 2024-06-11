Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43295176AD4
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107133; cv=none; b=jpLgBcDC1rnaRr+U4jCj8iwvvjhLx/1YfCOuWlzMDJnf/xIpFAFbMDjnlBkjhV2ClCr5zjfvX0veK/X745uX+4FXYnilDX1yvFtV6ZALelNOEXPp2my4y3L8b6nVY0I9ZvyADbP3RSxOFkJavMY2duCkXBKMrSV3CYkZ4vFfHYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107133; c=relaxed/simple;
	bh=34rHzqYBbh60jEbfBfujiU92Y4dYNmMTgx09Ovpq/ZA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l002sFE7+Jpvhsv037BOjvBLhaoAT1P1Pk0Cipk4VJUYFMSgUGaHHBOW9kG6Q8KYFGqMPrP/jDasZ7MoL1xLNcM4S0nB9wPEdUEM8ZMGRu3LhnFoGSsls5EOjEpRlkGd7JNWlqUTwlD6l/b/R41HBJmFE+Q0wTMC0SpD9jPS1TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F8/e5tP1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uf9VVQ3b; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F8/e5tP1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uf9VVQ3b"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9AD2A18000B9
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 07:58:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 11 Jun 2024 07:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718107131; x=1718193531; bh=5RyAq2z45q
	fKj8PdG1NZpZ8nIidOU6GFuzTgAd3wW2Y=; b=F8/e5tP17aaOjoN/92Z5iS4UMl
	AHqsAM4+XJS809GGsLhtR6iGmJtrWgiy6awLYhbL8o9NpN/ipJiPOAnu3gLlloXe
	fIVgmFw3H2hvteIa0XU8N0+tugr0jTI5yixQbSqPrXscRDb+033YE5gzwegfzkaM
	c3wbButKrS2FmaElfhP6CoDbKGmB+E5O3NW4LmoW71D47bKPqQpe6iIoSWHmZRRS
	A7/OKAfEs7HXCiF8ccPJkrPNsN6fR4QbOKGFytXy/ntUeFUSYlqnt6HCy2bsFBER
	Cj1fan2M+DWEJUqHiJS6nEegyVh+R2zWlQivTO9EdXi/+4bbs7bMrCXOGDJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718107131; x=1718193531; bh=5RyAq2z45qfKj8PdG1NZpZ8nIidO
	U6GFuzTgAd3wW2Y=; b=Uf9VVQ3butZnLdUHkN5B4dvHub+/3Sso1DUKDV7rf2hH
	CUy0YZ0a6V/A7PIBnCvjpGhi+af8P/dHdBe57M9VoDmZieCv6qP7yl1skyBnsj/M
	Rr0UGa8j+uh/m7MLdoqJE1fsOuPPs8VP5KiF7SMju14Q+3tLQgokSbCaC+zV2iaU
	Hi0h9ISCf+yYvmRrCo9SMo64Uky/XNJpER9FNXEv6FaFWtacSCAzGTc4me1z4Qah
	2nkmfYbY4rPlPcfqsVXz6GzcrdZb9hCsKvNr7vvYEBlvFSW8UT117cVidnEUXzEW
	6dst1yhVIFcuzTilLcxUewL+BMsmspbErEZdaxIeSg==
X-ME-Sender: <xms:-ztoZlW4rMLmcPQcDvBsf2a875MEJkJcZYoKvXf3YtFo9_mJZ3wMqg>
    <xme:-ztoZln2eP28p6XdUms9Mq_mHhxpSu7bsHaAlVGvOn8hIYJ09_E8EHUBqkDQXvhtw
    CMECwDWjSCBmhXYcA>
X-ME-Received: <xmr:-ztoZhYyQdnBOZBICc1mvUXQ3IaPJgr2-FksMHuvmhv0d6poOq1Vv0kd18USlDhQn_muFMjEM7YaN4QV_7McnzMMeusq6fbp5CBKyHzC6CnZV4fKlkJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:-ztoZoWD7ZjyR96bMLxgsGbwVu8OtQmNIBITslNNaRcJM8durczRvw>
    <xmx:-ztoZvlBKlLh_5PFtzjswWQMBe3QsbX43Z1-zoYi8YsrNE8Nr93clA>
    <xmx:-ztoZldptjMm90b_HM-sHF9nzK5m1cs7_6WBXposcLR7dN3BgICPkA>
    <xmx:-ztoZpGVIOjwpEODxKl4FqWj7y_knWq4pBUM8S_VfKpyiScwr2Hbyw>
    <xmx:-ztoZnua3fNRmZVdboEzGOLJDx8yEYJre06hZ3PUs2PriGauQ3XAtzZ6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 11 Jun 2024 07:58:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c1919028 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 11 Jun 2024 11:58:40 +0000 (UTC)
Date: Tue, 11 Jun 2024 13:58:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 16/21] compat/fsmonitor: remove dependency on
 `the_repository` in Darwin IPC
Message-ID: <d4e87f9d6b4813fe359e22f4b5d5ebda28e09a08.1718106285.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y+Yj4fl1lroKE94s"
Content-Disposition: inline
In-Reply-To: <cover.1718106284.git.ps@pks.im>


--y+Yj4fl1lroKE94s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The IPC socket used by the fsmonitor on Darwin is usually contained in
the Git repository itself. When the repository is hosted on a networked
filesystem though, we instead create the socket path in the user's home
directory or the socket directory. In that case, we derive the path by
hashing the repository path.

The hashing implicitly depends on `the_repository` though via
`hash_to_hex()`. For one, this is wrong because we really should be
using the passed-in repository. But arguably, it is not sensible to
derive the path hash from the repository's object hash in the first
place -- they don't have anything to do with each other, and a
repository that is hosted in the same path should always derive the same
IPC socket path.

Fix this by unconditionally using SHA1 to derive the path.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/fsmonitor/fsm-ipc-darwin.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-d=
arwin.c
index 6f3a95410c..b4d21d6dc2 100644
--- a/compat/fsmonitor/fsm-ipc-darwin.c
+++ b/compat/fsmonitor/fsm-ipc-darwin.c
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
2.45.2.436.gcd77e87115.dirty


--y+Yj4fl1lroKE94s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoO/YACgkQVbJhu7ck
PpQG4w/+L/BtyYwra0c1XCeKFwPU0qzF1Phb33uAM36vIIMLQv9JMq4Uu8GuHa6N
amG/thYntmIvttuuZQdj0jb/pXWhIH8PLtlw769Wp47qE4svoryL7IfCjMKqnC96
thiOxEAufeNh/cS8kC59d0Zy7C3xNLZPBmZMGU9b600qinf94RqYoy58BXf3J+V9
IIpBNqDYYhU9mD03cgdXT6pFQ7412HhShkY+UqO49tgLTMDpYos49lD2Vlr8h063
4X625Fbfa78kHONASm2l75lKiasyrlej5rE9845LbaJmmeIbLqvPbWwGwqSTGpbB
Zm54TuvdNls4l7wLrF8/6kWp2WqV+tLFhPf8O3Ba+wUjT1gVjO+MjX/a8dzC6gfd
Gsn0GcL0SaKgiN75JqPB8f1hmnPwpViFVgVCfDByM678R2gpcADOt8Q47vGwOqpD
rw4yJZuWUNo/ASgKHIbSVjiHgXNyatX34wr9NDMpMTnoM4oNIdgTe2s1E4iQWhBx
2Sn4WWqtsp2QRQXEeK1uUfYx7vqwrmD2p1qLhZmOeLD+vPFSe/l58cLwDsuMWjEP
HwL35wxQqk39Zwj0WU6dWaANfm5hQDYsQ+zRtf5emtN+tZixSqGcBclb78nboD16
rF3SZ4moCPZxv12Nf9Z9TUaYkZ3CYj9YFCh+djb4NwqRFgJpy8o=
=W7mC
-----END PGP SIGNATURE-----

--y+Yj4fl1lroKE94s--
