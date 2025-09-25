Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627072FB985
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758800676; cv=none; b=apRLzkqnVHWAUiPMtxC6AOeZb0EcZfBiyTbQj3gWBCCsuTmPrQJuGtzSHlauZEkVppMY3acRQoaiRb8VZe60SVb8Ay9HaACkNb8DTKyfh3JZa2flEivGxk1MmOUJZ7kpc/vSh6m+/4wOJQy3USY/xkyc4Y12DwBpoTPyjUiNQeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758800676; c=relaxed/simple;
	bh=Vm/rVxpmy0cmZ7gmBDVeBfsVMEqjU7TGas2EzOtC+qs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uuNyqOb90eHEZWArxXC5aUdPrU1Fn9Os7Jmg1WTvkbK7pJHbReV83fP09grhbiA6uhd8LAJ0wI/nSkFN//f0MH6K3PRqTqfkvuiTPqwUIOvTXHYtTZC2PwMYn/ByueZF60bSzYkcn5tD99S818vFEDy4q20J8MRYvn/NHeQ7z04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+yBJo24; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+yBJo24"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-85c66a8a462so66990685a.0
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 04:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758800674; x=1759405474; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IoowTXkBJcEmZPY4llr7ch/RHORltqdssQwef+UEu3s=;
        b=O+yBJo24JQnn9fryl5O9cgooDidbA1oHHm7HHYZ+KQ/b/V3r55d9dtOydAZiob7vBf
         S6+fAOXckGTzaNbLdFXy3KE4ysGzf7Z1yaaEIUhxFJ5G0v3Fg2Tp7bnsGqgv7jyxn8Ac
         yYxAFkOiYfwOKIjgv2zw0KVNgLwPlMe91Feb7GoWkGX4BVgZ6jhaoL2sGb4vxCT93aPE
         BAOmDYXyJ+eM3ukA5F7o0EehXiEw2uYDHzCad23HVOS3mX5ryVgZgd4+bXwrdamrrdwG
         iwJihUusG2h7ICb9oXk8v9YaVOlV5VWbpwWCJdAti1Hdm180P7r2Nzbf5iwiijtXxlMD
         xLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758800674; x=1759405474;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IoowTXkBJcEmZPY4llr7ch/RHORltqdssQwef+UEu3s=;
        b=up1MFbp2EbIRf1Rz18Hra7+hk1RcfiCD36CwGOemWgK/K5qmCXE0lM+oKveY/Nk5cT
         aZitc17U7yRAZT6eZ49zbft3ziI7jTs+Q1xW7C0R1gu6XLTtkzwCpca5f1/cEufD8Wix
         Jc75TW/3fa4FKtTBIk6A637IDAbOxes1UHw74X/XtDWfKTIJbAx0SbR7Go9XZcH8cEGe
         Jmp+ixq/lt7sgY5Cqeyyn7C5i4TOdLuSxD4gUCOtuOIVuLirLGqMUILsQP/By+1sskmW
         afeBd3EyTNbvrUZx8q24GtnFVRRwYMEjJ7T2iDZMUEoh09aPUnSDrJG5Gx3+fsi5e4vs
         dw9w==
X-Gm-Message-State: AOJu0YwReEllysNM0IvO8ZfZf4q67kEjyPU1EWbNR1h62KYtjnokOFEw
	0dT4iipeZxpclZGsF7ZKrA6jvCYAwx+OrZ3a5Nhd+FXc11LAAhHJrGkZsKOu5yMI
X-Gm-Gg: ASbGncv9DsygPQfBNp9B0Z0GGB2X4hqoFK2cSIw+k0pFBvkMd3oyTK9lPSHuGCpcgFf
	UjENsyy8sYlvBTLHflxFjJUIiyRzuPged/pRWNg1YWxi22cFktqWf0wwVw+eq7GlkwwQxBzwPA4
	zN2/Y2MMK/dsyMmLbNRqHQNbMUFN4PfVtHxBWGNP1Xesweyc3p7JjnFd/kWyJH6b9Wce3atPOZE
	+v1BBWWo25XYA+5q5Gi34ZU53D8hpJQf9QgWQrOi4OWvVRlekk1nIygTFg1CUVXg5FnhP380UhH
	zIRKLhuzWnUcFP7DyKhF4R0Da13fw2mfIKKVuuqbgaI2VJ8KYOcy9EgYATBbCIDtTHzM9kHfpJs
	ClniQYh9dsAqmQr3vevDfNwlo8g==
X-Google-Smtp-Source: AGHT+IHFalAz+HTB5JiBR9G/N5McjJUDibKjWrCbqgcHch0VNnSeYB4VTLJHfE79e+JwXgz67iGlNQ==
X-Received: by 2002:a05:620a:2902:b0:82b:54f:5b8a with SMTP id af79cd13be357-85aed30bd65mr446949385a.75.1758800673774;
        Thu, 25 Sep 2025 04:44:33 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.167.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c335b7050sm93788485a.58.2025.09.25.04.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 04:44:33 -0700 (PDT)
Message-Id: <a5904a2ac00ea6de142344272b45f6b4697b4f98.1758800669.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1977.git.1758800669.gitgitgadget@gmail.com>
References: <pull.1977.git.1758800669.gitgitgadget@gmail.com>
From: "ionnss via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 25 Sep 2025 11:44:29 +0000
Subject: [PATCH 2/2] libgit-rs: add get_bool() method to ConfigSet
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
Cc: ions <zara.leonardo@gmail.com>,
    ionnss <zara.leonardo@gmail.com>

From: ionnss <zara.leonardo@gmail.com>

Add support for parsing boolean configuration values in the Rust
ConfigSet API. The method follows Git's standard boolean parsing
rules, accepting true/yes/on/1 as true and false/no/off/0 as false.

The implementation reuses the existing get_string() infrastructure
and adds case-insensitive boolean parsing logic.

Signed-off-by: ionnss <zara.leonardo@gmail.com>
---
 contrib/libgit-rs/src/config.rs    | 24 ++++++++++++++++++++++++
 contrib/libgit-rs/testdata/config3 |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/contrib/libgit-rs/src/config.rs b/contrib/libgit-rs/src/config.rs
index 6bf04845c8..3f4a32c72d 100644
--- a/contrib/libgit-rs/src/config.rs
+++ b/contrib/libgit-rs/src/config.rs
@@ -68,6 +68,26 @@ impl ConfigSet {
             Some(owned_str)
         }
     }
+
+    pub fn get_bool(&mut self, key: &str) -> Option<bool> {
+        let key = CString::new(key).expect("Couldn't convert key to CString");
+        let mut val: *mut c_char = std::ptr::null_mut();
+        unsafe {
+            if libgit_configset_get_string(self.0, key.as_ptr(), &mut val as *mut *mut c_char) != 0
+            {
+                return None;
+            }
+            let borrowed_str = CStr::from_ptr(val);
+            let owned_str =
+                String::from(borrowed_str.to_str().expect("Couldn't convert val to str"));
+            free(val as *mut c_void); // Free the xstrdup()ed pointer from the C side
+            match owned_str.to_lowercase().as_str() {
+                "true" | "yes" | "on" | "1" => Some(true),
+                "false" | "no" | "off" | "0" => Some(false),
+                _ => None,
+            }
+        }
+    }
 }
 
 impl Default for ConfigSet {
@@ -102,5 +122,9 @@ mod tests {
         assert_eq!(cs.get_int("trace2.eventNesting"), Some(3));
         // ConfigSet returns None for missing key
         assert_eq!(cs.get_string("foo.bar"), None);
+        // Test boolean parsing
+        assert_eq!(cs.get_bool("test.booleanValue"), Some(true));
+        // Test missing boolean key
+        assert_eq!(cs.get_bool("missing.boolean"), None);
     }
 }
diff --git a/contrib/libgit-rs/testdata/config3 b/contrib/libgit-rs/testdata/config3
index ca7b9a7c38..83a474ccef 100644
--- a/contrib/libgit-rs/testdata/config3
+++ b/contrib/libgit-rs/testdata/config3
@@ -1,2 +1,4 @@
 [trace2]
 	eventNesting = 3
+[test]
+	booleanValue = true
-- 
gitgitgadget
