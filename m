Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F022248A8
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 20:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752784356; cv=none; b=mghyNTzcIx2TlXz7K9pt4eqoWlVdQvW6AjmXCN1vFueUXh5nvnGfjglmazEGij4xxQQaf98MBek/DVVmnTZ9rB1tT9tqu1unfMkdTiAbPVjz5C1+Sv9FzzBBiysNlSZzeVzwtPD2FNPddAvJrmKy+UqTOle/Y0zJZwAapvAoiUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752784356; c=relaxed/simple;
	bh=uTU5+hAsQDkoWxqKtEoOHknR88iU9yykCHL7fo+yT3I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=MruMjrr3Q8i51MXiV5YpKgE5f/Nf83mMBVmtV7bwheIRxMTUF8Us7Ts681xUNpDkvuP29iZwKfrv/LgsCXGXBJzKtp9Y3qyHPbQrO64g+iVVh3bp6CjVOT6CH1U5Ag+HNbx6KiB8LnzkZRoFtk36r6911Fy6N2/Ydjn5pnf0n98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZ+rd6wq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZ+rd6wq"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45555e3317aso8823515e9.3
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 13:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752784352; x=1753389152; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOdc4C736d02F70Sx8SAghT6aXqnOP07gaKueMvNx3o=;
        b=CZ+rd6wqipqHqgTftDcNSicVlnxBlXUOxggzjdQcBwQQMIXnalO2f8DhlwoFCOqoY6
         aPkxZBO8JKgXcHxh+bNKZYc8LWtbTpIOtmc3m7gg1Q8b+PI/H/lEYigpzlXP3DHLyg+g
         yx/G60C2zC/soHyv7Qiwj9qG/OMZskJJV9NB/xTfO86bSZUiqa+kICGp5VWwJ+t2YOoQ
         SL4ShUkgwqrAf6GUG9fWN+5/sg+RjrKPR8cwpSHqZcPMiM1t5H/D2LUoodvnv4zrtnCN
         OrcSUGB3/U5ErpfjmFxwqNLJOYDzgNoVmM6jRjWhxwPUISQ3UziccMFxtJJ7kbZ2Xtrp
         nV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752784352; x=1753389152;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOdc4C736d02F70Sx8SAghT6aXqnOP07gaKueMvNx3o=;
        b=SIAq5+UJbhuBokv6zIoGP0FOYpTyBbPlDgg7dJkwK1gAnWcvMMzQ9WjMkCdEZ+1KA7
         x/5bdWGq0/D53zhIY+1yoODKYk4Xw8c/ID4+S+aaVSkFJU1JvbHtu/uUiFDZ+BoTti8Z
         XoX6DifBWWFxH2yBDO3obCj70d5EeK8w+BWkZ95xw346CxFEdIgZ1Wb5ZqTRVsd3JFPH
         FY6Rw7UDu2nTJihNW7TUnZ+j8xOjQr1bVtxQrHPYcpWJEtY/6SUFRPeJXxNNKc6oLNGx
         2fGT+kSSxupVWlKWyNrPWmSoJHiPbQoZZ++J70GMNT9oXpK8uDYYqqOnAf1fgL3VI4QY
         ETDw==
X-Gm-Message-State: AOJu0Ywg2wNuX3Fatey6wAHQMKis5LgOerWrbvr8xlS5Xhsr1UdNjpdc
	tYNPudnZsMLpFmj0A29fcb5qLZ8NdRIvZOIr35jkXESGQ+bClvqLvPVGaF11lg==
X-Gm-Gg: ASbGncszURNZwE6FTbNwytGW/y0zeUZ3biWj9ysfVCD7ZtW1CsTAUdisPfQRj1awR9G
	NMWaXVnU8B5T9k8yWrT4BHujS0KuWIawYJTkvXfUMvN3WeEWmWgr+LzyfXchPvPsK9pmwLb55xz
	avdISZtk0SbK+zSX2vr5o3gA2DKEz8chNBFN2FcCrXkm+YrmNLC/NGHZM0sRDgrR3G8TsZRdpH6
	ZZggnTd2oJZ2En21bk0H3bgX9fTEoOkCO3pXyTfiDQOF7wDB0vWJ/p1zj60Xa+HE12wPwy4/l3i
	pbvjr5jQzA4Qs5zKFosUYWDDLzowrqEEOgBfcsq2xrW9ThjaGK198GhIKG33kNTbJihx3Qe5BBd
	Vv4JIb+YQhm7xOLBh5wP8fMg=
X-Google-Smtp-Source: AGHT+IET4xCcEGmkLwAQWJ3HQFuHWYHQGKK8nDOW1yvBQ3pggx5nqRBWEWmOIZA/M5bAnFsKlDTckw==
X-Received: by 2002:a05:600c:1ca2:b0:455:f6cd:8703 with SMTP id 5b1f17b1804b1-4562e39b29bmr95981085e9.31.1752784352191;
        Thu, 17 Jul 2025 13:32:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e8018a4sm60478325e9.9.2025.07.17.13.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 13:32:31 -0700 (PDT)
Message-Id: <5a959c9bdad79cf972b95dcf4324135dd7c94dac.1752784344.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Jul 2025 20:32:23 +0000
Subject: [PATCH 6/7] xdiff: conditionally use Rust's implementation of xxhash
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

When no whitespace flags are present use xxhash, for faster
hashing, otherwise use DJB2a (which is what xdiff has been
using all along).

The benchmark below compares my series with version v2.49.0
(built in build_release/ and build_v2.49.0/ respectively),
running log commands on linux kernel with 3 different machines.

$ BASE=/path/to/git/root

    // laptop
    // CPU: 6-core Intel Core i7-8750H (-MT MCP-) speed/min/max: 726/800/4100 MHz
    $ hyperfine --warmup 3 -L exe $BASE/build_release/git,$BASE/build_v2.49.0/git '{exe} log --oneline --shortstat v6.8..v6.9 >/dev/null'
    Benchmark 1: /home/ezekiel/development/work/git/build_release/git log --oneline --shortstat v6.8..v6.9 >/dev/null
      Time (mean ± σ):     10.419 s ±  0.166 s    [User: 10.097 s, System: 0.284 s]
      Range (min … max):   10.215 s … 10.680 s    10 runs

    Benchmark 2: /home/ezekiel/development/work/git/build_v2.49.0/git log --oneline --shortstat v6.8..v6.9 >/dev/null
      Time (mean ± σ):     10.980 s ±  0.137 s    [User: 10.633 s, System: 0.308 s]
      Range (min … max):   10.791 s … 11.178 s    10 runs

    Summary
      /home/ezekiel/development/work/git/build_release/git log --oneline --shortstat v6.8..v6.9 >/dev/null ran
        1.05 ± 0.02 times faster than /home/ezekiel/development/work/git/build_v2.49.0/git log --oneline --shortstat v6.8..v6.9 >/dev/null

    // desktop
    // CPU: 8-core Intel Core i7-9700 (-MCP-) speed/min/max: 800/800/4700 MHz
    $ hyperfine --warmup 3 -L exe $BASE/build_release/git,$BASE/build_v2.49.0/git '{exe} log --oneline --shortstat v6.8..v6.9 >/dev/null'
    Benchmark 1: /home/steamuser/dev/git/build_release/git log --oneline --shortstat v6.8..v6.9 >/dev/null
      Time (mean ± σ):      6.823 s ±  0.020 s    [User: 6.624 s, System: 0.180 s]
      Range (min … max):    6.801 s …  6.858 s    10 runs

    Benchmark 2: /home/steamuser/dev/git/build_v2.49.0/git log --oneline --shortstat v6.8..v6.9 >/dev/null
      Time (mean ± σ):      8.151 s ±  0.024 s    [User: 7.928 s, System: 0.198 s]
      Range (min … max):    8.105 s …  8.184 s    10 runs

    Summary
      /home/steamuser/dev/git/build_release/git log --oneline --shortstat v6.8..v6.9 >/dev/null ran
        1.19 ± 0.01 times faster than /home/steamuser/dev/git/build_v2.49.0/git log --oneline --shortstat v6.8..v6.9 >/dev/null

    // router
    // CPU: dual core Intel Celeron 3965U (-MCP-) speed/min/max: 1300/400/2200 MHz
    $ hyperfine --warmup 3 -L exe $BASE/build_release/git,$BASE/build_v2.49.0/git '{exe} log --oneline --shortstat v6.8..v6.9 >/dev/null'
    Benchmark 1: /home/metal/dev/git/build_release/git log --oneline --shortstat v6.8..v6.9 >/dev/null
      Time (mean ± σ):     21.209 s ±  0.054 s    [User: 20.341 s, System: 0.605 s]
      Range (min … max):   21.135 s … 21.309 s    10 runs

    Benchmark 2: /home/metal/dev/git/build_v2.49.0/git log --oneline --shortstat v6.8..v6.9 >/dev/null
      Time (mean ± σ):     23.683 s ±  0.060 s    [User: 22.735 s, System: 0.672 s]
      Range (min … max):   23.566 s … 23.751 s    10 runs

    Summary
      /home/metal/dev/git/build_release/git log --oneline --shortstat v6.8..v6.9 >/dev/null ran
        1.12 ± 0.00 times faster than /home/metal/dev/git/build_v2.49.0/git log --oneline --shortstat v6.8..v6.9 >/dev/null

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 rust/Cargo.lock       |  7 +++++++
 rust/xdiff/Cargo.toml |  1 +
 rust/xdiff/src/lib.rs |  7 +++++++
 xdiff/xprepare.c      | 19 +++++++++++++++++--
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index fb1eac690b39..5f84617b1049 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -11,4 +11,11 @@ name = "xdiff"
 version = "0.1.0"
 dependencies = [
  "interop",
+ "xxhash-rust",
 ]
+
+[[package]]
+name = "xxhash-rust"
+version = "0.8.15"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "fdd20c5420375476fbd4394763288da7eb0cc0b8c11deed431a91562af7335d3"
diff --git a/rust/xdiff/Cargo.toml b/rust/xdiff/Cargo.toml
index eb7966aada64..1516e829db18 100644
--- a/rust/xdiff/Cargo.toml
+++ b/rust/xdiff/Cargo.toml
@@ -13,3 +13,4 @@ crate-type = ["staticlib", "rlib"]
 
 [dependencies]
 interop = { path = "../interop" }
+xxhash-rust = { version = "0.8.15", features = ["xxh3"] }
diff --git a/rust/xdiff/src/lib.rs b/rust/xdiff/src/lib.rs
index e69de29bb2d1..96975975a1ba 100644
--- a/rust/xdiff/src/lib.rs
+++ b/rust/xdiff/src/lib.rs
@@ -0,0 +1,7 @@
+
+
+#[no_mangle]
+unsafe extern "C" fn xxh3_64(ptr: *const u8, size: usize) -> u64 {
+    let slice = std::slice::from_raw_parts(ptr, size);
+    xxhash_rust::xxh3::xxh3_64(slice)
+}
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index c44005e9bbb8..5a2e52f102cf 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -160,6 +160,9 @@ static void xdl_parse_lines(mmfile_t *mf, long narec, xdfile_t *xdf) {
 }
 
 
+extern u64 xxh3_64(u8 const* ptr, usize size);
+
+
 static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
 			   xdlclassifier_t *cf, xdfile_t *xdf) {
 	unsigned long *ha;
@@ -175,14 +178,26 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 
 	xdl_parse_lines(mf, narec, xdf);
 
+	if ((xpp->flags & XDF_WHITESPACE_FLAGS) == 0) {
+		for (usize i = 0; i < (usize) xdf->nrec; i++) {
+			xrecord_t *rec = xdf->recs[i];
+			rec->ha = xxh3_64(rec->ptr, rec->size);
+		}
+	} else {
+		for (usize i = 0; i < (usize) xdf->nrec; i++) {
+			xrecord_t *rec = xdf->recs[i];
+			char const* dump = (char const*) rec->ptr;
+			rec->ha = xdl_hash_record(&dump, (char const*) (rec->ptr + rec->size), xpp->flags);
+		}
+	}
+
 	for (usize i = 0; i < (usize) xdf->nrec; i++) {
 		xrecord_t *rec = xdf->recs[i];
-		char const* dump = (char const*) rec->ptr;
-		rec->ha = xdl_hash_record(&dump, (char const*) (rec->ptr + rec->size), xpp->flags);
 		xdl_classify_record(pass, cf, rec);
 	}
 
 
+
 	if (!XDL_CALLOC_ARRAY(rchg, xdf->nrec + 2))
 		goto abort;
 
-- 
gitgitgadget

