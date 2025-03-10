Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7592206BD
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 18:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630132; cv=none; b=AubBtpLexx+0WkgKUB8van/2pQPvWJyCbYq8A1OdpUNcyQY/YgK6hzFw4k1QaEz3HoQuDjj4Sa3xoUHmf6etTShTC2Rq5v+kKCAbHPIrwnM+64sZaF6xqh+UlVax5eBMUj07+xy+GwxoCv5FkId2C3oEuEFKFwqy6Jr/DyVP/+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630132; c=relaxed/simple;
	bh=KV4FrTi2yPYYFiXCW6+P9Zo4j2IW7CbBCtJXqJ3rlMU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=mQ/x+8Dzb2nj8ielTdkOo/xp95vRy/276z8UG8IUXO2k5JOznqJb/m274MhikR3GOvWnWdSsUNalzfvkYuE2VapFr7O7gl6UWauw7k2nIh5GrlfHvApFcwFnC3TcTLYz/g2hxGMiY27b0HGupjDj95nUt8wdP4Gg7hHb/wu0fYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlPSfNI6; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlPSfNI6"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso6976782a91.1
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 11:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741630130; x=1742234930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGSeM2ad00JvAAmXH6Ixwi39sL8eIN/g7ErEPu6YIVs=;
        b=dlPSfNI6rc2kTEK3jzz0SpdmbelaOMtVQDWXbiQcsdlVfl37TNrm/vjT/VhwqWlNr3
         a+xZUoddAD9IzhIspxXGyZmMuEU/3rLBMmSyZP9P+UzcavKJ/WeDDNWKzEPvdbZtdfe7
         L+mfLwF+o3DFMxz6miTptXBNHqnLQgdnMbNFulO2EO2qK0I8Wqv3UHbcSaxMkKqFR973
         Yha+8HJkFsOw9sgxCc7Qk88oz5KkRYC2bTa40Sy1tZqV90nQp7CoRN9LQvXpNYQYmDyb
         qlbfX/BDCi7u9ixJpfz7jk8XFbkNxlILKHBMolvPWNMlik8fbbEnoPGc00qLbM3JcrrZ
         Qdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741630130; x=1742234930;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGSeM2ad00JvAAmXH6Ixwi39sL8eIN/g7ErEPu6YIVs=;
        b=INqweQS8ovWFvM7uaEBdKwSSBaSZIHaBinz+osaBfVBa7EQwkd3jEgOhYojOdTYlDR
         W1yEJuY3w8TiFp7VS23B5hH1zknkZ+2W8xZzJCS7rND9AHuirWpYTxOF9LY8PpAC4ZCP
         wpUMSH4xmMROqrwf6EM8uvj7b7U7XXEtSqivbLlaPajLgT6xFk8tgP6cLo51AC75PBre
         mfasppNRsnIFDWrSTZYWfh9ho+byjY6cGM8+0DjebLM1gq319FMUOBU3scozAiPEgxzU
         GZCRjxWe1Ilqj1NCGKKwHBSmk2riZHlJFbrBhox9ql8qnKDTbL+RE09oQkm9ymY6S6c7
         tc/g==
X-Gm-Message-State: AOJu0Yw98KL/7BYlCVA9Dl6OSoXI+g6IyWujgO9UhIMQviAC95xX6ENg
	jgyXmLU+SPnIZuASrx8ELaeY9nZWHR3l2WgT2UlFyDbcFCMe3VkUDIOOOQ==
X-Gm-Gg: ASbGncurDJtMmLeoL+Yvj84kKOA/D9YJ9qz9RsJu5k7eMzODaJITJ0F1Dz5qLtc7jwA
	YET0Y7/I3GS8ZX8B35BoRhwWlsAWvGwg9E+bSMfqxlW0MtoAjWvjgfBbUHRmeNPMgVBXf/8M/Ve
	mtGEjDY981f9w702vyQTNtSAxqF5Nnf72PFqAQlvM34q7rE5RBsfAwu4/LwAWA3RBpeg46t2veA
	n4TC0pgS7j+IPaNZr4ORVRg+KNouQXiJu6rWOXdFhRzhCyRI7A4jgt8MOo/xAgXYbNisrXgvYJh
	qHHglDZDOj0H7ILMHOMbMc9ZP0O11gRmeWJTzRcT/v+8i/SIKerLLsY4k0fEMMWJjnktua9Oeju
	HB5OOaCuLFwdEWJp+6Y7AabRi
X-Google-Smtp-Source: AGHT+IHXfXDx4Y7OuQx2ucbYv0wJlXGtQiWLW/MYuOh7nso5sC2L3GP3p4p/RtYSPszleotrJ4238A==
X-Received: by 2002:a17:90b:1c07:b0:2fe:7f40:420a with SMTP id 98e67ed59e1d1-2ff7cea6996mr25156537a91.17.1741630129612;
        Mon, 10 Mar 2025 11:08:49 -0700 (PDT)
Received: from ?IPV6:2402:3a80:4163:e5a:15b1:e92d:8ad3:3f81? ([2402:3a80:4163:e5a:15b1:e92d:8ad3:3f81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-300d2ad6d19sm2975197a91.38.2025.03.10.11.08.48
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 11:08:49 -0700 (PDT)
Message-ID: <7c219279-8151-49c0-8fc0-8abe2624aca9@gmail.com>
Date: Mon, 10 Mar 2025 23:38:53 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [GSoC PATCH v2] decorate: fix sign comparison warnings
From: Arnav Bhate <bhatearnav@gmail.com>
To: git@vger.kernel.org
References: <afa6b428-3190-42ae-9eac-540c95b576fd@gmail.com>
Content-Language: en-US
In-Reply-To: <afa6b428-3190-42ae-9eac-540c95b576fd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There are multiple instances where ints have been initialized with
values of unsigned ints, and where negative values don't mean anything.
When such ints are compared with unsigned ints, it causes sign comparison
warnings.

Also, some of these are used just as stand-ins for their initial
values, never being modified, thus obscuring the specific conditions
under which certain operations happen.

Replace int with unsigned int for 2 variables, and replace the
intermediate variables with their initial values for 2 other variables.

Signed-off-by: Arnav Bhate <bhatearnav@gmail.com>
---
 decorate.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/decorate.c b/decorate.c
index e161e13772..9f24925263 100644
--- a/decorate.c
+++ b/decorate.c
@@ -3,8 +3,6 @@
  * data.
  */
 
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 #include "object.h"
 #include "decorate.h"
@@ -16,9 +14,8 @@ static unsigned int hash_obj(const struct object *obj, unsigned int n)
 
 static void *insert_decoration(struct decoration *n, const struct object *base, void *decoration)
 {
-	int size = n->size;
 	struct decoration_entry *entries = n->entries;
-	unsigned int j = hash_obj(base, size);
+	unsigned int j = hash_obj(base, n->size);
 
 	while (entries[j].base) {
 		if (entries[j].base == base) {
@@ -26,7 +23,7 @@ static void *insert_decoration(struct decoration *n, const struct object *base,
 			entries[j].decoration = decoration;
 			return old;
 		}
-		if (++j >= size)
+		if (++j >= n->size)
 			j = 0;
 	}
 	entries[j].base = base;
@@ -37,8 +34,8 @@ static void *insert_decoration(struct decoration *n, const struct object *base,
 
 static void grow_decoration(struct decoration *n)
 {
-	int i;
-	int old_size = n->size;
+	unsigned int i;
+	unsigned int old_size = n->size;
 	struct decoration_entry *old_entries = n->entries;
 
 	n->size = (old_size + 1000) * 3 / 2;
@@ -59,9 +56,7 @@ static void grow_decoration(struct decoration *n)
 void *add_decoration(struct decoration *n, const struct object *obj,
 		void *decoration)
 {
-	int nr = n->nr + 1;
-
-	if (nr > n->size * 2 / 3)
+	if ((n->nr + 1) > n->size * 2 / 3)
 		grow_decoration(n);
 	return insert_decoration(n, obj, decoration);
 }
-- 
2.48.1
