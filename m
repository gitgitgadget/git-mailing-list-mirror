Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEEA3E1222
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170546; cv=none; b=nXiOpBzQAwuHVew9qbrSN1ipCT7XXNCSkpIf+thjfa04hJtfN4BYmQIN5EPdTJ2nxxMgzUeTVqJ7/dPCxkCy3ZHOGoxcKwoq9EMTaBdjai8y+LJpryxZmB2qf/F9WKqipVfRBLW3uPCf5k816PGP99OJVOjaEAD7sKSTLOQgCk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170546; c=relaxed/simple;
	bh=NGV1UzC1FRIL8UqPTYJg/lp4kysRX3IKOt6X8n8rM9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I8fiyr8a/7iryOPntLOFAcynEv2QHSc6FDoefmCn4oDPjKWb86mcnuk29UiDIxv/aouJdxwZpP+JYCbOJecwGCSCSJOKUnAn+fLg7pL3a57QfjrJBrx7t3iebtF1yeYZVc1NAMzNRVqVA1f7ViJxqYFHXVGBxPxmH6C2NVZwDOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B9WGf4Yr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=em1uZOlN; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B9WGf4Yr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="em1uZOlN"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id A50791D00110;
	Mon, 31 Aug 2026 06:02:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 31 Aug 2026 06:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788170541;
	 x=1788256941; bh=oAPVENv4534ANznjjXY2UorGL2wjBuQR+E2TEMEh2ko=; b=
	B9WGf4YrjO7kaO/dFENZoRHS3pjihY4ovAINSMaQmJs43e7xEePRD421IRjCuGDH
	RHZpVEnh+ov0o5IhgnFvxMXBXPW/Cj7aN1jiiJc1LxdtcR3NYUUd0BRL3AcvApdw
	ZcCQG4MKCS7DXv32lzA1ZFWp97cNRR8zxD4H81ABP/cngrbChLk1VSpstyJjfOpX
	2F71TiTd6jxEG0IOg9fvNqWzy34FZpR+/G9st5WmMjWmOl/kBgkDWbFE3/N1+ipx
	HulWbkWTws39PMaJFVLILKt8hVeKqxWekAkt+gVQmPGG/xjgzAQAHBfd6vF/z1X8
	Ete78iSlQ0+rOTMmpUd2iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788170541; x=
	1788256941; bh=oAPVENv4534ANznjjXY2UorGL2wjBuQR+E2TEMEh2ko=; b=e
	m1uZOlNoCl275WjQ0blhdcInvZSN4ec/pIJQ2SrIFZE3VTqwDvvO9GvnaCqcWV5P
	8X1wIQXAQIxHF1kBEnEcFtbkRyiLh6k87sZuzA62kzYIVMhLz3Lo27En9a5Oe0N9
	OUIcqBsbrUgBhLCxzZjjV9gQsEdpoJdYFyQgDL2UwxBHDAPPeSOG9AYf7pfl2UGG
	7BlxH+awoV3hFzxG1QTa5J2+RetKeyfQTcudjmwWdlgAcL82qJMOPEb1BPk+2eFY
	lNJhTYuITtErOpmMCD6IX8qCUD1o0MN89C5uO5NCVgIQ9dA64Zz2UdlUs90dT5DD
	qhgtEbw88HMnncdOXi0Fg==
X-ME-Sender: <xms:LVGVavn6-qC5GfGmFD1tkwXxzSvMhLo1fLgffl0WovzxZ5ndWAo9OQ>
    <xme:LVGVaqSJtgW_7RzUQ9Bbn025Z8TymBiiBSkCJThePLY-X61nZlW-bwFjnEXchK1eA
    XFALWaGDNstksWs9yPnYkVX3x069yfFUv-3yky0wAprbkKmVIOEJA>
X-ME-Received: <xmr:LVGVajD7D76FUjQix7CsQppetijErHKpWeQlMzYI_DnlvVZ1mlVbvFVYb5h3C4QOtifZEQ>
X-ME-Proxy-Cause: dmFkZTErjFQUZgcOFnXFUOlNvgWJt2/tXbpjmcGQA/n2nwsULrOtSsSFRfRcudL7SI5qdZ
    2T3ffWQa2koWHMXgx41UF0savGPB3EI1ZeuDVVSn5u6I9aFqFldQH9yjk7Erq3PzsrEFGd
    pVAU+CNFmr5cr78jraWor1SQDGabY0OO5OCYYW6wBrFNmV6KHls6XZVMd/w7xZpueFG/yz
    xA211+jnlRALajI10VNVReO89MBolSPC3l7JjYeax73Ge0rUMwEIealSaxISccciTsKfXK
    xcA0KoRE87022Fe9f8tkPW6pZaDkEHJ4pqFR7V+aG1c41fxD9QltQErPpXuD4rnZS+VZKR
    OG1+kbNjEijqcU7kAXDs6Qwy4bjvFxwb7M/95DUpjhMYrt6JWFgENPH9tttvmcB1JJYhXq
    z0RGU+So5MoUBc3XMBOwiGKyOtA8/Ayn8OPNk2Q9EqxYbc+0ckk1Yto9VXYwrmxeOSV2Oe
    V5DsJqe7KEtXrtMWqFd9nCs9rLHsYpnsrlkoW8y6HjfO38ue+xEVvDClWoPd7qn6Ue6ulN
    YCazygYg2/NEjfZimwTD0nX2GT76vGGoYa58/S75CM4JcI+mNDAFYbCb5BuR/zy+XqQNKK
    C697azwq2q/XJ1SOQQx/WwKQWuA3MVQASxxjv7JunLamktV/VCBP9AdphloQ
X-ME-Proxy: <xmx:LVGVahSXhWGF1_sHRHT-CMywG975dEjHPSsyajeB0rceGJBbxqn8ZQ>
    <xmx:LVGVahrHbpR5Mc38Za5izguZW4I0k7y1z4vfuyitKcMcEMzvoXRFvA>
    <xmx:LVGVajyjldz_IDr1zH6Zez0SE04a1mYVjCHQjxQn76cQZmYIVWboqA>
    <xmx:LVGVamJygU2o6afSr4JSzvzwtvWBxxXf5dCkmHOBgbxZwS4E5Ve5sA>
    <xmx:LVGVaj4A-_95EMOGVi_pfRt6Zz-zwnp785DLQITkzotw1xA3BC1HKVin>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 06:02:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4fb33fe5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 10:02:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Aug 2026 12:02:06 +0200
Subject: [PATCH v2 2/8] builtin/clone: move around `setup_reference()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-pks-odb-write-alternates-at-creation-time-v2-2-aecd2382ba1c@pks.im>
References: <20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im>
In-Reply-To: <20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

In a subsequent commit, `setup_reference()` will start to call
`copy_alternates()`. Prepare for this by moving the function further
down so that we can avoid adding a declaration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 0a67492ebd..8c990ce0cc 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -179,16 +179,6 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
 	return 0;
 }
 
-static void setup_reference(void)
-{
-	int required = 1;
-	for_each_string_list(&option_required_reference,
-			     add_one_reference, &required);
-	required = 0;
-	for_each_string_list(&option_optional_reference,
-			     add_one_reference, &required);
-}
-
 static void copy_alternates(struct strbuf *src, const char *src_repo)
 {
 	/*
@@ -228,6 +218,16 @@ static void copy_alternates(struct strbuf *src, const char *src_repo)
 	fclose(in);
 }
 
+static void setup_reference(void)
+{
+	int required = 1;
+	for_each_string_list(&option_required_reference,
+			     add_one_reference, &required);
+	required = 0;
+	for_each_string_list(&option_optional_reference,
+			     add_one_reference, &required);
+}
+
 static void mkdir_if_missing(const char *pathname, mode_t mode)
 {
 	struct stat st;

-- 
2.55.0.979.g7e5102b832.dirty

