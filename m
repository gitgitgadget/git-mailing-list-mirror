Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3B620D51C
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141110; cv=none; b=d2qgCBsyQ51mm5mwLDtnrx4QMc3l9qpGGTAth7kEksF3fVkYYXcCsp9H2yO22gkiVbtOJZRrDr1hlxhnktPiqgr7zUXZccCeC7NQlwnPYM4sWgjZRspegkoJyZUFlPRczkwuI70tXueSqzQZgSnh+dya6z4sqGWbDbdITIBy1mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141110; c=relaxed/simple;
	bh=N9ZDHKsX08/EpCZ30VTOWoWYnJa8wqCIeeXF2aRkqfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dO+af9WMT97I7dRxLWMYG9lvKkSCMPERYfFpCnPP4llxNXmI+KoZpJqaoUHVH+EXUEEy1PuOcTmm9B+SCVoC6GPracFLberleODmyE6ohngzcsbZmu60AgTfRElIyk1F1xkaT5/jjxyMA3WfPeXx0lCF+Ga0c/buBBsHqKSIRtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rJtDWxzk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qZ57NH/d; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rJtDWxzk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qZ57NH/d"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E6238254017D;
	Mon,  2 Dec 2024 07:05:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 02 Dec 2024 07:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733141107;
	 x=1733227507; bh=e/XwpSSLlv3USlh8mCfsS4Q91Pvr+ShsGNMNoXUthxE=; b=
	rJtDWxzkRnt4CAweiYkmQXDlv0QHFwQtDHtx4aQZDsY6VSXz6mVOuWpehlQV0n5r
	pZFX39oHhlQBadwAcfDMGbErkNLY5Z31Xb+VRXe1PYxBWnglN6Ttoms13fH1cuTx
	so7zLFrXigZqBXbTPEOhdaNUX+yZfiknyrkRm2dV8WiNwR1F4sIgxy8s0ELcbeIU
	3I/9oJXzTBtSINBpooadKCJwoGeQUDnFa5hjqhJ3QtrpPyowKyo97TdJpt92eGvx
	Jpwma4sg5FEV4g7U1jzTfx6WEhTq8bsW0N3HK0kAgwh3etbMrvczBrIgRqvin7Op
	BUUWd0AioVNhdF7ir81GOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733141107; x=
	1733227507; bh=e/XwpSSLlv3USlh8mCfsS4Q91Pvr+ShsGNMNoXUthxE=; b=q
	Z57NH/doHIEBuQyKRetq0NVnIGZjAwUYeVl6fB478huRZwG59yzX88ans2MTj7kq
	rf5xrmbtOcYpi4Rq8OTNNyJImUIi4zjMiQEoq+oIvVxbw/mRjV0zPpQtwlOHqTrm
	GDYds2/UgpDq3z29pnLXjeXg0fkA3kWYKjhuPn40Ju4EWboF50XFQPkuU7z6amKk
	8aUcPS3MDfz/k0fjEKPYxfXq2gDrozWMM7Jwpu/8BXnCbdIUMOELibU7ytNSe6Hs
	WfS8SCNb4I5E4p9bSJDBJsLYN5ZCpIoxg80anXZ/oHBNNjp2B3/Hht80NWO2Ic0M
	7z3ZZMCTbB59mIXEimdJQ==
X-ME-Sender: <xms:c6JNZ292DEQLcSO0lUGXNEYDkwiy05nFyTXIvSjZMKefN-vVBqEr2w>
    <xme:c6JNZ2tDAOQZsQRcH0TR4TGqvHEs4wdFj63s2crGVQ8OO2JnycfLBEexys5nGQiqs
    Ls5C1et0hLmVJ12Rg>
X-ME-Received: <xmr:c6JNZ8AuszjjwYf7lmL3K_7KAoxfYSPi0TCu-gd4eODQoEvDvLZqT00Gni96ahi4zWxiiP9BTwlHxBxYD_AOEq7zgwaMgmrv50YponYhN_jXaoYjWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheelgdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:c6JNZ-fTLv7e-Z2CXZk7NBTIdKGeyAYw2zdL9vTRzMvaTildkhU_5Q>
    <xmx:c6JNZ7OHiTOgNF-Bi79mD_lh-vNTWk7fBKIwaXV9kzA3nupaQQYatg>
    <xmx:c6JNZ4k1ZFX06y44-bzrmCRuwzWbbvWwxf9gRZdjw5z8pe34d_2MAQ>
    <xmx:c6JNZ9tyrf6JI9XzcVSjCopufI7JnSjJvLqtf96ZtjW38LpnGZT1Lw>
    <xmx:c6JNZ0pjoPjAUk9myuDhS-UIcNp09-EOq4iWrbHIiqL66YsfLRF4qA7k>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 07:05:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6e6bd241 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Dec 2024 12:03:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Dec 2024 13:04:44 +0100
Subject: [PATCH v2 12/14] builtin/patch-id: fix type of `get_one_patchid()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-pks-sign-compare-v2-12-e7f0ad92a749@pks.im>
References: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
In-Reply-To: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

In `get_one_patchid()` we assign either the result of `strlen()` or
`remove_space()` to `len`. But while the former correctly returns a
`size_t`, the latter returns an `int` to indicate the length of the
string even though it cannot ever return a negative value. This causes a
warning with "-Wsign-conversion".

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

