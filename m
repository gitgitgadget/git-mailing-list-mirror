Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CFA57C93
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738441209; cv=none; b=FVlJ+ekZ16kn1KcSZmUcXGbJjm6tSptg31uh3OKrFKb9HDj6frAPHDyJR2iBfPghOmFDAv+4tf5MCmbwhn7yOWHVbuE69WIG0OtLEajHx5d6CtLIHOrc0ehr41oTuQp/Tn45IGQpTXewuh7Y+rg6TLY79fKk3TFU0537G6sDQT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738441209; c=relaxed/simple;
	bh=9W7dMn1Qku0x98lJjGot4hKO77JvknffjmFMtnrtMB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZL+b2H831PC/DUAhutZLPHnHeoBoUZdIsRhpWohXhGiod9o8xSCZ0G7S6spA8/9KWlDpQfY8RQ+0Pmv0blo/M7wZP4E0Ihr/lD2hUO3l25MpDcR+pNWTuu3HDm9RAXB8Mr2wOeFjPDMoG1RUFyJxgcWe/+ZY1ACJ44Qc69EFkRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgmzOldo; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgmzOldo"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3ebb4aae80dso1392161b6e.2
        for <git@vger.kernel.org>; Sat, 01 Feb 2025 12:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738441206; x=1739046006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHYWLJK55mooskMg01y7EmX2oDf94DQEr+i1mU/ip6k=;
        b=RgmzOldoYWrnmS0nh5HSIiD1FrT2hhxlu2a0bbKjIYT/5LmMM+eRn2yLdxRUijCCrC
         oecOuuTSlh9tkCFDdIcN/e9gtDi56sZAf6Nu3K9yruu6yV1iDYpOZ3r2nibsp4V8Y7qG
         6D6A0S/RuEkltqV5L+tB3XCqwEmLKWY+E1wdO6/nKUMbt+NzV0PwcijBWvr+trJ6WgkC
         AhzmIR/KwvZ/w2DD46ebKZH1DNkDWLs50OmIUetREO17+g8fwzb+YdKLaGsQzLfCksbC
         3rSZOPqzOJIosmh1GFRoWZU1sigNRYg5dnj1g3U6G1ZR4gBISNOWV5ShLLeTScctoBWY
         Mx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738441206; x=1739046006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHYWLJK55mooskMg01y7EmX2oDf94DQEr+i1mU/ip6k=;
        b=m03md0QIFRgyw1DtZJnRYmib8kfpxmPdS6I6SFk1OQ2ZYqlBDBxdCG8ui2kAXyrkaV
         nMxXZRWwDKqrbea8GzLJim1XTaaqe+LErGsGw6xXiqx40xqdvexYQxsaVlUxXrYFh1x6
         gf41B3nzb9Hj2xPbflb3vslcAjiUzwjDvV/C4HdVA2Uv3kTT6VC9VRKfhw1hZzeexLhb
         cn2I/ZiF62Zj3pTyjp6WAvmPImNQfkmm/o0kBXECycXzW1jJgi/Ht8KhcuXmpFigitY8
         1Upn8IPxB1GiXnMEMaoBJD5QgOI8B2o6ozbOX+1B4qzuwLK8OnjdzTy8Y5av3WDzPRar
         A0ow==
X-Gm-Message-State: AOJu0YyAb0MXPB6gHj17RK1Cn6Zaj4U2tt4R55Q1dy+6B7jJyJyKnH3I
	CblgCcEph3R7WC8kWdN/VyJYRo92L9njzEEEtTxTh1in78ELlACmEWdtKw==
X-Gm-Gg: ASbGncvhxLQLlty6Gd2YX9Rncj4SNOmPKSqlNAPQYvIwrOSVRs21Cj0lp9gemCkleWR
	ZKk+MwvoNauIOnA49Z/9OX0zQdYE/e44shFLFk6x3Zxe5tMS2i1XPUZEMSIHF6sF6KhEh/TlIV3
	dxANg+9ynoCSFhDsjXBc18YoPGSWc2YkDpubuUT94s/ztSEdhoUoBb2hD2NFdfUALJ3Bw/1pkux
	JQM9/s7mjg68+BM0k10zwKWACHVAf1Lw96GmIsUsTsRsPnLwqfi9h4G9zuamueDvzP25TYV6lqc
	mFKTeIBC6Kp0cGOEKYKYlfs=
X-Google-Smtp-Source: AGHT+IH80IOiklwBeN0m/gF2iTYfxz/AMrMmexM8prgJxcxJOWjRR211/eqf8BofLfD9MOPUaxzw8Q==
X-Received: by 2002:a05:6808:229e:b0:3ea:367e:db44 with SMTP id 5614622812f47-3f3239ed577mr10445881b6e.3.1738441206256;
        Sat, 01 Feb 2025 12:20:06 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f3332bb032sm1588336b6e.0.2025.02.01.12.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 12:20:05 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 1/4] quote: add c quote flag to ignore core.quotePath
Date: Sat,  1 Feb 2025 14:16:55 -0600
Message-ID: <20250201201658.11562-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.48.1.157.g3b0d05c4a7
In-Reply-To: <20250201201658.11562-1-jltobler@gmail.com>
References: <20250110053417.2602109-2-jltobler@gmail.com>
 <20250201201658.11562-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The output of `cq_must_quote()` is affected by `core.quotePath`. This is
undesirable for operations that want to ensure consistent output
independent of config settings.

Introduce the `CQUOTE_IGNORE_CONFIG` flag for the `quote_c_style*`
functions which when set makes `cq_must_quote()` always follow the
default behavior (core.quotePath=true) regardless of how its set in the
config.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 quote.c | 14 ++++++++------
 quote.h |  3 ++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/quote.c b/quote.c
index b9f6bdc775..d129c1de70 100644
--- a/quote.c
+++ b/quote.c
@@ -232,21 +232,22 @@ static signed char const cq_lookup[256] = {
 	/* 0x80 */ /* set to 0 */
 };
 
-static inline int cq_must_quote(char c)
+static inline int cq_must_quote(char c, int ignore_config)
 {
-	return cq_lookup[(unsigned char)c] + quote_path_fully > 0;
+	return cq_lookup[(unsigned char)c] + (quote_path_fully || ignore_config) > 0;
 }
 
 /* returns the longest prefix not needing a quote up to maxlen if positive.
    This stops at the first \0 because it's marked as a character needing an
    escape */
-static size_t next_quote_pos(const char *s, ssize_t maxlen)
+static size_t next_quote_pos(const char *s, ssize_t maxlen, int ignore_config)
 {
 	size_t len;
 	if (maxlen < 0) {
-		for (len = 0; !cq_must_quote(s[len]); len++);
+		for (len = 0; !cq_must_quote(s[len], ignore_config); len++);
 	} else {
-		for (len = 0; len < maxlen && !cq_must_quote(s[len]); len++);
+		for (len = 0;
+		     len < maxlen && !cq_must_quote(s[len], ignore_config); len++);
 	}
 	return len;
 }
@@ -282,13 +283,14 @@ static size_t quote_c_style_counted(const char *name, ssize_t maxlen,
 	} while (0)
 
 	int no_dq = !!(flags & CQUOTE_NODQ);
+	int ignore_config = !!(flags & CQUOTE_IGNORE_CONFIG);
 	size_t len, count = 0;
 	const char *p = name;
 
 	for (;;) {
 		int ch;
 
-		len = next_quote_pos(p, maxlen);
+		len = next_quote_pos(p, maxlen, ignore_config);
 		if (len == maxlen || (maxlen < 0 && !p[len]))
 			break;
 
diff --git a/quote.h b/quote.h
index 0300c29104..2a793fbef6 100644
--- a/quote.h
+++ b/quote.h
@@ -83,7 +83,8 @@ int sq_dequote_to_strvec(char *arg, struct strvec *);
 int unquote_c_style(struct strbuf *, const char *quoted, const char **endp);
 
 /* Bits in the flags parameter to quote_c_style() */
-#define CQUOTE_NODQ 01
+#define CQUOTE_NODQ	     (1u << 0)
+#define CQUOTE_IGNORE_CONFIG (1u << 1)
 size_t quote_c_style(const char *name, struct strbuf *, FILE *, unsigned);
 void quote_two_c_style(struct strbuf *, const char *, const char *, unsigned);
 
-- 
2.48.1.157.g3b0d05c4a7

