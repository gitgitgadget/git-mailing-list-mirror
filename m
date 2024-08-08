Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02B1EEA9
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122286; cv=none; b=YgxBbcIxD3+5zjt2eW+S0tS4ypNCDa3j6RrpHA74inF3+pZjZVfFrbK6251h7vAmM4YKWPWU7r4xuvRrscxy0VwsvXTRT8yTpaskBIawaLnL8CCRxHs4rZTDBcJJY95LKqqjI8Q2QLm2G66JjYm1S2z2Tu3NhToB5tsAw5qKbYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122286; c=relaxed/simple;
	bh=UFXWmf7TKxG06+KQI2gYlfJ0XeT51V20jk7beLuZYV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CU3w/EzQEIFzQlykMahmNSoaxNT0gWSRV9BUf8tcgqPzwPBw37R+GFchuvKJ9cw59uY5XvNB+Z+Zj1VrF8Q9oXVUjSArkzi9o2nJRLsnAgGRAlUQtEpGIJBXXASlfwCLUXieyw8cNz5pRoFasYaYHZ6mlHA1AxXmKnfqbZUGAgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VEViwi79; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MP9DRIIP; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VEViwi79";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MP9DRIIP"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0F78B1151AB7;
	Thu,  8 Aug 2024 09:04:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute8.internal (MEProxy); Thu, 08 Aug 2024 09:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723122283; x=1723208683; bh=xXMagUTGKL
	qwsUb02dzoSHqwmtvSzM8vLAcLUVJuR4k=; b=VEViwi79TWI7ayRINa9M8skeWY
	qjTXMc3xMSKS8MGtkmFlnHgqwYuiMhuTEidi/rw52Ey8sI8HaefDdNcfcqt+qTa3
	MJrohFdKggtOpv8Wuf1fLwXXe5Y9YdOd0N23N6p2Gihb1aKsTsTzXqctAZYm4aJN
	decJNWRRinTSMQZ44qVbhHBUjYFbhQAlk1lXwU4/kvNrXnrByTGWPiMZJaimNqC7
	6CJQkmvRz/hsd46z6ZwTPFYEvRmw3u6zAZiPsmw+XR0hlV3HEn6o2F6Tcf3MBims
	GZzmmuOmjdzNPkemFz3+3QKYd3JOyFOMQ8dIBetU4kxZpw77ONsygBW3rG1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723122283; x=1723208683; bh=xXMagUTGKLqwsUb02dzoSHqwmtvS
	zM8vLAcLUVJuR4k=; b=MP9DRIIPaI4a2/VtfqQATayeqIcFaj1zuHBNFF3tBO5+
	fbqwexMyMb533trNevtUjcLBiT0MVEpSNu/Q5be7oC/5PP3uOHlJPSBTSmfpM3wY
	zDBVEDBqCYfEb/Qf32soju3SKiaxZkze4V715sClv9z2/RKaD8rkTuZTU63wS1J0
	FQ+Qg3Dz9EDzs6OuOMWKwg1+r/W1g672Z4snqZZypX5v81OZ3LohiucMuCyfV465
	/6QYD507cBT5zvbp/i0Qy6tWpyWuxY28TymCPuPMBClIOQQfkRnhbWebmNX3t/RW
	dhm+6cK4gYKKPQH8JOr+z2KI6SqqYBARcIg7S48DCg==
X-ME-Sender: <xms:asK0ZkvmuQgAgUqUOFRshGF00ZiFU55CpNgIiFb_N0YIL4RqB-AUgQ>
    <xme:asK0ZheMKFvcfsvgQRmDUqTLA1IIxW1D3GBswLAiOTIuCcpXTGJU0vZrv044ixCaC
    ri2i3utTnB0B8NXLg>
X-ME-Received: <xmr:asK0ZvyntEwIZ_ZfS-o-2LA5UV6yT8z8bOqSRMQwC5IptaOLIt62ccgj1IW8Els7l5ZzUzRjYL--6qcANx8lhR52Ek-I52Ft_h_KQO_jmr0_QnQ_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:asK0ZnNaC6Hbw7fpv0HIH3sdqj1ChS7HnTRJClz2deYBBEOQpDOMaQ>
    <xmx:asK0Zk-ZYB1AGtQ0RzaT9DrMPCXWM5J7i8VlvqRabMeCl1aVqppUBQ>
    <xmx:asK0ZvXcmKPveBbEFmfiS5rMd1qvw3j10PxeBA8bPzE8Nx_aDmSXOQ>
    <xmx:asK0ZtfDE5kcsSwTpzF3OyoETHPfr-Mkv3viRYTTqxUc82sObhKiFQ>
    <xmx:a8K0ZjYMAgjAb2F92iNL-jiB0wH5duAJVcMdwTTui3JUcXOUv84vtlvY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 09:04:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 59c91c27 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 13:04:34 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:04:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 02/22] git: fix leaking system paths
Message-ID: <324140e4fdee54fbf0054e76abb287b7212fd21e.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3zN/9a3mFEW41pu3"
Content-Disposition: inline
In-Reply-To: <cover.1723121979.git.ps@pks.im>


--3zN/9a3mFEW41pu3
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
2.46.0.46.g406f326d27.dirty


--3zN/9a3mFEW41pu3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0wmYACgkQVbJhu7ck
PpRXdQ/+OJgCeuYBlf4wwStWebYZTMWkILfNBI2hpZoXk7LZlFvpS1BQm955oYSj
bQpx2ZMli+0zNS6AQy9g9SpRaWDUGxZRzWygwbj3Yxta4shkrd1zpBBrU54IM5KR
dStf5KO9MSrE0S3HwNPbpdyt+jsSY6umS9OpZfjln+JQyigWNXUd5jvuU84x/YG6
l8GGvb/JnXSVBLqJvjmRRZ6Gqf0XLnx+HEX+MqWr/HmrD2vaYwa25Dmt7GyTs9JJ
ZuhujvYqZSBeETNMyIjbznvENYtWunJodOcYM78VHYDGXCoXYM1ATZlnNhFe1Fz5
ApjUcKpmva4ahzszOzBYDHBLOK6PxfojOljjQtUR2fkLFLOD7AeeltVvWPXT6d6H
I51//r0B6RE2jDgP87ZES+ALFHXUXXATvQIXjo50XFuHNJe5kxbnT9AMnRsTkfwq
15lUeYC00Ia0H1vaUZYOB4lzDjhy0gF/FPtW7pyUrA0LtM8sy3WlR40Ov3TrtSs+
HghWnTa+ynsA2QtCFjLU0clY/FCfv3dW+bOndbtTu60CsTw2/9xmwfJ5f/Ylkxy5
w/rZwig549XJ4Y3f/lCjRdBSNp1flvFleZiRzNnkYhg2C2v/7WyZAE18mdwkjQSG
wfVYYHe6CtyN8MUqJ79D+hvtfgahB636oV3tGYy5kljod3bIqKw=
=V0Bh
-----END PGP SIGNATURE-----

--3zN/9a3mFEW41pu3--
