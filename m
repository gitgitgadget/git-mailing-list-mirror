Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF101B87FE
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738320819; cv=none; b=O/XhjS5EuqIAimn2S8wcg3rDfckyVZ45mC1BEhwtlut8AJt1Yx+t1Dwow2sUXSVHE87MHsvKeA4PN1APldHgKNM4FedkuKDyXZTl8cBxkLDv+Y1YWfYxnpz4qMtFR4Ip4Cq6ZK7qJ7atJRlY//seOqDM3m7fXltZDpfzSEsJEIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738320819; c=relaxed/simple;
	bh=b3l+aeMB26Rf4LKRbpM1ITGKoS7Gl3p7Itx0BkOXjVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LVs+navHfq8SlPnRtryije9G+q7Hj+alk8L4JNoGIfUcMW0sPB/aYBKadNynnnddn1XSKZPPOTVN7ZmzYpr5VkrkoCHfAASmuAk4h4Hxpi3ff0Xdt2dVmDFE7HOcNPJlWgjpq+6oaNsrsvhCsuI+XNae3kaTtHNzhVRumRSgJxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pB3QIHjL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rfRrPq5d; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pB3QIHjL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rfRrPq5d"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 13D5A1140110;
	Fri, 31 Jan 2025 05:53:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 31 Jan 2025 05:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738320816;
	 x=1738407216; bh=ayzyA8O2/qVkETBv1W6CvKJa22NeiEdGI04wGbhMUOk=; b=
	pB3QIHjLT4BNr4F0JlbXimWGNxHs8ZpWnKLykcf+SOSPor4jP2lWF2mlyMp/StjX
	d4ngfmeqxfYTzegLLB2VzNHF159y9eA5PdpL50swuXj+GQgwRGtAQ7KPlWlPpO+a
	Ray68y8UstIRNdy3a4cMVVv0zJtyDWGgcVQMTBN6e/oAwtWHiTo7jutTpKPU6/gZ
	RdRavyn8j4yOrdZQO0GtoU9FMLcgDJ+hr9vPFWpoDKPqisIR5NX87e5yHgF6LI10
	If5q4HjIeoZYJJKJN/oclX8hNBtzwPCdi+fSAuMSx5kpM70qfU93gsD5znuIW1Sy
	B/Pmo+BSthxWdnUFeXkTOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738320816; x=
	1738407216; bh=ayzyA8O2/qVkETBv1W6CvKJa22NeiEdGI04wGbhMUOk=; b=r
	fRrPq5dOo29bVV5Aiam0HbmkFdaysq1a3z+14rfG2tXSbrG0Re68VEroUpUh9Xze
	34c/foF3Kabz+SyBBhQ0VLeOvDfDpgxzhvI8hhCY1/2TcUkkzc6sfuFh1yiLrSMP
	VwWoyR6gfO9aUm/wkL3Jlc2MjFnLLf/31kaQpLrui0mub3Q9CZkWpQ9WntmVXUkk
	+JAZMeHOx/TasxWQ7dlBwwtX2zKIIFByTZ8JEeszbWHQdPyyKr4oNS1OPHN2M6tx
	qaBxo3LixhbhKJnyU9QfaLTIpYdzYWp2ybQobNtVUdHL2XF0N5hcHJaGATcFVoPp
	5QbQWJCLkFb3bpDUDd3Pg==
X-ME-Sender: <xms:r6ucZ576Bg1yqpwS1-VonNa6WeYiXdlzOLJmfaUzUQGZwpMTZ-riVw>
    <xme:r6ucZ27FwCYXRF3vw7X6LIRHx2ROMyURrkvy-6wS8sbrb9_vgmIODUmoci9dRPORD
    4W6unTYMZMnnJuMKg>
X-ME-Received: <xmr:r6ucZwc8PQ42PQrX1rlUz6EmE3uE0Uuim5ymt6ZCcrj8WSdI8CiATw2x5P11pb9TAZZ4CUUuBLZx113fq80fQb9azB4IJl6pZdKCs4N-eFICPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepiihhihihohhurdhjgiesrghlihgsrggsrgdqihhntgdr
    tghomh
X-ME-Proxy: <xmx:r6ucZyJFWMEcze6v0wuHqK9lETcL1GG4XAhEs5yrPACJH-i3AOJ_-g>
    <xmx:r6ucZ9K_TRRQwhhY4CVxyJcPXgqHROom5cG5eLUcH_JqHaCyWvNT5A>
    <xmx:r6ucZ7z07_FNYnKnvuE_VW61BazDCJ7LFHQbXSFF3D1rBkWre3v1Iw>
    <xmx:r6ucZ5Kt-bA8q-gvkk9u9hwDl8q5LpxswYUOkweSluutXfmjKR3zOg>
    <xmx:sKucZ921w0H8k0vlWyIvfHLt1klN0y_OLIlwytsb-iF-llN5Wky2b73S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 05:53:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2164f7e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 Jan 2025 10:53:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 31 Jan 2025 11:53:32 +0100
Subject: [PATCH v4 8/8] send-pack: gracefully close the connection for
 atomic push
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-pks-push-atomic-respect-exit-code-v4-8-a8b41f01a676@pks.im>
References: <20250131-pks-push-atomic-respect-exit-code-v4-0-a8b41f01a676@pks.im>
In-Reply-To: <20250131-pks-push-atomic-respect-exit-code-v4-0-a8b41f01a676@pks.im>
To: git@vger.kernel.org
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>, 
 Junio C Hamano <gitster@pobox.com>
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

