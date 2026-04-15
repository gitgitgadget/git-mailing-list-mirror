Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224A938C43D
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258408; cv=none; b=UuyiVZIiuBg7guCcI91t4HjoklRA8rCRgWWHxLYoBsnR6flghoflBqlsysP3lesM2maVrIMIV4JnGS+CIytPrRc6dwJBw0kNm8OVUOPcKl+B4QeCgZK8jutosig3amggzVz4ax7lbq7xAMcTaofNrhnEqs2/HOhuK2q7qB8xon4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258408; c=relaxed/simple;
	bh=QwaFflupcgZGtUiTur+0TZkVNF0tju6K2qOV2/CElLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KMMGsR6/M61lFUQU5q3XpJ/F0mSn//vrffs81Ck10Jd2UaHwKKNkxHYxu2e2X8ZV9FdxGQ9L1XhKtF6miqwKMhNNzKR9CI4jH99ragoZlrHxGmJ1nfrenKGEiE5oI/R3WpXVfWAEnsxgrP/fVo5l5rVz5lYo6sZX0wtk6XnKgUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CDaoCBnY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VWW6lTD8; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CDaoCBnY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VWW6lTD8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 605F6EC0233;
	Wed, 15 Apr 2026 09:06:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 15 Apr 2026 09:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776258406;
	 x=1776344806; bh=JH42nt/3fO7vfbU6MbHQgipsNo7cRzzerK9UINFMLgo=; b=
	CDaoCBnYvNG0ktPZ21h3+gABkhTJearPCQSu87xpCuzRdDveLQMJTJJrz7K8LnxI
	qChUax45PDANIHIL7MciRcxsq3baQVi7oqwB7A4uA6nI8hHpJt4/qYnVucvoIMli
	emKSuPZXwJ+MZHaFd+3/icM+9KqRU06qUJ6Yww9/BzpFnB4nSZWmKtlp7jkh6hSi
	+89cc+JDK+qveKQi2gY8xobzxX6SIS2oLuVpN6Sm/BzSXkuV1tMt6jBqunhUM6W2
	LATlqKQHvrWSAOMRfKEtXtSlkjrvvR3sPnaMZ9oJcALoivmQe4+SoP0UeL++yU8r
	W4rWzNNrhznh9FU6jbarXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776258406; x=
	1776344806; bh=JH42nt/3fO7vfbU6MbHQgipsNo7cRzzerK9UINFMLgo=; b=V
	WW6lTD8tfvzVB8hYmjFSF2ASOZwUpCzOioLXByXjjZvv9N59zPCiaHalVRXnHRhw
	VlVZHAKShZsWpjlhv3V0h/lzI/jeTlWr+ZatzfseLzuLbFExdmJ20fXNCwrVvQAO
	2q7okCPsAP9WOlnXIT+3tODsrrtpEbNAS/QMmh2jmeXSkYpNZrV0pdwY1kX+Fq+R
	yC+1HOHh2qhHEWqHZNnEeD3D1I1F8nBks/Zt9kVe4DNBhNfxbf7mxwujJVsBHeT8
	SrzYgn/s+t0pLiuO+6rZpuB1HS4sfA/tPBdGnDlEMie2TPavif8sfFyM0i38q3WR
	Wu7ZQ3uZtDyeoIB2lLUSw==
X-ME-Sender: <xms:Zo3faXdTH44M7rVXuNlX8hEvyJGAiFMgmORBEFg5007lN48AipZwPQ>
    <xme:Zo3faUpr2X3fmL_ehtiTiOwkNvRXSSVkvhiXFXfl2a6suu0C76UxrRoCOFmfofgsl
    kfVCQxFZ-x7q0anWUJ4xpDSNtAiRo5t8mHo6cF3c1GcEDn4u8d0nA>
X-ME-Received: <xmr:Zo3fad4yrTSEynnbjk3NeRaiAl4Oi-0RV3_IH_2IElaZA_eSO06Z4zQy93BbvevfiK1HDpWM9kxCohl0kXjr3EmnQU-wsmrJVJi4SuUIXrU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Zo3faSqg5Fo81bP26RSdo59JHXkcpdAOKHWo5HY7LKwP3nYgR4a1vw>
    <xmx:Zo3faXhpV5giUpj9ohD87gbq41c3ZVPumJRzAhObt-7JIozWrXUZ7w>
    <xmx:Zo3faUI5K7uk_6XtNJE_ME6uSM7PbHPcbDREcXx63vkRu3a6xkVKkg>
    <xmx:Zo3fafC2g_nLU0J4CEIAUEkMvT4TjxylpmjWa8iSrgl3WSfDkfBvLg>
    <xmx:Zo3fadaXzNn-epnxWcopGO25pPQj81JXCzLqW6j4MFMg4V_kNHUQHBk9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 09:06:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bb276fce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Apr 2026 13:06:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Apr 2026 15:06:36 +0200
Subject: [PATCH v2 03/12] t: prepare `stop_git_daemon ()` for `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-b4-pks-tests-with-set-e-v2-3-4e4904a96f15@pks.im>
References: <20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im>
In-Reply-To: <20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.1

We have a couple of calls to `stop_git_daemon ()` outside of specific
test cases that will kill a backgrounded git-daemon(1) process and
expect the process with a specific error code. While these function
calls do end up killing git-daemon(1), the error handling we have in
those contexts is basically ineffective. So while we expect the process
to exit with a specific error code, we will just continue with any error
in case it doesn't.

This will change once we enable `set -e` in a subsequent commit. There's
two issues though that will make this _always_ fail:

  - Our call to `wait` is expected to fail, but because it's not part of
    a condition it will cause us to bail out immediately with `set -e`.

  - We try to kill git-daemon(1) a second time via the pidfile. We can
    generally expect that this is the same PID though as we had in the
    "GIT_DAEMON_PID" environment variable, and thus it's more likely
    than not that we have already killed it, and the call to kill will
    fail.

Prepare for this change by handling the failure of `wait` with `||` and
by silencing failures of the second call to `kill`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/lib-git-daemon.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index e62569222b..d172aa51f0 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -85,14 +85,16 @@ stop_git_daemon() {
 
 	# kill git-daemon child of git
 	say >&3 "Stopping git daemon ..."
+
 	kill "$GIT_DAEMON_PID"
-	wait "$GIT_DAEMON_PID" >&3 2>&4
-	ret=$?
+	ret=0; wait "$GIT_DAEMON_PID" >&3 2>&4 || ret=$?
+
 	if ! test_match_signal 15 $ret
 	then
 		error "git daemon exited with status: $ret"
 	fi
-	kill "$(cat "$GIT_DAEMON_PIDFILE")" 2>/dev/null
+
+	kill "$(cat "$GIT_DAEMON_PIDFILE")" 2>/dev/null || :
 	GIT_DAEMON_PID=
 	rm -f git_daemon_output "$GIT_DAEMON_PIDFILE"
 }

-- 
2.54.0.rc2.529.gd9106f7525.dirty

