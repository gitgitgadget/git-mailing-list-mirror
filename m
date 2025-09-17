Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A81226D0F
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 01:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071818; cv=none; b=IQnUWeFOzgmsNgT5Ba5nKQDDKrdetPqaZD0tnU2seao1y4lW+znyVqZyNgENqzcXz2Nvepjet2k9YqvZdcjwoySqLfzCyvZm/FZ7chl6+W/dx49C960G1UQvBp6gQg56kTwEc0ho/E0L8quDCZaObIfJK5wznFjMEJ/w2s3Af/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071818; c=relaxed/simple;
	bh=/yYJtrfQRBW0ThExxTuPOUsapRaARG+iQw12Shp6BCY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=F70GywnjKPZAkiCVaJyrdN7cE2XNsGnHBqiyCIkRGMqQvu9YzpA5uOzzFzOLupVGmuvO5jHhBwg+0CZYuocKk+QSokgfK3M6yEezFqrhv4i4erdA3ula9f1X2C7LfhEFvaVkRYbslsaIngF1Ud9Dr1xdmM8EPHlD78Kpr/aSujE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W02hwjlh; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W02hwjlh"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b5488c409d1so4042905a12.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 18:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758071816; x=1758676616; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqoJ4o5o4cFLE+APXvUV+O2Yf+8Y878kB3OaxNLM5nc=;
        b=W02hwjlhhF9Syf7twQqhLwE4PglJhzPgbjQG5gn5WxZlEFcTya0BwzCp6uBiZbp9cn
         HyXWlPaBt9OjDHma0hux6XhTGkSnqILmgZoE+/CsMn8js4+MTB3s6GbccZnpTmk7dnEt
         1AntCoip+F7WJssRtNBvrXP9lIlI+sUVigKi5ZWUGRwrlVp0Y2kQ5DiJfk+qdyoWRZeo
         3g8UrQ5CSs+Z9Yvf3LMDdSmnNudzMSNUXFOdoL3TR9BzPpyFI2riPeG+59LC0SQSOu8l
         YihME8BdW8oZ5Jl7g/f8yhRMZ0GBGVSwh9qSVdJuATjyvaprOi+DicpuSGWf8ZeYxmw4
         oiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758071816; x=1758676616;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqoJ4o5o4cFLE+APXvUV+O2Yf+8Y878kB3OaxNLM5nc=;
        b=xC+2meJuaLTTazYwR0P2uiQCCBWkDVN0qhq1UwmyY2J38FNrddKKc7Yet0af/lyBBB
         7r9U0bs3xm8EgmMVZMoNz437xjMmwSka95CBs9p9HwxHke3C9t1yqj3n5aIzlIgNLNKx
         478YwL0UUuuy1FAtPdcFrGT6OOccmIjDEdxaQ7poB2LeJiPWE74yq2XmxjzqmA5NDjBZ
         8SRRCgQNx8WC2+fQeQM+pm003U5SPLYcWic5b4eyNC+H4QTUFzziIajxlhRCBJF64WM2
         TPVA7rbWgNVaD2YpJKpH29otCJEM3XIVP9k35EOvpCa5iQSJ/i3i1CJ1vxLLllB2JGUO
         tAHA==
X-Gm-Message-State: AOJu0Yxu/gev5/eJdonMj7NBC6ufwro/VgCXxVzkXcRhiuhEwlZeSdrw
	H4a8BJHPLQMVJlunTxwm7fMnUx+4IOHRHEfI8KNWGskfCYb4tVBuP9XYi10UzQ==
X-Gm-Gg: ASbGncs2i9iBkCW3ERsk25mH4OSg8bT85U7LTlDZ/h8UZ4dOCPb1QFuAdyEfwrP2Wyn
	SEQ0746JXS98qCVBWqXjNxVLddMG7KuFszHP5aMPyzF1lf108YHV9pRPF6lo4SuBGditBN56WtG
	qkNAp0elYanHJzxLqmGO/kucRbirxAKnCfXLJn0Ub1/pCYxPhyj9j06/kOtuYI7a8xtUEvaUdoH
	ADLy4FK5JRPzt9rhVbzvSqBrVTkbgpYby6iCRWalxhgmiNMNVjWxX0irEJ+V1xUqNTDPzbNv9C5
	cLeU04fAvNoMSezG//VePcYlbQRvBv6ZCgNUE2sj5nCNOios9hELA1TwzJr4aHeF2dqfkzwcH1G
	a48557G+vLE1O2koUfWnpWHwM5xU=
X-Google-Smtp-Source: AGHT+IFcISecjxQwHuUIy03RSsHmo+gNZxxQMcPS83fFgcR7fdw/lPLTJT85uGaKBemvLliw/bWnTw==
X-Received: by 2002:a17:903:13d0:b0:254:2cd9:9c04 with SMTP id d9443c01a7336-26811ba49b5mr4594085ad.16.1758071816349;
        Tue, 16 Sep 2025 18:16:56 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267d8666b1esm28447925ad.110.2025.09.16.18.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 18:16:55 -0700 (PDT)
Message-Id: <6a27e07e6310b6cad0e3feae817269b9b8eaed69.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Sep 2025 01:16:33 +0000
Subject: [PATCH v2 13/18] build-helper: link against libgit.a and any other
 required C libraries
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

Don't link against the C libraries when building with Make or Meson.
Run cargo tests like this:
cd rust && cargo clean && USE_LINKING=true cargo test

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 rust/build-helper/Cargo.toml |  1 -
 rust/build-helper/src/lib.rs | 84 ++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/rust/build-helper/Cargo.toml b/rust/build-helper/Cargo.toml
index 4455fff5ce..8939b4b876 100644
--- a/rust/build-helper/Cargo.toml
+++ b/rust/build-helper/Cargo.toml
@@ -4,4 +4,3 @@ version = "0.1.0"
 edition = "2021"
 
 [dependencies]
-
diff --git a/rust/build-helper/src/lib.rs b/rust/build-helper/src/lib.rs
index e69de29bb2..70e95d16f5 100644
--- a/rust/build-helper/src/lib.rs
+++ b/rust/build-helper/src/lib.rs
@@ -0,0 +1,84 @@
+use std::collections::HashMap;
+use std::path::PathBuf;
+
+
+fn parse_bool_from_str(value: &str) -> bool {
+    match value {
+        "1" | "true"  | "yes" | "on"  => true,
+        "0" | "false" | "no"  | "off" => false,
+        _ => false
+    }
+}
+
+fn parse_bool_from_option(value: Option<&String>, default: bool) -> bool {
+    match value {
+        Some(v) => {
+            parse_bool_from_str(v.as_str())
+        },
+        None => default,
+    }
+}
+
+/// To build without linking against C libraries run `USE_LINKING=false cargo build`
+/// To run tests set GIT_BUILD_DIR and run `USE_LINKING=true cargo test`
+pub struct BuildHelper {
+    crate_env: HashMap<String, String>,
+}
+
+
+impl BuildHelper {
+    pub fn new(crate_env: HashMap<String, String>) -> Self {
+        let it = Self {crate_env};
+
+        let dir_crate = it.dir_crate();
+        let dir_workspace = dir_crate.parent().unwrap();
+        let dir_git = dir_workspace.parent().unwrap();
+        let dir_interop = dir_git.join("interop");
+        if !dir_interop.exists() {
+            std::fs::create_dir(dir_interop.clone()).unwrap();
+        }
+
+        it
+    }
+
+    pub fn crate_name(&self) -> String {
+        self.crate_env["CARGO_PKG_NAME"].clone()
+    }
+
+    pub fn dir_crate(&self) -> PathBuf {
+        PathBuf::from(self.crate_env["CARGO_MANIFEST_DIR"].clone())
+    }
+
+    pub fn build(self) {
+        let use_linking = parse_bool_from_option(self.crate_env.get("USE_LINKING"), self.crate_env.get("CARGO_TARGET_DIR").is_none());
+        let dir_crate = self.dir_crate();
+        let dir_git = dir_crate.parent().unwrap().parent().unwrap();
+
+        println!("cargo:rerun-if-changed={}", dir_git.display());
+
+        if use_linking {
+            if let Some(git_build_dir) = self.crate_env.get("GIT_BUILD_DIR") {
+                let mut path_git_build_dir = PathBuf::from(git_build_dir);
+                path_git_build_dir = path_git_build_dir.canonicalize().unwrap();
+                if !path_git_build_dir.is_dir() {
+                    panic!("'GIT_BUILD_DIR' is not a directory: {}", path_git_build_dir.display());
+                }
+                println!("cargo:rustc-link-search=native={}", git_build_dir);
+            } else {
+                panic!("environment variable 'GIT_BUILD_DIR' is not set");
+            }
+
+            println!("cargo:rustc-link-lib=static=git");
+            println!("cargo:rustc-link-lib=pcre2-8");
+            if self.crate_env.get("ZLIB_NG").is_some() {
+                println!("cargo:rustc-link-lib=z-ng");
+            } else {
+                println!("cargo:rustc-link-lib=z");
+            }
+        } else {
+            println!("cargo:warning={} is not linking against C objects, `USE_LINKING=true cargo test`", self.crate_env["CARGO_PKG_NAME"]);
+        }
+    }
+}
+
+
-- 
gitgitgadget

