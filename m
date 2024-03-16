Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785EB1B950
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710602508; cv=none; b=aMhBQl65+WF8/eaEaXgf/dHzA088t/2juMR0kOk2Dp5e28jj47133aAlce7FW2o3bJ7VZ/yymPa7kw8FQK7GpjZJqgwl7dl2U9S6CVEC4W4s9J9BA3/vEArEtRsD36YAppJoazk3qNtJ3dfKuh3U4jOK2FFcBNykNpVoh8j9FNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710602508; c=relaxed/simple;
	bh=oPz7KYealauUVutAcjXrqnXsxeqhtKHs7y09p8I2XAs=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=XgqKxvBUdj95ZzZxAa6FK2Zt1XOjzRMs6idaTbsIXr9hQs9COrXq3oTkDNXtHn3rgcO9sDFXb0gzd6RKeAzqvVXyhW5SZh4rTwVreeDi4fvdoRaT8uIhP/EZKJ9ASY1YsPdsYvqomf3Ke+VObrR8wvfMbnr8me0vKDngj3hRxDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y10y8Lw1; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y10y8Lw1"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34005b5927eso215769f8f.1
        for <git@vger.kernel.org>; Sat, 16 Mar 2024 08:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710602504; x=1711207304; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFsf3ZoFuQo0W05UGN7ooRECEN9ypBHYE/9gBnciXhk=;
        b=Y10y8Lw1ZERwOonZr0K+Tl6W14qhivzEBqwymAiXytw4Y9DXEFNpR1j3M+/Uw6pJmU
         wHOfuiTDh+ScFjWhx5tbMrgg+IoTprEHOsbUICyPVuygbmYyutmn2ceChHyCjmZvjk/4
         Wd6+k9xo3mBcNcKLQa04XrsaUAr4JxmsqxbrQbvPEL+HJxFb5zINE+WREsY3rnmkDFb3
         EVMQfBB7Guk4lDfTDyXYztJG2wws+UWs94ShzT+96HlBEcPyqamfTAshPNMCfDQwyldv
         z0dlJ5JkT04ohx3i/ApSRoe8RnXWRIVxfkJAYMYcRjhicAyur0Zv70Xyp9CkdLA/27fu
         g2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710602504; x=1711207304;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFsf3ZoFuQo0W05UGN7ooRECEN9ypBHYE/9gBnciXhk=;
        b=pG8HI2oc0sTibsmIH3SQdM8Gj279Xir6cgigtJXnEL+VzAMEHMrds1Xpcq4KF01mjr
         j3qyAByBfy45bl8l+HTFr2DtEkRihIgyqJUq3AznIlivPb6spf/LOcdK6SRXQe/602SE
         StRw5Q5J/oBpyXYc1s2nfD5hf3hs29b+KCbOcyQYzfR5yH42VY4WPJ05s+LIkz7h/5/P
         DmGt4Na7SpVXKUMrDoWCQVXOuhzM1eTfe1O+IQU7n/kpFNSx7lGV7RGxFOoBMWEboMqM
         aNWOhrxtq1MDoAG3TR5nbIYgi3tNS7GH7w0teoo7OWxe7TVWMHvhXP2IwOiY0AfNinXb
         Q7Jg==
X-Gm-Message-State: AOJu0Yym4GIFAekxqKZYO9EPAfCudrX7aUBs3Vk60NDB0TmCFjfNmHg3
	18LdcBDHg1mBZwOB2opsp3AX77+i+i2P2JB3rgnaIDeTSKYF0lRMreoXPLPz
X-Google-Smtp-Source: AGHT+IFbIEHXvPGUAKBhHft6TRhK3GuSTA2Gqg3OfsZtvSDbbQMSiRhKcsm6V9uiZIZLYMxOjWE/mg==
X-Received: by 2002:adf:f3d2:0:b0:33d:b376:8a07 with SMTP id g18-20020adff3d2000000b0033db3768a07mr4429917wrp.8.1710602503586;
        Sat, 16 Mar 2024 08:21:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bu27-20020a056000079b00b0033ecbfc6941sm5297128wrb.110.2024.03.16.08.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 08:21:43 -0700 (PDT)
Message-ID: <2b016b82ab797e95e4acb3dc1ba7010296ac84ca.1710602501.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1697.git.1710602501.gitgitgadget@gmail.com>
References: <pull.1697.git.1710602501.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 16 Mar 2024 15:21:40 +0000
Subject: [PATCH 1/2] doc: format alternatives in synopsis
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

This is a list of various fixes on malformed alternative in commands
and option syntax.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/fetch-options.txt  | 2 +-
 Documentation/git-pull.txt       | 4 ++--
 Documentation/git-rebase.txt     | 2 +-
 Documentation/git-send-email.txt | 8 +++++---
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 54ebb4452e9..e22b217fba9 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -202,7 +202,7 @@ endif::git-pull[]
 	destination of an explicit refspec; see `--prune`).
 
 ifndef::git-pull[]
---recurse-submodules[=yes|on-demand|no]::
+--recurse-submodules[=(yes|on-demand|no)]::
 	This option controls if and under what conditions new commits of
 	submodules should be fetched too. When recursing through submodules,
 	`git fetch` always attempts to fetch "changed" submodules, that is, a
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 0e14f8b5b25..b2ae496e488 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -87,7 +87,7 @@ OPTIONS
 --verbose::
 	Pass --verbose to git-fetch and git-merge.
 
---[no-]recurse-submodules[=yes|on-demand|no]::
+--[no-]recurse-submodules[=(yes|on-demand|no)]::
 	This option controls if new commits of populated submodules should
 	be fetched, and if the working trees of active submodules should be
 	updated, too (see linkgit:git-fetch[1], linkgit:git-config[1] and
@@ -105,7 +105,7 @@ Options related to merging
 include::merge-options.txt[]
 
 -r::
---rebase[=false|true|merges|interactive]::
+--rebase[=(false|true|merges|interactive)]::
 	When true, rebase the current branch on top of the upstream
 	branch after fetching. If there is a remote-tracking branch
 	corresponding to the upstream branch and the upstream branch
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index e7e725044db..03d5e9936a0 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 	[--onto <newbase> | --keep-base] [<upstream> [<branch>]]
 'git rebase' [-i | --interactive] [<options>] [--exec <cmd>] [--onto <newbase>]
 	--root [<branch>]
-'git rebase' (--continue | --skip | --abort | --quit | --edit-todo | --show-current-patch)
+'git rebase' (--continue|--skip|--abort|--quit|--edit-todo|--show-current-patch)
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 8264f873809..c5d664f4519 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -9,7 +9,7 @@ git-send-email - Send a collection of patches as emails
 SYNOPSIS
 --------
 [verse]
-'git send-email' [<options>] <file|directory>...
+'git send-email' [<options>] (<file>|<directory>)...
 'git send-email' [<options>] <format-patch-options>
 'git send-email' --dump-aliases
 
@@ -278,7 +278,7 @@ must be used for each option.
 	if a username is not specified (with `--smtp-user` or `sendemail.smtpUser`),
 	then authentication is not attempted.
 
---smtp-debug=0|1::
+--smtp-debug=(0|1)::
 	Enable (1) or disable (0) debug output. If enabled, SMTP
 	commands and replies will be printed. Useful to debug TLS
 	connection and authentication problems.
@@ -301,7 +301,9 @@ must be used for each option.
 Automating
 ~~~~~~~~~~
 
---no-[to|cc|bcc]::
+--no-to::
+--no-cc::
+--no-bcc::
 	Clears any list of "To:", "Cc:", "Bcc:" addresses previously
 	set via config.
 
-- 
gitgitgadget

