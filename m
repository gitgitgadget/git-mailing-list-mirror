Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7F6155A5D
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 03:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786073684; cv=none; b=qtq3DAP/clWoU1e9PB31zRy/Nd0/UgNbgKN503OzlvaKUQTaeTNeIp5QcpVV7AJoDgnwa+72EBKL2jjP8+4lE4YY1emX8ffWtffd/QWJIBd3rvyPDVCVDGEOdafFf977QuBVKiH2b6ZImErsPzUNdCd5d93cqgDoDTrkWW4pEkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786073684; c=relaxed/simple;
	bh=MSAAlKp7NkFL2beKxTUQiurWT506aBXPFP+fsNOEQZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j9K3jEDygqq4BND9g6IW+lzKHa8KEKJtMePyyvgzU0lTaGMRKlOW+dKyXfJTTALh8u0DUV8L4xqh/rXD7UBaW7iINf0HnveSF5rDg0N85vWkzn+wCfmD1IlURuaVLbHtUKRXE4oIO2Z1mxUbW+5YJTomsSnD7YnURiXrGOTi2x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A1ypZ5AB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eM1b4RPG; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A1ypZ5AB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eM1b4RPG"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 615C214000E2;
	Thu,  6 Aug 2026 23:34:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 06 Aug 2026 23:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786073682;
	 x=1786160082; bh=m4Wf5OMXb4hO3m0OWgXPtNXkpGG3jWn/phbZPpHlZbM=; b=
	A1ypZ5AB5JuHXcFB0eKOvi2k9ZQEWZklZoWh1AFAeuXo7dnhJqr1YXlQU7ZigxxW
	0JVk7bYx/Z61e+ABS9v0BDpQLJZUY5Ed6+S5TViwJDHuWh0ansO3JtN57p0XNXqN
	w24XoaLdt+OXOEgJKWnhjcG7492FeUlo8FVWyV+/WHepcLxYJ3Hiu6DNL84Ylaii
	Qo8MKOSf4wDn7H4V5qfsgGuGg+inH95UEws4C735255yAzbrhqQeTQB0nAI4600w
	RfO5DpBFttI4yVCVLhlwl7ZkqNix+Wh4kBoVpu3skwFNJFtXJjeXgvBvR5LHNxup
	xLveF7HPKSmpxd7iPfqCig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786073682; x=
	1786160082; bh=m4Wf5OMXb4hO3m0OWgXPtNXkpGG3jWn/phbZPpHlZbM=; b=e
	M1b4RPGy1lwU5mPpFkkP3yy0OgFjddKk1HRXY3C8bWOKXqyPT12nZ7RQ9Xg4BVEk
	+fudJftTK6fRnRGsu7jOM80odo02u23aWL9WbflBgOexDZGi1aVrVTX6HrEYpY3X
	dEuf1t93S1hPUyEIXft67v77hCsGY3IdXRgHz4Opq5UL+0DHyV1GjoX96F41BDbc
	qOv/s/yQn4l18GE7Ll3YbiBxHi5lUkhNleV0yjkcOTA1rc+VmgEw2ApnEaGtMYBB
	LnSCeXUwFZVOczIUMITNoDnFJYXtb7+1WiWxB8h6q064kwhNFOTPznGUTZOwhaDI
	T2/F3IMUNtrtTQ+yoAZnQ==
X-ME-Sender: <xms:UlJ1akEdsb6PQ1UokWpkLRuxqymmLJDRp_21Ag5wvgrFX6sTqMqrsA>
    <xme:UlJ1akWbzArlCOYPgFeVvj_HGxhNXjASH8hfWHR_IcSCOs-hta11H--6CzkdGZ0wF
    h7VblEAe3ofnanZU2GjJHIMMblKA8wOKBajGIn6I37EyTC8i50-iw>
X-ME-Received: <xmr:UlJ1ajIoJNQ2x6IZ65mfMUON5INrXT87snzmhjjwqd_UnbF1ewQSK0CguaY3v9bddAZYS2OSDn85tk9MAIPgnBRpJiV5et8iT_TbRJvLRiZyOg>
X-ME-Proxy-Cause: dmFkZTEpJ905ceLpBayWX3K2xVuN8Fh1ASrLmuV2ELTMgG3mN72dqwQxgLk/YynA6mFzg0
    SQ4rtEnAiObF5tEVbP7SWB3+bUXupi1PvQkc0BTrYbzX75eRXbqnWS7gT0DmJnk9oY9kmg
    pD8oQGpDty0BfvIeEAxm7l8c8JMRsikMp/XKYk+OfQPq6oR7PopW3HHuWF4HSB8Swgyw53
    6P3RLVSpe73JATfgyBkVFZtqronx1xCTHL2R7bl0cLRecjhfjZbak3tOxrPx/4L3iqcEXO
    ZwRGzCN6elqPG+n/XB/wQjyyRHo77WEutysjlIKAFTNyCUt/WRfZ75jkGZ0MagrmvvDJE1
    EpDb6nxIsyZN7rQinBftGhFJIJ2wBcYQ0cCl0AWrPq5RwjxtynXZOLLMfBExdMfyvMqEan
    6T1PbEVNaSRed4pjkOyza2QHcSbqYju26Pdet8mwKrlifz+ravxYRBe/oWkLGsBooO6PU5
    AdQfq6V76Xh0cle+YdHGurccFYYNrwRMJiOEJfY+Ffg75CxL4SzstrS+NwT1LB2VnIdc1U
    Ddb+Z1I4mOPYOCcWpDoZ86lGKijf2a6TtQeUT3aOTc7Nclvb+m3XNHgE/oVwnt6hOuv1dX
    d9NPFqo/4MfdfoS3sE7evujZJaj9VYUGPb7pXA8XpcPO2hlnlw//pxGP5siw
X-ME-Proxy: <xmx:UlJ1ak8XuhLUDrpWsFiwuQUv2YneqoW9aixseH9bIJkJEWzxQQaZQg>
    <xmx:UlJ1amIcQtaUqPXsApetxG9cXwsnDaEd2Mmm3QiZF4lJSM4WSioQMQ>
    <xmx:UlJ1aplvlBSVfFGBf1l7_-OeL_llkgWl3OewIYSmhYes-QSVClv3UA>
    <xmx:UlJ1aqMNbjZbu36E63Z9I-OxATRSFRCVo8aInLJYqKYfQZx__ODlVA>
    <xmx:UlJ1atLiiARrEUVvR4jr-YdzQ0py7YwDf9KNt4DMj4Jh2i2w1RB4fRxL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 23:34:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 74853485 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Aug 2026 03:34:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Aug 2026 05:34:27 +0200
Subject: [PATCH v5 3/6] setup: handle ODB-related environment variables in
 `odb_new()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-pks-odb-create-on-disk-v5-3-399da0b0b140@pks.im>
References: <20260807-pks-odb-create-on-disk-v5-0-399da0b0b140@pks.im>
In-Reply-To: <20260807-pks-odb-create-on-disk-v5-0-399da0b0b140@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

When initializing a repository's object database we have to respect the
GIT_OBJECT_DIRECTORY and GIT_ALTERNATE_OBJECT_DIRECTORIES environment
variables, which can be set by the user to override the default location
of where we write objects to and read objects from.

This is handled in `apply_repository_format()`, which is fine. But in a
subsequent commit we'll have to defer constructing the object database
to a later point in some cases, and that will require a second site
where we call `odb_new()`. And of course, that second site would have to
handle those environment variables, as well.

It would be somewhat awkward to duplicate the logic though. But there's
a better alternative: instead of handling this logic in "setup.c", we
can easily handle environment variables in `odb_new()` itself. This
ensures that object database creation is neatly self-contained, and we
don't have to duplicate any of the logic.

Another benefit is that in a future patch series we plan to move
handling of alternates into the backends themselves [1], and that will
require us to also handle those environment variables in the "files"
backend itself. So moving the logic into the ODB level already gets us
one step closer to that goal.

Refactor the logic accordingly.

[1]: https://lore.kernel.org/git/amLgMqkqxR8mKIbT@pks.im/

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c                         | 21 ++++++++++++---------
 odb.h                         | 17 +++++++++++++++--
 setup.c                       | 11 ++++-------
 t/unit-tests/u-odb-inmemory.c |  2 +-
 4 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/odb.c b/odb.c
index cf6e7938c0..ed1d63f4bd 100644
--- a/odb.c
+++ b/odb.c
@@ -1004,26 +1004,29 @@ int odb_write_object_stream(struct object_database *odb,
 }
 
 struct object_database *odb_new(struct repository *repo,
-				const char *primary_source,
-				const char *secondary_sources)
+				enum odb_new_flags flags)
 {
-	struct object_database *o = xmalloc(sizeof(*o));
-	char *to_free = NULL;
+	char *primary_source = NULL, *secondary_sources = NULL;
+	struct object_database *o;
 
-	memset(o, 0, sizeof(*o));
+	CALLOC_ARRAY(o, 1);
 	o->repo = repo;
 	pthread_mutex_init(&o->replace_mutex, NULL);
 	string_list_init_dup(&o->submodule_source_paths);
 
+	if (flags & ODB_NEW_HONOR_ENV) {
+		primary_source = xstrdup_or_null(getenv(DB_ENVIRONMENT));
+		secondary_sources = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
+	}
 	if (!primary_source)
-		primary_source = to_free = xstrfmt("%s/objects", repo->commondir);
+		primary_source = xstrfmt("%s/objects", repo->commondir);
+
 	o->sources = odb_source_new(o, primary_source, true);
 	o->sources_tail = &o->sources->next;
-	o->alternate_db = xstrdup_or_null(secondary_sources);
+	o->alternate_db = secondary_sources;
 	o->inmemory_objects = &odb_source_inmemory_new(o)->base;
 
-	free(to_free);
-
+	free(primary_source);
 	return o;
 }
 
diff --git a/odb.h b/odb.h
index 7995bed97b..8ec335c7f7 100644
--- a/odb.h
+++ b/odb.h
@@ -100,6 +100,20 @@ struct object_database {
 	struct string_list submodule_source_paths;
 };
 
+enum odb_new_flags {
+	/*
+	 * Honor environment variables when constructing the object database
+	 * sources. This makes us respect the following environment variables:
+	 *
+	 *   - GIT_OBJECT_DIRECTORY to override the primary object directory.
+	 *
+	 *   - GIT_ALTERNATE_OBJECT_DIRECTORIES to override alternates.
+	 *
+	 * Environment variables may be backend-specific.
+	 */
+	ODB_NEW_HONOR_ENV = (1 << 0),
+};
+
 /*
  * Create a new object database for the given repository.
  *
@@ -112,8 +126,7 @@ struct object_database {
  * Returns the newly created object database.
  */
 struct object_database *odb_new(struct repository *repo,
-				const char *primary_source,
-				const char *alternate_sources);
+				enum odb_new_flags flags);
 
 /* Free the object database and release all resources. */
 void odb_free(struct object_database *o);
diff --git a/setup.c b/setup.c
index 825572f5f1..5dfab3e79e 100644
--- a/setup.c
+++ b/setup.c
@@ -1765,7 +1765,7 @@ int apply_repository_format(struct repository *repo,
 			    enum apply_repository_format_flags flags,
 			    struct strbuf *err)
 {
-	char *object_directory = NULL, *alternate_object_directories = NULL;
+	enum odb_new_flags odb_new_flags = 0;
 
 	if (verify_repository_format(format, err) < 0)
 		return -1;
@@ -1779,8 +1779,6 @@ int apply_repository_format(struct repository *repo,
 	if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV) {
 		const char *shallow_file;
 
-		object_directory = xstrdup_or_null(getenv(DB_ENVIRONMENT));
-		alternate_object_directories = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
 		shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
 		if (shallow_file)
 			set_alternate_shallow_file(repo, shallow_file);
@@ -1803,11 +1801,10 @@ int apply_repository_format(struct repository *repo,
 	repo->repository_format_precious_objects =
 		format->precious_objects;
 
-	repo->objects = odb_new(repo, object_directory,
-				alternate_object_directories);
+	if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV)
+		odb_new_flags |= ODB_NEW_HONOR_ENV;
+	repo->objects = odb_new(repo, odb_new_flags);
 
-	free(alternate_object_directories);
-	free(object_directory);
 	return 0;
 }
 
diff --git a/t/unit-tests/u-odb-inmemory.c b/t/unit-tests/u-odb-inmemory.c
index 6844bfc37c..db323e10fd 100644
--- a/t/unit-tests/u-odb-inmemory.c
+++ b/t/unit-tests/u-odb-inmemory.c
@@ -38,7 +38,7 @@ static void cl_assert_object_info(struct odb_source_inmemory *source,
 
 void test_odb_inmemory__initialize(void)
 {
-	odb = odb_new(&repo, "", "");
+	odb = odb_new(&repo, 0);
 }
 
 void test_odb_inmemory__cleanup(void)

-- 
2.55.0.679.g6767b8d81c.dirty

