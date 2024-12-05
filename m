Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7A71D63D7
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391418; cv=none; b=Izeh38k6rXkqEbXN7gSmumTsrpUuL+zTrO6nd820jM69U2/t9NhFGfxxYy5Qxm9EvG/Y0FWO6A7rrdJYj7DFHzAZeFHFEpmLJ0JgtrapnrbjBG6VwDrbwFAn/nd9AftHNqMCsZPybTNvjBzNNQlLsegUv58dWkL07aXFHwsMoyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391418; c=relaxed/simple;
	bh=lF2Vlg7RcN237vn2RCn+0Wbw1WkhLmz1aP5gDU2zCFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VsAFZnjeiyZ08clWmyg9uE67e7dYnc2qXP6GIXqiKHE5yn4X/Kf1tG9xImltpw3jl1iUDYQS1whEJ351v9Xh40phh1j7GT/hpAIXMVF+Y4ZU1yJIbUL0Tlf75nECLCZK/aZyp7PSOXkB5PW6Rw7y9oY6xu4+0n+1lhtaAZPf288=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oqOW8ggp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D1xVnbyZ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oqOW8ggp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D1xVnbyZ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4979011401DD;
	Thu,  5 Dec 2024 04:36:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 05 Dec 2024 04:36:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733391415;
	 x=1733477815; bh=PgF7cDQGRG37xgnzm8b+2/0HGErJ+D9vmAIADRe6qVg=; b=
	oqOW8ggpqVY97Q1nHEafHI1yNMerlcYTYEK2wBebn6m3vH5848cNfORPBoOfpTlA
	Kz1EFmApMtyeAUWYiTvgwf6WFb4PSysgE2jTLrnTnwWG3uBu2w872xiX3t31Hjbt
	+z14KWL60no6jA2oM2q4/YY0WngL4lFVnm4gNQEIKDddVsBpg0SxjBPNelOoR7Rd
	7/U1IOdWG/ZU7vbP5e36t/Lrr67Gs+0YZJVWAFe2mB48HKM412zZEJ7rBgury0I+
	RHNjEf3mhS4QKonwDrDcYCQZwuB32VAXhljtWiR0VdwUm5VS7WJleisAqMRR1gEJ
	vcN+1NIzJIlAoFA+ercvwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733391415; x=
	1733477815; bh=PgF7cDQGRG37xgnzm8b+2/0HGErJ+D9vmAIADRe6qVg=; b=D
	1xVnbyZV0P8LiVIL4wcO7OekEUZqETFoP0AACyvhB15KwhLTFP53w5I3PWFfkTY6
	Ra9AUosQu+J/982LeG3thIO799umvHAGjgg8wg/meXLV+eLhVgasnP780TlGxAqN
	Y3/PtIUysbCjYHcZqgd7oIivPppEGkBXcOL//2M2R9noo/rITbXO75x+DZ8QTzfY
	x19ELnQ67j09riMo0+0D4oBNS9+JaKO/FHD+r8dd8eKCikQ7wFERZd+TxOItxe80
	N+fK6QnsbiQ5n78ibP0gF+GsAwlHi82pd1z6ri+WcpLLwBbIFe3P+eJWxjfyg5pR
	2FpnZ97z43wKxM5It3ctg==
X-ME-Sender: <xms:N3RRZ5s4nImQckX-PXZWU7xB72-uVQrYpZopazELyzjSg2jY0jOxOA>
    <xme:N3RRZyd4OdMNebudaw_1DdDXLsrhXr_HVPQ4piRWYQM2xyOX_vHn9dWxYlXo7QhuX
    xh7yHVFUUH3tcAjTg>
X-ME-Received: <xmr:N3RRZ8yKvx41y7xR1dAcEX7mbv19dxVRdBE5R7PRDTW5E_jC1OKDo1oYOKltZasRUJacknQvWXg5EJxugIVhyecohvqfUtIKhSOzaJeIqabiMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhh
    vghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:N3RRZwPNNE8wO2-7g47oSc8WoBz2LHpX1Vp6GxjpcbkOHoGXhg9FQg>
    <xmx:N3RRZ5_As_4sbbaQ5eKGIDqHesuCa2dBZbqc7x46e4IR6ulIoxaUGA>
    <xmx:N3RRZwV6Eudqx6jvWd-rtXl_dUH56gzx2p_uBc8mHeW-maeBMBFdIw>
    <xmx:N3RRZ6cDuEFBj_TXoDFcCDuSgnmf0OgE60V78scHWJ7MvKvfAI1x7Q>
    <xmx:N3RRZ1bAEVijF2vTBXYxuiiQ4gnc8rFCGWjUAopwgs1U8sOyXAs08agW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 04:36:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 57aa150f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Dec 2024 09:35:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Dec 2024 10:36:29 +0100
Subject: [PATCH v3 07/15] sign-compare: 32-bit support
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-pks-sign-compare-v3-7-e211ee089717@pks.im>
References: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
In-Reply-To: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

From: Junio C Hamano <gitster@pobox.com>

On 32-bit platforms, ssize_t may be "int" while size_t may be
"unsigned int".  At times we compare the number of bytes we read
stored in a ssize_t variable with "unsigned int", but that is done
after we check that we did not get an error return (which is
negative---and that is the whole reason why we used ssize_t and not
size_t), so these comparisons are safe.

But compilers may not realize that.  Cast these to size_t to work
around the false positives.  On platforms with size_t/ssize_t wider
than a normal int, this won't be an issue.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 csum-file.c | 3 +--
 pkt-line.c  | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index c14bacc7f9e5f56fcdb06a3abc7ac9babc45041a..c8ec7b73e640c00b895c1b3ba92f052012a680e0 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -9,7 +9,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "progress.h"
@@ -24,7 +23,7 @@ static void verify_buffer_or_die(struct hashfile *f,
 
 	if (ret < 0)
 		die_errno("%s: sha1 file read error", f->name);
-	if (ret != count)
+	if ((size_t)ret != (size_t)count)
 		die("%s: sha1 file truncated", f->name);
 	if (memcmp(buf, f->check_buffer, count))
 		die("sha1 file '%s' validation error", f->name);
diff --git a/pkt-line.c b/pkt-line.c
index 90ea2b6974b1d0957cfdc5e2f9a2c30720723f12..f48b558ad23dd99f334d2d60e954ce9a83ac6114 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -363,7 +363,7 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 	}
 
 	/* And complain if we didn't get enough bytes to satisfy the read. */
-	if (ret != size) {
+	if ((size_t)ret != (size_t)size) {
 		if (options & PACKET_READ_GENTLE_ON_EOF)
 			return -1;
 

-- 
2.47.0.366.g5daf58cba8.dirty

