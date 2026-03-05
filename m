Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E864781724
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720433; cv=none; b=Qz5dPNh6zvdTzi/vBMqJmlE5h/zL+RjfeigwsBb//zPVpIwWSjdZioyoLAyAD8p8XARQORVq9SPe6WpHY6zseiGfCPl929IPOMAWYNk1G/2DzgrvVMt36FivenjNvZNyqypxnYLnpUHzP5Zey7xpsRBdS5wUOgSR2R5ZXeYBNBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720433; c=relaxed/simple;
	bh=rNwOL7kCFixkgLmuSLruiE+da2vi5wFdSxIOcYE++Xk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m9Qi3ZJCRvn3ktnEL8CNobHrDrURa5mXGjyy44PzLhHDyj4sCuSZISLvN3iQ8I+QERXDaV6b9WtleUszw7Tly3AjampVB7ToBvuymr9nEwZOEbE6WHTz60d785qlZeqeJwQYXHUzBltH9OrCwF86DYhn2RR5GLnOZR/BYDynM7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MmP1liyz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0X2WqO67; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MmP1liyz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0X2WqO67"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7023A7A00FC;
	Thu,  5 Mar 2026 09:20:31 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 05 Mar 2026 09:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772720431;
	 x=1772806831; bh=0ZAKUAhVP6k7cAtC2yYWFTgC9n6dcg5n1K4fBJcRmg0=; b=
	MmP1liyz+4as60k7KHs4voJkE98O+xtfGignClAJ0gCOUvImelGwL17CZYooGx1z
	PxL09eq5bzhN/ZNgmYz9fp4N8Wik2165/H1m3kXoiaiHF4WuyW4+3v/qo2Yb3aVN
	ZxRhQgwe3PEoWs7wInebgumBy7cwnGzh8JSQxS5Yf7M939Mw/IufODwx6iDGObu5
	tpNYXDdO5X7BistYTC9oDmnOlx6P9UXxGrAH+ObLtt4SywuLCO2ynqrJjGngBacU
	faG+RrwB/X3YC01NruLm5yZXg5AQW2OFlo2Q7ue4f60uBJzPY60LJjlTmTZP5oZl
	Dm8nP3UD8mtZZzsiZ02loA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772720431; x=
	1772806831; bh=0ZAKUAhVP6k7cAtC2yYWFTgC9n6dcg5n1K4fBJcRmg0=; b=0
	X2WqO67alovvF0ws2oK4hMwuccbMIy9vkVA5dSy13AzX8Zx+gDhcIj9djOBu00XZ
	4GrU9WeHDBWBd++tQNthywUWPjZBrV0qL0MQTUSmDiOmejYlugqoi9qSuA6/28gy
	WDPvzEcg0sXAlkAzFMVIDhf8lZ3ijutXZ3+YDlLRTPLxAgO+CNSK49HqWKIiPL4+
	utDGTsmadBxSmA37j9DYXzIbewL31UQQfMsZBPmbfG5vwwibHRuENWB1N/IAhsag
	iNgx+5dA2YOIe5wJX0549Xp9zIpFqZUBFrkvYwLV+k+XeE2R7ltOVZyt1CQkWTW/
	9m2YJfQiOpLGp8N790hbA==
X-ME-Sender: <xms:L5GpaVHJ2Wm--mlobQcq_hFrJOgITof7SlJtaO_y_1f_8AjlxXoZPw>
    <xme:L5GpaRU-dPQQhZ9l5aHQTvaZTYeqOiVPVuZErjl8hYZiPaiYqae5NsMEBsfMA5WG_
    Y_-_6r2Nv2wwEtIXwuzoCFwMDkIaovyNdQApt2xz1D3eNSRX5fhqg>
X-ME-Received: <xmr:L5GpacJai2R5thuFBCrfqLTxL7lLZJWuGeGvDux--l8ofnd0c8jsE9iDEEUI7Nm_MazOgLVjWUzHZZSbxZJb3dNxTIEH5nxJy_dP2Cv3LgKM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeiiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdr
    tghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:L5GpaZ_-18JOCUQKt2pInphmC75WqW8VfTenlWC6L1TS_-extpXSSA>
    <xmx:L5GpaXJ5j078UYotltzvDHgJnl1QyTAUlQ4m5PTG6MdI2MsjRaBgcg>
    <xmx:L5GpaWlv4Xlt3-UVYs6Ku3p8hXrUzaTJf2QKYNo8PvmSPJMnOhFhow>
    <xmx:L5GpaTPZy7l_zso9h8V6CDEIJdTjEgdojqB50dYCJLuOOlH5t3OzcA>
    <xmx:L5GpaXrH4ET-BydjyRtfm73urV1w6EVY8ECmjGYrNXAqw8I8r6MJKw2a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 09:20:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f5abe09c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 14:20:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Mar 2026 15:19:56 +0100
Subject: [PATCH v2 16/17] odb/source: make `write_alternate()` function
 pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-b4-pks-odb-source-pluggable-v2-16-3290bfd1f444@pks.im>
References: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
In-Reply-To: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Introduce a new callback function in `struct odb_source` to make the
function pluggable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c              | 52 --------------------------------------------------
 odb/source-files.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 odb/source.h       | 26 +++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 52 deletions(-)

diff --git a/odb.c b/odb.c
index d9424cdfd0..84a31084d3 100644
--- a/odb.c
+++ b/odb.c
@@ -236,58 +236,6 @@ static struct odb_source *odb_add_alternate_recursively(struct object_database *
 	return alternate;
 }
 
-static int odb_source_write_alternate(struct odb_source *source,
-				      const char *alternate)
-{
-	struct lock_file lock = LOCK_INIT;
-	char *path = xstrfmt("%s/%s", source->path, "info/alternates");
-	FILE *in, *out;
-	int found = 0;
-	int ret;
-
-	hold_lock_file_for_update(&lock, path, LOCK_DIE_ON_ERROR);
-	out = fdopen_lock_file(&lock, "w");
-	if (!out) {
-		ret = error_errno(_("unable to fdopen alternates lockfile"));
-		goto out;
-	}
-
-	in = fopen(path, "r");
-	if (in) {
-		struct strbuf line = STRBUF_INIT;
-
-		while (strbuf_getline(&line, in) != EOF) {
-			if (!strcmp(alternate, line.buf)) {
-				found = 1;
-				break;
-			}
-			fprintf_or_die(out, "%s\n", line.buf);
-		}
-
-		strbuf_release(&line);
-		fclose(in);
-	} else if (errno != ENOENT) {
-		ret = error_errno(_("unable to read alternates file"));
-		goto out;
-	}
-
-	if (found) {
-		rollback_lock_file(&lock);
-	} else {
-		fprintf_or_die(out, "%s\n", alternate);
-		if (commit_lock_file(&lock)) {
-			ret = error_errno(_("unable to move new alternates file into place"));
-			goto out;
-		}
-	}
-
-	ret = 0;
-
-out:
-	free(path);
-	return ret;
-}
-
 void odb_add_to_alternates_file(struct object_database *odb,
 				const char *dir)
 {
diff --git a/odb/source-files.c b/odb/source-files.c
index 199c55cfa4..c32cd67b26 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -1,12 +1,15 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "chdir-notify.h"
+#include "gettext.h"
+#include "lockfile.h"
 #include "object-file.h"
 #include "odb.h"
 #include "odb/source.h"
 #include "odb/source-files.h"
 #include "packfile.h"
 #include "strbuf.h"
+#include "write-or-die.h"
 
 static void odb_source_files_reparent(const char *name UNUSED,
 				      const char *old_cwd,
@@ -138,6 +141,58 @@ static int odb_source_files_read_alternates(struct odb_source *source,
 	return 0;
 }
 
+static int odb_source_files_write_alternate(struct odb_source *source,
+					    const char *alternate)
+{
+	struct lock_file lock = LOCK_INIT;
+	char *path = xstrfmt("%s/%s", source->path, "info/alternates");
+	FILE *in, *out;
+	int found = 0;
+	int ret;
+
+	hold_lock_file_for_update(&lock, path, LOCK_DIE_ON_ERROR);
+	out = fdopen_lock_file(&lock, "w");
+	if (!out) {
+		ret = error_errno(_("unable to fdopen alternates lockfile"));
+		goto out;
+	}
+
+	in = fopen(path, "r");
+	if (in) {
+		struct strbuf line = STRBUF_INIT;
+
+		while (strbuf_getline(&line, in) != EOF) {
+			if (!strcmp(alternate, line.buf)) {
+				found = 1;
+				break;
+			}
+			fprintf_or_die(out, "%s\n", line.buf);
+		}
+
+		strbuf_release(&line);
+		fclose(in);
+	} else if (errno != ENOENT) {
+		ret = error_errno(_("unable to read alternates file"));
+		goto out;
+	}
+
+	if (found) {
+		rollback_lock_file(&lock);
+	} else {
+		fprintf_or_die(out, "%s\n", alternate);
+		if (commit_lock_file(&lock)) {
+			ret = error_errno(_("unable to move new alternates file into place"));
+			goto out;
+		}
+	}
+
+	ret = 0;
+
+out:
+	free(path);
+	return ret;
+}
+
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
 					      const char *path,
 					      bool local)
@@ -159,6 +214,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.write_object = odb_source_files_write_object;
 	files->base.write_object_stream = odb_source_files_write_object_stream;
 	files->base.read_alternates = odb_source_files_read_alternates;
+	files->base.write_alternate = odb_source_files_write_alternate;
 
 	/*
 	 * Ideally, we would only ever store absolute paths in the source. This
diff --git a/odb/source.h b/odb/source.h
index fbdddcb2eb..ee540630d2 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -245,6 +245,19 @@ struct odb_source {
 	 */
 	int (*read_alternates)(struct odb_source *source,
 			       struct strvec *out);
+
+	/*
+	 * This callback is expected to persist the singular alternate passed
+	 * to it into its list of alternates. Any pre-existing alternates are
+	 * expected to remain active. Subsequent calls to `read_alternates` are
+	 * thus expected to yield the pre-existing list of alternates plus the
+	 * newly added alternate appended to its end.
+	 *
+	 * The callback is expected to return 0 on success, a negative error
+	 * code otherwise.
+	 */
+	int (*write_alternate)(struct odb_source *source,
+			       const char *alternate);
 };
 
 /*
@@ -412,4 +425,17 @@ static inline int odb_source_read_alternates(struct odb_source *source,
 	return source->read_alternates(source, out);
 }
 
+/*
+ * Write and persist a new alternate object database source for the given
+ * source. Any preexisting alternates are expected to stay valid, and the new
+ * alternate shall be appended to the end of the list.
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+static inline int odb_source_write_alternate(struct odb_source *source,
+					      const char *alternate)
+{
+	return source->write_alternate(source, alternate);
+}
+
 #endif

-- 
2.53.0.797.g7842e34a66.dirty

