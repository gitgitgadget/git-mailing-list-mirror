Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D2D20C00C
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 00:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978903; cv=none; b=HpSQOOj4qi231J8c2Ct13KLwPvbokrI7qYPbbTYTeyJAardWfsWpUhU2fwQFYXSJLsbD1LuFZu4TKHzUCPc55sZ/uEeQUM1JxZS/Usjf5/NyH+aaREHcgs/zPo5H5d+QMJshGZfq1eadRKFSouvhuJmzkchsyDkh1xuz7pi4yeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978903; c=relaxed/simple;
	bh=xn+n5mPuRlT2qDl2p+BIGMrTn8ifK+gjqBjAx15vU2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Asq2/lCz0AiumjSAlSbdZDHiC4Uw6nvxA13lku/IHxYCmDKGzoTLRvmK0BHGhK3tpamSdOieGDXcoLDJud8aa2dxvggjq/l0+F46wMZXznwoHZnZ70U8BzRFffU6X3NiYf+blNl36dUhKyZzHhhkKJI6G61Xc97MxAWR0XTZxm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=T60S7Mk2; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="T60S7Mk2"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8cb5c9ba82bso977160485a.2
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 16:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771978900; x=1772583700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vLRUgwUtfIi/IJu/Th2u79p4oDkoyHlzMaFSCsGGjRg=;
        b=T60S7Mk2KfJrKBdCY4cAZOfoIWx9mKRZJQmRN9CE0ZKTT2ljV1siA5v0vSjZIVerWp
         bgy3mmFF5ymQhJ6QZV3tLG+sHDRrZrGanTQKSD3a6JhUJX9DL/x2CqvV8v6aKvyp6bAy
         6zIDI4mVyWrk5vbBVeEtU7I6HkLoTdSLZeH7FThmrbQZbCt7cvJHBRtJsKslPqmln0EO
         3UwuLpaev5jI30JPYwqNQBeeuT3YVGDeLjQyYNQPmRtYUvgz/OoUc0EsR9QNQTHuK71y
         T1XDEukw5qvOss+xoZyM9UmqyqZt9fwmpdG/ZvISXbZS0M9lC+VgKRYnm3FkF9a20Wyf
         /+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771978900; x=1772583700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLRUgwUtfIi/IJu/Th2u79p4oDkoyHlzMaFSCsGGjRg=;
        b=QPC1OJGkr3NatAXsU7eI8cJpGhToqXsxGK0RW93KR2ez48lvPLd+EDiCP07/8U6WZK
         FErSTX030cn+wnzQSVU6JP3OVrTbuiPAo+jFWoObY9Qrv222AaaVAiao/8qeJE0zOOE1
         p38ypII1LC+bjKzyZCMZh+sFWU3vPTJJ1YR5OBijszUpCBOPNvCAFy3A3yDg5NsPYGjp
         GpCJmF40ArVjeQMKrrJHiu/60JsMYj4E0x9kwE3aJMNT7kEPg2DKK6Afgm60imlFxQ1r
         8nxpQEDF+khHcn/O7c/3sh4KZE/8VRpjfqI1fgTdCkYudrbiPcZyh81rl6oJDPTs+CHI
         u+6w==
X-Gm-Message-State: AOJu0YzYG1uDHkiU2dpBDcDw8+pa78fapOEnXsxd0jnLnjEnHK16IZuG
	JsZMIom6xvBiMyyu9XPIRBvao7mzVAgEETObq6w6r6qePRWHJ9Z2fi5ow4+7SuPxFivq4Ju9khZ
	NBdyLBt6F8wBM
X-Gm-Gg: ATEYQzziZf6Oiq/UeYixnTiLBjBqnSiOWUOYuK1s1uOSsReRi8iXt3KGyl+KV+TI69m
	gqvuM2Rt/3zUFLxp1JJbwpWNJKvrDOKHZO12uuvy9PXh+93rNHAA6E5c3zHB47ZJ/Jcug4k0/Yd
	ORiopNYbU/SMFfDCSOLIfve6ApIh5y+UXUz5X0UYV9+NUofxhCSoc9WSK9ePc0AwiSGkO8YlH8u
	6A1Vhniy01/WUqZncoIk7tE79uiSPEvCpI/7pDmkFQamznwF1kkrAatqo+MQ0RA5PYEOr8k/NC0
	xLX3YM6/iMvXUd8119AWIR5NCzXZYMqtsiBAXF6Mgl+LuGnfsF/WWlrrKZ+oEoWsiP4VKPigUOs
	v2UMfgp0XKcj18Er7O0RTSJIUI2ov5qVrAcEGCNnJ5QCwdWvU5wuWp/Wc9uSM0UuI94I/EEXCKA
	A7jcjLCkFLdByDKnIHIwCP+lFgCGbxwowMs0ZC38QsZZE/0fyMWGYYhxpifVh80OttDpDjJ4KXg
	xeyE6a2rEsefMliBW4UF9bJaXuq8g==
X-Received: by 2002:a05:620a:4514:b0:8b2:dfda:66c4 with SMTP id af79cd13be357-8cbb5790044mr65639385a.8.1771978900349;
        Tue, 24 Feb 2026 16:21:40 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997c6b6af6sm108351946d6.12.2026.02.24.16.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 16:21:40 -0800 (PST)
Date: Tue, 24 Feb 2026 19:21:37 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 09/14] repack-midx: extract
 `repack_fill_midx_stdin_packs()`
Message-ID: <e06fa5da501200d8d4fc2ae5884f2dc38214a1fc.1771978829.git.me@ttaylorr.com>
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

The function `write_midx_included_packs()` manages the lifecycle of
writing packs to stdin when running `git multi-pack-index write` as a
child process.

Extract a standalone `repack_fill_midx_stdin_packs()` helper, which
handles `--stdin-packs` argument setup, starting the command, writing
pack names to its standard input, and finishing the command.

This simplifies `write_midx_included_packs()` and prepares for a
subsequent commit where the same helper is called with `cmd->out = -1`
to capture the MIDX's checksum from the command's standard output,
which is needed when writing MIDX layers with `--checksum-only`.

No functional changes are included in this patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 repack-midx.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/repack-midx.c b/repack-midx.c
index 7547efc0651..bc5059927f7 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -300,23 +300,42 @@ static void repack_prepare_midx_command(struct child_process *cmd,
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
@@ -358,16 +377,7 @@ int write_midx_included_packs(struct repack_write_midx_opts *opts)
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
2.53.0.185.g29bc4dff628

