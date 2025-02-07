Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231231DEFF4
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738929128; cv=none; b=gizNMsIp2+5F1IZEM2r0KCCmlg/zEwD03Fnh6XYvBp9fZpVt/PZWEy3UlRRmh7SedIMJdT1g8+i9InnrE1V3wqaz+5uE3X9aFaTkR7W1EiJdepmFuv1eOiBKte6l2iHFfURCuKj0G6lc64uZHVf9rd+h5Xok//HSh8j5gsRmoOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738929128; c=relaxed/simple;
	bh=81LTn7UZRORPY2teFOFZFj1OqCLhZ9jWJcErZRHzdVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C1OpzqP1NLrRPtgi8orNLfZ2QKtZlgC7SOF8uyYyV5o/B89qCOr3i6K8i3ly2B7KpOtX0HV5s1Mgpqv5Y0TWMOI0+cGol0IhvZQVRpAI61+w1rSlje9xSr30oi9AQjFQQELHGa8QP6YFn6WcxfbiLjZ/11h7SC4bXv/56qU4NNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JbOjvOIa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MnML3KLR; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JbOjvOIa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MnML3KLR"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 65533138016B;
	Fri,  7 Feb 2025 06:52:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 07 Feb 2025 06:52:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738929124;
	 x=1739015524; bh=nIlvnYQGf294FuH8JnUpltKC/aiSknWtZvi3roloRoU=; b=
	JbOjvOIadfOjqRVJTsAV7zcrFc1comRmTBgyXGv8ud8nlIJEn+SBr8zczkzmLBgG
	4A+RekK9WbUe3KBLYH/Qy88+theD8SHnBuU84WmCS0hkFQQapH9atPsmABeWiotj
	8w8CEWjWMkiaqtlIzBUy5lPi8438EwpL/ahj5ZPrkA+C5Rncun8D7LImAaaEixo4
	mU0rsXXnR7rkFRaX5tj4kv1CZv0MZGOgnBgigMbX7jGRICW8KyMQ0Fz/y+mFvgP2
	yW94Lkzj/Ms5Rav9pJfYqtwNv445bEOxndFiVQARyacWpqKQiAnjnrNQU59MbrsF
	ud0hOuUMzUNvvwbOR/lryQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738929124; x=
	1739015524; bh=nIlvnYQGf294FuH8JnUpltKC/aiSknWtZvi3roloRoU=; b=M
	nML3KLR/goLb4vPj9iUaPbG3WM9DYe3TuR/AdX6SDr83qq0zIBxR3WQ/oGhMzbEd
	oC0ykhPp4JWEaXTRwzbxmKfhP/Bu248rgynAjFNsNQpp0M2HF9+W/mV9NrqUmxJ4
	sO4Lo54isqBM7LS8hK5Z1NoepN8sd72HCyDxzXjmxGtQJwLblGs4zuRdIavhJbbq
	6COZODg4JZRt3tD7kUX9lSIirVSNiD57sJf9g6WPHPFp1kvVOrsCYD9iSie/SY5a
	oFfL50rIZGbwZhb1KEQSSl3a6PxpQwV8gwZjsmgFPVGxjlvomeq7wB3NmR1CyG0F
	5AV77T3xTk8Uvf+ypKbQQ==
X-ME-Sender: <xms:5POlZ8EdKd-BIkmpTxXv-zDh0evoE29snqoCB5DMNqLGVRFHUnFNKA>
    <xme:5POlZ1UtHwl7uH_VgIVYLfsdcJ69yrYervjoF89TCkPqxc9A6UmDHHckvIc_1kKFa
    yLQ-jUlEA6xAkih5A>
X-ME-Received: <xmr:5POlZ2IDvVz2qYMKeehrQjaN-209wKugqIbWBwOVjcQ2OCjgZk9XbNFuKiIkpPZ1L1nALHDr9A15Qdg6i44fxtc9Ms5pPa6WrX3gqBU7C3Tr4bIe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegv
    thhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhg
X-ME-Proxy: <xmx:5POlZ-Hov6x8LfUlIFTfEsjVZwymAlrT98PmzN42Y6FKWlRk4NxnHQ>
    <xmx:5POlZyUSoAIkOteCIHOBAuqoxPXrKgIEqHSxgu6uUjkQR8gFx3V5Pw>
    <xmx:5POlZxOUdz_cfhM6NSeOD7SZJ38VjVhFZvA_sf9MhmCLddsVVR3FTQ>
    <xmx:5POlZ52vFOOlvZKS969Qwe_t0yaTB7c7r8tt_7swgISbLs9_p-HbxA>
    <xmx:5POlZ0fUwSA0h67W3uD3Id1zYdgTRwyyNnPLbnIp8umo-A3SY0hiknJQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:52:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 73103caa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:52:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Feb 2025 12:51:56 +0100
Subject: [PATCH v5 01/18] reftable/stack: stop using `read_in_full()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-pks-reftable-drop-git-compat-util-v5-1-ba2adc79110f@pks.im>
References: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
In-Reply-To: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.2

There is a single callsite of `read_in_full()` in the reftable library.
Open-code the function to reduce our dependency on the Git library.

Note that we only partially port over the logic from `read_in_full()`
and its underlying `xread()` helper. Most importantly, the latter also
knows to handle `EWOULDBLOCK` via `handle_nonblock()`. This logic is
irrelevant for us though because the reftable library never sets the
`O_NONBLOCK` option in the first place.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index f7c1845e15..d57acd9540 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -115,13 +115,16 @@ int reftable_new_stack(struct reftable_stack **dest, const char *dir,
 
 static int fd_read_lines(int fd, char ***namesp)
 {
-	off_t size = lseek(fd, 0, SEEK_END);
 	char *buf = NULL;
 	int err = 0;
+	off_t size;
+
+	size = lseek(fd, 0, SEEK_END);
 	if (size < 0) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
 	}
+
 	err = lseek(fd, 0, SEEK_SET);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
@@ -134,9 +137,16 @@ static int fd_read_lines(int fd, char ***namesp)
 		goto done;
 	}
 
-	if (read_in_full(fd, buf, size) != size) {
-		err = REFTABLE_IO_ERROR;
-		goto done;
+	for (off_t total_read = 0; total_read < size; ) {
+		ssize_t bytes_read = read(fd, buf + total_read, size - total_read);
+		if (bytes_read < 0 && (errno == EAGAIN || errno == EINTR))
+			continue;
+		if (bytes_read < 0 || !bytes_read) {
+			err = REFTABLE_IO_ERROR;
+			goto done;
+		}
+
+		total_read += bytes_read;
 	}
 	buf[size] = 0;
 

-- 
2.48.1.538.gc4cfc42d60.dirty

