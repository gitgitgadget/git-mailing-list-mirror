Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C7A48124B
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550051; cv=none; b=aPmi2r8dBm/EsIlQxxR9w5HkeJMvt7Q7q9UseS4cAFAsES52VEeKWaPmIkBb3bbgJKuuDkhjjPSHkC3F2d633rQl0ZBwPEPBKSkNUwMQzfiL8/sNVl78Dl2rmsAIUYNhDWHkZOo9XeHm8To5Lt4zb6+Z/Yyxv/eQqp10+FfV6fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550051; c=relaxed/simple;
	bh=f1Q42rKPw9dFC9Ah1ZTMlRPIt1lag2FlQXFnHaHXAh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p1dyAIKfu9xR3kzstihpDHNf6Z1yfdFUC4OxkYizWe44TUQ2i8gXGepBzh9a6FMOD9F6Q3jcSxRCdCNaf7t19nnC913cgiD7YGt6YVlaauQPjMd0r66vCPm4aAeO0h1wuEnJMLPe/KHPRgra/YhyLHlrs/k5nGZeAM75bJ9r9Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JiZsN6i9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hcE0qIXK; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JiZsN6i9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hcE0qIXK"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8A78814001D1;
	Tue,  3 Mar 2026 10:00:49 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 03 Mar 2026 10:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772550049;
	 x=1772636449; bh=qs7WV5J6FQOLZxJu1vK+Il/xwL9VWWXAx9nkC+KllQ8=; b=
	JiZsN6i9EdWpuIHRb7j1gE7txUldhSARuMtAj++4MSfGYmyZnhgsYzVO1C134eWR
	BEuUmVF+VqWJBHBNcPVQALeIaW6b0Gkq9vIGrMsgQj8tP0KLPQXFLL/PUxGdztHw
	GQFlOfT+KvtGaPmssPlAajeinaDnMBh4rT8KC1VkEBMyH+goisb4hq+Ibx/Dn0jR
	HC1wx+SmYfr7xcbbPXPBY2c81Yj4wQ9QJ1T6uocjvlv8Y4BuAgfm9FM0e/FfUjnj
	gTHUNT2AnGcwgx3zKaWpW/suqQdI6ngPG9xDFjgWdCgKnYwVgjDLj02XipwdQIZs
	uFtKlp6fMkBjFolOvZBOww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772550049; x=
	1772636449; bh=qs7WV5J6FQOLZxJu1vK+Il/xwL9VWWXAx9nkC+KllQ8=; b=h
	cE0qIXKphmElNTgQqrtjENJGAV9sXJfEUrSZ1D0erT0N984uAFj+qlKMrTXu9KeC
	15qWaDWpCGoCzk8DNkpdcuZH3dbgomX4WrQGpU1+E7rPvlL3DLA+TRLxMYKupANB
	Tq/ytWY3TyLWRAk/KTXLJZ9QLNdzW6fWSQwxSkZP7i+DNCDVe8YLOY2LP/x7zi46
	BR7P7ovtQ49R3lCckcxN32W33fuYFxJ8o3VcC3Izbu31kxRuW/ZWCXIv9l7rSuDJ
	K1verOwu0vWJjlXY+99ld2hQM0jykgiPozL0rVviUWf17+1h2J7MVKawXqrHQT5Z
	fdOvNviLh2bmo6YcYd9fA==
X-ME-Sender: <xms:ofemaaFJQpS6wUCB0t4THmIxTQGsdez496E6NaB8GLVqS1mAOIfMUA>
    <xme:ofemaSXA-o81dBAga6Ip5bJq6X31gXoU_6K-fpAiA_nbQALxYDx8wXtsfVYcPN9lv
    k3bNrDO1kY2QWmGBPNuFp_Ssz6jbbgCDfhUZMaR30cr98Kz5UeGzw>
X-ME-Received: <xmr:ofemaZIbazw5zy4c6bhfrGFKEuenT_ETGEpIbIPSVc5V8Y71gNLaCEOY2pN4wTmJpn1Yi0fP-lzdy8uxSt6OXtVHyQL9xwVqAWxq3sQMW2Va>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtph
    htthhopehmshhmihhlvgihsehgihhtlhgrsgdrtghomhdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ofemaS_3F9TLFft9c9OfB3X5k_q9AzkcbWfGslsJRBGiqHRKIco13A>
    <xmx:ofemacKu3SR8Zr8kFcHkmYDuRofHYXvRPsID_gWBWfiAaDELZ0-JjA>
    <xmx:ofemaXkC1II313-Zs7WGeQs2IEt3k2VTnZRoKBLhc1YDcJlsDx0GPw>
    <xmx:ofemaQPX9OtMpusCU-sykRvuuLf0D8_rpfjgND6Kliv8GZxJ9q5PuA>
    <xmx:ofemaZi7aDmgdIRTlH_LcL2gdbDIOM_I8V_XKIcKoIqLawJpwtBPL_ec>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 10:00:48 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0e22992b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Mar 2026 15:00:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 03 Mar 2026 16:00:22 +0100
Subject: [PATCH v2 07/10] sideband: use writev(3p) to send pktlines
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-pks-upload-pack-write-contention-v2-7-7321830f08fe@pks.im>
References: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
In-Reply-To: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

Every pktline that we send out via `send_sideband()` currently requires
two syscalls: one to write the pktline's length, and one to send its
data. This typically isn't all that much of a problem, but under extreme
load the syscalls may cause contention in the kernel.

Refactor the code to instead use the newly introduced writev(3p) infra
so that we can send out the data with a single syscall. This reduces the
number of syscalls from around 133,000 calls to write(3p) to around
67,000 calls to writev(3p).

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sideband.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sideband.c b/sideband.c
index ea7c25211e..1ed6614eaf 100644
--- a/sideband.c
+++ b/sideband.c
@@ -264,6 +264,7 @@ void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_ma
 	const char *p = data;
 
 	while (sz) {
+		struct iovec iov[2];
 		unsigned n;
 		char hdr[5];
 
@@ -273,12 +274,19 @@ void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_ma
 		if (0 <= band) {
 			xsnprintf(hdr, sizeof(hdr), "%04x", n + 5);
 			hdr[4] = band;
-			write_or_die(fd, hdr, 5);
+			iov[0].iov_base = hdr;
+			iov[0].iov_len = 5;
 		} else {
 			xsnprintf(hdr, sizeof(hdr), "%04x", n + 4);
-			write_or_die(fd, hdr, 4);
+			iov[0].iov_base = hdr;
+			iov[0].iov_len = 4;
 		}
-		write_or_die(fd, p, n);
+
+		iov[1].iov_base = (void *) p;
+		iov[1].iov_len = n;
+
+		writev_or_die(fd, iov, ARRAY_SIZE(iov));
+
 		p += n;
 		sz -= n;
 	}

-- 
2.53.0.697.g625c4fb2da.dirty

