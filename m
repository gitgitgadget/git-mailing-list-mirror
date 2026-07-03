Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ED032AAA0
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083541; cv=none; b=gpx+sUdZDt1U7xGihC00FC9oymyh4C9/rXbNQaLJs3D05zJKEa3oDPhIpF4gs5nw1CABVtmyK54JGLewmhXiEmDeD2QNNouU+fGjsSfHb0ralC8RgNGZ840sVJoY8gs+Vlx4s94U3OePXRPeeuSak//bFrJp2HSWf+T51Nx8Vz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083541; c=relaxed/simple;
	bh=ue1a3rVlY92oBF+QQW1cGfx7d7oRfm38V5lMQjam4Fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iI/r/SbxU7RoJm66LP1Unbz0vyP6k7iuB98Nn17s+eVD9sfNC9x3Hc6ee5RazdOArgecPWg87e0ciepmYt/NNiwslmgs3YF/GBv1TtjBOiLlsBNjyS0KIZGfpaZKihTt0w7CnPe+XWrNhTAur7briG2zrY9BQWOAx2+twhb7FBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cdxLRvBc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ph78IWKK; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cdxLRvBc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ph78IWKK"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B6E491D000C4;
	Fri,  3 Jul 2026 08:58:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 03 Jul 2026 08:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783083539;
	 x=1783169939; bh=Pdh8CpNVBVjtlMAjr2sjY7vyCDMvsEPTQw8AeKMnSB0=; b=
	cdxLRvBcG/hDCUDawPNtCRuB+07R/H8Xoay8lN89CfCEgeMKnEz+a9mdWmPbtfh4
	7fTXXMwaCSzor+sSvg2Zi2fJ1mpGn1BeNQifEMYZrFgupaVGiM0vtyRyWzJRoC0j
	w/QRaHrgwez+vXHBVZSicE+lA+dcvn3zAU/MRPMtdrtjaqBoOJ9rz9CXVF6Rs88H
	Wjza3R7NTALGCpOtR7LNKNf0UGeEoyn/+wffZqCxtcqUCujbhTmCPZ0Rhj6Ls7Tr
	cln694Ildgj+eEACWLTSdqugfIQND7oi9h69bnkmwS5OsLSA0CTag766flFayC7A
	iYxuavamfANwW87S3UHHPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783083539; x=
	1783169939; bh=Pdh8CpNVBVjtlMAjr2sjY7vyCDMvsEPTQw8AeKMnSB0=; b=P
	h78IWKKHnOdR45KoVoLMqSQ1jABeeDSaTe7dGlWzLrA8ye1O4kx7lc0+HAvLZOm9
	+JUsjyYHJ6gpqen7tNwZbm+7mnDv6v2fK66H8JV3VI/Pp3zVvt2brV6Bh+SKS5AX
	JHIhC4WrB+8qKybYd1uY1qtbC8bYse1uECz12vHGu9SodzSNypVce5Jrby2321P2
	H6JjP9J8+htj9h/SsyLe/h3T2Naw/D/Ec5XAdglvuqEzh5W9Nb/FybTeVK5yglKe
	BwfubRfQbnTvpIgUtPdgvihKqHyyrIBOzRMnErAigcjnOGfU1FArDx0DCGfWHwFl
	/zOoA6DJ7zbJcd0OVJSbw==
X-ME-Sender: <xms:E7JHatPSItFEbKJ9Fktte3nXwNEcJ6OhXW1HUGzHVyROos_xmqBEog>
    <xme:E7JHam8W8Aw9bDeohxoVqsphD4QRQPiZstgSE3d_dewtiheuwuCzd5qMOCav4ad8J
    PGpfQ8_BRrVfmNY8rtCpdqrmY40xKVh9euHnHloyivnbkkfr43->
X-ME-Received: <xmr:E7JHahRVn5QWZtzjxeRmVJHpne2LxmvrjEZ_l-q4x1TnftHcKYTQZkBX8ERaDDTX92JQcezp_jmq3w5C0N3Eoht7iv54-j4hEotn98fRKg>
X-ME-Proxy-Cause: dmFkZTE70wjLXbdj3mc/uT1iPcBLptY3t1fn4m8Ul79xuS57pM206ezWjT0mYLFjAH1c+0
    PQ+9ZOaosqnTmDIaFdrQodwSIi9v8T2iWukNYarsGMOnIdiVITsqlmWrxjtBHQ85GObvFx
    iIBKxTVTgtJDqLhj9BAfTlzB4OyH8Jo+6f1QLqleKOehDVAGEp4mTME/YHiNwQvxQCJ5zG
    0IRsTIcmUitZ/bYxE7qG7CDopWqKzJ9dnA6n33bcsyk2AENU7Ym88Ao6edOKjDyOSJ0uSv
    G+Og4QABLtl2JoTMB3BVENmOpQNh2vzUaVVCmUxO45V8m96/S0I3lhhzia5tw/+IlxlzcZ
    PvckrnvYUAt9qygXGeXUpZ+e4Zow3c4Uvcw+ITcB63v9udjQC+75HaEE9YlxQiTT3NmO67
    CQAvMA5iwL2HV/Q+dgSYTESVTiHRCcrTY0fK3BSQEc8za0jW/BY/AKbiKiOP/VFaQvdrE1
    7pFNONj1GZvgWMVfxePjivagTyrS8zdznhe/0UaVCLqDE2HjGWhSsL7tCYsSvPGXDaTFTY
    /W+rg8oGPsup2LurqG6ktbkSnKleeDaRuagGNEThPBIH7ZfFT1wDgFCJlhOir9PwN9vlsM
    HTo+e4JYr/OeolTb+wZZ9cDUge4OE+ffS/cTH1szgfSupdgZY1kVdbHcDV1w
X-ME-Proxy: <xmx:E7JHaok_1w0PegTt-2sWszPnNA0ZZ2zGJbA0FczWqkTY_lVptPArlw>
    <xmx:E7JHahRZSFVHxIdCdlp9HXOtwkuchUL1WnLGIX6bCfzjcr6vpAgSlA>
    <xmx:E7JHamMz3BQY0aL9wegrYQsV1slChU6mfej_-AyT9MiMW2G4pHe6lg>
    <xmx:E7JHaqXmG3k2WFkYrSD1ungLN1laft1dr0OMiamE8sj8YOUaoqeiNQ>
    <xmx:E7JHasmAJ1PZtuFb2KfwkdJ8gsAFnbFpMt6k0I5b7mIl-pTO2mYcQmSW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 08:58:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b0c96395 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 12:58:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jul 2026 14:58:45 +0200
Subject: [PATCH v3 02/12] oss-fuzz: add fuzzer for parsing reftables
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-pks-reftable-hardening-v3-2-b87c555b9920@pks.im>
References: <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
In-Reply-To: <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Toon Claes <toon@iotcl.com>, 
 Christian Couder <chriscool@tuxfamily.org>
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
2.55.0.795.g602f6c329a.dirty

