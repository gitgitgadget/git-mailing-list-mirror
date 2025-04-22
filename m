Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442FF214226
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 06:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745304625; cv=none; b=CB2j1EJUTBhR1hduRohDYA2IpLPIaj/iH1Q9/t3uKtYDYKs5R7KelsjfTtCOGxQHvvjgLsXvkg4LJKHf/MlDwur09NCVAnueQ2zOVyaUD1hTOUmsUuYfAifujdY1Wy5ZJIKjlvEa+qF57ATCtNBfbLfFyiUaO1+8r5JmmhQ0srY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745304625; c=relaxed/simple;
	bh=aFpBj/nZ+mcVwJvFXw2kBNVm0hYjDYmmZTZwef3xeLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WuPN3p2+I3tESsvGnfw6on4rlxtyVNl1Gj9Bby8UQFK3mOvcgkQDqB9h/NcCz9SGAbRnMtZdjKIiXNGWXE90eCWXxhhqfDOGTON2qxDvdAz+EhzxF8OgIzooy/pPdhj2wbQf5jATMZsgJmeZ8aH2q1FRG6to2V4SGzDNnjNM5/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OzbOmPZ/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tUD8BIdw; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OzbOmPZ/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tUD8BIdw"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 539CE11401DC;
	Tue, 22 Apr 2025 02:50:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 22 Apr 2025 02:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745304623;
	 x=1745391023; bh=6IAdhC98td/Pd8RfDcMIviWpHuVu2RNh9BYDW4/uKnE=; b=
	OzbOmPZ/65KIUcSfo3uSie/mBAaYkwvB8HFpUReOCxUSPO5tc0PtQklfcB6HM5Or
	4ieWpoYIl6/4j8dq+nzi1TcKvY22dZYbmIFkoh8FTi2D0K/ivBnyS8L0qMaaibL0
	wE8Yuq/NHu5BgqaHfT+sQ1dKcVPC3atdsXw2DOo4CU8BFipra4wQROB7VaeCJi1Z
	Cae2/Xwdg1fJS951dnVwaKbFQ4K5MLAnOGd/bsuB4YokfsKxzt4C1bm4xlnQccGY
	i4RCYzEQSlpAySALTtQ5eAz1tbpEJuCFEsdGFVKqHtOnCNhUeNcoidyJHBSRIf7T
	8PSUfX004wqd7us4drV0Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745304623; x=
	1745391023; bh=6IAdhC98td/Pd8RfDcMIviWpHuVu2RNh9BYDW4/uKnE=; b=t
	UD8BIdw5J/gK1uHQS0/c0hyYdKvh2185d0w2NtWEu+wi667xBjqkp6WHdCwpGWn3
	P6UXR5VhgCcN7edqBDewmGUreKX0mrT/Bq53QQlNrYjwS+kUm/LsAgL7IvRAH7WV
	6Q4hxa2cLqe0AdBOvAPiKrYbzXqWrMU/54zewd9V8BJeWG07A7LwI1Q+r8jxOBNr
	6xGelfoKl6BZhOyoHawuGeuuD2Sq0Sqd0PvuH4yKakb0448dyGI5PDASFNDb+pFK
	G7flm7YOyrdRxv2qc7e49gzY/YCBTOciYqZ+/BEVQJ9xKoqy4rqs2C2ynhFupDFF
	pQ1Xa+uU0Q7XhALbOPpmw==
X-ME-Sender: <xms:LjwHaKH-kJP6nlVgsZ39YjQs1RKdEzybh8dOwkTHAEZj5JXjlTuTOA>
    <xme:LjwHaLUs47u7s0NuLNbgZz3yxAHeQlA5wT8ohaVW3ZYPW-kdn_1059xzdUn9d9fY7
    Zq1-LzahQrPx7p6Lw>
X-ME-Received: <xmr:LjwHaEL_ID4T0IhdnRNkJLBO1olBBuu2HLublUnzxamSYzP2UKdPtFVg6rTh4QDqbHUcnHj-s4-O6K-SjpM39GACHFQNmj58NJmU54m5rpM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeftdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilh
    ihrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LjwHaEFnHeummmAqn_IPI97S3P4_UGGZkdstS19zyLZUdVlKy47TqQ>
    <xmx:LjwHaAUheVC5LP_GVSwD3tk4AsRNQfrmdJmPMBUeuUXwj1MmVgW0fw>
    <xmx:LjwHaHMpwF6isQdJJfc6oWjEfQ7zJPzX85YAQ9edBuLeUCjwGVCCig>
    <xmx:LjwHaH2JsF_7xqskge8l58ZXY3sYsb6hj5lYCWE2BwIyuXnzN2VIpA>
    <xmx:LzwHaKqCaqGZkPquSDL3CES4fZbITgoTzQLs3KPIyDbtC0eDJ7iyRtQ7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 02:50:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 51302261 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Apr 2025 06:50:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 22 Apr 2025 08:50:13 +0200
Subject: [PATCH v3 3/5] t/perf: fix benchmarks with out-of-tree builds
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-pks-meson-benchmarks-v3-3-7aad68bac6fd@pks.im>
References: <20250422-pks-meson-benchmarks-v3-0-7aad68bac6fd@pks.im>
In-Reply-To: <20250422-pks-meson-benchmarks-v3-0-7aad68bac6fd@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Christian Couder <chriscool@tuxfamily.org>
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

