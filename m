Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48A614EC56
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 21:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755713; cv=none; b=WmKoCu7JVfdtBDiSsEtc5km0COktVBiUXF7feEYfYYAIJTIQi3J/ZFyY3TlDTLq7N9xeO6Tl+5sr9kaJDej0A/GRwlAFJYUpl2zXvPXXmY8ptW54WYCjyLb4pALb1KCIITpISiN2E/mRBM0qGKECyb8/5j3Bp4JibkRw1htHD1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755713; c=relaxed/simple;
	bh=e0pUdkypE5N8JOR0223KnhXy7yYCfVdq0REDUuVeAMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGYcRr88vrR3V9YzArOQhr40z4XED7MB1ddwt4lI9fiAv7MahB6Az8M5IcEP4laRfeG/LgUsy6GQtl8k7NN/KW5J0+TZrMmsuEfdM9x5TGy8wHXITYYJV4Ek4vbZgBtf5dqgCtw86VcshiY5897XgdpO3L5l0fJxYqk8fTn4M0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=wgf0ZXfJ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="wgf0ZXfJ"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dfe43dca3bfso1474312276.0
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 14:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723755710; x=1724360510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hk7olCEw+V+2tKC2Zlgs33ebK2vFPcs6qBfEtV08lR4=;
        b=wgf0ZXfJCOTb/VB13sI9z+Olwna2qDTMLPGerReoVLuYfyNi/j27KfEu/mjxyk60E9
         tYr9r1zqJPFMBWDAVF4FZ8jksTZjqtnnBrSfk49p5AH2k1hRKrYCspNngOIjo6t6YKMn
         iDkytc3DjkUwZtuRCec3TKmVLrMjAkOPJ+kTtDWHcpBDO9HMAXb3FPRowFyScrBFPE0O
         Ush/8p/NNirfaIYutfeIuEudO2KI/sGg1V+mk3OwX1yTGlOlNj1XVO++TMBc9DS9zc0u
         OXFPmovh13u+tbwplPyxBZxXETAD6GjllbY1Mw9HhPdDjr7mY2UXTCq+Oo29U0980q9r
         Woxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723755710; x=1724360510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hk7olCEw+V+2tKC2Zlgs33ebK2vFPcs6qBfEtV08lR4=;
        b=cr9vc4OYpcoU2F5kEe69UV2+lpJUFoWXzR3FxxqrBwjPI9FMOgfqXLfuBxsLXPT5cF
         QbEMFMVeaheHG7J3WdAaprunROQvad/4rZ8kOhdcd0s1ooh0/bqm19PeuuZVUbsf5P3l
         a/8YUlQU/Xt0UYDb7qendL7e5BGPtK2m34ZuW+6h9v1S5cuk/jBzOIdvyirGYAYi83Ks
         nBfvKKyIrW4HNzGSZXP7lLhtk0jZnVlp+WXhgu6w9NOguy/ffgoySm/IJgM92pthhABm
         evflFGsO9fLA+Cy9QUhJOqWJST+ldQXBQD44n/vSFedi/6MM6ar6N4aRw625Rtn5okyJ
         5cCg==
X-Gm-Message-State: AOJu0Yw7UHFfh2240RscQ/5YEmc4uxIadyp7srGdoOHqfzXXF9D9A8Kv
	dS2zyonNi0hQBZ+hN1YuXIYMEv9zwYhRKAop3J5Cs4ecNAvrbQOXSAn+RkpfoY7w9UaNjgm0Ogm
	p
X-Google-Smtp-Source: AGHT+IFjhFHlMTgwgXeNrFv9BaVG8R88Jnb6cJrEwyh1GGmicSPgbVzWTdVlwS0BLSj508BCCpH8QA==
X-Received: by 2002:a05:6902:150a:b0:e03:227c:cf98 with SMTP id 3f1490d57ef6-e1180fd8b58mr1213359276.37.1723755710456;
        Thu, 15 Aug 2024 14:01:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e11720385bfsm447673276.60.2024.08.15.14.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:01:50 -0700 (PDT)
Date: Thu, 15 Aug 2024 17:01:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 10/13] ewah: implement `struct ewah_or_iterator`
Message-ID: <63019e952abfd70865466019cbc38bfdb8841301.1723755667.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723755667.git.me@ttaylorr.com>

While individual bitmap layers store different commit, type-level, and
pseudo-merge bitmaps, only the top-most layer is used to compute
reachability traversals.

Many functions which implement the aforementioned traversal rely on
enumerating the results according to the type-level bitmaps, and so
would benefit from a conceptual type-level bitmap that spans multiple
layers.

Implement `struct ewah_or_iterator` which is capable of enumerating
multiple EWAH bitmaps at once, and OR-ing the results together. When
initialized with, for example, all of the commit type bitmaps from each
layer, callers can pretend as if they are enumerating a large type-level
bitmap which contains the commits from *all* bitmap layers.

There are a couple of alternative approaches which were considered:

  - Decompress each EWAH bitmap and OR them together, enumerating a
    single (non-EWAH) bitmap. This would work, but has the disadvantage
    of decompressing a potentially large bitmap, which may not be
    necessary if the caller does not wish to read all of it.

  - Recursively call bitmap internal functions, reusing the "result" and
    "haves" bitmap from the top-most layer. This approach resembles the
    original implementation of this feature, but is inefficient in that
    it both (a) requires significant refactoring to implement, and (b)
    enumerates large sections of later bitmaps which are all zeros (as
    they pertain to objects in earlier layers).

    (b) is not so bad in and of itself, but can cause significant
    slow-downs when combined with expensive loop bodies.

This approach (enumerating an OR'd together version of all of the
type-level bitmaps from each layer) produces a significantly more
straightforward implementation with significantly less refactoring
required in order to make it work.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/ewah_bitmap.c | 33 +++++++++++++++++++++++++++++++++
 ewah/ewok.h        | 12 ++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index 8785cbc54a..b3a7ada071 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -372,6 +372,39 @@ void ewah_iterator_init(struct ewah_iterator *it, struct ewah_bitmap *parent)
 		read_new_rlw(it);
 }
 
+void ewah_or_iterator_init(struct ewah_or_iterator *it,
+			   struct ewah_bitmap **parents, size_t nr)
+{
+	size_t i;
+
+	memset(it, 0, sizeof(*it));
+
+	ALLOC_ARRAY(it->its, nr);
+	for (i = 0; i < nr; i++)
+		ewah_iterator_init(&it->its[it->nr++], parents[i]);
+}
+
+int ewah_or_iterator_next(eword_t *next, struct ewah_or_iterator *it)
+{
+	eword_t buf, out = 0;
+	size_t i;
+	int ret = 0;
+
+	for (i = 0; i < it->nr; i++)
+		if (ewah_iterator_next(&buf, &it->its[i])) {
+			out |= buf;
+			ret = 1;
+		}
+
+	*next = out;
+	return ret;
+}
+
+void ewah_or_iterator_free(struct ewah_or_iterator *it)
+{
+	free(it->its);
+}
+
 void ewah_xor(
 	struct ewah_bitmap *ewah_i,
 	struct ewah_bitmap *ewah_j,
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 5e357e2493..4b70641045 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -148,6 +148,18 @@ void ewah_iterator_init(struct ewah_iterator *it, struct ewah_bitmap *parent);
  */
 int ewah_iterator_next(eword_t *next, struct ewah_iterator *it);
 
+struct ewah_or_iterator {
+	struct ewah_iterator *its;
+	size_t nr;
+};
+
+void ewah_or_iterator_init(struct ewah_or_iterator *it,
+			   struct ewah_bitmap **parents, size_t nr);
+
+int ewah_or_iterator_next(eword_t *next, struct ewah_or_iterator *it);
+
+void ewah_or_iterator_free(struct ewah_or_iterator *it);
+
 void ewah_xor(
 	struct ewah_bitmap *ewah_i,
 	struct ewah_bitmap *ewah_j,
-- 
2.46.0.86.ge766d390f0.dirty

