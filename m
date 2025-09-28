Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D622D29D295
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097371; cv=none; b=ZcIhEIXXDXGYZp200sCmgEOxsHS99pqH7j3X6gtUTaLeo09RaBTBXD9Zatz0ddIaHaMqjBY6nMsJZkpyzaoWasX87qZ6xNnyrneObF5r59RaVJxYfKjSmmrD8YkNC+Wm90ATuWqTWw5awVSZR/lHwa/JJbC3foqanbQ3qTZyRNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097371; c=relaxed/simple;
	bh=EjXFMg5XWvTiHefQbaCanBQYTU7WL9NQyze4gOBg+2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCsgiIt5GDhQ5DYFa1+cBHT31WOL94QpjaswoyKntfarG0YG7nzD33qNV6UxyhIq5r9YTwIGJACEvsrBMbV4N0sW6QraVLUiyHydCczG+PWDQ/T2uzRdPMpqGQgnX87T1f+gTR5+oTzJEdcTn7yIK0CbcyjRzbMDnzY8zMEVqmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=b5pSFE78; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="b5pSFE78"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-637dc2292cfso1059762d50.3
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097369; x=1759702169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pl8ZRsVJFC7qBZDq35xSHRmTh+elMNEiZgknl9ig93M=;
        b=b5pSFE78KJnuxiuWcHSgt3LcSe2szipRMf0UvJeZ246S2LwNdd/T2CDsCuo6KVqpgu
         H7BqKsuTIGpLLu0CZ1pZOSC+6J1gc117e74OA35fKZHW7HygXP2M9hinRzylWyEV6cvF
         op+llq64FfoidGU/ZTWc/5Y2M/XpV9RS+dWJnCwKgdihJKwydMQ6+7ymLtSlz2BWufdS
         VAr1tGQZHCZjkDom/gunmEnyHiA3hF58YYK9Xdnp4EXwmre/pQaDl6/yvqciV9s705yE
         Fw53NWfk3LIFcxSFaLF+cK8P0Cauj+BxwuBWycQMPsN9uG+EFon9IvtIeNSyl1ZN/4vV
         i2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097369; x=1759702169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pl8ZRsVJFC7qBZDq35xSHRmTh+elMNEiZgknl9ig93M=;
        b=Abhun91j4JWZ9fwkiiNQtu48hxnDbhIYSM1h9paKjDHemFcmcIedJiBItl2Kv0F6jK
         aIoWwPx+L6OY72t2DV4NdLRAhEYHLhadiYlFzTXi6rSxNtgYiPJg/bGKPThQt0xRywSn
         w2CL+defV+W23U08FuvbSYimC8d5MtIOatL/U0iF4av268ONZok98bwA9Sd9zOe0uDah
         j+F3kCtqf0jTjOCINRyV6LExMUUN9nauO1BBt1ZAXSqlbkaSux7AKc66yYn5Wn5p7SA+
         YPFDKVIEx/bDkxSQIlle4DPFVfiVtq7WDKcD5GiiCJ1iOzHrEMlI/8cOwh7TzvWLRO2l
         OcGw==
X-Gm-Message-State: AOJu0Yy5Q3kvMzJd50DvGEqT5jNK0GZJ+Ol+ZjMwD8/Nii7H9pL+V05a
	4KsgPdHFRL0Wv1NZ+nyzKq9MiJtHKlSdHxJIAbKdfT0A12ImS08vXRw4JkOTHAQZJC9VQ62nPgM
	wyW7nObo=
X-Gm-Gg: ASbGncucAgRvh+YIQM8kX+8b+LJxCBWzwKKok5c3YtBuQZMIDr4cLrqJhwOe9/LPwhe
	s6ys07IqPvoaMrfcNvi8o+q8p6v5B/M5VxeYAc/wziWB5jvqVMEqFHWrt6jDy3Gy6/0Ucfue0q1
	4yzwU/DO73QXv1jX2Sbpy1Rol6BzfUY0EpZJZftgFnbFXaAJeS8fbZdjksD1I1ZrHxmTQaadir7
	jdIpH350HkR2gdr2QOSP8LJ6h9XjzDyB1qfNw3wT3ZxzyEgf/SW4UHYqZj+8L9JUG+REIII/9PE
	Gl62Wh5bRrBoRXy0FkkZMAVajjY/zCY4N4tEjaCBJgXaMlhQEC2QSYkVcpSalmAgPSR0jUyoJxb
	ffb2vhmcePneXdpxgXYdWpG80fnnGJvC4ZSxYudcmzm9gEQlCsHmXQjSv0btQIFD0rPn4IAT/aO
	RI4etRaNEjS0zSqvFkQxKUyFD8FQ==
X-Google-Smtp-Source: AGHT+IHbmCq1cHpuW+Hrsm9C9asYSnwfR/99pjyvXIyn+4j3Ibni0yQ371g99ZuyO/rNoggJqn88ug==
X-Received: by 2002:a05:690e:244f:b0:5fb:d2fd:3873 with SMTP id 956f58d0204a3-6361a716214mr12965648d50.1.1759097368647;
        Sun, 28 Sep 2025 15:09:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-eb383850bd7sm2998602276.5.2025.09.28.15.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:09:28 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:09:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 35/49] builtin/repack.c: reorder `remove_redundant_bitmaps()`
Message-ID: <85d229fff5aad2240612b09416e6d012e12d0a63.1759097191.git.me@ttaylorr.com>
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

The next commit will inline the call to `remove_redundant_bitmaps()`
into `write_midx_included_packs()`. Reorder these two functions to avoid
a forward declaration to `remove_redundant_bitmaps()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 58 ++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 251dd08b0a..957a9b5f9e 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -296,6 +296,35 @@ static void midx_included_packs(struct string_list *include,
 	strbuf_release(&buf);
 }
 
+static void remove_redundant_bitmaps(struct string_list *include,
+				     const char *packdir)
+{
+	struct strbuf path = STRBUF_INIT;
+	struct string_list_item *item;
+	size_t packdir_len;
+
+	strbuf_addstr(&path, packdir);
+	strbuf_addch(&path, '/');
+	packdir_len = path.len;
+
+	/*
+	 * Remove any pack bitmaps corresponding to packs which are now
+	 * included in the MIDX.
+	 */
+	for_each_string_list_item(item, include) {
+		strbuf_addstr(&path, item->string);
+		strbuf_strip_suffix(&path, ".idx");
+		strbuf_addstr(&path, ".bitmap");
+
+		if (unlink(path.buf) && errno != ENOENT)
+			warning_errno(_("could not remove stale bitmap: %s"),
+				      path.buf);
+
+		strbuf_setlen(&path, packdir_len);
+	}
+	strbuf_release(&path);
+}
+
 static int write_midx_included_packs(struct repack_write_midx_opts *opts)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -373,35 +402,6 @@ static int write_midx_included_packs(struct repack_write_midx_opts *opts)
 	return finish_command(&cmd);
 }
 
-static void remove_redundant_bitmaps(struct string_list *include,
-				     const char *packdir)
-{
-	struct strbuf path = STRBUF_INIT;
-	struct string_list_item *item;
-	size_t packdir_len;
-
-	strbuf_addstr(&path, packdir);
-	strbuf_addch(&path, '/');
-	packdir_len = path.len;
-
-	/*
-	 * Remove any pack bitmaps corresponding to packs which are now
-	 * included in the MIDX.
-	 */
-	for_each_string_list_item(item, include) {
-		strbuf_addstr(&path, item->string);
-		strbuf_strip_suffix(&path, ".idx");
-		strbuf_addstr(&path, ".bitmap");
-
-		if (unlink(path.buf) && errno != ENOENT)
-			warning_errno(_("could not remove stale bitmap: %s"),
-				      path.buf);
-
-		strbuf_setlen(&path, packdir_len);
-	}
-	strbuf_release(&path);
-}
-
 static int finish_pack_objects_cmd(const struct git_hash_algo *algop,
 				   struct child_process *cmd,
 				   struct string_list *names,
-- 
2.51.0.243.g16eca91f2c0

