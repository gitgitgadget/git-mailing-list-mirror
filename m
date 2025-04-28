Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EB817BCE
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745825459; cv=none; b=ToCP9tNDp+QXaSzc2mWSmSJXH9wcYZShYES457CHZIaQ7CihFWwushwbtHWb+Jv4VrNl01Ba/NLSgWYsp6IlB+R5zhiYf03NIHE9cCzxghXjB12crHmFuSKPBlkcrLJlvInmSBZ7UJOsSddM23nzcvlW5evTAhruXHW8+G6yUhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745825459; c=relaxed/simple;
	bh=W3g65cPMrQxn09A7JpkRVjfKi2jETDD0rXtBLTnOpSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J2KVhWJj8Fj9ZzBlmjpb9SDtJUSmwhTb9pcUM8EID3TEUaZ/lFRlKsTYyZudqYIAfM2YCQRKiotxLow9vX9k3zgDYED33I04cwPyHZyyTEhT3nhL1gsRzVTrZ0w+wASChz4169wIpf3yWruq4ZkJaFtsg1sICKm30/6Hd1SiMOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bgkxXb37; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UF+R21b8; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bgkxXb37";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UF+R21b8"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6B17D114024B;
	Mon, 28 Apr 2025 03:30:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 28 Apr 2025 03:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745825456;
	 x=1745911856; bh=HnzqoGZKZOTMaIS5NBlqLtw2y/aq4TIm9N/lssVZhC4=; b=
	bgkxXb37gTWOUDpzm1UCTeCRHXFrnr2AfdMVrWufZGCWGqKqF+e6c8RFQgLgdfZU
	LtsggMT5JouWmVzh1j1RaXUkudXXzz+PEXsSuzmw9Rkx7Lw9VsN5FCKVMzukPQCP
	i9Hbj2mWF75QbG2gwBBd64QQ6hKkkNhfHWVALnCMrggrwh7PVf9j2NdXKyM45gQS
	rv0qnaq81ggQGeDlJKiCvYYOsX+PEba5QoVjcwmmNiBBNvRscTmlOrTjIWvcJhhF
	3mq2LLBGQW/aPnVMKRwK5jApsQMb7FYl3rP0wE39cIez/GkR6Ct6UiybXqJ0rTsw
	f2Os3ywFMa19z6DFYNgWbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745825456; x=
	1745911856; bh=HnzqoGZKZOTMaIS5NBlqLtw2y/aq4TIm9N/lssVZhC4=; b=U
	F+R21b8LxM2I43v8ynnZ/GjjiWgkfdLeWWGaTN/ClpRpkyVvbyn2xGPUzlZiEKBr
	fx+EzqHhRrSNs+3HS65we8qHOeoMc+wliKs2UNiMd3HADDHtH35++14IUY6ahpZk
	O2yVKOKzDaXKWn3MbI6CrgtnJAsa+WqVFthmuGvVjS49mZnSqmb/HPbrp9w6mggY
	l/tLvD30o6CsrVLfcJoWsAirjuAOn4Wm96AeOxWRYi7y0DL4jUftyeCl0fXYgDxA
	pJyOJYbAvu5A0psTZ0XzuP7+uywG5pn8Q2BWUlmOaqsuiFG2t1lSISBeGVSTSVNT
	MpENg7QOsS7BJ0YeQXL6w==
X-ME-Sender: <xms:sC4PaNSULY0DqaLDZ1ZvxujMg9KlAjxQSFLGRBvdXL78oGpStqxAuw>
    <xme:sC4PaGzyhGPK0M5N7JByEFhXf4nbFa95CptzTB5mTj8zOmJcZ6rEgC49XUwSbJsdW
    kRW067zckVsMHqMaw>
X-ME-Received: <xmr:sC4PaC2YWOwhO526tvbByN4Su3DGg-KmmR-0an_omvojmqhSL8O870A8ds6TcwElDX4-znbT4t6rCziTXbyvXA4DppnJbtoMhQpFZNijM-t2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedtfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegt
    hhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepthhoohhnse
    hiohhttghlrdgtohhm
X-ME-Proxy: <xmx:sC4PaFCl0M5NftrTOUzpMBLSUU7kMjP98Ok2FvdrjtlCADIRRPaY3A>
    <xmx:sC4PaGgHYIWQO5Ry5skiaVBhv1HoGHtK58jzJ3If8UrafSIw5HoiqA>
    <xmx:sC4PaJozUZVHYzOtL8YBGFa2ruaepIYAjzPXa8eTRURtHEOTGt-f_g>
    <xmx:sC4PaBjmhBjUtX8ijRoSSG02IGQ_RQe0pHhF4OAZuk4PkZZDncKg_g>
    <xmx:sC4PaMFg2MotpA22Ox1rn9WeMZfM72io6OWssTYPvx2m9XhzV5C_criG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 03:30:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b3923f6e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 28 Apr 2025 07:30:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 28 Apr 2025 09:30:47 +0200
Subject: [PATCH v5 2/5] t/perf: use configured PERL_PATH
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-pks-meson-benchmarks-v5-2-5010dd014d1d@pks.im>
References: <20250428-pks-meson-benchmarks-v5-0-5010dd014d1d@pks.im>
In-Reply-To: <20250428-pks-meson-benchmarks-v5-0-5010dd014d1d@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
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
2.49.0.967.g6a0df3ecc3.dirty

