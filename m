Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028E5175D2D
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321533; cv=none; b=JQ0ijRnAZ41uoTsVavn4GmbCa0Rmz4jTQoIzuVspLMVFjnn3i7cb9ucniZ/owMuLEOEU/egQS2x1nnC2a7dCNSBggQY/YookTN7ydXhJhLjY1Kz/FRfHoftt9ShGXFDkQVUw4w97b1wTOdrGMT7DjejamvRv2/n27flutbUod3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321533; c=relaxed/simple;
	bh=W/OYrN84UwWTtzPwy5iZoS7I2DM+e7JU1WckliiE9LE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ej/rN2nZoYJ5FUQU1DNUs8unCdzB7LQ1SEvjnFrsmiRWF1v4Wu2//aFihSbQBLOL07chiz5kXQHDy5ym7ky0LFNznmBErWOKzrW1fdztB6dx1Ls+NAnMdIwlL/5rsFsGUBODEZL4TN0tMPYVnJ8rxFNUrzGZ2RtXxgWR6MZ12pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CkqXiV0I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FpcdylxX; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CkqXiV0I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FpcdylxX"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 09332114015F;
	Mon, 11 Nov 2024 05:38:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 11 Nov 2024 05:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731321531;
	 x=1731407931; bh=mwEANcnIwkVY6JDvwi75wiU/3Ay4qqaaKTielwvJ+Fo=; b=
	CkqXiV0IIEcRapHAdJiCCjpiZi0xG0uojMktQKKLjuqop8ClrhI5ZZLcfg8lmu7n
	ZGmSWIBRLXL6Ph2cKed75/19JaB4w1yH3qLHXs2IS+9/Ojdr/knrtOoC/2iOIkmz
	fbb3UsJyRGmZpCY7Rtl9buvEMDS8nGfOEgJSOtZP0sdl74b0hkdZzfAWjGMV7CwK
	uytnhkeZv0AkBxs8zG+1eYMYOrKS3nj1Lc3f1t2y2YDXhG8BiBQaxD7v0uTBOQaa
	LiGVKD6XoUYNpjLmE8jTTms8QryuQNwICkQWC5jRQSrDYqbDIqVAaJ8SlITvGIDg
	w5uPcyiEeiMQfBrI7QEYow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731321531; x=
	1731407931; bh=mwEANcnIwkVY6JDvwi75wiU/3Ay4qqaaKTielwvJ+Fo=; b=F
	pcdylxXBGG0dQsWf8lnMpWTYAKQmauofhlMGXGGkQpD3wdbeYhyfEt8gtAuNvTjP
	33hzDX9EayNQv8ln4V9SAO9qqt4VikyKOfVXpLUscBcEgXDHaz2w9eccqOs2BLwU
	pzfJMQSkK3+RGzdxapFyPyS5oGHKCGg8jjukC9ED07c7IV+Yh9XzAun/rWEfSPEd
	1jLDN/g109eltBipJXjeODbglPluGoFhHuJnJyV09739kGW6XjVvNHg304CXHHBB
	Z2HBOikbOCmy9JpEU21b+T5wkIUd4bpbLnFBrvS+QRcS80kXbtPl9v+sQ5s9ZDn0
	qiCuA2dhLE+lQWxEDHKFw==
X-ME-Sender: <xms:ut4xZ6r4gxJ91tq6WaGEJvMTUyCu0JI0D9YSY2wBCO2-glQaPZgyLA>
    <xme:ut4xZ4q4R2TwWmcQxEMlXZt1UkuBvuAdieicFIWSYun6mhEjSHuoxGas1WiodMrG6
    oF_9G6SWiNnGR_fcA>
X-ME-Received: <xmr:ut4xZ_Pm7eR_H-oYtfyyVTIAd-IS7kx9iKgiWLDq70o2Ul4w2VgoyF2RhJm1iDwg_Yg6OFnHd4xWiZTdktg1Z6YXONIhivkf6-P3aO6BNrttzNjr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ut4xZ54TsR3HJ3FrjLx3aRvLaNfwWWsP9LoSAh0Fc8qFk8U7k9lCsQ>
    <xmx:ut4xZ54S8RE-EL-dpu0kBNjlW6I0uVSiTiv1vHknTch54d6bz-MlXg>
    <xmx:ut4xZ5h97ehuSWBR7iOYZfFWGTuYdcE2LgvZ1qq_KpeFV66QGRVFfA>
    <xmx:ut4xZz6bspYCQodxmO53fTyRsO3IlDbHtuD533e4o-Z-WFc6Ok9dlQ>
    <xmx:u94xZ5GVRJpS1w7Y3F1N-L2Ubx3gRbRF94T_Ht_EFoYMO9ZCPLz0oQje>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:38:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 165d44bf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:38:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 11:38:33 +0100
Subject: [PATCH v2 04/27] bisect: fix leaking `current_bad_oid`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-b4-pks-leak-fixes-pt10-v2-4-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
X-Mailer: b4 0.14.2

When reading bisect refs we read the reference mapping to the "bad" term
into the global `current_bad_oid` variable. This is an allocated string,
but because it is global we never have to free it. This changes though
when `register_ref()` is being called multiple times, at which point
we'll overwrite the previous pointer and thus make it unreachable.

Fix this issue by freeing the previous value. This leak is exposed by
t6030, but plugging it does not make the whole test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bisect.c b/bisect.c
index e9e603877eba059c878ff92bc11dd84553d0649e..6dbc22f84fce11743f0e79eb4f8100c7ec07238f 100644
--- a/bisect.c
+++ b/bisect.c
@@ -456,6 +456,7 @@ static int register_ref(const char *refname, const char *referent UNUSED, const
 	strbuf_addstr(&good_prefix, "-");
 
 	if (!strcmp(refname, term_bad)) {
+		free(current_bad_oid);
 		current_bad_oid = xmalloc(sizeof(*current_bad_oid));
 		oidcpy(current_bad_oid, oid);
 	} else if (starts_with(refname, good_prefix.buf)) {

-- 
2.47.0.229.g8f8d6eee53.dirty

