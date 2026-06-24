Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA3739099B
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 08:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289418; cv=none; b=Kywu2ua71P7pvqZFY8GCPg/ao20rp6F+Oz8qz62nRa7/2q0+xT8P6Lw688dJyUkHTZ0bKsA1FYshWE+Lp0MdImMvtom/Om5QPMRNVdhHJ/MxTZVKLivZDp2dIJasVkiK59PnC5SQ/KaJ4pcierlz82K2h/elaW4MkM/qyQ9htW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289418; c=relaxed/simple;
	bh=Kd+F6RPVAQua9yV7E9ubVZd6Uswi94iKipuWv5da3E4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a9p1XFCzq/dGCPcEFkfZG0SpDQ6d7Pygb7r2yk1dVyu6TzlCBI0uvB99H6Rr7GNbHDBhoGm7iLfBMC6PDOiA38ZrhJZPpMCWjQAbLTOiJ6v7UrUBv5/jtvSgyPv30g3KOlm6v3jJBnvRxQDUPkZDCKK9AApLwF3hWTv6ibH9bOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mZEb+2f9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cHq/mXme; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mZEb+2f9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cHq/mXme"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id ACE201D000D7;
	Wed, 24 Jun 2026 04:23:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 24 Jun 2026 04:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782289414;
	 x=1782375814; bh=hn/c45MjfXZzTL5EaCHK0mOErnMI7jc3rbNc38T+e48=; b=
	mZEb+2f9P+UfLQUs99jwtbtrnzxRTO62mdHWdidcTxsYRwaT9suKI84QmVVrXdfC
	P6EGQj7bSPWtORpN2QNehDggc20w87uf1lfbxu+xYbbudz3QVp7o857q7D1wi+dn
	P9GpkBWTTb09780LmGZ5S/LLJB+RfAyEQ/JkNf41U04vNsLKzjItsnxdf0YRFTVO
	7ZD5JlouickcZfXS5GZtRX9DSxFwfrsJJz3McqGPjRiNNXB5wZHVJutuA/FkBgCS
	LtaZT5TuTLP2l5eddhpZtZ4tNsQG+LN1aTepMJctPp2E2e9pXh1LePYc9Q0jMe9Y
	tCD5SZoJcBQ9bqd186qSSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782289414; x=
	1782375814; bh=hn/c45MjfXZzTL5EaCHK0mOErnMI7jc3rbNc38T+e48=; b=c
	Hq/mXmeG/6NnPW2SvhUKePZxkn4E/ecRbbV4zjXchzAJKMv0E8Or3ntf4m1wW1D3
	MGp3vOt1YHPhGP4Lh5qkUVk92/XzxWZKGL3W4OmIzBez2ShWlucUWqfHHosZCG4t
	rOmE7SoC4vWIEXCjJqt9a2TCOLO0JZXeh5BY6rozoBwiuXlMprSmRUsc0aKGR+Eh
	e+W1J/Y6f11Sg+yioWTaW7b8tZ/0HZ+VYHtEFnhEIUc9qrHVa+b8DzyOq0DXLIgX
	8s/m2PtGOWkBfhZm3kofmM5N+Lq1zmZicdVydwwbqHK5jtRJR5D2mmy8EWBp4Lyw
	ZCBOgVQiiNwb1z3s6ZEKg==
X-ME-Sender: <xms:BpQ7agfHGVhrBHxOl6r0dGxcTpn3TM1fQAjpz0_GSiBMSHmcCmZHBg>
    <xme:BpQ7aoOn0RDaoiEw8WlWEaBa4WISNICklCeicCynbbeyfs2C5DoO6SdCvMyM1gSKv
    w5N7QPcKj5905MRrzTNqUZL8-MiH3UeUJMx46FS8X8A32uRg6VqVQ>
X-ME-Received: <xmr:BpQ7avL60MApBvwgrM_kSjxYB329Dmjh5B2vp_-7-loStocq9vnDnxBiZe-v5mcgpzO1SdnDTcZvAQba43bjieM0ikL8aTqPnqhfGaRK>
X-ME-Proxy-Cause: dmFkZTGhdet2ItwvUgz4oa9q250EhFHQ9U9tz4O1dL/XkJ5ZyFJJUQRFo4JQGGhKAyPcTw
    gaBBFW6bmgaIg9Gk2pxYRKh4o03P7cXmavet6k4nNUfWpUB5maJcrY/0k3qBdWpOihdPPW
    VfpQakKkdUFOuVzqvKaxLNlsavE7w8EdKPcQLjjH5YGELDuEjIzSjXnjr5FtC2IYHPQgOV
    Pyxw0OseW3D0aOlB9vgDiwjkdWIDplMKgSGEmR79G1GeadT0fMn3SS474oZ59AvPHa5Usc
    glsBDsy91qgiZSuMvIIJLFZh79VH2GT2rRd+Sb6LxgcHl1kZui//HgFfhQc6RwVSpVAcQr
    PKyQoaQg2WcPSsRvsBxbgWv0QoEuR66KiJdxYjhCXnCSckTtaoTbqJCbNtXJDFAcIBILNe
    SVUsQnncIImNqS05Y7XE3oQf7M3qu2FszJCf5L7AXr9FqVenqrARKd3kw85GZp9SxVsc/a
    g8FyD05y1y/G9tITeWnSFEfWWrmAzal9Ao82hNDadlEKWruXpf4XgL7tO+8tNtvXgT1fQe
    HtIpCY3TGgiEyqt6z6rWIR4pK+JVwL7pQMwy+n9+WR3QILB1ea7X0aNYcmBlpd3Zts2t2r
    wNPi1Wcr4KAgb9rbnQF7MbKWIE3AfShBUOltCyuZhFq78offGZHSSPr7KimQ
X-ME-Proxy: <xmx:BpQ7ahGOYjVoYGAVgjKUK4tMOH2tumYcLqRY3xTSacfLpcrvt5hmJA>
    <xmx:BpQ7avRADOYC4Qg3u61Q1TZ-Zn2scZdVTEKHG73UZwuSQ_BOGdZWXw>
    <xmx:BpQ7alHLGgy8A-s6FrXwlEHl9K3P-I6GJYhMQi3YQ7pLo5ZNiUfjfA>
    <xmx:BpQ7aj8KVMKiluDD-S9C9fTsXZ8Ct3BECwUxBrj0KuOjdgax2A2sbg>
    <xmx:BpQ7aqu3-HMIq8yHDT6x5jAsJTsee5QO5r0KFcOdUlcWdQSRzOy9Yugr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 04:23:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9688bbdd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 08:23:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 24 Jun 2026 10:23:05 +0200
Subject: [PATCH 02/11] oss-fuzz: add fuzzer for parsing reftables
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-pks-reftable-hardening-v1-2-66e4ce87c6b9@pks.im>
References: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
In-Reply-To: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>
X-Mailer: b4 0.15.2

Add a new fuzzer that exercises our parsing of reftables. Fallout from
this fuzzer will be fixed over subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                            |  1 +
 ci/run-build-and-minimal-fuzzers.sh |  1 +
 oss-fuzz/.gitignore                 |  1 +
 oss-fuzz/fuzz-reftable.c            | 74 +++++++++++++++++++++++++++++++++++++
 oss-fuzz/meson.build                |  1 +
 5 files changed, 78 insertions(+)

diff --git a/Makefile b/Makefile
index 1cec251f43..89d3edd5ea 100644
--- a/Makefile
+++ b/Makefile
@@ -2599,6 +2599,7 @@ FUZZ_OBJS += oss-fuzz/fuzz-date.o
 FUZZ_OBJS += oss-fuzz/fuzz-pack-headers.o
 FUZZ_OBJS += oss-fuzz/fuzz-pack-idx.o
 FUZZ_OBJS += oss-fuzz/fuzz-parse-attr-line.o
+FUZZ_OBJS += oss-fuzz/fuzz-reftable.o
 FUZZ_OBJS += oss-fuzz/fuzz-url-decode-mem.o
 .PHONY: fuzz-objs
 fuzz-objs: $(FUZZ_OBJS)
diff --git a/ci/run-build-and-minimal-fuzzers.sh b/ci/run-build-and-minimal-fuzzers.sh
index e7b97952e7..37b24b092d 100755
--- a/ci/run-build-and-minimal-fuzzers.sh
+++ b/ci/run-build-and-minimal-fuzzers.sh
@@ -21,6 +21,7 @@ date
 pack-headers
 pack-idx
 parse-attr-line
+reftable
 url-decode-mem
 "
 
diff --git a/oss-fuzz/.gitignore b/oss-fuzz/.gitignore
index f2d74de457..dc7a127a62 100644
--- a/oss-fuzz/.gitignore
+++ b/oss-fuzz/.gitignore
@@ -5,4 +5,5 @@ fuzz-date
 fuzz-pack-headers
 fuzz-pack-idx
 fuzz-parse-attr-line
+fuzz-reftable
 fuzz-url-decode-mem
diff --git a/oss-fuzz/fuzz-reftable.c b/oss-fuzz/fuzz-reftable.c
new file mode 100644
index 0000000000..c46eac2c6b
--- /dev/null
+++ b/oss-fuzz/fuzz-reftable.c
@@ -0,0 +1,74 @@
+#include "git-compat-util.h"
+#include "reftable/basics.h"
+#include "reftable/blocksource.h"
+#include "reftable/reftable-blocksource.h"
+#include "reftable/reftable-error.h"
+#include "reftable/reftable-iterator.h"
+#include "reftable/reftable-record.h"
+#include "reftable/reftable-table.h"
+#include "reftable/reftable-writer.h"
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
+{
+	struct reftable_block_source source = { 0 };
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+	struct reftable_table *table = NULL;
+	int err;
+
+	if (reftable_buf_add(&buf, (const char *)data, size) < 0)
+		goto out;
+	block_source_from_buf(&source, &buf);
+
+	err = reftable_table_new(&table, &source, "fuzz-input");
+	if (err < 0)
+		goto out;
+
+	/*
+	 * Exercise the ref, log and raw block iterators so that we cover as
+	 * much of the parsing code as possible.
+	 */
+	{
+		struct reftable_ref_record ref = { 0 };
+		struct reftable_iterator it = { 0 };
+
+		reftable_table_init_ref_iterator(table, &it);
+		if (!reftable_iterator_seek_ref(&it, ""))
+			while (!reftable_iterator_next_ref(&it, &ref))
+				;
+
+		reftable_ref_record_release(&ref);
+		reftable_iterator_destroy(&it);
+	}
+
+	{
+		struct reftable_log_record log = { 0 };
+		struct reftable_iterator it = { 0 };
+
+		reftable_table_init_log_iterator(table, &it);
+		if (!reftable_iterator_seek_log(&it, ""))
+			while (!reftable_iterator_next_log(&it, &log))
+				;
+
+		reftable_log_record_release(&log);
+		reftable_iterator_destroy(&it);
+	}
+
+	{
+		struct reftable_table_iterator it = { 0 };
+		const struct reftable_block *block;
+
+		if (!reftable_table_iterator_init(&it, table))
+			while (!reftable_table_iterator_next(&it, &block))
+				;
+
+		reftable_table_iterator_release(&it);
+	}
+
+out:
+	if (table)
+		reftable_table_decref(table);
+	reftable_buf_release(&buf);
+	return 0;
+}
diff --git a/oss-fuzz/meson.build b/oss-fuzz/meson.build
index 10bcac2f6d..5a3854256b 100644
--- a/oss-fuzz/meson.build
+++ b/oss-fuzz/meson.build
@@ -6,6 +6,7 @@ fuzz_programs = [
   'fuzz-pack-headers.c',
   'fuzz-pack-idx.c',
   'fuzz-parse-attr-line.c',
+  'fuzz-reftable.c',
   'fuzz-url-decode-mem.c',
 ]
 

-- 
2.55.0.rc1.745.g43192e7977.dirty

