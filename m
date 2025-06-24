Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41BA291C1A
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774128; cv=none; b=m7ED1NGG9MDowfa7yOYkhOBDwggx0DcvbKXD9uKT9VYQNheRcRJG/BbzLHHagtS+U3lAXOq30YWY7k87dh4KISLZC1KY3HhfPggkVOtOdLgTAdNDQSBx5JJuJqAiCnxT05qxr8bmc5q+jk8aERlcyI0o3Jxx/CuOGA7N3k2IVRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774128; c=relaxed/simple;
	bh=JdfDwyyk48v7HaHr/OwwJQHiHCGYmgAtiGMJ12cf3Dk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=D+cgWg6l3RMsHvvkapwGqvRb2CkoUI6OA/mwKq2iMa9FKLtEBrIg+3EuTQqYOrgY6YC9BrxepDE4G2bRxiVr6S7V3GhgTe32PSsU4acF2FBJrIbyOq+rQG5tpPV5YihqnB+6EN/PSOfMmWXNtzFOZHzS3FljXm0EjehBb6UK7Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6aXjhqe; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6aXjhqe"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a6d77b43c9so2889440f8f.3
        for <git@vger.kernel.org>; Tue, 24 Jun 2025 07:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750774125; x=1751378925; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bDm9G1cPljgd1U1w045KZL9WenKjaYBnjjxkJPXOjs=;
        b=P6aXjhqeJIEEqf4gx3N7FdM2cWpapKUy9/X9fv1IoSGa7UW79IEXsY9oF+BstMmmPW
         ZVaZKY6E3bW5rXRGS8JaW9YgwQKLJ71s8br49j7HwQiiURUtSKJat/VUChmSopDoThKE
         alQiJPubSo9rQwJ6wJQzz8RYmng6w+hbPDurj8rmGBYaiL5VLO24g/Ok9cOKErePPQqQ
         GAOx52maH1g82h+cRv8DnBH153sP7sJKfR6CZaeYxkvmeJr6v0Zd14rjKmguDQ+t51af
         kB6sEZ3gz0TP82U6Ri9hxzWVxpoCAlQXikW64PiZwTZdR3PuZmCi8Snwy0UvJMxid4fo
         sQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750774125; x=1751378925;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bDm9G1cPljgd1U1w045KZL9WenKjaYBnjjxkJPXOjs=;
        b=NJYaTGXmQDLJBSPZXo0kBbjInboU7K4mx5Z2ZkTW+mmYEwBHFrhrUjIqLdVMXYtE6E
         dPb2xVGl7hsaU8eBRh2PzDhj8Lfgey1VbxA+s/+rXFdUtcoh9Ba9Q3Axdqe4FxD/ZRAW
         kFP3QLF+BefxosFGCYcelOphs5XpOcKC/kIunizVrBcbBmujZUGQirP8Op3FjJ3Rl18h
         IBbydTqIaXQwMcqavAXqjPM93LdO+iXOiOVzqEvnh/rMlPXjk/8xVOtWj478HyFwpge3
         jvvR905BbJ5J+bNUS5NXxaPufHjMWcuVS9ALGs95z4Xbkf+G9ckfcCKtFUbyBpKv7AHP
         Rygw==
X-Gm-Message-State: AOJu0YzeifPOE2rtdaSLeg8YKE6dkhkOnKY1jA6u5OMSOc/1vBIyLula
	x8rhVoV1BSwttqwudB6nbQT5LcWzvPJiriITN10abldjJgzNJjuP7O7GJDTdgg==
X-Gm-Gg: ASbGncuuWkVczbNFqP+CXwkKY+1gB5xafAxCD5Q1e7IueBeL94nPzKvNDvfRFxara/D
	NS5XG1TYSn+/w8Vuwz1u1siU8zYRUDSZlNXUxVn1BORtya09b9v+eskVD1HXLMnqXJHGfAX3Ysu
	KrpLJoZevmEQ2bcZgPjCbtuGDcY+fwKLJAV0Rr2PUSddxBq+VcdRF3QZJZt3ufkvBNOjTLWocuY
	XVLJ8q+0id1fno8FB4Y1RHNNlYAmFRF4Hpo4Z/EnMyAwJwGq55y+IIHJDBInpKgYaXSx9yOgJVg
	aAB/DVuYtLn3rxBTm+EAiodhDGpIuEyt1LJz67vuVx6Ag5oGUHI0A9xxj8cIuGsb82H6Hj2cFQ=
	=
X-Google-Smtp-Source: AGHT+IFOjuVv22a8GJY5gmEaDe9kVceFo5aHX4AuBmqqu4ont6ejkaBWcOGsgjZulmSoE5VQVGdAXA==
X-Received: by 2002:a05:6000:2f82:b0:3a4:f644:95f0 with SMTP id ffacd0b85a97d-3a6d13260bbmr14469326f8f.54.1750774124208;
        Tue, 24 Jun 2025 07:08:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f24casm2067447f8f.61.2025.06.24.07.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 07:08:43 -0700 (PDT)
Message-Id: <2b5a58e53ac68e39a72e23bb40b386366ff03485.1750774122.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Jun 2025 14:08:40 +0000
Subject: [PATCH 1/3] compat/posix.h: track SA_RESTART fallback
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
Cc: Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
    =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

Systems without SA_RESTART where using custom CFLAGS instead of
the standard header file.

Consolidate that, so it will be easier to use in a future commit.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 compat/posix.h   | 7 +++++++
 config.mak.uname | 3 ---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/compat/posix.h b/compat/posix.h
index 067a00f33b83..2612a8515897 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -250,6 +250,13 @@ char *gitdirname(char *);
 #define NAME_MAX 255
 #endif
 
+/* On most systems <signal.h> would have given us this, but
+ * not on some systems (e.g. NonStop, QNX).
+ */
+#ifndef SA_RESTART
+#define SA_RESTART 0	/* disabled for sigaction() */
+#endif
+
 typedef uintmax_t timestamp_t;
 #define PRItime PRIuMAX
 #define parse_timestamp strtoumax
diff --git a/config.mak.uname b/config.mak.uname
index b1c5c4d5e8ed..52160ef5cb07 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -654,8 +654,6 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 
 	# Not detected (nor checked for) by './configure'.
-	# We don't have SA_RESTART on NonStop, unfortunalety.
-	COMPAT_CFLAGS += -DSA_RESTART=0
 	# Apparently needed in compat/fnmatch/fnmatch.c.
 	COMPAT_CFLAGS += -DHAVE_STRING_H=1
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
@@ -782,7 +780,6 @@ ifeq ($(uname_S),MINGW)
         endif
 endif
 ifeq ($(uname_S),QNX)
-	COMPAT_CFLAGS += -DSA_RESTART=0
 	EXPAT_NEEDS_XMLPARSE_H = YesPlease
 	HAVE_STRINGS_H = YesPlease
 	NEEDS_SOCKET = YesPlease
-- 
gitgitgadget

