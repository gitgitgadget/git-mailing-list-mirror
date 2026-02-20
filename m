Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A1633B6C5
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 10:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582535; cv=none; b=FOarDvkVLvMHTATrmTQJzWEmFDDhraIgUHgUnqik/MPibgsOfDjEPl0aRLw4SylHvjVN2yoplPcS7ytZ40sDTfvj5WrvQajjxXmBK3MCo+2CQLQksb5wiUUhAswxugZ4/OUi+Axbbh0kRZvRS6orCjWBnNae7T20p2YJhp69qbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582535; c=relaxed/simple;
	bh=HdocN2Aw5T4VjmTQ7N4Ell2+n0trMgwOnLfMauLWGj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dqPe14C0LQnah1YyJz0nlHpvY3mUAwt+/PtL64R3qcxh6yeSKRZolk/KHrolYET3Z8Pbx0mpqxmWsy/TugoaFQ7jLCRqpmlQEOgT3fTXgGdGVcWVBibmUeyt5QUg8mBOv3tLcngKgJ6V5gwsgee+9qonlL6pDtjBHxQh2uQ2UFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iC09dXAl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pQcsWoG+; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iC09dXAl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pQcsWoG+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D67027A01A0;
	Fri, 20 Feb 2026 05:15:32 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 20 Feb 2026 05:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771582532;
	 x=1771668932; bh=pIuDghb7OW7UrURXYSGLjDK6BDgMu3k7Ewx47H/HC6k=; b=
	iC09dXAlDTdSArZskLZfwHbtScHZk0ylT4vBHINA4RFbc5uqKXvvclCMVdb8FzJT
	lddbwESNMag18aQLYV6iVUNBM6uzDWB+bSR5ZLVuOcpWtFaGdC1/LmzmzntJ5wU2
	Y1KGr/iJDnnAlyqIQEn1vCMdEWJZrwNFLHX32/itXAoDo+kksc/W/qaZbhoc/Rel
	rh2M4qX2QG7qNPB3nDcp1qJPmX7GmWvWDrnSif92G4RgsP2hBAKkDE+qhZ5i+9dW
	KCJYzwXXuNs6T707GCTw2Q2/mGRNVFmSgSHpTOUAX9lkYlaCH999Szv6Ya6cgkoe
	7lFhmRQqhi4M9AWCcAmN2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771582532; x=
	1771668932; bh=pIuDghb7OW7UrURXYSGLjDK6BDgMu3k7Ewx47H/HC6k=; b=p
	QcsWoG+1MN6+NUqvfUO0eIX46x60xpZnDbdTMe7lG6zJ/aMskJ7jy79jRJ50jvuD
	yochaoB1sOIttbQBTRp1O4tJ0xYOJ1CNwg/YIn4bynbAPan81V3qQTI2RX9VaxLn
	xMkkZXZQ2ScrafxlOLDaTcoAM0ix+Fxwf+f8Zp/RfKp0iSQDYExngWguZnWG3shz
	cLnXTbfpn2oe6tZio+1iVfX61aNatScFsdNZKE7PKrFpDTYwEYsxtBSqiDVZLrbN
	qxIGuhZNKpCfJSDP1auDIIDGluIpxKXKeusSuxP29lVQnSiOv+EjUDE1jo+/VD02
	7ZsCY4dEh8YFOi9HAyRJw==
X-ME-Sender: <xms:RDSYaYG1Aq2m-Sp6sK7VK_GvfPYlZGHKKZLUD8ge-mu14E5WQX9Plw>
    <xme:RDSYaYwl9_ssERFkxs2Y7ZDIJgAFesaWLr323-iItgHkYrsqugOUMi9jp-oR-QGhQ
    XGXX6hg7k9b3IOqKxCkr54tvpQGXHB67OstBsHdzJPsegFba78nH60>
X-ME-Received: <xmr:RDSYafjMhI1KHGO3jEFe6rLKHT8wuisI6FJ83OBjfW0pzWaMpxj07l2fA3Ebn2j5PUk-Bot05EWCyuW4Dd1lgc7ooE_2E4exon7j7s1u2OBi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvg
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:RDSYaTyZHH-2VrTk1akjOAC2N-nMTsPva68UfNSSp90tc1up4rxz1w>
    <xmx:RDSYaSKiioZe-NVF2c2vxqoF3oI9XixlG7EbLbgZplU_30FNx7f8Ng>
    <xmx:RDSYaaQVm9Q_KTIAY1lTR4x3Qgf2Qt4L4rkKeA98vXufaiI0UK1O0w>
    <xmx:RDSYaaqYfHR63uzVvJvNwwc3lKH4r59bNTGOTj4LLPrHLIQN-HeFCA>
    <xmx:RDSYaRPiN_BURBZi3a2NQiE-tvjcmnuPlWfVJPqZ5yrcZlWj3M4H0J8I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 05:15:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 491e6e33 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 10:15:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 11:15:08 +0100
Subject: [PATCH 4/8] t5400: explicitly use "gc" strategy
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-4-faeb321ad13b@pks.im>
References: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
In-Reply-To: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

In t5400 we verify that git-receive-pack(1) runs automated repository
maintenance in the remote repository. The check is performed indirectly
by observing an effect that git-gc(1) would have, namely to prune a
temporary object from the object database. In a subsequent commit we're
about to switch to the "geometric" strategy by default though, and here
we stop observing that effect.

Adapt the test to explicitly use the "gc" strategy to prepare for that
upcoming change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5400-send-pack.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 83b42ff073..b32a0a6aa7 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -187,6 +187,7 @@ test_expect_success 'receive-pack runs auto-gc in remote repo' '
 		cd child &&
 		git config gc.autopacklimit 1 &&
 		git config gc.autodetach false &&
+		git config maintenance.strategy gc &&
 		git branch test_auto_gc &&
 		# And create a file that follows the temporary object naming
 		# convention for the auto-gc to remove

-- 
2.53.0.414.gf7e9f6c205.dirty

