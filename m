Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BF4C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 04:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiCAEmp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 23:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiCAEmh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 23:42:37 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995AC6F4A8
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:41:48 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d5-20020a623605000000b004e01ccd08abso8974996pfa.10
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=7NDs+70OZEEkMdjejrX6csVwUuyqMEn+qNeIcCtIvow=;
        b=Sm92cdYB3qtm7qL9iOL+cClPg1WzpkDc2isewkMcjJPR2g/Z2g9i6eaZYuSFRF2v+Y
         MBjiMtQ5Od+QLAT/RsMyt/WfKNZ3xHTtDxX5SW5BgIB69/bcalyNoyKCTAUClJRY3MTu
         y3HFq3+s2QkCEY75MbQE4XLdNini4O3f1lTue+fOk9GdaUOTBL1uIruTdJJB3xakoKA5
         sCV/5wLK+jSv1YHVWq+yR85gAf1ONGoX7Qlutbt9ZSF9YvL3BvHHt4ToK6ZZhyD8TxAA
         qUHJrddNr70VCH6xBfV2WZPI6oCg3vgJZyN1g+yT2Y1F/aNDGyOCP7xEQo5BNCue+leE
         voBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=7NDs+70OZEEkMdjejrX6csVwUuyqMEn+qNeIcCtIvow=;
        b=6Llx9vU3ujketBhkSOU2glTNOEQmAIqpoXN018C/QTd2y4quSCXDZH2YYu9wbpuZmR
         1TEM1NsGcy0jnEKsWftyHphlwwqXseDpkLWLxR6Zi8mrT2M77IEX0IIS7P3rR9EqO9IZ
         fvvUiEqdAlyVz1E8MK6N8EykquoMNcNU8TwwyHlTKgUmIiXhsvdV3ax0XQhUBfYKDlx6
         NkWj3eiCW9hp9zFM0T7xrh0TzP7ZnhOouDq8pHdWWEMTtZwGyLUl7ZeI4Z1dfIndQ9M7
         Ul+0oXOpmVeb2Pn/w/p+za/6ZWlj1FDopSjGluQ5TZ23OUxAQa8gqit9G9gRXZtjQggf
         o7Yw==
X-Gm-Message-State: AOAM530gn91DZmJWo/k0NSWYKs5CxTQ5hL+g7fERAGjyKBYBbuWPpVpa
        bXEsugAxChIEMXfPkwjqFM0WQW2gEdR50nfzfTo8CwuSe15mLPZ7YH6vZCV1x1jXAp6C55KAMZ/
        aVq5fu7DXhmwEsLPxGo76TPHv6zT+VHWsmIhlW/79fzrEfX9k6T+6t37JLYZ5jjs=
X-Google-Smtp-Source: ABdhPJx5UyeBbJbpH1fD0n+5FngOcNipZnAhq0fxt7lE9JH7kc9oAUGYSB98+Qmdbor2iOxegbt9JEnJZ3atng==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:cb94:b0:1bc:2e7e:535f with SMTP
 id a20-20020a17090acb9400b001bc2e7e535fmr19820967pju.21.1646109708059; Mon,
 28 Feb 2022 20:41:48 -0800 (PST)
Date:   Mon, 28 Feb 2022 20:41:25 -0800
In-Reply-To: <20220301044132.39474-1-chooglen@google.com>
Message-Id: <20220301044132.39474-7-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com> <20220301044132.39474-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2 06/13] submodule--helper: get remote names from any repository
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Atharva Raykar <raykar.ath@gmail.com>

`get_default_remote()` retrieves the name of a remote by resolving the
refs from of the current repository's ref store.

Thus in order to use it for retrieving the remote name of a submodule,
we have to start a new subprocess which runs from the submodule
directory.

Let's instead introduce a function called `repo_get_default_remote()`
which takes any repository object and retrieves the remote accordingly.

`get_default_remote()` is then defined as a call to
`repo_get_default_remote()` with 'the_repository' passed to it.

Now that we have `repo_get_default_remote()`, we no longer have to start
a subprocess that called `submodule--helper get-default-remote` from
within the submodule directory.

So let's make a function called `get_default_remote_submodule()` which
takes a submodule path, and returns the default remote for that
submodule, all within the same process.

We can now use this function to save an unnecessary subprocess spawn in
`sync_submodule()`, and also in the next patch, which will require this
functionality.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Helped-by: Glen Choo <chooglen@google.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 38 ++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6b473fc0d2..a58df3e007 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -31,11 +31,13 @@
 typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
 				  void *cb_data);
=20
-static char *get_default_remote(void)
+static char *repo_get_default_remote(struct repository *repo)
 {
 	char *dest =3D NULL, *ret;
 	struct strbuf sb =3D STRBUF_INIT;
-	const char *refname =3D resolve_ref_unsafe("HEAD", 0, NULL, NULL);
+	struct ref_store *store =3D get_main_ref_store(repo);
+	const char *refname =3D refs_resolve_ref_unsafe(store, "HEAD", 0, NULL,
+						      NULL);
=20
 	if (!refname)
 		die(_("No such ref: %s"), "HEAD");
@@ -48,7 +50,7 @@ static char *get_default_remote(void)
 		die(_("Expecting a full ref name, got %s"), refname);
=20
 	strbuf_addf(&sb, "branch.%s.remote", refname);
-	if (git_config_get_string(sb.buf, &dest))
+	if (repo_config_get_string(repo, sb.buf, &dest))
 		ret =3D xstrdup("origin");
 	else
 		ret =3D dest;
@@ -57,6 +59,19 @@ static char *get_default_remote(void)
 	return ret;
 }
=20
+static char *get_default_remote_submodule(const char *module_path)
+{
+	struct repository subrepo;
+
+	repo_submodule_init(&subrepo, the_repository, module_path, null_oid());
+	return repo_get_default_remote(&subrepo);
+}
+
+static char *get_default_remote(void)
+{
+	return repo_get_default_remote(the_repository);
+}
+
 static int print_default_remote(int argc, const char **argv, const char *p=
refix)
 {
 	char *remote;
@@ -1343,9 +1358,8 @@ static void sync_submodule(const char *path, const ch=
ar *prefix,
 {
 	const struct submodule *sub;
 	char *remote_key =3D NULL;
-	char *sub_origin_url, *super_config_url, *displaypath;
+	char *sub_origin_url, *super_config_url, *displaypath, *default_remote;
 	struct strbuf sb =3D STRBUF_INIT;
-	struct child_process cp =3D CHILD_PROCESS_INIT;
 	char *sub_config_path =3D NULL;
=20
 	if (!is_submodule_active(the_repository, path))
@@ -1384,21 +1398,15 @@ static void sync_submodule(const char *path, const =
char *prefix,
 	if (!is_submodule_populated_gently(path, NULL))
 		goto cleanup;
=20
-	prepare_submodule_repo_env(&cp.env_array);
-	cp.git_cmd =3D 1;
-	cp.dir =3D path;
-	strvec_pushl(&cp.args, "submodule--helper",
-		     "print-default-remote", NULL);
-
 	strbuf_reset(&sb);
-	if (capture_command(&cp, &sb, 0))
+	default_remote =3D get_default_remote_submodule(path);
+	if (!default_remote)
 		die(_("failed to get the default remote for submodule '%s'"),
 		      path);
=20
-	strbuf_strip_suffix(&sb, "\n");
-	remote_key =3D xstrfmt("remote.%s.url", sb.buf);
+	remote_key =3D xstrfmt("remote.%s.url", default_remote);
+	free(default_remote);
=20
-	strbuf_reset(&sb);
 	submodule_to_gitdir(&sb, path);
 	strbuf_addstr(&sb, "/config");
=20
--=20
2.33.GIT

