Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF5938AC72
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302076; cv=none; b=UnHcEMMkqkAaWyq7bFzFoOML0sgp0wd5kTApFY2pWJLeCYbkftXOn0sI9eipwveBH87K4g1MLamw/WYOPUH6PJvf3HD01gSvrRfzcoILvfFN1SE7oWy2h7fewrk6fvxosQyQue+GHzK62ZORZZp2Ycf785061DykMlh2Fa5f/0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302076; c=relaxed/simple;
	bh=Mu9dGWRFo51B05NfqpOitqjsWd7xG6c+hyTu2a0M8rQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r+JKIgTwzDVFNjbltrWJlHeMRPe+QGzH5eIZzqfADWLxeh42g+1QLPpb6tyCBlxFrIckOQWXKeQYE9zaUlBfgNBq4iY54Vg/cQJLtozKubW6tzrsLQj4E8pSwwkfPsJoie9SalKR4YTx/ySdaX+nGl0ELPXw8gywn1u5AJIoTW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T9oYRaBf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RkfvCKRr; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T9oYRaBf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RkfvCKRr"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id DE63FEC0087;
	Mon,  1 Jun 2026 04:21:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 01 Jun 2026 04:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780302074;
	 x=1780388474; bh=Mli6D2kKv0JG2Mz3CgFrGE91ii+ZyafB9en1iHxgP+4=; b=
	T9oYRaBfCsa9bZ5mGy+OtV175+mn5Hk5sg6yxGTaFhmlSOLeiqM/XmX+t5Ra9YxM
	mvhRqNFvw73C6faAfylIfCxcScV/ZSNga4qd/XjZBYKpH8x0azVguz6mSzlpYxvI
	c1QC/MGGeBdDPkbfV/N/vYAASSd3ImTKbm30USWheO/2ZN1NtbvG3YqB7y5pqyfG
	d1FN6l87DoB5B9QTXCTCKAJGJtHorZjwKHKiGISRvXecKhV9ta5xir3qJsxeC3CS
	hDR4JsICcVAGgnuI3bNYlFL7UpAI3E2Tbh8B/bg85JT+rOZYr2MTAcVCrPH9/f4w
	kIVRBczX4bdDW/XmchII1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780302074; x=
	1780388474; bh=Mli6D2kKv0JG2Mz3CgFrGE91ii+ZyafB9en1iHxgP+4=; b=R
	kfvCKRrcFfsTxIgb94wuNl419rE4xjYOPVq7weLMbbJV/q20oZLTDcwRPMBESEpR
	e9K/SfYUMSm89xk5aarrcyvesrS+0I2DOz2y4yqP9grYijxCfN3lmwsmsCHrvtyA
	Z4EoKTt+OXC7YNcDlOABx+khsKvyrYRM3Cx2hRrv2uLaimi9zdCDYC8xhOUdCexW
	sEuXz+oRCzh/ebnt2zu3+YJW3uteLHwitQ5r6gcBYL5s3OFvsLuKDEMbg2R1BhTW
	kaDx1P1KZ0gaOiN4y6/3G1d1EqSjWLvBH7jQkkvgU9UBIUSITGvbDdsAkBMG34aL
	+DD/cczM/lSdGmLFXQ3mQ==
X-ME-Sender: <xms:-kAdaldzAzqPQXpy7B9FcYhEr7pjWSI0mIvuEn4lhjNOxnLhjXvUpQ>
    <xme:-kAdapPl32srQ4P_NtrqQGYXuEovuO36fZ4msQZhj-rBEuWQxxMEZhglphZXNG4JZ
    vvoWEkVXhgfxyp12EChWfdGCy_Bcl7dYJJdrNXjZvrOC_eDGj2fKA>
X-ME-Received: <xmr:-kAdasLHY2gTTOJ8M8GS514o9x7al4IbUYwRTFVpi6HLl9kGiDcryK1W9dLdZDEjR97SS_mIRwkwZxNPkuq1JSQ1PmrHTx5fv-Glznlmbtlo>
X-ME-Proxy-Cause: dmFkZTF/3lZmQQwRdo6r+/fq8Smu+TwPVjvusxOBlavDLDIKjOJTF0mhx0PG3iRklQkuoR
    KybjvCZPyO5SLx+jbyhiK1BxFKgNdbR2k8ZGSaFuyqUYHwVzjbLxF0siLqxUSPxUbv4eNJ
    fV/lE4dC1z3Tys8YDo8tTlPo9a+DjaLVlDKReCXCDnes3wavR6RxAtxK9bLYxNNBcfChN0
    cv/ue+bQVlwkgxRxjHtpGk+YIdLNR9QVvw+cXDwukaHE/D4I3Jh3nQWCnkzs/U/zZw2aq1
    zOcyNk7IpwfHg3hcwEvbyg47DbUpdh0sWb1JmQTGPiTRGnO0qJer5wnPycvCGDmaBWnDcn
    eK5CYYBRme//aSjIQI5lgaqU68VOOlnCtj/nisM5jQyuAAgtTgkCUCL5Ir6cpjJwTvitOY
    CXb7sRA4eek+3yaxLhLDtFjVaPC6IodfhdwQ+uvlHuwelvUZDtZb6962xAM8xxz1I78SSX
    MtZD/iyLuwYsP2sZHpZxPt6wtzZBc5ORo+GlumnGsera+RqxBVjJ2u5g9dsxbyzBU0GA36
    0XqqEUNJPP97zJKJfjF4lvmM1sp8r9BJHV5TYGbfgWHXCyFhDNDiogUUGqCMGRrNZYfFng
    V5nmFottud71H8j/QlpfdLk77ovLgAed5tJIAEIqYdfwwihx3NNKMhYzeBMw
X-ME-Proxy: <xmx:-kAdaqGipqJFnKUuVAb6kt_I1G7CYAkk9e_YXq7TGQMHg2ki5E15hw>
    <xmx:-kAdakRiQmsaWb-oIAJ1JBVjG2JZ7r2ObLK1wvDglHlR8ws-zzxW4g>
    <xmx:-kAdamHa1HvB0nkWLk2scmESXy6NzhcrwsLgCl9hVHXj8MfHF9bJ4Q>
    <xmx:-kAdag_U1EBSsTzGuNMHyBH1ITSoZW4dQRE_xBI1TWmtOiEbRJWiWA>
    <xmx:-kAdag35n5T9Hml67y5YnOduMZgAV1xc7SRwaOSZGY5ENypQuH2OuZKv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 04:21:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e93bb7c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jun 2026 08:21:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 01 Jun 2026 10:20:41 +0200
Subject: [PATCH v2 18/18] odb/source-loose: drop pointer to the "files"
 source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-b4-pks-odb-source-loose-v2-18-90ff159430af@pks.im>
References: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
In-Reply-To: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Now that all callbacks of the loose source operate on `struct
odb_source_loose` directly we no longer have to reach into the "files"
source at all.

Drop this field and update `odb_source_loose_new()` to instead accept
all parameters required to initialize itself. This ensures that the
"loose" backend is a fully standalone source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 2 +-
 odb/source-loose.c | 8 ++++----
 odb/source-loose.h | 7 ++++---
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 83f8066c67..5bdd042922 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -268,7 +268,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 
 	CALLOC_ARRAY(files, 1);
 	odb_source_init(&files->base, odb, ODB_SOURCE_FILES, path, local);
-	files->loose = odb_source_loose_new(files);
+	files->loose = odb_source_loose_new(odb, path, local);
 	files->packed = packfile_store_new(&files->base);
 
 	files->base.free = odb_source_files_free;
diff --git a/odb/source-loose.c b/odb/source-loose.c
index e174941318..7d7ea2fb84 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -705,14 +705,14 @@ static void odb_source_loose_free(struct odb_source *source)
 	free(loose);
 }
 
-struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files)
+struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
+					      const char *path,
+					      bool local)
 {
 	struct odb_source_loose *loose;
 
 	CALLOC_ARRAY(loose, 1);
-	odb_source_init(&loose->base, files->base.odb, ODB_SOURCE_LOOSE,
-			files->base.path, files->base.local);
-	loose->files = files;
+	odb_source_init(&loose->base, odb, ODB_SOURCE_LOOSE, path, local);
 
 	loose->base.free = odb_source_loose_free;
 	loose->base.close = odb_source_loose_close;
diff --git a/odb/source-loose.h b/odb/source-loose.h
index 4dd4fd6ce3..6070aaf3ce 100644
--- a/odb/source-loose.h
+++ b/odb/source-loose.h
@@ -9,11 +9,10 @@ struct oidtree;
 
 /*
  * An object database source that stores its objects in loose format, one
- * file per object. This source is part of the files source.
+ * file per object.
  */
 struct odb_source_loose {
 	struct odb_source base;
-	struct odb_source_files *files;
 
 	/*
 	 * Used to store the results of readdir(3) calls when we are OK
@@ -31,7 +30,9 @@ struct odb_source_loose {
 	struct loose_object_map *map;
 };
 
-struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files);
+struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
+					      const char *path,
+					      bool local);
 
 /*
  * Cast the given object database source to the loose backend. This will cause

-- 
2.54.0.926.g75ba10bac6.dirty

