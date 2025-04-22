Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161E319AD70
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745304624; cv=none; b=nYQvMQuFrSQt+w87d9OdpN3Y/6UTbC+DOuFgZKEMsdoJ02RoSdJAmBW+3F+tnzjPcq683HdgNC6SwyDuCkolEKp+91a/Gailk4g5uF/Sitdn3z7+UXcFKwhuFgL2Gw6jjPV0X6yf61yH+rOIeyR474EIFmM7yKw8PQD9Y+H9ons=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745304624; c=relaxed/simple;
	bh=q8B05t79a321aNjFYW8CrX5lf7QGvrIejql9GPWOOs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FgBtIdXuwU88+3oMiJEB0p0Jwd9uzs80JdTl7uxGiv3kIR56hx+3vRk0Z0PA0VteEamcv5ZDymhRSwC8wALxiKAqLWPHD2UKOA+vmpzzgi9QWnCd3u2UljRqPDV2GwiHUTFB7FDqwJdDvWrNvQb429DhB+DKQdI5ZN9msrhLjKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BUuIrOK2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O20m2hLZ; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BUuIrOK2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O20m2hLZ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DE4B7254021E;
	Tue, 22 Apr 2025 02:50:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 22 Apr 2025 02:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745304621;
	 x=1745391021; bh=qMaoeiuIytpfIHfIWEtyup7XB4p00qBFM+IrbAgf+JY=; b=
	BUuIrOK2ZQV/MlATemEcEDqRXxBCx4Fm7+r/dUmUkhRiRAOzMFHP8c6J7NQnD7zm
	nj4MFd+/ZE/t27F31chTSxPxnpaYYrQj2Ydif5xdBqHk8rBJMzvbH6K0f1Qfievw
	d+L86QMwtkpOyyeuAw+kOgj1Bu2CyaHaN/h/1xXzwlyGvl3xa9NDOIWXQN3TZDJR
	OGTjsSl75r/IPQhvsDz6lvBaO4pxQhoNqxGt1UTZq8sLHpNgC5kK91MnopMhJJpS
	w2tCc5W5SRWH8c4FdaAbZ6MHOWC5wMXwf5rFzDYgxoYnOf1QC85YzCYaI3RzRd56
	/Z+Xd2GdIB20Dve0tS3AZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745304621; x=
	1745391021; bh=qMaoeiuIytpfIHfIWEtyup7XB4p00qBFM+IrbAgf+JY=; b=O
	20m2hLZyA4/ZWnIaxcNdV/0U6KWuIGm/O8TjSt0/OvZyW5F3uLVEXwQsyhMhffaX
	U57kxM6+dSFjvi9bMAMAqVC9bc4bFkrkpn8uih0l5eiSfJn3Wwi8SzCOzW6uk/Tf
	O18fu5PxLq1kt2is2LYRYupQXhYrb9HjTyRxKLGlMcWhRxcTKlQgK2OPTJGYvaG8
	P4m+Y8+OcGR4JX0vCJ9C9TBrQqXfdg7DgPTCckAtFwtXKCga3QHKEYbx909DoPiE
	RRWWA9359+xcJ1X73ex4Ly/thmh+pqt0vS5oH4LRXNPFspoA4gywVHaq/4fvITFo
	7FEFnpLm6dPq6pwJjiTRA==
X-ME-Sender: <xms:LTwHaJFeOtDswqwPyfNI1PlLAh7i5sCdambTxul85VTIjQHDLEHmFA>
    <xme:LTwHaOWlck21EdjvOUD4YR_Gh-ULE5w1zFFsTIXtZ5yV-Wd-PNhG1iRmqgP9PN4ep
    zwFqF635dOllX91-g>
X-ME-Received: <xmr:LTwHaLK4WHeHMElQiCAxgIxpt0dnr_-XdpDbasz0KgXwmr_hzSYyXRI6ySrMQvNsNUIU17xgaKhaD_qDQurS0uoVi6IsmE64o7Bds1BqeYI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeftdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhi
    shgtohholhesthhugihfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:LTwHaPH7sWuhiHPoKKgkjAPTRV-Zy__4CF5CJNCVTRxSfpmvaju4_A>
    <xmx:LTwHaPWPkj9t_5dYacJodnHBlgaxSlPAn-gsKzcnOlXOP6H8n1s13w>
    <xmx:LTwHaKMFgGuyV2sdBJj7HoxCGV9aefHLyYV1LM58-Ng4QdtMxWAMXw>
    <xmx:LTwHaO1pdMlBEzRPgSo3d1zDp3cd5nmRE_VQzxhFoX0JigBYLHcgtA>
    <xmx:LTwHaNqMzKct_UYaysFF2I_4LkC5EeE6GKq6c9au2NcaPDjETXSM4t6X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 02:50:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 90455326 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Apr 2025 06:50:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 22 Apr 2025 08:50:12 +0200
Subject: [PATCH v3 2/5] t/perf: use configured PERL_PATH
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-pks-meson-benchmarks-v3-2-7aad68bac6fd@pks.im>
References: <20250422-pks-meson-benchmarks-v3-0-7aad68bac6fd@pks.im>
In-Reply-To: <20250422-pks-meson-benchmarks-v3-0-7aad68bac6fd@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Our benchmarks use a couple of Perl scripts to compute results. These
Perl scripts get executed directly, and as the shebang is hardcoded to
"/usr/bin/perl" this will fail on any system where the Perl interpreter
is located in a different path.

Our build infrastructure already lets users configure the location of
Perl, which ultimately gets written into the GIT-BUILD-OPTIONS file.
This file is being sourced by "test-lib.sh", and consequently we already
have the "PERL_PATH" variable available that contains its configured
location.

Use "PERL_PATH" to execute Perl scripts, which makes them work on more
esoteric systems like NixOS. Furthermore, adapt the shebang to use
env(1) to execute Perl so that users who have Perl in PATH, but in a
non-standard location can execute the script directly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/perf/aggregate.perl | 2 +-
 t/perf/perf-lib.sh    | 4 ++--
 t/perf/run            | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 575d2000cc1..1791c7528a9 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 use lib '../../perl/build/lib';
 use strict;
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 1a9a51ca3cc..4173eee4def 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -276,7 +276,7 @@ test_perf_ () {
 	else
 		test_ok_ "$1"
 	fi
-	"$TEST_DIRECTORY"/perf/min_time.perl test_time.* >"$base".result
+	"$PERL_PATH" "$TEST_DIRECTORY"/perf/min_time.perl test_time.* >"$base".result
 	rm test_time.*
 }
 
@@ -324,7 +324,7 @@ test_at_end_hook_ () {
 	if test -z "$GIT_PERF_AGGREGATING_LATER"; then
 		(
 			cd "$TEST_DIRECTORY"/perf &&
-			./aggregate.perl --results-dir="$TEST_RESULTS_DIR" $(basename "$0")
+			"$PERL_PATH" ./aggregate.perl --results-dir="$TEST_RESULTS_DIR" $(basename "$0")
 		)
 	fi
 }
diff --git a/t/perf/run b/t/perf/run
index 486ead21980..073bcb2afff 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -192,10 +192,10 @@ run_subsection () {
 
 	if test -z "$GIT_PERF_SEND_TO_CODESPEED"
 	then
-		./aggregate.perl --results-dir="$TEST_RESULTS_DIR" $codespeed_opt "$@"
+		"$PERL_PATH" ./aggregate.perl --results-dir="$TEST_RESULTS_DIR" $codespeed_opt "$@"
 	else
 		json_res_file=""$TEST_RESULTS_DIR"/$GIT_PERF_SUBSECTION/aggregate.json"
-		./aggregate.perl --results-dir="$TEST_RESULTS_DIR" --codespeed "$@" | tee "$json_res_file"
+		"$PERL_PATH" ./aggregate.perl --results-dir="$TEST_RESULTS_DIR" --codespeed "$@" | tee "$json_res_file"
 		send_data_url="$GIT_PERF_SEND_TO_CODESPEED/result/add/json/"
 		curl -v --request POST --data-urlencode "json=$(cat "$json_res_file")" "$send_data_url"
 	fi

-- 
2.49.0.901.g37484f566f.dirty

