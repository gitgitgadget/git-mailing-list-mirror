Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F87200CB
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742821440; cv=none; b=SDulll/M3T4lS3zhQSL32Ckm3WLqowc17WpnWuXXmIE/HinsEwUBfWwjZBhnvDaes02/SAj01u8XCOHdZnUzZrtJVxuYZjTCyzDADHfjvqt9j+RSkMdaLeXbnzrvQ5hKRpcG/W/YPf3Z43lGSHmQczyOE63t6/62nlvts+pM0uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742821440; c=relaxed/simple;
	bh=H3XjKr6TpgCM9fpvcKPK+NaqSy8QEliyIJF+A8uTxb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkLNrM+sgKMyVT7e2qiC1SHbfKkFYwv5lOW4COUaZ6pV0yNQtj4o7SZRPLIReyAE6sVrJ754TQ5l1kdxnDU7TDak87QIZD9Vh/saOZGDdBtY8LvSlArkTQLOkrL4aNAlpR7Gi6ZJVvSnGaoLr95Bupv2LRPJqeO+pw8GqFPiU9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWJcH5Sr; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWJcH5Sr"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22409077c06so80056785ad.1
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 06:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742821438; x=1743426238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1G/yYpYw2nuxnGVXCypvuCz5hX9Nxf8oq7N+cjuKkAM=;
        b=RWJcH5Sr4ZgwiGo7zHWu4jFVTeobTLPJnGRCWPHLXuVFYQOHxO51w1USbEF4QLyJP5
         FbDCbR5ZRlFJKVCz6N62+n+2EquVrpQt/1t7VPa94tNSbM3bv2Tv/qpJbXX/Fjm3LYZl
         uf2QREJVOWrj5WdqOzmLkEDDcPKkOD+2pYeCFwPR2yXSblh3/9CSvs96w82IjagJT9Ef
         fzXn+TyrEkaPjGA118/Ncs6oPuG9fdcvaUrYOlm3rN5VthPSfWnaInDEXJ9SziOstlKq
         kPqStMZTWYLyQAoVg89Mtzj8ZbLC7092SBRjhdFr+qhlf6ohjOrwaifuo+xFO41j5ytF
         jIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742821438; x=1743426238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1G/yYpYw2nuxnGVXCypvuCz5hX9Nxf8oq7N+cjuKkAM=;
        b=DO8tBz8DmpC4MW/HUZeY806VPKaR8GFxzcgM7uuMLNS4kMd9UeVHMszF0dVPpI+QX5
         Du3rfw1tsbntOIH6xchSlTWRstSdpsMIFJF0iATwlaT1fn734OSnmn1exkaankC21f3i
         UeoqPha0Zt+470iHqSvASJWzDrYXDCySJ2CeyVO2vKLx8IADzQOWta4HT4XhZ3tCcMQB
         qrbmVG9LwsUQXFgazFG160IaR0OStBMumuouqgKi5U6FakNEm4qPoT1AeJTtChkNIYAt
         FNE38+/SiNdhzerTUNgkao8OLFUrqtrfjpaOZnzvchp7AwUohOs4KSXnv5gW4VIoMGL1
         7PRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUojWRAN0oIKfmChZCtRoJq+4CpTvA/kzkdXaGaIXZOVu5Fon+QwcXo6XFZU8yEGJT7NWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUB1i+lwpjzKdXKSoEsXf5xo4Zqo1hkVqq8tfSQROiO10bDcZr
	+e1QreUJvqa0jHysR+kuTDtmEAs6gKcfKMuv+m0RWA5rjDBQql27
X-Gm-Gg: ASbGnct8s1dBiVXOGZTXA/AGsaQLV77XoLdkDdor1FR5k1VwEerG2QmmZ6RdZWG4ErR
	4CyJBaf1urJVfQU6IQ6WWGkZ1gk9WpAb7EMLxp9qkWaWDZGHJqYrvJqVW9F0meQO4rr9q4X5zSH
	jLISvBZbLqWOozj8k9dCKToEZL3twcQSW2jcl4EjoyP9dTRN89dLw7fzjKvhYF8sOyeRt+JMs9p
	lo2jgbGmzZwrcWrcUhHh+dDn9hLSmdeOGw8QOJggOdQA6rm53FyZCa7Efg1hTHah37BqZ5r+VYG
	zdJNvduPc6dgXcTAR3foxYM9KpLI+YaABrkIH4caLlT/CN5ApTB4Jey/RDAkGYQl2ZoibLLYPs6
	2SHHz8BkaJr+56A==
X-Google-Smtp-Source: AGHT+IERQ0wxtqrD07ILUVYzx3XQypaeLe6HEDyngyvROMHstaplDhfzPs9QD64cAUGik+uQ2koYcA==
X-Received: by 2002:a17:903:1d2:b0:223:536d:f67b with SMTP id d9443c01a7336-22780e0947bmr164527385ad.38.1742821437744;
        Mon, 24 Mar 2025 06:03:57 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c005:b018:5841:514c:af52:5598])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390618dd29sm7795807b3a.167.2025.03.24.06.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 06:03:57 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gitster@pobox.com
Cc: ben.knoble@gmail.com,
	git@vger.kernel.org,
	jayatheerthkulkarni2005@gmail.com
Subject: [[GSOC][PATCH v4] 2/3] docs: update function signature, add UNUSED macro
Date: Mon, 24 Mar 2025 18:33:42 +0530
Message-ID: <20250324130343.113629-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <xmqq34f3qbna.fsf@gitster.g>
References: <xmqq34f3qbna.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 9b1cb507 (builtin: add a repository parameter
for builtin functions,  2024-09-13), built-in
commands now receive a `struct repository *` argument
for improved repository context handling.
Update example function signatures in the documentation
to align with this current convention.

Also, update `builtin.h` accordingly
and use the `UNUSED` macro to suppress
warnings for unused parameters in example code.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 7b856be41e..45efe117ab 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -142,9 +142,13 @@ followed by the name of the subcommand, in a source file named after the
 subcommand and contained within `builtin/`. So it makes sense to implement your
 command in `builtin/psuh.c`. Create that file, and within it, write the entry
 point for your command in a function matching the style and signature:
-
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix)
+int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo)
+----
+Before proceeding further, we should use the UNUSED macro to suppress warnings about unused parameters in the function.
+This prevents the compiler from generating warnings when certain parameters are not used within the function body:
+----
+int cmd_psuh(int argc UNUSED, const char **argv UNUSED, const char *prefix UNUSED, struct repository *repo UNUSED)
 ----
 
 We'll also need to add the declaration of psuh; open up `builtin.h`, find the
@@ -152,7 +156,7 @@ declaration for `cmd_pull`, and add a new line for `psuh` immediately before it,
 in order to keep the declarations alphabetically sorted:
 
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix);
+int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo);
 ----
 
 Be sure to `#include "builtin.h"` in your `psuh.c`. You'll also need to
@@ -168,7 +172,7 @@ Throughout the tutorial, we will mark strings for translation as necessary; you
 should also do so when writing your user-facing commands in the future.
 
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix)
+int cmd_psuh(int argc UNUSED, const char **argv UNUSED, const char *prefix UNUSED, struct repository *repo UNUSED)
 {
 	printf(_("Pony saying hello goes here.\n"));
 	return 0;
@@ -199,6 +203,9 @@ with the command name, a function pointer to the command implementation, and a
 setup option flag. For now, let's keep mimicking `push`. Find the line where
 `cmd_push` is registered, copy it, and modify it for `cmd_psuh`, placing the new
 line in alphabetical order (immediately before `cmd_pull`).
+----
+{ "psuh", cmd_psuh, RUN_SETUP}
+----
 
 The options are documented in `builtin.h` under "Adding a new built-in." Since
 we hope to print some data about the user's current workspace context later,
@@ -285,6 +292,8 @@ Modify your `cmd_psuh` implementation to dump the args you're passed, keeping
 existing `printf()` calls in place:
 
 ----
+int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
+{
 	int i;
 
 	...
@@ -298,7 +307,8 @@ existing `printf()` calls in place:
 
 	printf(_("Your current working directory:\n<top-level>%s%s\n"),
 	       prefix ? "/" : "", prefix ? prefix : "");
-
+	...
+}
 ----
 
 Build and try it. As you may expect, there's pretty much just whatever we give
-- 
2.48.1

