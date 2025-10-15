Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DAF3101D5
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567374; cv=none; b=HeSRMa5tDhTeiygW+V407oJJh65vVnGljWrH4QqQJ5IaLyLz6BZk8qyamL9AzNfi8UhKHCYBs/jGftI9iroFnA6XI53wHA574ahlFdLizWtPFLtJB4wmjZmYyNhUFmsInxD1IJBxWEIDyndzaZRdSbYjSrfiX7i5XPxJ1gBCl5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567374; c=relaxed/simple;
	bh=6vx6wiT6ZJDLo+gCUHPHhJ4i2nfJisOmhQZJPBsc6pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=homoTTGxJblKOoBcrG8xNmlUfoZSHsV02IWmGI0a4MyWCau8Fcf9YtSFIyF3EDj9dhb0mQg/HWvjw37mlG+z6FseZwoVuM7wJSRusSm6kfvbEs3NYxUtnn+lyg5ffU2D3YxJqOFJSRIQdU42W9G+HrW0cirsUKhlFzqkfOlpuwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=qQkw/ijy; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="qQkw/ijy"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-635fde9cd06so146067d50.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567371; x=1761172171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Okm9MbTfp54jIAShfWFb/s+LW9fqsyHwHA3LeEkOZm4=;
        b=qQkw/ijypaLRZvG71b5tMhrZdNzluglw7ALK7vLG5D+lq0URzzLpgYsy0TNkXy/TcU
         VQBn7qggI2KRPpf+hgvwiw7K6+mnAznNy9sgAWtUruM0wetiXmbf4R87mkhDzw5zJECQ
         /G49xi5t43/quA6PPVNQ5xvdNro4wEiscCLkhMVW2r2KMCwB0DF1wH3sbrkcTrnXA7j/
         sbsWH1gzK4DEwNFKwt5O/bQ0QZilVb5aKvwbTxDZp2Ykrbp9b40/6qEu1yY0ui3sHGuS
         AJqd2ov4p5sBIFD36NOrAV10gCm3RHnEhhf1QpGXH96CRtGbKUl5aFRiCfHWbXnqMXRE
         6PNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567371; x=1761172171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Okm9MbTfp54jIAShfWFb/s+LW9fqsyHwHA3LeEkOZm4=;
        b=k27u4r3VoPYC8isytmG9wOq4evz2BIh1Qzmyi8RtQ0wYB0m78TA8t0H8Z17jX+civM
         qYavfizD01F/rZoRraRGdCDZ5w5IeTvjX7D8W1n5QVwBDFebwPsNXWNGwkN/n7nm6ryO
         RztMIouUnETXCwNpx7AXb79t3hRoraqNU/5DvN+TPiJMy4u2WZtA10UZT5Op6WUacCQe
         HeSnWpDNFkjmkLt6XhENLlJaMlA2JNo2IRccGH8yZzxe5xNHroNBrn0gVRXL8hY6AFiT
         sG5Re0pOft4u1NJabEPuPGfXQshurVwO11gxeAJFB6BPmDs5Dwszl7eJn/Seh3K/SmNP
         vuQQ==
X-Gm-Message-State: AOJu0YyvWpzV/yks1wX5ciP7aBx+f6ng0PzwVeppIqN7Ay+5JT82Wt2X
	nhoJKmtC0H7nkiPjQhE8FWEwM7r/j9Fq2QWDNhQVLw+iatjFz1o1gHpgxsuuw8ukr9PEOqCL+TM
	dSfi17xKJ+A==
X-Gm-Gg: ASbGncsHr8U8pJXBCWiWPkQTVMt7zwe0LatHpm22W6U+CRFgxTmxNF+Lul+frvGktEb
	gm3mAP76nZz+LcbfK2aJs+2TGWze8hu42IwBfNqEdyDwyQkqJriZSD9WZy0uOOKfUrEzS/Y6LRh
	jqEPc/gssNsxbHfqV/amH4fnnWsKgNxpDd1RHD2ij/tLJsQOS84KgXZvPhFE1RhD/kd1a09Pisr
	NnzOU/rLXl0Kdx9H4NnEm/zfUPMdvgZzLrAkGG3Ryfcf3r94fOpXUGIIHyHSWrbclZheUVCdHXC
	ioEdQ7/wwM8dzA2/JDXhxBS9U3SG4k4gOsnlXESLmhGfYX2P7UilChfTgCQUdVui1pwC/90hhMM
	424uz1dnS4C3GczAWPhT52T4UXJHGiRJjTjcqyYBRPkEoTUBDbIs4EJP9wWTR/As++HXBWFO1T6
	D7KpmiL9ZbuIHxFfbCUB0VMpki10dNRiHTPCz1j2uf4C3Gc3Kumt7o2sfbKJnMDKfmT8MelpE3c
	HQPMRI2+Yp0SV08bQ==
X-Google-Smtp-Source: AGHT+IHAXVQuFUNxM6nMe7Qb2K2CvYOEsOHFBl4Pii50HT21Mzr9H2PTbHCjiCU5E1Af8oNbquC7Lw==
X-Received: by 2002:a05:690e:168c:b0:63d:30e0:e945 with SMTP id 956f58d0204a3-63d30e0ed2cmr2279548d50.12.1760567371491;
        Wed, 15 Oct 2025 15:29:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-63cd95e404fsm6009053d50.22.2025.10.15.15.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:29:31 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:29:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 45/49] repack: move `finish_pack_objects_cmd()` out of the
 builtin
Message-ID: <244260c6abfdd72e95dc19c965cf20b81ac91576.1760567210.git.me@ttaylorr.com>
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
index 5f382aaf19..71abcfa0b7 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -107,39 +107,6 @@ static int repack_config(const char *var, const char *value,
 	return git_default_config(var, value, ctx, cb);
 }
 
-static int finish_pack_objects_cmd(const struct git_hash_algo *algop,
-				   const struct write_pack_opts *opts,
-				   struct child_process *cmd,
-				   struct string_list *names)
-{
-	FILE *out;
-	bool local = write_pack_opts_is_local(opts);
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
 static int write_filtered_pack(const struct write_pack_opts *opts,
 			       struct existing_packs *existing,
 			       struct string_list *names)
diff --git a/repack.c b/repack.c
index d2ee9f2460..2c478970f3 100644
--- a/repack.c
+++ b/repack.c
@@ -82,6 +82,39 @@ bool write_pack_opts_is_local(const struct write_pack_opts *opts)
 	return starts_with(opts->destination, opts->packdir);
 }
 
+int finish_pack_objects_cmd(const struct git_hash_algo *algop,
+			    const struct write_pack_opts *opts,
+			    struct child_process *cmd,
+			    struct string_list *names)
+{
+	FILE *out;
+	bool local = write_pack_opts_is_local(opts);
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
index 26d1954ae2..3244f601e2 100644
--- a/repack.h
+++ b/repack.h
@@ -42,6 +42,11 @@ struct write_pack_opts {
 const char *write_pack_opts_pack_prefix(const struct write_pack_opts *opts);
 bool write_pack_opts_is_local(const struct write_pack_opts *opts);
 
+int finish_pack_objects_cmd(const struct git_hash_algo *algop,
+			    const struct write_pack_opts *opts,
+			    struct child_process *cmd,
+			    struct string_list *names);
+
 struct repository;
 struct packed_git;
 
-- 
2.51.0.540.ga7423965ad8

