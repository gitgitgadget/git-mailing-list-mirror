Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5681D7995
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391421; cv=none; b=k0hknQh2OjNzcxFbQVPekL7RcAzYAAVtWzEfwkgJ73LwB4CYRrthvYQYx9QPYDCS5TgjyULyo7qRSOd8N1Ezcoomb4JtjnolHrvKKbl/LHM5ydgAPZZXGVojx7elK3qkbBjj5p0caAfUBLvP3YgEoVcG4XqhWwcjc4do5dw2fs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391421; c=relaxed/simple;
	bh=OrIjeXuF9w1rHOW5ZBOKjcpZv9boHrkcBksyNW6vs6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZzhGJ5/toSaDsVR1nY13wzWbHTOWAVuz9KS+oPmCGdCripezjPS4i+o0j7wGiJAg20vjan62GvbDrpY1jeH0Ic6zUfvJY/qyMdAJqvxXCcM7xcgoZepkzGvuTBSh6nTheUEkuTv0KNGXU9qY1FXUibE1q0xboxitUsQwww1gl64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=foae+0Fr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QlpeHD+C; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="foae+0Fr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QlpeHD+C"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 65AE811401D9;
	Thu,  5 Dec 2024 04:36:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 05 Dec 2024 04:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733391417;
	 x=1733477817; bh=1RpNUTixPgdVutE0Y8H/jYG71yZfDcWpSTddOqURV3Q=; b=
	foae+0FrDJxa1Yh5unjdq/ojt2jqfWDLmIheP2czKpjzIwkk0MTOro3CYkm7z4nm
	s/nJF5fBktKxAuN/7BjEv7VLiVBXfgQmmuUyfyD4dn36XoTpwUnI4Z6W3lYcbAXj
	BPQ5OCjEJSpwqwN1syF7fEoxZJtd6hDd6FC32Y5Ce8nr8w0yyjEYHM1DrnWcUDzI
	CBE7rfDdYqAuupyOuytdSVIcfkLh9KVs6df5zkJ17zjnZH3b5QM8O3mL2Jt64qkS
	XNrmF6hVH5LdfNy8icrQWGolsNR4245mQ4pbICNlaBKV+GxipGqrSq8Iin7jTXyV
	7uw3lQ21w2B9aZc3TUntyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733391417; x=
	1733477817; bh=1RpNUTixPgdVutE0Y8H/jYG71yZfDcWpSTddOqURV3Q=; b=Q
	lpeHD+CkH9sQk/5AtVMkOZoerkRT5ujf84B573tHDt0ddpegcn3KaGvhhm33PZQJ
	U1F1pPkruGM3IdpVz6MSV8y9LGOBeDcZs4dP6KnLhTmixc3GBunu5HhynAEPU0KU
	fpcrVx2YQkfkQS8tvPOzSFiSJW6FDV5FR9yBv9e/At2Og/eNVv0TjFev/l3Q5Gde
	92sq1hdceqis+0QLmZXp6aGMd/Rfp9T/7IjzCRQedWE1CDHrBk8sD7IS59pyXzNs
	W8k4pHOclHCkZFngw5MnIDFYR2XgNFJkXAFYALsFXsrvfmZ6VoBeKIUNqTJXz0tA
	7rCwTSk++Cxt6PxQTMmMw==
X-ME-Sender: <xms:OXRRZ_eme3P0Wky2dTUNGVa4XHSnQ0LIdTeVW88ztEkrOOBEPJHXnQ>
    <xme:OXRRZ1MdUqkhYpvtsVjspTZ4_vsTJFWY_dVqwe9YZxIZ7Xm4BKyLMFJIYxGkiixrK
    09pUbPZrtQ6B8BTfQ>
X-ME-Received: <xmr:OXRRZ4hmM9hSSzsosmp42TVrL7IV9WF3wiW3LZn45fhh4_du30csgVLE5tVkUfCqXC-EVpTjKWEgFJskBIsZv1xUC6Xq_i67DgrH3YME9JjX2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhi
    rghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OXRRZw9ERPZX2KheGB0c2x2PdDUs4eDDncQcRWJTdzqUhJ1w0qSLlA>
    <xmx:OXRRZ7s4TiwBEZ1Qa8OLYYGzTLVAlWEgstWQHCHanI5SVl4tWYbxnQ>
    <xmx:OXRRZ_HFkBt29_8Ub1uDOIseRpeueb1JKBqoZBAX1Towxi3IaH_BJw>
    <xmx:OXRRZyNfRLm7DEl5O_S23qV2DNRsKXLlL3KogYyxuiGJBIwFZ5ZgXA>
    <xmx:OXRRZ1KP5yqSjxm5WVsQ8XS9P2zjM569q_sKlQ7jbTSiTv1NjGNIyz7W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 04:36:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a7c78d9c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Dec 2024 09:35:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Dec 2024 10:36:32 +0100
Subject: [PATCH v3 10/15] daemon: fix type of `max_connections`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-pks-sign-compare-v3-10-e211ee089717@pks.im>
References: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
In-Reply-To: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
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

