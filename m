Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEE730DECB
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567291; cv=none; b=ntDCdSySxSr4jLsYTaHdxZBEjO5PBF1mjjvS/9sQSxo2ltbHBuoQoXmc6FVR2Kbf+umxo8SHaSHThd+F0JHJbaOYC4lCDdJCAukxC4sLeNaQ+JM2qpbuqAZNj5s1k5l1diqcptZ/eWsCN/rZkG2iqicW/txoRGZYrYpya1wv9VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567291; c=relaxed/simple;
	bh=Ph0sYgTmLKX++xZdt3i3tIKiFiBax8qscN5hjcLBfQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEiPeHNkCGIuGj2PIxkro/R8rZl5byjdwV7/Xde71cmsID5TdDCniqpANEwtoazDlLTjq6L0ZQRtqVahUl2I4nKHU8g1Y1CquaynlLqJ+vEOUp79BFl2N/cHAHiwofxddNmpbGcJ004reqKsPnMeBANQN6I+Dlyz59ucdr0qY0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ZukAXSYT; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ZukAXSYT"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63d97bcb898so93919d50.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567289; x=1761172089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EjZT+Qw3buwEAlX1MKMSlR4qSd8VRjH5ERXsqV2T11g=;
        b=ZukAXSYTsFZx+e4PPR/0iL/Xy26NFdbw9Qm1RnlnV+61SIFgEdy/YcB0nvBA07lHwF
         n6aiN5otz8b6WasuHO1IH2yjgozTiGgkNS0BAK+zBLuP+ecO5P20m9Pxw01wi6mqtOo0
         Up7bC+cyxVvc2+abMfkmpGgChQHUuhzxLzc0V21Y0GwofG+shujyCJ1xYJLYRyWfM3Ef
         EEXuzjspeGi+WJfahXH3y4EA46YyL7Z728/SDrtNxjuJ37CGvVT3VIfOMtBRJEELjKb2
         VIh3UVdFS/C26Qvbhju8tP8da7UFSErEdmB20bWW021mbPndp2wlNUh8gTyVqPDXKgfZ
         Ri4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567289; x=1761172089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjZT+Qw3buwEAlX1MKMSlR4qSd8VRjH5ERXsqV2T11g=;
        b=ea9lpI5w76drkVu0+Vrci6+MHm/UfkB/DAaXKz+/eDy/KPpyelkTSFuzY4Gm+gUk1p
         l8J7i1L7T6xK3tLtq4ebZO5KyYZDlhgoPD3+Vbg7z11RPMAsZ+2MR2/daVKiS01BhMDd
         AkkBpCuV/MS2bfA8YoHEqz4Oh9ohry1D8+NygTx/XUdxKxTZrKChhPSXLXJD/RfXxWbf
         6Jsz7q8g4CeBKEo/X42tu6Z/UIxymbVCFnED0QFl/Vj4809EV+jEFYKV9E8VJ8JlCKoy
         RKC7DrITET3TDrYNk0vItu7+HtDm48WFCQlbWrKBdcmtgVPmvcEx1KnMmqc/MmZ7VRh4
         R4+Q==
X-Gm-Message-State: AOJu0YyNXtlLrv/zkR507Nueb4c7ve2m7n6YWXnomBXqywlSFaJ/WpxM
	WNLQJrQSylVFT8jUnztGGv0NN56bpMeuozjCULkZ0cVwIZ2G5tEsJXwmmzKktHJdl7Q05vVK3Bn
	CZ3KAg8RELQ==
X-Gm-Gg: ASbGncsRJA0Y+bXXxLdqrqFrUpN+Q2aUXH/jomaIuXibkTX63K94nHE8fBpVJ8tUUcO
	+DeLmSx0zcw3rl3qGe2m/scZseouonkuI6FsNDr+oW3FSK9+2wloCpSkL6LuLUUzt9b7FF6cVsY
	dIgfoUqOJQ+NSXQvylp5QEwpRZFLSR0vaDMVp3jl8Ty8wjp2Q1rBQNetW6vV8sNQcALjtMN7xkW
	1X6jGpphZ5w6j9/Mm2CUnsuifjrq6EZX+BqNIdlmtuvZEe6y5BnP9v1yCbZs4EyUeVTt+gsfujZ
	8aI78rFGP94yZ8dlVHpZ7PETKpDA3QGdQOwelB7vl7CVQWnJb+Jg5lZtkEhQfB2vcGCY3OawWoF
	61HVlXLp87pIUBgyatHv9PwKlbKZ99+4HoBXw1JpXZuVRC3Z8njOzfEo3fbhxNvyWIvUSBZBaUD
	W7SZud2jIJ2vm0fQZASEkHXmdw/diohcqFhjLE7qDUZuSuvqg7SSrYb9XKjpxJt9/bCe1kCpl5+
	v2pe9dR2im6iIr53w==
X-Google-Smtp-Source: AGHT+IEBsTeThxXaW5HKEn4bEvOhmFJZwd+7y/mzZvgTWbB4dwIO17QL9ON266s9XWD5nwfb6jdZQg==
X-Received: by 2002:a05:690e:4185:b0:636:2079:185d with SMTP id 956f58d0204a3-63e08e4a52emr1310891d50.2.1760567288661;
        Wed, 15 Oct 2025 15:28:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-63cdaf9fa5asm5800232d50.14.2025.10.15.15.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:28:08 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:28:07 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 16/49] repack: remove 'remove_redundant_pack' from the
 builtin
Message-ID: <4edbcb5893a927e6c68a981baf8d409e8bc77084.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

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
2.51.0.540.ga7423965ad8

