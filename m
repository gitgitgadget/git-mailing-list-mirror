Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5005C19E836
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886034; cv=none; b=aQf6iUOVRZWYFcV5yrca/IjenhXE9f3t5+ZX6/Y8SFfPMJtyqmFt982V25G9h9YYP8CM8zCCuGbG/Nx+wFZw3QxSp4K6Db5wg6z8Y11PjHPiIgqPm0uFOqSVESq1KcEKyAm5d7Z/yV46O/kOmwbJZcAQGTYkQ14v2cjucoDNqvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886034; c=relaxed/simple;
	bh=QFrusp397+dOKKcr4SKzF+LoFWbtbFJiGTftPiq2ZZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DYcShOzg4MYGU0c0kgxB5WJ8Y5VW7Do6L/Vd1OnyXphFkg4djd0l9/xtEbroQKgUvZL+PTI+nrY3v+6xNAoPbvQPovZFdCDt4lo/rkrqzkT+PnUHgYkat9SlihOx5mL1LSZbnKEzjBXbdGy5Jdsu4l6cJsikiFYSZmwuePvEujI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=x0FJapwk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pFpoKwms; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="x0FJapwk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pFpoKwms"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4B6A02540103
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 08:13:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 29 Nov 2024 08:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732886031;
	 x=1732972431; bh=h80l7HwccbjgUZiQGYrPx7hNd2Zha/Q0iHlJ/tqYFt8=; b=
	x0FJapwkS43Fbg1AWHx/ZzgJTym2ZZj1kR1NGp0fv04TY2MnUSkLYewfUMrnbBz3
	9HBFG0Um2LfrsARTpPm7rvfp9kail0cOkbfeZF5DLqWf2uv7QkSQ+M4ICNa7oOdE
	R23pBIqzFLYQTv4PwGnC1wIrLcbvstSGnIdoq/2QKcLBU/D51c6o6+UMQHIOTegP
	dX8cLyHZPVG15U6EUI6zT1wfFi7zGUwPN/EiK1ja3B48z/nEwiv3Dqk2+gfEILr4
	Pvyk0lpiO9fyLLriT6CH+kzBrGWxs0s60yTJqaRQwitf412Wu7QxINE5gatQcMSk
	ukx22Y3o0D0yigFDh5fn7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732886031; x=
	1732972431; bh=h80l7HwccbjgUZiQGYrPx7hNd2Zha/Q0iHlJ/tqYFt8=; b=p
	FpoKwmsyouMS4nSERgw/2Ur/s1nElSXIDKwm+OIWHzPVcCznf19sjtMwGH3UZzHE
	YwCeKqCYgIaAh0yxKQzNjS/2dq35YOEqz44nXWCo4fZK8SYGmicEAp0CGwhLp5Zb
	hdJEvh6LRoJ2/UapzTxl0mPXx6Fm9RiRmZPCEJTh869Owd05oIwdcm2wq1saN4ok
	82T+uDz+pVgAlmRL/yWB007KPSO/rrAcXPfDePCs3R+3F0XDBhOxB18+AUrL8oUe
	Q8JKcBVUTkarSZnYox7fNS1A9mVQxYWZDUbCx+Lqdu4LH6FMA7N4powJqIG7bAwY
	sn6eamPQZ6+MxeEXthSqw==
X-ME-Sender: <xms:Dr5JZ2nQk-_w-hq5j9joTlruwmZQ9gaoM8ccqbOMbVS4-P8Xd_NclA>
    <xme:Dr5JZ90u8EWpcyAClZaxcYerOa2iex4cexzZmbTsGTHD3v1n7omEU2W4POad_G9lj
    fvBnwtvYHcyOP09zQ>
X-ME-Received: <xmr:Dr5JZ0raemLdGpC94rj-dEC8tglLWmXG9cMCQniwRdwK-qMwcE4SHw5V5RbH-6QK2jLrDFeHr7jMuaNJGK4QQRQOzSQw4VAFqnoK8g2BqZT1_mPkEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheefgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Dr5JZ6nZiPtE99cbzouYn7K_LpxF9W0KhRThbgfIqJ4JrCvjknAIjw>
    <xmx:Dr5JZ01H4n6rLZuOw2Vbvt2vAz3fLExmCSDafb3GI5alkUHg_WYtMA>
    <xmx:Dr5JZxsmSlQNLV8hye_8qHnr7y1HZIc6z4QaxDdv5XUoEbfVHVU87A>
    <xmx:Dr5JZwUNUH-AT_pknLeyrvexoaA2vhm-7CXUx0516fSyZpbkZdkqKQ>
    <xmx:D75JZx8RmPMYZrbYl_229VtVFlrfL6PY7a4_lr_OvSWzFljqIksG-O0X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 29 Nov 2024 08:13:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d537a2c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 29 Nov 2024 13:12:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 29 Nov 2024 14:13:30 +0100
Subject: [PATCH 09/10] daemon: fix loops that have mismatching integer
 types
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-pks-sign-compare-v1-9-fc406b984bc9@pks.im>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
In-Reply-To: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
To: git@vger.kernel.org
Cc: 
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

