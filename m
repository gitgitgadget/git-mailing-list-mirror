Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEA722D780
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566104; cv=none; b=nZHoEMmeLtJFv9THZ0YanFU6aFpWTFviBvl04tLVNVUac/QxlYKePJu1+QTwAT5MvSUYEOfmoOPgJ29NQ6Ffd01RUliYkkY6eyoZofFKKdK5BAbfDRsY79qKCrWerK1ZdG/xeIBZet6uhMBcYXNnsaaM2GiVG6Kiif6iOVKk67k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566104; c=relaxed/simple;
	bh=aFpBj/nZ+mcVwJvFXw2kBNVm0hYjDYmmZTZwef3xeLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HY7V/yr7ZQk5hPZ1FUuIlkxEgUOLhw5WtljvVQ9iiC9Kxjct5ghv2smA74qd1dORX70cx9bDBaTqIg29+qyOUGmluOlxQsVwNxp7MVwoL9cK5pwR1w+CkZ83j/0Yua5YyG+cBUEpxSTlQDmUpfwDDEGWyKNsewTgnWmAobvgxPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sQDSaK8P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WYpadJGB; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sQDSaK8P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WYpadJGB"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 6D93B13801F3;
	Fri, 25 Apr 2025 03:28:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 25 Apr 2025 03:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745566101;
	 x=1745652501; bh=6IAdhC98td/Pd8RfDcMIviWpHuVu2RNh9BYDW4/uKnE=; b=
	sQDSaK8P6gfF3YEXemlYEFtpBdAnKX7I4ladygwlZ4vyYBxdwg9i8ZkSObzfLrFc
	dvNE4Z/HLxcsAfaFp321wNqdFsjlVi1lSVDQI0j72EUA7XcFmro5UqzbxfHKUBi4
	voh0zWrcqjrUhhop2CT8E22Z+4zmvqRKoupUv9G3fyxTRa5pZnFljWAbtCPxD7B1
	lPArq/1eUNuVUW6HW6XUPFY61YkTKffwukmgknxQe6QHjryvwmihyf8UgTyKgHA5
	uj+YQfnV6qRvqvSiVwWQbDxKokolmE+RYa02mg6PH0sEsJ+HCwL3+1Fwkce6INIW
	VNRj/MKPAAzNAbfyweG3Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745566101; x=
	1745652501; bh=6IAdhC98td/Pd8RfDcMIviWpHuVu2RNh9BYDW4/uKnE=; b=W
	YpadJGBkYPxGUbr5QBC9Gqc7+ZqcAcVZw9EtK9JQw93XgHALqO9j4+eekh4ixG8D
	kIPMlEpZ3c/mqns1CsM5LLgYULpRS9fzmzKYzvtjv/lK3MQk/iGiH2euUuEuSV05
	aHqldJjpXytBZumKJNeunxf7cLXOVVBvZ3l0wQDrevJngU28j9zdikRamhsfRASi
	xMaPLLVGjm/IGBkJ6lk07j4rP6gbvVsyGMBolYtwsAOIW+ilfihy6COc3FlMh2gD
	/qquzcRg2HP1jpdLxF/wmpaQA3cbFiFTVFw5AeCBVtxHhIm87w5JROw1OZwY7aFP
	sIu5X3qJW4vngNZyPz5nw==
X-ME-Sender: <xms:lTkLaGLEQTy2AO_QPB3hs7Ia3071aJbfXlxVb7BksghRPJ9qkG-Sjg>
    <xme:lTkLaOLFvgxvrljJaw3I_F3jfD7TErNhcCKLrzVhUhsCf1fZD3I8xH4iwu_WL-9tm
    9IejheTQP0jCR5h7A>
X-ME-Received: <xmr:lTkLaGuluzLFBiL7g_THYdoyboyvFu69BhCO7LJ5_fVOcVMSPFSYLha-fQkIdjV-h_8G_ptKxpIzwsNxJyun-npC4hrHGXZXxECqhH3c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhi
    shgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:lTkLaLb8Cr4JEmjGQZzGD0HRYoYzwhh5t8b_tBKVn2sBTZ5U19FYWg>
    <xmx:lTkLaNbhxNH33mvREqXYixofdOFzdwrfORXETrE0RA64iJ1TwwB_QQ>
    <xmx:lTkLaHAI6Xm6UHfvjboxizbVXZ6Paw0m0iC5SrgphLQgdLBNVNLLmA>
    <xmx:lTkLaDbJqp_xe8bldtajwr3MeQTdcmVzEC3SYyk_owu-gJy3s2g6Sg>
    <xmx:lTkLaD9q8axYHFRiq2uYF4I2QUbeb0CenkQEX_CrIzY2GjmZVQzTSmn8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 03:28:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2dd21f9a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 07:28:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 09:28:15 +0200
Subject: [PATCH v4 3/5] t/perf: fix benchmarks with out-of-tree builds
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-meson-benchmarks-v4-3-6b89555052c3@pks.im>
References: <20250425-pks-meson-benchmarks-v4-0-6b89555052c3@pks.im>
In-Reply-To: <20250425-pks-meson-benchmarks-v4-0-6b89555052c3@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

The "perf-lib.sh" script is sourced by all of our benchmarking suites to
make available common infrastructure. The script assumes that build and
source directory are the same, which works for our Makefile. But the
assumption breaks with both CMake and Meson, where the build directory
can be located in an arbitrary place.

Adapt the script so that it works with out-of-tree builds. Most
importantly, this requires us to figure out the location of the build
directory:

  - When running benchmarks via our Makefile the build directory is the
    same as the source directory. We already know to derive the test
    directory ("t/") via `$(pwd)/..`, which works because we chdir into
    "t/perf" before executing benchmarks. We can thus derive the build
    directory by appending another "/.." to that path.

  - When running benchmarks via Meson the build directory is located at
    an arbitrary location. The build system thus has to make the path
    known by exporting the `GIT_BUILD_DIR` environment variable.

This change prepares us for wiring up benchmarks in Meson.

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
2.49.0.901.g37484f566f.dirty

