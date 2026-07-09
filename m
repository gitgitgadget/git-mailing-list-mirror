Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAB44314B2
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613554; cv=none; b=j3AlwgdX/eviop93kUMIOl6fUhjpTnk7pX9MYQNXOmlC5eZ3Meg5GGsCthwk8ponBO9DPIHvl3aJ8/pPCIbcaVw4dCOIhpKfLimPErQgSSHsHt1yeuk0lyGIdNDFnw3jlOcEGK4riq8sfApKhqZ6wCLNUUQw5EM3VhFSaX7vbOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613554; c=relaxed/simple;
	bh=xi5Y0eNjh8iuUraRcXOzXEpCUk/7fPeCigZ3iCmHuyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m2wyDsq2z9IXlPnEHAeWTDRs5ZEFT6kV8OZ/GxRGtyknZ62NhzV6ILs5THJzMwyQztg/hw1DQPQVaEIF1U6T6fVXaOncdlZX+J7Kbe1zs4uRhQpJOhM0Zf1rSidq48NXdhD1x4ez98CuydYef+95ttUpjoPooDlagSttCs3XP98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=IdLvWvzz; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=h0gdCgUs; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="IdLvWvzz";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="h0gdCgUs"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=IdLvWvzzWLCyt/hsNjFiGkEZGX3Ct7pFp21rtsySkbuHhko4N//CqXoc43iGwTJbwT8OyeuTviaUqG3k5XzAwA1nGGfa1JA6LYxcLxR4DY3IFVWVrUUa4cdUJymouMD4XqQJLFFcScyOkfLLV1HWdOQLCNBxnfaMdP8Czdqr3FF35ykhXQOeQ9NU1bPzmeHDW9MoGL1OMARaj/+Xckzx6N5V5SwbF78FllUfeItx+ThuIC0QSQEg0xrhaUSSOcvdO6sTvZVOvlqViUGH5cI5waOSWnK4BFB703jnA0mAHn5Cl+36z7PrgJtCJQCi+wJL9CvX+EPs/VAEihhJ7X14IA==; s=purelymail1; d=malon.dev; v=1; bh=xi5Y0eNjh8iuUraRcXOzXEpCUk/7fPeCigZ3iCmHuyI=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=h0gdCgUs4eze9E7Z5RZL2e78atnB8t44zO9F0H+16iU8CQylxXqAV8v3SaMHVkk5hbY+6KjzSjXdRYY9k/4u5gOVUinLsVO3micEP27mdPRT1ePUYbJqfLRGYdKS9xSK+q/G1vypLygGpJ7jkLNR9KufJLMzwaHDKEHZhaydvfuaoCSz/riU5CcvawtapTyUcPUxK/7AMOWbgsVcGvcFHRijnLySBoRh07ZDnpJ8Y4hxbnJWWmMdUxq5uzbIYsCKCDrUzT7PfG8wkxhFG5jMcUNM6GaS6tM/PjksZ+DjkrnW2lexrrof44GjeJbhTVMS3d61/Y0dbpPN+JmdJ9H8Yw==; s=purelymail1; d=purelymail.com; v=1; bh=xi5Y0eNjh8iuUraRcXOzXEpCUk/7fPeCigZ3iCmHuyI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 872182701;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 09 Jul 2026 16:12:31 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v9 7/9] environment: move push_default into repo_config_values
Date: Fri, 10 Jul 2026 00:11:43 +0800
Message-ID: <20260709161145.13349-8-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709161145.13349-1-cat@malon.dev>
References: <20260708160300.8852-1-cat@malon.dev>
 <20260709161145.13349-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The global variable 'push_default' specifies the default behavior of
'git push' when no explicit refspec is provided. Move 'push_default'
into 'struct repo_config_values' to continue the libification effort.

While 'enum push_default_type' ideally belongs in 'remote.h', moving it
there introduces a circular dependency chain:

  remote.h -> hash.h -> repository.h -> environment.h.

Therefore, the enum definition is kept in 'environment.h' just above
'struct repo_config_values' with a NEEDSWORK comment for future cleanup.

Modify the configuration parsing in environment.c to update the
per-repository structure directly, and update caller across the
codebase to access the value via 'repo_config_values()'.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 builtin/push.c |  8 ++++----
 environment.c  | 16 +++++++++-------
 environment.h  | 26 ++++++++++++++++----------
 remote.c       |  2 +-
 4 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 6021b71d66..6dc3224b60 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -88,7 +88,7 @@ static void refspec_append_mapped(struct refspec *refspec=
, const char *ref,
 =09=09}
 =09}
=20
-=09if (push_default =3D=3D PUSH_DEFAULT_UPSTREAM &&
+=09if (repo_config_values(the_repository)->push_default =3D=3D PUSH_DEFAUL=
T_UPSTREAM &&
 =09    skip_prefix(matched->name, "refs/heads/", &branch_name)) {
 =09=09struct branch *branch =3D branch_get(branch_name);
 =09=09if (branch->merge_nr =3D=3D 1 && branch->merge[0]->src) {
@@ -160,7 +160,7 @@ static NORETURN void die_push_simple(struct branch *bra=
nch,
 =09 * Don't show advice for people who explicitly set
 =09 * push.default.
 =09 */
-=09if (push_default =3D=3D PUSH_DEFAULT_UNSPECIFIED)
+=09if (cfg->push_default =3D=3D PUSH_DEFAULT_UNSPECIFIED)
 =09=09advice_pushdefault_maybe =3D _("\n"
 =09=09=09=09 "To choose either option permanently, "
 =09=09=09=09 "see push.default in 'git help config'.\n");
@@ -232,7 +232,7 @@ static void setup_default_push_refspecs(int *flags, str=
uct remote *remote)
 =09const char *dst;
 =09int same_remote;
=20
-=09switch (push_default) {
+=09switch (repo_config_values(the_repository)->push_default) {
 =09case PUSH_DEFAULT_MATCHING:
 =09=09refspec_append(&rs, ":");
 =09=09return;
@@ -252,7 +252,7 @@ static void setup_default_push_refspecs(int *flags, str=
uct remote *remote)
 =09dst =3D branch->refname;
 =09same_remote =3D !strcmp(remote->name, remote_for_branch(branch, NULL));
=20
-=09switch (push_default) {
+=09switch (repo_config_values(the_repository)->push_default) {
 =09default:
 =09case PUSH_DEFAULT_UNSPECIFIED:
 =09case PUSH_DEFAULT_SIMPLE:
diff --git a/environment.c b/environment.c
index 8744790219..09de2fee87 100644
--- a/environment.c
+++ b/environment.c
@@ -59,7 +59,6 @@ enum eol core_eol =3D EOL_UNSET;
 int global_conv_flags_eol =3D CONV_EOL_RNDTRP_WARN;
 char *check_roundtrip_encoding;
 enum rebase_setup_type autorebase =3D AUTOREBASE_NEVER;
-enum push_default_type push_default =3D PUSH_DEFAULT_UNSPECIFIED;
 #ifndef OBJECT_CREATION_MODE
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
@@ -619,21 +618,23 @@ static int git_default_branch_config(const char *var,=
 const char *value)
=20
 static int git_default_push_config(const char *var, const char *value)
 {
+=09struct repo_config_values *cfg =3D repo_config_values(the_repository);
+
 =09if (!strcmp(var, "push.default")) {
 =09=09if (!value)
 =09=09=09return config_error_nonbool(var);
 =09=09else if (!strcmp(value, "nothing"))
-=09=09=09push_default =3D PUSH_DEFAULT_NOTHING;
+=09=09=09cfg->push_default =3D PUSH_DEFAULT_NOTHING;
 =09=09else if (!strcmp(value, "matching"))
-=09=09=09push_default =3D PUSH_DEFAULT_MATCHING;
+=09=09=09cfg->push_default =3D PUSH_DEFAULT_MATCHING;
 =09=09else if (!strcmp(value, "simple"))
-=09=09=09push_default =3D PUSH_DEFAULT_SIMPLE;
+=09=09=09cfg->push_default =3D PUSH_DEFAULT_SIMPLE;
 =09=09else if (!strcmp(value, "upstream"))
-=09=09=09push_default =3D PUSH_DEFAULT_UPSTREAM;
+=09=09=09cfg->push_default =3D PUSH_DEFAULT_UPSTREAM;
 =09=09else if (!strcmp(value, "tracking")) /* deprecated */
-=09=09=09push_default =3D PUSH_DEFAULT_UPSTREAM;
+=09=09=09cfg->push_default =3D PUSH_DEFAULT_UPSTREAM;
 =09=09else if (!strcmp(value, "current"))
-=09=09=09push_default =3D PUSH_DEFAULT_CURRENT;
+=09=09=09cfg->push_default =3D PUSH_DEFAULT_CURRENT;
 =09=09else {
 =09=09=09error(_("malformed value for %s: %s"), var, value);
 =09=09=09return error(_("must be one of nothing, matching, simple, "
@@ -725,6 +726,7 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 =09cfg->askpass_program =3D NULL;
 =09cfg->apply_default_whitespace =3D NULL;
 =09cfg->apply_default_ignorewhitespace =3D NULL;
+=09cfg->push_default =3D PUSH_DEFAULT_UNSPECIFIED;
 =09cfg->apply_sparse_checkout =3D 0;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 =09cfg->trust_ctime =3D 1;
diff --git a/environment.h b/environment.h
index 9aecd64152..72859b5d76 100644
--- a/environment.h
+++ b/environment.h
@@ -87,6 +87,21 @@ extern const char * const local_repo_env[];
 struct strvec;
=20
 struct repository;
+
+/*
+ * NEEDSWORK: It would be better if these definitions could be moved to
+ * other more specific files, but care is needed to avoid circular
+ * inclusion issues.
+ */
+enum push_default_type {
+=09PUSH_DEFAULT_NOTHING =3D 0,
+=09PUSH_DEFAULT_MATCHING,
+=09PUSH_DEFAULT_SIMPLE,
+=09PUSH_DEFAULT_UPSTREAM,
+=09PUSH_DEFAULT_CURRENT,
+=09PUSH_DEFAULT_UNSPECIFIED
+};
+
 struct repo_config_values {
 =09/* section "core" config values */
 =09char *attributes_file;
@@ -96,6 +111,7 @@ struct repo_config_values {
 =09char *askpass_program;
 =09char *apply_default_whitespace;
 =09char *apply_default_ignorewhitespace;
+=09enum push_default_type push_default;
 =09int apply_sparse_checkout;
 =09int trust_ctime;
 =09int check_stat;
@@ -197,16 +213,6 @@ enum rebase_setup_type {
 };
 extern enum rebase_setup_type autorebase;
=20
-enum push_default_type {
-=09PUSH_DEFAULT_NOTHING =3D 0,
-=09PUSH_DEFAULT_MATCHING,
-=09PUSH_DEFAULT_SIMPLE,
-=09PUSH_DEFAULT_UPSTREAM,
-=09PUSH_DEFAULT_CURRENT,
-=09PUSH_DEFAULT_UNSPECIFIED
-};
-extern enum push_default_type push_default;
-
 enum object_creation_mode {
 =09OBJECT_CREATION_USES_HARDLINKS =3D 0,
 =09OBJECT_CREATION_USES_RENAMES =3D 1
diff --git a/remote.c b/remote.c
index 00723b385e..d48c01d375 100644
--- a/remote.c
+++ b/remote.c
@@ -1933,7 +1933,7 @@ static char *branch_get_push_1(struct repository *rep=
o,
 =09if (remote->mirror)
 =09=09return tracking_for_push_dest(remote, branch->refname, err);
=20
-=09switch (push_default) {
+=09switch (repo_config_values(repo)->push_default) {
 =09case PUSH_DEFAULT_NOTHING:
 =09=09return error_buf(err, _("push has no destination (push.default is 'n=
othing')"));
=20
--=20
2.43.0

