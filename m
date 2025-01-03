Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB891FA170
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735915636; cv=none; b=PhIXCUq3mUZWsafaOYXMPfydvsqo9QN/ObCfolQe5kR6draBVg2Ym4yHzcRFqgYuv3cz6s/cGOY4CQrb9/Rx+1vEtSN1TW2G280pYASNL4PfCsrdP8yNIIUTvlncm+plwVNzI0GPZcgxpg1ps8NzrJ5AguNXWvEffUO1rr6dKDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735915636; c=relaxed/simple;
	bh=uCLcNqLoXjmDM+uus7WLtHwnNKHtE5tgJV8SzY6jxFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K0NKJM9ikqKYA7F1XittuNZ/+J+T2vtXr8DkO80m3G2lHlonHgJSOJYForCGPh9FhW/bNJGfqHum582W2FNwNuOlKdR5nO4Mb7aRf2207BZg3HYReNjODjonkNWej7ozmozZal9W6ILZ+JbNH2L4taCR0YBjWPL1CZr8Hx8Tw7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gtr2V9sY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fca9IM1n; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gtr2V9sY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fca9IM1n"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E1B411140161
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 09:47:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 03 Jan 2025 09:47:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735915633;
	 x=1736002033; bh=CsnXTabSIyHnxO2MuGx/cC6N+6oF8O0hrgOakeGfitE=; b=
	gtr2V9sYwDJSCIfLTO73rflKNbfpmPy2AXQS4z8PlHThY3BUPSGzT6vU0IV6gQq2
	0yZ4zSy2QRbCGRs9wvMt9zk3G7VpBWfT1h8tN7RGMdVyivwFfUu+iZO23vm0dlep
	BDe8xAlOsrooQZAfypyNj0UoBdkAbXloZ8tI6+qwMm+FtSVuVrZyEbLZ7eyLFJ5F
	aXFZV2XLAPI6AQTez+75eomaNs+IVtDdxEaygxiqFxr+x8LUzQ3Mpa2+/1ggNC4w
	k9zXe2oz4IDnPah1Be7cXbasOhk+WxnDCbdTWMpYIT5RYesRGWQBip5QIa4i88aa
	aKqjyNuhZmB0N9J+LoGh4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735915633; x=
	1736002033; bh=CsnXTabSIyHnxO2MuGx/cC6N+6oF8O0hrgOakeGfitE=; b=f
	ca9IM1nzgS2Io1ObICx3fBQJvS07GK8oqE/SC02MleTz1VPCsFEsyapIqzkBujy5
	fE99iNHVhz2Kpk0bhmQcKKHUZEAoEkn7Ev+XCsN5JfXIVcbmD1edlvR3DNtkl26n
	JDJd7k079qDvlpkf7icJos02WHJkDp8aD2Rba/c8PbE055iyLeFS29oUj42w1Wxp
	2apccsSPUV6tkszpDVsbJ0UHmyr/5cCk9OZOYXvA6L64ozT40rfnJztfCWVl10U/
	8jD296uHU0BkUexSRgy+Ry6nCwxf+1R+0n304e6Q8Z6rSkSqvJj8eHgBX59Krvm6
	r2M+dEl/LbMeTB/YGkZRA==
X-ME-Sender: <xms:cfh3Z7plimEyHK17bGc52xFZ1IuU9rnpKLm0AHQ0aq8hjwnu0zHv4A>
    <xme:cfh3Z1qIwDoqLgulwa3Ar1sNPmI6MAureOBQ9EmENOBjJbOcuoNKQ2Zz8URX64HJk
    RRmA1aBrmABcWswKw>
X-ME-Received: <xmr:cfh3Z4NC07RIIS2iTJmImXlTckx9UYPYux41EGlloaQsPf8kS3C_kk9JY7pWiN8QIDR7dqOvOU0XX21vDrzOOsddmUje3NmlaCdNF1o8InaDy1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cfh3Z-5vXPtDLjRWi6N6pd1m7C6C3K8DElPevtCzlTYkU10EKq7lQg>
    <xmx:cfh3Z65Al-Iuci4LCmLjvPRlX3zfgNJid8bA8mKO7sRwOvxWTGihvA>
    <xmx:cfh3Z2h60WP--U6nChY7sFNoDanDx3cbLgiOVyNt5_wLWVxMdF34sA>
    <xmx:cfh3Z84fqC7lFr72p0coAoedTT8fvQMeT9-p0Nr-YjJ42gJ-2Rb3bA>
    <xmx:cfh3ZwRLLOtFtQuM4JI2x6_DMZJuP6bA5Fzt6bcZxB84VDVL9MOPU6_g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Jan 2025 09:47:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 30f3fda7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Jan 2025 14:47:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jan 2025 15:46:44 +0100
Subject: [PATCH 07/10] gitlab-ci: add linux32 job testing against i386
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-b4-pks-ci-fixes-v1-7-a9bb95dff833@pks.im>
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
In-Reply-To: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Add another job to GitLab CI that tests against the i386 architecture.
This job is equivalent to the same job in GitHub Workflows.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 2 ++
 ci/lib.sh      | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 00bc727865031620752771af4a9030c7de1b73df..29e9056dd5010f8843e42aeae8410973c825de54 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -66,6 +66,8 @@ test:linux:
         image: fedora:latest
       - jobname: linux-musl
         image: alpine:latest
+      - jobname: linux32
+        image: i386/ubuntu:20.04
       - jobname: linux-meson
         image: ubuntu:latest
         CC: gcc
diff --git a/ci/lib.sh b/ci/lib.sh
index f8b68ab8a6546802756fd516ca15a2c97223da5f..2293849ada3b45873f80e4392ab93c65657d0f13 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -269,7 +269,7 @@ then
 		CI_OS_NAME=osx
 		JOBS=$(nproc)
 		;;
-	*,alpine:*|*,fedora:*|*,ubuntu:*)
+	*,alpine:*|*,fedora:*|*,ubuntu:*|*,i386/ubuntu:*)
 		CI_OS_NAME=linux
 		JOBS=$(nproc)
 		;;

-- 
2.48.0.rc1.241.g6c04ab211c.dirty

