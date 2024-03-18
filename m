Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAB23611F
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759171; cv=none; b=FQCyJWvH+T8ldrSGQRMluWyIeadrn31DSKjC31yzXTOJLLt7d1IDthOqaALGA2du0/UfxgOI2tjnpaM7UoBa8itpJbgsPY8xun5ZlsM1ZIcY82zH/NWAEe482t/VJYfyJbW7WFmbN0v7lDCNXzKqQ9ZFAgm8HB8BC8FMpO9kQ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759171; c=relaxed/simple;
	bh=nGBIsuU+kS3bKWVXomXq7EbrW9Q6OtWBGA+oOOvp2y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZb87YyBQiRMCg/NojYIqR0fqGTAt0Q+4Pr/x9YzbdFcatGVMgGzVACPSPrzEGTarywhS5Lrm0PjXdredF0HpwZrcxwcy8JxDcVH62trtgo5rjekw2l0BdVJoVeyJv2CyM/vZ67k/gtCImjzAymgrIkCPFYLRgAO2aV5JlkeT4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nUxnKFRF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cJ1Zqilw; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nUxnKFRF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cJ1Zqilw"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 8D37B5C005B;
	Mon, 18 Mar 2024 06:52:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 18 Mar 2024 06:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710759168; x=1710845568; bh=ijCvTQSBf1
	nsUGKqqguA/kXc1KwGVni7lM1GgKHLOWQ=; b=nUxnKFRFqZDH8r5xy66Fcx18l5
	CT7dxjlShcIH8H936mxfKiQ/03LAKsAM8H0BhA6ub3W7rTxfNzKTEKXS0sJ0Vwpt
	5iUFRJkOWqDLimwJabyKPm0vMtP+P8CBMdLOEcfqPUFkUZt6EkpZxLquaVEjZj2A
	BnhKWhnYd4Tu3Zb0BwrQsvC8xzg6/aZPx1yW7tLDjyA+lKb4ZfZpr16PLaoNpNBf
	vtsmVmfGSrs2kfQq4nkdKum70rBgMm/EZjficqlgSEZ4EXQQZcyidW50ILbnemlh
	sHInGlBsA2SNCUVviT44mSAPxG2WiwxuLjim7CC/ewU5o6BfNEbUK5cWjK/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710759168; x=1710845568; bh=ijCvTQSBf1nsUGKqqguA/kXc1KwG
	Vni7lM1GgKHLOWQ=; b=cJ1Zqilwe2dbwjPZcQlqhgcm8oj5Tio6ixdefiDhmikH
	nHSmsCLEl8yb7WzWMCAVsN2agS/fohoAxr9Je7gMoWdWJ8kzaR88gmkDa6yByS9R
	g7v3b2eG1CBahmBYFRJbttxsjICB7vvg9QeswK/DWpuA4PIcqfiUFW3DaCcLizZe
	yl371rdY+eidxYEbpsNDrM/sBGzPQWukk9/sj1nktBSfY3EHELPEEfLtiptEpDk3
	NOukS8XafxZADOrCdvvLrqZt2/cCfWr3smM3lHkubzp2nNJpXUnuXZN8fWUjFG3b
	LRA8MNyEZ9PQSFNLTM40YDozocjeu+Phr9WjF3BA9g==
X-ME-Sender: <xms:AB34ZYD0L99C4mSix8vE0jiNmPFJqsawgMdUshDEJNXRMJTBkh13eA>
    <xme:AB34Zag2DMsWrELQSmzUOaQGVnlxzjGwFf_4zK0x_8luzO3o-d9HrDAmJISZA5eoX
    lhoD84CRBlNITuvxw>
X-ME-Received: <xmr:AB34ZbmNjncFLvZN8wGNhP_1qlMgF0JYTD1jTRJ-h-MxyxGyuWNq-7G7MCW1CAPZluf5StbNNQfVmD1Zg-dIFzkB4rR83kfHU--c3yKR3sl4Xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:AB34Zez5dVS0xAxVFN3qPnbhTDhqc8RtVulv_uHzQ4Fy0-g6y0LFcg>
    <xmx:AB34ZdQ1mT4093-l86xlR9SU4qVv9oB_qNYFXKXkF8FtZ-GJK3PFKw>
    <xmx:AB34ZZb_7kU90kI4jiQFfsfW_bw3pP2pLApRQBd3WTVfMAdNtV3xXQ>
    <xmx:AB34ZWQoSaVusxqWFO7-91aYHvVIIILi8DFp-4-LKwvDpaibBOHW9w>
    <xmx:AB34ZYepnWp07ykh9A0PqINp26kxfIJ4FYWQyVE3Zu6maOs0AYJrOg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Mar 2024 06:52:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f3ca0b51 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Mar 2024 10:47:56 +0000 (UTC)
Date: Mon, 18 Mar 2024 11:52:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 05/15] refs/reftable: print errors on compaction failure
Message-ID: <f336db817c76339647424f316fa3d106bb90416d.1710706118.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LiPmLR3RFVHk9xSM"
Content-Disposition: inline
In-Reply-To: <cover.1710706118.git.ps@pks.im>


--LiPmLR3RFVHk9xSM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When git-pack-refs(1) fails in the reftable backend we end up printing
no error message at all, leaving the caller puzzled as to why compaction
has failed. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c    |  6 +++++-
 t/t0610-reftable-basics.sh | 12 ++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 74dab18eda..66cdbbdb24 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1221,8 +1221,12 @@ static int reftable_be_pack_refs(struct ref_store *r=
ef_store,
 		stack =3D refs->main_stack;
=20
 	ret =3D reftable_stack_compact_all(stack, NULL);
-	if (ret)
+	if (ret < 0) {
+		ret =3D error(_("unable to compact stack: %s"),
+			    reftable_error_str(ret));
 		goto out;
+	}
+
 	ret =3D reftable_stack_clean(stack);
 	if (ret)
 		goto out;
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 5f2f9baa9b..a53d1dc493 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -375,6 +375,18 @@ test_expect_success 'pack-refs: compacts tables' '
 	test_line_count =3D 1 repo/.git/reftable/tables.list
 '
=20
+test_expect_success 'pack-refs: compaction raises locking errors' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_commit -C repo A &&
+	touch repo/.git/reftable/tables.list.lock &&
+	cat >expect <<-EOF &&
+	error: unable to compact stack: data is locked
+	EOF
+	test_must_fail git -C repo pack-refs 2>err &&
+	test_cmp expect err
+'
+
 test_expect_success 'pack-refs: prunes stale tables' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
--=20
2.44.0


--LiPmLR3RFVHk9xSM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX4HPwACgkQVbJhu7ck
PpRg+Q//Q8sDr/oPD4P9JbZ+tJLVlluyx4o0wJfp1LC9mV2qcArgyVsoFJahN+vZ
6YS7oTEPj+726j5w2bI7k33U7RtHUgjoIHqpnMyMur/skEfdUPkHZ85CWMbNyWtB
zHLt8k/amPMUVmXGRfOh0Br8AVYDnhNJ5YAAzgsVYLNeZ6Jk1cHdnm60fzgvttWv
kSp30mK0IWIPP1ep8VDo+f6PyGRYetbvC8Da6hRMRWBI53suujG8d+zosW6YCkul
fs1BqDvjwy2CHpT0Gl+8MdGkuk9hfshF7AJnnkGxtMXy3LAGMRl1UrW4CHGRmxGV
BGDCYhCQlN5eZtYS3DAiVoBsKBGK9SsO50TEVDK5NjKMqRQtjV8+XfaC9K+52oDy
DxlJg0neWMcNFNmsPgitbM+fccU/xjJXQkzvLgaZbpJ9rxkMbEL+sr1opxqzqEF+
blg59nc7eV9r0HuRyAFfdok4jupIdNRyCnKLpeu28guzkX8P/SL0A4+ckDBrGHS+
cm8jEG4H4OUpRGaWnkNBxi7xelubd7U75OkJturEr46YFcbYAx/vxEFaHTVpnHPn
QVQOLOJ+hM+1TEA+Xfy8zlFUziN5rogAZQtfspX1JnLRPdHyeL1XXR8n0vgib4iI
2hdaJ33ta7PW6di322WAXatR1hJ6gk6F2MR+EMLER3nlNYAPyLo=
=RhTK
-----END PGP SIGNATURE-----

--LiPmLR3RFVHk9xSM--
