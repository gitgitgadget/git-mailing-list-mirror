Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AF726D4E8
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751405865; cv=none; b=BIGrGdJ1+/7Sp0STn/hkPoqqzlWB/874CK3Ean5EoGNmBJiH+98odxJjrl5E1Kxgka8gR6hMopxV+m3Ez7AoA5rnmXTl0lHd+8qM10Shdg56bxfQjFDY7otah80cyWec3cTym4/MVrjl2TjaBKH2FAzjuapbC+T15S9g34p/LM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751405865; c=relaxed/simple;
	bh=C54z5rezQSznh3IJ2WGwd/haJuBLII0UKSkqt6HHJ7g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ItfHMOGJ3Z7qFysFrJ0yoHGG0mDD4/h4HYc6TF2fmf2BSSSfhaHCZG+1f29WP9P6Ezghh1eE9A+ugSmId8ZJuVTIPXnUy1jE34eadHT80QTDhMhjRCVJr2cQLpu9zP0e5/78NW5NuASGgCqx7b8PbqyA39qqld7vwSKbY4G7oZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJ10NjET; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJ10NjET"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234b9dfb842so34551175ad.1
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 14:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751405861; x=1752010661; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxZvIuiNapi7Og2DhL38it3i1x4AOzsxlavzNgA6NBI=;
        b=YJ10NjETQy+mfaiero3kfy+GUYojzRMuE9uPdQWwGD1Qt/F2PpyIqipjUsbsqSZLO8
         pgcoi98zuJLjRs++jdY+7mNJldjO/eh/k0JiJYaKd7wX5P3yoZMWVfyRc0b4ZB3uZDyz
         AgOgOHR/BiVMWSdYg4F/1akQwuDyOiMrb4b1XOsFAIqWv2t1Gq67A/vIS0kIFjaE9UMt
         kAnck6zHG3LBxFialuwTfDq/OfpjBSl1cgAUtCW4XAQlL7L+QORozGWMdvqUUJHqRPGU
         SOnr6fAsyKdOEw33ujP5kj7c6W8B6P5lBJBF6LnXOejwOi4gnW/KTRaVHP4ZBR2VpqVk
         jx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751405861; x=1752010661;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zxZvIuiNapi7Og2DhL38it3i1x4AOzsxlavzNgA6NBI=;
        b=r1hliqTxPQLa5IwLxyVM9VkJnWpCJ7JsPIY+fB1c+wRG31kr2ACC9XV0mmKOcl3eQv
         u4QvO/uBG0vZ3FJHhUvy5FMGJkEdYqkY14BXYqX2S+mOsooBfIFf/r/TLbjGXM5XK+z4
         4rSRP634z5a2lcJPSk1z50ekAGvS3PbQ9Kn/bxt1IIbHmS5WUuWEGcru4zcfE2yJhf42
         NoN/2QNM0TjuWZ1zmn0jBzZq8FmYERripLzfdNl8yK4pWLlFiyxLXIejT2FmReR0KH5f
         SkTx1iSLC9IlPTZ4z9Gb0oAtHNKHTfl2MMewSiCY/RB73aMUX1koyZSPOn+pi1ZC5pL3
         mzNA==
X-Gm-Message-State: AOJu0YzWccGb++hWBNka63I/MZBLjixpVRS8tfM4l1Rt7rC3nnyo4TfU
	fdF4xP4mS/Qtt8fAWitngCvK1698J0Nl8mdCcC8kHaoIOXE6lZy+LLw8
X-Gm-Gg: ASbGnctV5lPGNYyqoioDCq7y+Pp9rAWFoQpLZqoW9f1XxVHBrTqbPLAvGQEDZ32ax/J
	WbeNDLggB6lXvlr68vaU37zMnZBjyaP+X/k6Da0OSCc1L4FkIy9YFXCoddi8y5ScR5n8+JQfQW2
	ZqVXTcY1RWpuHTi7JeO5xMtDRDaZGKFEPpV0ukoVPl5ANrpvV+NVi/XLR1OoO135xOgptX8OPXH
	aGFDFthAytGrbo+wLocrTepkr+NX0A3DeX2iY5xqjFa1+sa31M6vV+gCY5cRNp6VKQuBXWQEtqF
	OHZvk6RLulg2ZRqaeoY0aaeIV3JkNMYD3Jl2zodGamuczB1VuVc9dg8WoJTcA2h1emO7eDWegT7
	6FStnfuPC7ZieTWdCyAtVj9AgCCQ=
X-Google-Smtp-Source: AGHT+IEQ2jdnaj4QrbNvm+kKtgMWe9RQ2tv2PBEGaypTfteAE3im+Sd6yye+pxE+vowmLOX44sEVHA==
X-Received: by 2002:a17:902:f70b:b0:234:b430:cea7 with SMTP id d9443c01a7336-23c6e51015fmr3778405ad.22.1751405861429;
        Tue, 01 Jul 2025 14:37:41 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb39bc7dsm112203555ad.114.2025.07.01.14.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 14:37:41 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH 0/4] for-each-ref: introduce seeking functionality via
 '--skip-until'
In-Reply-To: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
	(Karthik Nayak's message of "Tue, 01 Jul 2025 17:03:26 +0200")
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
Date: Tue, 01 Jul 2025 14:37:40 -0700
Message-ID: <xmqqms9niod7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Offtopic.  After applying this topic, I asked clang-format if it
wants to change anything.

    $ git clang-format --diff $(git merge-base HEAD master)

The result was disasterous.  Can "clang-format --diff" mode be
taught a bit more focused to avoid touching existing entries in the
same array (in this case opts[] that has tons of options for the
"git for-each-ref" command), when only one new entry was added, I
wonder?

Also I am not impressed by the change it made to the code that is
commented out (in refs.h).

Line wrapping it did to refs_ref_iterator_begin() is an improvement,
but those to ref_iterator_seek() and do_for_each_ref_iterator() are
unnecessary (both of these were more readble in the original).

Even though I found its output better for Toon's "last-modified"
changes, I am not impressed by what clang-format suggested for this
series.


diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 543013cd11..39056557d4 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -8,7 +8,7 @@
 #include "strbuf.h"
 #include "strvec.h"
 
-static char const * const for_each_ref_usage[] = {
+static char const *const for_each_ref_usage[] = {
 	N_("git for-each-ref [<options>] [<pattern>]"),
 	N_("git for-each-ref [--points-at <object>]"),
 	N_("git for-each-ref [--merged [<commit>]] [--no-merged [<commit>]]"),
@@ -33,32 +33,41 @@ int cmd_for_each_ref(int argc,
 	struct option opts[] = {
 		OPT_BIT('s', "shell", &format.quote_style,
 			N_("quote placeholders suitably for shells"), QUOTE_SHELL),
-		OPT_BIT('p', "perl",  &format.quote_style,
+		OPT_BIT('p', "perl", &format.quote_style,
 			N_("quote placeholders suitably for perl"), QUOTE_PERL),
-		OPT_BIT(0 , "python", &format.quote_style,
-			N_("quote placeholders suitably for python"), QUOTE_PYTHON),
-		OPT_BIT(0 , "tcl",  &format.quote_style,
+		OPT_BIT(0, "python", &format.quote_style,
+			N_("quote placeholders suitably for python"),
+			QUOTE_PYTHON),
+		OPT_BIT(0, "tcl", &format.quote_style,
 			N_("quote placeholders suitably for Tcl"), QUOTE_TCL),
-		OPT_BOOL(0, "omit-empty",  &format.array_opts.omit_empty,
-			N_("do not output a newline after empty formatted refs")),
+		OPT_BOOL(0, "omit-empty", &format.array_opts.omit_empty,
+			 N_("do not output a newline after empty formatted refs")),
 
 		OPT_GROUP(""),
-		OPT_INTEGER( 0 , "count", &format.array_opts.max_count, N_("show only <n> matched refs")),
-		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
-		OPT_STRING(  0 , "skip-until", &filter.seek, N_("skip-until"), N_("skip references until")),
+		OPT_INTEGER(0, "count", &format.array_opts.max_count,
+			    N_("show only <n> matched refs")),
+		OPT_STRING(0, "format", &format.format, N_("format"),
+			   N_("format to use for the output")),
+		OPT_STRING(0, "skip-until", &filter.seek, N_("skip-until"),
+			   N_("skip references until")),
 		OPT__COLOR(&format.use_color, N_("respect format colors")),
 		OPT_REF_FILTER_EXCLUDE(&filter),
 		OPT_REF_SORT(&sorting_options),
-		OPT_CALLBACK(0, "points-at", &filter.points_at,
-			     N_("object"), N_("print only refs which points at the given object"),
+		OPT_CALLBACK(0, "points-at", &filter.points_at, N_("object"),
+			     N_("print only refs which points at the given object"),
 			     parse_opt_object_name),
 		OPT_MERGED(&filter, N_("print only refs that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only refs that are not merged")),
-		OPT_CONTAINS(&filter.with_commit, N_("print only refs which contain the commit")),
-		OPT_NO_CONTAINS(&filter.no_commit, N_("print only refs which don't contain the commit")),
-		OPT_BOOL(0, "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
-		OPT_BOOL(0, "stdin", &from_stdin, N_("read reference patterns from stdin")),
-		OPT_BOOL(0, "include-root-refs", &include_root_refs, N_("also include HEAD ref and pseudorefs")),
+		OPT_CONTAINS(&filter.with_commit,
+			     N_("print only refs which contain the commit")),
+		OPT_NO_CONTAINS(&filter.no_commit,
+				N_("print only refs which don't contain the commit")),
+		OPT_BOOL(0, "ignore-case", &icase,
+			 N_("sorting and filtering are case insensitive")),
+		OPT_BOOL(0, "stdin", &from_stdin,
+			 N_("read reference patterns from stdin")),
+		OPT_BOOL(0, "include-root-refs", &include_root_refs,
+			 N_("also include HEAD ref and pseudorefs")),
 		OPT_END(),
 	};
 
diff --git a/refs.h b/refs.h
index c5e08db0ff..518b17c748 100644
--- a/refs.h
+++ b/refs.h
@@ -1229,7 +1229,8 @@ int repo_migrate_ref_storage_format(struct repository *repo,
  *
  *             // Access information about the current reference:
  *             if (!(iter->flags & REF_ISSYMREF))
- *                     printf("%s is %s\n", iter->refname, oid_to_hex(iter->oid));
+ *                     printf("%s is %s\n", iter->refname,
+ * oid_to_hex(iter->oid));
  *
  *             // If you need to peel the reference:
  *             ref_iterator_peel(iter, &oid);
@@ -1284,10 +1285,11 @@ enum do_for_each_ref_flags {
  * trim that many characters off the beginning of each refname.
  * The output is ordered by refname.
  */
-struct ref_iterator *refs_ref_iterator_begin(
-		struct ref_store *refs,
-		const char *prefix, const char **exclude_patterns,
-		int trim, enum do_for_each_ref_flags flags);
+struct ref_iterator *refs_ref_iterator_begin(struct ref_store *refs,
+					     const char *prefix,
+					     const char **exclude_patterns,
+					     int trim,
+					     enum do_for_each_ref_flags flags);
 
 /*
  * Advance the iterator to the first or next item and return ITER_OK.
@@ -1317,8 +1319,8 @@ int ref_iterator_advance(struct ref_iterator *ref_iterator);
  *
  * Returns 0 on success, a negative error code otherwise.
  */
-int ref_iterator_seek(struct ref_iterator *ref_iterator,
-		      const char *seek, int set_prefix);
+int ref_iterator_seek(struct ref_iterator *ref_iterator, const char *seek,
+		      int set_prefix);
 
 /*
  * If possible, peel the reference currently being viewed by the
@@ -1339,8 +1341,7 @@ void ref_iterator_free(struct ref_iterator *ref_iterator);
  * adapter between the callback style of reference iteration and the
  * iterator style.
  */
-int do_for_each_ref_iterator(struct ref_iterator *iter,
-			     each_ref_fn fn, void *cb_data);
-
+int do_for_each_ref_iterator(struct ref_iterator *iter, each_ref_fn fn,
+			     void *cb_data);
 
 #endif /* REFS_H */
diff --git a/refs/iterator.c b/refs/iterator.c
index 1f99045d40..2b7f019c3e 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -15,8 +15,8 @@ int ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ref_iterator->vtable->advance(ref_iterator);
 }
 
-int ref_iterator_seek(struct ref_iterator *ref_iterator,
-		      const char *seek, int set_prefix)
+int ref_iterator_seek(struct ref_iterator *ref_iterator, const char *seek,
+		      int set_prefix)
 {
 	return ref_iterator->vtable->seek(ref_iterator, seek, set_prefix);
 }
@@ -57,8 +57,7 @@ static int empty_ref_iterator_advance(struct ref_iterator *ref_iterator UNUSED)
 }
 
 static int empty_ref_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
-				   const char *seek UNUSED,
-				   int set_prefix UNUSED)
+				   const char *seek UNUSED, int set_prefix UNUSED)
 {
 	return 0;
 }
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 656e6cd9ff..b812520dc7 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -525,7 +525,8 @@ static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
 				level->dir = dir;
 				level->index = -1;
 			} else {
-				/* reduce the index so the leaf node is iterated over */
+				/* reduce the index so the leaf node is iterated
+				 * over */
 				if (cmp <= 0 && !slash)
 					level->index = idx - 1;
 				/*
