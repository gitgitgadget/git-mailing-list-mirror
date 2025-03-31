Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6411DE2D7
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743410005; cv=none; b=d7yahz7gtNeIs4uyv0XkyX63ZEqDAGDtCMbBeE5R6g3lmX2KzCKsTon2PAZCUjAmiOPUUvw/rsme4N5D45D9BzzIZRuxjrUOXDNipcfvsn2RG0XLk8oxabIGxY28spXUqaJWv6tCOQ3t6tJk8m26RdcbW7WtvNiKs/30G+Nnt5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743410005; c=relaxed/simple;
	bh=GkcsVxfcOy3lSuJeYU+rasAEWRgcZUFf8MpqINDbG8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aGrXoeZDaTF9mpSVSv0TyTdQnGB8aVobPeuCEGGqgK+MQwIWdXtWkSa8KpX5864CkBMCMpgt6W+JXPCETQUjcSERaIugQ3bBguNnQzys3x3oNEYVplGRqQ18StTTdLVIcDkjXhKMcTEoSKLwAMX6S+dPCX3/w/AmOowBBfEEL1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jRJAaGqm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FxK6j68S; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jRJAaGqm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FxK6j68S"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 66811114013B;
	Mon, 31 Mar 2025 04:33:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 31 Mar 2025 04:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743410003;
	 x=1743496403; bh=gpI825NTlcy1PWNBuBui9JKs2txUBdBcIxorCVook3M=; b=
	jRJAaGqm46BfesA2mVCq+QSudT+tZSdO//3jxgSQfLIZYUgPsYQvm1CIQHhCXG8+
	a3wiHNXGO6RmJGdnyYHTq3q2fBVYnaiAyptUqSABPL0zDVDVvevEvvBsphSUQM+K
	lVgRz2XjAYkOQJdwLW8kHPCVjNslT4CK/3K/gRYZd/WEkxDi/5Gi6zgks6JbqE8d
	R+C0qHiI11nbItfNwK90BjvrszXu5XHEs7qFw0j5brWbIwZa84rqDuaKObhP/oni
	0BpoCXb5vUKtbfsXaRwiEBw4EhSqK2hPxThXj+ABa7+QjO7itv9+l9IgFu8XL4RR
	tI0+D/oy3AqFDyeDLEmfJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743410003; x=
	1743496403; bh=gpI825NTlcy1PWNBuBui9JKs2txUBdBcIxorCVook3M=; b=F
	xK6j68St3Kdk9XnKiKL0OuwUFZ35mFjlf9TNe+JLzNS0hggvJj8sYBUIGTZ9mAJ3
	VJGKcUvjDKuTvMHagXEhKFhHLpNrfbVv/7iXmES3DAmOy3Ox0EAPmuT5ImDiDJDR
	ubvbR8lzogDgnF8AI+N0zcoALNSvb9O/pHzqZSsI9XubHom6v4mX7KUekv39UH9L
	GUK5ozOHWwIZeE9ME9Sf5kw6QrxIN/IZeomU7hxS6/cbaoGP9/HLAkjqT+A1iuI1
	kPPiUqDs6LYDi2wgAU7qLHPFpWufEyQAGK7g0jCMleniS+BOEdh/YgTMB+dskqRq
	X06xJhnvqWKWFDoNF0G0w==
X-ME-Sender: <xms:U1PqZ6SeNRhxvNoOQdn1gsL0WvRytYIV8zmtTLc_Pvpw19Gr_-Gxsw>
    <xme:U1PqZ_z_gTrCUlkXDcfzLW6Kkh9GOgrUvsbzEUVb-X3OdHgKeNcppBZwAPLYyJaJK
    PkGLyvQRoF-rD-wGg>
X-ME-Received: <xmr:U1PqZ32-BjE5Adcl7h0Zfpe_TjQ8Ri-Pzn0cOSZL7wrfp2yOz8GaZ8NCwsWfRDqZUrBbCWkbc2HFDHLwvl0-il02Vf3n3RPNC7ATmwqb0XYxiJzo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopehsrghmsehgvghnthhoohdrohhrghdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghstghhfi
    grrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepthhgseguvggsihgrnhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepph
    hsrdhrvghpohhrthesghhmgidrnhgvth
X-ME-Proxy: <xmx:U1PqZ2DVIjXM3p4O-jpb7-B5cNJnNnqrgGyMH-BVn64v6jrcGWFCbg>
    <xmx:U1PqZzjeTBzFkrqgcY2awbxdjAsKjx9falEgNVy1I028xHVnvz6NuA>
    <xmx:U1PqZyqK5wh0N-HbhZRjCdXQFOM_IT_tZk6sqPhw21T-kA2ei35rxg>
    <xmx:U1PqZ2ghDQ74Edn49CupLZJq729z_6iytHUo1hIahr3Bnpy2OIMyfw>
    <xmx:U1PqZziBm09z2spzUshpWLAq1c4D0tBFUoMsTKmdtdwhMdr5negaTtnd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 04:33:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1e5d91ff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Mar 2025 08:33:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Mar 2025 10:33:11 +0200
Subject: [PATCH v2 5/5] ci: use Visual Studio for win+meson job on GitHub
 Workflows
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-b4-pks-collect-build-fixes-v2-5-6b06136808f3@pks.im>
References: <20250331-b4-pks-collect-build-fixes-v2-0-6b06136808f3@pks.im>
In-Reply-To: <20250331-b4-pks-collect-build-fixes-v2-0-6b06136808f3@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Sam James <sam@gentoo.org>, 
 Eli Schwartz <eschwartz@gentoo.org>, Thorsten Glaser <tg@debian.org>, 
 Peter Seiderer <ps.report@gmx.net>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

In 7304bd2bc39 (ci: wire up Visual Studio build with Meson, 2025-01-22)
we have wired up a new CI job that builds and tests Git with Meson on a
Windows machine. The expectation here was that this build uses the
Visual Studio toolchain to do so, and that is true on GitLab CI. But on
GitHub Workflows it is not the case because we've got GCC in our PATH,
and thus Meson favors that compiler toolchain over Visual Studio's.

Fix this by explicitly asking Meson to use the Visual Studio toolchain.
While this is only really required for GitHub Workflows, let's also pass
the flag in GitLab CI so that we don't implicitly assume the toolchain
that Meson is going to pick.

Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 2 +-
 .gitlab-ci.yml             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 9959b61ece2..6a002485aeb 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -265,7 +265,7 @@ jobs:
       run: pip install meson ninja
     - name: Setup
       shell: pwsh
-      run: meson setup build -Dperl=disabled -Dcredential_helpers=wincred
+      run: meson setup build --vsenv -Dperl=disabled -Dcredential_helpers=wincred
     - name: Compile
       shell: pwsh
       run: meson compile -C build
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2805cdeecb6..4798b283745 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -164,7 +164,7 @@ build:msvc-meson:
   extends: .msvc-meson
   stage: build
   script:
-    - meson setup build -Dperl=disabled -Dbackend_max_links=1 -Dcredential_helpers=wincred
+    - meson setup build --vsenv -Dperl=disabled -Dbackend_max_links=1 -Dcredential_helpers=wincred
     - meson compile -C build
   artifacts:
     paths:

-- 
2.49.0.604.gff1f9ca942.dirty

