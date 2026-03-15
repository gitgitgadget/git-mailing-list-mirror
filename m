Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D6826ED3E
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773567898; cv=none; b=eWpr0J46sB0eRSka+rINIkNAEM2O5yINbLdTcpci2ivkB1e8GnYppr1ISqr6O6YgcbFbdfOZ2Z5/SwqaekPlKp7ic9ocMn4iA+7voohBDLBjn06Cw8HSoESXTEC8OXykUIbclfFbzYJ0KjUumthuMcAOEz5nowNT8kAlBLMaWuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773567898; c=relaxed/simple;
	bh=Hjuvi43WjkTRGrJfzcnE2gEzOn/lg2QCHl+6jUGm85I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0/O3nGRgQQZ1l38x3ifFWuahsiemAqs/zvSZOqpXK+clLeEsxZFYMNg0dozfu9hdIa3tcQOEm8SNj04f7kDvTAiNT27LoAxazWCX3U8F1TvJAMqIG+jIUtWpr60GzYzqCeadq9NqXmwTXiiLJ3NGlCw0sMWYpMC1QWdgTH/PEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nf3RjEkJ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nf3RjEkJ"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so3548258a91.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 02:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773567896; x=1774172696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3JVar4ABkZKSRLyISHPHrcPlEHfg4dR0DYh+w/hS2k=;
        b=nf3RjEkJLSN8FDyGgNuuhdVWXRl0N7CWoCOSz8G/4v8BJOJkemVDg7MAMvw4jSr7Wp
         MOirRswZ5YDFdQxBZUL/QAmoHD+j3lTYRw/7PZ2/xeh7cquLPa2xFVTrxvr03oprbPs5
         Vrclhk9A5BQxyrxyZVICZi1d4YmjaPq2mLjg+lxgFEPvTcZSeCd9iy5hVyb0Gncbu45w
         B9NBFdipYeKk528kMFej9hUo2Ka0u+gVuf7QJhqrxdNwfw286dZzK6s7p+unL6ilp3f0
         XJjb9hPmXi1V/qx9W1yDWKOBr/mwVy7wDQ3ssQWLDKjGQyKlbAl20HORbxAaP9Fi7PSg
         2irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773567896; x=1774172696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/3JVar4ABkZKSRLyISHPHrcPlEHfg4dR0DYh+w/hS2k=;
        b=He+cWDbqxIfwWj36o81TFaaVS3p9U9m13+fEc6t+rSdfp21WM+0HpZ4hKYnI2dN6Kk
         xQWg4NWZ/O4rQcee7dX9ZR0RDQbfV8htZ4HRbfFK69xiWE9UM8WdFOkPZPhbfDGh36Yd
         ZIV4Pwk+L6SUWYrtkNzQQFZPHOZTcKRNHIHAHbsdLTRxwYRhlhJYvhDiFVt4e2Hu5TnR
         TyjwKnUNhAT1FWi1sgmh0+mNmRQZ51yJ8DetPPMIsNrh1aHoINVuJooR+vFKxlks8oBD
         COpkUYxQUG1fY+aNvZXiRkTQji6J3dy+IrLZ+zUxPkb0FFG6UsK3phpvaOWpArZQvzBt
         5MQw==
X-Gm-Message-State: AOJu0YykAgwpxbSvg0wdbjPwgNizqh+pA0lPhYU57dB//oNcJSqiE3aN
	vWp6/UG/NFNCNFWvF9OErxYTnQLJEyeCvm3tlw6ZxweZsoSjrtkoCUF0Xc1lTw==
X-Gm-Gg: ATEYQzz7NtrHxxmVgtmCSl5q8k5FwPxjxd95AIypOrBc1YftqX1PXIPB94fEj3XVkU2
	h2h5nIzoLW55sAoiHCjvelwBcQ+k4i0GaMCchLVg59zm9cPIthmKueqGxm47fznkLYEg1rV77iC
	YTkyLbp6TKkshGWvlBocf0YuGXltvImydXBpaTsyZfgAaTvkqF9YkMgPTWo3GCEeRDlBf3c0uKi
	xC5B9/JpHfoZkckbTiVqrPSjkGvhtTvUyfB3nSE7Naugl72o3Mqrr70bvt0HHU/CgHB1HIMsx+c
	eESVa3UM74PjYEswwT8jYUJLFwgjCfZ15z6rtaTpZlORR5krQpF4u1ZJJZ3gM+qXtJWdCS+Xtn6
	TZZnVD/ShQu2TbN5YwCJnxZQZpUNoO++ugehXGmhw+6P3E0A8qzkPjAz4KwZSU0Ovwd9Nq0eB3j
	tbO9voUjy409tyLqWjAZ/yMVQEWWfAnI316HqXKvuhzy54vok=
X-Received: by 2002:a17:90b:4c4d:b0:340:776d:f4ca with SMTP id 98e67ed59e1d1-35a220656aemr8684278a91.26.1773567896033;
        Sun, 15 Mar 2026 02:44:56 -0700 (PDT)
Received: from d ([106.207.231.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a229e7f9asm3413596a91.0.2026.03.15.02.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 02:44:55 -0700 (PDT)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	Deveshi Dwivedi <deveshigurgaon@gmail.com>
Subject: [PATCH 1/2] coccinelle: detect struct strbuf passed by value
Date: Sun, 15 Mar 2026 09:44:43 +0000
Message-ID: <20260315094445.19849-2-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
In-Reply-To: <20260315094445.19849-1-deveshigurgaon@gmail.com>
References: <20260315094445.19849-1-deveshigurgaon@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Passing a struct strbuf by value to a function copies the struct
but shares the underlying character array between caller and callee.
If the callee causes a reallocation, the caller's copy becomes a
dangling pointer, leading to a double-free when strbuf_release() is
called.  There is no coccinelle rule to catch this pattern.

Jeff King suggested adding one during review of the
write_worktree_linking_files() fix [1], and noted that a reporting
rule using coccinelle's Python scripting extensions could emit a
descriptive warning, but we do not currently require Python support
in coccinelle.

Add a transformation rule that rewrites a by-value strbuf parameter
to a pointer.  The detection is identical to what a Python-based
reporting rule would catch; only the presentation differs.  The
resulting diff will not produce compilable code on its own (callers
and the function body still need updating), but the spatch output
alerts the developer that the signature needs attention.  This is
consistent with the other rules in strbuf.cocci, which also rewrite
to the preferred form.

[1] https://lore.kernel.org/git/20260309192600.GC309867@coredump.intra.peff.net/

Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>
---
 contrib/coccinelle/strbuf.cocci | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbuf.cocci
index 5f06105df6..83bd93be5f 100644
--- a/contrib/coccinelle/strbuf.cocci
+++ b/contrib/coccinelle/strbuf.cocci
@@ -60,3 +60,14 @@ expression E1, E2;
 @@
 - strbuf_addstr(E1, real_path(E2));
 + strbuf_add_real_path(E1, E2);
+
+@@
+identifier fn, param;
+@@
+  fn(...,
+- struct strbuf param
++ struct strbuf *param
+  ,...)
+  {
+  ...
+  }
-- 
2.52.0.230.gd8af7cadaa

