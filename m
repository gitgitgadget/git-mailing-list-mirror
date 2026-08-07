Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552CB3890F3
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 03:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786073687; cv=none; b=ULIOL2AjnayNj6AgU0ZI//U8fT7Wo3FFomqIprScX31zk3F0v1gn0mFU1Qha8mG5gJEqHT1UYOuJ5a8Rbo24HGExWEI6s3Va6ZRIoATBhkFxTFBgiimSYk2b9GEAuoUWOESPZaxJai9kXNkZZJ6JpYElGYpyrLGBZ3McON84EYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786073687; c=relaxed/simple;
	bh=XW6VmGUp4II/Gig8wwy6pwxiuKGTv2EatAti08vDH98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ny7hLX99XbvriQwSTTFvmRmMX9QMnmfKuiW3JKDNZRt68UhEzk8MfpFO7EhbCpAAIgErcDJYcdTLm6mbQcxJx9z1zVgBw2q90ac5eHTvzq2d+GJnQq+M4IpMDcNRbWb7GcmBy8fx6RwmgCfC/YasMa2w9Z4fh7GS9myj6rAdorU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B8JfZZ/V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SooixK+A; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B8JfZZ/V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SooixK+A"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A6A9EC01E4;
	Thu,  6 Aug 2026 23:34:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 06 Aug 2026 23:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786073685;
	 x=1786160085; bh=qENymZEby51ZaetjIhi1hA3klYtD0e/8CoNjDXW7kkI=; b=
	B8JfZZ/VUaLcPmYyh8gY1NWOVPuC9vMWCswBaPTNH3Nh0JRoTy6g7F6WlUg1Uy8s
	UpVxwXeO9JVofFDL3NIpsx74wunkQDktafswTX6V6aTcQan9z3/Xq7YvBB+1h2Ib
	wj2HSJgsGbC8oxFXs/RtOqO2i0X4vNVmqG1fz5HNSHbFvx7ABdDx0RlWDXwl1BVG
	ojj9nnjl6Am8cfe7WYaIEuV5GuOhAOZj9OSB4Tj0Owt7jKe2O4eq1QFmc0xzUOcK
	z5D4qkUnBv1cK8jS59FT9DD3xSeG2/THVnYNqO7SOypJhJpr3CLOQjLIaP+9Clww
	EhiIIYhqvetq2q7GXXayNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786073685; x=
	1786160085; bh=qENymZEby51ZaetjIhi1hA3klYtD0e/8CoNjDXW7kkI=; b=S
	ooixK+AegI6P1unMCcM6j6tyTHdJUNb7wiySnhilep232qUA+TnbqesmHICXCH27
	bPXLZpvz4wtPTgozkqQ493QpZHhtsfNZ1wtu0d8o4zmG6aKerMqyv1hgXVXSovGD
	jJU8iR7+l3jwLYpVulgyf9jAR/9b2sQlWx7Oi6z9fM2bo++Fs+X0SBaWi6Ek1ZDK
	4ZU2wNA54l+6ez8RDokzQhsl6TzSl3p+b6gtNBvik78ZGUhuxHWV3mCeg3qy72II
	PZ8ds/1vaf4N57TFNPkDtbHU2PmD5+rC6mNsJbKSSxV5aaMmiq8Ispm5P2UKhNw1
	DIXaRPk8S993n+hSUpZXg==
X-ME-Sender: <xms:VVJ1amD90my4AG1dS6okh6I0hRLYsPGeToKNzlDEBQVkvc_sIFsXag>
    <xme:VVJ1anjiKB2eXKDEmM-WCggMmXPmBlr8T5XJ08Guh5RNMGUNywVwDqJkAdl3EnrnW
    9zvEaeRHxf79giWiCdsRgFJMpuq5toUCkcT6x20T5L-3z72L3y_1A>
X-ME-Received: <xmr:VVJ1aulKamoFUTjvcZIAd0OIFUUdFpKZ8Krr-asuITO99_FBhIStjll7Lk398LXO-TWOivqwkX-DsjcjhrAyrywc_7f_8a5-Z5CHMF0c_CutVg>
X-ME-Proxy-Cause: dmFkZTE7kdBa+2ZpN9yaQzNopvi5XGOOKBTvLDG9gmHatLClTyCzXowykrFEsXwaSZzd4i
    7rZ+PYPbEsDpQY65/3WEOnc3hfu3bdJkEr0npqZzCOFaVJnElXRww4Mk5FBkx2+neuda5y
    A+H0Sn3NmT1/usz1Tgjyy7AJoC08TLsGbBAgN5++8fR1k3aPnOSgHwDRp6T+iuecMdWx7o
    nj7jBoWmovohcLM4ckangVr/9NTxAZBdKgEEJXE/ShuS40CTDkm1PTxNMXsIZneVIrNtc+
    YP0jF47y+J8bJU/RfS7k4wGaeZn5/rp5UAv2tEyMAQrx5mBuiXa3CjLgjK6t3CHEGqxXZe
    T1eEe3lvMEpo/Fk94OS3o0HcjXst0Z70RTD/EAs8kgNXbZ1bubDAg+T10qSXFmY21Enj9w
    DIWiBA5scaZP3BKyAzYb5DwZ/JX5s9Vb6ywAXJJg/vN3p+rHyISlP+iH4TTfwJztD57BRS
    YB9WTksOQOCJAsoLTi8bCZbezgq4h+d092GaMN4hOxctbZ7rQSvVVL25eANyJAvqk299QU
    SSPP2q8yiR/o6o+sYuPNsq3TWnQX42LXd95yf3Y0c0Lu+qBc6MqaBlq4Jj9P1wyzSIL4ve
    B3jttRI8+2bzNtBBZjKC4ehlqENXEZypfPO5GWxk8Fo4WPEgtX4bwM/stvPA
X-ME-Proxy: <xmx:VVJ1ajpJe8RIXBV0FNLhVtFapN5ljzMIy7-Gm7ao2malPZt1KSER4A>
    <xmx:VVJ1anF_AecApSA2vCBFY2dfGnJR2KSRumqCzuVVGCdaja7tw5XPvA>
    <xmx:VVJ1avwW5XzFTyh76fDIfWiJCwJ5LmAfz0v_gV-NoDl8g-Gx-CYxYA>
    <xmx:VVJ1aspEbECcWhqhs2endSEW0_UlRcn46WJVsJeR0sbkcnD-l2fqoA>
    <xmx:VVJ1apkm5e2qJkYGSHZgwGjRg8omLtkUVy2MXyZ0TtmDN2ZmNnEjwHYH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 23:34:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2139797c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Aug 2026 03:34:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Aug 2026 05:34:28 +0200
Subject: [PATCH v5 4/6] setup: defer object database creation
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-pks-odb-create-on-disk-v5-4-399da0b0b140@pks.im>
References: <20260807-pks-odb-create-on-disk-v5-0-399da0b0b140@pks.im>
In-Reply-To: <20260807-pks-odb-create-on-disk-v5-0-399da0b0b140@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

In a subsequent commit we'll make the creation of the on-disk data
structures of an object database pluggable. This will lead to an
in-between state where we have already configured the repository's
object database, but it's not usable yet until we eventually call
`create_object_directory()`.

Lift the call to `odb_new()` out of `apply_repository_format()` so that
callers have more wiggle room with when exactly they call it, and adapt
them accordingly. The only exception is `init_db()`, where we now defer
creating the object database until we call `create_object_database()`.

With this change, initializing and creating the object database on disk
is now neatly encapsulated in a single function, which will make it
easier for a subsequent commit to move creation of the on-disk data
structures into the `struct odb_source` backends.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repository.c |  1 +
 setup.c      | 17 ++++++++---------
 setup.h      |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/repository.c b/repository.c
index 6d633002b4..5ec264e607 100644
--- a/repository.c
+++ b/repository.c
@@ -294,6 +294,7 @@ int repo_init(struct repository *repo,
 		warning("%s", err.buf);
 		goto error;
 	}
+	repo->objects = odb_new(repo, 0);
 
 	if (worktree)
 		repo_set_worktree(repo, worktree);
diff --git a/setup.c b/setup.c
index 5dfab3e79e..97338cbc51 100644
--- a/setup.c
+++ b/setup.c
@@ -1765,8 +1765,6 @@ int apply_repository_format(struct repository *repo,
 			    enum apply_repository_format_flags flags,
 			    struct strbuf *err)
 {
-	enum odb_new_flags odb_new_flags = 0;
-
 	if (verify_repository_format(format, err) < 0)
 		return -1;
 
@@ -1801,10 +1799,6 @@ int apply_repository_format(struct repository *repo,
 	repo->repository_format_precious_objects =
 		format->precious_objects;
 
-	if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV)
-		odb_new_flags |= ODB_NEW_HONOR_ENV;
-	repo->objects = odb_new(repo, odb_new_flags);
-
 	return 0;
 }
 
@@ -1888,6 +1882,7 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
 		read_and_verify_repository_format(&fmt, ".", NULL);
 		if (apply_repository_format(repo, &fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 			die("%s", err.buf);
+		repo->objects = odb_new(repo, ODB_NEW_HONOR_ENV);
 		startup_info->have_repository = 1;
 
 		clear_repository_format(&fmt);
@@ -2090,6 +2085,7 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 			if (apply_repository_format(repo, &discovery.format,
 						    APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 				die("%s", err.buf);
+			repo->objects = odb_new(repo, ODB_NEW_HONOR_ENV);
 
 			clear_repository_format(&discovery.format);
 			strbuf_release(&err);
@@ -2651,11 +2647,13 @@ static int create_default_files(struct repository *repo,
 	return reinit;
 }
 
-static void create_object_directory(struct repository *repo)
+static void create_object_database(struct repository *repo)
 {
 	struct strbuf path = STRBUF_INIT;
 	size_t baselen;
 
+	repo->objects = odb_new(repo, ODB_NEW_HONOR_ENV);
+
 	strbuf_addstr(&path, repo_get_object_directory(repo));
 	baselen = path.len;
 
@@ -2866,7 +2864,6 @@ int init_db(struct repository *repo,
 	repository_format_configure(&repo_fmt, hash, ref_storage_format);
 	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 		die("%s", err.buf);
-	startup_info->have_repository = 1;
 
 	/*
 	 * Ensure `core.hidedotfiles` is processed. This must happen after we
@@ -2882,7 +2879,9 @@ int init_db(struct repository *repo,
 
 	if (!(flags & INIT_DB_SKIP_REFDB))
 		create_reference_database(repo, initial_branch, flags & INIT_DB_QUIET);
-	create_object_directory(repo);
+	create_object_database(repo);
+
+	startup_info->have_repository = 1;
 
 	if (repo_settings_get_shared_repository(repo)) {
 		char buf[10];
diff --git a/setup.h b/setup.h
index 654f10e059..763fd384e8 100644
--- a/setup.h
+++ b/setup.h
@@ -245,8 +245,8 @@ enum apply_repository_format_flags {
 
 /*
  * Apply the given repository format to the repo. This initializes extensions
- * and basic data structures required for normal operation. Returns 0 on
- * success, a negative error code when the format is not valid as determined by
+ * required for normal operation. Returns 0 on success, a negative error code
+ * when the format is not valid as determined by
  * `verify_repository_format()`.
  */
 int apply_repository_format(struct repository *repo,

-- 
2.55.0.679.g6767b8d81c.dirty

