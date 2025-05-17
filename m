Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA9518FDB1
	for <git@vger.kernel.org>; Sat, 17 May 2025 03:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747453004; cv=none; b=mrQc8cLxllUFE9b2PABtyi+ttv0vWeqOypXf2Gadc+Rs7NACGG9280t5ziy0WNOXj18+FAfTb6GY9EFFPwr0lpIozfFogEvBinwxu8ILeknTwvSRiHCo10utDW74VjeP1VtOt1jy/luKNNdx95l6al5YHe6nwhKWTfYQZ4IcB4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747453004; c=relaxed/simple;
	bh=yzGO0a2a7Yr2w9Q11khS9hWAGdJ0O6VIIq+ddLR61Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOEDo7BB/hQMsamlZikyFJQ6lXw5YJp+YxmfS+DuOrvCQt0FPr6SLLt89gbdhZh3XJAOiHTTwyek6w6P/Ld3zMeoFBDi722miYJZxvQSBLq4NoqHSQY6CtQI0wC6dqSfr1CkS7RCx/ekNRwhfz1F3Q7D551HY8/9tC9DmbCEgB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFo1B1+r; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFo1B1+r"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso3148400b3a.0
        for <git@vger.kernel.org>; Fri, 16 May 2025 20:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747453002; x=1748057802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geuRyfOyeOcnxov5Ag/xW8t9tCZV9Z8hGnqmJuSYVbc=;
        b=mFo1B1+rLtm7/SNoQUv5V7SYZ0SqZaHQAgrsIMxy6eU33GoFBXwpzRtmwllLwB/iDd
         pSBH6ld2Y8Mlq4z6vePSTpXFdktDKqjb+CCBgEbbfTcUy/2SqOnSFkWAiFpInjwMZ4nk
         y6VgZgfGInwhW31UpS7ReX/j3fsKjBZCvDQIiSJbA9LfvG2f3rBRrhzwHcQS+o5aVVXT
         CuDkBUw0MwdVIaDPvBL7VD1vxD35n3JvEQmUfNGn//P1dLfKnZq9LjaG1MU0DHbYW+0m
         5HKxOgKTVBCe/EfeNNwzMKb2wvUEyKK9Lrrtj4B6juV09JpAp1ATYnAk6rdMCNZqUbYe
         TXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747453002; x=1748057802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=geuRyfOyeOcnxov5Ag/xW8t9tCZV9Z8hGnqmJuSYVbc=;
        b=EXjaHkXJm4lAi1bWRUVIAEp+SXBV/Nvs/ImZiiDUzeEtzXhVUlJLY74YhKgbAJwXix
         TZrJaBfwLALYB6Ehw3KrHfRlUM0RwTwsW4k0bEVmoMpBYtyg7Qh5c6pDk31Np1gWEA6O
         XcHtbT3cEA74S5UWj9SopzCuLEBEcUy7Q38mGqetTKD3eyLV4xaAsUqxVkZpQ3AiKETe
         MG5zzopl0IXvRJebWBC6YWwUydtxErHi2+Dy3r5HbCJDIrZqngooJfAJv+9NMVq9zuaQ
         GCeL23q8800LOLDhplFP4AlubSoLjXTfP/TVXh+7KuKuLb0hDWzyu3ZZ92AG8S7U1xlR
         FkGQ==
X-Gm-Message-State: AOJu0YyW5tIA2rN35peIHbUcN4meil/+0ti5NIduT9Gyp2+J9XLQ3FvP
	MS9LxVnycVeY2ZlFjnx1B9jKyUrWKBwlOlD/PX7lr+6VKMDHGQc80PN74mtGILKT
X-Gm-Gg: ASbGncv1gYkltx6edqZPcyPusfpjE+Xp2LAnEBXRGmwX5eJQseddO8fqDuXAXxkgxjf
	QbqMSoQGhls1TvWW4fVYs1Kuf0tbcdbmf+jFAE+COR/qNQbDsFkxqdBfzSkM2taJvbUQRcXp7ln
	HNRyrgQzRGt4PQbSI0u5Gqk9rYgkg2jWiDfO5Ig6vdDvvEJkGifInUGZkn9txssA/Rk3jj0jax9
	T+i89lytfzbjrpqCxOEumn7/6CvYbeBPQraq7Pxlv6k64t0WW/6qT+mINTNPLSuDD7V1gohNw7b
	TjEwbgSVsoOO+ZvO9NBCXqauvtQXgOeHfDv4yPWdVM6qo9Qb/SPcpE7cdlNpA5Bpx5hcJCzF7MK
	EGQ==
X-Google-Smtp-Source: AGHT+IHlTBqqwtzyfsWNceLC07Iw5vxyK3AAZvWjmF+y1PA+lItq8l6umORRAClwXdniD9C9V0MSmQ==
X-Received: by 2002:a05:6a00:178e:b0:740:b3d9:c889 with SMTP id d2e1a72fcca58-742a98d48e1mr7355413b3a.22.1747453002259;
        Fri, 16 May 2025 20:36:42 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829ba8sm2285500b3a.110.2025.05.16.20.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 20:36:41 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	jayatheerthkulkarni2005@gmail.com,
	nasamuffin@google.com
Subject: [PATCH v3 3/3] docs: replace git_config to repo_config
Date: Sat, 17 May 2025 09:06:26 +0530
Message-ID: <20250517033626.8052-4-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <20250517033626.8052-1-jayatheerthkulkarni2005@gmail.com>
References: <xmqqecworq39.fsf@gitster.g>
 <20250517033626.8052-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change updates the example in cmd_psuh to use repo_config and
repo_config_get_string_tmp instead of the global git_config functions.

While git_config() accesses global configuration via the_repository,
using repo_config() makes use of the repo parameter passed to built-in commands.
This is the preferred pattern in the Git codebase,
respect repository-specific configuration (e.g., .git/config)
and avoid relying on global state.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index f4320d8869..8c2ca5c092 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -314,7 +314,8 @@ on the command line, including the name of our command. (If `prefix` is empty
 for you, try `cd Documentation/ && ../bin-wrappers/git psuh`). That's not so
 helpful. So what other context can we get?
 
-Add a line to `#include "config.h"`. Then, add the following bits to the
+Add a line to `#include "config.h"` and `#include "repository.h"`.
+Then, add the following bits to the function body:
 function body:
 
 ----
@@ -322,18 +323,18 @@ function body:
 
 ...
 
-	git_config(git_default_config, NULL);
-	if (git_config_get_string_tmp("user.name", &cfg_name) > 0)
+	repo_config(repo, git_default_config, NULL);
+	if (repo_config_get_string_tmp(repo, "user.name", &cfg_name))
 		printf(_("No name is found in config\n"));
 	else
 		printf(_("Your name: %s\n"), cfg_name);
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
 
@@ -366,7 +367,7 @@ status_init_config(&s, git_status_config);
 ----
 
 But as we drill down, we can find that `status_init_config()` wraps a call
-to `git_config()`. Let's modify the code we wrote in the previous commit.
+to `repo_config()`. Let's modify the code we wrote in the previous commit.
 
 Be sure to include the header to allow you to use `struct wt_status`:
 
@@ -382,8 +383,8 @@ prepare it, and print its contents:
 
 ...
 
-	wt_status_prepare(the_repository, &status);
-	git_config(git_default_config, &status);
+	wt_status_prepare(repo, &status);
+	repo_config(repo, git_default_config, &status);
 
 ...
 
-- 
2.49.GIT

