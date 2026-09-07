Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8857343F0B7
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 08:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769571; cv=none; b=S5GjG0dJjQLJmX6k8bcSubq8xvyV6nX85mc3BDqHF8YJlbRgZnpmfCfHynMncX58XoyC31qlnx9khOMpatp8giVp9YDATS0w4MV9toJAhGOgUV+2+NlZb+LH3HaQYt1he9rgjFkM8DFsoHRjUDxuSo0Ks8qMJAesrae3Rv4J5+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769571; c=relaxed/simple;
	bh=Gy7ohZHA7xOHHNrUCgb2tpGaU6Z1BqKk86qSVL45j0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EnlQ16iWnRgmVaZGy+DCPcoi+fZYfwfzvPUHOm1ZPgo5Q1xJlN9VNZf6tPO7iHVEbNood0JcZMHMz6iAIUjQlUGIO2WW9ezaxLkD1scP9QSX4Lxd6XRkvEE3pasbfDOUIplrVHdb+eucj2MUBSRxUhLok9qcryk5VnZpaJ6lxgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R0rSOXux; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KSxSu3ZQ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R0rSOXux";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KSxSu3ZQ"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 85E911400212;
	Mon,  7 Sep 2026 04:26:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 07 Sep 2026 04:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788769569;
	 x=1788855969; bh=hm1aBg5b9C1FuyGuCz8UR7FsQ9j8FFU26nRTkYYrwio=; b=
	R0rSOXux121RCSweEQcwp48OelOtqXEKrgrdpXLGz0drqAVN4WELYt7G53L+OP38
	P5T09rxixJl0tTmaZ0s/wVhjfjS7tT8eGOposOfo5mOuo+yg76Kqgyg8bwZJIZim
	KR1LpgVAGE18xmT7oY64i2ORnhBhh0oiM1q0LOEU5pngkB2NtSXpSqlH/Q8YP9xq
	71kLEmnBvOXlE+GZVhW6bEHiSbJb4wNtXhaWEgrKEBxwiZ+o6dWwk4K/jWgXylVQ
	Cg4ZDf6wwJRwvOWQFD8/czS9kj+KCWYfjPU4X8Bs/KbJoBxvtm1uDjOd3+SXh1q/
	3AvFo3myPl7gNckVV1ZUcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788769569; x=
	1788855969; bh=hm1aBg5b9C1FuyGuCz8UR7FsQ9j8FFU26nRTkYYrwio=; b=K
	SxSu3ZQ6N2CIwlLQ561L3VNWIC5G/6HvsoA7cJFCMhQ8ltllGMKey7+Jb9kh+jVr
	DykY2zM/nPIi99OKKVR+JQDL/BSetDYTO4Ad/kkvL7NMLiH8lkLosVmq5zzun534
	0u8L+q6qn9jAQpCzSAePSZM5HF6kqQcBeuvRInjOCTW/cLt3f/LSfUrl05v6HD12
	bXY1iykD2H0OnQIx+FO23YLABeRoOL3hz5hXoh8tiqvlNqO93WKnoOwwV8PsNfCi
	B96UbDap1mpa3Ykqg29OdXp7Nx4ysEExb2S1c00MVB4MWHfMGFt7Da5kwyQ2rJ1g
	SDJNYN6zRVqzxbLt+19vw==
X-ME-Sender: <xms:IXWeajO9J4TonhvhJ7Dd5KB0rqYi8U6ksQG7zr1ltYTxVPlmVcB7qQ>
    <xme:IXWeak8hGgFXqxC85Dp4y1pnEuwNU93Z5kuCIYc6IYok3IK57z55g49XkSChquOBk
    BkzMJbhnRX7T_CUMZW9FNd_mbtkWl_L42dOQF8pROi_iRQC-Cswyw>
X-ME-Received: <xmr:IXWeanQ2y5Zd72wq1cuL8do_H9eHk9y9oPzPNdZdyVCoK6-jFIH3hA>
X-ME-Proxy-Cause: dmFkZTEKi7Tq2gM9kI04RZ7AxwxWYGlFfv7IpMvr6TFJshIykzk8cWZwrnl2r9BRAgYCGF
    svyVZ24paJqQTflWYnS1XUi6nxhcg5aUaz3lDZ4sP6CqkSSsvJAX1vGa1llKApY52k+tIp
    JUhgwCy9VKuEXQHpTZuR3yuGFLdoJIv1+RvEwC+02R4TGFHBGTVtLukA9AAdLbirgc4ORB
    9s5H/S5ZFboEvWTNS/GztHbTHvYByFqFeNQnbZtrMmRajkT54bqptIl/+dJTuh+le0o9LT
    EBAxQx9xRD0nrN1n1n1kdpD/T5PPCxT/87kY3rpi+OwggpbvfFnU8sST591vWsinZpqBTY
    jzWkyd+cScXa83RPla0awY5BVjJFcNR5o+JevAS2hNG3XSfO9HLxsKm1jiQDkFwA8NTL54
    YHVyaJSz2DJPBBnNTt9lQ7kf/NY7FsYy9oiDMgsRVReXHWXzxyOpgawyVIODkdvrqPhO4J
    ScjbvdKANgC+HM3DKJfYzcqMBpZofDOiyQNYa4ydWGHb79VFg93z6rijDveP77AkYDF1fA
    hmmbskMBTppfuNgqZJEMOD7hOZgdf/6urr5eUr3LnFw6myoKWHDzBukHUH86KsSVLREec4
    WM4Vuap1oA8lq1EqGXeHJ0bc6G2ST6Hsk37dTovuVq/uAicTHlc2dQYgOvKQ
X-ME-Proxy: <xmx:IXWeaml1gmuI6m6QTolLcuGLIBDfvOVvhkFkqEP-p44FAv6vaXOUPQ>
    <xmx:IXWeanSJFfTMEItI9VDlm_-EjJytB8J31MC6u79WmTAViamySJzKIw>
    <xmx:IXWeakMMMORaK6E5BNkn2_40mDYytcIBUzyyzzIGVovvimRbHoTGUw>
    <xmx:IXWeagV-KEOOgdj_YBEHmkZq-3qKkMSUaEPKcvz5hOn0ScDkrzEyJg>
    <xmx:IXWeavQbZcPk7O9k1w1UxurLIOg8pbpFHLW4nn6yw88-S5Wm-O2uCxuN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 04:26:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a5887663 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 08:26:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Sep 2026 10:25:45 +0200
Subject: [PATCH v3 8/9] builtin/clone: write alternates via
 `odb_create_on_disk()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-pks-odb-write-alternates-at-creation-time-v3-8-735d0b5b3e00@pks.im>
References: <20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im>
In-Reply-To: <20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

When creating a repository with alternates we first initialize the
object database and then write alternates to it in a separate step. This
is unfortunate due to a couple of reasons:

  - It requires us to have a `write_alternates()` callback, which is
    unfortunate as we never even write alternates to an object database
    after it has been created.

  - We're about to make alternates an implementation detail of the
    object database's backend in a future patch series, so having this
    callback is suboptimal there.

  - The backend has more flexibility with how exactly alternates are
    configured when it itself is in full control over their setup at the
    time where it creates the object database itself.

We have thus introduced the ability to write alternates right at
creation time in the preceding commits, and we have unified setup of
alternates into a single location. All that's left to do for us now is
to wire up alternates as an option for the database creation.

Do so.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c   | 5 +----
 builtin/init-db.c | 2 +-
 setup.c           | 7 +++++--
 setup.h           | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 84c1317867..9e84646845 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1364,11 +1364,8 @@ int cmd_clone(int argc,
 	if (option_local > 0 && !is_local)
 		warning(_("--local is ignored"));
 
-	create_object_database(the_repository);
 	collect_alternates(&alternates, path, is_local);
-
-	for (size_t i = 0; i < alternates.nr; i++)
-		odb_add_to_alternates_file(the_repository->objects, alternates.v[i]);
+	create_object_database(the_repository, &alternates);
 
 	transport = transport_get(remote, path ? path : remote->url.v[0]);
 	transport_set_verbosity(transport, option_verbosity, option_progress);
diff --git a/builtin/init-db.c b/builtin/init-db.c
index f2c7e3be6d..5c22eae2f3 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -251,7 +251,7 @@ int cmd_init_db(int argc,
 			  template_dir, hash_algo, ref_storage_format,
 			  init_shared_repository, &reinit);
 	create_reference_database(the_repository, initial_branch, quiet);
-	create_object_database(the_repository);
+	create_object_database(the_repository, NULL);
 
 	if (!quiet) {
 		int len = strlen(git_dir);
diff --git a/setup.c b/setup.c
index 37a8e6f124..17d0d25973 100644
--- a/setup.c
+++ b/setup.c
@@ -2647,9 +2647,12 @@ static int create_default_files(struct repository *repo,
 	return reinit;
 }
 
-void create_object_database(struct repository *repo)
+void create_object_database(struct repository *repo,
+			    const struct strvec *alternates)
 {
-	struct odb_create_on_disk_options opts = { 0 };
+	struct odb_create_on_disk_options opts = {
+		.alternates = alternates,
+	};
 
 	/*
 	 * Create the "objects" directory in the common directory. This is done
diff --git a/setup.h b/setup.h
index c4aa464caa..e9941c6875 100644
--- a/setup.h
+++ b/setup.h
@@ -270,7 +270,7 @@ void initialize_repository_version(struct repository *repo,
 				   enum ref_storage_format ref_storage_format,
 				   int reinit);
 void create_reference_database(struct repository *repo, const char *initial_branch, int quiet);
-void create_object_database(struct repository *repo);
+void create_object_database(struct repository *repo, const struct strvec *alternates);
 
 /*
  * NOTE NOTE NOTE!!

-- 
2.55.0.1007.g17ff1f9808.dirty

