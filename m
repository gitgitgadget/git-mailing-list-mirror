Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177BEAD2C
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 00:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702570; cv=none; b=uW06i9aNy/+13hW/Hk51aPNCezNeGoPtS+/W07dsAXuNmMxtQpz7Gx2Fwd6xTECIWC5QwBBfS7WmTS1nfZMwdB9MTVZCHOCOrYetdBh9rwh+HJkQqu4gv6UmMNgmp72eaJ4TIOiqDRbbcn7V+VdEUtmqhYZppp0Z3rmZT+gRvZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702570; c=relaxed/simple;
	bh=O+hAY1pofdpNaFonVJKAOOz3Dsk/jJc6qA1SokieYkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIGKaPqRmvgZYO550kD6EJOttBlBX/nMbWz6AP4VAEXN4sNio5PuQfb1Pj8R9IfmOMGF1NOv08rBreUFoQbmKlyjdxliHATXVgoAg4PA8qQO51U9Co2LjaB+8zsoRDDHXt9xn/3rE0q4x/Fr1iQGj/5rChKVMW++ColjrCYjgEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bphzsKuB; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bphzsKuB"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-728a433ec30so1046355a34.1
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 16:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740702567; x=1741307367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2YhYqgSveRgqexJCRWiA7ZeJ+THWdG09xVL+TUp5pg=;
        b=bphzsKuBDEwYIQxh2YJmdHKTXbej8/xFvH/UwJo5/J9tNhBxgFd/J+woO4Ww1IYbeH
         6T8Itk31otAKE3lbw1HDiXJLd2DkeaIjLG34O5TeTxlZ/EzAe4xuMTvKQkhTBgVAHejz
         KdH4n63HBTty0cpFiZaIowAYV9SiPmGdEjxkThpSZrumaKDfZWpGC6Z4y/OYMdPqeK33
         y//HbXg1H5684M6TD82aGYx5o/aEUNqTd4PdCywKkFVEGOHl80aM6DfWcTPEY7f+Vi4b
         cPeBzxljy40PwSS7B9x9AP5tjixhAIQkkDVt25FHhH0+agkaNFotBv7XDDl9Icf4Ni96
         r/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740702567; x=1741307367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2YhYqgSveRgqexJCRWiA7ZeJ+THWdG09xVL+TUp5pg=;
        b=LuGvElp/4W6GiZd0sUsMTyS7cOd5LVqIdTYg7SNAo/ctZ2XN2N3TaA7ZUOQVu0/7eZ
         sRc8w4VexM5Ry4aud4roFFP5hmhDWxbJQGimY3F8f7arGrCk3lDbGVO/nFcHaRnTYwWo
         9soKrSpK4iHl0EW31YR0VGghWJ83gG38DpJi8sbckljzgYDH2/E5qAhsD8zihCjtTO6j
         UBbhF1+PJP3mKj86OyinW+A9noB1eJ3wFCHWq2gDsHgWU2NLOA1SOSP8jiBaJ1qsJ46X
         GXWcvVmR8fn4GoT1Orp27slW6h76j7HSpD2EMMSuvWWz5/sLbfoKo/ChXca/XlWS4gKw
         YoMg==
X-Gm-Message-State: AOJu0YwfSAwd6hogJ3ORbQL4CSBGYI74MXztNrUTODRECSXZxKDACMIL
	lPkqbcxavmWDB2uGf+rNJeHNAUm0MICiQ9JWUrDGCCZknruzvkybT7ySzXsH
X-Gm-Gg: ASbGncsjfbHdXQbXRxGZlAuxrRW++kGDbTAsTUQP8AZkoZHydo7t5Xdu7LhXmWnJRZK
	tLoXyfp7bRYgT8zDdzR30AYbsK2VeOUle0ys1Lkd++CxxE/A3huB+kvjdH2p5PkRLBSr7Ds7mK7
	fMkU2bijMGp0dwG2tngy7Ubi2BqLcVOFsjNS4ynAz/HXSOHZ3tyPIEB192QjrWhHU1a0+36BJ+Y
	UFO6W5gDLpXjPDctIeVHsK7iTVdPSC4Os1kGrqFd/fyVJDrotNtO4nSqckniuVjVNU5rvjBMU7D
	6yU3VjbsZAHeAepcrTbJ6RAiNU7LPgfYCA==
X-Google-Smtp-Source: AGHT+IGTlC0EW+jMA8/iIzUHYUxj6sHxED1pzE1GMbd3bkE2Hvo1XQWoZrZjxuVMoAWscHAqyWxJ2w==
X-Received: by 2002:a05:6830:7302:b0:727:3313:5634 with SMTP id 46e09a7af769-728b8307c9amr818947a34.27.1740702567586;
        Thu, 27 Feb 2025 16:29:27 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5feaab9c8f9sm456509eaf.19.2025.02.27.16.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 16:29:26 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 2/4] diff: add option to skip resolving diff statuses
Date: Thu, 27 Feb 2025 18:26:02 -0600
Message-ID: <20250228002604.3859939-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228002604.3859939-1-jltobler@gmail.com>
References: <20250225233925.1345086-1-jltobler@gmail.com>
 <20250228002604.3859939-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default, `diffcore_std()` resolves the statuses for queued diff file
pairs by calling `diff_resolve_rename_copy()`. If status information is
already manually set, invoking `diffcore_std()` may change the status
value.

Introduce the `skip_resolving_statuses` diff option that prevents
`diffcore_std()` from resolving file pair statuses when enabled.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 diff.c | 2 +-
 diff.h | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index b5a779f997..37cc88c75b 100644
--- a/diff.c
+++ b/diff.c
@@ -7081,7 +7081,7 @@ void diffcore_std(struct diff_options *options)
 		diffcore_order(options->orderfile);
 	if (options->rotate_to)
 		diffcore_rotate(options);
-	if (!options->found_follow)
+	if (!options->found_follow && !options->skip_resolving_statuses)
 		/* See try_to_follow_renames() in tree-diff.c */
 		diff_resolve_rename_copy();
 	diffcore_apply_filter(options);
diff --git a/diff.h b/diff.h
index 63afa17e84..fc791ee2cc 100644
--- a/diff.h
+++ b/diff.h
@@ -353,6 +353,14 @@ struct diff_options {
 	/* to support internal diff recursion by --follow hack*/
 	int found_follow;
 
+	/*
+	 * By default, diffcore_std() resolves the statuses for queued diff file
+	 * pairs by calling diff_resolve_rename_copy(). If status information
+	 * has already been manually set, this option prevents diffcore_std()
+	 * from resetting statuses.
+	 */
+	int skip_resolving_statuses;
+
 	/* Callback which allows tweaking the options in diff_setup_done(). */
 	void (*set_default)(struct diff_options *);
 
-- 
2.48.1

