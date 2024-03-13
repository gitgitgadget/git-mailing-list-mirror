Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAED1C2AE
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320942; cv=none; b=OO2117M95u0ebwETFlt4CWa1mDaChB9XIykZ4tOWwqY+XUqgAu31fb2gAYIs66qP68kVl4xz65ymFWMcPKYq21EtT9eXyGN5NK9jyaaJYXMnKHHbEKiHPDQrhSPxbMxAzZ68OtZU4VK00Qdz/X7YrDWbvonTqMGaFKlkd3u7Zts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320942; c=relaxed/simple;
	bh=O/YkiuulqtfniB+OZoobOPt902Q6lYXPIFeL2JBmhTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8OsUsoxJbZGRbTJkDRUrxvEeEF9Vddq1eOvmCmcmePaM+5AS5t6V8r0VPxu9iXy453/23I9/FRtb/CKMaMXSS7PDU+R9zK4ANM6TaItxPgHg2pg1wRpWExrEIRyvm1EAG5NqOpmBXZFSbnxkk/CggpQk2kSsUrlUbfIL76mqRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=dqSvrv9n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HR7G7elA; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="dqSvrv9n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HR7G7elA"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 7668A1C00067;
	Wed, 13 Mar 2024 05:08:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 13 Mar 2024 05:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1710320938; x=
	1710407338; bh=l8ezkac0mZykaQGRkBk5JT2F1UomW2CUc4n3kjUg314=; b=d
	qSvrv9nVlg9U1+Ja1HoaBS5MYOV8lc0mMDw8b8SlT+1xAqg3hl0iU4AKmrVsu4j6
	SA11zU4wh189JX1Z97ZIx2zm96in/cgSjI94vnVmA5803GjGp2WNIIybh+jybraH
	IzMJb6HeK7YapNXWSRhaFMOzHckSBSijX8q1m0pRxmbe2woNIn/C1kFPSCu8xBVm
	mYhdkroqbPeeXCBOVx379O5KX3isVUpXiQiq3sRvkkFmyKyahNMtWSgHk0U/K+6j
	2e0x5xgynx6LCgSm8rwr9CME+qaIY+BKn2V7y6sce/ChM0x5SoGXziRqHPjPOJlS
	8DcBjEJJ0oh3/OcjK18Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710320938; x=
	1710407338; bh=l8ezkac0mZykaQGRkBk5JT2F1UomW2CUc4n3kjUg314=; b=H
	R7G7elATpaLC2tjJ3e4o5bcYwg8GbrrFqk82fV4B2pACGYjtd7wbkLIaFv1MlMOW
	NxiCBWzLjdWDUvvCQ5TyhgdWXmlRzDsECIKe5OTx7gd4mioFTg+90jYkMDWwO2Px
	Gru9Gc8+Myd/BGQaYZIT07ktvDxfRT+Bap4EknCVjQB5ggK/xTiEAtlM890TPCLb
	mINkFmS9WfrwnE7q5bhubGzf+xZqO0nc1SZCFnWy6ouOKBZl3QoKZmwQQMz3FsKf
	mt3jQSS7X9d08SWbQ+n1yXwcbI5GvDffmifKDwVC3r13dyuQ1SF/SpeZdHSTeTCJ
	vTb+LRPscqMDEDkjF3Lqg==
X-ME-Sender: <xms:Km3xZZ28OOgEDFZcqAfpmwaVk4nOGQw5fKIvOwaQ4847QPZwgFOMTQ>
    <xme:Km3xZQF5Tygt-jMkQi4CMogboRE0XghGvAU7v68iDMON7mN80xzs6urIMbPfK-iOL
    jJtTghPkU5LKCYKRg>
X-ME-Received: <xmr:Km3xZZ7D2fLzjgAA8E4IwVqixsXsBPCehTelsOCd7wMm4e_GsFWFK0qF-m3Vqu4UWfHwf4BSXKyzvbqAvMFSfQou68kbaBL1oT6zT9K6p01eNwzPLxqnznTU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeeggdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflrghmvghsucfnihhuuceojhgrmhgvshesjhgrmhgvshhl
    ihhurdhioheqnecuggftrfgrthhtvghrnhepleejtdeuudfgteegfeeiudehleeutedvhf
    euueeuheevleejkeelteetfeevhfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepjhgrmhgvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:Km3xZW2qA6sUwC0i67XDOx39qnR3Gpw8PuI9q2_serJMg3cFU0l8xA>
    <xmx:Km3xZcFCbfqvIhWMO0tq00gPbnkJk6s12nqDps_eS4RnK-jT4m6ALw>
    <xmx:Km3xZX9uUTP2spCbdwftwQnk3A7H3NRMyN6rP5rgAQi9l3js2elQDg>
    <xmx:Km3xZZm3o3QFqWFAG-YI3O9nUmVkHzY7mGyPcoHb1OkWzlO3sxEDKw>
    <xmx:Km3xZQCFI_C4SS4UweNjcy2v0GnTQCRdHmAdbqIctWSIAT7kCsZO-I7uZ5k>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Mar 2024 05:08:57 -0400 (EDT)
From: James Liu <james@jamesliu.io>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>
Subject: [PATCH 1/1] log: ensure diffs are omitted with --oneline
Date: Wed, 13 Mar 2024 20:08:41 +1100
Message-ID: <20240313090841.36717-2-james@jamesliu.io>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240313090841.36717-1-james@jamesliu.io>
References: <20240313090841.36717-1-james@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently when `git log --oneline` is invoked with the -L flag, the
full diffs are displayed along with the single line commit message.
It appears that within the log_tree_commit() function, the special
case that executes when opt->line_level_traverse is enabled (as in
the case when -L is provided) doesn't respect the --oneline option.

Ensure the --oneline option is respected by explicitly setting
DIFF_FORMAT_NO_OUTPUT if required.

Signed-off-by: James Liu <james@jamesliu.io>
---
 builtin/log.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index e5da0d1043..dd77ede00c 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -279,6 +279,10 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		rev->diffopt.output_format |= DIFF_FORMAT_NO_OUTPUT;
 	argc = setup_revisions(argc, argv, rev, opt);
 
+	/* Ensure that we don't output diffs if the --oneline flag is provided */
+	if (rev->commit_format == CMIT_FMT_ONELINE)
+		rev->diffopt.output_format |= DIFF_FORMAT_NO_OUTPUT;
+
 	/* Any arguments at this point are not recognized */
 	if (argc > 1)
 		die(_("unrecognized argument: %s"), argv[1]);
-- 
2.43.2

