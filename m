Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A34144605C
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433353; cv=none; b=l+y3XonvyJB6sjgyEeNX+qo2e/cWzBM6MEtcCJq4gpoy3qChU+NrxVPRSZVue5j7rwwro8ok1I3R7vDtkiOW2lFFWQqta5nC31Np+KbC7f7uyU1a0RcaXkGccxlzO8ey7AzfnZzCKGek/qWyTgdmogdXhoAA0HEFc5js0Aisogg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433353; c=relaxed/simple;
	bh=73bH0MiODiQL/EeHkddlbHF9SACFGPZsjuaqPnJbIWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZQk8cVFaeAEQJpU/b6TIEjpfdfS+KT8lGskvRvU0oxPOH2Bn8/fAADGd2v89OwEHx8/WgTLdv9GDZvqKG3JyvHj8f2zZJiCOU/oLO2CuNxioZAtugjH7A9T+7TDQPK7tWu+Gae/ahpxfGDVaqrIK+AKLfwavdG5s/9/B471Sfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfNLmNgK; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfNLmNgK"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso1115829a91.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2026 10:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785433352; x=1786038152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Cg6cZdSF9f8VVfLqRonYhMdW2NhQaOydkDst5gPhxA=;
        b=PfNLmNgKEW7Y3gKfWFw9VO8Gwz7laCC2mA8DH7iA7LN+Z90chJPBXwi8TzcxWV4uoc
         3Ens3ry6vM9pQb/I7Tj60UQ9anEXd6eTB7UEtC3cGeFi+sT2jGVnd2rJnkbKdYrfAbXc
         CSoFj7k2n66u3AlvKdpeDjn6t36REW1rOukkL4BaknHg7wnjO5S1egUwmecL5AnH85OA
         aHglvz+4HT8ElSHvpHqIgpMt9+a+tu4D6afol/lXOudDaJlEwxuhZjipABU4j/7GrzII
         9hDjxhusGaQ5p5YZNk5uIqUmErS814lNqFsFLIozvTfRxK/eDv9LvNnkyKq1W73nBk25
         RREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785433352; x=1786038152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Cg6cZdSF9f8VVfLqRonYhMdW2NhQaOydkDst5gPhxA=;
        b=SS/DBmDgmzGYFGzM4AzIjXJ/czSf5aN5Wd9KQzz6j4Xxt5XFXvnecf9ifVbOJOqZ8G
         lQRJuiVu9b7l1+DhYKjvGQU0P6WqvmSG4BwGCsgEcPuMZxplIU9vyjvDSiGCTjsh7myn
         QuxXD8bT3Qmx6y+od5fg8c506pDYlRbv161QJVA5v58VchoCC7XyDit/Pg/WJJ0OzLnq
         DFOtSIZ9geLY1hFlY50ARKYlM0jKm/rbdsZn2dnTu3ry35vFlF4z7UuzzydGWA6gaPTT
         GzBQNo9i2032ng0YML7gYWq1yFosoI+l6+aAXPag85Nptpd5b3uswZ33hmrxoCgcUt0L
         DxQg==
X-Gm-Message-State: AOJu0Yz8/oGAe7PuYqOhsdy5K+3WuKVHFoUtrizOk4S1bSQi5Hb8zLZO
	wGQjQB02Lc8fKuiRGCquikgwKXElWPzylIHcmswTL6WH3i4BZqj/EBoy7i2DSg==
X-Gm-Gg: AR+sD10gakdfwaZRUX/fuXL4Ix5xHN3sV3Iqt1tUf9WCmVCBr7mECQaIMv4nbztjLV7
	owSo76mLrHFHpIRyM5F2JqI62bI7qayp53LZeW+0cAQAbau2G3f3vo/yrywr8Cc1NJh13dR4hbG
	6tox96kuGMHsaVs1hnVORJeU/215dokUtyAzsGiyOGwnmwchyBtuyAS5jZQzlzu1OwmQdUijnQa
	waHnyHMXhFi256b/cDkRQ9AbgtGMyYhtdd+JZkhuiHw76GURKGK6DZ5Os1wZBDqzcxH/MwFvk/I
	wr+g7kRxj0NVaHqSbZQbjIKANFU7efKAWlVPUTMQmJ2HI1/NT6VMYbWIAcxT7FfhI4MjxCEHli2
	HOKLXYoBVyqoCiRxQ+CwRDEOscztZBElVxrwjdM0uz9Irig8KUKjDFPuOQEFqPXJsdrePnqvyYq
	9FB2HnnWZ+1wvMTuXy34SRbr38fPh0XCI3YihWQAkUAYQFgISknIFYcgBttZvp1KM5Wb3pEzWZg
	3m0pg9Llhzes0RgjqYiklFiUJhi5wXwWL7a+FonUgm6DAqsi2Kpu9oEEmO5JWkkuoccOL3Dnhx5
	1Pe1/fTILa9E5JCCME+Sc4+iqmE=
X-Received: by 2002:a17:90b:2b50:b0:38e:4f31:8412 with SMTP id 98e67ed59e1d1-38fa6d75cd3mr1092224a91.11.1785433351600;
        Thu, 30 Jul 2026 10:42:31 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:5622:d88b:20c4:5444:d41a:b6c2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504cc9dffsm25163964eec.14.2026.07.30.10.42.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jul 2026 10:42:30 -0700 (PDT)
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
Subject: [GSoC PATCH v2 2/7] list-objects-filter: add list_objects_filter__filter_oidset()
Date: Thu, 30 Jul 2026 23:11:48 +0530
Message-ID: <20260730174153.9949-3-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
 <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
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

