Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCE0296BBD
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097299; cv=none; b=hm0oneDpP/MnmbpJeKa3R9zHC2TE+hdz8g+8Nmhv9dnrIUnflNYAyswVnbCtSXxhGD7l/J+iiSJVxgoTvcxLhwl6Y+AFr9Se5VpCGZJYknQDGh4/h9lcfC3saCodfmv7BcUhrC+IWnVSD+iICCn0G/dQZ3Q36s1YRt2Ze/ZAxLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097299; c=relaxed/simple;
	bh=v7oEWx1GE6+8mlKkjQxbRlC1NThg9vSSOZtnv7yAmv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGwPj1i1vF5bQSFUvq2CfjrHOYqip0zN1nLBzuvQbcY3JulyiS7fHUf6VzeTONOf+SDEuXpz90+3voJ4iI2BgVUrfKbYI5f/RrVY2ORfdvlv8xboDUt+m7SOkfwQdQEWwWpBIhU1LIgSN5pHqW/gdmu9DcWLJfcquKuKawI5Bl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=SmtzE1IL; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="SmtzE1IL"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-76c144b06fdso33987047b3.3
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097294; x=1759702094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HJW/iA7Lr57wQBEeeg8eXbysqRk15UpcD/6hj40GJDc=;
        b=SmtzE1IL7hmAplTKSHoxPGSEnPBGSt68az5cGfJm9v6fo0k8av14sSfBd7VB0A18n9
         3Nq8tHwYZmYm3DRb2gbZ7Z8M/HveNifthQTaUHasjBQHpk58FYPNv2pq3bsR2jT5La5f
         wgvGlkARc1zJbJXtWUGu6RqjGFvo5I73SZcR/DDxQUtPk7PrxlL0Luu+LgY5exZSCT9C
         DnHTjq0e+ETwqq69Nlrw1yMQrE2criuXJOHH220f2B4fUlwZCxalPuPvLAB/qjtTgJmA
         ChddE7cYw6of7PQ4gjpbPsRbMTrUugtWQym080SzihIFaNLYSsd7MCq8koQkx7vRCNKb
         AzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097294; x=1759702094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJW/iA7Lr57wQBEeeg8eXbysqRk15UpcD/6hj40GJDc=;
        b=Hd9fhqXpDTV4TbOlWaWIM+JPNf//ojHqHvGl5YZ7lax78rV6DYTj5XMVNjFEiRjECJ
         4hIMbYVMOYtwXmn3Hber9fs+ufC2kYxzz3xaw2uZv1XTew59dbNf2F/GMgP4lfD7ZKqc
         j3yvMxlPdGAhyyJgWcjaA74HVldre7lht1MJ0U4gTByjX+j3bc5AJPp0D2Or430Fuis0
         xH/DTWxCO3mwOydu5uSI359UPLMPOruU8HlzoYQtYJAQoe/tAiPSjt10CvWFhfo/NQDv
         IfeAc1Qi16n2tlsYonEilkPOYBTptUqyxhmVVep7EmXPToObSqrYIs6zCDlCXw+2I3dy
         iEqA==
X-Gm-Message-State: AOJu0Yx/Vf/wX4xXXhz4twhv07Lgto2fgTBaS72rSKa0FpqoAEOhN10U
	UWy+raUrDz8wOOhnD3rt5vjsnZbYnxbdKEdhBwkqCUIDo/J+OdrZFo1E7q0F1YEwz1F19UygIAl
	0kn1ddprAZQ==
X-Gm-Gg: ASbGncuZ5BPTlE/0jxlNWsLro1HuQst1Fq+A7utT6mfYOC3WQBkxLh/5syEvq1KOSf6
	4k7zRUYU/T6eHyOzhZD9EjWRsJsLICcClUFW9bWMgj+ewHYW1uepY2Cbe8hVdBsjAcX73F3zbB2
	E56t2Z/RULxtqJnXxOdAkmOeH5UXidTUqtVPIQUHI63r2uRe4XURyG6uK1h01yMqLBU7F07pLbj
	GpIvdUVWlgcaCfVqeu1VBcrBupBoveu6Ddbi7pw7/TAps9EgCO6rkDC/ecaitF5MohI1MMA0sdk
	T/8AoTxvufuPNW3La5k4JUH/jjOX9T8tr2HRVPbq5VX7DSKwrOEHmGRNgA7RQKqJDCKwobfmQrK
	AFyh/V193mfI2IHFY4mKi2O8zDeZZ/HcjHx8xPLemzAvT6Z+oEf7nU4qHpdTeRgSy3QK+HVFclP
	H+Wjp4a7PHf5R17DkSX73PW4XRbRx20w9MxArA
X-Google-Smtp-Source: AGHT+IGdBT6BIL3Nba586XPscv7YtKyog/LKZ3Dj1jDFX65Lfk2TBTYDHNOrtZcPL6gMMoaDXKTlEQ==
X-Received: by 2002:a05:690c:3582:b0:76f:8f07:491b with SMTP id 00721157ae682-76f8f074a10mr111692717b3.29.1759097294167;
        Sun, 28 Sep 2025 15:08:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-765be76d954sm22862847b3.33.2025.09.28.15.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:08:13 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:08:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 16/49] repack: remove 'remove_redundant_pack' from the builtin
Message-ID: <d0a40e8e577b07391ea7330b3d7051732de0d043.1759097191.git.me@ttaylorr.com>
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

Extract "remove_redundant_pack()" as generic repack-related
functionality by moving its implementation to the repack.[ch]
compilation unit.

This is a prerequisite to moving the "existing_packs" API, which is one
of the callers of this function. (The remaining caller in the pack
geometry code will eventually move to its own compilation unit as well,
and will likewise rely on this function.)

While moving it over, prefix the function name with "repack_" to
indicate that it belongs to the repack-subsystem.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 18 ++----------------
 repack.c         | 18 ++++++++++++++++++
 repack.h         |  3 +++
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index f82e6c3930..31137cf711 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -208,20 +208,6 @@ static void existing_packs_mark_for_deletion(struct existing_packs *existing,
 					   &existing->cruft_packs);
 }
 
-static void remove_redundant_pack(struct repository *repo,
-				  const char *dir_name, const char *base_name)
-{
-	struct strbuf buf = STRBUF_INIT;
-	struct odb_source *source = repo->objects->sources;
-	struct multi_pack_index *m = get_multi_pack_index(source);
-	strbuf_addf(&buf, "%s.pack", base_name);
-	if (m && source->local && midx_contains_pack(m, buf.buf))
-		clear_midx_file(repo);
-	strbuf_insertf(&buf, 0, "%s/", dir_name);
-	unlink_pack_path(buf.buf, 1);
-	strbuf_release(&buf);
-}
-
 static void remove_redundant_packs_1(struct repository *repo,
 				     struct string_list *packs)
 {
@@ -229,7 +215,7 @@ static void remove_redundant_packs_1(struct repository *repo,
 	for_each_string_list_item(item, packs) {
 		if (!existing_pack_is_marked_for_deletion(item))
 			continue;
-		remove_redundant_pack(repo, packdir, item->string);
+		repack_remove_redundant_pack(repo, packdir, item->string);
 	}
 }
 
@@ -652,7 +638,7 @@ static void geometry_remove_redundant_packs(struct pack_geometry *geometry,
 		    (string_list_has_string(&existing->kept_packs, buf.buf)))
 			continue;
 
-		remove_redundant_pack(existing->repo, packdir, buf.buf);
+		repack_remove_redundant_pack(existing->repo, packdir, buf.buf);
 	}
 
 	strbuf_release(&buf);
diff --git a/repack.c b/repack.c
index 91b6e1cc09..3aaa351b5b 100644
--- a/repack.c
+++ b/repack.c
@@ -1,5 +1,9 @@
 #include "git-compat-util.h"
+#include "midx.h"
+#include "odb.h"
+#include "packfile.h"
 #include "repack.h"
+#include "repository.h"
 #include "run-command.h"
 
 void prepare_pack_objects(struct child_process *cmd,
@@ -44,3 +48,17 @@ void pack_objects_args_release(struct pack_objects_args *args)
 	free(args->threads);
 	list_objects_filter_release(&args->filter_options);
 }
+
+void repack_remove_redundant_pack(struct repository *repo, const char *dir_name,
+				  const char *base_name)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct odb_source *source = repo->objects->sources;
+	struct multi_pack_index *m = get_multi_pack_index(source);
+	strbuf_addf(&buf, "%s.pack", base_name);
+	if (m && source->local && midx_contains_pack(m, buf.buf))
+		clear_midx_file(repo);
+	strbuf_insertf(&buf, 0, "%s/", dir_name);
+	unlink_pack_path(buf.buf, 1);
+	strbuf_release(&buf);
+}
diff --git a/repack.h b/repack.h
index 3f7ec20735..a62bfa2ff9 100644
--- a/repack.h
+++ b/repack.h
@@ -28,4 +28,7 @@ void prepare_pack_objects(struct child_process *cmd,
 			  const char *out);
 void pack_objects_args_release(struct pack_objects_args *args);
 
+void repack_remove_redundant_pack(struct repository *repo, const char *dir_name,
+				  const char *base_name);
+
 #endif /* REPACK_H */
-- 
2.51.0.243.g16eca91f2c0

