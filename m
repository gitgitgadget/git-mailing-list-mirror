Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDA8431A5B
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786383679; cv=none; b=oluCuWtky4ouPDq6JRNdzwTuQ+y1CYCRHNiay/PqBae3VSpHGwRApwJCk/C/dHVyH1zkx0nDSp2FFdP5GHFG0And1J2JXjq3L4yCWZvsFFgA+L7zAzfZ6gJKTboRBo0tH48HUJ+lBXHXCmMKdzHJIGRVnx6ZBsfrWn3VWWC4WZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786383679; c=relaxed/simple;
	bh=73bH0MiODiQL/EeHkddlbHF9SACFGPZsjuaqPnJbIWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQac01ToomQ83g9yL0NKfa6+20zin4IDl8u6zY2Xwe9nFsPtAamSiAmhzMVit4BbxO6gIbDwkBEvhFFHkclJPEr0EoJ0QQhb/VkEVodGTRKsd7r+6h9IapeOQ82USH5mhBnDy/G2/JIp1PXUDkkOcvmgrvAAQV/CeWGGFDJB19g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIh6aC8N; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIh6aC8N"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ca80d708489so105812a12.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 10:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786383677; x=1786988477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Cg6cZdSF9f8VVfLqRonYhMdW2NhQaOydkDst5gPhxA=;
        b=hIh6aC8NdBW2ddHad7YikFyMdQaPqyco4lgpVtblskV97FEN8/kP3ob88PatNFZHqs
         ygkZrur5oe/PITmOPI4SBPZNvCfD0nGM39zDREecX+Chg115H3YCjCvDWxPVIuhTqR2N
         ttGiuKrJwKY8a3ahKXmqRoxNuf6N7QoouA7bRfAt/gF+jZLCnUZuqxJL10iy5KM7GTKP
         JQVUlcL++sDax3yXfkCg8sdRehdeFgigN3kNE0rvRPaNcF8U9oik4mfSj8eyf3gepw/w
         XoBvTBpwpu13LtHmlHDNhJFMPgBo/oV8S5Lx8Ua0zchIF97DbTM0PS+2nWPqBc8j671/
         AHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786383677; x=1786988477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Cg6cZdSF9f8VVfLqRonYhMdW2NhQaOydkDst5gPhxA=;
        b=H6Ky1EgroWZl7GnYAd4PkU03qch7fcZ2sMA9q7cQ7pqr/XiMyaUvqIzUcD/7sZ8TMw
         bK1dBzgZg7bSTKu9QvkSwAHAxQr2nP4Mt1vWS/8dzVoHqQZX4Eskrze0JBJYXKePq/Kh
         FxaEbH7lI7/ffCr5vNimwVVOAuQioEtAwdLVCH7jwX4NxGBPxgDcRg0tBfWtvnw3O8PV
         iiUYx0eJ+S5jgL60l8DNrQ15gsXgU4BQiUEIgdBmez+DQd7bq+aTNQGx+eeRZUA47flT
         X9DJNOiBdoiGbVLpJ7eDDL6goIptDdAbs2JyqNksEFb+cMqcPYrvnZG4DaalqwKzpLgj
         4uTQ==
X-Gm-Message-State: AOJu0YyxHCbdBxFcgr3yeHHEFRHIfSCWvaC//rAiTGQ8YoYXFyQmjAEA
	GSLfJHayo0aZUUEVFe8lC1WLqz5gOmZNNjUQmqHbJ4h0df8jIDVu6PGUSudOksUt
X-Gm-Gg: AR+sD10EvPO+LNodOF8tfeVE/6kFqP/mYhwMmX87u8iV388txtOEa7p8T+MX5MwU9N4
	2ku7urCiDuuuu6X7cBem/TeqE2ZVXiEkRRfID8Uu+n0C98qUcmtf7gj0C3QTwHgcL0YQRke86aw
	7qYW2VE0qyCt9JfkgGsNdFzctBPEsxnPjD5gsxk0s62NhWzwQ/w0XNbXmqcQGJr75Uj0m1OVHCk
	i4vrblmjGXX27ms543hvjBOyoihv6kZrhXElzJOrU54KFdHS9XwSqsEkI0Id0bogYyKyHgIUmDS
	qKCh2NS95nikTIbAcJkqHK5e2rgKIgb5g10kPs2VWVzmM2W2cuBC6tX8fSYGUPFn3HvLCYvdt6F
	42CjEtvzuZ9DLA3N9Co5PHr2xZ9pP2m+Gl0oRkQ8/LoKIQCj6QGFuQUv/3g6258fpB2pbS9mNwz
	Zs/Z44i7w61nkVfk5oxxFOO0fXqBTQ3JfcriPYdNxY9d/IHV1eWpzRdVChBwNIObHvvKQL49EHY
	BqrG7rA9+UMCaUf8EfzvK0AH3kQyTAW65jtynoXP0NXNr00x12nDQcSOM1TSpodRtueLjGAp0/K
	bT03J94E/SGm/5tQD8Wjmw==
X-Received: by 2002:a05:6a20:c996:b0:3c3:80bc:1540 with SMTP id adf61e73a8af0-3cc22d6e107mr191885637.3.1786383677333;
        Mon, 10 Aug 2026 10:41:17 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:5026:8db8:20aa:c615:9a47:206a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14101b7b39bsm36865585c88.14.2026.08.10.10.41.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Aug 2026 10:41:16 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	ttaylorr@openai.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [GSoC PATCH v4 2/7] list-objects-filter: add list_objects_filter__filter_oidset()
Date: Mon, 10 Aug 2026 23:10:42 +0530
Message-ID: <20260810174047.6524-3-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
References: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
 <20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
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

