Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567861D63EC
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391419; cv=none; b=eRZO+A4IJcIXjgocpMqs9hivCIxE1/pn/90Ye+QNUpHoMDWl5cUL/mPAWcqtUhJ/yyIvtpXKvVn0OWMvL5E+CwdDNLL5AQFOYVcjfqma9HDRQT+biw0XvI1paKGQEuBHIDGMKcHyRswIEVFneGjnoQ9X8cddLb0KN6+p2dWpzkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391419; c=relaxed/simple;
	bh=QFrusp397+dOKKcr4SKzF+LoFWbtbFJiGTftPiq2ZZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AkoMQAVKIdeqHjiOmYOAcTamDzBiWTOf3gYl8HFt3M3rnm4r6EQ0SF0nOD8xEXE1IUdpDDysU9HZhUszDsOP2AWMwZe4/WCAzIV7r/8gny9Ji8WSLToVbdVQTFlaGx55Ce73vc80/OiJAGBCmiJG/afvyOxApCfbT7v9vdwefcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=z6aEWp8b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3uDd20UA; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="z6aEWp8b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3uDd20UA"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7F6E911401D5;
	Thu,  5 Dec 2024 04:36:56 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 05 Dec 2024 04:36:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733391416;
	 x=1733477816; bh=h80l7HwccbjgUZiQGYrPx7hNd2Zha/Q0iHlJ/tqYFt8=; b=
	z6aEWp8bngqrwR8zanC8byAZ6fNEAiuZpkmK6oPug5Did9+u+NsKUJf/lcjYtD87
	Y1w598JcdJaUhhqeA6nzjleQv3UbK+Yv/EQdpFCGRWia+LicBAl6x4bXQECEgz9/
	dw9wqFwXJyHqd9qTnUbULcrmujQnUEJq33RngkbmqeO773JVDOXYMb5B6oslA0CC
	Vls2CyspBEb7K6zFX4Vo9fq+m56psJdyyGsPmFj8C8du3L1j0uuq/RKua0xtyPoq
	0rKNDbyds0EkmmeHtQ69P4F2JonXmRux81AdwYoRdC3vh+Qq04HHLsdD5KNZUPud
	2nc4SfbQNJAbE0A6YX/4Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733391416; x=
	1733477816; bh=h80l7HwccbjgUZiQGYrPx7hNd2Zha/Q0iHlJ/tqYFt8=; b=3
	uDd20UAMAMPmay0xYy8LcPF03AXgVScOqk4L0A+rr+/RYoDWoakLNChIwLFul4KA
	X18hfTOBHmobzoZWpMF6hHhp+yzZ6tzspRYV/MGvRG9gx/ZQJ3qJr5kn3/EhilgZ
	eZdH0H/ul8113vS+wlshyZVTduZMhJE92wGBHe2o6KSDyf443f90ZcF3CWPLy1cK
	cf44SiQIAGCqP2l9kUyYqF11lJvkt2pP/wYg4nzesJFlU5vrh7BC6RZFI6pIUYBj
	p64sgdZyoS5foSXrlVnnmQ3OEJLmkvfdqPiKPm7aDh+zQOrYdfTbdFlA1YoqQuUK
	YqZ9I9b9X8WhOsufpHc+Q==
X-ME-Sender: <xms:OHRRZ4bQb65PNNRskFTAPBNhjBsPpyuAIiVaLapu5or7aMSq9Fuwcw>
    <xme:OHRRZzZJcnKYtACZnOP0tFgjUs-rbhIOzcSZ4ZUHId8jCoCW3OHi-N-taZR_zL_6x
    AwGjptDP9YQuxiFSw>
X-ME-Received: <xmr:OHRRZy8ImLGSdjYQcmP1UdapZX4QlAQsO-41QVJng13rGk58VpmCNDmqWAR2jZxJ7J15Vd4eqKxPciVs8QXaMONsSsVXFWb78WxBtmOfkLY2CA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhh
    vghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:OHRRZyoiTcf5_pszI6O3k8FecBEJIwmunidENKwmPCKwUf6o9ndB8A>
    <xmx:OHRRZzoMhU-3wqwHcP0CMVMeHJCQaYwfLmFhe4MwT1VVCTn8cAulFQ>
    <xmx:OHRRZwTtAHdM-IuhL3DK-4qmoXFrvwCSUM3uXBqLREaQeGXhZryMkQ>
    <xmx:OHRRZzoUpOr4Hb2OiJKeN-dyAJQ9dKhbh4Ah41S9HGryFStk0yYtJA>
    <xmx:OHRRZ0kwCm_X2WKLOrNGkgBwKm7JZZ5T-NtVwO-cBgol68GSVBFsqUlO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 04:36:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 60f3aa4d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Dec 2024 09:35:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Dec 2024 10:36:31 +0100
Subject: [PATCH v3 09/15] daemon: fix loops that have mismatching integer
 types
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-pks-sign-compare-v3-9-e211ee089717@pks.im>
References: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
In-Reply-To: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
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

