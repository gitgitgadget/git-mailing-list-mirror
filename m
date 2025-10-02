Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE7530E842
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759403101; cv=none; b=qxQC5y0e+0l4xdCd4dbW9fxL6ks8LR8ELYyS5wORnY4jJDxx4zOoQ1Z5EiDxEwywGEAuiaF2ILX/SPWw04UF3n/cY0AEoMnC2XonqZ277rh9dou3v/Ws0cdOLQSgUMcodZNDq5TFCav02oNriLZ99U/kDdMEJWqZONxKf+iX1To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759403101; c=relaxed/simple;
	bh=f6qsfk+Ymy2LNTyF5LyR+4O/VKvVdNweh9i+Z9iE008=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F/AOoLpQY6dRGoKjgEkUlRZJYyI6yKrWTExWHSRlBdL6F/UgyTk2wWfc3gFtIlGFUNu5GtZd4FTJ2pMobx46Y29x/PCKIeJm9pLiItUrXtixAhA7juGd/E0ScxJs3Khu/nH50Uv0elzbHtBEcFt5OHRHI284NfjZhPiybjIrfzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GHvhGH95; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xz8U6QXq; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GHvhGH95";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xz8U6QXq"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B28147A0867;
	Thu,  2 Oct 2025 07:04:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 02 Oct 2025 07:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759403098;
	 x=1759489498; bh=d3PR5hODBk7k80scpoMEQNl7Cw+QrFBiDlyOCNTSZn4=; b=
	GHvhGH95pipxOGOcgGg1AGw8visJDB7ZZoee5YB+kxGr7oKtXUscbeXJ9RitEv17
	MKV6cGp2vk/dOVr0fHKa/EUP0yR37woEYNApckjpQYHaEhDxsYqRfv0SeKe5jyyl
	wHHdRP+W13OolYH0hN1T2fWB72/RoUXhG2YkB4Ud5plag686WiZN/02muCPmMy8X
	02IT+FqV4Hb22OiMx5tdVFgcqc52sfqVWz1CNWioOL+PzSm2aCWLd9HP6UTXyJXo
	uA6C2A4wbtF6gzOY89CcfNqFkV+TDPQCxhiC3rhLNV7qIo7UbZphzLf7NlbxQkGU
	XlOHlTOIKxBf4JYhF5SBQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759403098; x=
	1759489498; bh=d3PR5hODBk7k80scpoMEQNl7Cw+QrFBiDlyOCNTSZn4=; b=x
	z8U6QXq7o82yPsqe9nFTPgP3i4CIzfRi7jplSeKItAqvz8qYXtgqlba9Y+SQiBYz
	x8N2+HI9asP6ONGSnPv+AC1JHjaJdaRMrDUPcRH+CIL8YDJBFVPMRTGkeDlEQlRR
	GEPllZHG/eDWQGPN5nHbNGqtlMInP8GvHq1VaZ3q65cRO9TEnGQwbwuB4gIPwild
	ZimB/vcc+NcMp3TFC87HXXHTOmCrH6Xh2A+bfWGBaH5xwpMm47EDCFRQ6v+r+UA5
	wxetcOS8R7sW5riM48Crrcf+/Ll4/zrkhHJPqMNTH/2BeOabNtevnntRYepRTe65
	QA3DlDjNKPi+mFMhbevAg==
X-ME-Sender: <xms:WlzeaE4SCaof4p918biYLMCFxxR73peUpgVuPgHh__M7YOO-pspEoA>
    <xme:WlzeaL5-yuj2rVOQrgPUw12hXxPIOk9izHj8thwWxeya05BWaUeCWaOsZodnOzkV2
    HGmx73RMIXDGJnZ5lMAoIotycd2xElmutQ9ecigRvh_YWQqh1-j>
X-ME-Received: <xmr:WlzeaBGhh9vRBUm7GF6kmWurjIeb_78PX8EvE57yYOwqa1kNKyqNiyJDRzHZLt8CH6GVFyNmu7Riw2r3XG-BQ2yjljLWklnaxLGlaKruvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesih
    hothgtlhdrtghomh
X-ME-Proxy: <xmx:WlzeaEQj-7RnB7G9ZohM9XNtfTZKxWZUTWrrkRBWA9NjurbKIywgXg>
    <xmx:WlzeaKuZExU-y1TRrNdxYl7MezgPgDm2Q7bHHUWRAiB39hDY_QFAwA>
    <xmx:WlzeaDz7oyYSlAcCcd0bwImPKh-tiYTSmUJ-RJ_1o_AHH5W7cWMKEA>
    <xmx:WlzeaE6TbkZSnh-KDDILQtYx0wBq_o3peMqx49Ld-u0s7J0cyZNIEg>
    <xmx:WlzeaIRfi4i0y6Ki-_MTtY6QGrVA095t84cfXW5ZreyAWLl2L40eUlsU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 07:04:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7a0048f4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 11:04:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Oct 2025 13:04:39 +0200
Subject: [PATCH 4/5] gitlab-ci: upload Meson test logs as JUnit reports
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-pks-gitlab-ci-windows-improvements-v1-4-6a8b6b45d728@pks.im>
References: <20251002-pks-gitlab-ci-windows-improvements-v1-0-6a8b6b45d728@pks.im>
In-Reply-To: <20251002-pks-gitlab-ci-windows-improvements-v1-0-6a8b6b45d728@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

When running tests, Meson knows to output both a test log as well as a
JUnit test report that collates results. We don't currently upload these
results in our GitLab CI at all, which makes it hard to see which tests
ran, but also which of our tests may have failed.

Upload these JUnit reports as artifacts to make this information more
accessible. Note that we also do this for some jobs that don't use Meson
and thus don't generate these reports in the first place. GitLab CI
handles missing reports gracefully though, so there is no reason to
special-case those jobs that don't use Meson.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b388154078..85401b34a5 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -70,6 +70,8 @@ test:linux:
   artifacts:
     paths:
       - t/failed-test-artifacts
+    reports:
+      junit: build/meson-logs/testlog.junit.xml
     when: on_failure
 
 test:osx:
@@ -110,6 +112,8 @@ test:osx:
   artifacts:
     paths:
       - t/failed-test-artifacts
+    reports:
+      junit: build/meson-logs/testlog.junit.xml
     when: on_failure
 
 .windows_before_script: &windows_before_script
@@ -181,6 +185,9 @@ test:msvc-meson:
   script:
     - meson test -C build --no-rebuild --print-errorlogs --slice $Env:CI_NODE_INDEX/$Env:CI_NODE_TOTAL
   parallel: 10
+  artifacts:
+    reports:
+      junit: build/meson-logs/testlog.junit.xml
 
 test:fuzz-smoke-tests:
   image: ubuntu:latest

-- 
2.51.0.700.g236ee7b076.dirty

