Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327C61E00BF
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 07:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864780; cv=none; b=T8zHd5HSNJugxnXIQPIxCRctE3+bFse1RhkD1Gxup2eoBvGbWyBkulVvJClW9eWvzHCTfv8Pj6Z2p744cA8BVeu1+SLmClIG7TfdRmNmG1PDd5S5v62FQXzX+xr29q/x/Oyc/bVPFJai6UbdqoWqGMGUqTRza2Nhi8H5BsK13gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864780; c=relaxed/simple;
	bh=gTMLGybaWvWQ3pjOoPFj17/B1oRBi0cH6+jroQcy/MQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bVjh5uzclXp9A3DtAIIDUO29I0V796Pq+xt3nJK8ZDCl6W3J0MMuBVaARGi0/9E06/etkulI+eS+hwKkNcRH4dVbOe6svEUKQN6g8He8CDov8klTsHY9UQTqFYvZQFAv41cugER50GpqRfTV8oslm/IbTidsPqWKEXT2dyAu6vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lk84aT4Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=reJ2IAMQ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lk84aT4Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="reJ2IAMQ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 164BD1380A36;
	Tue, 18 Feb 2025 02:46:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 18 Feb 2025 02:46:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739864776;
	 x=1739951176; bh=6XDfuQyq6DMaf4dtdjQtc0eJ6cYncOUgpzOlNcQDWXg=; b=
	lk84aT4Q7bMJzgLqqtbhovz6K1xe9L6g4JVcLuv7pxuD5WMEjmCadF6VG+oTDCKJ
	l62vDGcx12CA9U+oiRWY+VLT41T/2dM7Dr1mM4uVJCpOtjoDJUm0oYO96zvvqJBK
	nk2u6AoCrd2FfaWW7ogLgkzR/+QPhiKzRmXbdv1qhprvyffMGyS8sYNxdSF7wRUp
	zQLpBD7f/fpdD0nFs4XobETntBh8WZYYtGuprU36XzmPSnco9IkSIBnHZ6wEf0av
	kVqz3nsepcSNIPnt9/DY4kXLOCNJYio+G+J5p8nW3c4OObu/mI/25q9JnyjDh20R
	0MLJzaakMwmbGfcEpvtxxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739864776; x=
	1739951176; bh=6XDfuQyq6DMaf4dtdjQtc0eJ6cYncOUgpzOlNcQDWXg=; b=r
	eJ2IAMQJdmoADNZbLouV174sB8y7dN3FkLKVfy8+2was5bm0LarVrmIOqU7wjqsY
	hkqUFfwr9kZWag/ii5JmvCPq2z2dLLo+Pf1lNRBWuSjls1VSvYSCliqSnVzMUA7i
	fj01xNHTsiLcsjGvDcBJg2QbyzAI2Gkp4x0SlLhREoaNt6ej4lgsTqzRpynj/dXD
	HziS/2vU1SnREhsK0RJ9EWqoWfsy8rxqzymS0sFGA/BUISOcSE+19tuXNzxPAF3h
	xDE+pu7Pgs6aLj5zU2+DjbEe3tM6JKJ+rL9l3Tjy0cGwcW3np0nbp6ACxQZp6z85
	zCjuGJUIylzeAMdPRybxA==
X-ME-Sender: <xms:xzq0ZwADaj2BO7Ni83tPcZMREz63qkn0Lw7EzuHW91c2U25l6hMmgA>
    <xme:xzq0Zyhjy3DiK3hqpT89xgV15igHmIrBKhZJDKwjzjBF9r9fhfEMmU3-Lm6-Xu8dO
    Czw61vEPVv7SG80vA>
X-ME-Received: <xmr:xzq0ZzmA79Fyh15aAU7Mn7DolDi77J-74eVCX4x1Gg63tzCADV-vikbRGMDYp89EccBk4w0234E0odj-MCVZ0og_BOS7wgDtkDLl6HnDttrEakXd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhrugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:xzq0Z2w6nHfNe02nxifP0A7_FDL2ZclYkPrYGCb0Aady2onyNM_WWg>
    <xmx:xzq0Z1Ss1Ql0SrCgKGN7nmJ49RxoI8pKSBxtrBx2Kk9nDcmOxYmRpw>
    <xmx:xzq0ZxZ0JF8mkPObZG9p7UP1OuHLmaSlnVHa10m6HGpbsc7tTN8qXw>
    <xmx:xzq0Z-TCts2gNaAmFQ_gV_5G31OTrFbERJsZVYMT3tNy28fQTgaFww>
    <xmx:yDq0Zwdwgsugay_J34DxJwNIdGxesqq6_xMLNm_V0KBrQsJxYRrBfXYk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 02:46:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ef7e8f2e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 07:46:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 08:45:59 +0100
Subject: [PATCH 11/12] ci: fix propagating UTF-8 test locale in musl-based
 Meson job
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-b4-pks-meson-contrib-v1-11-c3edd292beb8@pks.im>
References: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
In-Reply-To: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>
X-Mailer: b4 0.14.2

The musl-based Meson job is supposed to explicitly specify the UTF-8
locale used for testing, which has been introduced with 84bb5eeace7 (ci:
switch linux-musl to use Meson, 2025-01-28). That commit had two issues
though:

  - We continue to refer to "linux-musl", even though the job has been
    renamed in the same commit to "linux-musl-meson".

  - We use the wrong option name to specify the locale. This was not
    noticed though due to the first issue.

Fix both of these issues by fixing both the job and option naems.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 028fea0e7b5..84d11452650 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -348,8 +348,8 @@ case "$jobname" in
 linux32)
 	CC=gcc
 	;;
-linux-musl)
-	MESONFLAGS="$MESONFLAGS -DGIT_TEST_UTF8_LOCALE=C.UTF-8"
+linux-musl-meson)
+	MESONFLAGS="$MESONFLAGS -Dtest_utf8_locale=C.UTF-8"
 	;;
 linux-leaks|linux-reftable-leaks)
 	export SANITIZE=leak

-- 
2.48.1.666.gff9fcf71b7.dirty

