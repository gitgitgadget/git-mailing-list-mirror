Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B135133260B
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784980482; cv=none; b=tLHzNADVcnyrWMZXgs77l1rpHoqZhU8k2tb+MZwbmy8KfBqmdy/Lrp7cvonwzH63NzJA1WE9uqancIhtQUG1s4Z+T7QkZti2GVJr5RQhfFw1BvI3XlPnbntFJCo7iMjdq7qp/PLYqlzzcCKfWXNWzGD1CtKJ9bB76zubjRPvw6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784980482; c=relaxed/simple;
	bh=2fXh31vxpBpIWNgYrix/Kd+2N8be0tHbXXuvjzJZzmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Unun1SeW+7XR3SbyjRhfPP/btxSRshJg6oJNFpHZrbAVCI2VdwzlrOJYLwfT3qbghupwgeU5KmMImhLs2HSysJJvEE6PABkOe+CUmUCY/HHNUAAqVWzBxSsuUGjQ3uQ6wnqEDfICwjs9lwKllTKSQzyvsL4zBxdjisx2CPrFfok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=JnbDGy8p; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=a07odQZe; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="JnbDGy8p";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="a07odQZe"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=JnbDGy8pUF/eYGMVQUKCrvMcwu+b2tO9hFfrjHAESypXj+8Ddli2HwyWX9UMUT9mcYgv8qETYt2LqyX91V+ToLQRagmG/nKhdgVs5mKNPShCseB7HZTcFS1ZqVl8WKTUd6lRGWP4rjilKttVhDFwFECbGHZwMybCIFYo20spjby6cF64pC22TWmhydFs57XpIj4zpdpaZ9mhZmVfzLxSEcL3MvYobwSjTGOXDnrK6dN5zeVVo5IMFLFpbL1WJ+CFJLys0T6OFsDBLaNzrr7FHMYhE4647ZPAfEmfr2MBwnSb1oLJ5pCMQexujeSLBaM/XXVcuJTl79r+lBVjxFwR+Q==; s=purelymail3; d=malon.dev; v=1; bh=2fXh31vxpBpIWNgYrix/Kd+2N8be0tHbXXuvjzJZzmo=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=a07odQZeqtqgvPmBrGYeCdwlVTcDhNXi5VBLpChslfwCdUemP7rSf1/suWF8GRZ4/mdOBGTuvPVXi2j666aJQH4BS/cbrb82uaMgAAUUKK3sHd8xQkjD9g8uCHkoFIc2dHUNwIgbcHydZvsx8ik7YGoeaeP0I02aiFlyfGeAXPSXeLgW80axX702emKybMcISVPhKq3gEHL0y4aXf/zjHzkBGYsq9B5HSC6PmpCd59SjCGFujrKzF3pwhl/5ymwfDHDVrOk9NKsDLLh28VYgD2esRan+HNWfwgM80o5Q4LaOxakXaZtvYndY4U1P3fyauRGrPD7mE8+jAfnB/tJZTA==; s=purelymail3; d=purelymail.com; v=1; bh=2fXh31vxpBpIWNgYrix/Kd+2N8be0tHbXXuvjzJZzmo=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 891366051;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 25 Jul 2026 11:54:39 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	newren@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v1 1/3] environment: migrate minimum_abbrev and default_abbrev
Date: Sat, 25 Jul 2026 19:54:26 +0800
Message-ID: <20260725115428.2214202-2-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260725115428.2214202-1-cat@malon.dev>
References: <20260725115428.2214202-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Move the global 'minimum_abbrev' and 'default_abbrev' configurations
into the repository-specific 'repo_config_values'
struct.

To ensure code readability, the getter functions
'repo_minimum_abbrev()' and 'repo_default_abbrev()' have been introduced.
The existing MINIMUM_ABBREV and DEFAULT_ABBREV macros are redefined to
the corresponding getters.

Additionally, some subsystems forbid the direct use of 'the_repository'
and must pass their own local 'repo'. Let the getters explicitly intercept
these instances.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 environment.c | 31 ++++++++++++++++++++++++++-----
 environment.h |  6 +++++-
 merge-ort.c   |  7 ++++---
 object-name.h |  4 ++--
 replay.c      |  2 +-
 sequencer.c   |  5 +++--
 6 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/environment.c b/environment.c
index c663113e8a..2b44778b50 100644
--- a/environment.c
+++ b/environment.c
@@ -43,7 +43,6 @@ static int zlib_compression_seen;
=20
 int trust_executable_bit =3D 1;
 int has_symlinks =3D 1;
-int minimum_abbrev =3D 4, default_abbrev =3D -1;
 int assume_unchanged;
 char *git_commit_encoding;
 char *git_log_output_encoding;
@@ -148,6 +147,26 @@ int repo_ignore_case(struct repository *repo)
 =09=090;
 }
=20
+int repo_minimum_abbrev(struct repository *repo)
+{
+=09if (repo !=3D the_repository)
+=09=09repo =3D the_repository;
+
+=09return repo->initialized
+=09=09? repo_config_values(repo)->minimum_abbrev
+=09=09: 4;
+}
+
+int repo_default_abbrev(struct repository *repo)
+{
+=09if (repo !=3D the_repository)
+=09=09repo =3D the_repository;
+
+=09return repo->initialized
+=09=09? repo_config_values(repo)->default_abbrev
+=09=09: -1;
+}
+
 int have_git_dir(void)
 {
 =09return startup_info->have_repository
@@ -364,14 +383,14 @@ int git_default_core_config(const char *var, const ch=
ar *value,
 =09=09if (!value)
 =09=09=09return config_error_nonbool(var);
 =09=09if (!strcasecmp(value, "auto"))
-=09=09=09default_abbrev =3D -1;
+=09=09=09cfg->default_abbrev =3D -1;
 =09=09else if (!git_parse_maybe_bool_text(value))
-=09=09=09default_abbrev =3D GIT_MAX_HEXSZ;
+=09=09=09cfg->default_abbrev =3D GIT_MAX_HEXSZ;
 =09=09else {
 =09=09=09int abbrev =3D git_config_int(var, value, ctx->kvi);
-=09=09=09if (abbrev < minimum_abbrev)
+=09=09=09if (abbrev < cfg->minimum_abbrev)
 =09=09=09=09return error(_("abbrev length out of range: %d"), abbrev);
-=09=09=09default_abbrev =3D abbrev;
+=09=09=09cfg->default_abbrev =3D abbrev;
 =09=09}
 =09=09return 0;
 =09}
@@ -738,6 +757,8 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 =09cfg->check_stat =3D 1;
 =09cfg->zlib_compression_level =3D Z_BEST_SPEED;
 =09cfg->pack_compression_level =3D Z_DEFAULT_COMPRESSION;
+=09cfg->minimum_abbrev =3D 4;
+=09cfg->default_abbrev =3D -1;
 =09cfg->precomposed_unicode =3D -1; /* see probe_utf8_pathname_composition=
() */
 =09cfg->core_sparse_checkout_cone =3D 0;
 =09cfg->sparse_expect_files_outside_of_patterns =3D 0;
diff --git a/environment.h b/environment.h
index acfb670be1..c5905d8b01 100644
--- a/environment.h
+++ b/environment.h
@@ -95,6 +95,8 @@ struct repo_config_values {
 =09int check_stat;
 =09int zlib_compression_level;
 =09int pack_compression_level;
+=09int minimum_abbrev;
+=09int default_abbrev;
 =09int precomposed_unicode;
 =09int core_sparse_checkout_cone;
 =09int warn_on_object_refname_ambiguity;
@@ -151,6 +153,9 @@ int repo_protect_ntfs(struct repository *repo);
  */
 int repo_ignore_case(struct repository *repo);
=20
+int repo_minimum_abbrev(struct repository *repo);
+int repo_default_abbrev(struct repository *repo);
+
 void repo_config_values_init(struct repo_config_values *cfg);
=20
 int is_bare_repository(struct repository *repo);
@@ -180,7 +185,6 @@ int have_git_dir(void);
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
 extern int has_symlinks;
-extern int minimum_abbrev, default_abbrev;
 extern int assume_unchanged;
 extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
diff --git a/merge-ort.c b/merge-ort.c
index c410a5d353..b94ebcc2de 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -777,7 +777,7 @@ static void format_commit(struct strbuf *sb,
 {
 =09struct merge_remote_desc *desc;
 =09struct pretty_print_context ctx =3D {0};
-=09ctx.abbrev =3D DEFAULT_ABBREV;
+=09ctx.abbrev =3D repo_default_abbrev(repo);
=20
 =09strbuf_addchars(sb, ' ', indent);
 =09desc =3D merge_remote_util(commit);
@@ -2035,7 +2035,8 @@ static int merge_submodule(struct merge_options *opt,
 =09=09util->flag =3D sub_flag;
 =09=09util->abbrev =3D NULL;
 =09=09if (!sub_not_initialized) {
-=09=09=09abbrev =3D repo_find_unique_abbrev(&subrepo, b, DEFAULT_ABBREV);
+=09=09=09abbrev =3D repo_find_unique_abbrev(&subrepo, b,
+=09=09=09=09=09=09=09repo_default_abbrev(opt->repo));
 =09=09=09util->abbrev =3D xstrdup(abbrev);
 =09=09}
 =09=09string_list_append(csub, path)->util =3D util;
@@ -5348,7 +5349,7 @@ static void merge_ort_internal(struct merge_options *=
opt,
 =09} else {
 =09=09strbuf_add_unique_abbrev(&merge_base_abbrev,
 =09=09=09=09=09 &merged_merge_bases->object.oid,
-=09=09=09=09=09 DEFAULT_ABBREV);
+=09=09=09=09=09 repo_default_abbrev(opt->repo));
 =09=09ancestor_name =3D merge_base_abbrev.buf;
 =09}
=20
diff --git a/object-name.h b/object-name.h
index 167a9154ea..a6d7206ed8 100644
--- a/object-name.h
+++ b/object-name.h
@@ -133,8 +133,8 @@ struct object *repo_peel_to_type(struct repository *r,
 =09=09=09=09 struct object *o, enum object_type);
=20
 /* Convert to/from hex/sha1 representation */
-#define MINIMUM_ABBREV minimum_abbrev
-#define DEFAULT_ABBREV default_abbrev
+#define MINIMUM_ABBREV repo_minimum_abbrev(the_repository)
+#define DEFAULT_ABBREV repo_default_abbrev(the_repository)
=20
 /* used when the code does not know or care what the default abbrev is */
 #define FALLBACK_DEFAULT_ABBREV 7
diff --git a/replay.c b/replay.c
index 463c900d6c..cd41c7f507 100644
--- a/replay.c
+++ b/replay.c
@@ -27,7 +27,7 @@ static const char *short_commit_name(struct repository *r=
epo,
 =09=09=09=09     struct commit *commit)
 {
 =09return repo_find_unique_abbrev(repo, &commit->object.oid,
-=09=09=09=09       DEFAULT_ABBREV);
+=09=09=09=09       repo_default_abbrev(repo));
 }
=20
 static struct commit *peel_committish(struct repository *repo,
diff --git a/sequencer.c b/sequencer.c
index 1355a99a09..2426c5e422 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5813,7 +5813,7 @@ static const char *label_oid(struct object_id *oid, c=
onst char *label,
 =09=09label =3D p =3D state->buf.buf;
=20
 =09=09repo_find_unique_abbrev_r(the_repository, p, oid,
-=09=09=09=09=09  default_abbrev);
+=09=09=09=09=09  repo_default_abbrev(the_repository));
=20
 =09=09/*
 =09=09 * We may need to extend the abbreviated hash so that there is
@@ -5875,7 +5875,8 @@ static const char *label_oid(struct object_id *oid, c=
onst char *label,
 =09=09=09=09strbuf_addch(buf, '-');
 =09=09if (!buf->len) {
 =09=09=09strbuf_addstr(buf, "rev-");
-=09=09=09strbuf_add_unique_abbrev(buf, oid, default_abbrev);
+=09=09=09strbuf_add_unique_abbrev(buf, oid,
+=09=09=09=09=09=09 repo_default_abbrev(the_repository));
 =09=09}
 =09=09label =3D buf->buf;
=20
--=20
2.43.0

