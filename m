Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A816D315
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 22:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723243289; cv=none; b=t0rwWyOPA0TLyMEjceKKmRJ3gcA4eRP6BnVJBy/p3fdUlXl04ZDgivofBdPFle3TTPFhwSkPjXAK8D7WZ6Dl6W/K3ZvXKxqKGSAn8Oey6qjeRhNkhN1Qhf5wh50uXkNvx8DQLe4ojCe1rCSlDV1XlKH9OjitZeJjphEaBKigG14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723243289; c=relaxed/simple;
	bh=XGxIh6o4z04vy8A/yAcaN2qeQppZedVs0LMviRQ6sjI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BTegwrnzubqJn9Rpa0dnICLtp4DZafcnxUSBnMmDAyz002Z8VJ/2h4BGVlxo1yBidAhjAdm8+x4tzD4r/lO/wLwkLtOX0/Rt3e+7itpBxN4FMmwef3tV5HLow+1X4xG+ZaxUN6W2MWDtX7AWNozfrkWQZV1rSo8dGHWTFT29uAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EY9FIY95; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EY9FIY95"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-664fc7c4e51so52333527b3.3
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 15:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723243286; x=1723848086; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8O8L58z+pSeLkSMIC8NopkCyxoaH0uGAl+ihme5B/TE=;
        b=EY9FIY95zVmY1rzQIWQumPj/AVt//R2yGYHA0LKWb4k2doRURN+o+y5wpRC4K11d4l
         wzHvCewoO0TdyixjuKslFuWCObWwfwjyvvNc1NVwnycQlWTU939qUga5lIBXsd/7byfe
         akpm+VIHOh5gonIgNuBV3C67NRHA0YcvnzZ4akE8yDcEuLEVyxIlJYkMQy+TdiOTjjIL
         5mx63rXjvxfP/GK4VsLTKs5LZNy3PaVZY8Nl44D0+GtdowZjpWzEETVvm7c3y99Uh6Cc
         S7vbx1e3zFS9NbLacdsaHA7o/gLYGPiWq5SOyJreHzcgHV+motxEpkg5+vWYlxJhqVy/
         hVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723243286; x=1723848086;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8O8L58z+pSeLkSMIC8NopkCyxoaH0uGAl+ihme5B/TE=;
        b=tCflAu4lLUjYRZ75ZLDMjnhdYeaSoifPI+RjXuj1MtsqMzWKdoD+PrUOmg6CIG5M/u
         U4WXjvldAkbtT2mV6BVX4Tzi+PAR+zjcgFst0STBpeve53Kt2eOrsmAbt74ZbfDjYa8X
         WJIrPb7nBHN9kpYW8PL6gHLGLaeDHooRQgE9O0F3R/OV3xzZ5XVAaL4ys2nuunstm5JG
         Du6tcVUJBg98I4ZpPXDcCfw9DN4zkfG1wuicDw/t83ARYcQttow269Wu3etbWgT5hJh8
         H0c4M0+GEBsSiBU31GAqrHhP3lIaEmxcpajTVaI+JDiLdvJOiPy8ilCRAezF21RTq4gJ
         +y0w==
X-Gm-Message-State: AOJu0Yy7cWa6aU/8mSiofqXofhxtnkeyHa/4qs0XGbBcc/tBploU3Qcd
	q/dAn6wTaPLmdzdVOrO9+5ntuIHeBGoWZu/qMe3IYCyUvWxNpHb6ZNwqe9Ug8nk5X5X+7XRgx8b
	s3PPwJAeHbTb+Bfb87bzYKuwB0sUunOBftpKOuxL+W5H+uWglrluH03bhHUV+6UPHVyNL02r/zy
	97e/Mtr6sWnjT8Suj0Ll1g/Y0WOZaFI+PWY5OyNMU=
X-Google-Smtp-Source: AGHT+IH9ekYqX187NH/F6VdoKV3ctmF3bsf8FkK/HHKWuEYiv17mU45M3bSYproWAyxPCQohw58BkMqZqmM+Mg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:6126:cc38:1b9:851f])
 (user=steadmon job=sendgmr) by 2002:a05:690c:2f81:b0:68f:dfc2:98ee with SMTP
 id 00721157ae682-69ec86c66e2mr224507b3.5.1723243286254; Fri, 09 Aug 2024
 15:41:26 -0700 (PDT)
Date: Fri,  9 Aug 2024 15:41:16 -0700
In-Reply-To: <cover.1723242556.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1723242556.git.steadmon@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <908ad0b82fa084fc4e56d7f6dff49e4f255af6ec.1723242556.git.steadmon@google.com>
Subject: [PATCH v2 4/5] config: add git_configset_alloc() and git_configset_clear_and_free()
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, 
	emrass@google.com, rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, 
	sandals@crustytoothpaste.net, Jason@zx2c4.com, dsimic@manjaro.org
Content-Type: text/plain; charset="UTF-8"

Add git_configset_alloc() and git_configset_clear_and_free() functions
so that callers can manage config_set structs on the heap. This also
allows non-C external consumers to treat config_sets as opaque structs.

Co-authored-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 config.c | 11 +++++++++++
 config.h | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/config.c b/config.c
index 6421894614..444db8de79 100644
--- a/config.c
+++ b/config.c
@@ -2324,6 +2324,11 @@ static int config_set_element_cmp(const void *cmp_data UNUSED,
 	return strcmp(e1->key, e2->key);
 }
 
+struct config_set *git_configset_alloc(void)
+{
+	return xmalloc(sizeof(struct config_set));
+}
+
 void git_configset_init(struct config_set *set)
 {
 	hashmap_init(&set->config_hash, config_set_element_cmp, NULL, 0);
@@ -2353,6 +2358,12 @@ void git_configset_clear(struct config_set *set)
 	set->list.items = NULL;
 }
 
+void git_configset_clear_and_free(struct config_set *set)
+{
+	git_configset_clear(set);
+	free(set);
+}
+
 static int config_set_callback(const char *key, const char *value,
 			       const struct config_context *ctx,
 			       void *cb)
diff --git a/config.h b/config.h
index 54b47dec9e..074c85a788 100644
--- a/config.h
+++ b/config.h
@@ -472,6 +472,11 @@ struct config_set {
 	struct configset_list list;
 };
 
+/**
+ * Alloc a config_set
+ */
+struct config_set *git_configset_alloc(void);
+
 /**
  * Initializes the config_set `cs`.
  */
@@ -520,6 +525,11 @@ int git_configset_get_string_multi(struct config_set *cs, const char *key,
  */
 void git_configset_clear(struct config_set *cs);
 
+/**
+ * Clears and frees a heap-allocated `config_set` structure.
+ */
+void git_configset_clear_and_free(struct config_set *cs);
+
 /*
  * These functions return 1 if not found, and 0 if found, leaving the found
  * value in the 'dest' pointer.
-- 
2.46.0.76.ge559c4bf1a-goog

