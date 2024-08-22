Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565EB17DFE8
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318271; cv=none; b=UH5d2EPliEcwWSLefVSlPpNityz+7yq+gpg4Q5V4BB23EKLmy0ehq14F3GBFG1nxWScwOVo5veMPZBx6q+YdrMQdVbe1RfxwCW/FFxmyEWfqSCFhrUl/WgV/jXwvEtoHtJdpGtgh5NdJIodoKugChJKyLhCcd8XDI4DUe1pJ67U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318271; c=relaxed/simple;
	bh=C5cwareO0W7oYeLcgZkeCKuwuCjDCFyEOhsDpvAgKxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMkQfBAPfEClYUzMlb2gR2Jow/n17mjsW4weaqHJb4tFJvbZgNsdPVA9aFwn2ZlPryo28o2+aKHYdj7cI6X6A3cu/wLpoRi7q5YWAxXxSE1J7y/mCOT5SMIacV/vfUsIwGtKkodgFY/xCVOE28DPhx+t68uleyFm6lFBQemcR08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TlM49yU6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FlU8nZdz; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TlM49yU6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FlU8nZdz"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8732D138FF86;
	Thu, 22 Aug 2024 05:17:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 22 Aug 2024 05:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724318269; x=1724404669; bh=8MsbH4+FTr
	HtG/Xv2YoGxlTRjel4tAHFGdg9PDQNSMg=; b=TlM49yU6gOXoan9oqy+jSFp7ir
	ZIcoKjrTBt2mH+UfvLwmow1Vo5Xvdr+wUqV75PgEdjqqiwADuep+AfusvplUX20g
	7HNYxaHYTS9/cUKnu2aBkro0NNHjFfEShYaFNLf+htRAAdBXgbrkC/cj6KDUHorb
	Otm3BdVPgtOvIq9QvR13Al28jrdUnoYXpR/y6RNZVKZQhiSYtTochyI/6j1qcLXo
	/opSwsSXkHHOBQqz3tnW6zWptZS9QmfwkhXF2JcwrEPIIf0v7njEApmLXz8yRnXI
	tUUG0Go/sjW/JQs/Tgl8QPlF/suHo19+PK2dr6HM2qbAWHJaVcAqGB4ZZKlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724318269; x=1724404669; bh=8MsbH4+FTrHtG/Xv2YoGxlTRjel4
	tAHFGdg9PDQNSMg=; b=FlU8nZdzACPEkVHiyWc3BbjbEb5whOIQLufK8A9H3dr/
	hsi+wTzrbNmsRhY4nejqnfA7h0ZLH5w0bu7yFfgN0cZpWgRAzi63PU6xe3Dlwi7Z
	joSNfEHCFSiYIQADdvRC7TeHpU0F0b8Mhbmb5xi+qImUVxXbqhDKn5XjHLNeSMjD
	gi2YhDnvsHvFsdL55fMoIiKKFzw5+6TKcK9Qs9Wa1s50z5YT1Sc+H8f+rhALtzdp
	BSlgRqcLpUC592PldsbZLTh2oLvpJ2MpglRBBbTo3KMu+rQFPDziKVgakfJZICFC
	X+76zEfhr2RCDKZYBbi0G1HKLrGsfV6AsU6ZH8COQg==
X-ME-Sender: <xms:PQLHZryELNn2rne0OwWMSfcLT--90FbRlidMBQoZ1rBiIaHTDRJDZw>
    <xme:PQLHZjSIeySuFVCIUsM5ejugDf4WNg01b7y6lpW6DyRnMpy6J4W0EDJlp5nZ7zqud
    LcVlWYaFzo33Styrw>
X-ME-Received: <xmr:PQLHZlUOSCRhNt_2LXxYTXbEP1YDUDbZ9-l8354X5I_Ps9dXgeb1ihI86VxFSXCn2dtHeeluOGUQaDT8nQQjnJVrGmYRPrkuGWIClLFieJzTlE8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeethfegfeehhf
    evfeefleeludefgeegfeeltdejleeuvdeggfehjeduhfevfeehgfenucffohhmrghinhep
    hhhtthhprdhshhdphhhtthhpugdrshhhnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PQLHZljkzWD50JmQFCU0xra02QxrIENRqvlppXL4fcRLVxUZDd8l-A>
    <xmx:PQLHZtANNUC3tfqM0wNQs2_csP6qVx-kGJQB0weBot48_8E7X0tGSg>
    <xmx:PQLHZuJdpp09O4kagiW46SXVqvsczG96pzqyTCa_2reRm-bUT7zwhw>
    <xmx:PQLHZsCWJJNXM0AqY_paYf8ypwMAAVRKFG1A4Nuhk0LVrh6gcojHgw>
    <xmx:PQLHZgMFRiZyNVbv6plAk_x-I06rF5-8Z0HhwzXmc5CVV3uNOSWIUCCb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 05:17:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a41298c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 09:17:13 +0000 (UTC)
Date: Thu, 22 Aug 2024 11:17:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 12/20] builtin/send-pack: fix leaking refspecs
Message-ID: <f4300c9326b6ab4e641cde8efd9ca87daf368628.1724315484.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
 <cover.1724315484.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724315484.git.ps@pks.im>

We never free data associated with the assembled refspec in
git-send-pack(1), causing a memory leak. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/send-pack.c           | 1 +
 t/t5400-send-pack.sh          | 1 +
 t/t5401-update-hooks.sh       | 2 ++
 t/t5408-send-pack-stdin.sh    | 2 ++
 t/t5548-push-porcelain.sh     | 1 +
 t/t5812-proto-disable-http.sh | 2 ++
 6 files changed, 9 insertions(+)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 17cae6bbbdf..ef0df808249 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -338,5 +338,6 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 
 	free_refs(remote_refs);
 	free_refs(local_refs);
+	refspec_clear(&rs);
 	return ret;
 }
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 3f81f16e133..248c74d8ef2 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -9,6 +9,7 @@ test_description='See why rewinding head breaks send-pack
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cnt=64
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index d8cadeec733..3c1ea6086e7 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='Test the update hook infrastructure.'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5408-send-pack-stdin.sh b/t/t5408-send-pack-stdin.sh
index e8737df6f95..c3695a4d4e3 100755
--- a/t/t5408-send-pack-stdin.sh
+++ b/t/t5408-send-pack-stdin.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='send-pack --stdin tests'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 create_ref () {
diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index 6282728eaf3..ecb3877aa4b 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -4,6 +4,7 @@
 #
 test_description='Test git push porcelain output'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Create commits in <repo> and assign each commit's oid to shell variables
diff --git a/t/t5812-proto-disable-http.sh b/t/t5812-proto-disable-http.sh
index 769c717e88b..f69959c64ca 100755
--- a/t/t5812-proto-disable-http.sh
+++ b/t/t5812-proto-disable-http.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test disabling of git-over-http in clone/fetch'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-proto-disable.sh"
 . "$TEST_DIRECTORY/lib-httpd.sh"
-- 
2.46.0.164.g477ce5ccd6.dirty

