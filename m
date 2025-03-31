Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9068016FF37
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743401830; cv=none; b=O2P7qyKn4nlerHE1dwsAF/Lnpo8uew7ScNL8S6Lx9jZk1FGxiKkr1vGKXBg/zlreTNbY20d1Shg+h6O1oP4y8TsqlQT+Rp3wGBN98Tv+Yc8Ff54qTlCSJcssobG06bV+ZeQhAMbuFeCOsbvOC+Lm6DJ13KnI32Q+iVb1pjp7LK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743401830; c=relaxed/simple;
	bh=LjZ2xqFsdw01hpu5RB8LblUjKOINonFiN+AOalTLH6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HXECGMpEU7ZRoa9Z8rYEEs6M8Oc1hpRfaKBE3BY84tjvyhEtqWzAEv7mCXm84lC5dfRRxWwWOFtOyBGLf0QmN1CJOzKi3/JKgwmKMGHCQdkE20Vru5mI/a84jBut+vC29tSvy7m/tZxTyTUjV+nznndICowrrviDxnmYzcTFOn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pHjTJII9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s3wko+Mn; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pHjTJII9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s3wko+Mn"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 93C3211401BA
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 02:17:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 31 Mar 2025 02:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743401827;
	 x=1743488227; bh=41YHbAIFvgQZapSqNhC8qrl0Npz2TASpe0BaXLuKktE=; b=
	pHjTJII96G1PIoY3eWsqq5Fhb7zRXHFC5VhzPlVyo/8YYhNlBk4GAClmdkpyfH7v
	8UmQjAMYOomLxKEWQo4ooYnO4Ohz4I/PWek/pyXUTjX+gWU/68j9cqsGzApoR+Jw
	nQ4XgXXQybVSo/DQ+uOUEPpGyO2Z4vlf0NYWOLnm2DKUVDR/6tL0fCzJv3m7WmTT
	jB8bpA1Z14bB1mrAVJk0NdUDSGKDKuSVMYkCRowlixaUAJqJU3mkKAtlLjASJW27
	KD/Bmp/5LSFiqPy35aMl+D5Idpq3CqomuRNjns+reHYG7tG4oaE85zs01gaxKoYR
	IK99pin52TqQ7fpQzP2vIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743401827; x=
	1743488227; bh=41YHbAIFvgQZapSqNhC8qrl0Npz2TASpe0BaXLuKktE=; b=s
	3wko+Mn6+g9U7K+us0E3vRBaxIzRenWih7fccDdoPofRaZ+Bp59SpeV6p3Qbhe96
	/UwQERhEXnStFN87nsWB4T0Nfc6z3f6Fnae2Ct3SetTJP3o0bzQAn8igz2ksAXk6
	5HpEGBgvulAqUQKOQ/QknVtc8rZGC42GgQaXSDa0rwPVhKIuIu3NH21oeHhQ4DZD
	rsoDDavjZTTtvlyhTnzbu3DDJNWXSQkKt9hvbU79SgnRGs9KzRxKMyG+QFhI7rnQ
	19goxYEIv3JmcSTZFOWP4zcbr6EQnHTDScR6duvc5D/1LtcDpLYgLRnOW1uM81wB
	ss7HSYtigRA9kslqYO6PQ==
X-ME-Sender: <xms:YzPqZyuY803lCnkpJMoIUgShwqC6IroGOUbNM91FaXmQfIyLtAbLVg>
    <xme:YzPqZ3eICOV5rzH5IQduChUlv_toHi_IRpuGIcbsmk_mokBdnwK-bZ4tUbRfutCPq
    SDdbf0mzDqLErQl_g>
X-ME-Received: <xmr:YzPqZ9xcUSapWuKkZXnpUS1flRhiG20xxbzgbVJkIpzRNRLtIgubQld753inC0sqaV2_iEB54EP5cPcbDxXLvCRA6AT58ohQMpQPo_Di7ACvzhAN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeeludejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YzPqZ9OdxRHcrXbgJ3C5v3dHDHyN66CZsFI5o33HHNw-vs5C2hKtQg>
    <xmx:YzPqZy-Jt9EQyeQAuW_qpiMWjTx0_QQtKN_MTIr3NIra9HEbr_BcxQ>
    <xmx:YzPqZ1U_oOpqEBWW1QUe41GNe6-Co4sILd7_hPgbq-j81192fzfKMg>
    <xmx:YzPqZ7fmGmoPvOwQ6WPV-vhETWnp79nzC-NSlthXuElvYlvpsKCNAw>
    <xmx:YzPqZ4lwVf-KBjJUqYrSUYszy4UX_QSvOorIg6vPJXLxR3FcRibHmsLU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 31 Mar 2025 02:17:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 85cf043b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 31 Mar 2025 06:17:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Mar 2025 08:16:46 +0200
Subject: [PATCH 3/5] t/perf: fix benchmarks with out-of-tree builds
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-pks-meson-benchmarks-v1-3-b2ace85616a3@pks.im>
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
In-Reply-To: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The "perf-lib.sh" script is sourced by all of our benchmarking suites to
make available common infrastructure. The script assumes that build and
source directory are the same, which works for our Makefile. But the
assumption breaks with both CMake and Meson, where the build directory
can be located in an arbitrary place.

Adapt the script so that it works with out-of-tree builds. This prepares
us for wiring up benchmarks in Meson.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/perf/perf-lib.sh | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 4173eee4def..5406557b7ca 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -25,7 +25,29 @@ TEST_OUTPUT_DIRECTORY=$(pwd)
 TEST_NO_CREATE_REPO=t
 TEST_NO_MALLOC_CHECK=t
 
-. ../test-lib.sh
+# While test-lib.sh computes the build directory for us, we also have to do the
+# same thing in order to locate the script via GIT-BUILD-OPTIONS in the first
+# place.
+GIT_BUILD_DIR="${GIT_BUILD_DIR:-$TEST_DIRECTORY/..}"
+if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
+then
+	GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
+	# On Windows, we must convert Windows paths lest they contain a colon
+	case "$(uname -s)" in
+	*MINGW*)
+		GIT_BUILD_DIR="$(cygpath -au "$GIT_BUILD_DIR")"
+		;;
+	esac
+fi
+
+if test ! -f "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
+then
+	echo >&2 'error: GIT-BUILD-OPTIONS missing (has Git been built?).'
+	exit 1
+fi
+
+. "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
+. "$GIT_SOURCE_DIR"/t/test-lib.sh
 
 unset GIT_CONFIG_NOSYSTEM
 GIT_CONFIG_SYSTEM="$TEST_DIRECTORY/perf/config"
@@ -324,7 +346,7 @@ test_at_end_hook_ () {
 	if test -z "$GIT_PERF_AGGREGATING_LATER"; then
 		(
 			cd "$TEST_DIRECTORY"/perf &&
-			"$PERL_PATH" ./aggregate.perl --results-dir="$TEST_RESULTS_DIR" $(basename "$0")
+			"$PERL_PATH" "$GIT_SOURCE_DIR"/t/perf/aggregate.perl --results-dir="$TEST_RESULTS_DIR" $(basename "$0")
 		)
 	fi
 }

-- 
2.49.0.604.gff1f9ca942.dirty

