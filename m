Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1B721CC51
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 03:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758945119; cv=none; b=qKss0IyNDcsiaefy7K7S6jPrjODQquO6ArIsU4q/zirLab03XizhysuQyHSSnbYbvg2wIfgpc1nC7mgM9Te8bRU+sga6IDmImIU4Y8Ijrn37IGLYDogpfObb480y723v3VeLEli9+YEssqGIqRPFMXbCzb+5AvAKm/5sEWKbBRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758945119; c=relaxed/simple;
	bh=8ivAiA+B9ijLOgDUGtaSpCWTAVDY7cgH3+acmJpvboU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pEPgz+vGLbjkkezrSI3bAHeD5E+7uBEBMQmLD14JR5H2twspSCUNVO0elkJG8IjPHwzr3i63oRedvAhd4wOlaf4CPFV+1aBAXYMYQ/Yk8Niu5CRSZ23dL2CLUW/EW/tTFrD5pgJUGQxDc1Vyxl8yRnjQ2HUUjfkV5uwDjHRx/8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3ieBe3o; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3ieBe3o"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77f343231fcso1825645b3a.3
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 20:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758945117; x=1759549917; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnNBuifnCQ4e8FQxtkj+f5WbMSps2wucvU/0/83nYJk=;
        b=d3ieBe3oGP7pAh/RZ6/crBzEyv5+wPszzcyWIoHenxWNBnGOUMlfpXrRdYQ5dNMsTF
         zOs+kDatujO1Pccur9NnRp3ttfyefZdVnL4DdY/YbgO/ilfn/MSDEM82geW8gwDq3eGC
         Fub0d2gv+vR0wnVaAd1ItyK8/szy2kEYh77YlHxZvvBfveLMMjyDdjJiu/v0+32ZtiSr
         B6PEPeZIfGks/y0StSlB1IFmfxRz8ww9QUHugZgbMLUEmiqJH3upWvVhjvSEfmDiy419
         LKpP8SdUk7AELt88MMCDMIKJkRHYYyXqu0Qik6uyKai/qtK5uKrw67oGbGkLIjVX+6Ol
         RdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758945117; x=1759549917;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnNBuifnCQ4e8FQxtkj+f5WbMSps2wucvU/0/83nYJk=;
        b=LzHDOPVFjqAH7VDkPSh5qAkP4xERq01XCuBw+7hItBzWv8K096D3AMNEtuZC5WhnU2
         0MfZwBsNZfkQddj8QP1CXamJG1udex9FCku5vUWa+yYy7g+euW+KBh1DURESaGXa2i0C
         P8QvdtmzLjP08lQTwun0ZdydvTNb6SXkP19QMeQzrGY171wDJOh1uKGv2T+5k8MH3SUf
         kH4EWY/SsaNt9R/bP5wiJloPbPmQASUcFU1kCaJhXs/mi6V0anKv5XlLjz5ebp/iuJs/
         uzR/mtAdG9uAccAj3PI+p3LBvnRJe+w8oIkr9bthNnMNDzdXWeasf4KSkhtVLhP3rE0P
         aYJw==
X-Gm-Message-State: AOJu0YwkIRXkIiHIZyhVN1hLFpwDiSOI/mampSx4QjKN3jx+mLgNE5ky
	nFkPhRwKetsgVv0g1QG85P3Dhzve9eir0JZo3+f/rxabL73M36pnunYUIKx18c2L
X-Gm-Gg: ASbGncttP3KJTtkOh0QWCw9iWsbj/vU+iO8SqatPTyrFkq8eD+5jNLQqYzsAnSTqQ93
	vud2E1Yo3q7HHOStTSgU5k4mWxDLo6koyf8M7G8JXwJDJNR3cXbEEJh30amnfL+r1RS0FdmUv/0
	h75QfmjfYlz0wadXmZkCyvzqYcNNuD8xhNwd3qGENwTzCU5Esvo+k0iLJL6sa+WmRTEugAgmp8o
	pFSVlUl/2NMC2n88pOFeu+qAXbIjjhPaTU9lYJjPzJDuVvumQDIOi2Lm0iamFtBOsotkbnSNWk9
	fJJGsnTglSTTfI9f4whfm5P0ihlfdsCGInK5cV35z+SVPwgX3hQ4RvbwYj/jy/eueaV+CTQm1Zw
	myRvzILSIc0vP/sVL+Kam41fykC95mhwQwemv
X-Google-Smtp-Source: AGHT+IFgrunvlFI1WhtAaj6PQr7zkX2wU0XAUd+Y/T67wpnVxeIBGWEIgeir+2Hanv9t5gBUflcx/Q==
X-Received: by 2002:a05:6a00:4b14:b0:781:1e91:fd8c with SMTP id d2e1a72fcca58-7811e920009mr3536660b3a.11.1758945116823;
        Fri, 26 Sep 2025 20:51:56 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.218.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023c2b29sm5786868b3a.36.2025.09.26.20.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 20:51:55 -0700 (PDT)
Message-Id: <479c263bc19aa5cdfe9d990b2521f88b1620759c.1758945111.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1977.v3.git.1758945111.gitgitgadget@gmail.com>
References: <pull.1977.v2.git.1758931659.gitgitgadget@gmail.com>
	<pull.1977.v3.git.1758945111.gitgitgadget@gmail.com>
From: "ionnss via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 27 Sep 2025 03:51:50 +0000
Subject: [PATCH v3 2/3] libgit-rs: add get_bool() method to ConfigSet
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
Cc: Chris Torek <chris.torek@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    ions <zara.leonardo@gmail.com>,
    ionnss <zara.leonardo@gmail.com>

From: ionnss <zara.leonardo@gmail.com>

Add support for parsing boolean configuration values using Git's
git_configset_get_bool() C function. This ensures consistent behavior
with Git's native boolean parsing logic.

The method handles all Git boolean formats (true/false, yes/no, on/off,
1/0) and edge cases like "00" and "100" correctly.

Includes comprehensive tests for various boolean formats and edge cases.

Signed-off-by: ionnss <zara.leonardo@gmail.com>
---
 contrib/libgit-rs/src/config.rs    | 26 ++++++++++++++++++++++++++
 contrib/libgit-rs/testdata/config3 |  2 +-
 contrib/libgit-rs/testdata/config4 |  9 +++++++++
 contrib/libgit-sys/src/lib.rs      |  6 ++++++
 4 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 contrib/libgit-rs/testdata/config4

diff --git a/contrib/libgit-rs/src/config.rs b/contrib/libgit-rs/src/config.rs
index 6bf04845c8..72ee88801b 100644
--- a/contrib/libgit-rs/src/config.rs
+++ b/contrib/libgit-rs/src/config.rs
@@ -68,6 +68,20 @@ impl ConfigSet {
             Some(owned_str)
         }
     }
+
+    /// Load the value for the given key and attempt to parse it as a boolean. Dies with a fatal error
+    /// if the value cannot be parsed. Returns None if the key is not present.
+    pub fn get_bool(&mut self, key: &str) -> Option<bool> {
+        let key = CString::new(key).expect("config key should be valid CString");
+        let mut val: c_int = 0;
+        unsafe {
+            if libgit_configset_get_bool(self.0, key.as_ptr(), &mut val as *mut c_int) != 0 {
+                return None;
+            }
+        }
+
+        Some(val != 0)
+    }
 }
 
 impl Default for ConfigSet {
@@ -95,6 +109,7 @@ mod tests {
             Path::new("testdata/config1"),
             Path::new("testdata/config2"),
             Path::new("testdata/config3"),
+            Path::new("testdata/config4"),
         ]);
         // ConfigSet retrieves correct value
         assert_eq!(cs.get_int("trace2.eventTarget"), Some(1));
@@ -102,5 +117,16 @@ mod tests {
         assert_eq!(cs.get_int("trace2.eventNesting"), Some(3));
         // ConfigSet returns None for missing key
         assert_eq!(cs.get_string("foo.bar"), None);
+        // Test boolean parsing - comprehensive tests
+        assert_eq!(cs.get_bool("test.boolTrue"), Some(true));
+        assert_eq!(cs.get_bool("test.boolFalse"), Some(false));
+        assert_eq!(cs.get_bool("test.boolYes"), Some(true));
+        assert_eq!(cs.get_bool("test.boolNo"), Some(false));
+        assert_eq!(cs.get_bool("test.boolOne"), Some(true));
+        assert_eq!(cs.get_bool("test.boolZero"), Some(false));
+        assert_eq!(cs.get_bool("test.boolZeroZero"), Some(false)); // "00" → false
+        assert_eq!(cs.get_bool("test.boolHundred"), Some(true)); // "100" → true
+        // Test missing boolean key
+        assert_eq!(cs.get_bool("missing.boolean"), None);
     }
 }
diff --git a/contrib/libgit-rs/testdata/config3 b/contrib/libgit-rs/testdata/config3
index ca7b9a7c38..3ea5b96f12 100644
--- a/contrib/libgit-rs/testdata/config3
+++ b/contrib/libgit-rs/testdata/config3
@@ -1,2 +1,2 @@
 [trace2]
-	eventNesting = 3
+	eventNesting = 3
\ No newline at end of file
diff --git a/contrib/libgit-rs/testdata/config4 b/contrib/libgit-rs/testdata/config4
new file mode 100644
index 0000000000..c0755a32be
--- /dev/null
+++ b/contrib/libgit-rs/testdata/config4
@@ -0,0 +1,9 @@
+[test]
+	boolTrue = true
+	boolFalse = false
+	boolYes = yes
+	boolNo = no
+	boolOne = 1
+	boolZero = 0
+	boolZeroZero = 00
+	boolHundred = 100
diff --git a/contrib/libgit-sys/src/lib.rs b/contrib/libgit-sys/src/lib.rs
index 4bfc650450..b104fda8f6 100644
--- a/contrib/libgit-sys/src/lib.rs
+++ b/contrib/libgit-sys/src/lib.rs
@@ -43,6 +43,12 @@ extern "C" {
         dest: *mut *mut c_char,
     ) -> c_int;
 
+    pub fn libgit_configset_get_bool(
+        cs: *mut libgit_config_set,
+        key: *const c_char,
+        dest: *mut c_int,
+    ) -> c_int;
+
 }
 
 #[cfg(test)]
-- 
gitgitgadget

