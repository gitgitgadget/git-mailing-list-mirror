Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E790F3594E
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569828; cv=none; b=LiMrvqEfiK9VIf3yLtIouYD3Np1ERCQFUvq7iT/LpoAfuaIoBbI7vOyyAHG/DqSaseCC1VH4umPIjzNCmcp9QAwGKPM7yKpeVFzsz/ywtNjbo/k/hoFALCT5MGJzacMmviN5SDeFQqpZnLVg9TJh64thdAOR/Pu8k60diLNZODU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569828; c=relaxed/simple;
	bh=538gkqib+Zmt8jLpKMzEywM5PmF8jhMTRNmzeAf8qTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jduf83BPkey/KmD/iLHw/2TP022dF6Bm1RU7Y5xKdHGIS2xEfIoG9rUrY1RnjSDOYM2z/3PyXoA0e4S+E/fuKkZaC3UfYwYPX60xzhi5WBQIPlhcQOmnckYzrCjm2cK1jxnhM+2LkEjAi91gnNu5YaNVo25Cost+bdaaV3SkWmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hktAppXv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Raa4AdL0; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hktAppXv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Raa4AdL0"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id C7E5D138009C;
	Mon,  3 Feb 2025 03:03:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 03 Feb 2025 03:03:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738569825;
	 x=1738656225; bh=/B7cCQl98VIFXI8l2YTUWoKsoxfB0PRWDidVVzECTp4=; b=
	hktAppXvxr5vHNtSe92scXkY5qjs3pmS/arxKkKNWH365ysk3Zj1DmYPa0WWbVLS
	guB873WzjPl80BEQ5hP7b7VR16DuNaZsOXIzxkQHShxMUxuiFFjD8AMwFSYYpQtG
	TBuC6FvY75RX9kelXPZcEXWCPTB8bhkHLct2oT82SCp7nBuD93OfuEhWg8efS+Hy
	CaK3ama47wH+xOxNCjQQQhhRqthtWzlxvrrwviZs8106DOUxMi1e1wDMTgKo7cyI
	hKkPc2+zb1kC1upcJPG8pG2TWYdX47zjKD3euGD8YvyS14g38EK5HQi8uJIaIdhM
	sPmI/hL/tOEojVlnMosp/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738569825; x=
	1738656225; bh=/B7cCQl98VIFXI8l2YTUWoKsoxfB0PRWDidVVzECTp4=; b=R
	aa4AdL0IC+CHl3/XTK1YynMTEHkJ7vTbwNHOnljaqtEHB3VjVy9JhSCOm2cB45cN
	xpPs4aheMWT4RaHQ6YNyAz3uRwwH9C8PeyNK3+IDyWQhEHWGr5lSrsKpIJnT7her
	PcyUkN76MOGtbMZJCmUXf+EIQwBO/P3U3OCD6rFBDA99tOfYE+ijz7DBTDT/JcMV
	2IrlXMWt/phykaRCc2PccpPIvSOCl938iVb1INp8BPry2iCKKAeiviyoRT9W7JPl
	bAMpBalr9pMd2nDG8CJWvsN/l730KIYyF9gMN/CiJqbKAkudTB984nHaJCBe8KOy
	ZLv3kTlCpdXmLGVI5FCug==
X-ME-Sender: <xms:YXigZ0l2VYl9ype36pHmbREBygp48AtL8xJN1a51dcYStXnTtL1z3g>
    <xme:YXigZz0P6-JBXBU8AAxHTmhsHx9YC81OamlaAMCmgtFm2uyUfs4O_XL41NvMjc1BY
    YeVRdEJElhAR_bPzQ>
X-ME-Received: <xmr:YXigZyqjYremTnMGOSEKeoFNZKJFTH4tbeHUWxP6cJDvsYMjUU991PfB63fpBuBrLmbHCcTCN80vcdTmfNO3CbVEmrbYsr-QbNOG223pkbplsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghthhhomhhsohhnsegvug
    ifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:YXigZwmhMs9YntUQaq0mk9dg-4yr4gxfJW2gMNKZv3JLxXvLzTHU6A>
    <xmx:YXigZy1rzDNMNB_HLH_69Jv8HhyuRsDWlG21IJx_uI15rq_BDA-eZQ>
    <xmx:YXigZ3ustgpxmPndCk3MwWM1RIm7gNhGkPndmwLoLvJJDaU1WjzKhQ>
    <xmx:YXigZ-WDv8ysF5qhRTNpxfxLqcOViChCOC1zD4QLv0iGy9C30KG6Zw>
    <xmx:YXigZ1TKpfe-Lj3AXDfmbG3tKsZzmHGOKTdVmg79sM0m0lENZOdsfgq0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 03:03:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1b22b87a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 08:03:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Feb 2025 09:03:32 +0100
Subject: [PATCH v3 01/18] reftable/stack: stop using `read_in_full()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-pks-reftable-drop-git-compat-util-v3-1-446c9ed4ee9e@pks.im>
References: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
In-Reply-To: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
2.48.1.502.g6dc24dfdaf.dirty

