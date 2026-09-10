Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911CD2EB84E
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052984; cv=none; b=ezZpQI86JlSG1Hn+GW6R8rCQlJC3nOb8+s1EGKM0Px4KM0SVW5WGzrvEswmeIzIJkn/da3JJUkNupj8ucM1PNaxuOvz3bHiY48L+LhCyu8F5jvsbShK1e+D3z5ghJQmsxIYPl/Q2/qk54HEyGMrd0SuM358jQVj83YChEJfqZ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052984; c=relaxed/simple;
	bh=4NxWbQqSvgjQXKkXKMdDAKjX2zZRsg841/VZDU4H0So=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VDcGVQI+es2st3pMdsgk6zbtwOZOuqjAJEJip6CtbXc3bLEE95X6Mr0mUUx0eJcRTJufzFnJQUI4Ptlo1XjnSMYq6ITxoUo34NNA7HbYkH6bs9K1KiK7IIqHDbVmkETfspSBC4AdOK2e2adxkmRlkf4Y3aT6lFrwWRvSYXRcTxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AZUvsoFB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U9aQONR/; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AZUvsoFB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U9aQONR/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3454CEC01DC;
	Thu, 10 Sep 2026 11:09:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 10 Sep 2026 11:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789052978;
	 x=1789139378; bh=v/ZBJK0rBX3/vJj3Ll8BCKGnBS6GcaVBq0d97OLjNcU=; b=
	AZUvsoFBaOu1HrWxH1AYSOUS8wdj9ZmAOP4q1jSJAqOFIEq63QVqRPpWVWlNxDWR
	hf2mAjUOm9DbIeEKkK9Bd0+fXDN9EqVHHafDeM3esVvq5WMxIKXHHoOdxhwJ+F+M
	yerrSa+BJmhZkRxctbAsKLy3BchArPpU4Np8TM/6FSiqE7gQLhYuxogvOI8VaT4c
	qPRmVvnJXSexNPcuAy76+Bfa1GzjeJSqRJx5sKW0NvUZzeN+7crqfk354SQkDUqx
	eS8Euo181T+PCzZT3BopC1d0ov8E+z1+I1XiT4S2bA+UTvY1x5oyp7eYqyCSs96D
	U/rQ7ww5XwZz5KO/llUw9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789052978; x=
	1789139378; bh=v/ZBJK0rBX3/vJj3Ll8BCKGnBS6GcaVBq0d97OLjNcU=; b=U
	9aQONR/WGcu+tzk706c09o8a9KSs/++DR4B1XnP9wWMahOwH+HjW6ANU8L3PSIr2
	h74NPi9KCT0oRIpcpZ6NSmINew6k2yeNUvx6r3yK5FQvKSYueRrMR1kmwEpNuSNj
	/Vzj5P5e83dK54gnfZEbUSSYCZqz2KjpoLu1a8pTDSTUv+6Nom2VhenB8JsXVT8L
	7C1CFk28LWRBVZslyTP79N2rDqKHx3gGflXHxQwz6maoouIyDeoGXPcncCiaTN+C
	UG/pIXfvQvBE/RELxj8y/n/3/4b/kBqK83U6Zq0ZuTrV0w+/Zdc2tpLF+tBahj2e
	0Bd3lWC1AU46F5rXqV3MA==
X-ME-Sender: <xms:MsiiajGw7oz85Ah3uPKXCOErT9hi2omiEv_T_Oy2ngVv61XtFtHtnQ>
    <xme:MsiianPxRXottsmSCV033TJh3YwG5UjYzeFZVvt4eFFLIitbK6FficNhfbm_iNWCn
    6RWOvGfAYhbVmWAmGrwdqpu93cVcgwI753Hze3jW89MmM-caBai>
X-ME-Received: <xmr:Msiiateyy9koozR-zIL7b6lK5CVCRZlhFQHOoJmSHZxf-lg-BTpRSg>
X-ME-Proxy-Cause: dmFkZTFjMmORKiXYV5v4c7NqnDJufwejPDJi1cfPFm3mx0u8apQc0AvUhXFmyzPKLwg8qv
    gQxPujDla2ha2YRE4ueBGSHTp2xHkvls64y8wjIVNLvc9l/sEDZfcXZap63aj3KkvUT9tA
    H2U0ckPWE/epx57Ag4Ss/N1/kA7as8GrJQMRCubUFIbNx/x2/MBs1looTD1hAugKQeEImK
    WDDPtry92G1OoHWjevAppdv0F7IFYLEnNTxCW6tl/avjrRnkRSojpVwSaHdeKJpTM5NZO5
    tVPOhv3o3xBm0EQ9pB/dAdKzLgiyjpPlwQRjb18DWYa10wiyqKzjezMdYFE0HJJO4z6vmO
    XKYDMvvblPggvnh3yWmCIpNdyuVLy8YNNkWgd6vsKfjP6U45/LHSyfbVZopX0RJdEaH0r/
    pWJkDCkwhtW7ND1ilSKiY0br+WM74i1ja20KpJ1eiZKs/L+Je9e73cECE8Lqush6NayuG6
    ydaKU1sHYOP5s+WRNHBuv8zMXBBn26i8T352oCCVhwXBJumdVKVEvbHJwesXZefTsbeBAq
    DwTwpgg0lv/khuJ07G/bCsxN5JnexNWYfqkcBd0/E+sGRFmd+ZsNllRnqSUo9gwaqM+3W5
    ABTnoIFBUm59qatmiSIGkaq2QN0eahTg0vMXf/7NRABZLKvX89+glSkxkC/w
X-ME-Proxy: <xmx:Msiiast5PZQhRkAX35Ttv6JOvmjBcPFWj4QSRIeQN8kTHgP3ZpT7Rw>
    <xmx:Msiiamn60t8w1ZclZcEQYcTfIyRX2KPONdBw6hdAFXrnVNGLBfeZhg>
    <xmx:MsiiamxOl8Sx5GKzIoc5A_XQqopEZYgZaG7HxPFdwdXJDasmvB5n7g>
    <xmx:MsiiagO0qu7xRS9kc492HcZsS72tAaZas_BeNq6bXnpcRmoVUWeImA>
    <xmx:MsiiapJbpmzTbadhvFAQCVPlYAldfgktoE1JnRWRWj1GswxisWN7huMz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 11:09:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 379c93b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Sep 2026 15:09:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 10 Sep 2026 17:09:18 +0200
Subject: [PATCH v5 8/9] builtin/clone: write alternates via
 `odb_create_on_disk()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-pks-odb-write-alternates-at-creation-time-v5-8-8d10c4238edc@pks.im>
References: <20260910-pks-odb-write-alternates-at-creation-time-v5-0-8d10c4238edc@pks.im>
In-Reply-To: <20260910-pks-odb-write-alternates-at-creation-time-v5-0-8d10c4238edc@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
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
index 17353a8e1f..b14264c33a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1364,11 +1364,8 @@ int cmd_clone(int argc,
 	if (option_local > 0 && !is_local)
 		warning(_("--local is ignored"));
 
-	create_object_database(the_repository);
 	collect_alternates(&alternates, is_local ? path : NULL);
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

