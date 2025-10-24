Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977A130C62D
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299515; cv=none; b=arD+n7i0sGdUIGDaxvnfm5o4Qr+LEzDFpP4m/Uj5mmAwCH81brBgybrUY3PxvMqtiMn3ZKwOP5B5UAozhoqiriHUiNERXFiRY8cj5IhaKzNpwwloNGzEVD2BLrVYfWhxoMSJEmDuJfXgA3emILfy6Bdd1xmu3g0HZs5XahmGmuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299515; c=relaxed/simple;
	bh=u9PqAy+K/5LIvdjJ5p7F7dVI4P8A3CvO1xsOvgCUK8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sk2uyXPVQn1egslNO5zfYVyYK1I8zL60y/nu4bU9ABsJpMUXmZrLGw2aeOs96ua6A/LPAfHkCMs4aIr1yf1jhcrE1raRZu3vj57y4RHS9kwlCiaMPWWfXNiFKaJWHwdiD8p62z7VDF9+wxpnzk0UAkXlXaZFTwiQKCdMxpsHocY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=joYboEG0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ptUafend; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="joYboEG0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ptUafend"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 617B814001E5;
	Fri, 24 Oct 2025 05:51:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 24 Oct 2025 05:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761299512;
	 x=1761385912; bh=oFzk2iqmFnK/yQzjfPwOkdtvYV2qfT9IwEH4YMUl6dQ=; b=
	joYboEG0cS9YL0ElkwmMN3BWxMcFtTHmCshmSfZSeT9iacwfNZxox+BD2aA4IGC+
	1vwdMoRuXNVruNhS8lNhwpnamwnMthJzp4C56vQBJPZL2FXINhCICZofcgkRb4aI
	B/pvBaNa3rY0P893UH4e76FtFwf7My1JFvu0CHHmFR4U81oWaE6rIxZ3p7YZqRjN
	U6+5NdBJvbku39+Oaa/zRPEtWl64q2xM1mDOL4V5dMoAl5tIrtIexaTbVGyQpywS
	Eu63mqTTJzpTjplrkzC6rq1h0WWUIEmfjEXwSQCI6DZNwPVRZ+zuH2GocOmWIyCL
	lKUvENnCtz7blld6YOGycg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761299512; x=
	1761385912; bh=oFzk2iqmFnK/yQzjfPwOkdtvYV2qfT9IwEH4YMUl6dQ=; b=p
	tUafendWc5fbf1NeBIA/+pH4XS4caueyaN8QdBy1x2d1fd3Nr9w3i69uyI/+9ilQ
	LfXks2dXWKPP2QY+Whn77+3ua8XRHMNk5wFbYIIx8ovqAPTtGt5h8afw9BziCbFO
	rprAoHFdy3NHhL7zuPccKFrjAKN60u8Q7ohKzNdBhWFhw45DT55Kl4OAqkCnqoeO
	Kvcm42dQPbudIDZ6Dl6Jiut+L8lRILGbB+1j+HXJ8N8G2Gz4vbZWnH4ZaR/0XD8I
	NOYFruRxuOD6PvX1es9jiWX01R/MIXdefZExhMoJngtHk8dPqu3tXpHifsGDlZ15
	b2CIE+WTaisCYL8gj4J0g==
X-ME-Sender: <xms:OEz7aNo7irO6VDAMn3sZYTIgu-443V8xbhA-EqBaP5rAVIkFPnzvWg>
    <xme:OEz7aGoYyD-SwzdpmfRYK2dEVsHahENhEF2nlJ725Px3z15gG-rS4hzHLUosNXMLT
    QoKrvTCM7WvaYA3CGqf1LZpDK8S4GA52alhVGxkkuIFivBbOk42>
X-ME-Received: <xmr:OEz7aPOuw8mZcgq6oFf09nwklskBsmDGU0jOobPIXc_KYF016it0G-0Lr316jbNa7saQOcyB57dBF042UztcJNgFB_wJsdXdfTF_SNU8FA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:OEz7aHzdo5Lmq1FFl_WuxEywizqsGxJrTQ8eELz7MIoTWG3lZDxB8g>
    <xmx:OEz7aIvrUwywSotRleVWChIrlLP91bqCiWhyfEt9Nm8nv5cfNJvuaQ>
    <xmx:OEz7aA56FKIhx1hYh3v7xt0IezcM_rGo4MEn0ix8CMgKZ4fHeJ_4oA>
    <xmx:OEz7aHSfM5ksDjOH6LdeCjSPPWDkyxK0_s3doA1I76yQ1ZsPW-HjEA>
    <xmx:OEz7aFdvrQvkOQpwIvP0Pzo4D6X_A5b6_96a74gdK5uUJc1IEN1OYw7U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 05:51:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 02effb83 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 24 Oct 2025 09:51:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 11:51:33 +0200
Subject: [PATCH v2 1/5] gitlab-ci: reorder Linux job matrix to match
 GitHub's order
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-b4-pks-rust-cbindgen-v2-1-4b4bd4f18490@pks.im>
References: <20251024-b4-pks-rust-cbindgen-v2-0-4b4bd4f18490@pks.im>
In-Reply-To: <20251024-b4-pks-rust-cbindgen-v2-0-4b4bd4f18490@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Ezekiel Newren <ezekielnewren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

We have mostly the exact same CI configuration as GitHub has for our
Linux jobs. It's harder than necessary though to compare them with one
another as the ordering is different between both.

Reorder the job matrix in GitLab CI to match GitHub's order.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b419a84e2c..1dbf236b2c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -42,15 +42,15 @@ test:linux:
       - jobname: linux-reftable
         image: ubuntu:rolling
         CC: clang
+      - jobname: linux-TEST-vars
+        image: ubuntu:20.04
+        CC: gcc
+        CC_PACKAGE: gcc-8
       - jobname: linux-breaking-changes
         image: ubuntu:20.04
         CC: gcc
       - jobname: fedora-breaking-changes-meson
         image: fedora:latest
-      - jobname: linux-TEST-vars
-        image: ubuntu:20.04
-        CC: gcc
-        CC_PACKAGE: gcc-8
       - jobname: linux-leaks
         image: ubuntu:rolling
         CC: gcc
@@ -60,13 +60,13 @@ test:linux:
       - jobname: linux-asan-ubsan
         image: ubuntu:rolling
         CC: clang
+      - jobname: linux-meson
+        image: ubuntu:rolling
+        CC: gcc
       - jobname: linux-musl-meson
         image: alpine:latest
       - jobname: linux32
         image: i386/ubuntu:20.04
-      - jobname: linux-meson
-        image: ubuntu:rolling
-        CC: gcc
   artifacts:
     paths:
       - t/failed-test-artifacts

-- 
2.51.1.930.gacf6e81ea2.dirty

