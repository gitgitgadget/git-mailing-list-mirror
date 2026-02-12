Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3263635971F
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770900289; cv=none; b=YkFC3mPTOIZFxeZ9MGVZVMogjCWTFW+BG1Pl18xA7bJuNHozZssYlHtpnzOQs8t5f1z2A3Di3CTQW0yJQyqEUlnL+8y5+dOZB3lJBrDoXte1pLLNRuTj0Tafo3jRGo6zUiqjMh0mngkl+J4UkLmA67cvPwjtzZ5lk1NnSennECo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770900289; c=relaxed/simple;
	bh=wlFsk+pljyQw5U5NwkT2vi2cTpXC4jSA/B0ZllfjcqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i3UW8FyiXorP+aRo7zkX4cOKKsR/0PcuMxCF+esn6r6PF7bIbZkGeajcoysrSR5cW3igYSei4jTufYgZxDK/DXUU/KIZfnyWGL08OddfEMv+KSNJ0DWhbLc7Tn4aalUmPH+ySwomlaqujCq2Wmv4eDScYP+BPkpWKVjWy2uAboo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dWm2K124; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G2EPTolc; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dWm2K124";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G2EPTolc"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 33EF7140010F
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 07:44:45 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 12 Feb 2026 07:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770900285;
	 x=1770986685; bh=gGsao5hDdLcZfGdraPhGaScTDuVQmg07OmZqRrbq4kw=; b=
	dWm2K124Rp+iFp5YJVgkKydRgnvUNCxOcEscyG7kIbi/7z7y8Ev9PpNmytrTyc1t
	pXfRh2hD/Ad33v9SR057rXR9E/2S/EBn047KM5VYQMjv/Ok9jox3PnWT5UFw48qN
	pc6K3cK/lH0L/EeT/SVYWIgKr7wf9rotAiDsosQR5EoqD+ltbemNWV09iy2T8G+X
	mzXDiWwFgZI1yhWHG45AidPP5PsgTvtxIUvzpLlSyY+nZyHwE9awkh7bDo14C0JQ
	ObD6rfksweWx11+hYNT3TuNMOQ2cU1ORtDD0Lt1ZIspgGTDgSrkQb/LPA55u9ufj
	J4K4Z3oJ/g72/asnzKt7gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770900285; x=
	1770986685; bh=gGsao5hDdLcZfGdraPhGaScTDuVQmg07OmZqRrbq4kw=; b=G
	2EPTolcY7F/k864BsLfhdWzTXnmGziIdQATCGddIeXnEz7rjEIxVcuWBMUaJDPjm
	amMwCffq6CzX5P7/ka5AV3NpZZNA2LVpX3Xuahsj+W8yK3m4kUJAZeYwC3fZ8ECl
	qcHROCKs9fOg2YBuCxvy7hT6C4895d+2mlnmEvBqfGFrU2MC6ouf1Wh6h1nMbB8B
	o3ujXVugFWVCCoMEBmFfeZpTVsMiNNc84T3Y2Qwb+2LrOPuDZs1v/17dbD4Bqqej
	DqcUZSSNS1JLPE8Zb6JOgGX+VQzrWSJALFh7iO8RQAZZnZfy2pBVYPqIE2Gu5yU/
	1rnSCUMc7B0wj9y1Ne8Eg==
X-ME-Sender: <xms:PMuNaR1VUP7CLMdgEFg6mkH2A7IKUXk0IHxybh35Sez5IrsGRjfKdw>
    <xme:PMuNafBfCLgCwwLKmK2Oj30ejxp7o6VJ9CPHs2rlTVQMnjQ7v3n42vxapoGelM7PP
    gtKCJmtMw3v8E0qxnIWZAvYbxAKSpJCPuKoX3JGR87Vyxel9zmHg0M>
X-ME-Received: <xmr:PMuNaXjkJO_L943wITogfNezLA-tmb7m28Oal8Q_2u_5XM6TBTqrecZqmHbrOpVndBCudT0jySXCWiUMKc5TVPaqyyCG-AGuSgaorp2IcPo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdehgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:PMuNaT-YDg8StzPMx2Cl1AC_HjjslrRtvBGk1MWua7qwJo9abTQKTQ>
    <xmx:PMuNaT9iOCOPouqgnI31ATopvVxHwTOaHJvBmgGR7KeMS_dRPULHcA>
    <xmx:PMuNacBbBZ34SIGZCSla_mDqe4pQmdvNeIApj0oc0ZXvJjR--IZ_Ng>
    <xmx:PMuNaTyatc8T-z8Bsa1XVfpo8X9dhfRhNu1eH4NA4NdBEr5rnGAeMg>
    <xmx:PcuNaXF1Ze6l82u9NpIDoZnxO3gyqvktGKw6DjcyYnkjx9prPZObePN->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 12 Feb 2026 07:44:44 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7e33e7b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 12 Feb 2026 12:44:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 12 Feb 2026 13:44:35 +0100
Subject: [PATCH 2/4] builtin/history: check for merges before asking for
 user input
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-b4-pks-history-dry-run-v1-2-1ce03d631c1b@pks.im>
References: <20260212-b4-pks-history-dry-run-v1-0-1ce03d631c1b@pks.im>
In-Reply-To: <20260212-b4-pks-history-dry-run-v1-0-1ce03d631c1b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The replay infrastructure is not yet capable of replaying merge commits.
Unfortunately, we only notice that we're about to replay merges after we
have already asked the user for input, so any commit message that the
user may have written will be discarded in that case.

Fix this by checking whether the revwalk contains merge commits before
we ask for user input.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/history.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 t/t3451-history-reword.sh |  2 +-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/builtin/history.c b/builtin/history.c
index 1de51372ea..ca0cdb6a58 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -177,6 +177,42 @@ static int parse_ref_action(const struct option *opt, const char *value, int uns
 	return 0;
 }
 
+static int revwalk_contains_merges(struct repository *repo,
+				   const struct strvec *revwalk_args)
+{
+	struct strvec args = STRVEC_INIT;
+	struct rev_info revs;
+	int ret;
+
+	for (size_t i = 0; i < revwalk_args->nr; i++)
+		strvec_push(&args, revwalk_args->v[i]);
+	strvec_push(&args, "--min-parents=2");
+
+	repo_init_revisions(repo, &revs, NULL);
+
+	setup_revisions_from_strvec(&args, &revs, NULL);
+	if (args.nr != 1)
+		BUG("revisions were set up with invalid argument");
+
+	if (prepare_revision_walk(&revs) < 0) {
+		ret = error(_("error preparing revisions"));
+		goto out;
+	}
+
+	if (get_revision(&revs)) {
+		ret = error(_("replaying merge commits is not supported yet!"));
+		goto out;
+	}
+
+	reset_revision_walk();
+	ret = 0;
+
+out:
+	release_revisions(&revs);
+	strvec_clear(&args);
+	return ret;
+}
+
 static int setup_revwalk(struct repository *repo,
 			 enum ref_action action,
 			 struct commit *original,
@@ -236,6 +272,10 @@ static int setup_revwalk(struct repository *repo,
 		strvec_push(&args, "HEAD");
 	}
 
+	ret = revwalk_contains_merges(repo, &args);
+	if (ret < 0)
+		goto out;
+
 	setup_revisions_from_strvec(&args, revs, NULL);
 	if (args.nr != 1)
 		BUG("revisions were set up with invalid argument");
diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
index 6775ed62f9..12a9a7d051 100755
--- a/t/t3451-history-reword.sh
+++ b/t/t3451-history-reword.sh
@@ -203,7 +203,7 @@ test_expect_success 'can reword a merge commit' '
 
 		# It is not possible to replay merge commits embedded in the
 		# history (yet).
-		test_must_fail git history reword HEAD~ 2>err &&
+		test_must_fail git -c core.editor=false history reword HEAD~ 2>err &&
 		test_grep "replaying merge commits is not supported yet" err &&
 
 		# But it is possible to reword a merge commit directly.

-- 
2.53.0.295.g64333814d3.dirty

