Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2714D1E3DDB
	for <git@vger.kernel.org>; Sun, 18 May 2025 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747553697; cv=none; b=WfUTvD3dH6ufJXbYQ8umgSMM7F3MHnIOIwpMy3g3j2CyXTIost2t9z7Iv2N38Ys0sThnz4h4z98cZSrwsmy1b1pjjouTP3HEq3pKg2mb1XJ7Wtfnph/XOWnNcqQJly9UbY7OEXkYGQMx9jv8Oht4yTgCNLW5EaSE8ZyyCDozd5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747553697; c=relaxed/simple;
	bh=0XC4oeOnjyA4Y+QX9aiZKchM0utistwwSjOfadOHcWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTaj68IEb5uVqGlnYlIu/+ZTH+dujD7UiORgvT9hgL2RYWhKhuaXe7W7uB9ofb3NrjRGl+V+HLHAPPRFAFGwd4cUgRnvazJvDJRKkd86SgfT0pQQlCbGo8HIj2is8hL12COtzQqs6sTp7pmWokQ0Zqb4tkFPeNAR75PVSO/FV3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1d8uR5C; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1d8uR5C"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b1ff9b276c2so2032713a12.1
        for <git@vger.kernel.org>; Sun, 18 May 2025 00:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747553695; x=1748158495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+LO7bElb9Nihy9MjMvDsP6tusWsRZXv3TzfeAe6QnM=;
        b=N1d8uR5CDqV63hMv/3CeJbYM9G1sNcudKQuvsNzAgPz5J5M1qKRXb+M0g2/gu/4Rf3
         bo4wdigwbZ/O10qTJBbXjoNVC4KmA+qSN6c6l+NjD17yANAmPfKYhzSWt+GUjS0wZ6aj
         hfgLITOfQl4s1WkZviNkSAjbnEoj2+Pz8j8KIhXbLUNW1n9DKq1fYEJa4H1/omopVrwu
         A9vkrF7QtRg9tEzU1GOmq3iOUIj3VhfvLopYyCytC5As+bA43kbhw3S9Ju1zQSWYlyOL
         Xx3+8hAxpOvDOwK18ECBrLiAtEG7XYNKiMciKGR5Gx0rcw9nJ84+cf++OAJWkrlctZBh
         tlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747553695; x=1748158495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+LO7bElb9Nihy9MjMvDsP6tusWsRZXv3TzfeAe6QnM=;
        b=m+1M7Q6RU0OwLoCCQWtSI8wbZykwxBtJwhOjjzKesMtWhcZZxasGiZlddYuxKw3iMI
         ioRVbizfebwe5bl/mgCCR+/B+a5YkuW8dczul6JujOsrmO1xK98e2pw2WmppqxB+iL8r
         PMSqqR3lGeeLLk5EPgXNr0OifuntCzYNcls9F3liqg0kBTSCaOoH4IPthBmucIf0bXct
         on/MO+YSs5HJAlOxttiRtV0hXCnHq5uReOSx0+6r/nt45xRM+2JmHOG6dt1PkEsHCJtL
         /1Rw5zXwAcf+jyN5BwIDfv29RKkDSzMlGzMssvQj4vDn9j0yI1zMaSZDmG0KaaYzctls
         vCTg==
X-Gm-Message-State: AOJu0YxCqTukzQZk58zpw2qN4NkLLE6aL0lwrH5KaSu8S1QqPNbWaE2D
	aEFSyBYq34Xs3wkCMYh03YlXQsxOLg1c/RxBeD9T1eDJwIZDhcq3gIZu
X-Gm-Gg: ASbGncstysAOmVRXHKpimTNHt1V3K4mwaKJeK7NI87I5CKtmlfiTypVulNDgeUu4HnB
	Kmyn1QwhFUq6JbcVIov2ufMedbgf89WghkuCKOz8p8KIIAkxF9A6oIuThW0FM76n2a1txW9f4Sh
	UcM4YaYHAfyKGVF/aoRO7sBMK6/W9qas2u+V0Ys/JCHfF9h0eAEXy6K0UpNHkuOgTh+m5a4DBVi
	7K1y90JpafWres0wfBWvCU35BEsebHkZxeZ6Dh5ZjL3E4M/upJwZF2xzhBH1sUcagUWyQA8n/8e
	1FWcilz56GzHRD5AX8oOBgtxt+VnXL0/9H9C+odprN428PgU9Wb3PLhbkpkqguG2wWw=
X-Google-Smtp-Source: AGHT+IEJ9KYxmA0g+H7Jab1eyBCf0AJp8fWl8kKZqtwuIAgBpmSi4tyv1lNwodgNL2c1NzlRL1xVuQ==
X-Received: by 2002:a17:903:2303:b0:21a:8300:b9d5 with SMTP id d9443c01a7336-231d4524c4bmr128220205ad.23.1747553695328;
        Sun, 18 May 2025 00:34:55 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed897asm39847715ad.250.2025.05.18.00.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 00:34:55 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	jayatheerthkulkarni2005@gmail.com,
	nasamuffin@google.com
Subject: [PATCH v3 3/3] docs: replace git_config to repo_config
Date: Sun, 18 May 2025 13:04:42 +0530
Message-ID: <20250518073442.72666-4-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <20250518073442.72666-1-jayatheerthkulkarni2005@gmail.com>
References: <xmqqa57bqdxt.fsf@gitster.g>
 <20250518073442.72666-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since this document was written, the built-in API has been
updated a few times, but the document was left stale.

Adjust to the current best practices by calling repo_config() on the
repository instance the subcommand implementation receives as a
parameter, instead of calling git_config() that used to be the
common practice.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index da15d43d1f..08a3137101 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -322,7 +322,8 @@ on the command line, including the name of our command. (If `prefix` is empty
 for you, try `cd Documentation/ && ../bin-wrappers/git psuh`). That's not so
 helpful. So what other context can we get?
 
-Add a line to `#include "config.h"`. Then, add the following bits to the
+Add a line to `#include "config.h"` and `#include "repository.h"`.
+Then, add the following bits to the function body:
 function body:
 
 ----
@@ -330,18 +331,18 @@ function body:
 
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
 
@@ -374,7 +375,7 @@ status_init_config(&s, git_status_config);
 ----
 
 But as we drill down, we can find that `status_init_config()` wraps a call
-to `git_config()`. Let's modify the code we wrote in the previous commit.
+to `repo_config()`. Let's modify the code we wrote in the previous commit.
 
 Be sure to include the header to allow you to use `struct wt_status`:
 
@@ -390,8 +391,8 @@ prepare it, and print its contents:
 
 ...
 
-	wt_status_prepare(the_repository, &status);
-	git_config(git_default_config, &status);
+	wt_status_prepare(repo, &status);
+	repo_config(repo, git_default_config, &status);
 
 ...
 
-- 
2.49.GIT

