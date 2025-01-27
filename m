Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394371FFC66
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737983067; cv=none; b=qTVUKnax5CRtN0JCLBDaOb+2uXbzlTQ2DOIE/chpbVmyML/+3GBedYhPvVyGG7/4E1bIGY+MPoGgsnFWYX0ngXx1AgGYSaTz9MuZeZLw4r1w9E0otPxnIOiJgeK4W/3y9Fa8cpwVSJkfxD6csYiSWOHvC1EjY9z6bbls6433oAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737983067; c=relaxed/simple;
	bh=+1ZfmkbfY7oQbi3mh98Cov4Tt5PalQNH5hpbNUu+aZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bMor6DKN0MUWWtq7Ed4K4w28yKLpeovopEsE2DMhRybdjqEdYB2ebcsubG/nyoU4XjRnVXuk+fu69luFY+4tEusw4guRNfCf5oBIpl+fbNQtYsnDJWlLKMyt3dnYda51fdjbkUID8BNotE9F7ctLitQWxa9C063DOuV9BG4D0tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NneR5I8W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ChbCF877; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NneR5I8W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ChbCF877"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 429821380AF5;
	Mon, 27 Jan 2025 08:04:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 27 Jan 2025 08:04:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737983065;
	 x=1738069465; bh=wRD3Ek5awySUciyux3HbTKfEqgbwtD0r0n4BcJTAH80=; b=
	NneR5I8WcQp9dYMQDxprUBfngIrWwVsd7ZobRCMq08TL91ruuIn7xnYwDQf2lEHH
	+3kDBe9kodyXuVQPHQYyNyq0OwepRqWlkRc9sxLKhTBYwWPm8pQSNrJOMMp0wYp5
	XS8TWXP2yn8s13v5+SB61HeksSmF/uLFZfgwPhFZq6bFe0zQ0qOvy2FpOkjWUAQO
	ii0Pl0HjfAKiX+3idiSINs7KLwlAOVFIotkpaQC1RZujz8log0cpfNjTcdIV4VTh
	tTS3MQX0nrzgO4HyBL7ODVmdgXeGPAI8jx7BdraglDvaNhBUoRRp8mJ+HyHQqQnc
	HAYEXpPvtldPEFIBJ6oiPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737983065; x=
	1738069465; bh=wRD3Ek5awySUciyux3HbTKfEqgbwtD0r0n4BcJTAH80=; b=C
	hbCF877NNOmtHMCf9TcHUlH/FbsCRI99S8M1ePbviA3y4Xkagr8NB7C/FFUmBT5+
	Uqe7rk5dHIIpFPhHkGMEtoAXKDGdyNNmMSQFDy2k4ucIg/Rt2ijmdWdw76FUsF/f
	asz+Sna1g0U0ZYLyMn9/VnbgGKm0Nr/ybKhA4RkuF5tt8qXsYvwcdNZCtwE1myGA
	jdL6i0/Bi5uwhDZGc8EOhgx4hzsUUldi4ZwVSIdHwJyvIHO/S5X5PelrbvsfJnuT
	Gf6WH8TRotJ4ywBPDT+7KQ//TmwUZEkfheZfWinmTA50zHzqjMrL3RJ6/pGSPPQb
	Dv0Gf24WmjZHB7ibSMXQQ==
X-ME-Sender: <xms:WYSXZ2bwq3vY5JezsJJZ19dwY9OTWVjBk4JMBmc9B7OnlRGSVRwMrA>
    <xme:WYSXZ5YbL3wirjro1BPauO5ez8BK7EyEi_Ikljt5np_Quit_3CL_dNEM-OF8t-qb3
    Rx7kEjmtjEbT40RFw>
X-ME-Received: <xmr:WYSXZw_bf6z3eT9eXJsyzi284j7mhJeKoTDCf7kIM5iKnqdWXS19GdIlIjUp7W9AOgzKTmV5qb8WXpHV7Q4rFxTn-1ycq2PP3qng_1kuByb5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:WYSXZ4or94lZw9MuKYzM3jcnDtxeNHSbQULKycmkYd7stAS2H3a99A>
    <xmx:WYSXZxpK19ouNtYhaEc4XdVkgVzbxd8cXqxeK7wgPGrtJRsjTKLlzQ>
    <xmx:WYSXZ2SFHPeUG3XFreWXR-CcsVN7xCFKUo_kVCFsMU8rZM9912u4_w>
    <xmx:WYSXZxo1yvlLNnLp_waZJCPdFZU1U6VE_ZuQyCNqKTONCEqc6ouVuQ>
    <xmx:WYSXZ43AU4W7areVJr0jTgXR7wY6sqONNH5iUps4HySbKYdco2rPo6Y2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 08:04:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 336333fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 13:04:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Jan 2025 14:04:19 +0100
Subject: [PATCH 11/19] reftable/system: introduce `reftable_rand()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-pks-reftable-drop-git-compat-util-v1-11-6e280a564877@pks.im>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
In-Reply-To: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
X-Mailer: b4 0.14.2

Introduce a new system-level `reftable_rand()` function that generates a
single unsigned integer for us. The implementation of this function is
to be provided by the calling codebase, which allows us to more easily
hook into pre-seeded random number generators.

Adapt the two callsites where we generated random data.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c  | 4 ++--
 reftable/system.c | 5 +++++
 reftable/system.h | 6 ++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 5f155b344b..82bdf5169f 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -523,7 +523,7 @@ static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
 		close(fd);
 		fd = -1;
 
-		delay = delay + (delay * git_rand(CSPRNG_BYTES_INSECURE)) / UINT32_MAX + 1;
+		delay = delay + (delay * reftable_rand()) / UINT32_MAX + 1;
 		sleep_millisec(delay);
 	}
 
@@ -688,7 +688,7 @@ int reftable_stack_add(struct reftable_stack *st,
 static int format_name(struct reftable_buf *dest, uint64_t min, uint64_t max)
 {
 	char buf[100];
-	uint32_t rnd = git_rand(CSPRNG_BYTES_INSECURE);
+	uint32_t rnd = reftable_rand();
 	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64 "-%08x",
 		 min, max, rnd);
 	reftable_buf_reset(dest);
diff --git a/reftable/system.c b/reftable/system.c
index adf8e4d30b..e25ccc0da3 100644
--- a/reftable/system.c
+++ b/reftable/system.c
@@ -4,6 +4,11 @@
 #include "../lockfile.h"
 #include "../tempfile.h"
 
+uint32_t reftable_rand(void)
+{
+	return git_rand(CSPRNG_BYTES_INSECURE);
+}
+
 int tmpfile_from_pattern(struct reftable_tmpfile *out, const char *pattern)
 {
 	struct tempfile *tempfile;
diff --git a/reftable/system.h b/reftable/system.h
index 7d5f803eeb..3bd4a4e322 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -13,6 +13,12 @@ license that can be found in the LICENSE file or at
 
 #include "git-compat-util.h"
 
+/*
+ * Return a random 32 bit integer. This function is expected to return
+ * pre-seeded data.
+ */
+uint32_t reftable_rand(void);
+
 /*
  * An implementation-specific temporary file. By making this specific to the
  * implementation it becomes possible to tie temporary files into any kind of

-- 
2.48.1.362.g079036d154.dirty

