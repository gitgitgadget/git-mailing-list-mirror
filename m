Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AA22264C0
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 01:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071818; cv=none; b=gsKisGqB9MetcQiL/AB8VvOwOwDDDboW84HnvH6lszO0GBWmSjB5AIpJ64Zl3DizvCfCL5EcAl+fFj7LK7RI6asmkH/5tvrE4JBnRC42hXVkO6PkHL40/kd99IewVTuSHfsSkrf7MgX5lCPoVn+iweyvgJsGs9gyunStdIJdiFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071818; c=relaxed/simple;
	bh=GLb4mC7uu3AY/GjFEbCb1YfsO1johX4mxETWVpdtbGA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=p683NwOj57P7rkZJKJi1dJy0cuniDO5PPYQFBdL63rh/O+BbqPj6z2E75SQzfgD2xTJALaKTdlKn27TMwvdw8r8QVtvKxaoJr+1j9vwK3viutA0liWa1orh/lK8iIhFEtzgvjZfEJP9SfqqmwqlugRUBAbmc5pSmTGITQKrJW2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TK2eoXXm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TK2eoXXm"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-25669596955so62986575ad.0
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 18:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758071815; x=1758676615; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jf9yXjfvLIqJ/Qr7MPrFGe6d6Htz5zcYqyLIUWPYzOc=;
        b=TK2eoXXmw1mv2YA76BfaYjHxsyAK7axAMO9oEVP/i/3zpCG2RkxBlr7ERy9dwKO43q
         vK64QD8buNEjvbiwq1S7dXXV6GElbOQgifBd/DmOa8mN5SrXVfmmSxh4Gqjmy73NgzrA
         wjuVbX6QtPesIbxdi7/Yw4Nf5P7TVyN5K11/yoMuHqGJM2CFnEgOJ7l9MxyyvA629ul4
         wJinJv6yETb8I0sCNG8uLAitH7QcfSngzMKOIcP+vjQWxRTV1DR5uj3naTTWZCy8wfky
         sQOFldHmFyMYAUygQTC91f37+KRdp4rMVD5VYngCp5pCXt04crcKviVO0NB77+EY44FU
         CqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758071815; x=1758676615;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jf9yXjfvLIqJ/Qr7MPrFGe6d6Htz5zcYqyLIUWPYzOc=;
        b=MgJhQk6hLXLli4wk6abDhrjgJQP6G6Y6yi5LWLCBCJzCUCVy29lg/kKxpzf5daK5fL
         HGMTp1d60KNACVtMKgMx+Jz/AjjYP5Lz0bn6gbYTxiij96wz+yQwVvFQhBUZYUSqQ/YU
         G5JW2ldVvqEYL6bA9mm7RCSTDZUUew1jeePnLwZKz6d8z6jwkCksNVi2gQieUduOxZVF
         Mi5lKLAxusO+0Y6ntElX2bqXhke6aHmyrxwKFXvzS7vZ2oqazF3eCmqagXjKZEGt4R8I
         m9iFbOuVGHp1nkL9lLnXenR23TwEMFJSqqjawrXvMR4D5S0qJ5qZZZnAKyQdyPnnORRJ
         H8nw==
X-Gm-Message-State: AOJu0YwVNmIQguJY2op1ZROxUADeoFGMdAr5LNDzF3T2tnHur/tkmmfp
	aKvmKwId617ZVkCSDLei/rkyKCfNGWx9zBcKYKKlQsNKeNS8BtCH7NaW3RpLzw==
X-Gm-Gg: ASbGncsMTtzVupPHBJ1oLiec+DCrA9XUr6C2oKp5JBHKvN5lu21wh0s0jnTBYDBCbzb
	u2FnzeIvxkyT4SYb6CbFa83k+VY611I5SuyMvlfE7XaHUwVR8yZdh1TgJxWHhysGkEyNIYIUTTH
	NgdPZfW1rWENJSfZyxNO1LPI0qdagfNXS30dV6AQjNsVtpk2Rg8q8AwvmZLMiZLC4FMIfvj6WxJ
	FrIkxtpPGxsWXv6JZ2zaYFB0JZJifq5UqBHNu1qZJ2kvBdu2hqlzDQB49P3J9Zc0CTmE4I80nac
	YFqUrQURHitoAb91Tst2E5vmtQjeEyEokInf+l58skegpBViJE2qGXz3PQ+ggM1A6v7/6wFV35j
	VNKTZFY7pdFsyHc2JQxCbSkgyXHI=
X-Google-Smtp-Source: AGHT+IFlhH42Pjhwfe9r5iVqJn9cebkkqOIlDhaaLUpOGiK2ozQYZvrjp/5n0gKcy17TxlrocB1L1A==
X-Received: by 2002:a17:902:bf48:b0:265:9878:4852 with SMTP id d9443c01a7336-26812166540mr2563465ad.15.1758071815188;
        Tue, 16 Sep 2025 18:16:55 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-776235a1f03sm11157446b3a.6.2025.09.16.18.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 18:16:54 -0700 (PDT)
Message-Id: <1c923a71f27ba204ea17a725daf45576d0aa3ec5.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Sep 2025 01:16:32 +0000
Subject: [PATCH v2 12/18] build: new crate, build-helper
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

Make a crate that takes care of the boiler-plate code that most
build.rs files would need to write.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 .gitignore                   | 1 +
 rust/Cargo.toml              | 4 +++-
 rust/build-helper/Cargo.toml | 7 +++++++
 rust/build-helper/src/lib.rs | 0
 4 files changed, 11 insertions(+), 1 deletion(-)
 create mode 100644 rust/build-helper/Cargo.toml
 create mode 100644 rust/build-helper/src/lib.rs

diff --git a/.gitignore b/.gitignore
index 24292eb473..e595759d71 100644
--- a/.gitignore
+++ b/.gitignore
@@ -257,3 +257,4 @@ Release/
 .idea/
 /rust/target/
 /rust/Cargo.lock
+
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 9bc2f769fb..aaf008b5ee 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -1,3 +1,5 @@
 [workspace]
-members = []
+members = [
+    "build-helper",
+]
 resolver = "2"
diff --git a/rust/build-helper/Cargo.toml b/rust/build-helper/Cargo.toml
new file mode 100644
index 0000000000..4455fff5ce
--- /dev/null
+++ b/rust/build-helper/Cargo.toml
@@ -0,0 +1,7 @@
+[package]
+name = "build-helper"
+version = "0.1.0"
+edition = "2021"
+
+[dependencies]
+
diff --git a/rust/build-helper/src/lib.rs b/rust/build-helper/src/lib.rs
new file mode 100644
index 0000000000..e69de29bb2
-- 
gitgitgadget

