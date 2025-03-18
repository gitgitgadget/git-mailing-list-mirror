Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0C7212FBD
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742340273; cv=none; b=HbHeBHsJc6gnHO/D+/QarlvhYH+1gvkGwzpQdFngEnWSKBF3OpsBwEPWaivjb4Rts3h6xXwFaE7tNfz33uY5Lw5EpR/w8MwcZ4ZlZGUtBlTn8t/5v/z8AD8U1xl7Vxn3Hk+pb6ur6uTPmXFTUAXXPx3F0sWHviWdtRVh9gYR0K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742340273; c=relaxed/simple;
	bh=6cuUKzt5E1wLCA8+PoPjzzdS0jEkHMCyoeFul6vRTwA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MosWT4ND45upC1WQudix3GspOPI34CH7yNIUduc2VEwi3EwZ4FJ397R8Bm9OYchNRRlLWofTxwOFwZ7NcDS03U/AI9OD20rlTP9bxJBaRAS5tcht/6gQ2FCV1BbKETSpxKohXjzeWKcJ2QsYoMXxrm4HOysrtpjpYuDun071OAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SC1e5UG3; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SC1e5UG3"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-223d86b4df0so178214155ad.3
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 16:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742340270; x=1742945070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BZhgdEObtWIrYnSvQF9t8XeqGW7wxFD80uyJ4Wx4sko=;
        b=SC1e5UG31RazBu94eeYqwU11uWDK+oNM/x9CDwaow7VBKp5KWo9uiOqIOJBRZbvUG5
         7ROwhuoO3bhogPOlT93GSLlKnfe19s/CqZmWLTTZRxgT03b75SCOYHGKtQGR212UCXwJ
         A61od0GplPjORjgFj/7chWXTVb+2ney9R14YZdfC7Lm3aw8XZgSrIAFjQuIYjJKuGEjn
         LbMOfhOZmT9Z6FoOWWUrxBWya+r3l0h2ZqA4+L+WfUFPs3QGuQHU/GUsAMKPHs6nC7++
         y2t9v+LS+EPcaL4G0qipQZ80HvoCMFDasXxcR53pc6sD+loeT8FrStmZXccLmqE8CnDg
         XRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742340270; x=1742945070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZhgdEObtWIrYnSvQF9t8XeqGW7wxFD80uyJ4Wx4sko=;
        b=imfneMIBIIbCoL3UvtwFNLS8ldBxZ1pkTEPdcBc/q/AFenThquGPGtRSZRhTZ60Tgr
         iq/sjUH2zeE+TY0GpPotgvCUjW6EQlGQonNuXnaUxPXJIE/9E9qcmNsUzAn3YfemFx5f
         /r/lMeWuvM6WPX74gS/mnZjpGu0KGYGdxb1msTJ4CK0BNqxkXdtaSYnjVHDrZBPAZ33p
         9YoeyC44JVYjxHKCrKHd+eVaCORGSDJZL9Di41FU8d06A/3l4IaZd30fBUSWe78HLAyX
         ml5oB/KmSx7H5GahtRME5eEYx/hyOd0YupV1jqurN1oHHVLx9IqSsKSvdwKI7gGfzgJM
         Xmqg==
X-Gm-Message-State: AOJu0YywiXmAqN4PJLo9NNLZc489H15Cy9+ZweMTuiJ8TXXMT3wcd3k2
	4n4gUnANx/tVT8QJmT4bRkVqORv2c9178TLOqN2Cry/pCIBJL72QkqZlAMVh1FbcXSEePg0FTnn
	qGrYmQUwjUB+wKQc8OCdWWnWbieknTjUa5F9mCVHG/ssyEOOkX37n52xCifL3RIWrtvLBgnaZXu
	sscNozEWy95fU6UJ16nrojyYyHYEQxnVu94glOIw0=
X-Google-Smtp-Source: AGHT+IGTx9NzsPWFpAeuaL65MZw7wzjdj9jRGv7z+K4mraytDyfyJQfvy+TjDb33lv9fulD7bnEHhU4CHo3ldQ==
X-Received: from pgbfq12.prod.google.com ([2002:a05:6a02:298c:b0:af2:68b7:9f68])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7103:b0:1f5:730b:e09a with SMTP id adf61e73a8af0-1fbebc85239mr864828637.20.1742340270522;
 Tue, 18 Mar 2025 16:24:30 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:24:21 -0700
In-Reply-To: <cover.1742339107.git.josh@steadmon.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1742339107.git.josh@steadmon.net>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <905e4e4d043a0ae78bf329c074552c7feba900d2.1742339107.git.josh@steadmon.net>
Subject: [RFC PATCH v1 3/4] libgit-sys: parallelize build with Cargo's jobserver
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"

Cargo provides GNU Make flags that can be used to connect to its jobserver for
managing parallel builds. They are not automatically passed to any `make`
invocations, so let's add that to our build.rs script.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 contrib/libgit-sys/build.rs | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/libgit-sys/build.rs b/contrib/libgit-sys/build.rs
index 9d586d272d..16e0d66afb 100644
--- a/contrib/libgit-sys/build.rs
+++ b/contrib/libgit-sys/build.rs
@@ -8,9 +8,11 @@ pub fn main() -> std::io::Result<()> {
     let crate_root = PathBuf::from(env::var_os("CARGO_MANIFEST_DIR").unwrap());
     let git_root = crate_root.join("git-src");
     let dst = PathBuf::from(env::var_os("OUT_DIR").unwrap());
+    let makeflags = env::var_os("CARGO_MAKEFLAGS").unwrap();
 
     let make_output = make_cmd::gnu_make()
         .env("DEVELOPER", "1")
+        .env("MAKEFLAGS", &makeflags)
         .env_remove("PROFILE")
         .current_dir(git_root.clone())
         .args([
@@ -33,6 +35,7 @@ pub fn main() -> std::io::Result<()> {
 
     let make_output = make_cmd::gnu_make()
         .env("DEVELOPER", "1")
+        .env("MAKEFLAGS", &makeflags)
         .env_remove("PROFILE")
         .current_dir(git_root.clone())
         .args([
-- 
2.49.0.rc1.451.g8f38331e32-goog

