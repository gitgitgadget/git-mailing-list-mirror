Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6C33A1CE6
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833443; cv=none; b=kbdVZH9x+sYsLLj/u0c8uozNzwvcqi2Kb/VpKlN5R90qAmmcwIb/2vTqfXJ8guRzs+EV/7MPQWhCfiX5Uu8b7n2dIfM05DZgBoahBsOVZzocDlBPQgTReCfuCrkAO+YSwZMs8JoMH+LSXkLWcWKBJmRhfk+gXlwV1c1ShOvFffU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833443; c=relaxed/simple;
	bh=h/QQdXi7YjEThjF5UCRx0Nok0siJ5J2e4mYfQX8Tztc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1GwXVIYyzA4HA8/qw0SJKUS7jiClDjxTV6CD4lk05NujGLSFws2wsG3oBXXzdo8HSFpIY/NNDYdwOj/oj4Fd/AxEZzepRXxa15gBFkhQCkVpkc+GUtfTLFDrqZVQGYY0IsN3Wn6TjvqZXND+lzKPKx+OYJa+n4yhBhTzS70vYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhx2EB1w; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhx2EB1w"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ad135063so19893915e9.0
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 08:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775833440; x=1776438240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=302L+ih3NFo6fZRwKKT/wvJtKsWOsx2nOfZucYhHQJc=;
        b=jhx2EB1wjEUxDU12A2jyPBnlnChMvlJ6v1OHBy5v8BxMEeze190JY7qUFboMzgy8Vx
         VAwNV1vV+ng962xTEcMtiaS5JOJ1e4g1nyYuZi3LsvxiMdJ5J+as9IWgxgwVZ4rxA4bm
         x+XJdAodQLcJ1gtzuJ7pJrQr2pz2gtELDE3Y58P7OvRAeOUc/XPI515yrc6NaGlHLf5G
         EPu+D2BQ548gnqlSzWxCDlhsrt83ShRuZZgaDSApFNIsCIZ64vbwejAeu7aCrSWFBOM5
         5RlOz/BdgnpLJ4Uq+o2f0l1CTMjbeLGDFe4D0XYfrdE5XsMglw/RG9FYrPc/VDr6jf+c
         EX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775833440; x=1776438240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=302L+ih3NFo6fZRwKKT/wvJtKsWOsx2nOfZucYhHQJc=;
        b=aFZaPgBQ9xK+avRR1QnnxiYZ+09CoF3l6tCzZeqsTmdRBSymId+TpgwfVerpRTKaCK
         QzjGOVAo7pPHh0nNTznEvxrV0UJMAkXlq9eXMWLIwz8AYlC6xq2MH/xvvwn8Lp4Ia47u
         tRVtw/Q0QBEV7zSIjKt5do5LVla5GBrGwFFqisvfLERIFhJAtwNJ8xaSkLlw9QoUhXbA
         CUX1+ekWY3jYnRl5epn1QIWuO6Xn1ZSti7ZkncbfXbVmRfH0GKjXERP8rXjHSZ+u2hOr
         NJ4CRU0lRzuZqSZFc323tQTD1QfSaTJ8eV5apYFjcNd/zmGcQkzQGYpiTPqwSMaWK730
         w8PA==
X-Gm-Message-State: AOJu0YzM+vOThd5208VboRIyncONvTR648Md21WKPsgAzsXo/puC108W
	PVkfmQpJKyQYxprLGFiVzLsabIUy0ZkgUF87fn3FcjbrglGJ7PrYAYSNn2tKPbL1xc8=
X-Gm-Gg: AeBDieuLuPJ611VyOBZQvsLSy3DQfxGKOltkDEeCtAB4E28451mXWJDQ6kLmvHpuQLR
	PZMMs0k6pxIY8w3huMO9lJDQ3XB3WX52pFEd2sED/Ip4xLPuNKWX0h7Fp/YGu2Dpr/FRQ4G39Mx
	/YaSaEvxu+2ReenKfKBoA6v+CffKb8Y9Hi9i0Dl+0Xy1I7Odb22Ox7z/YIflWABJFHvbAqHfczf
	ieYOv1RVcS3DabiTerCWhiyhlilPqfIvI4Mz4tVNw2Jy88GiXC0BnkdkG/6dhuwa+xxXA5rWADO
	D1pJBYszORaFh1iTpc9c8Gnghs0ADigXe1ut1LeuFr2EZ0qeV1+VHnBVRW7pOQUB99nrN+o8glV
	cxhoA+mBCv6J2mO1igtkJ5KzIOlqj7AYeVfyPPoFeV1tuXnstHnFR9Hg1TFjO6cb90RgE+whPns
	WeLxEbe3PlQSIcTBRRvLiCLT9bcsVDX6acK3Hk8uYS1xeG7n/J1BTbnZ/vo/jXzEBtukEyd+hea
	Ax3rEJ/
X-Received: by 2002:a05:600c:8b27:b0:488:af7f:775f with SMTP id 5b1f17b1804b1-488d68766c7mr41807375e9.18.1775833439481;
        Fri, 10 Apr 2026 08:03:59 -0700 (PDT)
Received: from lorenzo-VM (host-79-19-37-238.retail.telecomitalia.it. [79.19.37.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d538c03esm79050795e9.13.2026.04.10.08.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:03:58 -0700 (PDT)
Date: Fri, 10 Apr 2026 17:03:56 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Tian Yuchen <cat@malon.dev>
Subject: [GSoC PATCH v4 3/5] repack-promisor: preserve content of promisor
 files after repack
Message-ID: <72ef2378b9cd50941b1c0c485bcbacb820e798c9.1775832056.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>

When a repack involving promisor packfiles happens, the new ".promisor"
file is created empty, losing all the debug info that might be present
inside the ".promisor" files before the repack.

Use the "copy_promisor_content()" function created previously to preserve
the contents of all ".promisor" files inside the first ".promisor" file
created by the repack.

For geometric repacking, we have to create a `strset` that contains the
basenames of all excluded packs. For "normal" repacking this is not
necessary, since there should be no excluded packs.

Also, update the documentation accordingly.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 Documentation/git-repack.adoc |  4 ++--
 repack-promisor.c             | 30 +++++++++++++++++-------------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
index 673ce91083..33d3c8afbd 100644
--- a/Documentation/git-repack.adoc
+++ b/Documentation/git-repack.adoc
@@ -45,8 +45,8 @@ other objects in that pack they already have locally.
 +
 Promisor packfiles are repacked separately: if there are packfiles that
 have an associated ".promisor" file, these packfiles will be repacked
-into another separate pack, and an empty ".promisor" file corresponding
-to the new separate pack will be written.
+into another separate pack, and a ".promisor" file corresponding to the
+new separate pack will be written (with arbitrary contents).
 
 -A::
 	Same as `-a`, unless `-d` is used.  Then any unreachable
diff --git a/repack-promisor.c b/repack-promisor.c
index 797314d7b9..0c373c8820 100644
--- a/repack-promisor.c
+++ b/repack-promisor.c
@@ -153,7 +153,8 @@ static void copy_promisor_content(struct repository *repo,
 static void finish_repacking_promisor_objects(struct repository *repo,
 					      struct child_process *cmd,
 					      struct string_list *names,
-					      const char *packtmp)
+					      const char *packtmp,
+					      struct strset *not_repacked_basenames)
 {
 	struct strbuf line = STRBUF_INIT;
 	FILE *out;
@@ -171,19 +172,15 @@ static void finish_repacking_promisor_objects(struct repository *repo,
 
 		/*
 		 * pack-objects creates the .pack and .idx files, but not the
-		 * .promisor file. Create the .promisor file, which is empty.
-		 *
-		 * NEEDSWORK: fetch-pack sometimes generates non-empty
-		 * .promisor files containing the ref names and associated
-		 * hashes at the point of generation of the corresponding
-		 * packfile, but this would not preserve their contents. Maybe
-		 * concatenate the contents of all .promisor files instead of
-		 * just creating a new empty file.
+		 * .promisor file. Create the .promisor file.
 		 */
 		promisor_name = mkpathdup("%s-%s.promisor", packtmp,
 					  line.buf);
 		write_promisor_file(promisor_name, NULL, 0);
 
+		/* Now let's fill the content of the newly created .promisor file */
+		copy_promisor_content(repo, line.buf, packtmp, not_repacked_basenames);
+
 		item->util = generated_pack_populate(item->string, packtmp);
 
 		free(promisor_name);
@@ -223,7 +220,7 @@ void repack_promisor_objects(struct repository *repo,
 		return;
 	}
 
-	finish_repacking_promisor_objects(repo, &cmd, names, packtmp);
+	finish_repacking_promisor_objects(repo, &cmd, names, packtmp, NULL);
 }
 
 void pack_geometry_repack_promisors(struct repository *repo,
@@ -234,6 +231,7 @@ void pack_geometry_repack_promisors(struct repository *repo,
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	FILE *in;
+	struct strset not_repacked_basenames = STRSET_INIT;
 
 	if (!geometry->promisor_split)
 		return;
@@ -247,9 +245,15 @@ void pack_geometry_repack_promisors(struct repository *repo,
 	in = xfdopen(cmd.in, "w");
 	for (size_t i = 0; i < geometry->promisor_split; i++)
 		fprintf(in, "%s\n", pack_basename(geometry->promisor_pack[i]));
-	for (size_t i = geometry->promisor_split; i < geometry->promisor_pack_nr; i++)
-		fprintf(in, "^%s\n", pack_basename(geometry->promisor_pack[i]));
+	for (size_t i = geometry->promisor_split; i < geometry->promisor_pack_nr; i++) {
+		const char *name = pack_basename(geometry->promisor_pack[i]);
+		fprintf(in, "^%s\n", name);
+		strset_add(&not_repacked_basenames, name);
+	}
 	fclose(in);
 
-	finish_repacking_promisor_objects(repo, &cmd, names, packtmp);
+	finish_repacking_promisor_objects(repo, &cmd, names, packtmp,
+			strset_get_size(&not_repacked_basenames) ? &not_repacked_basenames : NULL);
+
+	strset_clear(&not_repacked_basenames);
 }
-- 
2.53.0.585.ge25071d955

