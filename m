Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB892517A6
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 17:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949219; cv=none; b=YhEqLeubRg/a3kvetTakMq42a+1ciDbBt8bMuf6OTnSsdMURfLc8kJJZV0HSlKMJgHYGv4gTGW9diUVzZzLJ39NnwdtUL12WmOGUGPCuxk98oeqnecCIIPD/DaqKARcjEK2OvKksdb3ow9v3APOaU7DsFVgoO/CvLe85DvpvYUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949219; c=relaxed/simple;
	bh=mU8euINH0IXw1qZMgay3j2SgpC1ATfcX8LqoTEZ8T3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UuGKJsIlf3hPWcGqgEKynFJIwEGqYSbGNSYywwDIyTBa5k+uHRs+X+aH4BqqHvZ0+X4NaRuyETBFYB1NzZd+TYMffAQ1kJIjmeygQplT31leQEzItovpitpMgX7AKcDYJBg0u7IhTAFRBJfy6UCH0h+YzUgaYb31ldGeFriHN7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQp0H5uB; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQp0H5uB"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39c266c2dd5so7052424f8f.3
        for <git@vger.kernel.org>; Tue, 29 Apr 2025 10:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745949215; x=1746554015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z99cs7/y4TQCRlIzA7iWBs3S72LOKQejIXRBHvW4/kg=;
        b=aQp0H5uB69tbBc/0h+ZL/564vo+EJds7EJqNPPq28lrG5kYh9eqwwLhHgbzO9HvjCW
         DTwAyVPsnBk/22rHrvf26jcmknbLoJPJYNhU4WyWEJJNaXQPF2N6nO2Y6rGgjmw2nZnh
         /xopZkc58hoR3wTFpJFuaB3PRaN+iEYk9TX9A86usgwmkWQBRXIm6oW721R0+JaQaUcy
         SSprWfqoLPb57yfFtDPfjNVHsJ2l9Lisa28MZ+TdwBJUzX6ICZRMfN4qUtxDZxl1mPAm
         moH1sOmRXde1rohdF8P/ghAiOL1IN4vE3ZxdAl1G4YlARykMK9+Pz7gv7etDndhz6SL0
         Hc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745949215; x=1746554015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z99cs7/y4TQCRlIzA7iWBs3S72LOKQejIXRBHvW4/kg=;
        b=EHyojv9tWgPalDgtFE7XFlmygF/lTESYFrR/zuZBPlIPYCaQpXd9vjWFUz1qFLcTUy
         klGh7PiR4CVL2PUFwx0Y9WpTKLC/lsYr2exVINTLjgsy1d/0gftKmodRpp5v1mizB4Jm
         gSFig+ab9hdMj4qrMv45kJaOrL2aGDFaO+XJ8r45Uh5RuZ9QtGqZp4D2+KfH1sgDTqb+
         jTFGzHQNYouA2o7ppxDXFCfZlsvWTakb2ew/7oGEAWSUNLzxhXLr/5S7Ibldl6645jmt
         ZZhLskfg9B3VfHZZAk+vl1HZ2Tut1LActt0yfvvH4wglNSfk9SoU3zNZgUikb1T4vair
         rPyA==
X-Gm-Message-State: AOJu0YzROSYcdkHHc+T8jAOHJ7UYHht6MiDZJGBkoUtrGvHC4eXDFHup
	CaV5yeji5FFCnbBtv3Ez+FllhcRaiOlDWfzwSsCFN5vfhXbc6Ir+fGOT/9cEEoQafw==
X-Gm-Gg: ASbGncsEtbmkreY6zTfhfD6kaF1vNXW4DBMhKE7+8Gw3Wjb62/JqKklYPqWjDbzeCQW
	PQeTCuyBG0qOGFTQFxcjy9ngfCSBVpANmkLs+2Ukf9NWS329Wg/t53ZpzPgModzmwjaI9P8Fm/I
	XB5uqOQsjAS92PjervfOeKOnNK1nvuxbvv/O4p3lspIKLViezVGU7FwPZvqwzlB0WyhTtYhngOW
	Ot9fCzTlIDmYLcCSc+QmhYBAwqTatanEUjU+G0IUsSSiewWlO9pTtlERQxc3YOGXP5suzJ3Lr27
	U7pVeICpiUDowD2K6II1dzsvziTmfLDWUPY=
X-Google-Smtp-Source: AGHT+IGDCgRH3MAPHCNQn5PMWyL292m0+3gEYv0JubLwLrdFpDp7iXA22uBbqZOttgzQoagjm8CPZA==
X-Received: by 2002:a5d:5887:0:b0:38b:d7d2:12f6 with SMTP id ffacd0b85a97d-3a08f7524bdmr304542f8f.2.1745949215463;
        Tue, 29 Apr 2025 10:53:35 -0700 (PDT)
Received: from localhost.localdomain ([105.113.85.121])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ca511asm14261782f8f.26.2025.04.29.10.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 10:53:35 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 01/10] t/unit-tests: implement reftable test helper functions in unit-test.{c,h}
Date: Tue, 29 Apr 2025 18:52:53 +0100
Message-ID: <20250429175302.23724-2-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429175302.23724-1-kuforiji98@gmail.com>
References: <20250429175302.23724-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Helper functions defined in `t/unit-tests/lib-reftable.{c,h}` are
required for the reftable-related test files to run efficeintly. In the
current implementation these functions are designed to conform with our
homegrown unit-testing structure. So in other to convert the reftable
test files, there is need for a clar specific implementation of these
helper functions.

type cast `for (size_t i = 0; i < (size_t)stats->ref_stats.blocks;
i++)`, implement equivalent helper functions in unit-test.{c,h} to use
clar. These functions conform with the clar testing framework and become
available for all reftable-related test files implemented using the clar
testing framework, which requires them. This will be used by subsequent
commits.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 t/unit-tests/unit-test.c | 93 ++++++++++++++++++++++++++++++++++++++++
 t/unit-tests/unit-test.h | 16 +++++++
 2 files changed, 109 insertions(+)

diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
index 5af645048a..6c2a4e6aa8 100644
--- a/t/unit-tests/unit-test.c
+++ b/t/unit-tests/unit-test.c
@@ -1,10 +1,103 @@
 #include "unit-test.h"
 #include "hex.h"
 #include "parse-options.h"
+#include "reftable/constants.h"
+#include "reftable/writer.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "strvec.h"
 
+void cl_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id)
+{
+	memset(p, (uint8_t)i, hash_size(id));
+}
+
+static ssize_t strbuf_writer_write(void *b, const void *data, size_t sz)
+{
+	strbuf_add(b, data, sz);
+	return sz;
+}
+
+static int strbuf_writer_flush(void *arg UNUSED)
+{
+	return 0;
+}
+
+struct reftable_writer *cl_reftable_strbuf_writer(struct reftable_buf *buf,
+						 struct reftable_write_options *opts)
+{
+	struct reftable_writer *writer;
+	int ret = reftable_writer_new(&writer, &strbuf_writer_write, &strbuf_writer_flush,
+				      buf, opts);
+	cl_assert(ret == 0);
+	return writer;
+}
+
+void cl_reftable_write_to_buf(struct reftable_buf *buf,
+			     struct reftable_ref_record *refs,
+			     size_t nrefs,
+			     struct reftable_log_record *logs,
+			     size_t nlogs,
+			     struct reftable_write_options *_opts)
+{
+	struct reftable_write_options opts = { 0 };
+	const struct reftable_stats *stats;
+	struct reftable_writer *writer;
+	uint64_t min = 0xffffffff;
+	uint64_t max = 0;
+	int ret;
+
+	if (_opts)
+		opts = *_opts;
+
+	for (size_t i = 0; i < nrefs; i++) {
+		uint64_t ui = refs[i].update_index;
+		if (ui > max)
+			max = ui;
+		if (ui < min)
+			min = ui;
+	}
+	for (size_t i = 0; i < nlogs; i++) {
+		uint64_t ui = logs[i].update_index;
+		if (ui > max)
+			max = ui;
+		if (ui < min)
+			min = ui;
+	}
+
+	writer = cl_reftable_strbuf_writer(buf, &opts);
+	reftable_writer_set_limits(writer, min, max);
+
+	if (nrefs) {
+		ret = reftable_writer_add_refs(writer, refs, nrefs);
+		cl_assert_equal_i(ret, 0);
+	}
+
+	if (nlogs) {
+		ret = reftable_writer_add_logs(writer, logs, nlogs);
+		cl_assert_equal_i(ret, 0);
+	}
+
+	ret = reftable_writer_close(writer);
+	cl_assert_equal_i(ret, 0);
+
+	stats = reftable_writer_stats(writer);
+	for (size_t i = 0; i < (size_t)stats->ref_stats.blocks; i++) {
+		size_t off = i * (opts.block_size ? opts.block_size
+						  : DEFAULT_BLOCK_SIZE);
+		if (!off)
+			off = header_size(opts.hash_id == REFTABLE_HASH_SHA256 ? 2 : 1);
+		cl_assert(buf->buf[off] == 'r');
+	}
+
+	if (nrefs)
+		cl_assert(stats->ref_stats.blocks > 0);
+	if (nlogs)
+		cl_assert(stats->log_stats.blocks > 0);
+
+	reftable_writer_free(writer);
+}
+
 static const char * const unit_test_usage[] = {
 	N_("unit-test [<options>]"),
 	NULL,
diff --git a/t/unit-tests/unit-test.h b/t/unit-tests/unit-test.h
index 85e5d6a948..fe0aebd876 100644
--- a/t/unit-tests/unit-test.h
+++ b/t/unit-tests/unit-test.h
@@ -1,8 +1,24 @@
 #include "git-compat-util.h"
 #include "clar/clar.h"
 #include "clar-decls.h"
+#include "git-compat-util.h"
+#include "reftable/reftable-writer.h"
 #include "strbuf.h"
 
+struct reftable_buf;
+
+void cl_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id);
+
+struct reftable_writer *cl_reftable_strbuf_writer(struct reftable_buf *buf,
+						 struct reftable_write_options *opts);
+
+void cl_reftable_write_to_buf(struct reftable_buf *buf,
+			     struct reftable_ref_record *refs,
+			     size_t nrecords,
+			     struct reftable_log_record *logs,
+			     size_t nlogs,
+			     struct reftable_write_options *opts);
+
 #define cl_failf(fmt, ...) do { \
 	char desc[4096]; \
 	snprintf(desc, sizeof(desc), fmt, __VA_ARGS__); \
-- 
2.43.0

