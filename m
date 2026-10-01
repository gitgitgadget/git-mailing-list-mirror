Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B4141D100
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 04:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790827912; cv=none; b=tqy0X6pmLPX5BODlYqNZTllZCHRsuENhcrFD5zU5iRlWxpI/BwTCc2fmtjromg3qop/OmLnoPkpKTKK8rjPwHe1W6QcvUvyEksrD72ciWJwe6l86VuL/20ZpDxCN/o9JXdAR+bH/ZCarzPwNcpr47wm85gcD7cJLCCXIn0PPvoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790827912; c=relaxed/simple;
	bh=9SrZ67QXZ+dDqQefpLEO1o/Hv56/ii62H12dtn8hWHo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDsE9xPKu3PCqeGbSnW6A26lQDzWP3v0JAd2IYlzayZz3lO5qTYfRMziFoKIt8jv7/2st7FiDyWtddhb0Y7ZwmHrYiiiZ8r4vbaE+XYd5VTI3t2ijIena9dQduBFxDY0ll6F8Bsy49Y/ybpM4q0cXg30uiXZ3I/TjWeeJQDsmc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=dtKMtqES; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="dtKMtqES"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-81b02c279beso3645396a34.2
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 21:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790827910; x=1791432710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+ZOSoG/QYAxhgNSRMODGynDiPZhhs7jq9e5kU0Tg1S0=;
        b=dtKMtqESwWmWRezwug40/qW/Q9czaGf//h2UwEpm760Nv+UEsNr1g4xKhGBAtDI0Bf
         YmaJ9hpXuDkj9NDY4YaPVRaarDj9JA6IoQVVJyLPrakx023fZcor/EZJTF8kmz0QLKJH
         8oBVBnpUW5S/OIobO8yj15Z2p/y+AgaWhAVsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790827910; x=1791432710;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ZOSoG/QYAxhgNSRMODGynDiPZhhs7jq9e5kU0Tg1S0=;
        b=Qxh1QekzSvnCUzaMNOQb4YyQQGCegmhEISK2qWlADkQKAZVoC5IkerxCwHM9zMDArF
         zbv0fmCksYCHKyD5JyGmngvxjniexjORRW1z7fwJXI9+RbFJeJ14Wd4uDz4ok2N5GAGd
         5msvuMzcK+bPMPKUywnEO+5IlecaHpKvbazwLdBj/U7Fm3p4ywplKdk0I0yLpT2zIidg
         ud7/b27N5h7g4CKir4GVhEtYTalT1q9UWDw2fYrawmaJCUrhZqyOQQHL/GpE+tX7DBp4
         YNdOzTjrkyZYS/KRnWX/dgacMrL1HBgOC7NLp3QRUUIO1OJghRCxkpa89xoEHVChtnh2
         BrDg==
X-Gm-Message-State: AFuF++k+NVOKbIqOmwcegJgXNG5jqGICmTdFe9kI4aQ984RtR2w/aZp1
	D43qLDqxB7yWciSjgNUo94EYLru+UxuWFHeHn+kSUQXsoxtJn/E0CUoKMrllJTdxB5T/9cM0lM+
	TZ/Lk6QI=
X-Gm-Gg: AYBFou3XbsFAYv70CRBu55w5wX9mhYlh5wnAyonTeFvXSXgneyjYlUS7YbG83nEjULj
	gZSI8PhFh3opRcoM6yMjTRy5NQSx5vbtLX13toKmvqwQYH6mi2Iuv+J6PBys0LyuQKhHncv62xP
	ydp5ssmdJ97Z7x5ydvNmkkcurUSxPQUts4hLTnTcummlDvvk7GhqHXJvk2Y02US7RoqtqpdFcLw
	9qYvTaG7lGXzCEccZ4bUtdm5C8rccJOIdO8fiXlimIijth5vhZLaETbubDj2PXuuY7Yiz1p8LH2
	itBr5imluYhS9Ab7niNXof1TNrrAv6GPyOC3VY68CkzUEZo/Ft2J+Dt8mQdx3QZYysrEAzig3I7
	Rnwp4/OW0OtCxvADFSomzjoX6R2MGTeT4w46hStHSjj7Jy+Z4aLFVqSRPWxxLQkKN+8gUNSnEbE
	7jjIVHPLlpVeyAjJFnplQBATTsGHK8zGZnvL23/JY4y2UuIjuebeaP7+xEd0mrS/LQ0ZL4Im5+Z
	KBFYzlV71i4sbDMRycIOtDSNWgYGgAZVWwPEoR8Wrx5FHy00idsSfkBFbABCx67OgqGtMjUTe0L
	zjS1ceUZ
X-Received: by 2002:a4a:ee83:0:b0:6d8:1b5b:3a7d with SMTP id 006d021491bc7-6dcf4c6ad6fmr3871625eaf.22.1790827910277;
        Wed, 30 Sep 2026 21:11:50 -0700 (PDT)
Received: from com-79390 (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6dd950876dbsm1993578eaf.1.2026.09.30.21.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 21:11:49 -0700 (PDT)
From: Taylor Blau <ttaylorr@openai.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date: Wed, 30 Sep 2026 23:11:47 -0500
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: [PATCH v2 4/8] repack: use a sorted list for explicitly kept packs
Message-ID: <c1ff18bf91363c638536265c600a7ce5ac4e1218.1790827875.git.me@ttaylorr.com>
References: <cover.1790731662.git.me@ttaylorr.com>
 <cover.1790827875.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1790827875.git.me@ttaylorr.com>

`existing_packs_collect()` performs a linear search through the
'--keep-pack' arguments for each local pack. Typically the number of
such arguments is small enough that the difference between a linear and
binary search is just noise (especially compared with the amount of work
that 'repack' is about to perform).

However, an additional caller will wish to search through the same list.
To prevent that caller from having to duplicate the clunky for-loop in
`existing_packs_collect()`, sort the list using `fspathcmp()` and
replace the existing caller's loop with `string_list_has_string()`.

This does not change the overall behavior of '--keep-pack' arguments.

Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
 builtin/repack.c | 3 +++
 repack.c         | 8 +-------
 repack.h         | 4 ++++
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index b7596d488da..88b05e96b5b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -2,6 +2,7 @@
 
 #include "builtin.h"
 #include "config.h"
+#include "dir.h"
 #include "environment.h"
 #include "parse-options.h"
 #include "path.h"
@@ -455,6 +456,8 @@ int cmd_repack(int argc,
 	packtmp = mkpathdup("%s/%s", packdir, packtmp_name);
 
 	existing.repo = repo;
+	keep_pack_list.cmp = fspathcmp;
+	string_list_sort(&keep_pack_list);
 	existing_packs_collect(&existing, &keep_pack_list);
 
 	if (geometry.split_factor) {
diff --git a/repack.c b/repack.c
index d2aa58e1348..fa748ce46ce 100644
--- a/repack.c
+++ b/repack.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "dir.h"
 #include "midx.h"
 #include "odb.h"
 #include "packfile.h"
@@ -131,7 +130,6 @@ void existing_packs_collect(struct existing_packs *existing,
 	struct strbuf buf = STRBUF_INIT;
 
 	repo_for_each_pack(existing->repo, p) {
-		size_t i;
 		const char *base;
 
 		if (p->multi_pack_index)
@@ -142,15 +140,11 @@ void existing_packs_collect(struct existing_packs *existing,
 
 		base = pack_basename(p);
 
-		for (i = 0; i < extra_keep->nr; i++)
-			if (!fspathcmp(base, extra_keep->items[i].string))
-				break;
-
 		strbuf_reset(&buf);
 		strbuf_addstr(&buf, base);
 		strbuf_strip_suffix(&buf, ".pack");
 
-		if ((extra_keep->nr > 0 && i < extra_keep->nr) || p->pack_keep)
+		if (p->pack_keep || string_list_has_string(extra_keep, base))
 			string_list_append(&existing->kept_packs, buf.buf);
 		else if (p->is_cruft)
 			string_list_append(&existing->cruft_packs, buf.buf);
diff --git a/repack.h b/repack.h
index 61e554e4ed3..9f95e3a26f4 100644
--- a/repack.h
+++ b/repack.h
@@ -76,6 +76,10 @@ struct existing_packs {
  * or packs->kept based on whether each pack has a corresponding
  * .keep file or not.  Packs without a .keep file are not to be kept
  * if we are going to pack everything into one file.
+ *
+ * A non-empty extra_keep must be sorted and use fspathcmp() as its
+ * comparator. Its entries are pack basenames, including the ".pack"
+ * suffix.
  */
 void existing_packs_collect(struct existing_packs *existing,
 			    const struct string_list *extra_keep);
-- 
2.56.0.8.ga42f775cbe2

