Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B48420E9F
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208566; cv=none; b=sCRPOSL0JpCuum2NKo6X6vcoPwIMICK3SG4FDm+iDB0Nx/KTapFwL/WivyTsz8v4D12W1tIHe2N3rXwSJBJ3+iZQWDuDFHcPZnG/lRqp/eqWpZAmpH8WiY1Pvfj3PmYQUboqmz6wqJyGqIbiof4FX8WSwbVZn2s0vwUbyeQ2O6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208566; c=relaxed/simple;
	bh=73bH0MiODiQL/EeHkddlbHF9SACFGPZsjuaqPnJbIWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZ0vHQ1w3Khdk2VwPB03z2HJv6vi9cLpryqwfIbsl2Oa6GShcd5bzlKLIIxAJ3hUngmiqECXgxzBR32ULNmK3Pp8VqUTJPui/hElaz6R9YMQahWI6Ou1d7lkOJ8zd+fs5iIbOtoe2D6vsL4KeijODZ72syCEkCmWu1iJFZUibNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFZ4r2Wn; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFZ4r2Wn"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e08baf860so4148864a91.2
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 06:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784208564; x=1784813364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Cg6cZdSF9f8VVfLqRonYhMdW2NhQaOydkDst5gPhxA=;
        b=KFZ4r2Wn+KTvjw+1lTLKwXQRDSWjub+9W0aaNijoWnOvB7arRsQxZ5H4DdQB0ejgBw
         AQZ/zNn/mtuSb/Qy/0qdR7dXcyRQV+MyK0XUEDUBSPppQyZaYE1s0yX3wc3J6AHhRdAQ
         L5rdGdcGO4sHXzCOHQCnBGLRnZlHj50lEGCuP7cHI+mCxyqJzDoO7ct+ExxJo+bdHXXG
         znWnlL0q3rLD9syhHD7CR1HOopHVb8MAY8ahxL/15vOG8pDlYziEa+j3lm+HNvgaAf/Y
         Rq47FuW18wVPToABKUQDWWihOAhie8pwv0RQG8sMa7D74S80ksgwN4a9VgLOi0VyF1i6
         sCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784208564; x=1784813364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Cg6cZdSF9f8VVfLqRonYhMdW2NhQaOydkDst5gPhxA=;
        b=pH50sVE+UJHulduIVa8wIbytpjqf/3GQmU44UXuO/DQkas7aoA5nWDhIX0kt56qgxL
         ZlskNSV8Hvuobt/1V6kyWRhWqdAe3+ot5EO9c70jM/NE5lDwq5w7uWt4+taw3G38Y5Si
         Iq3FT+rwGtacCBvsh8kczy0xlYnn+nsuK8HxjJZ7fIMO8uBZy2KDfjS9DDExAck1WkQK
         LAfZYjpQRNmqjpHm/vy2Th1BHGHfNNvMSZvl2zS8I7pQJiCfl7z2RmYQ+vLQCrgJMmRJ
         rGL7CE5kE6x8Xo+Qylo3Gcb52gqQ5PjqgQ27G2kfCkqubnyf/wU2dfhamkwvQgW163w9
         MhKg==
X-Gm-Message-State: AOJu0YzarXdponX8ke2qjOAKs6v8Z2m5cfre5/EZW4VzjiGjMtLD2/T0
	FMUwIZ+QkftvIi4VOUQUUftY69NTO9kGULuyedP7ErNBGKERooPZQeKk1ZkE6cnQ
X-Gm-Gg: AfdE7ckLaVexW4635OoidCNL/qMdbN+N9buMoGwdX4l4bCymTi8+rZRyG52BlUQ2fk6
	nVJ+YyG0MHhpexCcGI1irY3UdisCWaIUy9EsqOaIQgyEfMJzfe4TG9uZpjkwpa6bTOS+RWYcCFt
	CErJLBpPpxFP5Z0fEp/JRt3uXJgwa1lHB2O0Rl6BAlstirlimVgOQ7RQb/YYmXe9zNYwleXTnuY
	+ACny7J+mxx3lfTiYEt7l5+VZ9v1CaTMClBFakzd+B/TUdGZogckDfKybEO2CWLeFpVgQYM6in1
	g9MdWobmmv1h2u6ouGmtW/0JUfpm16hal5/XRJwUHv8vKOB34adUi8LtPkYCG/JxnlkcUJ3B3Qq
	r1QXBZA4xy88nspJ/fl1JCANZc5TcoSENQSWBDJzqims40WqCfkrphJCL/oMYs9HSX8usq5VSQG
	AwtNITGhO3uOWauaUPyKGEFmLpjkPvlTOici/bm6QKRf3Sx6Mxg2jY9l39+j+P4DjeRiq/rhiyJ
	qGCkWQ/0jER3Nb3pT6gQHx9uvQ6cbnIlK1HQNQ3qg9BdGwQQWweRSg=
X-Received: by 2002:a05:6a20:9183:b0:3b3:bf7f:efeb with SMTP id adf61e73a8af0-3c36c3603d7mr8400202637.45.1784208563902;
        Thu, 16 Jul 2026 06:29:23 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:88fb:4543:3010:936c:4da8:7aa1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e4fcd31sm13291188eec.4.2026.07.16.06.29.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 06:29:23 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [RFC PATCH 2/7] list-objects-filter: add list_objects_filter__filter_oidset()
Date: Thu, 16 Jul 2026 18:58:43 +0530
Message-ID: <20260716132848.95982-3-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing filter entry point, list_objects_filter__filter_object(),
is built around the object-walk path: it expects traversal context and
provisional omit sets, and is meant to be called as objects are
visited during a walk. A caller that already has a set of OIDs in hand
and only wants to know which ones a filter would select has no usable
entry point into the filter API.

--drop-filtered is exactly such a caller: it collects promisor blobs
into an oidset and needs to know which of them exceed the filter
threshold, without performing an object walk.

Add a helper, list_objects_filter__filter_oidset(), that takes a set
of OIDs and populates an "omitted" set with those that would be
filtered out by the given filter options. Only blob:limit=N filters
are supported for now.

This helper does not actually reuse the existing filter machinery.
It reimplements the blob:limit size check directly. That machinery
is tied to the object-walk path and cannot easily be driven
from a plain oidset. A NEEDSWORK comment marks this so the helper can
later be refactored to reuse the real filter logic instead of
duplicating it.

OBJECT_INFO_SKIP_FETCH_OBJECT is passed when reading object info so
the helper never triggers a lazy fetch.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Siddharth Asthana <siddharthasthana31@gmail.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 list-objects-filter.c | 45 +++++++++++++++++++++++++++++++++++++++++++
 list-objects-filter.h | 16 +++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index c912ff3079..6a2e9d5b24 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -828,3 +828,48 @@ void list_objects_filter__free(struct filter *filter)
 	filter->free_fn(filter->filter_data);
 	free(filter);
 }
+
+/*
+ * NEEDSWORK: this reimplements the blob:limit size check rather than
+ * reusing the existing filter machinery in
+ * list_objects_filter__filter_object(). That machinery is currently
+ * tied to the object-walk path and cannot easily be driven from a
+ * plain oidset. It would be nice to refactor the filter code so this
+ * helper can reuse it instead of duplicating the size check.
+ */
+int list_objects_filter__filter_oidset(struct repository *r,
+	struct list_objects_filter_options *opts,
+	const struct oidset *in,
+	struct oidset *omitted)
+{
+	struct oidset_iter iter;
+	const struct object_id *oid;
+
+	if (opts->choice != LOFC_BLOB_LIMIT)
+		return error(_("filter_oidset: only blob:limit filters are supported"));
+
+	oidset_iter_init(in, &iter);
+	while ((oid = oidset_iter_next(&iter))) {
+		struct object_info info = OBJECT_INFO_INIT;
+		enum object_type type;
+		unsigned long size;
+
+		info.typep = &type;
+		info.sizep = &size;
+
+		/*
+		 * Use OBJECT_INFO_SKIP_FETCH_OBJECT to avoid triggering
+		 * a lazy fetch while inspecting candidates for removal.
+		 */
+		if (odb_read_object_info_extended(r->objects, oid, &info,
+				OBJECT_INFO_SKIP_FETCH_OBJECT) < 0)
+			continue;
+
+		if (type != OBJ_BLOB)
+			continue;
+
+		if (size >= opts->blob_limit_value)
+			oidset_insert(omitted, oid);
+	}
+	return 0;
+}
diff --git a/list-objects-filter.h b/list-objects-filter.h
index 9e98814111..56a2d87aa0 100644
--- a/list-objects-filter.h
+++ b/list-objects-filter.h
@@ -94,4 +94,20 @@ enum list_objects_filter_result list_objects_filter__filter_object(
  */
 void list_objects_filter__free(struct filter *filter);
 
+/*
+ * Given a set of OIDs in 'in', populate 'omitted' with those that
+ * would be filtered by 'opts'. Currently only blob:limit=N is
+ * supported. Objects that cannot be read are silently skipped.
+ *
+ * NEEDSWORK: this reimplements the blob:limit size check rather than
+ * reusing the existing filter machinery. See the matching comment in
+ * list-objects-filter.c.
+ *
+ * Return 0 on success, -1 if the filter is not supported.
+ */
+int list_objects_filter__filter_oidset(struct repository *r,
+	struct list_objects_filter_options *opts,
+	const struct oidset *in,
+	struct oidset *omitted);
+
 #endif /* LIST_OBJECTS_FILTER_H */
-- 
2.54.0

