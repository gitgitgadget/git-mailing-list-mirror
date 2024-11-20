Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943AD1C1F26
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110014; cv=none; b=bX4sSYqWQ+ixh26P/AUIC+POOMSmLuykeeqWCPEFwVWBf9rQ8+cMYTHhn2KLnDsl3GQfefhTaLWPNMm1Vom8sDbrnkYtoHSwAY+A9fiYKJuMw8zAMTADG7ujWaXO2byLQ5jpRuAB3wyzBMB6J2fznEFjvzrRV5tNjpehWUV3hwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110014; c=relaxed/simple;
	bh=sxJ2/KNuZ1eUpOPMK8VPpycEgigaO0zaS6SSY0qxHXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MvvGlU/NuL3c2e8I4wKmgCVkQDQOH/vMrjCoN/JXiWC/L7eszwsfqbFT7gq2i1abtlvMRf1RJvYjB/tbspfV+WcvhMum0UbveYGT8YNCIkdu6GTuZ6Qp9y+Yx5/M2a5rmeZ8cZhNcOf9szv7HlOGTRXc7adTUq+5L352T1nWZ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VS5NgoZj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0cjjQ99f; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VS5NgoZj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0cjjQ99f"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E93C711401D2;
	Wed, 20 Nov 2024 08:40:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 20 Nov 2024 08:40:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732110011;
	 x=1732196411; bh=XOt0kN1VQTuuYKN6SjPk+pDJohI4/05WTkKAU6CTCXA=; b=
	VS5NgoZjCpvrYpYFAbn5Ql5+lB0QSI1drEizqZ1pETFWbSkbyMnBXCIrnlbavOov
	PJl68tw5Wlz0HlmRkZuEWzVS90f3AC9k67nf1aDhEn+xW7cyZtWHDu1U9A6jmmkQ
	QJh2IGcw1FIEmZS2VPe35as3C+evfnxzzwVt1ib6IqUuFdLA3BXKh1yOmaWEJXOl
	hQMuAFT7N7L1LX1d2tgJeX5D7mMQO/e/zly2hXZMVyYsc6AEhJl81fBoUG65TGzE
	Y77CYldSZDrUow4dCPbpF326RZzVtIMAVAITtGWZYAFc7VlJfxzRkAF/kfESyl2O
	LeyT0UntRhrQ6euYUfcT+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732110011; x=
	1732196411; bh=XOt0kN1VQTuuYKN6SjPk+pDJohI4/05WTkKAU6CTCXA=; b=0
	cjjQ99fU6B5hX0K9LEJp93I93KsG4lAO9zOnxv2MLYyhfCrOb23yTVVALKIpnVQU
	q+75EljlidwMN3Daue8h5pb+V5SU6x/ftAa823Kr9bCvKx79DRMoVYmmppkrpkKS
	mIZKhfcjKPZmx/Z3lIOPLN9TI9115CzmSyJmefxePj/z3hDTgql9M5/Ibwuaox8u
	JPqzuIpLXYy45Vn+lW5nAhN4wd1KxliTi8zmgq2fFD27bm4n945EuzjqC0aXZdl9
	dRSXOJ9zlrJL/EYgVCFaAseo7lKhCPvqLDc7GXsJkOwsnGqBkqiymv1z54iFnEAN
	ZAobwp6zxpnnO882+r+2w==
X-ME-Sender: <xms:u-Y9Z9K9SDzMVVC-IkScVA7rCjbuaqG61SFyM2wArIRveSxyC_tzmQ>
    <xme:u-Y9Z5KaEWfXW2UPvkuCYAp8uwrt5jXaUTen7JkrwyJ4hjIwvIO7slVZvxVuKN3_k
    jVsruKdoh4_7tnyPg>
X-ME-Received: <xmr:u-Y9Z1tUVsVdsQ2BPScOfyAAATLuohzbFYdWXIuYvd6gPuAz2hEfJrWMiPTU8xjoHgjusP4tg6pIDJHvdI0ic3qJdWfOHG-cBsIN_Qt7f_9qAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohht
    tghlrdgtohhmpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:u-Y9Z-YYU4in8kYJVtOSYJ_AdoBhkL_SXb_FTHiHFGFGviW2daHE4A>
    <xmx:u-Y9Z0YCDFglAyYrwoY5fZ7o8tz67jLDd0jvqj_VT8Lu6tVroyMCWg>
    <xmx:u-Y9ZyB4lpRQAjq0F8wxKIBalW0hmGA5sfMKbPSrDm0KtyoloakvOg>
    <xmx:u-Y9ZyZ3G2RIqk9YjNDECmXw_wOqEpxMVHgZ7FkukWBel2qCZgNANw>
    <xmx:u-Y9Z7WE-h2klIGjyBiIpkqybSxRsCxrnbYiFSBLitUWbfVkHtW4iwP8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:40:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0653b78a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:39:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 14:39:53 +0100
Subject: [PATCH v3 24/27] t: mark some tests as leak free
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-24-d67f08f45c74@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Both t5558 and t5601 are leak-free starting with 6dab49b9fb (bundle-uri:
plug leak in unbundle_from_file(), 2024-10-10). Mark them accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5558-clone-bundle-uri.sh | 1 +
 t/t5601-clone.sh            | 1 +
 2 files changed, 2 insertions(+)

diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 3816ed5058d90118b4cbc700d65e97aa9c9987c0..b488b505b928ab6e58258360364ba53bec704eca 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -2,6 +2,7 @@
 
 test_description='test fetching bundles with --bundle-uri'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bundle.sh
 
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index d0c18660e33113e64a293c695239a1c1a7975add..3b5285cfcf326fa02015d7a808b4312c62283487 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -5,6 +5,7 @@ test_description=clone
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 X=

-- 
2.47.0.274.g962d0b743d.dirty

