Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8069D22F77B
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 01:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071824; cv=none; b=KHnwAWdVn1le7reNvIGpoKt9a7wSUI3F89pNeH4V1HvqUc64RmJrfX6fLoFnzn2i3bad7+lJDPgpYYke6pUFR5Yy7p1GZaYvVFJTUAHLRAGbQ9MK3m8VYegmwwst7mXUrE+32TYKc0DphBGZuwdOyZ2zL/PvMKNoZ+vcUkgPd88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071824; c=relaxed/simple;
	bh=s44mJ6ElxdS5ewu3IgQMuzZP3zfgXXkUpNOE3fMFlog=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qQh/Qi7Q9NdvB8aurkmL3Xdw7YC3PIXjmeQXz44ixJ3ruviKlv9U96Utz6Q4et+LtzPJ15kWg1Gn1m2dHhJ+PmP/3whwaQNjv9KA3m/HtXgQDBJG1hpbUmDYKduazu3PP7prssCrpk1y+pTBpUMXKW64DZPRiCwtMDX16xqw+RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOgSwfMQ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOgSwfMQ"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32ea10cab8eso1403363a91.0
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 18:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758071821; x=1758676621; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=468sG6CVFOnMX0d4ryudjT4N3pjB51dAvFiDmwT9gHk=;
        b=LOgSwfMQPMi+/1S+2aUgYmk805PsWH9SXJlDW30nnuvfOSyxcxwXmHb+ljeJboCdiT
         96Sy+vqsHa7ZTn4nc9UxedTwMKsCL7tnsN2fnhfVKdixlM+yCvJY3QwE+KLVs+abECWA
         zFxOXidE+oBx8owX0WMXmWRBWbzYx1++WM7ErAuWTJ81CJ28jbwor7uwDl9FhC4gWood
         CeZCFBagLrL6B/bh4u81G497GV6/nuzjPZvJvTpuG1GPx+t4IkfsJhY4boR/IoiECpuO
         402MsyXF3Q+eOOPpJlFeWVceTZ2NlqbZV2o13dm9rd78Akhe1ipeyApOdd4p/ClWxmzd
         A8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758071821; x=1758676621;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=468sG6CVFOnMX0d4ryudjT4N3pjB51dAvFiDmwT9gHk=;
        b=IFzLwWXcdB0MUhZf7BlYcMNiRekjCgWB0POBv891KRYe+DSkfLKPM2K4EEEFzgCAeX
         +x1PHdqQMANXD5bjlBgKgGJNlWuVwglLYd/5PVuPfnuVx5yB5O3ulBHRsrGjlR6MP/Cj
         2XB3Ihe/k51FT7OB/EnwK1yEWwdakckrRxNhBFw5BELBfEZLsxE/WyGRVYbaVukR42mU
         3XcQxrV72rXKVj2tHy0NqUzR5G6kC372Y26a0MIKXR4ny5pKePDTZ16f+KvxJfnTJb9W
         /HvjNoyEBUeXDONPDCZB0Jw09dyYHOcO/F6egh5uBKz7Bjci60OeOYHE8qxdmXABjeu9
         7Sig==
X-Gm-Message-State: AOJu0YyokDMXe3vXl72XI/rp7rYuBPL4ff08AuVDleq4a5W78ykgGx43
	iZE4equ83ufKqKh5G5KW1ApEQ6m0ocuwLr3MMLInfrCPprxnMCOLWLNjwkH5yQ==
X-Gm-Gg: ASbGncuqAsFy8z//oWGyEldg2XVQ3wigBUFM6lQj3lylEodugibIy3kt+QE4Mca+D3i
	JPIUtMtQRQrhZgVkS7h7L0vQOlT3hYzWeo8lTA4/DrCqsBkIQTn1X65H1VWXWPSxxf9an3atlY+
	ZjYGmUOiD69MXxXg4ANOEULwSycY9SmSFDh2MfeTPmrRbKtRzaQVL+t6sLUufdxAUGctJko5sF9
	w+1oc0QUwAoqdM/NxQdnKMQHrM68mkNPZaeBExQY9MFGQDXSyJ9YkViy+iOgFhh0WU7dOj/7rSW
	bGKAj1CZLZkwQ+2ijJ1QUWr9gzCcWLpuQvIpBWBSamD2cURvywOJ7k37q45WXdbolFMdRib1ltB
	AKq3bFZd2wl2eTBdIoa5bjm2zaDs=
X-Google-Smtp-Source: AGHT+IEHwsFhg5cylXHAUzVUcy+VwPJW3APGPc8lS62iIFOMRgQxDubRxDTq1XcSue6xIQpu87JEOw==
X-Received: by 2002:a17:90b:2e52:b0:32e:9a24:2dd4 with SMTP id 98e67ed59e1d1-32ee3ef08bemr500273a91.14.1758071821252;
        Tue, 16 Sep 2025 18:17:01 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7761562f25dsm14388297b3a.74.2025.09.16.18.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 18:17:00 -0700 (PDT)
Message-Id: <89bb7c3613802cd778abd88eada41a18bb54ff01.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Sep 2025 01:16:37 +0000
Subject: [PATCH v2 17/18] misc: use BuildHelper
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
 rust/misc/Cargo.toml | 3 +++
 rust/misc/build.rs   | 6 ++++++
 2 files changed, 9 insertions(+)
 create mode 100644 rust/misc/build.rs

diff --git a/rust/misc/Cargo.toml b/rust/misc/Cargo.toml
index 7195d7894d..0f93aa4ae4 100644
--- a/rust/misc/Cargo.toml
+++ b/rust/misc/Cargo.toml
@@ -12,3 +12,6 @@ path = "src/lib.rs"
 crate-type = ["staticlib", "rlib"]
 
 [dependencies]
+
+[build-dependencies]
+build-helper = { path = "../build-helper" }
diff --git a/rust/misc/build.rs b/rust/misc/build.rs
new file mode 100644
index 0000000000..291923ae1d
--- /dev/null
+++ b/rust/misc/build.rs
@@ -0,0 +1,6 @@
+use build_helper::BuildHelper;
+
+fn main() {
+    BuildHelper::new(std::env::vars().collect())
+        .build();
+}
-- 
gitgitgadget

