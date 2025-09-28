Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6244C1FB3
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097426; cv=none; b=Rq/aV3b5hXL6S5cx+MVa3VUk4C2vV3XJ2y+CkoxmbtFeS4LdxC5Bc0a53q2727XdPpc6j7FFtghNIyGX0gyN/kapvQOFoGM2ArHFNJNlBk5vRMrQu3omTetHhxAAZa6jdk0OS3AjcNs4wo7PnmfyWxgRmpaRXwoQPcIA8Qer5Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097426; c=relaxed/simple;
	bh=H+4uRoibtNhwcjWJGKTZN/DNuGwS+SFguBAd7TrkmOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upyGYSG2UYc3h0FXf8FyWLDFY9DZz4VeW1dKSuDxJGntB81Z1giQatJxF5eJ84MzuLGoau8lR1yO+E9sJIG4YBZ0DzVPszsPyjg3IYjLm32teU76e10ae0cFrJyRLx70xiEbzFls2zwTJ3PLQkS6tx/89XuT0UZC8ZpMpUs/V90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=YTxcLQo5; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="YTxcLQo5"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d71bcac45so38577697b3.0
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097423; x=1759702223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4uOpz3ugGyIqLc8tJIBOkpP2h8sisDKQbmrmCr7Kyz4=;
        b=YTxcLQo5BJLxyYB0XzT5WoZshfwtCZdjn/y8ux1ywUST2IV60vCYoMGAwySrAsNLyF
         E5R8JPeqPttdxauI83C9R/vx29Qss4D2WS1knDp2AHc3OWRL+ZSYt0c2iHFJKVQhHcx5
         rLzkijVrvT31Pe0vu7iOBXXpMFhhivezfmbRx0oHHN2FS6FHphwgAAeLRcyW0PnJ8lBh
         cG6SXRGG4CIq+BDboJ2BPS3dLFDgM8H9IuORFdIcja5Ho1Pqr5npJFMqH5rc/9r2xvvl
         JqPe2+M/y5xHl0G318ELrZcCvUGbIEts4gQvcIaorV5jxQ+Qynewa1owlClQQuJcaawE
         6MSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097423; x=1759702223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uOpz3ugGyIqLc8tJIBOkpP2h8sisDKQbmrmCr7Kyz4=;
        b=ZJbxam9j9glX1uYT1/6AgutsFQpEc81WDUw8bpOPr68Kz7yGPE39L8XgJ/FpSS9Ig5
         2oAZ61d6gW0B1qjjFRiNI8fM+kvSokRurFi1SfHz0wd608hZvgXEclyCK+Bz8Z5OMjV4
         FhZ2ZUJMVK0fx9dXzAkj24kHlOgJ9hcvkG/WWO2Aaue/rSmtsPyc+jKAgt5OqwTl/n7n
         8r8caehkJKTpaitlnWIlyzz3wJsQUGIE8u+khwdBRq2R83HaxjnI5WbVND/bt/piuTQW
         JO2bwwEijoj4Jm+HzhN+iBVC8Y6v2/E8vvTCJVHYzJTwhZakOdJ5ufc9LK9pk9hJ+1hl
         qrmA==
X-Gm-Message-State: AOJu0YzwbmKiDGyirAqEEIABn8hyCziweZTmZcIIKpm2Q4Osv5fZK320
	J0BmfhkzfJ7T0WUAEZsjOB4XgzIgT8sME3ZcpeCT/tbxe8YW29iIByrd0VwM6ukJBMe3WH+5BIE
	x1fRNmb0=
X-Gm-Gg: ASbGnctW4lEuYQJaCJ1gaS9bRnmkrilzv/mYd18KkxH8yMAbD9x/02pfQJepx3/u5A5
	GJp3oZGy561l4i2CptQ/lTaruQhUpKMwRjMQF7yKaFFEIdQyxfxhgcWIeDhHh59pMYl5FxH8M2B
	pQnA8KSHvuF/SMfRtJo+oXJlpntu6bDZ8vyds0H3BjiEFVa7OEmadeJF9HqNMdO2m0Iaca9DcBh
	RYkklJCtoZSI3RZE7I3CX4MvfME1UXjQea3PtretSTuNI2XLJg4opzeGTZa6ooBfMyYw1pIfVqE
	64hBWFNBowVLMiDdhQ2QOxkYTqPzV+O7uE4bKbE6AknpAucBp/wJhDGgqNcTFcd8gFPoMycbj1L
	IqWTAcki9A/JerIkcr7v6Z1vh0/0Ipbwmk12JnkZhXO6hNBabxsBDuGZ9zLHR2M4Uy/Ko4fpmY2
	Icwt29cVnPeJ279KCDa44tsHYD0XVp24CzZH7d
X-Google-Smtp-Source: AGHT+IHv2p4DEKd8MJjVVE8gs6pwA/GznNxgo4a1wJ7pvyX1rt/86hiUFg94OS6Us6TO4Fb50ZSl4w==
X-Received: by 2002:a53:b19c:0:b0:636:2420:d3ce with SMTP id 956f58d0204a3-6362420d61cmr10446401d50.51.1759097423156;
        Sun, 28 Sep 2025 15:10:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-eb383929a6asm2943969276.16.2025.09.28.15.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:10:22 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:10:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 45/49] repack: move `finish_pack_objects_cmd()` out of the
 builtin
Message-ID: <a38d14e411246d4f7a02a826262e9e7500b69237.1759097191.git.me@ttaylorr.com>
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

In a similar spirit as the previous commit(s), now that the function
`finish_pack_objects_cmd()` has no explicit dependencies within the
repack builtin, let's extract it.

This prepares us to extract the remaining two functions within the
repack builtin that explicitly write packfiles, which are
`write_cruft_pack()` and `write_filtered_pack()`, which will be done in
the future commits.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 33 ---------------------------------
 repack.c         | 33 +++++++++++++++++++++++++++++++++
 repack.h         |  5 +++++
 3 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 8db95305c8..836a006607 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -107,39 +107,6 @@ static int repack_config(const char *var, const char *value,
 	return git_default_config(var, value, ctx, cb);
 }
 
-static int finish_pack_objects_cmd(const struct git_hash_algo *algop,
-				   struct write_pack_opts *opts,
-				   struct child_process *cmd,
-				   struct string_list *names)
-{
-	FILE *out;
-	int local = write_pack_opts_is_local(opts);
-	struct strbuf line = STRBUF_INIT;
-
-	out = xfdopen(cmd->out, "r");
-	while (strbuf_getline_lf(&line, out) != EOF) {
-		struct string_list_item *item;
-
-		if (line.len != algop->hexsz)
-			die(_("repack: Expecting full hex object ID lines only "
-			      "from pack-objects."));
-		/*
-		 * Avoid putting packs written outside of the repository in the
-		 * list of names.
-		 */
-		if (local) {
-			item = string_list_append(names, line.buf);
-			item->util = generated_pack_populate(line.buf,
-							     opts->packtmp);
-		}
-	}
-	fclose(out);
-
-	strbuf_release(&line);
-
-	return finish_command(cmd);
-}
-
 static int write_filtered_pack(struct write_pack_opts *opts,
 			       struct existing_packs *existing,
 			       struct string_list *names)
diff --git a/repack.c b/repack.c
index 7af297ae48..8a0e4789fa 100644
--- a/repack.c
+++ b/repack.c
@@ -83,6 +83,39 @@ int write_pack_opts_is_local(struct write_pack_opts *opts)
 	return skip_prefix(opts->destination, opts->packdir, &scratch);
 }
 
+int finish_pack_objects_cmd(const struct git_hash_algo *algop,
+			    struct write_pack_opts *opts,
+			    struct child_process *cmd,
+			    struct string_list *names)
+{
+	FILE *out;
+	int local = write_pack_opts_is_local(opts);
+	struct strbuf line = STRBUF_INIT;
+
+	out = xfdopen(cmd->out, "r");
+	while (strbuf_getline_lf(&line, out) != EOF) {
+		struct string_list_item *item;
+
+		if (line.len != algop->hexsz)
+			die(_("repack: Expecting full hex object ID lines only "
+			      "from pack-objects."));
+		/*
+		 * Avoid putting packs written outside of the repository in the
+		 * list of names.
+		 */
+		if (local) {
+			item = string_list_append(names, line.buf);
+			item->util = generated_pack_populate(line.buf,
+							     opts->packtmp);
+		}
+	}
+	fclose(out);
+
+	strbuf_release(&line);
+
+	return finish_command(cmd);
+}
+
 #define DELETE_PACK 1
 #define RETAIN_PACK 2
 
diff --git a/repack.h b/repack.h
index 16f2de2ea9..9351293233 100644
--- a/repack.h
+++ b/repack.h
@@ -42,6 +42,11 @@ struct write_pack_opts {
 const char *write_pack_opts_pack_prefix(struct write_pack_opts *opts);
 int write_pack_opts_is_local(struct write_pack_opts *opts);
 
+int finish_pack_objects_cmd(const struct git_hash_algo *algop,
+			    struct write_pack_opts *opts,
+			    struct child_process *cmd,
+			    struct string_list *names);
+
 struct repository;
 struct packed_git;
 
-- 
2.51.0.243.g16eca91f2c0

