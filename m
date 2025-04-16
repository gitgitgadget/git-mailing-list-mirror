Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2800321E08B
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 06:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744784119; cv=none; b=YD2h/7zC8LnKZWalo9k9An20bUc9Cobx6UIMDKsPYx7G3mpiLoQLB0EPyZ79jpzFSUot7YnF/5280YioV/ldfSeVhbeS9BrpKS6NQhCTmDhe1GhEZzPm6S4hkj90CL6Wl7EfkD/Slc16bna553ESQPXBd4VlC9aj0WOEQitAXxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744784119; c=relaxed/simple;
	bh=PgdfRzNqYPBVMQigC9cF0P9GoK9l0CganEgJ5im8hZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaGrAkz7QygmhprF9BHSPs4ScKOirII62XEmiW2lLVJbVXgBoPW/v1jTdavbdSYk0EnTQDxZMDEzJ+n7T+Zv0Xl6XF0MgI1DdJyUv+rOBDI8ww1IwGI9FKzO3jdwNx0hn+i0+AMl3pbc5uzQlTKIZrPNAXViBJoZI2PKMArL7X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQeNY0G9; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQeNY0G9"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-301a4d5156aso6685312a91.1
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 23:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744784117; x=1745388917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYM71+bGXFwqJ1Ol8XLWqDyFlG+BUqcEp92gHIwqnzA=;
        b=kQeNY0G9vQN12DMrpwMBWjgxzekl5ceyGNXn5H/mOu8JaYJiKXJkwbqeODRw4uLRWj
         RIRxA0lc5FTgv4iQLQVcngyWRtvow3kWr/FSgkAzefHHj0fUrcoTM4HxUCNrheQUeRgW
         My4kMHRI/LMJW5EdF8jYoIDPgHFCfT9a8xcBTpaWNKhJqH2iOqaEFMAgilPO5oF/4aK9
         IEPEONoELkoHfYfdmLfrWhahHdZcVweXJ4oS7ubSA0Ql1o5IgfMTQLjh7T6sEKbeYxS8
         PBJyphEqbaNjIazu3LpLXOmRc99I3Gn1VNCUs+xz7N5UwDDK64GduxdDfy2WhhuSaLL/
         bPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744784117; x=1745388917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYM71+bGXFwqJ1Ol8XLWqDyFlG+BUqcEp92gHIwqnzA=;
        b=dfi3xfxoUBicEZBB7VfDGB7yFaHXUUEDmNdbuYxKZDbTCbk5bOfI+zcaXsUYliDXun
         N6fNHnYdWsSxntxxaHxlVlPnKXmXVfmfnKGM4ELYyPhccWREaLi+jh1a9orcgQ7/mJKx
         f4YXL9b3vu6ZYp7X8AfcvoU0hr6+BIiiSNqNMvHggsjgRVCdIyAN0yg+21J1G/ry3BNP
         49IXWnsII2+zDTknP/gqxm46vgz7+bGftZVc9ccnufslHhV14ZTIMgsRZDE8DJ6L70Yu
         WnU54h1r3s1MKyLTeTDIpKEI6GHUfcEUuzMWjF9/kFdHbNhwmTmg7n4cJI6Xk6fpGn+z
         0+og==
X-Gm-Message-State: AOJu0YxG5p6GEXxKQYyCnQARx/KBHpinNqNOaCALpiVhUxfA6ycFNKP5
	8YiSaXFt4il366Pv3bddfmy36CMhne4fmM8f+aqx1r69YMbcvPPmEkIWpA==
X-Gm-Gg: ASbGncsNjJgM2vG72ryQdmZBYQvXS1jl0tc7ww3adjBNC+R2KIofL+LSY0zyOKdYrkk
	Ym/N+fUbrjKAjSx7NF+O2uX6FODaspIxvPa2hl/iF8mVoKbY+cwf5KyZWm6viBMJ/P9rEpSbXwq
	UmaWUUJ/yKpXPlL4JxVqyIpNfS8mSF1G6GC1mzSi7t6Q2Zbmkf4FxwdcroDq3+0F/YmQC9RDSu2
	0dMdNcQmLZ7Y7My2lhl3bbiftM8+rkW7IM02czV6PYdI+sgjNVjS/NgXMg5AaxnUhGgZ84bssro
	PSpQOfs19dYq+RKIyQVzs8BNcMPTu7E2jcPlUmFChcM87O8dtEIJ7DjDaw==
X-Google-Smtp-Source: AGHT+IESahd9x/ST8F2jkppek4rqEBf8hdGrWW0s4vwSVQFeNdOeET1RXr0HhY72B+dyFPh0SfYJlA==
X-Received: by 2002:a17:90b:2751:b0:2ee:5bc9:75c3 with SMTP id 98e67ed59e1d1-30863d1f024mr873533a91.5.1744784117275;
        Tue, 15 Apr 2025 23:15:17 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:5522:eab2:4cba:30d0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308537cdb13sm1688603a91.0.2025.04.15.23.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 23:15:16 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	jayatheerthkulkarni2005@gmail.com
Subject: [PATCH 4/4] cmd_psuh: Prefer repo_config for config lookup
Date: Wed, 16 Apr 2025 11:44:50 +0530
Message-ID: <20250416061450.25695-5-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <20250416061450.25695-1-jayatheerthkulkarni2005@gmail.com>
References: <20250416061450.25695-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit updates cmd_psuh to use repo_config and
repo_config_get_string_tmp for retrieving the user.name config
variable. This is a more robust and correct approach than using the
global git_config functions because:

git_config uses the global configuration, ignoring any
repository-specific settings (e.g., in .git/config). repo_config
loads the configuration specific to the repository,
ensuring that the correct settings are used.

repo_config_get_string_tmp retrieves configuration values
relative to the repository, respecting any local overrides.

This change ensures that cmd_psuh correctly reads the
user.name setting that applies to the current repository,
rather than relying on globalsettings that might be
incorrect or misleading. It also demonstrates the correct way
to access repository-specific configuration within Git commands.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 52 ++++++++++++++++++--------
 1 file changed, 37 insertions(+), 15 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index ed6dcc1fc6..688240ce8b 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -325,26 +325,48 @@ on the command line, including the name of our command. (If `prefix` is empty
 for you, try `cd Documentation/ && ../bin-wrappers/git psuh`). That's not so
 helpful. So what other context can we get?
 
-Add a line to `#include "config.h"`. Then, add the following bits to the
-function body:
+Add a line to `#include "config.h"` and `#include "repository.h"`. 
+Then, add the following bits to the function body:
 
 ----
-	const char *cfg_name;
+#include "builtin.h"
+#include "gettext.h"
+#include "config.h"
+#include "repository.h"  
 
-...
+int cmd_psuh(int argc, const char **argv, 
+			const char *prefix, struct repository *repo)
+{
+    const char *cfg_name;
+
+    printf(Q_("Your args (there is %d):\n",
+              "Your args (there are %d):\n",
+              argc),
+           argc);
 
-	git_config(git_default_config, NULL);
-	if (git_config_get_string_tmp("user.name", &cfg_name) > 0)
-		printf(_("No name is found in config\n"));
-	else
-		printf(_("Your name: %s\n"), cfg_name);
+    for (int i = 0; i < argc; i++) {
+        printf("%d: %s\n", i, argv[i]);
+    }
+
+    printf(_("Your current working directory:\n<top-level>%s%s\n"),
+           prefix ? "/" : "", prefix ? prefix : "");
+
+    repo_config(repo, git_default_config, NULL);
+
+    if (repo_config_get_string_tmp(repo, "user.name", &cfg_name))
+        printf(_("No name is found in config\n"));
+    else
+        printf(_("Your name: %s\n"), cfg_name);
+
+    return 0;
+}
 ----
 
-`git_config()` will grab the configuration from config files known to Git and
-apply standard precedence rules. `git_config_get_string_tmp()` will look up
+`repo_config()` will grab the configuration from config files known to Git and
+apply standard precedence rules. `repo_config_get_string_tmp()` will look up
 a specific key ("user.name") and give you the value. There are a number of
 single-key lookup functions like this one; you can see them all (and more info
-about how to use `git_config()`) in `Documentation/technical/api-config.adoc`.
+about how to use `repo_config()`) in `Documentation/technical/api-config.adoc`.
 
 You should see that the name printed matches the one you see when you run:
 
@@ -377,7 +399,7 @@ status_init_config(&s, git_status_config);
 ----
 
 But as we drill down, we can find that `status_init_config()` wraps a call
-to `git_config()`. Let's modify the code we wrote in the previous commit.
+to `repo_config()`. Let's modify the code we wrote in the previous commit.
 
 Be sure to include the header to allow you to use `struct wt_status`:
 
@@ -393,8 +415,8 @@ prepare it, and print its contents:
 
 ...
 
-	wt_status_prepare(the_repository, &status);
-	git_config(git_default_config, &status);
+	wt_status_prepare(repo, &status);
+	repo_config(repo, git_default_config, &status);
 
 ...
 
-- 
2.49.GIT

