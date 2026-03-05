Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13E2384256
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709635; cv=none; b=sh6Nmr6mS0qMsJz64kBqnmHoTe1UNlZ2t6nWtRb76K14cxXIn3cIpQjwy85Ku/fhyf1ekogL+A6fEo8P0A9ixHQEhkza2+NVyQDXwnvlqRbQx5X3ayQ0sL7puqEtDjwUJbN4QBLAsxFSBJ8w1yxuiriLIDircPKwnP3lfZOEtYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709635; c=relaxed/simple;
	bh=3Qkhz8aBg/pdO0FMCwEdBbyLpDEuDgHY3goqBheGenc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fjmYxOmm5qHQAFYzkdqN3biNIjpU+QvwZ14uiLyAvMpR45fcI84K/Reds2VTCywEdsLmk4eJUd/Ln3Vm4NoKytnA5BOQA2CsZbzHrfhGhMmfa9lJdBlBFMsTlqPVu36jHE5Msf8oCunfLKXFcdRPpWIQqF6vQebBpg9AwjJyxMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D+UrYqmb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YsZrkUeR; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D+UrYqmb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YsZrkUeR"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 3B74C1D00291
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 06:20:34 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 05 Mar 2026 06:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772709634;
	 x=1772796034; bh=h2PA/gNIROsoKj0ZyBKzXlazISokpuWZR2TJ90aPzY4=; b=
	D+UrYqmb3XZR/w3Nz2B6ApKv7l9YG5JE0mWppgpMggm2ueYy30vG04Jjlm6bOFEN
	pN92ne1u1KaMzTUupMAphbgfKPqUOC+nmCWs8RTl34NtoNPZKxB59FC7B1AOSxAS
	detP/JbXqG3xsNS/BjMQY/p+BG0EhYoHd7jwjvm1Y4/B3gntM7aGFV1ukuc6bgyz
	l3BR6jiHIxrjY6h5oIXGtvUFYqmUwc7SzPXovpSPMuQ/evHmiXNWYwBpqFr/c+Dp
	EKEqjDMWZ5vZcGPpLA4fGS5EBQGOqXAtiDoG3NBY/UCX5Fi1uGsgMwFtmwT7Pq7C
	PY7IyAwvUq9Kf765VDTgFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772709634; x=
	1772796034; bh=h2PA/gNIROsoKj0ZyBKzXlazISokpuWZR2TJ90aPzY4=; b=Y
	sZrkUeRokqGWyD6Hf08wIrwyWYBg9/Zg0Lh8wMKpQwtkKxThWQc+a158HhtfV043
	kl2FR9RiZ47pif6h5gu7RanomQlUTRG7bM3xDhn/SXqUXJpDomp2yRqkoHRHwmWy
	AIVBffVdY249WMJcHMQ517IDKt/h9pFy/YV4bZ1r9qzGR5z3deFCpaZ4oQI5wmsc
	1vBtonWKcX9fCcQrSNXN1PDR3udMsI9YC2i7+9MdfpaUgXxf8uPc7z6ZvxDWgIDV
	DXB47dSvWZp5eVDOXTtspnm2on911mYHgp38MP35wCiyBcAAfsxB9CX1aORR/Lq+
	rxH1CBetgql1rXda4ei9A==
X-ME-Sender: <xms:AmepaV2r1rYW5DZelHRZhfoi4LQQ8ZoktUXrDcYw1NS_vEnrt-MW5g>
    <xme:AmepaTCZuP3Nl3ZqMOnBL-jvbE95zh1z3EiXQaZS9kyrGcLzRYlb2ohzp11RcwewS
    2XJv8vLmx_7sl41f0FdaLH0JIdfx_5tUGXnaeA34y0aYoa9Q47c1g>
X-ME-Received: <xmr:AmepabjEnDWBTUfa98KnBBL_d6Sivv8L-EJBEM7JQNZFihMby0q2UqGjEAaQfSqUJaWxAM3yp8OqsW5fTqGW5aNsIR9wuGYXUmk0FDORkAJO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeivdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:AmepaX-Tkv6bqZqJ1nQIghvShTuEXOIYnTzUvc05veJfzlsJCfl9Kg>
    <xmx:AmepaX_cJdH5OT82GUaFhTG1wzsLtTkiNZw32j3AqeOBEipf43e6cw>
    <xmx:AmepaQDp9zkJekXU_VjP4_6wFzvIyLl2ulklorTnPvzkZmlX15ZSOQ>
    <xmx:AmepaXw-40TRMig8i582KY7VP7JeHIuRJwiLvW1mnmdbJqFcNc6z4g>
    <xmx:AmepabHA3p9yhkFTMjAflTUgikD7-lWRtfo3Yebmzn-wzJmBgOv4Ms-r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 5 Mar 2026 06:20:33 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5d4540e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 5 Mar 2026 11:20:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Mar 2026 12:20:23 +0100
Subject: [PATCH 3/3] gitlab-ci: update to macOS 15 images
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-pks-gitlab-ci-macos-16-v1-3-ce8da0ff29c2@pks.im>
References: <20260305-pks-gitlab-ci-macos-16-v1-0-ce8da0ff29c2@pks.im>
In-Reply-To: <20260305-pks-gitlab-ci-macos-16-v1-0-ce8da0ff29c2@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The macos-14-xcode-15 images for GitLab's macOS runners have been
deprecated. Update to macOS 15, which is our current stable version.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 71b8a6e642..83ec786c5a 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -101,13 +101,13 @@ test:osx:
   parallel:
     matrix:
       - jobname: osx-clang
-        image: macos-14-xcode-15
+        image: macos-15-xcode-16
         CC: clang
       - jobname: osx-reftable
-        image: macos-14-xcode-15
+        image: macos-15-xcode-16
         CC: clang
       - jobname: osx-meson
-        image: macos-14-xcode-15
+        image: macos-15-xcode-16
         CC: clang
   artifacts:
     paths:

-- 
2.53.0.797.g7842e34a66.dirty

