Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0EA20DD5D
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141112; cv=none; b=uw2WALPdcj3Mb3vwfrysmivbU+fJk5IhuO/ndGMl8S+s6IBHMO4WQG9mkVvWMj/B7+FUt7W+Gbu8KYz3k8WQTuEmHiyqaMJpqh24LEX/goqhFQZjVPLQDPyO4VY9hEnp9IqG3BNkBh/hYiQfaMiQ0UsreMGNBvQGj/HZZ2/TWZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141112; c=relaxed/simple;
	bh=N/kGI35uw2wReGQtRhDTg/oIyFx9rb9hd63XvAwvqEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M4aWndI2/GYbR5bM7GFwSfcJU7Rd+9USdF4sDv82Jdbu78oZKTf7cT2iGC8FGRD7XYZiVe2fhCvBhbbZ6VU6Qy4sZrQWkiMW0KJfemQ/6XmZjTPjWAHrEc4DJvf3XEnDm30+RAFdzdvtah5/Dm5Qm4XPBvMWy7xbhF+OIiZItIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JCdNng8S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2frFsYvz; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JCdNng8S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2frFsYvz"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 52F08114017D;
	Mon,  2 Dec 2024 07:05:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 02 Dec 2024 07:05:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733141110;
	 x=1733227510; bh=Ossup2nZ6UWY2WKN4PsWIuN24Ki+kOfYdJwR1luyMmo=; b=
	JCdNng8SF4aygP7BrTKUqDkL6P5BzoORH4jkGdtPhssJa7iw4fU0oGqXpCT7RQ+B
	eOlMuxXMg2Mdt/gvo9yXfgXyBYfkBnZ+uLpw3Sk6l1NKiL4mzBYYAHOfMnN5M9w0
	dgX9LqLsPqYz07gmsMuCSV6lfAmnS7TzLVPXoo6f1uVLHfzKmroUZXNGCmWTYJN9
	KGEm/Rr2lpsI0Kd2MMMbq0K5zZLP/8AHQuQfJAxPSdpA7wFflhed0yYQcmQovo2K
	DDMAytWm4IT7JFvW+9LfU7gnsoSLkPpjF6R3g9f2VezbHQFb0q8VgNJlatv9nn9m
	S0ssQBeiy6kaNUu/Nv7ntQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733141110; x=
	1733227510; bh=Ossup2nZ6UWY2WKN4PsWIuN24Ki+kOfYdJwR1luyMmo=; b=2
	frFsYvz6a4SR6cInOQ8clTjtD4p9c07XO8kTHhoONoIhRyiof4uxw3cOA2Ujn+9I
	PgheTcLB/NDHN0kj4qi4eweA1yRP7NlYSvsASdROt+RVmdGwbiTK2Q80CQ8IqFvn
	pZwZC2MZaFl63iAOkCyKLqNgOq8WKsoBLq3n5tuA2/FDxxotxdEwWIi5+DC5IK8B
	gaA458RnKxe3rrtLATWmWdUwHsdDOyoJcWTPqbrHzvTFOtnB2v5ifltKzLoPO1UV
	p/MkJjckDOApm5MisufBJZI1sHjN+/z1231eG2QUILhwYfl4rZGioGcrV7bGihBs
	vo6EkT4WNG3K9MtJdn9pA==
X-ME-Sender: <xms:cqJNZzMr7DJSj8TOP5aCMb_OxFDBAbayvCFrVMBmLmd7mUCOrxq4UA>
    <xme:cqJNZ99SWDL4voA8NCM1FobruiFRSSUauPghjoTxhJxj1Ina41I8sXQg90NtADxUX
    IYScKVC0pKTYmTyUQ>
X-ME-Received: <xmr:cqJNZyT7A4nVdveZHLwoVnDDzOdiVFIq5ySbX2T0qt8PuvFakDeFhDXpSZXqpmQ80dQ3wZYxQImvqfxDtvZUss7MRfS3ffLS_YkDmoPKRoVOZ-00tQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheelgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:cqJNZ3uyZ-yImTSN_mgmNNrGd-qi0zd0FIdhsfyTnU0LJHp267te1g>
    <xmx:cqJNZ7dEKUKK9vMT8hzE3SsUuoyj7m-AS7LR-CDSQZxONeaXzX5_cQ>
    <xmx:cqJNZz1I6cow3WZScCd6lRcBvq0c6jWsr9nSiTjUkJQExFTm1nzBZA>
    <xmx:cqJNZ38hFO0fRcjSdWvTjbGiTubro_MXdltPM5HhVS0tusKumteKjA>
    <xmx:dqJNZ36YaUX2u_R0KWc5V2F91xCbE32bkkSxMQk1yrxYpd14KOWfo3bW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 07:05:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1ef26f82 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Dec 2024 12:03:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Dec 2024 13:04:42 +0100
Subject: [PATCH v2 10/14] gpg-interface: address -Wsign-comparison warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-pks-sign-compare-v2-10-e7f0ad92a749@pks.im>
References: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
In-Reply-To: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

There are a couple of -Wsign-comparison warnings in "gpg-interface.c".
Most of them are trivial and simply using signed integers to loop
towards an upper unsigned bound.

But in `parse_signed_buffer()` we have one case where the different
signedness of the two values of a ternary expression results in a
warning. Given that:

  - `size` will always be bigger than `len` due to the loop condition.

  - `eol` will always be after `buf + len` because it is found via
    memchr(3p) starting from `buf + len`.

We know that both values will always be natural integers.

Squelch the warning by casting the left-hand side to `size_t`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 gpg-interface.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index a67d80475bf9d8452de0c3ae9bb08ceeb4c11c4b..0896458de5a9889bf5951d9703c37a67e20d3e1a 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "commit.h"
@@ -128,9 +127,7 @@ static struct gpg_format *use_format = &gpg_format[0];
 
 static struct gpg_format *get_format_by_name(const char *str)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(gpg_format); i++)
+	for (size_t i = 0; i < ARRAY_SIZE(gpg_format); i++)
 		if (!strcmp(gpg_format[i].name, str))
 			return gpg_format + i;
 	return NULL;
@@ -138,9 +135,9 @@ static struct gpg_format *get_format_by_name(const char *str)
 
 static struct gpg_format *get_format_by_sig(const char *sig)
 {
-	int i, j;
+	int j;
 
-	for (i = 0; i < ARRAY_SIZE(gpg_format); i++)
+	for (size_t i = 0; i < ARRAY_SIZE(gpg_format); i++)
 		for (j = 0; gpg_format[i].sigs[j]; j++)
 			if (starts_with(sig, gpg_format[i].sigs[j]))
 				return gpg_format + i;
@@ -228,7 +225,7 @@ static void parse_gpg_output(struct signature_check *sigc)
 {
 	const char *buf = sigc->gpg_status;
 	const char *line, *next;
-	int i, j;
+	int j;
 	int seen_exclusive_status = 0;
 
 	/* Iterate over all lines */
@@ -243,7 +240,7 @@ static void parse_gpg_output(struct signature_check *sigc)
 			continue;
 
 		/* Iterate over all search strings */
-		for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
+		for (size_t i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
 			if (skip_prefix(line, sigcheck_gpg_status[i].check, &line)) {
 				/*
 				 * GOODSIG, BADSIG etc. can occur only once for
@@ -700,7 +697,7 @@ size_t parse_signed_buffer(const char *buf, size_t size)
 			match = len;
 
 		eol = memchr(buf + len, '\n', size - len);
-		len += eol ? eol - (buf + len) + 1 : size - len;
+		len += eol ? (size_t) (eol - (buf + len) + 1) : size - len;
 	}
 	return match;
 }

-- 
2.47.0.366.g5daf58cba8.dirty

