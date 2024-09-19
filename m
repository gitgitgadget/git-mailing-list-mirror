Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEF259167
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770901; cv=none; b=RYwzAXTZjf9KuieMeoA9VkEiL2apKfuyPNlR2g4SZiAtkx4Ho+oSZ474fkLT11fssDJwq6vhJBRLSlVnyFv/gRONf/5Ay6pwtt5Lb03BArcQKjpYaxLyhKtHOzWzmkZSNvyW+MeLYP35kprwDWN6j6X7AkqaXBQJrQXMojwfhtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770901; c=relaxed/simple;
	bh=fWrKeHbLwtUNeOD9wQbGj8bN9W70s6APZ0U5Mw8xD6c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GRFW1Xrt1qLYdOI0P/REK3KlRuJH/k00tfc6VYA5g14GdFR6ZZ5LviyWy05ZAN7kFwx2o4ndi87VkI/bODtZZj4oABsTIv+8U1ie/rWXEpzxT02vExzB2eAff4MI+SSjMENvaU/akb2kKTY54J3jvPq3qNHfFS7W/0HwaCH9ZEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQuPDVq5; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQuPDVq5"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c27067b81aso1564553a12.0
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 11:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726770898; x=1727375698; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuOmSxSpkGf8qVKaucukDYXQmh7UvS8M5DrYnhC6NaE=;
        b=GQuPDVq5IVmAZ5kcMXuI0TkkwBVdtjEJaITXa7sAlukTq1pfWjU21lKNS3fgFz01ST
         rF8zwEVyo4yTVZl2SuZ0OBf3yNcmmxp+9lXZ42QUGeXiGTZ/OR8AOY4/t+/vIl3i51ho
         BzrbazK7yb1xC7RJ1tTP8tojLdVzseSf1r//U/2zN2vddeJ3ymdsgXLlfDR5g+UQxFqx
         agwDm61VEZz0QEx7Rr7VtamrC3NFkTpM744zxE9tze4GWm8ApRt+gsnEZiFtnqo2+7BU
         TWDEDmwd6P9ZdxGvIfFDPN/yaU/i0LoZJMTdw3uRaKCWwh3xb2XuGJQkI7PikFNpQRBp
         RDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726770898; x=1727375698;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuOmSxSpkGf8qVKaucukDYXQmh7UvS8M5DrYnhC6NaE=;
        b=Ve9oKkSz/zLshGjxFylEv0iAyioeyRd9OhNCnBTDsnIUZ7W922/ZDehkXDyWuMWt6R
         TZeY/vGCcj1SnPEL3Q7phlEFsasNlIR6y5drp197mBV8PpBV2zQM2wHx/J3m8YV5cNhF
         Ldz6jNIeaeM7wr5sSs7FV58MfRQAUPrSovW4fcXTubKbTzI8EVl/7As21suW7JTXv4Rw
         IznUy6rh3wS7ILoNbY3pwpucn/hqpRfbJJYN9ODsuNVI1fuWmdFsYvUywcnS4yjTInAa
         46MT45QEHPWt8zSuDZfvUvbb+rl+2YH+rup3Ao3JHC6GlV66SX8/b0afgohS8Y9Jyfgq
         m/zw==
X-Gm-Message-State: AOJu0YyLG1QEWHawZ4MlXaXE9UbJJLmxpTlQOI8ShZDz2KWOTL0P2lGk
	x1rC0Nr3/1DortgqO2rF0hDYu4PK+i/Q20mIxjLe8LL29mcSdDa8E5Kjgg==
X-Google-Smtp-Source: AGHT+IGoRTY/po5ta0myjhr/75IIeDKXxBdOdcQX723s2C4TM6AcpGL6ErGDLWq/vVBzc1JX2V+NgQ==
X-Received: by 2002:a17:907:c898:b0:a86:95ff:f3a0 with SMTP id a640c23a62f3a-a90d4fbcf75mr15224866b.3.1726770898023;
        Thu, 19 Sep 2024 11:34:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967a5sm755832266b.21.2024.09.19.11.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 11:34:56 -0700 (PDT)
Message-Id: <1e21964bb14a0b6a4c00b5a1848db655423041d3.1726770881.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
References: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
From: "Andrew Kreimer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Sep 2024 18:34:35 +0000
Subject: [PATCH 15/20] refs: fix typos
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
Cc: Andrew Kreimer <algonell@gmail.com>,
    Andrew Kreimer <algonell@gmail.com>

From: Andrew Kreimer <algonell@gmail.com>

Fix typos in comments.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 refs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs.h b/refs.h
index f8b919a1388..6d06098f8f4 100644
--- a/refs.h
+++ b/refs.h
@@ -16,7 +16,7 @@ enum ref_storage_format ref_storage_format_by_name(const char *name);
 const char *ref_storage_format_to_name(enum ref_storage_format ref_storage_format);
 
 /*
- * Resolve a reference, recursively following symbolic refererences.
+ * Resolve a reference, recursively following symbolic references.
  *
  * Return the name of the non-symbolic reference that ultimately pointed
  * at the resolved object name.  The return value, if not NULL, is a
@@ -488,7 +488,7 @@ int refs_delete_reflog(struct ref_store *refs, const char *refname);
  * from UTC.  Its absolute value is formed by multiplying the hour
  * part by 100 and adding the minute part.  For example, 1 hour ahead
  * of UTC, CET == "+0100", is represented as positive one hundred (not
- * postiive sixty).
+ * positive sixty).
  *
  * The msg parameter is a single complete line; a reflog message given
  * to refs_delete_ref, refs_update_ref, etc. is returned to the
@@ -986,7 +986,7 @@ struct ref_store *get_worktree_ref_store(const struct worktree *wt);
 
 /*
  * Some of the names specified by refs have special meaning to Git.
- * Organize these namespaces in a comon 'ref_namespace' array for
+ * Organize these namespaces in a common 'ref_namespace' array for
  * reference from multiple places in the codebase.
  */
 
-- 
gitgitgadget

