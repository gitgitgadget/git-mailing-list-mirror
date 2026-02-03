Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BA6311C38
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 22:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770157118; cv=none; b=lYCbDpAfpkkvDqP/ecqfxhRRNZJkVOMlXCfLZCVQGy76OKoShlQULzIvVsFmDwqXqU95auzD9/5f/eKmWHGA54h84AQHO9NV/zJP5epCwioKRC11FVro9PmbV4ztLUWTAJWpeujhAFNLGpvBvHZ/uJfd7oiX7IUmAgzHFq/thRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770157118; c=relaxed/simple;
	bh=t3l26vnsNbByqCEVAJkax+D+jkgiGjID+yS+TC+XXQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SC7HDeYhYUukAwQg0K9C6C+Igd2dK41tyydWQ7or9yAGbz2rY/57GDaJy9h1d7Yj0JUwwke3p5kKHqVqgQCEUbTdhguJWxrBfhi4Lx2l0pOL+EaUpEcpAJyMrOpK5Pvn/TeVxT6o1jpyTwWECzeVEHCHMsaCVDA/5GypgwmZh80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2ZBWLQg; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2ZBWLQg"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4044d3ff57bso2253403fac.0
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 14:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770157115; x=1770761915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCQ0nUFz2hgH4eCvVUYJgfZS/rW2mCOkrq8RzudlYOE=;
        b=k2ZBWLQg7G/WvcaJIk52JDVwG5apc+tdvZcrUOEBY88b3Y17ktxcpS6bBbAO0lD2ac
         FIQxdN52isCDo3TrtgO1ktAxwloa/6+hjzdB8OOg4syROjUtJiQAqDe6+7DSXDlpiCYM
         xbEDXNak2omYAt5900wSjkTzjUy03DsRXvdJ/bQNb32xY/l0DYDpnXtOB340dW2237Di
         Vn43ByEjCjqB6SivFKUhXpVIXbC+lSmuCi49+VF46YqJ2aSB5lNafHommzWKgwepVLhO
         XFq4abpOyeNjuv1TIsoFGb5KkPTuNVeGZyCYsgQTIpbjUeZDp81zBBLi0w5c7WqLaq75
         CkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770157115; x=1770761915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HCQ0nUFz2hgH4eCvVUYJgfZS/rW2mCOkrq8RzudlYOE=;
        b=SCllMzeHxfaflIzM5TAPkN0vso3aQzz+WUWjENwu6QUGZfVvw01++4juT9pC+2RJ/L
         SrdzuhmxOrsWSQPFKU5q9MwW+U4j5e2hMzO89M/UtTgvskvUmUzJQz4S/c5u7Rj5eXNv
         uxfwWC9JGAfxP3KpAdaU9/PThfcRpVYzdKJCxATTuxG7z/vDJ5kXSsvpASp7yQzTp+yq
         uEueziUsesK/SDsez541oFWo0cfsI18sFa+sg+DSI98YO36gbxj9Vr4q+IJXxy/fIr8h
         ENkS+40QQuUWwVkHbHh9seqU9ZZAIB0qmNeuaGzAuoyDUS+GJSV4S4/3LiyDt2MG5e/i
         1kdA==
X-Gm-Message-State: AOJu0YydH66LcifYLhD+mtpA8nSMq0a1fEyxI45V+Naa6jgZgSgrrI/U
	vkLYoVyLJA5grIsxtegz0KHnw4sueG18tq3C2GrnW+lIJ497li+uimeFYsDARw==
X-Gm-Gg: AZuq6aIyluziqfxXMN11hJYInmt9IqTqnoaI0uMLVsBowz0wgFgmbychMgfyX6ZTH/7
	Jes3i5jhJN7u3RayYbRQ2hGKLBxAVfKZHMSkB2JrpYc97Uxl3qb016IpjZoxq2EZorgQKlRV/pw
	WOh9+if6Zlk+kcTSrzK9FtbftyHq8iYodmDf8990GT56yJhYdEkD1DRFj2Opaksp50X5zpORuOy
	QAAuMz63YsjXrrFsmDmYeOvLPXy9kqheOch/0AUu0tnAJl5ePbTw4fufuKSGgs2yeWe7/0xRR6b
	i+C6gNWGMqEt9rjxAr1EaNtwL465XYBePeUG3ZwPTC2Z5oDOXVbpj/pULt/LS9DG3XNeObNLhqC
	iwqqNEBiqVGTzBVW1rxQifhwBWshyUafIGv+5gBTROqrzlBISySZv8/he8D7AcAcIgc8QD64BkF
	gF5Bgu6uEiMQEWdMNQtKc=
X-Received: by 2002:a05:6871:73a4:b0:409:6ea8:5f7f with SMTP id 586e51a60fabf-40a53afdd42mr586685fac.20.1770157115076;
        Tue, 03 Feb 2026 14:18:35 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a53c3c4dasm479042fac.0.2026.02.03.14.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 14:18:34 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 2/5] builtin/repo: collect largest inflated objects
Date: Tue,  3 Feb 2026 16:17:55 -0600
Message-ID: <20260203221758.1164434-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260203221758.1164434-1-jltobler@gmail.com>
References: <20260203221758.1164434-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "structure" output for git-repo(1) shows the total inflated and disk
sizes of reachable objects in the repository, but doesn't show the size
of the largest individual objects. Since an individual object may be a
large contributor to the overall repository size, it is useful for users
to know the maximum size of individual objects.

While interating across objects, record the size and OID of the largest
objects encountered for each object type to provide as output. Note that
the default "table" output format only displays size information and not
the corresponding OID. In a subsequent commit, the table format is
updated to add table annotations that mention the OID.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-repo.adoc |  1 +
 builtin/repo.c              | 63 +++++++++++++++++++++++++++++++++++++
 t/t1901-repo-structure.sh   | 28 +++++++++++++++++
 3 files changed, 92 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 7d70270dfa..e812e59158 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -52,6 +52,7 @@ supported:
 * Reachable object counts categorized by type
 * Total inflated size of reachable objects by type
 * Total disk size of reachable objects by type
+* Largest reachable objects in the repository by type
 +
 The output format can be chosen through the flag `--format`. Three formats are
 supported:
diff --git a/builtin/repo.c b/builtin/repo.c
index c7c9f0f497..51a4359685 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -2,6 +2,7 @@
 
 #include "builtin.h"
 #include "environment.h"
+#include "hash.h"
 #include "hex.h"
 #include "odb.h"
 #include "parse-options.h"
@@ -197,6 +198,18 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 		return print_fields(argc, argv, repo, format);
 }
 
+struct object_data {
+	struct object_id oid;
+	size_t value;
+};
+
+struct largest_objects {
+	struct object_data tag_size;
+	struct object_data commit_size;
+	struct object_data tree_size;
+	struct object_data blob_size;
+};
+
 struct ref_stats {
 	size_t branches;
 	size_t remotes;
@@ -215,6 +228,7 @@ struct object_stats {
 	struct object_values type_counts;
 	struct object_values inflated_sizes;
 	struct object_values disk_sizes;
+	struct largest_objects largest;
 };
 
 struct repo_structure {
@@ -371,6 +385,21 @@ static void stats_table_setup_structure(struct stats_table *table,
 			      "    * %s", _("Blobs"));
 	stats_table_size_addf(table, objects->disk_sizes.tags,
 			      "    * %s", _("Tags"));
+
+	stats_table_addf(table, "");
+	stats_table_addf(table, "* %s", _("Largest objects"));
+	stats_table_addf(table, "  * %s", _("Commits"));
+	stats_table_size_addf(table, objects->largest.commit_size.value,
+			      "    * %s", _("Maximum size"));
+	stats_table_addf(table, "  * %s", _("Trees"));
+	stats_table_size_addf(table, objects->largest.tree_size.value,
+			      "    * %s", _("Maximum size"));
+	stats_table_addf(table, "  * %s", _("Blobs"));
+	stats_table_size_addf(table, objects->largest.blob_size.value,
+			      "    * %s", _("Maximum size"));
+	stats_table_addf(table, "  * %s", _("Tags"));
+	stats_table_size_addf(table, objects->largest.tag_size.value,
+			      "    * %s", _("Maximum size"));
 }
 
 static void stats_table_print_structure(const struct stats_table *table)
@@ -485,6 +514,23 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	printf("objects.tags.disk_size%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->objects.disk_sizes.tags, value_delim);
 
+	printf("objects.commits.max_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.largest.commit_size.value, value_delim);
+	printf("objects.commits.max_size_oid%c%s%c", key_delim,
+	       oid_to_hex(&stats->objects.largest.commit_size.oid), value_delim);
+	printf("objects.trees.max_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.largest.tree_size.value, value_delim);
+	printf("objects.trees.max_size_oid%c%s%c", key_delim,
+	       oid_to_hex(&stats->objects.largest.tree_size.oid), value_delim);
+	printf("objects.blobs.max_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.largest.blob_size.value, value_delim);
+	printf("objects.blobs.max_size_oid%c%s%c", key_delim,
+	       oid_to_hex(&stats->objects.largest.blob_size.oid), value_delim);
+	printf("objects.tags.max_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.largest.tag_size.value, value_delim);
+	printf("objects.tags.max_size_oid%c%s%c", key_delim,
+	       oid_to_hex(&stats->objects.largest.tag_size.oid), value_delim);
+
 	fflush(stdout);
 }
 
@@ -553,6 +599,15 @@ struct count_objects_data {
 	struct progress *progress;
 };
 
+static void check_largest(struct object_data *data, struct object_id *oid,
+			  size_t value)
+{
+	if (value > data->value) {
+		oidcpy(&data->oid, oid);
+		data->value = value;
+	}
+}
+
 static int count_objects(const char *path UNUSED, struct oid_array *oids,
 			 enum object_type type, void *cb_data)
 {
@@ -578,21 +633,29 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 			stats->type_counts.tags++;
 			stats->inflated_sizes.tags += inflated;
 			stats->disk_sizes.tags += disk;
+			check_largest(&stats->largest.tag_size, &oids->oid[i],
+				      inflated);
 			break;
 		case OBJ_COMMIT:
 			stats->type_counts.commits++;
 			stats->inflated_sizes.commits += inflated;
 			stats->disk_sizes.commits += disk;
+			check_largest(&stats->largest.commit_size, &oids->oid[i],
+				      inflated);
 			break;
 		case OBJ_TREE:
 			stats->type_counts.trees++;
 			stats->inflated_sizes.trees += inflated;
 			stats->disk_sizes.trees += disk;
+			check_largest(&stats->largest.tree_size, &oids->oid[i],
+				      inflated);
 			break;
 		case OBJ_BLOB:
 			stats->type_counts.blobs++;
 			stats->inflated_sizes.blobs += inflated;
 			stats->disk_sizes.blobs += disk;
+			check_largest(&stats->largest.blob_size, &oids->oid[i],
+				      inflated);
 			break;
 		default:
 			BUG("invalid object type");
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 17ff164b05..1999f325d0 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -52,6 +52,16 @@ test_expect_success 'empty repository' '
 		|     * Trees          |    0 B |
 		|     * Blobs          |    0 B |
 		|     * Tags           |    0 B |
+		|                      |        |
+		| * Largest objects    |        |
+		|   * Commits          |        |
+		|     * Maximum size   |    0 B |
+		|   * Trees            |        |
+		|     * Maximum size   |    0 B |
+		|   * Blobs            |        |
+		|     * Maximum size   |    0 B |
+		|   * Tags             |        |
+		|     * Maximum size   |    0 B |
 		EOF
 
 		git repo structure >out 2>err &&
@@ -104,6 +114,16 @@ test_expect_success SHA1 'repository with references and objects' '
 		|     * Trees          | $(object_type_disk_usage tree true) |
 		|     * Blobs          |  $(object_type_disk_usage blob true) |
 		|     * Tags           |    $(object_type_disk_usage tag) B   |
+		|                      |            |
+		| * Largest objects    |            |
+		|   * Commits          |            |
+		|     * Maximum size   |    223 B   |
+		|   * Trees            |            |
+		|     * Maximum size   |  32.29 KiB |
+		|   * Blobs            |            |
+		|     * Maximum size   |     13 B   |
+		|   * Tags             |            |
+		|     * Maximum size   |    132 B   |
 		EOF
 
 		git repo structure >out 2>err &&
@@ -138,6 +158,14 @@ test_expect_success SHA1 'keyvalue and nul format' '
 		objects.trees.disk_size=$(object_type_disk_usage tree)
 		objects.blobs.disk_size=$(object_type_disk_usage blob)
 		objects.tags.disk_size=$(object_type_disk_usage tag)
+		objects.commits.max_size=221
+		objects.commits.max_size_oid=de3508174b5c2ace6993da67cae9be9069e2df39
+		objects.trees.max_size=1335
+		objects.trees.max_size_oid=09931deea9d81ec21300d3e13c74412f32eacec5
+		objects.blobs.max_size=11
+		objects.blobs.max_size_oid=eaeeedced46482bd4281fda5a5f05ce24854151f
+		objects.tags.max_size=132
+		objects.tags.max_size_oid=1ee0f2b16ea37d895dbe9dbd76cd2ac70446176c
 		EOF
 
 		git repo structure --format=keyvalue >out 2>err &&
-- 
2.53.0

