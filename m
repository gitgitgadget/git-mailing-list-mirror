Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E02B2253EE
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 03:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755921379; cv=none; b=PMqY/skWm3nvRLmGIsqHQiK7uiwhEUtI9fOKJfQDlyEBykEhT4YqW9vZZ75m/YzkRcJ5h8M9t7X7SwF5ubsoAhDLWeL6Pr15JCmv8ZIO1/vXBaeHxhG2cEkIpsdLdju58F2ta8ANt9rcMn5DtLHRG/rwEyPEBGymskKZ7ZnMtkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755921379; c=relaxed/simple;
	bh=+UBMrDfJB6hBcbUSa+zghkcQP2ZOydni8zyAiRaC0B4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Wz21HPcL6eha4m6N0Mtqjjbw90RwwruGmu/qk86oBuW1USvxKGtTH9dN8DTz095OBvFwmPie2u32CVtGzJqgV/X9ZDYA/lv+ZW9x9K5IpFPzY3v0bMRk5oloPu/uklWMd72KOi24zpMJgqcnXA6GnNnzJvpVnW7iFxPv6dT3owQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbleA5ZJ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbleA5ZJ"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3c7aa4ce85dso12538f8f.3
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 20:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755921375; x=1756526175; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3pjiQrUZvGGvuiN7OP0Porf33N4ebJMkMyru4PjcVs=;
        b=EbleA5ZJ58N5Dg9dnkH0PSrILjwbWcxZMOpppWhLE2vaa11BDRWqQkYEKw00ArKQ8o
         o9kujrOj0TlXTwkiezFWkXUmy6ehox3lTQ1C5JOeDkG5synPutPI4zyWY0HbSnvW5wdQ
         KJ6w5bYfBFVYlTzMfZfGAWfLXuzNrz9JZPz1dLjm56fcQnHj6t8LEb9EAOex3jm5JvdP
         kywNk28RXG2AVcsNbNW9kXraUOoJtJASgkiz3MIE08wPez+RtvE0qAqSC/l17QAT+hjZ
         tX6tkc7X9l79ZfX2NZpOfx57rk8YaHtiodhKodd1yAp4n3TOybtD9FgFbWlvJMSCQHCa
         qy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755921375; x=1756526175;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3pjiQrUZvGGvuiN7OP0Porf33N4ebJMkMyru4PjcVs=;
        b=O0Wa8qD6mZ/L40Qp2OtY9bu04VRjvXKBaEEEoPxGwraKEFDrzN3KtCNNXFAFd8gtL/
         RpiXKnbwO0sf9b08v+6YjU4zfWd6JMu7I9GmKiZAsn9dLB7x7MpZhOzUTmvHP02oKjd2
         7OBK8XuiOIE+I48Yb5FNhs6t6IhQyZMMO8iHViODuNH3hjIhguHZ60KI2cD/Aear9RSv
         hZeJhVeA5Z6KYRZvQ1Uc674gleD7soGJj2t6XXK2Zk6B4QYkBUzKCnzGccc7AAcn30J6
         hJGPJ2/OtiXscOQJtdPGCWkduHMuXlUcw7sps9eHOzuE7WpNrUpHIwY5SVBsmEG1TuVU
         zmwA==
X-Gm-Message-State: AOJu0YyIChG2Gay0X7RXm1Uo68rFyVrtNH5Ly/JjsVIKt48I/RB+0zKG
	iJXak/ugLeDdj6SBKAWuTGje6bdJsGbI/TlRQ/ZejrUCNo3yorxw5PQXEPixuA==
X-Gm-Gg: ASbGncujYsryTRBI1Qagw1bfw+46BD4tFGB85TrM+cmZaDgzuobomGFRzzTF6/cRAui
	ul3GUz5iG1VlVSnTaj6rDYrjQq4pBn4j3TsleW6TNgJXc3TMZqQyOcIfkZ798yv6SqezwlflkYw
	wMZEW5d4Gg/A/pFEeIFUd05UUItkoP4/NDEZ4JoL3WzNANAS58j8ZXMStEd5X+ohVt53WfjBtwV
	wByQqiXaL7bQYCnY1A0BjhYzz5wHybjgRyQz6oxc9kpC9Q8UGARylGt+GZDTyIFdIdvC17UKRXJ
	WR5UYGVjQgtq5L3yOXgSbrkmcrP4v9Rz5BxvOyowN9oslmwTcqj2nt/NXj7SZ3Xe216/iYc8EFZ
	2yB0M6vw/nAElcSSllar7Q0tiskA=
X-Google-Smtp-Source: AGHT+IE6RQsXs5XE+skG+WmQ2xFJ9F2q8hEw99DXKAIfUF2FXjootyO7fXgbuUSFEKEabi46nsHELw==
X-Received: by 2002:a05:6000:2b07:b0:3c6:fd90:e361 with SMTP id ffacd0b85a97d-3c6fd90e531mr783517f8f.10.1755921375165;
        Fri, 22 Aug 2025 20:56:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b573f3119sm22763925e9.0.2025.08.22.20.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 20:56:14 -0700 (PDT)
Message-Id: <b18544b74f3c677bfa023e8a83ed9d2682e0e30d.1755921357.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
	<pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Aug 2025 03:55:56 +0000
Subject: [PATCH v3 15/15] xdiff: implement xdl_trim_ends() in Rust
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
Cc: Elijah Newren <newren@gmail.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Taylor Blau <me@ttaylorr.com>,
    Christian Brabandt <cb@256bit.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Eli Schwartz <eschwartz@gentoo.org>,
    "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
    Patrick Steinhardt <ps@pks.im>,
    Sam James <sam@gentoo.org>,
    Collin Funk <collin.funk1@gmail.com>,
    Mike Hommey <mh@glandium.org>,
    Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Replace the C implementation of xdl_trim_ends() with a Rust
implementation.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 rust/xdiff/src/lib.rs      | 14 ++++++++++++++
 rust/xdiff/src/xprepare.rs | 27 +++++++++++++++++++++++++++
 rust/xdiff/src/xtypes.rs   | 19 +++++++++++++++++++
 xdiff/xprepare.c           | 28 +---------------------------
 4 files changed, 61 insertions(+), 27 deletions(-)
 create mode 100644 rust/xdiff/src/xprepare.rs
 create mode 100644 rust/xdiff/src/xtypes.rs

diff --git a/rust/xdiff/src/lib.rs b/rust/xdiff/src/lib.rs
index 8b137891791f..4cc05a7e6b4b 100644
--- a/rust/xdiff/src/lib.rs
+++ b/rust/xdiff/src/lib.rs
@@ -1 +1,15 @@
+pub mod xprepare;
+pub mod xtypes;
 
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
index 000000000000..f64f60c09965
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
index 000000000000..3d1ce9742f28
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
index 93370f1c6db4..2c7480875f9f 100644
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
