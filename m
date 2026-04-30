Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D4513D638
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 00:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777508018; cv=none; b=Q2GKOlll85M6xPTYHYFmuMb838cMuN/eIaA5HDc/Rx0qZeCfaQ9ekM+XmlYziOm2WqFU6+IbkmSGk0gumAhMyws//PonDGcE4NRPuhRCi/0DN371XHilspgP+pS6AdE07w/50nicH8QcK5Cq7TpwiJ0dbEwVgLnvsCFn5u56SbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777508018; c=relaxed/simple;
	bh=eahfyoztswcCvK1GuwPHyBI3NgWgmCCSiXiOdzB4Xl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5PgSgr2MuKkaxdSgzV/rUp/mZSy+6czvV89thuGRnjxd1uIB/hfTEJKEGYY/cO4TjDHltlQ0rSyrUUycxREiVV+NUu02GOTV23jJohhqtKUNAfMtMP9LtUWlYOUZcPDtpNTr6LMbC9n+FT3TeM+V08nrJwBHEjNDY8wyCwZLnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Tg4Mib/c; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Tg4Mib/c"
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-7b4ee3a88e1so4248507b3.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 17:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1777508016; x=1778112816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7npMzKN2E9QLoKqrAcNASwwcJsixeG6boGqdu9cauk4=;
        b=Tg4Mib/cOp1Z9OkskJvzkfEE1F/bvb47DjZ7FY1ZsbWxtWgqIhsE2hxeMkTPiBBVWJ
         Ta1kNZM6mPiepOUSrX2wMV2tHZKdVFbjQPtP9r0lyHr6qUsS7MtlKSSbQChr+v2fyOy4
         LU6DztMBDm7Vd+OjmDlTY4N11FTpIgNWLrdvYhhgp2TZK96zJ4pu2hSXWWLItMVQGVlh
         m8p/WGjAHJiyb3o0Sj4bD8aKELxAIo3nQ0Gp5J4Z73c+R3BX99CJov41T8yOP/F20AEH
         Vjk8TZYh1FFwbD8tiWaMB9R3FoMpgh8PHddtDwyESFa3de/uT61bvJXAiEY+NhTYAPR8
         +s+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777508016; x=1778112816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7npMzKN2E9QLoKqrAcNASwwcJsixeG6boGqdu9cauk4=;
        b=L3Wmi4JKCj5+mXw+OIOse0WXIMjpYPiJNCwpJbQVn+o0RBverq9HK2qWX9cvqT4/6o
         7lHOsi8Feya7pybvfL4LD+ySIXfMi4QwBP31Ke8RUv14tNwCLprtRpctq4UrA7zdwadJ
         t+kE/9Nzd6CesILDOPBF9aNox+Hc3QJkJxMtqVhV+CB9zZwAak4RaZCWhMHWkM3fwFyG
         ZcwVZnTV2DGqfqloYH44edLlmyAnQhG4ZtpSYcw/8yXNC5YsiP6XSZnKA4UjNBE+prdk
         M9q5Bf9r/1kZ32/E+bbQke/XvWrp2W5oZLDPK6NpeU2PAx6DGQg0IUOgDKIvh9dhyEHT
         P6jQ==
X-Gm-Message-State: AOJu0YxkXqIWBMn7M8jhmnHaTv6UJpN51g8CnmhFHtv0Ti1WJJYUKbJ/
	cL0qrSFwplSYDr7AuHteeGHvxKuPLzRAfz2m1RDZRWZfbTdJCj+Ky6z+IAWGqFTo9pHFf+si3+n
	JDxN/8PdtYOLc
X-Gm-Gg: AeBDieuqBWqzAhPldi2VJGolRjRo43hWJDozyw5nq2zBmpI0RMTjTI2tY+0d9U7iy79
	MEfXGtzjsk2f+s4mksiXDFoYvaBtsjax2sGpE9uGt98DiLMDj+ibKaXzA+/pPFGu6gxvYgd84WT
	2FCXUmqtYhkYusMSqs8kTNU3pi//Qj0764JLb9n9lUCY29j78LhKg/fNXh5B7IdJRlA2I1QHHA+
	yh2w0+h0q59y1gfzHUswOJ8Jk1IE+vvnw/J5BRjDI78OE4Lx5Y2fbiOBpunQH4EHYg2pOTbBNJz
	n05VkK6WEY8uhdKb1p+jIa0N6nXr2zLgf1ls5fXKdy5Az6gs/okzJ3zyjJvFHN4RGUXx9tg+NCD
	NIoV918nb41mj7Zbif5pZM1/N/JuyqY7RiijCktwgxl1LqAXZNtaEsAIuh4Ty1Lml+vXO9F4LQl
	/u1BroMD8pPPWqD2sREATGCCTLsTod5b6eFVVynkJA846rY6Pz9xQ4cAHrerxb1gCHI1mF2k3VB
	v3uGUBYHCP15sqdqEgToztD2PESEjRyLU6fEHOnhJ4NNw0nNeyI0PzwqRJawFBfs7zPiBEXJA46
	0DYRv+yIq3R+OQ2QeCiCKnk3OPQ=
X-Received: by 2002:a05:690c:d82:b0:7ba:f0ed:c5a6 with SMTP id 00721157ae682-7bd5286fe5cmr10353987b3.15.1777508015775;
        Wed, 29 Apr 2026 17:13:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd54b0111csm1813967b3.1.2026.04.29.17.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 17:13:35 -0700 (PDT)
Date: Wed, 29 Apr 2026 20:13:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 10/16] repack-midx: extract
 `repack_fill_midx_stdin_packs()`
Message-ID: <2a87a1e45619d8c0c00cd816ca6614937f6ea205.1777507303.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1777507303.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1777507303.git.me@ttaylorr.com>

The function `write_midx_included_packs()` manages the lifecycle of
writing packs to stdin when running `git multi-pack-index write` as a
child process.

Extract a standalone `repack_fill_midx_stdin_packs()` helper, which
handles `--stdin-packs` argument setup, starting the command, writing
pack names to its standard input, and finishing the command.

This simplifies `write_midx_included_packs()` and prepares for a
subsequent commit where the same helper is called with `cmd->out = -1`
to capture the MIDX's checksum from the command's standard output,
which is needed when writing MIDX layers with `--no-write-chain-file`.

No functional changes are included in this patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 repack-midx.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/repack-midx.c b/repack-midx.c
index 83151d4734a..78f069c2151 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -292,23 +292,42 @@ static void repack_prepare_midx_command(struct child_process *cmd,
 		strvec_push(&cmd->args, "--bitmap");
 }
 
+static int repack_fill_midx_stdin_packs(struct child_process *cmd,
+					struct string_list *include)
+{
+	struct string_list_item *item;
+	FILE *in;
+	int ret;
+
+	cmd->in = -1;
+
+	strvec_push(&cmd->args, "--stdin-packs");
+
+	ret = start_command(cmd);
+	if (ret)
+		return ret;
+
+	in = xfdopen(cmd->in, "w");
+	for_each_string_list_item(item, include)
+		fprintf(in, "%s\n", item->string);
+	fclose(in);
+
+	return finish_command(cmd);
+}
+
 int write_midx_included_packs(struct repack_write_midx_opts *opts)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list include = STRING_LIST_INIT_DUP;
 	struct string_list_item *item;
 	struct packed_git *preferred = pack_geometry_preferred_pack(opts->geometry);
-	FILE *in;
 	int ret = 0;
 
 	midx_included_packs(&include, opts);
 	if (!include.nr)
 		goto done;
 
-	cmd.in = -1;
-
 	repack_prepare_midx_command(&cmd, opts, "write");
-	strvec_push(&cmd.args, "--stdin-packs");
 
 	if (preferred)
 		strvec_pushf(&cmd.args, "--preferred-pack=%s",
@@ -350,16 +369,7 @@ int write_midx_included_packs(struct repack_write_midx_opts *opts)
 		strvec_pushf(&cmd.args, "--refs-snapshot=%s",
 			     opts->refs_snapshot);
 
-	ret = start_command(&cmd);
-	if (ret)
-		goto done;
-
-	in = xfdopen(cmd.in, "w");
-	for_each_string_list_item(item, &include)
-		fprintf(in, "%s\n", item->string);
-	fclose(in);
-
-	ret = finish_command(&cmd);
+	ret = repack_fill_midx_stdin_packs(&cmd, &include);
 done:
 	if (!ret && opts->write_bitmaps)
 		remove_redundant_bitmaps(&include, opts->packdir);
-- 
2.54.0.16.g1c05dfce579

