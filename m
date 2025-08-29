Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7F25484B
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496565; cv=none; b=rY/LoNUpTl+sVgGpKe1d5SvfHJXNYFl6jYvtLb9EEtOYGyFh9rIq1eQZtPkwAw5TxLum+7URodczEOL8owAKYe9TKdTlgdZWRwxGGJ8ccT7iZGp9Rh+6uTwO7A0yDulPcev0JrVhaokYgit1V8kDhWOfrpeGoPzg0bpvJkGnYoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496565; c=relaxed/simple;
	bh=JvjMMyp/DVz5R1A5RNfR+sHk7hdeyyu/q2PKRp7GhVs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eCA0B3qPfiTqDCdH0sqSyP5SvNvrJVcjFc8vTtjKwFiRGW7g+zKT308X+AroVs6K0bWLkTlBpx0G6FW99YbWqpagiJPx9MDj56wsx6gBI6YbnsAr8bsh2f6KXMXxlq0hRUSPdd0X6fCy3Vz2pfyMAaesl7Dv47bDxQUp/HgLZuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFDZ7eJs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFDZ7eJs"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-248de53d12dso14517515ad.2
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 12:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756496562; x=1757101362; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuKP1ci51fdZgl3QECK0lkoImMiAcQsKNSUai6piGDg=;
        b=iFDZ7eJsNjTblKeSSCj/a8rnpj9exw2cpJIfPuHOh8xN+Lwm6rmUNcLDd60xFGHrDE
         pDZyMFKgyy+8vMZkig5lFpzTABNqIwQAjg13ApSAXDVwMz+tt1zyVjgkkDjVLFtOJiQx
         XAqbBBOnf80xXe5f+Dp4qvohmPvjKCnXokIg+OGYa2jvL7xK1vdJ+xTEl68xVqac+Mhv
         lZFLYeYW55PXhG47dwUc/98VGB9UhT1+FDfrKVRNBbBtcyBPl5YRKov7XdlZH56PB1l3
         eBC3MrdDrzkEb3Gl0NuWCJdgXEaL2Zz3b7XO9+54OJW1XpN5f83q8KTc5mdOYCztuCVN
         k+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756496562; x=1757101362;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuKP1ci51fdZgl3QECK0lkoImMiAcQsKNSUai6piGDg=;
        b=ho7qzBWcdLxP6nWdkIUZVEALJRwcvuKIkgsPkgvaYn0ZF2t7rFfV63CXdR84V2mi0F
         aqmuPh+eWAM81+ORRxY6HtsCZ1Qe8pbibgheBdGgqmwgiYBot45jIoH3ioRWNWEck3bY
         U8uq/C4XJoQYQg8rrenJg2cYDqvs6/C7n3w1OW+AUGKN4hA/cnbD+m6QtCBzsn22Psj9
         aKZ1o61GC95GFBZilTjXRCcCOeDy7sxO3ya6yzzeUCiVTZJcuQEuK7kd2F8X/fYGVy9s
         gouOVA5Qi3N8TophtPdCr0pLRoGNYKZFi/QXXH7gDSnO3LbkD7d79CIqgq6GBCwlYDA2
         bYSQ==
X-Gm-Message-State: AOJu0Yy2bx77Z3w+E26Z3Sb+1Mw0vjHuK739HMDa99IKxPiwAXqm49lr
	HwsQ4RIXTxjiyHg+izg1zSvg3Mw6IkhTIbWgnA3Z4uWee4m7WlkFGwoqR3FISA==
X-Gm-Gg: ASbGncusnKgfE3oysDw6xt4IZjg11YarGn+y4uBaT/RuPuuU5Bis6hNQfH4E3gZ1Y+i
	iOP9RM6a4kS9RD27v06EVRmP2pKkQ9VvkE40+9+mXb82QtiFa6GPaQsSrDJ8xEzNgry2wsAPX7z
	8/Y9dq5YrmdNjI9/RbmXQM+URyBS9aYLgw683gtEIzetK6KGi2KweEV5LHDOsx61sQBROG95c0A
	AXCSkbIyvDS61b1Ub/FzgFhH7xUwoDAbtHKiFZjszlUpReo6+ZW5AlceNFvlbhlVZLyfkfoXV3S
	7KVzbMwnLRrkKNkVA2QK8/9hOmH3E5zYwWWnw+4JWuklhD26NA/uKK8WVcNOVss8CE0+vIxVWRc
	B9eAdUVpS/9amnP2LHCFUCM0iH5U=
X-Google-Smtp-Source: AGHT+IEsd4mwKV7t4a+9mYwJzI7vnbH5ceZdzYc44T1dn+WFMgK7zXTq+EXP6wjXF2aZyygbaRyzkA==
X-Received: by 2002:a17:902:e846:b0:248:a054:e1c4 with SMTP id d9443c01a7336-248a054e4e1mr140607245ad.23.1756496562208;
        Fri, 29 Aug 2025 12:42:42 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f5925adsm9051172a91.10.2025.08.29.12.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 12:42:41 -0700 (PDT)
Message-Id: <9fdd23acf6613c6f07c8928755ce18b87321911e.1756496539.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 19:42:19 +0000
Subject: [PATCH 15/15] xdiff: implement xdl_trim_ends() in Rust
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Replace the C implementation of xdl_trim_ends() with a Rust
implementation.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 rust/xdiff/src/lib.rs      | 15 +++++++++++++++
 rust/xdiff/src/xprepare.rs | 27 +++++++++++++++++++++++++++
 rust/xdiff/src/xtypes.rs   | 19 +++++++++++++++++++
 xdiff/xprepare.c           | 28 +---------------------------
 4 files changed, 62 insertions(+), 27 deletions(-)
 create mode 100644 rust/xdiff/src/xprepare.rs
 create mode 100644 rust/xdiff/src/xtypes.rs

diff --git a/rust/xdiff/src/lib.rs b/rust/xdiff/src/lib.rs
index e69de29bb2..4cc05a7e6b 100644
--- a/rust/xdiff/src/lib.rs
+++ b/rust/xdiff/src/lib.rs
@@ -0,0 +1,15 @@
+pub mod xprepare;
+pub mod xtypes;
+
+use crate::xprepare::trim_ends;
+use crate::xtypes::xdfile;
+
+#[no_mangle]
+unsafe extern "C" fn xdl_trim_ends(xdf1: *mut xdfile, xdf2: *mut xdfile) -> i32 {
+    let xdf1 = xdf1.as_mut().expect("null pointer");
+    let xdf2 = xdf2.as_mut().expect("null pointer");
+
+    trim_ends(xdf1, xdf2);
+
+    0
+}
diff --git a/rust/xdiff/src/xprepare.rs b/rust/xdiff/src/xprepare.rs
new file mode 100644
index 0000000000..f64f60c099
--- /dev/null
+++ b/rust/xdiff/src/xprepare.rs
@@ -0,0 +1,27 @@
+use crate::xtypes::xdfile;
+
+///
+/// Early trim initial and terminal matching records.
+///
+pub(crate) fn trim_ends(xdf1: &mut xdfile, xdf2: &mut xdfile) {
+    let mut lim = std::cmp::min(xdf1.record.len(), xdf2.record.len());
+
+    for i in 0..lim {
+        if xdf1.record[i].ha != xdf2.record[i].ha {
+            xdf1.dstart = i as isize;
+            xdf2.dstart = i as isize;
+            lim -= i;
+            break;
+        }
+    }
+
+    for i in 0..lim {
+        let f1i = xdf1.record.len() - 1 - i;
+        let f2i = xdf2.record.len() - 1 - i;
+        if xdf1.record[f1i].ha != xdf2.record[f2i].ha {
+            xdf1.dend = f1i as isize;
+            xdf2.dend = f2i as isize;
+            break;
+        }
+    }
+}
diff --git a/rust/xdiff/src/xtypes.rs b/rust/xdiff/src/xtypes.rs
new file mode 100644
index 0000000000..3d1ce9742f
--- /dev/null
+++ b/rust/xdiff/src/xtypes.rs
@@ -0,0 +1,19 @@
+use interop::ivec::IVec;
+
+#[repr(C)]
+pub(crate) struct xrecord {
+    pub(crate) ptr: *const u8,
+    pub(crate) size: usize,
+    pub(crate) ha: u64,
+}
+
+#[repr(C)]
+pub(crate) struct xdfile {
+    pub(crate) record: IVec<xrecord>,
+    pub(crate) dstart: isize,
+    pub(crate) dend: isize,
+    pub(crate) rchg: *mut u8,
+    pub(crate) rindex: *mut usize,
+    pub(crate) nreff: usize,
+    pub(crate) ha: *mut u64,
+}
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 93370f1c6d..2c7480875f 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -318,33 +318,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 }
 
 
-/*
- * Early trim initial and terminal matching records.
- */
-static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
-	long i, lim;
-	xrecord_t *recs1, *recs2;
-
-	recs1 = xdf1->record.ptr;
-	recs2 = xdf2->record.ptr;
-	for (i = 0, lim = XDL_MIN(xdf1->record.length, xdf2->record.length); i < lim;
-	     i++, recs1++, recs2++)
-		if (recs1->ha != recs2->ha)
-			break;
-
-	xdf1->dstart = xdf2->dstart = i;
-
-	recs1 = xdf1->record.ptr + xdf1->record.length - 1;
-	recs2 = xdf2->record.ptr + xdf2->record.length - 1;
-	for (lim -= i, i = 0; i < lim; i++, recs1--, recs2--)
-		if (recs1->ha != recs2->ha)
-			break;
-
-	xdf1->dend = xdf1->record.length - i - 1;
-	xdf2->dend = xdf2->record.length - i - 1;
-
-	return 0;
-}
+extern i32 xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2);
 
 
 static int xdl_optimize_ctxs(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
-- 
gitgitgadget
