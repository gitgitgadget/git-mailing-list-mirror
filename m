Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5171B041E
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 06:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744613479; cv=none; b=PYDyHfKucYx4oZw7FyOguwth3FvVWM3uLPsri/9bk7rqQHDxHTl2/KJfUkzVhNu/Mp/Fs52U3prs0YNcuncAibsEaMClqLo2X5v8w4iu7/sG9s/UcfjC+YNL4jnZejMR0LePLuLfCwNbFUgLbwaNTnRVXXAzkCgKr0RMgmlvPh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744613479; c=relaxed/simple;
	bh=p45euj2zT55CptsN7FOjhIkoGTMivqNz1n0ktvYEaC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=lN+ujDmicJAlT+Q8Si4sJHNcf6wQg7KdBp9NGwy6eQhGjq1CCflulk7krJHx/j0RNwAOm/Ywq2X+C+Pg1PjVqMiTfltQ7cEdITQib4Ch7L7ytmUtaACVXbk89XtgbiEfy44/e6rsZbDl/esUpo8jugaURRleS3ABJCKs4BsZ3gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oBWwXQqa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uxqy9qOb; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oBWwXQqa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uxqy9qOb"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D5A2825400AD
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 02:51:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 14 Apr 2025 02:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744613476;
	 x=1744699876; bh=Pe4py9shOCNcCcSB5rV1c1mRpexZp5AI+99EoAe21Qo=; b=
	oBWwXQqaNVa7ktQAZ0UdU0Sbkc5JP7qC+OVCtny80lhXWHjz21qpT2WrWoayrCzP
	XEl0yk6eLmfT1RObSf7R9+YmKpeuBw7HYapplhY1ju36syshJ2wXog0nc1jRJWrB
	BgSYwcT5rsHdHopym75OKDlykfcbLG9aYpMskrutJal8koVwV/Ss8mTDPEMx6FkJ
	mm1ukRphuotBYpUFKY2lRR0D4BG2gJnfRyDN5UjhwtfpUEBVGFYzkSI1OmzZ5fAw
	abrcLr2bzavVcj/WBvRH6FFslNndYfzwXAAug9gmhNA65GML9//ZuS/j5LUO/mil
	LZzh7tbk40ihf5hrGScq9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744613476; x=1744699876; bh=P
	e4py9shOCNcCcSB5rV1c1mRpexZp5AI+99EoAe21Qo=; b=uxqy9qOb4ulISaXlw
	BTODqBfngh++bo+OU6LCh0U+/CK/GBfUBqCjjdxdl0cOS3LNIMQYYAJuPmGaj/76
	Wt+YLdCTnYQnBF2vV+IgrH4wV1qq4XC3oyyhsUop8kXqQWr1ixKvdc5lY+BYV00B
	juqD21StoxliP7XNZ/T0doz2tWGi6EacO2nZotcZTtrvHdfg4CSa8OdkBqfTzkkv
	OYnZyRguB6IR/YmB82g0nHLA6bRBvvCUtKi1YJ/k+28MEink3agfc8diQiGeAoHG
	h2kW7ba0ZLjbukhzOfnVvbe/2iKSB2Pqo9TQdx8wcsxWjoCYodjnS2GrX303HY1C
	Gmv5w==
X-ME-Sender: <xms:ZLD8Z7ANvJLrc85_2OciaBPhm0PzdwjtmsCwaywsUjS54qF6Rej1Mg>
    <xme:ZLD8ZxgQlPQmcrv3DTKEgE8NWGNdY8JnNNiTOR41Z8J4T7jU-zarL5_HCr_Ers-Hv
    uilgxlOwkbbZvNcZQ>
X-ME-Received: <xmr:ZLD8Z2nCAMemDFr3C_SM-7mJn94TBWQE67R1GfkfP4C3jOQ-621mnpG8Eki8GDfreUvUEc1963_rHme5AQcXDHPbKA9ynqKsPFV_DDmAQ6IS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudelkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvffosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeelueduue
    eljeelhfejueeffefgtedtvedtfeeffeevleelueetffegteduffegleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZLD8Z9yIrPVK10TTE8o7GT5basHYQby26CMqv7lsArkp7kfnnFIbaA>
    <xmx:ZLD8ZwSyf8xr4SdtWokKEGsFqzsj2O6ah2nyzj8gSxtpM7DjedVAdA>
    <xmx:ZLD8ZwYA5eCcs7GWtD2zQZOmmbBCYfTqyFF4t3OKuf4vu1vIWmYj-w>
    <xmx:ZLD8ZxT4qyt_pBJ2X-USeBQKdwXKPPSZOL_kwXeYUMj8t8qJYY09NA>
    <xmx:ZLD8Z5-YpVrvhp-fJrzEw2Yl5SuW2odpLDyUjVn291Z6GRrB0iyp07qO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 14 Apr 2025 02:51:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 28f0e80f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 14 Apr 2025 06:51:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 14 Apr 2025 08:51:12 +0200
Subject: [PATCH v2 2/5] t/perf: use configured PERL_PATH
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-pks-meson-benchmarks-v2-2-04377080a167@pks.im>
References: <20250414-pks-meson-benchmarks-v2-0-04377080a167@pks.im>
In-Reply-To: <20250414-pks-meson-benchmarks-v2-0-04377080a167@pks.im>
To: git@vger.kernel.org
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
2.49.0.805.g082f7c87e0.dirty

