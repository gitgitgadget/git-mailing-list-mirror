Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7CC2745C
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 00:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978898; cv=none; b=YWpQGXAUBJUHKINTcVyswAVzIi96XVHx93rvv3BUK8SLtoaE1vwXGZbnRyOlnDsXRUFn00Ke19PdOEBAPN6CQnbYuvIeGO0yHf1wh9X+8U1N6qpBoacd2QAGyr5xqpTh8b5sS1hYS6rXCOQsgnSf6VR7uhOGlp+xCia69LGK+ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978898; c=relaxed/simple;
	bh=DAHsoPR99Cb72lHOwzziVOV0h9laC+QABdQ+tZLyTEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0Mwg7opsNGGC4Cjq/cYstoeFM+B36gcj5ZYyyGH0lP+eWs4xWKHn2r8svXVnGhvNf2VF3vgWBEHDSa0VSZwaP8LRHa9Ul+Tr4ozES0eGnQLOjshpjs5NljtZOXP5opBRgFbVuLHHnLJEcp+ng2VL/ZmjovUve3/ogXFAsSkaKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ErPcfv5N; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ErPcfv5N"
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-506a297c14bso52298601cf.2
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 16:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771978896; x=1772583696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lnznF6Q/LfP5RzkzG9tGmoklbj1ZnpXxEVQn9TlJZ7E=;
        b=ErPcfv5Nu8Zv+uS+DZUe9L7SwrnweXOPU8H7MYuCEOFslV0FxRU10hxKEI0XBGteyP
         yJYDjHxlK+dz8BTOw9z8m297JIdgc0+vBqViudCPGK1ZgV5A0gWX2X3+n6CEprWu1SxC
         fksgFmddaR/JMs2E5F9sQT98/Q9BDjM2UhTEFrnf1wBCRh0M2auk6ZyQyd1Zs4YYSJt7
         EtFeyoa4elmlXY3UU4N08wCcJHW6Tc4/01NxBJiGa8QUy8Sr3GCUFrJOTERYi8cp1Lrk
         pxXnNjQltuRiHoNTuiECzkjm3nHGDaDmWShAf9eSPmhRZ8dp4kQK2mWttIMdD6jIMYXa
         Av4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771978896; x=1772583696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnznF6Q/LfP5RzkzG9tGmoklbj1ZnpXxEVQn9TlJZ7E=;
        b=PQSOud9gvvAEPNLe6iZV5AhAHvXx+1dfthyusTf3wWvode2BD16UGo+uRhMZ8m9l05
         9v68XDtYVEggUIk+s49kk3H2cWVPHz4sOKhRBVQQ2a9a+g9GMmAM3v1k6AjdK0eQ4mEw
         a2HT3wgA1H1u8qBfo9LN4GIp65ABwtyjuivcxEEIfW45S6NJNKwLcJeA5x8u9+FJ+top
         I/ACheZZl8ivDcjptCHxdBfn+XH49CkaxaIU7o5bvzamP95O2+nsKdh6H3QZ8if5Gu/P
         LHl8YA8kaHYeodIQ2F8ZrlVF0uwK5NQVm7aMeE/nCWHH2ihpGxds7L264Az0eOj/p1+h
         aioQ==
X-Gm-Message-State: AOJu0Yxdtt6mfoCOnvDBOA/xPHYppx6dh3D4MVWzpw73r7xqOakHZOac
	lXEh3pxEgpSdVrqWNaeiBI9+HwbLU247GpF/4VrzIb4BRdAti6Bqd+2zeHkZeMoEKbFKN4Lq+du
	l3hhuszNm5KVZ
X-Gm-Gg: ATEYQzzoOq5kl2TtXqUNrVfuY9FcWA5oC6d9LRDxyqa61YkTgFh5SKcj/pCz/JRhrCt
	XKBytZoczbrzIPRDdgzNQVEJS87XVZyPFDocgXRqvlKXOd1soakXfzwIiwNvIo2KbkKBGantgJU
	3+6JE9sX6dBrUuDkqCDjEWHKX186xABIc0tM2sTPCy8sYVebrGQqz3fc4gPn5B5fPjmil8Ex2+4
	NoLb5YXgj43zNNj/KiumI3BlCZ7cbk9lYHFGjch0qCkft42BYznD27DEft7crCIgLHLYfs/NVk2
	+0Qwyasgi0gX2T9w0ZJKL02OZorE6EV183Ggjl+d1sV/buyr6YAnoEShrpGYBUNo1F3gjKw0raV
	TN1nnYXBYdLlcyEody8l9bjSMlFn2vzjO6urVDDKrTD1VqZRRCR2zv6i/U9AS8o6FzJ9XUV5qhs
	6HDb2AL8fhNPFvh08d0kKwEiSHXwEdWF/rWqC0Udv5RcF2y+/dVL/3b5rCPnIBTCXnGzcl9K78P
	GI7j0e8+V56B1SrrUAm15uSh3+4NiJrpjYIvszG
X-Received: by 2002:a05:622a:148a:b0:4f4:e6b7:df20 with SMTP id d75a77b69052e-5070bc2844dmr197146761cf.32.1771978896160;
        Tue, 24 Feb 2026 16:21:36 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6a2759sm108291041cf.17.2026.02.24.16.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 16:21:35 -0800 (PST)
Date: Tue, 24 Feb 2026 19:21:33 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 08/14] repack-midx: factor out
 `repack_prepare_midx_command()`
Message-ID: <50cf14e1cf4c7e0a00bd72f24d0919f14115faba.1771978829.git.me@ttaylorr.com>
References: <cover.1771978829.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1771978829.git.me@ttaylorr.com>

The `write_midx_included_packs()` function assembles and executes a
`git multi-pack-index write` command, constructing the argument list
inline.

Future commits will introduce additional callers that need to construct
similar `git multi-pack-index` commands (for both `write` and `compact`
subcommands), so extract the common portions of the command setup into a
reusable `repack_prepare_midx_command()` helper.

The extracted helper sets `git_cmd`, pushes the `multi-pack-index`
subcommand and verb, and handles `--progress`/`--no-progress` and
`--bitmap` flags. The remaining arguments that are specific to the
`write` subcommand (such as `--stdin-packs`) are left to the caller.

No functional changes are included in this patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 repack-midx.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/repack-midx.c b/repack-midx.c
index 74bdfa3a6e9..7547efc0651 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -283,6 +283,23 @@ static void remove_redundant_bitmaps(struct string_list *include,
 	strbuf_release(&path);
 }
 
+static void repack_prepare_midx_command(struct child_process *cmd,
+					struct repack_write_midx_opts *opts,
+					const char *verb)
+{
+	cmd->git_cmd = 1;
+
+	strvec_pushl(&cmd->args, "multi-pack-index", verb, NULL);
+
+	if (opts->show_progress)
+		strvec_push(&cmd->args, "--progress");
+	else
+		strvec_push(&cmd->args, "--no-progress");
+
+	if (opts->write_bitmaps)
+		strvec_push(&cmd->args, "--bitmap");
+}
+
 int write_midx_included_packs(struct repack_write_midx_opts *opts)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -297,18 +314,9 @@ int write_midx_included_packs(struct repack_write_midx_opts *opts)
 		goto done;
 
 	cmd.in = -1;
-	cmd.git_cmd = 1;
 
-	strvec_push(&cmd.args, "multi-pack-index");
-	strvec_pushl(&cmd.args, "write", "--stdin-packs", NULL);
-
-	if (opts->show_progress)
-		strvec_push(&cmd.args, "--progress");
-	else
-		strvec_push(&cmd.args, "--no-progress");
-
-	if (opts->write_bitmaps)
-		strvec_push(&cmd.args, "--bitmap");
+	repack_prepare_midx_command(&cmd, opts, "write");
+	strvec_push(&cmd.args, "--stdin-packs");
 
 	if (preferred)
 		strvec_pushf(&cmd.args, "--preferred-pack=%s",
-- 
2.53.0.185.g29bc4dff628

