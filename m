Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5489525EFB4
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 13:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742821443; cv=none; b=iyXOVZRYIhEfIl3HlP+qw7TY7ho/dmPnSzjlKeYfnkfhix0XdiLAKnPOg4tCOWSrwhOvYk+X1fYsuv0xcGoADiRwVcSkrPskW8J5ZiKk8MVNpunY5RsePVNxZj7n8WSfU4mXFQG1FBTmGB8PNvo8WoOcRtdf6itS7jXx5+7Dlyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742821443; c=relaxed/simple;
	bh=iojjAU7q2253b/uD9cv5QZrK8BJ7rVJ2XUuXBZOnLQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLgOlXzK6gkfUCJ8SWfDI7NpdrAHKY6NrciuTZi0IyQ+QP8upq8UM6B7hS7izmkk9x8oVmZ5taQzkLXf4Kq4v/RpvnAN8EUSI1tLXyQl7/JynN67iUbtZj8PVek84NiQFAwHmr6AsHVPkhs9emNNlTpHdcHy5sZ7HeGL8Om4wpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRT9RwlF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRT9RwlF"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22423adf751so77589125ad.2
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 06:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742821441; x=1743426241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNvWKUWYgdxGPk86jeeMPlMbc/9lN33Azk4S234thP4=;
        b=fRT9RwlFOBx3rAeps8OFJPEu5UO6A0NXmIMGOspHd0gs6sWWbz7FLrrn9DoR/Z3yPk
         DFb+67ioZeEvTs9nv8T7+C7wJWf0g8ZnteoO8siejNa86dcZDTEC7pj4goHo2QI5GTpo
         +NOXHF5k6gtT1S/jvMZVsuzZp6XmlWdR/Za6qpwOpgCKP7XOaMinSqJv94tc+p0DzkIb
         pClHLKxqPM20BTtreRYbHqX2t8h93bWWpoUJA4ZYIIC3f75hLUHQEJRatp+oOIlYQf+3
         RZGj7RxE43yEhYZJuko/g0i/0ZXYMbPTW1Vp9d5LiAEYmABXcUx67XjF0mtAanMkWpxT
         Nspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742821441; x=1743426241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNvWKUWYgdxGPk86jeeMPlMbc/9lN33Azk4S234thP4=;
        b=quffnJq4bdUbZa/frwjCRVn3I/gsx1bHzNxgoieUsNkeHHnMy8mfd/VM9tflVetjXf
         JskxICQGSvb/0KMc9/o/rSYznOhK9m6goiR2f5E1GjVjn9kr1CQMsvmTxYlerHZ1Cmy1
         XOJUvInwlHEQIkRJRgxNWXHUGCwg8/nI3lWOaNij67pX633fDow/YZURy77D3fkVGoQo
         fKloPUjlKrZwCHLoBRyr2t0h6hh5OfOe/y1iXhRnt0DZ2UhpP8+qPShrJtmZpFu3oQjs
         zDfZwyiiFNHfaTI2lxJ0oH+qzlI/eeq603veYYF2jvPhn6icl9Kx07IpX91vsIL9MNAf
         XTCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7rKBm95juCmz0WJL+e74fLh7ntb/+ktSgnrrrIpy+hzr9Ls2pn+WxgTEMOQAXyA6+pbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YziopMVCaj6yl335Brdy0NVo91LYo7cBzWvheabrVdiNodxmCAu
	pmpbAlm13GN50YxL3tdziSvoQ1zKO27suwdtAKY9rmiEy22JlByF
X-Gm-Gg: ASbGncvV+qHzEy+ArAYA9pVKEgLtgypVgTFkN3Ai2KNhWvRSmZq/5XtPm4cj4w1t5Pw
	b3GG9FWhYXDUxF8l+1KlfItMVt9PCXl6oe4iRHPHrHOJlvUVkQCe/3e52my7kTi4qL004o505d1
	QEjAabaogq5XIrsRhXj4R1ik+isMPhLj2eeEfBe1dX8FuQ0avoPWnmJJzlO3i+Y+WbJYz7GD8Do
	iJ7s9eJCFit7wRfjS6ZyenonIUDD8cAO7Q5wjNqxMkB1r49sg1dz4mxjFqTKSsVVEZQ33nX+/dv
	CxaEQ7/995w8SfZ1qFWY+cwCQ/8c1xgA/AwwJvyMgJP7qZH/IxiFhOZbCCXtQMpVwdWfXnirGkM
	77Gc=
X-Google-Smtp-Source: AGHT+IHQRZTvhJlMYoz8eEdEiqAXBnQK7XSoeTywgTEft2ojuca++ZyMiRZF4HAb8XPZOXjz6nUbhg==
X-Received: by 2002:a05:6a00:84d:b0:736:a540:c9b5 with SMTP id d2e1a72fcca58-73905a2763bmr17414911b3a.22.1742821441069;
        Mon, 24 Mar 2025 06:04:01 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c005:b018:5841:514c:af52:5598])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390618dd29sm7795807b3a.167.2025.03.24.06.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 06:04:00 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gitster@pobox.com
Cc: ben.knoble@gmail.com,
	git@vger.kernel.org,
	jayatheerthkulkarni2005@gmail.com
Subject: [[GSOC][PATCH v4] 3/3] docs: replace git_config with repo_config
Date: Mon, 24 Mar 2025 18:33:43 +0530
Message-ID: <20250324130343.113629-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324130343.113629-1-jayatheerthkulkarni2005@gmail.com>
References: <xmqq34f3qbna.fsf@gitster.g>
 <20250324130343.113629-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor config handling by replacing git_config(...)
with repo_config(...) for better repository context
awareness and alignment with modern Git practices.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 57 ++++++++++++++++++--------
 1 file changed, 39 insertions(+), 18 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 45efe117ab..04c19ac0b2 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -316,26 +316,47 @@ on the command line, including the name of our command. (If `prefix` is empty
 for you, try `cd Documentation/ && ../bin-wrappers/git psuh`). That's not so
 helpful. So what other context can we get?
 
-Add a line to `#include "config.h"`. Then, add the following bits to the
+Add `#include "config.h"` and `#include "repository.h"`. Then, add the following bits to the
 function body:
 
 ----
-	const char *cfg_name;
+#include "builtin.h"
+#include "gettext.h"
+#include "config.h"
+#include "repository.h"  
 
-...
+int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo)
+{
+    const char *cfg_name;
+
+    printf(Q_("Your args (there is %d):\n",
+              "Your args (there are %d):\n",
+              argc),
+           argc);
+
+    for (int i = 0; i < argc; i++) {
+        printf("%d: %s\n", i, argv[i]);
+    }
 
-	git_config(git_default_config, NULL);
-	if (git_config_get_string_tmp("user.name", &cfg_name) > 0)
-		printf(_("No name is found in config\n"));
-	else
-		printf(_("Your name: %s\n"), cfg_name);
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
+about how to use `repo_config()` ) in `Documentation/git-config.adoc`.
 
 You should see that the name printed matches the one you see when you run:
 
@@ -383,8 +404,8 @@ prepare it, and print its contents:
 
 ...
 
-	wt_status_prepare(the_repository, &status);
-	git_config(git_default_config, &status);
+	wt_status_prepare(repo, &status);
+	repo_config(repo, git_default_config, &status);
 
 ...
 
@@ -1093,11 +1114,11 @@ The one generated for `psuh` from the sample implementation looks like this:
 
 ----
  Documentation/git-psuh.adoc | 40 +++++++++++++++++++++
- Makefile                    |  1 +
- builtin.h                   |  1 +
- builtin/psuh.c              | 73 ++++++++++++++++++++++++++++++++++++++
- git.c                       |  1 +
- t/t9999-psuh-tutorial.sh    | 12 +++++++
+ Makefile                   |  1 +
+ builtin.h                  |  1 +
+ builtin/psuh.c             | 73 ++++++++++++++++++++++++++++++++++++++
+ git.c                      |  1 +
+ t/t9999-psuh-tutorial.sh   | 12 +++++++
  6 files changed, 128 insertions(+)
  create mode 100644 Documentation/git-psuh.adoc
  create mode 100644 builtin/psuh.c
-- 
2.48.1

