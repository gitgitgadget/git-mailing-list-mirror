Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A842946D2C3
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268320; cv=none; b=K57uTj7TbqUl+FSvet1h8loaNql6gM8/usxLTXc0uVU28GEWjPeS4eHyCgXEVPnxA0RvQQhX5QnNMgaDy7EDeKN616++ZrV6LMWvMe+zfJIppoyJaD++fBcKe5xaDrY6IAxP03xVQcoqQjdG0H266iRpyMGy8HuPBZWRkV37kK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268320; c=relaxed/simple;
	bh=uBQIQ+pFWj15YDsGwpR9MnTkjZsRdIezTLZnMJbvwSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxnAYnjih+5e+yWlwHkqX/Aco9scFTwlVB9MRYfWnNzo5e+HBzfUkAzLGVTSkeOybcJgmE99z4MHDzyxCQrIcumP0soEtmsN1pnc8g6tQ4xXuYCCC2gQQLwe6ivTOwHtL39/ViDzAlnpb9tid0fYMjh89P0fQ+tD1ujeebJcafI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=FfK/lq3l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zkwm8aQm; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="FfK/lq3l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zkwm8aQm"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id D56E4138027F;
	Thu, 24 Sep 2026 12:45:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 24 Sep 2026 12:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1790268316; x=
	1790271916; bh=xXBbJi1uIln/SfHOX9cOUvnevFtUe3sFZYgjVg5H1A8=; b=F
	fK/lq3lvA1UwFQqTlxxE96cvFobXI7I/FINqh+EuHaDLA+XgbMQpkwzp+JjP3iEj
	UHUKjPWOZfZYWfGibdbt+zbO/twcO0LQunCf7m/bEo7/XizuvRtZMI1xcuSx2hXc
	MPLtWQ9VQa4pQ/VCXpg6F3PS76bX4j6izYtNz42QLdeusBaIazN06eiHl3AVLRv9
	h11ovjGt+7AJWG8hgaQ4IHWFCWY8VIB/2p4Og0uGaX3nRqzIRikG85X8alOYAlQo
	JPn9B3vFXj/86NckXK1dHZ+d6Rl9RNQKzaqMKHoIHv9V38w3Jm1S2d/yIpk48kLv
	vExqvB7Bgmq3vMZ7V0pmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790268316; x=1790271916; bh=x
	XBbJi1uIln/SfHOX9cOUvnevFtUe3sFZYgjVg5H1A8=; b=Zkwm8aQm5EYv4ttCK
	9l+n5woMOlA5vfu5p+yDUkYTBlyQ/wHXe2D0qWC+Hz5Ybsov+dbyP4HHytECFurg
	qPNgmBiin+L3pkTpwPH/tB/LZAVjl2CFE7+chSIgRjEex0/SwOJZMubwKYgZRr5x
	FbJefR/H5Xw9YWJXPiv8xt8KpEUmL+YnIXUV54elick5+1ixvRO+DcQahI8jHsG9
	djbLXN1/XtdUNdFIsv1nbXcKf8Fr7BHyFriNlnfHgXABebFIqXjvWvJT6WxPXYl0
	Oz+VkpK/T9h41dYCw5ANMeGdrMtzYI4nj3Qa2HFVhsWYqxpnLxsVaCk080v5gptp
	pFF+w==
X-ME-Sender: <xms:nFO1ameR7wRCdyFIkJt3FerNebNp_ClYLyPffmGM1n9PTs2P9pygDQ>
    <xme:nFO1anpqaWU8kj5D20yHvz8MReDJI2l-_KRD_UkKXdER71wbi7Imbqf4x1C7ZtZYY
    X4CTk3u4mxwA0wtdsVEn4kPko1SHSRW3AYRwYxP8tdvMNFMDjpk-_6Y>
X-ME-Received: <xmr:nFO1ak76gQwZDcIAnFDIVo7WasVPQhqmyyxqQDyuwzh31ah0_7a9RbXNZ6onxRl7VH3r3qIIDQFFfRpI3S_hbiW_5c22yIru_osQmSwfvRJF>
X-ME-Proxy-Cause: dmFkZTEW4LD9FU/40iGuYFn42hDNpfrVxWJ+pLgvltjL5+EqGBT+wjvnvOPt5Xt2QkxR7v
    EHLLnxlC1MlCSXV4YxzWZoZ9/jdTON2OTTRf4k/RUDWO4+C5Ot8yx4lMcCa97SbtfeMlgo
    YP4eFBg+e8X5JpndM0TXcEzg8wrQ9anbDQPNQaWbaYWi7OUmWfYiubM1mVACr16ZQxYvdO
    O10w7loGWMkInrpAj79tRLXz1jO3ap5mmDc1Z+tCM8iVvtbFK6AxCtB0H0UmM7e6c5cpST
    ga0zhvVe2/YccbqFLuLLFxz1e4xGtrQY+WHUsERjn78IVrtXN6BqG0GtVeI/0nEGeRQgZz
    Eyl4EAuaXQdhiCWTzuj0sxzJljOp5xNrAAkqW7YypQrEMPVQ3nYhGoO5dOJuC+Ma6GTJoK
    GiQ6iqB0RYYShar1nYaadeEDTrdHWKtDz9apX6CuX0tWzeiZ9RPByNF9ZVFU6gEWCYqcMM
    ZnXcd9ltNfl0ZoXIYTlUTDba6BjiHjxnyt7FMDTswX5YtI746Y4GZr9T+sJaelTkuwHRIE
    NwuHUA6wJ8EphHI8kjgZwGYkPnHa8ZHlXvoWjekIahpPlRvnZJ7htZJ6gU5hL4aI+oCVkY
    WQzGGcMtub5q/yreGODLoBo61cHraoFo/i2Tg45umN1LbjSoaUNf7WG4EyMQ
X-ME-Proxy: <xmx:nFO1atoq7GaLpH7g9Xyxc3Wijk1vIPsKyJQhD6imtYaMdtW6IIFyOQ>
    <xmx:nFO1amiWZ_gepVIJ0I7iaEKakXje_P4LoIoi81AKfnXV4vit2hV_7Q>
    <xmx:nFO1anL7rbcCUDeMplA3kzOxgnTYUtqfKuytwNC8kVxklzQC3iVBnQ>
    <xmx:nFO1amCF55ua1xg8OpduNBHEfowGNOsOSovzoBmZ-htDtL8FXBVQ5g>
    <xmx:nFO1avfdgU6fJ6PkCeLCjibw79N7oxCRCz3xjYi-2eXEUSMPErI03jaj>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 12:45:15 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH 1/1] repo: add filtering options to "repo structure"
Date: Thu, 24 Sep 2026 12:45:03 -0400
Message-ID: <20260924164503.119506-2-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924164503.119506-1-markchucarroll@fastmail.com>
References: <20260924164503.119506-1-markchucarroll@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"git repo structure" provides a collection of useful information
about the information stored in a repo. In particular, it's
valuable for diagnosing performance issues caused by large objects
stored in a repo.

The current implementation of "git repo stucture" provides summary
information about everything in the repository - all of the
branches, remotes, tags, stashes, and notes. But sometimes
to properly diagnose a problem, it's useful to be able to exclude
refs that are known to not be relevant to the issue at hand.

Add a set of flags that allow a user to selective exclude
reference types from the report generated by "git repo structure".
When a ref type is excluded by the filter, it no longer appears
in the report (ie, if "--no-tags" is passed, the report line
for "Branches" will no longer appear under "* References").
Following the pattern of flags that are only used to
disable functionality (eg, "--no-verify" in "builtins/push.c"),
only the "--no-<reftype>" syntax is listed in the updated
documentation.

Overview of the changes:
- Add an enum to represent the structure flags.
- Add structure flags to the options for the "repo structure" commands.
- For each reference flag, add a conditional in "count_references"
  which decides whether or not to add a ref to the pending list.
  If an references is not added to the pending list, the things it
  transitively references will not be added to the stats.
- Add a set of test cases to verify that reference counts
  in the repo structure report correctly omit the specified
  resource types.
- Update the documentation for git-repo to include the new options.

Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
---
 Documentation/git-repo.adoc |  35 ++++-
 builtin/repo.c              | 158 +++++++++++++++------
 t/t1901-repo-structure.sh   | 276 ++++++++++++++++++++++++++++++++++++
 3 files changed, 427 insertions(+), 42 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index ed7d80c690..463260cd23 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -10,7 +10,7 @@ SYNOPSIS
 [synopsis]
 git repo info [--format=(lines|nul) | -z] [--all | <key>...]
 git repo info --keys [--format=(lines|nul) | -z]
-git repo structure [--format=(table|lines|nul) | -z]
+git repo structure [--format=(table|lines|nul) | -z] [--no-branches] [--no-tags] [--no-remotes] [--no-notes] [--no-stashes]`::
 
 DESCRIPTION
 -----------
@@ -56,7 +56,7 @@ supported:
 `nul`:::
 	Similar to `lines`, but using a _NUL_ character after each value.
 
-`structure [--format=(table|lines|nul) | -z]`::
+`structure [--format=(table|lines|nul) | -z] [--no-branches] [--no-tags] [--no-remotes] [--no-notes] [--no-stashes]`::
 	Retrieve statistics about the current repository structure. The
 	following kinds of information are reported:
 +
@@ -66,6 +66,23 @@ supported:
 * Total disk size of reachable objects by type
 * Largest reachable objects in the repository by type
 +
+The types of objects counted can be filtered using flags:
++
+`--no-branches`:::
+	Omit branch refs from the set of objects to count.
+
+`--no-tags`:::
+	Omit tags from the set of objects to count.
+
+`--no-remotes`:::
+	Omit remotes from the set of objects to count.
+
+`--no-notes`:::
+	Omit notes from the set of objects to count.
+
+`--no-stashes`:::
+	Omit stashes from the set of objects to count.
++
 The output format can be chosen through the flag `--format`. Three formats are
 supported:
 +
@@ -141,6 +158,20 @@ using the `nul` format:
 git repo info --format=nul layout.bare layout.shallow
 ------------
 
+* Generates information about storage usage in the repository:
++
+------------
+git repo structure
+------------
++
+
+* Generates information about storage usage in the repository omitting
+remotes:
++
+------------
+git repo structure --no-remotes
+------------
+
 SEE ALSO
 --------
 linkgit:git-rev-parse[1]
diff --git a/builtin/repo.c b/builtin/repo.c
index 84e012f83f..c8f6e38011 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -53,6 +53,20 @@ enum output_format {
 	FORMAT_NUL_TERMINATED,
 };
 
+enum repo_structure_filter_flags {
+	REPO_STRUCTURE_FILTER_BRANCHES = (1 << 0),
+	REPO_STRUCTURE_FILTER_TAGS = (1 << 1),
+	REPO_STRUCTURE_FILTER_REMOTES = (1 << 2),
+	REPO_STRUCTURE_FILTER_NOTES  = (1 << 3),
+	REPO_STRUCTURE_FILTER_STASHES = (1 << 4),
+};
+
+#define REPO_STRUCTURE_FILTER_FLAGS_ALL (REPO_STRUCTURE_FILTER_BRANCHES | \
+					 REPO_STRUCTURE_FILTER_TAGS |	\
+					 REPO_STRUCTURE_FILTER_REMOTES | \
+					 REPO_STRUCTURE_FILTER_NOTES |\
+					 REPO_STRUCTURE_FILTER_STASHES)
+
 struct repo_info_field {
 	const char *key;
 	get_value_fn *get_value;
@@ -490,7 +504,8 @@ static inline size_t get_total_object_values(struct object_values *values)
 }
 
 static void stats_table_setup_structure(struct stats_table *table,
-					struct repo_structure *stats)
+					struct repo_structure *stats,
+					enum repo_structure_filter_flags flags)
 {
 	struct object_stats *objects = &stats->objects;
 	struct ref_stats *refs = &stats->refs;
@@ -502,9 +517,15 @@ static void stats_table_setup_structure(struct stats_table *table,
 	ref_total = get_total_reference_count(refs);
 	stats_table_addf(table, "* %s", _("References"));
 	stats_table_count_addf(table, ref_total, "  * %s", _("Count"));
-	stats_table_count_addf(table, refs->branches, "    * %s", _("Branches"));
-	stats_table_count_addf(table, refs->tags, "    * %s", _("Tags"));
-	stats_table_count_addf(table, refs->remotes, "    * %s", _("Remotes"));
+	if (flags & REPO_STRUCTURE_FILTER_BRANCHES) {
+		stats_table_count_addf(table, refs->branches, "    * %s", _("Branches"));
+	}
+	if (flags & REPO_STRUCTURE_FILTER_TAGS) {
+		stats_table_count_addf(table, refs->tags, "    * %s", _("Tags"));
+	}
+	if (flags & REPO_STRUCTURE_FILTER_REMOTES) {
+		stats_table_count_addf(table, refs->remotes, "    * %s", _("Remotes"));
+	}
 	stats_table_count_addf(table, refs->others, "    * %s", _("Others"));
 
 	object_count_total = get_total_object_values(&objects->type_counts);
@@ -517,8 +538,10 @@ static void stats_table_setup_structure(struct stats_table *table,
 			       "    * %s", _("Trees"));
 	stats_table_count_addf(table, objects->type_counts.blobs,
 			       "    * %s", _("Blobs"));
-	stats_table_count_addf(table, objects->type_counts.tags,
-			       "    * %s", _("Tags"));
+	if (flags & REPO_STRUCTURE_FILTER_TAGS) {
+		stats_table_count_addf(table, objects->type_counts.tags,
+				       "    * %s", _("Tags"));
+	}
 
 	inflated_object_total = get_total_object_values(&objects->inflated_sizes);
 	stats_table_size_addf(table, inflated_object_total,
@@ -529,8 +552,11 @@ static void stats_table_setup_structure(struct stats_table *table,
 			      "    * %s", _("Trees"));
 	stats_table_size_addf(table, objects->inflated_sizes.blobs,
 			      "    * %s", _("Blobs"));
-	stats_table_size_addf(table, objects->inflated_sizes.tags,
-			      "    * %s", _("Tags"));
+
+	if (flags & REPO_STRUCTURE_FILTER_TAGS) {
+		stats_table_size_addf(table, objects->inflated_sizes.tags,
+				      "    * %s", _("Tags"));
+	}
 
 	disk_object_total = get_total_object_values(&objects->disk_sizes);
 	stats_table_size_addf(table, disk_object_total,
@@ -541,8 +567,10 @@ static void stats_table_setup_structure(struct stats_table *table,
 			      "    * %s", _("Trees"));
 	stats_table_size_addf(table, objects->disk_sizes.blobs,
 			      "    * %s", _("Blobs"));
-	stats_table_size_addf(table, objects->disk_sizes.tags,
-			      "    * %s", _("Tags"));
+	if (flags & REPO_STRUCTURE_FILTER_TAGS) {
+		stats_table_size_addf(table, objects->disk_sizes.tags,
+				      "    * %s", _("Tags"));
+	}
 
 	stats_table_addf(table, "");
 	stats_table_addf(table, "* %s", _("Largest objects"));
@@ -569,11 +597,13 @@ static void stats_table_setup_structure(struct stats_table *table,
 				     &objects->largest.blob_size.oid,
 				     objects->largest.blob_size.value,
 				     "    * %s", _("Maximum size"));
-	stats_table_addf(table, "  * %s", _("Tags"));
-	stats_table_object_size_addf(table,
-				     &objects->largest.tag_size.oid,
-				     objects->largest.tag_size.value,
-				     "    * %s", _("Maximum size"));
+	if (flags & REPO_STRUCTURE_FILTER_TAGS) {
+		stats_table_addf(table, "  * %s", _("Tags"));
+		stats_table_object_size_addf(table,
+					     &objects->largest.tag_size.oid,
+					     objects->largest.tag_size.value,
+					     "    * %s", _("Maximum size"));
+	}
 }
 
 #define INDEX_WIDTH 4
@@ -681,14 +711,21 @@ static void print_object_data(const char *key, char key_delim,
 }
 
 static void structure_keyvalue_print(struct repo_structure *stats,
-				     char key_delim, char value_delim)
+				     char key_delim, char value_delim,
+				     enum repo_structure_filter_flags flags)
 {
-	print_keyvalue("references.branches.count", key_delim,
-		       stats->refs.branches, value_delim);
+	if (flags & REPO_STRUCTURE_FILTER_BRANCHES) {
+		print_keyvalue("references.branches.count", key_delim,
+			       stats->refs.branches, value_delim);
+	}
+	if (flags & REPO_STRUCTURE_FILTER_TAGS) {
 	print_keyvalue("references.tags.count", key_delim,
 		       stats->refs.tags, value_delim);
-	print_keyvalue("references.remotes.count", key_delim,
-		       stats->refs.remotes, value_delim);
+	}
+	if (flags & REPO_STRUCTURE_FILTER_REMOTES) {
+		print_keyvalue("references.remotes.count", key_delim,
+			       stats->refs.remotes, value_delim);
+	}
 	print_keyvalue("references.others.count", key_delim,
 		       stats->refs.others, value_delim);
 
@@ -698,8 +735,10 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 		       stats->objects.type_counts.trees, value_delim);
 	print_keyvalue("objects.blobs.count", key_delim,
 		       stats->objects.type_counts.blobs, value_delim);
-	print_keyvalue("objects.tags.count", key_delim,
-		       stats->objects.type_counts.tags, value_delim);
+	if (flags & REPO_STRUCTURE_FILTER_TAGS) {
+		print_keyvalue("objects.tags.count", key_delim,
+			       stats->objects.type_counts.tags, value_delim);
+	}
 
 	print_keyvalue("objects.commits.inflated_size", key_delim,
 		       stats->objects.inflated_sizes.commits, value_delim);
@@ -707,8 +746,10 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 		       stats->objects.inflated_sizes.trees, value_delim);
 	print_keyvalue("objects.blobs.inflated_size", key_delim,
 		       stats->objects.inflated_sizes.blobs, value_delim);
-	print_keyvalue("objects.tags.inflated_size", key_delim,
-		       stats->objects.inflated_sizes.tags, value_delim);
+	if (flags & REPO_STRUCTURE_FILTER_TAGS) {
+		print_keyvalue("objects.tags.inflated_size", key_delim,
+			       stats->objects.inflated_sizes.tags, value_delim);
+	}
 
 	print_keyvalue("objects.commits.disk_size", key_delim,
 		       stats->objects.disk_sizes.commits, value_delim);
@@ -716,8 +757,10 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 		       stats->objects.disk_sizes.trees, value_delim);
 	print_keyvalue("objects.blobs.disk_size", key_delim,
 		       stats->objects.disk_sizes.blobs, value_delim);
-	print_keyvalue("objects.tags.disk_size", key_delim,
-		       stats->objects.disk_sizes.tags, value_delim);
+	if (flags & REPO_STRUCTURE_FILTER_TAGS) {
+		print_keyvalue("objects.tags.disk_size", key_delim,
+			       stats->objects.disk_sizes.tags, value_delim);
+	}
 
 	print_object_data("objects.commits.max_size", key_delim,
 			  &stats->objects.largest.commit_size, value_delim);
@@ -725,8 +768,10 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 			  &stats->objects.largest.tree_size, value_delim);
 	print_object_data("objects.blobs.max_size", key_delim,
 			  &stats->objects.largest.blob_size, value_delim);
-	print_object_data("objects.tags.max_size", key_delim,
-			  &stats->objects.largest.tag_size, value_delim);
+	if (flags & REPO_STRUCTURE_FILTER_TAGS) {
+		print_object_data("objects.tags.max_size", key_delim,
+				  &stats->objects.largest.tag_size, value_delim);
+	}
 
 	print_object_data("objects.commits.max_parents", key_delim,
 			  &stats->objects.largest.parent_count, value_delim);
@@ -739,6 +784,7 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 struct count_references_data {
 	struct ref_stats *stats;
 	struct rev_info *revs;
+	enum repo_structure_filter_flags flags;
 	struct progress *progress;
 };
 
@@ -747,19 +793,42 @@ static int count_references(const struct reference *ref, void *cb_data)
 	struct count_references_data *data = cb_data;
 	struct ref_stats *stats = data->stats;
 	size_t ref_count;
+	bool add_pending = false;
 
 	switch (ref_kind_from_refname(ref->name)) {
 	case FILTER_REFS_BRANCHES:
-		stats->branches++;
+		if (data->flags & REPO_STRUCTURE_FILTER_BRANCHES) {
+			stats->branches++;
+			add_pending = true;
+		}
 		break;
 	case FILTER_REFS_REMOTES:
-		stats->remotes++;
+		if (data->flags & REPO_STRUCTURE_FILTER_REMOTES) {
+			stats->remotes++;
+			add_pending = true;
+		}
 		break;
 	case FILTER_REFS_TAGS:
-		stats->tags++;
+		if (data->flags & REPO_STRUCTURE_FILTER_TAGS) {
+			stats->tags++;
+			add_pending = true;
+		}
 		break;
 	case FILTER_REFS_OTHERS:
-		stats->others++;
+		if (!strcmp(ref->name, "refs/stash")) {
+			if (data->flags & REPO_STRUCTURE_FILTER_STASHES) {
+				stats->others++;
+				add_pending = true;
+			}
+		} else if (starts_with(ref->name, "refs/notes")) {
+			if (data->flags & REPO_STRUCTURE_FILTER_NOTES) {
+				stats->others++;
+				add_pending = true;
+			}
+		} else {
+			stats->others++;
+			add_pending = true;
+		}
 		break;
 	default:
 		BUG("unexpected reference type");
@@ -769,10 +838,11 @@ static int count_references(const struct reference *ref, void *cb_data)
 	 * While iterating through references for counting, also add OIDs in
 	 * preparation for the path walk.
 	 */
-	add_pending_oid(data->revs, NULL, ref->oid, 0);
-
-	ref_count = get_total_reference_count(stats);
-	display_progress(data->progress, ref_count);
+	if (add_pending) {
+		add_pending_oid(data->revs, NULL, ref->oid, 0);
+		ref_count = get_total_reference_count(stats);
+		display_progress(data->progress, ref_count);
+	}
 
 	return 0;
 }
@@ -780,11 +850,13 @@ static int count_references(const struct reference *ref, void *cb_data)
 static void structure_count_references(struct ref_stats *stats,
 				       struct rev_info *revs,
 				       struct repository *repo,
+				       enum repo_structure_filter_flags flags,
 				       int show_progress)
 {
 	struct count_references_data data = {
 		.stats = stats,
 		.revs = revs,
+		.flags = flags,
 	};
 
 	if (show_progress)
@@ -935,6 +1007,7 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 	struct repo_structure stats = { 0 };
 	struct rev_info revs;
 	int show_progress = -1;
+	int flags = REPO_STRUCTURE_FILTER_FLAGS_ALL;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
 			       N_("output format"),
@@ -944,6 +1017,11 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			       parse_format_cb),
 		OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
+		OPT_BIT(0, "branches", &flags, N_("include branches in structure statistics"), REPO_STRUCTURE_FILTER_BRANCHES),
+		OPT_BIT(0, "tags", &flags, N_("include tags in structure statistics"), REPO_STRUCTURE_FILTER_TAGS),
+		OPT_BIT(0, "remotes", &flags, N_("include remotes in structure statistics"), REPO_STRUCTURE_FILTER_REMOTES),
+		OPT_BIT(0, "notes", &flags, N_("include notes in structure statistics"), REPO_STRUCTURE_FILTER_NOTES),
+		OPT_BIT(0, "stashes", &flags, N_("include stashes in structure statistics"), REPO_STRUCTURE_FILTER_STASHES),
 		OPT_END()
 	};
 
@@ -956,19 +1034,19 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 	if (show_progress < 0)
 		show_progress = isatty(2);
 
-	structure_count_references(&stats.refs, &revs, repo, show_progress);
+	structure_count_references(&stats.refs, &revs, repo, flags, show_progress);
 	structure_count_objects(&stats.objects, &revs, repo, show_progress);
 
 	switch (format) {
 	case FORMAT_TABLE:
-		stats_table_setup_structure(&table, &stats);
+		stats_table_setup_structure(&table, &stats, flags);
 		stats_table_print_structure(&table);
 		break;
 	case FORMAT_NEWLINE_TERMINATED:
-		structure_keyvalue_print(&stats, '=', '\n');
+		structure_keyvalue_print(&stats, '=', '\n', flags);
 		break;
 	case FORMAT_NUL_TERMINATED:
-		structure_keyvalue_print(&stats, '\n', '\0');
+		structure_keyvalue_print(&stats, '\n', '\0', flags);
 		break;
 	default:
 		BUG("invalid output format");
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 02cc2b594a..60a82493c6 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -144,6 +144,170 @@ test_expect_success SHA1 'repository with references and objects' '
 	)
 '
 
+
+test_expect_success SHA1 'repository with references and objects, filtered with --no-origins' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit_bulk 1005 &&
+		git tag -a foo -m bar &&
+
+		oid="$(git rev-parse HEAD)" &&
+		git update-ref refs/remotes/origin/foo "$oid" &&
+
+		git checkout -b other_branch &&
+		test_commit_bulk 5 &&
+
+		git checkout master &&
+
+		# Also creates a commit, tree, and blob.
+		git notes add -m foo &&
+
+		# The tags disk size is handled specially due to the
+		# git-rev-list(1) --disk-usage=human option printing the full
+		# "byte/bytes" unit string instead of just "B".
+		cat >expect <<-EOF &&
+		| Repository structure      | Value      |
+		| ------------------------- | ---------- |
+		| * References              |            |
+		|   * Count                 |      4     |
+		|     * Branches            |      2     |
+		|     * Tags                |      1     |
+		|     * Others              |      1     |
+		|                           |            |
+		| * Reachable objects       |            |
+		|   * Count                 |   3.02 k   |
+		|     * Commits             |   1.01 k   |
+		|     * Trees               |   1.01 k   |
+		|     * Blobs               |   1.01 k   |
+		|     * Tags                |      1     |
+		|   * Inflated size         |  16.04 MiB |
+		|     * Commits             | 219.00 KiB |
+		|     * Trees               |  15.81 MiB |
+		|     * Blobs               |  11.68 KiB |
+		|     * Tags                |    132 B   |
+		|   * Disk size             | $(object_type_disk_usage all true) |
+		|     * Commits             | $(object_type_disk_usage commit true) |
+		|     * Trees               | $(object_type_disk_usage tree true) |
+		|     * Blobs               |  $(object_type_disk_usage blob true) |
+		|     * Tags                |    $(object_type_disk_usage tag) B   |
+		|                           |            |
+		| * Largest objects         |            |
+		|   * Commits               |            |
+		|     * Maximum size    [1] |    223 B   |
+		|     * Maximum parents [2] |      1     |
+		|   * Trees                 |            |
+		|     * Maximum size    [3] |  32.29 KiB |
+		|     * Maximum entries [4] |   1.01 k   |
+		|   * Blobs                 |            |
+		|     * Maximum size    [5] |     13 B   |
+		|   * Tags                  |            |
+		|     * Maximum size    [6] |    132 B   |
+
+		[1] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
+		[2] 0a8f6a47f34078bb7c4b2bb4377c2133157f6703
+		[3] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		[4] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		[5] 97d808e45116bf02103490294d3d46dad7a2ac62
+		[6] 4dae4f5954f5e6feb3577cfb1b181daa3fd3afd2
+		EOF
+		git repo structure --no-remotes >actual 2>err &&
+		test_cmp expect actual &&
+		test_line_count = 0 err
+	)
+'
+
+test_expect_success SHA1 'repository with references and objects, filtered with "--no-branches"' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit_bulk 1005 &&
+		git tag -a foo -m bar &&
+
+		oid="$(git rev-parse HEAD)" &&
+		git update-ref refs/remotes/origin/foo "$oid" &&
+
+		git checkout -b other_branch &&
+		test_commit_bulk 5 &&
+
+		git checkout master &&
+
+		# Also creates a commit, tree, and blob.
+		git notes add -m foo &&
+
+		git repo structure --no-branches >actual 2>err &&
+		test_line_count = 0 err &&
+		test_grep "|   \* Count                 |      3     |" actual &&
+		test_grep "|     \* Others              |      1     |" actual &&
+		test_grep !  "Branches" actual
+	)
+'
+
+test_expect_success SHA1 'repository with references and objects, filtered with "--no-notes"' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit_bulk 1005 &&
+		git tag -a foo -m bar &&
+
+		oid="$(git rev-parse HEAD)" &&
+		git update-ref refs/remotes/origin/foo "$oid" &&
+
+		git checkout -b other_branch &&
+		test_commit_bulk 5 &&
+
+		git checkout master &&
+
+		# Also creates a commit, tree, and blob.
+		git notes add -m foo &&
+
+		git repo structure --no-notes >actual 2>err &&
+		test_line_count = 0 err &&
+		test_grep "|   \* Count                 |      4     |" actual &&
+		test_grep "|     \* Others              |      0     |" actual &&
+		test_grep "|     \* Commits             | 218.81 KiB |" actual
+	)
+'
+
+test_expect_success SHA1 'repository with references and objects, filtered with multiple flags' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit_bulk 1005 &&
+		git tag -a foo -m bar &&
+
+		oid="$(git rev-parse HEAD)" &&
+		git update-ref refs/remotes/origin/foo "$oid" &&
+
+		git checkout -b other_branch &&
+		test_commit_bulk 5 &&
+
+		git checkout master &&
+
+		# Also creates a commit, tree, and blob.
+		git notes add -m foo &&
+
+		git repo structure --no-notes --no-branches >actual 2>err &&
+		test_line_count = 0 err &&
+		test_grep "|   \* Count                 |      2     |" actual &&
+		test_grep "|     \* Others              |      0     |" actual &&
+		test_grep "|     \* Commits             | 217.73 KiB |" actual &&
+		test_grep !  "Branches" actual &&
+
+		git repo structure --no-notes --no-branches --no-remotes >actual 2>err &&
+		test_line_count = 0 err &&
+		test_grep "|   \* Count                 |      1     |" actual &&
+		test_grep "|     \* Others              |      0     |" actual &&
+		test_grep "|     \* Commits             | 217.73 KiB |" actual &&
+		test_grep !  "Branches" actual &&
+		test_grep ! "Remotes" actual
+	)
+'
+
 test_expect_success SHA1 'lines and nul format' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
@@ -203,6 +367,118 @@ test_expect_success SHA1 'lines and nul format' '
 		test_line_count = 0 err
 	)
 '
+test_expect_success SHA1 'lines and nul format with --no-tags filter' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit_bulk 42 &&
+		git tag -a foo -m bar &&
+
+		cat >expect <<-EOF &&
+		references.branches.count=1
+		references.remotes.count=0
+		references.others.count=0
+		objects.commits.count=42
+		objects.trees.count=42
+		objects.blobs.count=42
+		objects.commits.inflated_size=9225
+		objects.trees.inflated_size=28554
+		objects.blobs.inflated_size=453
+		objects.commits.disk_size=$(object_type_disk_usage commit)
+		objects.trees.disk_size=$(object_type_disk_usage tree)
+		objects.blobs.disk_size=$(object_type_disk_usage blob)
+		objects.commits.max_size=221
+		objects.commits.max_size_oid=de3508174b5c2ace6993da67cae9be9069e2df39
+		objects.trees.max_size=1335
+		objects.trees.max_size_oid=09931deea9d81ec21300d3e13c74412f32eacec5
+		objects.blobs.max_size=11
+		objects.blobs.max_size_oid=eaeeedced46482bd4281fda5a5f05ce24854151f
+		objects.commits.max_parents=1
+		objects.commits.max_parents_oid=de3508174b5c2ace6993da67cae9be9069e2df39
+		objects.trees.max_entries=42
+		objects.trees.max_entries_oid=09931deea9d81ec21300d3e13c74412f32eacec5
+		EOF
+
+		git repo structure --format=lines --no-tags >actual 2>err &&
+		test_cmp expect actual &&
+		test_line_count = 0 err &&
+
+		git repo structure --format=nul --no-tags >out 2>err &&
+		tr "\012\000" "=\012" <out >actual &&
+
+		test_cmp expect actual &&
+		test_line_count = 0 err &&
+
+		# "-z", as a synonym to "--format=nul", participates in the
+		# usual "last one wins" rule.
+		git repo structure --format=table -z --no-tags >out 2>err &&
+		tr "\012\000" "=\012" <out >actual &&
+
+		test_cmp expect actual &&
+		test_line_count = 0 err
+	)
+'
+
+test_expect_success SHA1 'lines and nul format with --no-branches filter' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit_bulk 42 &&
+		git tag -a foo -m bar &&
+
+		cat >expect <<-EOF &&
+		references.tags.count=1
+		references.remotes.count=0
+		references.others.count=0
+		objects.commits.count=42
+		objects.trees.count=42
+		objects.blobs.count=42
+		objects.tags.count=1
+		objects.commits.inflated_size=9225
+		objects.trees.inflated_size=28554
+		objects.blobs.inflated_size=453
+		objects.tags.inflated_size=132
+		objects.commits.disk_size=$(object_type_disk_usage commit)
+		objects.trees.disk_size=$(object_type_disk_usage tree)
+		objects.blobs.disk_size=$(object_type_disk_usage blob)
+		objects.tags.disk_size=$(object_type_disk_usage tag)
+		objects.commits.max_size=221
+		objects.commits.max_size_oid=de3508174b5c2ace6993da67cae9be9069e2df39
+		objects.trees.max_size=1335
+		objects.trees.max_size_oid=09931deea9d81ec21300d3e13c74412f32eacec5
+		objects.blobs.max_size=11
+		objects.blobs.max_size_oid=eaeeedced46482bd4281fda5a5f05ce24854151f
+		objects.tags.max_size=132
+		objects.tags.max_size_oid=1ee0f2b16ea37d895dbe9dbd76cd2ac70446176c
+		objects.commits.max_parents=1
+		objects.commits.max_parents_oid=de3508174b5c2ace6993da67cae9be9069e2df39
+		objects.trees.max_entries=42
+		objects.trees.max_entries_oid=09931deea9d81ec21300d3e13c74412f32eacec5
+		EOF
+
+		git repo structure --format=lines --no-branches >actual 2>err &&
+		cp expect /tmp/expect &&
+		cp actual /tmp/actual &&
+		test_cmp expect actual &&
+		test_line_count = 0 err &&
+
+		git repo structure --format=nul --no-branches >out 2>err &&
+		tr "\012\000" "=\012" <out >actual &&
+
+		test_cmp expect actual &&
+		test_line_count = 0 err &&
+
+		# "-z", as a synonym to "--format=nul", participates in the
+		# usual "last one wins" rule.
+		git repo structure --format=table -z --no-branches >out 2>err &&
+		tr "\012\000" "=\012" <out >actual &&
+
+		test_cmp expect actual &&
+		test_line_count = 0 err
+	)
+'
 
 test_expect_success 'progress meter option' '
 	test_when_finished "rm -rf repo" &&
-- 
2.53.0

