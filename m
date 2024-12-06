Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA722066DF
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480872; cv=none; b=pVxqDaFM0z3vcJZD1/mxyGgGqYNbciY5BMpzcpdeClKV9gLR4KCeJKHtFUM203qtcQnPSWX7TSS5oUzitdujgR1uM7yp/BS4kszFy0/Q6AawIXqugrRFOfjGgSc1IeNBVG3HHLiVcIcSlP+/FtlOdbV2C6u+9aAv/L5qCDM7+a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480872; c=relaxed/simple;
	bh=w83Z7qVtT1pAzIDieN9NholhiQ7RayQeaLFBlaFFRws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ldo0LkIiLAsaOY3jIc0Jg5FuS/dEramAe6QBlCJALQYSQTopb2Y/aGo/bxDYx9nnTElPxwxYMXy+HEOvmdcQly7yIRz3HzJQd15EH81mWVsU//64IBRnxE2F6drcnTZXBH/QWLqEQgSgzBBw6282JBL06BhOTC0j99OW+YPrJRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VweMkaYE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=izj8y+wU; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VweMkaYE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="izj8y+wU"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B995F254019D;
	Fri,  6 Dec 2024 05:27:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 06 Dec 2024 05:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733480869;
	 x=1733567269; bh=lzXQzs4rHh1xMhm6Dtqos7K6TNTL60M0CMeaylKhEzM=; b=
	VweMkaYELnB1ZtJ3UVWvxeSOXAGct0Dth0Wv9r8+clFV/wuTCAZwy2XnB68h7AOg
	u0AOw4b1oIfNtE+JUywImjFx+8Yap6pdQklYM5Q01ogrq8p/l8ha4femNtlc+dn3
	xvnGfhyh8+m3LipPHspgIXdDazxodJutchUu7m0dze0/Qhem/ok4nI7NsrPembbu
	+dXjlFyM4Yv7Cjldr3fJ1aYtsubrgnS/r6krAD++j8QTSwmKPYDJErZXrVqfw1G/
	iTg5gOlSZnqXOwvtoev9iyWLknNjx+pWYJ9NMu7Bf0epa6JWLEQzz4njJJLUitL8
	zvdHn4oFwHX/N9O7xQgr9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733480869; x=
	1733567269; bh=lzXQzs4rHh1xMhm6Dtqos7K6TNTL60M0CMeaylKhEzM=; b=i
	zj8y+wUMRYDcspGBGHkxCSsMfuAN5YdL/mi2YtCT4E35qIDuBSbq/pQTbd9nQV8d
	7HjOqK37RdwN3l/651XjU88alYBUPFZ1aOuUDFLhKR/0ltTrtinz71GsHG9D9cxG
	aGpRxSQn21hCGJzLBvDyGQIQ5pyAbEfZjZgXjMXY42Bpeuoh6Rtyxo6glT4JKeUp
	1icoBKUG/svQl/ga1XP7kYm5BAd0/7/2bIltVzRTY34zmEYwQ1lNCVn3JWm2cZw1
	Kyyl4YYL033+uqJGzk625MKtSEYyFtocWzVVUmeqqq3yKJEHS/4CNBXvRlAdcLWH
	uwaA1KGF2pXR05llncX7Q==
X-ME-Sender: <xms:pdFSZ2NXeKmVO4SzjHCXlztT7Cny6mhY_RKD5jzUyKgwL_EzkO3sbA>
    <xme:pdFSZ09D-vccuIbL5Vmy1FWYygtkkCiMDfKgJQDZm37IBQxuV4ona7IYUpdWshxZf
    NckcdLcxmrlLudmkw>
X-ME-Received: <xmr:pdFSZ9T6O_RniTViUnzkG5LDSDcOpqpwWvqvRfm_lWl7Q15BjITzCDfVUG6RGldhwZD0kxJ26hxb0Ax5WRxJ65Wd8J-hKiTvWxKf1spCqGvrog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhi
    rghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:pdFSZ2uwNznb8G4sdL-ao0uFxBSqV2CMFn-JHURcRduWJ_SY4W7d0g>
    <xmx:pdFSZ-cDHg7NXaDf9Keb6B2XaMBCyUfq4inZVXchGngCIwvhrLcKqA>
    <xmx:pdFSZ63PI2Ztbeifq5WOZGEBi_laQvuaPiT8pR81Jj6f1e43K4D9zg>
    <xmx:pdFSZy9s7pWStBeDl5lfhpwdiqqSuvnpCfGOOnEAN6BMkYcgxxmtpQ>
    <xmx:pdFSZ96xqZFYyfKpCiQ_bfPmAeskHREjo1eU91KtaPS8kqBXqv2Ez-Ye>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 05:27:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 355963f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 10:26:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 11:27:29 +0100
Subject: [PATCH v4 14/16] builtin/patch-id: fix type of `get_one_patchid()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-sign-compare-v4-14-0344c6dfb219@pks.im>
References: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
In-Reply-To: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

In `get_one_patchid()` we assign either the result of `strlen()` or
`remove_space()` to `len`. But while the former correctly returns a
`size_t`, the latter returns an `int` to indicate the length of the
stripped string even though it cannot ever return a negative value. This
causes a warning with "-Wsign-conversion".

In fact, even `get_one_patchid()` itself is also using an integer as
return value even though it always returns the length of the patch, and
this bubbles up to other callers.

Adapt the function and its helpers to use `size_t` for string lengths
consistently.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/patch-id.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 56585757477911c96bbb9ef2cf3710691b8e744e..f540d8daa736b027649c8c64ffe5100cf4044037 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "config.h"
@@ -10,13 +9,13 @@
 #include "parse-options.h"
 #include "setup.h"
 
-static void flush_current_id(int patchlen, struct object_id *id, struct object_id *result)
+static void flush_current_id(size_t patchlen, struct object_id *id, struct object_id *result)
 {
 	if (patchlen)
 		printf("%s %s\n", oid_to_hex(result), oid_to_hex(id));
 }
 
-static int remove_space(char *line)
+static size_t remove_space(char *line)
 {
 	char *src = line;
 	char *dst = line;
@@ -63,10 +62,11 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
 	return 1;
 }
 
-static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
-			   struct strbuf *line_buf, int stable, int verbatim)
+static size_t get_one_patchid(struct object_id *next_oid, struct object_id *result,
+			      struct strbuf *line_buf, int stable, int verbatim)
 {
-	int patchlen = 0, found_next = 0;
+	size_t patchlen = 0;
+	int found_next = 0;
 	int before = -1, after = -1;
 	int diff_is_binary = 0;
 	char pre_oid_str[GIT_MAX_HEXSZ + 1], post_oid_str[GIT_MAX_HEXSZ + 1];
@@ -78,7 +78,7 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 	while (strbuf_getwholeline(line_buf, stdin, '\n') != EOF) {
 		char *line = line_buf->buf;
 		const char *p = line;
-		int len;
+		size_t len;
 
 		/* Possibly skip over the prefix added by "log" or "format-patch" */
 		if (!skip_prefix(line, "commit ", &p) &&
@@ -179,7 +179,7 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 static void generate_id_list(int stable, int verbatim)
 {
 	struct object_id oid, n, result;
-	int patchlen;
+	size_t patchlen;
 	struct strbuf line_buf = STRBUF_INIT;
 
 	oidclr(&oid, the_repository->hash_algo);

-- 
2.47.0.366.g5daf58cba8.dirty

