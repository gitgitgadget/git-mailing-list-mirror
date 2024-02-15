Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE10B13AC8
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985544; cv=none; b=ZOj52gw1HJyRYVzyN//cfuekiUKGL2bzvxkEEEsW5f1jSSJQlQBRGRlSZXrAOcK5E9AOdrVDwNNf7iUZzTRxeNNsJG54cDQQKK5cb/yMi2C52bkro2rmguPaO+dDZXNXJMI98mxRqSV3SmmA4ZIs8Zsxl32q/fdBjMbmq+fYu4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985544; c=relaxed/simple;
	bh=FRCSHu3KDkFIJArb1qreYFGt5wPC900nWAPrFJl68CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfDagDdp105NwUAhuLo3iZSiPHT3wns2NsVy51dNcsYITTJGaqIKC1/4YVo8usFiSs15MlhfyhIkWD87q/OBedU9k88v0cFw+/efMbvujSv4nddMyD/eEJPGVucA2yG1kF+Ja2IA9LBy9qPA3q9FHpT4+XLR4g1ou+dh35swrEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mB0B5IQL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LH0zILAE; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mB0B5IQL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LH0zILAE"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A28861140094;
	Thu, 15 Feb 2024 03:25:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 15 Feb 2024 03:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707985541; x=1708071941; bh=EkczgDjwNy
	xr4LM68CkLzkYZcAPhZe26gz2ynNXzfdo=; b=mB0B5IQLI7hbKNHEFWfFB+/Yhk
	gSXEvyhEFZrf0sFDBv/cdexkfojO6G7feoNIVvBgtOi9QVc1h9M3Uytnz204W0my
	gbxYxNp0zVnd4jpcNa6EqfZUyjWtNDgu7fsc+2EQP5avJSZtJpKSNxAFNw2OXmA2
	cZzlh+s7Qq2rl9+zxieuejTH4OzjyA1Q+yQjckYEubkZnZWWWmm83+E6/4MlZGpg
	GNBgIhvIb9lRisVOAVz0cKj90VpF1jmMUkWGihoec7CHA9O2xtQ9gpFO9/5d2fnp
	RX1bBHUNZxaNymxy/llXqdK+R85Dz63NSI+0m+GwWwBYteV6eb3oXYDHD6kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707985541; x=1708071941; bh=EkczgDjwNyxr4LM68CkLzkYZcAPh
	Ze26gz2ynNXzfdo=; b=LH0zILAEZfoKn9D7Wfax9NGUs0vGS2w0G8b3HFTnB1q7
	fr0kDzGR5W1RSXO1K3EIKvLi8VKQgws7zA/w/zLh27Pv6rX3tCn1j+hg1wyavBuf
	d3w7sCWNFqJD0ZJHG3VHTxhT5ZFG1rezcrL021hXztMjI3sWaPjaHQgFHFFtuJui
	OOMf/7QMfqUMbV/7Xdp5XOZQw35+QhutPlSPoW+iTOaI06RTo0g8XCDsEEj73kl5
	2G1tM0Swgs1QbCzX7nJt2X1F0fqeKTG8S26i2Ro3UsU8RyEt4QB/1OZmye09Xld3
	oEhO8uSqdaAvKAxR8pMlcHi6WlzCRtqNyKC1Zbhj+Q==
X-ME-Sender: <xms:hcrNZY_8jU2y0EkRnxXEIJAEsNXEq0hy1T7ec75UPeAkUQWDDozl3w>
    <xme:hcrNZQsfJ7QVSs3uWpoAEVm8HhBmKuDRGg3czGV7VL1cJSAMWVfzn_G4s05N5IFcR
    mty6U31wmm6fxuaWg>
X-ME-Received: <xmr:hcrNZeBxEPq1pLq-gPMo70jn8yy-w7MFjo96YqaHOIm0tywjyMAg5ZuVTVSo5JlJqC6TPYWwG-f9v5s-S15PL-c02r0yXgI_NrkXAqpYuKx_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:hcrNZYcos749vokhR2I-CLJo_ihtZZhfyPbaiUnbxt9A_HiKlIGuRA>
    <xmx:hcrNZdNPadP7w90_lzVUwG7kqgFvrolSFWJYHROILbVDakKIp-ZDLQ>
    <xmx:hcrNZSkr-bK91Gw2KN_XIXz0pik3mZeATg2RQXggtFXJwZeK8MQ_fA>
    <xmx:hcrNZepsgm2y4XyJgK_bai59Hc-1ZZ5Q02k4Ye-mUueh0SP6tkg6Rg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 03:25:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dc9837de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 08:21:48 +0000 (UTC)
Date: Thu, 15 Feb 2024 09:25:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/7] t1400: exercise reflog with gaps with reftable backend
Message-ID: <ed57913eb95e4031ef3319b37aa0972c8c1ee89a.1707985173.git.ps@pks.im>
References: <cover.1707463221.git.ps@pks.im>
 <cover.1707985173.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nPwgyMhSieW8OZX8"
Content-Disposition: inline
In-Reply-To: <cover.1707985173.git.ps@pks.im>


--nPwgyMhSieW8OZX8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In t1400, we have a test that exercises whether we print a warning
message as expected when the reflog contains entries which have a gap
between the old entry's new object ID and the new entry's old object ID.
While the logic should apply to all ref backends, the test setup writes
into `.git/logs` directly and is thus "files"-backend specific.

Refactor the test to instead use `git reflog delete` to create the gap
and drop the REFFILES prerequisite.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1400-update-ref.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index bf37763bd6..6ebc3ef945 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -426,15 +426,15 @@ test_expect_success 'Query "main@{2005-05-28}" (past =
end of history)' '
 rm -f expect
 git update-ref -d $m
=20
-test_expect_success REFFILES 'query reflog with gap' '
+test_expect_success 'query reflog with gap' '
 	test_when_finished "git update-ref -d $m" &&
=20
-	git update-ref $m $F &&
-	cat >.git/logs/$m <<-EOF &&
-	$Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 -0500
-	$A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 -0500
-	$D $F $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150680 -0500
-	EOF
+	GIT_COMMITTER_DATE=3D"1117150320 -0500" git update-ref $m $A &&
+	GIT_COMMITTER_DATE=3D"1117150380 -0500" git update-ref $m $B &&
+	GIT_COMMITTER_DATE=3D"1117150480 -0500" git update-ref $m $C &&
+	GIT_COMMITTER_DATE=3D"1117150580 -0500" git update-ref $m $D &&
+	GIT_COMMITTER_DATE=3D"1117150680 -0500" git update-ref $m $F &&
+	git reflog delete $m@{2} &&
=20
 	git rev-parse --verify "main@{2005-05-26 23:33:01}" >actual 2>stderr &&
 	echo "$B" >expect &&
--=20
2.44.0-rc0


--nPwgyMhSieW8OZX8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXNyoEACgkQVbJhu7ck
PpQhSA//XafytE/h+kWwcd+phSpyTkFwNwazRjUy3neiJx60XQ8QD2v6Fig4tyNP
Fu5JboZ9mIfX5EW5cWzuXlq9W1uwVOoWa/IEjckOc5KUbXMhv3KK4C02zzLac9Eq
tHqZcNVr+HgPjwv+d2opBYWdP4AgUGA8MnE2BBd0WCHP/nXrndJNfzc/86G9HuT1
huH+Ne/vkb1mmdNtR5hHjjvyLCe/H+1lzZ6UfTG0dewfFMgB7qBtcaKpzCnqS/gw
h85BiP1Kftwgd17qEYYCakPkssn/NX1k8eTuBjOJMbaeC8Z9tk4Hg8RH5m11g7EH
M1DaXyLrtzkdsyLFfMBv0D2OODnj617kVYoss85QE7cCPDPbyY3YSC7ADjCsYXHu
ODhy+kDpHuP8HWPYRQoFKNMcdPEv5mkBy58fX6FimEphV+evXY99lKzbCgRVzZI9
O0UgZlQvbJ/y+lukz5VvKQqapEALvJLllEtS4PXNyzJGkzI0jjXYUox3e59TLavs
0gqkuVT53LmfvxpexFWtirrv3eRFaT4N2lEF7WvPoyDfSK6ir+pTnE8gA9H5ipuo
9bR02RdHjGJdLg85stg88GPTCTpkUt1+AeSt97ilykITrniCaMkTg492Yq/mRrbl
ox2G6HBE9UkvK+DSQVPwExb6QPfmorkPu+ZnuDD0Kqh7MYQjZRE=
=/65i
-----END PGP SIGNATURE-----

--nPwgyMhSieW8OZX8--
