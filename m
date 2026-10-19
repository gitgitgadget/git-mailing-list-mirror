Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735C449B464
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400175; cv=none; b=cOVb7lS5NRxqTGkSdPNZG/l7yEbK+k6saKD1HcNkdlgegUEWRwVxQDDjYUrsMfBRdGoz1cnAsuTCg/hBIN1ek+nZVsLJX9NyvmUrxQYzHKQxfulyuQyOrmPCIGkrbPF8nY7iOzUcjy/MdVEXSxEIc9hcvLW5mSyZZO/ZFkYCrbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400175; c=relaxed/simple;
	bh=i5i/z//D1jwku3wD2zpdjrNkV3ef/ejIU56H68VvPKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fKwTJ9yuIQzfILCyY2Iozp3Tr3phESpPemvm/8vTcuK+11IQ2I48rzrlvvBQkVftuhhoRwhNRrF+DlUhLu+XBCPYTk/86dUGel1X5UU3glzdL7yJauwqY3tm0gKsLUIhGoZotYcklSGbs4wqNGh+aH2877Ylu5DghtguHzelGso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TXDDRb2F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HS06uiqz; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TXDDRb2F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HS06uiqz"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D22497A00CC
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 04:56:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 19 Oct 2026 04:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792400172;
	 x=1792486572; bh=/c5KF7P97OuzhXdr0G++OiZCN4PJyPyCMdM4h1kFQJU=; b=
	TXDDRb2FziNTUDEVK/Z5BDuqIg/2Nq+MkPHZEcF02Ktl6L5ilEsiwTJq6MByOLNY
	CytgjG7Txe7xR4+QOVWCaOXc5nqVfaSD9si697d5KLmPUXubE+Ca5XYqiWb5xUFw
	y6UNsc1GXoAblWZn7HRxsPUiPzbehLt5VWXxnqAHAwyjWSa04hG/rGdNWovobTEH
	bGyKt5M6tW6cJ1BxVuRAvaWPLO/q3KFC5vr+QD6GcwPJ1RwTrOZh2+m0ZCwCze64
	Q2JAIf+abFHn30gmB+b3GcV8HO/vw8WTkU1kBYZ/nzY1a7YDK2Q1W7qBSrE6TnNT
	pL31tzB/xH5obyhDNK9Tmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792400172; x=
	1792486572; bh=/c5KF7P97OuzhXdr0G++OiZCN4PJyPyCMdM4h1kFQJU=; b=H
	S06uiqzDo6QxWNITSWpz97KOrmvtfk9whIJ1GnDgGx5KC4EPYSr5YHcyMix5vZZz
	+In+T8vP8wV0PIVgLenRg3+bpdmgJKjklXcCvbGnUhrnWnCITeeeyrPkNTozv5LU
	ZVV70Hz9/l/nFYnMH7Pg8XvBMrtA/cPi/4lPrDIRQJ+WFkR9mPZuAOSOEI1OXKME
	StDE11dj1+y95vUEuOFzgQtetHQmo/oNLN9xT11zHcIF8J1+TpTo7ObXN76tQ797
	uE28UtVqph2638Et0YS6Pzj0y76OmllKJppI1Xs4W9ZQ7sZxH49OKie5sYCBEvsH
	LJ/nget/lvgj/+2BT3UmA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792400172; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:R2liRVFNJTept9BID3HyOCP9dhhubujHFxW4wnTOB4Lcbfh
	o95CXQQ6Do9JIaKEGMvCp5zECuXtWwL3/e+Dp5zkL6lXHy/hxcPvONFYd+wDBIXi
	Y2goDXMZBRG8KfDJNMK6iS2Kw4+/NgAxWoTyU9KHNBnyCCRW+XH2f3YwnQi9l3KF
	Ll1z8zjO+s0WCBzno1opC8DeiIyETxUvY948CH4uCnGF5WQOULPQVOfBGTIYG23o
	0+CbD0LVzgSnpbR0200cxPRz+Pikfaxj3zv9TZ6GmUGbQjg4oxatynou+Vp3LcfG
	q4a98heqmAFJeu4Y2Y40QYVjYd89iUjgak1GWWA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:0rDcymlHepSwO6E47kV2CrCjoWQ4Cweomo7pjSQjUYE=:i5i/z//D1jwku3wD2zpdjrNkV3ef/ejIU56H68VvPKU=;
X-ME-Sender: <xms:LNvVahQHCzDq4Nb0VrlNot7pK9Z6qahMqOKC-ItxGRE76z6uqx8eTg>
    <xme:LNvVahsQHuL8nODk_yHl1ZMt0d0w2BqffimDnG-3yJgPoEzNi6Z1ALJ69da0InGQH
    k6Y-RwWAOvDw3sJthOvoO0hkBiTbd7Tn1JLm49WxvBGbe8d2-if3tw>
X-ME-Received: <xmr:LNvVaseISwi9DtG6JPppqlmFXRT19EZAqvssOfIUkPaKS2zcGVXVmg>
X-ME-Proxy-Cause: dmFkZTG23idctCybf0+Q/l30SdoKiCOHSSle9HRu+3X9JZZgVo8nvJv+b9ldcx2nfgzyr8
    SP87B1b17rPQ3OJUrRXQkeVVK411shVkI/u5Rel7mhVGXxmcv9NDeVwwbePnCOFaKtl9qE
    XMEeSZ0cXcpOIlFM80wQDUMHoLrM2ar/kJnUkw6Foyh3YExP7HzhFD6liMtUnyuLBud/Mi
    nyE0OUyZv57vSpdaVxZhpeeiLY+sFeFN0s3TBEeXmHizJNiqky43z0Qa8ObKvaHAXiAIJg
    k9hrD8K6RAyMO821uT1I7iuHPSksXnmtAjtM5Rym9XGb+Pa5PbO6m9drHVma1yG1d09yhL
    cF0MHYswHJTx+FmTk4OsfIInMTtTDJPX6HL10pnH2DAhtWlm3pbJs5Y7FEZR10zFMv4tNU
    Ww4eSePpTTP08VrukHud2o0EZt+969SDQN4kQC7/aNUgLBuptNUBU9Nd1cdQST6LmzsSL9
    jUNWUmPC1Ne5M8fbW0CKhhPmw43EELEK/sQH6sC75G7rzlUJ/yZyaObXh3TITAe3Az/xoy
    8erTtlcmOGcfPqh1u+kRcXQjHdM8JeYWWYA4vgr8Rbj1/VSsB1iitZ20eUWp8z/835AoYZ
    6qfqBLeeossDhKLyr/7OfAfSTwnh5SRbNl0p0SfWnSrqdVhhOuBumamdPU2g
X-ME-Proxy: <xmx:LNvVauKH9XZXHgUaZu4oH1LAgkkURNbfflCDmmUnF7zLg9VGFJGzzg>
    <xmx:LNvVaqbcHCDDWUk_cbFcX2p8xMplTg_qu0EhgF53F6CaWQJimnmjEg>
    <xmx:LNvVapsDOrkMJWI3Eywv8rvLuJYevW61B5NJjEkjv90PZpWzYkH0sw>
    <xmx:LNvVanvU08iN9aFhiSgeU0JbP8xuNX46iSnRHEmEXZfnAUExmpcvDw>
    <xmx:LNvVatSTw9N93zKW569_u0xT1upTUgCMAANzOGMLvj7HnR9-nIEXy9r7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 19 Oct 2026 04:56:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 413eab50 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 19 Oct 2026 08:56:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 19 Oct 2026 10:55:57 +0200
Subject: [PATCH 2/7] setup: introduce object storage extension
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-b4-pks-odb-extension-v1-2-143a5963b77f@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
In-Reply-To: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Introduce a new "extensions.objectStorage" extension that allows the
user to configure the primary object database source of a repository.
The value is a URI in the format "<schema>[://<payload>]", mirroring
the format used by "extensions.refStorage":

  - The schema identifies the backend that shall be used. For now the
    only supported schema is "files", which is the existing object
    database backed by loose objects and packfiles.

  - The payload can be passed to configure the backend, and its
    interpretation is backend-specific. For the "files" backend, it
    allows you to configure a different location for the ".git/objects"
    directory.

Eventually, this mechanism will be used to support alternative backends.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/extensions.adoc     | 23 +++++++++++++++
 Documentation/object-storage-format.adoc |  6 ++++
 odb.c                                    |  2 +-
 odb/source-files.c                       |  7 +++++
 odb/source-files.h                       |  1 +
 odb/source.c                             | 48 +++++++++++++++++++++++++++++++-
 odb/source.h                             | 12 +++++++-
 repository.c                             |  8 ++++++
 repository.h                             |  8 ++++++
 setup.c                                  | 13 +++++++++
 setup.h                                  |  1 +
 t/t0001-init.sh                          | 30 ++++++++++++++++++++
 12 files changed, 156 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index be6678bb5b..4f3a66a454 100644
--- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -56,6 +56,29 @@ preciousObjects:::
 For historical reasons, this extension is respected regardless of the
 `core.repositoryFormatVersion` setting.
 
+objectStorage:::
+	Specify the object storage format and a corresponding payload. The
+	value can be either a format name or a URI:
++
+--
+* A format name alone (e.g., `files`).
+
+* A URI format `<format>://<payload>` explicitly specifies both the
+  format and payload (e.g., `files:///foo/bar`).
+
+Supported formats are:
+
+include::../object-storage-format.adoc[]
+
+--
++
+Note that this setting should only be set by linkgit:git-init[1] or
+linkgit:git-clone[1]. Trying to change it after initialization will make
+preexisting objects inaccessible.
++
+NOTE: This extension is still considered EXPERIMENTAL and may be subject to
+change.
+
 refStorage:::
 	Specify the ref storage format and a corresponding payload. The value
 	can be either a format name or a URI:
diff --git a/Documentation/object-storage-format.adoc b/Documentation/object-storage-format.adoc
new file mode 100644
index 0000000000..4c4aef6dda
--- /dev/null
+++ b/Documentation/object-storage-format.adoc
@@ -0,0 +1,6 @@
+`files[://<path>]`;; for loose objects and packfiles. This is the default.
++
+The optional payload can be passed to specify an alternative filesystem path
+where the objects will be stored. Relative paths are resolved relative to the
+`$GIT_COMMON_DIR`. Defaults to `$GIT_COMMON_DIR/objects` when no payload is
+provided. The payload is ignored when `GIT_OBJECT_DIRECTORY` is set.
diff --git a/odb.c b/odb.c
index 98c5c862f5..6c07b3b671 100644
--- a/odb.c
+++ b/odb.c
@@ -757,7 +757,7 @@ struct object_database *odb_new(struct repository *repo,
 	o->repo = repo;
 	pthread_mutex_init(&o->replace_mutex, NULL);
 
-	o->source = odb_source_new(o, flags);
+	o->source = odb_source_new(o, repo->object_storage_format, flags);
 	o->inmemory_objects = &odb_source_inmemory_new(o)->base;
 
 	return o;
diff --git a/odb/source-files.c b/odb/source-files.c
index 455f409db0..4a7cbbfd9b 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -1235,6 +1235,7 @@ struct odb_files_dir *odb_source_files_find_dir(struct object_database *odb, con
 }
 
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
+					      const char *payload,
 					      enum odb_new_flags flags)
 {
 	struct odb_source_files *files;
@@ -1245,6 +1246,12 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 		object_dir = xstrdup_or_null(getenv(DB_ENVIRONMENT));
 		alternates = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
 	}
+	if (!object_dir && payload) {
+		if (is_absolute_path(payload))
+			object_dir = xstrdup(payload);
+		else
+			object_dir = xstrfmt("%s/%s", odb->repo->commondir, payload);
+	}
 	if (!object_dir)
 		object_dir = xstrfmt("%s/objects", odb->repo->commondir);
 
diff --git a/odb/source-files.h b/odb/source-files.h
index 837e890304..71e8db84ff 100644
--- a/odb/source-files.h
+++ b/odb/source-files.h
@@ -70,6 +70,7 @@ struct odb_source_files {
 
 /* Allocate and initialize a new object source. */
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
+					      const char *payload,
 					      enum odb_new_flags flags);
 
 /*
diff --git a/odb/source.c b/odb/source.c
index b25ef14df8..10abe33a26 100644
--- a/odb/source.c
+++ b/odb/source.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "gettext.h"
 #include "object-file.h"
 #include "odb/source-files.h"
 #include "odb/source.h"
@@ -23,10 +24,55 @@ const char *odb_source_type_to_name(enum odb_source_type type)
 	return name;
 }
 
+static enum odb_source_type odb_source_type_by_name(const char *name)
+{
+	if (!strcmp(name, "files"))
+		return ODB_SOURCE_FILES;
+	return ODB_SOURCE_UNKNOWN;
+}
+
+enum odb_source_type odb_source_type_by_uri(const char *uri, char **payload)
+{
+	enum odb_source_type type;
+	const char *schema_end;
+	char *name;
+
+	schema_end = strstr(uri, "://");
+	if (!schema_end) {
+		name = xstrdup(uri);
+		if (payload)
+			*payload = NULL;
+	} else {
+		name = xstrndup(uri, schema_end - uri);
+		if (payload)
+			*payload = *(schema_end + 3) ? xstrdup(schema_end + 3) : NULL;
+	}
+
+	type = odb_source_type_by_name(name);
+	free(name);
+	return type;
+}
+
 struct odb_source *odb_source_new(struct object_database *odb,
+				  const char *object_storage_format,
 				  enum odb_new_flags flags)
 {
-	return &odb_source_files_new(odb, flags)->base;
+	struct odb_source *source;
+	char *payload = NULL;
+
+	if (!object_storage_format)
+		return &odb_source_files_new(odb, NULL, flags)->base;
+
+	switch (odb_source_type_by_uri(object_storage_format, &payload)) {
+	case ODB_SOURCE_FILES:
+		source = &odb_source_files_new(odb, payload, flags)->base;
+		break;
+	default:
+		die(_("unknown object storage format '%s'"), object_storage_format);
+	}
+
+	free(payload);
+	return source;
 }
 
 void odb_source_init(struct odb_source *source,
diff --git a/odb/source.h b/odb/source.h
index 1867347dfc..c194b3254b 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -32,6 +32,14 @@ enum odb_source_type {
  */
 const char *odb_source_type_to_name(enum odb_source_type type);
 
+/*
+ * Parse the given URI in the format "<schema>[://<payload>]" and return the
+ * source type identified by the schema. If `payload` is non-NULL it will be
+ * set to a newly allocated copy of the payload, or NULL if the URI has no or
+ * an empty payload. Returns `ODB_SOURCE_UNKNOWN` for unknown schemas.
+ */
+enum odb_source_type odb_source_type_by_uri(const char *uri, char **payload);
+
 struct object_id;
 struct odb_stream;
 struct strbuf;
@@ -304,9 +312,11 @@ struct odb_source {
 
 /*
  * Allocate and initialize a new source for the given object database. The path
- * of the source is derived from repository paths.
+ * of the source is derived from repository paths or from the object storage
+ * format.
  */
 struct odb_source *odb_source_new(struct object_database *odb,
+				  const char *object_storage_format,
 				  enum odb_new_flags flags);
 
 /*
diff --git a/repository.c b/repository.c
index 970d181828..bb01fe5dd6 100644
--- a/repository.c
+++ b/repository.c
@@ -217,6 +217,13 @@ void repo_set_ref_storage_format(struct repository *repo,
 	repo->ref_storage_payload = xstrdup_or_null(payload);
 }
 
+void repo_set_object_storage_format(struct repository *repo,
+				    const char *uri)
+{
+	free(repo->object_storage_format);
+	repo->object_storage_format = xstrdup_or_null(uri);
+}
+
 /*
  * Attempt to resolve and set the provided 'gitdir' for repository 'repo'.
  * Return 0 upon success and a non-zero value upon failure.
@@ -382,6 +389,7 @@ void repo_clear(struct repository *repo)
 	free(repo->worktree);
 	free(repo->submodule_prefix);
 	free(repo->ref_storage_payload);
+	free(repo->object_storage_format);
 
 	odb_free(repo->objects);
 
diff --git a/repository.h b/repository.h
index 2a348012e8..e9a3a7f18b 100644
--- a/repository.h
+++ b/repository.h
@@ -178,6 +178,12 @@ struct repository {
 	 */
 	char *ref_storage_payload;
 
+	/*
+	 * The object storage URI in the format "<schema>[://<payload>]", as
+	 * configured via "extensions.objectStorage".
+	 */
+	char *object_storage_format;
+
 	/* A unique-id for tracing purposes. */
 	int trace2_repo_id;
 
@@ -255,6 +261,8 @@ void repo_set_compat_hash_algo(struct repository *repo, uint32_t compat_algo);
 void repo_set_ref_storage_format(struct repository *repo,
 				 enum ref_storage_format format,
 				 const char *payload);
+void repo_set_object_storage_format(struct repository *repo,
+				    const char *uri);
 void initialize_repository(struct repository *repo);
 RESULT_MUST_BE_USED
 int repo_init(struct repository *r, const char *gitdir, const char *worktree);
diff --git a/setup.c b/setup.c
index 3ee19f3e3c..499b5bbe3c 100644
--- a/setup.c
+++ b/setup.c
@@ -9,6 +9,7 @@
 #include "hex.h"
 #include "object-file.h"
 #include "object-name.h"
+#include "odb/source.h"
 #include "refs.h"
 #include "repository.h"
 #include "config.h"
@@ -687,6 +688,15 @@ static enum extension_result handle_extension(const char *var,
 				     "extensions.refstorage", value);
 		data->ref_storage_format = format;
 		return EXTENSION_OK;
+	} else if (!strcmp(ext, "objectstorage")) {
+		if (!value)
+			return config_error_nonbool(var);
+		if (odb_source_type_by_uri(value, NULL) == ODB_SOURCE_UNKNOWN)
+			return error(_("invalid value for '%s': '%s'"),
+				     "extensions.objectstorage", value);
+		free(data->object_storage);
+		data->object_storage = xstrdup(value);
+		return EXTENSION_OK;
 	} else if (!strcmp(ext, "relativeworktrees")) {
 		data->relative_worktrees = git_config_bool(var, value);
 		return EXTENSION_OK;
@@ -694,6 +704,7 @@ static enum extension_result handle_extension(const char *var,
 		data->submodule_path_cfg = git_config_bool(var, value);
 		return EXTENSION_OK;
 	}
+
 	return EXTENSION_UNKNOWN;
 }
 
@@ -864,6 +875,7 @@ void clear_repository_format(struct repository_format *format)
 	free(format->work_tree);
 	free(format->partial_clone);
 	free(format->ref_storage_payload);
+	free(format->object_storage);
 	init_repository_format(format);
 }
 
@@ -1786,6 +1798,7 @@ int apply_repository_format(struct repository *repo,
 	repo_set_ref_storage_format(repo,
 				    format->ref_storage_format,
 				    format->ref_storage_payload);
+	repo_set_object_storage_format(repo, format->object_storage);
 	repo->repository_format_worktree_config =
 		format->worktree_config;
 	repo->repository_format_submodule_path_cfg =
diff --git a/setup.h b/setup.h
index 7a3efe5e48..9145aacc5f 100644
--- a/setup.h
+++ b/setup.h
@@ -192,6 +192,7 @@ struct repository_format {
 	char *ref_storage_payload;
 	int sparse_index;
 	char *work_tree;
+	char *object_storage;
 	struct string_list unknown_extensions;
 	struct string_list v1_only_extensions;
 };
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index f1d227f271..c7c464d3a2 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -839,6 +839,36 @@ test_expect_success 'init with --ref-storage-format=garbage' '
 	test_cmp expect err
 '
 
+test_expect_success DEFAULT_REPO_FORMAT 'extensions.objectStorage is not allowed with repo version 0' '
+	test_when_finished "rm -rf objstorage" &&
+	git init objstorage &&
+	git -C objstorage config set extensions.objectStorage files &&
+	test_must_fail git -C objstorage rev-parse 2>err &&
+	test_grep "repo version is 0, but v1-only extension found" err
+'
+
+test_expect_success DEFAULT_REPO_FORMAT 'extensions.objectStorage with files backend' '
+	test_when_finished "rm -rf objstorage" &&
+	git init objstorage &&
+	git -C objstorage config set core.repositoryformatversion 1 &&
+	git -C objstorage config set extensions.objectStorage files &&
+	test_commit -C objstorage A &&
+	git -C objstorage rev-parse --verify HEAD
+'
+
+test_expect_success DEFAULT_REPO_FORMAT 'extensions.objectStorage with unknown backend' '
+	test_when_finished "rm -rf objstorage" &&
+	git init objstorage &&
+	git -C objstorage config set core.repositoryformatversion 1 &&
+	git -C objstorage config set extensions.objectStorage garbage &&
+	test_must_fail git -C objstorage rev-parse 2>err &&
+	test_grep "invalid value for ${SQ}extensions.objectstorage${SQ}: ${SQ}garbage${SQ}" err &&
+
+	git config --file objstorage/.git/config extensions.objectStorage garbage://payload &&
+	test_must_fail git -C objstorage rev-parse 2>err &&
+	test_grep "invalid value for ${SQ}extensions.objectstorage${SQ}: ${SQ}garbage://payload${SQ}" err
+'
+
 test_expect_success MINGW 'core.hidedotfiles = false' '
 	git config --global core.hidedotfiles false &&
 	rm -rf newdir &&

-- 
2.56.0.269.g68944adf51.dirty

