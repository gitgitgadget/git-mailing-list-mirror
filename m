Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5264B18A6B3
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122298; cv=none; b=uZ/t2lABVNaEBiT67Y7vGrshLdkEjzNw4ZFog8zfr8mSjP6t07zHzk/m5GfamQQX9/WYtCc9t6HwA4UWLjCei+KSjrTXJdvgR6M/9jkcNeBCLd4EqPXT26YKMHXM67eCJo4hFxwLsMnlx8BW4+qarCMKk+xwL2hAclEYITagmeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122298; c=relaxed/simple;
	bh=yp1ZPpMPF1yeULBu/xlmGHp6Va6lHWm6BK29k8JtWw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfzLa/MUVbq+AziYTz2y+BGAujEmEFpwhFlopteYUviRKWGa7vfGrXbRZxZqOfrreUCgJwkRiRmnMABKY8oLlZZ+KNAwwxzKnuC7qbQ8iUTIoNXr0JtKrIMD7eOA9uK7fUFOTG+3bPbwijeScQ366qQ6oifebbf6/GYGIjm93ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k+uqrOaI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TWz70G2U; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k+uqrOaI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TWz70G2U"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6E3DC138FC65;
	Thu,  8 Aug 2024 09:04:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 09:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723122296; x=1723208696; bh=ihvA0cZgu/
	ZmG9F3up+dU6Ozg2T/EtM1clmJPbKKljc=; b=k+uqrOaIwqg9tLRXdGidnbcz6i
	K9pJKiJ++coxWhpgfH26fCcIc4weTKAEgzzs6yS1rpBJ6pP+zorkEYDTX2UsU1AI
	U/kONjooqGRM5SglVTG2tmkuF+/AeIzxO1/rEkL0bTPhj7q6sTDILUuQRYJtUO8L
	UbyQ0jc/mDfAK0mFgJWsWZWYvZkOSFbjsxjuWnI4pvDAHNVsucLelEQ6uR5zcptc
	5W9El6tX3syf9oBnAI3vRpvX/RSvC8pEOKww88CePcsTwo5kK0GGs1KKxpxJQP6J
	YDmYys62slc1epW3YvuOCGJMKIC2NLtl7SIQE/Xi62Xa6uVHjeQImrTNwmpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723122296; x=1723208696; bh=ihvA0cZgu/ZmG9F3up+dU6Ozg2T/
	EtM1clmJPbKKljc=; b=TWz70G2ULDbA5kaQnAET4ZFRHIjcJsoTXzpNNh/jQTQE
	Qex9KLCYIzamco5pdETb68OazURtlM6fm0+U+4CIOGAwmaSzwYig9RjmT4W8X8Cy
	jVR4TJ2xCly0SDP/y4XF8Zkx4Qa9OyNI7kvvaWUv6dLWmNwrj/WMlMcXDwM46V1g
	3ccDWI2EiV3wuzbTkZt10QUB5rZYTAWTHY/LwRmcmvqM4EsAYR6vNw9O9vSRWhxa
	DHCkYGHec8P/PNykpYm5H95VRMtllarNCSc2UCYZm611MhBhm/dPdUZ1w7r9akrc
	JfiUna7hNlKMKLwHNwOb54iUUsIt6WQw/hRMBdomzA==
X-ME-Sender: <xms:eMK0Zj4b-LVoDVX0xhcQzCDxB6FJBTrZoJLWcGoAEKCY4zUVsVI9_Q>
    <xme:eMK0Zo5pO4zVEpVaexiNbjJzY72dfBU2KxZM0a19evS8iM7kB7snHYQXQKz4u2ekt
    m0rxuzyrLGFi8yhuQ>
X-ME-Received: <xmr:eMK0ZqfdaYAscJQ75AYSbI0_RwZKOqZ2_6V0b5dWGTv-q5fndmGq13PNFl_GuTNLjmdFSAXbyNfFQHW23-MAilLzzjAnxKlJ3d4pIR8qljfnrlIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphht
    thhopehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:eMK0ZkLWDjfe9PDRj8KhVokKxJttnUTz35aCUWYHW2ZoOimN7MAPyw>
    <xmx:eMK0ZnJK7MJ4vVmT-dYFOasPaAWePq7WyZ0_iPVwdLYS18KFa-AgBg>
    <xmx:eMK0Zty6fEd-ElJxae_dU-pjKJnOfMbVc7sG9Fl-5OLmpvPjsG7lGQ>
    <xmx:eMK0ZjLJav3cqNLHn7Kvt9dhBm7NXbgb6BQz3Iibmx9IG7dXdFoGMg>
    <xmx:eMK0Zv0flzqSANdGBMY3O6YzJwtLBGhiY90TWirbrS52BOf-aoKFuJHJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 09:04:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2d4e96db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 13:04:48 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:04:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 05/22] bulk-checkin: fix leaking state TODO
Message-ID: <454139e7a4b0272ec8c304bc2a84dad35187de78.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xYk0YOjpRNY9CZEd"
Content-Disposition: inline
In-Reply-To: <cover.1723121979.git.ps@pks.im>


--xYk0YOjpRNY9CZEd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When flushing a bulk-checking to disk we also reset the `struct
bulk_checkin_packfile` state. But while we free some of its members,
others aren't being free'd, leading to memory leaks:

  - The temporary packfile name is not getting freed.

  - The `struct hashfile` only gets freed in case we end up calling
    `finalize_hashfile()`. There are code paths though where that is not
    the case, namely when nothing has been written. For this, we need to
    make `free_hashfile()` public.

Fix those leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bulk-checkin.c   |  2 ++
 csum-file.c      |  2 +-
 csum-file.h      | 10 ++++++++++
 t/t1050-large.sh |  1 +
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index da8673199b..9089c214fa 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -61,6 +61,7 @@ static void flush_bulk_checkin_packfile(struct bulk_check=
in_packfile *state)
=20
 	if (state->nr_written =3D=3D 0) {
 		close(state->f->fd);
+		free_hashfile(state->f);
 		unlink(state->pack_tmp_name);
 		goto clear_exit;
 	} else if (state->nr_written =3D=3D 1) {
@@ -83,6 +84,7 @@ static void flush_bulk_checkin_packfile(struct bulk_check=
in_packfile *state)
 		free(state->written[i]);
=20
 clear_exit:
+	free(state->pack_tmp_name);
 	free(state->written);
 	memset(state, 0, sizeof(*state));
=20
diff --git a/csum-file.c b/csum-file.c
index 8abbf01325..7e0ece1305 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -56,7 +56,7 @@ void hashflush(struct hashfile *f)
 	}
 }
=20
-static void free_hashfile(struct hashfile *f)
+void free_hashfile(struct hashfile *f)
 {
 	free(f->buffer);
 	free(f->check_buffer);
diff --git a/csum-file.h b/csum-file.h
index 566e05cbd2..ca553eba17 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -46,6 +46,16 @@ int hashfile_truncate(struct hashfile *, struct hashfile=
_checkpoint *);
 struct hashfile *hashfd(int fd, const char *name);
 struct hashfile *hashfd_check(const char *name);
 struct hashfile *hashfd_throughput(int fd, const char *name, struct progre=
ss *tp);
+
+/*
+ * Free the hashfile without flushing its contents to disk. This only
+ * needs to be called when not calling `finalize_hashfile()`.
+ */
+void free_hashfile(struct hashfile *f);
+
+/*
+ * Finalize the hashfile by flushing data to disk and free'ing it.
+ */
 int finalize_hashfile(struct hashfile *, unsigned char *, enum fsync_compo=
nent, unsigned int);
 void hashwrite(struct hashfile *, const void *, unsigned int);
 void hashflush(struct hashfile *f);
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index c71932b024..ed638f6644 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -3,6 +3,7 @@
=20
 test_description=3D'adding and checking out large blobs'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'core.bigFileThreshold must be non-negative' '
--=20
2.46.0.46.g406f326d27.dirty


--xYk0YOjpRNY9CZEd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0wnQACgkQVbJhu7ck
PpRVOxAAq1YZRl5MlM8QfcdSJ6itwIZjs7XglQHvw7zzwK08W2ruNExlMW3Xlaup
EjlRofcrMXYMapQfxvSqOMQp1W3nX9j5gC7vLEeEv2VgXcr78f8V6vGbKFwpti8+
fUwwXiy+ajV5dTEeF1w0CDSCzJDBPCdcbNqyBorXBKZ0T2YTJOiWK3j8dUOkMZ9R
x41UYa/iz4D/XPTF9TKogJc1wVGs1gqRHA/P2to+VB31gnitrlo9beWGIcXrCOmD
uI/pZifkn6NT/H+uTLFrhJ6FrtUjm9dYfZKHN7TbJDaqbCXQy0lrEZwyYIXagVVw
KyldQLmCAm5p8b0fJQ9DOWiuShHomV6UVJxVfdoof17+9jMtAG0p3UsRSZVS4kKZ
Pp9k/uGf5B3+U+uKCDqsGFDEiGGY4WfVD7e53BsL/+rd9tUfg6uYbZTQmASgVins
B6TGPx2y11Jdr3tmmwtIE/8Ocs82B18CJ21aUU+/ld9O830KumxFzk8SIRxzQ8Me
NZM9/L6Yjg3MpgDLalUhMtcon7Vrc2Rcs2kTNp+0vVRsANNJ0kaCNDQlcXcCCmhx
RcEOJlURHOaxTvX8vaxPTL0RI3050fC+b8ikB2YofBTA2G6BrAVyo1e4OTE3sUMp
XDpMXmkhXzdPDw7OzgEeaU51s397hN/W63fnZ1PNL0aTsp2l+Tc=
=go0l
-----END PGP SIGNATURE-----

--xYk0YOjpRNY9CZEd--
