Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C94958112
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710249305; cv=none; b=DhVhh9Y3+Y0dwSGevxlpPw0kPb2ABn+rvNsbuldUHWy7x7C1zCci4wJDMdPNj9Ua/rYuN1DGhDDbTR8JKt2rzAJNdcibVPx39hDly3Jznrdc0UUSoorQlCZMeBjadgteHvVtmyYW5b5fL7Id8xFcjuYZCic4MZKiARnP2K5tLEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710249305; c=relaxed/simple;
	bh=w8LPhrdhOHREuZ8PAt3X/OIKjeeOhrw/XlZV8QgoVkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjNRWYjrCNgiQLRUo4+Tp61RfhRmNev3r06l3FkEn5/NLJfQ6Dqr263m3ebKaeVkZ/gFW8GEDGhfl4sfXt1WHk7l8tZjfl7qEspwRk56B6gCM8syjZlxHNCrSg908c7OaBooWWyK6Ea/kbcKSsnmymD4/s8LMQtC48ai9Mmt7H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maKbKVj9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maKbKVj9"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33e94c12f33so2321929f8f.3
        for <git@vger.kernel.org>; Tue, 12 Mar 2024 06:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710249302; x=1710854102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTCLg17ZGhvDzGeQoCBYxGyYTWyBwI0CNDaIgma/jfQ=;
        b=maKbKVj9hh0FRKV6/Ro2LzGt66QUmjl/9gE+OB7aY6IMJHiKlIIZgoREx4qmYhnS0N
         kKp4Ab/gWa/zMG/BMegp6GWzAF8CXTk3gqhLZ+BEvPUnoe8XsgCQQuzm4kDcHxkhB4h7
         iGoNFgYuh5FWcm95HFg6wcx8szwxQqW4a0XrEAXgXi8opFWKvYy0djbxhXcOkuwF0nl0
         DuqnE12vqhfB3qu/6XfZlvfswltONow0li4x4qB8TMg8KSHtHFh2F2ErRlentAdVeg9a
         WRwrRybKehmTtgxMs+/3qB8g+4ntalRdRDs3E/BJ4rgI3xGoX9WCYQ+nfjYWjkrgQKZv
         EP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710249302; x=1710854102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTCLg17ZGhvDzGeQoCBYxGyYTWyBwI0CNDaIgma/jfQ=;
        b=qf+vkOim9X59rQfvhfXStjM1f/2+AOQFDaW6hmZbeLT16agS4qcF6qkLANDvsTC8aI
         DORBtdP81PY4IJl/OvE+iXVOtyF3f8qM4rA4nZR3jlAgVtdluIjww04J50tGVRss3rw4
         8Yl/b3Mdaafg4M9qRvLOsLlGZBL2fHIdMwbxIy+HdfYtqKNEQyBhRMKuSyqQfhiNoqFD
         CV6RNnJtg4aZu7zQm/hoa3J0KIUBuOhS/p3iJ4M63iNlzSZt0giebeBN2H+5HwRGxASk
         AxercwuwHFkvq8GPoHPeDO9JdFP3DD2jWNgstU/hyA33743qKMM5WB9qe3YMCtWCp5Wr
         AkKQ==
X-Gm-Message-State: AOJu0YzcLFUxFLr+Oc7mWMRuRXZjoFePZjX3k2tGBWb6qx8DfIRT+YBa
	WT1N2ZA04vyqvvXAMeMa4WRFei4M53t+7egnYJpX62gsbLKfrq+mHwb/Q1G2LnY=
X-Google-Smtp-Source: AGHT+IGFvHInMPXoSQOOiVxEo/EXIsQXbtdyqsxnShLBsuUL8gnEhm04qBUHyEOOW+LfB+R/9Ot+Uw==
X-Received: by 2002:a05:600c:3583:b0:413:1bbc:b25f with SMTP id p3-20020a05600c358300b004131bbcb25fmr113447wmq.25.1710249301675;
        Tue, 12 Mar 2024 06:15:01 -0700 (PDT)
Received: from host-sergy.. ([154.72.153.211])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c4f0200b00412a31d2e2asm12586737wmq.32.2024.03.12.06.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 06:15:01 -0700 (PDT)
From: Sergius Nyah <sergiusnyah@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	pk@pks.im,
	Sergius Nyah <sergiusnyah@gmail.com>
Subject: [GSOC][PATCH v2 3/3]userdiff: remove trailing whitespaces, fix multiline comments
Date: Tue, 12 Mar 2024 14:14:48 +0100
Message-ID: <20240312131448.638472-3-sergiusnyah@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240312131448.638472-1-sergiusnyah@gmail.com>
References: <ZeWOhxBDvyjH8gW7@tanuki>
 <20240312131448.638472-1-sergiusnyah@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes trailing whitespaces and fixes multiline comments in the `userdiff.c` file
to match Gits coding standards as seen in [1].

Signed-off-by: Sergius Nyah <sergiusnyah@gmail.com>
---
 userdiff.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index bbe2bcb9a3..15342c8662 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -184,17 +184,18 @@ PATTERNS("java",
 	 "|[-+*/<>%&^|=!]="
 	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
 PATTERNS("javascript",
-      /* Looks for lines that start with optional whitespace, followed
-      * by 'function'* and any characters (for function declarations),
-      * or valid JavaScript identifiers, equals sign '=', 'function' keyword
-      * and any characters (for function expressions).
-      * Also considers functions defined inside blocks with '{...}'.
-      */
-      "^[ \t]*(function[ \t]*.*|[a-zA-Z_$][0-9a-zA-Z_$]*[ \t]*=[ \t]*function[ \t]*.*|(\\{[ \t]*)?)\n",
-      /* This pattern matches JavaScript identifiers */
-      "[a-zA-Z_$][0-9a-zA-Z_$]*"
-      "|[-+0-9.eE]+|0[xX][0-9a-fA-F]+"
-      "|[-+*/<>%&^|=!:]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\|"),
+	/*
+	 * Look for lines that start with optional whitespace, followed
+	 * by 'function' and any characters (for function declarations),
+	 * or valid JavaScript identifiers, equals sign '=', 'function' keyword
+	 * and any characters (for function expressions).
+	 * Also consider functions defined inside blocks with '{...}'.
+	 */
+	 "^[ \t]*(function[ \t]*.*|[a-zA-Z_$][0-9a-zA-Z_$]*[ \t]*=[ \t]*function[ \t]*.*|(\\{[ \t]*)?)\n",
+	 /* Match JavaScript identifiers with this pattern */
+	 "[a-zA-Z_$][0-9a-zA-Z_$]*"
+	 "|[-+0-9.eE]+|0[xX][0-9a-fA-F]+"
+	 "|[-+*/<>%&^|=!:]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\|"),
 PATTERNS("kotlin",
 	 "^[ \t]*(([a-z]+[ \t]+)*(fun|class|interface)[ \t]+.*)$",
 	 /* -- */
--
2.43.2

[1]:
https://github.com/git/git/blob/master/Documentation/CodingGuidelines
