Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2377B20D503
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 12:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141108; cv=none; b=BWFVeuYWXx9vq+jQSiZ5QOfzaHY2ogSj6fpwIiiVCnjX+5+SIcK9PXadb5rrIorY/gbmh4Rum+S1qBPU5oUTLxAU/F7wLEbqEQblUeL2TEL+RYSo5zAdfTj3/e5AnpxZfGcu+Gf74KmCwCMh8/jyN+i1sBBOmNX5pBW+A1JhSqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141108; c=relaxed/simple;
	bh=OrIjeXuF9w1rHOW5ZBOKjcpZv9boHrkcBksyNW6vs6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jdd3ikZ+XxMf7hBN80EhAnYWMMWVznyja6EVX+nB6bEJFsrpdtkE8h+VnPKui42l1jjn/caMMkNVk5qvNCN+9vxAoebRhu8nCN9n8Q17Z1QnGgdVP3rleNVkiL9dMCAf1gY0UWsSWu9tzc8MoqcXpm4wJnLAEA2n4VNjwpAhaWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=xpIUwv25; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xDcvwsCw; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xpIUwv25";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xDcvwsCw"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 48109254017C;
	Mon,  2 Dec 2024 07:05:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 02 Dec 2024 07:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733141106;
	 x=1733227506; bh=1RpNUTixPgdVutE0Y8H/jYG71yZfDcWpSTddOqURV3Q=; b=
	xpIUwv25NnDWFu0mEe0aXgUeqGTg5rZ71zkKrVkWe8aObav5FoEOUVhL/sABF3d8
	37vwEbCKJK4nTFyusOl83RO2t5pi+MYj2WcyWKYMQvbptQn2ncLaKCzep/8f74V3
	0hR0F8aGg/EPgIXokQsfexFqFN0ndls5CNzCFAoi1UJVTgj1rnt4ADkdaSj02oVh
	X3L6FtVN673eCbjlzCpdPwCVrzqLWoHuP6Dl4kU8QLqxJLhd+7n9CwCrwYb6QhwH
	qXSxRhI5/Gxhwk4USeT7KF6WUP1gh5t1I54folapdPgJfH1jx72A0d0LQ4cdqJtq
	NghYhRal8P0EKoKzTh720Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733141106; x=
	1733227506; bh=1RpNUTixPgdVutE0Y8H/jYG71yZfDcWpSTddOqURV3Q=; b=x
	DcvwsCwWf/2xFD8NYcj4ycZbYqBjgnFwDztSHxO/fguxLWt8jKn8UHDoEnUI0tW3
	EdouhlKKfqSpZoWcQV6vnVPqefS0j9keEcULL5iB3QCHFm1jdYklYFGUW6+H2UQf
	i5toyB2VEuUQEZnRLiGMZ01a6NsWh0m1ohl3Cxv0TPwubERb86fk2l6/PnOTx7iY
	bNwL7dQwFJehvBacLfQj2JBWo4mQfSxmb6CrjFZ7oUz6ABxlgcg/Z6vXaawavDkf
	2ytLgH6kVm9vmpJs1AzP2ezvywOrQajmDyEyjUKaH83Uc6GjMv7f8QJTj/wdgkWx
	IMspZKcCPouVh1X4+1eJg==
X-ME-Sender: <xms:caJNZ75OF5eQp_gfX8aEQ1_WVGNkqwbRCXpbU08NVuPKS7sUZL4Kew>
    <xme:caJNZw5XyejqbpyZQPYMTIxWZmm1UfBKCiEnRfgCJ-LaQua8K4_SAp3bA_A8yBqLN
    ZXoIVQEIvaNL6Fm5Q>
X-ME-Received: <xmr:caJNZyf9OF6fagcW57-N3ke5V5cLc961ybxldKNnHMCgkarMKCoonrYAHraE1jLVcvKepLlZzDicNlIKd1jKPnztdcFo2HhYqD79q4g1EcqRs9m_SA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheelgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhi
    rghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:caJNZ8I_jMguzkL3aPkzPKub25al5NVF_v-Td1Xsp8G9zerzNGhK6g>
    <xmx:caJNZ_I1G6Q9x0hXuv5ibkNmzclhIFrEgsdMjXnhNGHlsASTznkiyA>
    <xmx:caJNZ1wADGoQK8pNADIlq6NYU6xHo39fJ93-Zp8Z8Ca-GA1yxWzE4w>
    <xmx:caJNZ7Jg3H7S38zLbw8xy3rKFOiGXMZHzyMN33Adq0DSCVjpNHTqRw>
    <xmx:cqJNZ32VuTZfNdGlJI45AJ9rspDfUc6amiYHZs1WKYBZcf0VrdiDOTsS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 07:05:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 67232229 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Dec 2024 12:03:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Dec 2024 13:04:41 +0100
Subject: [PATCH v2 09/14] daemon: fix type of `max_connections`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-pks-sign-compare-v2-9-e7f0ad92a749@pks.im>
References: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
In-Reply-To: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

The `max_connections` type tracks how many children git-daemon(1) would
spawn at the same time. This value can be controlled via a command line
switch: if given a positive value we'll set that up as the limit. But
when given either zero or a negative value we don't enforce any limit at
all.

But even when being passed a negative value we won't actually store it,
but normalize it to 0. Still, the variable used to store the config is
using a signed integer, which causes warnings when comparing the number
of accepted connections (`max_connections`) with the number of current
connections being handled (`live_children`).

Adapt the type of `max_connections` such that the types of both
variables match.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 daemon.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/daemon.c b/daemon.c
index bf313bc21a0b82a12064c534af78c9ad51be78e6..5ca70335fc4b94b6f3cadeac309316b70dd9377f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
@@ -801,8 +800,7 @@ static int addrcmp(const struct sockaddr_storage *s1,
 	return 0;
 }
 
-static int max_connections = 32;
-
+static unsigned int max_connections = 32;
 static unsigned int live_children;
 
 static struct child {
@@ -1315,10 +1313,11 @@ int cmd_main(int argc, const char **argv)
 			continue;
 		}
 		if (skip_prefix(arg, "--max-connections=", &v)) {
-			if (strtol_i(v, 10, &max_connections))
+			int parsed_value;
+			if (strtol_i(v, 10, &parsed_value))
 				die(_("invalid max-connections '%s', expecting an integer"), v);
-			if (max_connections < 0)
-				max_connections = 0;  /* unlimited */
+			/* A negative value indicates unlimited children. */
+			max_connections = parsed_value < 0 ? 0 : parsed_value;
 			continue;
 		}
 		if (!strcmp(arg, "--strict-paths")) {

-- 
2.47.0.366.g5daf58cba8.dirty

