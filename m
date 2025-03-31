Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11EF81AC8
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 06:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743401829; cv=none; b=R3qumdmHRdtcl9Y5LEXAVBH9E0LKzLxjRtPO2RQ8eBi4ihhIShzCWE4UZ9pyOR4r/54s+5Ri1ETYmK9mu6l2KJKYIvP/Tz4RYifVO18sSiuHOaTp4Q1pcGIji3HMtOG9OTDCvfNAzVNgjVym7fMvbGLu8mqxUSgZr8yM/p6AnXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743401829; c=relaxed/simple;
	bh=uD7dl4sfd7ZNmM5x0m7AViwf1RkTYkVrAUxvBB51YfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CvEVW1uaUmaJ1golpm5fjIQvMcNAGvGrydxdsVLg8eYqaDICVX21DzjpOT5gfz3eww4sXFxQ9Am6SVuXtO+7U4P2pVq1RKcldmseggHhQBrOhNK2Nfqaa7jWgFd1YvNYG7N1sy7oBnxhoHhYIR2s9rTzeaxFKwfOvNczSZKHy2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c9NNBqbT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GpQYyxfS; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c9NNBqbT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GpQYyxfS"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BE562114013B
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 02:17:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 31 Mar 2025 02:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743401826;
	 x=1743488226; bh=St00EI3Dmv3hm2bCdH/Qr8Jz8TJbsf6tdqk9gEwUZ3U=; b=
	c9NNBqbT79rUXcQ8Phen8L5/JA314HtzEXIt8iCfRAO/o+PU1uewWFHRIRhK8Pvw
	lTzpShlaO4hOEUaTXpfZVXFAwmyTdmejhv9IbiBjkW27rz33orEzfZsQj3PamQKW
	vZLUxZ3cCB3ViZpi6PJ1/3dCNdcDnp2iZZsrUs6NS6bMV+82B8VlbL0vqM8qcE+w
	Nz42TElADFH34SNb6yYcGbIO7eo4L7iydWYvPRfE1kGJv6OT+3gi3alrKTzdIKGR
	IOpWbhhr5/RsO+tjzpIRTPMOtN6oHkSnXVTalDOdHO5gFfdGfQT4QP/J4yw15nQO
	GFrhDOxsf31kGaNyKnn1/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743401826; x=
	1743488226; bh=St00EI3Dmv3hm2bCdH/Qr8Jz8TJbsf6tdqk9gEwUZ3U=; b=G
	pQYyxfS/hXEp4BcIkBkSAzBMfpuT9+zdRrL+pnE7DoAPdgwyuMZ/rdWiP+h9MxeV
	uB1G3aH4YygA1Z1pca2s+Mjl4TfBGivaywCFE5fgWs7ke+HlwhhCK/3WoZDJJmAM
	SXT8+tHGJMaE7XdZlq4Tk0p4mESaIyEhFnHDVtrWKPqKrWYIevGP0VrCQwvVjTD/
	Ntdc+54O+zYW3ZetapppjU2DbDgtBUy6wjZllYufXC2q5slC3qI0RbIznO274Emj
	s1YuhrMdsghnCEZCSvR/XUd2QuImdMrGY3HdSyeNwn7B47WYox8uKRlu4SFFCcwa
	Ud1uOOSGaQK7FO4y+Nfxg==
X-ME-Sender: <xms:YjPqZ3HpI-eWPos1OEG7tMHsuH9bqV0E_AxKTerg_O5BFVDZ-q-BwQ>
    <xme:YjPqZ0UHKCjij05VHgTrGEp4b8oQZ1lrXucAXFFgi0PX_yHQrFVFbJk7WozhD9nb7
    cVEzISZwLN3ZXeLtQ>
X-ME-Received: <xmr:YjPqZ5Juj5DOyrN7VDM59zNESv7K9kavg9_2MTWBTT26vfl5Sq85UOqTt97dLwJzdR9kXwE5V1ijtYNL3ZpgTzC1_RD06kTkVd3BLjQhagUEkCS0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeeludejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YjPqZ1Gs5DneGqxS6YZrJ2xsQE6uDIVzAm44SxQ9zc0uIn9RrBswAA>
    <xmx:YjPqZ9XoHW7RLICGUpDfIOBGt1rmq9LWmARZZ2UnI7lPJUmRFwZuvQ>
    <xmx:YjPqZwMdLp1lLy8PmoYyKek0SbfzhYgXx7qvr2M6lyZNSaLcgUGnDA>
    <xmx:YjPqZ82dFCb6V_wWl6ISEHVmTEDolSvj6C2qk-tJBbTpMy4XGD6vMA>
    <xmx:YjPqZ8eQjM8-9FFVeAs3Tl2s-ztjzqImKSPp_8pcyV8lYq6TEOrmV8Yh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 31 Mar 2025 02:17:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bf8972c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 31 Mar 2025 06:17:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Mar 2025 08:16:45 +0200
Subject: [PATCH 2/5] t/perf: use configured PERL_PATH
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-pks-meson-benchmarks-v1-2-b2ace85616a3@pks.im>
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
In-Reply-To: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
To: git@vger.kernel.org
Cc: 
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
esoteric systems like NixOS.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/perf/perf-lib.sh | 4 ++--
 t/perf/run         | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

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
2.49.0.604.gff1f9ca942.dirty

