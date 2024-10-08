Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED3C1E008B
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397793; cv=none; b=JKE1dXKUmzZVVMryGp/2XEBEAD5iGHlpcEdU8odfcA0CMpDZUmwOuxne5ElVL/qXtZx6PXERc3jT534GLb00MwJsJ/WeSMbFyXxqs1TDi999IXmg1FwXiBhL62fpzOfW+YAXrS/zCCFyDkOg+BehTd/AG/SClc3VgNHcpFw8hgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397793; c=relaxed/simple;
	bh=AEWdfE7AV8FYn4O6JdW/ByWjFI3wZjaUQf6tedP8+wM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C+6vnXemkoqBRUUrrfPaERJJQWM2BIgK6mrDZ26/NGADJZAApdvXTaKMat/sv6mOEtccZCOiviJUM5y6B8v+6tV5lhVQ+Kjw2lvXc8amrW1pYuXxh9uetxnqWdWjAgSn6YGmR6EyvvZT3KXgAs9TdmPL6wi1TUA2Y1EuOHuTdRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhzvHyQE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhzvHyQE"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71de92fdf13so324527b3a.0
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 07:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728397791; x=1729002591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbTuAaPIAZK+BdwYfVPqpjUQjAPr+X9TTBJgolYubrw=;
        b=dhzvHyQE9rDneKnlV0LMhkN4rPBsw5J87NEiHBZZvL2jHWdMi/LCeJMuKtGq8uMJ5U
         joABd5sH5ZYnJ9oGj9chYsB4KpNX1F+++YJmAWwIzOaBLWl4UZyd8BNqXEAlphQZimhB
         zUoca5Ou28FFQe4LHhqjFfESA1EsPr545LqUCoH9iQ+87P6uqas1BCooCgqxIMnHlUnh
         N3S0RFRpZqHHfFiC/K1lCq4otRbApuSOHSU1rwkTKmgmPgnU4XcClYZsaWL70ZzuBGnT
         oqA5ofjhNh+qESn9qy2sJO6g7ABUTqrt0yc+oLLSo8CzQlYqf6dIgNZKX1DavYOjmnj/
         2SeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397791; x=1729002591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbTuAaPIAZK+BdwYfVPqpjUQjAPr+X9TTBJgolYubrw=;
        b=NAwB2nVWgAdEUNjlcXw8weKzpYW6Fi6La7HOy8xZdnuZPhOnWIMQnjZ6a0xsUGrZML
         SPFcnB3Tzl0oWW9BjD8PCD75ezHOA16Msrmvyj6fMlHKU9twvVDeUumFjsOGXktR4SIF
         mytaWNmQRi8CGmISjvyXq2wb3BWgyoYjJ6SPVRSbwqP9jmCAB26bXSVnbh9HKUJtX8L2
         pepKGB63hjOQML9VlRNxXAsEaqYypHFnj7flp02JSIkpHL+aQ17lJ1gUi+KY6LnuvhY3
         a0n906QC70Sl8TeSquUk9EkkYNlfZ5IJx8ahYYRu4s5CvgGXPC+kPu2PZddoDG4nd/52
         0cow==
X-Gm-Message-State: AOJu0Yx9ivLaYxcJ+3a1PUSngStNrUVvcQfaExQh0/izja3YbsYYJfVS
	KSu18dt1f2fZP+BbAzHMofYO4czm39IvpdYoPa7/TRO9nQ/HrXkRXBd+5Q==
X-Google-Smtp-Source: AGHT+IEdTZoON/dMGpxcM8DKnL060gWYQJn11FBeAo/RHckPj1CvE6GsjVnnNvr0TrStGHgDkdf9gQ==
X-Received: by 2002:a05:6a00:91cf:b0:71d:fdf2:6b04 with SMTP id d2e1a72fcca58-71dfdf26d8fmr5955825b3a.1.1728397791056;
        Tue, 08 Oct 2024 07:29:51 -0700 (PDT)
Received: from localhost.localdomain ([2604:3d09:e083:d900:fddc:a13c:16ae:b340])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f681f089sm6795954a12.25.2024.10.08.07.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:29:50 -0700 (PDT)
From: Josh Heinrichs <joshiheinrichs@gmail.com>
To: git@vger.kernel.org
Cc: Josh Heinrichs <joshiheinrichs@gmail.com>
Subject: [PATCH v2 1/1] git-config.1: remove value from positional args in unset usage
Date: Tue,  8 Oct 2024 08:29:20 -0600
Message-Id: <20241008142920.570244-2-joshiheinrichs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241008142920.570244-1-joshiheinrichs@gmail.com>
References: <20241008040749.69801-1-joshiheinrichs@gmail.com>
 <20241008142920.570244-1-joshiheinrichs@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The synopsis for `git config unset` mentions two positional arguments:
`<name>` and `<value>`. While the first argument is correct, the second
is not. Users are expected to provide the value via `--value=<value>`.

Remove the positional argument. The `--value=<value>` option is already
documented correctly, so this is all we need to do to fix the
documentation.

Signed-off-by: Josh Heinrichs <joshiheinrichs@gmail.com>
---
 Documentation/git-config.txt | 2 +-
 builtin/config.c             | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 7f81fbbea8..3e420177c1 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git config list' [<file-option>] [<display-option>] [--includes]
 'git config get' [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<value>] [--fixed-value] [--default=<default>] <name>
 'git config set' [<file-option>] [--type=<type>] [--all] [--value=<value>] [--fixed-value] <name> <value>
-'git config unset' [<file-option>] [--all] [--value=<value>] [--fixed-value] <name> <value>
+'git config unset' [<file-option>] [--all] [--value=<value>] [--fixed-value] <name>
 'git config rename-section' [<file-option>] <old-name> <new-name>
 'git config remove-section' [<file-option>] <name>
 'git config edit' [<file-option>]
diff --git a/builtin/config.c b/builtin/config.c
index 97e4d5f57c..d60e106bd6 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -19,7 +19,7 @@ static const char *const builtin_config_usage[] = {
 	N_("git config list [<file-option>] [<display-option>] [--includes]"),
 	N_("git config get [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<value>] [--fixed-value] [--default=<default>] <name>"),
 	N_("git config set [<file-option>] [--type=<type>] [--all] [--value=<value>] [--fixed-value] <name> <value>"),
-	N_("git config unset [<file-option>] [--all] [--value=<value>] [--fixed-value] <name> <value>"),
+	N_("git config unset [<file-option>] [--all] [--value=<value>] [--fixed-value] <name>"),
 	N_("git config rename-section [<file-option>] <old-name> <new-name>"),
 	N_("git config remove-section [<file-option>] <name>"),
 	N_("git config edit [<file-option>]"),
@@ -43,7 +43,7 @@ static const char *const builtin_config_set_usage[] = {
 };
 
 static const char *const builtin_config_unset_usage[] = {
-	N_("git config unset [<file-option>] [--all] [--value=<value>] [--fixed-value] <name> <value>"),
+	N_("git config unset [<file-option>] [--all] [--value=<value>] [--fixed-value] <name>"),
 	NULL
 };
 
-- 
2.25.1

