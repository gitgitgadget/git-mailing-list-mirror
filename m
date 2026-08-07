Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F28F3793DC
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 03:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786073694; cv=none; b=SteYapHfc0zvH5N0AG5u01PXuSOmjZDZoQNuSg5NrNj6SVSc//6Kw/4CQOsfuWEJRdG5pxStgCuP98HJWR35GgJURdLzafdTsFYkTGU4gYmXcAAkbixrJ+7ip/JHiq5SqnBolPVmYNdlDpbNSFzdHv3w4Hg2RiQ44No5sRYeImM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786073694; c=relaxed/simple;
	bh=w26uY5W9Ke+y73uAfnwgBm60tzo7GT+AfY4agjixfAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rel0W1VNgIknzNs2zLAS+OKb0s7duVNltu00UCXvKCGYHPtnQzBfwp3nby0gmflfG/U++uW4NqJ4hf4utljgkiRJU5sbEFQdJUaFv9x6HK08Zth1DLRmkOvUtaUIvQWxM33ztJQ6sCw1jHz2p6nPvsCrntuARc6RhO+FyTaipps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oyH+Ojf5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UIaU4EW1; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oyH+Ojf5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UIaU4EW1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 83821EC01B8;
	Thu,  6 Aug 2026 23:34:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 06 Aug 2026 23:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786073691;
	 x=1786160091; bh=FlpWMb4kB2Y+Gi9hkjwBko8ga8N5GjkRLwmevBAlfuI=; b=
	oyH+Ojf5pIMyY1NGoC62LlWPxCx3l7Wr15r3/g42px5optXa4yLQGGnDmW89BhVo
	82zr9qoi7XUH0AVO10nZTVvld77rZsygTSF7mjS//zWjIhM6qKwjZG24svoL1Pwu
	PTY9SsbiXCFJ9dQaon4WgT/Zw9WVTVhYI3nqEEsZGSw65vMvPQidhvYVU8NSR3yE
	MC8vn5zm/4GcVq5u3zzreopgIrl9hFJySO0TIsoRYS+L+KXFYGgKRcrEKo2EK0X3
	vbeBJ7342NmyG03CMVyWzh3WxeMHuQ8vol1OBdeRbrGxdOpjABJZPC3oUhnewBcO
	Cxwo94jaNPVL+UWB7qQiGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786073691; x=
	1786160091; bh=FlpWMb4kB2Y+Gi9hkjwBko8ga8N5GjkRLwmevBAlfuI=; b=U
	IaU4EW1XbHXOuBLm2jqrzHCXLf2on4YIlaTBMKecdZcIcrxknRalYJxJu/fAlNb2
	0Ejr4zot+tfwdQFkTzqQJBMiVvg1mWdkPpFkRmRZWn5IIlv3U3DJii0Nr8rGru3e
	wgT/JiEL2CfHGSoWnNAraJo9Zwj1u7RUaouuQLk2/lTlPb+5XBl88zFVQJe0pY8R
	jHwmuq3GM5ROQBaF1EzJ8JQFBLw9ZAiGDqtFM8kN0gMppvpw9g7sqRWkdyNoWRG6
	eA1SKbkSx6VyxSNeYnCgqfDR231rohYAtdtOjJ4bshGlMtKqBtbH2k/T0m8mX4te
	wFTgv8uAwQLxPBAQiisvw==
X-ME-Sender: <xms:W1J1avtIqHtgBNthpaMYfJ9CjFG3xGp1kPkAoBzh__xHsyX82nkJUQ>
    <xme:W1J1andVyywVWtKp-0efcD-G8vGXf18zGjVMnhbgpqHPrctsuxdiu_dC5Df-nBPIZ
    fn2xLeoWKremVLwjBFNjB7t_2q0P9PcxFTsv9yAQeCdkHHrEW7wM98>
X-ME-Received: <xmr:W1J1anxb-ip2bIvQtKmiI8h4JDSe_T94m6bXgbz-mGlnYCnhfoP4bYjE6ur9EYZ2Qc1G7uM4Qynuqv28l15dVKpQ_Wxk9fiAkuwigafShqxI9w>
X-ME-Proxy-Cause: dmFkZTEja0Zdzix3jY9oN1FvPJvnyPJlY0MZ5etQvts4FyCPtwEUwNiV72k5kksQUTj5al
    SNpwu9IvFpI7MW6N/SoG+5HUrE1ReUoPg3tSz/xLZGeVkyj3lQ6+i0+qIOpGesy2V6yspF
    t9EJpVGGB09jIB4/ovOFJSJdJlp23c1B/JJP7mdTIlq12OofwpRKRHSa6Z6GQt+XEiu7W5
    rOGFnCPS1ioolo7nTBt4DEHnMCD/ynqdYiqryLhUdMrA4DZDNb/BzINv7xuJvyS0dPa9Vc
    LcKh/xd/WZeTd46nUDcRVvny/R9LH5RDLiZgJ/FRHYMSbhulSvRoblMyRhQP4hcIDTHhIi
    IidUjMvUxYtB9cCNVe7x0ihSRLc+2lJVBgSv/jgZ9aA6wrNbidDW5vodGSAN2UA0t/uoOo
    lKEflyzZZYxBc1RbwRCmg8v3pr6QQki/J4j0EazdTYGDPrnAzjm3CpjML7igRCLXJE+Iii
    p9Smi4Rz9aMkbysCQUPfidqtFeGthUXRNBsdz5dpAik4y9mMA6apNyzKe/VY5D6eO/RVIO
    FApEaZ4ReTuSpvup4kQccDWqk/jMx9wcuFKAFAEJEwI87jB7UGYK8aRU6n1cK/FVg8AXkU
    rRHWRF5Mp3+BMckGQROKmYpcmcciTcXPCoCtRBzZ2iTZ7DGH3FcZsZQ6RLZQ
X-ME-Proxy: <xmx:W1J1atFpOvIhSlBY58jQhkQm-qKGosvpjcfl4hi8j4XlPMu9Ctk1Hw>
    <xmx:W1J1arwJ3hWNmWVUky9lhg6xeP_zlgExIu55evF4GrmCGEHF0XhR8A>
    <xmx:W1J1autaLxxJO_ScOZzFCTzRikADY0czghvhYoNytByVHdGIohlRdw>
    <xmx:W1J1ao3rZ6727QJfGOqHFrZCv2E4AqecSGfbjt4x2bDOvqLQQ5nlKQ>
    <xmx:W1J1anws5IUrMBpYgQirQwegMHBkorQUtWHNOC8Ejr2h2IMkDxYLzrim>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 23:34:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f0754bc8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Aug 2026 03:34:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Aug 2026 05:34:30 +0200
Subject: [PATCH v5 6/6] odb: make creation of on-disk structures pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-pks-odb-create-on-disk-v5-6-399da0b0b140@pks.im>
References: <20260807-pks-odb-create-on-disk-v5-0-399da0b0b140@pks.im>
In-Reply-To: <20260807-pks-odb-create-on-disk-v5-0-399da0b0b140@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

When creating a new "files" object database source we have to create a
couple of directories. These directories are of course specific to this
particular backend, and a different backend may require a setup that is
completely different.

Make the creation of on-disk structures pluggable to accommodate for
this.

Note that there is one exception though: the "objects" directory must
exist in a repository regardless of which backend is in use. If it
doesn't exist then the repository is not treated as a Git repository at
all. Consequently, we create this directory regardless of the backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 19 +++++++++++++++++++
 odb/source.h       | 23 +++++++++++++++++++++++
 setup.c            | 34 ++++++++++++++++++----------------
 3 files changed, 60 insertions(+), 16 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 4138758511..0db6e681fe 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -9,6 +9,7 @@
 #include "odb/source-files.h"
 #include "odb/source-loose.h"
 #include "packfile.h"
+#include "path.h"
 #include "strbuf.h"
 #include "write-or-die.h"
 
@@ -41,6 +42,23 @@ static void odb_source_files_close(struct odb_source *source)
 	odb_source_close(&files->packed->base);
 }
 
+static int odb_source_files_create_on_disk(struct odb_source *source)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	safe_create_dir(source->odb->repo, source->path, 1);
+
+	strbuf_addf(&path, "%s/pack", source->path);
+	safe_create_dir(source->odb->repo, path.buf, 1);
+
+	strbuf_reset(&path);
+	strbuf_addf(&path, "%s/info", source->path);
+	safe_create_dir(source->odb->repo, path.buf, 1);
+
+	strbuf_release(&path);
+	return 0;
+}
+
 static void odb_source_files_prepare(struct odb_source *source,
 				     enum odb_prepare_flags flags)
 {
@@ -271,6 +289,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 
 	files->base.free = odb_source_files_free;
 	files->base.close = odb_source_files_close;
+	files->base.create_on_disk = odb_source_files_create_on_disk;
 	files->base.prepare = odb_source_files_prepare;
 	files->base.read_object_info = odb_source_files_read_object_info;
 	files->base.read_object_stream = odb_source_files_read_object_stream;
diff --git a/odb/source.h b/odb/source.h
index ab16d152f4..4abc418bdd 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -89,6 +89,18 @@ struct odb_source {
 	 */
 	void (*close)(struct odb_source *source);
 
+	/*
+	 * This callback is expected to create on-disk data structures that are
+	 * required for this source to operate.
+	 *
+	 * The callback is expected to return 0 on success, a negative error
+	 * code otherwise.
+	 *
+	 * This callback may be NULL in case the source does not need any
+	 * on-disk setup.
+	 */
+	int (*create_on_disk)(struct odb_source *source);
+
 	/*
 	 * This callback is expected to prepare the source so that it becomes
 	 * ready for use. It optionally clears underlying caches of the object
@@ -316,6 +328,17 @@ static inline void odb_source_close(struct odb_source *source)
 	source->close(source);
 }
 
+/*
+ * Create on-disk data structures that are required for this source to operate
+ * correctly. Returns 0 on success, a negative error code otherwise.
+ */
+static inline int odb_source_create_on_disk(struct odb_source *source)
+{
+	if (!source->create_on_disk)
+		return 0;
+	return source->create_on_disk(source);
+}
+
 /*
  * Prepare the object database source and clear any caches. Depending on the
  * backend used this may have the effect that concurrently-written objects
diff --git a/setup.c b/setup.c
index 97338cbc51..ace3c59d18 100644
--- a/setup.c
+++ b/setup.c
@@ -2649,25 +2649,27 @@ static int create_default_files(struct repository *repo,
 
 static void create_object_database(struct repository *repo)
 {
-	struct strbuf path = STRBUF_INIT;
-	size_t baselen;
+	/*
+	 * Create the "objects" directory in the common directory. This is done
+	 * so that the repository can be discovered regardless of the backend
+	 * used.
+	 *
+	 * Note that we only do this in case the object directory wasn't
+	 * overwritten via an environment variable. If it _is_ being overridden
+	 * then we skip this step, as the repository won't be discoverable
+	 * anyway without the environment variable.
+	 */
+	if (!getenv(DB_ENVIRONMENT)) {
+		struct strbuf objects_dir = STRBUF_INIT;
+		repo_common_path_append(repo, &objects_dir, "objects");
+		safe_create_dir(repo, objects_dir.buf, 1);
+		strbuf_release(&objects_dir);
+	}
 
 	repo->objects = odb_new(repo, ODB_NEW_HONOR_ENV);
 
-	strbuf_addstr(&path, repo_get_object_directory(repo));
-	baselen = path.len;
-
-	safe_create_dir(repo, path.buf, 1);
-
-	strbuf_setlen(&path, baselen);
-	strbuf_addstr(&path, "/pack");
-	safe_create_dir(repo, path.buf, 1);
-
-	strbuf_setlen(&path, baselen);
-	strbuf_addstr(&path, "/info");
-	safe_create_dir(repo, path.buf, 1);
-
-	strbuf_release(&path);
+	if (odb_source_create_on_disk(repo->objects->sources) < 0)
+		die(_("failed creating object database"));
 }
 
 static void separate_git_dir(const char *git_dir, const char *git_link)

-- 
2.55.0.679.g6767b8d81c.dirty

