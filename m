Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CE120D4F8
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 12:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141108; cv=none; b=YKUzrntJjjz/rDgDD7XWfizSfnkW894ViSc8dte8XgSpUySZoqlpPMw+n6iR3wXKJXEAoQ3x+1J804JCD6EPG9JAnzd/cNYczSJijx+S908SnqPF1bLvE0ccZw4lSatAHncmlhkGm5vd55WgETlnKxI5iZP3PUn9HIpszDkb/Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141108; c=relaxed/simple;
	bh=QFrusp397+dOKKcr4SKzF+LoFWbtbFJiGTftPiq2ZZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pnonljvTLiS6/GziDoWXpVNXQkAxS3qgXNRtriZQJo3A2D/JtPoFPdcUfgLIXwNOFoRqCJZCLtn0Zo8OmVYXwNQIcT3/kudOrJbwfEaO5TPS3cmENOE9XXA/qdsckoOXQWJni2syZ+zxLaSYIOC+xM1u95jjdvWmG0ii6scjw9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wPiBq1M5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tqjh4tFF; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wPiBq1M5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tqjh4tFF"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A205A254017A;
	Mon,  2 Dec 2024 07:05:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 02 Dec 2024 07:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733141105;
	 x=1733227505; bh=h80l7HwccbjgUZiQGYrPx7hNd2Zha/Q0iHlJ/tqYFt8=; b=
	wPiBq1M5ZaHzxK+BZ5qDeAb1xUoJyUyBLdqmX77qSby9mDCFahKL2+p1xT6CQMRs
	5QqETAzw6gPbMyLa9vxY3fOLklIIZrMTjlBi8PCFhsnl9sme+kHMenOSTBe7y0kw
	R6TTcDfHqPFVDgZkfHzfjbF1jBYphQ0Vhr19+KE4HWtmNq/JTZU0rSeNZNRoDqff
	0WVfohujxhd6LQob6G/mRGimuv8uUphbwhDVJ9psIf6fY5yc5ijGJAYHisr6TKsI
	byHFCLpYG4yzWYtk59yLdbnUH6XxbMABkzWEWNYzKSaSWiFi1rPy6wMhW4QlgxaU
	fdR2JnnCxoZmXt5Tfx0GjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733141105; x=
	1733227505; bh=h80l7HwccbjgUZiQGYrPx7hNd2Zha/Q0iHlJ/tqYFt8=; b=t
	qjh4tFF0E1Yj79AmmVlTV6e6tNTeYuLYGtloWn1KTkmZYGYfB8eyMucVfMSA8Zry
	6t/GY//Mu4B10gBPkNnXDT+4mVpDwYn7Tk3iGxkvqf33UU3zTs6ADjaetSwLNt3g
	Gg1BOO9sFvSSjSW0DaWV+SQJ0lq09okeTAsMb5WfCX6TWBUJHWyNkw7F9f/Uht35
	xjs19Tf9JiV6pliAejgTHh2qcBCptftJo+dcjMCtlg2GkjOuz1nGXWCZZSUkizUU
	Xq1KsdX/2TAKTJRovKf3x4uD54ULz1vDXxrd2UL6YAzWxb8nStLoSbNOuq1U9T0o
	ugxG6fLWIFVsVUHYIXgAA==
X-ME-Sender: <xms:caJNZ9LexMlfj6oTiacH5z2Ec_rYq1bg8C0XfNcYYDloTlztW2oHXg>
    <xme:caJNZ5KnkZa2djhjyTLAolGV1v-2iK-3dKXyxReORTl-wEFJw2gmRVR8NFn2IPxDC
    JAyBUlmCy96ajspEw>
X-ME-Received: <xmr:caJNZ1vdiQYfxmfOI9j7jPXVGzHdyK2xZKKLosno5N4R50zpHQ0brpkSxThvN9ZbrkhAV8IOhxoJ7ZgloYNk-XlMbps6CzF08d5-Ylzc970iVFIJdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheelgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:caJNZ-ZtWuS-HsO70a2Un_RZGMs4EeJLOxOm7jiqpHULHWuQca4Jbg>
    <xmx:caJNZ0YziXmlOb0zKwRx4_yaMFKTb_1wjtt59bTexMdaHZ2zryaQeA>
    <xmx:caJNZyBV6nyGcPVprt70Sqz3vTHrANHkrQXDwQGJdRx4BMcWlNLGnA>
    <xmx:caJNZyaQXmTKUACF0xpErmZFP9f_CS94l8bHoq92OvqpUHij9FwHdQ>
    <xmx:caJNZ8E-XLjAoP9Uy8QfqYPbCXc3bxkS7NQUkMylVn-384p0bsnALoWZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 07:05:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cd61aeb5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Dec 2024 12:03:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Dec 2024 13:04:40 +0100
Subject: [PATCH v2 08/14] daemon: fix loops that have mismatching integer
 types
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-pks-sign-compare-v2-8-e7f0ad92a749@pks.im>
References: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
In-Reply-To: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>
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

