Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711E73F86FC
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723746; cv=none; b=HWQ5aYUtUNksRtXcQFl2UsyDmRGso0nMaMWUq0G/lEMLjDj94u5fVQAtN9SSZTbKzAq93n+4Jh30sZWkRWWRYfGzwmFfBwer7mPhEreYt1jejjMKYMFHnPlOudalda3Scrz7CBpVzNY2Yxfg4iajSJCEshciEwDUBSP0Eq5uvA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723746; c=relaxed/simple;
	bh=dDiH/lShnSxylTsd9gi6EV9joK0TOfa/V6vwEbZafnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y7SjYctzSZI6CQjpFfRugkRwJQp0oWz9UXtHxaGSP16wFyf5g7/VGhBjEmW6PcKuEZG70RFbx3aQQFWdUGeYm+krMx/wZ6WM/HnYEWg8pXDQ8IHSFyxgRXfqUMQg7CEh8Q4YLxOaEBXfrlxYFgOuIt0hlucg22nllDgkekU4pw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Bg6wiVs7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TX3K/vOO; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bg6wiVs7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TX3K/vOO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B8C3C7A009C;
	Mon, 29 Jun 2026 05:02:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 29 Jun 2026 05:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782723744;
	 x=1782810144; bh=ebu+XZ9G+rxx/riaXvMZF8tF4FMBCdsg5d2k06RSCAE=; b=
	Bg6wiVs7rurR4izYiyZkaIE1uicB/GsRRoAjkOHIhm/5IE/8QZxpmdx84EOMDIhB
	AmPhh4jwV8kg7XWzswRLxhVkGCfRxzzSr+LWqMo6ANat5+D9omxUMC7qbte1Wi/O
	KoW56A0kGkZc0evRd9LW2DyN3YiTq3/1WYOVuH72FWlotnmH9bT7oGQCCrh8DNFE
	mGfWRQC4MU3VHNAt98hkOD3kDRP+NS9Xkx905NlTzTIUvkGpNPUdBi0wIHu9f5X3
	ESiUJugAtU3eo5JJs1aXBKtTln1wuVbjfT6eJtTY+2Wr3vJ00/nMRC/DupwgdMIZ
	mcaxFgEGS+qGj5qi1LYSJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782723744; x=
	1782810144; bh=ebu+XZ9G+rxx/riaXvMZF8tF4FMBCdsg5d2k06RSCAE=; b=T
	X3K/vOOd/A+0HE+pIjHVcbcgBx+456myO8NfVA2ccLI3HTrkpVIoTGh6o+6+BpIc
	Uk+zy0XJGIpB4QUDDk2zt4D3O8FXZMaYMSfeGzbxRQdF2GNHmTvqdDBQaOilmKyY
	tTNktUPZFk6IZq1i81qitqm2YhxB0+zVXC2ecf9txUS7+aSijNyR8M9rIK/VVZ78
	Gp8eRzrzYqwEH8g0TNNW8+GmLGpgiEPIjv9i9gqIHgKtiG34mBaaYoTrUnZ0pT0F
	v00/ON1Nh7eobNVvoNIxZC1mS86tPL/nTEUQ5IsOeZARIwSBIl7xeuZkhK8IO/yF
	28Prn/lhHKhkrAnw0ZqMg==
X-ME-Sender: <xms:oDRCageNXlX87582HJ7MG5icwcXTdcZQ3ZNORhL_J7lJAwYdiPrbkA>
    <xme:oDRCappNPBLqPUwNKEl12BZC-81H4sIPgckewMkRw4RosOCBd-eXgnZMjfvs2cSKz
    L_rtaySUWwVg1ABR7Wd96Wn4o2Xw-EcG3pOwPNyZh6vp2qFCX_OCg>
X-ME-Received: <xmr:oDRCau5u2ztQBt7UktOIgmmU4gr78vVskswbRi2LHeVAqxMw_po4xYktI0aFwiQ_15gP53jWeGZiNGX4Z-3DVXyYoJBs7dOEwyzTQhYwmkXl>
X-ME-Proxy-Cause: dmFkZTE+GKhRNiM0I6Brenw3w0YotI1FE0O/3qBN+IiuMuHqc7Y43TkqBK3nHRqQl7/WT9
    NjtACQq01LGlnfgbcIBpTcbKqMbh/zJzNf8yhBF1p3guV034x30EE3R6qXGP6w/qntK6Ux
    0PL7om6PrQjYGPISHZMvXWC7rQiyEM+W2s2TcfHNcnru5SF3Gom0s9ezgP2SLdaiksbGqv
    9ahmvvth3y37MtP0bKLpUKT1qqa2XzEqRF9tJ7vMWyEGT3m/3BWZ/6qFBcIBCqblUnO6Hw
    cG++3OSh0KCA/DktwhQcvdgoQtQwIkVYCE2YHpxHn9MNzvRgn4PBy3ySupY9N3taY4+LOX
    HnQ2LWVvMRGHBEB4NtNlVu9n/Lzn9SFYV6jcNpzOJWOYFQHpCW8iw7SwgRye5LaQ0vp7Fr
    FGesdZQt0AgjQA5OgYzOxrSn95HWEKuAMmvCENjy9TO+jU4j2J5ALh5NM9GvEcjaoKlzAW
    WKpL0EaeU8cLDyS25c7Kgq0Bbk+Tlh7YuEeeoMWG9Mk2CZrqTcCxee/nRXyxhWpvZpB1Zs
    KsFUKaWYDYMGG8CKk92Sr/HGQmI+Ct9HgEJFtBVRHJyE6igbp3Hspf2cH0zkFi+WbCjN0i
    Qw9ioYY+ZJECncdrj6K7XlRqCEJPJ/k4s8ZxTXbQYv0jrAXvEuSBwaIjQvYA
X-ME-Proxy: <xmx:oDRCavqSSjJWB6rhMmPaUPyrlREVkCifNjqsZpxcCkqrL5E5kgHEOA>
    <xmx:oDRCagisph4lYcYQuUYQXoYj7AVAV3wEzmjooV3mD1fV2X2meu3v6Q>
    <xmx:oDRCapLwd13S1vWQ3TpfhANvloe9xSimpu9KLjtxM30FAOEFETaKMA>
    <xmx:oDRCagCkn16-i3_H1efGdrUMr31rC0Yn-elH-3HAILPBohGUR70vjQ>
    <xmx:oDRCakkN9XqxQa2BOuxMr0RrJCPC0utRvHHo1kMVCpT2_nL2-zIXQocR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 05:02:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 39200a4d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 09:02:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 29 Jun 2026 11:02:15 +0200
Subject: [PATCH v2 02/12] oss-fuzz: add fuzzer for parsing reftables
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pks-reftable-hardening-v2-2-b0228e7d908d@pks.im>
References: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
In-Reply-To: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Christian Couder <chriscool@tuxfamily.org>
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
2.55.0.rc2.803.g1fd1e6609c.dirty

