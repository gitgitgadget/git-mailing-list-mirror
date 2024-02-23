Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803D710A25
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 03:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658313; cv=none; b=mDJl0mwwzUyY5uU8bg69SaL48wA3WGz0ifxHuIvUP4g3j1Vq+YAw9XMmMMYXj2ZXWz2hczQwEbtUVo6gl62zTxsEDw9+jmxIiYBSzLzxQ6BL2Dwfp9Lgw2fNxLn0ztqS9DRS/QgyPYhIXtI12uDIgVsPlG9PyeY1xjBx8578EE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658313; c=relaxed/simple;
	bh=8XxRUSLP1i2H4pP7Ur/AnG+3Ro+HeevnzAIaMxKdsxo=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nZlw7Fa95KPbSDvScf2kNW+3lBl6B9lcoDcgaNa/VxFDJQRct9AmpUO6anjYkhs0pUFlJP+nTurw0jD7qvmBR9m881ZKcUfxzxIvvIYjIyG5H03J/z9iyCmTrwv1uDLmgKtHRR0EA2yx8PEAfGNWfAsz30/OyIzNIG4BP7b/2m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUQR4YnH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUQR4YnH"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412903facc9so2913615e9.1
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 19:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708658309; x=1709263109; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4syVdYZ4bavYVFDZfPF7YqPDiBAXmbzeINYHl0d0os=;
        b=YUQR4YnHKm8xoHfxsv6IFPD6gip8MasQYM6cnPdHkCcFOs5+tnResO9epR5lYm64Wp
         POKR0gT2ZqznT0Q1b1DFhzCBm0Pv2hye/RQ7RCJswQ1JCqG+6gw3K239OFslxzqAMvWW
         EA5wboUtqhsju6nOVLsbUm5jjY/K+S/Zpqv26KjoFiiKcZviPqBvgW8rVftEgChYOwfU
         UQot0DjDmdYFBBDPDqIvFvRhTZ3R6dIqhvYMlINbjBFJORZ6zFv1jgukbWMZPpL+FnHY
         lEKEam+WUf3rFAN7anXXcMILMnFIFB780moBj55LiGXRV/vWy120Us9P5I0XBuG4WmAo
         FlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708658309; x=1709263109;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4syVdYZ4bavYVFDZfPF7YqPDiBAXmbzeINYHl0d0os=;
        b=ilJKePIaBjhmRW/FQb2muzcZRobUW9FvJ5Hv9gIt/VXbue5hbLSRG2m62A/gTdQNhW
         +zoU1+sR5bvjyDigW5/cnMeRGUfbvpwpPD0TVXKMyuxw+KwNrF9skEyG+Z9gsiYf50wJ
         fgzV07C73yyN9hSPgUI/QQHBvbr5sv2s9ETxiK0O7MDmzFFpylSv9yXhhFsGa1B0pazI
         BiDRm8jfKUUZumZrbdwOg6uMN2FNJn30Zb+2gVaRhajgZi8haHR/bZcLKCWjlUDsQ0gz
         E9UpUkMhoBzuRPRAdHUA6Y8BWMS2WLe98zccVOkP8LKUlynymkjDhWDYkzN+Ze1Yr/1T
         3zBw==
X-Gm-Message-State: AOJu0Yw/XSuCfpu8JIXGNBTA/96AcFZs4ote+AXURKHICcRmyPSiPhaG
	GyXwv7U+tyZEJnJzUkJb9UB7EQAou78zUxSscZY/dMn+iAU4iMeBb3fjUWhK
X-Google-Smtp-Source: AGHT+IFwXSGpzGz/pvC7frTv1/W7no/6rboejejnAP/EFBUFscuhyr6gQevqqEZTBfzBA9mCjl0Uqg==
X-Received: by 2002:a05:600c:4fd2:b0:412:7880:3da8 with SMTP id o18-20020a05600c4fd200b0041278803da8mr408277wmq.16.1708658308983;
        Thu, 22 Feb 2024 19:18:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c211000b004126732390asm574926wml.37.2024.02.22.19.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 19:18:28 -0800 (PST)
Message-ID: <99c0d3e0742c1a7e0f7608707402a772ec112716.1708658300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 03:18:11 +0000
Subject: [PATCH v2 07/16] dir: create
 untracked_cache_invalidate_trimmed_path()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff Hostetler <git@jeffhostetler.com>,
    Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Create a wrapper function for untracked_cache_invalidate_path()
that silently trims a trailing slash, if present, before calling
the wrapped function.

The untracked cache expects to be called with a pathname that
does not contain a trailing slash.  This can make it inconvenient
for callers that have a directory path.  Lets hide this complexity.

This will be used by a later commit in the FSMonitor code which
may receive directory pathnames from an FSEvent.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 dir.c | 20 ++++++++++++++++++++
 dir.h |  7 +++++++
 2 files changed, 27 insertions(+)

diff --git a/dir.c b/dir.c
index ac699542302..1157f3e43fa 100644
--- a/dir.c
+++ b/dir.c
@@ -3918,6 +3918,26 @@ void untracked_cache_invalidate_path(struct index_state *istate,
 				 path, strlen(path));
 }
 
+void untracked_cache_invalidate_trimmed_path(struct index_state *istate,
+					     const char *path,
+					     int safe_path)
+{
+	size_t len = strlen(path);
+
+	if (!len)
+		return; /* should not happen */
+
+	if (path[len - 1] != '/') {
+		untracked_cache_invalidate_path(istate, path, safe_path);
+	} else {
+		struct strbuf tmp = STRBUF_INIT;
+
+		strbuf_add(&tmp, path, len - 1);
+		untracked_cache_invalidate_path(istate, tmp.buf, safe_path);
+		strbuf_release(&tmp);
+	}
+}
+
 void untracked_cache_remove_from_index(struct index_state *istate,
 				       const char *path)
 {
diff --git a/dir.h b/dir.h
index 98aa85fcc0e..45a7b9ec5f2 100644
--- a/dir.h
+++ b/dir.h
@@ -576,6 +576,13 @@ int cmp_dir_entry(const void *p1, const void *p2);
 int check_dir_entry_contains(const struct dir_entry *out, const struct dir_entry *in);
 
 void untracked_cache_invalidate_path(struct index_state *, const char *, int safe_path);
+/*
+ * Invalidate the untracked-cache for this path, but first strip
+ * off a trailing slash, if present.
+ */
+void untracked_cache_invalidate_trimmed_path(struct index_state *,
+					     const char *path,
+					     int safe_path);
 void untracked_cache_remove_from_index(struct index_state *, const char *);
 void untracked_cache_add_to_index(struct index_state *, const char *);
 
-- 
gitgitgadget

