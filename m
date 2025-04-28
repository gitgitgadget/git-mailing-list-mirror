Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FEB190057
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745825459; cv=none; b=L/Ia4xa/kQ2Idtkco3xkv2GFB9cXgMzoL6ztFq4NK55fN4bJQ7XDpAv7I4y5+XPeQMCigOetGn6HauD7Eas8CWS2jRea7NXcgI1fsyVP3OOdBs9kuKYddRgX7jdSjHgaPlu/NvBLsjx/2x0jwqylZV3IePyweoBW4o8f+/DVoWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745825459; c=relaxed/simple;
	bh=neYrfJ4783CuAiur7SpoxyTFy0wj9jp/vUnYbTfL6nE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=th4LfETy8Y8yOkCSd50nhwIsb2Eq5LABtTwI1X9CPhQKhO9BV+KK10AqHV41iInz54AJvltoBUexazDjP6oFf5CBk0zIvTZkBTUmF/qLynIXMvkkb8ATWPNGhp2RmRR2T0xcLpuHJUGaGNU5GMY04E8m/g1f+kGhzzB9cgmJNdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i+qL29+l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bPvpxUDd; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i+qL29+l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bPvpxUDd"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id DB492138013A;
	Mon, 28 Apr 2025 03:30:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 28 Apr 2025 03:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745825456;
	 x=1745911856; bh=acfbb3zNsv6QsUWYfKbTUXsoDwnXp9Oic++uluOdjBE=; b=
	i+qL29+lax5jWEgRWphX3Et7uNLle8ztxutx/o0xbWuDgSVhTH1r3R78rfO1oqTP
	D60i7hVoFNpI/J5BAsUWOr4I0y6IVBV700ZL+bsB521w/RS4y5b4e903mTfoHZno
	AL9ewuDBDtQntyNI4hEfVcZKPwRpMq0Au8nDq7ez9ss5VObON20XZTXsLdLbxJ8t
	An/7XeNp4xExCBYlTiaVarSS6uXmVyVmb6huJLBlJZmNU4l0Goju1KZaLxoanuM6
	diAc8NN+4vxtLf3OWt3W0zN1Tuj7L65f/fxc9hHQ/Yu7YkAXJU7nEO6NwPSpJA//
	J9Uv4nFjmhd+10KVIfZImQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745825456; x=
	1745911856; bh=acfbb3zNsv6QsUWYfKbTUXsoDwnXp9Oic++uluOdjBE=; b=b
	PvpxUDdF9niCWqtI0Yt/px6RfIZo3ZCXPcxLUITlrKXOe1eM3TqzokH/8DenIdOx
	vNSPrpcutKX/VbURqBR2FiumLfnLT+FY7zZOzG/U8cIpfzZIZivAZy69r9dPBd+t
	4eL43IyobUnCg2HMYDZ6Ku5FxF/sY49UKPUFRuTj2Qz78Q2VIK2W+hFq8VopNGF3
	D7111zC738R3e6waWOtoJzqwdyZPB9RzoxVOsgROpeZioSqJFtkA1T9dSbekz/kN
	vgT3qo9Pkb93HJJ2Pmoz7SF6DNjNBEuYeg9ER1LUg/BRvmqSs0AtWL+7nmyd34hT
	N0UqcBUK3lKXTLcUlBKXw==
X-ME-Sender: <xms:sC4PaJRQTgKsG0eh7BOSrGnNzMGId9BwvU_rTDZEyx3_dEbUQh9woQ>
    <xme:sC4PaCxjI0CIXfBdOqqNpzAG98ou91wdQeJcOqmaO2N3kP8e8_uvfDow5RrKCIkly
    X9UfpVWmT0x0xZktw>
X-ME-Received: <xmr:sC4PaO0ZG6Z5855dJKGHzJ0IFtEd3koGIuN01cYhMHh0-gtOAuVylO6cHJOlJAY7iEkZuL0UmZ0yVMhuOLblFPWgeh837BMMBq16ZkFp8ed2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedtfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeht
    ohhonhesihhothgtlhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfh
    grmhhilhihrdhorhhg
X-ME-Proxy: <xmx:sC4PaBBkNMQDgUBrhx_8NOla_VpXZXZFTpthAFHEilSthzI3mewX_w>
    <xmx:sC4PaCi_OPfyrIuF20xi0hY8nMgqBNS9CYWWAs2n-_02Brgq1jLsng>
    <xmx:sC4PaFrwrahzTf7z-gGwwn3oVtgWIxImqwE9fTAKD-fluLL6m4D-Ig>
    <xmx:sC4PaNjDlSlRf2kaTnYAD_V1BmQ2VSPLSlhsEvFl804xoPQnc21ZYA>
    <xmx:sC4PaL8uvReWj4dXcxgMyEPw6Oo5PK0E9fajv6YT5Hw9wm1MHg9scMeb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 03:30:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 92a0aa2e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 28 Apr 2025 07:30:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 28 Apr 2025 09:30:48 +0200
Subject: [PATCH v5 3/5] t/perf: fix benchmarks with out-of-tree builds
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-pks-meson-benchmarks-v5-3-5010dd014d1d@pks.im>
References: <20250428-pks-meson-benchmarks-v5-0-5010dd014d1d@pks.im>
In-Reply-To: <20250428-pks-meson-benchmarks-v5-0-5010dd014d1d@pks.im>
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
2.49.0.967.g6a0df3ecc3.dirty

