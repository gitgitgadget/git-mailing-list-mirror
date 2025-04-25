Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B398022AE71
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566103; cv=none; b=X9jD+XEtaLQHHLE0edKxbbbv9jysq2pN6SN+5N9+9OsBjeG9+5d0LcTp9644g9azhRjj/hxSyt8nNSTWqPG2e10ZCuReT2Cs+QbVxEHc6KQsmFOrig0TwM8gvYqfDq2fIF6KEBxoNMhyEL06C/tKOU0aw0nevGieOlVCFkQmN5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566103; c=relaxed/simple;
	bh=q8B05t79a321aNjFYW8CrX5lf7QGvrIejql9GPWOOs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VMhIqiQwFS4bpnhl1mDK/NklM9WPHLFffMW8EcjqNKAJYZ+pBUJmxBBhzQEuVHcsPOBGUsze1OL73Hsu75TN5RamGGJDZN/Pvd4G7TNusLoaIRl3sJgwzd4AfiOZ14Cbjiz5x0GP8U7tjJSZuZwUA/Gb56aqvfeQj+wqCwKMWDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a57S51BE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H3a8IwF/; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a57S51BE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H3a8IwF/"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AFE6F11401FF;
	Fri, 25 Apr 2025 03:28:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 25 Apr 2025 03:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745566100;
	 x=1745652500; bh=qMaoeiuIytpfIHfIWEtyup7XB4p00qBFM+IrbAgf+JY=; b=
	a57S51BEHOkZw9k/THbtKqD0seX8hWxJI+Td7ucz2fkpdxkPOxxOuWwMhVdHO63M
	fHo9N7eMXgTzWwf6niuXqT4zltfyiCbNlWUdD42KDm9+L3w6DV0FGIf6SSdohSRI
	iXdzlUJl9IzXPm5hIqR5yKaPsF9r+vGnaDeIIUmpZEs01sh/0hiCKHb7fk10/Ib4
	beK8sGLlbc3umlFIRjNXVIMBk/A4qhRs69VeplnKPD3NRRtn8Ek6ZdNuJuPozA9h
	fapVQVPDr1RiOUibimPHJuTHRen67IJv1wiqMuEdVIi6oB8cM5uUMIJGS/qrMz9e
	TmTr3sf67upJJHwpiA1chw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745566100; x=
	1745652500; bh=qMaoeiuIytpfIHfIWEtyup7XB4p00qBFM+IrbAgf+JY=; b=H
	3a8IwF/kUkqcmqLFDxD69zqKyFLMySgm0mkayDHdpm/mC5TVl9HKZYv1NU8xV9LL
	XvFkjmtxhbNV6+0//bzdYB2k6npQGdxlo36WvkSzeIfwOLwECg/63lya8Y4vhfyD
	yPkr9SjfUZJ/MTxBLfw6bZ0bEIzugvMqAF9pDTx9D+8Yb98JNuw80EnOaycPhMhk
	PA5oesG1feux6hpOTFIP3en5U0uRmh+DtOrUi0pKEi2BkWXx+NTNqb3bDPGp40Qy
	DlpHBuqR2CCegJwIv8LoR+bHqGz1VBkrrVDzDFzogm5CHqw3ZkonbG5z0kYSEb62
	hOy4BetTb6Pu3nJFkUESw==
X-ME-Sender: <xms:lDkLaL6WJ-uix5ssnpE4dqgECq_lN22eemnzACo2kvSjk8ulJATcNQ>
    <xme:lDkLaA7_Z7RZ2CTFUrpPQ4Ls8rnFe84qx0PKIRWvNBnILhUXkSZiul18uQdBqjjYR
    BnMMDMRMv3yfdp1ng>
X-ME-Received: <xmr:lDkLaCeFtnux4z5r707QxxuGk29unnNbKhoCnmZswtv2kuVg7_u08yvubWLqGpeoHe3HnYUuIrcKWBRxD6I4Tvz4-xnQfQa1cMV2lq1r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujeegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:lDkLaMInL3-Qha3NuLAT5TiaHKKTLBFGcF7ZJVUyK_a4IbqdPsp5Jg>
    <xmx:lDkLaPL956N9686wcybEe0N6EFK5BLJCpkEliwNHeNm767miu5XL5w>
    <xmx:lDkLaFwo7a8AdsFRDFDVJqP2pW2zA8D7rPFYCiXlEtcvk9ehSDvy4g>
    <xmx:lDkLaLJoqmniEX_ok-WRzBhjzTbGokObkuBemyJIOQWDCdUmtHSxkQ>
    <xmx:lDkLaHsaIelr709DAbjHdJyRoWNReuLwZ2GsLQHD_MiLkjSnl1dglg9S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 03:28:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aaf92e3b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 07:28:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 09:28:14 +0200
Subject: [PATCH v4 2/5] t/perf: use configured PERL_PATH
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-meson-benchmarks-v4-2-6b89555052c3@pks.im>
References: <20250425-pks-meson-benchmarks-v4-0-6b89555052c3@pks.im>
In-Reply-To: <20250425-pks-meson-benchmarks-v4-0-6b89555052c3@pks.im>
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
2.49.0.901.g37484f566f.dirty

