Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C78B29BD91
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097328; cv=none; b=d2ZiyNMMw+a1g8HEWogV6ZSe1poByT2dQSUXI/YVVLMY/QATt61vYHduedBxW3XX0ggrj7/xot6jXFJHSc2eaxeZ1RbqrLRXf5J42kTHeALMhRAYz1q+nnjHdt3+U28C0cXDgWSYaKoPeKYA4ljl+qrjlAVZFoa2L8vS50pHAuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097328; c=relaxed/simple;
	bh=4HOp1LJHr8BoxtIH/RyVSwBsMmwUThJzGdon8S16Ugc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCB+8rcvp5oPuKGBBJKECsqs2r1fj4O7q+7km8ANvwnjyu4TES8xosxZWiXf/YlaA7gi80werlaz8gVIOeZy47I66mej3zD3YLZDlcSTQmAySn2b5mMaquRtfJWijT4GPTSQds1qiw2VGofgjMVmoQG9JnfSQmsBQeLPoTQtSdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=WjEO+aUA; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="WjEO+aUA"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6353ff1a78dso2807879d50.0
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097325; x=1759702125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KrL43T0wa+SBi30kDxc91zurCDusJQAzj4yPPhk5PMs=;
        b=WjEO+aUAnDVxKGtkXEUo/2EXfxXfiXDhJLeq861joZ4GPFexMbX74RRN3tiZJmANue
         3nT7wiX4zlyPGzVaE4v848V2Qq069jRzSkbX1JSDAxXPurtsYinrL6Rh2TW5+8rQFIB2
         anBhl6awSRWmRW6gNxICrfyfWXEcuCTwwaf5e5hXCLy5b618PS5dQqFB9ChSSEXHsYN2
         32P+HDAR2l1bkMmnvNYtMTZTAluwQnx4ahILFwR0i5cWIafhA9uGEWTWrZXeOQEr5s1+
         mmqKNcpAzxUmrtH8kHt8JjB5ko3bN4nehqtT9mO6KqsX57YUL7px5hcsUMvUE8RMNqp2
         maIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097325; x=1759702125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrL43T0wa+SBi30kDxc91zurCDusJQAzj4yPPhk5PMs=;
        b=BMcdUvwEo5kjQ3fh1xQF6pm//eoPL6Yyp/7zfLQKZhWVSdVE9VRFyx4htrdU1SqRAR
         +CtNZUlKSaQtnRb15Fr7dHeVSaMJc8RVEmDTgdoirvNVJlZYEpKGUxVDeTaOTvqf0phc
         CXXE65Faoh57/4ch2IVI44MwqqK8N1Tns/PdrdIx5DZIbKu0kabSO0snUgKhbAfU0DNM
         PwCSyNN3TdK4ZduHNnAJnrmX6mSMvV99ZaKC3la2htcVunnVOQ4cWCRnyJBGjP29MRI/
         wzIitQJ56CxaRZMQdkLVcrgORLBG/+7QcW555moPfOsnWhovHucE3mKgZ7SnHg+F0Zyf
         Fvxg==
X-Gm-Message-State: AOJu0YzDKyrt+Xa0XbaH3uHJDKCSDTO5L3sdXcfHosbN9DTxSGv8rJf1
	NqLzsvDBnni5ConMXZ8Lc6wcSpGj6ol/Ml/bgmSFKIgjWjiwLeaWt46DVMdPL7eOCaqBYC56Pmu
	ZA1uZu9U=
X-Gm-Gg: ASbGncuF09zDCRE1+CqWZWxoaOzVlxtEIv8GpQxNq3cTWPv6tKtaodOLw4N+HpfCJap
	4H71DigksFIhsqlAO+6wXvrLd6+HmlWbVq2xHeTiQbJ3tiqEohP0UHNx4Y/c9sQlZ+01e1TiP8h
	EblKqU/rewy2sE8P5ERVKrV90YplT52fcrxExzkxKFBQ8ZuWDVL8gwpoSfmeO9lheo8Er/INH9b
	fdQ8+kgaR7iflzji/TmOJolCM0FBVQ6jwQMlevKGxmCsl03mxduzJ33aLu9r4JkGLhc3VFTZRL9
	uxZZ4NvGjsuFDWq3tCjWgzAMnXkDvecKFfsEWeIuJSfg7zMd25w01bmaZLKRYPHS9/eL/AqM8wi
	aE7SgIPteOPAzmcgsHSaXawlpj8EJuRbBMM14+3WM0RVaKjQPsbQzKwMqHBtJFuYPI1apoaesQw
	auObd3txNKSibL6s3CMFJkVvxPc9at9wV2afv9
X-Google-Smtp-Source: AGHT+IFZV5bRoJbmxym+9AEgqYqZ4vjkrDiljma7DHcZYwA6N0djEuW6VUfDrK0PHsSxpRgEdW5GrQ==
X-Received: by 2002:a05:690e:1512:b0:635:4ecd:75a5 with SMTP id 956f58d0204a3-6361a8ad0bcmr15462244d50.51.1759097325574;
        Sun, 28 Sep 2025 15:08:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-eb3e96db2f8sm2537601276.23.2025.09.28.15.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:08:45 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:08:43 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 24/49] repack: remove 'generated_pack' API from the builtin
Message-ID: <9979b77979b1f2611dbb2ff8369d596a6130c55b.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

Now that we have factored the "generated_pack" API, we can move it to
repack.ch, further slimming down builtin/repack.c.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 83 ------------------------------------------------
 repack.c         | 83 ++++++++++++++++++++++++++++++++++++++++++++++++
 repack.h         |  8 +++++
 3 files changed, 91 insertions(+), 83 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index a4f0a19453..b7826e676b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -134,89 +134,6 @@ static int write_oid(const struct object_id *oid,
 	return 0;
 }
 
-static struct {
-	const char *name;
-	unsigned optional:1;
-} exts[] = {
-	{".pack"},
-	{".rev", 1},
-	{".mtimes", 1},
-	{".bitmap", 1},
-	{".promisor", 1},
-	{".idx"},
-};
-
-struct generated_pack {
-	struct tempfile *tempfiles[ARRAY_SIZE(exts)];
-};
-
-static struct generated_pack *generated_pack_populate(const char *name,
-						      const char *packtmp)
-{
-	struct stat statbuf;
-	struct strbuf path = STRBUF_INIT;
-	struct generated_pack *pack = xcalloc(1, sizeof(*pack));
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(exts); i++) {
-		strbuf_reset(&path);
-		strbuf_addf(&path, "%s-%s%s", packtmp, name, exts[i].name);
-
-		if (stat(path.buf, &statbuf))
-			continue;
-
-		pack->tempfiles[i] = register_tempfile(path.buf);
-	}
-
-	strbuf_release(&path);
-	return pack;
-}
-
-static int generated_pack_has_ext(const struct generated_pack *pack,
-				  const char *ext)
-{
-	int i;
-	for (i = 0; i < ARRAY_SIZE(exts); i++) {
-		if (strcmp(exts[i].name, ext))
-			continue;
-		return !!pack->tempfiles[i];
-	}
-	BUG("unknown pack extension: '%s'", ext);
-}
-
-static void generated_pack_install(struct generated_pack *pack,
-				   const char *name,
-				   const char *packdir, const char *packtmp)
-{
-	int ext;
-	for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
-		char *fname;
-
-		fname = mkpathdup("%s/pack-%s%s", packdir, name,
-				  exts[ext].name);
-
-		if (pack->tempfiles[ext]) {
-			const char *fname_old = get_tempfile_path(pack->tempfiles[ext]);
-			struct stat statbuffer;
-
-			if (!stat(fname_old, &statbuffer)) {
-				statbuffer.st_mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
-				chmod(fname_old, statbuffer.st_mode);
-			}
-
-			if (rename_tempfile(&pack->tempfiles[ext], fname))
-				die_errno(_("renaming pack to '%s' failed"),
-					  fname);
-		} else if (!exts[ext].optional)
-			die(_("pack-objects did not write a '%s' file for pack %s-%s"),
-			    exts[ext].name, packtmp, name);
-		else if (unlink(fname) < 0 && errno != ENOENT)
-			die_errno(_("could not unlink: %s"), fname);
-
-		free(fname);
-	}
-}
-
 static void repack_promisor_objects(struct repository *repo,
 				    const struct pack_objects_args *args,
 				    struct string_list *names)
diff --git a/repack.c b/repack.c
index 9182e1c50b..d8afdd352d 100644
--- a/repack.c
+++ b/repack.c
@@ -3,9 +3,11 @@
 #include "midx.h"
 #include "odb.h"
 #include "packfile.h"
+#include "path.h"
 #include "repack.h"
 #include "repository.h"
 #include "run-command.h"
+#include "tempfile.h"
 
 void prepare_pack_objects(struct child_process *cmd,
 			  const struct pack_objects_args *args,
@@ -219,3 +221,84 @@ void existing_packs_release(struct existing_packs *existing)
 	string_list_clear(&existing->non_kept_packs, 0);
 	string_list_clear(&existing->cruft_packs, 0);
 }
+
+static struct {
+	const char *name;
+	unsigned optional:1;
+} exts[] = {
+	{".pack"},
+	{".rev", 1},
+	{".mtimes", 1},
+	{".bitmap", 1},
+	{".promisor", 1},
+	{".idx"},
+};
+
+struct generated_pack {
+	struct tempfile *tempfiles[ARRAY_SIZE(exts)];
+};
+
+struct generated_pack *generated_pack_populate(const char *name,
+					       const char *packtmp)
+{
+	struct stat statbuf;
+	struct strbuf path = STRBUF_INIT;
+	struct generated_pack *pack = xcalloc(1, sizeof(*pack));
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(exts); i++) {
+		strbuf_reset(&path);
+		strbuf_addf(&path, "%s-%s%s", packtmp, name, exts[i].name);
+
+		if (stat(path.buf, &statbuf))
+			continue;
+
+		pack->tempfiles[i] = register_tempfile(path.buf);
+	}
+
+	strbuf_release(&path);
+	return pack;
+}
+
+int generated_pack_has_ext(const struct generated_pack *pack, const char *ext)
+{
+	size_t i;
+	for (i = 0; i < ARRAY_SIZE(exts); i++) {
+		if (strcmp(exts[i].name, ext))
+			continue;
+		return !!pack->tempfiles[i];
+	}
+	BUG("unknown pack extension: '%s'", ext);
+}
+
+void generated_pack_install(struct generated_pack *pack, const char *name,
+			    const char *packdir, const char *packtmp)
+{
+	size_t ext;
+	for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
+		char *fname;
+
+		fname = mkpathdup("%s/pack-%s%s", packdir, name,
+				  exts[ext].name);
+
+		if (pack->tempfiles[ext]) {
+			const char *fname_old = get_tempfile_path(pack->tempfiles[ext]);
+			struct stat statbuffer;
+
+			if (!stat(fname_old, &statbuffer)) {
+				statbuffer.st_mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
+				chmod(fname_old, statbuffer.st_mode);
+			}
+
+			if (rename_tempfile(&pack->tempfiles[ext], fname))
+				die_errno(_("renaming pack to '%s' failed"),
+					  fname);
+		} else if (!exts[ext].optional)
+			die(_("pack-objects did not write a '%s' file for pack %s-%s"),
+			    exts[ext].name, packtmp, name);
+		else if (unlink(fname) < 0 && errno != ENOENT)
+			die_errno(_("could not unlink: %s"), fname);
+
+		free(fname);
+	}
+}
diff --git a/repack.h b/repack.h
index 19796e2243..f37eb49524 100644
--- a/repack.h
+++ b/repack.h
@@ -66,4 +66,12 @@ void existing_packs_remove_redundant(struct existing_packs *existing,
 				     const char *packdir);
 void existing_packs_release(struct existing_packs *existing);
 
+struct generated_pack;
+
+struct generated_pack *generated_pack_populate(const char *name,
+					       const char *packtmp);
+int generated_pack_has_ext(const struct generated_pack *pack, const char *ext);
+void generated_pack_install(struct generated_pack *pack, const char *name,
+			    const char *packdir, const char *packtmp);
+
 #endif /* REPACK_H */
-- 
2.51.0.243.g16eca91f2c0

