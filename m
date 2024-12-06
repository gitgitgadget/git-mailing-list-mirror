Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E61202F86
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480868; cv=none; b=aYHyKlVvu6mcQaeNrDmblcGTdEFKAL4ZxuQfDeOAVT4A0tlvzgf7rjtbQLciQVlK4bWPFcqX6htSLPZyljkT+pIsBcWYUQGgAQqUDJdeuj6uW8Gxay7+6YCpKDam1UCw66Nft0gZ15sYE2y2gxVQJH3Czwj/UzALGmIWyFDWE90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480868; c=relaxed/simple;
	bh=OrIjeXuF9w1rHOW5ZBOKjcpZv9boHrkcBksyNW6vs6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=knOATgbQIMAe98nVTwRxvWmt5GXWzPa/JdZ5FwkKnIDv6DmXxxQB7Q2BAKqEqv1Hgp6+nirpkiOEYyQgv5dBr6Gaw/AtKALTPcPVh7OYOWPkcXv3HpgxaC0sJqYqlBnDR/tdP209V6Hjc1gsMV5lwwibfZnz2j7wRc1+bmGbl60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ojx/Shnd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qr04ZBBl; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ojx/Shnd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qr04ZBBl"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 8CAF5114017B;
	Fri,  6 Dec 2024 05:27:45 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 06 Dec 2024 05:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733480865;
	 x=1733567265; bh=1RpNUTixPgdVutE0Y8H/jYG71yZfDcWpSTddOqURV3Q=; b=
	ojx/ShndBenWVSAPkCsL194nTjyfZxIsgX8amepjcjBZzMgnYv2bIIuwOTMkfxex
	X0lsFyWYxFylqbZ/j9f2nilsTy5s4nAY5+o0RPgBovD9gWRFVYoxQVO8cMBXtB9T
	K1ijQ8KLFu0z4qUIWdmlkXryDwBbkcQOTcRxgVKF5ctu0Tqa9OtzeoKXflvNPRyh
	1XQkEwhGSvqq1Vn/xpRRQtgbLg0Mn+EWTHS/4LRQcXQlgcj6wSFXOyJWTVxNxoLS
	qn5L/lq6DxpoYPy16zGaEyLMjNBtiL8Y41S8bYB10U544c//KwEmylJoIp0Rg+r5
	UsST+Xn+977IzOnnS/o3Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733480865; x=
	1733567265; bh=1RpNUTixPgdVutE0Y8H/jYG71yZfDcWpSTddOqURV3Q=; b=q
	r04ZBBlKqC2nQWC2bGv6Wp1/5Moo2Vgpji8l2N1rXg5EMDYC8fRET90oYzRb0Jjb
	QMPqu8JwdTgPff4xHNpLZon6Bln4iuE1RLdQ7H5UBoB48dZfHwaoU1rZptA88ngI
	iDlcNOGRiliaAyF+5EHTvlGzwXDsR2D7T1sQV3nthvyuii7rebXLFEcCukFd1GMa
	Ewsc/WQn9Ve+8hGgq7vRQJ2xztLakZvWsSCnQ7MeWnAH5oulBCSAs6ZqvVoYLGug
	8WIQNV27v/3qKPphAWOsIWXNerd7WHgTvjsh682tDBzLLnh6LfYC5kHDzvPrjb1E
	313wXkvhoVNPmBQtqcVZA==
X-ME-Sender: <xms:odFSZ8Wr6g_3hQ8kzwcFwfT-IQKdVjhqQ0bRUsdqc6ahwpnUEkOOHw>
    <xme:odFSZwk90BRzyuMjx7eBS6Fhe_9YO0FoT6CGAFqax0VVJK-UVMnjGfG7Si9pI7RsL
    pgfbTOc_D3cgS4B6Q>
X-ME-Received: <xmr:odFSZwZrLP3BzA7dMH8RURACrKo99W-8g2UD8Z8epKnR6lFLrdmws2Sa22GOJZyXsQoFSAbAcotp2fs3Q8c6Ce9bxQmpsoR219pnajhwC2P0OA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhh
    vghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:odFSZ7VhfNYdVC2AGpCwY6k8H7MIcm6NUG8mIrChzF23B58hE0IMHw>
    <xmx:odFSZ2n83VfuGion_W9d48xG_othJY78einp_YhIUDzhCGhaY0WcTw>
    <xmx:odFSZwdr_Rlw5Qbr9NmpQUV1-t5k0x_8t_iC9UdRmiwGj6SJgkdg4A>
    <xmx:odFSZ4FtIO5iKrUwqf_N5bISarXJkS0OTj0vhaLprQjliul5V1OR6A>
    <xmx:odFSZ3DLxx1jxP2Fn_M-i_hqXYSjsyuU46CBy4nSm2gNFtGLHWfI1N3r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 05:27:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f365c310 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 10:26:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 11:27:26 +0100
Subject: [PATCH v4 11/16] daemon: fix type of `max_connections`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-sign-compare-v4-11-0344c6dfb219@pks.im>
References: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
In-Reply-To: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
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

