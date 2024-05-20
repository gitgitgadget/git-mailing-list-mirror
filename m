Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7A0139578
	for <git@vger.kernel.org>; Mon, 20 May 2024 20:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716236535; cv=none; b=j8toV056B78OfI4knLjZ/UZV3xFlE+2JOm3w9LwE0cmXVVYLHfj3N0/LZSdZJ8o9EgIb+fB6BQ+B8sQZyc0sUZKmUGOWXKuHT6uw6+5xR67cY+chnXPFYRfas3ixkL+YYt9GA6SYx71wWnA93zLNRU6Toq8zwLnLFAqPT7fUf6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716236535; c=relaxed/simple;
	bh=NACUjCKOyFbBT9Jcvg+gdcvRvWOxx7KfWVnfiD/FlN4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iR6HmlJuzAzNyeDNUB9O6X7mOqo+2YSFhNttPtOsKSFq/XD+fv6ZO/BLXlMcnqW8hbegLrjbpjzcQTTFKlCy3X1e2BkFFGUYJp+NqAk4mfTBJfiXtasohvz/cjvc91+8tLti8cGwd2b58G44eHSf0vdlal37ycC0YOQHJ0OCEEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiaiSGmR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiaiSGmR"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-420180b5838so18200925e9.2
        for <git@vger.kernel.org>; Mon, 20 May 2024 13:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716236532; x=1716841332; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6d3NikhGkK867apaAyTM/p8Uvw8q8n1MJ0T9cVpYng=;
        b=ZiaiSGmRIES36sHw7+8fuoKd8+xRH5YzhKs5QlXswL70dYpZ6LlXkd32Ea9HDhrOWC
         a1lpuFyAskZCZ78hDsAfa2ksS4Awc5Hn2eLt9It2uaAY2mGrxaHUGnsDlVo7ttwGon36
         xkRNgSHYal/hR+WS8rwdssn/naERc7QeTWUOQKGOaNI6bW7zDe2K0pjCBrT8z/z14va9
         xkPKOKCKAq1r0jKb8qr9n6c5kDCDJhiq7ZA//qoFIyzyGV93szwlAccA0MJAPIGbbeuX
         o6+wQo1VElwWE5GRMp3Zf9DTvSq9cWw2xm6q4Y21nADRfFGo0jHlhmRZtrtABXUPvPOX
         ogkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716236532; x=1716841332;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6d3NikhGkK867apaAyTM/p8Uvw8q8n1MJ0T9cVpYng=;
        b=ehlV6PIuwAs/P5JOiYO1jpwFgUEKmGz3kIrpG+76PQEb8dLjaV/acJsebaR6wvLK1l
         whM/Uvk/nQ/kWTbqeaOnAJKp0Fc4Tcj0dBB04iljmz+KEvDWJ7a8zsnK/mvW9IwhBUNt
         KlvJtkHnNi8Tz7Lnyag5+qifzeSImrkX7lMoJlac+9i4nU1BaG19PT376MMCQJS2kUJF
         KRIwIZlMYRWcriANj+qkkwLRFwqERfZdUvfuFgCmNGgDja4IudwT+6SjcmjkIqycvIM8
         yfC7NYyB/HqBnzVSYe1WaBtDR/WCdDiGweEPQNF/3cqWrP81xDUq7yDpqk7ood0nxzPY
         t7KQ==
X-Gm-Message-State: AOJu0YzLrPpJ4qvcK6vjvK9U1FzbNzYba29zywmyau1mzy301hQHSKDR
	bgWpQbgOgD9X1hJtisTGZ84RqHi5F55yqs8TCaWVfsaqzSKX81rtohnc8w==
X-Google-Smtp-Source: AGHT+IERd8BUQHHQjfWCaHwegdX9ASxC5fX1vn0k8gEuqH/WeKKUICUILA0oe8ymqPsBtFkPf4B5Dg==
X-Received: by 2002:a05:600c:4614:b0:415:6daf:c626 with SMTP id 5b1f17b1804b1-41feaa4392amr294540965e9.21.1716236531817;
        Mon, 20 May 2024 13:22:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4201da9895csm277442365e9.44.2024.05.20.13.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 13:22:11 -0700 (PDT)
Message-Id: <57db89a14977bdff01f8f82cb4d6f85cc49d4b55.1716236526.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1732.v3.git.1716236526.gitgitgadget@gmail.com>
References: <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
	<pull.1732.v3.git.1716236526.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 May 2024 20:22:02 +0000
Subject: [PATCH v3 3/6] Revert "core.hooksPath: add some protection while
 cloning"
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This defense-in-depth was intended to protect the clone operation
against future escalations where bugs in `git clone` would allow
attackers to write arbitrary files in the `.git/` directory would allow
for Remote Code Execution attacks via maliciously-placed hooks.

However, it turns out that the `core.hooksPath` protection has
unintentional side effects so severe that they do not justify the
benefit of the protections. For example, it has been reported in
https://lore.kernel.org/git/FAFA34CB-9732-4A0A-87FB-BDB272E6AEE8@alchemists.io/
that the following invocation, which is intended to make `git clone`
safer, is itself broken by that protective measure:

	git clone --config core.hooksPath=/dev/null <url>

Since it turns out that the benefit does not justify the cost, let's revert
20f3588efc6 (core.hooksPath: add some protection while cloning,
2024-03-30).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c        | 13 +------------
 t/t1800-hook.sh | 15 ---------------
 2 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/config.c b/config.c
index 85b37f2ee09..8c1c4071f0d 100644
--- a/config.c
+++ b/config.c
@@ -1525,19 +1525,8 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "core.attributesfile"))
 		return git_config_pathname(&git_attributes_file, var, value);
 
-	if (!strcmp(var, "core.hookspath")) {
-		if (current_config_scope() == CONFIG_SCOPE_LOCAL &&
-		    git_env_bool("GIT_CLONE_PROTECTION_ACTIVE", 0))
-			die(_("active `core.hooksPath` found in the local "
-			      "repository config:\n\t%s\nFor security "
-			      "reasons, this is disallowed by default.\nIf "
-			      "this is intentional and the hook should "
-			      "actually be run, please\nrun the command "
-			      "again with "
-			      "`GIT_CLONE_PROTECTION_ACTIVE=false`"),
-			    value);
+	if (!strcmp(var, "core.hookspath"))
 		return git_config_pathname(&git_hooks_path, var, value);
-	}
 
 	if (!strcmp(var, "core.bare")) {
 		is_bare_repository_cfg = git_config_bool(var, value);
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 7ee12e6f48a..2ef3579fa7c 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -177,19 +177,4 @@ test_expect_success 'git hook run a hook with a bad shebang' '
 	test_cmp expect actual
 '
 
-test_expect_success 'clone protections' '
-	test_config core.hooksPath "$(pwd)/my-hooks" &&
-	mkdir -p my-hooks &&
-	write_script my-hooks/test-hook <<-\EOF &&
-	echo Hook ran $1
-	EOF
-
-	git hook run test-hook 2>err &&
-	grep "Hook ran" err &&
-	test_must_fail env GIT_CLONE_PROTECTION_ACTIVE=true \
-		git hook run test-hook 2>err &&
-	grep "active .core.hooksPath" err &&
-	! grep "Hook ran" err
-'
-
 test_done
-- 
gitgitgadget

