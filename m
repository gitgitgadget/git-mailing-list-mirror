Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3AE1B81C1
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 06:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744613481; cv=none; b=Zzps7vnDs2xrGddV92622rdMbHY0Re0RUell+22cttqZ2FaEJbO/pHRW52OIp2Rq05uxKhPkuQIV0HN4ciDoMNZZIoqkRJMX9Lu0Sqs39ogpzGLEYQ7TOeRyr+nfikuDK2pdny/Eoo+9B3ZDxSwtQgG1aesIVpWSDAkS/2p0a/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744613481; c=relaxed/simple;
	bh=bsCO1secU1xo+GV1d9ghY+2+whmnn5f6c9nHeipdLmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=WtmLIAAplpvy9R99Aw5vyXnCsrAuk9LeAn6vuSgd0WVueWcnPkfH2Uuxj4o8aAKCFK4IXx3CtdTL3aVLgAE8FJ9kM7FHze0UUJUgqxOwy+2eq6Eus0uwYTRanb32qM8T22rAfpZJXemSdmHZTeuIXph+hVrco9FYCYEYdcDuQPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ojAAhGvn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qO89C088; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ojAAhGvn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qO89C088"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id DAD7B1140105
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 02:51:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 14 Apr 2025 02:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744613477;
	 x=1744699877; bh=0aAM5EQUmmAr43UyPXlzPWBCaiEkv0DNoB7DoBezet0=; b=
	ojAAhGvn+t8CO9NMl0YUyafX1NwZ+DDcdcigpV+QP98i4yDwlkczfh/NkSdQ5Ji0
	ea6fKOkb7gI4YVAjjQpQgeIwlWD+UbAjZnz/GexIHLhYSjYaSrjYnpx1ekG2k7+M
	PebYRq+3hia/jCxeytnj9j6aRq6PwB57MZTX64JsU9paC24s43A0kxSY+Ao+LVER
	cJ2e9XRnlpdP1iB55D4GxtCc1K7LxE+PMdrWYg/jGWyo+OLcEf0RtE2fQUYd1WRT
	kvL4zYlLv+fYn3crEl0bo0X6sotIUhg8Sq5Qp3KNDo7uxsH3f8aupFLyLGKJp3Yn
	lwz3iA7Q66Z0p7OfZxIThw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744613477; x=1744699877; bh=0
	aAM5EQUmmAr43UyPXlzPWBCaiEkv0DNoB7DoBezet0=; b=qO89C088xtYh5fplM
	QEtJmuXGSrKBztxdkQHtOH3my/SFMcWRlqTAi3yvC7y/zhSMKJEc1IQYAG0/IDxW
	I74e4r4SRCUF4UQBLGk+npRbluPAgZYI66jaI2engubryyC1qrj8611oNC8AXQ5U
	bjfSegMstSIOthhQIMinm0PXr92dF7NXOqkk/FMIwwAmgUxKyhWYNmax3/olZcgT
	oKwYETBZgw9iBy1xE5wrjvslZZVnxijgIz0XLBRk+DBOzrubU9Ix1/tk7BjthJ71
	z2LDI0G106em66+xMal8GJI6Z02KHcpQ5glCKoi0ox9PbW+CO9wba4/XPrG1kSuY
	Y3o7A==
X-ME-Sender: <xms:ZbD8Z1DO13lpgtBeZvU9LO9Pn9JSLWbxOmfzqYUpzGI19kwYnxFHjg>
    <xme:ZbD8ZzjU9J0pOEjajeCU-cn4kMJYOa6szmi8lbKIDDHAXoCYdiq1XPGofuFavT6AE
    slP1dJD6jkPutkMRw>
X-ME-Received: <xmr:ZbD8ZwkE6WJBLBfEqnSznPuqWyvE5cfNH9x0P1Z3u_ltYaf_3hVUIZqEEe8WkvWOkDGDJ4aWsiCYuOJv8p4k8vFgj1SF4dQgOOx1tcbRfxxn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudelkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvffosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeelueduue
    eljeelhfejueeffefgtedtvedtfeeffeevleelueetffegteduffegleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZbD8Z_w5BkIhxhY-DEcEC_T_ySzad6nnw9d_OYuvjFGmMKBqms27mg>
    <xmx:ZbD8Z6TcUu1TDMhLWN4bAVSL6obZTuIbMLuOSab2I4-dvWIpthDAlw>
    <xmx:ZbD8ZybmmZ559C9x_OSv_oUQgI3uZdRNhsVdFegC9z4kdfimu1GDSQ>
    <xmx:ZbD8Z7Sz8l0nDZZATv-Iu4qNnIpmEbABkzr0jM_XlJlY1KpVm81Yog>
    <xmx:ZbD8Z_LfefJXYtg5ZEDPZ2XjhNym70OOCtsh-mgNC1pPmC5dswP-zZy->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 14 Apr 2025 02:51:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1b77ea52 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 14 Apr 2025 06:51:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 14 Apr 2025 08:51:13 +0200
Subject: [PATCH v2 3/5] t/perf: fix benchmarks with out-of-tree builds
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-pks-meson-benchmarks-v2-3-04377080a167@pks.im>
References: <20250414-pks-meson-benchmarks-v2-0-04377080a167@pks.im>
In-Reply-To: <20250414-pks-meson-benchmarks-v2-0-04377080a167@pks.im>
To: git@vger.kernel.org
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
2.49.0.805.g082f7c87e0.dirty

