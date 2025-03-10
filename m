Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0452253F7
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600270; cv=none; b=qm5P0z/njZLnQzuXN+RdkJriCfSo9hZw8TWwX/rzfZP201Eli6M+B1OdCDY7TwwYTQr/Qvs6HwmtWqC9PKFw1bG4njD2VkVr/TWT0xppgr9yIs9EZ7lBS2S+qN2qQHrR15/uzBtu6ez76/o8qFbdIyOrvFmxbvNDwjzWeoMx7m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600270; c=relaxed/simple;
	bh=7kbPunVOR6ujw2txjtLCnvvIEzZ4Wlz96U5oH9vNTmk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=b21Mo5LmiTtW3EzdRmY+X+NK7O9cx4FNF+ctMXpFhPoBTbXeIiSPR2XRlweXp9YAH/an/+bDZTG9MUG8sC90HglYI9Rz77NYnYKmBT8e8AgTBoWeFL4fohq7vpX/DI8saoaWH1u7CFF3msL2GbDRPwgZPu2q0sTblX1SfG8idHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1HLEbxq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1HLEbxq"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22435603572so33335575ad.1
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 02:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741600268; x=1742205068; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cc1zUtOnpqjuyjqC5ggNxAOl8cibiBaD9VXDRF3fm1E=;
        b=j1HLEbxqjAgVp5eKRvzSYfO7ggExbVt1d0q5KsPowovQ6tiY+lPnN2gXt7VGrVjR6Q
         0U7LsVZUyl+MxWWVUHcsXcLhhpsUVrIRAzpodfeUE11IUC9D7cxAAu3bNCyyDxg3QoOB
         qYbKElJA11yqYWYnIgbGGtwnvjAc1G7NuEBtc0Ak8zhSYuvoUdAWgtfLpQgCrURJJ7Xe
         4dl6Il1lxHJjbWDdPOuaIT51sH3H1XkcljUFbd/2aFw/y2DtgC1H0lL6qcunr9kfydOU
         EpqbXLo1mh+Ytj6aO2No8NC7SB7QUTcO5MdgIUvQ1anZ4a2yu6lA57eftb/rQ2KZlzck
         Hd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741600268; x=1742205068;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cc1zUtOnpqjuyjqC5ggNxAOl8cibiBaD9VXDRF3fm1E=;
        b=C4ahI+02CCZ1m2QhLKs94Kh9selGTc3wXCn4H0EFJzJiQJuidXj2qNQvkJwaqhS8qA
         eVwA3VQ+qj4qGO1c0YMScRuQ0qtHyx6+VbarXHCWkL860dUZmm2qwF7HTOd3X60rmRjD
         TUU0e6Q6DjLzYZdL/ERQDbCWXxMutCy4ntzI1w8s5fbXNKW7oV8wjCvL1uiLPee9F0PQ
         wDgYQFiMtm6omaVffmQMq6UP61j7k/XKYE7LYVuA+I+BkChfifpr5U9YpMUd+IzRDQj+
         a6RdoypJxJH+J0/nsJNxmSkb939n8GEUwO15aS/TPW6VYXkbKLOtDC4qKqB5jka83qlO
         yAig==
X-Gm-Message-State: AOJu0Yw4QftXYoiFLJrfobUPSOz0UtjdPpY6EtITr99rvly6Elz+X6Bk
	AbJu2O6aIQrJuBG/oLL5oJ70/iQsHIUxAekFdaASpM+YUkrTtIWzMq1/JQ==
X-Gm-Gg: ASbGncu01ayzuVo7mG8ydEQmCueP0lyO9iPNOUREgKdF0fKb8sAjE5KHPTsyxmZFoew
	dLdA3gSgReH2g/QIAHgV7L/4Jq0wLpuY1LU6u1uTeb8icSYy76DCPTpf4gEAgiBKXXAREQ8Az4n
	thwnK3vZc6KCWNT6cjWtDCLjmf0TkfMqntGrAcqzHQ5b76peEKhROS+VKalZo7FLJC0zykQit0o
	5p38UutIxKZnW+psqVcg201JOWw0QIwsA0p5rb1FoP2H5/00jxrl9AoGzYf6fG+3bQmCnnbXULB
	/YabXp8eGUCpzAZHL9KlvqUp93Va1WU74cfFXwuaR8hFiIDlmg==
X-Google-Smtp-Source: AGHT+IGOsLSPTXHehISnDQMETptgqFcYaL4R34gGfR3GYKA4L7laV2T2rbLLSjVgWAe60BKUgsDcMw==
X-Received: by 2002:a17:902:ce0a:b0:220:cb1a:da5 with SMTP id d9443c01a7336-22428c075e3mr242154665ad.40.1741600267660;
        Mon, 10 Mar 2025 02:51:07 -0700 (PDT)
Received: from [10.61.111.37] ([103.21.124.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a91d4esm73610295ad.198.2025.03.10.02.51.06
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 02:51:07 -0700 (PDT)
Message-ID: <afa6b428-3190-42ae-9eac-540c95b576fd@gmail.com>
Date: Mon, 10 Mar 2025 15:21:11 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Arnav Bhate <bhatearnav@gmail.com>
Subject: [GSoC PATCH] decorate: fix sign comparison warnings
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In two instances, an int was initialized and assigned the value of an
unsigned int. Then, the int was compared to unsigned ints.

Replace int with unsigned int in both cases.

Signed-off-by: Arnav Bhate <bhatearnav@gmail.com>
---
 decorate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/decorate.c b/decorate.c
index e161e13772..8d5774fcdd 100644
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
@@ -16,7 +14,7 @@ static unsigned int hash_obj(const struct object *obj, unsigned int n)
 
 static void *insert_decoration(struct decoration *n, const struct object *base, void *decoration)
 {
-	int size = n->size;
+	unsigned int size = n->size;
 	struct decoration_entry *entries = n->entries;
 	unsigned int j = hash_obj(base, size);
 
@@ -59,7 +57,7 @@ static void grow_decoration(struct decoration *n)
 void *add_decoration(struct decoration *n, const struct object *obj,
 		void *decoration)
 {
-	int nr = n->nr + 1;
+	unsigned int nr = n->nr + 1;
 
 	if (nr > n->size * 2 / 3)
 		grow_decoration(n);
-- 
2.48.1
