Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBC4176ABA
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321533; cv=none; b=R0bSuNDDCvHY6on/qhxXZ+l85pcknDI5OowuDwC2o6cATgypzOY+z/emsij0orua+Gip7dQxajq0r7rkqw0p68lFUqHoLsFJftfg0cIjbtRHv/P2JIW8H5FNTM0kWAiJfDpeh2JXBVlZOqWSeyuWBWPlpB8YJIAn5voopqE/hwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321533; c=relaxed/simple;
	bh=mJ6qIKCut5hsdmitnUvT8Ib5UZmYc4vlYUVPt+J0/fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d0yukI8a1CafJ4I9UV40avMrJ/nXJnH21nNRN0c4/MqRWEoda/t7cfR4YDD69FHNy3L3EYm1vti/YYfjAX5Jmg+DJdGoIoDCDjwIBBAvuhZ2Yz/ZcWP7XhPj47WCZ1FnddUrp37DSohJMfjkvVPG6mVMUksFWR4oQWDZIaTCFdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CV8mfX6s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i46j6/Q7; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CV8mfX6s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i46j6/Q7"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 584B91140162;
	Mon, 11 Nov 2024 05:38:51 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 11 Nov 2024 05:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731321531;
	 x=1731407931; bh=2ZxOkV71neIxtFoVno2DEgw+GHy3pqE/E1Hf/8OqHHg=; b=
	CV8mfX6sZNR7DP2efAxyq40plyxbEwZdAPeS2KwOTbSVNzhMIUhe9IPfi3tG3gab
	M7lSP+YT8G7XbJ/A2AdjII7uT7F0xGZFME3kyEhdIsJ64p80vzF6LWmOtRjjzbeU
	JJ50epkYbtGjUv+Tvtpd/iff4HQ7ACNsC26foiGFNGahxMzf6siLvSVSMxRvG+Zf
	YEMtkHU/f6ykf8d5MRyutxT89DHj/ReEy3l4caQI0Dfe/nyMyFXaLvFwuWSBYofk
	0EUMpSR7UNvoaoheCTUJXPcxNe+j8yJLqNqVIwaoDzPq+sa3GaK4mIcwCVZvwbru
	QYcRObu4AhSIUCQyLqGPmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731321531; x=
	1731407931; bh=2ZxOkV71neIxtFoVno2DEgw+GHy3pqE/E1Hf/8OqHHg=; b=i
	46j6/Q7eO1xkJIKtUrWBfjpnDi22c6FYLvEqSllp+LN5sg3+XZB/WvhJ3cA0EZJM
	ElqwyO101fkCxpDzthItSW5LG9VnpEkqnt5uNbFOqk5442vE2E33QA7Wx2ZHm3zK
	yIpJA/eP/a8i/sOaScZjdVVb6oWROObd7tcO8GUA0HKhi1ZBNYjVsWeYUTVP2h0I
	h7sfnNK5fuBsSjXjsWZz6ATHuqgUwWGSl39usvqjCO1aS0b+J5spmHoeiJK9WqUS
	srQ1Fwth4CNOrY3Wb6QhD2fs86plKTBKaQH0XiAbjSDkQGJ8hOmLPuUMetX+9/K0
	L7xKHkVi8HutNrMEmptIA==
X-ME-Sender: <xms:u94xZxnZ22KwyAcN7jBXz_AJOyn6ofcr6vzE1FXJTVNcjGI7q2FilA>
    <xme:u94xZ80BqrV26HZBj5Mx0gnnVCejICb8fS7VO6r_CdChnJNlm8lDwWAg7A7llgTv-
    MzfiRuHHnWr3yku6Q>
X-ME-Received: <xmr:u94xZ3pKXX0_annGAbwV_9QSKDn1hRB_jvQ77z_Q571gA6PaIusTZEg8BBeW1eTRNm3Hn5qXM9_X1Mg4x_7IHoq8HCSIR3Q4ZOf5pvcG4yuyADkh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:u94xZxm-_eq2fXW_wE0M1w9Ht3T9-FKW5ZmAU0SRkmKsMIbEhNnIlQ>
    <xmx:u94xZ_0qJDC6LhxY_vPGxlqO2e6n7hqSp1RL6Y5VZ6GDwIAwtEyIow>
    <xmx:u94xZws4KIZynrCLCn8Dq3Nbbv2Ds7qvXrilibl5JLAhz5HZUSi-_g>
    <xmx:u94xZzVQO-jB4m3vl0i2lNaRzgRAAJBa4sHR9DI_XEqG_hLPMa2RCw>
    <xmx:u94xZ9C6uMEjNFgmMEdUWXq3QxZ-Exdx3A-IF4_oQxy205Od_WFPgw5E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:38:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6a6215b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:38:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 11:38:34 +0100
Subject: [PATCH v2 05/27] bisect: fix multiple leaks in `bisect_next_all()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-b4-pks-leak-fixes-pt10-v2-5-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
X-Mailer: b4 0.14.2

There are multiple leaks in `bisect_next_all()`. For one we don't free
the `tried` commit list. Second, one of the branches uses a direct
return instead of jumping to the cleanup code.

Fix these by freeing the commit list and converting the return to a
goto.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index 6dbc22f84fce11743f0e79eb4f8100c7ec07238f..04e9a63f11c7fa1a9dd11d3f193c500a4cb937c6 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1031,7 +1031,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 {
 	struct strvec rev_argv = STRVEC_INIT;
 	struct rev_info revs = REV_INFO_INIT;
-	struct commit_list *tried;
+	struct commit_list *tried = NULL;
 	int reaches = 0, all = 0, nr, steps;
 	enum bisect_error res = BISECT_OK;
 	struct object_id *bisect_rev;
@@ -1098,7 +1098,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 	if (oideq(bisect_rev, current_bad_oid)) {
 		res = error_if_skipped_commits(tried, current_bad_oid);
 		if (res)
-			return res;
+			goto cleanup;
 		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
 			term_bad);
 
@@ -1132,6 +1132,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 
 	res = bisect_checkout(bisect_rev, no_checkout);
 cleanup:
+	free_commit_list(tried);
 	release_revisions(&revs);
 	strvec_clear(&rev_argv);
 	return res;

-- 
2.47.0.229.g8f8d6eee53.dirty

