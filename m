Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD9F36B935
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 05:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932959; cv=none; b=a/jkK49QDFFyJF/dZ948MRzaA9Q0cVvo8L/ePW1SOzr6aWDzYqNcgFKFTZN9m3qR377wmIDxXXeO6aSAvBfyLwS34wi3fYkqhoTw9QGk+rNaW1MJuBF6U7PJmaqRUNATxH+fYPqZijUbu4SPAoxdOeJ2QukCuxRZhn2vEvmaJUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932959; c=relaxed/simple;
	bh=tEFscxPurUpjm7OVHQthxsQOMbZ66u2moVKvxlqFEH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ajcN24tXQuoa/pnZGTlqrc8vc1WzWPwsuKhANxUyDbTvoTxyeMVBIE5dW1S/Z4tdjk0sao3N8VnKcqngZ5AQSjdgivutUAJflwuIjzeKhYTuRFRRzdHe9Zm/v7TyulNXLFYc4txaUZp1/O9RTf+bu2OnaUYm+k1UkC0DII5m7sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AIn6Wd/+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qCvA9YH7; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AIn6Wd/+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qCvA9YH7"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 311CE1D000DB;
	Wed,  9 Sep 2026 01:49:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 09 Sep 2026 01:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788932957;
	 x=1789019357; bh=3Uc73516qUS5FLbiL38ED6R59jmGChi4RGt/2YOsg3U=; b=
	AIn6Wd/+vTPoO99I9Ej77rvxOnZDNWNgdDLFSFAElS7PljzjWMoelgCtJITGracs
	0AkwhERddqSQPljDmZcdUE705wlqVNp3wKsnkEvdYRa+g8edead3uThqhsW/onN/
	YlYsEFYOhTeWzvNUDwb8+0tSOuz04GBxUPMiKD4Kc15/iCrYsqOpMWM+R9MPrU7Q
	9V1jxEBBHgSnwhWISMPvMHxars34PC6rTT+T/Vkyt+Fefg9+ZV9lL3+Co5TybWbo
	Bx3tO/lvFxBNIONNV2Du4+i8TAGkPD5oKuoERWHvkLYMQDW8ylWyzpMlw/a3trdi
	TVnoshOhV5xy87eua7uiqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788932957; x=
	1789019357; bh=3Uc73516qUS5FLbiL38ED6R59jmGChi4RGt/2YOsg3U=; b=q
	CvA9YH78BKTNe4q3cD7waDBZcDbcP5bAy0mKpo+9a8L+aa1x8sendiTkFMVWmYVx
	Au85NMhOsCKw7HzfP3pPPwjc8lcWKQS7iOevWngavNapi9zdb79hN755tK1a1sru
	TQLY0rqdDeMfZsaDspXVPXfHJ6zhfBFqcGwbA1/LZx2Y1/XjiJPudhBc9I2QYZ7J
	RFMNXmrWJ7EIbMV+Zaso1iO2Khp4mMvmz9NXts8yQQdHlEwMlKI4ZLqCKR0rqLBy
	7tTITKR1LY/Sxc+uhAhqKrs1GOcQm4p/J1MXjsU7QhqxHAwMzWuuZkryyQYbkf6P
	O26beLthbSwnnROB/J8fg==
X-ME-Sender: <xms:XPOgapPVZPsBPJZhkSHYjjCcRYkV85a6ljpG8KQZUcR9WRCZli8aUg>
    <xme:XPOgai_Cg2LQHrbLncTGAYK27PP_qX--seGg1oUINRI1zE8wnDFVd68ExRicxgN73
    v1F5cRsY0oaM7nWUZtVstuBZY9-2crAl9zU5btXsClieBs8LQ_TOc8>
X-ME-Received: <xmr:XPOgatT1zYV-imhzWktlH9GMlinXn9gVyIujo8jYQxuDGUOGEWINTJIPYormUjRP6kKXdw>
X-ME-Proxy-Cause: dmFkZTEO5N4/wRkUGETagV1iliwdFQpV+cs4U6YeYU5TvgMv/ATqJVK1f27ZFzwKVJOUS7
    wCoSru23TiKYHjTDNxQCgu7q4blsVPNJ+eUEzb5tjdqyknI9FyFC2q7Gsy/D7l26beIyVQ
    HHxlURFw8VEPIU0sxcuIuxpsH0HJwr5SAPAPnA94yxCdm5eo2gHVmCUbPKybOiJyBDC8W8
    wb5V7z8SQaRPfUSGu1Rmp1BwzrA04ODauUynmPX0aRXAER3Xzd5IgC6MDE2giTOD4cpMts
    0+5J5DPPtwD9wzjKGVG+sm9ORLCw3jBqNzMMFHGbjCtu69MYnBOEiGgpW0BzwPH4QgUQnF
    tkUXeWNjXa3xjTbO/mF7J2xSg4ySEiYPOrdv91sV2aPfAD91ptyvriV7Q3qhgZm3VYn16g
    M2xk9QASh1mDcJX662q8W6LnsxoUQjQaLFwYiR54ss5Bp6t9HTpDFYTcgOv9IelvMR11SF
    cDM1dh6CWdBRifCzORKR2WD/9b1G+K/GgshCA+iWAAUFWSnaxtxwHFRzfhSxy7frFSvQdS
    UehZNhwfaSyxjDcKtekiIzH9RZ11kLqR3Tupg7MGIVLyUyKDROytWVEfcp6ttQ/eEA3TvR
    vxziN7J+gzbfzj9GJdfnd/tDpkfH40exZ+UpEuPj1QpleexbftSFhBFnmViw
X-ME-Proxy: <xmx:XfOgakkxHlRW95-QOZYgS2HcqBZV392UQ3pvErj-Vdf5mXnMlF4a4g>
    <xmx:XfOgatTHr1sRPVSo-3IYO7_Qa9buhrUMl3fPwMGYl98q3RoKuCt0Ig>
    <xmx:XfOgaiPbZlXQ8V6WXms1PthyFqnizQdUEsUkwl56XRXGkIjbFwV-zg>
    <xmx:XfOgamXT26tcIpF16bZFU9yu5QfcQczVLFzzIY9jiCRAEHbFCfUX3Q>
    <xmx:XfOgalQ1ndWwugsK4wBu_Q_v9_s-oPUGRwxIrVEI9QsRE87ADwqGmHkS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 01:49:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bb343dd0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 05:49:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Sep 2026 07:48:50 +0200
Subject: [PATCH v4 8/9] builtin/clone: write alternates via
 `odb_create_on_disk()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-pks-odb-write-alternates-at-creation-time-v4-8-d8a78ffc32e4@pks.im>
References: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
In-Reply-To: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
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
 setup.h           | 6 ++++--
 4 files changed, 11 insertions(+), 9 deletions(-)

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
index f1c1ed65fb..27b2492373 100644
--- a/setup.h
+++ b/setup.h
@@ -291,9 +291,11 @@ void create_reference_database(struct repository *repo, const char *initial_bran
 
 /*
  * Create the object database for the repository. The repository must have
- * already been configured properly before calling this function.
+ * already been configured properly before calling this function. When set,
+ * `alternates` is the list of alternates that should be written into the
+ * object database.
  */
-void create_object_database(struct repository *repo);
+void create_object_database(struct repository *repo, const struct strvec *alternates);
 
 /*
  * NOTE NOTE NOTE!!

-- 
2.55.0.1074.ge7621b4bad.dirty

