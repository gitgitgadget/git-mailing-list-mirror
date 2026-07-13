Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A2113B5B3
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 01:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783905118; cv=none; b=hqTW3asfL7zJ5TAVfeNllBlhi4lUiKuxrfp1lMdI5QN6QxO2w9iUR04/HADz2q6VHNBi45+Jq8+Up+iLRxm1A5SmgJRNecBwccZcx4aappFA+K9hP3j7qaQgkk4sRG325NKH8lX+YDVILDuSXRLWU7cFTzQcYZ0xvnXF3NAyzFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783905118; c=relaxed/simple;
	bh=kk5AZ+xfEy/VmM/D4FJUjEt2YaDI6OswBqbf+sBfd3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iebC6CnHBegoxCjW1DwY5vy7oMOFy4jXl4yPCAY9ETpDHDYj2jNUdf4yI0MceH5ZbS1nSx8t8qWMwodloE7h1DV3cykUIQeiRABXlvM3SkurR8kjcOUtivTRKED0lmUa6oVcaK8Gb3EthuIewfHvB81MqH82o3RlRSyueU0nQmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=C78/8Wwn; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="C78/8Wwn"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-809b19a7f25so32516417b3.3
        for <git@vger.kernel.org>; Sun, 12 Jul 2026 18:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783905116; x=1784509916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=487VG6fZhHK/F7imib2P5aU06RFEniuC8U+9xQZueKk=;
        b=C78/8WwnC9V/cy2NSD95H0kFTO8WnNSWUvtnvnWGpnZEwrpmQwG/fWXKeVa4j5yeq3
         EA1Nxg8yKg8+jLzGxvbTto+SDC0zHAKzRbOnAPngbT/N+E6ld6nbafDjE+gPvbSIn+GY
         GRFyvo3qLQFwnok/Ct2k8Lu8Os81n6SOXPON0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783905116; x=1784509916;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=487VG6fZhHK/F7imib2P5aU06RFEniuC8U+9xQZueKk=;
        b=YdVvFeUIRWSk4T/HHe2KJkJozwDhB9BzQHMsxCLVgzGzaM2JkgBbt1TWzuWQq/PNq9
         8Q62zEAjwLnzFb4rJmMGCrU6x7XtpGpfag3sQvxpm+HLe4nyR/fGmwRQW2uaHk5lAHHt
         fZtPHjamZWQ2yQX1FKHEoxuWE/guATgdWcLpLqA/Nvu42nSOUnLRnnHM0xGGOjkpQZMM
         CLYJJYPWq7M4z6RXzaPPfutOoha9Qf6dtmNJ05DT1I/DRi1d/EgCoYjYHJYjCFJ+lsHH
         3ru0zR6K+FCyGqyKZlcQVJ61I9yN/VL5YMl/K6DnqNnM328HQroUxRyLWwNH5MHdy350
         WyQQ==
X-Gm-Message-State: AOJu0YxSaBRo5vLci/8n355eVpN1zSey+c1fEr2drkm8/Sss1lJ9txah
	TrP05rDJqTKGVAxzCf97TN0V82qSsnxlg0s/Q6J1x9v91JA/C67naSOljYoan6XPmKnVFAe+KrF
	v11PRFOXheQ==
X-Gm-Gg: AfdE7cnfq9OhJ36CE90BWC0vnWHSuAj06N8DbLvbw2NSeMxdJ0ztnKsZuM4ixYSrGQ2
	HTlNMVrNpIhpeUrHle/DZJ7A3k7ZB0cgi9/yloBWz6iixMHu9Vx+JXrd578f6tsmqPODLWWt1Op
	Szvvuoojyi+temeDVQfnI5HyaqExc0io9TnQrwieZ13KeCf9OS2ShaH1NJEgRSNG7XAwB3CJM6n
	nUHeLHb1Qv3LiOETBuXj3FqtQHUSUsLhuk44/xk+jlBpCWaiVmB1bTc2PzwjR5lQNcDCq/Ob1TL
	bKqfaaXrhtYv3MbpH8bjhW6cjsNvM6QHkxF2To5c8l/tsGq2I0+t3vpyOYIBIZMrlv57Anvb2hF
	HwhBV4JntbmizTtzOdrDsVrn2ayJWOEaZxyA0KX6nS22HVEcc6Nl36FXhRtGlzevMDB2ZhHnprp
	VyikU+IHZSX2YXMHpMnQO9yg==
X-Received: by 2002:a05:690c:d90:b0:81e:77e4:e77e with SMTP id 00721157ae682-81e902eb311mr50069017b3.70.1783905116034;
        Sun, 12 Jul 2026 18:11:56 -0700 (PDT)
Received: from com-79390 ([12.187.141.7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c1e5706sm102812857b3.34.2026.07.12.18.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 18:11:55 -0700 (PDT)
Date: Sun, 12 Jul 2026 18:11:53 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] t/helper: teach pack-deltas to list delta entries
Message-ID: <alQ7WKITYDXfiVn9@com-79390>
References: <cover.1783905084.git.ttaylorr@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1783905084.git.ttaylorr@openai.com>

In the following commit(s), some tests will need to distinguish between
`REF_DELTA`s and `OFS_DELTA`s to exercise a new '--no-ref-delta' option
for 'pack-objects'.

Existing tools report delta relationships, but not how their bases are
represented in the pack.

Teach 'test-tool pack-deltas' a '--list-deltas' mode. For each delta
entry, print the object ID, its REF_DELTA or OFS_DELTA type, and the
base object ID or pack offset, respectively. This lets tests inspect
pack headers without open-coding a parser.

Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
 t/helper/test-pack-deltas.c | 69 +++++++++++++++++++++++++++++++++++++
 t/t5300-pack-object.sh      |  8 +++--
 2 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-pack-deltas.c b/t/helper/test-pack-deltas.c
index 840797cf0d..4ba6fe2dd3 100644
--- a/t/helper/test-pack-deltas.c
+++ b/t/helper/test-pack-deltas.c
@@ -7,6 +7,7 @@
 #include "hash.h"
 #include "hex.h"
 #include "pack.h"
+#include "packfile.h"
 #include "pack-objects.h"
 #include "parse-options.h"
 #include "setup.h"
@@ -15,6 +16,7 @@
 
 static const char *usage_str[] = {
 	"test-tool pack-deltas --num-objects <num-objects>",
+	"test-tool pack-deltas --list-deltas <pack>.idx",
 	NULL
 };
 
@@ -80,19 +82,86 @@ static void write_ref_delta(struct hashfile *f,
 	free(delta_buf);
 }
 
+static int list_delta(const struct object_id *oid,
+		      struct packed_git *p,
+		      uint32_t pos,
+		      void *_w_curs)
+{
+	struct pack_window **w_curs = _w_curs;
+	off_t obj_offset = nth_packed_object_offset(p, pos);
+	off_t cur = obj_offset;
+	size_t size;
+	enum object_type type = unpack_object_header(p, w_curs, &cur,
+						      &size);
+
+	if (type < 0)
+		die("unable to parse object at position %"PRIu32, pos);
+	if (type != OBJ_REF_DELTA && type != OBJ_OFS_DELTA)
+		return 0;
+
+	if (type == OBJ_REF_DELTA) {
+		struct object_id base_oid;
+		const unsigned char *base = use_pack(p, w_curs, cur,
+						     NULL);
+
+		oidread(&base_oid, base, p->repo->hash_algo);
+		printf("%s REF_DELTA %s\n", oid_to_hex(oid),
+		       oid_to_hex(&base_oid));
+	} else {
+		off_t base_offset = get_delta_base(p, w_curs, &cur,
+						   type, obj_offset);
+
+		if (!base_offset)
+			die("unable to read base of object %s", oid_to_hex(oid));
+		printf("%s OFS_DELTA %"PRIuMAX"\n", oid_to_hex(oid),
+		       (uintmax_t)base_offset);
+	}
+
+	return 0;
+}
+
+static void list_deltas(const char *idx_name)
+{
+	struct packed_git *p;
+	struct pack_window *w_curs = NULL;
+
+	p = add_packed_git(the_repository, idx_name, strlen(idx_name), 1);
+	if (!p || open_pack_index(p))
+		die("unable to open pack index %s", idx_name);
+
+	if (for_each_object_in_pack(p, list_delta, &w_curs,
+				    ODB_FOR_EACH_OBJECT_PACK_ORDER))
+		die("unable to iterate over objects in %s", idx_name);
+
+	unuse_pack(&w_curs);
+	close_pack(p);
+	free(p);
+}
+
 int cmd__pack_deltas(int argc, const char **argv)
 {
 	int num_objects = -1;
+	int list_deltas_mode = 0;
 	struct hashfile *f;
 	struct strbuf line = STRBUF_INIT;
 	struct option options[] = {
 		OPT_INTEGER('n', "num-objects", &num_objects, N_("the number of objects to write")),
+		OPT_BOOL(0, "list-deltas", &list_deltas_mode,
+			 N_("list REF_DELTA and OFS_DELTA entries")),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, NULL,
 			     options, usage_str, 0);
 
+	if (list_deltas_mode) {
+		if (argc != 1 || num_objects >= 0)
+			usage_with_options(usage_str, options);
+		setup_git_directory(the_repository);
+		list_deltas(argv[0]);
+		return 0;
+	}
+
 	if (argc || num_objects < 0)
 		usage_with_options(usage_str, options);
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 73445782e7..4bee490ff6 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -190,7 +190,9 @@ test_expect_success 'unpack without delta (core.fsyncmethod=batch)' '
 
 test_expect_success 'pack with REF_DELTA' '
 	packname_2=$(git pack-objects --progress test-2 <obj-list 2>stderr) &&
-	check_deltas stderr -gt 0
+	check_deltas stderr -gt 0 &&
+	test-tool pack-deltas --list-deltas test-2-$packname_2.idx >deltas &&
+	test_grep " REF_DELTA " deltas
 '
 
 test_expect_success 'unpack with REF_DELTA' '
@@ -204,7 +206,9 @@ test_expect_success 'unpack with REF_DELTA (core.fsyncmethod=batch)' '
 test_expect_success 'pack with OFS_DELTA' '
 	packname_3=$(git pack-objects --progress --delta-base-offset test-3 \
 			<obj-list 2>stderr) &&
-	check_deltas stderr -gt 0
+	check_deltas stderr -gt 0 &&
+	test-tool pack-deltas --list-deltas test-3-$packname_3.idx >deltas &&
+	test_grep " OFS_DELTA " deltas
 '
 
 test_expect_success 'unpack with OFS_DELTA' '
-- 
2.55.0

