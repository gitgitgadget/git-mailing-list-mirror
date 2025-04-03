Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3827424EAAD
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743689369; cv=none; b=CpVvN2fG+qTvYPl6Ngd7iRvdTP0dCvUNoa60+P80+n18G6BpFylsbpG7TxISfZSp4qXRXfXMyGR3x/txQWptjm6oq/q/EA1K80Az57wksmkS5/a/lxj/Twmxq8AYuBEMGDKbeOu4wi2chOmCPHbVwfbRm5g7+l0URDxfIgK6aVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743689369; c=relaxed/simple;
	bh=M8Nm9dUvvKrsyAfSUOLniA8aWRct1X5Gw6xoT0WOego=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHUn/OEvA9RIDKU61o1W5HEvbZE4iWm486UIX/pjD7ur/QLlNywxD49lrAtFgeegF5bSDlDtofHBmPjzjZKDkvnwBXSi8G7rnIcNOJ4soogmbFB7zKjqXsn7u26YiOc6a5OgIJrGuzH6sLB19yhcsIir9UR7rOvd1lvQ4faaIgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIVeHb/X; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIVeHb/X"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72c14235af3so618158a34.3
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 07:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743689367; x=1744294167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ke2hmwyLQBNc63TANNBfBeuCYiLWIA5p3ngtHSJa3vc=;
        b=HIVeHb/X5lVqPhgy8rVuivvLasKSJuw/1Va7MZs83glfDnDucMoAunmG+2BTzRO3s+
         F0IrXr7rU6YrSK69fSCccXvtoiJ/Koy6HfDksGme862Wjw6hXDvtLPhg3+F+1/pUxgB+
         HEy9u86H3LqIW6h104mVwedXPYqLcmrItY1LJWghZnzvzqgG56x6hCZ2Mt1cDem45OKD
         6wo/j/sx1tkihoVwM8ZVHnNSU5J2ItFMLZbQjxm3ieLVd47hbrNz5IgHvUkLzR/h/t+b
         kRTfxOvdgcD+SRWCd0bxvP+MpVPLO1KOnhGPm+ekBkSUdu70bhRXXusuGV9Vj8Bk6AAn
         Sn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743689367; x=1744294167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ke2hmwyLQBNc63TANNBfBeuCYiLWIA5p3ngtHSJa3vc=;
        b=IxSRX1YcrWFPbGbev3HduJfqdyMWZ+/jlt7OT8VZ0vrU9LB77HiIiMuHV3EKoDf9CO
         m2Q2nY9wAHXDs4gfYsdM7d/q/tIps7aFFn+vd+dnW1G5dbx+Yl9pNbNAvsL4i6R9vJri
         kLFIYOsqzjUif2D2iVTW8yPl8qZef8LWqyoHgAkXaiVYq5mhhA0qLWHOlCMPwbZRyQaI
         NYa69g85GnwnptyEY1t6z4DHkReHIMETGdrsuIhOzuqi578UL0U94nGJdeN4A+EQ+NzF
         N4W4zxWMb7As7HiHQDHHvmr9rYYYHdQoUqCbMqoIH37JYMAXdljTjyV3NAGVXkMaCzQq
         SqZg==
X-Gm-Message-State: AOJu0YzVXn0WwrKreRaqNTGiuEX+A/TCSx11ddDtx1X83fIl/HMtMjy9
	IhXorHGvJbQRZ+d/wQ2yuBkc0nHXCvDrtfyWG7XFA6q3+paOyZlyFXzPOg==
X-Gm-Gg: ASbGncuzJvk0d3DQxb/H4yUpHqOFqexH137ji2kGSBH2Vw9JfADLz3X5wwR+RU1LUSC
	iqD0kfYMiIXlJ8VJAQb/KCc/KTKnilL+OHD73xf6uL+8566fAHhMME70jZO9eo9w/TOJotalpyo
	aRfkwh7p/jd1sUSdNn1KK3YLqZ2YgzZPbgP762c5hj+IHXvk11CpOHMcR5/pBst0pBY7T9WEG4E
	e0EmfuUK1Fwtg6U+9KGu9AT38gydAzho6f+wrFHzKenKEQLQP3gciW3kciKYbsduzdLUjiC7C9S
	y4dfTTE4BO01EwGgcaT3PDUOcBnMJF/ciltQJpLAVDZ4o4x+97nt
X-Google-Smtp-Source: AGHT+IF7pXsywafA20dVFF9LZu7QaZixRy6Z5aCdPvEqaVLM1z9KHHMnblICpGdZEAaeBwzy1/JrQA==
X-Received: by 2002:a05:6830:4705:b0:72c:320c:d4ed with SMTP id 46e09a7af769-72e2eef588dmr1941261a34.22.1743689366659;
        Thu, 03 Apr 2025 07:09:26 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2cc845bb8fcsm261557fac.11.2025.04.03.07.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 07:09:25 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 2/2] help: include unsafe SHA-1 build info in version
Date: Thu,  3 Apr 2025 09:05:29 -0500
Message-ID: <20250403140529.497876-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403140529.497876-1-jltobler@gmail.com>
References: <20250401203630.285451-1-jltobler@gmail.com>
 <20250403140529.497876-1-jltobler@gmail.com>
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
 Documentation/git-version.adoc | 4 +++-
 hash.h                         | 3 +++
 help.c                         | 4 ++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-version.adoc b/Documentation/git-version.adoc
index 913ebf147d..9462043a14 100644
--- a/Documentation/git-version.adoc
+++ b/Documentation/git-version.adoc
@@ -27,7 +27,9 @@ The libraries used to implement the SHA-1 and SHA-256 algorithms are displayed
 in the form `SHA-1: <option>` and `SHA-256: <option>`. Note that the SHA-1
 options `SHA1_APPLE`, `SHA1_OPENSSL`, and `SHA1_BLK` do not use a collision
 detection algorithm and thus may be vulnerable to known SHA-1 collision
-attacks.
+attacks. When a faster SHA-1 implementation without collision detection is used
+for only non-cryptographic purposes, the algorithm is displayed in the form
+`non-collision-detecting-SHA-1: <option>`.
 
 GIT
 ---
diff --git a/hash.h b/hash.h
index 51cd0ec7b6..72334d3506 100644
--- a/hash.h
+++ b/hash.h
@@ -20,12 +20,14 @@
 #endif
 
 #if defined(SHA1_APPLE_UNSAFE)
+#  define SHA1_UNSAFE_BACKEND "SHA1_APPLE_UNSAFE"
 #  include <CommonCrypto/CommonDigest.h>
 #  define platform_SHA_CTX_unsafe CC_SHA1_CTX
 #  define platform_SHA1_Init_unsafe CC_SHA1_Init
 #  define platform_SHA1_Update_unsafe CC_SHA1_Update
 #  define platform_SHA1_Final_unsafe CC_SHA1_Final
 #elif defined(SHA1_OPENSSL_UNSAFE)
+#  define SHA1_UNSAFE_BACKEND "SHA1_OPENSSL_UNSAFE"
 #  include <openssl/sha.h>
 #  if defined(OPENSSL_API_LEVEL) && OPENSSL_API_LEVEL >= 3
 #    define SHA1_NEEDS_CLONE_HELPER_UNSAFE
@@ -42,6 +44,7 @@
 #    define platform_SHA1_Final_unsafe SHA1_Final
 #  endif
 #elif defined(SHA1_BLK_UNSAFE)
+#  define SHA1_UNSAFE_BACKEND "SHA1_BLK_UNSAFE"
 #  include "block-sha1/sha1.h"
 #  define platform_SHA_CTX_unsafe blk_SHA_CTX
 #  define platform_SHA1_Init_unsafe blk_SHA1_Init
diff --git a/help.c b/help.c
index 991a9525db..6ef90838f1 100644
--- a/help.c
+++ b/help.c
@@ -805,6 +805,10 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 		strbuf_addf(buf, "zlib: %s\n", ZLIB_VERSION);
 #endif
 		strbuf_addf(buf, "SHA-1: %s\n", SHA1_BACKEND);
+#if defined SHA1_UNSAFE_BACKEND
+		strbuf_addf(buf, "non-collision-detecting-SHA-1: %s\n",
+			    SHA1_UNSAFE_BACKEND);
+#endif
 		strbuf_addf(buf, "SHA-256: %s\n", SHA256_BACKEND);
 	}
 }
-- 
2.49.0

