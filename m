Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0363B243946
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754299395; cv=none; b=SDmw9ZgdGtRXs/DWTlRk3bgxrictlv07DTQEdmUr5fUqNHTGjOevUw/peubiRM5ywNBDrjRoviRzq18DX3JezwXEh5DXvzfXj2sn1ztXwlEPXxp2tdFqHglR8Le2ahm6P5fRQwjoEH/JrrbM7rMfto+RdJO2bm0V8uP6cVGE+Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754299395; c=relaxed/simple;
	bh=Luw1ZnHBqNv5seZ3JYoUarxZrVMOoy8otRy5GilZldk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m+mIi+0Ho9YGYnAQ8wEPsYpaH+zGCDxNMSBB6AYGNoY+ltADB4WgkmGVrQ04/t9eHHoBotldCvjPPl/Q4UOyZ4gkeaT+ElhhdEENNZB26MXX8WEiSkVGkPbupMKlkKOR0tlzB5fSmqiAmr0nChYBVQfRiQtpzsG0o0Fh/Cqd9es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaDKuZcT; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaDKuZcT"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b271f3ae786so3181208a12.3
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 02:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754299393; x=1754904193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SI15psiGYpi8mxluP/ygZsr9qurTvyHgEMjKCs+LREg=;
        b=DaDKuZcTm2XikqLhubW8iSx2T+0xgv7ryM067JqCwzr17coOGw9deG2Cj7URtSFjj0
         p/Udb1kJ7qUlx9Fum4VKr9w0GMRXuZdpigRXYzoUiJV0L+lTowqbwR+vrxnIDJuHEbSK
         5FbodVty3KAkzIy8xkBrAGNn7u4Z7TSKk2M5K4cEiG1DOt/VqJAfOJlN67eWTr8LQmCJ
         hcp13zmKc5LAhAswYphUCtcjle9djnd5k2Xdss4VYd4BqgibrXTZUo1+fdxjD2XO2fzE
         XLUQL3jXRYlFeoc0LUJKh4VDXWAe5ra53wTj6Z7/ArbJQdINObBGuLceOJerJpgvebqM
         l73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754299393; x=1754904193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SI15psiGYpi8mxluP/ygZsr9qurTvyHgEMjKCs+LREg=;
        b=KlDmK0esew7SM9/hqTcYxjEmASyBLEl4ZgVDrXg/tPIy7StlYmxYyLGoMgMc/6TnKx
         Mt6+DQpGdRlJ/YeMO9YWGhL18cgQNVvKKyYCRBV447LRtQ012Tb3LfMyl+0Ai45Ks7W7
         wJXZjshPYj752rq8kvhqHX7LoX6JLWGBVtxWUVvNe73mPMkUF2qeYe00B36XmaC02QNl
         atstzwyeChjL8daiHVyt7ePMr5uLGy+oqVv2WgaiD9/2R/b6bly4u/4NFZwJJzEBnn/q
         DcWSZb1DPkwMckoXl4Esp4enU6N8LMcJGpBbXNCteGqyajkm5cQx14l6ub1FhWZpb9lp
         MtWA==
X-Gm-Message-State: AOJu0YzBw5PnnEN19SVInDT+dB4c2Q4Jq00RPkyjtkb/UgvSAfG3Fh3R
	5gGQC8Um43cNorVbuclzt+tZLv8eOfbM5jDVpDqZgLAFdzKnFV8pzgo8O8pBwsQOFAs=
X-Gm-Gg: ASbGncvSIzQB/1KJ6QwRCBWOuQtdL5s2KeneMbXMj6LwRjWQZ9bf0qOtvhexOIWd8JX
	Jbfk26n90O3FnvMeL4m9Uz5k4+YlydXd+bTAB2pwFrIZLxBjiB2mDckKxNg2A5o1OiWOyAJ2y4H
	w3+DMeV2IBDInlvca/0VPa92ku2Z0whKsEsu7xs35yMrHdoDCxv+6H60w/O3m8x5VgJoPjNKnHH
	SA0qx4NNpPftw3K1SExtYH//FPRqXutyfDYTiMSXLPDj51/G/ixWma9XFX2Z00l+YZ3zEqX3/eY
	o4Y3gtCwRbk0aKxUFYV9ieFMlan0+wGmFH2g2f7OZZ3dBjbqdZ1YFW4GFyAt1LpWOWOz+0eV3k3
	jHhh6pV7vXbV/F399ivo=
X-Google-Smtp-Source: AGHT+IEnyqpKH5aifCv9L4u73fshcZbyRzRhTCCnhVI2Zqy1FeWOGamGOxGXSmm70a2JDemSkaekxw==
X-Received: by 2002:a17:903:2f87:b0:240:2774:8372 with SMTP id d9443c01a7336-24247033fe3mr120749915ad.36.1754299392800;
        Mon, 04 Aug 2025 02:23:12 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6c62sm106205565ad.4.2025.08.04.02.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 02:23:12 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	karthik.188@gmail.com,
	gitster@pobox.com,
	sunshine@sunshineco.com,
	phillip.wood123@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Aaron Lipman <alipman88@gmail.com>
Subject: [GSoC][RFC PATCH v5 2/6] builtin/for-each-ref: align usage string with the man page
Date: Mon,  4 Aug 2025 14:52:51 +0530
Message-Id: <20250804092255.1092973-3-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804092255.1092973-1-meetsoni3017@gmail.com>
References: <20250731090040.1625303-1-meetsoni3017@gmail.com>
 <20250804092255.1092973-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Usage string for `git for-each-ref` was out of sync with its official
documentation. The test `t0450-txt-doc-vs-help.sh` was marked as broken
due to this.

Update the usage string to match the documentation. This allows the test
to pass, so remove the corresponding 'known breakage' marker from the
test file.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 builtin/for-each-ref.c       | 14 ++++++++++----
 t/t0450/adoc-help-mismatches |  1 -
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 3d2207ec77..b2186f9f9a 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -8,11 +8,17 @@
 #include "strbuf.h"
 #include "strvec.h"
 
+#define COMMON_USAGE_FOR_EACH_REF \
+	"[--count=<count>] [--shell|--perl|--python|--tcl]\n" \
+	"                         [(--sort=<key>)...] [--format=<format>]\n" \
+	"                         [--include-root-refs] [ --stdin | <pattern>... ]\n" \
+	"                         [--points-at=<object>]\n" \
+	"                         [--merged[=<object>]] [--no-merged[=<object>]]\n" \
+	"                         [--contains[=<object>]] [--no-contains[=<object>]]\n" \
+	"                         [--exclude=<pattern> ...]"
+
 static char const * const for_each_ref_usage[] = {
-	N_("git for-each-ref [<options>] [<pattern>]"),
-	N_("git for-each-ref [--points-at <object>]"),
-	N_("git for-each-ref [--merged [<commit>]] [--no-merged [<commit>]]"),
-	N_("git for-each-ref [--contains [<commit>]] [--no-contains [<commit>]]"),
+	"git for-each-ref " COMMON_USAGE_FOR_EACH_REF,
 	NULL
 };
 
diff --git a/t/t0450/adoc-help-mismatches b/t/t0450/adoc-help-mismatches
index 06b469bdee..2c6ecd5fc8 100644
--- a/t/t0450/adoc-help-mismatches
+++ b/t/t0450/adoc-help-mismatches
@@ -17,7 +17,6 @@ fast-export
 fast-import
 fetch-pack
 fmt-merge-msg
-for-each-ref
 format-patch
 fsck-objects
 fsmonitor--daemon
-- 
2.34.1

