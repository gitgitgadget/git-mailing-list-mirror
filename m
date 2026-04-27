Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9EA39B949
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293694; cv=none; b=qqCVFSml5SMClOFRiBMOTBv6FyMzfDpbklDZK/Ewldjy/tbQVrnMICv5D8ne/dTB7YXMsNGV29yf0pXyHn/HLHa6pNBvUDedhKfOezkvLPSf4vaoMx751+IyFTOnhJ89fgWeBSR+SteLe/07eWLP6i3Tu7CqH6ixh+tlwWqwVxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293694; c=relaxed/simple;
	bh=XpiP92FVCCsz2C5iKiYK9B0s2jRRjPfm2v16ooV3wr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGKkTtOhJ+YxpN1mNvLurdB8R+v2FhIz+Qcwv+T+Ya8OPMGvx0QgSrf0osumCdhrBVZdYZIVX/FWlx5JvYBWXBpwxf7qSrBRbmP/fRSz+DaXRbIP+3v4WgQ6auzGFmxAlRw/0dRM6ek+3XVCFOLWpfA1Eq1YclWNr0b6xS8OTS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGkHq1Ei; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGkHq1Ei"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ba6b39871a3so1242134966b.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 05:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777293691; x=1777898491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRAQEx5XuyFjwU1OhaGKHiU2yevTqm9GfEMrfwXWYS0=;
        b=VGkHq1EiqKwYbM3foI189k3fgQ7qcEAvB/bYpjOmGiiE4Wljn/O4FwUkRiqMjnJ9+2
         w6W2cMpTHTECnai1EpkSv9snmjwrmJVD0PD6ltTgUCzC/0gx1g/sjFyz4zmeFf16bCYY
         49AsJWK9jdNzdkcpqar7kMknzTD36JkMiaiV9WYs6CBjk/zB4JFxhM1hWF49l3QZrh9U
         u7fe3rMc0z60byFYQ4GsxIW5pB8NHEkfvHl5eHGuWi8KhRv8b/1MhQvEtL33IbRqj07U
         Y1Chwnw2jJA133LB70Z/cw326kpF7laatf6cv+KCr+On76EHH51o7mWluTw7mvCYg9lf
         34AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777293691; x=1777898491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WRAQEx5XuyFjwU1OhaGKHiU2yevTqm9GfEMrfwXWYS0=;
        b=gMFHEXTyYPXwVP7UVstPUdJ96lzniZum/Nvpwk06WexbFrhRf4WfdU91C6GY5SlzXC
         cA+RUkSh6RHl/FyGInr9ZQT4VAtMTOexdcb7SU6TKwcpfh2PI1eT2I4i0U2MPisgryla
         lEoJVRXa5s0yeGM84jQ7VXP/x66o+pz0YsTOt0RfOh9By1rS28+6MEkDn/Z/oUv9WH9H
         H/LT3iOfr3njLIyWa8wmxHvfC6z32YmArafBhIaxMXpof0DtWKBt5Ec6QyZy0oOMc5Al
         x8zsv6/z3BwV55jnD/M+MkyGsuyeIlqzBmilVxz00HhDFLiYUP5PYzzU+RTyhWh4nUss
         4XVQ==
X-Gm-Message-State: AOJu0Yxq9vY0AMscNjGRqSlYUwutvQ/5Dq+AndN9bGQJS5zwPkETdTG+
	IhGy/tO8wpb1KcsEkFJ9Fw6k9VJ/f+Lhs7epP7tDanzrUR08GQZJAKxNkyuQ/A==
X-Gm-Gg: AeBDieubtMOgoQlYEHA5xKgqThjOx5db8VImp4B6FAfq+tC8EQ6m9OVbVOpTcsqDawp
	BBhv7WQ28danL4Y3CYo4O7PEVv2lyIZQ7oq5sKEEw7knsHYc41lrmN1z9jTc8xBD480Cf8rnDxh
	nLf9Ltgvskwfgy7yHi+pl9Tj67UV66t6xPdPI/ZMZSEv1uGSJa1y/ht32IUOBngZgQUWMtqosUL
	Y8JwuB7HXYlaT0JaTKTvd2+W0zuFPYDgq6w1TWDuXXNaf9J7dv2L7ZgBFLO44sfb8UQSt40Rp7R
	sLOoZohpHpFNt50poS1dnSfMug6/Mg/j/Kuu2PjKHTZ6KsUCvLaJj+9mSOhaH3zBGcbrRd64off
	OehSOV9LBJye33jQOLuNTGUfS3shcPTEiWWka7d8YZXnUAVnv0prbk6YKb6UUkcLAwMfsgnin1E
	Gdn1e4bc/Obt0lVWt3D8VMqi0rKRNMjbOhFj+ieRGtWVbSIrVjb91emixH5RkOKSYNngPjnaOcK
	2aCpcaCkIlr7/yQtDqORPvbm22tHBGfT4OJvMnF5EnKa8DIe5s5CoES8OAp
X-Received: by 2002:a17:907:2d0f:b0:ba6:a05c:ac2f with SMTP id a640c23a62f3a-ba6a05cb512mr1494420866b.22.1777293690486;
        Mon, 27 Apr 2026 05:41:30 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6744dcdf29fsm6760446a12.30.2026.04.27.05.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:41:30 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/8] urlmatch: add url_normalize_pattern() helper
Date: Mon, 27 Apr 2026 14:41:03 +0200
Message-ID: <20260427124108.3524129-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.19.gb68b9497aa
In-Reply-To: <20260427124108.3524129-1-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20260427124108.3524129-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a following commit, we will need to normalize a URL glob pattern
(which may contain '*' in the host portion) and extract its component
offsets (host, path, etc.) for separate matching. Let's export a
dedicated helper function url_normalize_pattern() for that purpose.

It works like url_normalize(), but passes allow_globs=true to the
internal url_normalize_1(), so that '*' characters in the host are
accepted rather than rejected.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 urlmatch.c |  5 +++++
 urlmatch.h | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/urlmatch.c b/urlmatch.c
index 989bc7eb8b..7e734e2660 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -440,6 +440,11 @@ char *url_normalize(const char *url, struct url_info *out_info)
 	return url_normalize_1(url, out_info, false);
 }
 
+char *url_normalize_pattern(const char *url, struct url_info *out_info)
+{
+	return url_normalize_1(url, out_info, true);
+}
+
 static size_t url_match_prefix(const char *url,
 			       const char *url_prefix,
 			       size_t url_prefix_len)
diff --git a/urlmatch.h b/urlmatch.h
index 5ba85cea13..32c5067f9b 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -36,6 +36,18 @@ struct url_info {
 
 char *url_normalize(const char *, struct url_info *);
 
+/*
+ * Like url_normalize(), but also allows '*' glob characters in the host
+ * portion. Use this when normalizing URL patterns from user configuration.
+ *
+ * Note that '*' is a valid path character per RFC 3986 (as a sub-delim),
+ * so glob patterns using '*' in the path are also accepted.
+ *
+ * Returns a newly allocated normalized string and fills out_info if
+ * non-NULL, or NULL if the pattern is invalid.
+ */
+char *url_normalize_pattern(const char *url, struct url_info *out_info);
+
 struct urlmatch_item {
 	size_t hostmatch_len;
 	size_t pathmatch_len;
-- 
2.54.0.19.gb68b9497aa

