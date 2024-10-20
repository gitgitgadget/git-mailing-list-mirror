Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D3820E31D
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 22:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729462524; cv=none; b=TP+kLtYpSBsGPUCxJ7JAiVl0+1t5u/9NZMC4um6Q5D4cjhv16S0lHJIPaR60LSW7tkENEbuBx+TaZehQoTIPIjHqDafkyWAxt1SvobOB9L3SjOEAtszxEiCZNfaQO7W+ox5MQad7yVkoTCg5Ri7BnAmkzZ5X56FktN0b7gGRrIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729462524; c=relaxed/simple;
	bh=JcHco3UrVw9O5NZMGhp5sr3sEGPEuFd5i7XwscEmOb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0QnIlqahNBsSbiK3c3mqJm2xmHJR4szDcWDSHb8WwkkDbsNFfg5I1OtmaF4LzWxJebHPYVOc25rcojtqfcODbnHMxp+x5TqekhIExSjIFgURkclzvNRt4xmmQPqb37oUlO61dE4TsAMjr4PMXxWiyleV5gOa1P0GpdukQDzToY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LixTWxbg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PMszc1BO; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LixTWxbg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PMszc1BO"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 9A4C913801A9;
	Sun, 20 Oct 2024 18:15:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sun, 20 Oct 2024 18:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729462520;
	 x=1729548920; bh=rqx4o7Il/mkitrz9hyTelQxGfKF8okf8GuLgzLbgABQ=; b=
	LixTWxbgeh0xnlRjEhP+/+Ot1yEfCsimt6PWgj0TD5T4G6b4r9A4XLf1KP39nJLi
	umkS7HKE8Pq3XRfhxcKfGjdIp/w4ZZOntelILKw8Cz+8QiYORH/MN3qMBnpCmPoq
	H5OPyYdUJ+9CDz6x7o7w3+j7GnfS8zP+DoK9yFYU0dP1BPaaaNiQ+/Aw/gcPvTlv
	Taxxb/uY2fcnaz2X3gApemsq8CqE/lD3cgOhPcIa7u36QIg6KjFbHC8jAl0gJgpz
	u350tG+ogEjksveYUCSmrTcdfTIIq2Q0EUbQu7VRtCu4Ao5ynUrkiLFKLwQ6t6wt
	ovrfkthkyXffFdD8zNjfKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729462520; x=
	1729548920; bh=rqx4o7Il/mkitrz9hyTelQxGfKF8okf8GuLgzLbgABQ=; b=P
	Mszc1BOKAlrhhIHIOOzqp0yu2z9P0qXhp7ENAj50Sahu3XVkaDIxKR2mVv/jqzkG
	sm16vguZ3dHiBkxyRQPfD+AuyFLRvgoBEb7bMZP4GJ/9qw8KqBwPm7qnVTtDRjQs
	E33O0VAzgeddiy3m9xhiiB1CqozRGG6lEzken3lYlJvlYrMhQDyJ2YfsKG71LOkz
	7kTRr7v0dp7ULGIYXjHW4fno10ImCi1gWNgfd4b3kk3/fjIyhkZV89y44BFvA0/P
	ljcqBtcbsxl/daddS9gaDF2r3DGoFRnc2Ee7XvdLIz+HxEIVw7GQbqSMR2OQP4N7
	yYY1ZMo9PHaNj2JnWFXTw==
X-ME-Sender: <xms:-IAVZ36db0o1LbHXdp_w9rM8RS8YXa7SUfKraXWlBpfTj3nFbJ3ELvI>
    <xme:-IAVZ85eI7WERuqaB6XfGVLLvNzzkhgRaObhW4VyPsi_UxJ-GiWW4YbUlWH5bVHJ6
    86qKoxhb_7-GKcGSA>
X-ME-Received: <xmr:-IAVZ-fJhOjqYgu5xUMUXqhPO22ZlQ4-uDEJ9ug050PjCN5wWRcxtbkNY64ov51amWIsFwjLmDPtmV7qUF6XjRqAyXNX0juy03JHLJjVCBDcF82Am_sFYmNp6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehkedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffgge
    elhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfeknecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegushhimh
    hitgesmhgrnhhjrghrohdrohhrgh
X-ME-Proxy: <xmx:-IAVZ4LtxgUQwR77a2qBZnnCZ9QiE1uyKDYMILkrNtEkkPnN4uzZcA>
    <xmx:-IAVZ7KwMRvnaCllJ2qmnOJRa43F4EGt8jJ9uHCWTEIsRX4nWUyFKA>
    <xmx:-IAVZxzE5vnMgEvkbv0P9H7hgtCn1zOOzzBl9SoyjppRQRaOFXLjCQ>
    <xmx:-IAVZ3I54D--BT5Wzla9tb9dYNhleSrrqxn9t8xJsBzDC-y8PhoBAQ>
    <xmx:-IAVZ4HEAPD-FnmCxJZC9F_FLrQcEpegS3kL30Ys6l6DGmU8_QAbp7I6>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Oct 2024 18:15:18 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	gitster@pobox.com,
	dsimic@manjaro.org
Subject: [PATCH v2] t7001: add failure test which triggers assertion
Date: Mon, 21 Oct 2024 00:14:46 +0200
Message-ID: <29d71db280c972c91174bd0a501af66be72643af.1729462326.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <ce1b5ae24ed8356b9beed340fff61e96f7c1d549.1708259215.git.code@khaugsbakk.name>
References: <ce1b5ae24ed8356b9beed340fff61e96f7c1d549.1708259215.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Commit-Hash: 29d71db280c972c91174bd0a501af66be72643af
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

git-mv(1) gets very confused:

    git: builtin/mv.c:506: cmd_mv: Assertion `pos >= 0' failed.
    Aborted (core dumped)
    test_must_fail: died by signal 6: git mv a/a.txt a b
    fatal: Unable to create '<path>.git/index.lock': File exists.

    Another git process seems to be running in this repository, e.g.
    an editor opened by 'git commit'. Please make sure all processes
    are terminated then try again. If it still fails, a git process
    may have crashed in this repository earlier:
    remove the file manually to continue.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    It’s been a good while.  Let’s just add this as a known breakage?

 t/t7001-mv.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 86258f9f430..739c25e2551 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -551,4 +551,16 @@ test_expect_success 'moving nested submodules' '
 	git status
 '
 
+test_expect_failure 'nonsense mv triggers assertion failure at builtin/mv.c:502' '
+	test_when_finished git reset --hard HEAD &&
+	git reset --hard HEAD &&
+	mkdir -p a &&
+	mkdir -p b &&
+	>a/a.txt &&
+	git add a/a.txt &&
+	test_must_fail git mv a/a.txt a b &&
+	git status --porcelain >actual &&
+	grep "^A[ ]*a/a.txt$" actual
+'
+
 test_done

base-commit: 34b6ce9b30747131b6e781ff718a45328aa887d0
-- 
2.46.1.641.g54e7913fcb6

