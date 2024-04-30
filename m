Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BC328F0
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714437310; cv=none; b=ULXQyUEz1YVEY+pyldc46WqJUGdtS7Rs9yFWkmAYobIVPKozrN2ztR/PtqN6hCkmZeYVxL+IOHeFN/IC/wJuaaT/4Uby+t4dzU3+zKLKNnbjNlVbiuMGtCTkbQQhZEc3+wwIdxy4ZJi72w2BKGbZpgTh5axxz2hEPyIlFt7lA7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714437310; c=relaxed/simple;
	bh=IC3xG8rggbCOARBpCSeuJmsFTaIp/UHBbUFexka6P3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQeUss+SIueRKPzw+nXWExxdE5/ZZ40sUJJwLjvEuuqDfNVR7Xh3Ch0qgd0T0eheIpgCD5c7xSmrR84gWIEJJgxgXN+ojenbr/SBSQBF7nUVJVqG4dVeQuIqFY93nqyEPekSJxpTiCTCjufzLahDvUUMvrx/XT475QaYbvTVSvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABLvED5Z; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABLvED5Z"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ed3587b93bso3090915a34.1
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 17:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714437308; x=1715042108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KL8kJSAclLO5yPOlqZEE9sIdByXY7rfvTqxrHUoUmW4=;
        b=ABLvED5ZkogaLm959Ier37hu/x2XCzbSlP5yrrhwMKWT7eq6K+QDs+Glq2kcFkFpae
         WJSYo0rYhd0IOMqpi9FVh2e4YEAgIb8prs+XuD6Mf3WzhYVfebr3fjZe18Lwzg0u7Vtf
         /IiS+cfMdh2N/XRxoKLXPiMvnvYf9mhDyyWfzu0l1u9mG99cRz6/vt+sn5GFxC5nnhcD
         YZ6QIuK62oePO/dHADZkR3DgDVauuYIhUHhv+9DVakYuaG5yC+8JFlUln+i4SEJ+TmVe
         +tj6sYiXkGzhJoBFsdyMFZ8yn6+13pSpD9Uiv7iKgHlXn0jIZz0xE06NuWxrGelJt99Q
         oEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714437308; x=1715042108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KL8kJSAclLO5yPOlqZEE9sIdByXY7rfvTqxrHUoUmW4=;
        b=V51UwdL+r2bwg+Qptne6FnDc0mEjxvhEIMQPbkTeXPWhg9tdxY45leEomzwq5yYsQP
         ahObye24MXfbtCOOYv7zT6NFTF3tKPMkbKwv1h7Q3Sym4xMVhB9qOVJ+ZpPjKNkwgz/i
         +UQZ+zHNdb+VPjFxfJGJofM2Ry/J7bNkHxqAwHW9aToHseb+Jxl9GZTtbWY5NUowlEaG
         6i0ekTbpTXaP6TxcbtPvW7IwSqmoMVjRHyFOZeX3E0JmxLlIbugllSlD9A51lyD2+qCy
         HBRzn69pVE9+yI4eUFh3Jif4NlTwW5+NO+2Q7UETdn41aNW4IU0x16jo4YfTawKwDgrN
         JpAA==
X-Gm-Message-State: AOJu0YwS8EM4TIMqMGV2zJQoTbrdCQ2gni1PCq8sc4FHg2Ed/XQgRvGl
	f3po/8Wc/OxG/4npGgfs1FNkt8gS4zIbRwYcIkRe+kY3qKhLXnfKwVUyk4Qx
X-Google-Smtp-Source: AGHT+IH7YkoFOkunMWoegRGVt074+jDjh2ASEq/LeleaWi1xz0ZiV2jp+XpiyJoi275IQ1SQv7ImiA==
X-Received: by 2002:a05:6830:1199:b0:6ee:3a37:b230 with SMTP id u25-20020a056830119900b006ee3a37b230mr4014346otq.38.1714437307891;
        Mon, 29 Apr 2024 17:35:07 -0700 (PDT)
Received: from denethor.localdomain ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id bw3-20020a0568300dc300b006ee5b409f23sm188645otb.22.2024.04.29.17.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 17:35:07 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 2/2] gitlab-ci: add whitespace error check
Date: Mon, 29 Apr 2024 19:33:23 -0500
Message-ID: <20240430003323.6210-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430003323.6210-1-jltobler@gmail.com>
References: <20240430003323.6210-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To check for whitespace errors introduced by a set of changes, there is
the `.github/workflows/check-whitespace.yml` GitHub action. This script
executes `git log --check` over a range containing the new commits and
parses the output to generate a markdown formatted artifact that
summarizes detected errors with GitHub links to the affected commits and
blobs.

Since this script is rather specific to GitHub actions, a more general
and simple `ci/check-whitespace.sh` is added instead that functions the
same, but does not generate the markdown file for the action summary.
From this, a new GitLab CI job is added to support the whitespace error
check.

Note that the `$CI_MERGE_REQUEST_TARGET_BRANCH_SHA` variable is only
available in GitLab merge request pipelines and therefore the CI job is
configured to only run as part of those pipelines.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 .gitlab-ci.yml         |  9 +++++++++
 ci/check-whitespace.sh | 16 ++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100755 ci/check-whitespace.sh

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c0fa2fe90b..31cf420a11 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -102,3 +102,12 @@ static-analysis:
   script:
     - ./ci/run-static-analysis.sh
     - ./ci/check-directional-formatting.bash
+
+check-whitespace:
+  image: ubuntu:latest
+  before_script:
+    - ./ci/install-docker-dependencies.sh
+  script:
+    - ./ci/check-whitespace.sh $CI_MERGE_REQUEST_TARGET_BRANCH_SHA
+  rules:
+    - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
diff --git a/ci/check-whitespace.sh b/ci/check-whitespace.sh
new file mode 100755
index 0000000000..1cad2d7374
--- /dev/null
+++ b/ci/check-whitespace.sh
@@ -0,0 +1,16 @@
+#! /bin/sh
+#
+# Check that commits after a specified point do not contain new or modified
+# lines with whitespace errors.
+#
+
+baseSha=${1}
+
+git log --check --pretty=format:"---% h% s" ${baseSha}..
+if test $? -ne 0
+then
+	echo "A whitespace issue was found in one or more of the commits."
+	echo "Run the following command to resolve whitespace issues:"
+	echo "\tgit rebase --whitespace=fix ${baseSha}"
+	exit 2
+fi
-- 
2.44.0

