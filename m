Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70DB18E36E
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935368; cv=none; b=F+BhsYtM0RBV8aA3/MZhvM/L61eSZpxp0VuygW6UnkgS3Ki/7D4TVvoFQraLwEeOyFxtIgH9GsM9qMSJLlSozV6AppQ91apqNrc1ZbJB5Bic9O9OQHOPQ1Y9Nr9nqITySdjb1xE083uOmM3lTiv07mY+aGJgV01owTAIpAAratc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935368; c=relaxed/simple;
	bh=m4MLzlye2TCdFcxQ5yXjI9cu8FgC9uqy1O7ylsOZ7E4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fY3shDNHx9xBpWd8sZl5ID32Z8JJb3NrDf1TonkBgplcdu3v6NxZgKA6l2i/rX4qlenFkd1p9E/nEoQugSkIbG1vTJPLWDnAUOZk7vIWHLVuyerk4y7mrWELmoY07S9zLFcPxlhoeZJfSa0pC/ZhW5zUOb4a+iE3xsMEM3BXnss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dt5n9PWX; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dt5n9PWX"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d56155f51so20067566b.2
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935364; x=1726540164; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RthP71xYYsrFkCGp0OJL2Lstp0libMEfFDTaMFMxoWQ=;
        b=dt5n9PWXCEUeyaHuRVPQ+UFHCCXjB45JwnMS9ndlWrYGhpbvYfoLPP9/AHoV0iiYX2
         pLAxOKg+j63XYmP5a7iWFxJhfCkC83c45726fI9I10p5iolRo8mmUE/F8HI8ETKAeIQ9
         4GOqFMy2AGHAnIe2lItHW3DWkTlEvLredA+JKIr6S5jMJrBffkMezFgYnShFRNBsNO4y
         4Z+gVNstMy+Q+iouI9eKiFLevBt+8U4IOGgoqq6YUH2jb5Ir6XuUIAIt+l7kGXqTOlbh
         PAFPr6vP9ZeX8hlnA0ggVDupF+DzORFI8UbyzXL+lv3KsoLNR5vAHM4FCq9VcvNgC+zQ
         22rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935364; x=1726540164;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RthP71xYYsrFkCGp0OJL2Lstp0libMEfFDTaMFMxoWQ=;
        b=Stgmj4jmYrYXS4cL8WN6+7vo10Ipy35B0onWYbcJC/7iUZx88cCalUB8pBaHWLiqzB
         d2OaeENXjOKbn//HXh6y/4D+qRe02OckalxAZJkgasp6QVki5aP3MHwn0e6wQ6TY56sK
         d4F3HL/2q/vJfjiu9OIdFsm1lwRU/L2vItRvY8pgupnOQoJvaxEK5Hev/qgfa3QhkApk
         teZcykDMtYTBnJldUXT6roq17+TMx+0+vYwMiNdQ2zkQHzf0PQ9Ji9HFbYeeWOWF018B
         NFeBJDqCPNaCE6WcEsEGsLvRpBJKWpNy0GtZFOIk1DPa/oOm6XUQ3KX2duJvh15KrYtg
         OvOQ==
X-Gm-Message-State: AOJu0YzRl1dmMtpttpPj3AcRccaTXJJyWsoZcdm1hBHOQ+CemIIwUV62
	ipsUYmcxsK6kPfDwhhUzROagdN9y9k6GczlyuH+0PFHmNuHR9K1kHy/zlQ==
X-Google-Smtp-Source: AGHT+IFSnl45fi6DQTSgP/TDnnv77vEVngJUWqC+rprlJRKQ+cLSffCR/hT9OgVK3b7ZNYNp8m42BQ==
X-Received: by 2002:a17:907:60d4:b0:a8d:64af:dc2a with SMTP id a640c23a62f3a-a8d64afdcafmr334682566b.25.1725935364290;
        Mon, 09 Sep 2024 19:29:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ced18csm412235866b.161.2024.09.09.19.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:23 -0700 (PDT)
Message-Id: <460feef90fdd869b42e3663a1a1336a8ae663bc0.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:55 +0000
Subject: [PATCH 30/30] pack-objects: output debug info about deltas
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

In order to debug what is going on during delta calculations, add a
--debug-file=<file> option to 'git pack-objects'. This leads to sending
a JSON-formatted description of the delta information to that file.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c | 69 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5d5a57e6b1f..7d1dd5a6557 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -50,6 +50,9 @@
  */
 static struct packing_data to_pack;
 
+static FILE *delta_file;
+static int delta_file_nr;
+
 static inline struct object_entry *oe_delta(
 		const struct packing_data *pack,
 		const struct object_entry *e)
@@ -516,6 +519,14 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 	hdrlen = encode_in_pack_object_header(header, sizeof(header),
 					      type, size);
 
+	if (delta_file) {
+		if (delta_file_nr++)
+			fprintf(delta_file, ",\n");
+		fprintf(delta_file, "\t\t{\n");
+		fprintf(delta_file, "\t\t\t\"oid\" : \"%s\",\n", oid_to_hex(&entry->idx.oid));
+		fprintf(delta_file, "\t\t\t\"size\" : %"PRIuMAX",\n", datalen);
+	}
+
 	if (type == OBJ_OFS_DELTA) {
 		/*
 		 * Deltas with relative base contain an additional
@@ -536,6 +547,11 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 		hashwrite(f, header, hdrlen);
 		hashwrite(f, dheader + pos, sizeof(dheader) - pos);
 		hdrlen += sizeof(dheader) - pos;
+		if (delta_file) {
+			fprintf(delta_file, "\t\t\t\"delta_type\" : \"OFS\",\n");
+			fprintf(delta_file, "\t\t\t\"offset\" : %"PRIuMAX",\n", ofs);
+			fprintf(delta_file, "\t\t\t\"delta_base\" : \"%s\",\n", oid_to_hex(&DELTA(entry)->idx.oid));
+		}
 	} else if (type == OBJ_REF_DELTA) {
 		/*
 		 * Deltas with a base reference contain
@@ -550,6 +566,10 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 		hashwrite(f, header, hdrlen);
 		hashwrite(f, DELTA(entry)->idx.oid.hash, hashsz);
 		hdrlen += hashsz;
+		if (delta_file) {
+			fprintf(delta_file, "\t\t\t\"delta_type\" : \"REF\",\n");
+			fprintf(delta_file, "\t\t\t\"delta_base\" : \"%s\",\n", oid_to_hex(&DELTA(entry)->idx.oid));
+		}
 	} else {
 		if (limit && hdrlen + datalen + hashsz >= limit) {
 			if (st)
@@ -559,6 +579,10 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 		}
 		hashwrite(f, header, hdrlen);
 	}
+
+	if (delta_file)
+		fprintf(delta_file, "\t\t\t\"reused\" : false\n\t\t}");
+
 	if (st) {
 		datalen = write_large_blob_data(st, f, &entry->idx.oid);
 		close_istream(st);
@@ -619,6 +643,14 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 		return write_no_reuse_object(f, entry, limit, usable_delta);
 	}
 
+	if (delta_file) {
+		if (delta_file_nr++)
+			fprintf(delta_file, ",\n");
+		fprintf(delta_file, "\t\t{\n");
+		fprintf(delta_file, "\t\t\t\"oid\" : \"%s\",\n", oid_to_hex(&entry->idx.oid));
+		fprintf(delta_file, "\t\t\t\"size\" : %"PRIuMAX",\n", entry_size);
+	}
+
 	if (type == OBJ_OFS_DELTA) {
 		off_t ofs = entry->idx.offset - DELTA(entry)->idx.offset;
 		unsigned pos = sizeof(dheader) - 1;
@@ -633,6 +665,12 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 		hashwrite(f, dheader + pos, sizeof(dheader) - pos);
 		hdrlen += sizeof(dheader) - pos;
 		reused_delta++;
+
+		if (delta_file) {
+			fprintf(delta_file, "\t\t\t\"delta_type\" : \"OFS\",\n");
+			fprintf(delta_file, "\t\t\t\"offset\" : %"PRIuMAX",\n", ofs);
+			fprintf(delta_file, "\t\t\t\"delta_base\" : \"%s\",\n", oid_to_hex(&DELTA(entry)->idx.oid));
+		}
 	} else if (type == OBJ_REF_DELTA) {
 		if (limit && hdrlen + hashsz + datalen + hashsz >= limit) {
 			unuse_pack(&w_curs);
@@ -642,6 +680,10 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 		hashwrite(f, DELTA(entry)->idx.oid.hash, hashsz);
 		hdrlen += hashsz;
 		reused_delta++;
+		if (delta_file) {
+			fprintf(delta_file, "\t\t\t\"delta_type\" : \"REF\",\n");
+			fprintf(delta_file, "\t\t\t\"delta_base\" : \"%s\",\n", oid_to_hex(&DELTA(entry)->idx.oid));
+		}
 	} else {
 		if (limit && hdrlen + datalen + hashsz >= limit) {
 			unuse_pack(&w_curs);
@@ -652,6 +694,10 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 	copy_pack_data(f, p, &w_curs, offset, datalen);
 	unuse_pack(&w_curs);
 	reused++;
+
+	if (delta_file)
+		fprintf(delta_file, "\t\t\t\"reused\" : true\n\t\t}");
+
 	return hdrlen + datalen;
 }
 
@@ -1264,6 +1310,11 @@ static void write_pack_file(void)
 	ALLOC_ARRAY(written_list, to_pack.nr_objects);
 	write_order = compute_write_order();
 
+	if (delta_file) {
+		fprintf(delta_file, "{\n\t\"num_objects\" : %"PRIu32",\n", to_pack.nr_objects);
+		fprintf(delta_file, "\t\"objects\" : [\n");
+	}
+
 	do {
 		unsigned char hash[GIT_MAX_RAWSZ];
 		char *pack_tmp_name = NULL;
@@ -1412,6 +1463,9 @@ static void write_pack_file(void)
 		    written, nr_result);
 	trace2_data_intmax("pack-objects", the_repository,
 			   "write_pack_file/wrote", nr_result);
+
+	if (delta_file)
+		fprintf(delta_file, "\n\t]\n}");
 }
 
 static int no_try_delta(const char *path)
@@ -4430,6 +4484,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	struct list_objects_filter_options filter_options =
 		LIST_OBJECTS_FILTER_INIT;
+	const char *delta_file_name = NULL;
 
 	struct option pack_objects_options[] = {
 		OPT_CALLBACK_F('q', "quiet", &progress, NULL,
@@ -4536,6 +4591,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 				N_("exclude any configured uploadpack.blobpackfileuri with this protocol")),
 		OPT_BOOL(0, "full-name-hash", &use_full_name_hash,
 			 N_("optimize delta compression across identical path names over time")),
+		OPT_STRING(0, "delta-file", &delta_file_name,
+				N_("filename"),
+				N_("output delta compression details to the given file")),
 		OPT_END(),
 	};
 
@@ -4573,6 +4631,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (pack_to_stdout != !base_name || argc)
 		usage_with_options(pack_usage, pack_objects_options);
 
+	if (delta_file_name) {
+		delta_file = fopen(delta_file_name, "w");
+		if (!delta_file)
+			die_errno("failed to open '%s'", delta_file_name);
+		trace2_printf("opened '%s' for writing deltas", delta_file_name);
+	}
 	if (depth < 0)
 		depth = 0;
 	if (depth >= (1 << OE_DEPTH_BITS)) {
@@ -4796,5 +4860,10 @@ cleanup:
 	list_objects_filter_release(&filter_options);
 	strvec_clear(&rp);
 
+	if (delta_file) {
+		fflush(delta_file);
+		fclose(delta_file);
+	}
+
 	return 0;
 }
-- 
gitgitgadget
