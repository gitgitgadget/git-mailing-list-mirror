Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A554249F5
	for <git@vger.kernel.org>; Fri, 31 May 2024 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717142214; cv=none; b=iyNAXI5Sw5J16naR+FmE2sTcuefPg6wWdqg1Rt7rXhDtTyhJxaYXS+voniEH8p919v7Q0r09tx6HF/ZAVBk33iVLgYMLcQiY3JVd2hatkrz5V0NYU2OHPje29fzz92INg+1/BsM/iWG2BjzcQwsendXVNOn38RduJwx/GbAhcFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717142214; c=relaxed/simple;
	bh=Zw+EpuPgWpsV6MFxK/sELM0jT0q2HWkcrZuZMnwMvxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miqf9RbdfP+Utg8N5RqvYiQcqjBy1iDCUCPLoEQ0RktdEiraEA/yWqwsgfpiIjFm1rFnWK79/oxxbELq7mRv8ElAcoQdQQ7+2Yw89/II3f2/iRmgZCylBpAkomybX8WOjUev7omQhjR2urZmJ0y1B2lvyi/nndJTMI+H82ERQ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mPBurAwo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d4thBKxi; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mPBurAwo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d4thBKxi"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 190251380117;
	Fri, 31 May 2024 03:56:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 31 May 2024 03:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717142211; x=1717228611; bh=4sAc2Wg3jA
	PHoq+8jItbEAGb5nmR64qPde2+mugyQt4=; b=mPBurAwoKtMTWKiIKKLLInqyLG
	EHJ3nJgKQPIUp3DLgyRQsUhpA3UAq7pd79LhYCyv2pz8Hasv5ODHHf/cj959i2qK
	cyX+FGTLwI4+mpxQvs7U5MHQEu3QSjIC/ifJa/33b8el4V6wi9w2dydWGtr7Q9LV
	IgL3Gf9YYrNKw/nhu3lvhgPuB8HGpQZ+ffmcNdxF3fJT86QTwTTBVcJlGqUAMXi3
	L6TnPx227CGdfCPC/hZzZ0mE2iTXOfY5kzdwuAT1DAIJ9THU5Y2G65nkRiNjDKwg
	Z8r9Jucf23bwvW3iAP8RDix7kuTaWLa4RH5gipljCdQRLaGtWUVziqrWZ13g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717142211; x=1717228611; bh=4sAc2Wg3jAPHoq+8jItbEAGb5nmR
	64qPde2+mugyQt4=; b=d4thBKxiKh8iQjVM9qIaJYwWXpXpG5bsFvZDcdGWkP7E
	qHkRYkvry0wmWWhPkN6BZ8yRZKzaPHBs6zAAr8YMSHqYJ8SydkanOBNDvluy9we9
	ayNdjvfnuYaUF3DX/J33jp5Af6mJK4VKkeOt/WJlr8qxJK0GC+F0sCjSpc1eZUWv
	uJHewf0SQFrgyokrUir020qQqUbOFTAdiJHJjb9HwFhUv2xLQwgKTM/0H+usve53
	Cb4kvCj3RrzwAmlUAdVasi4oOCplABPi4oTHU4j6aGpnTL8fU4cBmzV2y9+REIex
	HKtSbKUHyx6kFRP0e2J8TIm+7GO7OfiJdQUIHRCdVw==
X-ME-Sender: <xms:woJZZlrVqG3tOlDC-EAeWyb8AdXlY4AvkgVMCGrIPQfexu0B2viIXw>
    <xme:woJZZnrPf2PxhQuEh5aCNQrEdUheX0u8zO8bkmVh966aQ6OVtpwu39uSl7sUadGdv
    qDKFPq66kzUpq2GzA>
X-ME-Received: <xmr:woJZZiNLqzmu_9L0DaK-BIDt_6m-pfcbwjUrxHrMJb5gzbf1Cvcn6Z4kD-bn6IKWgyhUn2kqww8SIf6ddnzb6zbod-CaEsWm5Fvwl60u7JB1W0c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekhedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:woJZZg7cl1ZjsfWs3wsciUry_7i1jIZTgwddFEsMRa-H9TUxoxA-Wg>
    <xmx:woJZZk4KiYvijud9K003xIpNFN_YCHaYW7CSMXCBvVyNYoFRwa96yA>
    <xmx:woJZZogTai1oz4Lm9nxLHPO7QW5vkJjLc5b-mFblMIYYzmXeKa_gww>
    <xmx:woJZZm4StAeHwRutLS4PubgoH0F-IB538O-1ACpwiardo3DDuZbsWw>
    <xmx:w4JZZjYsxPgrN4uH8SsREiJVEhOaqwFcQkppV72Kn4QBZP4zL5ej6PQe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 May 2024 03:56:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1e9bbd82 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 May 2024 07:56:31 +0000 (UTC)
Date: Fri, 31 May 2024 09:56:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 4/4] BreakingChanges: document that we do not plan to
 deprecate git-checkout
Message-ID: <40594bda5c8050c2a863df8c9f6f92cd98ea8484.1717141598.git.ps@pks.im>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1717141598.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9esZ4gEzpPVBpKXR"
Content-Disposition: inline
In-Reply-To: <cover.1717141598.git.ps@pks.im>


--9esZ4gEzpPVBpKXR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The git-checkout(1) command is seen by many as hard to understand
because it connects two somewhat unrelated features: switching between
branches and restoring worktree files from arbitrary revisions. In 2019,
we thus implemented two new commands git-switch(1) and git-restore(1) to
split out these separate concerns into standalone functions.

This "replacement" of git-checkout(1) has repeatedly triggered concerns
for our userbase that git-checkout(1) will eventually go away. This is
not the case though: the use of that command is still widespread, and it
is not expected that this will change anytime soon.

Document that neither of these commands will not go away anytime soon.
This decision may be revisited in case we ever figure out that most
everyone has given up on any of the commands.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/BreakingChanges.md | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/BreakingChanges.md b/Documentation/BreakingChang=
es.md
index 14c0972b08..fb2c8ddf5a 100644
--- a/Documentation/BreakingChanges.md
+++ b/Documentation/BreakingChanges.md
@@ -99,3 +99,15 @@ Some features have gained newer replacements that aim to=
 improve the design in
 certain ways. The fact that there is a replacement does not automatically =
mean
 that the old way of doing things will eventually be removed. This section =
tracks
 those superseded features.
+
+ - git-restore(1) and git-switch(1) have been introduced as a replacement =
for
+   git-checkout(1). As git-checkout(1) is quite established, and as the be=
nefit
+   of switching to git-restore(1) and git-switch(1) is contended, all three
+   commands will stay.
+
+   This decision may get revisited in case we ever figure out that there a=
re
+   almost no users of any of the commands anymore.
+
+   Cf. <xmqqttjazwwa.fsf@gitster.g>,
+       <xmqqleeubork.fsf@gitster.g>,
+       <112b6568912a6de6672bf5592c3a718e@manjaro.org>.
--=20
2.45.1.410.g58bac47f8e.dirty


--9esZ4gEzpPVBpKXR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZZgr0ACgkQVbJhu7ck
PpT5oA/+NuRqZd+urP/fUaM6A7gGSh5XZ3rE6uC0oQFQBhJ1slfj968H3sOGOMeb
TJAPjyV5YAy88NYWE7sQ3UDSQaCMLE4HDSOUgTbfmd6cma++rofBPudVaRyzQrI3
m4T1ZIn1Qx2E6qpMWGXJWBa27mrnAWr3BqFs45I2+uN8R1XNcjlyi2Lm3g61DTHm
t0W/oKS7CrY3kqSM2l8e+k+S2Dbi06ISiZqCptkSQbVhtaSpF1xr6rVPgXs+bKJs
BXtu7cuZXjOnC5TxcCn8mMigA+faXy4/v36eY0PuV41FRdwcM3J8d7mtWpUACe/v
ntFkI7rMKQqD5NHc+aaZOz3EgD7DMu39jXy9H+ozQyayrurMcrgwKcfaKTqzQWfM
E3kLN/5h8NotDq+esZRHa/jn7edSiZmVtfkBmkNoPivKfXWmdDRh43CUAp/a77+m
9N510Zt5fI/w99o5GUqUAcOZK9X7DK2/nIgsrMimScOffwjHZ1/flI8Oal/jR+kL
Dr/VneEV/bvMlgt1LEdpj9VlF+gVmUMBkiFGCmI5aBrpCC6U2D5dvbrAtvfmgc2w
fIuCDqnl4nrb13RHRztIMsGOvavipG6CMIYqtrmUTvclbcCVrF4PWHoRrkyMfFQ9
l7PKS1xs3olj2NoEA5RdkEa+KlTB29AI/RcR+9BuOcME3ElxpNI=
=mq9a
-----END PGP SIGNATURE-----

--9esZ4gEzpPVBpKXR--
