Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921662036F2
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 10:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480869; cv=none; b=qbeggMfxr+LFvYxVnzgkXnLNXAI4K2eKVhZuVOzClwmK5lufZaeREP55L/BHnHoQmZylEY5vYH1VzkianfLn2myVaIYjfskRyYKJ8AgON3jShj+mwivA1j5ncBxK7ejeJtblYCJok5faUFvyeJUMCeVPO8prsrxO2R11S2gmGVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480869; c=relaxed/simple;
	bh=N/kGI35uw2wReGQtRhDTg/oIyFx9rb9hd63XvAwvqEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jJwmOwT2XPZs/vB0Gld20cZUyk/+w9dQmwBLbNv4bYnWiC6EGPmnSK1gnAzOnCX0oEJQPTVoo72RBOmpoM2MH95j2mVoRFV7Kt7hurrBoC7Qt2Fcl6j17k0bSa9k4bSVFTlu6RVb1sa1OL+p8fh4M3hdaoXzvkNNOL55zoswsMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uqJHuHoy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BRqd5fh2; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uqJHuHoy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BRqd5fh2"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8BB7525401A4;
	Fri,  6 Dec 2024 05:27:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 06 Dec 2024 05:27:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733480866;
	 x=1733567266; bh=Ossup2nZ6UWY2WKN4PsWIuN24Ki+kOfYdJwR1luyMmo=; b=
	uqJHuHoyluktx4AyJDhl8Z4b82YxBaSOdeZq+DEbzgOyLwkcLNyztHEO2TqwZoVs
	HFeDC3EHAK9vHEDgfKCbgzWIGWW57XqRjPyG+7domIF530vN3J7PCYA0195ADW33
	CEdlU6oJKINRrknbRB9GL2Uiksg57IzI7XRBU4dK92ug1HJfWrhMnzO6EU9j7rOH
	eMV/UTJwrlsoJUlODUba/mGZA995b8zJZd9l9UMS3i4g+farFZoYSdJHR+8oZtlZ
	hUUp8lIdOF1xZybphsgnLs9exEm8KvNY4nS6b8CpSsjDLYjbk7j/Ede8V/LP7VeT
	Dq+cJXukxCWMtFIHGIvroQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733480866; x=
	1733567266; bh=Ossup2nZ6UWY2WKN4PsWIuN24Ki+kOfYdJwR1luyMmo=; b=B
	Rqd5fh2mBr+2GfkXkgr1nUMM7bPFgmsHmrXvnv4O0zloJfyvVZMDAqygLAWdReAg
	Jdmd07xgij/Ma3avQAlbBJ9idhwyVa1eNTjGhnT/mJjkTjEQNmaRHkNZ1kI49HbW
	GdRltRRVaxZOZUdtjQTF0eOZSA0tfWthfSY/G/WR9uYi1OgTRG571ldshfTcXE+5
	od19H8YLbKhlO36QSlE62FheFsHfx4omxj9TlRxrq7TAnp2JNADuS9NefdOXWY+w
	eO9uKDwGGtT7Cx2wm+lL8TtFNJq+7f77uOMhyViik6anjqodGn1kXob3+dm+U7o6
	aRRfz31QlEnVlqcuHbFHw==
X-ME-Sender: <xms:otFSZ2WHVe15jhPXw4DlL1mKjr6ZIJvCAkbred01Xpsd6FyTlT6Izw>
    <xme:otFSZymAIZQut-xPa6eorBCybK23Ge69KGjuJ2Iwid80sZxDnhRH5gm59XSUPZJIX
    lGEt4fkzQAuhe49Ug>
X-ME-Received: <xmr:otFSZ6a_lNbngscNYeTz-QWLCz7U9KSh7VrHIb-y1XXZUQaDK_s67fO3amU_s6H8ePbVJYmnvCEuuqiXrBq7sR_-QtoOHvic8iNnvLu5oWXZtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:otFSZ9UpcOfDLzWOMAPzzgh5cWHKSXlltazOFt6yi0OnFFDST1Qw2w>
    <xmx:otFSZwny9tKqqi4hEKCLGbNHWbcZKaKJFVYGu6nW3A2C2bbTUVhMeA>
    <xmx:otFSZyfAyx-CrCm1MBA_vd9lNCMWyFzyPB8DMGTQkQBwoVHtsRBzHg>
    <xmx:otFSZyFs9QA1wnZfcblHRp7gPvwaDPiGPzA7AopaBhT_JWUx_NKEGQ>
    <xmx:otFSZxD-gQK_mYprcNUA-Ci8C0hDuG99CpSx92a9YcXArrDVSG7blnv3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 05:27:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bd7e8cdc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 10:26:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 11:27:27 +0100
Subject: [PATCH v4 12/16] gpg-interface: address -Wsign-comparison warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-sign-compare-v4-12-0344c6dfb219@pks.im>
References: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
In-Reply-To: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
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

