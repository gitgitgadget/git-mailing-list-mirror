Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E19C1E766F
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 06:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738564193; cv=none; b=jlfzPNbqIqlJtnlfO3HCP5eKELOeqy0R5atml+kr52sK98MJINfhf3zTY2NJ+lw+3IBs6ybKCqzvtI/V8544Oj4EbqjT75myV2V9iUckSuqvy3h5dXQU4whg30P/Uz3IkPoQLMSx+vvfi9AKArcbGp1n5vivWsUmo0MKGyl+9Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738564193; c=relaxed/simple;
	bh=b3l+aeMB26Rf4LKRbpM1ITGKoS7Gl3p7Itx0BkOXjVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hL4J4iaQtMRrLrHgGtwkH+3rY/P+zVC/ESfZf5yD5E/s5jR3b8hrmncO6+IeSikkvAFIbgh18Mcy7zr9XpfaZaoWse5LL5kTf5qCxuDB+N9oIO6F/8Q3i/IBL4QWpi1d9CaPYLas3FT1Q1tAL7eOJdM0PAatO5ma9i887BbOMEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V0fCy7uW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zSPsFOg0; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V0fCy7uW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zSPsFOg0"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A70EC1380601;
	Mon,  3 Feb 2025 01:29:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 03 Feb 2025 01:29:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738564190;
	 x=1738650590; bh=ayzyA8O2/qVkETBv1W6CvKJa22NeiEdGI04wGbhMUOk=; b=
	V0fCy7uWGadEisPmiVApZ6wn6m5pKMjQjsGODSUK+DNliJfd6t1NA97kkHVTwCCi
	0zcoTl2mZGGVdsbLkIVC7JizFAMVHkgFhevZR24QNKYOVNpPN+tvLLMPbG66kC/9
	M87bhWJMwEIQEiUcAsGLFQbZpGxWu+u93UQCgL9Zv0wg2V3vA06q4j5ogMl7i/BB
	H3p6+dLRTF1P2FdbLcZoT31+4BAO2papyeuz5YhnE9AKW5vKf3n5kK7ZzaPge0gq
	rLx6tB7OmaBmt21ASILnyhOEP5uNqWgbDRw7/LFViceTYXbfo+9AeakHJlTISIQJ
	rdPQEe+o7j+14Nprff1LlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738564190; x=
	1738650590; bh=ayzyA8O2/qVkETBv1W6CvKJa22NeiEdGI04wGbhMUOk=; b=z
	SPsFOg0RDiEi+KOo1cLIWf/NU3Yr/Bx1yoRe65ojfMu8eerA34W2SBAMkD65UciQ
	IsXT4m3T2KukVV1SAJ/OphmkHeA7zjvl7Y2lXlgkl/mEl+jgJmszP0hp1tM/ZTvt
	27q1YeYHLvJ0zJXaLcOp2BFfSKWOtUODZnoJseRcwgfkbfa8G0rrzxF+BAdD26Kg
	3O95Q3y/2sqqxmqPWh8rwarYcMizi5bY6dIMVPOK8YaTzbcbT5uXc/r0+T0I2tKC
	HJOhTE9SNNTbEv09gGJ5QH9AWP8SEHH7It505pMV8jK03CViNHH+lqZCdCIoR7UL
	2B+OUAqU4+9MrDtGNipcA==
X-ME-Sender: <xms:XmKgZ-DzebApJPZRntfz9fwjir499KuXEWLJg_xdeONY_rvp6aV0vA>
    <xme:XmKgZ4gyfg_wo2f2gjSGFdQnkEmSoiSC3oMRpki9kxld0YeqSVmB582I6nQcCWlyt
    yJKdQvKye511wniNA>
X-ME-Received: <xmr:XmKgZxkM4nYVRfk2btJPyThillvxzwjMbAt7P17loMK-x00LE9IUm-jXZ9MLTP9xG0I9tBM8kJEs0myMj3ACMHYE0j6Hiivc8IxyDNxIxz8BVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepiihhihihohhurdhjgiesrghlihgsrggsrgdqih
    hntgdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:XmKgZ8wIDc_CjGv9LU4MngiWlwQ0yrOWbtKGbEkD9cTMdDSNn8kzpQ>
    <xmx:XmKgZzTLxx5JdrTKDfcRmsaEDMzX08ksIkiRVlFnkZQGApqpwfneAQ>
    <xmx:XmKgZ3bZeIgtYfPbp9Eka2niwmbgHxo-UHo2yZ-roPDRauy-H8KVDg>
    <xmx:XmKgZ8QsOu5MVNNnliUJR-sbInYisIlj778vOC2SBh7cxYTx8P4sfg>
    <xmx:XmKgZxMQk2CECm-aJrqo5_-mtB8Mt-fio1SNF7VcT-ctr1d6mc-5giNq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 01:29:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id abb6a42f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 06:29:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Feb 2025 07:29:38 +0100
Subject: [PATCH v5 8/8] send-pack: gracefully close the connection for
 atomic push
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-pks-push-atomic-respect-exit-code-v5-8-d66481e36622@pks.im>
References: <20250203-pks-push-atomic-respect-exit-code-v5-0-d66481e36622@pks.im>
In-Reply-To: <20250203-pks-push-atomic-respect-exit-code-v5-0-d66481e36622@pks.im>
To: git@vger.kernel.org
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>, 
 Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.2

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Patrick reported an issue that the exit code of git-receive-pack(1) is
ignored during atomic push with "--porcelain" flag, and added new test
cases in t5543.

This issue originated from commit 7dcbeaa0df (send-pack: fix
inconsistent porcelain output, 2020-04-17). At that time, I chose to
ignore the exit code of "finish_connect()" without investigating the
root cause of the abnormal termination of git-receive-pack. That was an
incorrect solution.

The root cause is that an atomic push operation terminates early without
sending a flush packet to git-receive-pack. As a result,
git-receive-pack continues waiting for commands without exiting. By
sending a flush packet at the appropriate location in "send_pack()", we
ensure that the git-receive-pack process closes properly, avoiding an
erroneous exit code for git-push. At the same time, revert the changes
to the "transport.c" file made in commit 7dcbeaa0df.

Reported-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 send-pack.c            |  1 +
 t/t5543-atomic-push.sh |  4 ++--
 transport.c            | 10 +---------
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 4448c081cc..856a65d5f5 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -633,6 +633,7 @@ int send_pack(struct repository *r,
 				error("atomic push failed for ref %s. status: %d",
 				      ref->name, ref->status);
 				ret = ERROR_SEND_PACK_BAD_REF_STATUS;
+				packet_flush(out);
 				goto out;
 			}
 			/* else fallthrough */
diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
index 32181b9afb..3a700b0676 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -280,7 +280,7 @@ test_expect_success 'atomic push reports (reject by non-ff)' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'atomic push reports exit code failure' '
+test_expect_success 'atomic push reports exit code failure' '
 	write_script receive-pack-wrapper <<-\EOF &&
 	git-receive-pack "$@"
 	exit 1
@@ -296,7 +296,7 @@ test_expect_failure 'atomic push reports exit code failure' '
 	test_cmp expect err
 '
 
-test_expect_failure 'atomic push reports exit code failure with porcelain' '
+test_expect_success 'atomic push reports exit code failure with porcelain' '
 	write_script receive-pack-wrapper <<-\EOF &&
 	git-receive-pack "$@"
 	exit 1
diff --git a/transport.c b/transport.c
index d064aff33e..b0c6c339f4 100644
--- a/transport.c
+++ b/transport.c
@@ -948,15 +948,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 
 	close(data->fd[1]);
 	close(data->fd[0]);
-	/*
-	 * Atomic push may abort the connection early and close the pipe,
-	 * which may cause an error for `finish_connect()`. Ignore this error
-	 * for atomic git-push.
-	 */
-	if (ret || args.atomic)
-		finish_connect(data->conn);
-	else
-		ret = finish_connect(data->conn);
+	ret |= finish_connect(data->conn);
 	data->conn = NULL;
 	data->finished_handshake = 0;
 

-- 
2.48.1.502.g6dc24dfdaf.dirty

