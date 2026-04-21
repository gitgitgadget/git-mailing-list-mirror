Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC03381B1A
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 20:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803863; cv=none; b=oIbxBsZm3OWPKqiIqMhas6thRBRj59BkN8be6/1iW6duE4aD6A7cCNapFY8VPdtDq/aiXK+jF8muVCRhfBIZpI1ZaP00p46hKo2Nugqx9Yt22jvSNAcL4z+doOh/FkpkYW6Qy1yg80saQbeXW0xGn/QzQCCihdlUTP+UtG+TtPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803863; c=relaxed/simple;
	bh=xxNiXaAglrNYJcP6DAa6FXJXFpzH1um3eN+vzX9hM7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoXXkgV5fPJgyPUl20I2U21DpOcrWXxOTxp3du2JqgkHi77UR31iJ7HcEdcw/lUxhvY3j2w6zrsM2uMJN0V8JIP9iiOLEWMrwvXL0QcKYAHeS2VK/VNHKjPeYVbgS8NzbZGxhD7ikrCMrFU5uyOuGlG+SnZ44r4RKEZtkA4vR7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=nAfmPBxx; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="nAfmPBxx"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dcd9061b1aso1001845a34.2
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 13:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776803861; x=1777408661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zVBOiJppV8jzOBaNwrmh6YcpH5lWep2Yf49L/LcEUJU=;
        b=nAfmPBxxdarItCYqkyDt11YzeIp4lZOv3SNzEHMyMn2DBGFTTuTlOJM+aqh2Mph5Ic
         0kVKpXcMJ9LWl+svPqFqgVzVGxOTTe7Tj94yLFo7zSOXlRsNXLrjzlz9HM4xtH31Sldp
         1lTmLDtTOl20bsBKxdBFKMMJPiHVUZVImX8fiwPPtZ2BGHwq6iBAxxo9PLainQ1MysnH
         R3uDTvqXgxPHaCvyFzcP0UO72F/pZ8tD4IegfQ2DcU50XOcrfTDNcN7KtUyfiyxQhWj4
         aWiI+g4Jd0S1XmTZ1pTED/CR3kTWuz6SRsn+lgZxFO6s1EgOluBu/gCRPaIOWm7QzI+d
         0hZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776803861; x=1777408661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVBOiJppV8jzOBaNwrmh6YcpH5lWep2Yf49L/LcEUJU=;
        b=aBQyMsVgZgrwNV/2hwGThKaUnzwGHSjCXsIugVc7IPBDgCXdUWpZoLJge/lBOciiRA
         ep65TA0rUQhFiRaCqaUPUiqD0gtTR3wKmkUqT/9eVwY0Fga5kxtA5oex0SJYuvNMAqnS
         kcgZ1NYY6BT4utENzHcWYLanRlJrr76gDyxaqop/v6Lg0h8bdaH/POxydiGATnC2RIk1
         qGjezb0GA3geTZO5DHFMx3o3NJ6d7o85+7XXTxY5UHYtbZg/R1oqtP2bElmqsqi/edy5
         jDRUg5jPzHaBa5QvYWmlmBHj6terpg/95XrubNEOXoyE+ReBWfwJnZ97n+8LLzhvuInX
         X65A==
X-Gm-Message-State: AOJu0YwV+UAwo59+Uxj340lVUwgDFp1EKYbCswAq/2XgpBSUI6o1rjJA
	Fccyu3Hd47Ysb70saw4vwcW2M3nhrtCcbf97RoVeJxIJSLfd5PzFC3pQhrJU159m+6mM0hDCN4U
	+yBOnyYE=
X-Gm-Gg: AeBDiet/ifh03DHmGc9t51Fg6GoVgnuF3UQ6SuzF9GFqM6fOcemQbMOAMXAxXmCCZLW
	AZ3wa/TiZ0Sl7XP03SQlyRyI/ofuFLzMCqjeP8HDLXEcE0iY2cvg7JHyQAQ3gKR9tQh6Yv1QyPX
	U6tS/MKf+jnbJ0B2TCdw7nvHgYt37woYgvB/+1aZl5PGcIkmZrRi6qcnficLk71ZMrFrIn09TAO
	kumvTtAxLbDWdPS6UQxJ9/3bTVzxD2up4Yv4D3Q2oU9QAvSc9e26pOQtO4MnE+yqaXDA5b4J3im
	8xLsJLIOkdeokjFb4b1iy7OlvxOlBARflCVZhyn+m+sGq3c+v3lfYzY3LMsldd3DSUDIt0j4qh7
	To40FD9GYnTdwBfQe2zwPbguKTRJHaV6OL4dYD4IJYvm+9Ici2RRznUUlQbZ1+89/A2qzsV0RON
	Yqm3zM/nUCc3uliOKIof+99g2yRQ58wI2NSDLTLRgwSnPXbWbCrwtrPyrPjO2Kh5whkHhlaUj49
	5+WA+9M62N3KnK9yLQsPEZegZdcdDB7Z2Awvfj1OVTjRYE7oA+/YlRZZ4WCKMHc5wPsojW8necu
	oj4qtJbR/c9a033UPGLW+HhwySX6TuGTvZZYDA==
X-Received: by 2002:a05:6830:67f6:b0:7d7:5559:3d1c with SMTP id 46e09a7af769-7dc94f961d0mr12575753a34.1.1776803860943;
        Tue, 21 Apr 2026 13:37:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc9751a2f9sm11962715a34.12.2026.04.21.13.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:37:40 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:37:39 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 09/16] repack-midx: factor out
 `repack_prepare_midx_command()`
Message-ID: <1bd2f194c6f7f64f2ff1e7b55a3a69defcb6a344.1776803827.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1776803827.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776803827.git.me@ttaylorr.com>

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
index 0682b80c427..83151d4734a 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -275,6 +275,23 @@ static void remove_redundant_bitmaps(struct string_list *include,
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
@@ -289,18 +306,9 @@ int write_midx_included_packs(struct repack_write_midx_opts *opts)
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
2.54.0.9.gb905fd5d0ae

