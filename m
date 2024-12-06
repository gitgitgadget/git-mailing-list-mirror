Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ADB202F71
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480867; cv=none; b=JdvtmwkSresWvnCkQ3gAGR3+N3aaCSZ9QstS1KZoLgoVm8C0D4MdDYZIii47kkMtbapaCqIWqb+QsKJJnspPfzkXSUvB/s9d2xCpiSMGS1nP/hJYKuJcNc3aoWCsLympRM9gJQl+rafKoDmVAw9mqU5x+2wFU5uzU/Hg10qEXRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480867; c=relaxed/simple;
	bh=QFrusp397+dOKKcr4SKzF+LoFWbtbFJiGTftPiq2ZZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=htHNAIu9vxvmGvE/GLJC4z+jZItxgm/LulVbVDrXtWgqvn9GNvP9gPOPr3h++K/j+hlBjLL1QdvpZy1QQRhWNK3gvvFMMATuBNTbIf0I6/SDurbx/BApTNfeOaxRAVKgwOa01hSmdFEfH4HXhBf9iLYC5adXqToAI5jEv3NCxE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e5zXIBMd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2bNoyd6x; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e5zXIBMd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2bNoyd6x"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EBA22254019F;
	Fri,  6 Dec 2024 05:27:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 06 Dec 2024 05:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733480864;
	 x=1733567264; bh=h80l7HwccbjgUZiQGYrPx7hNd2Zha/Q0iHlJ/tqYFt8=; b=
	e5zXIBMddN01qCV4ywiyK6UH7A3F/gJlK27BTQ5ZxrbhUAFmXUJDTdmUG+nsIUlU
	vzOT3aUqNID1Nl8LarYsSAXUbO5Dzf1ZWJcvgMUOEDCYp1lvoEKXb0vf/ep6nl+N
	y5zrRp7Rh/dB2XCfQNa6xjtv7ylGaxf3SVHW9qANqBXVsjOlq7j4BSyKUf7WH4yD
	nDBR+/r3Mr6JrG5Xo/SHVgiaXVN5DLzPJabtv721r90xSfTsVQpvDQb9Mi5fX3JK
	t68SLclLHGpaMfikotQa5iIyg/PiWKqDdCktfmnOJiYm8nxkVBxpdTHRDWE2wlEW
	9jBId96FlS2xVm5jgNz1bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733480864; x=
	1733567264; bh=h80l7HwccbjgUZiQGYrPx7hNd2Zha/Q0iHlJ/tqYFt8=; b=2
	bNoyd6xXOGTVx2t/9wEFvS7qqougXF9y87SZeWuS6VAEPJq0BDewK/vTfEf0Y4OU
	yKc/+/DU0fecKtKjHPwU15UhFn4+wyLGyBpeTn4gxGxFZdgm961h3lkmod7OfMqA
	62muiJnPUTWPWEW1wVrVNGG/tw1/qtxp7qCAsezTAVywzvhOvyf2d0h4siw6Q7HD
	GlNkpukE5QX1UmAGRze/b0qdA9Isud7LUimHFpEox098aa4/1OqhHWZ74K/Up0KM
	RvVs3v6rtg7ohdxDlurpSlzePmm9dzqR7s+z4OjPHq7QpBCXWjWtDn2zdJB1cabB
	kqGPywQuiekwp5/20Yj2Q==
X-ME-Sender: <xms:oNFSZwAhcI0Gfh_RnTN9-tc-lDa2cNjNYkhnl5mAhBcOyS5QoLjCOg>
    <xme:oNFSZygpWqqhTQZllxyPmc2HhgtvlsglFZnBvc9Fc9WbMHo8L4KtnI2tnnDoGm0hy
    ZAiZ5NPDb6ngCwQ7g>
X-ME-Received: <xmr:oNFSZznOnSEYHDIPsMJlnq0Qd9HS93khnPuytJErjQrIttjCLceVBiHz8EoQEOazQbBLeo2S1TcFek24mGvq-NSL70-rp_ThMA2Nnig26VJzNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhi
    rghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:oNFSZ2xw5-Yty-VwuI-kwMmQ_sGR9141Uj9KwZP25dPVtXvC4jgc5A>
    <xmx:oNFSZ1SqX8dBhkyPgJSzVR5DjZKcN5JujxeBgp8T3_T8LtP5B-sXzA>
    <xmx:oNFSZxaaGTU9JkKxAjAf2Kwv4I9XiHSjd9PxrqMqewUJ4cFaVD0rVw>
    <xmx:oNFSZ-TwOy9ApLWNP0NlUvD4vzFkH0lc2qn8rUXdx_W-fIu9mLWm_g>
    <xmx:oNFSZzM4PRN6QLU-nz7u5MXP8xEktb4wL1uSd2LYJw2Od37c05YdXK4K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 05:27:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2404da87 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 10:26:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 11:27:25 +0100
Subject: [PATCH v4 10/16] daemon: fix loops that have mismatching integer
 types
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-sign-compare-v4-10-0344c6dfb219@pks.im>
References: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
In-Reply-To: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

We have several loops in "daemon.c" that use a signed integer to loop
through a `size_t`. Adapt them to instead use a `size_t` as counter
value.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 daemon.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/daemon.c b/daemon.c
index 68789ceb222eeb389d58998fd00388f289868fc3..bf313bc21a0b82a12064c534af78c9ad51be78e6 100644
--- a/daemon.c
+++ b/daemon.c
@@ -503,8 +503,7 @@ static struct daemon_service daemon_service[] = {
 
 static void enable_service(const char *name, int ena)
 {
-	int i;
-	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		if (!strcmp(daemon_service[i].name, name)) {
 			daemon_service[i].enabled = ena;
 			return;
@@ -515,8 +514,7 @@ static void enable_service(const char *name, int ena)
 
 static void make_service_overridable(const char *name, int ena)
 {
-	int i;
-	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		if (!strcmp(daemon_service[i].name, name)) {
 			daemon_service[i].overridable = ena;
 			return;
@@ -737,7 +735,7 @@ static void set_keep_alive(int sockfd)
 static int execute(void)
 {
 	char *line = packet_buffer;
-	int pktlen, len, i;
+	int pktlen, len;
 	char *addr = getenv("REMOTE_ADDR"), *port = getenv("REMOTE_PORT");
 	struct hostinfo hi = HOSTINFO_INIT;
 	struct strvec env = STRVEC_INIT;
@@ -758,7 +756,7 @@ static int execute(void)
 	if (len != pktlen)
 		parse_extra_args(&hi, &env, line + len + 1, pktlen - len - 1);
 
-	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		struct daemon_service *s = &(daemon_service[i]);
 		const char *arg;
 
@@ -1108,8 +1106,8 @@ static void socksetup(struct string_list *listen_addr, int listen_port, struct s
 	if (!listen_addr->nr)
 		setup_named_sock(NULL, listen_port, socklist);
 	else {
-		int i, socknum;
-		for (i = 0; i < listen_addr->nr; i++) {
+		int socknum;
+		for (size_t i = 0; i < listen_addr->nr; i++) {
 			socknum = setup_named_sock(listen_addr->items[i].string,
 						   listen_port, socklist);
 
@@ -1123,11 +1121,10 @@ static void socksetup(struct string_list *listen_addr, int listen_port, struct s
 static int service_loop(struct socketlist *socklist)
 {
 	struct pollfd *pfd;
-	int i;
 
 	CALLOC_ARRAY(pfd, socklist->nr);
 
-	for (i = 0; i < socklist->nr; i++) {
+	for (size_t i = 0; i < socklist->nr; i++) {
 		pfd[i].fd = socklist->list[i];
 		pfd[i].events = POLLIN;
 	}
@@ -1135,8 +1132,6 @@ static int service_loop(struct socketlist *socklist)
 	signal(SIGCHLD, child_handler);
 
 	for (;;) {
-		int i;
-
 		check_dead_children();
 
 		if (poll(pfd, socklist->nr, -1) < 0) {
@@ -1148,7 +1143,7 @@ static int service_loop(struct socketlist *socklist)
 			continue;
 		}
 
-		for (i = 0; i < socklist->nr; i++) {
+		for (size_t i = 0; i < socklist->nr; i++) {
 			if (pfd[i].revents & POLLIN) {
 				union {
 					struct sockaddr sa;

-- 
2.47.0.366.g5daf58cba8.dirty

