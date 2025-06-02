Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E19D2C325A
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748897449; cv=none; b=LKv3v95uCJ8jvsW+u3Ms4ePa+n9J7ZlKwcuN6Eb43JsABX/HGExBLoWz75PLmaeJiMExy5KHwLXha0r/1XZns0s7RFLSgczvh8bF3n9U0b6VBrOF8EPzPSvW6QUv724SnG2FmuCFpDbkMHNy1Hh5X9T8MMa38c4c3IqmRpAmaBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748897449; c=relaxed/simple;
	bh=kuVSFSgYsyFrzwntYiq5MjM8BXCeTRyyKXMLCJ5C9cw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BtEHgtY4oUyo7j9R3PMSLlMhDfxm+sgghcg/9fc4OWg9dL/EB4V51j6S0eOKxuLq3YYVMQdMvPoZPEbWHZEdDIi0th+3UVh4BdXwdDZFaeW04t/81BDoeYsZ2Oz1Jp4tNFRPOJtnxKHiV9dAll6Lwsmr3CGR9ARmKoBoNkRzJ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WX9RynUy; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WX9RynUy"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4e45dae6c8cso3545762137.2
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 13:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748897446; x=1749502246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVV/737LLZCvBMfg45KqvH/rKA4gLDW5kXNinUs5Y+c=;
        b=WX9RynUyt/AN2o6MYJGByYA3ecBXQBkgOJVhYqkX2jzbJVIDHBSLRxLslRN1Vxllw8
         gLvnzXSAi175r5hrqUPnEUf5QTSL73WCCxdvecYUZDSr0VYUUs1HFWzjjfziZHAKEfwG
         qfSKXjKCqsNRLxfv9tUpmkuBbXbJQMOqBVOrKWHdpbDT7uNh7w3Uw2VnTC42hJ5rSR6c
         KVqNeHFT0MHezz4eo6M4LcyY7Jpl5kKwiIfiC1595AQ0Ll0gNWvg5mT6+xZo/JdGiRXo
         K7oobB1SpLuMyDQjxc/pKspysLbgb9sLQtMkYZaADdMMb2AnzNWJqL2gMjlUSovW9gFf
         /rCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748897446; x=1749502246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVV/737LLZCvBMfg45KqvH/rKA4gLDW5kXNinUs5Y+c=;
        b=D/a2wsqQ9s3NU0S8z1HnmM6mJcD0nksPWK7HraPm01J9QQDGHXF/g1MaHpW1k74tSM
         1V//9K1M0kcyG7pzGAYN9wu7aIiX4EDEOM0TZDa4lEE0J1rjugrkR6IGVWoRitmu+hWR
         0NfHmKNWqXbk2x4SCfaoogegR6Dk6JMA7JhqKZ7Sn9Z+pzw9oN4DNJGtEAYt2tbau3q3
         GsWV/dkrPqicqZSpCr41aDVG5oTWWSN0RrjowAbePK2Y7QKdczHqVm+yiJ/ssSMLG1t9
         vwEoBzNVlOe5cL7Bv44y+TAukTA3lEQqyGwTkrQ32lNG9DnrfoljoHLIXIM2VmQfCgRK
         VM9w==
X-Gm-Message-State: AOJu0YyHOhzWqoCsblCOk4U0qp91R6Tu9QuUyiYdzPftFjjWRVirPP+r
	JaAIw0c0DOxgqNDu+HRyz6oViitWDqMd/bpz2l+vUMt/ljJo1crHX+DkjiPwbg==
X-Gm-Gg: ASbGnctVQ2GqeiVo5t6qec2aiIK4Cc8g0F3/ws0pZyNqEipud6ARCTVWlDi+DUwe24K
	/66+2Kob0xDdr91DXHJeu8JXM/Dy6NHSilaVZdeikE0HI6pXkCXDykmvsWI/ZaYyddz67mCbRSa
	YojJgfUVNYKMR0dblfi+hCaRPOQoRt4K28pHEPlFCx4fzr4raJPyB423At5OtI5CquHFdxk+YYV
	xdIDV/SaxAeogN/SHr/VSlZgn14haLKBh06HNu2aWUUu0Bpe+dfJio4oq8uzft4PlJAPWFXi3SX
	d8Fkc0eLcIZl9SbqIZu6icpaKMjelJSJ4wWBYIEz5dmQLRTUUpn8DGhpglcCd9ZjKMPqkEsZm3D
	3N4tgPjrS+12RtNuBEUKz
X-Google-Smtp-Source: AGHT+IHv6mQmwM5y9sAzw5tbwa0d/flauNy5szBZlpqEQ4ro+8/TDUIYEn/SNClUpXfdX5/IMyHOOQ==
X-Received: by 2002:a05:6102:358d:b0:4c1:9526:a636 with SMTP id ada2fe7eead31-4e701adfc86mr7974088137.15.1748897435795;
        Mon, 02 Jun 2025 13:50:35 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:b77d:58:c47c:a673:bf76:10ce])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87e2a2a1622sm6746409241.10.2025.06.02.13.50.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Jun 2025 13:50:35 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v2 1/2] MyFirstContribution: use struct repository in examples
Date: Mon,  2 Jun 2025 17:50:20 -0300
Message-Id: <20250602205021.4223-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250602205021.4223-1-lucasseikioshiro@gmail.com>
References: <20250529192036.75408-1-lucasseikioshiro@gmail.com>
 <20250602205021.4223-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the parameter `struct repository *repo` to the cmd_walken function.

Since commit 9b1cb5070f (builtin: add a repository parameter for
builtin functions, 2024-09-13), all the cmd_* have the `repo` parameter
and new commands must follow this convention, so the documentation
should also be changed.

Change the `git_config` calls to `repo_config`, also passing the `repo`
parameter, as since 036876a106 (config: hide functions using
`the_repository` by default, 2024-08-13) the non-repo config functions
are no longer recommended as they use the global `repository` variable.

Helped-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/MyFirstObjectWalk.adoc | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.adoc b/Documentation/MyFirstObjectWalk.adoc
index f03753dfc0..a4ba6e21ec 100644
--- a/Documentation/MyFirstObjectWalk.adoc
+++ b/Documentation/MyFirstObjectWalk.adoc
@@ -43,7 +43,7 @@ Open up a new file `builtin/walken.c` and set up the command handler:
 #include "builtin.h"
 #include "trace.h"
 
-int cmd_walken(int argc, const char **argv, const char *prefix)
+int cmd_walken(int argc, const char **argv, const char *prefix, struct repository *repo)
 {
 	trace_printf(_("cmd_walken incoming...\n"));
 	return 0;
@@ -86,7 +86,7 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
 Also add the relevant line in `builtin.h` near `cmd_version()`:
 
 ----
-int cmd_walken(int argc, const char **argv, const char *prefix);
+int cmd_walken(int argc, const char **argv, const char *prefix, struct repository *repo);
 ----
 
 Include the command in `git.c` in `commands[]` near the entry for `version`,
@@ -193,7 +193,7 @@ initialization functions.
 
 Next, we should have a look at any relevant configuration settings (i.e.,
 settings readable and settable from `git config`). This is done by providing a
-callback to `git_config()`; within that callback, you can also invoke methods
+callback to `repo_config()`; within that callback, you can also invoke methods
 from other components you may need that need to intercept these options. Your
 callback will be invoked once per each configuration value which Git knows about
 (global, local, worktree, etc.).
@@ -221,14 +221,14 @@ static int git_walken_config(const char *var, const char *value,
 }
 ----
 
-Make sure to invoke `git_config()` with it in your `cmd_walken()`:
+Make sure to invoke `repo_config()` with it in your `cmd_walken()`:
 
 ----
-int cmd_walken(int argc, const char **argv, const char *prefix)
+int cmd_walken(int argc, const char **argv, const char *prefix, struct repository *repo)
 {
 	...
 
-	git_config(git_walken_config, NULL);
+	repo_config(repo, git_walken_config, NULL);
 
 	...
 }
@@ -250,14 +250,14 @@ We'll also need to include the `revision.h` header:
 
 ...
 
-int cmd_walken(int argc, const char **argv, const char *prefix)
+int cmd_walken(int argc, const char **argv, const char *prefix, struct repository *repo)
 {
 	/* This can go wherever you like in your declarations.*/
 	struct rev_info rev;
 	...
 
-	/* This should go after the git_config() call. */
-	repo_init_revisions(the_repository, &rev, prefix);
+	/* This should go after the repo_config() call. */
+	repo_init_revisions(repo, &rev, prefix);
 
 	...
 }
@@ -305,7 +305,7 @@ Then let's invoke `final_rev_info_setup()` after the call to
 `repo_init_revisions()`:
 
 ----
-int cmd_walken(int argc, const char **argv, const char *prefix)
+int cmd_walken(int argc, const char **argv, const char *prefix, struct repository *repo)
 {
 	...
 
-- 
2.39.5 (Apple Git-154)

