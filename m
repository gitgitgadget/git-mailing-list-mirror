Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69851DB13A
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181528; cv=none; b=JdAAjvt6vkDwoHdkI202+ntci9OUtYaIJlR+Ksq1E7TR1gHsTZ/Tsoa22i6TKeWlHRHlSoF0YRN2/cFMqmKh7C27cT79WfdTvqQslqV6KnVYp+i7RgoDWoYvqLRenNRmqWvtggA/PKmz0TchnF6hmhuSp7fK/Y3UN+gNl9uNWgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181528; c=relaxed/simple;
	bh=poliQUiPmUYejsJjzk6xebI4OX28VQmIFQavl+TpbDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUIRElW90He2VYf1Orzk17VNb7cIhm8J1Ozhy914IY+CI6eoCqlqSASiNl70H+iN7ts9zY/I8XoroDjmVjd2Ot/hLrrfI/xvEvzMvVf6AFbyFWKPS7P1YW4QOKuIoWBHuQe8Ii7Q/cRRFL3RHzZtRcYE7IRDqyYTydRUhPOVLwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H98e4n2t; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H98e4n2t"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3fe9fe62295so764259b6e.0
        for <git@vger.kernel.org>; Fri, 28 Mar 2025 10:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743181525; x=1743786325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgtWzKM1JejgAbaQIKA1dhHnN40cJ56jUGXP/oBvI+c=;
        b=H98e4n2t2v/zQxC8lHqipzvlpeNoqKTiC0Zk4lxs2FGU+vAw2UssXho6JBu/YXKuZK
         YxqKoogAWbjUz2v/Jrd4lfAiabWWNpKKAOhfJ2SCl6OubKuDJobi9+uDJrSbqq41ylg2
         GAy4kqwguCZ47zzQmYrrc851W0YwNBjq/Ql8KNUbER5S4NaUN+DQiOt7f9xNsRgLC8Dz
         wvmBlhFV2jqR1ZWYX4IbfGO4QTCYqd/wxY0oIXF8BBe2KQMpwOQUZrilptyoN3s7WvmH
         EB5XDgQOAvTLCV335XgpwdKVSmjSUBd/mC33c4vhj/76ID84yjXiR41IQ8Yr81E22q/C
         dw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743181525; x=1743786325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgtWzKM1JejgAbaQIKA1dhHnN40cJ56jUGXP/oBvI+c=;
        b=ajdU/amTZYvtFAtRPo9Ipnuv6zbxUU4+7lwWczbAs+00RNDx96W8CixSIWzMIdIw4M
         l9gfcCW3RluZhEts0AK3qcmlSBTTtm5o4xLnCKLIhsZNE/0L2Kq44LgYOJKUMVqt+lwP
         Z5YcFT5j8GZx43k7Uyr0eyL6VKYF4ePI4chlAS3gx9KTpaCUgphaVrfy9aeXRkuxQPRR
         P//egt/RMe/9CW06LUCb4tYcuuIQcQKswU5CO8JzpDXqA1NuXkWb+YkZKjZWnx+Q0YbO
         VpOvbY85hC/JAjabFjqvN/vE9HM8TWl4Gp2o/1yYR7GG4QXqS7vRAjp+M+lnvac6Z07Z
         vPAA==
X-Gm-Message-State: AOJu0YwXPMk3bAei6CefKviC9fCPvAeKr9bUPG2jg+i7o4fqQMS4iR2d
	4H+yJJRdozIaC/DgAwE2oxHnSXUHoH+Ez2pJA+BvGzhEfMZioU9VIlcPEA==
X-Gm-Gg: ASbGncspfyyfS/T3cliV27wibg0dsCkcpcqchyYaX+OtxtWM8ACiR1n1zL++aJtp2YJ
	jpKkDyWtgBOsF7xkrYoejdGgeIrNFWo8aaneH91pG1z4W1bjBCOdWxn9X6xb6rlAHp/pZXupZ1Q
	1aP235PXz/2XsnxJhruvLtjB/kxQWsWdtpr2sePFWtxN8OtIhc6Qx1awnh+v5j6XksvmYks1Y2y
	MROl1uxt9LG/KVhCfdbx/iABEl9sVrh4HT84Mn5TjWjpXw8u+dFXQdWfQRopAWyYrDrzsSrQiva
	Oaz8p6/7xEEAo7bSQzAsbXf0oNIUhEO7LiJyzGddAA2uwfXu2ZZ7
X-Google-Smtp-Source: AGHT+IH+VsN5PuYZBOO9NoeTZS3j7qqcCICnt8U36wOzsDSF0r1YFlMcmDpzWZ7ZlsUvoAL2+w2CyQ==
X-Received: by 2002:a05:6808:22a2:b0:3f9:9076:b659 with SMTP id 5614622812f47-3ff0f59bbbfmr11906b6e.28.1743181525277;
        Fri, 28 Mar 2025 10:05:25 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ff05166b27sm402136b6e.3.2025.03.28.10.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 10:05:24 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 2/2] help: include unsafe SHA-1 build info in version
Date: Fri, 28 Mar 2025 12:01:21 -0500
Message-ID: <20250328170121.157563-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250328170121.157563-1-jltobler@gmail.com>
References: <20250328170121.157563-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 06c92dafb8 (Makefile: allow specifying a SHA-1 for non-cryptographic
uses, 2024-09-26), support for unsafe SHA-1 is added. Add the unsafe
SHA-1 build info to `git version --build-info` and update corresponding
documentation.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-version.adoc | 3 +++
 help.c                         | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/git-version.adoc b/Documentation/git-version.adoc
index 80fa7754a6..53c8ba74c1 100644
--- a/Documentation/git-version.adoc
+++ b/Documentation/git-version.adoc
@@ -22,6 +22,9 @@ OPTIONS
 --build-options::
 	Include additional information about how git was built for diagnostic
 	purposes.
++
+If built to use a faster SHA-1 implementation for non-cryptographic purposes,
+the implmentation used is denoted as "unsafe-SHA-1".
 
 GIT
 ---
diff --git a/help.c b/help.c
index 32b5d4e6f5..7670e0a64a 100644
--- a/help.c
+++ b/help.c
@@ -784,6 +784,14 @@ static void get_sha_impl(struct strbuf *buf)
 	strbuf_addstr(buf, "SHA-1: Collision Detection\n");
 #endif
 
+#if defined(SHA1_OPENSSL_UNSAFE)
+	strbuf_addstr(buf, "unsafe-SHA-1: OpenSSL\n");
+#elif defined(SHA1_BLK_UNSAFE)
+	strbuf_addstr(buf, "unsafe-SHA-1: blk\n");
+#elif defined(SHA1_APPLE_UNSAFE)
+	strbuf_addstr(buf, "unsafe-SHA-1: Apple CommonCrypto\n");
+#endif
+
 #if defined(SHA256_OPENSSL)
 	strbuf_addstr(buf, "SHA-256: OpenSSL\n");
 #elif defined(SHA256_NETTLE)
-- 
2.49.0

