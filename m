Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4C9C4332F
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 396416103B
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242162AbhJGU1k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 16:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242140AbhJGU1X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 16:27:23 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A91C061765
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 13:25:29 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id o20so22698527wro.3
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 13:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GpwNID0VrzrfwftFoVvo6TxZhM1AX2ihEq23nc2JbuU=;
        b=Sr0MLsvemA6/4bRKhS7zlc1G+vb6kq4aATZ0KTTF73pM4wQudwVGC3fkabVYOOA+RP
         ZIg8NbHkQYFso1XJQ6XqKz54mpgR4Pjr43oEFcF9Z2Du61SGYSIBkkBMNCXtxUBVGpvJ
         5AH72KbKKqmjuO/9hcBh9dlf6K+xMaTZSBpHvWClT3OVMsIMRHm0goYvqmtQdOhvA6GT
         9FXYpfSrI4pslsWaqqLWW44XQT9zxp74mJRtixT5savxZ3sKWAdo2GWE9CngtKCiBQs1
         XEVks+28ETwo/R5y/TxggcaVq9d62JLga3qM3gARLo2Da87UCQuU84VtmP2OGVxR9/0d
         LUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GpwNID0VrzrfwftFoVvo6TxZhM1AX2ihEq23nc2JbuU=;
        b=P7mzAbCLqwkJ9UwwuzlVqtRIEDVD+IqRCMNx6KGZJS0K4MOsebJ3nts8VFje9Y38ki
         TUc7mX2rW5jmSHRgYAeAfVgCR2IGTPFMCVQUL5MYoLi9puWCsghkruI1+7pB5Q7CTSCa
         2B5J4Quq0ad8q6AgCkvElC+F5wxjSNUvZan2XrRXbYJJHKaSZZyIc86/4gKTGsA62a8F
         LUkL6y6pl9kAq6IjD/U1Not3ml8MzZA54YWz9c31JmPL5OoZKNi/lfsV4t3jP/LMk5Xl
         ZA8c+MLw6AFugXf6iRN5gVqK/MO8Y32FFT5NhTSMPyleRIR5DiwwPGtluWlHhDWKUu7r
         1img==
X-Gm-Message-State: AOAM530dqyCfCXi4qyBjWsxJcV1udf9IUC56+BmFsgpK6spIhuup/RWo
        EAIiPFHakddiRFnNlnsMO3v+v16IwZE=
X-Google-Smtp-Source: ABdhPJw10A5ls32A+tHbxYaGqRyOwmWcUAlNf9cy/uMQ919jXMmrtHGTaOnQd6EvWhDW2JK5+O2XcA==
X-Received: by 2002:a05:6000:2c2:: with SMTP id o2mr8074325wry.194.1633638327802;
        Thu, 07 Oct 2021 13:25:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g25sm326338wrc.88.2021.10.07.13.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 13:25:27 -0700 (PDT)
Message-Id: <6e5ee04308370885e280fa17c19b64c6d34b4f6e.1633638316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v4.git.git.1633638315.gitgitgadget@gmail.com>
References: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
        <pull.1081.v4.git.git.1633638315.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 20:25:10 +0000
Subject: [PATCH v4 14/19] reftable: add a heap-based priority queue for
 reftable records
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This is needed to create a merged view multiple reftables

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                  |   2 +
 reftable/pq.c             | 105 ++++++++++++++++++++++++++++++++++++++
 reftable/pq.h             |  33 ++++++++++++
 reftable/pq_test.c        |  82 +++++++++++++++++++++++++++++
 reftable/reftable-tests.h |   1 +
 t/helper/test-reftable.c  |   1 +
 6 files changed, 224 insertions(+)
 create mode 100644 reftable/pq.c
 create mode 100644 reftable/pq.h
 create mode 100644 reftable/pq_test.c

diff --git a/Makefile b/Makefile
index 65d3856aaea..cdfde13b584 100644
--- a/Makefile
+++ b/Makefile
@@ -2442,6 +2442,7 @@ REFTABLE_OBJS += reftable/block.o
 REFTABLE_OBJS += reftable/blocksource.o
 REFTABLE_OBJS += reftable/iter.o
 REFTABLE_OBJS += reftable/publicbasics.o
+REFTABLE_OBJS += reftable/pq.o
 REFTABLE_OBJS += reftable/reader.o
 REFTABLE_OBJS += reftable/record.o
 REFTABLE_OBJS += reftable/refname.o
@@ -2452,6 +2453,7 @@ REFTABLE_OBJS += reftable/writer.o
 
 REFTABLE_TEST_OBJS += reftable/basics_test.o
 REFTABLE_TEST_OBJS += reftable/block_test.o
+REFTABLE_TEST_OBJS += reftable/pq_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
 REFTABLE_TEST_OBJS += reftable/readwrite_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
diff --git a/reftable/pq.c b/reftable/pq.c
new file mode 100644
index 00000000000..efc474017a2
--- /dev/null
+++ b/reftable/pq.c
@@ -0,0 +1,105 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "pq.h"
+
+#include "reftable-record.h"
+#include "system.h"
+#include "basics.h"
+
+int pq_less(struct pq_entry *a, struct pq_entry *b)
+{
+	struct strbuf ak = STRBUF_INIT;
+	struct strbuf bk = STRBUF_INIT;
+	int cmp = 0;
+	reftable_record_key(&a->rec, &ak);
+	reftable_record_key(&b->rec, &bk);
+
+	cmp = strbuf_cmp(&ak, &bk);
+
+	strbuf_release(&ak);
+	strbuf_release(&bk);
+
+	if (cmp == 0)
+		return a->index > b->index;
+
+	return cmp < 0;
+}
+
+struct pq_entry merged_iter_pqueue_top(struct merged_iter_pqueue pq)
+{
+	return pq.heap[0];
+}
+
+int merged_iter_pqueue_is_empty(struct merged_iter_pqueue pq)
+{
+	return pq.len == 0;
+}
+
+struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
+{
+	int i = 0;
+	struct pq_entry e = pq->heap[0];
+	pq->heap[0] = pq->heap[pq->len - 1];
+	pq->len--;
+
+	i = 0;
+	while (i < pq->len) {
+		int min = i;
+		int j = 2 * i + 1;
+		int k = 2 * i + 2;
+		if (j < pq->len && pq_less(&pq->heap[j], &pq->heap[i])) {
+			min = j;
+		}
+		if (k < pq->len && pq_less(&pq->heap[k], &pq->heap[min])) {
+			min = k;
+		}
+
+		if (min == i) {
+			break;
+		}
+
+		SWAP(pq->heap[i], pq->heap[min]);
+		i = min;
+	}
+
+	return e;
+}
+
+void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry e)
+{
+	int i = 0;
+	if (pq->len == pq->cap) {
+		pq->cap = 2 * pq->cap + 1;
+		pq->heap = reftable_realloc(pq->heap,
+					    pq->cap * sizeof(struct pq_entry));
+	}
+
+	pq->heap[pq->len++] = e;
+	i = pq->len - 1;
+	while (i > 0) {
+		int j = (i - 1) / 2;
+		if (pq_less(&pq->heap[j], &pq->heap[i])) {
+			break;
+		}
+
+		SWAP(pq->heap[j], pq->heap[i]);
+
+		i = j;
+	}
+}
+
+void merged_iter_pqueue_release(struct merged_iter_pqueue *pq)
+{
+	int i = 0;
+	for (i = 0; i < pq->len; i++) {
+		reftable_record_destroy(&pq->heap[i].rec);
+	}
+	FREE_AND_NULL(pq->heap);
+	pq->len = pq->cap = 0;
+}
diff --git a/reftable/pq.h b/reftable/pq.h
new file mode 100644
index 00000000000..56fc1b6d873
--- /dev/null
+++ b/reftable/pq.h
@@ -0,0 +1,33 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef PQ_H
+#define PQ_H
+
+#include "record.h"
+
+struct pq_entry {
+	int index;
+	struct reftable_record rec;
+};
+
+struct merged_iter_pqueue {
+	struct pq_entry *heap;
+	size_t len;
+	size_t cap;
+};
+
+struct pq_entry merged_iter_pqueue_top(struct merged_iter_pqueue pq);
+int merged_iter_pqueue_is_empty(struct merged_iter_pqueue pq);
+void merged_iter_pqueue_check(struct merged_iter_pqueue pq);
+struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq);
+void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry e);
+void merged_iter_pqueue_release(struct merged_iter_pqueue *pq);
+int pq_less(struct pq_entry *a, struct pq_entry *b);
+
+#endif
diff --git a/reftable/pq_test.c b/reftable/pq_test.c
new file mode 100644
index 00000000000..c9bb05e37b7
--- /dev/null
+++ b/reftable/pq_test.c
@@ -0,0 +1,82 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "system.h"
+
+#include "basics.h"
+#include "constants.h"
+#include "pq.h"
+#include "record.h"
+#include "reftable-tests.h"
+#include "test_framework.h"
+
+void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
+{
+	int i;
+	for (i = 1; i < pq.len; i++) {
+		int parent = (i - 1) / 2;
+
+		EXPECT(pq_less(&pq.heap[parent], &pq.heap[i]));
+	}
+}
+
+static void test_pq(void)
+{
+	char *names[54] = { NULL };
+	int N = ARRAY_SIZE(names) - 1;
+
+	struct merged_iter_pqueue pq = { NULL };
+	const char *last = NULL;
+
+	int i = 0;
+	for (i = 0; i < N; i++) {
+		char name[100];
+		snprintf(name, sizeof(name), "%02d", i);
+		names[i] = xstrdup(name);
+	}
+
+	i = 1;
+	do {
+		struct reftable_record rec =
+			reftable_new_record(BLOCK_TYPE_REF);
+		struct pq_entry e = { 0 };
+
+		reftable_record_as_ref(&rec)->refname = names[i];
+		e.rec = rec;
+		merged_iter_pqueue_add(&pq, e);
+		merged_iter_pqueue_check(pq);
+		i = (i * 7) % N;
+	} while (i != 1);
+
+	while (!merged_iter_pqueue_is_empty(pq)) {
+		struct pq_entry e = merged_iter_pqueue_remove(&pq);
+		struct reftable_ref_record *ref =
+			reftable_record_as_ref(&e.rec);
+
+		merged_iter_pqueue_check(pq);
+
+		if (last) {
+			EXPECT(strcmp(last, ref->refname) < 0);
+		}
+		last = ref->refname;
+		ref->refname = NULL;
+		reftable_free(ref);
+	}
+
+	for (i = 0; i < N; i++) {
+		reftable_free(names[i]);
+	}
+
+	merged_iter_pqueue_release(&pq);
+}
+
+int pq_test_main(int argc, const char *argv[])
+{
+	RUN_TEST(test_pq);
+	return 0;
+}
diff --git a/reftable/reftable-tests.h b/reftable/reftable-tests.h
index 3d541fa5c0c..0019cbcfa49 100644
--- a/reftable/reftable-tests.h
+++ b/reftable/reftable-tests.h
@@ -12,6 +12,7 @@ https://developers.google.com/open-source/licenses/bsd
 int basics_test_main(int argc, const char **argv);
 int block_test_main(int argc, const char **argv);
 int merged_test_main(int argc, const char **argv);
+int pq_test_main(int argc, const char **argv);
 int record_test_main(int argc, const char **argv);
 int refname_test_main(int argc, const char **argv);
 int readwrite_test_main(int argc, const char **argv);
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 898aba836fd..0b5a1701df1 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -5,6 +5,7 @@ int cmd__reftable(int argc, const char **argv)
 {
 	basics_test_main(argc, argv);
 	block_test_main(argc, argv);
+	pq_test_main(argc, argv);
 	record_test_main(argc, argv);
 	readwrite_test_main(argc, argv);
 	tree_test_main(argc, argv);
-- 
gitgitgadget

