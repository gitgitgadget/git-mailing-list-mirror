Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAED21BD513
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110010; cv=none; b=AOzkegt/IHe0ZF5YjhWpZJmDVMzq4CJjcfrCFNIrAbTtPM5ivWL1J/IkURmuyMDqjJYjqjWtF8Yk7Rm4Ift96nu7O7ZG/U281/WanM3nkEUAKwO2GsxL00YolMab1Gi2iyTqKuHbAqMeFCiobPdICQN/1MEokEG07Q30mlqpAyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110010; c=relaxed/simple;
	bh=qpH2jlB/SyuV/g40kwvr6WnItqLcwPHPx3jy2ptrqzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s7gEw/Mob20F2rkTMGnhRxsSbGsNL8ubXSNVbzEnwfuCHn6JsafNz2NmFKYY9GSWjuvGxmhKNrBKDsJe5n1+GD51dCA9IRv2wStsNYR5oPaz+8sCHG2NPYLAZhRcUmw/N+vomHf+4+SLlPaiopBIIkv8Zh0ipR7WVXjwDrUnHYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Nk3oA6tY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5W/97ssn; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Nk3oA6tY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5W/97ssn"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4892611401EA;
	Wed, 20 Nov 2024 08:40:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 20 Nov 2024 08:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732110008;
	 x=1732196408; bh=/4q7UFzDo38aVGCZ5ULe7u2AOIGDFIwzQkcp6LhIp7A=; b=
	Nk3oA6tY9aAgRxWBnpS/FxGSDmb/ZvtzHdnr+/KirHvu9PoJkeoloa9LFXvnghAy
	wEpsV+5cS9/kk95eOnHLfDtxkCl4H6UoaXQdt5UoMyAammlSvES+Pi0R7yxjGSci
	aFgu5QdMpjyIcYhSdVAv05JVwdMzSnNMBk4cLxZM/osdKw3ICphAklSdUfVyDm9c
	eX8CNCOAmvHuIuymN3VOytJZ0P+msH2HD1UnGXSM8+gd1Zc1c+z0ec4szC6rMyuv
	i8IXlya41gPB7E6DvmzB0+j/hYH81CQaGch16T5kpEZbRT58yr9XK9g+wFQJRT6q
	xwAmkIL1G3cp84OgEgpw+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732110008; x=
	1732196408; bh=/4q7UFzDo38aVGCZ5ULe7u2AOIGDFIwzQkcp6LhIp7A=; b=5
	W/97ssnairkLxLn/pEY82aTjl0K4yUEZufhCwLAbguMj3ygf4qmYJA+FkOlCRmse
	UgThfIHxhdIdK0aFyxMrGd/uRwoWiTDJrQGGa1ddqbuXjkXbOqgeYigkIVmMpzbV
	qrKhvHUY74QPWhQV5ayM6dgTwQk7BNL8PrPLvcrFbX2Bgw2OSs5QNq8OIFNGD3hs
	53R98+R1V91jfw1fz4ixcxz9OZNoUZOI2FlPrKzplNV6jUGm7qQzdBcV47iUX/e2
	2dUUFrLlgSRXsQfDbGYSLN8YF2b4iyaTtac1MYFnZghMRLL6yeiCaA338O1zPuOo
	x+H/OkSyEM9gMVTsk8EVw==
X-ME-Sender: <xms:uOY9Zw77TDGjnhby32pOLfvxl0KtNnvMtliqNe0OrAdBp-NS0OMzwQ>
    <xme:uOY9Zx6VMwSL5kVO3re4J1Fkss1GW0hcFuwCwH-98-w-mPuk0n7NWuo_LgQqK096T
    lJH40z8lBwfaQulDw>
X-ME-Received: <xmr:uOY9Z_fJ95Qh_d5C-PDYVMLV0zG8tXAhuUjy1LNFAB_IKh8sN2E_Qaj0P-1mO0i6CvosYKeRY1jGniJCkpbXkGTgpyTmquBQDz44NGuZUKFNqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhjuhhsthhosehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:uOY9Z1JUjLNwPcjnsVnmjGwWBSnRAgaH4r2NuCvvYuG2r8gwlom_0g>
    <xmx:uOY9Z0JXXZrtI9F_3-m2ZZyiMr3HrqgXdGiuBEuBrYpKvQkkLudBIw>
    <xmx:uOY9Z2wP4sM8gsUBFA6qHPYPCQmQv8sZHWVpqd25Rp_-V0Y2D6Zl5Q>
    <xmx:uOY9Z4IqSdMUERTTamc-J_vAbxGoAEjdgMLt2Za8cp6q-19ZOV0kEw>
    <xmx:uOY9Z5HHkOW4cOSw60U49jMKWPyoIxeVI5dIykY209xJKSmzIAtlEJl9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:40:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 078e16f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:39:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 14:39:49 +0100
Subject: [PATCH v3 20/27] t/helper: fix leaking commit graph in
 "read-graph" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-20-d67f08f45c74@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

We're leaking the commit-graph in the "test-helper read-graph"
subcommand, but as the leak is annotated with `UNLEAK()` the leak
sanitizer doesn't complain.

Fix the leak by calling `free_commit_graph()`. Besides getting rid of
the `UNLEAK()` annotation, it also increases code coverage because we
properly release resources as Git would do it, as well.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-read-graph.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 9018c9f54122833eaf9dde52ced06e354e1919ef..811dde1cb3c8809352f79428a589c2158fc62545 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -97,7 +97,6 @@ int cmd__read_graph(int argc, const char **argv)
 	}
 
 done:
-	UNLEAK(graph);
-
+	free_commit_graph(graph);
 	return ret;
 }

-- 
2.47.0.274.g962d0b743d.dirty

