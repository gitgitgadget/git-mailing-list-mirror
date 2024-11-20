Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9322C19E804
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732109994; cv=none; b=R1C7iG9pGEwcLnT0qboXszzc2ciZx90iAry3vewBZqAGAgisNXMA4VEFwgnU4pzt3X6U7/L/knF3WnVL5KMM+R5jaZjoJVSaIPcGhP2KGGCrl9ua72pV6BEV1E9YK3H8YDGas3Ofdam6I98U5W7rt1gcNUOci7sUJLp+V5pkesE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732109994; c=relaxed/simple;
	bh=Bi5Udds+t1aWp3rkI44BuuffERTuC1QaUbzUeiP7IJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pwf7bxSwymDSKPBobuOpvNsVgO6UFQYCgK65MWCug1p2msdnvkuWOiOo8sg8ERW4noK+F/caXOrBm7s+m/a1FjIWexLUt7C+WkJVKfVfG9BwwN07eVYD/mfvohTiAzEOB5S8akMqdBXKNBFFQlIxj5tMDB1ry1B1CZWwlzp2e2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vzRuA6xN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Can4EkT3; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vzRuA6xN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Can4EkT3"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C0E7811401CE;
	Wed, 20 Nov 2024 08:39:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 20 Nov 2024 08:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732109990;
	 x=1732196390; bh=8ubANSNcVvYLwPGneYQ5uabULAVa4rzyPqLvvEa1IRw=; b=
	vzRuA6xNRb1YNsn/Gn34qZILVXkN6D28p+IM/md+eiOj6xuCoBX1WD79eONCeZiD
	fNREQ41cXzmRx4SruyFRAn8YnQMJJ91A/BPoLkDUkI3/iZ7RqX8mxfdxqLwoIs2y
	FDAZ5IytQzcfcPy+xjn5CnozoeJYJx5S2+Kr4IpxACk0CyMw6u9NCeqb6zn5cTRE
	GVuRTRj7lpdZjg6zQ0fpF6DoB7dd78Q5QmW2Ck02e0FWh3Ygp74fpAFMNIHHrB9q
	19Cx9V5J3QiKGrO3VpC1d6mYsqvTnjTlfdkpy3evl6yJuyzjkFax0AzsiLn6z6rb
	KeEqwvgRKLpsLUgKapi4VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732109990; x=
	1732196390; bh=8ubANSNcVvYLwPGneYQ5uabULAVa4rzyPqLvvEa1IRw=; b=C
	an4EkT3JagbXCErvH8HlaW2qK0runFhnCIKwFT7mnCrnguiY9qRcQsI7/jrzac1/
	+0rQYD84Vqv3tTn8UsN2/9SadpWJpcnftcoTpLthvTjQLUIL+eNkRdIkSK19BhUJ
	oODZWLNI5kNAw3ktvxOL8Vgm4CTf8oxL9mgrrgstfy46NfLohVRXqyNhtEGEtCs7
	gVEDZsvTEjHHOe0L9V4AeiEVPWef4YHT2u4XuTsUgaPJgKZrVqHldMEcu8aSqKDI
	j9t9NRabKEBqkHa6Xyus6Gf86STTvbf9xJiT4ur1stJnS6VR+T0GL1yqReepqMVA
	FJeUoNr0hp/9bCDKC321A==
X-ME-Sender: <xms:puY9Z86NJQoV24Cr9kLX518Hy1r0kyfOBaWmpqLBvJBv_AbxPHdzPw>
    <xme:puY9Z96QQrVooZjE607nPdxdp2XDNZelPXdVVbGUsVtG8dSFWqZWI1YZ7iOVi8yEv
    5U7pN3EVYkw0uLvMA>
X-ME-Received: <xmr:puY9Z7d6hwMPB-gm_gDpO7MhLfk4qWOEKJpUYgO1yHQrlulaAvlh_iifRiBNcGQUBn3JWlPc2n3aIP_KcKlIJe5ng9ZxljEHbWxjxYIaHnnI2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hrjhhushhtohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:puY9ZxIWh1Dc7Vh2y5YiwM1wP-ZRrqQtMaqna_Gm_gK9H9TYt2BTXw>
    <xmx:puY9ZwJWNNiJrkQH3COi7DB9uExw1zgGAYKa3nBGRIbkaj-cqetQpA>
    <xmx:puY9ZywHTZqx7E3KYkdEJ7CXMBrKHVzVo27qhk8kWJrtL56y9DVtUw>
    <xmx:puY9Z0Inax4b2IDilmE0_0KjsF1wrDAptZdVriTLHA1P5MMq9y0cAA>
    <xmx:puY9Z1GcrXiyZMCgNkukSuKbYPdQgeWZb4cCjJQlWANyX6o_Ecv7dI5Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:39:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3ecd0f78 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:38:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 14:39:32 +0100
Subject: [PATCH v3 03/27] bisect: fix leaking string in
 `handle_bad_merge_base()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-3-d67f08f45c74@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

When handling a bad merge base we print an error, which includes the set
of good revisions joined by spaces. This string is allocated, but never
freed.

Fix this memory leak. Note that the local `bad_hex` varible also looks
like a string that we should free. But in fact, `oid_to_hex()` returns
an address to a static variable even though it is declared to return a
non-constant string. The function signature is thus quite misleading and
really should be fixed, but doing so is outside of the scope of this
patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bisect.c b/bisect.c
index 9c52241050c14ecbf3f7950a0c5e7b962fcaa541..e9e603877eba059c878ff92bc11dd84553d0649e 100644
--- a/bisect.c
+++ b/bisect.c
@@ -801,6 +801,8 @@ static enum bisect_error handle_bad_merge_base(void)
 				"between %s and [%s].\n"),
 				bad_hex, term_bad, term_good, bad_hex, good_hex);
 		}
+
+		free(good_hex);
 		return BISECT_MERGE_BASE_CHECK;
 	}
 

-- 
2.47.0.274.g962d0b743d.dirty

