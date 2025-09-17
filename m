Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2D8227E82
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 01:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071821; cv=none; b=mhE9wD8frGGLkHEZkE42iDvPgMe+guQuavAHGLFpQCJzkpkAyT3VACpiWhUOEdXUMGxqRXL1tTji7hAvpI8eVWkV1ftX9ncBKPgr0svRxz56sCrxZblv8Z2q5xpuf7j7QLjMeveOcVTf35D2y702oq/0bX4NJXIccT3JMbnsy0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071821; c=relaxed/simple;
	bh=bk66ckkJnactczDTXp042WrWXXQFiPWab9Y/tDc6AFs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WiUmqY+gFWYbhCmu9Oft5s7OoX53F4vefzCif4cwSZyVv0j+kVFibP7IoDFaJjIPxsc29enEy1Gouv23onAOBhT0yJUiVZSWwBRrUsShwLW2r90P3DhZd7fJN6HFRaPCcMRT5RZ6QGvzjXZsNlGvxr3oQDxazWo+nAd+IS7Dl0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ek8ctkU+; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ek8ctkU+"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so1186582a91.0
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 18:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758071818; x=1758676618; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y97JB+bcwwktcDOnhtlCLrdCt7DEuwLCcQQaBr9uE3A=;
        b=Ek8ctkU+U/zmeJjHrof4QfocOmYCD81cUz36GMTJgeTWGjQFzRnwzX330Vl4G98WKF
         6uv/RfdXd2StZfZfmOkn7XEBMg7pGezJRI6rWGVp5LIY4crhWOzrQfoM7UI0rzj8UyU3
         CRHq7D0U3dBIueOp2WJ3D27/CEQGNHtfpxtzfnnT3+d1oca8ePSj6IO1yOgAaO4OIYti
         ikW11RS4QF+WtqYg/4QCjqBPaym6k0XV9NEWTDDs5nRFCYtWjZU1/WALO1SNqgF4UDZF
         PLiHXpP2NMHfyS4gLl4LP/GVPWDs2gdXB3uJ8ASI/L+CPyJcpHRk9g+JeDqAr+ZPwSLa
         rc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758071818; x=1758676618;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y97JB+bcwwktcDOnhtlCLrdCt7DEuwLCcQQaBr9uE3A=;
        b=FWfooyP8cM7rc9GiXAt98Zgnyq9tXDQTLrGUhX/vCkJwcZ1b2DMcW4qfQwLyT8HihX
         sYnzxamtX0O1fhaX/MgD+aeUmgSbbK1supbOdH5YZoZf4c2+cmkZ2Q5bt21mOAG0ARvp
         Awc3MKi1mQRF0++2ZI2y2XZFy0+7uRH1Vs/JNcYO5Ejjp3IWw6NaXw9XlxuYuqajRWLe
         J91viYqaAE4T2KtPYiFG0r0kw6COuvo5TvNoAMoFhQ2OWV88EUmNpsOt6SSmInQ1B1V8
         Pw2ovfnCiCaocRtgRM4RcYaTTZsrdmJRS/KUuaSP6DYt/jwrmzRzhODhWGeALBvOfVv+
         5zbQ==
X-Gm-Message-State: AOJu0YxOcqq04e58QODq7WF5v5hsRRupYJAIBxF1mRLPdlpDkWIVb/WY
	OidBDsSomv98hsmHH5XW0PGShskVkw8bIMTLsPeFGI/Tbr0syXvQF5Oruscs3g==
X-Gm-Gg: ASbGncs2BJHZ+7qpNAcL6q1zAxPjoNROhKHTboHI+8PMqrTSJTnj/d4yk0HEtrRLaEo
	a8hd7g33IGWvxOfRAztpa2c+nKKUAD28f/22O89LLenywYtUp9h3IvavFQ7zE38H2FVc95vb3Iv
	xjzBMdfQ3AxWsyCTrYfianyQwzV6o/YZSkE/V/vdSsLy2YqamjuMGYcHqmm0hGNU8WmJdNfp7iD
	HIy8Gokpmw0BkopPrlmv19Zj690AQcwc1yPFoaSHxNmBmg43dfrVMFx/vfNVNfgSg3ZbItZllZW
	ZDH4W7hrwj1vRXu6DRsbiKDJvwK1bbHZ2neE+PG/VYUVUiM//clQ+R7ChbJVdwbn2GytegGFh1j
	jEFvSR7yuAmTF3VQcEqvhTOPYvuI=
X-Google-Smtp-Source: AGHT+IHRLq+u8t3FMTSZmoryqMFUfVryo/SfZvvtNH60gWuWWKjCEleMlIxWIvDcVZxdNCB6IYRFdg==
X-Received: by 2002:a17:90b:3b43:b0:32e:2798:9064 with SMTP id 98e67ed59e1d1-32ee3f53712mr418599a91.35.1758071817617;
        Tue, 16 Sep 2025 18:16:57 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760793be05sm17055966b3a.1.2025.09.16.18.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 18:16:57 -0700 (PDT)
Message-Id: <fa334405686a329dd1508bf8d8cbfa12dc5dc7bb.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Sep 2025 01:16:34 +0000
Subject: [PATCH v2 14/18] build-helper: cbindgen, let crates generate a header
 file
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
 rust/build-helper/Cargo.toml |  5 ++++
 rust/build-helper/src/lib.rs | 44 +++++++++++++++++++++++++++++++++++-
 rust/cbindgen-template.toml  | 16 +++++++++++++
 3 files changed, 64 insertions(+), 1 deletion(-)
 create mode 100644 rust/cbindgen-template.toml

diff --git a/rust/build-helper/Cargo.toml b/rust/build-helper/Cargo.toml
index 8939b4b876..2e42bb5405 100644
--- a/rust/build-helper/Cargo.toml
+++ b/rust/build-helper/Cargo.toml
@@ -4,3 +4,8 @@ version = "0.1.0"
 edition = "2021"
 
 [dependencies]
+cbindgen = "0.24.0"
+textwrap = "=0.16.1"
+once_cell = "=1.20.3"
+unicode-width = "=0.1.13"
+
diff --git a/rust/build-helper/src/lib.rs b/rust/build-helper/src/lib.rs
index 70e95d16f5..640bc19734 100644
--- a/rust/build-helper/src/lib.rs
+++ b/rust/build-helper/src/lib.rs
@@ -1,5 +1,7 @@
 use std::collections::HashMap;
+use std::io::Write;
 use std::path::PathBuf;
+use cbindgen::Config;
 
 
 fn parse_bool_from_str(value: &str) -> bool {
@@ -23,12 +25,20 @@ fn parse_bool_from_option(value: Option<&String>, default: bool) -> bool {
 /// To run tests set GIT_BUILD_DIR and run `USE_LINKING=true cargo test`
 pub struct BuildHelper {
     crate_env: HashMap<String, String>,
+    generate_header: bool,
+    file_out: PathBuf,
+    config: Config,
 }
 
 
 impl BuildHelper {
     pub fn new(crate_env: HashMap<String, String>) -> Self {
-        let it = Self {crate_env};
+        let mut it = Self {
+            crate_env,
+            generate_header: false,
+            file_out: PathBuf::default(),
+            config: Config::default(),
+        };
 
         let dir_crate = it.dir_crate();
         let dir_workspace = dir_crate.parent().unwrap();
@@ -38,6 +48,12 @@ impl BuildHelper {
             std::fs::create_dir(dir_interop.clone()).unwrap();
         }
 
+        let file_cbindgen = dir_workspace.join("cbindgen-template.toml");
+        it.file_out = dir_interop.join(format!("{}.h", it.crate_name()));
+
+        it.config = Config::from_file(file_cbindgen.display().to_string().as_str()).unwrap();
+        it.config.include_guard = Some(format!("{}_H", it.crate_name().to_uppercase()));
+
         it
     }
 
@@ -49,6 +65,16 @@ impl BuildHelper {
         PathBuf::from(self.crate_env["CARGO_MANIFEST_DIR"].clone())
     }
 
+    pub fn generate_header<F>(mut self, editor: F) -> Self
+    where
+        F: Fn(&mut Config)
+    {
+        self.generate_header = true;
+        editor(&mut self.config);
+
+        self
+    }
+
     pub fn build(self) {
         let use_linking = parse_bool_from_option(self.crate_env.get("USE_LINKING"), self.crate_env.get("CARGO_TARGET_DIR").is_none());
         let dir_crate = self.dir_crate();
@@ -78,6 +104,22 @@ impl BuildHelper {
         } else {
             println!("cargo:warning={} is not linking against C objects, `USE_LINKING=true cargo test`", self.crate_env["CARGO_PKG_NAME"]);
         }
+
+        if self.generate_header {
+            let mut buffer = Vec::<u8>::new();
+            cbindgen::Builder::new()
+                .with_crate(dir_crate.clone())
+                .with_config(self.config)
+                .with_std_types(true)
+                .generate()
+                .expect("Unable to generate bindings")
+                .write(&mut buffer);
+
+            let mut fd = std::fs::File::create(self.file_out).unwrap();
+            fd.write(buffer.as_slice()).unwrap();
+        } else {
+            let _ = std::fs::remove_file(self.file_out);
+        }
     }
 }
 
diff --git a/rust/cbindgen-template.toml b/rust/cbindgen-template.toml
new file mode 100644
index 0000000000..cab83218d0
--- /dev/null
+++ b/rust/cbindgen-template.toml
@@ -0,0 +1,16 @@
+## compat/posix.h includes stdbool.h where git-compat-util.h does not
+## this is mandatory for correct bool C <-> Rust interop. Though the
+## 'includes' (and all other variables in this file) can be
+## overridden in build.rs.
+sys_includes = ["compat/posix.h"]
+
+autogen_warning = "/* Warning, this file is autogenerated by cbindgen. Don't modify this manually. */"
+
+language = "C"
+no_includes = true
+usize_is_size_t = true
+style = "tag"
+tab_width = 4
+
+[parse]
+parse_deps = false
-- 
gitgitgadget

