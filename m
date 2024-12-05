Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E031D90AD
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391421; cv=none; b=kz6pKSmiTh/DqY+dystBxl8Sh5+dYkywEqSg/GBBulKzyu+VejPvKo0QeHkWoWeRwIZGECsaw/10mqmHkigl9VX6eBRw1vzC4ugwdAQTIReKO6fy5GYmnvSBUpODosrr2ZYpI4N+y1iGcVlAgQqYmNx3yfpoXWjFoYxgL9IPglQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391421; c=relaxed/simple;
	bh=w83Z7qVtT1pAzIDieN9NholhiQ7RayQeaLFBlaFFRws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZXUChqpX72/rcwH2bqsWWlhy8ANVjkgtvv8KrlO6WJsBWN1YUE0fczBn0l+KMVNDDZiANuuMSBXuQaa2xbE1pBx5xXtajZOS8yUmEd18kk3HY710K/qmYqen/BBaEaRHnSQzgmbE7rdKtTAFLpTJpSRlaI2Re8lqNgGoWvkfe/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PMgXuPdr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WMzAwGsm; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PMgXuPdr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WMzAwGsm"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 1B9591380B88;
	Thu,  5 Dec 2024 04:36:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 05 Dec 2024 04:36:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733391419;
	 x=1733477819; bh=lzXQzs4rHh1xMhm6Dtqos7K6TNTL60M0CMeaylKhEzM=; b=
	PMgXuPdrMIiKBnMQU4xv6zfJLseH8v4M6zK8zoTnCjQvXzvNUGXQyI4Kj76foXuh
	/dQ8VGvPxuVz9ft6UNlRX0EXB3cPbtVKbcqg3q+m5rJr/ECj87Kt1V7R0IkiP6UF
	EXMXlL3PdO0pZ1rsode8idun2oPGNEg+l5RcP65E7AVh9rQf4rjIyp4uAXDabX0r
	Lq4rkcdlG6FT8UYvgPHbkMq1/dc9vKmlmbZeZ7y8t5rQETMMICRgjOCNrhQmj6ou
	CDwfG6nTBjh2TcWjVkUBxBrEWudqWBe9HdIqBjAg9Pc8tJKaadzocH3aBe5TAbHg
	GUtDejA4c5+hB+sVJV3tAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733391419; x=
	1733477819; bh=lzXQzs4rHh1xMhm6Dtqos7K6TNTL60M0CMeaylKhEzM=; b=W
	MzAwGsmk+gpEABK6p7OjLMK3BiHec09Kc8fXysAvjq7+YED5I1sIa+hygw1JFgyA
	dNf4Z4WY+rVNKX0RtIaq5m9TMfBxfVv1l606o11t/Tjs6WZKV26KHJLJS2l4qs/s
	zqikX2zGUnCQwImoUJOD5sx2HIp4CAc612Ljd19WPrrH1UcPPNw+Sm3VHIqpopNm
	pNnJ4HFdNkbGmCJTuxQcmN/FaSSXSv/NVghJh7gkgkyYD18Cg7df5TDfjrd1memF
	iQKV63sKMJ4cnPjHg8MrWT91q3ATK2d6cz6tLGF1dj6L+bjo1ni5kAJ+Rkjps/Eo
	IgrKgWgPr0JXX/ToQmryA==
X-ME-Sender: <xms:OnRRZ6ChAJKpIbwtmZPbGPOyAPrqq3Tb28wVKJBAOdsZJ__gVrsBEA>
    <xme:OnRRZ0it8MJuyqGCInknMGcRW3nIO54sK-bS3l53mh8AIR44QhKlC-pDw79jtQCXS
    g-8ys5XVwpQIDAwuQ>
X-ME-Received: <xmr:OnRRZ9nP6GErqHF6KRg4gNSU89F5dwaG9B26if9jYTbFGsGGfimtbUQ8fbOE5nFdN1pBGVHine5wIIPmzAzV1CTcI31V-fSyQN4bv_rNkGJuVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:OnRRZ4zhzOmZokPVW3EOxXbWO2aapoiKtNLdi3pWrLs-xkI4nYCtAA>
    <xmx:O3RRZ_SUMzAy1M2MMyIhL5c3ZBUDLmwTWex_15-KMZGZKxZ9E46TPg>
    <xmx:O3RRZzZAoEcXRWgIVCh274cBy0eM59JTq_Z8t-lIBJdwGETZdOOd5A>
    <xmx:O3RRZ4RsUfF90B0Ilw4xWHIL2RLOsY1dgXvp5lnJxNU-kaIcuwEGlA>
    <xmx:O3RRZ9OH6q19KX0z6EgrdW3Wxjyx6nuvBEhaI_vojaW1xLvDwAwotyAd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 04:36:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 495c7d36 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Dec 2024 09:35:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Dec 2024 10:36:35 +0100
Subject: [PATCH v3 13/15] builtin/patch-id: fix type of `get_one_patchid()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-pks-sign-compare-v3-13-e211ee089717@pks.im>
References: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
In-Reply-To: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
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

