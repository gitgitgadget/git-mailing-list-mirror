Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3398B46AEE9
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 21:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772228724; cv=none; b=AxcjO1+hYAio39/QpPT8XpjO/o3v62YPLBJ2eAaD8WXwdBFRgiV8ROKi+FFkPto5ujF+pkfONs0mXtuC0T+PzDdAiXU+/TpBVa6cb1gLLK+GVtlPEvLTMH0mV66ELb46utRQoe2rDBfBY7qqTFE2wjaKHFLBpPLdNdx9bZ/F4Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772228724; c=relaxed/simple;
	bh=gMPZWF5iZhaL80Lxj8Soj1re6gUh4NnwIVLQSSq2nbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deWw/5OyisJSLmJ+T4eqKjNdcyl4jO4EjDDgv2J+YtCySD3jfOYbLPbcbGtI0pbm4Ic/pPpItRp0C+q4vCAGRc9sCmNfYRbIo2S1reqj7Wxf3lmgPY0jbcTSor55msR8Fcizi2dkfNP7XLJVjUOTh8dTcO4+i9iT6xzZdfLOkGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGYbjvf0; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGYbjvf0"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4807068eacbso20621265e9.2
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 13:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772228721; x=1772833521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WgzfqPqIL5ePTRc/oMFIgwtVjcmKtqL5wgcFGJTU/34=;
        b=lGYbjvf0ChwAjX1m0qKdYuEGQWBvKfbd8XtT0RJJ0DxCiZ89qGU+nXgxn6E3+bMGoB
         D8qqWn85eGWxIH5J5Vn+pz6Sf3VKSZchu9n2+mMg3SBI3Gr3zfhMymE9DLOdz2eLFMBV
         kULB8NltBWOeBAKI3iTlOseo4mpIdRXc4DXh9sOdjhixXtKkdMqK08bD9mF0iqsfWZE1
         iPI3Rd96zMEFyVH3dl/wvPjsGIpXiyCZyzjX5s5zhu/pr8+6OJBqqFTwVfvg69gbs7MK
         yFwYjoneMNQR+6CU3TUzyrePXj5sidjCOYiZ4GGL9XY577qJD2Bhq0sNmmQvRsf6rWh+
         eGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772228721; x=1772833521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgzfqPqIL5ePTRc/oMFIgwtVjcmKtqL5wgcFGJTU/34=;
        b=BbygwGrPVMrqUWMSgwsvW3ErizRzx3M1KQ1oleke7TSIIoD2QmSX1tPnMYi6gUh57E
         YvifV7ypzDyLEdZR+vUPJPKIyMnJLh1mpfNytJClPHKtx8NfZ1JtoE4HiJEug+qv+VtO
         xN/ni2WvHyBcvHq/xIEJtSwyvvTdNQUuVa7OK+r287Gs7Gd1ZeMupdDf3VA8Ki2rUrmA
         KksBL4Fhe5g2Lf+CCN4T1zh1ApoeTCGZ8HyVI0eZ1DF0QmM55cAKNuU3A/XBIl2wf7m0
         0gfwY/9svdZ9Nh3BKSZjYHgSEcQPHG+oRNkc5qrbM5go7naHNCTlWJemhWhXQVsK9Je8
         6uYA==
X-Gm-Message-State: AOJu0YycsIrAM7YAkYxYhy5EihA23dM08k54vxPEL+BKNvAiUXZeweeg
	HIeQdb0jAciBuUsr6D+jjdbOIMYDUa8AV71DSW8OCHN9+prOAlf4KQz8PyV+5g==
X-Gm-Gg: ATEYQzx1t7kdmyHOw3lpLr0K+Omf/vCiHitNJTRuO2fqupOTDjNEKCoX80ObE6bSC+q
	JAZhlM0c4xuCUiusvj/iGfo3d4Y64lwXLJpOeLEIvG3xTDLw9MNKDUlxxLFGiPdvRK/NhDNgWvx
	O+8oK5RH5q1qn0DHY2Ya1VhXPUB7boxwNn4Wa3sPl8RANNqxMZ3vVcVM/fKv3ohlIj/x1HRoI0R
	llZ27v8RNWVYyYCurq39XRdezh7CrBVeJP8uNbc6SeuD1P1+tQ6KXTUwB/zQlsl/pivLAD7m8PO
	+0IsHD6FlKn9wdaxjTkbO6LemE0H+Wrokq8ev72ysSfth9GWK4pXJ4Q1SmC8nU1Vuce12r2m3M3
	eAEmRtdOm5TzxskP583eDpJ70KkGhkGcJotbJD0UEEIS1axNETv1zSKum6L9lZutPD7kyCwBJDA
	DOOz3rFfvZWAMso1dGCQSRZoFBsIUXcvBibCI=
X-Received: by 2002:a05:600c:1daa:b0:47e:e970:b4e4 with SMTP id 5b1f17b1804b1-483c9c0afb3mr58833705e9.29.1772228721304;
        Fri, 27 Feb 2026 13:45:21 -0800 (PST)
Received: from lorenzo-VM ([84.33.161.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfccad8esm68781355e9.22.2026.02.27.13.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 13:45:20 -0800 (PST)
Date: Fri, 27 Feb 2026 22:45:19 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH v3 1/2] diff: handle ANSI escape codes in prefix when
 calculating diffstat width
Message-ID: <f75d6d779e893c47665fea0162fff6f35dea1b49.1772226209.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1772136203.git.lorenzo.pegorari2002@gmail.com>
 <cover.1772226209.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772226209.git.lorenzo.pegorari2002@gmail.com>

The diffstat width is calculated by taking the terminal width and
incorrectly subtracting the `strlen()` of `line_prefix`, instead of the
actual display width of `line_prefix`, which may contain ANSI escape
codes (e.g., ANSI-colored strings in `log --graph --stat`).

Utilize the display width instead, obtained via `utf8_strnwidth()` with
the flag `skip_ansi`.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 diff.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 35b903a9a0..6eaf40fe2e 100644
--- a/diff.c
+++ b/diff.c
@@ -2749,7 +2749,9 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	count = i; /* where we can stop scanning in data->files[] */
 
 	/*
-	 * We have width = stat_width or term_columns() columns total.
+	 * We have width = stat_width or term_columns() columns total minus the
+	 * length of line_prefix skipping ANSI escape codes to get the display
+	 * width (e.g., skip ANSI-colored strings in "log --graph --stat").
 	 * We want a maximum of min(max_len, stat_name_width) for the name part.
 	 * We want a maximum of min(max_change, stat_graph_width) for the +- part.
 	 * We also need 1 for " " and 4 + decimal_width(max_change)
@@ -2776,14 +2778,8 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	 * separators and this message, this message will "overflow"
 	 * making the line longer than the maximum width.
 	 */
-
-	/*
-	 * NEEDSWORK: line_prefix is often used for "log --graph" output
-	 * and contains ANSI-colored string.  utf8_strnwidth() should be
-	 * used to correctly count the display width instead of strlen().
-	 */
 	if (options->stat_width == -1)
-		width = term_columns() - strlen(line_prefix);
+		width = term_columns() - utf8_strnwidth(line_prefix, strlen(line_prefix), 1);
 	else
 		width = options->stat_width ? options->stat_width : 80;
 	number_width = decimal_width(max_change) > number_width ?
-- 
2.43.0

