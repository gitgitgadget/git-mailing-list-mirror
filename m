Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2338149E00
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 04:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734063982; cv=none; b=pivOpSD6Cz2gc0+AP8BdjMGSeQh/8RvEmsPCdLT7hz42HxC/+xodiACtCeXihX/ySJsH+Enxipheq6ab6fJ86OsApbkI2kEFbs+SFQVQGxGugX7SfFCJu7FpubWw+5I4pr3GRfPpTzReHkVtSwXbc8qbOCXXFMI43tOQnSl5flw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734063982; c=relaxed/simple;
	bh=72CM4Cjj7WtNHlTGSycHDBGt/RrWHpBODKp2lysFJfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oreWe36ZAkoDpbngZtoUWRoJ2FBDzmalILYM4GsYv02+l6oQXEHwWEUeGwmTubQfSieUp+3ohJ7A/NRgG7mBrneGrd3TAerC4w5X+XxGQRtoNs9l2bTW+X9Pz3NGgyR9uUOZGNOPYVocjP+o30RAw5xCs5xvNfwMkl/e67BkT1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTE4OdOD; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTE4OdOD"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71e2aa8d5e3so718139a34.2
        for <git@vger.kernel.org>; Thu, 12 Dec 2024 20:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734063980; x=1734668780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VX9SzKPvYczFjd/zgQ+OkdhEyEw8jdVyLWuQCELWD38=;
        b=LTE4OdODMpMU0F2FylhHF1LcSwG9KlyRJtdQndfm5vYwzlDOYhKSUjWuxnwtiPDOTl
         n+UGNciE6FU0O5UW/Ss+yL6ksZrl09ij6pY4pt35pSM+FuxKitF9PA+ch2aV94OlpPKN
         MxHefpj6bYCpSANFBwmEvgdi0l6ucgpoHcChnJqRITp67KSeMd3Do/yHFqy4FtvPCUVG
         qrYJXWu3LbGunqXWu2cIBrxmcWopFjmE0zONs3HSNDFAbF/Ke+VjnjK31udh+4TBQ97D
         YGDm0rscWzYTnpSg9T0ttTcE1uZOGFTHzXaS/KJBjkilslgW9KzrPrejbI9Hs6EAI77G
         Vh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734063980; x=1734668780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VX9SzKPvYczFjd/zgQ+OkdhEyEw8jdVyLWuQCELWD38=;
        b=SYctnqutqxzC3oTGMc75Yny3+PzcavqpVJxqv62LdH81mLtX7hfseaUfMln0Q5hGuA
         LrubXUaa0y+IPff1T46BknME2OMKdMO9HqC64E08+KyHHYGur6IAjyyrYEPff+bQ1R09
         Or4+9ijY+opbuAN+DYmaiQcm9H7rxwOZNO8fLVrDLndM9qYKKI0MTrhh8x+B3c8BYJwq
         N1lI6L/Rg+5DabFvn/NvFld+hb4po9TbcwcMpOPIk/sT8Bs0qcrVj8b9GqJrRDRHcxFp
         hZiZ4qzsTtk6UfIM4xqZEhUqBhANQK5JGulDaY/avkHiYconTW/sxE5gkywcFxu8d+UW
         bvFw==
X-Gm-Message-State: AOJu0YyeAg0a9S7Uu5oizB1l6TM9G+hFPJ/SAXQopqtyiSuMzkGUPLFK
	W1RSiP2Cdwh5FNCdXUGrS7x69Ch6gr4LuA0T72nUcZSNiD31Twop5WOuzQ==
X-Gm-Gg: ASbGnct+CxvZUlcUThcfAntoWHxqyNgXTa3zaNU9B5RWE4L4eRwjjtC5LMkMfi4qtTA
	d/UmN+zFmiuL47GtdVcg72w4VDQxGJ/i89Uz3jtoYgMUwxXuVf/QnMP8HND5G6YCC3i/Dk0rsTN
	c50OVzRsgy5ZKcKEw9ccX0Gygz6BMachDj4pEqVD0dlJJkoS/AMo+eLiFO7aOyVb7QtTAifnvux
	bDeVZSgp06EgKoYmOOI/ic8lJ0yhkZjHyJ34tahWFeWTAKhC9729orZMs0tFT95
X-Google-Smtp-Source: AGHT+IFTdjZh3bgrFjp84zMVa4lSdUSUnnfUS0js6LQetMiCRfNuccN+8DYhRk8FJtCR4YPBu+Jwpg==
X-Received: by 2002:a05:6830:6e18:b0:71d:f239:c0a8 with SMTP id 46e09a7af769-71e3b827be9mr665537a34.6.1734063979870;
        Thu, 12 Dec 2024 20:26:19 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71e37410edfsm342736a34.67.2024.12.12.20.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 20:26:19 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 2/3] builtin/diff-blob: add "--stdin" option
Date: Thu, 12 Dec 2024 22:23:11 -0600
Message-ID: <20241213042312.2890841-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213042312.2890841-1-jltobler@gmail.com>
References: <20241213042312.2890841-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is not a way to generate multiple blob diffs from a single
process. Similar to git-diff-tree(1) with its "--stdin" option, it would
be useful if multiple blob pairs could be provided to git-diff-blob(1)
to compute blob diffs for.

Teach git-diff-blob(1) the "--stdin" option to allow a pair of blobs to
be read from each line of stdin instead of relying on the single blob
pair provided as arguments. When this option is specified, each valid
line of input computes a blob diff thus allowing multiple blob diffs in
a single process. A blob may be specified by its ID or a path-scoped
revision that resolve to a blob. When a path-scoped revision is used,
path and mode information is also extracted and presented in the
resulting diff header.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-diff-blob.txt |  6 ++++
 builtin/diff-blob.c             | 64 +++++++++++++++++++++++++++++++++
 t/t4063-diff-blobs.sh           | 14 ++++++++
 3 files changed, 84 insertions(+)

diff --git a/Documentation/git-diff-blob.txt b/Documentation/git-diff-blob.txt
index 732992d1d7..f6ecd522fa 100644
--- a/Documentation/git-diff-blob.txt
+++ b/Documentation/git-diff-blob.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git diff-blob' <blob> <blob>
+'git diff-blob' --stdin
 
 DESCRIPTION
 -----------
@@ -20,6 +21,11 @@ OPTIONS
 <blob>::
 	The id of a blob object or path-scoped revision that resolves to a blob.
 
+--stdin::
+	When `--stdin` is specified, the command does not take <blob> arguments
+	from the command line.  Instead, it reads lines containing two <blob>
+	from its standard input.  (Use a single space as separator.)
+
 include::pretty-formats.txt[]
 
 include::diff-format.txt[]
diff --git a/builtin/diff-blob.c b/builtin/diff-blob.c
index 7cfa4eb436..45edfdd979 100644
--- a/builtin/diff-blob.c
+++ b/builtin/diff-blob.c
@@ -4,9 +4,12 @@
 #include "diffcore.h"
 #include "gettext.h"
 #include "hash.h"
+#include "object-name.h"
 #include "object.h"
 #include "parse-options.h"
 #include "revision.h"
+#include "strbuf.h"
+#include "string-list.h"
 
 static void diff_blobs(struct object_array_entry *old_blob,
 		       struct object_array_entry *new_blob,
@@ -59,18 +62,66 @@ static void diff_blobs(struct object_array_entry *old_blob,
 	diff_flush(opts);
 }
 
+static void parse_blob_stdin(struct object_array *blob_pair,
+			     struct repository *repo, const char *name)
+{
+	int flags = GET_OID_BLOB | GET_OID_RECORD_PATH;
+	struct object_context oc;
+	struct object_id oid;
+	struct object *obj;
+
+	if (get_oid_with_context(repo, name, flags, &oid, &oc))
+		die("invalid object %s given", name);
+
+	obj = parse_object_or_die(&oid, name);
+	if (obj->type != OBJ_BLOB)
+		die("object %s is not a blob", name);
+
+	add_object_array_with_path(obj, name, blob_pair, oc.mode, oc.path);
+	object_context_release(&oc);
+}
+
+static void diff_blob_stdin(struct repository *repo, struct diff_options *opts)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct string_list_item *item;
+
+	while (strbuf_getline(&sb, stdin) != EOF) {
+		struct object_array blob_pair = OBJECT_ARRAY_INIT;
+		struct string_list list = STRING_LIST_INIT_NODUP;
+
+		if (string_list_split_in_place(&list, sb.buf, " ", -1) != 2)
+			die("two blobs not provided");
+
+		for_each_string_list_item(item, &list) {
+			parse_blob_stdin(&blob_pair, repo, item->string);
+		}
+
+		diff_blobs(&blob_pair.objects[0], &blob_pair.objects[1], opts);
+
+		string_list_clear(&list, 1);
+		object_array_clear(&blob_pair);
+	}
+
+	strbuf_release(&sb);
+}
+
 int cmd_diff_blob(int argc, const char **argv, const char *prefix,
 		  struct repository *repo)
 {
 	struct object_array_entry *old_blob, *new_blob;
 	struct rev_info revs;
+	int read_stdin = 0;
 	int ret;
 
 	const char * const usage[] = {
 		N_("git diff-blob <blob> <blob>"),
+		N_("git diff-blob --stdin"),
 		NULL
 	};
 	struct option options[] = {
+		OPT_BOOL(0, "stdin", &read_stdin,
+			N_("read blob pairs from stdin")),
 		OPT_END()
 	};
 
@@ -93,7 +144,20 @@ int cmd_diff_blob(int argc, const char **argv, const char *prefix,
 		revs.diffopt.output_format = DIFF_FORMAT_PATCH;
 
 	switch (revs.pending.nr) {
+	case 0:
+		if (!read_stdin)
+			usage_with_options(usage, options);
+
+		revs.diffopt.no_free = 1;
+		diff_blob_stdin(repo, &revs.diffopt);
+		revs.diffopt.no_free = 0;
+		diff_free(&revs.diffopt);
+
+		break;
 	case 2:
+		if (read_stdin)
+			usage_with_options(usage, options);
+
 		old_blob = &revs.pending.objects[0];
 		new_blob = &revs.pending.objects[1];
 
diff --git a/t/t4063-diff-blobs.sh b/t/t4063-diff-blobs.sh
index 23615565fe..d7785d4a6e 100755
--- a/t/t4063-diff-blobs.sh
+++ b/t/t4063-diff-blobs.sh
@@ -98,4 +98,18 @@ for cmd in $commands; do
 	'
 done
 
+test_expect_success 'diff-blob --stdin with blob ID' '
+	echo $sha1_one $sha1_two | git diff-blob --full-index --stdin >diff &&
+	check_index $sha1_one $sha1_two &&
+	check_paths $sha1_one $sha1_two &&
+	! grep mode diff
+'
+
+test_expect_success 'diff-blob --stdin with revision' '
+	echo HEAD:one HEAD:two | git diff-blob --full-index --stdin >diff &&
+	check_index $sha1_one $sha1_two &&
+	check_paths one two &&
+	check_mode 100644 100755
+'
+
 test_done
-- 
2.47.1

