Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD27231840
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669572; cv=none; b=qNSXH6OCiut4gIfQF39StklZmCIadZoZum295o2ttNIVYQwqUL+Q8VJqZwu+3OIpx8KUrH8GABhr6dSrYvUl4r02WR7tJQT0Nvm67rnonhLojSJbhBKzuCG8FKQSxNFUFyBEVjMmay9D9NymwQ8Xga8VVMLX7kzbuZPpjqzRaRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669572; c=relaxed/simple;
	bh=OXAVugRRbh44N220L7bp1nAMjhdH0APgmhriJwt7aZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISBv97u7UiwkWRNA+DepiI7Qac2WZyxMlJ00CvUOGADdmH4471yDXLj1pPJwUTi6Izafzx4KYjwAIlx96XXEp2bhpd7dPd1foz4JPH56Vj2IRUvPVJNbMSK7mNMQFyFdMEPVS41w1/wFu/7rOtZRN7FPQSGLiF5ni8UwKWB1V/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcDCvdP+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcDCvdP+"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so3017672b3a.1
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 02:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750669571; x=1751274371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzcIaeXQXlxD8Cuu2oBcYBk3vSvcIuKeMj2IxYGprHM=;
        b=LcDCvdP+3FQ40mdg+p+6gXnZlYkGWDvewl8SP3OozBOPtyHgDQw82tZKoBOdBqkcJ4
         oFwbMAcTUfERsVA9bKjnte2vDDBAyJI8vXyETxvsodSzch3NBxG9C+7X5NuoML/wba9K
         CIIuZ30IT09IgCDa4QEVet4lOcIVOWCgqBtDJL4etjZtisOjO+5xDIIfE1vL1NDc8JpI
         3CeLa9uz2na/3FwSNh0/ePyqHGzvQNRDQW6SfnoFJJ77WM3fIHvupqVtBOaMPWT1C6GV
         SZWAkqbfLhYxl1mZs3bArnqKBNfq9XXfX0vnPsc6xnleGMq0Np8h5JVKRJP3MEbt8suh
         G5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750669571; x=1751274371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzcIaeXQXlxD8Cuu2oBcYBk3vSvcIuKeMj2IxYGprHM=;
        b=FIVEwdC6cF3w59Wraa1kQB3UKcwSsudArYWG8EG4+b32jmnNYOeeqoeKvozUscapk4
         wLWLJ4SFlN9t6ZMyrab9LjDLmEEFHe1NWO9uT92ObLC8lsopHB/2hg8Ip636hcfFHxoE
         7aB2e6oWl+GNV47ZpbGCbkueCIx1644GCYaVddL3oY039bC7tqS+YQDhsM39krHebEzv
         aBzdzc9UZdtzFuDK2K8pcdYl1gPE0qmexvoaM7QJVFSA9NwfFGkkkU0W0hpzM7RuaX+g
         Rws+oCmU0paGa/YW8ZWft5ryeumSJK2LPPUWvPhIPQsuDC9FDzd673twkmRPFt2Df/Gh
         INIA==
X-Forwarded-Encrypted: i=1; AJvYcCUjwa80hBTqapiS1JbvROGbgIujzGzn/S6eDBAthASrvSMzbsDQTEm2N933nGVdgasdkcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxitIQAQsnZLjtvsTeIADZq7L3/EogvT/0lBSkxzBJJTxcTzX23
	+UXVO+MB62GQEzSrnj6Tmq02vDq1qlUKok9UjcOYgyjhv9HLyUzbY483
X-Gm-Gg: ASbGncusfqkxZTmd3ATGO5V7Bc+Atx0IEHv+ii067IM/rkUuUIzOymByM4vgpc0ahKT
	6FUCNFOwSlp7H7d7sQnutLSnKOFrpqBB3bKlj4EgeoDe8Oga9UmzKmSmY2ucd6pCcwoOoBjEh4U
	4YU37agGAMQUBhTItFJZEBZxqgtx4QdkB1m2iBLr1IQ+7enHfawZTG0yNk+zZq1yfzGJbBZr0bn
	nWhgKh0PNao7EctAVSp7hq73GVsSV0zh4yOCxGTPdvrzLVcSQ4eY6ZzPzIPMZ5ub/ixl/lSa/n/
	YLCw6yQx0EJTAmrHKrZGXU8DjuxH0AMesKHLNSt2UX6pLeQXxDDx/UOXs/1vK5NlVdZBQF8+Ils
	XyOTiZNLOYHikT1a4uIYo76ntyR+gq0ik
X-Google-Smtp-Source: AGHT+IGp+hVSBMrqvI0WiCcAEAwttN+pt10foRtJXh3NYqXFZUGcP4YCbwQ+Z0p245ULrpKsSPZu7Q==
X-Received: by 2002:a05:6a00:1393:b0:736:9f2e:1357 with SMTP id d2e1a72fcca58-7490f592146mr15363842b3a.12.1750669564851;
        Mon, 23 Jun 2025 02:06:04 -0700 (PDT)
Received: from dwmfdoom.tail99f6b6.ts.net ([177.33.100.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a623e8csm7779179b3a.83.2025.06.23.02.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 02:06:03 -0700 (PDT)
From: "Derick W. de M. Frias" <derick.william.moraes@gmail.com>
To: j6t@kdbg.org
Cc: derick.william.moraes@gmail.com,
	git@vger.kernel.org
Subject: [PATCH v2 1/4] userdiff: add javascript diff driver
Date: Mon, 23 Jun 2025 03:35:46 -0300
Message-ID: <20250623090538.154858-2-derick.william.moraes@gmail.com>
X-Mailer: git-send-email 2.50.0.rc0.62.g658f0ae201.dirty
In-Reply-To: <20250623090538.154858-1-derick.william.moraes@gmail.com>
References: <4deb24c2-98f2-40f8-b50c-c74485ebc10d@kdbg.org>
 <20250623090538.154858-1-derick.william.moraes@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add diff pattern for JavaScript programming language and documentation. 

Signed-off-by: Derick W. de M. Frias <derick.william.moraes@gmail.com>
---
 Documentation/gitattributes.adoc |  2 ++
 userdiff.c                       | 62 ++++++++++++++++++--------------
 2 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/Documentation/gitattributes.adoc b/Documentation/gitattributes.adoc
index f20041a323..b7075ccb29 100644
--- a/Documentation/gitattributes.adoc
+++ b/Documentation/gitattributes.adoc
@@ -891,6 +891,8 @@ patterns are available:
 
 - `java` suitable for source code in the Java language.
 
+- `javascript` suitable for source code in the JavaScript language.
+
 - `kotlin` suitable for source code in the Kotlin language.
 
 - `markdown` suitable for Markdown documents.
diff --git a/userdiff.c b/userdiff.c
index 94134e5b09..0d352bc722 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -238,33 +238,43 @@ PATTERNS("java",
 	 "|[-+*/<>%&^|=!]="
 	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
 PATTERNS("javascript",
-     /* conventional named functions */
-     "^[ \t]*(async[ \t]+)?function[ \t]*\\*?[ \t]*([$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*\\(.*$|"
-     /* assigned functions */
-     "^[ \t]*(const|let|var)[ \t]+([$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*="
-     "[ \t]*(async[ \t]+)?function[ \t]*\\*?[ \t]*([$_a-zA-Z][$_a-zA-Z0-9]*)?[ \t]*\\(.*$|"
-     /* arrow functions */
-     "^[ \t]*(const|let|var)[ \t]+([$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*="
-     "[ \t]*(\\([^\\)]*\\)|[$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*=>[ \t]*\\{?.*$|"
-     /* functions declared inside classes and objects */
-     "^[ \t]*(static[ \t]+)?(async[ \t]+)?(get[ \t]+|set[ \t]+)?\\*?[ \t]*"
-     "([$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*\\([^)]*\\)[ \t]*\\{.*$",
-     /* identifiers */
-	 "[$_A-Za-z][$_A-Za-z0-9]*|"
-     /* hexadecimal and big hexadecimal */
-     "0[xX](?:[0-9a-fA-F](?:_?[0-9a-fA-F])*)n?|"
-     /* octa and big octa */
-     "0[oO](?:[0-7](?:_?[0-7])*)n?|"
-     /* binary and big binary */
-     "0[bB](?:[01](?:_?[01])*)n?|"
-     /* decimal, floting point and exponent notation (eE) */
-     "(?:0|[1-9](?:_?[0-9])*)(?:\\.(?:[0-9](?:_?[0-9])*))?(?:[eE][+-]?(?:[0-9](?:_?[0-9])*))?|"
-     /* big decimal */
-     "(?:0|[1-9](?:_?[0-9])*)n|"
+	 /* don't match reserved expressions that have function-like syntax */
+	 "!^[ \t]*(if|do|while|for|with|switch|catch|import|return)\n"
+	 /* matches conventional named functions, that can also be async and/or have export */
+	 "^[ \t]*(export[ \t]+)?(async[ \t]+)?function[ \t]*\\*?[ \t]*"
+	 "([$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*\\(.*$"
+	 /* matches assigned exports */
+	 "|^[ \t]*export[ \t]*(const|default)[ \t]*([$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*="
+	 /* matches assigned functions */
+	 "|^[ \t]*(const|let|var)[ \t]+([$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*=[ \t]*"
+	 "(async[ \t]+)?function[ \t]*\\*?[ \t]*([$_a-zA-Z][$_a-zA-Z0-9]*)?[ \t]*\\(.*$"
+	 /* arrow functions */
+	 "|^[ \t]*(const|let|var)[ \t]+([$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*=[ \t]*"
+	 "(\\([^\\)]*\\)|[$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*=>[ \t]*\\{?.*$"
+	 /* matches functions declared inside classes and objects */
+	 "|^[ \t]*(static[ \t]+)?(async[ \t]+)?(get[ \t]+|set[ \t]+)?\\*?[ \t]*"
+	 "([$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*\\([^)]*\\)[ \t]*\\{.*$"
+	 /* matches functions created or assigned in 'exports.' or 'module.exports.' context*/
+	 "|^[ \t]*(module.)?exports.([$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*="
+	 "([ \t]*(async[ \t]+)?(function)?[ \t]*\\*?[ \t]*"
+	 "([$_a-zA-Z][$_a-zA-Z0-9]*)?[ \t]*\\(.*$"
+	 "|[ \t]*([$_a-zA-Z][$_a-zA-Z0-9]*);"
+	 "|[ \t]*(async[ \t]+)?([$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*=>)",
+	 /* identifiers */
+	 "[$_A-Za-z][$_A-Za-z0-9]*"
+	 /* hexadecimal and big hexadecimal */
+	 "|0[xX](?:[0-9a-fA-F](?:_?[0-9a-fA-F])*)n?"
+	 /* octa and big octa */
+	 "|0[oO](?:[0-7](?:_?[0-7])*)n?"
+	 /* binary and big binary */
+	 "|0[bB](?:[01](?:_?[01])*)n?"
+	 /* decimal, floting point and exponent notation (eE) */
+	 "|(?:0|[1-9](?:_?[0-9])*)(?:\\.(?:[0-9](?:_?[0-9])*))?(?:[eE][+-]?(?:[0-9](?:_?[0-9])*))?"
+	 /* big decimal */
+	 "|(?:0|[1-9](?:_?[0-9])*)n"
 	 /* punctuation */
-	 "\\{|\\}|\\(|\\)|\\.|\\.{3}|;|,|<|>|<=|>=|==|!=|={3}|!==|\\+|-|\\*|/|%|\\*{2}|"
-	 "\\+{2}|--|<<|>>|>>>|&|\\||\\^|!|~|&&|\\|{2}|\\?{1,2}|:|=|\\+=|-=|\\*=|%=|\\*{2}=|"
-	 "<<=|>>=|>>>=|&=|\\|=|\\^=|&&=|\\|{2}=|\\?{2}=|=>"),
+	 "|\\.{3}|<=|>=|==|!=|===|!==|\\*{2}|\\+{2}|--|<<|>>|>>>|&&|\\|{2}|\\?{2}|\\+=|-="
+	 "|\\*=|%=|\\*{2}=|<<=|>>=|>>>=|&=|\\|=|\\^=|&&=|\\|{2}=|\\?{2}=|=>"),
 PATTERNS("kotlin",
 	 "^[ \t]*(([a-z]+[ \t]+)*(fun|class|interface)[ \t]+.*)$",
 	 /* -- */
-- 
2.50.0.rc0.62.g658f0ae201.dirty

