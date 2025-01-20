Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB711E9B3D
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737389854; cv=none; b=OxwGNOXNd6HZs0GA57snVAqS93z+vOYB7xFUy+FYXbww3h3fo6cAhqgLKah4mb2M6a+N4s7WN8vM+cBPpO9KlHHIDRVErrjSpHN0RxIfUR8I1HzJXWx1dxpmOwmYcUQ5hFXaCgGTQaDS0Z/OAyeMiQs4WcAR7i3MFFfKWE1vnfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737389854; c=relaxed/simple;
	bh=6tvhN6EcJgITAjChpiuF7TVBt5Fr+ayJ+qqaWOlQjXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dY1dzPh80KibOEi9zME3KrWAFvFJ8xY30QOe8VU45V05UqECu0m4alD/A/Imts1GFVyOSTuptGMhM+/PEMrkfv5SmH2VhkemycYOA65zt8Gdx0mLvfKWEhFyLRV1eXu8PU+FWb3QLzYvUm+RytPyQY56+hG9LrV3rVSUdQJMLpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OMxO2EJq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VRHX6ApG; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OMxO2EJq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VRHX6ApG"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 3A0B113808D1;
	Mon, 20 Jan 2025 11:17:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 20 Jan 2025 11:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737389852;
	 x=1737476252; bh=T2SLHxlQijOEtbTTMYIgVBEVuxkdCkkIuy/Uf0jnA+s=; b=
	OMxO2EJqkQizopIzJzosOb+XxzXo2TBw9DGfbvyUG00vuLx25v5mXNf5/4nKdlXV
	Obl2TJ89S4LefBa2m3VTmGS1N+Vbv9AvrfW/j+3/vO6GuBv5kqEXaibeYL6+y5Hr
	ghRcqtB91giMd6vq7ZGMTjn2XafqeaTU4fZeZeloua311sGlH+euacB4DC9wVeNa
	gPi4gcOsxl1VArUntGxSblU0m3z3XA/xXC1v+hRpfAUhum5NyytChN0rSWOn7RrJ
	9iIhqyqSoSaOJf/2p55+dRD7aSr7uotMgOGQ6FlW4RiENCRs/xCSZ9IpxUKfS/Au
	s7xaGXD6q38Hlf8VbYNhJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737389852; x=
	1737476252; bh=T2SLHxlQijOEtbTTMYIgVBEVuxkdCkkIuy/Uf0jnA+s=; b=V
	RHX6ApG0tgvar6jPulAZDLbLYpMN5+Xyq0zPZadpK8AMwXRYJPEn+uZX+ily78ko
	c2XIGHIC4Bu9zZgNg8deidTfIPoI2M+KXZWuSK4Rs6ejOhzFHoxXOtNdxfWxi6Rs
	cNsSNAJhp4pQF6Rgal9Wosrg2p0bEeihf9r/WVsSdHTcFcrCNDqpVvf/FkUQ7hwM
	XvKdN7smmyHVSpwAqgp60NYisMDpZK9AkySTywY53wlGQW3X7vm7obbPWCj996Z3
	XLBu90vHI4mTGmRHueGGQuRN+56MfabopGxXL/xfFKGFjPIvQ9IKEHqloF2jxcro
	5FZKV6XRX0S5wHNmYcDMg==
X-ME-Sender: <xms:HHeOZ2voRzJRuL0qCgtxEFRKF4yvCrxMYUMi_YrkuH1Hq31NfUEhxg>
    <xme:HHeOZ7czCFjmACHKQkS43ebTClT9NWzYhx--Q4Hd43UBnZtntg1BEmUe8njcWylEb
    GrrM9a455VCNs9yGw>
X-ME-Received: <xmr:HHeOZxzHCDD4yXVe-09zG2cY0gs0F3KxGO7buJOPFlBS4iqsnb8Gi9aS_9J-hnOFzTzhWncDJT8vYaQKHBZ3xWMUfh7EzGDT9nhhaMh2GRviCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiledgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:HHeOZxNbU3FRRpZJUFA-TEPjDMognOKl8E1VUH82zELpaBD62DTTwQ>
    <xmx:HHeOZ2-dGNBSNH4za-gAoowSHckZ55uJ4yhANb2WZKm9fFseKcngCA>
    <xmx:HHeOZ5VeJ524fVNdmMPu2FKBVtm8smQXmyCZXdizoIJlrQBQdVJvVg>
    <xmx:HHeOZ_e0tiLbuBTKwIfAqa2di6AObfM5y7XPJ6odH1VmtHExof-YhA>
    <xmx:HHeOZ4JJyouunHS_MnIxcHC0BSSP5nlbvGdBiCtoOHhs60H-d3WvzmHK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 11:17:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1769634c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Jan 2025 16:17:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Jan 2025 17:17:26 +0100
Subject: [PATCH v2 08/10] reftable/blocksource: adjust type of the block
 length
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-b4-pks-reftable-sign-compare-v2-8-b4566d02e4a5@pks.im>
References: <20250120-b4-pks-reftable-sign-compare-v2-0-b4566d02e4a5@pks.im>
In-Reply-To: <20250120-b4-pks-reftable-sign-compare-v2-0-b4566d02e4a5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

The block length is used to track the number of bytes available in a
specific block. As such, it is never set to a negative value, but is
still represented by a signed integer.

Adjust the type of the variable to be `size_t`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reftable-blocksource.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/reftable-blocksource.h b/reftable/reftable-blocksource.h
index 5aa3990a57..f06ad52e0a 100644
--- a/reftable/reftable-blocksource.h
+++ b/reftable/reftable-blocksource.h
@@ -22,7 +22,7 @@ struct reftable_block_source {
  * so it can return itself into the pool. */
 struct reftable_block {
 	uint8_t *data;
-	int len;
+	size_t len;
 	struct reftable_block_source source;
 };
 

-- 
2.48.0.257.gd3603152ad.dirty

