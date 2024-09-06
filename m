Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7625214B959
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 19:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725651972; cv=none; b=PrY9mXdWQBijGXxjZzWPp5HPu357r3ofBP6w1PCdIV9bjsMrDhiLanAzE7tBS9/zFyWNA2IcQbxn95gBs7Q669vNdu+62E/awaQTRhiMB7tKlw9GXHDN8UaQ/pTVK2uLWD2+RWRS0GXLsa3iV6uh5LUvSuLz5WFJ0hmXZRsfjZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725651972; c=relaxed/simple;
	bh=1OqZqRC1CrZSSpImBHMiCDIKQRPT/8tatXq1Gc7aI9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKWLyWdjKPV/Xh5lJdRY/Vr9GL7eT1ehYoHSrd3OPsMLfSjG4FzMx3OqiBl8Tp5D2HcB810e1jJ3+kl9mtbG3UHveuwQ1FiWxwMBe2jBHr3D0KX0NsGgylKv91vmwkOqKb08XfoEOPF90dW6pdoybXzGKGzGyVBzpH0vXB6VPL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ZjaQVAF2; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ZjaQVAF2"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e1a7c25e350so2414938276.3
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 12:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725651968; x=1726256768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cuyOPfkT1dv+XTlY81AnoeYXvIHchtUuGIDnOUMROTg=;
        b=ZjaQVAF27vtR2+gFC2lL9cA9ujwYPvGyeeYWQbJZeEqKW6gyNEPw9aA7ZvYw08tqRk
         ViympYWvHgox69o6ubZeuS2cCHfL7Bok90VvBERLeVRPpJECyHiyoim+o+jKUKESYPqe
         YHbGzBF232+5Gw111ClkBMzWWGw4Ilrc3z82U6PJh3g4dHLEoM4xbva7AhsV6Lig/McH
         dTSRdAfwy5e+v9yLGHccCNDhf88VJS1PiO8Tq+U2M9id7+D9eqPpwJDhdNsHpD+x0ZH1
         hJ8opWXPm9WJCiCIIwdvTf0d/Ist8Hd3Duo1uyxb5LAq/L0oLea3ehtilscLJNJHNSBg
         Qw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725651968; x=1726256768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuyOPfkT1dv+XTlY81AnoeYXvIHchtUuGIDnOUMROTg=;
        b=BFuwR7mYlgG73HKvHxhGkGFG2TaAJMcx8OkAP1Wt+4/cpvXunOb1WoWY+pm74dbgLE
         0TKvaAO+/SlpeA0V46WdA6W5trW/0JhI9CHmaKS39bHGIRkhzZT2oAwVo9vFIDvVCrUP
         EBycpsX2U1dd3fUaq6FQ5uJ91KTJ2APuA+3BHn5iGHOUO2LCgt7n2yyAI3zbeNe+siuc
         zZgTuS2vlw3atNYxNV4tnYgmuSt1qM/GDf62fshCoPDRzAgpUrmAYzD27PvE57K7Rat9
         1Jks856/S8LU0qfA9vbvJjYNpSbPY4j4+5+KZTuXxwVKgK5gTp78FVQ1PGVVbPhC2S8M
         yniA==
X-Gm-Message-State: AOJu0Yych5D9YBqY+jtZPfLfp38M6snQ8AVDD3EEgIQGHSVuP+vLN0WS
	R8DoY12RjwOIiZFODzf+k7n6Kk2Acgnzh9ZIkEWe3GWPXng54Y6WAC8RvAmuRjVS1jsBinja+2k
	Lc/0=
X-Google-Smtp-Source: AGHT+IGQRWcSXBbCijYaSByn6EkXqEzbaTPPSyrbrjK8nD7+hictfC9etTFtQhbppQn272pHYANdCg==
X-Received: by 2002:a05:690c:386:b0:6c7:a120:e0ec with SMTP id 00721157ae682-6db44f2f717mr51022127b3.22.1725651968112;
        Fri, 06 Sep 2024 12:46:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6db565385f0sm1148397b3.62.2024.09.06.12.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 12:46:07 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:46:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/9] finalize_object_file(): check for name collision
 before renaming
Message-ID: <738b1eb17b47c11ae0185b5328bac549dbf05081.1725651952.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1725651952.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1725651952.git.me@ttaylorr.com>

We prefer link()/unlink() to rename() for object files, with the idea
that we should prefer the data that is already on disk to what is
incoming. But we may fall back to rename() if the user has configured us
to do so, or if the filesystem seems not to support cross-directory
links. This loses the "prefer what is on disk" property.

We can mitigate this somewhat by trying to stat() the destination
filename before doing the rename. This is racy, since the object could
be created between the stat() and rename() calls. But in practice it is
expanding the definition of "what is already on disk" to be the point
that the function is called. That is enough to deal with any potential
attacks where an attacker is trying to collide hashes with what's
already in the repository.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 object-file.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/object-file.c b/object-file.c
index c5994202ba0..683e6b2a0bd 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1904,6 +1904,7 @@ static void write_object_file_prepare_literally(const struct git_hash_algo *algo
  */
 int finalize_object_file(const char *tmpfile, const char *filename)
 {
+	struct stat st;
 	int ret = 0;
 
 	if (object_creation_mode == OBJECT_CREATION_USES_RENAMES)
@@ -1924,9 +1925,12 @@ int finalize_object_file(const char *tmpfile, const char *filename)
 	 */
 	if (ret && ret != EEXIST) {
 	try_rename:
-		if (!rename(tmpfile, filename))
+		if (!stat(filename, &st))
+			ret = EEXIST;
+		else if (!rename(tmpfile, filename))
 			goto out;
-		ret = errno;
+		else
+			ret = errno;
 	}
 	unlink_or_warn(tmpfile);
 	if (ret) {
-- 
2.46.0.430.gca674632b70

