Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8C02ECEAC
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 06:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891180; cv=none; b=umb37KF+7JpjKz1WjRAoo+qF38BeLrrDkr7MwS+Wgn4d6Z6vkapzRzm5BQaVzkQmV8sbUdfH7eAEYG3L9HA+eTCaKCQmTZog/hkdiwi7zD8fhgxaaG7RqDPBxa8MtosQj0XxxfgC9psz8S4Vbjkhx522hejrLShM5aiOnLkGOgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891180; c=relaxed/simple;
	bh=OSTxvVqeytRp3+l5EWeTOd/lJPI+JxAxg8C7iRsTErI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uk3eE8GaiJ8s5FIF+mY+H48gqBwC/T6PP+jbOBTaDJt8503CmOWv+SJ4k97T0RywLT0p0iHdhMErnq7GsMKO1DHDBRfaw37atNGI5jNXA6a735KCTWpfHXZTledqc6TlgQK+CkVD8ymzAtyRrc6C76gGZypxdOmjGUHZqojSSkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T7duCfLP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=noBILrZQ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T7duCfLP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="noBILrZQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 4FCCCEC0084;
	Fri, 31 Oct 2025 02:12:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 31 Oct 2025 02:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761891178;
	 x=1761977578; bh=kzEYWsaqXybZc1zc+P8mMLj9ooEkubE4f+sy5qw0v1E=; b=
	T7duCfLPzgejaOp+MluN/WysOu0/Cxf8sKfCwsxRGoqQ8U5z3NcNlaafmURlDUnh
	gqNoeFRwww1hER+WgQErY6KfEOopQyJgJ3BAgkJr0IL3AZh9Eb7swxCMdcdaMMRG
	ixz05jil2YfDKkH3FueoGkoKUY+LJcnrpRCsDYW4Fr8a94oQpn4KTv0P3H7nsZa1
	Z17gQrcFLYyu1ZUTY9uSBuJFtkKzWfloYVHS9HtfC8ZWV4B12TtHUy7IKJ+JAs8r
	aiLi2NcQk9cFLB57Awoyu5ruC581htq+KaPDbRsdn+KTbkZPkNwTTL1N0VMG6yUy
	u9Q+uWu8xjYV0cc47Dt6fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761891178; x=
	1761977578; bh=kzEYWsaqXybZc1zc+P8mMLj9ooEkubE4f+sy5qw0v1E=; b=n
	oBILrZQK+uF0Xcy7bBOEvK0B8A1rRsvt+LAr5YPEr4bCWVW8vAJNuscUmh2jhRqH
	4hRlYDkttA+82ZAUBQmEymBgGjxnL5nyEred6MjXRRgqbr7U13mvmxHXhcw6MRPH
	/bf2Fb5a9m0LLYX5k6wnnPS8nCNJX1XyefRWoOMWA54FU2Fgthb/n4vfLwdcpPIV
	xGpFrCTr/Jfd2MeZfGA3lM1nnOqw1hxOpe0Adly/K91Axk2edoaWtcQnpLYF1Azu
	Mjyl3lL4sXLzy08e88YLGCigpeR9WhM4UAkV/i2XfDDZAvRJJcRS04BWPIT+gM7g
	YjQH58lgME8JjRKTb7Xyw==
X-ME-Sender: <xms:alMEaVQmT7oyGFbhfYiRq9hvG-rZx_NyDkBxHQmRPgT7QfJcuvFuww>
    <xme:alMEaWPBZE--ObU37GPh6Q0qGPFDKk6Bm7p60ifbmMvhGc_dZ4bYbdG8D7Bdpq46s
    v2BdgRee1pBEK7pq3xzYZUNwxZXDJm6_EuLTf-ILaHkYCP156sq>
X-ME-Received: <xmr:alMEaYNRZ6nV0CbW73v2huMCGlp2CvoOWrSVwrFgfYXRNeiO-Hi69Ob1WieZxq_9dbu0nFifqzd0vX8BqZWCb_aXovLCoBPyhxZCAFAh0r82rA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:alMEaWvqx5vQKmIPkFNQaMv9L5bLVt5XEGyswgYLv6ZIhuO_uAKgxg>
    <xmx:alMEaSVtwD-0dJPAK9786wZFnWuQn6WTaCNJDRnmoo6g34X2xEtN4w>
    <xmx:alMEaes3q8XKq1iFuLb5_uruJDTEl3FfFqfZHAEcyu3bas2cPXInPg>
    <xmx:alMEaeX6msID2tTMuaZKuBBYC8JyRcAFIlQfjCvotIHiUp9m8WNzsw>
    <xmx:alMEaWPlSQHVjhyB9AXzvwPWDPg_MFluyRvWKzwwZyOGI3bPfsKitj0E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 02:12:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9b04b8b0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 31 Oct 2025 06:12:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 31 Oct 2025 07:12:40 +0100
Subject: [PATCH v2 04/13] object-file: move `fetch_if_missing`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-b4-pks-odb-loose-backend-v2-4-920f721aef71@pks.im>
References: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
In-Reply-To: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The `fetch_if_missing` global variable is declared in "object-file.h"
but defined in "odb.c". The variable relates to the whole object
database instead of only loose objects, so move the declaration into
"odb.h" accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.h | 8 --------
 odb.h         | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/object-file.h b/object-file.h
index 3fd48dcafbf..097e9764be1 100644
--- a/object-file.h
+++ b/object-file.h
@@ -7,14 +7,6 @@
 
 struct index_state;
 
-/*
- * Set this to 0 to prevent odb_read_object_info_extended() from fetching missing
- * blobs. This has a difference only if extensions.partialClone is set.
- *
- * Its default value is 1.
- */
-extern int fetch_if_missing;
-
 enum {
 	INDEX_WRITE_OBJECT = (1 << 0),
 	INDEX_FORMAT_CHECK = (1 << 1),
diff --git a/odb.h b/odb.h
index 2bec895d135..2346ffeca85 100644
--- a/odb.h
+++ b/odb.h
@@ -14,6 +14,14 @@ struct strbuf;
 struct repository;
 struct multi_pack_index;
 
+/*
+ * Set this to 0 to prevent odb_read_object_info_extended() from fetching missing
+ * blobs. This has a difference only if extensions.partialClone is set.
+ *
+ * Its default value is 1.
+ */
+extern int fetch_if_missing;
+
 /*
  * Compute the exact path an alternate is at and returns it. In case of
  * error NULL is returned and the human readable error is added to `err`

-- 
2.51.2.1041.gc1ab5b90ca.dirty

