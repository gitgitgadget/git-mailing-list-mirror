Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3050D1FA82F
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735915631; cv=none; b=MEuJIEj1Jfs7LRNTkQyOekkD1ncHeD2QoqU21f4/zSU9n/6WXqupfJ/fetg2dSiCckHLO4B1+8yVcPtc+l2gtBNPn5Gps1cKMunmaxeKNKKO5onCbr9eIM77uCC6gILNsWF8AhhDPUDk95N/5UMizLMjfez+PqsIkThCONowFtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735915631; c=relaxed/simple;
	bh=HMH0fpUN1uI7/2bWhxXkqOcvNXEH6e4k46mtsF6SdSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IGvLX6xulZZ8X+YdMAqAQA9EZ0TybzoVUKiyXIjqYlMLQfBvW6GHT72uWVZpuHwpLOuhAj9ixT5qzTDRWx+XMIjoaUkKtW2N52MtswWH0+Pnts9yjUUnkTf98yYij8AmGtYBR2wDGFYPF+AlCQJXp3YY4Nr8CAr7PznIrv25+po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uw5QUDR8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ORbCZFwo; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uw5QUDR8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ORbCZFwo"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1A4B313806DA
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 09:47:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 03 Jan 2025 09:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735915628;
	 x=1736002028; bh=oML5C9rooFVckFk2VilofDdmvx3UowN2qmRzsP2cyEA=; b=
	uw5QUDR8n9aTcuUw5rH2iZiZqXGZsBYn1DcAk4a8RTaRlDTR65b+lEVnSlgzU9EF
	tN7QYq90Dm35f8xVZ1l6z1IQl+ESWjMZ7ueuoXkfbnyG29WEFZByr7ENigix4t4c
	tTyBusn1tDXF7cV07KAeli7EK9N9MHCMP+PxpeceOiNi0o5+mUdDmeLLI7TXy6by
	JaDrjHvtwDHncA36Oyx6Vlzdp5azcVj+EzSPcNLFLEywTz1Ts1Ee2o4WxXHdTcLo
	UiMCC/PFJg38Eom/m2MuY4tG6Rs9LXau6n5iGhd759tzz4uzMnbue83rh+HborhQ
	mMx6XUzh4fDgSF8PungeAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735915628; x=
	1736002028; bh=oML5C9rooFVckFk2VilofDdmvx3UowN2qmRzsP2cyEA=; b=O
	RbCZFwouXJzjJgsVj2LKNbq8AS977yw/MMZr0RNG7ebAdH0tkrAlwvSG9zTGmGyN
	HwwNFUQk+5btLW0dL1x8bC2eb4U9Nnkqb+fsKt0p8v5Nj6KutGs2x5o5zeyr6jgn
	SULX7zZQ3Q2j28RCcQNyOnkwM+hTVfr4m9B51r/VOa8yZere75MONZ8lz1FM5mx0
	6yI3PnUwLw5qgui699+CukKhZlR7C6R8vtAR3qiLAuvene8hd0NLOsU+axhUpRQl
	Q+koduaeprq7V/7k5hgrsIdKP5P6DMoyVXvPfnhgl+sCsAfJgieRngv2j3LWaY/F
	LmEa3uAXrDh5Bkkp5Si3w==
X-ME-Sender: <xms:a_h3ZzLU1oA8o-pmWm7jDKfMBF8H8bVN36CFdl9_TzLVbEJhODIvHg>
    <xme:a_h3Z3JhKyBvIIvrKet0DCoOI_PkAQTj2kQKwKSMqtJNjjXhXyth7boOvvaxpwxbq
    JL2_1ZoykPzoDkv-g>
X-ME-Received: <xmr:a_h3Z7tBfVSnbNW6guBDpcPNZR377buQg5tczArUIGh127Bv5K3uYDxGLEqWFVPlzzL5RXpXB-xTkgdpMCP6nQibOaw4E4FrkYFQxv0T0IyF9FQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:a_h3Z8ZqqokxlSoUhiMswUmrfivjVo7dYtOk8b-cD81O9fIMJbPqJA>
    <xmx:a_h3Z6YeSRhA40YjGeDymWyHOOFsWfXSFbOnmaE-vQayW_nDvhWOsg>
    <xmx:a_h3ZwDNmb7yQ_m_qhlgoZkh3NcbVFMDI-scDA_DkZisGwEBckVVig>
    <xmx:a_h3Z4baR8R-2afLN0PcuxH6xESpY3TWIA-cMkdtHBDlcaEGXbCKnA>
    <xmx:bPh3Z9zIPRtG9Yj9i8DInYb32unvz15Yp0ZzgY47oTPHhKv19eF12M4w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Jan 2025 09:47:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4bef1e97 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Jan 2025 14:47:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jan 2025 15:46:39 +0100
Subject: [PATCH 02/10] t7422: fix flaky test caused by buffered stdout
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-b4-pks-ci-fixes-v1-2-a9bb95dff833@pks.im>
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
In-Reply-To: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

One test in t7422 asserts that `git submodule status --recursive`
properly handles SIGPIPE. This test is flaky though and may sometimes
not see a SIGPIPE at all:

    expecting success of 7422.18 'git submodule status --recursive propagates SIGPIPE':
            { git submodule status --recursive 2>err; echo $?>status; } |
                    grep -q X/S &&
            test_must_be_empty err &&
            test_match_signal 13 "$(cat status)"
    ++ git submodule status --recursive
    ++ grep -q X/S
    ++ echo 0
    ++ test_must_be_empty err
    ++ test 1 -ne 1
    ++ test_path_is_file err
    ++ test 1 -ne 1
    ++ test -f err
    ++ test -s err
    +++ cat status
    ++ test_match_signal 13 0
    ++ test 0 = 141
    ++ test 0 = 269
    ++ return 1
    error: last command exited with $?=1
    not ok 18 - git submodule status --recursive propagates SIGPIPE

The issue is caused by us using grep(1) to terminate the pipe on the
first matching line in the recursing git-submodule(1) process. Standard
streams are typically buffered though, so this condition is racy and may
cause us to terminate the pipe after git-submodule(1) has already
exited, and in that case we wouldn't see the expected signal.

Fix the issue by converting standard streams to be unbuffered. I have
only been able to reproduce this issue a single time after running t7422
with `--stress` after an extended amount of time, so I cannot claim to
be fully certain that this fix is sufficient.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7422-submodule-output.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
index f21e9203678b94701281d5339ae8bfe53d5de0ed..ba843c02c9c2da198578aec5716813de32960b86 100755
--- a/t/t7422-submodule-output.sh
+++ b/t/t7422-submodule-output.sh
@@ -166,9 +166,13 @@ do
 	'
 done
 
-test_expect_success !MINGW 'git submodule status --recursive propagates SIGPIPE' '
-	{ git submodule status --recursive 2>err; echo $?>status; } |
-		grep -q X/S &&
+test_lazy_prereq STDBUF '
+	stdbuf --version
+'
+
+test_expect_success !MINGW,STDBUF 'git submodule status --recursive propagates SIGPIPE' '
+	{ stdbuf -oL git submodule status --recursive 2>err; echo $?>status; } |
+		stdbuf -i0 grep -q X/S &&
 	test_must_be_empty err &&
 	test_match_signal 13 "$(cat status)"
 '

-- 
2.48.0.rc1.241.g6c04ab211c.dirty

