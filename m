Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81352C324E
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 01:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764205850; cv=none; b=cnWfGXlnUUOJfQEJrQGeCet+bnTVgigLw09jWevT+azld/LAdxfy6E3WI0B2ymth5fTd4VJGtBA7cBHp4WAChFSOYPK8lHWaL2FCM4nKggAtu2w6Gm9xWTOeD6eUNfg9b6+VGX/0+3TW/RNevk/OJO7DYYnLkz0Ph3hpsZV2elo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764205850; c=relaxed/simple;
	bh=7ovZ9GtRtJaylVsihELbg2WiizTEEcQN/yTetHqfSN8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nARWaBGgZr3bcBev2iwzbyNaPkW7v9vUoAzHZIoUJLy0Z2wG81Ct3nhC+7jCgRTgtZezvORHC07emcqdwkpgi/X9/IA0ebsTGY1yh3jp/qpjLKEL/qw/GUwllbP3EacWchdP7xWNB3TI3n/IS+xjV8DUBbsfkn6CM/AbybwFtow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ee/BMROg; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ee/BMROg"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-948673fdc47so14465339f.3
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 17:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764205847; x=1764810647; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axWyVq6HVgxk1DIW0STGLI6px9v2dXr68h1DAteb7fU=;
        b=ee/BMROgS406RMUhXv1XqkIdwSMG+Ozdzik76Upw0QOZaGrQ2bCYeHLDufcXn/ADj1
         6yAFiiq4aqiCNxh7rkKT2tlyZKagExvk+fKJBdrrhY22WUh1BcWP6Kspuh75bGBnosWJ
         pmeW+24BroqEzuyUEjPt68v7Vn4yKF0l9tbjrLNBu8PxDgLE6b+/iHk6d2QdSEjl2V7n
         o7MepHXi9pjsBWkgTq/amQD+PUYClvPs3lrbwOLr+oizngZ+UpT7xflxe2P74GBDLdya
         WDjBmF490Vdx7tf/ZhHV0toA8c1cHU7njNosVMdqKE0jQU38VcDwmkX476B11ueK8Os2
         vC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764205847; x=1764810647;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=axWyVq6HVgxk1DIW0STGLI6px9v2dXr68h1DAteb7fU=;
        b=P1xYphkjefOqG8hDFtHa7tSqngXYaFUQkcKB8cbzdp5sdmjYU6fMITriQk3flWNnkT
         gmVU3uBiEwA/VS07rele+sk3M6oYgRHPjJHQrShjxa5CaC1pSjouRoWH4EpEiDrwt6E9
         j0Hg9SNrsf02FdgZAf8VKoOBw16aP/ABCk4hlOP4Sb0natWhhjzLE0gD62CIaOLlrFqG
         vQMCb78kYeLV1jfr3UBIbbU4jmL5uXzxCS4xnaN9kEfD2mIZdAddpUVQgofpYYwcpdYM
         X/840pPKCAT+cznFNIKdKjqDClZV242DySRYcOx8ZaRhiL6ClZXO58qEbv6AB5ubSwuN
         Iesw==
X-Gm-Message-State: AOJu0YxarJf9DyNyUehNvca5Aap2MDef3dBmr4jqWLi7POoL+4KT2U5k
	dH2jgyfVFEN9+0VzHcjLJCwk5EHx0maXIghpHr/aYtgUWTrpRaLqplS4RU1D9K0N
X-Gm-Gg: ASbGnctcUICItKFNO0sWxo5Cqy1Pm2Y+RzZXsHXB4MedLHKblsXnkwJcaNLJ1ichB48
	rqxt1R13eZRco69P6ckHe4p1eByl+ndMMqd64IqTZ8t/JOd2XqQQmj31wJcpatYCL0+eYgVKu0m
	TBj0ntAjokJ0KlnkMA2Sx6/WuS8kKh26wr+JrnZ34bynnt6qvNSVlaRaMCTpG+oXeF/r1PKDfq6
	mvmGtizUt/E5S2+Y28HaQKvfnuCuFiB5zUk0udWX38tXZ+m038HE2nXy+C/4zCJIUMSd308LQg0
	R7VXHjEN7W1ysuhBmSZlkztjAX9DTH5Yw9kx3itV9mBPv4VfSXbdIlC4yw8CCBqVeUiLUfx6nYR
	QEgx8Vii63ipCdUjjZK46n3lz8dST7L/lRZtcyrFHQs7FY+8Cbef9rLKg+u5R9ZxG0aWs4nUTye
	pn7bmq4ZqT9oWLrw==
X-Google-Smtp-Source: AGHT+IH6IMpaIrnewaRHpU2V2JqJ//f/L1o2ScVI/E5NQJ4LfCGBqcWGzW6yI+WJqwjP8XMRpDkjYg==
X-Received: by 2002:a05:6638:1448:b0:5b7:c786:c100 with SMTP id 8926c6da1cb9f-5b967889da5mr17486659173.0.1764205847441;
        Wed, 26 Nov 2025 17:10:47 -0800 (PST)
Received: from [127.0.0.1] ([64.236.141.183])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954a0deb0sm8824841173.9.2025.11.26.17.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 17:10:46 -0800 (PST)
Message-Id: <e51a78cfb5dd6d34948dc26d21513450469c6790.1764205835.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
References: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Nov 2025 01:10:29 +0000
Subject: [PATCH 07/13] cargo: create crate link-with-c
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

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 rust/link-with-c/Cargo.toml |  9 +++++
 rust/link-with-c/src/lib.rs | 77 +++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 rust/link-with-c/Cargo.toml
 create mode 100644 rust/link-with-c/src/lib.rs

diff --git a/rust/link-with-c/Cargo.toml b/rust/link-with-c/Cargo.toml
new file mode 100644
index 0000000000..adb38fdc9c
--- /dev/null
+++ b/rust/link-with-c/Cargo.toml
@@ -0,0 +1,9 @@
+[package]
+name = "link-with-c"
+version = "0.1.0"
+edition = "2018"
+
+[lib]
+crate-type = ["staticlib", "rlib"]
+
+[dependencies]
diff --git a/rust/link-with-c/src/lib.rs b/rust/link-with-c/src/lib.rs
new file mode 100644
index 0000000000..f6faaf774d
--- /dev/null
+++ b/rust/link-with-c/src/lib.rs
@@ -0,0 +1,77 @@
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
+        Self {
+            crate_env,
+        }
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
+                let path_git_build_dir = PathBuf::from(git_build_dir);
+                let is_abs = path_git_build_dir.is_absolute();
+                if !is_abs {
+                    panic!("GIT_BUILD_DIR must be an absolute path: {}'", path_git_build_dir.display());
+                }
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
-- 
gitgitgadget

