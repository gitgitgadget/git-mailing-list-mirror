Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36378175A7D
	for <git@vger.kernel.org>; Tue,  5 May 2026 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778013955; cv=none; b=KTtnii55oY59Er7t2Hxr0GaACJxEIS08iVjGL6C4mK8Wb1zXRHmM8+HRFeQZPRxPFXAEwjoN2ITPaaljeGwaEUqHxBFpzufMqbp9hcGsLYoCubsZP8wVnxvAif+WPXtCb9KiSbl1Xf8snORDovW5jXwe/KRPiI9gWVVg7nV29hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778013955; c=relaxed/simple;
	bh=Pi1I+VmsP3OYpOifm32L7e4478ZCMpqZ0ZcRrOuPH7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=emn17RakPcTC+eaLWY8LIWciOdKISCgqzE2bCpj+p3cqTQkAE8ABzJW7vb3oXB/cnVpik3LWuUShCqAbsNh6vDysE3Z8pnjwP3rx58mTOsbJeN0bl7x3aBeF6sOtxkdNMB7XH0pTNOEyZf7tTJfvGrW6VPob7WJdL9sS+nZfsC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LM0LByJF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AdaaeZ1n; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LM0LByJF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AdaaeZ1n"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 68C09140010D;
	Tue,  5 May 2026 16:45:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 05 May 2026 16:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1778013952; x=1778100352; bh=4U
	jZtTniW+3UySo4zpk2uUwBuHxhofN2AR5JCRFzUzk=; b=LM0LByJFSa0ruRLQuP
	V86H3XP0Jqunp5Abd8LWDTB7fi62jQ3fxLES4/rTxS0B3VDTmeVlrUBnn8SELn4K
	2p33fAwTxQp86oCJVeQykQXjh5knt0YXZ2pS2kFAPo4yGtgpF7JwZ84uWBzgGQM6
	KXsq2YwxU9zsUW7AmPoQRQUYhrif3QM3b2tFs5nM+fwrB6bk32vv/HRiDQHWWqSA
	OD7HFMIPz3egixjR5DJIC60gmOB2SaVC1rFT9pwAq70NavlJSNMR8JMDKQU45N2Z
	RRAsyzY+6X6LMPnX2rQlGls1s0GSMQD/maW1mngliJYHf7uvcH74/FSvpLqvFm8N
	6MoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1778013952; x=1778100352; bh=4UjZtTniW+3UySo4zpk2uUwBuHxh
	ofN2AR5JCRFzUzk=; b=AdaaeZ1nksLpdcNY/w+NGyxJKhgmFdHLi6MRlFEtU+uT
	HXIQjJ+Z4uP4MHoBlJgO6pkHG4QYrxTQCyMrfLfv/8hnBuf5z4xfK2TMOa/WzZSc
	0A9laI7KNhUo0awxzoFGSwESaZvkz8KR/0rpDhp1DHBj5kxdfqePofcv/xp8nRX4
	UPupSBlWQjAkavZd0kXjL/0fV0wjZ3ea4IIb7oGqPTLaRADYu992Y2dDUwHKF24Q
	rpAHrXPrPZUSMliqI5EKdPcmIPFEcH747G2LJ3mwsTD9DG/UE7+7zxYNqX0ngRts
	JWdqYQj7VxIVNLwhZFVbFJLX5SWfJ1071rJOv8ZYKA==
X-ME-Sender: <xms:AFf6aZmHQx0Q-NaaHvB1eQUo1N-fCHFELV353Noz-NvnlGWgp697ZDY>
    <xme:AFf6acQpcoIcFjHn4H4LP7SYttcrPqCph6fTPoToXjd-xpY2jUu7DZkFu3lqJ6VA7
    elM5F1CTeLGcpuiqfO6C1Fx3sWRyNKdgZpSzG4KYDTr2XB017gZnA>
X-ME-Received: <xmr:AFf6adDoT8m0FCCv9oeUYHwILTJ_8SnpYzszf0CkGEYbM9XXqIff9VVMz6rJY20IIYwjNQzKGaGFTKF4i6rk9Kqh3B_ID_wQcqGOLRJGvzGFpwGMidc7E1x3PA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddvjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeen
    ucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmnecuggftrfgrthhtvghrnheptefgkeejffdufeefffegkeevgfevvdegffeujeej
    leegudfhtdffieekleefhffgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepshhtohhlvggvsehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:AFf6aTSEu2qBwNIyQ-vhU4cjVmXrflKoO9L78ik_wsenTevWNeisNg>
    <xmx:AFf6abp970x2BfeptgGGCBgdHU4n-MmF8wyCc-WbCVrplhe1gX2tfA>
    <xmx:AFf6aVwl9yoeQgtSOfNfbM9TjwAf04CmbYlf7rV4d-IAwIOf6ZAAbw>
    <xmx:AFf6aQKabv3m9-wNOSxwry5MR4KKOoDJiE3Gv-E9yPypsHLOoHL85A>
    <xmx:AFf6aQQxCL3HqZx8p8NemEC9CAYRXqS8LwBGqq1WsYxU1AKAgvVIJevF>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 16:45:50 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH] doc: add caveat about turning off commit-graph
Date: Tue,  5 May 2026 22:45:42 +0200
Message-ID: <caveat_commit-graph.671@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The doc `technical/commit-graph.adoc` says that replace objects and
commit grafts turn off commit-graph:

    Commit grafts and replace objects can change the shape of the commit
    history. The latter can also be enabled/disabled on the fly using
    `--no-replace-objects`. This leads to difficulty storing both possible
    interpretations of a commit id, especially when computing generation
    numbers. The commit-graph will not be read or written when
    replace-objects or grafts are present.

But this isn’t mentioned in the user-facing doc. Let’s mention it on
git-replace(1) and git-commit-graph(1).

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-commit-graph.adoc | 6 ++++++
 Documentation/git-replace.adoc      | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/git-commit-graph.adoc b/Documentation/git-commit-graph.adoc
index 6d19026035f..f2a37e91634 100644
--- a/Documentation/git-commit-graph.adoc
+++ b/Documentation/git-commit-graph.adoc
@@ -146,6 +146,12 @@ $ git show-ref -s | git commit-graph write --stdin-commits
 $ git rev-parse HEAD | git commit-graph write --stdin-commits --append
 ------------------------------------------------
 
+CAVEATS
+-------
+
+The existence of replace objects or commit grafts turns off reading or
+writing to the commit-graph. See linkgit:git-replace[1].
+
 CONFIGURATION
 -------------
 
diff --git a/Documentation/git-replace.adoc b/Documentation/git-replace.adoc
index 0a65460adbd..2c0ea07724d 100644
--- a/Documentation/git-replace.adoc
+++ b/Documentation/git-replace.adoc
@@ -145,6 +145,12 @@ commit instead of the replaced commit.
 There may be other problems when using 'git rev-list' related to
 pending objects.
 
+CAVEATS
+-------
+
+The existence of replace objects or commit grafts turns off reading or
+writing to the commit-graph. See linkgit:git-commit-graph[1].
+
 SEE ALSO
 --------
 linkgit:git-hash-object[1]

base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
2.54.0.13.g9c7419e39f8

