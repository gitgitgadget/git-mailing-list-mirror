Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F263530E853
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863539; cv=none; b=NOgFTXuJWqfbCEKnhKoJaCAL9ZpVoXjZ2NPIRJmloq/z72UYslOmIL0HdgbxfWnjLSvKqsthIx0CoNdrf3O2NSO0lOsqimolL48BALrcrzkwmxN7MuEB6ip10DlBCGJYLEfHr8/e1htPRW+DwtyfQ2zWB9/Wll9MdFZ7Ley7ptE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863539; c=relaxed/simple;
	bh=VGMYC3MiaIk6XYALDzGIjaP+bAZOu69ZZ4w5VmlXeQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J8Y7nUwAuoaLbQ3l8C0zZQLI2tNixj/0z4TU9fP8ho4hMuGBHmQEbd2jeTuOknZkLiRiVY9kgTfYZ4n1ldELQEK2I/3LVI56XrJHzELxzh+5fNLCJIqEr1ONYjQXAU4CDT+lO+mO+ez+K4zYL1ppk1ZLUQs7c+qOkSOG8YFQQTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZB9Lb60d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WzxFBkAs; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZB9Lb60d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WzxFBkAs"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 1E406EC05AD
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:53 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 23 Feb 2026 11:18:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771863533;
	 x=1771949933; bh=BUPlBpGOyXrNNCgqZXcvNFlyg4wbBiUu+YyiqIYtACQ=; b=
	ZB9Lb60dkfQ0GpgaV15ZPJXeIJTSNwxazdZbcTAVg4I7xLKUuYurfX1LJzRTLnTE
	EVZAdcqrL/LTO+7oEIwyKdH/GyrhGhkzd6ID0/IThxlhGZHxx35c/k184PsQemkP
	+gkmgvpmaPU1xhS4CaueylCPwDrnr2CrhlvdpOmqxM6361Nf/BnLIR57g3RnP+MO
	w4ZDZpOX5YwbLYGe8y6ty2W0drNhSNDW6CnONtJeeymV+wKF4dHhcFFluvbnKsSL
	LxPzPvE2JcaimIIbHCZbRBfU4nQY/ZpC9AIZKY2ZRMl1pn2LNHVqPVIa+F+mwSp+
	u+s+zLC0u5FWT2zw7sfzjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771863533; x=
	1771949933; bh=BUPlBpGOyXrNNCgqZXcvNFlyg4wbBiUu+YyiqIYtACQ=; b=W
	zxFBkAsp8SmmfQuj6tq0mqaZ9R0jyND5IXo/Nl5YcBDeHqtptpkro7Z4/vwwn9Dk
	CxUQK1eP8ecF4Bc8hnRkeFr7gZ0Exqg03BP+gdOdVevzO36yg8tB/SBA/u0JE3iX
	Ae6Z6jLDokFgYBXiDPNt4yE1Fe7ONmXfVkgRM1u2+6vK12KMa1+aEa1cXOCWi3h5
	CgL6/dwoeym/s2zVSb4w6tLAuxSBm36JeFP/ma7ZCuu5XMyN7o3/hPIZEF0pwOTy
	UicSAIfGelJk7QQgCoxBL7wUvCZbR6l2/7sgSsAk0pIM3+4DSV988O9CZz7cCTub
	Bi0PKjslwGVNPam4jhIew==
X-ME-Sender: <xms:7X2caeUHJ3vY9Q4Hq5_2kYqfdPn8eu-mTEQ-BKOowbakQIdTsqhFTw>
    <xme:7X2caRgvcgQVZm1-tSaGaz2QtP8PtWvGb6BgH5NT2FG2tSxkvUf3kmt30Kn-QCrqb
    NJ396PPUokr76wnpaUxjzmw3f78xndJHgfQ_i2tQJ492oBtXjCsUw>
X-ME-Received: <xmr:7X2caYAIMDE5tX3JUD_2FDJb-p_fijAhgO01mxDvAoQeJE6RyN05YSF2HN-_tDqZM58Sw3AQpWyTRABWLpym4BMznEcWtGzS4ENFI5Zcew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:7X2caacfjFeCOZMFgCGkIveTOkLViym0HoBa5DWftQKBOVSmZjSKFg>
    <xmx:7X2caYd5Mszt5CpK5b-jZd8xaRO6FTc3MWDAMb7HxNQ_okSW8_rNvA>
    <xmx:7X2caWj1yyabeY1FXXsT9sSKZ7GrBtc6BF3-9w6EKnt_2ODsOZMlFQ>
    <xmx:7X2cacT2MT5bxsSRiAx6S4T8tM9oqpJHgpw1d09zDw0H4aQGh8MFhg>
    <xmx:7X2cadmmc6xU1CjzV_1FhLeR3TKhjAqMJK1R7nOdKu2hF7Rv6ZycLF98>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:52 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id db51b666 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 23 Feb 2026 16:18:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 17:18:07 +0100
Subject: [PATCH 16/17] odb/source: make `write_alternate()` function
 pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-b4-pks-odb-source-pluggable-v1-16-253bac1db598@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 14f5d56f68..cf301679da 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -244,6 +244,19 @@ struct odb_source {
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
@@ -408,4 +421,17 @@ static inline int odb_source_read_alternates(struct odb_source *source,
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
2.53.0.536.g309c995771.dirty

